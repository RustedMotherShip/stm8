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
	.globl _reg_check
	.globl _char_buffer_to_int
	.globl _get_size_from_buff
	.globl _get_addr_from_buff
	.globl _convert_int_to_binary
	.globl _convert_chars_to_int
	.globl _convert_int_to_chars
	.globl _uart_read
	.globl _UART_RX
	.globl _uart_write
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
	.globl _status_registers
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_status_registers::
	.ds 256
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
;	main.c: 27: void delay(unsigned long count) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #8
;	main.c: 28: while (count--)
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
;	main.c: 29: nop();
	nop
	jra	00101$
00104$:
;	main.c: 30: }
	ldw	x, (9, sp)
	addw	sp, #14
	jp	(x)
;	main.c: 38: void UART_TX(unsigned char value)
;	-----------------------------------------
;	 function UART_TX
;	-----------------------------------------
_UART_TX:
;	main.c: 40: UART1_DR = value;
	ld	0x5231, a
;	main.c: 41: while(!(UART1_SR & UART_SR_TXE));
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 42: }
	ret
;	main.c: 44: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #5
	ldw	(0x03, sp), x
;	main.c: 46: for(i = 0; i < strlen(str); i++) {
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
;	main.c: 48: UART_TX(str[i]);
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x03, sp)
	ld	a, (x)
	call	_UART_TX
;	main.c: 46: for(i = 0; i < strlen(str); i++) {
	inc	(0x05, sp)
	jra	00103$
00101$:
;	main.c: 51: return(i); // Bytes sent
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
;	main.c: 52: }
	addw	sp, #5
	ret
;	main.c: 53: unsigned char UART_RX(void)
;	-----------------------------------------
;	 function UART_RX
;	-----------------------------------------
_UART_RX:
;	main.c: 56: while(!(UART1_SR & UART_SR_TXE));
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	main.c: 58: return UART1_DR;
	ld	a, 0x5231
;	main.c: 59: }
	ret
;	main.c: 60: int uart_read(void)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
;	main.c: 63: memset(buffer, 0, sizeof(buffer));
	push	#0x00
	push	#0x01
	clrw	x
	pushw	x
	ldw	x, #(_buffer+0)
	call	_memset
;	main.c: 66: while(i<256)
	clrw	x
00105$:
	cpw	x, #0x0100
	jrsge	00107$
;	main.c: 69: if(UART1_SR & UART_SR_RXNE)
	ld	a, 0x5230
	bcp	a, #0x20
	jreq	00105$
;	main.c: 72: buffer[i] = UART_RX();
	ldw	y, x
	addw	y, #(_buffer+0)
	pushw	x
	pushw	y
	call	_UART_RX
	popw	y
	popw	x
	ld	(y), a
;	main.c: 73: if(buffer[i] == '\r\n' )
	cp	a, #0x0d
	jrne	00102$
;	main.c: 75: return 1;
	clrw	x
	incw	x
	ret
;	main.c: 76: break;
00102$:
;	main.c: 78: i++;
	incw	x
	jra	00105$
00107$:
;	main.c: 82: return 0;
	clrw	x
;	main.c: 83: }
	ret
;	main.c: 92: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
;	-----------------------------------------
;	 function convert_int_to_chars
;	-----------------------------------------
_convert_int_to_chars:
	sub	sp, #13
	ld	(0x0d, sp), a
	ldw	(0x0b, sp), x
