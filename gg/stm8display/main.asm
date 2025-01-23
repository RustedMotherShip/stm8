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
	.globl _gg
	.globl _setup
	.globl _set_bit
	.globl _get_bit
	.globl _I2C_IRQ
	.globl _splash
	.globl _buf_size
	.globl _buf_pos
	.globl _rx_buf_pointer
	.globl _tx_buf_pointer
	.globl _uart_transmission_irq
	.globl _uart_reciever_irq
	.globl _uart_write_irq
	.globl _uart_read_irq
	.globl _uart_init
	.globl _uart_read_byte
	.globl _uart_write_byte
	.globl _uart_write
	.globl _uart_read
	.globl _i2c_init
	.globl _i2c_start
	.globl _i2c_stop
	.globl _i2c_send_address
	.globl _i2c_read_byte
	.globl _i2c_read
	.globl _i2c_send_byte
	.globl _i2c_write
	.globl _i2c_scan
	.globl _ssd1306_init
	.globl _ssd1306_set_params_to_write
	.globl _ssd1306_draw_pixel
	.globl _ssd1306_buffer_fill_entire
	.globl _ssd1306_clean
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_tx_buf_pointer::
	.ds 2
_rx_buf_pointer::
	.ds 2
_buf_pos::
	.ds 1
_buf_size::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_splash::
	.ds 512
_I2C_IRQ::
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
	int 0x000000 ; trap
	int 0x000000 ; int0
	int 0x000000 ; int1
	int 0x000000 ; int2
	int 0x000000 ; int3
	int 0x000000 ; int4
	int 0x000000 ; int5
	int 0x000000 ; int6
	int 0x000000 ; int7
	int 0x000000 ; int8
	int 0x000000 ; int9
	int 0x000000 ; int10
	int 0x000000 ; int11
	int 0x000000 ; int12
	int 0x000000 ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int _uart_transmission_irq ; int17
	int _uart_reciever_irq ; int18
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
;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
;	-----------------------------------------
;	 function uart_transmission_irq
;	-----------------------------------------
_uart_transmission_irq:
;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
	ldw	x, #0x5230
	ld	a, (x)
	swap	a
	srl	a
	srl	a
	srl	a
	bcp	a, #0x01
	jreq	00107$
;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
	ld	a, _tx_buf_pointer+1
	add	a, _buf_pos+0
	ld	xl, a
	ld	a, _tx_buf_pointer+0
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	jreq	00102$
	ld	a, _buf_pos+0
	cp	a, _buf_size+0
	jrnc	00102$
;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
	ld	a, _buf_pos+0
	inc	_buf_pos+0
	clrw	x
	ld	xl, a
	addw	x, _tx_buf_pointer+0
	ld	a, (x)
	ld	0x5231, a
	jra	00107$
00102$:
;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
	bres	0x5235, #7
00107$:
;	./libs/uart_lib.c: 14: }
	iret
;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
;	-----------------------------------------
;	 function uart_reciever_irq
;	-----------------------------------------
_uart_reciever_irq:
	push	a
;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
	ld	a, 0x5230
	swap	a
	srl	a
	bcp	a, #0x01
	jreq	00107$
;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
	ld	a, 0x5231
;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
	ld	(0x01, sp), a
	cp	a, #0x0a
	jreq	00102$
	ld	a, _buf_pos+0
	cp	a, _buf_size+0
	jrnc	00102$
;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
	ld	a, _buf_pos+0
	inc	_buf_pos+0
	clrw	x
	ld	xl, a
	addw	x, _rx_buf_pointer+0
	ld	a, (0x01, sp)
	ld	(x), a
	jra	00107$
00102$:
;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
	bres	0x5235, #5
00107$:
;	./libs/uart_lib.c: 30: }
	pop	a
	iret
;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_write_irq
;	-----------------------------------------
_uart_write_irq:
	sub	sp, #2
