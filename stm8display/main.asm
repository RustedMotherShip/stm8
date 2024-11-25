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
;	libs/i2c_lib.c: 23: trash_reg = (uint8_t)I2C_SR2;
;	libs/i2c_lib.c: 25: }
	ret
;	libs/i2c_lib.c: 26: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	libs/i2c_lib.c: 29: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
	bres	0x5210, #0
;	libs/i2c_lib.c: 30: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0xc0
	or	a, #0x10
	ld	0x5212, a
;	libs/i2c_lib.c: 31: I2C_CCRH -> CCR = 0;// =0
	ld	a, 0x521c
	and	a, #0xf0
	ld	0x521c, a
;	libs/i2c_lib.c: 32: I2C_CCRL -> CCR = 80;// 100kHz for I2C
	mov	0x521b+0, #0x50
;	libs/i2c_lib.c: 33: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
	bres	0x521c, #7
;	libs/i2c_lib.c: 34: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
	bres	0x5214, #7
;	libs/i2c_lib.c: 35: I2C_OARH -> ADDCONF = 1;// see reference manual
	bset	0x5214, #0
;	libs/i2c_lib.c: 36: I2C_CR1 -> PE = 1;// PE=1, enable I2C
	bset	0x5210, #0
;	libs/i2c_lib.c: 37: }
	ret
;	libs/i2c_lib.c: 39: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	libs/i2c_lib.c: 40: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
	bset	0x5211, #0
;	libs/i2c_lib.c: 41: while(!(I2C_SR1 -> SB));// Ожидание отправки стартового сигнала
00101$:
	btjf	0x5217, #0, 00101$
;	libs/i2c_lib.c: 42: }
	ret