;	main.c: 95: rx_int_chars[0] = num / 100 + '0';
	ld	a, (0x0d, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	ldw	(0x03, sp), x
;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x05, sp), x
;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
	call	__divsint
	ldw	(0x07, sp), x
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ld	(0x09, sp), a
;	main.c: 93: if (num > 99) {
	ld	a, (0x0d, sp)
	cp	a, #0x63
	jrule	00105$
;	main.c: 95: rx_int_chars[0] = num / 100 + '0';
	push	#0x64
	push	#0x00
	ldw	x, (0x03, sp)
	call	__divsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
	push	#0x0a
	push	#0x00
	ldw	x, (0x09, sp)
	call	__modsint
	ld	a, xl
	add	a, #0x30
	ldw	x, (0x03, sp)
	ld	(x), a
;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
	ldw	x, (0x05, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 98: rx_int_chars[3] ='\0';
	ldw	x, (0x0b, sp)
	clr	(0x0003, x)
	jra	00107$
00105$:
;	main.c: 100: } else if (num > 9) {
	ld	a, (0x0d, sp)
	cp	a, #0x09
	jrule	00102$
;	main.c: 102: rx_int_chars[0] = num / 10 + '0';
	ld	a, (0x08, sp)
	ld	(0x0a, sp), a
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 103: rx_int_chars[1] = num % 10 + '0';
	ldw	x, (0x03, sp)
	ld	a, (0x09, sp)
	ld	(x), a
;	main.c: 104: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
	ldw	x, (0x05, sp)
	clr	(x)
	jra	00107$
00102$:
;	main.c: 107: rx_int_chars[0] = num + '0';
	ld	a, (0x0d, sp)
	add	a, #0x30
	ldw	x, (0x0b, sp)
	ld	(x), a
;	main.c: 108: rx_int_chars[1] ='\0';
	ldw	x, (0x03, sp)
	clr	(x)
00107$:
;	main.c: 110: }
	addw	sp, #13
	ret
;	main.c: 112: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
;	-----------------------------------------
;	 function convert_chars_to_int
;	-----------------------------------------
_convert_chars_to_int:
	sub	sp, #3
	ldw	(0x02, sp), x
;	main.c: 113: uint8_t result = 0;
	clr	a
;	main.c: 115: for (int o = 0; o < i; o++) {
	clrw	x
00103$:
	cpw	x, (0x06, sp)
	jrsge	00101$
;	main.c: 117: result = (result * 10) + (rx_chars_int[o] - '0');
	ld	yl, a
	ld	a, #0x0a
	mul	y, a
	exg	a, yl
	ld	(0x01, sp), a
	exg	a, yl
	ldw	y, x
	addw	y, (0x02, sp)
	ld	a, (y)
	sub	a, #0x30
	add	a, (0x01, sp)
;	main.c: 115: for (int o = 0; o < i; o++) {
	incw	x
	jra	00103$
00101$:
;	main.c: 120: return result;
;	main.c: 121: }
	ldw	x, (4, sp)
	addw	sp, #7
	jp	(x)
;	main.c: 124: void convert_int_to_binary(int num, char* rx_binary_chars) {
;	-----------------------------------------
;	 function convert_int_to_binary
;	-----------------------------------------
_convert_int_to_binary:
	sub	sp, #4
	ldw	(0x01, sp), x
;	main.c: 126: for(int i = 7; i >= 0; i--) {
	ldw	x, #0x0007
	ldw	(0x03, sp), x
00103$:
	tnz	(0x03, sp)
	jrmi	00101$
;	main.c: 128: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
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
;	main.c: 126: for(int i = 7; i >= 0; i--) {
	ldw	x, (0x03, sp)
	decw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 130: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
	ldw	x, (0x07, sp)
	clr	(0x0008, x)
;	main.c: 131: }
	ldw	x, (5, sp)
	addw	sp, #8
	jp	(x)
;	main.c: 140: void get_addr_from_buff(void)
;	-----------------------------------------
;	 function get_addr_from_buff
;	-----------------------------------------
_get_addr_from_buff:
	sub	sp, #2
;	main.c: 144: while(1)
	ld	a, #0x03
	ld	(0x01, sp), a
	clr	(0x02, sp)
00105$:
;	main.c: 146: if(buffer[i] == ' ' || buffer[i] == '\r\n')
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	ld	a, (_buffer+0, x)
	cp	a, #0x20
	jreq	00101$
	cp	a, #0x0d
	jrne	00102$
00101$:
;	main.c: 148: p_size = i+1;
	ld	a, (0x01, sp)
	inc	a
	ld	_p_size+0, a
;	main.c: 149: break;
	jra	00106$
00102$:
;	main.c: 151: i++;
	inc	(0x01, sp)
;	main.c: 152: counter++;
	inc	(0x02, sp)
	jra	00105$
00106$:
;	main.c: 154: memcpy(a, &buffer[3], counter);
	clrw	x
	ld	a, (0x02, sp)
	ld	xl, a
	pushw	x
	push	#<(_buffer+3)
	push	#((_buffer+3) >> 8)
	ldw	x, #(_a+0)
	call	___memcpy
;	main.c: 155: d_addr = convert_chars_to_int(a, counter);
	clrw	x
	ld	a, (0x02, sp)
	ld	xl, a
	pushw	x
	ldw	x, #(_a+0)
	call	_convert_chars_to_int
	ld	_d_addr+0, a
;	main.c: 156: }
	addw	sp, #2
	ret
;	main.c: 158: void get_size_from_buff(void)
;	-----------------------------------------
;	 function get_size_from_buff
;	-----------------------------------------
_get_size_from_buff:
	sub	sp, #2
;	main.c: 160: memset(a, 0, sizeof(a));
	push	#0x03
	push	#0x00
	clrw	x
	pushw	x
	ldw	x, #(_a+0)
	call	_memset
;	main.c: 162: uint8_t i = p_size;
	ld	a, _p_size+0
	ld	(0x01, sp), a
;	main.c: 163: while(1)
	clr	(0x02, sp)
00105$:
;	main.c: 165: if(buffer[i] == ' ' || buffer[i] == '\r\n')
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	ld	a, (_buffer+0, x)
	cp	a, #0x20
	jreq	00101$
	cp	a, #0x0d
	jrne	00102$
00101$:
;	main.c: 168: p_bytes = i+1;
	ld	a, (0x01, sp)
	inc	a
	ld	_p_bytes+0, a
;	main.c: 169: break;
	jra	00106$
00102$:
;	main.c: 171: i++;
	inc	(0x01, sp)
;	main.c: 172: counter++;
	inc	(0x02, sp)
	jra	00105$
00106$:
;	main.c: 175: memcpy(a, &buffer[p_size], counter);
	clrw	y
	ld	a, (0x02, sp)
	ld	yl, a
	clrw	x
	ld	a, _p_size+0
	ld	xl, a
	addw	x, #(_buffer+0)
	pushw	y
	pushw	x
	ldw	x, #(_a+0)
	call	___memcpy
;	main.c: 176: d_size = convert_chars_to_int(a, counter);
	clrw	x
	ld	a, (0x02, sp)
	ld	xl, a
	pushw	x
	ldw	x, #(_a+0)
	call	_convert_chars_to_int
	ld	_d_size+0, a
;	main.c: 177: }
	addw	sp, #2
	ret
;	main.c: 178: void char_buffer_to_int(void)
;	-----------------------------------------
;	 function char_buffer_to_int
;	-----------------------------------------
_char_buffer_to_int:
	sub	sp, #8
;	main.c: 180: memset(a, 0, sizeof(a));
	push	#0x03
	push	#0x00
	clrw	x
	pushw	x
	ldw	x, #(_a+0)
	call	_memset
;	main.c: 181: uint8_t counter = d_size;
	ld	a, _d_size+0
	ld	(0x01, sp), a
;	main.c: 182: uint8_t i = p_bytes;
	ld	a, _p_bytes+0
	ld	(0x03, sp), a
;	main.c: 185: for(int o = 0; o < counter;o++)
	clr	(0x04, sp)
	clrw	x
	ldw	(0x05, sp), x
00112$:
	ld	a, (0x01, sp)
	ld	(0x08, sp), a
	clr	(0x07, sp)
	ldw	x, (0x05, sp)
	cpw	x, (0x07, sp)
	jrsge	00114$
;	main.c: 187: uint8_t number_counter = 0;
	clr	(0x02, sp)
;	main.c: 188: while(1)
	ld	a, (0x03, sp)
	ld	(0x07, sp), a
	clr	(0x08, sp)
00108$:
;	main.c: 190: if(buffer[i] == ' ')
	clrw	x
	ld	a, (0x07, sp)
	ld	xl, a
	ld	a, (_buffer+0, x)
	cp	a, #0x20
	jrne	00105$
;	main.c: 192: i++;
	inc	(0x03, sp)
;	main.c: 193: break;
	jra	00109$
00105$:
;	main.c: 195: else if(buffer[i] == '\r\n')
	cp	a, #0x0d
	jreq	00109$
;	main.c: 198: i++;
	inc	(0x07, sp)
	ld	a, (0x07, sp)
	ld	(0x03, sp), a
;	main.c: 200: number_counter++;
	inc	(0x08, sp)
	ld	a, (0x08, sp)
	ld	(0x02, sp), a
	jra	00108$
00109$:
;	main.c: 202: memcpy(a, &buffer[i - number_counter], number_counter);
	clrw	y
	ld	a, (0x02, sp)
	ld	yl, a
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	ld	a, (0x02, sp)
	ld	(0x08, sp), a
	clr	(0x07, sp)
	subw	x, (0x07, sp)
	addw	x, #(_buffer+0)
	pushw	y
	pushw	x
	ldw	x, #(_a+0)
	call	___memcpy
;	main.c: 203: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
	clrw	x
	ld	a, (0x04, sp)
	ld	xl, a
	addw	x, #(_data_buf+0)
	pushw	x
	ldw	y, (0x09, sp)
	pushw	y
	ldw	x, #(_a+0)
	call	_convert_chars_to_int
	popw	x
	ld	(x), a
;	main.c: 204: int_buf_i++;
	inc	(0x04, sp)
;	main.c: 185: for(int o = 0; o < counter;o++)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	jra	00112$
00114$:
;	main.c: 206: }
	addw	sp, #8
	ret
;	main.c: 214: void reg_check(void)
;	-----------------------------------------
;	 function reg_check
;	-----------------------------------------
_reg_check:
;	main.c: 216: status_registers[0] = I2C_SR1;
	mov	_status_registers+0, 0x5217
;	main.c: 217: status_registers[1] = I2C_SR2;
	mov	_status_registers+1, 0x5218
;	main.c: 218: status_registers[2] = I2C_SR3;
	mov	_status_registers+2, 0x5219
;	main.c: 219: }
	ret
