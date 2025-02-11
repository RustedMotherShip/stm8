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
	.globl _params_default_conf
	.globl _tmr2_irq
	.globl _menu_set_paragraph
	.globl _menu_set_item_menu
	.globl _menu_set_params_value
	.globl _menu_border_item
	.globl _menu_border_paragraph
	.globl _menu_border
	.globl _ssd1306_send_buffer
	.globl _ssd1306_buffer_clean
	.globl _set_bit
	.globl _get_bit
	.globl _i2c_irq
	.globl _memset
	.globl _TIM2_IRQ
	.globl _main_buffer
	.globl _ttf_line_down
	.globl _ttf_line_up
	.globl _ttf_line_left
	.globl _ttf_line_right
	.globl _ttf_corner_right_down
	.globl _ttf_corner_left_down
	.globl _ttf_corner_right_up
	.globl _ttf_corner_left_up
	.globl _ttf_num_0
	.globl _ttf_num_9
	.globl _ttf_num_8
	.globl _ttf_num_7
	.globl _ttf_num_6
	.globl _ttf_num_5
	.globl _ttf_num_4
	.globl _ttf_num_3
	.globl _ttf_num_2
	.globl _ttf_num_1
	.globl _ttf_void
	.globl _I2C_IRQ
	.globl _ttf_eng_z
	.globl _ttf_eng_y
	.globl _ttf_eng_x
	.globl _ttf_eng_w
	.globl _ttf_eng_v
	.globl _ttf_eng_u
	.globl _ttf_eng_t
	.globl _ttf_eng_s
	.globl _ttf_eng_r
	.globl _ttf_eng_q
	.globl _ttf_eng_p
	.globl _ttf_eng_o
	.globl _ttf_eng_n
	.globl _ttf_eng_m
	.globl _ttf_eng_l
	.globl _ttf_eng_k
	.globl _ttf_eng_j
	.globl _ttf_eng_i
	.globl _ttf_eng_h
	.globl _ttf_eng_g
	.globl _ttf_eng_f
	.globl _ttf_eng_e
	.globl _ttf_eng_d
	.globl _ttf_eng_c
	.globl _ttf_eng_b
	.globl _ttf_eng_a
	.globl _params_value
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
	.globl _i2c_start_irq
	.globl _i2c_stop_irq
	.globl _ssd1306_init
	.globl _ssd1306_set_params_to_write
	.globl _ssd1306_draw_pixel
	.globl _ssd1306_buffer_write
	.globl _ssd1306_clean
	.globl _delay_s
	.globl _delay_ms
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
_params_value::
	.ds 8
_menu_set_params_value_numbers_10000_171:
	.ds 20
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_ttf_eng_a::
	.ds 8
_ttf_eng_b::
	.ds 8
_ttf_eng_c::
	.ds 8
_ttf_eng_d::
	.ds 8
_ttf_eng_e::
	.ds 8
_ttf_eng_f::
	.ds 8
_ttf_eng_g::
	.ds 8
_ttf_eng_h::
	.ds 8
_ttf_eng_i::
	.ds 8
_ttf_eng_j::
	.ds 8
_ttf_eng_k::
	.ds 8
_ttf_eng_l::
	.ds 8
_ttf_eng_m::
	.ds 8
_ttf_eng_n::
	.ds 8
_ttf_eng_o::
	.ds 8
_ttf_eng_p::
	.ds 8
_ttf_eng_q::
	.ds 8
_ttf_eng_r::
	.ds 8
_ttf_eng_s::
	.ds 8
_ttf_eng_t::
	.ds 8
_ttf_eng_u::
	.ds 8
_ttf_eng_v::
	.ds 8
_ttf_eng_w::
	.ds 8
_ttf_eng_x::
	.ds 8
_ttf_eng_y::
	.ds 8
_ttf_eng_z::
	.ds 8
_I2C_IRQ::
	.ds 1
_ttf_void::
	.ds 8
_ttf_num_1::
	.ds 8
_ttf_num_2::
	.ds 8
_ttf_num_3::
	.ds 8
_ttf_num_4::
	.ds 8
_ttf_num_5::
	.ds 8
_ttf_num_6::
	.ds 8
_ttf_num_7::
	.ds 8
_ttf_num_8::
	.ds 8
_ttf_num_9::
	.ds 8
_ttf_num_0::
	.ds 8
_ttf_corner_left_up::
	.ds 8
_ttf_corner_right_up::
	.ds 8
_ttf_corner_left_down::
	.ds 8
_ttf_corner_right_down::
	.ds 8
_ttf_line_right::
	.ds 8
_ttf_line_left::
	.ds 8
_ttf_line_up::
	.ds 8
_ttf_line_down::
	.ds 8
_main_buffer::
	.ds 512
_TIM2_IRQ::
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
	int _tmr2_irq ; int13
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
;	./libs/menu_lib.c: 63: static uint8_t *numbers[] = {&ttf_num_0[0],&ttf_num_1[0],&ttf_num_2[0],&ttf_num_3[0],&ttf_num_4[0],&ttf_num_5[0],&ttf_num_6[0],&ttf_num_7[0],&ttf_num_8[0],&ttf_num_9[0]};
	ldw	x, #_ttf_num_0+0
	ldw	_menu_set_params_value_numbers_10000_171+0, x
	ldw	x, #_ttf_num_1+0
	ldw	_menu_set_params_value_numbers_10000_171+2, x
	ldw	x, #_ttf_num_2+0
	ldw	_menu_set_params_value_numbers_10000_171+4, x
	ldw	x, #_ttf_num_3+0
	ldw	_menu_set_params_value_numbers_10000_171+6, x
	ldw	x, #_ttf_num_4+0
	ldw	_menu_set_params_value_numbers_10000_171+8, x
	ldw	x, #_ttf_num_5+0
	ldw	_menu_set_params_value_numbers_10000_171+10, x
	ldw	x, #_ttf_num_6+0
	ldw	_menu_set_params_value_numbers_10000_171+12, x
	ldw	x, #_ttf_num_7+0
	ldw	_menu_set_params_value_numbers_10000_171+14, x
	ldw	x, #_ttf_num_8+0
	ldw	_menu_set_params_value_numbers_10000_171+16, x
	ldw	x, #_ttf_num_9+0
	ldw	_menu_set_params_value_numbers_10000_171+18, x
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
;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
;	-----------------------------------------
;	 function i2c_irq
;	-----------------------------------------
_i2c_irq:
	clr	a
	div	x, a
;	./libs/i2c_lib.c: 6: disableInterrupts();
	sim
;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
	mov	_I2C_IRQ+0, #0x00
;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
	ldw	x, #0x5217
	ld	a, (x)
	srl	a
	and	a, #0x01
	jreq	00102$
;	./libs/i2c_lib.c: 11: clr_sr1();
	ld	a,0x5217
;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
	bset	_I2C_IRQ+0, #1
;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
	ld	a,0x5219
;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
	ld	a, #0xe1
	call	_uart_write_byte
;	./libs/i2c_lib.c: 16: return;
	jp	00113$
00102$:
;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
	ld	a, 0x5217
	swap	a
	srl	a
	srl	a
	srl	a
	bcp	a, #0x01
	jreq	00104$
;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
	bset	_I2C_IRQ+0, #4
;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
	bres	0x521a, #2
;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
	bres	0x521a, #0
;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
	ld	a, #0xea
	call	_uart_write_byte
;	./libs/i2c_lib.c: 26: return;
	jra	00113$
00104$:
;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
	ld	a, 0x5217
	swap	a
	srl	a
	srl	a
	bcp	a, #0x01
	jreq	00106$