;	libs/i2c_lib.c: 44: uint8_t i2c_send_byte(unsigned char data){
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
	push	a
;	libs/i2c_lib.c: 45: uart_write("start send byte\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	libs/i2c_lib.c: 48: trash_clean();
	call	_trash_clean
;	libs/i2c_lib.c: 49: uart_write("byte -");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	libs/i2c_lib.c: 50: uart_write((unsigned char *)I2C_DR);
	ldw	x, #0x5216
	call	_uart_write
;	libs/i2c_lib.c: 51: uart_write("\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	libs/i2c_lib.c: 52: I2C_DR -> DR = 0x28;
	mov	0x5216+0, #0x28
;	libs/i2c_lib.c: 53: trash_clean();
	call	_trash_clean
;	libs/i2c_lib.c: 54: uart_write("byte send\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	libs/i2c_lib.c: 55: delay(500);
	ldw	x, #0x01f4
	call	_delay
;	libs/i2c_lib.c: 57: trash_clean();
	call	_trash_clean
;	libs/i2c_lib.c: 59: int result = I2C_SR2 -> AF;
	ld	a, 0x5218
	srl	a
	srl	a
	and	a, #0x01
	ld	(0x01, sp), a
;	libs/i2c_lib.c: 60: uart_write("DR byte\n");
	ldw	x, #(___str_4+0)
	call	_uart_write
;	libs/i2c_lib.c: 64: uart_write("AF -> ");
	ldw	x, #(___str_5+0)
	call	_uart_write
;	libs/i2c_lib.c: 65: uart_write((result ? "1" : "0"));
	tnz	(0x01, sp)
	jreq	00103$
	ldw	x, #___str_6+0
	.byte 0xbc
00103$:
	ldw	x, #___str_7+0
00104$:
	call	_uart_write
;	libs/i2c_lib.c: 66: uart_write("\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	libs/i2c_lib.c: 67: return result;
	ld	a, (0x01, sp)
;	libs/i2c_lib.c: 68: }
	addw	sp, #1
	ret
;	libs/i2c_lib.c: 70: uint8_t i2c_read_byte(unsigned char *data){
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	libs/i2c_lib.c: 71: while (!(I2C_SR1 -> RXNE));
00101$:
	btjf	0x5217, #6, 00101$
;	libs/i2c_lib.c: 73: return 0;
	clr	a
;	libs/i2c_lib.c: 75: }
	ret
;	libs/i2c_lib.c: 77: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	libs/i2c_lib.c: 78: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
	bset	0x5211, #1
;	libs/i2c_lib.c: 79: }
	ret
;	libs/i2c_lib.c: 82: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	libs/i2c_lib.c: 87: address = address << 1;
	sll	a
;	libs/i2c_lib.c: 84: switch(rw_type)
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00102$
;	libs/i2c_lib.c: 87: address = address << 1;
;	libs/i2c_lib.c: 88: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	libs/i2c_lib.c: 89: break;
;	libs/i2c_lib.c: 90: default:
;	libs/i2c_lib.c: 91: address = address << 1; // Отправка адреса устройства с битом на запись
;	libs/i2c_lib.c: 93: }
00102$:
;	libs/i2c_lib.c: 94: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	libs/i2c_lib.c: 95: I2C_DR -> DR = address;
	ld	0x5216, a
;	libs/i2c_lib.c: 96: uart_write("WHILE start\n");
	ldw	x, #(___str_8+0)
	call	_uart_write
;	libs/i2c_lib.c: 97: while (!(I2C_SR1 -> ADDR) && !(I2C_SR2 -> AF));
00105$:
	btjt	0x5217, #1, 00107$
	btjf	0x5218, #2, 00105$
00107$:
;	libs/i2c_lib.c: 99: uart_write("WHILE passed\n");  
	ldw	x, #(___str_9+0)
	call	_uart_write
;	libs/i2c_lib.c: 100: return I2C_SR1 -> ADDR;
	ld	a, 0x5217
	srl	a
	and	a, #0x01
;	libs/i2c_lib.c: 101: }
	popw	x
	addw	sp, #1
	jp	(x)
;	libs/i2c_lib.c: 103: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	push	a
;	libs/i2c_lib.c: 105: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	libs/i2c_lib.c: 108: uart_write("PIVO\n");
	ldw	x, #(___str_10+0)
	call	_uart_write
;	libs/i2c_lib.c: 109: uart_write("predfor\n");
	ldw	x, #(___str_11+0)
	call	_uart_write
;	libs/i2c_lib.c: 113: for(int i = 0;i < 25;i++)
	clr	(0x01, sp)
00105$:
	ld	a, (0x01, sp)
	cp	a, #0x19
	jrnc	00101$
;	libs/i2c_lib.c: 115: uart_write("for\n");
	ldw	x, #(___str_12+0)
	call	_uart_write
;	libs/i2c_lib.c: 116: i2c_send_byte(0x29);//Проверка на АСК бит
	ld	a, #0x29
	call	_i2c_send_byte
;	libs/i2c_lib.c: 113: for(int i = 0;i < 25;i++)
	inc	(0x01, sp)
	jra	00105$
00101$:
;	libs/i2c_lib.c: 125: uart_write("postforif\n");
	ldw	x, #(___str_13+0)
	call	_uart_write
00103$:
;	libs/i2c_lib.c: 127: uart_write("predstop\n");
	ldw	x, #(___str_14+0)
	call	_uart_write
;	libs/i2c_lib.c: 129: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 130: uart_write("poststop\n");
	ldw	x, #(___str_15+0)
	ldw	y, (2, sp)
	ldw	(5, sp), y
	addw	sp, #4
;	libs/i2c_lib.c: 131: }
	jp	_uart_write
;	libs/i2c_lib.c: 133: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #2
;	libs/i2c_lib.c: 134: I2C_CR2 -> ACK = 1;
	ldw	x, #0x5211
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	libs/i2c_lib.c: 135: if(i2c_send_address(dev_addr,1))
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	libs/i2c_lib.c: 136: for(int i = 0;i < size;i++)
	clrw	x
00105$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00103$
;	libs/i2c_lib.c: 138: i2c_read_byte((unsigned char *)data[i]);
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	clrw	y
	ld	yl, a
	pushw	x
	ldw	x, y
	call	_i2c_read_byte
	popw	x
