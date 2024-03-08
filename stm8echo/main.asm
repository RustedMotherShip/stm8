;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.0 #14184 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _uart_read
	.globl _uart_init
	.globl _status_check
	.globl _convert_int_to_binary
	.globl _uart_write
	.globl _UART_RX
	.globl _UART_TX
	.globl _delay
	.globl _strlen
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 6: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #8
;	main.c: 7: while (count--)
	ldw	y, (0x0d, sp)
	ldw	(0x07, sp), y
	ldw	x, (0x0b, sp)
00101$:
	ldw	(0x01, sp), x
	ld	a, (0x07, sp)
	ld	(0x03, sp), a
	ld	a, (0x08, sp)
	ldw	y, (0x07, sp)
	subw	y, #0x0001
	ldw	(0x07, sp), y
	jrnc	00117$
	decw	x
00117$:
	tnz	a
	jrne	00118$
	ldw	y, (0x02, sp)
	jrne	00118$
	tnz	(0x01, sp)
	jreq	00104$
00118$:
;	main.c: 8: nop();
	nop
	jra	00101$
00104$:
;	main.c: 9: }
	ldw	x, (9, sp)
	addw	sp, #14
	jp	(x)
;	main.c: 10: void UART_TX(unsigned char value)
;	-----------------------------------------
;	 function UART_TX
;	-----------------------------------------
_UART_TX:
;	main.c: 12: UART1_DR = value;
	ld	0x5231, a
;	main.c: 13: while(!(UART1_SR & UART_SR_TXE));
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 14: }
	ret
;	main.c: 15: unsigned char UART_RX(void)
;	-----------------------------------------
;	 function UART_RX
;	-----------------------------------------
_UART_RX:
;	main.c: 17: while(!(UART1_SR & UART_SR_RXNE));
00101$:
	btjf	0x5230, #5, 00101$
;	main.c: 18: return UART1_DR;
	ld	a, 0x5231
;	main.c: 19: }
	ret
;	main.c: 20: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 23: for(i = 0; i < strlen(str); i++) {
	clr	(0x05, sp)
00103$:
	ldw	x, (0x03, sp)
	call	_strlen
	ldw	(0x01, sp), x
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
	cpw	x, (0x01, sp)
	jrnc	00101$
;	main.c: 25: UART_TX(str[i]);
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	call	_UART_TX
;	main.c: 23: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00103$
00101$:
;	main.c: 27: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 28: }
	addw	sp, #5
	ret
