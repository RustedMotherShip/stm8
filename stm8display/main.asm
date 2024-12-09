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
	.globl _i2c_read
	.globl _i2c_write
	.globl _i2c_send_address
	.globl _i2c_read_byte
	.globl _i2c_send_byte
	.globl _i2c_stop
	.globl _i2c_start
	.globl _i2c_init
	.globl _i2c_irq
	.globl _uart_read
	.globl _uart_write_byte
	.globl _uart_read_byte
	.globl _uart_init
	.globl _uart_reciever_irq
	.globl _uart_transmission_irq
	.globl _memset
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
	int _i2c_irq ; int19
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
;	libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
;	-----------------------------------------
;	 function i2c_irq
;	-----------------------------------------
_i2c_irq:
	clr	a
	div	x, a
;	libs/i2c_lib.c: 5: disableInterrupts();
	sim
;	libs/i2c_lib.c: 6: memset(&I2C_IRQ, 0, sizeof(I2C_IRQ));
	push	#0x01
	push	#0x00
	clrw	x
	pushw	x
	ldw	x, #(_I2C_IRQ+0)
	call	_memset
;	libs/i2c_lib.c: 7: if(I2C_SR1 -> SB) 
	btjf	0x5217, #0, 00102$
;	libs/i2c_lib.c: 9: I2C_IRQ.SB = 1;
	bset	_I2C_IRQ+0, #0
;	libs/i2c_lib.c: 10: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
00102$:
;	libs/i2c_lib.c: 12: if(I2C_SR1 -> ADDR) 
	btjf	0x5217, #1, 00104$
;	libs/i2c_lib.c: 14: I2C_IRQ.ADDR = 1;
	bset	_I2C_IRQ+0, #1
;	libs/i2c_lib.c: 15: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
00104$:
;	libs/i2c_lib.c: 17: if(I2C_SR1 -> BTF) 
	btjf	0x5217, #2, 00106$
;	libs/i2c_lib.c: 19: I2C_IRQ.BTF = 1;
	bset	_I2C_IRQ+0, #2
;	libs/i2c_lib.c: 20: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
00106$:
;	libs/i2c_lib.c: 22: if(I2C_SR1 -> TXE) 
	btjf	0x5217, #7, 00108$
;	libs/i2c_lib.c: 24: I2C_IRQ.TXE = 1;
	bset	_I2C_IRQ+0, #4
;	libs/i2c_lib.c: 25: I2C_ITR -> ITBUFEN = 0;
	bres	0x521a, #2
00108$:
;	libs/i2c_lib.c: 27: if(I2C_SR1 -> RXNE) 
	btjf	0x5217, #6, 00110$
;	libs/i2c_lib.c: 29: I2C_IRQ.RXNE = 1;
	bset	_I2C_IRQ+0, #3
;	libs/i2c_lib.c: 30: I2C_ITR -> ITBUFEN = 0;
	bres	0x521a, #2
00110$:
;	libs/i2c_lib.c: 32: if(I2C_SR2 -> AF) 
	ldw	x, #0x5218
	ld	a, (x)
	srl	a
	srl	a
	and	a, #0x01
	jreq	00112$
;	libs/i2c_lib.c: 34: I2C_IRQ.AF = 1;
	bset	_I2C_IRQ+0, #5
;	libs/i2c_lib.c: 35: I2C_ITR -> ITERREN = 0;
	ldw	x, #0x521a
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
00112$:
;	libs/i2c_lib.c: 37: enableInterrupts(); 
	rim
;	libs/i2c_lib.c: 39: }
	iret
;	libs/i2c_lib.c: 41: void i2c_init(void)
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	libs/i2c_lib.c: 45: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
	bres	0x5210, #0
;	libs/i2c_lib.c: 46: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0xc0
	or	a, #0x10
	ld	0x5212, a
;	libs/i2c_lib.c: 47: I2C_CCRH -> CCR = 0;// =0
	ld	a, 0x521c
	and	a, #0xf0
	ld	0x521c, a
;	libs/i2c_lib.c: 48: I2C_CCRL -> CCR = 80;// 100kHz for I2C
	mov	0x521b+0, #0x50
;	libs/i2c_lib.c: 49: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
	bres	0x521c, #7
