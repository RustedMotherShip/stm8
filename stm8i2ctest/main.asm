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
	.globl _command_switcher
	.globl _data_handler
	.globl _cm_SW
	.globl _cm_SR
	.globl _cm_ST
	.globl _cm_DB
	.globl _cm_RM
	.globl _cm_SN
	.globl _cm_SM
	.globl _i2c_scan
	.globl _i2c_read
	.globl _i2c_write
	.globl _i2c_stop
	.globl _i2c_send_address
	.globl _i2c_start
	.globl _i2c_init
	.globl _uart_init
	.globl _status_check
	.globl _char_buffer_to_int
	.globl _get_size_from_buff
	.globl _get_addr_from_buff
	.globl _convert_int_to_binary
	.globl _convert_chars_to_int
	.globl _convert_int_to_chars
	.globl _uart_read
	.globl _uart_write
	.globl _UART_RX
	.globl _UART_TX
	.globl _delay
	.globl ___memcpy
	.globl _strlen
	.globl _memset
	.globl _memcmp
	.globl _current_dev
	.globl _data_buf
	.globl _p_bytes
	.globl _d_size
	.globl _p_size
	.globl _d_addr
	.globl _a
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
_a::
	.ds 3
_d_addr::
	.ds 1
_p_size::
	.ds 1
_d_size::
	.ds 1
_p_bytes::
	.ds 1
_data_buf::
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
;	main.c: 26: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #8
;	main.c: 27: while (count--)
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
;	main.c: 28: nop();
	nop
	jra	00101$
00104$:
;	main.c: 29: }
	ldw	x, (9, sp)
	addw	sp, #14
	jp	(x)
;	main.c: 37: void UART_TX(unsigned char value)
;	-----------------------------------------
;	 function UART_TX
;	-----------------------------------------
_UART_TX:
;	main.c: 39: UART1_DR = value;
	ld	0x5231, a
;	main.c: 40: while(!(UART1_SR & UART_SR_TXE));
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 41: }
	ret
;	main.c: 42: unsigned char UART_RX(void)
;	-----------------------------------------
;	 function UART_RX
;	-----------------------------------------
_UART_RX:
;	main.c: 44: while(!(UART1_SR & UART_SR_TXE));
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 45: return UART1_DR;
	ld	a, 0x5231
;	main.c: 46: }
	ret
;	main.c: 47: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 49: for(i = 0; i < strlen(str); i++) {
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
;	main.c: 51: UART_TX(str[i]);
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	call	_UART_TX
;	main.c: 49: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00103$
00101$:
;	main.c: 53: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 54: }
	addw	sp, #5
	ret
;	main.c: 55: int uart_read(void)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
;	main.c: 57: memset(buffer, 0, sizeof(buffer));
	push	#0x00
	push	#0x01
	clrw	x
	pushw	x
	ldw	x, #(_buffer+0)
	call	_memset
;	main.c: 59: while(i<256)
	clrw	x
00105$:
	cpw	x, #0x0100
	jrsge	00107$
;	main.c: 61: if(UART1_SR & UART_SR_RXNE)
	ld	a, 0x5230
	bcp	a, #0x20
	jreq	00105$
;	main.c: 63: buffer[i] = UART_RX();
	ldw	y, x
	addw	y, #(_buffer+0)
	pushw	x
	pushw	y
	call	_UART_RX
	popw	y
	popw	x
	ld	(y), a
;	main.c: 64: if(buffer[i] == '\r\n' )
	cp	a, #0x0d
	jrne	00102$
;	main.c: 66: return 1;
	clrw	x
	incw	x
	ret
;	main.c: 67: break;
00102$:
;	main.c: 69: i++;
	incw	x
	jra	00105$
00107$:
;	main.c: 72: return 0;
	clrw	x
;	main.c: 73: }
	ret
;	main.c: 82: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
;	-----------------------------------------
;	 function convert_int_to_chars
;	-----------------------------------------
_convert_int_to_chars:
	sub	sp, #13
	ld	(0x0d, sp), a
	ldw	(0x0b, sp), x
;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
	ld	a, (0x0d, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	ldw	(0x03, sp), x
;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x05, sp), x
;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
	call	__divsint
	ldw	(0x07, sp), x
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ld	(0x09, sp), a
;	main.c: 83: if (num > 99) {
	ld	a, (0x0d, sp)
	cp	a, #0x63
	jrule	00105$
;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
	push	#0x64
	push	#0x00
	ldw	x, (0x03, sp)
	call	__divsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x09, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x03, sp)
	ld	(x), a