;	main.c: 30: void convert_int_to_binary(int num, char* rx_binary_chars) {
;	-----------------------------------------
;	 function convert_int_to_binary
;	-----------------------------------------
_convert_int_to_binary:
	sub	sp, #4
	ldw	(0x01, sp), x
;	main.c: 32: for(int i = 7; i >= 0; i--) {
	ldw	x, #0x0007
	ldw	(0x03, sp), x
00103$:
	tnz	(0x03, sp)
	jrmi	00101$
;	main.c: 34: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
	ldw	x, #0x0007
	subw	x, (0x03, sp)
	addw	x, (0x07, sp)
	ldw	y, (0x01, sp)
	ld	a, (0x04, sp)
	jreq	00120$
00119$:
	sraw	y
	dec	a
	jrne	00119$
00120$:
	ld	a, yl
	and	a, #0x01
	add	a, #0x30
	ld	(x), a
;	main.c: 32: for(int i = 7; i >= 0; i--) {
	ldw	x, (0x03, sp)
	decw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 36: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
	ldw	x, (0x07, sp)
	clr	(0x0008, x)
;	main.c: 37: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	main.c: 39: void status_check(void){
;	-----------------------------------------
;	 function status_check
;	-----------------------------------------
_status_check:
	sub	sp, #9
;	main.c: 40: char rx_binary_chars[9]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
;	main.c: 41: uart_write("UART_REGS >.<\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	main.c: 42: convert_int_to_binary(UART1_SR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5230
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 43: uart_write("\nSR -> ");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 44: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 45: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 46: convert_int_to_binary(UART1_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5231
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 47: uart_write("DR -> ");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 48: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 49: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 50: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5232
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 51: uart_write("BRR1 -> ");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	main.c: 52: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 53: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 54: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5233
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 55: uart_write("BRR2 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	main.c: 56: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 57: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 58: convert_int_to_binary(UART1_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5234
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 59: uart_write("CR1 -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 60: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 61: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 62: convert_int_to_binary(UART1_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5235
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 63: uart_write("CR2 -> ");
	ldw	x, #(___str_7+0)
	call	_uart_write
;	main.c: 64: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 65: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 66: convert_int_to_binary(UART1_CR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5236
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 67: uart_write("CR3 -> ");
	ldw	x, #(___str_8+0)
	call	_uart_write
;	main.c: 68: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 69: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 70: convert_int_to_binary(UART1_CR4, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5237
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 71: uart_write("CR4 -> ");
	ldw	x, #(___str_9+0)
	call	_uart_write
;	main.c: 72: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 73: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 74: convert_int_to_binary(UART1_CR5, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5238
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 75: uart_write("CR5 -> ");
	ldw	x, #(___str_10+0)
	call	_uart_write
;	main.c: 76: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 77: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 78: convert_int_to_binary(UART1_GTR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5239
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 79: uart_write("GTR -> ");
	ldw	x, #(___str_11+0)
	call	_uart_write
;	main.c: 80: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 81: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 82: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x523a
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 83: uart_write("PSCR -> ");
	ldw	x, #(___str_12+0)
	call	_uart_write
;	main.c: 84: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 85: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 86: }
	addw	sp, #9
	ret
;	main.c: 92: void uart_init(void){
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	main.c: 93: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 96: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 97: UART1_CR2 |= UART_CR2_REN; // Receiver enable
	bset	0x5235, #2
;	main.c: 98: UART1_CR2 |= UART_CR2_ILIEN; //String Enable
	bset	0x5235, #4
;	main.c: 99: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 101: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 102: }
	ret
;	main.c: 104: int uart_read(void)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
	ldw	y, sp
	subw	y, #9
	sub	sp, #255
	sub	sp, #5
;	main.c: 107: char buffer[256]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
	clr	(0x0a, sp)
	clr	(0x0b, sp)
	clr	(0x0c, sp)
	clr	(0x0d, sp)
	clr	(0x0e, sp)
	clr	(0x0f, sp)
	clr	(0x10, sp)
	clr	(0x11, sp)
	clr	(0x12, sp)
	clr	(0x13, sp)
	clr	(0x14, sp)
	clr	(0x15, sp)
	clr	(0x16, sp)
	clr	(0x17, sp)
	clr	(0x18, sp)
	clr	(0x19, sp)
	clr	(0x1a, sp)
	clr	(0x1b, sp)
	clr	(0x1c, sp)
	clr	(0x1d, sp)
	clr	(0x1e, sp)
	clr	(0x1f, sp)
	clr	(0x20, sp)
	clr	(0x21, sp)
	clr	(0x22, sp)
	clr	(0x23, sp)
	clr	(0x24, sp)
	clr	(0x25, sp)
	clr	(0x26, sp)
	clr	(0x27, sp)
	clr	(0x28, sp)
	clr	(0x29, sp)
	clr	(0x2a, sp)
	clr	(0x2b, sp)
	clr	(0x2c, sp)
	clr	(0x2d, sp)
	clr	(0x2e, sp)
	clr	(0x2f, sp)
	clr	(0x30, sp)
	clr	(0x31, sp)
	clr	(0x32, sp)
	clr	(0x33, sp)
	clr	(0x34, sp)
	clr	(0x35, sp)
	clr	(0x36, sp)
	clr	(0x37, sp)
	clr	(0x38, sp)
	clr	(0x39, sp)
	clr	(0x3a, sp)
	clr	(0x3b, sp)
	clr	(0x3c, sp)
	clr	(0x3d, sp)
	clr	(0x3e, sp)
	clr	(0x3f, sp)
	clr	(0x40, sp)
	clr	(0x41, sp)
	clr	(0x42, sp)
	clr	(0x43, sp)
	clr	(0x44, sp)
	clr	(0x45, sp)
	clr	(0x46, sp)
	clr	(0x47, sp)
	clr	(0x48, sp)
	clr	(0x49, sp)
	clr	(0x4a, sp)
	clr	(0x4b, sp)
	clr	(0x4c, sp)
	clr	(0x4d, sp)
	clr	(0x4e, sp)
	clr	(0x4f, sp)
	clr	(0x50, sp)
	clr	(0x51, sp)
	clr	(0x52, sp)
	clr	(0x53, sp)
	clr	(0x54, sp)
	clr	(0x55, sp)
	clr	(0x56, sp)
	clr	(0x57, sp)
	clr	(0x58, sp)
	clr	(0x59, sp)
	clr	(0x5a, sp)
	clr	(0x5b, sp)
	clr	(0x5c, sp)
	clr	(0x5d, sp)
	clr	(0x5e, sp)
	clr	(0x5f, sp)
	clr	(0x60, sp)
	clr	(0x61, sp)
	clr	(0x62, sp)
	clr	(0x63, sp)
	clr	(0x64, sp)
	clr	(0x65, sp)
	clr	(0x66, sp)
	clr	(0x67, sp)
	clr	(0x68, sp)
	clr	(0x69, sp)
	clr	(0x6a, sp)
	clr	(0x6b, sp)
	clr	(0x6c, sp)
	clr	(0x6d, sp)
	clr	(0x6e, sp)
	clr	(0x6f, sp)
	clr	(0x70, sp)
	clr	(0x71, sp)
	clr	(0x72, sp)
	clr	(0x73, sp)
	clr	(0x74, sp)
	clr	(0x75, sp)
	clr	(0x76, sp)
	clr	(0x77, sp)
	clr	(0x78, sp)
	clr	(0x79, sp)
	clr	(0x7a, sp)
	clr	(0x7b, sp)
	clr	(0x7c, sp)
	clr	(0x7d, sp)
	clr	(0x7e, sp)
	clr	(0x7f, sp)
	clr	(0x80, sp)
	clr	(0x81, sp)
	clr	(0x82, sp)
	clr	(0x83, sp)
	clr	(0x84, sp)
	clr	(0x85, sp)
	clr	(0x86, sp)
	clr	(0x87, sp)
	clr	(0x88, sp)
	clr	(0x89, sp)
	clr	(0x8a, sp)
	clr	(0x8b, sp)
	clr	(0x8c, sp)
	clr	(0x8d, sp)
	clr	(0x8e, sp)
	clr	(0x8f, sp)
	clr	(0x90, sp)
	clr	(0x91, sp)
	clr	(0x92, sp)
	clr	(0x93, sp)
	clr	(0x94, sp)
	clr	(0x95, sp)
	clr	(0x96, sp)
	clr	(0x97, sp)
	clr	(0x98, sp)
	clr	(0x99, sp)
	clr	(0x9a, sp)
	clr	(0x9b, sp)
	clr	(0x9c, sp)
	clr	(0x9d, sp)
	clr	(0x9e, sp)
	clr	(0x9f, sp)
	clr	(0xa0, sp)
	clr	(0xa1, sp)
	clr	(0xa2, sp)
	clr	(0xa3, sp)
	clr	(0xa4, sp)
	clr	(0xa5, sp)
	clr	(0xa6, sp)
	clr	(0xa7, sp)
	clr	(0xa8, sp)
	clr	(0xa9, sp)
	clr	(0xaa, sp)
	clr	(0xab, sp)
	clr	(0xac, sp)
	clr	(0xad, sp)
	clr	(0xae, sp)
	clr	(0xaf, sp)
	clr	(0xb0, sp)
	clr	(0xb1, sp)
	clr	(0xb2, sp)
	clr	(0xb3, sp)
	clr	(0xb4, sp)
	clr	(0xb5, sp)
	clr	(0xb6, sp)
	clr	(0xb7, sp)
	clr	(0xb8, sp)
	clr	(0xb9, sp)
	clr	(0xba, sp)
	clr	(0xbb, sp)
	clr	(0xbc, sp)
	clr	(0xbd, sp)
	clr	(0xbe, sp)
	clr	(0xbf, sp)
	clr	(0xc0, sp)
	clr	(0xc1, sp)
	clr	(0xc2, sp)
	clr	(0xc3, sp)
	clr	(0xc4, sp)
	clr	(0xc5, sp)
	clr	(0xc6, sp)
	clr	(0xc7, sp)
	clr	(0xc8, sp)
	clr	(0xc9, sp)
	clr	(0xca, sp)
	clr	(0xcb, sp)
	clr	(0xcc, sp)
	clr	(0xcd, sp)
	clr	(0xce, sp)
	clr	(0xcf, sp)
	clr	(0xd0, sp)
	clr	(0xd1, sp)
	clr	(0xd2, sp)
	clr	(0xd3, sp)
	clr	(0xd4, sp)
	clr	(0xd5, sp)
	clr	(0xd6, sp)
	clr	(0xd7, sp)
	clr	(0xd8, sp)
	clr	(0xd9, sp)
	clr	(0xda, sp)
	clr	(0xdb, sp)
	clr	(0xdc, sp)
	clr	(0xdd, sp)
	clr	(0xde, sp)
	clr	(0xdf, sp)
	clr	(0xe0, sp)
	clr	(0xe1, sp)
	clr	(0xe2, sp)
	clr	(0xe3, sp)
	clr	(0xe4, sp)
	clr	(0xe5, sp)
	clr	(0xe6, sp)
	clr	(0xe7, sp)
	clr	(0xe8, sp)
	clr	(0xe9, sp)
	clr	(0xea, sp)
	clr	(0xeb, sp)
	clr	(0xec, sp)
	clr	(0xed, sp)
	clr	(0xee, sp)
	clr	(0xef, sp)
	clr	(0xf0, sp)
	clr	(0xf1, sp)
	clr	(0xf2, sp)
	clr	(0xf3, sp)
	clr	(0xf4, sp)
	clr	(0xf5, sp)
	clr	(0xf6, sp)
	clr	(0xf7, sp)
	clr	(0xf8, sp)
	clr	(0xf9, sp)
	clr	(0xfa, sp)
	clr	(0xfb, sp)
	clr	(0xfc, sp)
	clr	(0xfd, sp)
	clr	(0xfe, sp)
	clr	(0xff, sp)
	clr	(0x5, y)
;	main.c: 108: int i = 0;
	clrw	x
	ldw	(0x6, y), x
;	main.c: 109: while(i<5)
	clrw	x
	ldw	(0x8, y), x
00108$:
	ldw	x, y
	ldw	x, (0x8, x)
	cpw	x, #0x0005
	jrsge	00110$
;	main.c: 112: if(UART1_SR & UART_SR_RXNE)
	ld	a, 0x5230
	bcp	a, #0x20
	jreq	00121$
;	main.c: 116: buffer[i] = UART_RX();
	ldw	x, y
	ldw	x, (0x8, x)
	pushw	x
	ldw	x, sp
	addw	x, #3
	addw	x, (1, sp)
	addw	sp, #2
	pushw	x
	pushw	y
	call	_UART_RX
	popw	y
	popw	x
	ld	(x), a
;	main.c: 120: if(buffer[i] == '\r\n' || buffer[i] == '\0')
	cp	a, #0x0d
	jreq	00101$
	ld	a, (x)
	jrne	00102$
00101$:
;	main.c: 123: return 1;
	clrw	x
	incw	x
	jra	00114$
;	main.c: 124: break;
00102$:
;	main.c: 126: i++;
	ldw	x, y
	ldw	x, (0x8, x)
	incw	x
	ldw	(0x8, y), x
	ld	a, (0x8, y)
	ld	(0x6, y), a
	ld	a, (0x9, y)
	ld	(0x7, y), a
	jra	00108$
;	main.c: 131: for(int g = 0;g < i; g++)
00121$:
	clrw	x
	ldw	(0x8, y), x
00112$:
	ldw	x, y
	ldw	x, (0x8, x)
	cpw	x, (0x6, y)
	jrsge	00110$
;	main.c: 132: UART_TX(buffer[g]);
	ldw	x, y
	ldw	x, (0x8, x)
	pushw	x
	ldw	x, sp
	addw	x, #3
	addw	x, (1, sp)
	addw	sp, #2
	ld	a, (x)
	pushw	y
	call	_UART_TX
	popw	y
;	main.c: 131: for(int g = 0;g < i; g++)
	ldw	x, y
	ldw	x, (0x8, x)
	incw	x
	ldw	(0x8, y), x
	jra	00112$
;	main.c: 134: break;
00110$:
;	main.c: 138: return 0;
	clrw	x
00114$:
;	main.c: 139: }
	addw	sp, #255
	addw	sp, #5
	ret
;	main.c: 141: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 143: uart_init();
	call	_uart_init
;	main.c: 144: uart_write("ECHO START\n");
	ldw	x, #(___str_13+0)
	call	_uart_write
;	main.c: 145: while(uart_read()<1);
00101$:
	call	_uart_read
	cpw	x, #0x0001
	jrslt	00101$
;	main.c: 146: uart_write("ECHO end\n");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 147: return 0;
	clrw	x
;	main.c: 148: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "UART_REGS >.<"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.db 0x0a
	.ascii "SR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii " <-"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "DR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "BRR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "BRR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "CR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_7:
	.ascii "CR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_8:
	.ascii "CR3 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_9:
	.ascii "CR4 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.ascii "CR5 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_11:
	.ascii "GTR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_12:
	.ascii "PSCR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_13:
	.ascii "ECHO START"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_14:
	.ascii "ECHO end"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
