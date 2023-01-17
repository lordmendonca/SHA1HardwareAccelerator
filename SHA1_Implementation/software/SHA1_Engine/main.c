#include "system.h"
#include "alt_types.h"
#include <sys/alt_irq.h>
#include "sys/alt_stdio.h"
#include <stdlib.h>
#include "sys/alt_timestamp.h"

#define ZERO 0x00

#define __I  volatile const				// read-only permission
#define __IO volatile 					// read/write permission ...
#define __O  volatile 					// write only permission ;-) doesn't work in C...

#define JTAG_UART_BASE_ADDRESS			(JTAG_UART_CORE_BASE | ALT_CPU_DCACHE_BYPASS_MASK)
#define SHA1_BASE_ADDESS				(SHA1_ENGINE_0_BASE | ALT_CPU_DCACHE_BYPASS_MASK)

/**
 * In-built JTAG UART register build.
 */
typedef struct {
	__IO alt_u32 DATA_REG;
	__IO alt_u32 CTRL_REG;
} JTAG_UART_TYPE;

/**
 * Custom register build for SHA-1 Engine on hardware accelerator.
 */
typedef struct {
	__IO alt_u32 CONTROL_REG;
	__I  alt_u32 STATUS_REG;
	__IO alt_u32 HASH_REG[5];
	__IO alt_u32 DATA_REG[16];
} SHA1_TYPE;

#define DATA_RVALID_OFFSET		(15)
#define RE_IRQ_ENABLE			(0)
#define WRITE_FIFO_SPACE_MSK	(0xFFFF0000)

#define JTAG_UART (*((JTAG_UART_TYPE *) JTAG_UART_BASE_ADDRESS))
#define SHA1 (*((SHA1_TYPE *) SHA1_BASE_ADDESS))

/**
 *  To read a word from JTAG UART Data register.
 */
volatile alt_u32 word_received;
/**
 *  Interrupt flag to indicate end of an entered string on JTAG UART.
 */
volatile alt_u8 irq_exchange;
/**
 *  A sufficient buffer size for the array that read the serial characters from JTAG UART.
 */
#define BUFFER_SIZE 4096
/**
 *  An array that stores the entered serial characters on JTAG UART.
 */
alt_u32 INPUT_DATA_ARRAY[BUFFER_SIZE];
/**
 *  To index the Input array. Also has the size of the entered string of characters.
 */
alt_u32 input_data_array_idx;
/**
 *  Custom datatype to store 64-words as a block in SHA-1 computation.
 */
typedef struct
{
	alt_u32 word[64];
}wordBlocks_t;

/**
 *  Initialization of five random strings of hex characters that will serve as part of the hash function.
 */
alt_u32 H[5] = {0x67452301,
				0xEFCDAB89, 
				0x98BADCFE,
				0x10325476, 
				0xC3D2E1F0};
/**
 *  A fixed sequence of 4 constant words K(i) that vary across 4 different iterations namely, [0 19], [20 39], [40 59] and [60 79].
 */ 
const alt_u32 K[4] = {0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6};
/**
 *  \brief Registers the interrupt routine for the triggered JTAG UART interrupt.
 */
static void jtag_uart_rx_isr_setup_task(void);
/**
 *  \brief The interrupt service routine.
 */
static void jtag_uart_rx_isr_task(void *context, alt_u32 id) __attribute__ ((section (".exceptions")));
/**
 *  \brief Function that does the preprocessing for SHA-1 computation.
 *  
 *  \param [in] W           : 80-Word array to store the word expansion.
 *  \param [in] blocksize   : message block size.
 *  \param [in] bytes       : message size in byte.
 *  \param [in] block       : The block array of type wordBlocks_t whose size depends on blocksize.
 */
void sha1_PreProcessing(alt_u32* W, alt_u32* blocksize, alt_u32* bytes, wordBlocks_t* block);
/**
 *  \brief The SHA-1 computation by SW.
 *  
 *  \param [in] W             : 80-Word expanded array.
 *  \param [in] messageDigest :  Calculated hash for the message.
 *  \param [in] block         : The block array of type wordBlocks_t whose size depends on blocksize.
 *  \param [in] blockNumber   : message block under process.
 *  \return Return description
 *  
 *  \details More details
 */
void sha1_Computation(alt_u32* W, alt_u32* messageDigest, wordBlocks_t* block, alt_u32* blockNumber);
/**
 *  \brief Helper function that performs circular shift-N operation.
 *  
 *  \param [in] word      : Word that needs to be circular-shifted-by-N.
 *  \param [in] shiftby   : The shift value for the operation.
 *  
 *  \return The circular-shifted-by-N value.
 */
