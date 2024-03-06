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
;	main.c: 12: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 14: for(i = 0; i < strlen(str); i++) {
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
;	main.c: 15: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 16: UART1_DR = str[i];
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	ld	0x5231, a
;	main.c: 14: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00106$
00104$:
;	main.c: 18: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 19: }
	addw	sp, #5
	ret
;	main.c: 21: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
;	-----------------------------------------
;	 function convert_int_to_chars
;	-----------------------------------------
_convert_int_to_chars:
	sub	sp, #13
	ld	(0x0d, sp), a
	ldw	(0x0b, sp), x
;	main.c: 24: rx_int_chars[0] = num / 100 + '0';
	ld	a, (0x0d, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	main.c: 25: rx_int_chars[1] = num / 10 % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	ldw	(0x03, sp), x
;	main.c: 26: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x05, sp), x
;	main.c: 25: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
;	main.c: 26: rx_int_chars[2] = num % 10 + '0';
	call	__divsint
	ldw	(0x07, sp), x
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ld	(0x09, sp), a
;	main.c: 22: if (num > 99) {
	ld	a, (0x0d, sp)
	cp	a, #0x63
	jrule	00105$
;	main.c: 24: rx_int_chars[0] = num / 100 + '0';
	push	#0x64
	push	#0x00
	ldw	x, (0x03, sp)
	call	__divsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 25: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x09, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x03, sp)
	ld	(x), a
;	main.c: 26: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x05, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 27: rx_int_chars[3] ='\0';
	ldw	x, (0x0b, sp)
	clr	(0x0003, x)
	jra	00107$
