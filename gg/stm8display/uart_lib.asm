;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module uart_lib
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
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
;	libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
;	-----------------------------------------
;	 function uart_reciever_irq
;	-----------------------------------------
_uart_reciever_irq:
	push	a
;	libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
	ld	a, 0x5230
	swap	a
	srl	a
	bcp	a, #0x01
	jreq	00107$
;	libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
	ld	a, 0x5231
;	libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
	ld	(0x01, sp), a
	cp	a, #0x0a
	jreq	00102$
	ld	a, _buf_pos+0
	cp	a, _buf_size+0
	jrnc	00102$
;	libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
	ld	a, _buf_pos+0
	inc	_buf_pos+0
	clrw	x
	ld	xl, a
	addw	x, _rx_buf_pointer+0
	ld	a, (0x01, sp)
	ld	(x), a
	jra	00107$
00102$:
;	libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
	bres	0x5235, #5
00107$:
;	libs/uart_lib.c: 30: }
	pop	a
	iret
;	libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_write_irq
;	-----------------------------------------
_uart_write_irq:
	sub	sp, #2
;	libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
	ldw	(0x01, sp), x
	ldw	_tx_buf_pointer+0, x
;	libs/uart_lib.c: 35: buf_pos = 0;
	clr	_buf_pos+0
;	libs/uart_lib.c: 36: buf_size = 0;
	clr	_buf_size+0
;	libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
00101$:
	ld	a, _buf_size+0
	inc	_buf_size+0
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	jrne	00101$
;	libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
	bset	0x5235, #7
;	libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
00104$:
	btjt	0x5235, #7, 00104$
;	libs/uart_lib.c: 40: }
	addw	sp, #2
	ret
;	libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
;	-----------------------------------------
;	 function uart_read_irq
;	-----------------------------------------
_uart_read_irq:
;	libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
	ldw	_rx_buf_pointer+0, x
;	libs/uart_lib.c: 44: buf_pos = 0;
	clr	_buf_pos+0
;	libs/uart_lib.c: 45: buf_size = size;
	ld	a, (0x04, sp)
	ld	_buf_size+0, a
;	libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
	bset	0x5235, #5
;	libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
00101$:
	ld	a, 0x5235
	swap	a
	srl	a
	and	a, #0x01
	jrne	00101$
;	libs/uart_lib.c: 48: }
	ldw	x, (1, sp)
	addw	sp, #4
	jp	(x)
;	libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
	sub	sp, #2
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
	pop	a
;	libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
	ldw	x, #0x5235
	push	a
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	pop	a
;	libs/uart_lib.c: 56: switch(stopbit)
	cp	a, #0x02
	jreq	00101$
	cp	a, #0x03
	jreq	00102$
	jra	00103$
;	libs/uart_lib.c: 58: case 2:
00101$:
;	libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
	ld	a, 0x5236
	and	a, #0xcf
	or	a, #0x20
	ld	0x5236, a
;	libs/uart_lib.c: 60: break;
	jra	00104$
;	libs/uart_lib.c: 61: case 3:
00102$:
;	libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
	ld	a, 0x5236
	or	a, #0x30
	ld	0x5236, a
;	libs/uart_lib.c: 63: break;
	jra	00104$
;	libs/uart_lib.c: 64: default:
00103$:
;	libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
	ld	a, 0x5236
	and	a, #0xcf
	ld	0x5236, a
;	libs/uart_lib.c: 67: }
00104$:
;	libs/uart_lib.c: 68: switch(baudrate)
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
;	libs/uart_lib.c: 70: case (unsigned int)2400:
00105$:
;	libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
	ld	a, 0x5233
	and	a, #0x0f
	or	a, #0x10
	ld	0x5233, a
;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
	mov	0x5232+0, #0xa0
;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	libs/uart_lib.c: 74: break;
	jra	00114$