;	libs/i2c_lib.c: 50: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
	bres	0x5214, #7
;	libs/i2c_lib.c: 51: I2C_OARH -> ADDCONF = 1;// see reference manual
	bset	0x5214, #0
;	libs/i2c_lib.c: 52: I2C_CR1 -> PE = 1;// PE=1, enable I2C
	bset	0x5210, #0
;	libs/i2c_lib.c: 53: }
	ret
;	libs/i2c_lib.c: 55: void i2c_start(void)
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	libs/i2c_lib.c: 57: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
	bset	0x521a, #1
;	libs/i2c_lib.c: 58: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
	bset	0x5211, #0
;	libs/i2c_lib.c: 59: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
00101$:
	ld	a, 0x521a
	bcp	a, #2
	jrne	00101$
;	libs/i2c_lib.c: 61: }
	ret
;	libs/i2c_lib.c: 63: void i2c_stop(void)
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	libs/i2c_lib.c: 65: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
	bset	0x5211, #1
;	libs/i2c_lib.c: 66: }
	ret
;	libs/i2c_lib.c: 68: uint8_t i2c_send_byte(unsigned char data)
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
	push	a
	ld	(0x01, sp), a
;	libs/i2c_lib.c: 70: I2C_ITR -> ITBUFEN = 1;
	bset	0x521a, #2
;	libs/i2c_lib.c: 71: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
	bset	0x521a, #1
;	libs/i2c_lib.c: 72: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
	bset	0x521a, #0
;	libs/i2c_lib.c: 73: I2C_DR -> DR = data; //Отправка данных
	ldw	x, #0x5216
	ld	a, (0x01, sp)
	ld	(x), a
;	libs/i2c_lib.c: 74: while(I2C_ITR -> ITBUFEN || I2C_ITR -> ITERREN);
00102$:
	ld	a, 0x521a
	srl	a
	bcp	a, #2
	jrne	00102$
	ld	a, 0x521a
	bcp	a, #0x01
	jrne	00102$
;	libs/i2c_lib.c: 75: return I2C_IRQ.AF;
	ld	a, _I2C_IRQ+0
	swap	a
	srl	a
	and	a, #0x01
;	libs/i2c_lib.c: 76: }
	addw	sp, #1
	ret
;	libs/i2c_lib.c: 78: uint8_t i2c_read_byte(unsigned char *data){
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	libs/i2c_lib.c: 79: while (!(I2C_SR1 -> RXNE));
00101$:
	btjf	0x5217, #6, 00101$
;	libs/i2c_lib.c: 81: return 0;
	clr	a
;	libs/i2c_lib.c: 83: }
	ret
;	libs/i2c_lib.c: 88: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
	ld	yl, a
;	libs/i2c_lib.c: 90: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
	bset	0x521a, #1
;	libs/i2c_lib.c: 91: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
	bset	0x521a, #0
;	libs/i2c_lib.c: 95: address = address << 1;
	ldw	x, y
	sllw	x
;	libs/i2c_lib.c: 92: switch(rw_type)
	ld	a, (0x03, sp)
	dec	a
	jrne	00102$
;	libs/i2c_lib.c: 95: address = address << 1;
	ld	a, xl
;	libs/i2c_lib.c: 96: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	libs/i2c_lib.c: 97: break;
;	libs/i2c_lib.c: 98: default:
;	libs/i2c_lib.c: 99: address = address << 1; // Отправка адреса устройства с битом на запись
;	libs/i2c_lib.c: 101: }
	.byte 0x21
00102$:
	ld	a, xl
00103$:
;	libs/i2c_lib.c: 102: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	libs/i2c_lib.c: 103: I2C_DR -> DR = address;
	ld	0x5216, a
;	libs/i2c_lib.c: 104: while(I2C_ITR -> ITEVTEN || I2C_ITR -> ITERREN);
00105$:
	ld	a, 0x521a
	bcp	a, #2
	jrne	00105$
	ld	a, 0x521a
	bcp	a, #0x01
	jrne	00105$
;	libs/i2c_lib.c: 105: return I2C_IRQ.ADDR;
	ld	a, _I2C_IRQ+0
	srl	a
	and	a, #0x01
