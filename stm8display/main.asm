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
	.globl _setup
	.globl _i2c_scan
	.globl _i2c_write
	.globl _i2c_send_byte
	.globl _i2c_read
	.globl _i2c_read_byte
	.globl _i2c_send_address
	.globl _i2c_stop
	.globl _i2c_start
	.globl _i2c_init
	.globl _uart_read
	.globl _uart_write_byte
	.globl _uart_read_byte
	.globl _uart_init
	.globl _uart_reciever_irq
	.globl _uart_transmission_irq
	.globl _I2C_IRQ
	.globl _buf_size
	.globl _buf_pos
	.globl _rx_buf_pointer
	.globl _tx_buf_pointer
	.globl _uart_write
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
;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
;	-----------------------------------------
;	 function uart_transmission_irq
;	-----------------------------------------
_uart_transmission_irq:
;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
	ldw	x, #0x5230
	ld	a, (x)
	swap	a
	srl	a
	srl	a
	srl	a
	bcp	a, #0x01
	jreq	00107$
;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
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
;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
	ld	a, _buf_pos+0
	inc	_buf_pos+0
	clrw	x
	ld	xl, a
	addw	x, _tx_buf_pointer+0
	ld	a, (x)
	ld	0x5231, a
	jra	00107$
00102$:
;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
	bres	0x5235, #7
00107$:
;	libs/uart_lib.c: 14: }
	iret
;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
;	-----------------------------------------
;	 function uart_reciever_irq
;	-----------------------------------------
_uart_reciever_irq:
	push	a
;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
	ld	a, 0x5230
	swap	a
	srl	a
	bcp	a, #0x01
	jreq	00107$
;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
	ld	a, 0x5231
;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
	ld	(0x01, sp), a
	cp	a, #0x0a
	jreq	00102$
	ld	a, _buf_pos+0
	cp	a, _buf_size+0
	jrnc	00102$
;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
	ld	a, _buf_pos+0
	inc	_buf_pos+0
	clrw	x
	ld	xl, a
	addw	x, _rx_buf_pointer+0
	ld	a, (0x01, sp)
	ld	(x), a
	jra	00107$
00102$:
;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
	bres	0x5235, #5
00107$:
;	libs/uart_lib.c: 29: }
	pop	a
	iret
;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
	sub	sp, #2
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
	pop	a
;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	libs/uart_lib.c: 36: switch(stopbit)
	cp	a, #0x02
	jreq	00101$
	cp	a, #0x03
	jreq	00102$
	jra	00103$
;	libs/uart_lib.c: 38: case 2:
00101$:
;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
	ld	a, 0x5236
	and	a, #0xcf
	or	a, #0x20
	ld	0x5236, a
;	libs/uart_lib.c: 40: break;
	jra	00104$
;	libs/uart_lib.c: 41: case 3:
00102$:
;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
	ld	a, 0x5236
	or	a, #0x30
	ld	0x5236, a
;	libs/uart_lib.c: 43: break;
	jra	00104$
;	libs/uart_lib.c: 44: default:
00103$:
;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	libs/uart_lib.c: 47: }
00104$:
;	libs/uart_lib.c: 48: switch(baudrate)
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
;	libs/uart_lib.c: 50: case (unsigned int)2400:
00105$:
;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
	ld	a, 0x5233
	and	a, #0x0f
	or	a, #0x10
	ld	0x5233, a
;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
	mov	0x5232+0, #0xa0
;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	libs/uart_lib.c: 54: break;
	jra	00114$
;	libs/uart_lib.c: 55: case (unsigned int)19200:
00106$:
;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
	mov	0x5232+0, #0x34
;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	libs/uart_lib.c: 58: break;
	jra	00114$
;	libs/uart_lib.c: 59: case (unsigned int)57600:
00107$:
;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
	mov	0x5232+0, #0x11
;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x06
	ld	0x5233, a
;	libs/uart_lib.c: 62: break;
	jra	00114$
;	libs/uart_lib.c: 63: case (unsigned int)115200:
00108$:
;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
	mov	0x5232+0, #0x08
;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	libs/uart_lib.c: 66: break;
	jra	00114$
;	libs/uart_lib.c: 67: case (unsigned int)230400:
00109$:
;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
	mov	0x5232+0, #0x04