;	libs/uart_lib.c: 75: case (unsigned int)19200:
00106$:
;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
	mov	0x5232+0, #0x34
;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	libs/uart_lib.c: 78: break;
	jra	00114$
;	libs/uart_lib.c: 79: case (unsigned int)57600:
00107$:
;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
	mov	0x5232+0, #0x11
;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x06
	ld	0x5233, a
;	libs/uart_lib.c: 82: break;
	jra	00114$
;	libs/uart_lib.c: 83: case (unsigned int)115200:
00108$:
;	libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
	mov	0x5232+0, #0x08
;	libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x0b
	ld	0x5233, a
;	libs/uart_lib.c: 86: break;
	jra	00114$
;	libs/uart_lib.c: 87: case (unsigned int)230400:
00109$:
;	libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
	mov	0x5232+0, #0x04
;	libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x05
	ld	0x5233, a
;	libs/uart_lib.c: 90: break;
	jra	00114$
;	libs/uart_lib.c: 91: case (unsigned int)460800:
00110$:
;	libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
	mov	0x5232+0, #0x02
;	libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	libs/uart_lib.c: 94: break;
	jra	00114$
;	libs/uart_lib.c: 95: case (unsigned int)921600:
00111$:
;	libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
	mov	0x5232+0, #0x01
;	libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x01
	ld	0x5233, a
;	libs/uart_lib.c: 98: break;
	jra	00114$
;	libs/uart_lib.c: 99: default:
00112$:
;	libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
	mov	0x5232+0, #0x68
;	libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
	ld	a, 0x5233
	and	a, #0xf0
	or	a, #0x03
	ld	0x5233, a
;	libs/uart_lib.c: 103: }
00114$:
;	libs/uart_lib.c: 104: }
	addw	sp, #2
	ret
;	libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
;	-----------------------------------------
;	 function uart_read_byte
;	-----------------------------------------
_uart_read_byte:
;	libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
00101$:
	btjf	0x5230, #5, 00101$
;	libs/uart_lib.c: 110: return 1;
	clrw	x
	incw	x
;	libs/uart_lib.c: 111: }
	ret
;	libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
;	-----------------------------------------
;	 function uart_write_byte
;	-----------------------------------------
_uart_write_byte:
;	libs/uart_lib.c: 115: UART1_DR -> DR = data;
	ld	0x5231, a
;	libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
00101$:
	btjf	0x5230, #7, 00101$
;	libs/uart_lib.c: 117: return 1;
	clrw	x
	incw	x
;	libs/uart_lib.c: 118: }
	ret
;	libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #4
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 122: int count = 0;
	clrw	x
	ldw	(0x03, sp), x
;	libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	clrw	x
00103$:
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (y)
	jreq	00101$
;	libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
	pushw	x
	call	_uart_write_byte
	exgw	x, y
	popw	x
	addw	y, (0x03, sp)
	ldw	(0x03, sp), y
;	libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	incw	x
	jra	00103$
00101$:
;	libs/uart_lib.c: 125: return count;
	ldw	x, (0x03, sp)
;	libs/uart_lib.c: 126: }
	addw	sp, #4
	ret
;	libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
	sub	sp, #4
	ldw	(0x01, sp), x
;	libs/uart_lib.c: 130: int count = 0;
	clrw	x
	ldw	(0x03, sp), x
;	libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	clrw	x
00103$:
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (y)
	jreq	00101$
;	libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
	clrw	y
	ld	yl, a
	pushw	x
	ldw	x, y
	call	_uart_read_byte
	exgw	x, y
	popw	x
	addw	y, (0x03, sp)
	ldw	(0x03, sp), y
;	libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
	incw	x
	jra	00103$
00101$:
;	libs/uart_lib.c: 133: return count;
	ldw	x, (0x03, sp)
;	libs/uart_lib.c: 134: }
	addw	sp, #4
	popw	y
	addw	sp, #2
	jp	(y)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
