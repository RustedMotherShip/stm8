;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _i2c_scan
	.globl _i2c_read
	.globl _i2c_write
	.globl _i2c_send_address
	.globl _i2c_stop
	.globl _i2c_read_byte
	.globl _i2c_send_byte
	.globl _i2c_start
	.globl _i2c_init
	.globl _trash_clean
	.globl _delay
	.globl _uart_read
	.globl _uart_write
	.globl _uart_write_byte
	.globl _uart_read_byte
	.globl _uart_init
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
;	libs/uart_lib.c: 3: void uart_init(unsigned int baudrate,uint8_t stopbit)
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
	sub	sp, #2
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 7: UART1_CR2 -> TEN = 1; // Transmitter enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
	pop	a
;	libs/uart_lib.c: 8: UART1_CR2 -> REN = 1; // Receiver enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	libs/uart_lib.c: 9: switch(stopbit)
	cp	a, #0x02
	jreq	00101$
	cp	a, #0x03
	jreq	00102$
	jra	00103$
;	libs/uart_lib.c: 11: case 2:
00101$:
;	libs/uart_lib.c: 12: UART1_CR3 -> STOP = 2;
	ld	a, 0x5236
	and	a, #0xcf
	or	a, #0x20
	ld	0x5236, a
;	libs/uart_lib.c: 13: break;
	jra	00104$
;	libs/uart_lib.c: 14: case 3:
00102$:
;	libs/uart_lib.c: 15: UART1_CR3 -> STOP = 3;
	ld	a, 0x5236
	or	a, #0x30
	ld	0x5236, a
;	libs/uart_lib.c: 16: break;
	jra	00104$
;	libs/uart_lib.c: 17: default:
00103$:
;	libs/uart_lib.c: 18: UART1_CR3 -> STOP = 0;
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	libs/uart_lib.c: 20: }
00104$:
;	libs/uart_lib.c: 21: switch(baudrate)
	ldw	x, (0x01, sp)
	cpw	x, #0x0800
	jrne	00186$
	jp	00110$
00186$:
	ldw	x, (0x01, sp)
	cpw	x, #0x0960
	jreq	00105$
	ldw	x, (0x01, sp)
	cpw	x, #0x1000
	jrne	00192$
	jp	00111$
00192$:
	ldw	x, (0x01, sp)
	cpw	x, #0x4b00
	jreq	00106$
	ldw	x, (0x01, sp)
	cpw	x, #0x8400
	jreq	00109$
	ldw	x, (0x01, sp)
	cpw	x, #0xc200
	jreq	00108$
	ldw	x, (0x01, sp)
	cpw	x, #0xe100
	jreq	00107$
	jra	00112$
;	libs/uart_lib.c: 23: case (unsigned int)2400:
00105$:
;	libs/uart_lib.c: 24: UART1_BRR2 -> MSB = 0x01;
	ld	a, 0x5233
	and	a, #0x0f
	or	a, #0x10
	ld	0x5233, a
;	libs/uart_lib.c: 25: UART1_BRR1 -> DIV = 0xA0;
	mov	0x5232+0, #0xa0
;	libs/uart_lib.c: 26: UART1_BRR2 -> LSB = 0x0B; 
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	libs/uart_lib.c: 27: break;
	jra	00114$
;	libs/uart_lib.c: 28: case (unsigned int)19200:
00106$:
;	libs/uart_lib.c: 29: UART1_BRR1 -> DIV = 0x34;
	mov	0x5232+0, #0x34
;	libs/uart_lib.c: 30: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	libs/uart_lib.c: 31: break;
	jra	00114$
;	libs/uart_lib.c: 32: case (unsigned int)57600:
00107$:
;	libs/uart_lib.c: 33: UART1_BRR1 -> DIV = 0x11;
	mov	0x5232+0, #0x11
;	libs/uart_lib.c: 34: UART1_BRR2 -> LSB = 0x06;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x06
	ld	0x5233, a
;	libs/uart_lib.c: 35: break;
	jra	00114$
;	libs/uart_lib.c: 36: case (unsigned int)115200:
00108$:
;	libs/uart_lib.c: 37: UART1_BRR1 -> DIV = 0x08;
	mov	0x5232+0, #0x08
;	libs/uart_lib.c: 38: UART1_BRR2 -> LSB = 0x0B;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	libs/uart_lib.c: 39: break;
	jra	00114$
;	libs/uart_lib.c: 40: case (unsigned int)230400:
00109$:
;	libs/uart_lib.c: 41: UART1_BRR1 -> DIV = 0x04;
	mov	0x5232+0, #0x04
;	libs/uart_lib.c: 42: UART1_BRR2 -> LSB = 0x05;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x05
	ld	0x5233, a