;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
	bset	_I2C_IRQ+0, #3
;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
	bres	0x521a, #2
;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
	bres	0x521a, #0
;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
	ld	a, #0xeb
	call	_uart_write_byte
;	./libs/i2c_lib.c: 35: return;
	jra	00113$
00106$:
;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
	ld	a, 0x5217
	bcp	a, #0x01
	jreq	00108$
;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
	bset	_I2C_IRQ+0, #0
;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
	ld	a, #0xe2
	call	_uart_write_byte
;	./libs/i2c_lib.c: 43: return;
	jra	00113$
00108$:
;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
	ld	a, 0x5217
	srl	a
	srl	a
	bcp	a, #0x01
	jreq	00110$
;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
	bset	_I2C_IRQ+0, #2
;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
	ld	a, #0xe3
	call	_uart_write_byte
;	./libs/i2c_lib.c: 50: return;
	jra	00113$
00110$:
;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
	ldw	x, #0x5218
	ld	a, (x)
	srl	a
	srl	a
	and	a, #0x01
	jreq	00112$
;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
	bset	_I2C_IRQ+0, #5
;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
	bres	0x521a, #1
;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
	bres	0x521a, #0
;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
	bres	0x521a, #2
;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
	ld	a, #0xee
	call	_uart_write_byte
;	./libs/i2c_lib.c: 60: return;
	jra	00113$
00112$:
;	./libs/i2c_lib.c: 63: enableInterrupts(); 
	rim
00113$:
;	./libs/i2c_lib.c: 64: }
	iret
;	./libs/i2c_lib.c: 66: void i2c_init(void)
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
	bres	0x5210, #0
;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0xc0
	or	a, #0x10
	ld	0x5212, a
;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
	ld	a, 0x521c
	and	a, #0xf0
	ld	0x521c, a
;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
	mov	0x521b+0, #0x50
;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
	bres	0x521c, #7
;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
	bres	0x5214, #7
;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
	bset	0x5214, #0
;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
	bset	0x5210, #0
;	./libs/i2c_lib.c: 78: }
	ret
;	./libs/i2c_lib.c: 80: void i2c_start(void)
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
	bset	0x5211, #0
;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
00101$:
	btjf	0x5217, #0, 00101$
;	./libs/i2c_lib.c: 84: }
	ret
;	./libs/i2c_lib.c: 86: void i2c_stop(void)
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
	bset	0x5211, #1
;	./libs/i2c_lib.c: 89: }
	ret
;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	./libs/i2c_lib.c: 96: address = address << 1;
	sll	a
;	./libs/i2c_lib.c: 93: switch(rw_type)
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00102$
;	./libs/i2c_lib.c: 96: address = address << 1;
;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	./libs/i2c_lib.c: 98: break;
;	./libs/i2c_lib.c: 99: default:
;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
;	./libs/i2c_lib.c: 102: }
00102$:
;	./libs/i2c_lib.c: 103: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
	ld	0x5216, a
;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
00106$:
	ldw	x, #0x5217
	ld	a, (x)
	srl	a
	and	a, #0x01
	jrne	00108$
;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
	btjf	0x5218, #2, 00106$
;	./libs/i2c_lib.c: 107: return 0;
	clr	a
	jra	00109$
00108$:
;	./libs/i2c_lib.c: 108: clr_sr1();
	ld	a,0x5217
;	./libs/i2c_lib.c: 109: clr_sr3();
	ld	a,0x5219
;	./libs/i2c_lib.c: 110: return 1;
	ld	a, #0x01
00109$:
;	./libs/i2c_lib.c: 111: }
	popw	x
	addw	sp, #1
	jp	(x)
;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
00101$:
	btjf	0x5217, #6, 00101$
;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
	ld	a, 0x5216
;	./libs/i2c_lib.c: 117: }
	ret
;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #4
;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
	bset	0x5211, #2
;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
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
;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
	ldw	x, (0x08, sp)
	addw	x, (0x03, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00105$
00101$:
;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
	ld	a, 0x5211
	and	a, #0xfb
	ld	0x5211, a
;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
	ldw	x, (0x08, sp)
	addw	x, (0x01, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	./libs/i2c_lib.c: 132: i2c_stop();
	call	_i2c_stop
00103$:
;	./libs/i2c_lib.c: 135: i2c_stop();
	ldw	x, (5, sp)
	ldw	(8, sp), x
	addw	sp, #7
;	./libs/i2c_lib.c: 137: }
	jp	_i2c_stop
;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
	ld	0x5216, a
;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
00103$:
	btjt	0x5217, #7, 00105$
;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
	btjf	0x5218, #2, 00103$
;	./libs/i2c_lib.c: 144: return 1;
	ld	a, #0x01
	ret
00105$:
;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
	clr	a
;	./libs/i2c_lib.c: 146: }
	ret
;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #2
;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jreq	00105$
;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
	clrw	x
00107$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00105$
;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	pushw	x
	call	_i2c_send_byte
	popw	x
	tnz	a
	jrne	00105$
;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
	incw	x
	jra	00107$
00105$:
;	./libs/i2c_lib.c: 158: i2c_stop();
	ldw	x, (3, sp)
	ldw	(6, sp), x
	addw	sp, #5
;	./libs/i2c_lib.c: 159: }
	jp	_i2c_stop
;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
;	-----------------------------------------
;	 function i2c_scan
;	-----------------------------------------
_i2c_scan:
	sub	sp, #2
;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
	ld	a, #0x01
	ld	(0x01, sp), a
00105$:
	cp	a, #0x7f
	jrnc	00103$
;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
	push	a
	push	#0x00
	call	_i2c_send_address
	ld	(0x03, sp), a
	pop	a
	tnz	(0x02, sp)
	jreq	00102$
;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
	call	_i2c_stop
;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
	ld	a, (0x01, sp)
	jra	00107$
00102$:
;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
	ldw	x, #0x5218
	push	a
	ld	a, (x)
	and	a, #0xfb
	ld	(x), a
	pop	a
;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
	inc	a
	ld	(0x01, sp), a
	jra	00105$
00103$:
;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
	call	_i2c_stop
;	./libs/i2c_lib.c: 173: return 0;
	clr	a
00107$:
;	./libs/i2c_lib.c: 174: }
	addw	sp, #2
	ret
;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
;	-----------------------------------------
;	 function i2c_start_irq
;	-----------------------------------------
_i2c_start_irq:
;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
	bset	0x521a, #1
;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
	bset	0x5211, #0
;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
00101$:
	ld	a, 0x521a
	bcp	a, #2
	jrne	00101$
;	./libs/i2c_lib.c: 182: }
	ret
;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
;	-----------------------------------------
;	 function i2c_stop_irq
;	-----------------------------------------
_i2c_stop_irq:
;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
	bset	0x5211, #1
;	./libs/i2c_lib.c: 187: }
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
;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
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
;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
	pushw	x
	push	#0x1b
	ld	a, #0x3c
	call	_i2c_write
;	./libs/ssd1306_lib.c: 43: }
	addw	sp, #27
	ret
;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
;	-----------------------------------------
;	 function ssd1306_set_params_to_write
;	-----------------------------------------
_ssd1306_set_params_to_write:
	sub	sp, #7
;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
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
;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
	pushw	x
	push	#0x07
	ld	a, #0x3c
	call	_i2c_write
;	./libs/ssd1306_lib.c: 52: }
	addw	sp, #7
	ret
;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
;	-----------------------------------------
;	 function ssd1306_draw_pixel
;	-----------------------------------------
_ssd1306_draw_pixel:
	sub	sp, #8
	ldw	(0x07, sp), x
