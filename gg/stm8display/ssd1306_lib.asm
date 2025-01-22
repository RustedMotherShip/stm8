;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module ssd1306_lib
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bit
	.globl _get_bit
	.globl _i2c_write
	.globl _display_init
	.globl _display_set_params_to_write
	.globl _display_draw_pixel
	.globl _display_buffer_fill_entire
	.globl _display_clean
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
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
;	libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
;	-----------------------------------------
;	 function get_bit
;	-----------------------------------------
_get_bit:
;	libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
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
;	libs/ssd1306_lib.c: 6: }
	popw	y
	addw	sp, #2
	jp	(y)
;	libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
;	-----------------------------------------
;	 function set_bit
;	-----------------------------------------
_set_bit:
	sub	sp, #4
	ldw	(0x01, sp), x
;	libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
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
;	libs/ssd1306_lib.c: 10: switch(value)
	ldw	x, (0x09, sp)
	decw	x
	jrne	00102$
;	libs/ssd1306_lib.c: 13: data |= mask;
	ld	a, (0x02, sp)
	or	a, (0x04, sp)
	ld	xl, a
	ld	a, (0x01, sp)
	or	a, (0x03, sp)
;	libs/ssd1306_lib.c: 14: break;
	jra	00103$
;	libs/ssd1306_lib.c: 16: default:
00102$:
;	libs/ssd1306_lib.c: 17: data &= ~mask;
	ldw	x, (0x03, sp)
	cplw	x
	ld	a, xl
	and	a, (0x02, sp)
	rlwa	x
	and	a, (0x01, sp)
;	libs/ssd1306_lib.c: 19: }
00103$:
;	libs/ssd1306_lib.c: 20: return data;
	ld	xh, a
;	libs/ssd1306_lib.c: 21: }
	ldw	y, (5, sp)
	addw	sp, #10
	jp	(y)
;	libs/ssd1306_lib.c: 23: void display_init(void)
;	-----------------------------------------
;	 function display_init
;	-----------------------------------------
_display_init:
	sub	sp, #7
;	libs/ssd1306_lib.c: 25: uint8_t setup_buf[7] = {0x00,0xAE,0xD5,0x80,0xA8,0x1F,0xAF};
	clr	(0x01, sp)
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
	ld	a, #0xaf
	ld	(0x07, sp), a
;	libs/ssd1306_lib.c: 26: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x05
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 27: setup_buf[1] = 0x1F;
	ld	a, #0x1f
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 28: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 29: setup_buf[1] = 0xD3;
	ld	a, #0xd3
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 30: setup_buf[2] = 0x00;
	clr	(0x03, sp)
;	libs/ssd1306_lib.c: 31: setup_buf[3] = 0x40;
	ld	a, #0x40
	ld	(0x04, sp), a
;	libs/ssd1306_lib.c: 32: setup_buf[4] = 0x8D;
	ld	a, #0x8d
	ld	(0x05, sp), a
;	libs/ssd1306_lib.c: 33: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x05
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 34: setup_buf[1] = 0x14;
	ld	a, #0x14
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 35: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 36: setup_buf[1] = 0xDB;
	ld	a, #0xdb
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 37: setup_buf[2] = 0x40;
	ld	a, #0x40
	ld	(0x03, sp), a
;	libs/ssd1306_lib.c: 38: setup_buf[3] = 0xA4;
	ld	a, #0xa4
	ld	(0x04, sp), a
;	libs/ssd1306_lib.c: 39: setup_buf[4] = 0xA6;
	ld	a, #0xa6
	ld	(0x05, sp), a
;	libs/ssd1306_lib.c: 40: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x05
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 41: setup_buf[1] = 0xDA;
	ld	a, #0xda
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 42: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 43: setup_buf[1] = 0x02;
	ld	a, #0x02
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 44: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 45: setup_buf[1] = 0x81;
	ld	a, #0x81
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 46: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 47: setup_buf[1] = 0x8F;
	ld	a, #0x8f
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 48: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 49: setup_buf[1] = 0xD9;
	ld	a, #0xd9
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 50: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 51: setup_buf[1] = 0xF1;
	ld	a, #0xf1
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 52: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x02
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 53: setup_buf[1] = 0x20;
	ld	a, #0x20
	ld	(0x02, sp), a
;	libs/ssd1306_lib.c: 54: setup_buf[2] = 0x00;
	clr	(0x03, sp)
;	libs/ssd1306_lib.c: 55: setup_buf[3] = 0xA1;
	ld	a, #0xa1
	ld	(0x04, sp), a
;	libs/ssd1306_lib.c: 56: setup_buf[4] = 0xC8;
	ld	a, #0xc8
	ld	(0x05, sp), a
;	libs/ssd1306_lib.c: 57: i2c_write(I2C_DISPLAY_ADDR,7,setup_buf);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x07
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 58: }
	addw	sp, #7
	ret