;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
	ldw	(0x01, sp), x
	ldw	_tx_buf_pointer+0, x
;	./libs/uart_lib.c: 35: buf_pos = 0;
	clr	_buf_pos+0
;	./libs/uart_lib.c: 36: buf_size = 0;
	clr	_buf_size+0
;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
00101$:
	ld	a, _buf_size+0
	inc	_buf_size+0
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	jrne	00101$
;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
	bset	0x5235, #7
;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
00104$:
	btjt	0x5235, #7, 00104$
;	./libs/uart_lib.c: 40: }
	addw	sp, #2
	ret
;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
;	-----------------------------------------
;	 function uart_read_irq
;	-----------------------------------------
_uart_read_irq:
;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
	ldw	_rx_buf_pointer+0, x
;	./libs/uart_lib.c: 44: buf_pos = 0;
	clr	_buf_pos+0
;	./libs/uart_lib.c: 45: buf_size = size;
	ld	a, (0x04, sp)
	ld	_buf_size+0, a
;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
	bset	0x5235, #5
;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
00101$:
	ld	a, 0x5235
	swap	a
	srl	a
	and	a, #0x01
	jrne	00101$
;	./libs/uart_lib.c: 48: }
	ldw	x, (1, sp)
	addw	sp, #4
	jp	(x)
;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
	sub	sp, #2
	ldw	(0x01, sp), x
;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
	pop	a
;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	./libs/uart_lib.c: 56: switch(stopbit)
	cp	a, #0x02
	jreq	00101$
	cp	a, #0x03
	jreq	00102$
	jra	00103$
;	./libs/uart_lib.c: 58: case 2:
00101$:
;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
	ld	a, 0x5236
	and	a, #0xcf
	or	a, #0x20
	ld	0x5236, a
;	./libs/uart_lib.c: 60: break;
	jra	00104$
;	./libs/uart_lib.c: 61: case 3:
00102$:
;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
	ld	a, 0x5236
	or	a, #0x30
	ld	0x5236, a
;	./libs/uart_lib.c: 63: break;
	jra	00104$
;	./libs/uart_lib.c: 64: default:
00103$:
;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	./libs/uart_lib.c: 67: }
00104$:
;	./libs/uart_lib.c: 68: switch(baudrate)
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
;	./libs/uart_lib.c: 70: case (unsigned int)2400:
00105$:
;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
	ld	a, 0x5233
	and	a, #0x0f
	or	a, #0x10
	ld	0x5233, a
;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
	mov	0x5232+0, #0xa0
;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	./libs/uart_lib.c: 74: break;
	jra	00114$
;	./libs/uart_lib.c: 75: case (unsigned int)19200:
00106$:
;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
	mov	0x5232+0, #0x34
;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	./libs/uart_lib.c: 78: break;
	jra	00114$
;	./libs/uart_lib.c: 79: case (unsigned int)57600:
00107$:
;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
	mov	0x5232+0, #0x11
;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x06
	ld	0x5233, a
;	./libs/uart_lib.c: 82: break;
	jra	00114$
;	./libs/uart_lib.c: 83: case (unsigned int)115200:
00108$:
;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
	mov	0x5232+0, #0x08
;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	./libs/uart_lib.c: 86: break;
	jra	00114$
;	./libs/uart_lib.c: 87: case (unsigned int)230400:
00109$:
;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
	mov	0x5232+0, #0x04
;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x05
	ld	0x5233, a
;	./libs/uart_lib.c: 90: break;
	jra	00114$
;	./libs/uart_lib.c: 91: case (unsigned int)460800:
00110$:
;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
	mov	0x5232+0, #0x02
;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	./libs/uart_lib.c: 94: break;
	jra	00114$
;	./libs/uart_lib.c: 95: case (unsigned int)921600:
00111$:
;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
	mov	0x5232+0, #0x01
;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	./libs/uart_lib.c: 98: break;
	jra	00114$