;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
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
;	./libs/ssd1306_lib.c: 57: }
	ldw	x, (9, sp)
	addw	sp, #12
	jp	(x)
;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
;	-----------------------------------------
;	 function ssd1306_buffer_clean
;	-----------------------------------------
_ssd1306_buffer_clean:
;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
	push	#0x00
	push	#0x02
	clrw	x
	pushw	x
	ldw	x, #(_main_buffer+0)
	call	_memset
;	./libs/ssd1306_lib.c: 62: }
	ret
;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
;	-----------------------------------------
;	 function ssd1306_send_buffer
;	-----------------------------------------
_ssd1306_send_buffer:
	sub	sp, #4
;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
	call	_ssd1306_set_params_to_write
;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
	clrw	x
	ldw	(0x03, sp), x
00112$:
	ldw	x, (0x03, sp)
	cpw	x, #0x0004
	jrsge	00114$
;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
	push	#0x00
	ld	a, #0x3c
	call	_i2c_send_address
	tnz	a
	jreq	00105$
;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
	ld	a, #0x40
	call	_i2c_send_byte
;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
	ldw	x, (0x03, sp)
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	ldw	(0x01, sp), x
	clrw	x
00109$:
	cpw	x, #0x0080
	jrsge	00103$
;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i+(128*j)]))//Проверка на АСК бит
	ldw	y, x
	addw	y, (0x01, sp)
	ld	a, (_main_buffer+0, y)
	pushw	x
	call	_i2c_send_byte
	popw	x
	tnz	a
	jrne	00103$
;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
	incw	x
	jra	00109$
00103$:
;	./libs/ssd1306_lib.c: 78: i2c_stop();
	call	_i2c_stop
	jra	00113$
00105$:
;	./libs/ssd1306_lib.c: 81: i2c_stop();
	call	_i2c_stop
00113$:
;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00112$
00114$:
;	./libs/ssd1306_lib.c: 83: }
	addw	sp, #4
	ret
;	./libs/ssd1306_lib.c: 85: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
;	-----------------------------------------
;	 function ssd1306_buffer_write
;	-----------------------------------------
_ssd1306_buffer_write:
	sub	sp, #13
	ldw	(0x08, sp), x
;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
	clrw	x
	ldw	(0x0a, sp), x
00109$:
	ldw	x, (0x0a, sp)
	cpw	x, #0x0008
	jrslt	00150$
	jp	00111$
00150$:
;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
	ldw	x, (0x12, sp)
	addw	x, (0x0a, sp)
	ldw	(0x05, sp), x
	clrw	x
	ldw	(0x0c, sp), x
00106$:
	ldw	x, (0x0c, sp)
	cpw	x, #0x0008
	jrsge	00110$
;	./libs/ssd1306_lib.c: 90: if(data[height + width / 8] & (128 >> (width & 7)))
	ldw	x, (0x0a, sp)
	addw	x, (0x12, sp)
	ld	a, (x)
	ld	(0x07, sp), a
	ld	a, (0x0d, sp)
	and	a, #0x07
	ldw	x, #0x0080
	tnz	a
	jreq	00153$
00152$:
	sraw	x
	dec	a
	jrne	00152$
00153$:
	ldw	(0x01, sp), x
	ld	a, (0x07, sp)
	and	a, (0x02, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ldw	x, (0x03, sp)
	jreq	00107$
;	./libs/ssd1306_lib.c: 91: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(data[height], 7 - (width % 8)));
	push	#0x08
	push	#0x00
	ldw	x, (0x0e, sp)
	call	__modsint
	ldw	(0x03, sp), x
	ldw	y, #0x0007
	subw	y, (0x03, sp)
	ldw	x, (0x05, sp)
	ld	a, (x)
	clrw	x
	pushw	y
	ld	xl, a
	call	_get_bit
	ld	a, (0x11, sp)
	ld	(0x07, sp), a
	ld	a, (0x0b, sp)
	add	a, (0x07, sp)
	ld	xh, a
	ld	a, (0x09, sp)
	ld	(0x07, sp), a
	ld	a, (0x0d, sp)
	add	a, (0x07, sp)
	ld	(0x07, sp), a
	ld	a, xl
	push	a
	ld	a, xh
	push	a
	ld	a, (0x09, sp)
	ldw	x, #(_main_buffer+0)
	call	_ssd1306_draw_pixel
00107$:
;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
	ldw	x, (0x0c, sp)
	incw	x
	ldw	(0x0c, sp), x
	jra	00106$
00110$:
;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
	ldw	x, (0x0a, sp)
	incw	x
	ldw	(0x0a, sp), x
	jp	00109$
00111$:
;	./libs/ssd1306_lib.c: 93: }
	ldw	x, (14, sp)
	addw	sp, #19
	jp	(x)
;	./libs/ssd1306_lib.c: 95: void ssd1306_clean(void)
;	-----------------------------------------
;	 function ssd1306_clean
;	-----------------------------------------
_ssd1306_clean:
;	./libs/ssd1306_lib.c: 97: ssd1306_buffer_clean();
	call	_ssd1306_buffer_clean
;	./libs/ssd1306_lib.c: 98: ssd1306_send_buffer();
;	./libs/ssd1306_lib.c: 99: }
	jp	_ssd1306_send_buffer
;	./libs/menu_lib.c: 3: void menu_border(void)
;	-----------------------------------------
;	 function menu_border
;	-----------------------------------------
_menu_border:
	sub	sp, #4
;	./libs/menu_lib.c: 6: ssd1306_buffer_write(0,0,ttf_corner_left_up);
	push	#<(_ttf_corner_left_up+0)
	push	#((_ttf_corner_left_up+0) >> 8)
	clrw	x
	pushw	x
	clrw	x
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 7: for(int x = 1;x<15;x++)
	clrw	x
	incw	x
	ldw	(0x03, sp), x
00104$:
	ldw	x, (0x03, sp)
	cpw	x, #0x000f
	jrsge	00101$
;	./libs/menu_lib.c: 8: ssd1306_buffer_write(x*8,0,ttf_line_up);
	ldw	x, (0x03, sp)
	sllw	x
	sllw	x
	sllw	x
	ldw	(0x01, sp), x
	push	#<(_ttf_line_up+0)
	push	#((_ttf_line_up+0) >> 8)
	clrw	x
	pushw	x
	ldw	x, (0x05, sp)
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 7: for(int x = 1;x<15;x++)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00104$
00101$:
;	./libs/menu_lib.c: 9: ssd1306_buffer_write(120,0,ttf_corner_right_up);
	push	#<(_ttf_corner_right_up+0)
	push	#((_ttf_corner_right_up+0) >> 8)
	clrw	x
	pushw	x
	ldw	x, #0x0078
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 11: ssd1306_buffer_write(0,8,ttf_line_left);
	push	#<(_ttf_line_left+0)
	push	#((_ttf_line_left+0) >> 8)
	push	#0x08
	push	#0x00
	clrw	x
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 12: ssd1306_buffer_write(0,16,ttf_line_left);
	push	#<(_ttf_line_left+0)
	push	#((_ttf_line_left+0) >> 8)
	push	#0x10
	push	#0x00
	clrw	x
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 14: ssd1306_buffer_write(120,8,ttf_line_right);
	push	#<(_ttf_line_right+0)
	push	#((_ttf_line_right+0) >> 8)
	push	#0x08
	push	#0x00
	ldw	x, #0x0078
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 15: ssd1306_buffer_write(120,16,ttf_line_right);
	push	#<(_ttf_line_right+0)
	push	#((_ttf_line_right+0) >> 8)
	push	#0x10
	push	#0x00
	ldw	x, #0x0078
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 17: ssd1306_buffer_write(0,24,ttf_corner_left_down);
	push	#<(_ttf_corner_left_down+0)
	push	#((_ttf_corner_left_down+0) >> 8)
	push	#0x18
	push	#0x00
	clrw	x
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 18: for(int x = 1;x<15;x++)
	clrw	x
	incw	x
