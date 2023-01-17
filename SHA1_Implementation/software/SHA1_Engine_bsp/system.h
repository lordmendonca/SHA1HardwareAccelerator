/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_cpu' in SOPC Builder design 'SHA1_Base'
 * SOPC Builder design path: ../../SHA1_Base.sopcinfo
 *
 * Generated: Fri Mar 18 16:13:42 CET 2022
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00008820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x10
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x00000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x10
#define ALT_CPU_NAME "nios2_cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00008820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x10
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x00000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x10
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_GEN2
#define __SHA1_ENGINE


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "MAX 10"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_core"
#define ALT_STDERR_BASE 0x9140
#define ALT_STDERR_DEV jtag_uart_core
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_core"
#define ALT_STDIN_BASE 0x9140
#define ALT_STDIN_DEV jtag_uart_core
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_core"
#define ALT_STDOUT_BASE 0x9140
#define ALT_STDOUT_DEV jtag_uart_core
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "SHA1_Base"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK TIMER_CORE


/*
 * jtag_uart_core configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_core altera_avalon_jtag_uart
#define JTAG_UART_CORE_BASE 0x9140
#define JTAG_UART_CORE_IRQ 2
#define JTAG_UART_CORE_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_CORE_NAME "/dev/jtag_uart_core"
#define JTAG_UART_CORE_READ_DEPTH 64
#define JTAG_UART_CORE_READ_THRESHOLD 8
#define JTAG_UART_CORE_SPAN 8
#define JTAG_UART_CORE_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_CORE_WRITE_DEPTH 64
#define JTAG_UART_CORE_WRITE_THRESHOLD 8


/*
 * onchip_mem configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_mem altera_avalon_onchip_memory2
#define ONCHIP_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEM_BASE 0x0
#define ONCHIP_MEM_CONTENTS_INFO ""
#define ONCHIP_MEM_DUAL_PORT 1
#define ONCHIP_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEM_INIT_CONTENTS_FILE "SHA1_Base_onchip_mem"
#define ONCHIP_MEM_INIT_MEM_CONTENT 0
#define ONCHIP_MEM_INSTANCE_ID "NONE"
#define ONCHIP_MEM_IRQ -1
#define ONCHIP_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEM_NAME "/dev/onchip_mem"
#define ONCHIP_MEM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEM_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEM_SINGLE_CLOCK_OP 0
#define ONCHIP_MEM_SIZE_MULTIPLE 1
#define ONCHIP_MEM_SIZE_VALUE 30000
#define ONCHIP_MEM_SPAN 30000
#define ONCHIP_MEM_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEM_WRITABLE 1


/*
 * pio_leds configuration
 *
 */

#define ALT_MODULE_CLASS_pio_leds altera_avalon_pio
#define PIO_LEDS_BASE 0x9130
#define PIO_LEDS_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LEDS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LEDS_CAPTURE 0
#define PIO_LEDS_DATA_WIDTH 8
#define PIO_LEDS_DO_TEST_BENCH_WIRING 0
#define PIO_LEDS_DRIVEN_SIM_VALUE 0
#define PIO_LEDS_EDGE_TYPE "NONE"
#define PIO_LEDS_FREQ 50000000
#define PIO_LEDS_HAS_IN 0
#define PIO_LEDS_HAS_OUT 1
#define PIO_LEDS_HAS_TRI 0
#define PIO_LEDS_IRQ -1
#define PIO_LEDS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_LEDS_IRQ_TYPE "NONE"
#define PIO_LEDS_NAME "/dev/pio_leds"
#define PIO_LEDS_RESET_VALUE 0
#define PIO_LEDS_SPAN 16
#define PIO_LEDS_TYPE "altera_avalon_pio"


/*
 * pio_pushbuttons configuration
 *
 */

#define ALT_MODULE_CLASS_pio_pushbuttons altera_avalon_pio
#define PIO_PUSHBUTTONS_BASE 0x9120
#define PIO_PUSHBUTTONS_BIT_CLEARING_EDGE_REGISTER 1
#define PIO_PUSHBUTTONS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_PUSHBUTTONS_CAPTURE 1
#define PIO_PUSHBUTTONS_DATA_WIDTH 2
#define PIO_PUSHBUTTONS_DO_TEST_BENCH_WIRING 0
#define PIO_PUSHBUTTONS_DRIVEN_SIM_VALUE 0
#define PIO_PUSHBUTTONS_EDGE_TYPE "FALLING"
#define PIO_PUSHBUTTONS_FREQ 50000000
#define PIO_PUSHBUTTONS_HAS_IN 1
#define PIO_PUSHBUTTONS_HAS_OUT 0
#define PIO_PUSHBUTTONS_HAS_TRI 0
#define PIO_PUSHBUTTONS_IRQ 1
#define PIO_PUSHBUTTONS_IRQ_INTERRUPT_CONTROLLER_ID 0
#define PIO_PUSHBUTTONS_IRQ_TYPE "EDGE"
#define PIO_PUSHBUTTONS_NAME "/dev/pio_pushbuttons"
#define PIO_PUSHBUTTONS_RESET_VALUE 0
#define PIO_PUSHBUTTONS_SPAN 16
#define PIO_PUSHBUTTONS_TYPE "altera_avalon_pio"


/*
 * sha1_engine_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sha1_engine_0 sha1_engine
#define SHA1_ENGINE_0_BASE 0x9000
#define SHA1_ENGINE_0_IRQ -1
#define SHA1_ENGINE_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SHA1_ENGINE_0_NAME "/dev/sha1_engine_0"
#define SHA1_ENGINE_0_SPAN 256
#define SHA1_ENGINE_0_TYPE "sha1_engine"


/*
 * timer_core configuration
 *
 */

#define ALT_MODULE_CLASS_timer_core altera_avalon_timer
#define TIMER_CORE_ALWAYS_RUN 0
#define TIMER_CORE_BASE 0x9100
#define TIMER_CORE_COUNTER_SIZE 32
#define TIMER_CORE_FIXED_PERIOD 0
#define TIMER_CORE_FREQ 50000000
#define TIMER_CORE_IRQ 0
#define TIMER_CORE_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_CORE_LOAD_VALUE 49999
#define TIMER_CORE_MULT 0.001
#define TIMER_CORE_NAME "/dev/timer_core"
#define TIMER_CORE_PERIOD 1
#define TIMER_CORE_PERIOD_UNITS "ms"
#define TIMER_CORE_RESET_OUTPUT 0
#define TIMER_CORE_SNAPSHOT 1
#define TIMER_CORE_SPAN 32
#define TIMER_CORE_TICKS_PER_SEC 1000
#define TIMER_CORE_TIMEOUT_PULSE_OUTPUT 1
#define TIMER_CORE_TYPE "altera_avalon_timer"

#endif /* __SYSTEM_H_ */