;	./libs/uart_lib.c: 99: default:
00112$:
;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
	mov	0x5232+0, #0x68
;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	./libs/uart_lib.c: 103: }
00114$:
;	./libs/uart_lib.c: 104: }
	addw	sp, #2
	ret
;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
;	-----------------------------------------
;	 function uart_read_byte
;	-----------------------------------------
_uart_read_byte:
;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
00101$:
	btjf	0x5230, #5, 00101$
;	./libs/uart_lib.c: 110: return 1;
	clrw	x
	incw	x
;	./libs/uart_lib.c: 111: }
	ret
;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
;	-----------------------------------------
;	 function uart_write_byte
;	-----------------------------------------
_uart_write_byte:
;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
	ld	0x5231, a
;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
00101$:
	btjf	0x5230, #7, 00101$
;	./libs/uart_lib.c: 117: return 1;
	clrw	x
	incw	x
;	./libs/uart_lib.c: 118: }
	ret
;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #4
	ldw	(0x01, sp), x
;	./libs/uart_lib.c: 122: int count = 0;
	clrw	x
	ldw	(0x03, sp), x
;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	clrw	x
00103$:
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (y)
	jreq	00101$
;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
	pushw	x
	call	_uart_write_byte
	exgw	x, y
	popw	x
	addw	y, (0x03, sp)
	ldw	(0x03, sp), y
;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	incw	x
	jra	00103$
00101$:
;	./libs/uart_lib.c: 125: return count;
	ldw	x, (0x03, sp)
;	./libs/uart_lib.c: 126: }
	addw	sp, #4
	ret
;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
	sub	sp, #4
	ldw	(0x01, sp), x
;	./libs/uart_lib.c: 130: int count = 0;
	clrw	x
	ldw	(0x03, sp), x
;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	clrw	x
00103$:
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (y)
	jreq	00101$
;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
	clrw	y
	ld	yl, a
	pushw	x
	ldw	x, y
	call	_uart_read_byte
	exgw	x, y
	popw	x
	addw	y, (0x03, sp)
	ldw	(0x03, sp), y
;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	incw	x
	jra	00103$
00101$:
;	./libs/uart_lib.c: 133: return count;
	ldw	x, (0x03, sp)
;	./libs/uart_lib.c: 134: }
	addw	sp, #4
	popw	y
	addw	sp, #2
	jp	(y)
;	./libs/i2c_lib.c: 3: void i2c_init(void)
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	./libs/i2c_lib.c: 7: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
	bres	0x5210, #0
;	./libs/i2c_lib.c: 8: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0xc0
	or	a, #0x10
	ld	0x5212, a
;	./libs/i2c_lib.c: 9: I2C_CCRH -> CCR = 0;// =0
	ld	a, 0x521c
	and	a, #0xf0
	ld	0x521c, a
;	./libs/i2c_lib.c: 10: I2C_CCRL -> CCR = 80;// 100kHz for I2C
	mov	0x521b+0, #0x50
;	./libs/i2c_lib.c: 11: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
	bres	0x521c, #7
;	./libs/i2c_lib.c: 12: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
	bres	0x5214, #7
;	./libs/i2c_lib.c: 13: I2C_OARH -> ADDCONF = 1;// see reference manual
	bset	0x5214, #0
;	./libs/i2c_lib.c: 14: I2C_CR1 -> PE = 1;// PE=1, enable I2C
	bset	0x5210, #0
;	./libs/i2c_lib.c: 15: }
	ret
;	./libs/i2c_lib.c: 17: void i2c_start(void)
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	./libs/i2c_lib.c: 19: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
	bset	0x5211, #0
;	./libs/i2c_lib.c: 20: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
00101$:
	btjf	0x5217, #0, 00101$
;	./libs/i2c_lib.c: 21: }
	ret
