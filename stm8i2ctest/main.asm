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
	.globl _status_check
	.globl _uart_write_line
	.globl _convert_int_to_binary
	.globl _convert_int_to_chars
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
;	main.c: 7: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #8
;	main.c: 8: while (count--)
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
;	main.c: 9: nop();
	nop
	jra	00101$
00104$:
;	main.c: 10: }
	ldw	x, (9, sp)
	addw	sp, #14
	jp	(x)
;	main.c: 12: void convert_int_to_chars(int num, char* rx_int_chars) {
;	-----------------------------------------
;	 function convert_int_to_chars
;	-----------------------------------------
_convert_int_to_chars:
	sub	sp, #11
	ldw	(0x0a, sp), x
;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
	ldw	y, (0x0e, sp)
	ldw	(0x01, sp), y
;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x0c, sp)
;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
	call	__divsint
	ldw	(0x03, sp), x
	push	#0x0a
	push	#0x00
	ldw	x, (0x0c, sp)
;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
	call	__modsint
	ldw	y, x
	ld	a, xl
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x05, sp), x
;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x01, sp)
	incw	x
	incw	x
	ldw	(0x07, sp), x
	add	a, #0x30
	ld	(0x09, sp), a
;	main.c: 13: if (num > 99) {
	ldw	x, (0x0a, sp)
	cpw	x, #0x0063
	jrsle	00105$
;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
	push	#0x64
	push	#0x00
	ldw	x, (0x0c, sp)
	call	__divsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x01, sp)
	ld	(x), a
;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x05, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x05, sp)
	ld	(x), a
;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x07, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 18: rx_int_chars[3] ='\0';
	ldw	x, (0x01, sp)
	clr	(0x0003, x)
	jra	00107$