;	main.c: 222: void status_check(void){
;	-----------------------------------------
;	 function status_check
;	-----------------------------------------
_status_check:
	sub	sp, #9
;	main.c: 223: char rx_binary_chars[9]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
	clr	(0x06, sp)
	clr	(0x07, sp)
	clr	(0x08, sp)
	clr	(0x09, sp)
;	main.c: 224: uart_write("\nI2C_REGS >.<\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	main.c: 225: convert_int_to_binary(I2C_SR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5217
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 226: uart_write("\nSR1 -> ");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	main.c: 227: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 228: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 229: convert_int_to_binary(I2C_SR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5218
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 230: uart_write("SR2 -> ");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	main.c: 231: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 232: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 233: convert_int_to_binary(I2C_SR3, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5219
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 234: uart_write("SR3 -> ");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	main.c: 235: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 236: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 237: convert_int_to_binary(I2C_CR1, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5210
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 238: uart_write("CR1 -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	main.c: 239: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 240: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 241: convert_int_to_binary(I2C_CR2, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5211
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 242: uart_write("CR2 -> ");
	ldw	x, #(___str_6+0)
	call	_uart_write
;	main.c: 243: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 244: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 245: convert_int_to_binary(I2C_DR, rx_binary_chars);
	ldw	x, sp
	incw	x
	exgw	x, y
	ld	a, 0x5216
	clrw	x
	pushw	y
	ld	xl, a
	call	_convert_int_to_binary
;	main.c: 246: uart_write("DR -> ");
	ldw	x, #(___str_7+0)
	call	_uart_write
;	main.c: 247: uart_write(rx_binary_chars);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 248: uart_write(" <-\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	main.c: 249: uart_write("UART_REGS >.<\n");
	ldw	x, #(___str_8+0)
	call	_uart_write
;	main.c: 294: }
	addw	sp, #9
	ret
;	main.c: 296: void uart_init(void){
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	main.c: 297: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 300: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
	bset	0x5235, #3
;	main.c: 301: UART1_CR2 |= UART_CR2_REN; // Receiver enable
	bset	0x5235, #2
;	main.c: 302: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	main.c: 304: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
	mov	0x5233+0, #0x03
	mov	0x5232+0, #0x68
;	main.c: 305: }
	ret
;	main.c: 309: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	main.c: 315: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
	bres	0x5210, #0
;	main.c: 316: I2C_FREQR= 16;                  // peripheral frequence =16MHz
	mov	0x5212+0, #0x10
;	main.c: 317: I2C_CCRH = 0;                   // =0
	mov	0x521c+0, #0x00
;	main.c: 318: I2C_CCRL = 80;                  // 100kHz for I2C
	mov	0x521b+0, #0x50
;	main.c: 319: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
	bres	0x521c, #7
;	main.c: 320: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
	bres	0x5214, #7
;	main.c: 321: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
	bset	0x5214, #6
;	main.c: 322: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
	bset	0x5210, #0
;	main.c: 323: }
	ret
;	main.c: 332: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	main.c: 333: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
	bset	0x5211, #0
;	main.c: 334: while(!(I2C_SR1 & (1 << 0)));
00101$:
	btjf	0x5217, #0, 00101$
;	main.c: 336: }
	ret
;	main.c: 338: void i2c_send_address(uint8_t address) {
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	main.c: 339: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
	sll	a
	ld	0x5216, a
;	main.c: 340: reg_check();
	call	_reg_check
;	main.c: 341: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
00102$:
	btjf	0x5217, #1, 00117$
	ret
00117$:
	btjf	0x5218, #2, 00102$
;	main.c: 343: }
	ret
;	main.c: 345: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	main.c: 346: I2C_CR2 = I2C_CR2 | (1 << 1);// Отправка стопового сигнала
	bset	0x5211, #1
;	main.c: 348: }
	ret
;	main.c: 349: void i2c_write(void){
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #2
;	main.c: 350: I2C_DR = 0;
	mov	0x5216+0, #0x00
;	main.c: 351: reg_check();
	call	_reg_check
;	main.c: 352: I2C_DR = d_addr;
	mov	0x5216+0, _d_addr+0
;	main.c: 353: reg_check();
	call	_reg_check
;	main.c: 354: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
00103$:
	ld	a, 0x5217
	jrmi	00122$
	btjf	0x5218, #2, 00122$
	btjf	0x5217, #2, 00103$
;	main.c: 355: for(int i = 0;i < d_size;i++)
00122$:
	clrw	x
00112$:
	ld	a, _d_size+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00114$
;	main.c: 357: I2C_DR = data_buf[i];
	ldw	y, x
	ld	a, (_data_buf+0, y)
	ld	0x5216, a
;	main.c: 358: reg_check();
	pushw	x
	call	_reg_check
	popw	x
;	main.c: 359: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)));
00107$:
	ld	a, 0x5217
	jrmi	00113$
	btjt	0x5218, #2, 00107$
00113$:
;	main.c: 355: for(int i = 0;i < d_size;i++)
	incw	x
	jra	00112$
00114$:
;	main.c: 361: }
	addw	sp, #2
	ret