;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x05
	ld	0x5233, a
;	libs/uart_lib.c: 70: break;
	jra	00114$
;	libs/uart_lib.c: 71: case (unsigned int)460800:
00110$:
;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
	mov	0x5232+0, #0x02
;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	libs/uart_lib.c: 74: break;
	jra	00114$
;	libs/uart_lib.c: 75: case (unsigned int)921600:
00111$:
;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
	mov	0x5232+0, #0x01
;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	libs/uart_lib.c: 78: break;
	jra	00114$
;	libs/uart_lib.c: 79: default:
00112$:
;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
	mov	0x5232+0, #0x68
;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	libs/uart_lib.c: 83: }
00114$:
;	libs/uart_lib.c: 84: }
	addw	sp, #2
	ret
;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
;	-----------------------------------------
;	 function uart_read_byte
;	-----------------------------------------
_uart_read_byte:
;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
00101$:
	btjf	0x5230, #5, 00101$
;	libs/uart_lib.c: 90: return 1;
	clrw	x
	incw	x
;	libs/uart_lib.c: 91: }
	ret
;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
;	-----------------------------------------
;	 function uart_write_byte
;	-----------------------------------------
_uart_write_byte:
;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
	ld	0x5231, a
;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
00101$:
	btjf	0x5230, #7, 00101$
;	libs/uart_lib.c: 97: return 1;
	clrw	x
	incw	x
;	libs/uart_lib.c: 98: }
	ret
;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #2
;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
	ldw	(0x01, sp), x
	ldw	_tx_buf_pointer+0, x
;	libs/uart_lib.c: 103: buf_pos = 0;
	clr	_buf_pos+0
;	libs/uart_lib.c: 104: buf_size = 0;
	clr	_buf_size+0
;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
00101$:
	ld	a, _buf_size+0
	inc	_buf_size+0
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	jrne	00101$
;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
	bset	0x5235, #7
;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
00104$:
	btjt	0x5235, #7, 00104$
;	libs/uart_lib.c: 108: }
	addw	sp, #2
	ret
;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
	ldw	_rx_buf_pointer+0, x
;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
	ldw	x, #(___str_0+0)
	call	_uart_write
;	libs/uart_lib.c: 113: buf_pos = 0;
	clr	_buf_pos+0
;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
	ldw	x, #(___str_1+0)
	call	_uart_write
;	libs/uart_lib.c: 115: buf_size = size;
	ld	a, (0x04, sp)
	ld	_buf_size+0, a
;	libs/uart_lib.c: 116: uart_write("buf_size\n");
	ldw	x, #(___str_2+0)
	call	_uart_write
;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
	bset	0x5235, #5
;	libs/uart_lib.c: 118: uart_write("RIEN\n");
	ldw	x, #(___str_3+0)
	call	_uart_write
;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
00101$:
	ld	a, 0x5235
	swap	a
	srl	a
	and	a, #0x01
	jrne	00101$
;	libs/uart_lib.c: 120: }
	ldw	x, (1, sp)
	addw	sp, #4
	jp	(x)
;	libs/i2c_lib.c: 3: void i2c_init(void)
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	libs/i2c_lib.c: 7: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
	bres	0x5210, #0
;	libs/i2c_lib.c: 8: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0xc0
	or	a, #0x10
	ld	0x5212, a
;	libs/i2c_lib.c: 9: I2C_CCRH -> CCR = 0;// =0
	ld	a, 0x521c
	and	a, #0xf0
	ld	0x521c, a
;	libs/i2c_lib.c: 10: I2C_CCRL -> CCR = 80;// 100kHz for I2C
	mov	0x521b+0, #0x50
;	libs/i2c_lib.c: 11: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
	bres	0x521c, #7
;	libs/i2c_lib.c: 12: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
	bres	0x5214, #7
;	libs/i2c_lib.c: 13: I2C_OARH -> ADDCONF = 1;// see reference manual
	bset	0x5214, #0
;	libs/i2c_lib.c: 14: I2C_CR1 -> PE = 1;// PE=1, enable I2C
	bset	0x5210, #0
;	libs/i2c_lib.c: 15: }
	ret
;	libs/i2c_lib.c: 17: void i2c_start(void)
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	libs/i2c_lib.c: 19: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
	bset	0x5211, #0