;	./libs/i2c_lib.c: 23: void i2c_stop(void)
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	./libs/i2c_lib.c: 25: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
	bset	0x5211, #1
;	./libs/i2c_lib.c: 26: }
	ret
;	./libs/i2c_lib.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	./libs/i2c_lib.c: 33: address = address << 1;
	sll	a
;	./libs/i2c_lib.c: 30: switch(rw_type)
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00102$
;	./libs/i2c_lib.c: 33: address = address << 1;
;	./libs/i2c_lib.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	./libs/i2c_lib.c: 35: break;
;	./libs/i2c_lib.c: 36: default:
;	./libs/i2c_lib.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
;	./libs/i2c_lib.c: 39: }
00102$:
;	./libs/i2c_lib.c: 40: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	./libs/i2c_lib.c: 41: I2C_DR -> DR = address;
	ld	0x5216, a
;	./libs/i2c_lib.c: 42: while(!I2C_SR1 -> ADDR)
00106$:
	ldw	x, #0x5217
	ld	a, (x)
	srl	a
	and	a, #0x01
	jrne	00108$
;	./libs/i2c_lib.c: 43: if(I2C_SR2 -> AF)
	btjf	0x5218, #2, 00106$
;	./libs/i2c_lib.c: 44: return 0;
	clr	a
	jra	00109$
00108$:
;	./libs/i2c_lib.c: 45: clr_sr1();
	ld	a,0x5217
;	./libs/i2c_lib.c: 46: clr_sr3();
	ld	a,0x5219
;	./libs/i2c_lib.c: 47: return 1;
	ld	a, #0x01
00109$:
;	./libs/i2c_lib.c: 48: }
	popw	x
	addw	sp, #1
	jp	(x)
;	./libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void)
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	./libs/i2c_lib.c: 52: while(!I2C_SR1 -> RXNE);
00101$:
	btjf	0x5217, #6, 00101$
;	./libs/i2c_lib.c: 53: return I2C_DR -> DR;
	ld	a, 0x5216
;	./libs/i2c_lib.c: 54: }
	ret
;	./libs/i2c_lib.c: 56: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #4
;	./libs/i2c_lib.c: 58: if(i2c_send_address(dev_addr, 1))//проверка на ACK
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	./libs/i2c_lib.c: 60: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
	bset	0x5211, #2
;	./libs/i2c_lib.c: 61: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
	clrw	x
	ldw	(0x03, sp), x
00105$:
	clrw	x
	ld	a, (0x07, sp)
	ld	xl, a
	decw	x
	ldw	(0x01, sp), x
	ldw	x, (0x03, sp)
	cpw	x, (0x01, sp)
	jrsge	00101$
;	./libs/i2c_lib.c: 63: data[i] = i2c_read_byte();//функция записи байта в элемент массива
	ldw	x, (0x08, sp)
	addw	x, (0x03, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	./libs/i2c_lib.c: 61: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00105$
00101$:
;	./libs/i2c_lib.c: 65: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
	ld	a, 0x5211
	and	a, #0xfb
	ld	0x5211, a
;	./libs/i2c_lib.c: 67: data[size-1] = i2c_read_byte();
	ldw	x, (0x08, sp)
	addw	x, (0x01, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	./libs/i2c_lib.c: 69: i2c_stop();
	call	_i2c_stop
00103$:
;	./libs/i2c_lib.c: 72: i2c_stop();
	ldw	x, (5, sp)
	ldw	(8, sp), x
	addw	sp, #7
;	./libs/i2c_lib.c: 74: }
	jp	_i2c_stop
;	./libs/i2c_lib.c: 76: uint8_t i2c_send_byte(uint8_t data)
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
;	./libs/i2c_lib.c: 78: I2C_DR -> DR = data; //Отправка данных
	ld	0x5216, a
;	./libs/i2c_lib.c: 79: while(!I2C_SR1 -> TXE)
00103$:
	btjt	0x5217, #7, 00105$
;	./libs/i2c_lib.c: 80: if(I2C_SR2 -> AF)
	btjf	0x5218, #2, 00103$
;	./libs/i2c_lib.c: 81: return 1;
	ld	a, #0x01
	ret
00105$:
;	./libs/i2c_lib.c: 82: return 0;//флаг ответа
	clr	a
;	./libs/i2c_lib.c: 83: }
	ret