;	main.c: 363: void i2c_read(void){
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #4
;	main.c: 364: I2C_DR = d_addr;
	mov	0x5216+0, _d_addr+0
;	main.c: 365: status_check();
	call	_status_check
;	main.c: 366: while (!(I2C_SR1 & (1 << 7)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
00102$:
	ld	a, 0x5217
	jrmi	00104$
	btjf	0x5217, #2, 00102$
00104$:
;	main.c: 367: i2c_stop();
	call	_i2c_stop
;	main.c: 368: i2c_start();
	call	_i2c_start
;	main.c: 369: I2C_DR = (current_dev << 1) | (1 << 0);
	ld	a, _current_dev+0
	sll	a
	or	a, #0x01
	ld	0x5216, a
;	main.c: 370: status_check();
	call	_status_check
;	main.c: 371: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR1 & (1 << 2)));
00106$:
	btjt	0x5217, #1, 00108$
	btjf	0x5217, #2, 00106$
00108$:
;	main.c: 372: status_check();
	call	_status_check
;	main.c: 374: for(int i = 0;i < d_size;i++)
	clrw	x
	ldw	(0x03, sp), x
00114$:
	ld	a, _d_size+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00116$
;	main.c: 376: status_check();
	call	_status_check
;	main.c: 377: data_buf[i] = I2C_DR;
	ldw	x, (0x03, sp)
	ld	a, 0x5216
	ld	((_data_buf+0), x), a
;	main.c: 378: status_check();
	call	_status_check
;	main.c: 379: while (!(I2C_SR1 & (1 << 6)));
00109$:
	btjf	0x5217, #6, 00109$
;	main.c: 380: status_check();
	call	_status_check
;	main.c: 374: for(int i = 0;i < d_size;i++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00114$
00116$:
;	main.c: 382: }
	addw	sp, #4
	ret
;	main.c: 383: void i2c_scan(void) {
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	main.c: 384: for (uint8_t addr = current_dev; addr < 127; addr++) {
	ld	a, _current_dev+0
	ld	(0x01, sp), a
	ld	(0x02, sp), a
00105$:
	ld	a, (0x02, sp)
	cp	a, #0x7f
	jrnc	00107$
;	main.c: 385: i2c_start();
	call	_i2c_start
;	main.c: 386: i2c_send_address(addr);
	ld	a, (0x02, sp)
	call	_i2c_send_address
;	main.c: 387: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
	btjt	0x5218, #2, 00102$
;	main.c: 389: current_dev = addr;
	ld	a, (0x01, sp)
	ld	_current_dev+0, a
;	main.c: 390: i2c_stop();
	addw	sp, #2
;	main.c: 391: break;
	jp	_i2c_stop
00102$:
;	main.c: 393: i2c_stop();
	call	_i2c_stop
;	main.c: 394: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
	bres	0x5218, #2
;	main.c: 384: for (uint8_t addr = current_dev; addr < 127; addr++) {
	inc	(0x02, sp)
	ld	a, (0x02, sp)
	ld	(0x01, sp), a
	jra	00105$
00107$:
;	main.c: 396: }
	addw	sp, #2
	ret
;	main.c: 406: void cm_SM(void)
;	-----------------------------------------
;	 function cm_SM
;	-----------------------------------------
_cm_SM:
	sub	sp, #4
;	main.c: 408: char cur_dev[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 409: convert_int_to_chars(current_dev, cur_dev);
	ldw	x, sp
	incw	x
	ld	a, _current_dev+0
	call	_convert_int_to_chars
;	main.c: 410: uart_write("SM ");
	ldw	x, #(___str_9+0)
	call	_uart_write
;	main.c: 411: uart_write(cur_dev);
	ldw	x, sp
	incw	x
	call	_uart_write
;	main.c: 412: uart_write("\r\n");
	ldw	x, #(___str_10+0)
	call	_uart_write
;	main.c: 413: }
	addw	sp, #4
	ret
;	main.c: 414: void cm_SN(void)
;	-----------------------------------------
;	 function cm_SN
;	-----------------------------------------
_cm_SN:
;	main.c: 416: i2c_scan();
	call	_i2c_scan
;	main.c: 417: cm_SM();
;	main.c: 418: }
	jp	_cm_SM
;	main.c: 419: void cm_RM(void)
;	-----------------------------------------
;	 function cm_RM
;	-----------------------------------------
_cm_RM:
;	main.c: 421: current_dev = 0;
	clr	_current_dev+0
;	main.c: 422: uart_write("RM\n");
	ldw	x, #(___str_11+0)
;	main.c: 423: }
	jp	_uart_write
;	main.c: 425: void cm_DB(void)
;	-----------------------------------------
;	 function cm_DB
;	-----------------------------------------
_cm_DB:
;	main.c: 427: status_check();
;	main.c: 428: }
	jp	_status_check