00107$:
	cpw	x, #0x000f
	jrsge	00102$
;	./libs/menu_lib.c: 19: ssd1306_buffer_write(x*8,24,ttf_line_down);
	ldw	y, x
	sllw	y
	sllw	y
	sllw	y
	pushw	x
	push	#<(_ttf_line_down+0)
	push	#((_ttf_line_down+0) >> 8)
	push	#0x18
	push	#0x00
	ldw	x, y
	call	_ssd1306_buffer_write
	popw	x
;	./libs/menu_lib.c: 18: for(int x = 1;x<15;x++)
	incw	x
	jra	00107$
00102$:
;	./libs/menu_lib.c: 20: ssd1306_buffer_write(120,24,ttf_corner_right_down);
	push	#<(_ttf_corner_right_down+0)
	push	#((_ttf_corner_right_down+0) >> 8)
	push	#0x18
	push	#0x00
	ldw	x, #0x0078
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 21: }
	addw	sp, #4
	ret
;	./libs/menu_lib.c: 23: void menu_border_paragraph(uint8_t number_of_letters)
;	-----------------------------------------
;	 function menu_border_paragraph
;	-----------------------------------------
_menu_border_paragraph:
	sub	sp, #7
	ld	(0x07, sp), a
;	./libs/menu_lib.c: 26: ssd1306_buffer_write(6,8,ttf_corner_left_up);
	push	#<(_ttf_corner_left_up+0)
	push	#((_ttf_corner_left_up+0) >> 8)
	push	#0x08
	push	#0x00
	ldw	x, #0x0006
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 27: ssd1306_buffer_write(6,16,ttf_corner_left_down);
	push	#<(_ttf_corner_left_down+0)
	push	#((_ttf_corner_left_down+0) >> 8)
	push	#0x10
	push	#0x00
	ldw	x, #0x0006
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 28: for(int x = 1;x<number_of_letters+1;x++)
	clrw	x
	incw	x
	ldw	(0x05, sp), x
00104$:
	clrw	y
	ld	a, (0x07, sp)
	ld	yl, a
	ldw	x, y
	incw	x
	ldw	(0x01, sp), x
	ldw	x, (0x05, sp)
	cpw	x, (0x01, sp)
	jrsge	00101$
;	./libs/menu_lib.c: 29: ssd1306_buffer_write(6+x*8,8,ttf_line_up);
	ldw	x, (0x05, sp)
	sllw	x
	sllw	x
	sllw	x
	ldw	(0x01, sp), x
	addw	x, #0x0006
	ldw	(0x03, sp), x
	push	#<(_ttf_line_up+0)
	push	#((_ttf_line_up+0) >> 8)
	push	#0x08
	push	#0x00
	ldw	x, (0x07, sp)
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 28: for(int x = 1;x<number_of_letters+1;x++)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	jra	00104$
00101$:
;	./libs/menu_lib.c: 30: ssd1306_buffer_write(6+number_of_letters*8,8,ttf_corner_right_up);
	ldw	x, y
	sllw	x
	sllw	x
	sllw	x
	ld	a, xl
	add	a, #0x06
	ld	(0x04, sp), a
	ld	a, xh
	adc	a, #0x00
	ld	(0x03, sp), a
	pushw	x
	push	#<(_ttf_corner_right_up+0)
	push	#((_ttf_corner_right_up+0) >> 8)
	push	#0x08
	push	#0x00
	ldw	x, (0x09, sp)
	call	_ssd1306_buffer_write
	popw	x
;	./libs/menu_lib.c: 31: ssd1306_buffer_write(12+number_of_letters*8,0,ttf_line_left);
	addw	x, #0x000c
	ldw	(0x05, sp), x
	push	#<(_ttf_line_left+0)
	push	#((_ttf_line_left+0) >> 8)
	clrw	x
	pushw	x
	ldw	x, (0x09, sp)
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 34: ssd1306_buffer_write(6,16,ttf_corner_left_down);
	push	#<(_ttf_corner_left_down+0)
	push	#((_ttf_corner_left_down+0) >> 8)
	push	#0x10
	push	#0x00
	ldw	x, #0x0006
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 35: for(int x = 1;x<number_of_letters+1;x++)
	clrw	x
	incw	x
00107$:
	cpw	x, (0x01, sp)
	jrsge	00102$
;	./libs/menu_lib.c: 36: ssd1306_buffer_write(6+x*8,16,ttf_line_down);
	ldw	y, x
	sllw	y
	sllw	y
	sllw	y
	addw	y, #0x0006
	pushw	x
	push	#<(_ttf_line_down+0)
	push	#((_ttf_line_down+0) >> 8)
	push	#0x10
	push	#0x00
	ldw	x, y
	call	_ssd1306_buffer_write
	popw	x
;	./libs/menu_lib.c: 35: for(int x = 1;x<number_of_letters+1;x++)
	incw	x
	jra	00107$
00102$:
;	./libs/menu_lib.c: 37: ssd1306_buffer_write(6+number_of_letters*8,16,ttf_corner_right_down);
	push	#<(_ttf_corner_right_down+0)
	push	#((_ttf_corner_right_down+0) >> 8)
	push	#0x10
	push	#0x00
	ldw	x, (0x07, sp)
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 38: ssd1306_buffer_write(12+number_of_letters*8,24,ttf_line_left);
	push	#<(_ttf_line_left+0)
	push	#((_ttf_line_left+0) >> 8)
	push	#0x18
	push	#0x00
	ldw	x, (0x09, sp)
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 40: }
	addw	sp, #7
	ret
;	./libs/menu_lib.c: 42: void menu_border_item(uint8_t number_of_letters)
;	-----------------------------------------
;	 function menu_border_item
;	-----------------------------------------
_menu_border_item:
	sub	sp, #6
;	./libs/menu_lib.c: 45: ssd1306_buffer_write(12+number_of_letters*8,7,ttf_corner_left_down);
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x01, sp)
	sllw	x
	sllw	x
	sllw	x
	addw	x, #0x000c
	ldw	(0x03, sp), x
	push	#<(_ttf_corner_left_down+0)
	push	#((_ttf_corner_left_down+0) >> 8)
	push	#0x07
	push	#0x00
	ldw	x, (0x07, sp)
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 46: for(int x = 1;x<14-number_of_letters;x++)
	ld	a, #0x0e
	sub	a, (0x02, sp)
	ld	(0x06, sp), a
	clr	a
	sbc	a, (0x01, sp)
	ld	(0x05, sp), a
	clrw	x
	incw	x
00103$:
	cpw	x, (0x05, sp)
	jrsge	00101$
;	./libs/menu_lib.c: 47: ssd1306_buffer_write(12+number_of_letters*8+x*8,7,ttf_line_down);
	ldw	y, x
	sllw	y
	sllw	y
	sllw	y
	addw	y, (0x03, sp)
	pushw	x
	push	#<(_ttf_line_down+0)
	push	#((_ttf_line_down+0) >> 8)
	push	#0x07
	push	#0x00
	ldw	x, y
	call	_ssd1306_buffer_write
	popw	x
;	./libs/menu_lib.c: 46: for(int x = 1;x<14-number_of_letters;x++)
	incw	x
	jra	00103$
