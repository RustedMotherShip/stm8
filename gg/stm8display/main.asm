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
	.globl _display_clean
	.globl _display_buffer_fill_entire
	.globl _display_init
	.globl _i2c_init
	.globl _I2C_IRQ
	.globl _splash
	.globl _buf_size
	.globl _buf_pos
	.globl _rx_buf_pointer
	.globl _tx_buf_pointer
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
;	main.c: 16: display_init();
	call	_display_init
;	main.c: 17: display_clean();
	call	_display_clean
;	main.c: 18: display_buffer_fill_entire(splash);
	ldw	x, #(_splash+0)
;	main.c: 20: }
	jp	_display_buffer_fill_entire
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