alt_u32 circularshift(alt_u32 word, alt_u32 shiftby);

void task_sha1_benchmarking(void)
{
	/* Registering JTAG UART IRQ. */
	jtag_uart_rx_isr_setup_task();

	alt_u64 time1;
	alt_u64 time2;
	alt_u64 timer_overhead;
	alt_u64 total_time_sw;
	alt_u64 total_time_hw;
	alt_u32 boost_factor;

	if(alt_timestamp_start() < 0)
	{
		alt_printf("Timer start failed. \n");
	}
	else
	{
		alt_printf("Timer started successfully. \n");
	}

	/* Calculating the timer overhead. */
	time1 = alt_timestamp();
	time2 = alt_timestamp();
	alt_printf("\n\n");
	timer_overhead = time2 - time1;
	alt_printf("Timer Overhead : [ %x ]", timer_overhead);
	alt_printf("\n\n");

	alt_printf(" Enter Text : \n");

	while(1)
	{
		if(irq_exchange > 0)
		{
			// Clear Interrupt Flag.
			irq_exchange = 0;

			alt_printf("\n Entered Message : ");
			for(alt_u32 i = 0; i < input_data_array_idx; i++)
			{
				alt_printf("%c", INPUT_DATA_ARRAY[i]);
			}
			alt_printf("\n \n");

			/* 80 iterative computation of 16 32-bit message chunks are stored here. */
			alt_u32 W[80] = {0};
			/* message digest after SHA-1 computation is stored here. */
			alt_u32 messageDigest[5];
			/* identifying the message block size for the SHA-1 computation. */
			alt_u32 blocksize = 0;
			/* message size in bytes. */
			alt_u32 bytes = 0;

			/* Determining the block size.*/
			for(alt_u32 n = 1; n < 1000; n++)
			{
				if(input_data_array_idx < ((64*n)-9))
				{
					/* block size */
					blocksize = n;
					/* total number of bytes in multiples of 64 bytes (512bits) */
					bytes = 64 * n;
					break;
				}
			}

			/* Creating blocks of 64bytes (512 bits) [message chunks] of padded text data. */
			wordBlocks_t block[blocksize];

			/* Pre-processing the message. */
			sha1_PreProcessing(W, &blocksize, &bytes, block);

			/***********************************************************************************/
			/** SHA-1 Computation using SW *****************************************************/
			/***********************************************************************************/

			time1 = alt_timestamp();

			/* Feeding blocks [message chunks] of data in iterative manner determined by block size for SHA-1 computation. */
			for(alt_u32 loop = 0; loop < blocksize; loop++)
				sha1_Computation(W, messageDigest, block, &loop);

			time2 = alt_timestamp();

			/* Printing 160-bit Message Digest after SHA-1 computation. */
			alt_printf("SHA-1 was calculated using Software only. The calculated hash is : \n");
			alt_printf(" [ ");
			for(alt_u32 i = 0; i < 5; i ++)
				alt_printf("%x ", messageDigest[i]);
			alt_printf(" ] \n \n");

			total_time_sw = time2 - time1 - timer_overhead;
			alt_printf("Time taken to compute the hash using Software only method : [ %x ] \n",total_time_sw);
			alt_printf("\n");

			H[0] = 0x67452301;
			H[1] = 0xEFCDAB89;
			H[2] = 0x98BADCFE;
			H[3] = 0x10325476;
			H[4] = 0xC3D2E1F0;

			alt_u32 wordarray[blocksize][16];

			/* 16 words creation for each message block to be fed into custom registers build on accelerator */
			/* Iteration 0 to 15 on the message chunks for W0 to W15. */
			for(alt_u32 k = 0; k < blocksize; k++)
			{
				for(alt_u32 i = 0, j = 0; i < 16; i++)
				{
					wordarray[k][i] = (block[k].word[j]) << 24 | (block[k].word[j+1] << 16) | (block[k].word[j+2] << 8) | (block[k].word[j+3]);
					j = j + 4;
					if(0 == i % 8)
						alt_printf("\n");
				}
			}

			/***********************************************************************************/
			/** SHA-1 Computation on HW  *******************************************************/
			/***********************************************************************************/

			time1 = alt_timestamp();

			for(alt_u16 i = 0; i < blocksize; i++)
			{
				for(alt_u16 j = 0; j < 5; j++)
				{
					SHA1.HASH_REG[j] = H[j];
				}

				for(alt_u16 j = 0; j < 16; j++)
				{
					SHA1.DATA_REG[j] = wordarray[i][j];
				}

				SHA1.CONTROL_REG = 0x01;

				while(SHA1.STATUS_REG != 1);

				for(alt_u16 j = 0; j < 5; j++)
				{
					H[j] = SHA1.HASH_REG[j];
				}
			}

			time2 = alt_timestamp();

			alt_printf("SHA-1 was calculated using Hardware accelerator. The calculated hash is : \n");
			alt_printf(" [ %x %x %x %x %x ] \n\n" ,H[0], H[1], H[2], H[3], H[4]);

			total_time_hw = time2 - time1 - timer_overhead;
			alt_printf("Time taken to compute the hash using hardware accelerator : [ %x ] \n", total_time_hw);
			alt_printf("\n");

			/** BOOST FACTOR  **/

			boost_factor = total_time_sw/total_time_hw;

			alt_printf("Boost Factor : [ %x ]\n", boost_factor);
			alt_printf("HW based computation was %x times faster than SW based computation.\n", boost_factor);

			/* Reset input data array index to 0 for next input. */
			input_data_array_idx = 0;

			H[0] = 0x67452301;
			H[1] = 0xEFCDAB89;
			H[2] = 0x98BADCFE;
			H[3] = 0x10325476;
			H[4] = 0xC3D2E1F0;

			alt_printf("\n Enter Text : ");
		}
	}
}