;	./libs/i2c_lib.c: 85: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #2
;	./libs/i2c_lib.c: 87: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jreq	00105$
;	./libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
	clrw	x
00107$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00105$
;	./libs/i2c_lib.c: 90: if(i2c_send_byte(data[i]))//Проверка на АСК бит
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	pushw	x
	call	_i2c_send_byte
	popw	x
	tnz	a
	jrne	00105$
;	./libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
	incw	x
	jra	00107$
00105$:
;	./libs/i2c_lib.c: 95: i2c_stop();
	ldw	x, (3, sp)
	ldw	(6, sp), x
	addw	sp, #5
;	./libs/i2c_lib.c: 96: }
	jp	_i2c_stop
;	./libs/i2c_lib.c: 98: uint8_t i2c_scan(void) 
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	./libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
	ld	a, #0x01
	ld	(0x01, sp), a
00105$:
	cp	a, #0x7f
	jrnc	00103$
;	./libs/i2c_lib.c: 102: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
	push	a
	push	#0x00
	call	_i2c_send_address
	ld	(0x03, sp), a
	pop	a
	tnz	(0x02, sp)
	jreq	00102$
;	./libs/i2c_lib.c: 104: i2c_stop();//адрес совпал 
	call	_i2c_stop
;	./libs/i2c_lib.c: 105: return addr;// выход из цикла
	ld	a, (0x01, sp)
	jra	00107$
00102$:
;	./libs/i2c_lib.c: 107: I2C_SR2 -> AF = 0;//очистка флага ошибки
	ldw	x, #0x5218
	push	a
	ld	a, (x)
	and	a, #0xfb
	ld	(x), a
	pop	a
;	./libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
	inc	a
	ld	(0x01, sp), a
	jra	00105$
00103$:
;	./libs/i2c_lib.c: 109: i2c_stop();//совпадений нет выход из функции
	call	_i2c_stop
;	./libs/i2c_lib.c: 110: return 0;
	clr	a
00107$:
;	./libs/i2c_lib.c: 111: }
	addw	sp, #2
	ret
;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
;	-----------------------------------------
;	 function get_bit
;	-----------------------------------------
_get_bit:
;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
	ld	a, (0x04, sp)
	jreq	00113$
00112$:
	sraw	x
	dec	a
	jrne	00112$
00113$:
	srlw	x
	jrnc	00103$
	clrw	x
	incw	x
	.byte 0x21
00103$:
	clrw	x
00104$:
;	./libs/ssd1306_lib.c: 6: }
	popw	y
	addw	sp, #2
	jp	(y)
;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
;	-----------------------------------------
;	 function set_bit
;	-----------------------------------------
_set_bit:
	sub	sp, #4
	ldw	(0x01, sp), x
;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
	clrw	x
	incw	x
	ldw	(0x03, sp), x
	ld	a, (0x08, sp)
	jreq	00114$
00113$:
	sll	(0x04, sp)
	rlc	(0x03, sp)
	dec	a
	jrne	00113$
00114$:
;	./libs/ssd1306_lib.c: 10: switch(value)
	ldw	x, (0x09, sp)
	decw	x
	jrne	00102$
;	./libs/ssd1306_lib.c: 13: data |= mask;
	ld	a, (0x02, sp)
	or	a, (0x04, sp)
	ld	xl, a
	ld	a, (0x01, sp)
	or	a, (0x03, sp)
;	./libs/ssd1306_lib.c: 14: break;
	jra	00103$
