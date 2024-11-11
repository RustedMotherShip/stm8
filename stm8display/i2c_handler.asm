;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module i2c_handler
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _i2c_write
	.globl _i2c_send_byte
	.globl _i2c_stop
	.globl _i2c_send_address
	.globl _i2c_start
	.globl _i2c_init
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
;	i2c_handler.c: 9: void i2c_init(void) {
;	-----------------------------------------
;	 function i2c_init
;	-----------------------------------------
_i2c_init:
;	i2c_handler.c: 12: I2C_CR1 -> PE = 0;      // PE=0, disable I2C before setup
	bres	0x5210, #7
;	i2c_handler.c: 13: I2C_FREQR -> FREQ = 16;                  // peripheral frequence =16MHz
	ld	a, 0x5212
	and	a, #0x03
	or	a, #0x40
	ld	0x5212, a
;	i2c_handler.c: 14: I2C_CCRH -> CCR = 0;                   // =0
	ld	a, 0x521c
	and	a, #0x0f
	ld	0x521c, a
;	i2c_handler.c: 15: I2C_CCRL -> CCR = 80;                  // 100kHz for I2C
	mov	0x521b+0, #0x50
;	i2c_handler.c: 16: I2C_CCRH -> FS = 0;    // set standart mode(100кHz)
	bres	0x521c, #0
;	i2c_handler.c: 17: I2C_OARH -> ADDMODE = 0;    // 7-bit address mode
	bres	0x5214, #0
;	i2c_handler.c: 18: I2C_OARH -> ADDCONF = 1;     // see reference manual
	bset	0x5214, #1
;	i2c_handler.c: 19: I2C_CR1 -> PE = 1;      // PE=1, enable I2C
	bset	0x5210, #7
;	i2c_handler.c: 20: }
	ret
;	i2c_handler.c: 23: void i2c_start(void) {
;	-----------------------------------------
;	 function i2c_start
;	-----------------------------------------
_i2c_start:
;	i2c_handler.c: 24: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
	bset	0x5211, #7
;	i2c_handler.c: 25: while(!(I2C_SR1 -> SB)); // Ожидание отправки стартового сигнала
00101$:
	btjf	0x5217, #7, 00101$
;	i2c_handler.c: 26: }
	ret
;	i2c_handler.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) {
;	-----------------------------------------
;	 function i2c_send_address
;	-----------------------------------------
_i2c_send_address:
;	i2c_handler.c: 33: address = address << 1;
	sll	a
;	i2c_handler.c: 30: switch(rw_type)
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00102$
;	i2c_handler.c: 33: address = address << 1;
;	i2c_handler.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
	or	a, #0x01
;	i2c_handler.c: 35: break;
;	i2c_handler.c: 36: default:
;	i2c_handler.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
;	i2c_handler.c: 39: } 
00102$:
;	i2c_handler.c: 40: I2C_DR -> DR = address;
	ld	0x5216, a
;	i2c_handler.c: 41: while (!(I2C_SR1 -> ADDR));//Ожидание отправки адреса
00104$:
	btjf	0x5217, #6, 00104$
;	i2c_handler.c: 42: return I2C_SR2 -> AF;
	ld	a, 0x5218
	swap	a
	srl	a
	and	a, #0x01
;	i2c_handler.c: 43: }
	popw	x
	addw	sp, #1
	jp	(x)
;	i2c_handler.c: 45: void i2c_stop(void) {
;	-----------------------------------------
;	 function i2c_stop
;	-----------------------------------------
_i2c_stop:
;	i2c_handler.c: 46: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
	bset	0x5211, #6
;	i2c_handler.c: 47: }
	ret
;	i2c_handler.c: 48: uint8_t i2c_send_byte(uint8_t data){
;	-----------------------------------------
;	 function i2c_send_byte
;	-----------------------------------------
_i2c_send_byte:
;	i2c_handler.c: 49: I2C_DR -> DR = data;
	ld	0x5216, a
;	i2c_handler.c: 50: while (!(I2C_SR1 -> TXE) && !(I2C_SR1 -> BTF));
00102$:
	btjt	0x5217, #0, 00104$
	btjf	0x5217, #5, 00102$
00104$:
;	i2c_handler.c: 51: return I2C_SR2 -> AF;
	ld	a, 0x5218
	swap	a
	srl	a
	and	a, #0x01
;	i2c_handler.c: 52: }
	ret
;	i2c_handler.c: 53: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data){
;	-----------------------------------------
;	 function i2c_write
;	-----------------------------------------
_i2c_write:
	sub	sp, #2
;	i2c_handler.c: 54: i2c_start();
	push	a
	call	_i2c_start
	pop	a
;	i2c_handler.c: 55: if(!i2c_send_address(dev_addr, 0))//Проверка на АСК бит
	push	#0x00
	call	_i2c_send_address
	tnz	a
	jrne	00105$
;	i2c_handler.c: 56: for(int i = 0;i < size;i++)
	clrw	x
00107$:
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrsge	00105$
;	i2c_handler.c: 58: if(i2c_send_byte(data[i])) //Проверка на АСК бит
	ldw	y, x
	addw	y, (0x06, sp)
	ld	a, (y)
	pushw	x
	call	_i2c_send_byte
	popw	x
	tnz	a
	jrne	00105$
;	i2c_handler.c: 56: for(int i = 0;i < size;i++)
	incw	x
	jra	00107$
00105$:
;	i2c_handler.c: 61: i2c_stop();
	ldw	x, (3, sp)
	ldw	(6, sp), x
	addw	sp, #5
;	i2c_handler.c: 62: }
	jp	_i2c_stop
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