;	libs/i2c_lib.c: 20: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
00101$:
	btjf	0x5217, #0, 00101$
;	libs/i2c_lib.c: 21: }
	ret
;	libs/i2c_lib.c: 23: void i2c_stop(void)
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	libs/i2c_lib.c: 25: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
	bset	0x5211, #1
;	libs/i2c_lib.c: 26: }
	ret
;	libs/i2c_lib.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	libs/i2c_lib.c: 33: address = address << 1;
	sll	a
;	libs/i2c_lib.c: 30: switch(rw_type)
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00102$
;	libs/i2c_lib.c: 33: address = address << 1;
;	libs/i2c_lib.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	libs/i2c_lib.c: 35: break;
;	libs/i2c_lib.c: 36: default:
;	libs/i2c_lib.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
;	libs/i2c_lib.c: 39: }
00102$:
;	libs/i2c_lib.c: 40: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	libs/i2c_lib.c: 41: I2C_DR -> DR = address;
	ld	0x5216, a
;	libs/i2c_lib.c: 42: while(!I2C_SR1 -> ADDR)
00106$:
	ldw	x, #0x5217
	ld	a, (x)
	srl	a
	and	a, #0x01
	jrne	00108$
;	libs/i2c_lib.c: 43: if(I2C_SR2 -> AF)
	btjf	0x5218, #2, 00106$
;	libs/i2c_lib.c: 44: return 0;
	clr	a
	jra	00109$
00108$:
;	libs/i2c_lib.c: 45: clr_sr1();
	ld	a,0x5217
;	libs/i2c_lib.c: 46: clr_sr3();
	ld	a,0x5219
;	libs/i2c_lib.c: 47: return 1;
	ld	a, #0x01
00109$:
;	libs/i2c_lib.c: 48: }
	popw	x
	addw	sp, #1
	jp	(x)
;	libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void){
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	libs/i2c_lib.c: 51: while(!I2C_SR1 -> RXNE);
00101$:
	btjf	0x5217, #6, 00101$
;	libs/i2c_lib.c: 52: return I2C_DR -> DR;
	ld	a, 0x5216
;	libs/i2c_lib.c: 53: }
	ret
;	libs/i2c_lib.c: 55: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #4
;	libs/i2c_lib.c: 57: if(i2c_send_address(dev_addr, 1))//проверка на ACK
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	libs/i2c_lib.c: 59: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
	bset	0x5211, #2
;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
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
;	libs/i2c_lib.c: 62: data[i] = i2c_read_byte();//функция записи байта в элемент массива
	ldw	x, (0x08, sp)
	addw	x, (0x03, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00105$
00101$:
;	libs/i2c_lib.c: 64: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
	bres	0x5211, #2
;	libs/i2c_lib.c: 65: uart_write_byte(0x00);
	clr	a
	call	_uart_write_byte
;	libs/i2c_lib.c: 66: data[size-1] = i2c_read_byte();
	ldw	x, (0x08, sp)
	addw	x, (0x01, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	libs/i2c_lib.c: 67: uart_write_byte(0x01);
	ld	a, #0x01
	call	_uart_write_byte
;	libs/i2c_lib.c: 68: i2c_stop();
	call	_i2c_stop
00103$:
;	libs/i2c_lib.c: 70: uart_write_byte(0x02);
	ld	a, #0x02
	call	_uart_write_byte
;	libs/i2c_lib.c: 71: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 72: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 73: uart_write_byte(0x03); 
	ld	a, #0x03
	ldw	x, (5, sp)
	ldw	(8, sp), x
	addw	sp, #7
;	libs/i2c_lib.c: 74: }
	jp	_uart_write_byte
;	libs/i2c_lib.c: 76: uint8_t i2c_send_byte(uint8_t data)
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
;	libs/i2c_lib.c: 78: I2C_DR -> DR = data; //Отправка данных
	ld	0x5216, a
;	libs/i2c_lib.c: 79: while(!I2C_SR1 -> TXE)
00103$:
	btjt	0x5217, #7, 00105$
;	libs/i2c_lib.c: 80: if(I2C_SR2 -> AF)
	btjf	0x5218, #2, 00103$
;	libs/i2c_lib.c: 81: return 0;
	clr	a
	ret
00105$:
;	libs/i2c_lib.c: 82: return 1;//флаг ответа
	ld	a, #0x01
;	libs/i2c_lib.c: 83: }
	ret
