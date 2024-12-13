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
                                     13 	.globl _i2c_scan
                                     14 	.globl _i2c_read
                                     15 	.globl _i2c_write
                                     16 	.globl _delay
                                     17 	.globl _i2c_send_address
                                     18 	.globl _i2c_read_byte
                                     19 	.globl _i2c_send_byte
                                     20 	.globl _i2c_stop
                                     21 	.globl _i2c_start
                                     22 	.globl _i2c_init
                                     23 	.globl _i2c_irq
                                     24 	.globl _uart_read
                                     25 	.globl _uart_write_byte
                                     26 	.globl _uart_read_byte
                                     27 	.globl _uart_init
                                     28 	.globl _uart_reciever_irq
                                     29 	.globl _uart_transmission_irq
                                     30 	.globl _memset
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
                                     61 ;--------------------------------------------------------
                                     62 ; Stack segment in internal ram
                                     63 ;--------------------------------------------------------
                                     64 	.area SSEG
      00000A                         65 __start__stack:
      00000A                         66 	.ds	1
                                     67 
                                     68 ;--------------------------------------------------------
                                     69 ; absolute external ram data
                                     70 ;--------------------------------------------------------
                                     71 	.area DABS (ABS)
                                     72 
                                     73 ; default segment ordering for linker
                                     74 	.area HOME
                                     75 	.area GSINIT
                                     76 	.area GSFINAL
                                     77 	.area CONST
                                     78 	.area INITIALIZER
                                     79 	.area CODE
                                     80 
                                     81 ;--------------------------------------------------------
                                     82 ; interrupt vector
                                     83 ;--------------------------------------------------------
                                     84 	.area HOME
      008000                         85 __interrupt_vect:
      008000 82 00 80 5B             86 	int s_GSINIT ; reset
      008004 82 00 00 00             87 	int 0x000000 ; trap
      008008 82 00 00 00             88 	int 0x000000 ; int0
      00800C 82 00 00 00             89 	int 0x000000 ; int1
      008010 82 00 00 00             90 	int 0x000000 ; int2
      008014 82 00 00 00             91 	int 0x000000 ; int3
      008018 82 00 00 00             92 	int 0x000000 ; int4
      00801C 82 00 00 00             93 	int 0x000000 ; int5
      008020 82 00 00 00             94 	int 0x000000 ; int6
      008024 82 00 00 00             95 	int 0x000000 ; int7
      008028 82 00 00 00             96 	int 0x000000 ; int8
      00802C 82 00 00 00             97 	int 0x000000 ; int9
      008030 82 00 00 00             98 	int 0x000000 ; int10
      008034 82 00 00 00             99 	int 0x000000 ; int11
      008038 82 00 00 00            100 	int 0x000000 ; int12
      00803C 82 00 00 00            101 	int 0x000000 ; int13
      008040 82 00 00 00            102 	int 0x000000 ; int14
      008044 82 00 00 00            103 	int 0x000000 ; int15
      008048 82 00 00 00            104 	int 0x000000 ; int16
      00804C 82 00 81 32            105 	int _uart_transmission_irq ; int17
      008050 82 00 81 6E            106 	int _uart_reciever_irq ; int18
      008054 82 00 83 16            107 	int _i2c_irq ; int19
                                    108 ;--------------------------------------------------------
                                    109 ; global & static initialisations
                                    110 ;--------------------------------------------------------
                                    111 	.area HOME
                                    112 	.area GSINIT
                                    113 	.area GSFINAL
                                    114 	.area GSINIT
      00805B CD 85 AB         [ 4]  115 	call	___sdcc_external_startup
      00805E 4D               [ 1]  116 	tnz	a
      00805F 27 03            [ 1]  117 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  118 	jp	__sdcc_program_startup
      008064                        119 __sdcc_init_data:
                                    120 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  121 	ldw x, #l_DATA
      008067 27 07            [ 1]  122 	jreq	00002$
      008069                        123 00001$:
      008069 72 4F 00 00      [ 1]  124 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  125 	decw x
      00806E 26 F9            [ 1]  126 	jrne	00001$
      008070                        127 00002$:
      008070 AE 00 03         [ 2]  128 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  129 	jreq	00004$
      008075                        130 00003$:
      008075 D6 81 2E         [ 1]  131 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  132 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  133 	decw	x
      00807C 26 F7            [ 1]  134 	jrne	00003$
      00807E                        135 00004$:
                                    136 ; stm8_genXINIT() end
                                    137 	.area GSFINAL
      00807E CC 80 58         [ 2]  138 	jp	__sdcc_program_startup
                                    139 ;--------------------------------------------------------
                                    140 ; Home
                                    141 ;--------------------------------------------------------
                                    142 	.area HOME
                                    143 	.area HOME
      008058                        144 __sdcc_program_startup:
      008058 CC 85 62         [ 2]  145 	jp	_main
                                    146 ;	return from main will return to caller
                                    147 ;--------------------------------------------------------
                                    148 ; code
                                    149 ;--------------------------------------------------------
                                    150 	.area CODE
                                    151 ;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    152 ;	-----------------------------------------
                                    153 ;	 function uart_transmission_irq
                                    154 ;	-----------------------------------------
      008132                        155 _uart_transmission_irq:
                                    156 ;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      008132 AE 52 30         [ 2]  157 	ldw	x, #0x5230
      008135 F6               [ 1]  158 	ld	a, (x)
      008136 4E               [ 1]  159 	swap	a
      008137 44               [ 1]  160 	srl	a
      008138 44               [ 1]  161 	srl	a
      008139 44               [ 1]  162 	srl	a
      00813A A5 01            [ 1]  163 	bcp	a, #0x01
      00813C 27 2F            [ 1]  164 	jreq	00107$
                                    165 ;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      00813E C6 00 02         [ 1]  166 	ld	a, _tx_buf_pointer+1
      008141 CB 00 05         [ 1]  167 	add	a, _buf_pos+0
      008144 97               [ 1]  168 	ld	xl, a
      008145 C6 00 01         [ 1]  169 	ld	a, _tx_buf_pointer+0
      008148 A9 00            [ 1]  170 	adc	a, #0x00
      00814A 95               [ 1]  171 	ld	xh, a
      00814B F6               [ 1]  172 	ld	a, (x)
      00814C 27 1B            [ 1]  173 	jreq	00102$
      00814E C6 00 05         [ 1]  174 	ld	a, _buf_pos+0
      008151 C1 00 06         [ 1]  175 	cp	a, _buf_size+0
      008154 24 13            [ 1]  176 	jrnc	00102$
                                    177 ;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      008156 C6 00 05         [ 1]  178 	ld	a, _buf_pos+0
      008159 72 5C 00 05      [ 1]  179 	inc	_buf_pos+0
      00815D 5F               [ 1]  180 	clrw	x
      00815E 97               [ 1]  181 	ld	xl, a
      00815F 72 BB 00 01      [ 2]  182 	addw	x, _tx_buf_pointer+0
      008163 F6               [ 1]  183 	ld	a, (x)
      008164 C7 52 31         [ 1]  184 	ld	0x5231, a
      008167 20 04            [ 2]  185 	jra	00107$
      008169                        186 00102$:
                                    187 ;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      008169 72 1F 52 35      [ 1]  188 	bres	0x5235, #7
      00816D                        189 00107$:
                                    190 ;	libs/uart_lib.c: 14: }
      00816D 80               [11]  191 	iret
                                    192 ;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    193 ;	-----------------------------------------
                                    194 ;	 function uart_reciever_irq
                                    195 ;	-----------------------------------------
      00816E                        196 _uart_reciever_irq:
      00816E 88               [ 1]  197 	push	a
                                    198 ;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
      00816F C6 52 30         [ 1]  199 	ld	a, 0x5230
      008172 4E               [ 1]  200 	swap	a
      008173 44               [ 1]  201 	srl	a
      008174 A5 01            [ 1]  202 	bcp	a, #0x01
      008176 27 27            [ 1]  203 	jreq	00107$
                                    204 ;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
      008178 C6 52 31         [ 1]  205 	ld	a, 0x5231
                                    206 ;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
      00817B 6B 01            [ 1]  207 	ld	(0x01, sp), a
      00817D A1 0A            [ 1]  208 	cp	a, #0x0a
      00817F 27 1A            [ 1]  209 	jreq	00102$
      008181 C6 00 05         [ 1]  210 	ld	a, _buf_pos+0
      008184 C1 00 06         [ 1]  211 	cp	a, _buf_size+0
      008187 24 12            [ 1]  212 	jrnc	00102$
                                    213 ;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
      008189 C6 00 05         [ 1]  214 	ld	a, _buf_pos+0
      00818C 72 5C 00 05      [ 1]  215 	inc	_buf_pos+0
      008190 5F               [ 1]  216 	clrw	x
      008191 97               [ 1]  217 	ld	xl, a
      008192 72 BB 00 03      [ 2]  218 	addw	x, _rx_buf_pointer+0
      008196 7B 01            [ 1]  219 	ld	a, (0x01, sp)
      008198 F7               [ 1]  220 	ld	(x), a
      008199 20 04            [ 2]  221 	jra	00107$
      00819B                        222 00102$:
                                    223 ;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
      00819B 72 1B 52 35      [ 1]  224 	bres	0x5235, #5
      00819F                        225 00107$:
                                    226 ;	libs/uart_lib.c: 29: }
      00819F 84               [ 1]  227 	pop	a
      0081A0 80               [11]  228 	iret
                                    229 ;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    230 ;	-----------------------------------------
                                    231 ;	 function uart_init
                                    232 ;	-----------------------------------------
      0081A1                        233 _uart_init:
      0081A1 52 02            [ 2]  234 	sub	sp, #2
      0081A3 1F 01            [ 2]  235 	ldw	(0x01, sp), x
                                    236 ;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
      0081A5 AE 52 35         [ 2]  237 	ldw	x, #0x5235
      0081A8 88               [ 1]  238 	push	a
      0081A9 F6               [ 1]  239 	ld	a, (x)
      0081AA AA 08            [ 1]  240 	or	a, #0x08
      0081AC F7               [ 1]  241 	ld	(x), a
      0081AD 84               [ 1]  242 	pop	a
                                    243 ;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
      0081AE AE 52 35         [ 2]  244 	ldw	x, #0x5235
      0081B1 88               [ 1]  245 	push	a
      0081B2 F6               [ 1]  246 	ld	a, (x)
      0081B3 AA 04            [ 1]  247 	or	a, #0x04
      0081B5 F7               [ 1]  248 	ld	(x), a
      0081B6 84               [ 1]  249 	pop	a
                                    250 ;	libs/uart_lib.c: 36: switch(stopbit)
      0081B7 A1 02            [ 1]  251 	cp	a, #0x02
      0081B9 27 06            [ 1]  252 	jreq	00101$
      0081BB A1 03            [ 1]  253 	cp	a, #0x03
      0081BD 27 0E            [ 1]  254 	jreq	00102$
      0081BF 20 16            [ 2]  255 	jra	00103$
                                    256 ;	libs/uart_lib.c: 38: case 2:
      0081C1                        257 00101$:
                                    258 ;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
      0081C1 C6 52 36         [ 1]  259 	ld	a, 0x5236
      0081C4 A4 CF            [ 1]  260 	and	a, #0xcf
      0081C6 AA 20            [ 1]  261 	or	a, #0x20
      0081C8 C7 52 36         [ 1]  262 	ld	0x5236, a
                                    263 ;	libs/uart_lib.c: 40: break;
      0081CB 20 12            [ 2]  264 	jra	00104$
                                    265 ;	libs/uart_lib.c: 41: case 3:
      0081CD                        266 00102$:
                                    267 ;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
      0081CD C6 52 36         [ 1]  268 	ld	a, 0x5236
      0081D0 AA 30            [ 1]  269 	or	a, #0x30
      0081D2 C7 52 36         [ 1]  270 	ld	0x5236, a
                                    271 ;	libs/uart_lib.c: 43: break;
      0081D5 20 08            [ 2]  272 	jra	00104$
                                    273 ;	libs/uart_lib.c: 44: default:
      0081D7                        274 00103$:
                                    275 ;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
      0081D7 C6 52 36         [ 1]  276 	ld	a, 0x5236
      0081DA A4 CF            [ 1]  277 	and	a, #0xcf
      0081DC C7 52 36         [ 1]  278 	ld	0x5236, a
                                    279 ;	libs/uart_lib.c: 47: }
      0081DF                        280 00104$:
                                    281 ;	libs/uart_lib.c: 48: switch(baudrate)
      0081DF 1E 01            [ 2]  282 	ldw	x, (0x01, sp)
      0081E1 A3 08 00         [ 2]  283 	cpw	x, #0x0800
      0081E4 26 03            [ 1]  284 	jrne	00186$
      0081E6 CC 82 72         [ 2]  285 	jp	00110$
      0081E9                        286 00186$:
      0081E9 1E 01            [ 2]  287 	ldw	x, (0x01, sp)
      0081EB A3 09 60         [ 2]  288 	cpw	x, #0x0960
      0081EE 27 28            [ 1]  289 	jreq	00105$
      0081F0 1E 01            [ 2]  290 	ldw	x, (0x01, sp)
      0081F2 A3 10 00         [ 2]  291 	cpw	x, #0x1000
      0081F5 26 03            [ 1]  292 	jrne	00192$
      0081F7 CC 82 82         [ 2]  293 	jp	00111$
      0081FA                        294 00192$:
      0081FA 1E 01            [ 2]  295 	ldw	x, (0x01, sp)
      0081FC A3 4B 00         [ 2]  296 	cpw	x, #0x4b00
      0081FF 27 31            [ 1]  297 	jreq	00106$
      008201 1E 01            [ 2]  298 	ldw	x, (0x01, sp)
      008203 A3 84 00         [ 2]  299 	cpw	x, #0x8400
      008206 27 5A            [ 1]  300 	jreq	00109$
      008208 1E 01            [ 2]  301 	ldw	x, (0x01, sp)
      00820A A3 C2 00         [ 2]  302 	cpw	x, #0xc200
      00820D 27 43            [ 1]  303 	jreq	00108$
      00820F 1E 01            [ 2]  304 	ldw	x, (0x01, sp)
      008211 A3 E1 00         [ 2]  305 	cpw	x, #0xe100
      008214 27 2C            [ 1]  306 	jreq	00107$
      008216 20 7A            [ 2]  307 	jra	00112$
                                    308 ;	libs/uart_lib.c: 50: case (unsigned int)2400:
      008218                        309 00105$:
                                    310 ;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
      008218 C6 52 33         [ 1]  311 	ld	a, 0x5233
      00821B A4 0F            [ 1]  312 	and	a, #0x0f
      00821D AA 10            [ 1]  313 	or	a, #0x10
      00821F C7 52 33         [ 1]  314 	ld	0x5233, a
                                    315 ;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
      008222 35 A0 52 32      [ 1]  316 	mov	0x5232+0, #0xa0
                                    317 ;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
      008226 C6 52 33         [ 1]  318 	ld	a, 0x5233
      008229 A4 F0            [ 1]  319 	and	a, #0xf0
      00822B AA 0B            [ 1]  320 	or	a, #0x0b
      00822D C7 52 33         [ 1]  321 	ld	0x5233, a
                                    322 ;	libs/uart_lib.c: 54: break;
      008230 20 6E            [ 2]  323 	jra	00114$
                                    324 ;	libs/uart_lib.c: 55: case (unsigned int)19200:
      008232                        325 00106$:
                                    326 ;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
      008232 35 34 52 32      [ 1]  327 	mov	0x5232+0, #0x34
                                    328 ;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
      008236 C6 52 33         [ 1]  329 	ld	a, 0x5233
      008239 A4 F0            [ 1]  330 	and	a, #0xf0
      00823B AA 01            [ 1]  331 	or	a, #0x01
      00823D C7 52 33         [ 1]  332 	ld	0x5233, a
                                    333 ;	libs/uart_lib.c: 58: break;
      008240 20 5E            [ 2]  334 	jra	00114$
                                    335 ;	libs/uart_lib.c: 59: case (unsigned int)57600:
      008242                        336 00107$:
                                    337 ;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
      008242 35 11 52 32      [ 1]  338 	mov	0x5232+0, #0x11
                                    339 ;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
      008246 C6 52 33         [ 1]  340 	ld	a, 0x5233
      008249 A4 F0            [ 1]  341 	and	a, #0xf0
      00824B AA 06            [ 1]  342 	or	a, #0x06
      00824D C7 52 33         [ 1]  343 	ld	0x5233, a
                                    344 ;	libs/uart_lib.c: 62: break;
      008250 20 4E            [ 2]  345 	jra	00114$
                                    346 ;	libs/uart_lib.c: 63: case (unsigned int)115200:
      008252                        347 00108$:
                                    348 ;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
      008252 35 08 52 32      [ 1]  349 	mov	0x5232+0, #0x08
                                    350 ;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
      008256 C6 52 33         [ 1]  351 	ld	a, 0x5233
      008259 A4 F0            [ 1]  352 	and	a, #0xf0
      00825B AA 0B            [ 1]  353 	or	a, #0x0b
      00825D C7 52 33         [ 1]  354 	ld	0x5233, a
                                    355 ;	libs/uart_lib.c: 66: break;
      008260 20 3E            [ 2]  356 	jra	00114$
                                    357 ;	libs/uart_lib.c: 67: case (unsigned int)230400:
      008262                        358 00109$:
                                    359 ;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
      008262 35 04 52 32      [ 1]  360 	mov	0x5232+0, #0x04
                                    361 ;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
      008266 C6 52 33         [ 1]  362 	ld	a, 0x5233
      008269 A4 F0            [ 1]  363 	and	a, #0xf0
      00826B AA 05            [ 1]  364 	or	a, #0x05
      00826D C7 52 33         [ 1]  365 	ld	0x5233, a
                                    366 ;	libs/uart_lib.c: 70: break;
      008270 20 2E            [ 2]  367 	jra	00114$
                                    368 ;	libs/uart_lib.c: 71: case (unsigned int)460800:
      008272                        369 00110$:
                                    370 ;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
      008272 35 02 52 32      [ 1]  371 	mov	0x5232+0, #0x02
                                    372 ;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
      008276 C6 52 33         [ 1]  373 	ld	a, 0x5233
      008279 A4 F0            [ 1]  374 	and	a, #0xf0
      00827B AA 03            [ 1]  375 	or	a, #0x03
      00827D C7 52 33         [ 1]  376 	ld	0x5233, a
                                    377 ;	libs/uart_lib.c: 74: break;
      008280 20 1E            [ 2]  378 	jra	00114$
                                    379 ;	libs/uart_lib.c: 75: case (unsigned int)921600:
      008282                        380 00111$:
                                    381 ;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
      008282 35 01 52 32      [ 1]  382 	mov	0x5232+0, #0x01
                                    383 ;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      008286 C6 52 33         [ 1]  384 	ld	a, 0x5233
      008289 A4 F0            [ 1]  385 	and	a, #0xf0
      00828B AA 01            [ 1]  386 	or	a, #0x01
      00828D C7 52 33         [ 1]  387 	ld	0x5233, a
                                    388 ;	libs/uart_lib.c: 78: break;
      008290 20 0E            [ 2]  389 	jra	00114$
                                    390 ;	libs/uart_lib.c: 79: default:
      008292                        391 00112$:
                                    392 ;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
      008292 35 68 52 32      [ 1]  393 	mov	0x5232+0, #0x68
                                    394 ;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
      008296 C6 52 33         [ 1]  395 	ld	a, 0x5233
      008299 A4 F0            [ 1]  396 	and	a, #0xf0
      00829B AA 03            [ 1]  397 	or	a, #0x03
      00829D C7 52 33         [ 1]  398 	ld	0x5233, a
                                    399 ;	libs/uart_lib.c: 83: }
      0082A0                        400 00114$:
                                    401 ;	libs/uart_lib.c: 84: }
      0082A0 5B 02            [ 2]  402 	addw	sp, #2
      0082A2 81               [ 4]  403 	ret
                                    404 ;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
                                    405 ;	-----------------------------------------
                                    406 ;	 function uart_read_byte
                                    407 ;	-----------------------------------------
      0082A3                        408 _uart_read_byte:
                                    409 ;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
      0082A3                        410 00101$:
      0082A3 72 0B 52 30 FB   [ 2]  411 	btjf	0x5230, #5, 00101$
                                    412 ;	libs/uart_lib.c: 90: return 1;
      0082A8 5F               [ 1]  413 	clrw	x
      0082A9 5C               [ 1]  414 	incw	x
                                    415 ;	libs/uart_lib.c: 91: }
      0082AA 81               [ 4]  416 	ret
                                    417 ;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
                                    418 ;	-----------------------------------------
                                    419 ;	 function uart_write_byte
                                    420 ;	-----------------------------------------
      0082AB                        421 _uart_write_byte:
                                    422 ;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
      0082AB C7 52 31         [ 1]  423 	ld	0x5231, a
                                    424 ;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
      0082AE                        425 00101$:
      0082AE 72 0F 52 30 FB   [ 2]  426 	btjf	0x5230, #7, 00101$
                                    427 ;	libs/uart_lib.c: 97: return 1;
      0082B3 5F               [ 1]  428 	clrw	x
      0082B4 5C               [ 1]  429 	incw	x
                                    430 ;	libs/uart_lib.c: 98: }
      0082B5 81               [ 4]  431 	ret
                                    432 ;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
                                    433 ;	-----------------------------------------
                                    434 ;	 function uart_write
                                    435 ;	-----------------------------------------
      0082B6                        436 _uart_write:
      0082B6 52 02            [ 2]  437 	sub	sp, #2
                                    438 ;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
      0082B8 1F 01            [ 2]  439 	ldw	(0x01, sp), x
      0082BA CF 00 01         [ 2]  440 	ldw	_tx_buf_pointer+0, x
                                    441 ;	libs/uart_lib.c: 103: buf_pos = 0;
      0082BD 72 5F 00 05      [ 1]  442 	clr	_buf_pos+0
                                    443 ;	libs/uart_lib.c: 104: buf_size = 0;
      0082C1 72 5F 00 06      [ 1]  444 	clr	_buf_size+0
                                    445 ;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
      0082C5                        446 00101$:
      0082C5 C6 00 06         [ 1]  447 	ld	a, _buf_size+0
      0082C8 72 5C 00 06      [ 1]  448 	inc	_buf_size+0
      0082CC 5F               [ 1]  449 	clrw	x
      0082CD 97               [ 1]  450 	ld	xl, a
      0082CE 72 FB 01         [ 2]  451 	addw	x, (0x01, sp)
      0082D1 F6               [ 1]  452 	ld	a, (x)
      0082D2 26 F1            [ 1]  453 	jrne	00101$
                                    454 ;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
      0082D4 72 1E 52 35      [ 1]  455 	bset	0x5235, #7
                                    456 ;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
      0082D8                        457 00104$:
      0082D8 72 0E 52 35 FB   [ 2]  458 	btjt	0x5235, #7, 00104$
                                    459 ;	libs/uart_lib.c: 108: }
      0082DD 5B 02            [ 2]  460 	addw	sp, #2
      0082DF 81               [ 4]  461 	ret
                                    462 ;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
                                    463 ;	-----------------------------------------
                                    464 ;	 function uart_read
                                    465 ;	-----------------------------------------
      0082E0                        466 _uart_read:
                                    467 ;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
      0082E0 CF 00 03         [ 2]  468 	ldw	_rx_buf_pointer+0, x
                                    469 ;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
      0082E3 AE 80 81         [ 2]  470 	ldw	x, #(___str_0+0)
      0082E6 CD 82 B6         [ 4]  471 	call	_uart_write
                                    472 ;	libs/uart_lib.c: 113: buf_pos = 0;
      0082E9 72 5F 00 05      [ 1]  473 	clr	_buf_pos+0
                                    474 ;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
      0082ED AE 80 91         [ 2]  475 	ldw	x, #(___str_1+0)
      0082F0 CD 82 B6         [ 4]  476 	call	_uart_write
                                    477 ;	libs/uart_lib.c: 115: buf_size = size;
      0082F3 7B 04            [ 1]  478 	ld	a, (0x04, sp)
      0082F5 C7 00 06         [ 1]  479 	ld	_buf_size+0, a
                                    480 ;	libs/uart_lib.c: 116: uart_write("buf_size\n");
      0082F8 AE 80 9A         [ 2]  481 	ldw	x, #(___str_2+0)
      0082FB CD 82 B6         [ 4]  482 	call	_uart_write
                                    483 ;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
      0082FE 72 1A 52 35      [ 1]  484 	bset	0x5235, #5
                                    485 ;	libs/uart_lib.c: 118: uart_write("RIEN\n");
      008302 AE 80 A4         [ 2]  486 	ldw	x, #(___str_3+0)
      008305 CD 82 B6         [ 4]  487 	call	_uart_write
                                    488 ;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
      008308                        489 00101$:
      008308 C6 52 35         [ 1]  490 	ld	a, 0x5235
      00830B 4E               [ 1]  491 	swap	a
      00830C 44               [ 1]  492 	srl	a
      00830D A4 01            [ 1]  493 	and	a, #0x01
      00830F 26 F7            [ 1]  494 	jrne	00101$
                                    495 ;	libs/uart_lib.c: 120: }
      008311 1E 01            [ 2]  496 	ldw	x, (1, sp)
      008313 5B 04            [ 2]  497 	addw	sp, #4
      008315 FC               [ 2]  498 	jp	(x)
                                    499 ;	libs/i2c_lib.c: 5: void i2c_irq(void) __interrupt(I2C_vector)
                                    500 ;	-----------------------------------------
                                    501 ;	 function i2c_irq
                                    502 ;	-----------------------------------------
      008316                        503 _i2c_irq:
      008316 4F               [ 1]  504 	clr	a
      008317 62               [ 2]  505 	div	x, a
                                    506 ;	libs/i2c_lib.c: 8: disableInterrupts();
      008318 9B               [ 1]  507 	sim
                                    508 ;	libs/i2c_lib.c: 9: memset(&I2C_IRQ, 0, sizeof(I2C_IRQ));
      008319 4B 01            [ 1]  509 	push	#0x01
      00831B 4B 00            [ 1]  510 	push	#0x00
      00831D 5F               [ 1]  511 	clrw	x
      00831E 89               [ 2]  512 	pushw	x
      00831F AE 00 07         [ 2]  513 	ldw	x, #(_I2C_IRQ+0)
      008322 CD 85 89         [ 4]  514 	call	_memset
                                    515 ;	libs/i2c_lib.c: 10: govno_alert = 0;
      008325 72 5F 00 08      [ 1]  516 	clr	_govno_alert+0
                                    517 ;	libs/i2c_lib.c: 11: if(I2C_SR1 -> ADDR == 1)
      008329 72 03 52 17 08   [ 2]  518 	btjf	0x5217, #1, 00102$
                                    519 ;	libs/i2c_lib.c: 14: I2C_IRQ.ADDR = 1;
      00832E 72 12 00 07      [ 1]  520 	bset	_I2C_IRQ+0, #1
                                    521 ;	libs/i2c_lib.c: 15: govno_alert = 6;
      008332 35 06 00 08      [ 1]  522 	mov	_govno_alert+0, #0x06
                                    523 ;	libs/i2c_lib.c: 16: I2C_SR3; //EV6 
      008336                        524 00102$:
                                    525 ;	libs/i2c_lib.c: 19: if(I2C_SR1 -> SB)//EV5 
      008336 72 01 52 17 04   [ 2]  526 	btjf	0x5217, #0, 00104$
                                    527 ;	libs/i2c_lib.c: 22: I2C_IRQ.SB = 1;
      00833B 72 10 00 07      [ 1]  528 	bset	_I2C_IRQ+0, #0
      00833F                        529 00104$:
                                    530 ;	libs/i2c_lib.c: 24: if(I2C_SR1 -> BTF) 
      00833F 72 05 52 17 04   [ 2]  531 	btjf	0x5217, #2, 00106$
                                    532 ;	libs/i2c_lib.c: 26: I2C_IRQ.BTF = 1;
      008344 72 14 00 07      [ 1]  533 	bset	_I2C_IRQ+0, #2
      008348                        534 00106$:
                                    535 ;	libs/i2c_lib.c: 28: if(I2C_SR1 -> TXE) 
      008348 72 0F 52 17 08   [ 2]  536 	btjf	0x5217, #7, 00108$
                                    537 ;	libs/i2c_lib.c: 30: counter++;
      00834D 72 5C 00 09      [ 1]  538 	inc	_counter+0
                                    539 ;	libs/i2c_lib.c: 31: I2C_IRQ.TXE = 1;
      008351 72 18 00 07      [ 1]  540 	bset	_I2C_IRQ+0, #4
      008355                        541 00108$:
                                    542 ;	libs/i2c_lib.c: 33: if(I2C_SR1 -> RXNE) 
      008355 72 0D 52 17 04   [ 2]  543 	btjf	0x5217, #6, 00110$
                                    544 ;	libs/i2c_lib.c: 35: I2C_IRQ.RXNE = 1;
      00835A 72 16 00 07      [ 1]  545 	bset	_I2C_IRQ+0, #3
      00835E                        546 00110$:
                                    547 ;	libs/i2c_lib.c: 37: if(I2C_SR2 -> AF) 
      00835E C6 52 18         [ 1]  548 	ld	a, 0x5218
      008361 44               [ 1]  549 	srl	a
      008362 44               [ 1]  550 	srl	a
      008363 A5 01            [ 1]  551 	bcp	a, #0x01
      008365 27 04            [ 1]  552 	jreq	00112$
                                    553 ;	libs/i2c_lib.c: 39: I2C_IRQ.AF = 1;
      008367 72 1A 00 07      [ 1]  554 	bset	_I2C_IRQ+0, #5
      00836B                        555 00112$:
                                    556 ;	libs/i2c_lib.c: 41: I2C_ITR -> ITBUFEN = 0;
      00836B 72 15 52 1A      [ 1]  557 	bres	0x521a, #2
                                    558 ;	libs/i2c_lib.c: 42: I2C_ITR -> ITEVTEN = 0; //Выключение флагов прерываний
      00836F 72 13 52 1A      [ 1]  559 	bres	0x521a, #1
                                    560 ;	libs/i2c_lib.c: 43: I2C_ITR -> ITERREN = 0;
      008373 AE 52 1A         [ 2]  561 	ldw	x, #0x521a
      008376 F6               [ 1]  562 	ld	a, (x)
      008377 A4 FE            [ 1]  563 	and	a, #0xfe
      008379 F7               [ 1]  564 	ld	(x), a
                                    565 ;	libs/i2c_lib.c: 44: enableInterrupts(); 
      00837A 9A               [ 1]  566 	rim
                                    567 ;	libs/i2c_lib.c: 46: }
      00837B 80               [11]  568 	iret
                                    569 ;	libs/i2c_lib.c: 47: void i2c_init(void)
                                    570 ;	-----------------------------------------
                                    571 ;	 function i2c_init
                                    572 ;	-----------------------------------------
      00837C                        573 _i2c_init:
                                    574 ;	libs/i2c_lib.c: 51: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      00837C 72 11 52 10      [ 1]  575 	bres	0x5210, #0
                                    576 ;	libs/i2c_lib.c: 52: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      008380 C6 52 12         [ 1]  577 	ld	a, 0x5212
      008383 A4 C0            [ 1]  578 	and	a, #0xc0
      008385 AA 10            [ 1]  579 	or	a, #0x10
      008387 C7 52 12         [ 1]  580 	ld	0x5212, a
                                    581 ;	libs/i2c_lib.c: 53: I2C_CCRH -> CCR = 0;// =0
      00838A C6 52 1C         [ 1]  582 	ld	a, 0x521c
      00838D A4 F0            [ 1]  583 	and	a, #0xf0
      00838F C7 52 1C         [ 1]  584 	ld	0x521c, a
                                    585 ;	libs/i2c_lib.c: 54: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008392 35 50 52 1B      [ 1]  586 	mov	0x521b+0, #0x50
                                    587 ;	libs/i2c_lib.c: 55: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      008396 72 1F 52 1C      [ 1]  588 	bres	0x521c, #7
                                    589 ;	libs/i2c_lib.c: 56: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      00839A 72 1F 52 14      [ 1]  590 	bres	0x5214, #7
                                    591 ;	libs/i2c_lib.c: 57: I2C_OARH -> ADDCONF = 1;// see reference manual
      00839E 72 10 52 14      [ 1]  592 	bset	0x5214, #0
                                    593 ;	libs/i2c_lib.c: 58: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0083A2 72 10 52 10      [ 1]  594 	bset	0x5210, #0
                                    595 ;	libs/i2c_lib.c: 59: }
      0083A6 81               [ 4]  596 	ret
                                    597 ;	libs/i2c_lib.c: 61: void i2c_start(void)
                                    598 ;	-----------------------------------------
                                    599 ;	 function i2c_start
                                    600 ;	-----------------------------------------
      0083A7                        601 _i2c_start:
                                    602 ;	libs/i2c_lib.c: 63: uart_write("i2c_start\n");
      0083A7 AE 80 AA         [ 2]  603 	ldw	x, #(___str_4+0)
      0083AA CD 82 B6         [ 4]  604 	call	_uart_write
                                    605 ;	libs/i2c_lib.c: 64: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      0083AD 72 12 52 1A      [ 1]  606 	bset	0x521a, #1
                                    607 ;	libs/i2c_lib.c: 65: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
      0083B1 72 10 52 11      [ 1]  608 	bset	0x5211, #0
                                    609 ;	libs/i2c_lib.c: 66: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      0083B5                        610 00101$:
      0083B5 C6 52 1A         [ 1]  611 	ld	a, 0x521a
      0083B8 A5 02            [ 1]  612 	bcp	a, #2
      0083BA 26 F9            [ 1]  613 	jrne	00101$
                                    614 ;	libs/i2c_lib.c: 68: }
      0083BC 81               [ 4]  615 	ret
                                    616 ;	libs/i2c_lib.c: 70: void i2c_stop(void)
                                    617 ;	-----------------------------------------
                                    618 ;	 function i2c_stop
                                    619 ;	-----------------------------------------
      0083BD                        620 _i2c_stop:
                                    621 ;	libs/i2c_lib.c: 72: uart_write("i2c_stop\n");
      0083BD AE 80 B5         [ 2]  622 	ldw	x, #(___str_5+0)
      0083C0 CD 82 B6         [ 4]  623 	call	_uart_write
                                    624 ;	libs/i2c_lib.c: 73: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
      0083C3 72 12 52 11      [ 1]  625 	bset	0x5211, #1
                                    626 ;	libs/i2c_lib.c: 74: if(govno_alert == 6)
      0083C7 C6 00 08         [ 1]  627 	ld	a, _govno_alert+0
      0083CA A1 06            [ 1]  628 	cp	a, #0x06
      0083CC 27 01            [ 1]  629 	jreq	00114$
      0083CE 81               [ 4]  630 	ret
      0083CF                        631 00114$:
                                    632 ;	libs/i2c_lib.c: 75: uart_write("govno alert\n");
      0083CF AE 80 BF         [ 2]  633 	ldw	x, #(___str_6+0)
                                    634 ;	libs/i2c_lib.c: 77: }
      0083D2 CC 82 B6         [ 2]  635 	jp	_uart_write
                                    636 ;	libs/i2c_lib.c: 79: uint8_t i2c_send_byte(unsigned char data)
                                    637 ;	-----------------------------------------
                                    638 ;	 function i2c_send_byte
                                    639 ;	-----------------------------------------
      0083D5                        640 _i2c_send_byte:
      0083D5 88               [ 1]  641 	push	a
      0083D6 6B 01            [ 1]  642 	ld	(0x01, sp), a
                                    643 ;	libs/i2c_lib.c: 81: uart_write("i2c_send_byte\n");
      0083D8 AE 80 CC         [ 2]  644 	ldw	x, #(___str_7+0)
      0083DB CD 82 B6         [ 4]  645 	call	_uart_write
                                    646 ;	libs/i2c_lib.c: 82: I2C_ITR -> ITBUFEN = 1;
      0083DE 72 14 52 1A      [ 1]  647 	bset	0x521a, #2
                                    648 ;	libs/i2c_lib.c: 83: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      0083E2 72 12 52 1A      [ 1]  649 	bset	0x521a, #1
                                    650 ;	libs/i2c_lib.c: 84: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      0083E6 72 10 52 1A      [ 1]  651 	bset	0x521a, #0
                                    652 ;	libs/i2c_lib.c: 85: uart_write("i2c_irq_enable_all_send_byte\n");
      0083EA AE 80 DB         [ 2]  653 	ldw	x, #(___str_8+0)
      0083ED CD 82 B6         [ 4]  654 	call	_uart_write
                                    655 ;	libs/i2c_lib.c: 86: while(I2C_ITR -> ITERREN && I2C_ITR -> ITEVTEN);
      0083F0                        656 00102$:
      0083F0 C6 52 1A         [ 1]  657 	ld	a, 0x521a
      0083F3 A5 01            [ 1]  658 	bcp	a, #0x01
      0083F5 27 07            [ 1]  659 	jreq	00104$
      0083F7 C6 52 1A         [ 1]  660 	ld	a, 0x521a
      0083FA A5 02            [ 1]  661 	bcp	a, #2
      0083FC 26 F2            [ 1]  662 	jrne	00102$
      0083FE                        663 00104$:
                                    664 ;	libs/i2c_lib.c: 88: I2C_DR -> DR = data; //Отправка данных
      0083FE AE 52 16         [ 2]  665 	ldw	x, #0x5216
      008401 7B 01            [ 1]  666 	ld	a, (0x01, sp)
      008403 F7               [ 1]  667 	ld	(x), a
                                    668 ;	libs/i2c_lib.c: 89: I2C_DR -> DR = data; //Отправка данных
      008404 AE 52 16         [ 2]  669 	ldw	x, #0x5216
      008407 7B 01            [ 1]  670 	ld	a, (0x01, sp)
      008409 F7               [ 1]  671 	ld	(x), a
                                    672 ;	libs/i2c_lib.c: 90: uart_write("AF -> ");
      00840A AE 80 F9         [ 2]  673 	ldw	x, #(___str_9+0)
      00840D CD 82 B6         [ 4]  674 	call	_uart_write
                                    675 ;	libs/i2c_lib.c: 91: uart_write((I2C_IRQ.AF ? "1\n" : "0\n"));
      008410 72 0B 00 07 04   [ 2]  676 	btjf	_I2C_IRQ+0, #5, 00107$
      008415 AE 81 00         [ 2]  677 	ldw	x, #___str_10+0
      008418 BC                     678 	.byte 0xbc
      008419                        679 00107$:
      008419 AE 81 03         [ 2]  680 	ldw	x, #___str_11+0
      00841C                        681 00108$:
      00841C CD 82 B6         [ 4]  682 	call	_uart_write
                                    683 ;	libs/i2c_lib.c: 92: return I2C_IRQ.AF;
      00841F C6 00 07         [ 1]  684 	ld	a, _I2C_IRQ+0
      008422 4E               [ 1]  685 	swap	a
      008423 44               [ 1]  686 	srl	a
      008424 A4 01            [ 1]  687 	and	a, #0x01
                                    688 ;	libs/i2c_lib.c: 93: }
      008426 5B 01            [ 2]  689 	addw	sp, #1
      008428 81               [ 4]  690 	ret
                                    691 ;	libs/i2c_lib.c: 95: uint8_t i2c_read_byte(unsigned char *data){
                                    692 ;	-----------------------------------------
                                    693 ;	 function i2c_read_byte
                                    694 ;	-----------------------------------------
      008429                        695 _i2c_read_byte:
                                    696 ;	libs/i2c_lib.c: 96: while (!(I2C_SR1 -> RXNE));
      008429                        697 00101$:
      008429 72 0D 52 17 FB   [ 2]  698 	btjf	0x5217, #6, 00101$
                                    699 ;	libs/i2c_lib.c: 98: return 0;
      00842E 4F               [ 1]  700 	clr	a
                                    701 ;	libs/i2c_lib.c: 100: }
      00842F 81               [ 4]  702 	ret
                                    703 ;	libs/i2c_lib.c: 105: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    704 ;	-----------------------------------------
                                    705 ;	 function i2c_send_address
                                    706 ;	-----------------------------------------
      008430                        707 _i2c_send_address:
      008430 88               [ 1]  708 	push	a
      008431 6B 01            [ 1]  709 	ld	(0x01, sp), a
                                    710 ;	libs/i2c_lib.c: 107: i2c_start();
      008433 CD 83 A7         [ 4]  711 	call	_i2c_start
                                    712 ;	libs/i2c_lib.c: 108: uart_write("i2c_send_address\n");
      008436 AE 81 06         [ 2]  713 	ldw	x, #(___str_12+0)
      008439 CD 82 B6         [ 4]  714 	call	_uart_write
                                    715 ;	libs/i2c_lib.c: 112: address = address << 1;
      00843C 7B 01            [ 1]  716 	ld	a, (0x01, sp)
      00843E 48               [ 1]  717 	sll	a
                                    718 ;	libs/i2c_lib.c: 109: switch(rw_type)
      00843F 88               [ 1]  719 	push	a
      008440 7B 05            [ 1]  720 	ld	a, (0x05, sp)
      008442 4A               [ 1]  721 	dec	a
      008443 84               [ 1]  722 	pop	a
      008444 26 02            [ 1]  723 	jrne	00102$
                                    724 ;	libs/i2c_lib.c: 112: address = address << 1;
                                    725 ;	libs/i2c_lib.c: 113: address |= 0x01; // Отправка адреса устройства с битом на чтение
      008446 AA 01            [ 1]  726 	or	a, #0x01
                                    727 ;	libs/i2c_lib.c: 114: break;
                                    728 ;	libs/i2c_lib.c: 115: default:
                                    729 ;	libs/i2c_lib.c: 116: address = address << 1; // Отправка адреса устройства с битом на запись
                                    730 ;	libs/i2c_lib.c: 118: }
      008448                        731 00102$:
                                    732 ;	libs/i2c_lib.c: 119: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      008448 AE 52 1A         [ 2]  733 	ldw	x, #0x521a
      00844B 88               [ 1]  734 	push	a
      00844C F6               [ 1]  735 	ld	a, (x)
      00844D AA 02            [ 1]  736 	or	a, #0x02
      00844F F7               [ 1]  737 	ld	(x), a
      008450 84               [ 1]  738 	pop	a
                                    739 ;	libs/i2c_lib.c: 120: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      008451 AE 52 1A         [ 2]  740 	ldw	x, #0x521a
      008454 88               [ 1]  741 	push	a
      008455 F6               [ 1]  742 	ld	a, (x)
      008456 AA 01            [ 1]  743 	or	a, #0x01
      008458 F7               [ 1]  744 	ld	(x), a
      008459 AE 81 18         [ 2]  745 	ldw	x, #(___str_13+0)
      00845C CD 82 B6         [ 4]  746 	call	_uart_write
      00845F 84               [ 1]  747 	pop	a
                                    748 ;	libs/i2c_lib.c: 122: I2C_DR -> DR = address;
      008460 C7 52 16         [ 1]  749 	ld	0x5216, a
                                    750 ;	libs/i2c_lib.c: 123: while(I2C_ITR -> ITEVTEN && I2C_ITR -> ITERREN);
      008463                        751 00105$:
      008463 C6 52 1A         [ 1]  752 	ld	a, 0x521a
      008466 A5 02            [ 1]  753 	bcp	a, #2
      008468 27 07            [ 1]  754 	jreq	00107$
      00846A C6 52 1A         [ 1]  755 	ld	a, 0x521a
      00846D A5 01            [ 1]  756 	bcp	a, #0x01
      00846F 26 F2            [ 1]  757 	jrne	00105$
      008471                        758 00107$:
                                    759 ;	libs/i2c_lib.c: 124: if(I2C_IRQ.ADDR > 0)
      008471 72 03 00 07 08   [ 2]  760 	btjf	_I2C_IRQ+0, #1, 00109$
                                    761 ;	libs/i2c_lib.c: 125: uart_write("1\n");
      008476 AE 81 00         [ 2]  762 	ldw	x, #(___str_10+0)
      008479 CD 82 B6         [ 4]  763 	call	_uart_write
      00847C 20 06            [ 2]  764 	jra	00110$
      00847E                        765 00109$:
                                    766 ;	libs/i2c_lib.c: 127: uart_write("0\n");
      00847E AE 81 03         [ 2]  767 	ldw	x, #(___str_11+0)
      008481 CD 82 B6         [ 4]  768 	call	_uart_write
      008484                        769 00110$:
                                    770 ;	libs/i2c_lib.c: 129: return I2C_IRQ.AF;
      008484 C6 00 07         [ 1]  771 	ld	a, _I2C_IRQ+0
      008487 4E               [ 1]  772 	swap	a
      008488 44               [ 1]  773 	srl	a
      008489 A4 01            [ 1]  774 	and	a, #0x01
                                    775 ;	libs/i2c_lib.c: 130: }
      00848B 5B 01            [ 2]  776 	addw	sp, #1
      00848D 85               [ 2]  777 	popw	x
      00848E 5B 01            [ 2]  778 	addw	sp, #1
      008490 FC               [ 2]  779 	jp	(x)
                                    780 ;	libs/i2c_lib.c: 132: void delay(uint16_t ticks)
                                    781 ;	-----------------------------------------
                                    782 ;	 function delay
                                    783 ;	-----------------------------------------
      008491                        784 _delay:
                                    785 ;	libs/i2c_lib.c: 134: while(ticks > 0)
      008491                        786 00101$:
      008491 5D               [ 2]  787 	tnzw	x
      008492 26 01            [ 1]  788 	jrne	00120$
      008494 81               [ 4]  789 	ret
      008495                        790 00120$:
                                    791 ;	libs/i2c_lib.c: 136: ticks-=2;
      008495 5A               [ 2]  792 	decw	x
      008496 5A               [ 2]  793 	decw	x
                                    794 ;	libs/i2c_lib.c: 137: ticks+=1;
      008497 5C               [ 1]  795 	incw	x
      008498 20 F7            [ 2]  796 	jra	00101$
                                    797 ;	libs/i2c_lib.c: 139: }
      00849A 81               [ 4]  798 	ret
                                    799 ;	libs/i2c_lib.c: 140: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    800 ;	-----------------------------------------
                                    801 ;	 function i2c_write
                                    802 ;	-----------------------------------------
      00849B                        803 _i2c_write:
      00849B 52 02            [ 2]  804 	sub	sp, #2
                                    805 ;	libs/i2c_lib.c: 142: i2c_send_address(dev_addr, 0);//Проверка на АСК бит
      00849D 4B 00            [ 1]  806 	push	#0x00
      00849F CD 84 30         [ 4]  807 	call	_i2c_send_address
                                    808 ;	libs/i2c_lib.c: 145: for(int i = 0;i < size;i++)
      0084A2 5F               [ 1]  809 	clrw	x
      0084A3                        810 00104$:
      0084A3 7B 05            [ 1]  811 	ld	a, (0x05, sp)
      0084A5 6B 02            [ 1]  812 	ld	(0x02, sp), a
      0084A7 0F 01            [ 1]  813 	clr	(0x01, sp)
      0084A9 13 01            [ 2]  814 	cpw	x, (0x01, sp)
      0084AB 2E 0F            [ 1]  815 	jrsge	00101$
                                    816 ;	libs/i2c_lib.c: 147: i2c_send_byte(data[i]);//Проверка на АСК бит
      0084AD 90 93            [ 1]  817 	ldw	y, x
      0084AF 72 F9 06         [ 2]  818 	addw	y, (0x06, sp)
      0084B2 90 F6            [ 1]  819 	ld	a, (y)
      0084B4 89               [ 2]  820 	pushw	x
      0084B5 CD 83 D5         [ 4]  821 	call	_i2c_send_byte
      0084B8 85               [ 2]  822 	popw	x
                                    823 ;	libs/i2c_lib.c: 145: for(int i = 0;i < size;i++)
      0084B9 5C               [ 1]  824 	incw	x
      0084BA 20 E7            [ 2]  825 	jra	00104$
      0084BC                        826 00101$:
                                    827 ;	libs/i2c_lib.c: 153: i2c_stop();
      0084BC CD 83 BD         [ 4]  828 	call	_i2c_stop
                                    829 ;	libs/i2c_lib.c: 154: for(int i = 0;i< counter;i++)
      0084BF 5F               [ 1]  830 	clrw	x
      0084C0                        831 00107$:
      0084C0 C6 00 09         [ 1]  832 	ld	a, _counter+0
      0084C3 6B 02            [ 1]  833 	ld	(0x02, sp), a
      0084C5 0F 01            [ 1]  834 	clr	(0x01, sp)
      0084C7 13 01            [ 2]  835 	cpw	x, (0x01, sp)
      0084C9 2E 0B            [ 1]  836 	jrsge	00109$
                                    837 ;	libs/i2c_lib.c: 155: uart_write("|");
      0084CB 89               [ 2]  838 	pushw	x
      0084CC AE 81 21         [ 2]  839 	ldw	x, #(___str_14+0)
      0084CF CD 82 B6         [ 4]  840 	call	_uart_write
      0084D2 85               [ 2]  841 	popw	x
                                    842 ;	libs/i2c_lib.c: 154: for(int i = 0;i< counter;i++)
      0084D3 5C               [ 1]  843 	incw	x
      0084D4 20 EA            [ 2]  844 	jra	00107$
      0084D6                        845 00109$:
                                    846 ;	libs/i2c_lib.c: 156: }
      0084D6 1E 03            [ 2]  847 	ldw	x, (3, sp)
      0084D8 5B 07            [ 2]  848 	addw	sp, #7
      0084DA FC               [ 2]  849 	jp	(x)
                                    850 ;	libs/i2c_lib.c: 158: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
                                    851 ;	-----------------------------------------
                                    852 ;	 function i2c_read
                                    853 ;	-----------------------------------------
      0084DB                        854 _i2c_read:
      0084DB 52 02            [ 2]  855 	sub	sp, #2
                                    856 ;	libs/i2c_lib.c: 159: I2C_CR2 -> ACK = 1;
      0084DD AE 52 11         [ 2]  857 	ldw	x, #0x5211
      0084E0 88               [ 1]  858 	push	a
      0084E1 F6               [ 1]  859 	ld	a, (x)
      0084E2 AA 04            [ 1]  860 	or	a, #0x04
      0084E4 F7               [ 1]  861 	ld	(x), a
      0084E5 84               [ 1]  862 	pop	a
                                    863 ;	libs/i2c_lib.c: 160: if(i2c_send_address(dev_addr,1))
      0084E6 4B 01            [ 1]  864 	push	#0x01
      0084E8 CD 84 30         [ 4]  865 	call	_i2c_send_address
      0084EB 4D               [ 1]  866 	tnz	a
      0084EC 27 1F            [ 1]  867 	jreq	00103$
                                    868 ;	libs/i2c_lib.c: 161: for(int i = 0;i < size;i++)
      0084EE 5F               [ 1]  869 	clrw	x
      0084EF                        870 00105$:
      0084EF 7B 05            [ 1]  871 	ld	a, (0x05, sp)
      0084F1 6B 02            [ 1]  872 	ld	(0x02, sp), a
      0084F3 0F 01            [ 1]  873 	clr	(0x01, sp)
      0084F5 13 01            [ 2]  874 	cpw	x, (0x01, sp)
      0084F7 2E 14            [ 1]  875 	jrsge	00103$
                                    876 ;	libs/i2c_lib.c: 163: i2c_read_byte((unsigned char *)data[i]);
      0084F9 90 93            [ 1]  877 	ldw	y, x
      0084FB 72 F9 06         [ 2]  878 	addw	y, (0x06, sp)
      0084FE 90 F6            [ 1]  879 	ld	a, (y)
      008500 90 5F            [ 1]  880 	clrw	y
      008502 90 97            [ 1]  881 	ld	yl, a
      008504 89               [ 2]  882 	pushw	x
      008505 93               [ 1]  883 	ldw	x, y
      008506 CD 84 29         [ 4]  884 	call	_i2c_read_byte
      008509 85               [ 2]  885 	popw	x
                                    886 ;	libs/i2c_lib.c: 161: for(int i = 0;i < size;i++)
      00850A 5C               [ 1]  887 	incw	x
      00850B 20 E2            [ 2]  888 	jra	00105$
      00850D                        889 00103$:
                                    890 ;	libs/i2c_lib.c: 165: I2C_CR2 -> ACK = 0;
      00850D C6 52 11         [ 1]  891 	ld	a, 0x5211
      008510 A4 FB            [ 1]  892 	and	a, #0xfb
      008512 C7 52 11         [ 1]  893 	ld	0x5211, a
                                    894 ;	libs/i2c_lib.c: 166: }
      008515 1E 03            [ 2]  895 	ldw	x, (3, sp)
      008517 5B 07            [ 2]  896 	addw	sp, #7
      008519 FC               [ 2]  897 	jp	(x)
                                    898 ;	libs/i2c_lib.c: 167: uint8_t i2c_scan(void) 
                                    899 ;	-----------------------------------------
                                    900 ;	 function i2c_scan
                                    901 ;	-----------------------------------------
      00851A                        902 _i2c_scan:
      00851A 52 02            [ 2]  903 	sub	sp, #2
                                    904 ;	libs/i2c_lib.c: 169: for (uint8_t addr = 1; addr < 127; addr++)
      00851C A6 01            [ 1]  905 	ld	a, #0x01
      00851E 6B 01            [ 1]  906 	ld	(0x01, sp), a
      008520 6B 02            [ 1]  907 	ld	(0x02, sp), a
      008522                        908 00105$:
      008522 7B 02            [ 1]  909 	ld	a, (0x02, sp)
      008524 A1 7F            [ 1]  910 	cp	a, #0x7f
      008526 24 23            [ 1]  911 	jrnc	00103$
                                    912 ;	libs/i2c_lib.c: 171: if(!(i2c_send_address(addr, 0)))
      008528 4B 00            [ 1]  913 	push	#0x00
      00852A 7B 03            [ 1]  914 	ld	a, (0x03, sp)
      00852C CD 84 30         [ 4]  915 	call	_i2c_send_address
      00852F 4D               [ 1]  916 	tnz	a
      008530 26 07            [ 1]  917 	jrne	00102$
                                    918 ;	libs/i2c_lib.c: 173: i2c_stop();
      008532 CD 83 BD         [ 4]  919 	call	_i2c_stop
                                    920 ;	libs/i2c_lib.c: 174: return addr;
      008535 7B 01            [ 1]  921 	ld	a, (0x01, sp)
      008537 20 16            [ 2]  922 	jra	00107$
      008539                        923 00102$:
                                    924 ;	libs/i2c_lib.c: 176: I2C_SR2 -> AF = 0;
      008539 72 15 52 18      [ 1]  925 	bres	0x5218, #2
                                    926 ;	libs/i2c_lib.c: 177: uart_write("error addr\n"); //Очистка флага ошибки
      00853D AE 81 23         [ 2]  927 	ldw	x, #(___str_15+0)
      008540 CD 82 B6         [ 4]  928 	call	_uart_write
                                    929 ;	libs/i2c_lib.c: 169: for (uint8_t addr = 1; addr < 127; addr++)
      008543 0C 02            [ 1]  930 	inc	(0x02, sp)
      008545 7B 02            [ 1]  931 	ld	a, (0x02, sp)
      008547 6B 01            [ 1]  932 	ld	(0x01, sp), a
      008549 20 D7            [ 2]  933 	jra	00105$
      00854B                        934 00103$:
                                    935 ;	libs/i2c_lib.c: 179: i2c_stop();
      00854B CD 83 BD         [ 4]  936 	call	_i2c_stop
                                    937 ;	libs/i2c_lib.c: 180: return 0;
      00854E 4F               [ 1]  938 	clr	a
      00854F                        939 00107$:
                                    940 ;	libs/i2c_lib.c: 181: }
      00854F 5B 02            [ 2]  941 	addw	sp, #2
      008551 81               [ 4]  942 	ret
                                    943 ;	main.c: 2: void setup(void)
                                    944 ;	-----------------------------------------
                                    945 ;	 function setup
                                    946 ;	-----------------------------------------
      008552                        947 _setup:
                                    948 ;	main.c: 5: CLK_CKDIVR = 0;
      008552 35 00 50 C6      [ 1]  949 	mov	0x50c6+0, #0x00
                                    950 ;	main.c: 7: uart_init(9600,0);
      008556 4F               [ 1]  951 	clr	a
      008557 AE 25 80         [ 2]  952 	ldw	x, #0x2580
      00855A CD 81 A1         [ 4]  953 	call	_uart_init
                                    954 ;	main.c: 8: i2c_init();
      00855D CD 83 7C         [ 4]  955 	call	_i2c_init
                                    956 ;	main.c: 10: enableInterrupts();
      008560 9A               [ 1]  957 	rim
                                    958 ;	main.c: 11: }
      008561 81               [ 4]  959 	ret
                                    960 ;	main.c: 12: int main(void)
                                    961 ;	-----------------------------------------
                                    962 ;	 function main
                                    963 ;	-----------------------------------------
      008562                        964 _main:
      008562 52 05            [ 2]  965 	sub	sp, #5
                                    966 ;	main.c: 14: setup();
      008564 CD 85 52         [ 4]  967 	call	_setup
                                    968 ;	main.c: 17: buf[0] = 0xA4;
      008567 96               [ 1]  969 	ldw	x, sp
      008568 5C               [ 1]  970 	incw	x
      008569 A6 A4            [ 1]  971 	ld	a, #0xa4
      00856B F7               [ 1]  972 	ld	(x), a
                                    973 ;	main.c: 18: buf[1] = 0xA5;
      00856C A6 A5            [ 1]  974 	ld	a, #0xa5
      00856E 6B 02            [ 1]  975 	ld	(0x02, sp), a
                                    976 ;	main.c: 19: buf[2] = 0xA6;
      008570 A6 A6            [ 1]  977 	ld	a, #0xa6
      008572 6B 03            [ 1]  978 	ld	(0x03, sp), a
                                    979 ;	main.c: 20: buf[3] = 0xA7;
      008574 A6 A7            [ 1]  980 	ld	a, #0xa7
      008576 6B 04            [ 1]  981 	ld	(0x04, sp), a
                                    982 ;	main.c: 21: buf[4] = 0xA8;
      008578 A6 A8            [ 1]  983 	ld	a, #0xa8
      00857A 6B 05            [ 1]  984 	ld	(0x05, sp), a
                                    985 ;	main.c: 22: i2c_write(0x66,5,buf);
      00857C 89               [ 2]  986 	pushw	x
      00857D 4B 05            [ 1]  987 	push	#0x05
      00857F A6 66            [ 1]  988 	ld	a, #0x66
      008581 CD 84 9B         [ 4]  989 	call	_i2c_write
                                    990 ;	main.c: 23: while(1);
      008584                        991 00102$:
      008584 20 FE            [ 2]  992 	jra	00102$
                                    993 ;	main.c: 34: }
      008586 5B 05            [ 2]  994 	addw	sp, #5
      008588 81               [ 4]  995 	ret
                                    996 	.area CODE
                                    997 	.area CONST
                                    998 	.area CONST
      008081                        999 ___str_0:
      008081 72 78 5F 62 75 66 5F  1000 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808F 0A                    1001 	.db 0x0a
      008090 00                    1002 	.db 0x00
                                   1003 	.area CODE
                                   1004 	.area CONST
      008091                       1005 ___str_1:
      008091 62 75 66 5F 70 6F 73  1006 	.ascii "buf_pos"
      008098 0A                    1007 	.db 0x0a
      008099 00                    1008 	.db 0x00
                                   1009 	.area CODE
                                   1010 	.area CONST
      00809A                       1011 ___str_2:
      00809A 62 75 66 5F 73 69 7A  1012 	.ascii "buf_size"
             65
      0080A2 0A                    1013 	.db 0x0a
      0080A3 00                    1014 	.db 0x00
                                   1015 	.area CODE
                                   1016 	.area CONST
      0080A4                       1017 ___str_3:
      0080A4 52 49 45 4E           1018 	.ascii "RIEN"
      0080A8 0A                    1019 	.db 0x0a
      0080A9 00                    1020 	.db 0x00
                                   1021 	.area CODE
                                   1022 	.area CONST
      0080AA                       1023 ___str_4:
      0080AA 69 32 63 5F 73 74 61  1024 	.ascii "i2c_start"
             72 74
      0080B3 0A                    1025 	.db 0x0a
      0080B4 00                    1026 	.db 0x00
                                   1027 	.area CODE
                                   1028 	.area CONST
      0080B5                       1029 ___str_5:
      0080B5 69 32 63 5F 73 74 6F  1030 	.ascii "i2c_stop"
             70
      0080BD 0A                    1031 	.db 0x0a
      0080BE 00                    1032 	.db 0x00
                                   1033 	.area CODE
                                   1034 	.area CONST
      0080BF                       1035 ___str_6:
      0080BF 67 6F 76 6E 6F 20 61  1036 	.ascii "govno alert"
             6C 65 72 74
      0080CA 0A                    1037 	.db 0x0a
      0080CB 00                    1038 	.db 0x00
                                   1039 	.area CODE
                                   1040 	.area CONST
      0080CC                       1041 ___str_7:
      0080CC 69 32 63 5F 73 65 6E  1042 	.ascii "i2c_send_byte"
             64 5F 62 79 74 65
      0080D9 0A                    1043 	.db 0x0a
      0080DA 00                    1044 	.db 0x00
                                   1045 	.area CODE
                                   1046 	.area CONST
      0080DB                       1047 ___str_8:
      0080DB 69 32 63 5F 69 72 71  1048 	.ascii "i2c_irq_enable_all_send_byte"
             5F 65 6E 61 62 6C 65
             5F 61 6C 6C 5F 73 65
             6E 64 5F 62 79 74 65
      0080F7 0A                    1049 	.db 0x0a
      0080F8 00                    1050 	.db 0x00
                                   1051 	.area CODE
                                   1052 	.area CONST
      0080F9                       1053 ___str_9:
      0080F9 41 46 20 2D 3E 20     1054 	.ascii "AF -> "
      0080FF 00                    1055 	.db 0x00
                                   1056 	.area CODE
                                   1057 	.area CONST
      008100                       1058 ___str_10:
      008100 31                    1059 	.ascii "1"
      008101 0A                    1060 	.db 0x0a
      008102 00                    1061 	.db 0x00
                                   1062 	.area CODE
                                   1063 	.area CONST
      008103                       1064 ___str_11:
      008103 30                    1065 	.ascii "0"
      008104 0A                    1066 	.db 0x0a
      008105 00                    1067 	.db 0x00
                                   1068 	.area CODE
                                   1069 	.area CONST
      008106                       1070 ___str_12:
      008106 69 32 63 5F 73 65 6E  1071 	.ascii "i2c_send_address"
             64 5F 61 64 64 72 65
             73 73
      008116 0A                    1072 	.db 0x0a
      008117 00                    1073 	.db 0x00
                                   1074 	.area CODE
                                   1075 	.area CONST
      008118                       1076 ___str_13:
      008118 41 44 44 52 20 2D 3E  1077 	.ascii "ADDR -> "
             20
      008120 00                    1078 	.db 0x00
                                   1079 	.area CODE
                                   1080 	.area CONST
      008121                       1081 ___str_14:
      008121 7C                    1082 	.ascii "|"
      008122 00                    1083 	.db 0x00
                                   1084 	.area CODE
                                   1085 	.area CONST
      008123                       1086 ___str_15:
      008123 65 72 72 6F 72 20 61  1087 	.ascii "error addr"
             64 64 72
      00812D 0A                    1088 	.db 0x0a
      00812E 00                    1089 	.db 0x00
                                   1090 	.area CODE
                                   1091 	.area INITIALIZER
      00812F                       1092 __xinit__I2C_IRQ:
      00812F 00                    1093 	.db 0x00
      008130                       1094 __xinit__govno_alert:
      008130 00                    1095 	.db #0x00	; 0
      008131                       1096 __xinit__counter:
      008131 00                    1097 	.db #0x00	; 0
                                   1098 	.area CABS (ABS)