;	libs/ssd1306_lib.c: 60: void display_set_params_to_write(void)
;	-----------------------------------------
;	 function display_set_params_to_write
;	-----------------------------------------
_display_set_params_to_write:
	sub	sp, #8
;	libs/ssd1306_lib.c: 62: uint8_t set_params_buf[8] = {0x00,0x22,0x00,0x03,0x00,0x21,0x00,0x7F};
	ldw	x, sp
	incw	x
	clr	(x)
	ld	a, #0x22
	ld	(0x02, sp), a
	clr	(0x03, sp)
	ld	a, #0x03
	ld	(0x04, sp), a
	clr	(0x05, sp)
	ld	a, #0x21
	ld	(0x06, sp), a
	clr	(0x07, sp)
	ld	a, #0x7f
	ld	(0x08, sp), a
;	libs/ssd1306_lib.c: 63: i2c_write(I2C_DISPLAY_ADDR,8,set_params_buf);
	pushw	x
	push	#0x08
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 64: }
	addw	sp, #8
	ret
;	libs/ssd1306_lib.c: 71: void display_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
;	-----------------------------------------
;	 function display_draw_pixel
;	-----------------------------------------
_display_draw_pixel:
	sub	sp, #8
	ldw	(0x07, sp), x
;	libs/ssd1306_lib.c: 73: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
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
;	libs/ssd1306_lib.c: 74: }
	ldw	x, (9, sp)
	addw	sp, #12
	jp	(x)
;	libs/ssd1306_lib.c: 76: void display_buffer_fill_entire(uint8_t *in_data)
;	-----------------------------------------
;	 function display_buffer_fill_entire
;	-----------------------------------------
_display_buffer_fill_entire:
	sub	sp, #141
	ldw	(0x86, sp), x
;	libs/ssd1306_lib.c: 79: display_set_params_to_write();
	call	_display_set_params_to_write
;	libs/ssd1306_lib.c: 80: uint8_t part[129]={0x40};
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
;	libs/ssd1306_lib.c: 82: for(int page = 0;page <= 384;page+=128)
	clrw	x
	ldw	(0x88, sp), x
00111$:
	ldw	x, (0x88, sp)
	cpw	x, #0x0180
	jrsle	00160$
	jp	00113$
00160$:
;	libs/ssd1306_lib.c: 84: for (int height = 0; height < 8; height++) 
	clrw	x
	ldw	(0x8a, sp), x
00108$:
	ldw	x, (0x8a, sp)
	cpw	x, #0x0008
	jrsge	00102$
;	libs/ssd1306_lib.c: 86: for (int width = 0; width < 128; width++) 
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
;	libs/ssd1306_lib.c: 88: display_draw_pixel(&part[1], width, height, get_bit(in_data[page+(height*16) + (width / 8)], 7 - (width % 8)));
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
	call	_display_draw_pixel
;	libs/ssd1306_lib.c: 86: for (int width = 0; width < 128; width++) 
	ldw	x, (0x8c, sp)
	incw	x
	ldw	(0x8c, sp), x
	jra	00105$
00109$:
;	libs/ssd1306_lib.c: 84: for (int height = 0; height < 8; height++) 
	ldw	x, (0x8a, sp)
	incw	x
	ldw	(0x8a, sp), x
	jra	00108$
00102$:
;	libs/ssd1306_lib.c: 91: i2c_write(I2C_DISPLAY_ADDR, 129, part);
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x81
	ld	a, #0x3c
	call	_i2c_write
;	libs/ssd1306_lib.c: 82: for(int page = 0;page <= 384;page+=128)
	ldw	x, (0x88, sp)
	addw	x, #0x0080
	ldw	(0x88, sp), x
	jp	00111$
00113$:
;	libs/ssd1306_lib.c: 93: }
	addw	sp, #141
	ret
;	libs/ssd1306_lib.c: 95: void display_clean(void)
;	-----------------------------------------
;	 function display_clean
;	-----------------------------------------
_display_clean:
	sub	sp, #129
;	libs/ssd1306_lib.c: 97: uint8_t clean_buf[129] = {0x40};
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
;	libs/ssd1306_lib.c: 99: display_set_params_to_write();
	call	_display_set_params_to_write
;	libs/ssd1306_lib.c: 101: for(int i = 0;i<4;i++)
	clr	a
00103$:
	cp	a, #0x04
	jrnc	00105$
;	libs/ssd1306_lib.c: 102: i2c_write(I2C_DISPLAY_ADDR,129,clean_buf);
	push	a
	ldw	x, sp
	incw	x
	incw	x
	pushw	x
	push	#0x81
	ld	a, #0x3c
	call	_i2c_write
	pop	a
;	libs/ssd1306_lib.c: 101: for(int i = 0;i<4;i++)
	inc	a
	jra	00103$
00105$:
;	libs/ssd1306_lib.c: 104: }
	addw	sp, #129
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