;	libs/i2c_lib.c: 85: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #2
;	libs/i2c_lib.c: 87: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jreq	00105$
;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
	clrw	x
00107$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00105$
;	libs/i2c_lib.c: 90: if(i2c_send_byte(data[i]))//Проверка на АСК бит
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	pushw	x
	call	_i2c_send_byte
	popw	x
	tnz	a
	jrne	00105$
;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
	incw	x
	jra	00107$
00105$:
;	libs/i2c_lib.c: 95: i2c_stop();
	ldw	x, (3, sp)
	ldw	(6, sp), x
	addw	sp, #5
;	libs/i2c_lib.c: 96: }
	jp	_i2c_stop
;	libs/i2c_lib.c: 98: uint8_t i2c_scan(void) 
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
	ld	a, #0x01
	ld	(0x01, sp), a
00105$:
	cp	a, #0x7f
	jrnc	00103$
;	libs/i2c_lib.c: 102: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
	push	a
	push	#0x00
	call	_i2c_send_address
	ld	(0x03, sp), a
	pop	a
	tnz	(0x02, sp)
	jreq	00102$
;	libs/i2c_lib.c: 104: i2c_stop();//адрес совпал 
	call	_i2c_stop
;	libs/i2c_lib.c: 105: return addr;// выход из цикла
	ld	a, (0x01, sp)
	jra	00107$
00102$:
;	libs/i2c_lib.c: 107: I2C_SR2 -> AF = 0;//очистка флага ошибки
	ldw	x, #0x5218
	push	a
	ld	a, (x)
	and	a, #0xfb
	ld	(x), a
	pop	a
;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
	inc	a
	ld	(0x01, sp), a
	jra	00105$
00103$:
;	libs/i2c_lib.c: 109: i2c_stop();//совпадений нет выход из функции
	call	_i2c_stop
;	libs/i2c_lib.c: 110: return 0;
	clr	a
00107$:
;	libs/i2c_lib.c: 111: }
	addw	sp, #2
	ret
;	main.c: 2: void setup(void)
;	-----------------------------------------
;	 function setup
;	-----------------------------------------
_setup:
;	main.c: 5: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 7: uart_init(9600,0);
	clr	a
	ldw	x, #0x2580
	call	_uart_init
;	main.c: 8: i2c_init();
	call	_i2c_init
;	main.c: 10: enableInterrupts();
	rim
;	main.c: 11: }
	ret
;	main.c: 12: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #132
;	main.c: 14: setup();
	call	_setup
;	main.c: 15: uint8_t buf[5] = {0};
	ldw	x, sp
	incw	x
	clr	(x)
	clr	(0x02, sp)
	clr	(0x03, sp)
	clr	(0x04, sp)
	clr	(0x05, sp)
;	main.c: 16: uint8_t buf1[127] = {0};
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
;	main.c: 18: buf[0] = 0xAF;
	ld	a, #0xaf
	ld	(x), a
;	main.c: 19: buf[1] = 0x00;
	clr	(0x02, sp)
;	main.c: 20: buf[2] = 0xA6;
	ld	a, #0xa6
	ld	(0x03, sp), a
;	main.c: 21: buf[3] = 0xA7;
	ld	a, #0xa7
	ld	(0x04, sp), a
;	main.c: 22: buf[4] = 0xA8;
	ld	a, #0xa8
	ld	(0x05, sp), a
;	main.c: 23: i2c_write(I2C_DISPLAY_ADDR,2,buf);
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	main.c: 30: i2c_read(I2C_DISPLAY_ADDR,12,buf1);
	ldw	x, sp
	addw	x, #6
	pushw	x
	push	#0x0c
	ld	a, #0x3c
	call	_i2c_read
;	main.c: 31: while(1);
00102$:
	jra	00102$
;	main.c: 32: }
	addw	sp, #132
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "rx_buf_pointer"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "buf_pos"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "buf_size"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "RIEN"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
__xinit__I2C_IRQ:
	.db #0x00	; 0
	.area CABS (ABS)