int main(void) {

	task_sha1_benchmarking();

	while(1) {

	}
	return 0;
}

static void jtag_uart_rx_isr_setup_task(void){
	alt_ic_isr_register(JTAG_UART_CORE_IRQ_INTERRUPT_CONTROLLER_ID,
						JTAG_UART_CORE_IRQ,
						(void *)jtag_uart_rx_isr_task,
						ZERO,
						ZERO
	);
	JTAG_UART.CTRL_REG = (1 << RE_IRQ_ENABLE);
}

static void jtag_uart_rx_isr_task(void *context, alt_u32 id){
	alt_u32 input_data;
	input_data =  JTAG_UART.DATA_REG;
	if(input_data & (1 << DATA_RVALID_OFFSET))
	{
		if((input_data & 0x000000FF) != '\n')
		{
			word_received = input_data & 0x000000FF;
			INPUT_DATA_ARRAY[input_data_array_idx++] = word_received;
			irq_exchange = 1; // Set Interrupt flag.
		}
	}
}

void sha1_PreProcessing(alt_u32* W, alt_u32* blocksize, alt_u32* bytes, wordBlocks_t* block)

{
		/* padding of 1 at the end of text data. */
		INPUT_DATA_ARRAY[input_data_array_idx] = 128;

		/* Thereafter padding of zeroes until last 64bits are left.*/
		for(alt_u32 i = input_data_array_idx+1 ; i < *bytes -1 ; i++)
		{
			INPUT_DATA_ARRAY[i] = 0;
		}

		/* storing the length of the text in the 64 bits */
		INPUT_DATA_ARRAY[*bytes - 1] = input_data_array_idx * 8;

		/* Creating blocks of 64bytes (512 bits) [message chunks] of padded text data. */
		for(alt_u32 i = 0, k = 0; i < *blocksize; i++, k = k + 64)
		{
			for(alt_u32 j = 0; j < 64; j++)
			{
				block[i].word[j] = INPUT_DATA_ARRAY[j+k];
			}
		}

		/* Feeding blocks [message chunks] of data in iterative manner determined by block size. */
		for(alt_u32 loop = 0; loop < *blocksize; loop++)
		{

			/* Iteration 0 to 15 on the message chunks for W0 to W15. */
			for(alt_u32 i = 0, j = 0; i < 16; i++)
			{
				W[i] = (block[loop].word[j]) << 24 | (block[loop].word[j+1] << 16) | (block[loop].word[j+2] << 8) | (block[loop].word[j+3]);
				j = j + 4;
			}
		}
}

