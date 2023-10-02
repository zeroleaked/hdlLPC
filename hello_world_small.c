/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "alt_types.h"

#include "system.h"

#define X_OFFSET 		LPC_ENCODE_AVALON_0_BASE+0
#define RESIDUE_OFFSET 	LPC_ENCODE_AVALON_0_BASE+320
#define A_OFFSET 		LPC_ENCODE_AVALON_0_BASE+640
#define CTRL	 		LPC_ENCODE_AVALON_0_BASE+680

#define CTRL_START		0x00000001
#define CTRL_FIN		0x00010000

alt_u16 x_data[] = {0xFFC7,0xFD54,0xFC5E,0xFD41,0xFD63,0xFF97,0xFED1,0xFBCA,0xFAE1,0xFBD7,0xFB3F,0xFC31,0xFBF6,0xFB29,0xF96F,0xF7FE,0xF7FE,0xF89D,0xFAC1,0xFAB9,0xFA25,0xFA2B,0xFBDC,0xFCA9,0xFD49,0xFF13,0x013E,0x0089,0xFFA9,0x02CA,0x0229,0x024B,0x05D2,0x0850,0x06BB,0x060D,0x087B,0x09D5,0x0CED,0x10C1,0x101D,0x1014,0x1469,0x15BA,0x1948,0x1F88,0x20E2,0x1FE7,0x2013,0x1A6F,0x08DC,0xF268,0xE386,0xDDFC,0xDCEA,0xDF4F,0xE57B,0xE997,0xEA28,0xEE96,0xF9FE,0x05F1,0x0EB1,0x1472,0x13DC,0x0C82,0x0372,0xFB69,0xF501,0xF04A,0xEAA0,0xE439,0xE0E2,0xE1DF,0xE5E2,0xEE11,0xF8A1,0x0164,0x06D1,0x09CA,0x0B38,0x0AAA,0x0755,0xFF9C,0xF4F7,0xEBF7,0xE42D,0xDD04,0xDDA1,0xE5F4,0xECDC,0xF1E1,0xF92F,0xFE15,0xFF0E,0x0315,0x08A5,0x0A6F,0x0AA1,0x0AFA,0x0951,0x0860,0x0A8D,0x0D0B,0x0E44,0x100A,0x12EA,0x1732,0x1E06,0x26FE,0x2F22,0x3674,0x3C76,0x412B,0x399A,0x12C1,0xE25C,0xD038,0xCDF0,0xC5E5,0xD05D,0xE77E,0xE6D6,0xDFAB,0xEF62,0x01B5,0x0C9A,0x2092,0x2FE7,0x2A47,0x1C2E,0x0A52,0xF57E,0xEB53,0xE7B5,0xDD60,0xD6BB,0xD8E5,0xD6C1,0xD836,0xE963,0xFCF3,0x09F5,0x178F,0x20DB,0x1F4A,0x1A81,0x14F0,0x0B92,0x027A,0xF91D,0xEBDD,0xE1AD,0xDE0E,0xDB5A,0xDC05,0xE4D9,0xEEFB,0xF52C,0xFCBE};


int main()
{ 
  alt_putstr("Hello from Nios II!\n");

  volatile alt_u32 * lpc_reg_x = (void *) X_OFFSET;
  volatile alt_u32 * lpc_ctrl = (void *) CTRL;
  volatile alt_u32 * lpc_reg_a = (void *) A_OFFSET;
  volatile alt_u32 * lpc_reg_residue = (void *) RESIDUE_OFFSET;


  for (int i=0; i<80; i++) {
	  lpc_reg_x[i] = x_data[i*2] | ( ( (alt_u32) x_data[i*2+1]) << 16 );
  }

  alt_putstr("Reg written\n");
  *lpc_ctrl = CTRL_START;
  while(((*lpc_ctrl) & CTRL_FIN) == 0) alt_putstr(".");
  alt_putstr("\n");

  alt_putstr("Encode fin\n");
//
//  for (int i=0; i<80; i++) {
//	  alt_printf("%x %x\n", i, lpc_reg_residue[i]);
//  }
  for (int i=0; i<10; i++) {
	  alt_printf("%x %x\n", i, lpc_reg_a[i]);
  }

  alt_printf("ctrl %x\n", lpc_ctrl);
  alt_printf("a %x\n", lpc_reg_a);
  alt_printf("x %x\n", lpc_reg_x);

  alt_putstr("good night\n");
  /* Event loop never exits. */
  while (1);

  return 0;
}