;	main.c: 430: void cm_ST(void)
;	-----------------------------------------
;	 function cm_ST
;	-----------------------------------------
_cm_ST:
;	main.c: 432: get_addr_from_buff();
	call	_get_addr_from_buff
;	main.c: 433: current_dev = d_addr;
	mov	_current_dev+0, _d_addr+0
;	main.c: 434: uart_write("ST\n");
	ldw	x, #(___str_12+0)
;	main.c: 435: }
	jp	_uart_write
;	main.c: 436: void cm_SR(void)
;	-----------------------------------------
;	 function cm_SR
;	-----------------------------------------
_cm_SR:
	sub	sp, #4
;	main.c: 438: i2c_start();
	call	_i2c_start
;	main.c: 439: i2c_send_address(current_dev);
	ld	a, _current_dev+0
	call	_i2c_send_address
;	main.c: 440: i2c_read();
	call	_i2c_read
;	main.c: 441: i2c_stop();
	call	_i2c_stop
;	main.c: 442: uart_write("SR ");
	ldw	x, #(___str_13+0)
	call	_uart_write
;	main.c: 443: convert_int_to_chars(d_addr, a);
	ldw	x, #(_a+0)
	ld	a, _d_addr+0
	call	_convert_int_to_chars
;	main.c: 444: uart_write(a);
	ldw	x, #(_a+0)
	call	_uart_write