void sha1_Computation(alt_u32* W, alt_u32 messageDigest[], wordBlocks_t* block, alt_u32* blockNumber)
{
	/* Iteration 0 to 15 on the message chunks for W0 to W15. */
	for(alt_u32 i = 0, j = 0; i < 16; i++)
	{
		W[i] = (block[*blockNumber].word[j]) << 24 | (block[*blockNumber].word[j+1] << 16) | (block[*blockNumber].word[j+2] << 8) | (block[*blockNumber].word[j+3]);
		j = j + 4;
	}

	/* Store the hash values in the following variables. */
	alt_u32 A = H[0];
	alt_u32 B = H[1];
	alt_u32 C = H[2];
	alt_u32 D = H[3];
	alt_u32 E = H[4];

	/*
	 *  SHA-1 mathematical computations over 80 iterations.
	 *  For 80 iterations [i = 0 to 79], compute TEMP = (circularshift(A, 5) + f(i; B, C, D) + E + W(i) + K(i)) such that,
	 *  f(i;B,C,D) = (B & C) | ((~B) & D) in [i = 0 to 19]
	 *  f(i;B,C,D) = (B ^ C ^ D) in [i = 20 to 39]
	 *  f(i;B,C,D) = (B & C) | (B & D) | (C & D) in [i = 40 to 59]
	 *  f(i;B,C,D) = (B ^ C ^ D) in [i = 60 to 79]
	 *  K(i) = 0x5a827999 in [i = 0 to 19]
	 *  K(i) = 0x6ed9eba1 in [i = 20 to 39]
	 *  K(i) = 0x8f1bbcdc in [i = 60 to 79]
	 *  K(i) = 0xca62c1d6 in [i = 60 to 79]
	 *  Then reassign the following variables:
	 *  E = D
	 *  D = C
	 *  C = circularshift(B, 30)
	 *  B = A
	 *  A = TEMP
	 *  */
	unsigned int word_idx = 16;
	unsigned int word_temp;

	alt_u32 TEMP = 0;
	for(alt_u32 i = 0; i < 20; i++)
	{
		alt_u32 temp = 0;
		temp = (B & C) ^ ((~B) & D);
		TEMP = E + temp + circularshift(A,5) + W[i] +K[0];

		E = D;
		D = C;
		C = circularshift(B, 30);
		B = A;
		A = TEMP;

		word_temp = W[word_idx-3] ^ W[word_idx-8] ^ W[word_idx-14] ^ W[word_idx-16];
		W[word_idx] = circularshift(word_temp, 1);
		word_idx++;
	}

	TEMP = 0;
	for(alt_u32 i = 20; i < 40; i++)
	{
		alt_u32 temp = 0;
		temp = B ^ C ^ D;
		TEMP = E + temp + circularshift(A,5) + W[i] +K[1];

		E = D;
		D = C;
		C = circularshift(B, 30);
		B = A;
		A = TEMP;

		word_temp = W[word_idx-3] ^ W[word_idx-8] ^ W[word_idx-14] ^ W[word_idx-16];
		W[word_idx] = circularshift(word_temp, 1);
		word_idx++;
	}

	TEMP = 0;
	for(alt_u32 i = 40; i < 60; i++)
	{
		alt_u32 temp = 0;
		temp = (B & C) ^ (B & D) ^ (C & D);
		TEMP = E + temp + circularshift(A,5) + W[i] +K[2];

		E = D;
		D = C;
		C = circularshift(B, 30);
		B = A;
		A = TEMP;

		word_temp = W[word_idx-3] ^ W[word_idx-8] ^ W[word_idx-14] ^ W[word_idx-16];
		W[word_idx] = circularshift(word_temp, 1);
		word_idx++;
	}

	TEMP = 0;
	for(alt_u32 i = 60; i < 80; i++)
	{
		alt_u32 temp = 0;
		temp = B ^ C ^ D;
		TEMP = E + temp + circularshift(A,5) + W[i] +K[3];

		E = D;
		D = C;
		C = circularshift(B, 30);
		B = A;
		A = TEMP;

		if(word_idx < 80)
		{
			word_temp = W[word_idx-3] ^ W[word_idx-8] ^ W[word_idx-14] ^ W[word_idx-16];
			W[word_idx] = circularshift(word_temp, 1);
			word_idx++;
		}
	}

	/*
	 * Store the result of the chunk's hash to the overall hash value of all chunks, as shown below, and proceed to execute the next chunk:
	 * H0 = H0 + A
	 * H1 = H1 + B
	 * H2 = H2 + C
	 * H3 = H3 + D
	 * H4 = H4 + E
	 */
	H[0] += A;
	H[1] += B;
	H[2] += C;
	H[3] += D;
	H[4] += E;

	/*
	 * The message digest is represented as the 160-bit string comprised of the 5 hashed values:
	 */
	messageDigest[0] = H[0];
	messageDigest[1] = H[1];
	messageDigest[2] = H[2];
	messageDigest[3] = H[3];
	messageDigest[4] = H[4];
}

alt_u32 circularshift(alt_u32 word, alt_u32 shiftby)
{
	alt_u32 temp_word = word;
	return (word << shiftby) | (temp_word >> (32 - shiftby));
}
