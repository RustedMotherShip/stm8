;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module i2c_lib
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _I2C_IRQ
	.globl _i2c_init
	.globl _i2c_start
	.globl _i2c_stop
	.globl _i2c_send_address
	.globl _i2c_read_byte
	.globl _i2c_read
	.globl _i2c_send_byte
	.globl _i2c_write
	.globl _i2c_scan
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_I2C_IRQ::
	.ds 1
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
;	libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void)
;	-----------------------------------------
;	 function i2c_read_byte
;	-----------------------------------------
_i2c_read_byte:
;	libs/i2c_lib.c: 52: while(!I2C_SR1 -> RXNE);
00101$:
	btjf	0x5217, #6, 00101$
;	libs/i2c_lib.c: 53: return I2C_DR -> DR;
	ld	a, 0x5216
;	libs/i2c_lib.c: 54: }
	ret
;	libs/i2c_lib.c: 56: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
;	-----------------------------------------
;	 function i2c_read
;	-----------------------------------------
_i2c_read:
	sub	sp, #4
;	libs/i2c_lib.c: 58: if(i2c_send_address(dev_addr, 1))//проверка на ACK
	push	#0x01
	call	_i2c_send_address
	tnz	a
	jreq	00103$
;	libs/i2c_lib.c: 60: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
	bset	0x5211, #2
;	libs/i2c_lib.c: 61: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
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
;	libs/i2c_lib.c: 63: data[i] = i2c_read_byte();//функция записи байта в элемент массива
	ldw	x, (0x08, sp)
	addw	x, (0x03, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	libs/i2c_lib.c: 61: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00105$
00101$:
;	libs/i2c_lib.c: 65: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
	ld	a, 0x5211
	and	a, #0xfb
	ld	0x5211, a
;	libs/i2c_lib.c: 67: data[size-1] = i2c_read_byte();
	ldw	x, (0x08, sp)
	addw	x, (0x01, sp)
	pushw	x
	call	_i2c_read_byte
	popw	x
	ld	(x), a
;	libs/i2c_lib.c: 69: i2c_stop();
	call	_i2c_stop
00103$:
;	libs/i2c_lib.c: 72: i2c_stop();
	ldw	x, (5, sp)
	ldw	(8, sp), x
	addw	sp, #7
;	libs/i2c_lib.c: 74: }
	jp	_i2c_stop
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
;	libs/i2c_lib.c: 81: return 1;
	ld	a, #0x01
	ret
00105$:
;	libs/i2c_lib.c: 82: return 0;//флаг ответа
	clr	a
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
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__I2C_IRQ:
	.db #0x00	; 0
	.area CABS (ABS)
