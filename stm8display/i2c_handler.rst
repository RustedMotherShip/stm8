                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module i2c_handler
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _i2c_write
                                     12 	.globl _i2c_send_byte
                                     13 	.globl _i2c_stop
                                     14 	.globl _i2c_send_address
                                     15 	.globl _i2c_start
                                     16 	.globl _i2c_init
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	i2c_handler.c: 9: void i2c_init(void) {
                                     55 ;	-----------------------------------------
                                     56 ;	 function i2c_init
                                     57 ;	-----------------------------------------
      00802D                         58 _i2c_init:
                                     59 ;	i2c_handler.c: 12: I2C_CR1 -> PE = 0;      // PE=0, disable I2C before setup
      00802D 72 1F 52 10      [ 1]   60 	bres	0x5210, #7
                                     61 ;	i2c_handler.c: 13: I2C_FREQR -> FREQ = 16;                  // peripheral frequence =16MHz
      008031 C6 52 12         [ 1]   62 	ld	a, 0x5212
      008034 A4 03            [ 1]   63 	and	a, #0x03
      008036 AA 40            [ 1]   64 	or	a, #0x40
      008038 C7 52 12         [ 1]   65 	ld	0x5212, a
                                     66 ;	i2c_handler.c: 14: I2C_CCRH -> CCR = 0;                   // =0
      00803B C6 52 1C         [ 1]   67 	ld	a, 0x521c
      00803E A4 0F            [ 1]   68 	and	a, #0x0f
      008040 C7 52 1C         [ 1]   69 	ld	0x521c, a
                                     70 ;	i2c_handler.c: 15: I2C_CCRL -> CCR = 80;                  // 100kHz for I2C
      008043 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	i2c_handler.c: 16: I2C_CCRH -> FS = 0;    // set standart mode(100кHz)
      008047 72 11 52 1C      [ 1]   73 	bres	0x521c, #0
                                     74 ;	i2c_handler.c: 17: I2C_OARH -> ADDMODE = 0;    // 7-bit address mode
      00804B 72 11 52 14      [ 1]   75 	bres	0x5214, #0
                                     76 ;	i2c_handler.c: 18: I2C_OARH -> ADDCONF = 1;     // see reference manual
      00804F 72 12 52 14      [ 1]   77 	bset	0x5214, #1
                                     78 ;	i2c_handler.c: 19: I2C_CR1 -> PE = 1;      // PE=1, enable I2C
      008053 72 1E 52 10      [ 1]   79 	bset	0x5210, #7
                                     80 ;	i2c_handler.c: 20: }
      008057 81               [ 4]   81 	ret
                                     82 ;	i2c_handler.c: 23: void i2c_start(void) {
                                     83 ;	-----------------------------------------
                                     84 ;	 function i2c_start
                                     85 ;	-----------------------------------------
      008058                         86 _i2c_start:
                                     87 ;	i2c_handler.c: 24: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
      008058 72 1E 52 11      [ 1]   88 	bset	0x5211, #7
                                     89 ;	i2c_handler.c: 25: while(!(I2C_SR1 -> SB)); // Ожидание отправки стартового сигнала
      00805C                         90 00101$:
      00805C 72 0F 52 17 FB   [ 2]   91 	btjf	0x5217, #7, 00101$
                                     92 ;	i2c_handler.c: 26: }
      008061 81               [ 4]   93 	ret
                                     94 ;	i2c_handler.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) {
                                     95 ;	-----------------------------------------
                                     96 ;	 function i2c_send_address
                                     97 ;	-----------------------------------------
      008062                         98 _i2c_send_address:
                                     99 ;	i2c_handler.c: 33: address = address << 1;
      008062 48               [ 1]  100 	sll	a
                                    101 ;	i2c_handler.c: 30: switch(rw_type)
      008063 88               [ 1]  102 	push	a
      008064 7B 04            [ 1]  103 	ld	a, (0x04, sp)
      008066 4A               [ 1]  104 	dec	a
      008067 84               [ 1]  105 	pop	a
      008068 26 02            [ 1]  106 	jrne	00102$
                                    107 ;	i2c_handler.c: 33: address = address << 1;
                                    108 ;	i2c_handler.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
      00806A AA 01            [ 1]  109 	or	a, #0x01
                                    110 ;	i2c_handler.c: 35: break;
                                    111 ;	i2c_handler.c: 36: default:
                                    112 ;	i2c_handler.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
                                    113 ;	i2c_handler.c: 39: } 
      00806C                        114 00102$:
                                    115 ;	i2c_handler.c: 40: I2C_DR -> DR = address;
      00806C C7 52 16         [ 1]  116 	ld	0x5216, a
                                    117 ;	i2c_handler.c: 41: while (!(I2C_SR1 -> ADDR));//Ожидание отправки адреса
      00806F                        118 00104$:
      00806F 72 0D 52 17 FB   [ 2]  119 	btjf	0x5217, #6, 00104$
                                    120 ;	i2c_handler.c: 42: return I2C_SR2 -> AF;
      008074 C6 52 18         [ 1]  121 	ld	a, 0x5218
      008077 4E               [ 1]  122 	swap	a
      008078 44               [ 1]  123 	srl	a
      008079 A4 01            [ 1]  124 	and	a, #0x01
                                    125 ;	i2c_handler.c: 43: }
      00807B 85               [ 2]  126 	popw	x
      00807C 5B 01            [ 2]  127 	addw	sp, #1
      00807E FC               [ 2]  128 	jp	(x)
                                    129 ;	i2c_handler.c: 45: void i2c_stop(void) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function i2c_stop
                                    132 ;	-----------------------------------------
      00807F                        133 _i2c_stop:
                                    134 ;	i2c_handler.c: 46: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
      00807F 72 1C 52 11      [ 1]  135 	bset	0x5211, #6
                                    136 ;	i2c_handler.c: 47: }
      008083 81               [ 4]  137 	ret
                                    138 ;	i2c_handler.c: 48: uint8_t i2c_send_byte(uint8_t data){
                                    139 ;	-----------------------------------------
                                    140 ;	 function i2c_send_byte
                                    141 ;	-----------------------------------------
      008084                        142 _i2c_send_byte:
                                    143 ;	i2c_handler.c: 49: I2C_DR -> DR = data;
      008084 C7 52 16         [ 1]  144 	ld	0x5216, a
                                    145 ;	i2c_handler.c: 50: while (!(I2C_SR1 -> TXE) && !(I2C_SR1 -> BTF));
      008087                        146 00102$:
      008087 72 00 52 17 05   [ 2]  147 	btjt	0x5217, #0, 00104$
      00808C 72 0B 52 17 F6   [ 2]  148 	btjf	0x5217, #5, 00102$
      008091                        149 00104$:
                                    150 ;	i2c_handler.c: 51: return I2C_SR2 -> AF;
      008091 C6 52 18         [ 1]  151 	ld	a, 0x5218
      008094 4E               [ 1]  152 	swap	a
      008095 44               [ 1]  153 	srl	a
      008096 A4 01            [ 1]  154 	and	a, #0x01
                                    155 ;	i2c_handler.c: 52: }
      008098 81               [ 4]  156 	ret
                                    157 ;	i2c_handler.c: 53: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data){
                                    158 ;	-----------------------------------------
                                    159 ;	 function i2c_write
                                    160 ;	-----------------------------------------
      008099                        161 _i2c_write:
      008099 52 02            [ 2]  162 	sub	sp, #2
                                    163 ;	i2c_handler.c: 54: i2c_start();
      00809B 88               [ 1]  164 	push	a
      00809C CD 80 58         [ 4]  165 	call	_i2c_start
      00809F 84               [ 1]  166 	pop	a
                                    167 ;	i2c_handler.c: 55: if(!i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      0080A0 4B 00            [ 1]  168 	push	#0x00
      0080A2 CD 80 62         [ 4]  169 	call	_i2c_send_address
      0080A5 4D               [ 1]  170 	tnz	a
      0080A6 26 1D            [ 1]  171 	jrne	00105$
                                    172 ;	i2c_handler.c: 56: for(int i = 0;i < size;i++)
      0080A8 5F               [ 1]  173 	clrw	x
      0080A9                        174 00107$:
      0080A9 7B 05            [ 1]  175 	ld	a, (0x05, sp)
      0080AB 6B 02            [ 1]  176 	ld	(0x02, sp), a
      0080AD 0F 01            [ 1]  177 	clr	(0x01, sp)
      0080AF 13 01            [ 2]  178 	cpw	x, (0x01, sp)
      0080B1 2E 12            [ 1]  179 	jrsge	00105$
                                    180 ;	i2c_handler.c: 58: if(i2c_send_byte(data[i])) //Проверка на АСК бит
      0080B3 90 93            [ 1]  181 	ldw	y, x
      0080B5 72 F9 06         [ 2]  182 	addw	y, (0x06, sp)
      0080B8 90 F6            [ 1]  183 	ld	a, (y)
      0080BA 89               [ 2]  184 	pushw	x
      0080BB CD 80 84         [ 4]  185 	call	_i2c_send_byte
      0080BE 85               [ 2]  186 	popw	x
      0080BF 4D               [ 1]  187 	tnz	a
      0080C0 26 03            [ 1]  188 	jrne	00105$
                                    189 ;	i2c_handler.c: 56: for(int i = 0;i < size;i++)
      0080C2 5C               [ 1]  190 	incw	x
      0080C3 20 E4            [ 2]  191 	jra	00107$
      0080C5                        192 00105$:
                                    193 ;	i2c_handler.c: 61: i2c_stop();
      0080C5 1E 03            [ 2]  194 	ldw	x, (3, sp)
      0080C7 1F 06            [ 2]  195 	ldw	(6, sp), x
      0080C9 5B 05            [ 2]  196 	addw	sp, #5
                                    197 ;	i2c_handler.c: 62: }
      0080CB CC 80 7F         [ 2]  198 	jp	_i2c_stop
                                    199 	.area CODE
                                    200 	.area CONST
                                    201 	.area INITIALIZER
                                    202 	.area CABS (ABS)
