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
	.globl _i2c_scan
	.globl _i2c_stop
	.globl _i2c_send_address
	.globl _i2c_start
	.globl _i2c_init
	.globl _uart_init
	.globl _status_check
	.globl _convert_int_to_binary
	.globl _convert_int_to_chars
	.globl _uart_write
	.globl _delay
	.globl _strlen
	.globl _current_dev
	.globl _buffer
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_buffer::
	.ds 256
_current_dev::
	.ds 1
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
;	main.c: 8: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #8
;	main.c: 9: while (count--)
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
;	main.c: 10: nop();
	nop
	jra	00101$
00104$:
;	main.c: 11: }
	ldw	x, (9, sp)
	addw	sp, #14
	jp	(x)
;	main.c: 13: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 15: for(i = 0; i < strlen(str); i++) {
	clr	(0x05, sp)
00106$:
	ldw	x, (0x03, sp)
	call	_strlen
	ldw	(0x01, sp), x
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	cpw	x, (0x01, sp)
	jrnc	00104$
;	main.c: 16: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 17: UART1_DR = str[i];
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	ld	0x5231, a
;	main.c: 15: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00106$
00104$:
;	main.c: 19: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 20: }
	addw	sp, #5
	ret
;	main.c: 24: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
;	-----------------------------------------
;	 function convert_int_to_chars
;	-----------------------------------------
_convert_int_to_chars:
	sub	sp, #13
	ld	(0x0d, sp), a
	ldw	(0x0b, sp), x
;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
	ld	a, (0x0d, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	ldw	(0x03, sp), x
;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x05, sp), x
;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
	call	__divsint
	ldw	(0x07, sp), x
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ld	(0x09, sp), a
;	main.c: 25: if (num > 99) {
	ld	a, (0x0d, sp)
	cp	a, #0x63
	jrule	00105$
;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
	push	#0x64
	push	#0x00
	ldw	x, (0x03, sp)
	call	__divsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x09, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x03, sp)
	ld	(x), a
;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x05, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 30: rx_int_chars[3] ='\0';
	ldw	x, (0x0b, sp)
	clr	(0x0003, x)
	jra	00107$
