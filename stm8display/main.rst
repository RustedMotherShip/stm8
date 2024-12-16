                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _setup
                                     13 	.globl _uart_read
                                     14 	.globl _uart_write_byte
                                     15 	.globl _uart_read_byte
                                     16 	.globl _uart_init
                                     17 	.globl _uart_reciever_irq
                                     18 	.globl _uart_transmission_irq
                                     19 	.globl _i2c_scan
                                     20 	.globl _i2c_read
                                     21 	.globl _i2c_write
                                     22 	.globl _i2c_send_address
                                     23 	.globl _i2c_read_byte
                                     24 	.globl _i2c_send_byte
                                     25 	.globl _i2c_stop
                                     26 	.globl _i2c_start
                                     27 	.globl _i2c_init
                                     28 	.globl _i2c_irq
                                     29 	.globl _delay
                                     30 	.globl _dummy
                                     31 	.globl _counter
                                     32 	.globl _govno_alert
                                     33 	.globl _I2C_IRQ
                                     34 	.globl _buf_size
                                     35 	.globl _buf_pos
                                     36 	.globl _rx_buf_pointer
                                     37 	.globl _tx_buf_pointer
                                     38 	.globl _uart_write
                                     39 ;--------------------------------------------------------
                                     40 ; ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area DATA
      000001                         43 _tx_buf_pointer::
      000001                         44 	.ds 2
      000003                         45 _rx_buf_pointer::
      000003                         46 	.ds 2
      000005                         47 _buf_pos::
      000005                         48 	.ds 1
      000006                         49 _buf_size::
      000006                         50 	.ds 1
                                     51 ;--------------------------------------------------------
                                     52 ; ram data
                                     53 ;--------------------------------------------------------
                                     54 	.area INITIALIZED
      000007                         55 _I2C_IRQ::
      000007                         56 	.ds 1
      000008                         57 _govno_alert::
      000008                         58 	.ds 1
      000009                         59 _counter::
      000009                         60 	.ds 1
      00000A                         61 _dummy::
      00000A                         62 	.ds 1
                                     63 ;--------------------------------------------------------
                                     64 ; Stack segment in internal ram
                                     65 ;--------------------------------------------------------
                                     66 	.area SSEG
      00000B                         67 __start__stack:
      00000B                         68 	.ds	1
                                     69 
                                     70 ;--------------------------------------------------------
                                     71 ; absolute external ram data
                                     72 ;--------------------------------------------------------
                                     73 	.area DABS (ABS)
                                     74 
                                     75 ; default segment ordering for linker
                                     76 	.area HOME
                                     77 	.area GSINIT
                                     78 	.area GSFINAL
                                     79 	.area CONST
                                     80 	.area INITIALIZER
                                     81 	.area CODE
                                     82 
                                     83 ;--------------------------------------------------------
                                     84 ; interrupt vector
                                     85 ;--------------------------------------------------------
                                     86 	.area HOME
      008000                         87 __interrupt_vect:
      008000 82 00 80 5B             88 	int s_GSINIT ; reset
      008004 82 00 00 00             89 	int 0x000000 ; trap
      008008 82 00 00 00             90 	int 0x000000 ; int0
      00800C 82 00 00 00             91 	int 0x000000 ; int1
      008010 82 00 00 00             92 	int 0x000000 ; int2
      008014 82 00 00 00             93 	int 0x000000 ; int3
      008018 82 00 00 00             94 	int 0x000000 ; int4
      00801C 82 00 00 00             95 	int 0x000000 ; int5
      008020 82 00 00 00             96 	int 0x000000 ; int6
      008024 82 00 00 00             97 	int 0x000000 ; int7
      008028 82 00 00 00             98 	int 0x000000 ; int8
      00802C 82 00 00 00             99 	int 0x000000 ; int9
      008030 82 00 00 00            100 	int 0x000000 ; int10
      008034 82 00 00 00            101 	int 0x000000 ; int11
      008038 82 00 00 00            102 	int 0x000000 ; int12
      00803C 82 00 00 00            103 	int 0x000000 ; int13
      008040 82 00 00 00            104 	int 0x000000 ; int14
      008044 82 00 00 00            105 	int 0x000000 ; int15
      008048 82 00 00 00            106 	int 0x000000 ; int16
      00804C 82 00 82 98            107 	int _uart_transmission_irq ; int17
      008050 82 00 82 D4            108 	int _uart_reciever_irq ; int18
      008054 82 00 80 B8            109 	int _i2c_irq ; int19
                                    110 ;--------------------------------------------------------
                                    111 ; global & static initialisations
                                    112 ;--------------------------------------------------------
                                    113 	.area HOME
                                    114 	.area GSINIT
                                    115 	.area GSFINAL
                                    116 	.area GSINIT
      00805B CD 84 C9         [ 4]  117 	call	___sdcc_external_startup
      00805E 4D               [ 1]  118 	tnz	a
      00805F 27 03            [ 1]  119 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  120 	jp	__sdcc_program_startup
      008064                        121 __sdcc_init_data:
                                    122 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  123 	ldw x, #l_DATA
      008067 27 07            [ 1]  124 	jreq	00002$
      008069                        125 00001$:
      008069 72 4F 00 00      [ 1]  126 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  127 	decw x
      00806E 26 F9            [ 1]  128 	jrne	00001$
      008070                        129 00002$:
      008070 AE 00 04         [ 2]  130 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  131 	jreq	00004$
      008075                        132 00003$:
      008075 D6 80 A9         [ 1]  133 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  134 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  135 	decw	x
      00807C 26 F7            [ 1]  136 	jrne	00003$
      00807E                        137 00004$:
                                    138 ; stm8_genXINIT() end
                                    139 	.area GSFINAL
      00807E CC 80 58         [ 2]  140 	jp	__sdcc_program_startup
                                    141 ;--------------------------------------------------------
                                    142 ; Home
                                    143 ;--------------------------------------------------------
                                    144 	.area HOME
                                    145 	.area HOME
      008058                        146 __sdcc_program_startup:
      008058 CC 84 8C         [ 2]  147 	jp	_main
                                    148 ;	return from main will return to caller
                                    149 ;--------------------------------------------------------
                                    150 ; code
                                    151 ;--------------------------------------------------------
                                    152 	.area CODE
                                    153 ;	libs/i2c_lib.c: 5: void delay(uint16_t ticks)
                                    154 ;	-----------------------------------------
                                    155 ;	 function delay
                                    156 ;	-----------------------------------------
      0080AE                        157 _delay:
                                    158 ;	libs/i2c_lib.c: 7: while(ticks > 0)
      0080AE                        159 00101$:
      0080AE 5D               [ 2]  160 	tnzw	x
      0080AF 26 01            [ 1]  161 	jrne	00120$
      0080B1 81               [ 4]  162 	ret
      0080B2                        163 00120$:
                                    164 ;	libs/i2c_lib.c: 9: ticks-=2;
      0080B2 5A               [ 2]  165 	decw	x
      0080B3 5A               [ 2]  166 	decw	x
                                    167 ;	libs/i2c_lib.c: 10: ticks+=1;
      0080B4 5C               [ 1]  168 	incw	x
      0080B5 20 F7            [ 2]  169 	jra	00101$
                                    170 ;	libs/i2c_lib.c: 12: }
      0080B7 81               [ 4]  171 	ret
                                    172 ;	libs/i2c_lib.c: 14: void i2c_irq(void) __interrupt(I2C_vector)
                                    173 ;	-----------------------------------------
                                    174 ;	 function i2c_irq
                                    175 ;	-----------------------------------------
      0080B8                        176 _i2c_irq:
      0080B8 4F               [ 1]  177 	clr	a
      0080B9 62               [ 2]  178 	div	x, a
                                    179 ;	libs/i2c_lib.c: 17: disableInterrupts();
      0080BA 9B               [ 1]  180 	sim
                                    181 ;	libs/i2c_lib.c: 18: I2C_IRQ.all = 0;//обнуление флагов регистров
      0080BB 35 00 00 07      [ 1]  182 	mov	_I2C_IRQ+0, #0x00
                                    183 ;	libs/i2c_lib.c: 20: if(I2C_SR1 -> ADDR)//прерывание адреса
      0080BF AE 52 17         [ 2]  184 	ldw	x, #0x5217
      0080C2 F6               [ 1]  185 	ld	a, (x)
      0080C3 44               [ 1]  186 	srl	a
      0080C4 A4 01            [ 1]  187 	and	a, #0x01
      0080C6 27 10            [ 1]  188 	jreq	00102$
                                    189 ;	libs/i2c_lib.c: 22: clr_sr1();
      0080C8 C6 52 17         [ 1]  190 	ld	a,0x5217
                                    191 ;	libs/i2c_lib.c: 23: I2C_IRQ.ADDR = 1;
      0080CB 72 12 00 07      [ 1]  192 	bset	_I2C_IRQ+0, #1
                                    193 ;	libs/i2c_lib.c: 24: clr_sr3();//EV6
      0080CF C6 52 19         [ 1]  194 	ld	a,0x5219
                                    195 ;	libs/i2c_lib.c: 25: I2C_ITR -> ITEVTEN = 0;
      0080D2 72 13 52 1A      [ 1]  196 	bres	0x521a, #1
                                    197 ;	libs/i2c_lib.c: 26: return;
      0080D6 20 6A            [ 2]  198 	jra	00113$
      0080D8                        199 00102$:
                                    200 ;	libs/i2c_lib.c: 28: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      0080D8 C6 52 17         [ 1]  201 	ld	a, 0x5217
      0080DB A5 01            [ 1]  202 	bcp	a, #0x01
      0080DD 27 0A            [ 1]  203 	jreq	00104$
                                    204 ;	libs/i2c_lib.c: 30: I2C_IRQ.SB = 1;
      0080DF 72 10 00 07      [ 1]  205 	bset	_I2C_IRQ+0, #0
                                    206 ;	libs/i2c_lib.c: 31: I2C_ITR -> ITEVTEN = 0;
      0080E3 72 13 52 1A      [ 1]  207 	bres	0x521a, #1
                                    208 ;	libs/i2c_lib.c: 32: return;
      0080E7 20 59            [ 2]  209 	jra	00113$
      0080E9                        210 00104$:
                                    211 ;	libs/i2c_lib.c: 34: if(I2C_SR1 -> BTF) //прерывание отправки данных
      0080E9 C6 52 17         [ 1]  212 	ld	a, 0x5217
      0080EC 44               [ 1]  213 	srl	a
      0080ED 44               [ 1]  214 	srl	a
      0080EE A5 01            [ 1]  215 	bcp	a, #0x01
      0080F0 27 0A            [ 1]  216 	jreq	00106$
                                    217 ;	libs/i2c_lib.c: 36: I2C_IRQ.BTF = 1;
      0080F2 72 14 00 07      [ 1]  218 	bset	_I2C_IRQ+0, #2
                                    219 ;	libs/i2c_lib.c: 37: I2C_ITR -> ITEVTEN = 0;
      0080F6 72 13 52 1A      [ 1]  220 	bres	0x521a, #1
                                    221 ;	libs/i2c_lib.c: 38: return;
      0080FA 20 46            [ 2]  222 	jra	00113$
      0080FC                        223 00106$:
                                    224 ;	libs/i2c_lib.c: 40: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      0080FC C6 52 17         [ 1]  225 	ld	a, 0x5217
      0080FF 4E               [ 1]  226 	swap	a
      008100 44               [ 1]  227 	srl	a
      008101 44               [ 1]  228 	srl	a
      008102 44               [ 1]  229 	srl	a
      008103 A5 01            [ 1]  230 	bcp	a, #0x01
      008105 27 0A            [ 1]  231 	jreq	00108$
                                    232 ;	libs/i2c_lib.c: 42: I2C_IRQ.TXE = 1;
      008107 72 18 00 07      [ 1]  233 	bset	_I2C_IRQ+0, #4
                                    234 ;	libs/i2c_lib.c: 43: I2C_ITR -> ITBUFEN = 0;
      00810B 72 15 52 1A      [ 1]  235 	bres	0x521a, #2
                                    236 ;	libs/i2c_lib.c: 44: return;
      00810F 20 31            [ 2]  237 	jra	00113$
      008111                        238 00108$:
                                    239 ;	libs/i2c_lib.c: 46: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      008111 C6 52 17         [ 1]  240 	ld	a, 0x5217
      008114 4E               [ 1]  241 	swap	a
      008115 44               [ 1]  242 	srl	a
      008116 44               [ 1]  243 	srl	a
      008117 A5 01            [ 1]  244 	bcp	a, #0x01
      008119 27 0A            [ 1]  245 	jreq	00110$
                                    246 ;	libs/i2c_lib.c: 48: I2C_IRQ.RXNE = 1;
      00811B 72 16 00 07      [ 1]  247 	bset	_I2C_IRQ+0, #3
                                    248 ;	libs/i2c_lib.c: 49: I2C_ITR -> ITBUFEN = 0;
      00811F 72 15 52 1A      [ 1]  249 	bres	0x521a, #2
                                    250 ;	libs/i2c_lib.c: 50: return;
      008123 20 1D            [ 2]  251 	jra	00113$
      008125                        252 00110$:
                                    253 ;	libs/i2c_lib.c: 52: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      008125 AE 52 18         [ 2]  254 	ldw	x, #0x5218
      008128 F6               [ 1]  255 	ld	a, (x)
      008129 44               [ 1]  256 	srl	a
      00812A 44               [ 1]  257 	srl	a
      00812B A4 01            [ 1]  258 	and	a, #0x01
      00812D 27 12            [ 1]  259 	jreq	00112$
                                    260 ;	libs/i2c_lib.c: 54: I2C_IRQ.AF = 1;
      00812F 72 1A 00 07      [ 1]  261 	bset	_I2C_IRQ+0, #5
                                    262 ;	libs/i2c_lib.c: 55: I2C_ITR -> ITEVTEN = 0;
      008133 72 13 52 1A      [ 1]  263 	bres	0x521a, #1
                                    264 ;	libs/i2c_lib.c: 56: I2C_ITR -> ITERREN = 0;
      008137 72 11 52 1A      [ 1]  265 	bres	0x521a, #0
                                    266 ;	libs/i2c_lib.c: 57: I2C_ITR -> ITBUFEN = 0;
      00813B 72 15 52 1A      [ 1]  267 	bres	0x521a, #2
                                    268 ;	libs/i2c_lib.c: 58: return;
      00813F 20 01            [ 2]  269 	jra	00113$
      008141                        270 00112$:
                                    271 ;	libs/i2c_lib.c: 60: enableInterrupts(); 
      008141 9A               [ 1]  272 	rim
      008142                        273 00113$:
                                    274 ;	libs/i2c_lib.c: 61: }
      008142 80               [11]  275 	iret
                                    276 ;	libs/i2c_lib.c: 62: void i2c_init(void)
                                    277 ;	-----------------------------------------
                                    278 ;	 function i2c_init
                                    279 ;	-----------------------------------------
      008143                        280 _i2c_init:
                                    281 ;	libs/i2c_lib.c: 66: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      008143 72 11 52 10      [ 1]  282 	bres	0x5210, #0
                                    283 ;	libs/i2c_lib.c: 67: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      008147 C6 52 12         [ 1]  284 	ld	a, 0x5212
      00814A A4 C0            [ 1]  285 	and	a, #0xc0
      00814C AA 10            [ 1]  286 	or	a, #0x10
      00814E C7 52 12         [ 1]  287 	ld	0x5212, a
                                    288 ;	libs/i2c_lib.c: 68: I2C_CCRH -> CCR = 0;// =0
      008151 C6 52 1C         [ 1]  289 	ld	a, 0x521c
      008154 A4 F0            [ 1]  290 	and	a, #0xf0
      008156 C7 52 1C         [ 1]  291 	ld	0x521c, a
                                    292 ;	libs/i2c_lib.c: 69: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008159 35 50 52 1B      [ 1]  293 	mov	0x521b+0, #0x50
                                    294 ;	libs/i2c_lib.c: 70: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      00815D 72 1F 52 1C      [ 1]  295 	bres	0x521c, #7
                                    296 ;	libs/i2c_lib.c: 71: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      008161 72 1F 52 14      [ 1]  297 	bres	0x5214, #7
                                    298 ;	libs/i2c_lib.c: 72: I2C_OARH -> ADDCONF = 1;// see reference manual
      008165 72 10 52 14      [ 1]  299 	bset	0x5214, #0
                                    300 ;	libs/i2c_lib.c: 73: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      008169 72 10 52 10      [ 1]  301 	bset	0x5210, #0
                                    302 ;	libs/i2c_lib.c: 74: }
      00816D 81               [ 4]  303 	ret
                                    304 ;	libs/i2c_lib.c: 76: void i2c_start(void)
                                    305 ;	-----------------------------------------
                                    306 ;	 function i2c_start
                                    307 ;	-----------------------------------------
      00816E                        308 _i2c_start:
                                    309 ;	libs/i2c_lib.c: 79: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      00816E 72 12 52 1A      [ 1]  310 	bset	0x521a, #1
                                    311 ;	libs/i2c_lib.c: 80: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      008172 72 10 52 11      [ 1]  312 	bset	0x5211, #0
                                    313 ;	libs/i2c_lib.c: 81: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      008176                        314 00101$:
      008176 C6 52 1A         [ 1]  315 	ld	a, 0x521a
      008179 A5 02            [ 1]  316 	bcp	a, #2
      00817B 26 F9            [ 1]  317 	jrne	00101$
                                    318 ;	libs/i2c_lib.c: 82: }
      00817D 81               [ 4]  319 	ret
                                    320 ;	libs/i2c_lib.c: 84: void i2c_stop(void)
                                    321 ;	-----------------------------------------
                                    322 ;	 function i2c_stop
                                    323 ;	-----------------------------------------
      00817E                        324 _i2c_stop:
                                    325 ;	libs/i2c_lib.c: 86: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      00817E 72 12 52 11      [ 1]  326 	bset	0x5211, #1
                                    327 ;	libs/i2c_lib.c: 87: }
      008182 81               [ 4]  328 	ret
                                    329 ;	libs/i2c_lib.c: 89: uint8_t i2c_send_byte(unsigned char data)
                                    330 ;	-----------------------------------------
                                    331 ;	 function i2c_send_byte
                                    332 ;	-----------------------------------------
      008183                        333 _i2c_send_byte:
      008183 88               [ 1]  334 	push	a
      008184 6B 01            [ 1]  335 	ld	(0x01, sp), a
                                    336 ;	libs/i2c_lib.c: 91: I2C_ITR -> ITBUFEN = 1;
      008186 72 14 52 1A      [ 1]  337 	bset	0x521a, #2
                                    338 ;	libs/i2c_lib.c: 92: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      00818A 72 12 52 1A      [ 1]  339 	bset	0x521a, #1
                                    340 ;	libs/i2c_lib.c: 93: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      00818E 72 10 52 1A      [ 1]  341 	bset	0x521a, #0
                                    342 ;	libs/i2c_lib.c: 94: I2C_DR -> DR = data; //Отправка данных
      008192 AE 52 16         [ 2]  343 	ldw	x, #0x5216
      008195 7B 01            [ 1]  344 	ld	a, (0x01, sp)
      008197 F7               [ 1]  345 	ld	(x), a
                                    346 ;	libs/i2c_lib.c: 95: while(I2C_ITR -> ITERREN && I2C_ITR -> ITEVTEN);//ожидание прерывания
      008198                        347 00102$:
      008198 C6 52 1A         [ 1]  348 	ld	a, 0x521a
      00819B A5 01            [ 1]  349 	bcp	a, #0x01
      00819D 27 07            [ 1]  350 	jreq	00104$
      00819F C6 52 1A         [ 1]  351 	ld	a, 0x521a
      0081A2 A5 02            [ 1]  352 	bcp	a, #2
      0081A4 26 F2            [ 1]  353 	jrne	00102$
      0081A6                        354 00104$:
                                    355 ;	libs/i2c_lib.c: 96: return I2C_IRQ.AF;//флаг ответа
      0081A6 C6 00 07         [ 1]  356 	ld	a, _I2C_IRQ+0
      0081A9 4E               [ 1]  357 	swap	a
      0081AA 44               [ 1]  358 	srl	a
      0081AB A4 01            [ 1]  359 	and	a, #0x01
                                    360 ;	libs/i2c_lib.c: 97: }
      0081AD 5B 01            [ 2]  361 	addw	sp, #1
      0081AF 81               [ 4]  362 	ret
                                    363 ;	libs/i2c_lib.c: 99: uint8_t i2c_read_byte(unsigned char data){
                                    364 ;	-----------------------------------------
                                    365 ;	 function i2c_read_byte
                                    366 ;	-----------------------------------------
      0081B0                        367 _i2c_read_byte:
                                    368 ;	libs/i2c_lib.c: 100: I2C_ITR -> ITBUFEN = 1;
      0081B0 72 14 52 1A      [ 1]  369 	bset	0x521a, #2
                                    370 ;	libs/i2c_lib.c: 101: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      0081B4 72 12 52 1A      [ 1]  371 	bset	0x521a, #1
                                    372 ;	libs/i2c_lib.c: 102: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      0081B8 72 10 52 1A      [ 1]  373 	bset	0x521a, #0
                                    374 ;	libs/i2c_lib.c: 103: while(I2C_ITR -> ITERREN && I2C_ITR -> ITEVTEN);//ожидание прерывания
      0081BC                        375 00102$:
      0081BC C6 52 1A         [ 1]  376 	ld	a, 0x521a
      0081BF A5 01            [ 1]  377 	bcp	a, #0x01
      0081C1 27 07            [ 1]  378 	jreq	00104$
      0081C3 C6 52 1A         [ 1]  379 	ld	a, 0x521a
      0081C6 A5 02            [ 1]  380 	bcp	a, #2
      0081C8 26 F2            [ 1]  381 	jrne	00102$
      0081CA                        382 00104$:
                                    383 ;	libs/i2c_lib.c: 105: return 0;
      0081CA 4F               [ 1]  384 	clr	a
                                    385 ;	libs/i2c_lib.c: 106: }
      0081CB 81               [ 4]  386 	ret
                                    387 ;	libs/i2c_lib.c: 108: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    388 ;	-----------------------------------------
                                    389 ;	 function i2c_send_address
                                    390 ;	-----------------------------------------
      0081CC                        391 _i2c_send_address:
                                    392 ;	libs/i2c_lib.c: 113: address = address << 1;
      0081CC 48               [ 1]  393 	sll	a
                                    394 ;	libs/i2c_lib.c: 110: switch(rw_type)
      0081CD 88               [ 1]  395 	push	a
      0081CE 7B 04            [ 1]  396 	ld	a, (0x04, sp)
      0081D0 4A               [ 1]  397 	dec	a
      0081D1 84               [ 1]  398 	pop	a
      0081D2 26 02            [ 1]  399 	jrne	00102$
                                    400 ;	libs/i2c_lib.c: 113: address = address << 1;
                                    401 ;	libs/i2c_lib.c: 114: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0081D4 AA 01            [ 1]  402 	or	a, #0x01
                                    403 ;	libs/i2c_lib.c: 115: break;
                                    404 ;	libs/i2c_lib.c: 116: default:
                                    405 ;	libs/i2c_lib.c: 117: address = address << 1; // Отправка адреса устройства с битом на запись
                                    406 ;	libs/i2c_lib.c: 119: }
      0081D6                        407 00102$:
                                    408 ;	libs/i2c_lib.c: 120: i2c_start();
      0081D6 88               [ 1]  409 	push	a
      0081D7 CD 81 6E         [ 4]  410 	call	_i2c_start
      0081DA 84               [ 1]  411 	pop	a
                                    412 ;	libs/i2c_lib.c: 121: I2C_DR -> DR = address;
      0081DB C7 52 16         [ 1]  413 	ld	0x5216, a
                                    414 ;	libs/i2c_lib.c: 122: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      0081DE 72 12 52 1A      [ 1]  415 	bset	0x521a, #1
                                    416 ;	libs/i2c_lib.c: 123: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      0081E2 72 10 52 1A      [ 1]  417 	bset	0x521a, #0
                                    418 ;	libs/i2c_lib.c: 124: while(I2C_ITR -> ITEVTEN && I2C_ITR -> ITERREN);
      0081E6                        419 00105$:
      0081E6 C6 52 1A         [ 1]  420 	ld	a, 0x521a
      0081E9 A5 02            [ 1]  421 	bcp	a, #2
      0081EB 27 07            [ 1]  422 	jreq	00107$
      0081ED C6 52 1A         [ 1]  423 	ld	a, 0x521a
      0081F0 A5 01            [ 1]  424 	bcp	a, #0x01
      0081F2 26 F2            [ 1]  425 	jrne	00105$
      0081F4                        426 00107$:
                                    427 ;	libs/i2c_lib.c: 125: return !I2C_IRQ.AF;
      0081F4 C6 00 07         [ 1]  428 	ld	a, _I2C_IRQ+0
      0081F7 4E               [ 1]  429 	swap	a
      0081F8 44               [ 1]  430 	srl	a
      0081F9 A4 01            [ 1]  431 	and	a, #0x01
      0081FB A8 01            [ 1]  432 	xor	a, #0x01
                                    433 ;	libs/i2c_lib.c: 126: }
      0081FD 85               [ 2]  434 	popw	x
      0081FE 5B 01            [ 2]  435 	addw	sp, #1
      008200 FC               [ 2]  436 	jp	(x)
                                    437 ;	libs/i2c_lib.c: 128: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    438 ;	-----------------------------------------
                                    439 ;	 function i2c_write
                                    440 ;	-----------------------------------------
      008201                        441 _i2c_write:
      008201 52 02            [ 2]  442 	sub	sp, #2
                                    443 ;	libs/i2c_lib.c: 130: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008203 4B 00            [ 1]  444 	push	#0x00
      008205 CD 81 CC         [ 4]  445 	call	_i2c_send_address
      008208 4D               [ 1]  446 	tnz	a
      008209 27 1D            [ 1]  447 	jreq	00105$
                                    448 ;	libs/i2c_lib.c: 131: for(int i = 0;i < size;i++)
      00820B 5F               [ 1]  449 	clrw	x
      00820C                        450 00107$:
      00820C 7B 05            [ 1]  451 	ld	a, (0x05, sp)
      00820E 6B 02            [ 1]  452 	ld	(0x02, sp), a
      008210 0F 01            [ 1]  453 	clr	(0x01, sp)
      008212 13 01            [ 2]  454 	cpw	x, (0x01, sp)
      008214 2E 12            [ 1]  455 	jrsge	00105$
                                    456 ;	libs/i2c_lib.c: 133: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008216 90 93            [ 1]  457 	ldw	y, x
      008218 72 F9 06         [ 2]  458 	addw	y, (0x06, sp)
      00821B 90 F6            [ 1]  459 	ld	a, (y)
      00821D 89               [ 2]  460 	pushw	x
      00821E CD 81 83         [ 4]  461 	call	_i2c_send_byte
      008221 85               [ 2]  462 	popw	x
      008222 4D               [ 1]  463 	tnz	a
      008223 26 03            [ 1]  464 	jrne	00105$
                                    465 ;	libs/i2c_lib.c: 131: for(int i = 0;i < size;i++)
      008225 5C               [ 1]  466 	incw	x
      008226 20 E4            [ 2]  467 	jra	00107$
      008228                        468 00105$:
                                    469 ;	libs/i2c_lib.c: 138: i2c_stop();
      008228 1E 03            [ 2]  470 	ldw	x, (3, sp)
      00822A 1F 06            [ 2]  471 	ldw	(6, sp), x
      00822C 5B 05            [ 2]  472 	addw	sp, #5
                                    473 ;	libs/i2c_lib.c: 139: }
      00822E CC 81 7E         [ 2]  474 	jp	_i2c_stop
                                    475 ;	libs/i2c_lib.c: 141: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    476 ;	-----------------------------------------
                                    477 ;	 function i2c_read
                                    478 ;	-----------------------------------------
      008231                        479 _i2c_read:
      008231 52 02            [ 2]  480 	sub	sp, #2
                                    481 ;	libs/i2c_lib.c: 144: i2c_send_address(dev_addr, 1);
      008233 88               [ 1]  482 	push	a
      008234 4B 01            [ 1]  483 	push	#0x01
      008236 CD 81 CC         [ 4]  484 	call	_i2c_send_address
      008239 84               [ 1]  485 	pop	a
                                    486 ;	libs/i2c_lib.c: 145: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      00823A 4B 01            [ 1]  487 	push	#0x01
      00823C CD 81 CC         [ 4]  488 	call	_i2c_send_address
      00823F 4D               [ 1]  489 	tnz	a
      008240 27 1A            [ 1]  490 	jreq	00103$
                                    491 ;	libs/i2c_lib.c: 148: for(int i = 0;i < size;i++) //цикл чтения данных с шины
      008242 5F               [ 1]  492 	clrw	x
      008243                        493 00105$:
      008243 7B 05            [ 1]  494 	ld	a, (0x05, sp)
      008245 6B 02            [ 1]  495 	ld	(0x02, sp), a
      008247 0F 01            [ 1]  496 	clr	(0x01, sp)
      008249 13 01            [ 2]  497 	cpw	x, (0x01, sp)
      00824B 2E 0F            [ 1]  498 	jrsge	00103$
                                    499 ;	libs/i2c_lib.c: 150: i2c_read_byte(data[i]);//функция записи байта в элемент массива
      00824D 90 93            [ 1]  500 	ldw	y, x
      00824F 72 F9 06         [ 2]  501 	addw	y, (0x06, sp)
      008252 90 F6            [ 1]  502 	ld	a, (y)
      008254 89               [ 2]  503 	pushw	x
      008255 CD 81 B0         [ 4]  504 	call	_i2c_read_byte
      008258 85               [ 2]  505 	popw	x
                                    506 ;	libs/i2c_lib.c: 148: for(int i = 0;i < size;i++) //цикл чтения данных с шины
      008259 5C               [ 1]  507 	incw	x
      00825A 20 E7            [ 2]  508 	jra	00105$
      00825C                        509 00103$:
                                    510 ;	libs/i2c_lib.c: 154: i2c_stop(); 
      00825C 1E 03            [ 2]  511 	ldw	x, (3, sp)
      00825E 1F 06            [ 2]  512 	ldw	(6, sp), x
      008260 5B 05            [ 2]  513 	addw	sp, #5
                                    514 ;	libs/i2c_lib.c: 155: }
      008262 CC 81 7E         [ 2]  515 	jp	_i2c_stop
                                    516 ;	libs/i2c_lib.c: 156: uint8_t i2c_scan(void) 
                                    517 ;	-----------------------------------------
                                    518 ;	 function i2c_scan
                                    519 ;	-----------------------------------------
      008265                        520 _i2c_scan:
      008265 52 02            [ 2]  521 	sub	sp, #2
                                    522 ;	libs/i2c_lib.c: 158: for (uint8_t addr = 1; addr < 127; addr++)
      008267 A6 01            [ 1]  523 	ld	a, #0x01
      008269 6B 01            [ 1]  524 	ld	(0x01, sp), a
      00826B                        525 00105$:
      00826B A1 7F            [ 1]  526 	cp	a, #0x7f
      00826D 24 22            [ 1]  527 	jrnc	00103$
                                    528 ;	libs/i2c_lib.c: 160: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      00826F 88               [ 1]  529 	push	a
      008270 4B 00            [ 1]  530 	push	#0x00
      008272 CD 81 CC         [ 4]  531 	call	_i2c_send_address
      008275 6B 03            [ 1]  532 	ld	(0x03, sp), a
      008277 84               [ 1]  533 	pop	a
      008278 0D 02            [ 1]  534 	tnz	(0x02, sp)
      00827A 27 07            [ 1]  535 	jreq	00102$
                                    536 ;	libs/i2c_lib.c: 162: i2c_stop();//адрес совпал 
      00827C CD 81 7E         [ 4]  537 	call	_i2c_stop
                                    538 ;	libs/i2c_lib.c: 163: return addr;// выход из цикла
      00827F 7B 01            [ 1]  539 	ld	a, (0x01, sp)
      008281 20 12            [ 2]  540 	jra	00107$
      008283                        541 00102$:
                                    542 ;	libs/i2c_lib.c: 165: I2C_SR2 -> AF = 0;//очистка флага ошибки
      008283 AE 52 18         [ 2]  543 	ldw	x, #0x5218
      008286 88               [ 1]  544 	push	a
      008287 F6               [ 1]  545 	ld	a, (x)
      008288 A4 FB            [ 1]  546 	and	a, #0xfb
      00828A F7               [ 1]  547 	ld	(x), a
      00828B 84               [ 1]  548 	pop	a
                                    549 ;	libs/i2c_lib.c: 158: for (uint8_t addr = 1; addr < 127; addr++)
      00828C 4C               [ 1]  550 	inc	a
      00828D 6B 01            [ 1]  551 	ld	(0x01, sp), a
      00828F 20 DA            [ 2]  552 	jra	00105$
      008291                        553 00103$:
                                    554 ;	libs/i2c_lib.c: 167: i2c_stop();//совпадений нет выход из функции
      008291 CD 81 7E         [ 4]  555 	call	_i2c_stop
                                    556 ;	libs/i2c_lib.c: 168: return 0;
      008294 4F               [ 1]  557 	clr	a
      008295                        558 00107$:
                                    559 ;	libs/i2c_lib.c: 169: }
      008295 5B 02            [ 2]  560 	addw	sp, #2
      008297 81               [ 4]  561 	ret
                                    562 ;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    563 ;	-----------------------------------------
                                    564 ;	 function uart_transmission_irq
                                    565 ;	-----------------------------------------
      008298                        566 _uart_transmission_irq:
                                    567 ;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      008298 AE 52 30         [ 2]  568 	ldw	x, #0x5230
      00829B F6               [ 1]  569 	ld	a, (x)
      00829C 4E               [ 1]  570 	swap	a
      00829D 44               [ 1]  571 	srl	a
      00829E 44               [ 1]  572 	srl	a
      00829F 44               [ 1]  573 	srl	a
      0082A0 A5 01            [ 1]  574 	bcp	a, #0x01
      0082A2 27 2F            [ 1]  575 	jreq	00107$
                                    576 ;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0082A4 C6 00 02         [ 1]  577 	ld	a, _tx_buf_pointer+1
      0082A7 CB 00 05         [ 1]  578 	add	a, _buf_pos+0
      0082AA 97               [ 1]  579 	ld	xl, a
      0082AB C6 00 01         [ 1]  580 	ld	a, _tx_buf_pointer+0
      0082AE A9 00            [ 1]  581 	adc	a, #0x00
      0082B0 95               [ 1]  582 	ld	xh, a
      0082B1 F6               [ 1]  583 	ld	a, (x)
      0082B2 27 1B            [ 1]  584 	jreq	00102$
      0082B4 C6 00 05         [ 1]  585 	ld	a, _buf_pos+0
      0082B7 C1 00 06         [ 1]  586 	cp	a, _buf_size+0
      0082BA 24 13            [ 1]  587 	jrnc	00102$
                                    588 ;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0082BC C6 00 05         [ 1]  589 	ld	a, _buf_pos+0
      0082BF 72 5C 00 05      [ 1]  590 	inc	_buf_pos+0
      0082C3 5F               [ 1]  591 	clrw	x
      0082C4 97               [ 1]  592 	ld	xl, a
      0082C5 72 BB 00 01      [ 2]  593 	addw	x, _tx_buf_pointer+0
      0082C9 F6               [ 1]  594 	ld	a, (x)
      0082CA C7 52 31         [ 1]  595 	ld	0x5231, a
      0082CD 20 04            [ 2]  596 	jra	00107$
      0082CF                        597 00102$:
                                    598 ;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0082CF 72 1F 52 35      [ 1]  599 	bres	0x5235, #7
      0082D3                        600 00107$:
                                    601 ;	libs/uart_lib.c: 14: }
      0082D3 80               [11]  602 	iret
                                    603 ;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    604 ;	-----------------------------------------
                                    605 ;	 function uart_reciever_irq
                                    606 ;	-----------------------------------------
      0082D4                        607 _uart_reciever_irq:
      0082D4 88               [ 1]  608 	push	a
                                    609 ;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
      0082D5 C6 52 30         [ 1]  610 	ld	a, 0x5230
      0082D8 4E               [ 1]  611 	swap	a
      0082D9 44               [ 1]  612 	srl	a
      0082DA A5 01            [ 1]  613 	bcp	a, #0x01
      0082DC 27 27            [ 1]  614 	jreq	00107$
                                    615 ;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
      0082DE C6 52 31         [ 1]  616 	ld	a, 0x5231
                                    617 ;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
      0082E1 6B 01            [ 1]  618 	ld	(0x01, sp), a
      0082E3 A1 0A            [ 1]  619 	cp	a, #0x0a
      0082E5 27 1A            [ 1]  620 	jreq	00102$
      0082E7 C6 00 05         [ 1]  621 	ld	a, _buf_pos+0
      0082EA C1 00 06         [ 1]  622 	cp	a, _buf_size+0
      0082ED 24 12            [ 1]  623 	jrnc	00102$
                                    624 ;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
      0082EF C6 00 05         [ 1]  625 	ld	a, _buf_pos+0
      0082F2 72 5C 00 05      [ 1]  626 	inc	_buf_pos+0
      0082F6 5F               [ 1]  627 	clrw	x
      0082F7 97               [ 1]  628 	ld	xl, a
      0082F8 72 BB 00 03      [ 2]  629 	addw	x, _rx_buf_pointer+0
      0082FC 7B 01            [ 1]  630 	ld	a, (0x01, sp)
      0082FE F7               [ 1]  631 	ld	(x), a
      0082FF 20 04            [ 2]  632 	jra	00107$
      008301                        633 00102$:
                                    634 ;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
      008301 72 1B 52 35      [ 1]  635 	bres	0x5235, #5
      008305                        636 00107$:
                                    637 ;	libs/uart_lib.c: 29: }
      008305 84               [ 1]  638 	pop	a
      008306 80               [11]  639 	iret
                                    640 ;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    641 ;	-----------------------------------------
                                    642 ;	 function uart_init
                                    643 ;	-----------------------------------------
      008307                        644 _uart_init:
      008307 52 02            [ 2]  645 	sub	sp, #2
      008309 1F 01            [ 2]  646 	ldw	(0x01, sp), x
                                    647 ;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
      00830B AE 52 35         [ 2]  648 	ldw	x, #0x5235
      00830E 88               [ 1]  649 	push	a
      00830F F6               [ 1]  650 	ld	a, (x)
      008310 AA 08            [ 1]  651 	or	a, #0x08
      008312 F7               [ 1]  652 	ld	(x), a
      008313 84               [ 1]  653 	pop	a
                                    654 ;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
      008314 AE 52 35         [ 2]  655 	ldw	x, #0x5235
      008317 88               [ 1]  656 	push	a
      008318 F6               [ 1]  657 	ld	a, (x)
      008319 AA 04            [ 1]  658 	or	a, #0x04
      00831B F7               [ 1]  659 	ld	(x), a
      00831C 84               [ 1]  660 	pop	a
                                    661 ;	libs/uart_lib.c: 36: switch(stopbit)
      00831D A1 02            [ 1]  662 	cp	a, #0x02
      00831F 27 06            [ 1]  663 	jreq	00101$
      008321 A1 03            [ 1]  664 	cp	a, #0x03
      008323 27 0E            [ 1]  665 	jreq	00102$
      008325 20 16            [ 2]  666 	jra	00103$
                                    667 ;	libs/uart_lib.c: 38: case 2:
      008327                        668 00101$:
                                    669 ;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
      008327 C6 52 36         [ 1]  670 	ld	a, 0x5236
      00832A A4 CF            [ 1]  671 	and	a, #0xcf
      00832C AA 20            [ 1]  672 	or	a, #0x20
      00832E C7 52 36         [ 1]  673 	ld	0x5236, a
                                    674 ;	libs/uart_lib.c: 40: break;
      008331 20 12            [ 2]  675 	jra	00104$
                                    676 ;	libs/uart_lib.c: 41: case 3:
      008333                        677 00102$:
                                    678 ;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
      008333 C6 52 36         [ 1]  679 	ld	a, 0x5236
      008336 AA 30            [ 1]  680 	or	a, #0x30
      008338 C7 52 36         [ 1]  681 	ld	0x5236, a
                                    682 ;	libs/uart_lib.c: 43: break;
      00833B 20 08            [ 2]  683 	jra	00104$
                                    684 ;	libs/uart_lib.c: 44: default:
      00833D                        685 00103$:
                                    686 ;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
      00833D C6 52 36         [ 1]  687 	ld	a, 0x5236
      008340 A4 CF            [ 1]  688 	and	a, #0xcf
      008342 C7 52 36         [ 1]  689 	ld	0x5236, a
                                    690 ;	libs/uart_lib.c: 47: }
      008345                        691 00104$:
                                    692 ;	libs/uart_lib.c: 48: switch(baudrate)
      008345 1E 01            [ 2]  693 	ldw	x, (0x01, sp)
      008347 A3 08 00         [ 2]  694 	cpw	x, #0x0800
      00834A 26 03            [ 1]  695 	jrne	00186$
      00834C CC 83 D8         [ 2]  696 	jp	00110$
      00834F                        697 00186$:
      00834F 1E 01            [ 2]  698 	ldw	x, (0x01, sp)
      008351 A3 09 60         [ 2]  699 	cpw	x, #0x0960
      008354 27 28            [ 1]  700 	jreq	00105$
      008356 1E 01            [ 2]  701 	ldw	x, (0x01, sp)
      008358 A3 10 00         [ 2]  702 	cpw	x, #0x1000
      00835B 26 03            [ 1]  703 	jrne	00192$
      00835D CC 83 E8         [ 2]  704 	jp	00111$
      008360                        705 00192$:
      008360 1E 01            [ 2]  706 	ldw	x, (0x01, sp)
      008362 A3 4B 00         [ 2]  707 	cpw	x, #0x4b00
      008365 27 31            [ 1]  708 	jreq	00106$
      008367 1E 01            [ 2]  709 	ldw	x, (0x01, sp)
      008369 A3 84 00         [ 2]  710 	cpw	x, #0x8400
      00836C 27 5A            [ 1]  711 	jreq	00109$
      00836E 1E 01            [ 2]  712 	ldw	x, (0x01, sp)
      008370 A3 C2 00         [ 2]  713 	cpw	x, #0xc200
      008373 27 43            [ 1]  714 	jreq	00108$
      008375 1E 01            [ 2]  715 	ldw	x, (0x01, sp)
      008377 A3 E1 00         [ 2]  716 	cpw	x, #0xe100
      00837A 27 2C            [ 1]  717 	jreq	00107$
      00837C 20 7A            [ 2]  718 	jra	00112$
                                    719 ;	libs/uart_lib.c: 50: case (unsigned int)2400:
      00837E                        720 00105$:
                                    721 ;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
      00837E C6 52 33         [ 1]  722 	ld	a, 0x5233
      008381 A4 0F            [ 1]  723 	and	a, #0x0f
      008383 AA 10            [ 1]  724 	or	a, #0x10
      008385 C7 52 33         [ 1]  725 	ld	0x5233, a
                                    726 ;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
      008388 35 A0 52 32      [ 1]  727 	mov	0x5232+0, #0xa0
                                    728 ;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
      00838C C6 52 33         [ 1]  729 	ld	a, 0x5233
      00838F A4 F0            [ 1]  730 	and	a, #0xf0
      008391 AA 0B            [ 1]  731 	or	a, #0x0b
      008393 C7 52 33         [ 1]  732 	ld	0x5233, a
                                    733 ;	libs/uart_lib.c: 54: break;
      008396 20 6E            [ 2]  734 	jra	00114$
                                    735 ;	libs/uart_lib.c: 55: case (unsigned int)19200:
      008398                        736 00106$:
                                    737 ;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
      008398 35 34 52 32      [ 1]  738 	mov	0x5232+0, #0x34
                                    739 ;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
      00839C C6 52 33         [ 1]  740 	ld	a, 0x5233
      00839F A4 F0            [ 1]  741 	and	a, #0xf0
      0083A1 AA 01            [ 1]  742 	or	a, #0x01
      0083A3 C7 52 33         [ 1]  743 	ld	0x5233, a
                                    744 ;	libs/uart_lib.c: 58: break;
      0083A6 20 5E            [ 2]  745 	jra	00114$
                                    746 ;	libs/uart_lib.c: 59: case (unsigned int)57600:
      0083A8                        747 00107$:
                                    748 ;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
      0083A8 35 11 52 32      [ 1]  749 	mov	0x5232+0, #0x11
                                    750 ;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
      0083AC C6 52 33         [ 1]  751 	ld	a, 0x5233
      0083AF A4 F0            [ 1]  752 	and	a, #0xf0
      0083B1 AA 06            [ 1]  753 	or	a, #0x06
      0083B3 C7 52 33         [ 1]  754 	ld	0x5233, a
                                    755 ;	libs/uart_lib.c: 62: break;
      0083B6 20 4E            [ 2]  756 	jra	00114$
                                    757 ;	libs/uart_lib.c: 63: case (unsigned int)115200:
      0083B8                        758 00108$:
                                    759 ;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
      0083B8 35 08 52 32      [ 1]  760 	mov	0x5232+0, #0x08
                                    761 ;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
      0083BC C6 52 33         [ 1]  762 	ld	a, 0x5233
      0083BF A4 F0            [ 1]  763 	and	a, #0xf0
      0083C1 AA 0B            [ 1]  764 	or	a, #0x0b
      0083C3 C7 52 33         [ 1]  765 	ld	0x5233, a
                                    766 ;	libs/uart_lib.c: 66: break;
      0083C6 20 3E            [ 2]  767 	jra	00114$
                                    768 ;	libs/uart_lib.c: 67: case (unsigned int)230400:
      0083C8                        769 00109$:
                                    770 ;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
      0083C8 35 04 52 32      [ 1]  771 	mov	0x5232+0, #0x04
                                    772 ;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
      0083CC C6 52 33         [ 1]  773 	ld	a, 0x5233
      0083CF A4 F0            [ 1]  774 	and	a, #0xf0
      0083D1 AA 05            [ 1]  775 	or	a, #0x05
      0083D3 C7 52 33         [ 1]  776 	ld	0x5233, a
                                    777 ;	libs/uart_lib.c: 70: break;
      0083D6 20 2E            [ 2]  778 	jra	00114$
                                    779 ;	libs/uart_lib.c: 71: case (unsigned int)460800:
      0083D8                        780 00110$:
                                    781 ;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
      0083D8 35 02 52 32      [ 1]  782 	mov	0x5232+0, #0x02
                                    783 ;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
      0083DC C6 52 33         [ 1]  784 	ld	a, 0x5233
      0083DF A4 F0            [ 1]  785 	and	a, #0xf0
      0083E1 AA 03            [ 1]  786 	or	a, #0x03
      0083E3 C7 52 33         [ 1]  787 	ld	0x5233, a
                                    788 ;	libs/uart_lib.c: 74: break;
      0083E6 20 1E            [ 2]  789 	jra	00114$
                                    790 ;	libs/uart_lib.c: 75: case (unsigned int)921600:
      0083E8                        791 00111$:
                                    792 ;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
      0083E8 35 01 52 32      [ 1]  793 	mov	0x5232+0, #0x01
                                    794 ;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      0083EC C6 52 33         [ 1]  795 	ld	a, 0x5233
      0083EF A4 F0            [ 1]  796 	and	a, #0xf0
      0083F1 AA 01            [ 1]  797 	or	a, #0x01
      0083F3 C7 52 33         [ 1]  798 	ld	0x5233, a
                                    799 ;	libs/uart_lib.c: 78: break;
      0083F6 20 0E            [ 2]  800 	jra	00114$
                                    801 ;	libs/uart_lib.c: 79: default:
      0083F8                        802 00112$:
                                    803 ;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
      0083F8 35 68 52 32      [ 1]  804 	mov	0x5232+0, #0x68
                                    805 ;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
      0083FC C6 52 33         [ 1]  806 	ld	a, 0x5233
      0083FF A4 F0            [ 1]  807 	and	a, #0xf0
      008401 AA 03            [ 1]  808 	or	a, #0x03
      008403 C7 52 33         [ 1]  809 	ld	0x5233, a
                                    810 ;	libs/uart_lib.c: 83: }
      008406                        811 00114$:
                                    812 ;	libs/uart_lib.c: 84: }
      008406 5B 02            [ 2]  813 	addw	sp, #2
      008408 81               [ 4]  814 	ret
                                    815 ;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
                                    816 ;	-----------------------------------------
                                    817 ;	 function uart_read_byte
                                    818 ;	-----------------------------------------
      008409                        819 _uart_read_byte:
                                    820 ;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
      008409                        821 00101$:
      008409 72 0B 52 30 FB   [ 2]  822 	btjf	0x5230, #5, 00101$
                                    823 ;	libs/uart_lib.c: 90: return 1;
      00840E 5F               [ 1]  824 	clrw	x
      00840F 5C               [ 1]  825 	incw	x
                                    826 ;	libs/uart_lib.c: 91: }
      008410 81               [ 4]  827 	ret
                                    828 ;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
                                    829 ;	-----------------------------------------
                                    830 ;	 function uart_write_byte
                                    831 ;	-----------------------------------------
      008411                        832 _uart_write_byte:
                                    833 ;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
      008411 C7 52 31         [ 1]  834 	ld	0x5231, a
                                    835 ;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
      008414                        836 00101$:
      008414 72 0F 52 30 FB   [ 2]  837 	btjf	0x5230, #7, 00101$
                                    838 ;	libs/uart_lib.c: 97: return 1;
      008419 5F               [ 1]  839 	clrw	x
      00841A 5C               [ 1]  840 	incw	x
                                    841 ;	libs/uart_lib.c: 98: }
      00841B 81               [ 4]  842 	ret
                                    843 ;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
                                    844 ;	-----------------------------------------
                                    845 ;	 function uart_write
                                    846 ;	-----------------------------------------
      00841C                        847 _uart_write:
      00841C 52 02            [ 2]  848 	sub	sp, #2
                                    849 ;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
      00841E 1F 01            [ 2]  850 	ldw	(0x01, sp), x
      008420 CF 00 01         [ 2]  851 	ldw	_tx_buf_pointer+0, x
                                    852 ;	libs/uart_lib.c: 103: buf_pos = 0;
      008423 72 5F 00 05      [ 1]  853 	clr	_buf_pos+0
                                    854 ;	libs/uart_lib.c: 104: buf_size = 0;
      008427 72 5F 00 06      [ 1]  855 	clr	_buf_size+0
                                    856 ;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
      00842B                        857 00101$:
      00842B C6 00 06         [ 1]  858 	ld	a, _buf_size+0
      00842E 72 5C 00 06      [ 1]  859 	inc	_buf_size+0
      008432 5F               [ 1]  860 	clrw	x
      008433 97               [ 1]  861 	ld	xl, a
      008434 72 FB 01         [ 2]  862 	addw	x, (0x01, sp)
      008437 F6               [ 1]  863 	ld	a, (x)
      008438 26 F1            [ 1]  864 	jrne	00101$
                                    865 ;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
      00843A 72 1E 52 35      [ 1]  866 	bset	0x5235, #7
                                    867 ;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
      00843E                        868 00104$:
      00843E 72 0E 52 35 FB   [ 2]  869 	btjt	0x5235, #7, 00104$
                                    870 ;	libs/uart_lib.c: 108: }
      008443 5B 02            [ 2]  871 	addw	sp, #2
      008445 81               [ 4]  872 	ret
                                    873 ;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
                                    874 ;	-----------------------------------------
                                    875 ;	 function uart_read
                                    876 ;	-----------------------------------------
      008446                        877 _uart_read:
                                    878 ;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
      008446 CF 00 03         [ 2]  879 	ldw	_rx_buf_pointer+0, x
                                    880 ;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
      008449 AE 80 81         [ 2]  881 	ldw	x, #(___str_0+0)
      00844C CD 84 1C         [ 4]  882 	call	_uart_write
                                    883 ;	libs/uart_lib.c: 113: buf_pos = 0;
      00844F 72 5F 00 05      [ 1]  884 	clr	_buf_pos+0
                                    885 ;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
      008453 AE 80 91         [ 2]  886 	ldw	x, #(___str_1+0)
      008456 CD 84 1C         [ 4]  887 	call	_uart_write
                                    888 ;	libs/uart_lib.c: 115: buf_size = size;
      008459 7B 04            [ 1]  889 	ld	a, (0x04, sp)
      00845B C7 00 06         [ 1]  890 	ld	_buf_size+0, a
                                    891 ;	libs/uart_lib.c: 116: uart_write("buf_size\n");
      00845E AE 80 9A         [ 2]  892 	ldw	x, #(___str_2+0)
      008461 CD 84 1C         [ 4]  893 	call	_uart_write
                                    894 ;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
      008464 72 1A 52 35      [ 1]  895 	bset	0x5235, #5
                                    896 ;	libs/uart_lib.c: 118: uart_write("RIEN\n");
      008468 AE 80 A4         [ 2]  897 	ldw	x, #(___str_3+0)
      00846B CD 84 1C         [ 4]  898 	call	_uart_write
                                    899 ;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
      00846E                        900 00101$:
      00846E C6 52 35         [ 1]  901 	ld	a, 0x5235
      008471 4E               [ 1]  902 	swap	a
      008472 44               [ 1]  903 	srl	a
      008473 A4 01            [ 1]  904 	and	a, #0x01
      008475 26 F7            [ 1]  905 	jrne	00101$
                                    906 ;	libs/uart_lib.c: 120: }
      008477 1E 01            [ 2]  907 	ldw	x, (1, sp)
      008479 5B 04            [ 2]  908 	addw	sp, #4
      00847B FC               [ 2]  909 	jp	(x)
                                    910 ;	main.c: 2: void setup(void)
                                    911 ;	-----------------------------------------
                                    912 ;	 function setup
                                    913 ;	-----------------------------------------
      00847C                        914 _setup:
                                    915 ;	main.c: 5: CLK_CKDIVR = 0;
      00847C 35 00 50 C6      [ 1]  916 	mov	0x50c6+0, #0x00
                                    917 ;	main.c: 7: uart_init(9600,0);
      008480 4F               [ 1]  918 	clr	a
      008481 AE 25 80         [ 2]  919 	ldw	x, #0x2580
      008484 CD 83 07         [ 4]  920 	call	_uart_init
                                    921 ;	main.c: 8: i2c_init();
      008487 CD 81 43         [ 4]  922 	call	_i2c_init
                                    923 ;	main.c: 10: enableInterrupts();
      00848A 9A               [ 1]  924 	rim
                                    925 ;	main.c: 11: }
      00848B 81               [ 4]  926 	ret
                                    927 ;	main.c: 12: int main(void)
                                    928 ;	-----------------------------------------
                                    929 ;	 function main
                                    930 ;	-----------------------------------------
      00848C                        931 _main:
      00848C 52 05            [ 2]  932 	sub	sp, #5
                                    933 ;	main.c: 14: setup();
      00848E CD 84 7C         [ 4]  934 	call	_setup
                                    935 ;	main.c: 15: uint8_t buf[5] = {0};
      008491 96               [ 1]  936 	ldw	x, sp
      008492 5C               [ 1]  937 	incw	x
      008493 7F               [ 1]  938 	clr	(x)
      008494 0F 02            [ 1]  939 	clr	(0x02, sp)
      008496 0F 03            [ 1]  940 	clr	(0x03, sp)
      008498 0F 04            [ 1]  941 	clr	(0x04, sp)
      00849A 0F 05            [ 1]  942 	clr	(0x05, sp)
                                    943 ;	main.c: 16: i2c_read(I2C_DISPLAY_ADDR,5,buf);
      00849C 90 93            [ 1]  944 	ldw	y, x
      00849E 89               [ 2]  945 	pushw	x
      00849F 90 89            [ 2]  946 	pushw	y
      0084A1 4B 05            [ 1]  947 	push	#0x05
      0084A3 A6 3C            [ 1]  948 	ld	a, #0x3c
      0084A5 CD 82 31         [ 4]  949 	call	_i2c_read
      0084A8 85               [ 2]  950 	popw	x
                                    951 ;	main.c: 17: buf[0] = 0xA4;
      0084A9 A6 A4            [ 1]  952 	ld	a, #0xa4
      0084AB F7               [ 1]  953 	ld	(x), a
                                    954 ;	main.c: 18: buf[1] = 0xA5;
      0084AC A6 A5            [ 1]  955 	ld	a, #0xa5
      0084AE 6B 02            [ 1]  956 	ld	(0x02, sp), a
                                    957 ;	main.c: 19: buf[2] = 0xA6;
      0084B0 A6 A6            [ 1]  958 	ld	a, #0xa6
      0084B2 6B 03            [ 1]  959 	ld	(0x03, sp), a
                                    960 ;	main.c: 20: buf[3] = 0xA7;
      0084B4 A6 A7            [ 1]  961 	ld	a, #0xa7
      0084B6 6B 04            [ 1]  962 	ld	(0x04, sp), a
                                    963 ;	main.c: 21: buf[4] = 0xA8;
      0084B8 A6 A8            [ 1]  964 	ld	a, #0xa8
      0084BA 6B 05            [ 1]  965 	ld	(0x05, sp), a
                                    966 ;	main.c: 22: i2c_write(I2C_DISPLAY_ADDR,5,buf);
      0084BC 89               [ 2]  967 	pushw	x
      0084BD 4B 05            [ 1]  968 	push	#0x05
      0084BF A6 3C            [ 1]  969 	ld	a, #0x3c
      0084C1 CD 82 01         [ 4]  970 	call	_i2c_write
                                    971 ;	main.c: 24: while(1);
      0084C4                        972 00102$:
      0084C4 20 FE            [ 2]  973 	jra	00102$
                                    974 ;	main.c: 26: }
      0084C6 5B 05            [ 2]  975 	addw	sp, #5
      0084C8 81               [ 4]  976 	ret
                                    977 	.area CODE
                                    978 	.area CONST
                                    979 	.area CONST
      008081                        980 ___str_0:
      008081 72 78 5F 62 75 66 5F   981 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808F 0A                     982 	.db 0x0a
      008090 00                     983 	.db 0x00
                                    984 	.area CODE
                                    985 	.area CONST
      008091                        986 ___str_1:
      008091 62 75 66 5F 70 6F 73   987 	.ascii "buf_pos"
      008098 0A                     988 	.db 0x0a
      008099 00                     989 	.db 0x00
                                    990 	.area CODE
                                    991 	.area CONST
      00809A                        992 ___str_2:
      00809A 62 75 66 5F 73 69 7A   993 	.ascii "buf_size"
             65
      0080A2 0A                     994 	.db 0x0a
      0080A3 00                     995 	.db 0x00
                                    996 	.area CODE
                                    997 	.area CONST
      0080A4                        998 ___str_3:
      0080A4 52 49 45 4E            999 	.ascii "RIEN"
      0080A8 0A                    1000 	.db 0x0a
      0080A9 00                    1001 	.db 0x00
                                   1002 	.area CODE
                                   1003 	.area INITIALIZER
      0080AA                       1004 __xinit__I2C_IRQ:
      0080AA 00                    1005 	.db #0x00	; 0
      0080AB                       1006 __xinit__govno_alert:
      0080AB 00                    1007 	.db #0x00	; 0
      0080AC                       1008 __xinit__counter:
      0080AC 00                    1009 	.db #0x00	; 0
      0080AD                       1010 __xinit__dummy:
      0080AD 00                    1011 	.db #0x00	; 0
                                   1012 	.area CABS (ABS)
