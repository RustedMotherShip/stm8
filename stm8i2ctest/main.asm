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
	.globl _uart_write_char
	.globl _uart_write_line
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
;	main.c: 5: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #8
;	main.c: 6: while (count--)
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
;	main.c: 7: nop();
	nop
	jra	00101$
00104$:
;	main.c: 8: }
	ldw	x, (9, sp)
	addw	sp, #14
	jp	(x)
;	main.c: 10: int uart_write_line(const char *str) {
;	-----------------------------------------
;	 function uart_write_line
;	-----------------------------------------
_uart_write_line:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 12: for(i = 0; i < strlen(str); i++) {
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
;	main.c: 13: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 14: UART1_DR = str[i];
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	ld	0x5231, a
;	main.c: 12: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00106$
00104$:
;	main.c: 16: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 17: }
	addw	sp, #5
	ret
;	main.c: 19: void uart_write_char(char str_char) {
;	-----------------------------------------
;	 function uart_write_char
;	-----------------------------------------
_uart_write_char:
	push	a
	ld	(0x01, sp), a
;	main.c: 20: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 21: UART1_DR = str_char;
	ldw	x, #0x5231
	ld	a, (0x01, sp)
	ld	(x), a
;	main.c: 22: }
	pop	a
	ret
;	main.c: 25: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	push	a
;	main.c: 28: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 31: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 33: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 35: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 38: I2C_CR1 = 0x01;  // включаем подключение к шине
	mov	0x5210+0, #0x01
;	main.c: 39: I2C_FREQR = 0x01;  
	mov	0x5212+0, #0x01
;	main.c: 40: I2C_CCRL = 0x50;  // Загружаем нижние 8 бит делителя для получения 100 кГц
	mov	0x521b+0, #0x50
;	main.c: 41: I2C_CCRH = 0x00;  // Обнуляем верхние биты делителя
	mov	0x521c+0, #0x00
;	main.c: 44: while(1) {
00103$:
;	main.c: 45: uart_write_line("Start Scanning\n");
	ldw	x, #(___str_0+0)
	call	_uart_write_line
;	main.c: 47: for(char addr = 0x00; addr < 0xFF;addr++)
	clr	(0x01, sp)
00106$:
	ld	a, (0x01, sp)
	cp	a, #0xff
	jrnc	00103$
;	main.c: 50: uart_write_line("_______Start______\n");
	ldw	x, #(___str_1+0)
	call	_uart_write_line
;	main.c: 51: uart_write_line("Dev -> ");
	ldw	x, #(___str_2+0)
	call	_uart_write_line
;	main.c: 52: uart_write_char(addr);
	ld	a, (0x01, sp)
	call	_uart_write_char
;	main.c: 53: uart_write_line(" <-Dev\n");
	ldw	x, #(___str_3+0)
	call	_uart_write_line
;	main.c: 56: I2C_DR = addr;
	ldw	x, #0x5216
	ld	a, (0x01, sp)
	ld	(x), a
;	main.c: 61: uart_write_line("_______Stop_______\n");
	ldw	x, #(___str_4+0)
	call	_uart_write_line
;	main.c: 62: delay(2000000L);
	push	#0x80
	push	#0x84
	push	#0x1e
	push	#0x00
	call	_delay
;	main.c: 47: for(char addr = 0x00; addr < 0xFF;addr++)
	inc	(0x01, sp)
	jra	00106$
;	main.c: 67: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "Start Scanning"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "_______Start______"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "Dev -> "
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii " <-Dev"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "_______Stop_______"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