;	libs/i2c_lib.c: 106: }
	popw	x
	addw	sp, #1
	jp	(x)
;	libs/i2c_lib.c: 108: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #2
;	libs/i2c_lib.c: 110: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jreq	00105$
;	libs/i2c_lib.c: 112: for(int i = 0;i < size;i++)
	clrw	x
00107$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00105$
;	libs/i2c_lib.c: 114: if(i2c_send_byte(data[i]))//Проверка на АСК бит
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	pushw	x
	call	_i2c_send_byte
	popw	x
	tnz	a
	jrne	00105$
;	libs/i2c_lib.c: 112: for(int i = 0;i < size;i++)
	incw	x
	jra	00107$
00105$:
;	libs/i2c_lib.c: 120: i2c_stop();
	ldw	x, (3, sp)
	ldw	(6, sp), x
	addw	sp, #5
;	libs/i2c_lib.c: 121: }
	jp	_i2c_stop
;	libs/i2c_lib.c: 123: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #2
;	libs/i2c_lib.c: 124: I2C_CR2 -> ACK = 1;
	ldw	x, #0x5211
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	libs/i2c_lib.c: 125: if(i2c_send_address(dev_addr,1))
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	libs/i2c_lib.c: 126: for(int i = 0;i < size;i++)
	clrw	x
00105$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00103$
;	libs/i2c_lib.c: 128: i2c_read_byte((unsigned char *)data[i]);
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	clrw	y
	ld	yl, a
	pushw	x
	ldw	x, y
	call	_i2c_read_byte
	popw	x
;	libs/i2c_lib.c: 126: for(int i = 0;i < size;i++)
	incw	x
	jra	00105$
00103$:
;	libs/i2c_lib.c: 130: I2C_CR2 -> ACK = 0;
	ld	a, 0x5211
	and	a, #0xfb
	ld	0x5211, a
;	libs/i2c_lib.c: 131: }
	ldw	x, (3, sp)
	addw	sp, #7
	jp	(x)
;	libs/i2c_lib.c: 132: uint8_t i2c_scan(void) 
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	libs/i2c_lib.c: 134: for (uint8_t addr = 1; addr < 127; addr++)
	ld	a, #0x01
	ld	(0x01, sp), a
	ld	(0x02, sp), a
00105$:
	ld	a, (0x02, sp)
	cp	a, #0x7f
	jrnc	00103$
;	libs/i2c_lib.c: 136: if(i2c_send_address(addr, 0))
	push	#0x00
	ld	a, (0x03, sp)
	call	_i2c_send_address
	tnz	a
	jreq	00102$
;	libs/i2c_lib.c: 138: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 139: return addr;
	ld	a, (0x01, sp)
	jra	00107$
00102$:
;	libs/i2c_lib.c: 141: I2C_SR2 -> AF = 0;
	bres	0x5218, #2
;	libs/i2c_lib.c: 142: uart_write("error addr\n"); //Очистка флага ошибки
	ldw	x, #(___str_4+0)
	call	_uart_write
;	libs/i2c_lib.c: 134: for (uint8_t addr = 1; addr < 127; addr++)
	inc	(0x02, sp)
	ld	a, (0x02, sp)
	ld	(0x01, sp), a
	jra	00105$
00103$:
;	libs/i2c_lib.c: 144: i2c_stop();
	call	_i2c_stop
;	libs/i2c_lib.c: 145: return 0;
	clr	a
00107$:
;	libs/i2c_lib.c: 146: }
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
	sub	sp, #2
;	main.c: 14: setup();
	call	_setup
;	main.c: 20: buf[0] = 0xA4;
	ldw	x, sp
	incw	x
	ld	a, #0xa4
	ld	(x), a
;	main.c: 21: buf[1] = 0xA5;
	ld	a, #0xa5
	ld	(0x02, sp), a
;	main.c: 22: i2c_write(I2C_DISPLAY_ADDR,2,buf);
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	main.c: 23: while(1);
00102$:
	jra	00102$
;	main.c: 34: }
	addw	sp, #2
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
	.area CONST
___str_4:
	.ascii "error addr"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
__xinit__I2C_IRQ:
	.db 0x00
	.area CABS (ABS)