00101$:
;	./libs/menu_lib.c: 48: ssd1306_buffer_write(120,7,ttf_corner_right_down);
	push	#<(_ttf_corner_right_down+0)
	push	#((_ttf_corner_right_down+0) >> 8)
	push	#0x07
	push	#0x00
	ldw	x, #0x0078
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 51: ssd1306_buffer_write(97,15,ttf_line_left);
	push	#<(_ttf_line_left+0)
	push	#((_ttf_line_left+0) >> 8)
	push	#0x0f
	push	#0x00
	ldw	x, #0x0061
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 52: ssd1306_buffer_write(97,17,ttf_corner_left_down);
	push	#<(_ttf_corner_left_down+0)
	push	#((_ttf_corner_left_down+0) >> 8)
	push	#0x11
	push	#0x00
	ldw	x, #0x0061
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 53: ssd1306_buffer_write(104,17,ttf_line_down);
	push	#<(_ttf_line_down+0)
	push	#((_ttf_line_down+0) >> 8)
	push	#0x11
	push	#0x00
	ldw	x, #0x0068
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 54: ssd1306_buffer_write(112,17,ttf_line_down);
	push	#<(_ttf_line_down+0)
	push	#((_ttf_line_down+0) >> 8)
	push	#0x11
	push	#0x00
	ldw	x, #0x0070
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 55: ssd1306_buffer_write(120,17,ttf_line_down);
	push	#<(_ttf_line_down+0)
	push	#((_ttf_line_down+0) >> 8)
	push	#0x11
	push	#0x00
	ldw	x, #0x0078
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 58: }
	addw	sp, #6
	ret
;	./libs/menu_lib.c: 60: void menu_set_params_value(uint8_t number)
;	-----------------------------------------
;	 function menu_set_params_value
;	-----------------------------------------
_menu_set_params_value:
	sub	sp, #5
;	./libs/menu_lib.c: 64: do {
	clr	(0x05, sp)
00101$:
;	./libs/menu_lib.c: 65: ssd1306_buffer_write(117-8*index,15,numbers[number % 10]); // Получаем последнюю цифру
	ld	(0x02, sp), a
	clr	(0x01, sp)
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
	call	__modsint
	sllw	x
	ldw	x, (_menu_set_params_value_numbers_10000_171+0, x)
	ldw	y, x
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	sllw	x
	sllw	x
	sllw	x
	ldw	(0x03, sp), x
	ldw	x, #0x0075
	subw	x, (0x03, sp)
	pushw	y
	push	#0x0f
	push	#0x00
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 66: number /= 10; // Убираем последнюю цифру
	push	#0x0a
	push	#0x00
	ldw	x, (0x03, sp)
	call	__divsint
	ld	a, xl
;	./libs/menu_lib.c: 67: index++;
	inc	(0x05, sp)
;	./libs/menu_lib.c: 68: } while (number > 0);
	tnz	a
	jrne	00101$
;	./libs/menu_lib.c: 69: }
	addw	sp, #5
	ret
;	./libs/menu_lib.c: 70: void menu_set_item_menu(uint8_t item)
;	-----------------------------------------
;	 function menu_set_item_menu
;	-----------------------------------------
_menu_set_item_menu:
;	./libs/menu_lib.c: 73: switch(item)
	cp	a, #0x07
	jrule	00118$
	ret