00105$:
;	main.c: 32: } else if (num > 9) {
	ld	a, (0x0d, sp)
	cp	a, #0x09
	jrule	00102$
;	main.c: 34: rx_int_chars[0] = num / 10 + '0';
	ld	a, (0x08, sp)
	ld	(0x0a, sp), a
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 35: rx_int_chars[1] = num % 10 + '0';
	ldw	x, (0x03, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 36: rx_int_chars[2] ='\0';
	ldw	x, (0x05, sp)
	clr	(x)
	jra	00107$
00102$:
;	main.c: 41: rx_int_chars[0] = num + '0';
	ld	a, (0x0d, sp)
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 42: rx_int_chars[1] ='\0';
	ldw	x, (0x03, sp)
	clr	(x)
00107$:
;	main.c: 44: }
	addw	sp, #13
	ret
;	main.c: 46: void convert_int_to_binary(int num, char* rx_binary_chars) {
;	-----------------------------------------
;	 function convert_int_to_binary
;	-----------------------------------------
_convert_int_to_binary:
	sub	sp, #4
	ldw	(0x01, sp), x
;	main.c: 48: for(int i = 7; i >= 0; i--) {
	ldw	x, #0x0007
	ldw	(0x03, sp), x
00103$:
	tnz	(0x03, sp)
	jrmi	00101$
;	main.c: 50: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
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
;	main.c: 48: for(int i = 7; i >= 0; i--) {
	ldw	x, (0x03, sp)
	decw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 52: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
	ldw	x, (0x07, sp)
	clr	(0x0008, x)
;	main.c: 53: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	main.c: 55: void status_check(void){
;	-----------------------------------------
;	 function status_check
;	-----------------------------------------
_status_check:
	sub	sp, #9
;	main.c: 56: char rx_binary_chars[9]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
;	main.c: 57: uart_write("\nI2C_REGS >.<\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	main.c: 58: convert_int_to_binary(I2C_SR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5217
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 59: uart_write("\nSR1 -> ");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 60: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 61: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 62: convert_int_to_binary(I2C_SR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5218
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 63: uart_write("SR2 -> ");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 64: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 65: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 66: convert_int_to_binary(I2C_SR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5219
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 67: uart_write("SR3 -> ");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	main.c: 68: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 69: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 70: convert_int_to_binary(I2C_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5210
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 71: uart_write("CR1 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	main.c: 72: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 73: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 74: convert_int_to_binary(I2C_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5211
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 75: uart_write("CR2 -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 76: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 77: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 78: convert_int_to_binary(I2C_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5216
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 79: uart_write("DR -> ");
	ldw	x, #(___str_7+0)
	call	_uart_write
;	main.c: 80: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 81: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 82: uart_write("UART_REGS >.<\n");
	ldw	x, #(___str_8+0)
	call	_uart_write
;	main.c: 83: convert_int_to_binary(UART1_SR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5230
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 84: uart_write("\nSR -> ");
	ldw	x, #(___str_9+0)
	call	_uart_write
;	main.c: 85: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 86: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 87: convert_int_to_binary(UART1_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5231
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 88: uart_write("DR -> ");
	ldw	x, #(___str_7+0)
	call	_uart_write
;	main.c: 89: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 90: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 91: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5232
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 92: uart_write("BRR1 -> ");
	ldw	x, #(___str_10+0)
	call	_uart_write
;	main.c: 93: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 94: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 95: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5233
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 96: uart_write("BRR2 -> ");
	ldw	x, #(___str_11+0)
	call	_uart_write
;	main.c: 97: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 98: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 99: convert_int_to_binary(UART1_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5234
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 100: uart_write("CR1 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	main.c: 101: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 102: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 103: convert_int_to_binary(UART1_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5235
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 104: uart_write("CR2 -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 105: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 106: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 107: convert_int_to_binary(UART1_CR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5236
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 108: uart_write("CR3 -> ");
	ldw	x, #(___str_12+0)
	call	_uart_write
;	main.c: 109: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 110: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 111: convert_int_to_binary(UART1_CR4, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5237
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 112: uart_write("CR4 -> ");
	ldw	x, #(___str_13+0)
	call	_uart_write
;	main.c: 113: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 114: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 115: convert_int_to_binary(UART1_CR5, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5238
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 116: uart_write("CR5 -> ");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 117: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 118: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 119: convert_int_to_binary(UART1_GTR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5239
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 120: uart_write("GTR -> ");
	ldw	x, #(___str_15+0)
	call	_uart_write
;	main.c: 121: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 122: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 123: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x523a
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 124: uart_write("PSCR -> ");
	ldw	x, #(___str_16+0)
	call	_uart_write
;	main.c: 125: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 126: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 127: }
	addw	sp, #9
	ret
;	main.c: 129: void uart_init(void){
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	main.c: 130: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 133: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 134: UART1_CR2 |= UART_CR2_REN; // Receiver enable
	bset	0x5235, #2
;	main.c: 135: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 137: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 138: }
	ret
;	main.c: 142: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	main.c: 148: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
	bres	0x5210, #0
;	main.c: 149: I2C_FREQR= 16;                  // peripheral frequence =16MHz
	mov	0x5212+0, #0x10
;	main.c: 150: I2C_CCRH = 0;                   // =0
	mov	0x521c+0, #0x00
;	main.c: 151: I2C_CCRL = 80;                  // 100kHz for I2C
	mov	0x521b+0, #0x50
;	main.c: 152: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
	bres	0x521c, #7
;	main.c: 153: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
	bres	0x5214, #7
;	main.c: 154: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
	bset	0x5214, #6
;	main.c: 155: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
	bset	0x5210, #0
;	main.c: 156: }
	ret
;	main.c: 160: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	main.c: 161: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
	bset	0x5211, #0
;	main.c: 162: while(!(I2C_SR1 & (1 << 0)));
00101$:
	btjf	0x5217, #0, 00101$
;	main.c: 164: }
	ret
;	main.c: 166: void i2c_send_address(uint8_t address) {
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	main.c: 167: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
	sll	a
	ld	0x5216, a
;	main.c: 168: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
00102$:
	btjf	0x5217, #1, 00117$
	ret
00117$:
	btjf	0x5218, #2, 00102$
;	main.c: 169: }
	ret
;	main.c: 171: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	main.c: 172: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
	bset	0x5211, #1
;	main.c: 174: }
	ret
;	main.c: 178: void i2c_scan(void) {
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #5
;	main.c: 179: for (uint8_t addr = 1; addr < 127; addr++) {
	ld	a, #0x01
	ld	(0x05, sp), a
00105$:
	ld	a, (0x05, sp)
	cp	a, #0x7f
	jrnc	00107$
;	main.c: 180: i2c_start();
	call	_i2c_start
;	main.c: 181: i2c_send_address(addr);
	ld	a, (0x05, sp)
	call	_i2c_send_address
;	main.c: 182: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
	btjt	0x5218, #2, 00102$
;	main.c: 184: uart_write("SM ");
	ldw	x, #(___str_17+0)
	call	_uart_write
;	main.c: 185: char rx_int_chars[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 186: convert_int_to_chars(addr, rx_int_chars);
	ldw	x, sp
	incw	x
	ld	a, (0x05, sp)
	call	_convert_int_to_chars
;	main.c: 187: uart_write(rx_int_chars); 
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 188: uart_write("\r\n");
	ldw	x, #(___str_18+0)
	call	_uart_write
;	main.c: 189: current_dev = addr;
	ld	a, (0x05, sp)
	ld	_current_dev+0, a
;	main.c: 190: status_check();
	call	_status_check
00102$:
;	main.c: 192: i2c_stop();
	call	_i2c_stop
;	main.c: 193: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
	bres	0x5218, #2
;	main.c: 179: for (uint8_t addr = 1; addr < 127; addr++) {
	inc	(0x05, sp)
	jra	00105$
00107$:
;	main.c: 197: }
	addw	sp, #5
	ret
;	main.c: 200: int uart_read(void)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
	sub	sp, #11
;	main.c: 202: char rx_binary_chars[9]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
;	main.c: 203: for(int i = 0; i < 256; i++)
	clrw	x
00112$:
	cpw	x, #0x0100
	jrsge	00101$
;	main.c: 205: buffer[i] = 0;
	ldw	y, x
	clr	((_buffer+0), y)
;	main.c: 203: for(int i = 0; i < 256; i++)
	incw	x
	jra	00112$
00101$:
;	main.c: 207: int i = 0;
	clrw	x
	ldw	(0x0a, sp), x
;	main.c: 208: while(i < 256)
	clrw	y
00108$:
	cpw	y, #0x0100
	jrsge	00110$
;	main.c: 210: while(!(UART1_SR & UART_SR_RXNE));
00102$:
	btjf	0x5230, #5, 00102$
;	main.c: 211: buffer[i] = UART1_DR;
	ldw	x, y
	addw	x, #(_buffer+0)
	ld	a, 0x5231
	ld	(x), a
;	main.c: 212: if(buffer[i] == '\n' || buffer[i] == '\0')
	cp	a, #0x0a
	jreq	00105$
	ld	a, (x)
	jrne	00106$
00105$:
;	main.c: 214: buffer[i] = '\0';
	ldw	x, (0x0a, sp)
	clr	((_buffer+0), x)
;	main.c: 215: uart_write("flag_S");
	ldw	x, #(___str_19+0)
	call	_uart_write
;	main.c: 216: return 1;
	clrw	x
	incw	x
	jra	00114$
00106$:
;	main.c: 218: i++;
	incw	y
	ldw	(0x0a, sp), y
	jra	00108$
00110$:
;	main.c: 220: return 0;
	clrw	x
00114$:
;	main.c: 246: }
	addw	sp, #11
	ret
;	main.c: 249: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 251: uart_init();
	call	_uart_init
;	main.c: 252: uart_write("SS\n");
	ldw	x, #(___str_20+0)
	call	_uart_write
;	main.c: 254: while(uart_read())
00102$:
	call	_uart_read
	tnzw	x
	jreq	00104$
;	main.c: 256: uart_write("\n>buffer start<\n");
	ldw	x, #(___str_21+0)
	call	_uart_write
;	main.c: 257: for(int i = 0; i < 256; i++)
	clrw	x
00106$:
	cpw	x, #0x0100
	jrsge	00101$
;	main.c: 259: uart_write(&buffer[i] + '\0');
	ldw	y, x
	addw	y, #(_buffer+0)
	pushw	x
	ldw	x, y
	call	_uart_write
	ldw	x, #(___str_22+0)
	call	_uart_write
	popw	x
;	main.c: 257: for(int i = 0; i < 256; i++)
	incw	x
	jra	00106$
00101$:
;	main.c: 262: uart_write("> buffer end <");
	ldw	x, #(___str_23+0)
	call	_uart_write
	jra	00102$
00104$:
;	main.c: 264: i2c_init();
	call	_i2c_init
;	main.c: 268: i2c_scan(); 
	call	_i2c_scan
;	main.c: 270: return 0;
	clrw	x
;	main.c: 271: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.db 0x0a
	.ascii "I2C_REGS >.<"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.db 0x0a
	.ascii "SR1 -> "
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
	.ascii "SR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "SR3 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "CR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "CR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_7:
	.ascii "DR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_8:
	.ascii "UART_REGS >.<"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_9:
	.db 0x0a
	.ascii "SR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.ascii "BRR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_11:
	.ascii "BRR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_12:
	.ascii "CR3 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_13:
	.ascii "CR4 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_14:
	.ascii "CR5 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_15:
	.ascii "GTR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_16:
	.ascii "PSCR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_17:
	.ascii "SM "
	.db 0x00
	.area CODE
	.area CONST
___str_18:
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_19:
	.ascii "flag_S"
	.db 0x00
	.area CODE
	.area CONST
___str_20:
	.ascii "SS"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_21:
	.db 0x0a
	.ascii ">buffer start<"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_22:
	.ascii " "
	.db 0x00
	.area CODE
	.area CONST
___str_23:
	.ascii "> buffer end <"
	.db 0x00
	.area CODE
	.area INITIALIZER
__xinit__buffer:
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
__xinit__current_dev:
	.db #0x00	; 0
	.area CABS (ABS)