;	main.c: 445: uart_write(" ");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 446: convert_int_to_chars(d_size, a);
	ldw	x, #(_a+0)
	ld	a, _d_size+0
	call	_convert_int_to_chars
;	main.c: 447: uart_write(a);
	ldw	x, #(_a+0)
	call	_uart_write
;	main.c: 448: for(int i = 0;i < d_size;i++)
	clrw	x
	ldw	(0x03, sp), x
00103$:
	ld	a, _d_size+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00101$
;	main.c: 450: uart_write(" ");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 451: convert_int_to_chars(data_buf[i], a);
	ldw	x, (0x03, sp)
	ld	a, (_data_buf+0, x)
	ldw	x, #(_a+0)
	call	_convert_int_to_chars
;	main.c: 452: uart_write(a);
	ldw	x, #(_a+0)
	call	_uart_write
;	main.c: 448: for(int i = 0;i < d_size;i++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 455: uart_write("\r\n");
	ldw	x, #(___str_10+0)
	addw	sp, #4
;	main.c: 456: }
	jp	_uart_write
;	main.c: 457: void cm_SW(void)
;	-----------------------------------------
;	 function cm_SW
;	-----------------------------------------
_cm_SW:
	sub	sp, #4
;	main.c: 459: i2c_start();
	call	_i2c_start