00118$:
	clrw	x
	ld	xl, a
	sllw	x
	ldw	x, (#00119$, x)
	jp	(x)
00119$:
	.dw	#00109$
	.dw	#00101$
	.dw	#00102$
	.dw	#00103$
	.dw	#00104$
	.dw	#00105$
	.dw	#00106$
	.dw	#00107$
;	./libs/menu_lib.c: 75: case red:
00101$:
;	./libs/menu_lib.c: 76: menu_border_item(color);
	ld	a, #0x05
	call	_menu_border_item
;	./libs/menu_lib.c: 78: ssd1306_buffer_write(15+color*8,4,ttf_eng_r);
	push	#<(_ttf_eng_r+0)
	push	#((_ttf_eng_r+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0037
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 79: ssd1306_buffer_write(15+color*8+8,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x003f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 80: ssd1306_buffer_write(15+color*8+16,4,ttf_eng_d);
	push	#<(_ttf_eng_d+0)
	push	#((_ttf_eng_d+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 82: menu_set_params_value(params_value.current_red);
	ld	a, _params_value+2
;	./libs/menu_lib.c: 84: break;
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 85: case green:
00102$:
;	./libs/menu_lib.c: 86: menu_border_item(color);
	ld	a, #0x05
	call	_menu_border_item
;	./libs/menu_lib.c: 88: ssd1306_buffer_write(15+color*8,4,ttf_eng_g);
	push	#<(_ttf_eng_g+0)
	push	#((_ttf_eng_g+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0037
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 89: ssd1306_buffer_write(15+color*8+8,4,ttf_eng_r);
	push	#<(_ttf_eng_r+0)
	push	#((_ttf_eng_r+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x003f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 90: ssd1306_buffer_write(15+color*8+16,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 91: ssd1306_buffer_write(15+color*8+24,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x004f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 92: ssd1306_buffer_write(15+color*8+32,4,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0057
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 94: menu_set_params_value(params_value.current_green);
	ld	a, _params_value+3
;	./libs/menu_lib.c: 97: break;
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 98: case blue:
00103$:
;	./libs/menu_lib.c: 99: menu_border_item(color);
	ld	a, #0x05
	call	_menu_border_item
;	./libs/menu_lib.c: 101: ssd1306_buffer_write(15+color*8,4,ttf_eng_b);
	push	#<(_ttf_eng_b+0)
	push	#((_ttf_eng_b+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0037
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 102: ssd1306_buffer_write(15+color*8+8,4,ttf_eng_l);
	push	#<(_ttf_eng_l+0)
	push	#((_ttf_eng_l+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x003f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 103: ssd1306_buffer_write(15+color*8+16,4,ttf_eng_u);
	push	#<(_ttf_eng_u+0)
	push	#((_ttf_eng_u+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 104: ssd1306_buffer_write(15+color*8+24,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x004f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 106: menu_set_params_value(params_value.current_blue);
	ld	a, _params_value+4
;	./libs/menu_lib.c: 107: break;
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 108: case first:
00104$:
;	./libs/menu_lib.c: 109: menu_border_item(segment);
	ld	a, #0x07
	call	_menu_border_item
;	./libs/menu_lib.c: 111: ssd1306_buffer_write(15+segment*8,4,ttf_eng_f);
	push	#<(_ttf_eng_f+0)
	push	#((_ttf_eng_f+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 112: ssd1306_buffer_write(15+segment*8+8,4,ttf_eng_i);
	push	#<(_ttf_eng_i+0)
	push	#((_ttf_eng_i+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x004f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 113: ssd1306_buffer_write(15+segment*8+16,4,ttf_eng_r);
	push	#<(_ttf_eng_r+0)
	push	#((_ttf_eng_r+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0057
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 114: ssd1306_buffer_write(15+segment*8+24,4,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x005f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 115: ssd1306_buffer_write(15+segment*8+32,4,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0067
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 117: menu_set_params_value(params_value.current_first);
	ldw	x, #_params_value+5
	ld	a, (x)
	and	a, #0x0f
;	./libs/menu_lib.c: 118: break;
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 119: case second:
00105$:
;	./libs/menu_lib.c: 120: menu_border_item(segment);
	ld	a, #0x07
	call	_menu_border_item
;	./libs/menu_lib.c: 122: ssd1306_buffer_write(15+segment*8,4,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 123: ssd1306_buffer_write(15+segment*8+8,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x004f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 124: ssd1306_buffer_write(15+segment*8+16,4,ttf_eng_c);
	push	#<(_ttf_eng_c+0)
	push	#((_ttf_eng_c+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0057
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 125: ssd1306_buffer_write(15+segment*8+24,4,ttf_eng_o);
	push	#<(_ttf_eng_o+0)
	push	#((_ttf_eng_o+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x005f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 126: ssd1306_buffer_write(15+segment*8+32,4,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0067
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 127: ssd1306_buffer_write(15+segment*8+40,4,ttf_eng_d);
	push	#<(_ttf_eng_d+0)
	push	#((_ttf_eng_d+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x006f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 129: menu_set_params_value(params_value.current_second);
	ldw	x, #_params_value+5
	ld	a, (x)
	swap	a
	and	a, #0x0f
;	./libs/menu_lib.c: 130: break;
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 131: case sens:
00106$:
;	./libs/menu_lib.c: 132: menu_border_item(settings);
	ld	a, #0x06
	call	_menu_border_item
;	./libs/menu_lib.c: 134: ssd1306_buffer_write(15+settings*8,4,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x003f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 135: ssd1306_buffer_write(15+settings*8+8,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 136: ssd1306_buffer_write(15+settings*8+16,4,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x004f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 137: ssd1306_buffer_write(15+settings*8+24,4,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0057
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 139: menu_set_params_value(params_value.current_sens);
	ld	a, _params_value+6
;	./libs/menu_lib.c: 140: break;
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 141: case vers:
00107$:
;	./libs/menu_lib.c: 142: menu_border_item(settings);
	ld	a, #0x06
	call	_menu_border_item
;	./libs/menu_lib.c: 144: ssd1306_buffer_write(15+settings*8,4,ttf_eng_v);
	push	#<(_ttf_eng_v+0)
	push	#((_ttf_eng_v+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x003f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 145: ssd1306_buffer_write(15+settings*8+8,4,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0047
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 146: ssd1306_buffer_write(15+settings*8+16,4,ttf_eng_r);
	push	#<(_ttf_eng_r+0)
	push	#((_ttf_eng_r+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x004f
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 147: ssd1306_buffer_write(15+settings*8+24,4,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0057
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 149: menu_set_params_value(params_value.current_vers);
	ld	a, _params_value+7
	jp	_menu_set_params_value
;	./libs/menu_lib.c: 151: }
00109$:
;	./libs/menu_lib.c: 153: }
	ret
;	./libs/menu_lib.c: 158: void menu_set_paragraph(uint8_t paragraph)
;	-----------------------------------------
;	 function menu_set_paragraph
;	-----------------------------------------
_menu_set_paragraph:
;	./libs/menu_lib.c: 160: switch(paragraph)
	cp	a, #0x04
	jreq	00101$
	cp	a, #0x05
	jrne	00140$
	jp	00102$
00140$:
	cp	a, #0x06
	jrne	00143$
	jp	00104$
00143$:
	cp	a, #0x07
	jrne	00146$
	jp	00103$
00146$:
	ret
;	./libs/menu_lib.c: 162: case menu:
00101$:
;	./libs/menu_lib.c: 163: ssd1306_buffer_clean();
	call	_ssd1306_buffer_clean
;	./libs/menu_lib.c: 164: menu_border();
	call	_menu_border
;	./libs/menu_lib.c: 165: menu_border_paragraph(menu);
	ld	a, #0x04
	call	_menu_border_paragraph
;	./libs/menu_lib.c: 167: ssd1306_buffer_write(10,12,ttf_eng_m);
	push	#<(_ttf_eng_m+0)
	push	#((_ttf_eng_m+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x000a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 168: ssd1306_buffer_write(18,12,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0012
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 169: ssd1306_buffer_write(26,12,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x001a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 170: ssd1306_buffer_write(34,12,ttf_eng_u);
	push	#<(_ttf_eng_u+0)
	push	#((_ttf_eng_u+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0022
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 172: ssd1306_buffer_write(48,4,ttf_eng_c);
	push	#<(_ttf_eng_c+0)
	push	#((_ttf_eng_c+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0030
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 173: ssd1306_buffer_write(56,4,ttf_eng_o);
	push	#<(_ttf_eng_o+0)
	push	#((_ttf_eng_o+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0038
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 174: ssd1306_buffer_write(64,4,ttf_eng_l);
	push	#<(_ttf_eng_l+0)
	push	#((_ttf_eng_l+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0040
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 175: ssd1306_buffer_write(72,4,ttf_eng_o);
	push	#<(_ttf_eng_o+0)
	push	#((_ttf_eng_o+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0048
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 176: ssd1306_buffer_write(80,4,ttf_eng_r);
	push	#<(_ttf_eng_r+0)
	push	#((_ttf_eng_r+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0050
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 177: ssd1306_buffer_write(114,4,ttf_line_left);
	push	#<(_ttf_line_left+0)
	push	#((_ttf_line_left+0) >> 8)
	push	#0x04
	push	#0x00
	ldw	x, #0x0072
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 179: ssd1306_buffer_write(48,12,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0030
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 180: ssd1306_buffer_write(56,12,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0038
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 181: ssd1306_buffer_write(64,12,ttf_eng_g);
	push	#<(_ttf_eng_g+0)
	push	#((_ttf_eng_g+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0040
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 182: ssd1306_buffer_write(72,12,ttf_eng_m);
	push	#<(_ttf_eng_m+0)
	push	#((_ttf_eng_m+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0048
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 183: ssd1306_buffer_write(80,12,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0050
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 184: ssd1306_buffer_write(88,12,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0058
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 185: ssd1306_buffer_write(96,12,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0060
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 186: ssd1306_buffer_write(114,12,ttf_void);
	push	#<(_ttf_void+0)
	push	#((_ttf_void+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0072
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 188: ssd1306_buffer_write(48,20,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0030
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 189: ssd1306_buffer_write(56,20,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0038
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 190: ssd1306_buffer_write(64,20,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0040
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 191: ssd1306_buffer_write(72,20,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0048
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 192: ssd1306_buffer_write(80,20,ttf_eng_i);
	push	#<(_ttf_eng_i+0)
	push	#((_ttf_eng_i+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0050
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 193: ssd1306_buffer_write(88,20,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0058
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 194: ssd1306_buffer_write(96,20,ttf_eng_g);
	push	#<(_ttf_eng_g+0)
	push	#((_ttf_eng_g+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0060
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 195: ssd1306_buffer_write(104,20,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0068
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 196: ssd1306_buffer_write(114,20,ttf_void);
	push	#<(_ttf_void+0)
	push	#((_ttf_void+0) >> 8)
	push	#0x14
	push	#0x00
	ldw	x, #0x0072
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 198: ssd1306_send_buffer();
;	./libs/menu_lib.c: 199: break;
	jp	_ssd1306_send_buffer
;	./libs/menu_lib.c: 200: case color:
00102$:
;	./libs/menu_lib.c: 201: ssd1306_buffer_clean();
	call	_ssd1306_buffer_clean
;	./libs/menu_lib.c: 202: menu_border();
	call	_menu_border
;	./libs/menu_lib.c: 203: menu_border_paragraph(color);
	ld	a, #0x05
	call	_menu_border_paragraph
;	./libs/menu_lib.c: 205: ssd1306_buffer_write(10,12,ttf_eng_c);
	push	#<(_ttf_eng_c+0)
	push	#((_ttf_eng_c+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x000a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 206: ssd1306_buffer_write(18,12,ttf_eng_o);
	push	#<(_ttf_eng_o+0)
	push	#((_ttf_eng_o+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0012
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 207: ssd1306_buffer_write(26,12,ttf_eng_l);
	push	#<(_ttf_eng_l+0)
	push	#((_ttf_eng_l+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x001a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 208: ssd1306_buffer_write(34,12,ttf_eng_o);
	push	#<(_ttf_eng_o+0)
	push	#((_ttf_eng_o+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0022
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 209: ssd1306_buffer_write(42,12,ttf_eng_r);
	push	#<(_ttf_eng_r+0)
	push	#((_ttf_eng_r+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x002a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 211: menu_set_item_menu(red);
	ld	a, #0x01
	call	_menu_set_item_menu
;	./libs/menu_lib.c: 213: ssd1306_send_buffer();
;	./libs/menu_lib.c: 214: break;
	jp	_ssd1306_send_buffer
;	./libs/menu_lib.c: 215: case segment:
00103$:
;	./libs/menu_lib.c: 216: ssd1306_buffer_clean();
	call	_ssd1306_buffer_clean
;	./libs/menu_lib.c: 217: menu_border();
	call	_menu_border
;	./libs/menu_lib.c: 218: menu_border_paragraph(segment);
	ld	a, #0x07
	call	_menu_border_paragraph
;	./libs/menu_lib.c: 220: ssd1306_buffer_write(10,12,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x000a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 221: ssd1306_buffer_write(18,12,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0012
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 222: ssd1306_buffer_write(26,12,ttf_eng_g);
	push	#<(_ttf_eng_g+0)
	push	#((_ttf_eng_g+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x001a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 223: ssd1306_buffer_write(34,12,ttf_eng_m);
	push	#<(_ttf_eng_m+0)
	push	#((_ttf_eng_m+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0022
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 224: ssd1306_buffer_write(42,12,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x002a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 225: ssd1306_buffer_write(50,12,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0032
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 226: ssd1306_buffer_write(58,12,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x003a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 228: menu_set_item_menu(first);
	ld	a, #0x04
	call	_menu_set_item_menu
;	./libs/menu_lib.c: 230: ssd1306_send_buffer();
;	./libs/menu_lib.c: 233: break;
	jp	_ssd1306_send_buffer
;	./libs/menu_lib.c: 234: case settings:
00104$:
;	./libs/menu_lib.c: 235: ssd1306_buffer_clean();
	call	_ssd1306_buffer_clean
;	./libs/menu_lib.c: 236: menu_border();
	call	_menu_border
;	./libs/menu_lib.c: 237: menu_border_paragraph(settings);
	ld	a, #0x06
	call	_menu_border_paragraph
;	./libs/menu_lib.c: 239: ssd1306_buffer_write(10,12,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x000a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 240: ssd1306_buffer_write(18,12,ttf_eng_e);
	push	#<(_ttf_eng_e+0)
	push	#((_ttf_eng_e+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0012
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 241: ssd1306_buffer_write(26,12,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x001a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 242: ssd1306_buffer_write(34,12,ttf_eng_t);
	push	#<(_ttf_eng_t+0)
	push	#((_ttf_eng_t+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0022
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 243: ssd1306_buffer_write(42,12,ttf_eng_i);
	push	#<(_ttf_eng_i+0)
	push	#((_ttf_eng_i+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x002a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 244: ssd1306_buffer_write(50,12,ttf_eng_n);
	push	#<(_ttf_eng_n+0)
	push	#((_ttf_eng_n+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0032
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 245: ssd1306_buffer_write(58,12,ttf_eng_g);
	push	#<(_ttf_eng_g+0)
	push	#((_ttf_eng_g+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x003a
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 246: ssd1306_buffer_write(66,12,ttf_eng_s);
	push	#<(_ttf_eng_s+0)
	push	#((_ttf_eng_s+0) >> 8)
	push	#0x0c
	push	#0x00
	ldw	x, #0x0042
	call	_ssd1306_buffer_write
;	./libs/menu_lib.c: 248: menu_set_item_menu(sens);
	ld	a, #0x06
	call	_menu_set_item_menu
;	./libs/menu_lib.c: 250: ssd1306_send_buffer();
;	./libs/menu_lib.c: 252: }
;	./libs/menu_lib.c: 253: }
	jp	_ssd1306_send_buffer
;	./libs/tmr2_lib.c: 3: void tmr2_irq(void) __interrupt(TIM2_vector)
;	-----------------------------------------
;	 function tmr2_irq
;	-----------------------------------------
_tmr2_irq:
	clr	a
	div	x, a
;	./libs/tmr2_lib.c: 6: disableInterrupts();
	sim
;	./libs/tmr2_lib.c: 7: TIM2_IRQ.all = 0;//обнуление флагов регистров
	mov	_TIM2_IRQ+0, #0x00
;	./libs/tmr2_lib.c: 9: if(TIM2_SR1 -> UIF)//прерывание таймера
	ldw	x, #0x5304
	ld	a, (x)
	and	a, #0x01
	jreq	00102$
;	./libs/tmr2_lib.c: 11: TIM2_IRQ.UIF = 1;
	bset	_TIM2_IRQ+0, #7
;	./libs/tmr2_lib.c: 12: TIM2_IER -> UIE = 0;
	ldw	x, #0x5303
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
00102$:
;	./libs/tmr2_lib.c: 14: enableInterrupts();
	rim
;	./libs/tmr2_lib.c: 15: }
	iret
;	./libs/tmr2_lib.c: 16: void delay_s(uint8_t ticks)
;	-----------------------------------------
;	 function delay_s
;	-----------------------------------------
_delay_s:
	sub	sp, #7
	ld	(0x05, sp), a
;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks+1;i++)//блять в душе не ебу почему так сработало, но почему-то если на один больше, то таймер нормально работает
	clrw	x
	ldw	(0x06, sp), x
00106$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x03, sp), x
	ldw	x, (0x06, sp)
	cpw	x, (0x03, sp)
	jrsge	00104$
;	./libs/tmr2_lib.c: 20: TIM2_SR1 -> UIF = 0;
	bres	0x5304, #0
;	./libs/tmr2_lib.c: 21: TIM2_ARRH->ARR = 0x03;
	mov	0x530f+0, #0x03
;	./libs/tmr2_lib.c: 22: TIM2_ARRL->ARR = 0xD1;
	mov	0x5310+0, #0xd1
;	./libs/tmr2_lib.c: 23: TIM2_PSCR -> PSC = 0x0E;
	ld	a, 0x530e
	and	a, #0xf0
	or	a, #0x0e
	ld	0x530e, a
;	./libs/tmr2_lib.c: 24: TIM2_IER -> UIE = 1;
	bset	0x5303, #0
;	./libs/tmr2_lib.c: 25: TIM2_CR1-> CEN = 1;
	bset	0x5300, #0
;	./libs/tmr2_lib.c: 26: while(TIM2_IER -> UIE);	
00101$:
	btjt	0x5303, #0, 00101$
;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks+1;i++)//блять в душе не ебу почему так сработало, но почему-то если на один больше, то таймер нормально работает
	ldw	x, (0x06, sp)
	incw	x
	ldw	(0x06, sp), x
	jra	00106$
00104$:
;	./libs/tmr2_lib.c: 28: TIM2_CR1-> CEN = 0;
	bres	0x5300, #0
;	./libs/tmr2_lib.c: 29: }
	addw	sp, #7
	ret
;	./libs/tmr2_lib.c: 30: void delay_ms(uint8_t ticks)
;	-----------------------------------------
;	 function delay_ms
;	-----------------------------------------
_delay_ms:
	sub	sp, #7
	ld	(0x05, sp), a
;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks+1;i++)
	clrw	x
	ldw	(0x06, sp), x
00106$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x03, sp), x
	ldw	x, (0x06, sp)
	cpw	x, (0x03, sp)
	jrsge	00104$
;	./libs/tmr2_lib.c: 34: TIM2_SR1 -> UIF = 0;
	bres	0x5304, #0
;	./libs/tmr2_lib.c: 35: TIM2_ARRH->ARR = 0x03;
	mov	0x530f+0, #0x03
;	./libs/tmr2_lib.c: 36: TIM2_ARRL->ARR = 0xD1;
	mov	0x5310+0, #0xd1
;	./libs/tmr2_lib.c: 37: TIM2_PSCR -> PSC = 0x0E;
	ld	a, 0x530e
	and	a, #0xf0
	or	a, #0x0e
	ld	0x530e, a
;	./libs/tmr2_lib.c: 38: TIM2_IER -> UIE = 1;
	bset	0x5303, #0
;	./libs/tmr2_lib.c: 39: TIM2_CR1-> CEN = 1;
	bset	0x5300, #0
;	./libs/tmr2_lib.c: 40: while(TIM2_IER -> UIE);	
00101$:
	btjt	0x5303, #0, 00101$
;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks+1;i++)
	ldw	x, (0x06, sp)
	incw	x
	ldw	(0x06, sp), x
	jra	00106$
00104$:
;	./libs/tmr2_lib.c: 42: TIM2_CR1-> CEN = 0;
	bres	0x5300, #0
;	./libs/tmr2_lib.c: 43: }
	addw	sp, #7
	ret
;	main.c: 3: void params_default_conf(void)
;	-----------------------------------------
;	 function params_default_conf
;	-----------------------------------------
_params_default_conf:
;	main.c: 5: params_value.current_red = 255;
	mov	_params_value+2, #0xff
;	main.c: 6: params_value.current_green = 255;
	mov	_params_value+3, #0xff
;	main.c: 7: params_value.current_blue = 255;
	mov	_params_value+4, #0xff
;	main.c: 9: params_value.current_first = 0;
	ldw	x, #(_params_value+0)+5
	ld	a, (x)
	and	a, #0xf0
;	main.c: 10: params_value.current_second = 15;
	ld	(x), a
	or	a, #0xf0
	ld	(x), a
;	main.c: 12: params_value.current_sens = 10;
	mov	_params_value+6, #0x0a
;	main.c: 13: params_value.current_vers = 0xA1;
	mov	_params_value+7, #0xa1
;	main.c: 14: }
	ret
;	main.c: 16: void setup(void)
;	-----------------------------------------
;	 function setup
;	-----------------------------------------
_setup:
;	main.c: 19: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 21: params_value.all = 0;
	mov	_params_value+0, #0x00
;	main.c: 23: uart_init(9600,0);
	clr	a
	ldw	x, #0x2580
	call	_uart_init
;	main.c: 24: i2c_init();
	call	_i2c_init
;	main.c: 25: ssd1306_init();
	call	_ssd1306_init
;	main.c: 26: ssd1306_send_buffer();
	call	_ssd1306_send_buffer
;	main.c: 27: params_default_conf();
	call	_params_default_conf
;	main.c: 29: enableInterrupts();
	rim
;	main.c: 30: delay_s(1);
	ld	a, #0x01
;	main.c: 31: }
	jp	_delay_s
;	main.c: 34: void gg(void)
;	-----------------------------------------
;	 function gg
;	-----------------------------------------
_gg:
;	main.c: 36: menu_set_paragraph(menu);
	ld	a, #0x04
	call	_menu_set_paragraph
;	main.c: 37: delay_s(1);
	ld	a, #0x01
	call	_delay_s
;	main.c: 39: menu_set_paragraph(color);
	ld	a, #0x05
	call	_menu_set_paragraph
;	main.c: 40: delay_s(1);
	ld	a, #0x01
;	main.c: 52: }
	jp	_delay_s
;	main.c: 54: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 56: setup();
	call	_setup
;	main.c: 57: gg();
	call	_gg
;	main.c: 58: while(1);
00102$:
	jra	00102$
;	main.c: 59: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__ttf_eng_a:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
__xinit__ttf_eng_b:
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x42	; 66	'B'
	.db #0x7c	; 124
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_eng_c:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__ttf_eng_d:
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_eng_e:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__ttf_eng_f:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
__xinit__ttf_eng_g:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x40	; 64
	.db #0x4e	; 78	'N'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__ttf_eng_h:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
__xinit__ttf_eng_i:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__ttf_eng_j:
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x6c	; 108	'l'
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_eng_k:
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x68	; 104	'h'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x68	; 104	'h'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
__xinit__ttf_eng_l:
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__ttf_eng_m:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x66	; 102	'f'
	.db #0x5a	; 90	'Z'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
__xinit__ttf_eng_n:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x62	; 98	'b'
	.db #0x52	; 82	'R'
	.db #0x4a	; 74	'J'
	.db #0x46	; 70	'F'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
__xinit__ttf_eng_o:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__ttf_eng_p:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
__xinit__ttf_eng_q:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0x00	; 0
__xinit__ttf_eng_r:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7c	; 124
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
__xinit__ttf_eng_s:
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3c	; 60
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_eng_t:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
__xinit__ttf_eng_u:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3e	; 62
	.db #0x00	; 0
__xinit__ttf_eng_v:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x00	; 0
__xinit__ttf_eng_w:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x5a	; 90	'Z'
	.db #0x5a	; 90	'Z'
	.db #0x24	; 36
	.db #0x00	; 0
__xinit__ttf_eng_x:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x22	; 34
	.db #0x42	; 66	'B'
	.db #0x00	; 0
__xinit__ttf_eng_y:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
__xinit__ttf_eng_z:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x7e	; 126
	.db #0x00	; 0
__xinit__I2C_IRQ:
	.db #0x00	; 0
__xinit__ttf_void:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__ttf_num_1:
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
__xinit__ttf_num_2:
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_num_3:
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x02	; 2
	.db #0x3c	; 60
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_num_4:
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
__xinit__ttf_num_5:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x00	; 0
__xinit__ttf_num_6:
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x00	; 0
__xinit__ttf_num_7:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x00	; 0
__xinit__ttf_num_8:
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x00	; 0
__xinit__ttf_num_9:
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x3c	; 60
	.db #0x00	; 0
__xinit__ttf_num_0:
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x46	; 70	'F'
	.db #0x4a	; 74	'J'
	.db #0x52	; 82	'R'
	.db #0x62	; 98	'b'
	.db #0x3c	; 60
	.db #0x00	; 0
__xinit__ttf_corner_left_up:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
__xinit__ttf_corner_right_up:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
__xinit__ttf_corner_left_down:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
__xinit__ttf_corner_right_down:
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
__xinit__ttf_line_right:
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
__xinit__ttf_line_left:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
__xinit__ttf_line_up:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__ttf_line_down:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
__xinit__main_buffer:
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x01	; 1
	.db #0x3d	; 61
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x01	; 1
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x1d	; 29
	.db #0x01	; 1
	.db #0x3d	; 61
	.db #0x11	; 17
	.db #0x3d	; 61
	.db #0x01	; 1
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x3d	; 61
	.db #0x25	; 37
	.db #0x3d	; 61
	.db #0x01	; 1
	.db #0x05	; 5
	.db #0x3d	; 61
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0xbf	; 191
	.db #0xbe	; 190
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xb3	; 179
	.db #0xb3	; 179
	.db #0xb3	; 179
	.db #0xb3	; 179
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb0	; 176
	.db #0xb0	; 176
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
__xinit__TIM2_IRQ:
	.db #0x00	; 0
	.area CABS (ABS)