;	./libs/ssd1306_lib.c: 16: default:
00102$:
;	./libs/ssd1306_lib.c: 17: data &= ~mask;
	ldw	x, (0x03, sp)
	cplw	x
	ld	a, xl
	and	a, (0x02, sp)
	rlwa	x
	and	a, (0x01, sp)
;	./libs/ssd1306_lib.c: 19: }
00103$:
;	./libs/ssd1306_lib.c: 20: return data;
	ld	xh, a
;	./libs/ssd1306_lib.c: 21: }
	ldw	y, (5, sp)
	addw	sp, #10
	jp	(y)
;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
;	-----------------------------------------
;	 function ssd1306_init
;	-----------------------------------------
_ssd1306_init:
	sub	sp, #27
;	./libs/ssd1306_lib.c: 26: uint8_t setup_buf[27] = {COMMAND, DISPLAY_OFF, 
	ldw	x, sp
	incw	x
	clr	(x)
	ld	a, #0xae
	ld	(0x02, sp), a
	ld	a, #0xd5
	ld	(0x03, sp), a
	ld	a, #0x80
	ld	(0x04, sp), a
	ld	a, #0xa8
	ld	(0x05, sp), a
	ld	a, #0x1f
	ld	(0x06, sp), a
	ld	a, #0xd3
	ld	(0x07, sp), a
	clr	(0x08, sp)
	ld	a, #0x40
	ld	(0x09, sp), a
	ld	a, #0x8d
	ld	(0x0a, sp), a
	ld	a, #0x14
	ld	(0x0b, sp), a
	ld	a, #0xdb
	ld	(0x0c, sp), a
	ld	a, #0x40
	ld	(0x0d, sp), a
	ld	a, #0xa4
	ld	(0x0e, sp), a
	ld	a, #0xa6
	ld	(0x0f, sp), a
	ld	a, #0xda
	ld	(0x10, sp), a
	ld	a, #0x02
	ld	(0x11, sp), a
	ld	a, #0x81
	ld	(0x12, sp), a
	ld	a, #0x8f
	ld	(0x13, sp), a
	ld	a, #0xd9
	ld	(0x14, sp), a
	ld	a, #0xf1
	ld	(0x15, sp), a
	ld	a, #0x20
	ld	(0x16, sp), a
	clr	(0x17, sp)
	ld	a, #0xa0
	ld	(0x18, sp), a
	ld	a, #0xc0
	ld	(0x19, sp), a
	ld	a, #0x1f
	ld	(0x1a, sp), a
	ld	a, #0xaf
	ld	(0x1b, sp), a
;	./libs/ssd1306_lib.c: 43: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buf);
	pushw	x
	push	#0x1b
	ld	a, #0x3c
	call	_i2c_write
;	./libs/ssd1306_lib.c: 44: }
	addw	sp, #27
	ret
;	./libs/ssd1306_lib.c: 46: void ssd1306_set_params_to_write(void)
;	-----------------------------------------
;	 function ssd1306_set_params_to_write
;	-----------------------------------------
_ssd1306_set_params_to_write:
	sub	sp, #7
;	./libs/ssd1306_lib.c: 48: uint8_t set_params_buf[7] = {COMMAND,
	ldw	x, sp
	incw	x
	clr	(x)
	ld	a, #0x22
	ld	(0x02, sp), a
	clr	(0x03, sp)
	ld	a, #0x03
	ld	(0x04, sp), a
	ld	a, #0x21
	ld	(0x05, sp), a
	clr	(0x06, sp)
	ld	a, #0x7f
	ld	(0x07, sp), a
;	./libs/ssd1306_lib.c: 52: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
	pushw	x
	push	#0x07
	ld	a, #0x3c
	call	_i2c_write
;	./libs/ssd1306_lib.c: 53: }
	addw	sp, #7
	ret