;	main.c: 460: i2c_send_address(current_dev);
	ld	a, _current_dev+0
	call	_i2c_send_address
;	main.c: 461: i2c_write();
	call	_i2c_write
;	main.c: 462: i2c_stop();
	call	_i2c_stop
;	main.c: 463: uart_write("SW ");
	ldw	x, #(___str_15+0)
	call	_uart_write
;	main.c: 464: convert_int_to_chars(d_addr, a);
	ldw	x, #(_a+0)
	ld	a, _d_addr+0
	call	_convert_int_to_chars
;	main.c: 465: uart_write(a);
	ldw	x, #(_a+0)
	call	_uart_write
;	main.c: 466: uart_write(" ");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 467: convert_int_to_chars(d_size, a);
	ldw	x, #(_a+0)
	ld	a, _d_size+0
	call	_convert_int_to_chars
;	main.c: 468: uart_write(a);
	ldw	x, #(_a+0)
	call	_uart_write
;	main.c: 469: for(int i = 0;i < d_size;i++)
	clrw	x
	ldw	(0x03, sp), x
00103$:
	ld	a, _d_size+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00101$
;	main.c: 471: uart_write(" ");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	main.c: 472: convert_int_to_chars(data_buf[i], a);
	ldw	x, (0x03, sp)
	ld	a, (_data_buf+0, x)
	ldw	x, #(_a+0)
	call	_convert_int_to_chars
;	main.c: 473: uart_write(a);
	ldw	x, #(_a+0)
	call	_uart_write
;	main.c: 469: for(int i = 0;i < d_size;i++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00103$
00101$:
;	main.c: 476: uart_write("\r\n");
	ldw	x, #(___str_10+0)
	addw	sp, #4
;	main.c: 477: }
	jp	_uart_write
;	main.c: 485: int data_handler(void)
;	-----------------------------------------
;	 function data_handler
;	-----------------------------------------
_data_handler:
;	main.c: 487: p_size = 0;
	clr	_p_size+0
;	main.c: 488: p_bytes = 0;
	clr	_p_bytes+0
;	main.c: 489: d_addr = 0;
	clr	_d_addr+0
;	main.c: 490: d_size = 0;
	clr	_d_size+0
;	main.c: 491: memset(a, 0, sizeof(a));
	push	#0x03
	push	#0x00
	clrw	x
	pushw	x
	ldw	x, #(_a+0)
	call	_memset
;	main.c: 492: memset(data_buf, 0, sizeof(data_buf));
	push	#0x00
	push	#0x01
	clrw	x
	pushw	x
	ldw	x, #(_data_buf+0)
	call	_memset