;	libs/i2c_lib.c: 136: for(int i = 0;i < size;i++)
	incw	x
	jra	00105$
00103$:
;	libs/i2c_lib.c: 140: I2C_CR2 -> ACK = 0;
	ld	a, 0x5211
	and	a, #0xfb
	ld	0x5211, a
;	libs/i2c_lib.c: 141: }
	ldw	x, (3, sp)
	addw	sp, #7
	jp	(x)
;	libs/i2c_lib.c: 142: uint8_t i2c_scan(void) 
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	libs/i2c_lib.c: 144: for (uint8_t addr = 1; addr < 127; addr++)
	ld	a, #0x01
	ld	(0x01, sp), a
	ld	(0x02, sp), a
00105$:
	ld	a, (0x02, sp)
	cp	a, #0x7f
	jrnc	00103$
;	libs/i2c_lib.c: 146: if(i2c_send_address(addr, 0))
	push	#0x00
	ld	a, (0x03, sp)
	call	_i2c_send_address
	tnz	a
	jreq	00102$
;	libs/i2c_lib.c: 148: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 149: return addr;
	ld	a, (0x01, sp)
	jra	00107$
00102$:
;	libs/i2c_lib.c: 151: I2C_SR2 -> AF = 0;
	bres	0x5218, #2
;	libs/i2c_lib.c: 152: uart_write("error addr\n"); //Очистка флага ошибки
	ldw	x, #(___str_16+0)
	call	_uart_write
;	libs/i2c_lib.c: 144: for (uint8_t addr = 1; addr < 127; addr++)
	inc	(0x02, sp)
	ld	a, (0x02, sp)
	ld	(0x01, sp), a
	jra	00105$
00103$:
;	libs/i2c_lib.c: 154: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 155: return 0;
	clr	a
00107$:
;	libs/i2c_lib.c: 156: }
	addw	sp, #2
	ret
;	main.c: 3: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	ldw	y, sp
	subw	y, #10
	sub	sp, #255
	sub	sp, #3
;	main.c: 6: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 7: uart_init(9600,0);
	pushw	y
	clr	a
	ldw	x, #0x2580
	call	_uart_init
	call	_i2c_init
	popw	y
;	main.c: 11: buf[0] = 0xA4;
	ld	a, #0xa4
	ld	(0x01, sp), a
;	main.c: 12: buf[1] = 0xA5;
	ld	a, #0xa5
	ld	(0x02, sp), a
;	main.c: 15: uint8_t buf1[256] = {0};
	ldw	x, sp
	addw	x, #3
	clr	(x)
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
	clr	(0x8, y)
	clr	(0x9, y)
	clr	(0xa, y)
;	main.c: 16: buf1[0] = 0x01;
	ld	a, #0x01
	ld	(x), a
;	main.c: 17: buf1[1] = 0x02;
	ld	a, #0x02
	ld	(0x04, sp), a
;	main.c: 18: i2c_write(I2C_DISPLAY_ADDR,25,buf1);
	pushw	y
	pushw	x
	push	#0x19
	ld	a, #0x3c
	call	_i2c_write
	popw	y
;	main.c: 19: while(1);
00102$:
	jra	00102$
;	main.c: 25: }
	addw	sp, #255
	addw	sp, #3
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
	.ascii "byte -"
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "byte send"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_4:
	.ascii "DR byte"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_5:
	.ascii "AF -> "
	.db 0x00
	.area CODE
	.area CONST
___str_6:
	.ascii "1"
	.db 0x00
	.area CODE
	.area CONST
___str_7:
	.ascii "0"
	.db 0x00
	.area CODE
	.area CONST
___str_8:
	.ascii "WHILE start"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_9:
	.ascii "WHILE passed"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_10:
	.ascii "PIVO"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_11:
	.ascii "predfor"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_12:
	.ascii "for"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_13:
	.ascii "postforif"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_14:
	.ascii "predstop"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_15:
	.ascii "poststop"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_16:
	.ascii "error addr"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