;	./libs/ssd1306_lib.c: 55: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
;	-----------------------------------------
;	 function ssd1306_draw_pixel
;	-----------------------------------------
_ssd1306_draw_pixel:
	sub	sp, #8
	ldw	(0x07, sp), x
;	./libs/ssd1306_lib.c: 57: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
	ld	(0x06, sp), a
	clr	(0x05, sp)
	ld	a, (0x0b, sp)
	clr	(0x01, sp)
	ld	xl, a
	rlwa	x
	clr	a
	rrwa	x
	tnzw	x
	jrpl	00103$
	addw	x, #0x0007
00103$:
	sraw	x
	sraw	x
	sraw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	addw	x, (0x05, sp)
	addw	x, (0x07, sp)
	ldw	(0x03, sp), x
	clrw	y
	exg	a, yl
	ld	a, (0x0c, sp)
	exg	a, yl
	and	a, #0x07
	ld	(0x06, sp), a
	clr	(0x05, sp)
	ldw	x, (0x03, sp)
	ld	a, (x)
	clrw	x
	pushw	y
	ldw	y, (0x07, sp)
	pushw	y
	ld	xl, a
	call	_set_bit
	ld	a, xl
	ldw	x, (0x03, sp)
	ld	(x), a
;	./libs/ssd1306_lib.c: 58: }
	ldw	x, (9, sp)
	addw	sp, #12
	jp	(x)
;	./libs/ssd1306_lib.c: 60: void ssd1306_buffer_fill_entire(uint8_t *in_data)
;	-----------------------------------------
;	 function ssd1306_buffer_fill_entire
;	-----------------------------------------
_ssd1306_buffer_fill_entire:
	sub	sp, #141
	ldw	(0x86, sp), x
;	./libs/ssd1306_lib.c: 63: ssd1306_set_params_to_write();
	call	_ssd1306_set_params_to_write
;	./libs/ssd1306_lib.c: 64: uint8_t part[129]={SET_DISPLAY_START_LINE};
	ld	a, #0x40
	ld	(0x01, sp), a
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
;	./libs/ssd1306_lib.c: 66: for(int page = 0;page <= 384;page+=128)
	clrw	x
	ldw	(0x88, sp), x
00111$:
	ldw	x, (0x88, sp)
	cpw	x, #0x0180
	jrsle	00160$
	jp	00113$
00160$:
;	./libs/ssd1306_lib.c: 68: for (int height = 0; height < 8; height++) 
	clrw	x
	ldw	(0x8a, sp), x
00108$:
	ldw	x, (0x8a, sp)
	cpw	x, #0x0008
	jrsge	00102$
;	./libs/ssd1306_lib.c: 70: for (int width = 0; width < 128; width++) 
	ldw	x, (0x8a, sp)
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	addw	x, (0x88, sp)
	ldw	(0x82, sp), x
	clrw	x
	ldw	(0x8c, sp), x
00105$:
	ldw	x, (0x8c, sp)
	cpw	x, #0x0080
	jrsge	00109$
;	./libs/ssd1306_lib.c: 72: ssd1306_draw_pixel(&part[1], width, height, get_bit(in_data[page+(height*16) + (width / 8)], 7 - (width % 8)));
	push	#0x08
	push	#0x00
	ldw	x, (0x8e, sp)
	call	__modsint
	ldw	(0x84, sp), x
	ldw	y, #0x0007
	subw	y, (0x84, sp)
	ldw	x, (0x8c, sp)
	jrpl	00163$
	addw	x, #0x0007
00163$:
	sraw	x
	sraw	x
	sraw	x
	addw	x, (0x82, sp)
	addw	x, (0x86, sp)
	ld	a, (x)
	clrw	x
	pushw	y
	ld	xl, a
	call	_get_bit
	ld	a, (0x8b, sp)
	rlwa	x
	ld	a, (0x8d, sp)
	rrwa	x
	pushw	x
	addw	sp, #1
	push	a
	ld	a, xh
	ldw	x, sp
	addw	x, #4
	call	_ssd1306_draw_pixel