00105$:
;	main.c: 20: } else if (num > 9) {
	ldw	x, (0x0a, sp)
	cpw	x, #0x0009
	jrsle	00102$
;	main.c: 22: rx_int_chars[0] = num / 10 + '0';
	ld	a, (0x04, sp)
	add	a, #0x30
	ldw	x, (0x01, sp)
	ld	(x), a
;	main.c: 23: rx_int_chars[1] = num % 10 + '0';
	ldw	x, (0x05, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 24: rx_int_chars[2] ='\0';
	ldw	x, (0x07, sp)
	clr	(x)
	jra	00107$
00102$:
;	main.c: 29: rx_int_chars[0] = num + '0';
	ld	a, (0x0b, sp)
	add	a, #0x30
	ldw	x, (0x01, sp)
	ld	(x), a
;	main.c: 30: rx_int_chars[1] ='\0';
	ldw	x, (0x05, sp)
	clr	(x)
00107$:
;	main.c: 32: }
	ldw	x, (12, sp)
	addw	sp, #15
	jp	(x)
;	main.c: 34: void convert_int_to_binary(int num, char* rx_binary_chars) {
;	-----------------------------------------
;	 function convert_int_to_binary
;	-----------------------------------------
_convert_int_to_binary:
	sub	sp, #4
	ldw	(0x01, sp), x
;	main.c: 36: for(int i = 7; i >= 0; i--) {
	ldw	x, #0x0007
	ldw	(0x03, sp), x
00103$:
	tnz	(0x03, sp)
	jrmi	00101$
;	main.c: 38: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
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
;	main.c: 36: for(int i = 7; i >= 0; i--) {
	ldw	x, (0x03, sp)
	decw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 40: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
	ldw	x, (0x07, sp)
	clr	(0x0008, x)
;	main.c: 41: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	main.c: 46: int uart_write_line(const char *str) {
;	-----------------------------------------
;	 function uart_write_line
;	-----------------------------------------
_uart_write_line:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 48: for(i = 0; i < strlen(str); i++) {
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
;	main.c: 49: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 50: UART1_DR = str[i];
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	ld	0x5231, a
;	main.c: 48: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00106$
00104$:
;	main.c: 52: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 53: }
	addw	sp, #5
	ret
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
;	main.c: 57: convert_int_to_binary(I2C_SR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5217
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 58: uart_write_line("SR1 -> ");
	ldw	x, #(___str_0+0)
	call	_uart_write_line
;	main.c: 59: uart_write_line(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write_line
;	main.c: 60: uart_write_line(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write_line
;	main.c: 61: convert_int_to_binary(I2C_SR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5218
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 62: uart_write_line("SR2 -> ");
	ldw	x, #(___str_2+0)
	call	_uart_write_line
;	main.c: 63: uart_write_line(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write_line
;	main.c: 64: uart_write_line(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write_line
;	main.c: 65: convert_int_to_binary(I2C_SR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5219
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 66: uart_write_line("SR3 -> ");
	ldw	x, #(___str_3+0)
	call	_uart_write_line
;	main.c: 67: uart_write_line(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write_line
;	main.c: 68: uart_write_line(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write_line
;	main.c: 69: convert_int_to_binary(I2C_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5210
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 70: uart_write_line("CR1 -> ");
	ldw	x, #(___str_4+0)
	call	_uart_write_line
;	main.c: 71: uart_write_line(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write_line
;	main.c: 72: uart_write_line(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write_line
;	main.c: 73: convert_int_to_binary(I2C_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5211
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 74: uart_write_line("CR2 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write_line
;	main.c: 75: uart_write_line(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write_line
;	main.c: 76: uart_write_line(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write_line
;	main.c: 77: }
	addw	sp, #9
	ret
;	main.c: 79: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #5
;	main.c: 82: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 85: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 87: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 89: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 93: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
	bres	0x5210, #0
;	main.c: 97: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
	bres	0x521c, #7
;	main.c: 98: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
	bres	0x5214, #7
;	main.c: 99: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
	bset	0x5214, #6
;	main.c: 100: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
	bset	0x5210, #0
;	main.c: 101: status_check();
	call	_status_check
;	main.c: 106: uart_write_line("Start Scanning\n");
	ldw	x, #(___str_6+0)
	call	_uart_write_line
;	main.c: 108: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
	clr	(0x05, sp)
00106$:
	ld	a, (0x05, sp)
	cp	a, #0xff
	jrnc	00104$
;	main.c: 111: uart_write_line("_______Start______\n");
	ldw	x, #(___str_7+0)
	call	_uart_write_line
;	main.c: 112: uart_write_line("Dev ->  ");
	ldw	x, #(___str_8+0)
	call	_uart_write_line
;	main.c: 113: char rx_int_chars[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 115: convert_int_to_chars(addr, rx_int_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, (0x05, sp)
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_chars
;	main.c: 116: uart_write_line(rx_int_chars);
	ldw	x, sp
	incw	x
	call	_uart_write_line
;	main.c: 117: uart_write_line("  <- Dev\n");
	ldw	x, #(___str_9+0)
	call	_uart_write_line
;	main.c: 123: I2C_CR2 = I2C_CR2 | (1 << 2); // Set ACK bit
	bset	0x5211, #2
;	main.c: 126: I2C_CR2 = I2C_CR2 | (1 << 0); // START
	bset	0x5211, #0
;	main.c: 129: while (!(I2C_SR1 & (1 << 0)));
00101$:
	btjf	0x5217, #0, 00101$
;	main.c: 133: I2C_DR = I2C_DR | addr;
	ld	a, 0x5216
	or	a, (0x05, sp)
	ld	0x5216, a
;	main.c: 140: I2C_SR1 = 0x00;
	mov	0x5217+0, #0x00
;	main.c: 141: I2C_SR3 = 0x00;
	mov	0x5219+0, #0x00
;	main.c: 142: I2C_CR2 = I2C_CR2 | (1 << 1); // STOP
	bset	0x5211, #1
;	main.c: 143: status_check();
	call	_status_check
;	main.c: 146: uart_write_line("_______Stop_______\n");
	ldw	x, #(___str_10+0)
	call	_uart_write_line
;	main.c: 108: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
	inc	(0x05, sp)
	jra	00106$
00104$:
;	main.c: 152: return 0;
	clrw	x
;	main.c: 153: }
	addw	sp, #5
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "SR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii " <-"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "SR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "SR3 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "CR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "CR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "Start Scanning"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_7:
	.ascii "_______Start______"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_8:
	.ascii "Dev ->  "
	.db 0x00
	.area CODE
	.area CONST
___str_9:
	.ascii "  <- Dev"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.ascii "_______Stop_______"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