;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x05, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 88: rx_int_chars[3] ='\0';
	ldw	x, (0x0b, sp)
	clr	(0x0003, x)
	jra	00107$
00105$:
;	main.c: 90: } else if (num > 9) {
	ld	a, (0x0d, sp)
	cp	a, #0x09
	jrule	00102$
;	main.c: 92: rx_int_chars[0] = num / 10 + '0';
	ld	a, (0x08, sp)
	ld	(0x0a, sp), a
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 93: rx_int_chars[1] = num % 10 + '0';
	ldw	x, (0x03, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 94: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
	ldw	x, (0x05, sp)
	clr	(x)
	jra	00107$
00102$:
;	main.c: 97: rx_int_chars[0] = num + '0';
	ld	a, (0x0d, sp)
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 98: rx_int_chars[1] ='\0';
	ldw	x, (0x03, sp)
	clr	(x)
00107$:
;	main.c: 100: }
	addw	sp, #13
	ret
;	main.c: 102: int convert_chars_to_int(char* rx_chars_int) {
;	-----------------------------------------
;	 function convert_chars_to_int
;	-----------------------------------------
_convert_chars_to_int:
	sub	sp, #3
	ldw	(0x02, sp), x
;	main.c: 103: uint8_t result = 0;
	clrw	x
;	main.c: 105: for (int i = 0; i < 3; i++) {
	clrw	y
00103$:
	cpw	y, #0x0003
	jrsge	00101$
;	main.c: 106: result = (result * 10) + (rx_chars_int[i] - '0');
	ld	a, #0x0a
	mul	x, a
	exg	a, xl
	ld	(0x01, sp), a
	exg	a, xl
	ldw	x, y
	addw	x, (0x02, sp)
	ld	a, (x)
	sub	a, #0x30
	add	a, (0x01, sp)
	ld	xl, a
;	main.c: 105: for (int i = 0; i < 3; i++) {
	incw	y
	jra	00103$
00101$:
;	main.c: 109: return result;
	clr	a
	ld	xh, a
;	main.c: 110: }
	addw	sp, #3
	ret
;	main.c: 113: void convert_int_to_binary(int num, char* rx_binary_chars) {
;	-----------------------------------------
;	 function convert_int_to_binary
;	-----------------------------------------
_convert_int_to_binary:
	sub	sp, #4
	ldw	(0x01, sp), x
;	main.c: 115: for(int i = 7; i >= 0; i--) {
	ldw	x, #0x0007
	ldw	(0x03, sp), x
00103$:
	tnz	(0x03, sp)
	jrmi	00101$
;	main.c: 117: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
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
;	main.c: 115: for(int i = 7; i >= 0; i--) {
	ldw	x, (0x03, sp)
	decw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 119: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
	ldw	x, (0x07, sp)
	clr	(0x0008, x)
;	main.c: 120: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	main.c: 129: void get_addr_from_buff(void)
;	-----------------------------------------
;	 function get_addr_from_buff
;	-----------------------------------------
_get_addr_from_buff:
	sub	sp, #2
;	main.c: 133: while(1)
	ld	a, #0x04
	ld	(0x01, sp), a
	clr	(0x02, sp)
00105$:
;	main.c: 135: if(buffer[i] == 32 || buffer[i] == 10)
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	ld	a, (_buffer+0, x)
	cp	a, #0x20
	jreq	00101$
	cp	a, #0x0a
	jrne	00102$
00101$:
;	main.c: 137: p_size = i+1;
	ld	a, (0x01, sp)
	inc	a
	ld	_p_size+0, a
;	main.c: 138: break;
	jra	00106$
00102$:
;	main.c: 140: i++;
	inc	(0x01, sp)
;	main.c: 141: counter++;
	inc	(0x02, sp)
	jra	00105$
00106$:
;	main.c: 143: memcpy(a, &buffer[3], counter);
	clrw	x
	ld	a, (0x02, sp)
	ld	xl, a
	pushw	x
	push	#<(_buffer+3)
	push	#((_buffer+3) >> 8)
	ldw	x, #(_a+0)
	call	___memcpy
;	main.c: 144: d_addr = convert_chars_to_int(a);
	ldw	x, #(_a+0)
	call	_convert_chars_to_int
	ld	a, xl
	ld	_d_addr+0, a
;	main.c: 145: }
	addw	sp, #2
	ret
;	main.c: 147: void get_size_from_buff(void)
;	-----------------------------------------
;	 function get_size_from_buff
;	-----------------------------------------
_get_size_from_buff:
	push	a
;	main.c: 150: uint8_t i = p_size;
	ld	a, _p_size+0
	ld	(0x01, sp), a
;	main.c: 151: while(1)
	clrw	y
00105$:
;	main.c: 153: if(buffer[i] == 32 || buffer[i] == 10)
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	ld	a, (_buffer+0, x)
	cp	a, #0x20
	jreq	00101$
	cp	a, #0x0a
	jrne	00102$
00101$:
;	main.c: 155: p_bytes = i+1;
	ld	a, (0x01, sp)
	inc	a
	ld	_p_bytes+0, a
;	main.c: 156: break;
	jra	00106$
00102$:
;	main.c: 158: i++;
	inc	(0x01, sp)
;	main.c: 159: counter++;
	incw	y
	jra	00105$
00106$:
;	main.c: 161: memcpy(a, &buffer[p_size], counter);
	clr	a
	ld	yh, a
	clrw	x
	ld	a, _p_size+0
	ld	xl, a
	addw	x, #(_buffer+0)
	pushw	y
	pushw	x
	ldw	x, #(_a+0)
	call	___memcpy
;	main.c: 162: d_size = convert_chars_to_int(a);
	ldw	x, #(_a+0)
	call	_convert_chars_to_int
	ld	a, xl
	ld	_d_size+0, a
;	main.c: 163: }
	pop	a
	ret
;	main.c: 164: void char_buffer_to_int(void)
;	-----------------------------------------
;	 function char_buffer_to_int
;	-----------------------------------------
_char_buffer_to_int:
	sub	sp, #10
;	main.c: 166: uint8_t counter = d_size;
	ld	a, _d_size+0
	ld	(0x07, sp), a
;	main.c: 167: uint8_t i = p_bytes;
	ld	a, _p_bytes+0
	ld	(0x08, sp), a
;	main.c: 169: while(counter > 0)
	clr	(0x09, sp)
00111$:
	tnz	(0x07, sp)
	jreq	00114$
;	main.c: 171: if(buffer[i] == 32)
	clrw	x
	ld	a, (0x08, sp)
	ld	xl, a
	addw	x, #(_buffer+0)
	ldw	(0x05, sp), x
	ld	a, (x)
	cp	a, #0x20
	jrne	00109$
;	main.c: 174: while(1)
	clr	(0x0a, sp)
00104$:
;	main.c: 176: if(buffer[i+1] == 32)
	ld	a, (0x08, sp)
	clrw	x
	ld	xl, a
	incw	x
	ld	a, (_buffer+0, x)
	cp	a, #0x20
	jreq	00105$
;	main.c: 178: buf_counter++;
	inc	(0x0a, sp)
	jra	00104$
00105$:
;	main.c: 180: char ar[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 181: memcpy(a, &buffer[i], buf_counter);
	clrw	x
	ld	a, (0x0a, sp)
	ld	xl, a
	ldw	y, (0x05, sp)
	pushw	x
	pushw	y
	ldw	x, #(_a+0)
	call	___memcpy
;	main.c: 182: data_buf[buf_i] = convert_chars_to_int(a);
	clrw	x
	ld	a, (0x09, sp)
	ld	xl, a
	addw	x, #(_data_buf+0)
	ldw	(0x05, sp), x
	ldw	x, #(_a+0)
	call	_convert_chars_to_int
	ld	a, xl
	ldw	x, (0x05, sp)
	ld	(x), a
;	main.c: 183: counter--;
	dec	(0x07, sp)
;	main.c: 184: buf_i++;
	inc	(0x09, sp)
;	main.c: 185: convert_int_to_chars(data_buf[buf_i], ar);
	clrw	x
	ld	a, (0x09, sp)
	ld	xl, a
	ld	a, (_data_buf+0, x)
	ldw	x, sp
	incw	x
	call	_convert_int_to_chars
;	main.c: 186: uart_write(ar);
	ldw	x, sp
	incw	x
	call	_uart_write
	jra	00110$
00109$:
;	main.c: 188: else if(buffer[i] == 10)
	cp	a, #0x0a
	jreq	00114$
;	main.c: 190: break;
00110$:
;	main.c: 192: i++;
	inc	(0x08, sp)
;	main.c: 193: uart_write("while");
	ldw	x, #(___str_0+0)
	call	_uart_write
	jra	00111$
00114$:
;	main.c: 196: }
	addw	sp, #10
	ret
;	main.c: 204: void status_check(void){
;	-----------------------------------------
;	 function status_check
;	-----------------------------------------
_status_check:
	sub	sp, #9
;	main.c: 205: char rx_binary_chars[9]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
;	main.c: 206: uart_write("\nI2C_REGS >.<\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 207: convert_int_to_binary(I2C_SR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5217
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 208: uart_write("\nSR1 -> ");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 209: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 210: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 211: convert_int_to_binary(I2C_SR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5218
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 212: uart_write("SR2 -> ");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	main.c: 213: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 214: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 215: convert_int_to_binary(I2C_SR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5219
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 216: uart_write("SR3 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	main.c: 217: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 218: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 219: convert_int_to_binary(I2C_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5210
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 220: uart_write("CR1 -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 221: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 222: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 223: convert_int_to_binary(I2C_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5211
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 224: uart_write("CR2 -> ");
	ldw	x, #(___str_7+0)
	call	_uart_write
;	main.c: 225: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 226: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 227: convert_int_to_binary(I2C_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5216
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 228: uart_write("DR -> ");
	ldw	x, #(___str_8+0)
	call	_uart_write
;	main.c: 229: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 230: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 231: uart_write("UART_REGS >.<\n");
	ldw	x, #(___str_9+0)
	call	_uart_write
;	main.c: 232: convert_int_to_binary(UART1_SR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5230
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 233: uart_write("\nSR -> ");
	ldw	x, #(___str_10+0)
	call	_uart_write
;	main.c: 234: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 235: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 236: convert_int_to_binary(UART1_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5231
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 237: uart_write("DR -> ");
	ldw	x, #(___str_8+0)
	call	_uart_write
;	main.c: 238: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 239: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 240: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5232
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 241: uart_write("BRR1 -> ");
	ldw	x, #(___str_11+0)
	call	_uart_write
;	main.c: 242: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 243: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 244: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5233
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 245: uart_write("BRR2 -> ");
	ldw	x, #(___str_12+0)
	call	_uart_write
;	main.c: 246: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 247: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 248: convert_int_to_binary(UART1_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5234
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 249: uart_write("CR1 -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 250: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 251: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 252: convert_int_to_binary(UART1_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5235
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 253: uart_write("CR2 -> ");
	ldw	x, #(___str_7+0)
	call	_uart_write
;	main.c: 254: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 255: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 256: convert_int_to_binary(UART1_CR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5236
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 257: uart_write("CR3 -> ");
	ldw	x, #(___str_13+0)
	call	_uart_write
;	main.c: 258: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 259: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 260: convert_int_to_binary(UART1_CR4, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5237
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 261: uart_write("CR4 -> ");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 262: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 263: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 264: convert_int_to_binary(UART1_CR5, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5238
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 265: uart_write("CR5 -> ");
	ldw	x, #(___str_15+0)
	call	_uart_write
;	main.c: 266: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 267: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 268: convert_int_to_binary(UART1_GTR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5239
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 269: uart_write("GTR -> ");
	ldw	x, #(___str_16+0)
	call	_uart_write
;	main.c: 270: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 271: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 272: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x523a
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 273: uart_write("PSCR -> ");
	ldw	x, #(___str_17+0)
	call	_uart_write
;	main.c: 274: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 275: uart_write(" <-\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 276: }
	addw	sp, #9
	ret
;	main.c: 278: void uart_init(void){
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	main.c: 279: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 282: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 283: UART1_CR2 |= UART_CR2_REN; // Receiver enable
	bset	0x5235, #2
;	main.c: 284: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 286: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 287: }
	ret
;	main.c: 291: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	main.c: 297: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
	bres	0x5210, #0
;	main.c: 298: I2C_FREQR= 16;                  // peripheral frequence =16MHz
	mov	0x5212+0, #0x10
;	main.c: 299: I2C_CCRH = 0;                   // =0
	mov	0x521c+0, #0x00
;	main.c: 300: I2C_CCRL = 80;                  // 100kHz for I2C
	mov	0x521b+0, #0x50
;	main.c: 301: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
	bres	0x521c, #7
;	main.c: 302: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
	bres	0x5214, #7
;	main.c: 303: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
	bset	0x5214, #6
;	main.c: 304: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
	bset	0x5210, #0
;	main.c: 305: }
	ret
;	main.c: 314: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	main.c: 315: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
	bset	0x5211, #0
;	main.c: 316: while(!(I2C_SR1 & (1 << 0)));
00101$:
	btjf	0x5217, #0, 00101$
;	main.c: 318: }
	ret
;	main.c: 320: void i2c_send_address(uint8_t address) {
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	main.c: 321: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
	sll	a
	ld	0x5216, a
;	main.c: 322: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
00102$:
	btjf	0x5217, #1, 00117$
	ret
00117$:
	btjf	0x5218, #2, 00102$
;	main.c: 323: }
	ret
;	main.c: 325: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	main.c: 326: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
	bset	0x5211, #1
;	main.c: 328: }
	ret
;	main.c: 329: void i2c_write(void){
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #4
;	main.c: 330: I2C_DR = d_addr; // Отправка адреса устройства с битом на запись
	mov	0x5216+0, _d_addr+0
;	main.c: 331: uart_write("flag1\r");
	ldw	x, #(___str_18+0)
	call	_uart_write
;	main.c: 332: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
00102$:
	btjt	0x5217, #1, 00104$
	btjt	0x5218, #2, 00104$
;	main.c: 333: uart_write(".");
	ldw	x, #(___str_19+0)
	call	_uart_write
	jra	00102$
00104$:
;	main.c: 334: uart_write("flag2\r");
	ldw	x, #(___str_20+0)
	call	_uart_write
;	main.c: 335: for(int i = 0;i < d_size;i++)
	clrw	x
	ldw	(0x03, sp), x
00111$:
	ld	a, _d_size+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00113$
;	main.c: 337: uart_write("flag3\r");
	ldw	x, #(___str_21+0)
	call	_uart_write
;	main.c: 338: I2C_DR = data_buf[i];
	ldw	x, (0x03, sp)
	ld	a, (_data_buf+0, x)
	ld	0x5216, a
;	main.c: 339: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
00106$:
	btjt	0x5217, #1, 00108$
	btjt	0x5218, #2, 00108$
;	main.c: 340: uart_write(".");
	ldw	x, #(___str_19+0)
	call	_uart_write
	jra	00106$
00108$:
;	main.c: 341: uart_write("flag4\r");
	ldw	x, #(___str_22+0)
	call	_uart_write
;	main.c: 335: for(int i = 0;i < d_size;i++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00111$
00113$:
;	main.c: 343: }
	addw	sp, #4
	ret
;	main.c: 345: void i2c_read(void){
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #4
;	main.c: 346: I2C_DR = (current_dev << 1) & (1 << 0);
	ld	a, _current_dev+0
	sll	a
	and	a, #0x01
	ld	0x5216, a
;	main.c: 347: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
00102$:
	btjt	0x5217, #1, 00104$
	btjt	0x5218, #2, 00104$
;	main.c: 348: uart_write(".");
	ldw	x, #(___str_19+0)
	call	_uart_write
	jra	00102$
00104$:
;	main.c: 349: uart_write("\r\n");
	ldw	x, #(___str_23+0)
	call	_uart_write
;	main.c: 350: I2C_DR = d_addr;
	mov	0x5216+0, _d_addr+0
;	main.c: 351: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
00106$:
	btjt	0x5217, #1, 00108$
	btjt	0x5218, #2, 00108$
;	main.c: 352: uart_write(".");
	ldw	x, #(___str_19+0)
	call	_uart_write
	jra	00106$
00108$:
;	main.c: 353: uart_write("\r\n");
	ldw	x, #(___str_23+0)
	call	_uart_write
;	main.c: 354: i2c_stop();
	call	_i2c_stop
;	main.c: 355: for(int i = 0;i < d_size;i++)
	clrw	x
	ldw	(0x03, sp), x
00115$:
	ld	a, _d_size+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00117$
;	main.c: 357: data_buf[i] = I2C_DR;
	ldw	x, (0x03, sp)
	ld	a, 0x5216
	ld	((_data_buf+0), x), a
;	main.c: 358: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
00110$:
	btjt	0x5217, #1, 00112$
	btjt	0x5218, #2, 00112$
;	main.c: 359: uart_write(".");
	ldw	x, #(___str_19+0)
	call	_uart_write
	jra	00110$
00112$:
;	main.c: 360: uart_write("\r\n");
	ldw	x, #(___str_23+0)
	call	_uart_write
;	main.c: 355: for(int i = 0;i < d_size;i++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00115$
00117$:
;	main.c: 363: }
	addw	sp, #4
	ret
;	main.c: 364: void i2c_scan(void) {
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	main.c: 365: for (uint8_t addr = current_dev; addr < 127; addr++) {
	ld	a, _current_dev+0
	ld	(0x01, sp), a
	ld	(0x02, sp), a
00105$:
	ld	a, (0x02, sp)
	cp	a, #0x7f
	jrnc	00107$
;	main.c: 366: i2c_start();
	call	_i2c_start
;	main.c: 367: i2c_send_address(addr);
	ld	a, (0x02, sp)
	call	_i2c_send_address
;	main.c: 368: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
	btjt	0x5218, #2, 00102$
;	main.c: 370: current_dev = addr;
	ld	a, (0x01, sp)
	ld	_current_dev+0, a
;	main.c: 371: i2c_stop();
	addw	sp, #2
;	main.c: 372: break;
	jp	_i2c_stop
00102$:
;	main.c: 374: i2c_stop();
	call	_i2c_stop
;	main.c: 375: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
	bres	0x5218, #2
;	main.c: 365: for (uint8_t addr = current_dev; addr < 127; addr++) {
	inc	(0x02, sp)
	ld	a, (0x02, sp)
	ld	(0x01, sp), a
	jra	00105$
00107$:
;	main.c: 377: }
	addw	sp, #2
	ret
;	main.c: 387: void cm_SM(void)
;	-----------------------------------------
;	 function cm_SM
;	-----------------------------------------
_cm_SM:
	sub	sp, #4
;	main.c: 389: char cur_dev[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 390: convert_int_to_chars(current_dev, cur_dev);
	ldw	x, sp
	incw	x
	ld	a, _current_dev+0
	call	_convert_int_to_chars
;	main.c: 391: uart_write("SM ");
	ldw	x, #(___str_24+0)
	call	_uart_write
;	main.c: 392: uart_write(cur_dev);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 393: uart_write("\r\n");
	ldw	x, #(___str_23+0)
	call	_uart_write
;	main.c: 394: }
	addw	sp, #4
	ret
;	main.c: 395: void cm_SN(void)
;	-----------------------------------------
;	 function cm_SN
;	-----------------------------------------
_cm_SN:
;	main.c: 397: i2c_scan();
	call	_i2c_scan
;	main.c: 398: cm_SM();
;	main.c: 399: }
	jp	_cm_SM
;	main.c: 400: void cm_RM(void)
;	-----------------------------------------
;	 function cm_RM
;	-----------------------------------------
_cm_RM:
;	main.c: 402: current_dev = 0;
	clr	_current_dev+0
;	main.c: 403: uart_write("RM\n");
	ldw	x, #(___str_25+0)
;	main.c: 404: }
	jp	_uart_write
;	main.c: 406: void cm_DB(void)
;	-----------------------------------------
;	 function cm_DB
;	-----------------------------------------
_cm_DB:
;	main.c: 408: status_check();
;	main.c: 409: }
	jp	_status_check
;	main.c: 411: void cm_ST(void)
;	-----------------------------------------
;	 function cm_ST
;	-----------------------------------------
_cm_ST:
;	main.c: 413: get_addr_from_buff();
	call	_get_addr_from_buff
;	main.c: 414: current_dev = d_addr;
	mov	_current_dev+0, _d_addr+0
;	main.c: 415: uart_write("ST\n");
	ldw	x, #(___str_26+0)
;	main.c: 416: }
	jp	_uart_write
;	main.c: 417: void cm_SR(void)
;	-----------------------------------------
;	 function cm_SR
;	-----------------------------------------
_cm_SR:
;	main.c: 419: i2c_start();
	call	_i2c_start
;	main.c: 420: i2c_send_address(current_dev);
	ld	a, _current_dev+0
	call	_i2c_send_address
;	main.c: 421: i2c_read();
	call	_i2c_read
;	main.c: 422: i2c_stop();
;	main.c: 423: }
	jp	_i2c_stop
;	main.c: 424: void cm_SW(void)
;	-----------------------------------------
;	 function cm_SW
;	-----------------------------------------
_cm_SW:
	sub	sp, #4
;	main.c: 426: char ar[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 427: uart_write("f1");
	ldw	x, #(___str_27+0)
	call	_uart_write
;	main.c: 428: i2c_start();
	call	_i2c_start
;	main.c: 429: uart_write("f2");
	ldw	x, #(___str_28+0)
	call	_uart_write
;	main.c: 430: i2c_send_address(current_dev);
	ld	a, _current_dev+0
	call	_i2c_send_address
;	main.c: 431: uart_write("f3");
	ldw	x, #(___str_29+0)
	call	_uart_write
;	main.c: 432: i2c_write();
	call	_i2c_write
;	main.c: 433: uart_write("f4");
	ldw	x, #(___str_30+0)
	call	_uart_write
;	main.c: 434: i2c_stop();
	call	_i2c_stop
;	main.c: 435: uart_write("f5");
	ldw	x, #(___str_31+0)
	call	_uart_write
;	main.c: 436: uart_write("SW ");
	ldw	x, #(___str_32+0)
	call	_uart_write
;	main.c: 437: convert_int_to_chars(d_addr, ar);
	ldw	x, sp
	incw	x
	ld	a, _d_addr+0
	call	_convert_int_to_chars
;	main.c: 438: uart_write(ar);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 439: uart_write(" ");
	ldw	x, #(___str_33+0)
	call	_uart_write
;	main.c: 440: convert_int_to_chars(d_size, ar);
	ldw	x, sp
	incw	x
	ld	a, _d_size+0
	call	_convert_int_to_chars
;	main.c: 441: uart_write(ar);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 442: uart_write("\r\n");
	ldw	x, #(___str_23+0)
	call	_uart_write
;	main.c: 443: }
	addw	sp, #4
	ret
;	main.c: 451: int data_handler(void)
;	-----------------------------------------
;	 function data_handler
;	-----------------------------------------
_data_handler:
;	main.c: 453: p_size = 0;
	clr	_p_size+0
;	main.c: 454: p_bytes = 0;
	clr	_p_bytes+0
;	main.c: 455: d_addr = 0;
	clr	_d_addr+0
;	main.c: 456: d_size = 0;
	clr	_d_size+0
;	main.c: 457: memset(data_buf, 0, sizeof(data_buf));
	push	#0x00
	push	#0x01
	clrw	x
	pushw	x
	ldw	x, #(_data_buf+0)
	call	_memset
;	main.c: 458: if(memcmp(&buffer[0],"SM",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_34+0)
	push	#((___str_34+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
;	main.c: 459: return 1;
	tnzw	x
	jrne	00102$
	incw	x
	ret
00102$:
;	main.c: 460: if(memcmp(&buffer[0],"SN",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_35+0)
	push	#((___str_35+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00104$
;	main.c: 461: return 2;
	ldw	x, #0x0002
	ret
00104$:
;	main.c: 462: if(memcmp(&buffer[0],"ST",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_36+0)
	push	#((___str_36+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00106$
;	main.c: 463: return 5;
	ldw	x, #0x0005
	ret
00106$:
;	main.c: 464: if(memcmp(&buffer[0],"RM",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_37+0)
	push	#((___str_37+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00108$
;	main.c: 465: return 6;
	ldw	x, #0x0006
	ret
00108$:
;	main.c: 466: if(memcmp(&buffer[0],"DB",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_38+0)
	push	#((___str_38+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00110$
;	main.c: 467: return 7;
	ldw	x, #0x0007
	ret
00110$:
;	main.c: 469: get_addr_from_buff();
	call	_get_addr_from_buff
;	main.c: 470: get_size_from_buff();
	call	_get_size_from_buff
;	main.c: 472: if(memcmp(&buffer[0],"SR",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_39+0)
	push	#((___str_39+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00112$
;	main.c: 473: return 3;
	ldw	x, #0x0003
	ret
00112$:
;	main.c: 475: char_buffer_to_int();
	call	_char_buffer_to_int
;	main.c: 477: if(memcmp(&buffer[0],"SW",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_40+0)
	push	#((___str_40+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00114$
;	main.c: 478: return 4;
	ldw	x, #0x0004
	ret
00114$:
;	main.c: 479: return 0;
	clrw	x
;	main.c: 481: }
	ret
;	main.c: 483: void command_switcher(void)
;	-----------------------------------------
;	 function command_switcher
;	-----------------------------------------
_command_switcher:
	sub	sp, #6
;	main.c: 485: char ar[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 487: int af = data_handler();
	call	_data_handler
	ldw	(0x05, sp), x
;	main.c: 488: convert_int_to_chars(af, ar);
	ldw	x, sp
	incw	x
	ld	a, (0x06, sp)
	call	_convert_int_to_chars
;	main.c: 489: uart_write("preswitch\n");
	ldw	x, #(___str_41+0)
	call	_uart_write
;	main.c: 490: uart_write(ar);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 491: uart_write("\n");
	ldw	x, #(___str_42+0)
	call	_uart_write
;	main.c: 492: switch(af)
	tnz	(0x05, sp)
	jrmi	00109$
	ldw	x, (0x05, sp)
	cpw	x, #0x0007
	jrsgt	00109$
	ldw	x, (0x05, sp)
	sllw	x
	ldw	x, (#00123$, x)
	jp	(x)
00123$:
	.dw	#00109$
	.dw	#00101$
	.dw	#00102$
	.dw	#00103$
	.dw	#00104$
	.dw	#00105$
	.dw	#00106$
	.dw	#00107$
;	main.c: 494: case 1:
00101$:
;	main.c: 495: cm_SM();
	call	_cm_SM
;	main.c: 496: break;
	jra	00109$
;	main.c: 497: case 2:
00102$:
;	main.c: 498: cm_SN();
	call	_cm_SN
;	main.c: 499: break;
	jra	00109$
;	main.c: 500: case 3:
00103$:
;	main.c: 501: cm_SR();
	call	_cm_SR
;	main.c: 502: break;
	jra	00109$
;	main.c: 503: case 4:
00104$:
;	main.c: 504: uart_write("switch\n");
	ldw	x, #(___str_43+0)
	call	_uart_write
;	main.c: 505: cm_SW();
	call	_cm_SW
;	main.c: 506: break;
	jra	00109$
;	main.c: 507: case 5:
00105$:
;	main.c: 508: cm_ST();
	call	_cm_ST
;	main.c: 509: break;
	jra	00109$
;	main.c: 510: case 6:
00106$:
;	main.c: 511: cm_RM();
	call	_cm_RM
;	main.c: 512: break;
	jra	00109$
;	main.c: 513: case 7:
00107$:
;	main.c: 514: cm_DB();
	call	_cm_DB
;	main.c: 516: }
00109$:
;	main.c: 517: }
	addw	sp, #6
	ret
;	main.c: 520: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 522: uart_init();
	call	_uart_init
;	main.c: 523: i2c_init();
	call	_i2c_init
;	main.c: 524: uart_write("SS\n");
	ldw	x, #(___str_44+0)
	call	_uart_write
;	main.c: 525: while(1)
00102$:
;	main.c: 527: uart_read();
	call	_uart_read
;	main.c: 528: command_switcher();
	call	_command_switcher
	jra	00102$
;	main.c: 530: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "while"
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.db 0x0a
	.ascii "I2C_REGS >.<"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.db 0x0a
	.ascii "SR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii " <-"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "SR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "SR3 -> "
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
	.ascii "DR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_9:
	.ascii "UART_REGS >.<"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.db 0x0a
	.ascii "SR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_11:
	.ascii "BRR1 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_12:
	.ascii "BRR2 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_13:
	.ascii "CR3 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_14:
	.ascii "CR4 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_15:
	.ascii "CR5 -> "
	.db 0x00
	.area CODE
	.area CONST
___str_16:
	.ascii "GTR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_17:
	.ascii "PSCR -> "
	.db 0x00
	.area CODE
	.area CONST
___str_18:
	.ascii "flag1"
	.db 0x0d
	.db 0x00
	.area CODE
	.area CONST
___str_19:
	.ascii "."
	.db 0x00
	.area CODE
	.area CONST
___str_20:
	.ascii "flag2"
	.db 0x0d
	.db 0x00
	.area CODE
	.area CONST
___str_21:
	.ascii "flag3"
	.db 0x0d
	.db 0x00
	.area CODE
	.area CONST
___str_22:
	.ascii "flag4"
	.db 0x0d
	.db 0x00
	.area CODE
	.area CONST
___str_23:
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_24:
	.ascii "SM "
	.db 0x00
	.area CODE
	.area CONST
___str_25:
	.ascii "RM"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_26:
	.ascii "ST"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_27:
	.ascii "f1"
	.db 0x00
	.area CODE
	.area CONST
___str_28:
	.ascii "f2"
	.db 0x00
	.area CODE
	.area CONST
___str_29:
	.ascii "f3"
	.db 0x00
	.area CODE
	.area CONST
___str_30:
	.ascii "f4"
	.db 0x00
	.area CODE
	.area CONST
___str_31:
	.ascii "f5"
	.db 0x00
	.area CODE
	.area CONST
___str_32:
	.ascii "SW "
	.db 0x00
	.area CODE
	.area CONST
___str_33:
	.ascii " "
	.db 0x00
	.area CODE
	.area CONST
___str_34:
	.ascii "SM"
	.db 0x00
	.area CODE
	.area CONST
___str_35:
	.ascii "SN"
	.db 0x00
	.area CODE
	.area CONST
___str_36:
	.ascii "ST"
	.db 0x00
	.area CODE
	.area CONST
___str_37:
	.ascii "RM"
	.db 0x00
	.area CODE
	.area CONST
___str_38:
	.ascii "DB"
	.db 0x00
	.area CODE
	.area CONST
___str_39:
	.ascii "SR"
	.db 0x00
	.area CODE
	.area CONST
___str_40:
	.ascii "SW"
	.db 0x00
	.area CODE
	.area CONST
___str_41:
	.ascii "preswitch"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_42:
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_43:
	.ascii "switch"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_44:
	.ascii "SS"
	.db 0x0a
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
__xinit__a:
	.db #0x00	; 0
	.db 0x00
	.db 0x00
__xinit__d_addr:
	.db #0x00	; 0
__xinit__p_size:
	.db #0x00	; 0
__xinit__d_size:
	.db #0x00	; 0
__xinit__p_bytes:
	.db #0x00	; 0
__xinit__data_buf:
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