;	main.c: 493: if(memcmp(&buffer[0],"SM",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_16+0)
	push	#((___str_16+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
;	main.c: 494: return 1;
	tnzw	x
	jrne	00102$
	incw	x
	ret
00102$:
;	main.c: 495: if(memcmp(&buffer[0],"SN",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_17+0)
	push	#((___str_17+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00104$
;	main.c: 496: return 2;
	ldw	x, #0x0002
	ret
00104$:
;	main.c: 497: if(memcmp(&buffer[0],"ST",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_18+0)
	push	#((___str_18+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00106$
;	main.c: 498: return 5;
	ldw	x, #0x0005
	ret
00106$:
;	main.c: 499: if(memcmp(&buffer[0],"RM",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_19+0)
	push	#((___str_19+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00108$
;	main.c: 500: return 6;
	ldw	x, #0x0006
	ret
00108$:
;	main.c: 501: if(memcmp(&buffer[0],"DB",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_20+0)
	push	#((___str_20+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00110$
;	main.c: 502: return 7;
	ldw	x, #0x0007
	ret
00110$:
;	main.c: 504: get_addr_from_buff();
	call	_get_addr_from_buff
;	main.c: 505: get_size_from_buff();
	call	_get_size_from_buff
;	main.c: 507: if(memcmp(&buffer[0],"SR",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_21+0)
	push	#((___str_21+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00112$
;	main.c: 508: return 3;
	ldw	x, #0x0003
	ret
00112$:
;	main.c: 510: char_buffer_to_int();
	call	_char_buffer_to_int
;	main.c: 512: if(memcmp(&buffer[0],"SW",2) == 0)
	push	#0x02
	push	#0x00
	push	#<(___str_22+0)
	push	#((___str_22+0) >> 8)
	ldw	x, #(_buffer+0)
	call	_memcmp
	tnzw	x
	jrne	00114$
;	main.c: 513: return 4;
	ldw	x, #0x0004
	ret
00114$:
;	main.c: 514: return 0;
	clrw	x
;	main.c: 516: }
	ret
;	main.c: 518: void command_switcher(void)
;	-----------------------------------------
;	 function command_switcher
;	-----------------------------------------
_command_switcher:
	sub	sp, #4
;	main.c: 520: char ar[4]={0};
	clr	(0x01, sp)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
;	main.c: 522: switch(data_handler())
	call	_data_handler
	tnzw	x
	jrmi	00109$
	cpw	x, #0x0007
	jrsgt	00109$
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
;	main.c: 524: case 1:
00101$:
;	main.c: 525: cm_SM();
	call	_cm_SM
;	main.c: 526: break;
	jra	00109$
;	main.c: 527: case 2:
00102$:
;	main.c: 528: cm_SN();
	call	_cm_SN
;	main.c: 529: break;
	jra	00109$
;	main.c: 530: case 3:
00103$:
;	main.c: 531: cm_SR();
	call	_cm_SR
;	main.c: 532: break;
	jra	00109$
;	main.c: 533: case 4:
00104$:
;	main.c: 534: cm_SW();
	call	_cm_SW
;	main.c: 535: break;
	jra	00109$
;	main.c: 536: case 5:
00105$:
;	main.c: 537: cm_ST();
	call	_cm_ST
;	main.c: 538: break;
	jra	00109$
;	main.c: 539: case 6:
00106$:
;	main.c: 540: cm_RM();
	call	_cm_RM
;	main.c: 541: break;
	jra	00109$
;	main.c: 542: case 7:
00107$:
;	main.c: 543: cm_DB();
	call	_cm_DB
;	main.c: 545: }
00109$:
;	main.c: 546: }
	addw	sp, #4
	ret
;	main.c: 549: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 551: uart_init();
	call	_uart_init
;	main.c: 552: i2c_init();
	call	_i2c_init
;	main.c: 553: uart_write("SS\n");
	ldw	x, #(___str_23+0)
	call	_uart_write
;	main.c: 554: while(1)
00102$:
;	main.c: 556: uart_read();
	call	_uart_read
;	main.c: 557: command_switcher();
	call	_command_switcher
	jra	00102$
;	main.c: 559: }
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
	.ascii "SM "
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_11:
	.ascii "RM"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_12:
	.ascii "ST"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_13:
	.ascii "SR "
	.db 0x00
	.area CODE
	.area CONST
___str_14:
	.ascii " "
	.db 0x00
	.area CODE
	.area CONST
___str_15:
	.ascii "SW "
	.db 0x00
	.area CODE
	.area CONST
___str_16:
	.ascii "SM"
	.db 0x00
	.area CODE
	.area CONST
___str_17:
	.ascii "SN"
	.db 0x00
	.area CODE
	.area CONST
___str_18:
	.ascii "ST"
	.db 0x00
	.area CODE
	.area CONST
___str_19:
	.ascii "RM"
	.db 0x00
	.area CODE
	.area CONST
___str_20:
	.ascii "DB"
	.db 0x00
	.area CODE
	.area CONST
___str_21:
	.ascii "SR"
	.db 0x00
	.area CODE
	.area CONST
___str_22:
	.ascii "SW"
	.db 0x00
	.area CODE
	.area CONST
___str_23:
	.ascii "SS"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
__xinit__status_registers:
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