;	./libs/ssd1306_lib.c: 70: for (int width = 0; width < 128; width++) 
	ldw	x, (0x8c, sp)
	incw	x
	ldw	(0x8c, sp), x
	jra	00105$
00109$:
;	./libs/ssd1306_lib.c: 68: for (int height = 0; height < 8; height++) 
	ldw	x, (0x8a, sp)
	incw	x
	ldw	(0x8a, sp), x
	jra	00108$
00102$:
;	./libs/ssd1306_lib.c: 75: i2c_write(I2C_DISPLAY_ADDR, 129, part);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x81
	ld	a, #0x3c
	call	_i2c_write
;	./libs/ssd1306_lib.c: 66: for(int page = 0;page <= 384;page+=128)
	ldw	x, (0x88, sp)
	addw	x, #0x0080
	ldw	(0x88, sp), x
	jp	00111$
00113$:
;	./libs/ssd1306_lib.c: 77: }
	addw	sp, #141
	ret
;	./libs/ssd1306_lib.c: 79: void ssd1306_clean(void)
;	-----------------------------------------
;	 function ssd1306_clean
;	-----------------------------------------
_ssd1306_clean:
	sub	sp, #129
;	./libs/ssd1306_lib.c: 81: uint8_t clean_buf[129] = {SET_DISPLAY_START_LINE};
	ld	a, #0x40
	ld	(0x01, sp), a
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
;	./libs/ssd1306_lib.c: 83: ssd1306_set_params_to_write();
	call	_ssd1306_set_params_to_write
;	./libs/ssd1306_lib.c: 85: for(int i = 0;i<4;i++)
	clr	a
00103$:
	cp	a, #0x04
	jrnc	00105$
;	./libs/ssd1306_lib.c: 86: i2c_write(I2C_DISPLAY_ADDR,129,clean_buf);
	push	a
	ldw	x, sp
	incw	x
	incw	x
	pushw	x
	push	#0x81
	ld	a, #0x3c
	call	_i2c_write
	pop	a
;	./libs/ssd1306_lib.c: 85: for(int i = 0;i<4;i++)
	inc	a
	jra	00103$
00105$:
;	./libs/ssd1306_lib.c: 88: }
	addw	sp, #129
	ret
;	main.c: 3: void setup(void)
;	-----------------------------------------
;	 function setup
;	-----------------------------------------
_setup:
;	main.c: 6: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 9: i2c_init();
	call	_i2c_init
;	main.c: 11: enableInterrupts();
	rim
;	main.c: 12: }
	ret
;	main.c: 14: void gg(void)
;	-----------------------------------------
;	 function gg
;	-----------------------------------------
_gg:
;	main.c: 16: ssd1306_init();
	call	_ssd1306_init
;	main.c: 17: ssd1306_clean();
	call	_ssd1306_clean
;	main.c: 18: ssd1306_buffer_fill_entire(splash);
	ldw	x, #(_splash+0)
;	main.c: 20: }
	jp	_ssd1306_buffer_fill_entire
;	main.c: 22: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 24: setup();
	call	_setup
;	main.c: 25: gg();
	call	_gg
;	main.c: 26: while(1);
00102$:
	jra	00102$
;	main.c: 27: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__splash:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x5c	; 92
	.db #0xed	; 237
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x54	; 84	'T'
	.db #0xa5	; 165
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0xdc	; 220
	.db #0xa5	; 165
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0xd1	; 209
	.db #0x54	; 84	'T'
	.db #0xe5	; 229
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0x7c	; 124
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x38	; 56	'8'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x38	; 56	'8'
	.db #0x66	; 102	'f'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x38	; 56	'8'
	.db #0x66	; 102	'f'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
__xinit__I2C_IRQ:
	.db #0x00	; 0
	.area CABS (ABS)