;	libs/uart_lib.c: 43: break;
	jra	00114$
;	libs/uart_lib.c: 44: case (unsigned int)460800:
00110$:
;	libs/uart_lib.c: 45: UART1_BRR1 -> DIV = 0x02;
	mov	0x5232+0, #0x02
;	libs/uart_lib.c: 46: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	libs/uart_lib.c: 47: break;
	jra	00114$
;	libs/uart_lib.c: 48: case (unsigned int)921600:
00111$:
;	libs/uart_lib.c: 49: UART1_BRR1 -> DIV = 0x01;
	mov	0x5232+0, #0x01
;	libs/uart_lib.c: 50: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	libs/uart_lib.c: 51: break;
	jra	00114$
;	libs/uart_lib.c: 52: default:
00112$:
;	libs/uart_lib.c: 53: UART1_BRR1 -> DIV = 0x68;
	mov	0x5232+0, #0x68
;	libs/uart_lib.c: 54: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	libs/uart_lib.c: 56: }
00114$:
;	libs/uart_lib.c: 57: }
	addw	sp, #2
	ret
;	libs/uart_lib.c: 59: int uart_read_byte(uint8_t *data)
;	-----------------------------------------
;	 function uart_read_byte
;	-----------------------------------------
_uart_read_byte:
;	libs/uart_lib.c: 61: while(!(UART1_SR -> RXNE));
00101$:
	btjf	0x5230, #5, 00101$
;	libs/uart_lib.c: 63: return 1;
	clrw	x
	incw	x
;	libs/uart_lib.c: 64: }
	ret
;	libs/uart_lib.c: 66: int uart_write_byte(uint8_t data)
;	-----------------------------------------
;	 function uart_write_byte
;	-----------------------------------------
_uart_write_byte:
;	libs/uart_lib.c: 68: UART1_DR -> DR = data;
	ld	0x5231, a
;	libs/uart_lib.c: 69: while(!(UART1_SR -> TXE));
00101$:
	btjf	0x5230, #7, 00101$
;	libs/uart_lib.c: 70: return 1;
	clrw	x
	incw	x
;	libs/uart_lib.c: 71: }
	ret
;	libs/uart_lib.c: 73: int uart_write(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #4
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 75: int count = 0;
	clrw	x
	ldw	(0x03, sp), x
;	libs/uart_lib.c: 76: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	clrw	x
00103$:
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (y)
	jreq	00101$
;	libs/uart_lib.c: 77: count += uart_write_byte(data_buf[i]);
	pushw	x
	call	_uart_write_byte
	exgw	x, y
	popw	x
	addw	y, (0x03, sp)
	ldw	(0x03, sp), y
;	libs/uart_lib.c: 76: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	incw	x
	jra	00103$
00101$:
;	libs/uart_lib.c: 78: return count;
	ldw	x, (0x03, sp)
;	libs/uart_lib.c: 79: }
	addw	sp, #4
	ret
;	libs/uart_lib.c: 80: int uart_read(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
	sub	sp, #4
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 82: int count = 0;
	clrw	x
	ldw	(0x03, sp), x
;	libs/uart_lib.c: 83: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	clrw	x
00103$:
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (y)
	jreq	00101$
;	libs/uart_lib.c: 84: count += uart_read_byte((unsigned char *)data_buf[i]);
	clrw	y
	ld	yl, a
	pushw	x
	ldw	x, y
	call	_uart_read_byte
	exgw	x, y
	popw	x
	addw	y, (0x03, sp)
	ldw	(0x03, sp), y
;	libs/uart_lib.c: 83: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	incw	x
	jra	00103$
00101$:
;	libs/uart_lib.c: 85: return count;
	ldw	x, (0x03, sp)
;	libs/uart_lib.c: 86: }
	addw	sp, #4
	ret
;	libs/i2c_lib.c: 10: void delay(uint16_t ticks)
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
;	libs/i2c_lib.c: 12: while(ticks > 0)
00101$:
	tnzw	x
	jrne	00120$
	ret
00120$:
;	libs/i2c_lib.c: 14: ticks-=2;
	decw	x
	decw	x
;	libs/i2c_lib.c: 15: ticks+=1;
	incw	x
	jra	00101$
;	libs/i2c_lib.c: 17: }
	ret
;	libs/i2c_lib.c: 18: void trash_clean(void)
;	-----------------------------------------
;	 function trash_clean
;	-----------------------------------------
_trash_clean:
;	libs/i2c_lib.c: 23: trash_reg = (unsigned char)I2C_SR3;
;	libs/i2c_lib.c: 24: }
	ret