00105$:
;	main.c: 29: } else if (num > 9) {
	ld	a, (0x0d, sp)
	cp	a, #0x09
	jrule	00102$
;	main.c: 31: rx_int_chars[0] = num / 10 + '0';
	ld	a, (0x08, sp)
	ld	(0x0a, sp), a
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 32: rx_int_chars[1] = num % 10 + '0';
	ldw	x, (0x03, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 33: rx_int_chars[2] ='\0';
	ldw	x, (0x05, sp)
	clr	(x)
	jra	00107$
00102$:
;	main.c: 38: rx_int_chars[0] = num + '0';
	ld	a, (0x0d, sp)
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 39: rx_int_chars[1] ='\0';
	ldw	x, (0x03, sp)
	clr	(x)
00107$:
;	main.c: 41: }
	addw	sp, #13
	ret
;	main.c: 43: void convert_int_to_binary(int num, char* rx_binary_chars) {
;	-----------------------------------------
;	 function convert_int_to_binary
;	-----------------------------------------
_convert_int_to_binary:
	sub	sp, #4
	ldw	(0x01, sp), x
;	main.c: 45: for(int i = 7; i >= 0; i--) {
	ldw	x, #0x0007
	ldw	(0x03, sp), x
00103$:
	tnz	(0x03, sp)
	jrmi	00101$
;	main.c: 47: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
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
;	main.c: 45: for(int i = 7; i >= 0; i--) {
	ldw	x, (0x03, sp)
	decw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 49: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
	ldw	x, (0x07, sp)
	clr	(0x0008, x)
;	main.c: 50: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	main.c: 52: void status_check(void){
;	-----------------------------------------
;	 function status_check
;	-----------------------------------------
_status_check:
	sub	sp, #9
;	main.c: 53: char rx_binary_chars[9]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
;	main.c: 54: convert_int_to_binary(I2C_SR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5217
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 55: uart_write("\nSR1 -> ");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	main.c: 56: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 57: uart_write(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 58: convert_int_to_binary(I2C_SR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5218
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 59: uart_write("SR2 -> ");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 60: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 61: uart_write(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 62: convert_int_to_binary(I2C_SR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5219
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 63: uart_write("SR3 -> ");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 64: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 65: uart_write(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 66: convert_int_to_binary(I2C_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5210
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 67: uart_write("CR1 -> ");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	main.c: 68: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 69: uart_write(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 70: convert_int_to_binary(I2C_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5211
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 71: uart_write("CR2 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	main.c: 72: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 73: uart_write(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 74: convert_int_to_binary(I2C_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5216
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 75: uart_write("DR -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 76: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 77: uart_write(" <-\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 78: }
	addw	sp, #9
	ret
;	main.c: 80: void uart_init(void){
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	main.c: 81: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 84: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 86: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 88: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 89: }
	ret
;	main.c: 93: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	main.c: 99: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
	bres	0x5210, #0
;	main.c: 100: I2C_FREQR= 16;                  // peripheral frequence =16MHz
	mov	0x5212+0, #0x10
;	main.c: 101: I2C_CCRH = 0;                   // =0
	mov	0x521c+0, #0x00
;	main.c: 102: I2C_CCRL = 80;                  // 100kHz for I2C
	mov	0x521b+0, #0x50
;	main.c: 103: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
	bres	0x521c, #7
;	main.c: 104: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
	bres	0x5214, #7
;	main.c: 105: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
	bset	0x5214, #6
;	main.c: 106: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
	bset	0x5210, #0
;	main.c: 107: }
	ret
;	main.c: 111: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	main.c: 112: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
	bset	0x5211, #0
;	main.c: 113: while(!(I2C_SR1 & (1 << 0)));
00101$:
	ld	a, 0x5217
	srl	a
	jrnc	00101$
;	main.c: 114: uart_write("Start generated\n"); // Ожидание отправки стартового сигнала
	ldw	x, #(___str_7+0)
;	main.c: 115: }
	jp	_uart_write
;	main.c: 117: void i2c_send_address(uint8_t address) {
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	main.c: 118: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
	sll	a
	ld	0x5216, a
;	main.c: 119: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
00102$:
	ld	a, 0x5217
	bcp	a, #0x02
	jrne	00104$
	ld	a, 0x5218
	bcp	a, #0x04
	jreq	00102$
00104$:
;	main.c: 125: uart_write("Addr send\n"); // Ожидание подтверждения адреса
	ldw	x, #(___str_8+0)
;	main.c: 126: }
	jp	_uart_write
;	main.c: 128: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	main.c: 129: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
	ld	a, 0x5211
	or	a, #0x02
	ld	0x5211, a
;	main.c: 130: uart_write("Stop generated\n");
	ldw	x, #(___str_9+0)
;	main.c: 131: }
	jp	_uart_write
;	main.c: 133: void i2c_scan(void) {
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #5
;	main.c: 134: for (uint8_t addr = 1; addr < 127; addr++) {
	ld	a, #0x01
	ld	(0x05, sp), a
00105$:
	ld	a, (0x05, sp)
	cp	a, #0x7f
	jrnc	00103$
;	main.c: 135: i2c_start();
	call	_i2c_start
;	main.c: 136: i2c_send_address(addr);
	ld	a, (0x05, sp)
	call	_i2c_send_address
;	main.c: 137: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
	btjt	0x5218, #2, 00102$
;	main.c: 139: uart_write("Device found at: ");
	ldw	x, #(___str_10+0)
	call	_uart_write
;	main.c: 140: char rx_int_chars[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 143: uart_write("\r\n");
	ldw	x, #(___str_11+0)
	call	_uart_write
;	main.c: 144: status_check();
	call	_status_check
00102$:
;	main.c: 146: i2c_stop();
	call	_i2c_stop
;	main.c: 147: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
	bres	0x5218, #2
;	main.c: 148: delay(10000L); // Небольшая задержка для стабилизации шины
	push	#0x10
	push	#0x27
	clrw	x
	pushw	x
	call	_delay
;	main.c: 134: for (uint8_t addr = 1; addr < 127; addr++) {
	inc	(0x05, sp)
	jra	00105$
00103$:
;	main.c: 150: uart_write("Devs Not Found");
	ldw	x, #(___str_12+0)
	call	_uart_write
;	main.c: 151: }
	addw	sp, #5
	ret
;	main.c: 157: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 159: uart_init();
	call	_uart_init
;	main.c: 160: uart_write("Start Scanning\n");
	ldw	x, #(___str_13+0)
	call	_uart_write
;	main.c: 161: i2c_init();
	call	_i2c_init
;	main.c: 162: status_check();
	call	_status_check
;	main.c: 165: i2c_scan(); 
	call	_i2c_scan
;	main.c: 167: return 0;
	clrw	x
;	main.c: 168: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.db 0x0a
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
	.ascii "DR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_7:
	.ascii "Start generated"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_8:
	.ascii "Addr send"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_9:
	.ascii "Stop generated"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.ascii "Device found at: "
	.db 0x00
	.area CODE
	.area CONST
___str_11:
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_12:
	.ascii "Devs Not Found"
	.db 0x00
	.area CODE
	.area CONST
___str_13:
	.ascii "Start Scanning"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