;	libs/i2c_lib.c: 25: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	libs/i2c_lib.c: 28: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
	bres	0x5210, #0
;	libs/i2c_lib.c: 29: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0xc0
	or	a, #0x10
	ld	0x5212, a
;	libs/i2c_lib.c: 30: I2C_CCRH -> CCR = 0;// =0
	ld	a, 0x521c
	and	a, #0xf0
	ld	0x521c, a
;	libs/i2c_lib.c: 31: I2C_CCRL -> CCR = 80;// 100kHz for I2C
	mov	0x521b+0, #0x50
;	libs/i2c_lib.c: 32: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
	bres	0x521c, #7
;	libs/i2c_lib.c: 33: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
	bres	0x5214, #7
;	libs/i2c_lib.c: 34: I2C_OARH -> ADDCONF = 1;// see reference manual
	bset	0x5214, #0
;	libs/i2c_lib.c: 35: I2C_CR1 -> PE = 1;// PE=1, enable I2C
	bset	0x5210, #0
;	libs/i2c_lib.c: 36: }
	ret
;	libs/i2c_lib.c: 38: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	libs/i2c_lib.c: 39: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
	bset	0x5211, #0
;	libs/i2c_lib.c: 40: while(!(I2C_SR1 -> SB));// Ожидание отправки стартового сигнала
00101$:
	btjf	0x5217, #0, 00101$
;	libs/i2c_lib.c: 41: }
	ret
;	libs/i2c_lib.c: 43: uint8_t i2c_send_byte(unsigned char data){
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
	push	a
	ld	(0x01, sp), a
;	libs/i2c_lib.c: 44: uart_write("start send byte\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	libs/i2c_lib.c: 45: while (!(I2C_SR1 -> TXE));
00101$:
	btjf	0x5217, #7, 00101$
;	libs/i2c_lib.c: 46: uart_write("while passed\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	libs/i2c_lib.c: 47: I2C_DR -> DR = data;
	ldw	x, #0x5216
	ld	a, (0x01, sp)
	ld	(x), a
;	libs/i2c_lib.c: 49: uart_write("DR byte\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	libs/i2c_lib.c: 50: int result = I2C_SR2 -> AF;
	ld	a, 0x5218
	swap	a
	srl	a
	srl	a
	srl	a
	and	a, #0x01
;	libs/i2c_lib.c: 51: return result;
;	libs/i2c_lib.c: 52: }
	addw	sp, #1
	ret
;	libs/i2c_lib.c: 54: uint8_t i2c_read_byte(unsigned char *data){
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	libs/i2c_lib.c: 55: while (!(I2C_SR1 -> RXNE));
00101$:
	btjf	0x5217, #6, 00101$
;	libs/i2c_lib.c: 57: return 0;
	clr	a
;	libs/i2c_lib.c: 59: }
	ret
;	libs/i2c_lib.c: 61: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	libs/i2c_lib.c: 62: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
	bset	0x5211, #1
;	libs/i2c_lib.c: 63: }
	ret
;	libs/i2c_lib.c: 66: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	libs/i2c_lib.c: 68: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	libs/i2c_lib.c: 72: address = address << 1;
	sll	a
;	libs/i2c_lib.c: 69: switch(rw_type)
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00102$
;	libs/i2c_lib.c: 72: address = address << 1;
;	libs/i2c_lib.c: 73: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	libs/i2c_lib.c: 74: break;
;	libs/i2c_lib.c: 75: default:
;	libs/i2c_lib.c: 76: address = address << 1; // Отправка адреса устройства с битом на запись
;	libs/i2c_lib.c: 78: }
00102$:
;	libs/i2c_lib.c: 79: I2C_DR -> DR = address;//Отправка адреса
	ld	0x5216, a
;	libs/i2c_lib.c: 80: delay(250);
	ldw	x, #0x00fa
	call	_delay
;	libs/i2c_lib.c: 82: int result = I2C_SR1 -> ADDR;
	ld	a, 0x5217
	srl	a
	and	a, #0x01
;	libs/i2c_lib.c: 83: return result;
;	libs/i2c_lib.c: 84: }
	popw	x
	addw	sp, #1
	jp	(x)
;	libs/i2c_lib.c: 86: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #4
;	libs/i2c_lib.c: 88: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jreq	00105$
;	libs/i2c_lib.c: 90: uart_write("PIVO\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	libs/i2c_lib.c: 91: for(int i = 0;i < size;i++)
	clrw	x
	ldw	(0x03, sp), x
00107$:
	ld	a, (0x07, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00105$
;	libs/i2c_lib.c: 93: uart_write("for\n");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	libs/i2c_lib.c: 94: if(i2c_send_byte(data[i]))//Проверка на АСК бит
	ldw	x, (0x08, sp)
	addw	x, (0x03, sp)
	ld	a, (x)
	call	_i2c_send_byte
	tnz	a
	jreq	00102$
;	libs/i2c_lib.c: 96: uart_write("error send byte\n");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	libs/i2c_lib.c: 97: break;
	jra	00105$
00102$:
;	libs/i2c_lib.c: 99: uart_write("if passed\n");    
	ldw	x, #(___str_6+0)
	call	_uart_write
;	libs/i2c_lib.c: 91: for(int i = 0;i < size;i++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00107$
00105$:
;	libs/i2c_lib.c: 102: i2c_stop();
	ldw	x, (5, sp)
	ldw	(8, sp), x
	addw	sp, #7
;	libs/i2c_lib.c: 103: }
	jp	_i2c_stop
;	libs/i2c_lib.c: 105: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #2
;	libs/i2c_lib.c: 106: I2C_CR2 -> ACK = 1;
	ldw	x, #0x5211
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	libs/i2c_lib.c: 107: if(i2c_send_address(dev_addr,1))
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	libs/i2c_lib.c: 108: for(int i = 0;i < size;i++)
	clrw	x
00105$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00103$
;	libs/i2c_lib.c: 110: i2c_read_byte((unsigned char *)data[i]);
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	clrw	y
	ld	yl, a
	pushw	x
	ldw	x, y
	call	_i2c_read_byte
	popw	x
;	libs/i2c_lib.c: 108: for(int i = 0;i < size;i++)
	incw	x
	jra	00105$
00103$:
;	libs/i2c_lib.c: 112: I2C_CR2 -> ACK = 0;
	ld	a, 0x5211
	and	a, #0xfb
	ld	0x5211, a
;	libs/i2c_lib.c: 113: }
	ldw	x, (3, sp)
	addw	sp, #7
	jp	(x)
;	libs/i2c_lib.c: 114: uint8_t i2c_scan(void) 
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	libs/i2c_lib.c: 116: for (uint8_t addr = 1; addr < 127; addr++)
	ld	a, #0x01
	ld	(0x01, sp), a
00105$:
	cp	a, #0x7f
	jrnc	00103$
;	libs/i2c_lib.c: 118: if(i2c_send_address(addr, 0))
	push	a
	push	#0x00
	call	_i2c_send_address
	ld	(0x03, sp), a
	pop	a
	tnz	(0x02, sp)
	jreq	00102$
;	libs/i2c_lib.c: 120: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 121: return addr;
	ld	a, (0x01, sp)
	jra	00107$
00102$:
;	libs/i2c_lib.c: 123: I2C_SR2 -> AF = 0; //Очистка флага ошибки
	ldw	x, #0x5218
	push	a
	ld	a, (x)
	and	a, #0x7f
	ld	(x), a
	pop	a
;	libs/i2c_lib.c: 116: for (uint8_t addr = 1; addr < 127; addr++)
	inc	a
	ld	(0x01, sp), a
	jra	00105$
00103$:
;	libs/i2c_lib.c: 125: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 126: return 0;
	clr	a
00107$:
;	libs/i2c_lib.c: 127: }
	addw	sp, #2
	ret
;	main.c: 3: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #2
;	main.c: 6: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 7: uart_init(9600,0);
	clr	a
	ldw	x, #0x2580
	call	_uart_init
;	main.c: 8: i2c_init();
	call	_i2c_init
;	main.c: 11: buf[0] = 0xA4;
	ld	a, #0xa4
	ld	(0x01, sp), a
;	main.c: 12: i2c_write(I2C_DISPLAY_ADDR,1,buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x01
	ld	a, #0x3c
	call	_i2c_write
;	main.c: 13: for(int i = 0;i < 256;i++)
	clrw	x
00103$:
	cpw	x, #0x0100
	jrsge	00101$
;	main.c: 15: buf[0] = i;
	ld	a, xl
	ld	(0x01, sp), a
;	main.c: 16: buf[1] = 1;
	ld	a, #0x01
	ld	(0x02, sp), a
;	main.c: 17: i2c_write(I2C_DISPLAY_ADDR,2,buf);
	pushw	x
	ldw	y, sp
	addw	y, #3
	pushw	y
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
	popw	x
;	main.c: 18: i++;
	incw	x
;	main.c: 13: for(int i = 0;i < 256;i++)
	incw	x
	jra	00103$
00101$:
;	main.c: 20: return 0;
	clrw	x
;	main.c: 21: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "start send byte"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "while passed"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "DR byte"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "PIVO"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "for"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "error send byte"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "if passed"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
