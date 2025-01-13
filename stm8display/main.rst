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
                                     11 	.globl _display_splash
                                     12 	.globl _main
                                     13 	.globl _gg
                                     14 	.globl _display_clean
                                     15 	.globl _display_set
                                     16 	.globl _display_buffer_fill
                                     17 	.globl _display_draw_pixel
                                     18 	.globl _display_set_params_to_write
                                     19 	.globl _display_init
                                     20 	.globl _delay
                                     21 	.globl _setup
                                     22 	.globl _i2c_scan
                                     23 	.globl _i2c_write
                                     24 	.globl _i2c_send_byte
                                     25 	.globl _i2c_read
                                     26 	.globl _i2c_read_byte
                                     27 	.globl _i2c_send_address
                                     28 	.globl _i2c_stop
                                     29 	.globl _i2c_start
                                     30 	.globl _i2c_init
                                     31 	.globl _uart_read
                                     32 	.globl _uart_write_byte
                                     33 	.globl _uart_read_byte
                                     34 	.globl _uart_init
                                     35 	.globl _uart_reciever_irq
                                     36 	.globl _uart_transmission_irq
                                     37 	.globl _splash
                                     38 	.globl _I2C_IRQ
                                     39 	.globl _buf_size
                                     40 	.globl _buf_pos
                                     41 	.globl _rx_buf_pointer
                                     42 	.globl _tx_buf_pointer
                                     43 	.globl _uart_write
                                     44 ;--------------------------------------------------------
                                     45 ; ram data
                                     46 ;--------------------------------------------------------
                                     47 	.area DATA
      000001                         48 _tx_buf_pointer::
      000001                         49 	.ds 2
      000003                         50 _rx_buf_pointer::
      000003                         51 	.ds 2
      000005                         52 _buf_pos::
      000005                         53 	.ds 1
      000006                         54 _buf_size::
      000006                         55 	.ds 1
                                     56 ;--------------------------------------------------------
                                     57 ; ram data
                                     58 ;--------------------------------------------------------
                                     59 	.area INITIALIZED
      000007                         60 _I2C_IRQ::
      000007                         61 	.ds 1
      000008                         62 _splash::
      000008                         63 	.ds 512
                                     64 ;--------------------------------------------------------
                                     65 ; Stack segment in internal ram
                                     66 ;--------------------------------------------------------
                                     67 	.area SSEG
      000208                         68 __start__stack:
      000208                         69 	.ds	1
                                     70 
                                     71 ;--------------------------------------------------------
                                     72 ; absolute external ram data
                                     73 ;--------------------------------------------------------
                                     74 	.area DABS (ABS)
                                     75 
                                     76 ; default segment ordering for linker
                                     77 	.area HOME
                                     78 	.area GSINIT
                                     79 	.area GSFINAL
                                     80 	.area CONST
                                     81 	.area INITIALIZER
                                     82 	.area CODE
                                     83 
                                     84 ;--------------------------------------------------------
                                     85 ; interrupt vector
                                     86 ;--------------------------------------------------------
                                     87 	.area HOME
      008000                         88 __interrupt_vect:
      008000 82 00 80 57             89 	int s_GSINIT ; reset
      008004 82 00 00 00             90 	int 0x000000 ; trap
      008008 82 00 00 00             91 	int 0x000000 ; int0
      00800C 82 00 00 00             92 	int 0x000000 ; int1
      008010 82 00 00 00             93 	int 0x000000 ; int2
      008014 82 00 00 00             94 	int 0x000000 ; int3
      008018 82 00 00 00             95 	int 0x000000 ; int4
      00801C 82 00 00 00             96 	int 0x000000 ; int5
      008020 82 00 00 00             97 	int 0x000000 ; int6
      008024 82 00 00 00             98 	int 0x000000 ; int7
      008028 82 00 00 00             99 	int 0x000000 ; int8
      00802C 82 00 00 00            100 	int 0x000000 ; int9
      008030 82 00 00 00            101 	int 0x000000 ; int10
      008034 82 00 00 00            102 	int 0x000000 ; int11
      008038 82 00 00 00            103 	int 0x000000 ; int12
      00803C 82 00 00 00            104 	int 0x000000 ; int13
      008040 82 00 00 00            105 	int 0x000000 ; int14
      008044 82 00 00 00            106 	int 0x000000 ; int15
      008048 82 00 00 00            107 	int 0x000000 ; int16
      00804C 82 00 82 A7            108 	int _uart_transmission_irq ; int17
      008050 82 00 82 E3            109 	int _uart_reciever_irq ; int18
                                    110 ;--------------------------------------------------------
                                    111 ; global & static initialisations
                                    112 ;--------------------------------------------------------
                                    113 	.area HOME
                                    114 	.area GSINIT
                                    115 	.area GSFINAL
                                    116 	.area GSINIT
      008057 CD 91 41         [ 4]  117 	call	___sdcc_external_startup
      00805A 4D               [ 1]  118 	tnz	a
      00805B 27 03            [ 1]  119 	jreq	__sdcc_init_data
      00805D CC 80 54         [ 2]  120 	jp	__sdcc_program_startup
      008060                        121 __sdcc_init_data:
                                    122 ; stm8_genXINIT() start
      008060 AE 00 06         [ 2]  123 	ldw x, #l_DATA
      008063 27 07            [ 1]  124 	jreq	00002$
      008065                        125 00001$:
      008065 72 4F 00 00      [ 1]  126 	clr (s_DATA - 1, x)
      008069 5A               [ 2]  127 	decw x
      00806A 26 F9            [ 1]  128 	jrne	00001$
      00806C                        129 00002$:
      00806C AE 02 01         [ 2]  130 	ldw	x, #l_INITIALIZER
      00806F 27 09            [ 1]  131 	jreq	00004$
      008071                        132 00003$:
      008071 D6 80 A5         [ 1]  133 	ld	a, (s_INITIALIZER - 1, x)
      008074 D7 00 06         [ 1]  134 	ld	(s_INITIALIZED - 1, x), a
      008077 5A               [ 2]  135 	decw	x
      008078 26 F7            [ 1]  136 	jrne	00003$
      00807A                        137 00004$:
                                    138 ; stm8_genXINIT() end
                                    139 	.area GSFINAL
      00807A CC 80 54         [ 2]  140 	jp	__sdcc_program_startup
                                    141 ;--------------------------------------------------------
                                    142 ; Home
                                    143 ;--------------------------------------------------------
                                    144 	.area HOME
                                    145 	.area HOME
      008054                        146 __sdcc_program_startup:
      008054 CC 8E 29         [ 2]  147 	jp	_main
                                    148 ;	return from main will return to caller
                                    149 ;--------------------------------------------------------
                                    150 ; code
                                    151 ;--------------------------------------------------------
                                    152 	.area CODE
                                    153 ;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    154 ;	-----------------------------------------
                                    155 ;	 function uart_transmission_irq
                                    156 ;	-----------------------------------------
      0082A7                        157 _uart_transmission_irq:
                                    158 ;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0082A7 AE 52 30         [ 2]  159 	ldw	x, #0x5230
      0082AA F6               [ 1]  160 	ld	a, (x)
      0082AB 4E               [ 1]  161 	swap	a
      0082AC 44               [ 1]  162 	srl	a
      0082AD 44               [ 1]  163 	srl	a
      0082AE 44               [ 1]  164 	srl	a
      0082AF A5 01            [ 1]  165 	bcp	a, #0x01
      0082B1 27 2F            [ 1]  166 	jreq	00107$
                                    167 ;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0082B3 C6 00 02         [ 1]  168 	ld	a, _tx_buf_pointer+1
      0082B6 CB 00 05         [ 1]  169 	add	a, _buf_pos+0
      0082B9 97               [ 1]  170 	ld	xl, a
      0082BA C6 00 01         [ 1]  171 	ld	a, _tx_buf_pointer+0
      0082BD A9 00            [ 1]  172 	adc	a, #0x00
      0082BF 95               [ 1]  173 	ld	xh, a
      0082C0 F6               [ 1]  174 	ld	a, (x)
      0082C1 27 1B            [ 1]  175 	jreq	00102$
      0082C3 C6 00 05         [ 1]  176 	ld	a, _buf_pos+0
      0082C6 C1 00 06         [ 1]  177 	cp	a, _buf_size+0
      0082C9 24 13            [ 1]  178 	jrnc	00102$
                                    179 ;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0082CB C6 00 05         [ 1]  180 	ld	a, _buf_pos+0
      0082CE 72 5C 00 05      [ 1]  181 	inc	_buf_pos+0
      0082D2 5F               [ 1]  182 	clrw	x
      0082D3 97               [ 1]  183 	ld	xl, a
      0082D4 72 BB 00 01      [ 2]  184 	addw	x, _tx_buf_pointer+0
      0082D8 F6               [ 1]  185 	ld	a, (x)
      0082D9 C7 52 31         [ 1]  186 	ld	0x5231, a
      0082DC 20 04            [ 2]  187 	jra	00107$
      0082DE                        188 00102$:
                                    189 ;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0082DE 72 1F 52 35      [ 1]  190 	bres	0x5235, #7
      0082E2                        191 00107$:
                                    192 ;	libs/uart_lib.c: 14: }
      0082E2 80               [11]  193 	iret
                                    194 ;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    195 ;	-----------------------------------------
                                    196 ;	 function uart_reciever_irq
                                    197 ;	-----------------------------------------
      0082E3                        198 _uart_reciever_irq:
      0082E3 88               [ 1]  199 	push	a
                                    200 ;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
      0082E4 C6 52 30         [ 1]  201 	ld	a, 0x5230
      0082E7 4E               [ 1]  202 	swap	a
      0082E8 44               [ 1]  203 	srl	a
      0082E9 A5 01            [ 1]  204 	bcp	a, #0x01
      0082EB 27 27            [ 1]  205 	jreq	00107$
                                    206 ;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
      0082ED C6 52 31         [ 1]  207 	ld	a, 0x5231
                                    208 ;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
      0082F0 6B 01            [ 1]  209 	ld	(0x01, sp), a
      0082F2 A1 0A            [ 1]  210 	cp	a, #0x0a
      0082F4 27 1A            [ 1]  211 	jreq	00102$
      0082F6 C6 00 05         [ 1]  212 	ld	a, _buf_pos+0
      0082F9 C1 00 06         [ 1]  213 	cp	a, _buf_size+0
      0082FC 24 12            [ 1]  214 	jrnc	00102$
                                    215 ;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
      0082FE C6 00 05         [ 1]  216 	ld	a, _buf_pos+0
      008301 72 5C 00 05      [ 1]  217 	inc	_buf_pos+0
      008305 5F               [ 1]  218 	clrw	x
      008306 97               [ 1]  219 	ld	xl, a
      008307 72 BB 00 03      [ 2]  220 	addw	x, _rx_buf_pointer+0
      00830B 7B 01            [ 1]  221 	ld	a, (0x01, sp)
      00830D F7               [ 1]  222 	ld	(x), a
      00830E 20 04            [ 2]  223 	jra	00107$
      008310                        224 00102$:
                                    225 ;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
      008310 72 1B 52 35      [ 1]  226 	bres	0x5235, #5
      008314                        227 00107$:
                                    228 ;	libs/uart_lib.c: 29: }
      008314 84               [ 1]  229 	pop	a
      008315 80               [11]  230 	iret
                                    231 ;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    232 ;	-----------------------------------------
                                    233 ;	 function uart_init
                                    234 ;	-----------------------------------------
      008316                        235 _uart_init:
      008316 52 02            [ 2]  236 	sub	sp, #2
      008318 1F 01            [ 2]  237 	ldw	(0x01, sp), x
                                    238 ;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
      00831A AE 52 35         [ 2]  239 	ldw	x, #0x5235
      00831D 88               [ 1]  240 	push	a
      00831E F6               [ 1]  241 	ld	a, (x)
      00831F AA 08            [ 1]  242 	or	a, #0x08
      008321 F7               [ 1]  243 	ld	(x), a
      008322 84               [ 1]  244 	pop	a
                                    245 ;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
      008323 AE 52 35         [ 2]  246 	ldw	x, #0x5235
      008326 88               [ 1]  247 	push	a
      008327 F6               [ 1]  248 	ld	a, (x)
      008328 AA 04            [ 1]  249 	or	a, #0x04
      00832A F7               [ 1]  250 	ld	(x), a
      00832B 84               [ 1]  251 	pop	a
                                    252 ;	libs/uart_lib.c: 36: switch(stopbit)
      00832C A1 02            [ 1]  253 	cp	a, #0x02
      00832E 27 06            [ 1]  254 	jreq	00101$
      008330 A1 03            [ 1]  255 	cp	a, #0x03
      008332 27 0E            [ 1]  256 	jreq	00102$
      008334 20 16            [ 2]  257 	jra	00103$
                                    258 ;	libs/uart_lib.c: 38: case 2:
      008336                        259 00101$:
                                    260 ;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
      008336 C6 52 36         [ 1]  261 	ld	a, 0x5236
      008339 A4 CF            [ 1]  262 	and	a, #0xcf
      00833B AA 20            [ 1]  263 	or	a, #0x20
      00833D C7 52 36         [ 1]  264 	ld	0x5236, a
                                    265 ;	libs/uart_lib.c: 40: break;
      008340 20 12            [ 2]  266 	jra	00104$
                                    267 ;	libs/uart_lib.c: 41: case 3:
      008342                        268 00102$:
                                    269 ;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
      008342 C6 52 36         [ 1]  270 	ld	a, 0x5236
      008345 AA 30            [ 1]  271 	or	a, #0x30
      008347 C7 52 36         [ 1]  272 	ld	0x5236, a
                                    273 ;	libs/uart_lib.c: 43: break;
      00834A 20 08            [ 2]  274 	jra	00104$
                                    275 ;	libs/uart_lib.c: 44: default:
      00834C                        276 00103$:
                                    277 ;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
      00834C C6 52 36         [ 1]  278 	ld	a, 0x5236
      00834F A4 CF            [ 1]  279 	and	a, #0xcf
      008351 C7 52 36         [ 1]  280 	ld	0x5236, a
                                    281 ;	libs/uart_lib.c: 47: }
      008354                        282 00104$:
                                    283 ;	libs/uart_lib.c: 48: switch(baudrate)
      008354 1E 01            [ 2]  284 	ldw	x, (0x01, sp)
      008356 A3 08 00         [ 2]  285 	cpw	x, #0x0800
      008359 26 03            [ 1]  286 	jrne	00186$
      00835B CC 83 E7         [ 2]  287 	jp	00110$
      00835E                        288 00186$:
      00835E 1E 01            [ 2]  289 	ldw	x, (0x01, sp)
      008360 A3 09 60         [ 2]  290 	cpw	x, #0x0960
      008363 27 28            [ 1]  291 	jreq	00105$
      008365 1E 01            [ 2]  292 	ldw	x, (0x01, sp)
      008367 A3 10 00         [ 2]  293 	cpw	x, #0x1000
      00836A 26 03            [ 1]  294 	jrne	00192$
      00836C CC 83 F7         [ 2]  295 	jp	00111$
      00836F                        296 00192$:
      00836F 1E 01            [ 2]  297 	ldw	x, (0x01, sp)
      008371 A3 4B 00         [ 2]  298 	cpw	x, #0x4b00
      008374 27 31            [ 1]  299 	jreq	00106$
      008376 1E 01            [ 2]  300 	ldw	x, (0x01, sp)
      008378 A3 84 00         [ 2]  301 	cpw	x, #0x8400
      00837B 27 5A            [ 1]  302 	jreq	00109$
      00837D 1E 01            [ 2]  303 	ldw	x, (0x01, sp)
      00837F A3 C2 00         [ 2]  304 	cpw	x, #0xc200
      008382 27 43            [ 1]  305 	jreq	00108$
      008384 1E 01            [ 2]  306 	ldw	x, (0x01, sp)
      008386 A3 E1 00         [ 2]  307 	cpw	x, #0xe100
      008389 27 2C            [ 1]  308 	jreq	00107$
      00838B 20 7A            [ 2]  309 	jra	00112$
                                    310 ;	libs/uart_lib.c: 50: case (unsigned int)2400:
      00838D                        311 00105$:
                                    312 ;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
      00838D C6 52 33         [ 1]  313 	ld	a, 0x5233
      008390 A4 0F            [ 1]  314 	and	a, #0x0f
      008392 AA 10            [ 1]  315 	or	a, #0x10
      008394 C7 52 33         [ 1]  316 	ld	0x5233, a
                                    317 ;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
      008397 35 A0 52 32      [ 1]  318 	mov	0x5232+0, #0xa0
                                    319 ;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
      00839B C6 52 33         [ 1]  320 	ld	a, 0x5233
      00839E A4 F0            [ 1]  321 	and	a, #0xf0
      0083A0 AA 0B            [ 1]  322 	or	a, #0x0b
      0083A2 C7 52 33         [ 1]  323 	ld	0x5233, a
                                    324 ;	libs/uart_lib.c: 54: break;
      0083A5 20 6E            [ 2]  325 	jra	00114$
                                    326 ;	libs/uart_lib.c: 55: case (unsigned int)19200:
      0083A7                        327 00106$:
                                    328 ;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
      0083A7 35 34 52 32      [ 1]  329 	mov	0x5232+0, #0x34
                                    330 ;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
      0083AB C6 52 33         [ 1]  331 	ld	a, 0x5233
      0083AE A4 F0            [ 1]  332 	and	a, #0xf0
      0083B0 AA 01            [ 1]  333 	or	a, #0x01
      0083B2 C7 52 33         [ 1]  334 	ld	0x5233, a
                                    335 ;	libs/uart_lib.c: 58: break;
      0083B5 20 5E            [ 2]  336 	jra	00114$
                                    337 ;	libs/uart_lib.c: 59: case (unsigned int)57600:
      0083B7                        338 00107$:
                                    339 ;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
      0083B7 35 11 52 32      [ 1]  340 	mov	0x5232+0, #0x11
                                    341 ;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
      0083BB C6 52 33         [ 1]  342 	ld	a, 0x5233
      0083BE A4 F0            [ 1]  343 	and	a, #0xf0
      0083C0 AA 06            [ 1]  344 	or	a, #0x06
      0083C2 C7 52 33         [ 1]  345 	ld	0x5233, a
                                    346 ;	libs/uart_lib.c: 62: break;
      0083C5 20 4E            [ 2]  347 	jra	00114$
                                    348 ;	libs/uart_lib.c: 63: case (unsigned int)115200:
      0083C7                        349 00108$:
                                    350 ;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
      0083C7 35 08 52 32      [ 1]  351 	mov	0x5232+0, #0x08
                                    352 ;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
      0083CB C6 52 33         [ 1]  353 	ld	a, 0x5233
      0083CE A4 F0            [ 1]  354 	and	a, #0xf0
      0083D0 AA 0B            [ 1]  355 	or	a, #0x0b
      0083D2 C7 52 33         [ 1]  356 	ld	0x5233, a
                                    357 ;	libs/uart_lib.c: 66: break;
      0083D5 20 3E            [ 2]  358 	jra	00114$
                                    359 ;	libs/uart_lib.c: 67: case (unsigned int)230400:
      0083D7                        360 00109$:
                                    361 ;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
      0083D7 35 04 52 32      [ 1]  362 	mov	0x5232+0, #0x04
                                    363 ;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
      0083DB C6 52 33         [ 1]  364 	ld	a, 0x5233
      0083DE A4 F0            [ 1]  365 	and	a, #0xf0
      0083E0 AA 05            [ 1]  366 	or	a, #0x05
      0083E2 C7 52 33         [ 1]  367 	ld	0x5233, a
                                    368 ;	libs/uart_lib.c: 70: break;
      0083E5 20 2E            [ 2]  369 	jra	00114$
                                    370 ;	libs/uart_lib.c: 71: case (unsigned int)460800:
      0083E7                        371 00110$:
                                    372 ;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
      0083E7 35 02 52 32      [ 1]  373 	mov	0x5232+0, #0x02
                                    374 ;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
      0083EB C6 52 33         [ 1]  375 	ld	a, 0x5233
      0083EE A4 F0            [ 1]  376 	and	a, #0xf0
      0083F0 AA 03            [ 1]  377 	or	a, #0x03
      0083F2 C7 52 33         [ 1]  378 	ld	0x5233, a
                                    379 ;	libs/uart_lib.c: 74: break;
      0083F5 20 1E            [ 2]  380 	jra	00114$
                                    381 ;	libs/uart_lib.c: 75: case (unsigned int)921600:
      0083F7                        382 00111$:
                                    383 ;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
      0083F7 35 01 52 32      [ 1]  384 	mov	0x5232+0, #0x01
                                    385 ;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      0083FB C6 52 33         [ 1]  386 	ld	a, 0x5233
      0083FE A4 F0            [ 1]  387 	and	a, #0xf0
      008400 AA 01            [ 1]  388 	or	a, #0x01
      008402 C7 52 33         [ 1]  389 	ld	0x5233, a
                                    390 ;	libs/uart_lib.c: 78: break;
      008405 20 0E            [ 2]  391 	jra	00114$
                                    392 ;	libs/uart_lib.c: 79: default:
      008407                        393 00112$:
                                    394 ;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
      008407 35 68 52 32      [ 1]  395 	mov	0x5232+0, #0x68
                                    396 ;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
      00840B C6 52 33         [ 1]  397 	ld	a, 0x5233
      00840E A4 F0            [ 1]  398 	and	a, #0xf0
      008410 AA 03            [ 1]  399 	or	a, #0x03
      008412 C7 52 33         [ 1]  400 	ld	0x5233, a
                                    401 ;	libs/uart_lib.c: 83: }
      008415                        402 00114$:
                                    403 ;	libs/uart_lib.c: 84: }
      008415 5B 02            [ 2]  404 	addw	sp, #2
      008417 81               [ 4]  405 	ret
                                    406 ;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
                                    407 ;	-----------------------------------------
                                    408 ;	 function uart_read_byte
                                    409 ;	-----------------------------------------
      008418                        410 _uart_read_byte:
                                    411 ;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
      008418                        412 00101$:
      008418 72 0B 52 30 FB   [ 2]  413 	btjf	0x5230, #5, 00101$
                                    414 ;	libs/uart_lib.c: 90: return 1;
      00841D 5F               [ 1]  415 	clrw	x
      00841E 5C               [ 1]  416 	incw	x
                                    417 ;	libs/uart_lib.c: 91: }
      00841F 81               [ 4]  418 	ret
                                    419 ;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
                                    420 ;	-----------------------------------------
                                    421 ;	 function uart_write_byte
                                    422 ;	-----------------------------------------
      008420                        423 _uart_write_byte:
                                    424 ;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
      008420 C7 52 31         [ 1]  425 	ld	0x5231, a
                                    426 ;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
      008423                        427 00101$:
      008423 72 0F 52 30 FB   [ 2]  428 	btjf	0x5230, #7, 00101$
                                    429 ;	libs/uart_lib.c: 97: return 1;
      008428 5F               [ 1]  430 	clrw	x
      008429 5C               [ 1]  431 	incw	x
                                    432 ;	libs/uart_lib.c: 98: }
      00842A 81               [ 4]  433 	ret
                                    434 ;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
                                    435 ;	-----------------------------------------
                                    436 ;	 function uart_write
                                    437 ;	-----------------------------------------
      00842B                        438 _uart_write:
      00842B 52 02            [ 2]  439 	sub	sp, #2
                                    440 ;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
      00842D 1F 01            [ 2]  441 	ldw	(0x01, sp), x
      00842F CF 00 01         [ 2]  442 	ldw	_tx_buf_pointer+0, x
                                    443 ;	libs/uart_lib.c: 103: buf_pos = 0;
      008432 72 5F 00 05      [ 1]  444 	clr	_buf_pos+0
                                    445 ;	libs/uart_lib.c: 104: buf_size = 0;
      008436 72 5F 00 06      [ 1]  446 	clr	_buf_size+0
                                    447 ;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
      00843A                        448 00101$:
      00843A C6 00 06         [ 1]  449 	ld	a, _buf_size+0
      00843D 72 5C 00 06      [ 1]  450 	inc	_buf_size+0
      008441 5F               [ 1]  451 	clrw	x
      008442 97               [ 1]  452 	ld	xl, a
      008443 72 FB 01         [ 2]  453 	addw	x, (0x01, sp)
      008446 F6               [ 1]  454 	ld	a, (x)
      008447 26 F1            [ 1]  455 	jrne	00101$
                                    456 ;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
      008449 72 1E 52 35      [ 1]  457 	bset	0x5235, #7
                                    458 ;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
      00844D                        459 00104$:
      00844D 72 0E 52 35 FB   [ 2]  460 	btjt	0x5235, #7, 00104$
                                    461 ;	libs/uart_lib.c: 108: }
      008452 5B 02            [ 2]  462 	addw	sp, #2
      008454 81               [ 4]  463 	ret
                                    464 ;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
                                    465 ;	-----------------------------------------
                                    466 ;	 function uart_read
                                    467 ;	-----------------------------------------
      008455                        468 _uart_read:
                                    469 ;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
      008455 CF 00 03         [ 2]  470 	ldw	_rx_buf_pointer+0, x
                                    471 ;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
      008458 AE 80 7D         [ 2]  472 	ldw	x, #(___str_0+0)
      00845B CD 84 2B         [ 4]  473 	call	_uart_write
                                    474 ;	libs/uart_lib.c: 113: buf_pos = 0;
      00845E 72 5F 00 05      [ 1]  475 	clr	_buf_pos+0
                                    476 ;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
      008462 AE 80 8D         [ 2]  477 	ldw	x, #(___str_1+0)
      008465 CD 84 2B         [ 4]  478 	call	_uart_write
                                    479 ;	libs/uart_lib.c: 115: buf_size = size;
      008468 7B 04            [ 1]  480 	ld	a, (0x04, sp)
      00846A C7 00 06         [ 1]  481 	ld	_buf_size+0, a
                                    482 ;	libs/uart_lib.c: 116: uart_write("buf_size\n");
      00846D AE 80 96         [ 2]  483 	ldw	x, #(___str_2+0)
      008470 CD 84 2B         [ 4]  484 	call	_uart_write
                                    485 ;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
      008473 72 1A 52 35      [ 1]  486 	bset	0x5235, #5
                                    487 ;	libs/uart_lib.c: 118: uart_write("RIEN\n");
      008477 AE 80 A0         [ 2]  488 	ldw	x, #(___str_3+0)
      00847A CD 84 2B         [ 4]  489 	call	_uart_write
                                    490 ;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
      00847D                        491 00101$:
      00847D C6 52 35         [ 1]  492 	ld	a, 0x5235
      008480 4E               [ 1]  493 	swap	a
      008481 44               [ 1]  494 	srl	a
      008482 A4 01            [ 1]  495 	and	a, #0x01
      008484 26 F7            [ 1]  496 	jrne	00101$
                                    497 ;	libs/uart_lib.c: 120: }
      008486 1E 01            [ 2]  498 	ldw	x, (1, sp)
      008488 5B 04            [ 2]  499 	addw	sp, #4
      00848A FC               [ 2]  500 	jp	(x)
                                    501 ;	libs/i2c_lib.c: 3: void i2c_init(void)
                                    502 ;	-----------------------------------------
                                    503 ;	 function i2c_init
                                    504 ;	-----------------------------------------
      00848B                        505 _i2c_init:
                                    506 ;	libs/i2c_lib.c: 7: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      00848B 72 11 52 10      [ 1]  507 	bres	0x5210, #0
                                    508 ;	libs/i2c_lib.c: 8: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      00848F C6 52 12         [ 1]  509 	ld	a, 0x5212
      008492 A4 C0            [ 1]  510 	and	a, #0xc0
      008494 AA 10            [ 1]  511 	or	a, #0x10
      008496 C7 52 12         [ 1]  512 	ld	0x5212, a
                                    513 ;	libs/i2c_lib.c: 9: I2C_CCRH -> CCR = 0;// =0
      008499 C6 52 1C         [ 1]  514 	ld	a, 0x521c
      00849C A4 F0            [ 1]  515 	and	a, #0xf0
      00849E C7 52 1C         [ 1]  516 	ld	0x521c, a
                                    517 ;	libs/i2c_lib.c: 10: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0084A1 35 50 52 1B      [ 1]  518 	mov	0x521b+0, #0x50
                                    519 ;	libs/i2c_lib.c: 11: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0084A5 72 1F 52 1C      [ 1]  520 	bres	0x521c, #7
                                    521 ;	libs/i2c_lib.c: 12: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0084A9 72 1F 52 14      [ 1]  522 	bres	0x5214, #7
                                    523 ;	libs/i2c_lib.c: 13: I2C_OARH -> ADDCONF = 1;// see reference manual
      0084AD 72 10 52 14      [ 1]  524 	bset	0x5214, #0
                                    525 ;	libs/i2c_lib.c: 14: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0084B1 72 10 52 10      [ 1]  526 	bset	0x5210, #0
                                    527 ;	libs/i2c_lib.c: 15: }
      0084B5 81               [ 4]  528 	ret
                                    529 ;	libs/i2c_lib.c: 17: void i2c_start(void)
                                    530 ;	-----------------------------------------
                                    531 ;	 function i2c_start
                                    532 ;	-----------------------------------------
      0084B6                        533 _i2c_start:
                                    534 ;	libs/i2c_lib.c: 19: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0084B6 72 10 52 11      [ 1]  535 	bset	0x5211, #0
                                    536 ;	libs/i2c_lib.c: 20: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0084BA                        537 00101$:
      0084BA 72 01 52 17 FB   [ 2]  538 	btjf	0x5217, #0, 00101$
                                    539 ;	libs/i2c_lib.c: 21: }
      0084BF 81               [ 4]  540 	ret
                                    541 ;	libs/i2c_lib.c: 23: void i2c_stop(void)
                                    542 ;	-----------------------------------------
                                    543 ;	 function i2c_stop
                                    544 ;	-----------------------------------------
      0084C0                        545 _i2c_stop:
                                    546 ;	libs/i2c_lib.c: 25: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0084C0 72 12 52 11      [ 1]  547 	bset	0x5211, #1
                                    548 ;	libs/i2c_lib.c: 26: }
      0084C4 81               [ 4]  549 	ret
                                    550 ;	libs/i2c_lib.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    551 ;	-----------------------------------------
                                    552 ;	 function i2c_send_address
                                    553 ;	-----------------------------------------
      0084C5                        554 _i2c_send_address:
                                    555 ;	libs/i2c_lib.c: 33: address = address << 1;
      0084C5 48               [ 1]  556 	sll	a
                                    557 ;	libs/i2c_lib.c: 30: switch(rw_type)
      0084C6 88               [ 1]  558 	push	a
      0084C7 7B 04            [ 1]  559 	ld	a, (0x04, sp)
      0084C9 4A               [ 1]  560 	dec	a
      0084CA 84               [ 1]  561 	pop	a
      0084CB 26 02            [ 1]  562 	jrne	00102$
                                    563 ;	libs/i2c_lib.c: 33: address = address << 1;
                                    564 ;	libs/i2c_lib.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0084CD AA 01            [ 1]  565 	or	a, #0x01
                                    566 ;	libs/i2c_lib.c: 35: break;
                                    567 ;	libs/i2c_lib.c: 36: default:
                                    568 ;	libs/i2c_lib.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
                                    569 ;	libs/i2c_lib.c: 39: }
      0084CF                        570 00102$:
                                    571 ;	libs/i2c_lib.c: 40: i2c_start();
      0084CF 88               [ 1]  572 	push	a
      0084D0 CD 84 B6         [ 4]  573 	call	_i2c_start
      0084D3 84               [ 1]  574 	pop	a
                                    575 ;	libs/i2c_lib.c: 41: I2C_DR -> DR = address;
      0084D4 C7 52 16         [ 1]  576 	ld	0x5216, a
                                    577 ;	libs/i2c_lib.c: 42: while(!I2C_SR1 -> ADDR)
      0084D7                        578 00106$:
      0084D7 AE 52 17         [ 2]  579 	ldw	x, #0x5217
      0084DA F6               [ 1]  580 	ld	a, (x)
      0084DB 44               [ 1]  581 	srl	a
      0084DC A4 01            [ 1]  582 	and	a, #0x01
      0084DE 26 08            [ 1]  583 	jrne	00108$
                                    584 ;	libs/i2c_lib.c: 43: if(I2C_SR2 -> AF)
      0084E0 72 05 52 18 F2   [ 2]  585 	btjf	0x5218, #2, 00106$
                                    586 ;	libs/i2c_lib.c: 44: return 0;
      0084E5 4F               [ 1]  587 	clr	a
      0084E6 20 08            [ 2]  588 	jra	00109$
      0084E8                        589 00108$:
                                    590 ;	libs/i2c_lib.c: 45: clr_sr1();
      0084E8 C6 52 17         [ 1]  591 	ld	a,0x5217
                                    592 ;	libs/i2c_lib.c: 46: clr_sr3();
      0084EB C6 52 19         [ 1]  593 	ld	a,0x5219
                                    594 ;	libs/i2c_lib.c: 47: return 1;
      0084EE A6 01            [ 1]  595 	ld	a, #0x01
      0084F0                        596 00109$:
                                    597 ;	libs/i2c_lib.c: 48: }
      0084F0 85               [ 2]  598 	popw	x
      0084F1 5B 01            [ 2]  599 	addw	sp, #1
      0084F3 FC               [ 2]  600 	jp	(x)
                                    601 ;	libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void){
                                    602 ;	-----------------------------------------
                                    603 ;	 function i2c_read_byte
                                    604 ;	-----------------------------------------
      0084F4                        605 _i2c_read_byte:
                                    606 ;	libs/i2c_lib.c: 51: while(!I2C_SR1 -> RXNE);
      0084F4                        607 00101$:
      0084F4 72 0D 52 17 FB   [ 2]  608 	btjf	0x5217, #6, 00101$
                                    609 ;	libs/i2c_lib.c: 52: return I2C_DR -> DR;
      0084F9 C6 52 16         [ 1]  610 	ld	a, 0x5216
                                    611 ;	libs/i2c_lib.c: 53: }
      0084FC 81               [ 4]  612 	ret
                                    613 ;	libs/i2c_lib.c: 55: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    614 ;	-----------------------------------------
                                    615 ;	 function i2c_read
                                    616 ;	-----------------------------------------
      0084FD                        617 _i2c_read:
      0084FD 52 04            [ 2]  618 	sub	sp, #4
                                    619 ;	libs/i2c_lib.c: 57: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      0084FF 4B 01            [ 1]  620 	push	#0x01
      008501 CD 84 C5         [ 4]  621 	call	_i2c_send_address
      008504 4D               [ 1]  622 	tnz	a
      008505 27 41            [ 1]  623 	jreq	00103$
                                    624 ;	libs/i2c_lib.c: 59: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008507 72 14 52 11      [ 1]  625 	bset	0x5211, #2
                                    626 ;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00850B 5F               [ 1]  627 	clrw	x
      00850C 1F 03            [ 2]  628 	ldw	(0x03, sp), x
      00850E                        629 00105$:
      00850E 5F               [ 1]  630 	clrw	x
      00850F 7B 07            [ 1]  631 	ld	a, (0x07, sp)
      008511 97               [ 1]  632 	ld	xl, a
      008512 5A               [ 2]  633 	decw	x
      008513 1F 01            [ 2]  634 	ldw	(0x01, sp), x
      008515 1E 03            [ 2]  635 	ldw	x, (0x03, sp)
      008517 13 01            [ 2]  636 	cpw	x, (0x01, sp)
      008519 2E 12            [ 1]  637 	jrsge	00101$
                                    638 ;	libs/i2c_lib.c: 62: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00851B 1E 08            [ 2]  639 	ldw	x, (0x08, sp)
      00851D 72 FB 03         [ 2]  640 	addw	x, (0x03, sp)
      008520 89               [ 2]  641 	pushw	x
      008521 CD 84 F4         [ 4]  642 	call	_i2c_read_byte
      008524 85               [ 2]  643 	popw	x
      008525 F7               [ 1]  644 	ld	(x), a
                                    645 ;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008526 1E 03            [ 2]  646 	ldw	x, (0x03, sp)
      008528 5C               [ 1]  647 	incw	x
      008529 1F 03            [ 2]  648 	ldw	(0x03, sp), x
      00852B 20 E1            [ 2]  649 	jra	00105$
      00852D                        650 00101$:
                                    651 ;	libs/i2c_lib.c: 64: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00852D 72 15 52 11      [ 1]  652 	bres	0x5211, #2
                                    653 ;	libs/i2c_lib.c: 65: uart_write_byte(0x00);
      008531 4F               [ 1]  654 	clr	a
      008532 CD 84 20         [ 4]  655 	call	_uart_write_byte
                                    656 ;	libs/i2c_lib.c: 66: data[size-1] = i2c_read_byte();
      008535 1E 08            [ 2]  657 	ldw	x, (0x08, sp)
      008537 72 FB 01         [ 2]  658 	addw	x, (0x01, sp)
      00853A 89               [ 2]  659 	pushw	x
      00853B CD 84 F4         [ 4]  660 	call	_i2c_read_byte
      00853E 85               [ 2]  661 	popw	x
      00853F F7               [ 1]  662 	ld	(x), a
                                    663 ;	libs/i2c_lib.c: 67: uart_write_byte(0x01);
      008540 A6 01            [ 1]  664 	ld	a, #0x01
      008542 CD 84 20         [ 4]  665 	call	_uart_write_byte
                                    666 ;	libs/i2c_lib.c: 68: i2c_stop();
      008545 CD 84 C0         [ 4]  667 	call	_i2c_stop
      008548                        668 00103$:
                                    669 ;	libs/i2c_lib.c: 70: uart_write_byte(0x02);
      008548 A6 02            [ 1]  670 	ld	a, #0x02
      00854A CD 84 20         [ 4]  671 	call	_uart_write_byte
                                    672 ;	libs/i2c_lib.c: 71: i2c_stop();
      00854D CD 84 C0         [ 4]  673 	call	_i2c_stop
                                    674 ;	libs/i2c_lib.c: 72: i2c_stop();
      008550 CD 84 C0         [ 4]  675 	call	_i2c_stop
                                    676 ;	libs/i2c_lib.c: 73: uart_write_byte(0x03); 
      008553 A6 03            [ 1]  677 	ld	a, #0x03
      008555 1E 05            [ 2]  678 	ldw	x, (5, sp)
      008557 1F 08            [ 2]  679 	ldw	(8, sp), x
      008559 5B 07            [ 2]  680 	addw	sp, #7
                                    681 ;	libs/i2c_lib.c: 74: }
      00855B CC 84 20         [ 2]  682 	jp	_uart_write_byte
                                    683 ;	libs/i2c_lib.c: 76: uint8_t i2c_send_byte(uint8_t data)
                                    684 ;	-----------------------------------------
                                    685 ;	 function i2c_send_byte
                                    686 ;	-----------------------------------------
      00855E                        687 _i2c_send_byte:
                                    688 ;	libs/i2c_lib.c: 78: I2C_DR -> DR = data; //Отправка данных
      00855E C7 52 16         [ 1]  689 	ld	0x5216, a
                                    690 ;	libs/i2c_lib.c: 79: while(!I2C_SR1 -> TXE)
      008561                        691 00103$:
      008561 72 0E 52 17 08   [ 2]  692 	btjt	0x5217, #7, 00105$
                                    693 ;	libs/i2c_lib.c: 80: if(I2C_SR2 -> AF)
      008566 72 05 52 18 F6   [ 2]  694 	btjf	0x5218, #2, 00103$
                                    695 ;	libs/i2c_lib.c: 81: return 1;
      00856B A6 01            [ 1]  696 	ld	a, #0x01
      00856D 81               [ 4]  697 	ret
      00856E                        698 00105$:
                                    699 ;	libs/i2c_lib.c: 82: return 0;//флаг ответа
      00856E 4F               [ 1]  700 	clr	a
                                    701 ;	libs/i2c_lib.c: 83: }
      00856F 81               [ 4]  702 	ret
                                    703 ;	libs/i2c_lib.c: 85: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    704 ;	-----------------------------------------
                                    705 ;	 function i2c_write
                                    706 ;	-----------------------------------------
      008570                        707 _i2c_write:
      008570 52 02            [ 2]  708 	sub	sp, #2
                                    709 ;	libs/i2c_lib.c: 87: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008572 4B 00            [ 1]  710 	push	#0x00
      008574 CD 84 C5         [ 4]  711 	call	_i2c_send_address
      008577 4D               [ 1]  712 	tnz	a
      008578 27 1D            [ 1]  713 	jreq	00105$
                                    714 ;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      00857A 5F               [ 1]  715 	clrw	x
      00857B                        716 00107$:
      00857B 7B 05            [ 1]  717 	ld	a, (0x05, sp)
      00857D 6B 02            [ 1]  718 	ld	(0x02, sp), a
      00857F 0F 01            [ 1]  719 	clr	(0x01, sp)
      008581 13 01            [ 2]  720 	cpw	x, (0x01, sp)
      008583 2E 12            [ 1]  721 	jrsge	00105$
                                    722 ;	libs/i2c_lib.c: 90: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008585 90 93            [ 1]  723 	ldw	y, x
      008587 72 F9 06         [ 2]  724 	addw	y, (0x06, sp)
      00858A 90 F6            [ 1]  725 	ld	a, (y)
      00858C 89               [ 2]  726 	pushw	x
      00858D CD 85 5E         [ 4]  727 	call	_i2c_send_byte
      008590 85               [ 2]  728 	popw	x
      008591 4D               [ 1]  729 	tnz	a
      008592 26 03            [ 1]  730 	jrne	00105$
                                    731 ;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      008594 5C               [ 1]  732 	incw	x
      008595 20 E4            [ 2]  733 	jra	00107$
      008597                        734 00105$:
                                    735 ;	libs/i2c_lib.c: 95: i2c_stop();
      008597 1E 03            [ 2]  736 	ldw	x, (3, sp)
      008599 1F 06            [ 2]  737 	ldw	(6, sp), x
      00859B 5B 05            [ 2]  738 	addw	sp, #5
                                    739 ;	libs/i2c_lib.c: 96: }
      00859D CC 84 C0         [ 2]  740 	jp	_i2c_stop
                                    741 ;	libs/i2c_lib.c: 98: uint8_t i2c_scan(void) 
                                    742 ;	-----------------------------------------
                                    743 ;	 function i2c_scan
                                    744 ;	-----------------------------------------
      0085A0                        745 _i2c_scan:
      0085A0 52 02            [ 2]  746 	sub	sp, #2
                                    747 ;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0085A2 A6 01            [ 1]  748 	ld	a, #0x01
      0085A4 6B 01            [ 1]  749 	ld	(0x01, sp), a
      0085A6                        750 00105$:
      0085A6 A1 7F            [ 1]  751 	cp	a, #0x7f
      0085A8 24 22            [ 1]  752 	jrnc	00103$
                                    753 ;	libs/i2c_lib.c: 102: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0085AA 88               [ 1]  754 	push	a
      0085AB 4B 00            [ 1]  755 	push	#0x00
      0085AD CD 84 C5         [ 4]  756 	call	_i2c_send_address
      0085B0 6B 03            [ 1]  757 	ld	(0x03, sp), a
      0085B2 84               [ 1]  758 	pop	a
      0085B3 0D 02            [ 1]  759 	tnz	(0x02, sp)
      0085B5 27 07            [ 1]  760 	jreq	00102$
                                    761 ;	libs/i2c_lib.c: 104: i2c_stop();//адрес совпал 
      0085B7 CD 84 C0         [ 4]  762 	call	_i2c_stop
                                    763 ;	libs/i2c_lib.c: 105: return addr;// выход из цикла
      0085BA 7B 01            [ 1]  764 	ld	a, (0x01, sp)
      0085BC 20 12            [ 2]  765 	jra	00107$
      0085BE                        766 00102$:
                                    767 ;	libs/i2c_lib.c: 107: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0085BE AE 52 18         [ 2]  768 	ldw	x, #0x5218
      0085C1 88               [ 1]  769 	push	a
      0085C2 F6               [ 1]  770 	ld	a, (x)
      0085C3 A4 FB            [ 1]  771 	and	a, #0xfb
      0085C5 F7               [ 1]  772 	ld	(x), a
      0085C6 84               [ 1]  773 	pop	a
                                    774 ;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0085C7 4C               [ 1]  775 	inc	a
      0085C8 6B 01            [ 1]  776 	ld	(0x01, sp), a
      0085CA 20 DA            [ 2]  777 	jra	00105$
      0085CC                        778 00103$:
                                    779 ;	libs/i2c_lib.c: 109: i2c_stop();//совпадений нет выход из функции
      0085CC CD 84 C0         [ 4]  780 	call	_i2c_stop
                                    781 ;	libs/i2c_lib.c: 110: return 0;
      0085CF 4F               [ 1]  782 	clr	a
      0085D0                        783 00107$:
                                    784 ;	libs/i2c_lib.c: 111: }
      0085D0 5B 02            [ 2]  785 	addw	sp, #2
      0085D2 81               [ 4]  786 	ret
                                    787 ;	main.c: 4: void setup(void)
                                    788 ;	-----------------------------------------
                                    789 ;	 function setup
                                    790 ;	-----------------------------------------
      0085D3                        791 _setup:
                                    792 ;	main.c: 7: CLK_CKDIVR = 0;
      0085D3 35 00 50 C6      [ 1]  793 	mov	0x50c6+0, #0x00
                                    794 ;	main.c: 9: uart_init(9600,0);
      0085D7 4F               [ 1]  795 	clr	a
      0085D8 AE 25 80         [ 2]  796 	ldw	x, #0x2580
      0085DB CD 83 16         [ 4]  797 	call	_uart_init
                                    798 ;	main.c: 10: i2c_init();
      0085DE CD 84 8B         [ 4]  799 	call	_i2c_init
                                    800 ;	main.c: 12: enableInterrupts();
      0085E1 9A               [ 1]  801 	rim
                                    802 ;	main.c: 13: }
      0085E2 81               [ 4]  803 	ret
                                    804 ;	main.c: 15: void delay(uint16_t ticks)
                                    805 ;	-----------------------------------------
                                    806 ;	 function delay
                                    807 ;	-----------------------------------------
      0085E3                        808 _delay:
                                    809 ;	main.c: 17: while(ticks > 0)
      0085E3                        810 00101$:
      0085E3 5D               [ 2]  811 	tnzw	x
      0085E4 26 01            [ 1]  812 	jrne	00120$
      0085E6 81               [ 4]  813 	ret
      0085E7                        814 00120$:
                                    815 ;	main.c: 19: ticks-=2;
      0085E7 5A               [ 2]  816 	decw	x
      0085E8 5A               [ 2]  817 	decw	x
                                    818 ;	main.c: 20: ticks+=1;
      0085E9 5C               [ 1]  819 	incw	x
      0085EA 20 F7            [ 2]  820 	jra	00101$
                                    821 ;	main.c: 22: }
      0085EC 81               [ 4]  822 	ret
                                    823 ;	main.c: 24: void display_init(void)
                                    824 ;	-----------------------------------------
                                    825 ;	 function display_init
                                    826 ;	-----------------------------------------
      0085ED                        827 _display_init:
      0085ED 52 07            [ 2]  828 	sub	sp, #7
                                    829 ;	main.c: 26: uint8_t setup_buf[7] = {0x00,0xAE,0xD5,0x80,0xA8,0x1F,0xAF};
      0085EF 0F 01            [ 1]  830 	clr	(0x01, sp)
      0085F1 A6 AE            [ 1]  831 	ld	a, #0xae
      0085F3 6B 02            [ 1]  832 	ld	(0x02, sp), a
      0085F5 A6 D5            [ 1]  833 	ld	a, #0xd5
      0085F7 6B 03            [ 1]  834 	ld	(0x03, sp), a
      0085F9 A6 80            [ 1]  835 	ld	a, #0x80
      0085FB 6B 04            [ 1]  836 	ld	(0x04, sp), a
      0085FD A6 A8            [ 1]  837 	ld	a, #0xa8
      0085FF 6B 05            [ 1]  838 	ld	(0x05, sp), a
      008601 A6 1F            [ 1]  839 	ld	a, #0x1f
      008603 6B 06            [ 1]  840 	ld	(0x06, sp), a
      008605 A6 AF            [ 1]  841 	ld	a, #0xaf
      008607 6B 07            [ 1]  842 	ld	(0x07, sp), a
                                    843 ;	main.c: 27: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      008609 96               [ 1]  844 	ldw	x, sp
      00860A 5C               [ 1]  845 	incw	x
      00860B 89               [ 2]  846 	pushw	x
      00860C 4B 05            [ 1]  847 	push	#0x05
      00860E A6 3C            [ 1]  848 	ld	a, #0x3c
      008610 CD 85 70         [ 4]  849 	call	_i2c_write
                                    850 ;	main.c: 28: setup_buf[1] = 0x1F;
      008613 A6 1F            [ 1]  851 	ld	a, #0x1f
      008615 6B 02            [ 1]  852 	ld	(0x02, sp), a
                                    853 ;	main.c: 29: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      008617 96               [ 1]  854 	ldw	x, sp
      008618 5C               [ 1]  855 	incw	x
      008619 89               [ 2]  856 	pushw	x
      00861A 4B 02            [ 1]  857 	push	#0x02
      00861C A6 3C            [ 1]  858 	ld	a, #0x3c
      00861E CD 85 70         [ 4]  859 	call	_i2c_write
                                    860 ;	main.c: 30: setup_buf[1] = 0xD3;
      008621 A6 D3            [ 1]  861 	ld	a, #0xd3
      008623 6B 02            [ 1]  862 	ld	(0x02, sp), a
                                    863 ;	main.c: 31: setup_buf[2] = 0x00;
      008625 0F 03            [ 1]  864 	clr	(0x03, sp)
                                    865 ;	main.c: 32: setup_buf[3] = 0x40;
      008627 A6 40            [ 1]  866 	ld	a, #0x40
      008629 6B 04            [ 1]  867 	ld	(0x04, sp), a
                                    868 ;	main.c: 33: setup_buf[4] = 0x8D;
      00862B A6 8D            [ 1]  869 	ld	a, #0x8d
      00862D 6B 05            [ 1]  870 	ld	(0x05, sp), a
                                    871 ;	main.c: 34: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      00862F 96               [ 1]  872 	ldw	x, sp
      008630 5C               [ 1]  873 	incw	x
      008631 89               [ 2]  874 	pushw	x
      008632 4B 05            [ 1]  875 	push	#0x05
      008634 A6 3C            [ 1]  876 	ld	a, #0x3c
      008636 CD 85 70         [ 4]  877 	call	_i2c_write
                                    878 ;	main.c: 35: setup_buf[1] = 0x14;
      008639 A6 14            [ 1]  879 	ld	a, #0x14
      00863B 6B 02            [ 1]  880 	ld	(0x02, sp), a
                                    881 ;	main.c: 36: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      00863D 96               [ 1]  882 	ldw	x, sp
      00863E 5C               [ 1]  883 	incw	x
      00863F 89               [ 2]  884 	pushw	x
      008640 4B 02            [ 1]  885 	push	#0x02
      008642 A6 3C            [ 1]  886 	ld	a, #0x3c
      008644 CD 85 70         [ 4]  887 	call	_i2c_write
                                    888 ;	main.c: 37: setup_buf[1] = 0xDB;
      008647 A6 DB            [ 1]  889 	ld	a, #0xdb
      008649 6B 02            [ 1]  890 	ld	(0x02, sp), a
                                    891 ;	main.c: 38: setup_buf[2] = 0x40;
      00864B A6 40            [ 1]  892 	ld	a, #0x40
      00864D 6B 03            [ 1]  893 	ld	(0x03, sp), a
                                    894 ;	main.c: 39: setup_buf[3] = 0xA4;
      00864F A6 A4            [ 1]  895 	ld	a, #0xa4
      008651 6B 04            [ 1]  896 	ld	(0x04, sp), a
                                    897 ;	main.c: 40: setup_buf[4] = 0xA6;
      008653 A6 A6            [ 1]  898 	ld	a, #0xa6
      008655 6B 05            [ 1]  899 	ld	(0x05, sp), a
                                    900 ;	main.c: 41: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      008657 96               [ 1]  901 	ldw	x, sp
      008658 5C               [ 1]  902 	incw	x
      008659 89               [ 2]  903 	pushw	x
      00865A 4B 05            [ 1]  904 	push	#0x05
      00865C A6 3C            [ 1]  905 	ld	a, #0x3c
      00865E CD 85 70         [ 4]  906 	call	_i2c_write
                                    907 ;	main.c: 42: setup_buf[1] = 0xDA;
      008661 A6 DA            [ 1]  908 	ld	a, #0xda
      008663 6B 02            [ 1]  909 	ld	(0x02, sp), a
                                    910 ;	main.c: 43: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      008665 96               [ 1]  911 	ldw	x, sp
      008666 5C               [ 1]  912 	incw	x
      008667 89               [ 2]  913 	pushw	x
      008668 4B 02            [ 1]  914 	push	#0x02
      00866A A6 3C            [ 1]  915 	ld	a, #0x3c
      00866C CD 85 70         [ 4]  916 	call	_i2c_write
                                    917 ;	main.c: 44: setup_buf[1] = 0x02;
      00866F A6 02            [ 1]  918 	ld	a, #0x02
      008671 6B 02            [ 1]  919 	ld	(0x02, sp), a
                                    920 ;	main.c: 45: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      008673 96               [ 1]  921 	ldw	x, sp
      008674 5C               [ 1]  922 	incw	x
      008675 89               [ 2]  923 	pushw	x
      008676 4B 02            [ 1]  924 	push	#0x02
      008678 A6 3C            [ 1]  925 	ld	a, #0x3c
      00867A CD 85 70         [ 4]  926 	call	_i2c_write
                                    927 ;	main.c: 46: setup_buf[1] = 0x81;
      00867D A6 81            [ 1]  928 	ld	a, #0x81
      00867F 6B 02            [ 1]  929 	ld	(0x02, sp), a
                                    930 ;	main.c: 47: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      008681 96               [ 1]  931 	ldw	x, sp
      008682 5C               [ 1]  932 	incw	x
      008683 89               [ 2]  933 	pushw	x
      008684 4B 02            [ 1]  934 	push	#0x02
      008686 A6 3C            [ 1]  935 	ld	a, #0x3c
      008688 CD 85 70         [ 4]  936 	call	_i2c_write
                                    937 ;	main.c: 48: setup_buf[1] = 0x8F;
      00868B A6 8F            [ 1]  938 	ld	a, #0x8f
      00868D 6B 02            [ 1]  939 	ld	(0x02, sp), a
                                    940 ;	main.c: 49: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      00868F 96               [ 1]  941 	ldw	x, sp
      008690 5C               [ 1]  942 	incw	x
      008691 89               [ 2]  943 	pushw	x
      008692 4B 02            [ 1]  944 	push	#0x02
      008694 A6 3C            [ 1]  945 	ld	a, #0x3c
      008696 CD 85 70         [ 4]  946 	call	_i2c_write
                                    947 ;	main.c: 50: setup_buf[1] = 0xD9;
      008699 A6 D9            [ 1]  948 	ld	a, #0xd9
      00869B 6B 02            [ 1]  949 	ld	(0x02, sp), a
                                    950 ;	main.c: 51: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      00869D 96               [ 1]  951 	ldw	x, sp
      00869E 5C               [ 1]  952 	incw	x
      00869F 89               [ 2]  953 	pushw	x
      0086A0 4B 02            [ 1]  954 	push	#0x02
      0086A2 A6 3C            [ 1]  955 	ld	a, #0x3c
      0086A4 CD 85 70         [ 4]  956 	call	_i2c_write
                                    957 ;	main.c: 52: setup_buf[1] = 0xF1;
      0086A7 A6 F1            [ 1]  958 	ld	a, #0xf1
      0086A9 6B 02            [ 1]  959 	ld	(0x02, sp), a
                                    960 ;	main.c: 53: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086AB 96               [ 1]  961 	ldw	x, sp
      0086AC 5C               [ 1]  962 	incw	x
      0086AD 89               [ 2]  963 	pushw	x
      0086AE 4B 02            [ 1]  964 	push	#0x02
      0086B0 A6 3C            [ 1]  965 	ld	a, #0x3c
      0086B2 CD 85 70         [ 4]  966 	call	_i2c_write
                                    967 ;	main.c: 54: setup_buf[1] = 0x20;
      0086B5 A6 20            [ 1]  968 	ld	a, #0x20
      0086B7 6B 02            [ 1]  969 	ld	(0x02, sp), a
                                    970 ;	main.c: 55: setup_buf[2] = 0x01;
      0086B9 A6 01            [ 1]  971 	ld	a, #0x01
      0086BB 6B 03            [ 1]  972 	ld	(0x03, sp), a
                                    973 ;	main.c: 56: setup_buf[3] = 0xA1;
      0086BD A6 A1            [ 1]  974 	ld	a, #0xa1
      0086BF 6B 04            [ 1]  975 	ld	(0x04, sp), a
                                    976 ;	main.c: 57: setup_buf[4] = 0xC8;
      0086C1 A6 C8            [ 1]  977 	ld	a, #0xc8
      0086C3 6B 05            [ 1]  978 	ld	(0x05, sp), a
                                    979 ;	main.c: 58: i2c_write(I2C_DISPLAY_ADDR,7,setup_buf);
      0086C5 96               [ 1]  980 	ldw	x, sp
      0086C6 5C               [ 1]  981 	incw	x
      0086C7 89               [ 2]  982 	pushw	x
      0086C8 4B 07            [ 1]  983 	push	#0x07
      0086CA A6 3C            [ 1]  984 	ld	a, #0x3c
      0086CC CD 85 70         [ 4]  985 	call	_i2c_write
                                    986 ;	main.c: 59: }
      0086CF 5B 07            [ 2]  987 	addw	sp, #7
      0086D1 81               [ 4]  988 	ret
                                    989 ;	main.c: 61: void display_set_params_to_write(void)
                                    990 ;	-----------------------------------------
                                    991 ;	 function display_set_params_to_write
                                    992 ;	-----------------------------------------
      0086D2                        993 _display_set_params_to_write:
      0086D2 52 08            [ 2]  994 	sub	sp, #8
                                    995 ;	main.c: 63: uint8_t set_params_buf[8] = {0x00,0x22,0x00,0x03,0x00,0x21,0x00,0x7F};
      0086D4 96               [ 1]  996 	ldw	x, sp
      0086D5 5C               [ 1]  997 	incw	x
      0086D6 7F               [ 1]  998 	clr	(x)
      0086D7 A6 22            [ 1]  999 	ld	a, #0x22
      0086D9 6B 02            [ 1] 1000 	ld	(0x02, sp), a
      0086DB 0F 03            [ 1] 1001 	clr	(0x03, sp)
      0086DD A6 03            [ 1] 1002 	ld	a, #0x03
      0086DF 6B 04            [ 1] 1003 	ld	(0x04, sp), a
      0086E1 0F 05            [ 1] 1004 	clr	(0x05, sp)
      0086E3 A6 21            [ 1] 1005 	ld	a, #0x21
      0086E5 6B 06            [ 1] 1006 	ld	(0x06, sp), a
      0086E7 0F 07            [ 1] 1007 	clr	(0x07, sp)
      0086E9 A6 7F            [ 1] 1008 	ld	a, #0x7f
      0086EB 6B 08            [ 1] 1009 	ld	(0x08, sp), a
                                   1010 ;	main.c: 64: i2c_write(I2C_DISPLAY_ADDR,8,set_params_buf);
      0086ED 89               [ 2] 1011 	pushw	x
      0086EE 4B 08            [ 1] 1012 	push	#0x08
      0086F0 A6 3C            [ 1] 1013 	ld	a, #0x3c
      0086F2 CD 85 70         [ 4] 1014 	call	_i2c_write
                                   1015 ;	main.c: 65: }
      0086F5 5B 08            [ 2] 1016 	addw	sp, #8
      0086F7 81               [ 4] 1017 	ret
                                   1018 ;	main.c: 71: void display_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1019 ;	-----------------------------------------
                                   1020 ;	 function display_draw_pixel
                                   1021 ;	-----------------------------------------
      0086F8                       1022 _display_draw_pixel:
      0086F8 52 06            [ 2] 1023 	sub	sp, #6
      0086FA 1F 05            [ 2] 1024 	ldw	(0x05, sp), x
                                   1025 ;	main.c: 77: buffer[x + (y / 8) * SSD1306_LCDWIDTH] |=  (1 << (y & 7));
      0086FC 6B 02            [ 1] 1026 	ld	(0x02, sp), a
      0086FE 0F 01            [ 1] 1027 	clr	(0x01, sp)
      008700 5F               [ 1] 1028 	clrw	x
      008701 7B 09            [ 1] 1029 	ld	a, (0x09, sp)
      008703 97               [ 1] 1030 	ld	xl, a
      008704 5D               [ 2] 1031 	tnzw	x
      008705 2A 03            [ 1] 1032 	jrpl	00121$
      008707 1C 00 07         [ 2] 1033 	addw	x, #0x0007
      00870A                       1034 00121$:
      00870A 57               [ 2] 1035 	sraw	x
      00870B 57               [ 2] 1036 	sraw	x
      00870C 57               [ 2] 1037 	sraw	x
      00870D A4 07            [ 1] 1038 	and	a, #0x07
      00870F 58               [ 2] 1039 	sllw	x
      008710 58               [ 2] 1040 	sllw	x
      008711 58               [ 2] 1041 	sllw	x
      008712 58               [ 2] 1042 	sllw	x
      008713 58               [ 2] 1043 	sllw	x
      008714 58               [ 2] 1044 	sllw	x
      008715 58               [ 2] 1045 	sllw	x
      008716 88               [ 1] 1046 	push	a
      008717 A6 01            [ 1] 1047 	ld	a, #0x01
      008719 6B 04            [ 1] 1048 	ld	(0x04, sp), a
      00871B 84               [ 1] 1049 	pop	a
      00871C 4D               [ 1] 1050 	tnz	a
      00871D 27 05            [ 1] 1051 	jreq	00123$
      00871F                       1052 00122$:
      00871F 08 03            [ 1] 1053 	sll	(0x03, sp)
      008721 4A               [ 1] 1054 	dec	a
      008722 26 FB            [ 1] 1055 	jrne	00122$
      008724                       1056 00123$:
      008724 72 FB 01         [ 2] 1057 	addw	x, (0x01, sp)
      008727 72 FB 05         [ 2] 1058 	addw	x, (0x05, sp)
                                   1059 ;	main.c: 74: switch(color)
      00872A 7B 0A            [ 1] 1060 	ld	a, (0x0a, sp)
      00872C A1 00            [ 1] 1061 	cp	a, #0x00
      00872E 27 0B            [ 1] 1062 	jreq	00102$
      008730 7B 0A            [ 1] 1063 	ld	a, (0x0a, sp)
      008732 4A               [ 1] 1064 	dec	a
      008733 26 0F            [ 1] 1065 	jrne	00105$
                                   1066 ;	main.c: 77: buffer[x + (y / 8) * SSD1306_LCDWIDTH] |=  (1 << (y & 7));
      008735 F6               [ 1] 1067 	ld	a, (x)
      008736 1A 03            [ 1] 1068 	or	a, (0x03, sp)
      008738 F7               [ 1] 1069 	ld	(x), a
                                   1070 ;	main.c: 78: break;
      008739 20 09            [ 2] 1071 	jra	00105$
                                   1072 ;	main.c: 79: case BLACK:
      00873B                       1073 00102$:
                                   1074 ;	main.c: 80: buffer[x + (y / 8) * SSD1306_LCDWIDTH] &= ~(1 << (y & 7));
      00873B F6               [ 1] 1075 	ld	a, (x)
      00873C 6B 04            [ 1] 1076 	ld	(0x04, sp), a
      00873E 7B 03            [ 1] 1077 	ld	a, (0x03, sp)
      008740 43               [ 1] 1078 	cpl	a
      008741 14 04            [ 1] 1079 	and	a, (0x04, sp)
      008743 F7               [ 1] 1080 	ld	(x), a
                                   1081 ;	main.c: 84: }
      008744                       1082 00105$:
                                   1083 ;	main.c: 85: }
      008744 1E 07            [ 2] 1084 	ldw	x, (7, sp)
      008746 5B 0A            [ 2] 1085 	addw	sp, #10
      008748 FC               [ 2] 1086 	jp	(x)
                                   1087 ;	main.c: 87: void display_buffer_fill(uint8_t x, uint8_t y,uint8_t *in_data, uint8_t *out_data,uint8_t width, uint8_t height, uint8_t color)
                                   1088 ;	-----------------------------------------
                                   1089 ;	 function display_buffer_fill
                                   1090 ;	-----------------------------------------
      008749                       1091 _display_buffer_fill:
      008749 52 0C            [ 2] 1092 	sub	sp, #12
      00874B 6B 08            [ 1] 1093 	ld	(0x08, sp), a
                                   1094 ;	main.c: 89: uint8_t byteWidth = (width + 7) / 8;
      00874D 7B 14            [ 1] 1095 	ld	a, (0x14, sp)
      00874F 6B 02            [ 1] 1096 	ld	(0x02, sp), a
      008751 0F 01            [ 1] 1097 	clr	(0x01, sp)
      008753 1E 01            [ 2] 1098 	ldw	x, (0x01, sp)
      008755 1C 00 07         [ 2] 1099 	addw	x, #0x0007
      008758 5D               [ 2] 1100 	tnzw	x
      008759 2A 03            [ 1] 1101 	jrpl	00150$
      00875B 1C 00 07         [ 2] 1102 	addw	x, #0x0007
      00875E                       1103 00150$:
      00875E 57               [ 2] 1104 	sraw	x
      00875F 57               [ 2] 1105 	sraw	x
      008760 57               [ 2] 1106 	sraw	x
      008761 9F               [ 1] 1107 	ld	a, xl
      008762 6B 03            [ 1] 1108 	ld	(0x03, sp), a
                                   1109 ;	main.c: 91: for(int j = 0; j < height; j++) {
      008764 5F               [ 1] 1110 	clrw	x
      008765 1F 09            [ 2] 1111 	ldw	(0x09, sp), x
      008767                       1112 00109$:
      008767 7B 15            [ 1] 1113 	ld	a, (0x15, sp)
      008769 6B 0C            [ 1] 1114 	ld	(0x0c, sp), a
      00876B 0F 0B            [ 1] 1115 	clr	(0x0b, sp)
      00876D 1E 09            [ 2] 1116 	ldw	x, (0x09, sp)
      00876F 13 0B            [ 2] 1117 	cpw	x, (0x0b, sp)
      008771 2E 72            [ 1] 1118 	jrsge	00111$
                                   1119 ;	main.c: 92: for(int i = 0; i < width; i++) {
      008773 5F               [ 1] 1120 	clrw	x
      008774 1F 0B            [ 2] 1121 	ldw	(0x0b, sp), x
      008776                       1122 00106$:
      008776 1E 0B            [ 2] 1123 	ldw	x, (0x0b, sp)
      008778 13 01            [ 2] 1124 	cpw	x, (0x01, sp)
      00877A 2E 62            [ 1] 1125 	jrsge	00110$
                                   1126 ;	main.c: 93: if(in_data[j * byteWidth + i / 8] & (128 >> (i & 7)))
      00877C 5F               [ 1] 1127 	clrw	x
      00877D 7B 03            [ 1] 1128 	ld	a, (0x03, sp)
      00877F 97               [ 1] 1129 	ld	xl, a
      008780 89               [ 2] 1130 	pushw	x
      008781 1E 0B            [ 2] 1131 	ldw	x, (0x0b, sp)
      008783 CD 91 24         [ 4] 1132 	call	__mulint
      008786 1F 06            [ 2] 1133 	ldw	(0x06, sp), x
      008788 1E 0B            [ 2] 1134 	ldw	x, (0x0b, sp)
      00878A 2A 03            [ 1] 1135 	jrpl	00153$
      00878C 1C 00 07         [ 2] 1136 	addw	x, #0x0007
      00878F                       1137 00153$:
      00878F 57               [ 2] 1138 	sraw	x
      008790 57               [ 2] 1139 	sraw	x
      008791 57               [ 2] 1140 	sraw	x
      008792 72 FB 06         [ 2] 1141 	addw	x, (0x06, sp)
      008795 72 FB 10         [ 2] 1142 	addw	x, (0x10, sp)
      008798 F6               [ 1] 1143 	ld	a, (x)
      008799 6B 07            [ 1] 1144 	ld	(0x07, sp), a
      00879B 7B 0C            [ 1] 1145 	ld	a, (0x0c, sp)
      00879D A4 07            [ 1] 1146 	and	a, #0x07
      00879F AE 00 80         [ 2] 1147 	ldw	x, #0x0080
      0087A2 4D               [ 1] 1148 	tnz	a
      0087A3 27 04            [ 1] 1149 	jreq	00155$
      0087A5                       1150 00154$:
      0087A5 57               [ 2] 1151 	sraw	x
      0087A6 4A               [ 1] 1152 	dec	a
      0087A7 26 FC            [ 1] 1153 	jrne	00154$
      0087A9                       1154 00155$:
      0087A9 7B 07            [ 1] 1155 	ld	a, (0x07, sp)
      0087AB 6B 05            [ 1] 1156 	ld	(0x05, sp), a
      0087AD 0F 04            [ 1] 1157 	clr	(0x04, sp)
      0087AF 9F               [ 1] 1158 	ld	a, xl
      0087B0 14 05            [ 1] 1159 	and	a, (0x05, sp)
      0087B2 6B 07            [ 1] 1160 	ld	(0x07, sp), a
      0087B4 0F 06            [ 1] 1161 	clr	(0x06, sp)
      0087B6 1E 06            [ 2] 1162 	ldw	x, (0x06, sp)
      0087B8 27 1D            [ 1] 1163 	jreq	00107$
                                   1164 ;	main.c: 94: display_draw_pixel(out_data,x + i, y + j, color);
      0087BA 7B 0A            [ 1] 1165 	ld	a, (0x0a, sp)
      0087BC 6B 07            [ 1] 1166 	ld	(0x07, sp), a
      0087BE 7B 0F            [ 1] 1167 	ld	a, (0x0f, sp)
      0087C0 1B 07            [ 1] 1168 	add	a, (0x07, sp)
      0087C2 97               [ 1] 1169 	ld	xl, a
      0087C3 7B 0C            [ 1] 1170 	ld	a, (0x0c, sp)
      0087C5 6B 07            [ 1] 1171 	ld	(0x07, sp), a
      0087C7 7B 08            [ 1] 1172 	ld	a, (0x08, sp)
      0087C9 1B 07            [ 1] 1173 	add	a, (0x07, sp)
      0087CB 95               [ 1] 1174 	ld	xh, a
      0087CC 7B 16            [ 1] 1175 	ld	a, (0x16, sp)
      0087CE 88               [ 1] 1176 	push	a
      0087CF 9F               [ 1] 1177 	ld	a, xl
      0087D0 88               [ 1] 1178 	push	a
      0087D1 9E               [ 1] 1179 	ld	a, xh
      0087D2 1E 14            [ 2] 1180 	ldw	x, (0x14, sp)
      0087D4 CD 86 F8         [ 4] 1181 	call	_display_draw_pixel
      0087D7                       1182 00107$:
                                   1183 ;	main.c: 92: for(int i = 0; i < width; i++) {
      0087D7 1E 0B            [ 2] 1184 	ldw	x, (0x0b, sp)
      0087D9 5C               [ 1] 1185 	incw	x
      0087DA 1F 0B            [ 2] 1186 	ldw	(0x0b, sp), x
      0087DC 20 98            [ 2] 1187 	jra	00106$
      0087DE                       1188 00110$:
                                   1189 ;	main.c: 91: for(int j = 0; j < height; j++) {
      0087DE 1E 09            [ 2] 1190 	ldw	x, (0x09, sp)
      0087E0 5C               [ 1] 1191 	incw	x
      0087E1 1F 09            [ 2] 1192 	ldw	(0x09, sp), x
      0087E3 20 82            [ 2] 1193 	jra	00109$
      0087E5                       1194 00111$:
                                   1195 ;	main.c: 97: }
      0087E5 1E 0D            [ 2] 1196 	ldw	x, (13, sp)
      0087E7 5B 16            [ 2] 1197 	addw	sp, #22
      0087E9 FC               [ 2] 1198 	jp	(x)
                                   1199 ;	main.c: 100: void display_set(uint8_t **data)
                                   1200 ;	-----------------------------------------
                                   1201 ;	 function display_set
                                   1202 ;	-----------------------------------------
      0087EA                       1203 _display_set:
      0087EA 52 29            [ 2] 1204 	sub	sp, #41
      0087EC 1F 26            [ 2] 1205 	ldw	(0x26, sp), x
                                   1206 ;	main.c: 103: display_set_params_to_write();
      0087EE CD 86 D2         [ 4] 1207 	call	_display_set_params_to_write
                                   1208 ;	main.c: 104: for (int i = 0; i < 512; i += 32) 
      0087F1 5F               [ 1] 1209 	clrw	x
      0087F2 1F 28            [ 2] 1210 	ldw	(0x28, sp), x
      0087F4                       1211 00107$:
      0087F4 1E 28            [ 2] 1212 	ldw	x, (0x28, sp)
      0087F6 A3 02 00         [ 2] 1213 	cpw	x, #0x0200
      0087F9 2F 03            [ 1] 1214 	jrslt	00141$
      0087FB CC 88 82         [ 2] 1215 	jp	00109$
      0087FE                       1216 00141$:
                                   1217 ;	main.c: 106: uint8_t set_buf[33] = {0x40};
      0087FE A6 40            [ 1] 1218 	ld	a, #0x40
      008800 6B 01            [ 1] 1219 	ld	(0x01, sp), a
      008802 0F 02            [ 1] 1220 	clr	(0x02, sp)
      008804 0F 03            [ 1] 1221 	clr	(0x03, sp)
      008806 0F 04            [ 1] 1222 	clr	(0x04, sp)
      008808 0F 05            [ 1] 1223 	clr	(0x05, sp)
      00880A 0F 06            [ 1] 1224 	clr	(0x06, sp)
      00880C 0F 07            [ 1] 1225 	clr	(0x07, sp)
      00880E 0F 08            [ 1] 1226 	clr	(0x08, sp)
      008810 0F 09            [ 1] 1227 	clr	(0x09, sp)
      008812 0F 0A            [ 1] 1228 	clr	(0x0a, sp)
      008814 0F 0B            [ 1] 1229 	clr	(0x0b, sp)
      008816 0F 0C            [ 1] 1230 	clr	(0x0c, sp)
      008818 0F 0D            [ 1] 1231 	clr	(0x0d, sp)
      00881A 0F 0E            [ 1] 1232 	clr	(0x0e, sp)
      00881C 0F 0F            [ 1] 1233 	clr	(0x0f, sp)
      00881E 0F 10            [ 1] 1234 	clr	(0x10, sp)
      008820 0F 11            [ 1] 1235 	clr	(0x11, sp)
      008822 0F 12            [ 1] 1236 	clr	(0x12, sp)
      008824 0F 13            [ 1] 1237 	clr	(0x13, sp)
      008826 0F 14            [ 1] 1238 	clr	(0x14, sp)
      008828 0F 15            [ 1] 1239 	clr	(0x15, sp)
      00882A 0F 16            [ 1] 1240 	clr	(0x16, sp)
      00882C 0F 17            [ 1] 1241 	clr	(0x17, sp)
      00882E 0F 18            [ 1] 1242 	clr	(0x18, sp)
      008830 0F 19            [ 1] 1243 	clr	(0x19, sp)
      008832 0F 1A            [ 1] 1244 	clr	(0x1a, sp)
      008834 0F 1B            [ 1] 1245 	clr	(0x1b, sp)
      008836 0F 1C            [ 1] 1246 	clr	(0x1c, sp)
      008838 0F 1D            [ 1] 1247 	clr	(0x1d, sp)
      00883A 0F 1E            [ 1] 1248 	clr	(0x1e, sp)
      00883C 0F 1F            [ 1] 1249 	clr	(0x1f, sp)
      00883E 0F 20            [ 1] 1250 	clr	(0x20, sp)
      008840 0F 21            [ 1] 1251 	clr	(0x21, sp)
                                   1252 ;	main.c: 107: for(int o = 0; o < 32; o++)
      008842 90 5F            [ 1] 1253 	clrw	y
      008844                       1254 00104$:
      008844 90 A3 00 20      [ 2] 1255 	cpw	y, #0x0020
      008848 2E 24            [ 1] 1256 	jrsge	00101$
                                   1257 ;	main.c: 108: set_buf[o+1] = data[i+o][1];
      00884A 90 9F            [ 1] 1258 	ld	a, yl
      00884C 4C               [ 1] 1259 	inc	a
      00884D 6B 23            [ 1] 1260 	ld	(0x23, sp), a
      00884F 49               [ 1] 1261 	rlc	a
      008850 4F               [ 1] 1262 	clr	a
      008851 A2 00            [ 1] 1263 	sbc	a, #0x00
      008853 6B 22            [ 1] 1264 	ld	(0x22, sp), a
      008855 96               [ 1] 1265 	ldw	x, sp
      008856 5C               [ 1] 1266 	incw	x
      008857 72 FB 22         [ 2] 1267 	addw	x, (0x22, sp)
      00885A 1F 24            [ 2] 1268 	ldw	(0x24, sp), x
      00885C 93               [ 1] 1269 	ldw	x, y
      00885D 72 FB 28         [ 2] 1270 	addw	x, (0x28, sp)
      008860 58               [ 2] 1271 	sllw	x
      008861 72 FB 26         [ 2] 1272 	addw	x, (0x26, sp)
      008864 FE               [ 2] 1273 	ldw	x, (x)
      008865 E6 01            [ 1] 1274 	ld	a, (0x1, x)
      008867 1E 24            [ 2] 1275 	ldw	x, (0x24, sp)
      008869 F7               [ 1] 1276 	ld	(x), a
                                   1277 ;	main.c: 107: for(int o = 0; o < 32; o++)
      00886A 90 5C            [ 1] 1278 	incw	y
      00886C 20 D6            [ 2] 1279 	jra	00104$
      00886E                       1280 00101$:
                                   1281 ;	main.c: 109: i2c_write(I2C_DISPLAY_ADDR,33,set_buf);
      00886E 96               [ 1] 1282 	ldw	x, sp
      00886F 5C               [ 1] 1283 	incw	x
      008870 89               [ 2] 1284 	pushw	x
      008871 4B 21            [ 1] 1285 	push	#0x21
      008873 A6 3C            [ 1] 1286 	ld	a, #0x3c
      008875 CD 85 70         [ 4] 1287 	call	_i2c_write
                                   1288 ;	main.c: 104: for (int i = 0; i < 512; i += 32) 
      008878 1E 28            [ 2] 1289 	ldw	x, (0x28, sp)
      00887A 1C 00 20         [ 2] 1290 	addw	x, #0x0020
      00887D 1F 28            [ 2] 1291 	ldw	(0x28, sp), x
      00887F CC 87 F4         [ 2] 1292 	jp	00107$
      008882                       1293 00109$:
                                   1294 ;	main.c: 111: }
      008882 5B 29            [ 2] 1295 	addw	sp, #41
      008884 81               [ 4] 1296 	ret
                                   1297 ;	main.c: 113: void display_clean(void)
                                   1298 ;	-----------------------------------------
                                   1299 ;	 function display_clean
                                   1300 ;	-----------------------------------------
      008885                       1301 _display_clean:
      008885 52 21            [ 2] 1302 	sub	sp, #33
                                   1303 ;	main.c: 115: uint8_t clean_buf[33] = {0x40};
      008887 A6 40            [ 1] 1304 	ld	a, #0x40
      008889 6B 01            [ 1] 1305 	ld	(0x01, sp), a
      00888B 0F 02            [ 1] 1306 	clr	(0x02, sp)
      00888D 0F 03            [ 1] 1307 	clr	(0x03, sp)
      00888F 0F 04            [ 1] 1308 	clr	(0x04, sp)
      008891 0F 05            [ 1] 1309 	clr	(0x05, sp)
      008893 0F 06            [ 1] 1310 	clr	(0x06, sp)
      008895 0F 07            [ 1] 1311 	clr	(0x07, sp)
      008897 0F 08            [ 1] 1312 	clr	(0x08, sp)
      008899 0F 09            [ 1] 1313 	clr	(0x09, sp)
      00889B 0F 0A            [ 1] 1314 	clr	(0x0a, sp)
      00889D 0F 0B            [ 1] 1315 	clr	(0x0b, sp)
      00889F 0F 0C            [ 1] 1316 	clr	(0x0c, sp)
      0088A1 0F 0D            [ 1] 1317 	clr	(0x0d, sp)
      0088A3 0F 0E            [ 1] 1318 	clr	(0x0e, sp)
      0088A5 0F 0F            [ 1] 1319 	clr	(0x0f, sp)
      0088A7 0F 10            [ 1] 1320 	clr	(0x10, sp)
      0088A9 0F 11            [ 1] 1321 	clr	(0x11, sp)
      0088AB 0F 12            [ 1] 1322 	clr	(0x12, sp)
      0088AD 0F 13            [ 1] 1323 	clr	(0x13, sp)
      0088AF 0F 14            [ 1] 1324 	clr	(0x14, sp)
      0088B1 0F 15            [ 1] 1325 	clr	(0x15, sp)
      0088B3 0F 16            [ 1] 1326 	clr	(0x16, sp)
      0088B5 0F 17            [ 1] 1327 	clr	(0x17, sp)
      0088B7 0F 18            [ 1] 1328 	clr	(0x18, sp)
      0088B9 0F 19            [ 1] 1329 	clr	(0x19, sp)
      0088BB 0F 1A            [ 1] 1330 	clr	(0x1a, sp)
      0088BD 0F 1B            [ 1] 1331 	clr	(0x1b, sp)
      0088BF 0F 1C            [ 1] 1332 	clr	(0x1c, sp)
      0088C1 0F 1D            [ 1] 1333 	clr	(0x1d, sp)
      0088C3 0F 1E            [ 1] 1334 	clr	(0x1e, sp)
      0088C5 0F 1F            [ 1] 1335 	clr	(0x1f, sp)
      0088C7 0F 20            [ 1] 1336 	clr	(0x20, sp)
      0088C9 0F 21            [ 1] 1337 	clr	(0x21, sp)
                                   1338 ;	main.c: 117: display_set_params_to_write();
      0088CB CD 86 D2         [ 4] 1339 	call	_display_set_params_to_write
                                   1340 ;	main.c: 119: for(int i = 0;i<16;i++)
      0088CE 4F               [ 1] 1341 	clr	a
      0088CF                       1342 00103$:
      0088CF A1 10            [ 1] 1343 	cp	a, #0x10
      0088D1 24 10            [ 1] 1344 	jrnc	00105$
                                   1345 ;	main.c: 120: i2c_write(I2C_DISPLAY_ADDR,33,clean_buf);
      0088D3 88               [ 1] 1346 	push	a
      0088D4 96               [ 1] 1347 	ldw	x, sp
      0088D5 5C               [ 1] 1348 	incw	x
      0088D6 5C               [ 1] 1349 	incw	x
      0088D7 89               [ 2] 1350 	pushw	x
      0088D8 4B 21            [ 1] 1351 	push	#0x21
      0088DA A6 3C            [ 1] 1352 	ld	a, #0x3c
      0088DC CD 85 70         [ 4] 1353 	call	_i2c_write
      0088DF 84               [ 1] 1354 	pop	a
                                   1355 ;	main.c: 119: for(int i = 0;i<16;i++)
      0088E0 4C               [ 1] 1356 	inc	a
      0088E1 20 EC            [ 2] 1357 	jra	00103$
      0088E3                       1358 00105$:
                                   1359 ;	main.c: 122: }
      0088E3 5B 21            [ 2] 1360 	addw	sp, #33
      0088E5 81               [ 4] 1361 	ret
                                   1362 ;	main.c: 124: void gg(void)
                                   1363 ;	-----------------------------------------
                                   1364 ;	 function gg
                                   1365 ;	-----------------------------------------
      0088E6                       1366 _gg:
      0088E6 90 96            [ 1] 1367 	ldw	y, sp
      0088E8 72 A2 01 0D      [ 2] 1368 	subw	y, #269
      0088EC 90 94            [ 1] 1369 	ldw	sp, y
      0088EE 52 F3            [ 2] 1370 	sub	sp, #243
                                   1371 ;	main.c: 126: display_init();
      0088F0 90 89            [ 2] 1372 	pushw	y
      0088F2 CD 85 ED         [ 4] 1373 	call	_display_init
      0088F5 CD 88 85         [ 4] 1374 	call	_display_clean
      0088F8 90 85            [ 2] 1375 	popw	y
                                   1376 ;	main.c: 129: uint8_t buffer[512] = {0};
      0088FA 0F 01            [ 1] 1377 	clr	(0x01, sp)
      0088FC 0F 02            [ 1] 1378 	clr	(0x02, sp)
      0088FE 0F 03            [ 1] 1379 	clr	(0x03, sp)
      008900 0F 04            [ 1] 1380 	clr	(0x04, sp)
      008902 0F 05            [ 1] 1381 	clr	(0x05, sp)
      008904 0F 06            [ 1] 1382 	clr	(0x06, sp)
      008906 0F 07            [ 1] 1383 	clr	(0x07, sp)
      008908 0F 08            [ 1] 1384 	clr	(0x08, sp)
      00890A 0F 09            [ 1] 1385 	clr	(0x09, sp)
      00890C 0F 0A            [ 1] 1386 	clr	(0x0a, sp)
      00890E 0F 0B            [ 1] 1387 	clr	(0x0b, sp)
      008910 0F 0C            [ 1] 1388 	clr	(0x0c, sp)
      008912 0F 0D            [ 1] 1389 	clr	(0x0d, sp)
      008914 0F 0E            [ 1] 1390 	clr	(0x0e, sp)
      008916 0F 0F            [ 1] 1391 	clr	(0x0f, sp)
      008918 0F 10            [ 1] 1392 	clr	(0x10, sp)
      00891A 0F 11            [ 1] 1393 	clr	(0x11, sp)
      00891C 0F 12            [ 1] 1394 	clr	(0x12, sp)
      00891E 0F 13            [ 1] 1395 	clr	(0x13, sp)
      008920 0F 14            [ 1] 1396 	clr	(0x14, sp)
      008922 0F 15            [ 1] 1397 	clr	(0x15, sp)
      008924 0F 16            [ 1] 1398 	clr	(0x16, sp)
      008926 0F 17            [ 1] 1399 	clr	(0x17, sp)
      008928 0F 18            [ 1] 1400 	clr	(0x18, sp)
      00892A 0F 19            [ 1] 1401 	clr	(0x19, sp)
      00892C 0F 1A            [ 1] 1402 	clr	(0x1a, sp)
      00892E 0F 1B            [ 1] 1403 	clr	(0x1b, sp)
      008930 0F 1C            [ 1] 1404 	clr	(0x1c, sp)
      008932 0F 1D            [ 1] 1405 	clr	(0x1d, sp)
      008934 0F 1E            [ 1] 1406 	clr	(0x1e, sp)
      008936 0F 1F            [ 1] 1407 	clr	(0x1f, sp)
      008938 0F 20            [ 1] 1408 	clr	(0x20, sp)
      00893A 0F 21            [ 1] 1409 	clr	(0x21, sp)
      00893C 0F 22            [ 1] 1410 	clr	(0x22, sp)
      00893E 0F 23            [ 1] 1411 	clr	(0x23, sp)
      008940 0F 24            [ 1] 1412 	clr	(0x24, sp)
      008942 0F 25            [ 1] 1413 	clr	(0x25, sp)
      008944 0F 26            [ 1] 1414 	clr	(0x26, sp)
      008946 0F 27            [ 1] 1415 	clr	(0x27, sp)
      008948 0F 28            [ 1] 1416 	clr	(0x28, sp)
      00894A 0F 29            [ 1] 1417 	clr	(0x29, sp)
      00894C 0F 2A            [ 1] 1418 	clr	(0x2a, sp)
      00894E 0F 2B            [ 1] 1419 	clr	(0x2b, sp)
      008950 0F 2C            [ 1] 1420 	clr	(0x2c, sp)
      008952 0F 2D            [ 1] 1421 	clr	(0x2d, sp)
      008954 0F 2E            [ 1] 1422 	clr	(0x2e, sp)
      008956 0F 2F            [ 1] 1423 	clr	(0x2f, sp)
      008958 0F 30            [ 1] 1424 	clr	(0x30, sp)
      00895A 0F 31            [ 1] 1425 	clr	(0x31, sp)
      00895C 0F 32            [ 1] 1426 	clr	(0x32, sp)
      00895E 0F 33            [ 1] 1427 	clr	(0x33, sp)
      008960 0F 34            [ 1] 1428 	clr	(0x34, sp)
      008962 0F 35            [ 1] 1429 	clr	(0x35, sp)
      008964 0F 36            [ 1] 1430 	clr	(0x36, sp)
      008966 0F 37            [ 1] 1431 	clr	(0x37, sp)
      008968 0F 38            [ 1] 1432 	clr	(0x38, sp)
      00896A 0F 39            [ 1] 1433 	clr	(0x39, sp)
      00896C 0F 3A            [ 1] 1434 	clr	(0x3a, sp)
      00896E 0F 3B            [ 1] 1435 	clr	(0x3b, sp)
      008970 0F 3C            [ 1] 1436 	clr	(0x3c, sp)
      008972 0F 3D            [ 1] 1437 	clr	(0x3d, sp)
      008974 0F 3E            [ 1] 1438 	clr	(0x3e, sp)
      008976 0F 3F            [ 1] 1439 	clr	(0x3f, sp)
      008978 0F 40            [ 1] 1440 	clr	(0x40, sp)
      00897A 0F 41            [ 1] 1441 	clr	(0x41, sp)
      00897C 0F 42            [ 1] 1442 	clr	(0x42, sp)
      00897E 0F 43            [ 1] 1443 	clr	(0x43, sp)
      008980 0F 44            [ 1] 1444 	clr	(0x44, sp)
      008982 0F 45            [ 1] 1445 	clr	(0x45, sp)
      008984 0F 46            [ 1] 1446 	clr	(0x46, sp)
      008986 0F 47            [ 1] 1447 	clr	(0x47, sp)
      008988 0F 48            [ 1] 1448 	clr	(0x48, sp)
      00898A 0F 49            [ 1] 1449 	clr	(0x49, sp)
      00898C 0F 4A            [ 1] 1450 	clr	(0x4a, sp)
      00898E 0F 4B            [ 1] 1451 	clr	(0x4b, sp)
      008990 0F 4C            [ 1] 1452 	clr	(0x4c, sp)
      008992 0F 4D            [ 1] 1453 	clr	(0x4d, sp)
      008994 0F 4E            [ 1] 1454 	clr	(0x4e, sp)
      008996 0F 4F            [ 1] 1455 	clr	(0x4f, sp)
      008998 0F 50            [ 1] 1456 	clr	(0x50, sp)
      00899A 0F 51            [ 1] 1457 	clr	(0x51, sp)
      00899C 0F 52            [ 1] 1458 	clr	(0x52, sp)
      00899E 0F 53            [ 1] 1459 	clr	(0x53, sp)
      0089A0 0F 54            [ 1] 1460 	clr	(0x54, sp)
      0089A2 0F 55            [ 1] 1461 	clr	(0x55, sp)
      0089A4 0F 56            [ 1] 1462 	clr	(0x56, sp)
      0089A6 0F 57            [ 1] 1463 	clr	(0x57, sp)
      0089A8 0F 58            [ 1] 1464 	clr	(0x58, sp)
      0089AA 0F 59            [ 1] 1465 	clr	(0x59, sp)
      0089AC 0F 5A            [ 1] 1466 	clr	(0x5a, sp)
      0089AE 0F 5B            [ 1] 1467 	clr	(0x5b, sp)
      0089B0 0F 5C            [ 1] 1468 	clr	(0x5c, sp)
      0089B2 0F 5D            [ 1] 1469 	clr	(0x5d, sp)
      0089B4 0F 5E            [ 1] 1470 	clr	(0x5e, sp)
      0089B6 0F 5F            [ 1] 1471 	clr	(0x5f, sp)
      0089B8 0F 60            [ 1] 1472 	clr	(0x60, sp)
      0089BA 0F 61            [ 1] 1473 	clr	(0x61, sp)
      0089BC 0F 62            [ 1] 1474 	clr	(0x62, sp)
      0089BE 0F 63            [ 1] 1475 	clr	(0x63, sp)
      0089C0 0F 64            [ 1] 1476 	clr	(0x64, sp)
      0089C2 0F 65            [ 1] 1477 	clr	(0x65, sp)
      0089C4 0F 66            [ 1] 1478 	clr	(0x66, sp)
      0089C6 0F 67            [ 1] 1479 	clr	(0x67, sp)
      0089C8 0F 68            [ 1] 1480 	clr	(0x68, sp)
      0089CA 0F 69            [ 1] 1481 	clr	(0x69, sp)
      0089CC 0F 6A            [ 1] 1482 	clr	(0x6a, sp)
      0089CE 0F 6B            [ 1] 1483 	clr	(0x6b, sp)
      0089D0 0F 6C            [ 1] 1484 	clr	(0x6c, sp)
      0089D2 0F 6D            [ 1] 1485 	clr	(0x6d, sp)
      0089D4 0F 6E            [ 1] 1486 	clr	(0x6e, sp)
      0089D6 0F 6F            [ 1] 1487 	clr	(0x6f, sp)
      0089D8 0F 70            [ 1] 1488 	clr	(0x70, sp)
      0089DA 0F 71            [ 1] 1489 	clr	(0x71, sp)
      0089DC 0F 72            [ 1] 1490 	clr	(0x72, sp)
      0089DE 0F 73            [ 1] 1491 	clr	(0x73, sp)
      0089E0 0F 74            [ 1] 1492 	clr	(0x74, sp)
      0089E2 0F 75            [ 1] 1493 	clr	(0x75, sp)
      0089E4 0F 76            [ 1] 1494 	clr	(0x76, sp)
      0089E6 0F 77            [ 1] 1495 	clr	(0x77, sp)
      0089E8 0F 78            [ 1] 1496 	clr	(0x78, sp)
      0089EA 0F 79            [ 1] 1497 	clr	(0x79, sp)
      0089EC 0F 7A            [ 1] 1498 	clr	(0x7a, sp)
      0089EE 0F 7B            [ 1] 1499 	clr	(0x7b, sp)
      0089F0 0F 7C            [ 1] 1500 	clr	(0x7c, sp)
      0089F2 0F 7D            [ 1] 1501 	clr	(0x7d, sp)
      0089F4 0F 7E            [ 1] 1502 	clr	(0x7e, sp)
      0089F6 0F 7F            [ 1] 1503 	clr	(0x7f, sp)
      0089F8 0F 80            [ 1] 1504 	clr	(0x80, sp)
      0089FA 0F 81            [ 1] 1505 	clr	(0x81, sp)
      0089FC 0F 82            [ 1] 1506 	clr	(0x82, sp)
      0089FE 0F 83            [ 1] 1507 	clr	(0x83, sp)
      008A00 0F 84            [ 1] 1508 	clr	(0x84, sp)
      008A02 0F 85            [ 1] 1509 	clr	(0x85, sp)
      008A04 0F 86            [ 1] 1510 	clr	(0x86, sp)
      008A06 0F 87            [ 1] 1511 	clr	(0x87, sp)
      008A08 0F 88            [ 1] 1512 	clr	(0x88, sp)
      008A0A 0F 89            [ 1] 1513 	clr	(0x89, sp)
      008A0C 0F 8A            [ 1] 1514 	clr	(0x8a, sp)
      008A0E 0F 8B            [ 1] 1515 	clr	(0x8b, sp)
      008A10 0F 8C            [ 1] 1516 	clr	(0x8c, sp)
      008A12 0F 8D            [ 1] 1517 	clr	(0x8d, sp)
      008A14 0F 8E            [ 1] 1518 	clr	(0x8e, sp)
      008A16 0F 8F            [ 1] 1519 	clr	(0x8f, sp)
      008A18 0F 90            [ 1] 1520 	clr	(0x90, sp)
      008A1A 0F 91            [ 1] 1521 	clr	(0x91, sp)
      008A1C 0F 92            [ 1] 1522 	clr	(0x92, sp)
      008A1E 0F 93            [ 1] 1523 	clr	(0x93, sp)
      008A20 0F 94            [ 1] 1524 	clr	(0x94, sp)
      008A22 0F 95            [ 1] 1525 	clr	(0x95, sp)
      008A24 0F 96            [ 1] 1526 	clr	(0x96, sp)
      008A26 0F 97            [ 1] 1527 	clr	(0x97, sp)
      008A28 0F 98            [ 1] 1528 	clr	(0x98, sp)
      008A2A 0F 99            [ 1] 1529 	clr	(0x99, sp)
      008A2C 0F 9A            [ 1] 1530 	clr	(0x9a, sp)
      008A2E 0F 9B            [ 1] 1531 	clr	(0x9b, sp)
      008A30 0F 9C            [ 1] 1532 	clr	(0x9c, sp)
      008A32 0F 9D            [ 1] 1533 	clr	(0x9d, sp)
      008A34 0F 9E            [ 1] 1534 	clr	(0x9e, sp)
      008A36 0F 9F            [ 1] 1535 	clr	(0x9f, sp)
      008A38 0F A0            [ 1] 1536 	clr	(0xa0, sp)
      008A3A 0F A1            [ 1] 1537 	clr	(0xa1, sp)
      008A3C 0F A2            [ 1] 1538 	clr	(0xa2, sp)
      008A3E 0F A3            [ 1] 1539 	clr	(0xa3, sp)
      008A40 0F A4            [ 1] 1540 	clr	(0xa4, sp)
      008A42 0F A5            [ 1] 1541 	clr	(0xa5, sp)
      008A44 0F A6            [ 1] 1542 	clr	(0xa6, sp)
      008A46 0F A7            [ 1] 1543 	clr	(0xa7, sp)
      008A48 0F A8            [ 1] 1544 	clr	(0xa8, sp)
      008A4A 0F A9            [ 1] 1545 	clr	(0xa9, sp)
      008A4C 0F AA            [ 1] 1546 	clr	(0xaa, sp)
      008A4E 0F AB            [ 1] 1547 	clr	(0xab, sp)
      008A50 0F AC            [ 1] 1548 	clr	(0xac, sp)
      008A52 0F AD            [ 1] 1549 	clr	(0xad, sp)
      008A54 0F AE            [ 1] 1550 	clr	(0xae, sp)
      008A56 0F AF            [ 1] 1551 	clr	(0xaf, sp)
      008A58 0F B0            [ 1] 1552 	clr	(0xb0, sp)
      008A5A 0F B1            [ 1] 1553 	clr	(0xb1, sp)
      008A5C 0F B2            [ 1] 1554 	clr	(0xb2, sp)
      008A5E 0F B3            [ 1] 1555 	clr	(0xb3, sp)
      008A60 0F B4            [ 1] 1556 	clr	(0xb4, sp)
      008A62 0F B5            [ 1] 1557 	clr	(0xb5, sp)
      008A64 0F B6            [ 1] 1558 	clr	(0xb6, sp)
      008A66 0F B7            [ 1] 1559 	clr	(0xb7, sp)
      008A68 0F B8            [ 1] 1560 	clr	(0xb8, sp)
      008A6A 0F B9            [ 1] 1561 	clr	(0xb9, sp)
      008A6C 0F BA            [ 1] 1562 	clr	(0xba, sp)
      008A6E 0F BB            [ 1] 1563 	clr	(0xbb, sp)
      008A70 0F BC            [ 1] 1564 	clr	(0xbc, sp)
      008A72 0F BD            [ 1] 1565 	clr	(0xbd, sp)
      008A74 0F BE            [ 1] 1566 	clr	(0xbe, sp)
      008A76 0F BF            [ 1] 1567 	clr	(0xbf, sp)
      008A78 0F C0            [ 1] 1568 	clr	(0xc0, sp)
      008A7A 0F C1            [ 1] 1569 	clr	(0xc1, sp)
      008A7C 0F C2            [ 1] 1570 	clr	(0xc2, sp)
      008A7E 0F C3            [ 1] 1571 	clr	(0xc3, sp)
      008A80 0F C4            [ 1] 1572 	clr	(0xc4, sp)
      008A82 0F C5            [ 1] 1573 	clr	(0xc5, sp)
      008A84 0F C6            [ 1] 1574 	clr	(0xc6, sp)
      008A86 0F C7            [ 1] 1575 	clr	(0xc7, sp)
      008A88 0F C8            [ 1] 1576 	clr	(0xc8, sp)
      008A8A 0F C9            [ 1] 1577 	clr	(0xc9, sp)
      008A8C 0F CA            [ 1] 1578 	clr	(0xca, sp)
      008A8E 0F CB            [ 1] 1579 	clr	(0xcb, sp)
      008A90 0F CC            [ 1] 1580 	clr	(0xcc, sp)
      008A92 0F CD            [ 1] 1581 	clr	(0xcd, sp)
      008A94 0F CE            [ 1] 1582 	clr	(0xce, sp)
      008A96 0F CF            [ 1] 1583 	clr	(0xcf, sp)
      008A98 0F D0            [ 1] 1584 	clr	(0xd0, sp)
      008A9A 0F D1            [ 1] 1585 	clr	(0xd1, sp)
      008A9C 0F D2            [ 1] 1586 	clr	(0xd2, sp)
      008A9E 0F D3            [ 1] 1587 	clr	(0xd3, sp)
      008AA0 0F D4            [ 1] 1588 	clr	(0xd4, sp)
      008AA2 0F D5            [ 1] 1589 	clr	(0xd5, sp)
      008AA4 0F D6            [ 1] 1590 	clr	(0xd6, sp)
      008AA6 0F D7            [ 1] 1591 	clr	(0xd7, sp)
      008AA8 0F D8            [ 1] 1592 	clr	(0xd8, sp)
      008AAA 0F D9            [ 1] 1593 	clr	(0xd9, sp)
      008AAC 0F DA            [ 1] 1594 	clr	(0xda, sp)
      008AAE 0F DB            [ 1] 1595 	clr	(0xdb, sp)
      008AB0 0F DC            [ 1] 1596 	clr	(0xdc, sp)
      008AB2 0F DD            [ 1] 1597 	clr	(0xdd, sp)
      008AB4 0F DE            [ 1] 1598 	clr	(0xde, sp)
      008AB6 0F DF            [ 1] 1599 	clr	(0xdf, sp)
      008AB8 0F E0            [ 1] 1600 	clr	(0xe0, sp)
      008ABA 0F E1            [ 1] 1601 	clr	(0xe1, sp)
      008ABC 0F E2            [ 1] 1602 	clr	(0xe2, sp)
      008ABE 0F E3            [ 1] 1603 	clr	(0xe3, sp)
      008AC0 0F E4            [ 1] 1604 	clr	(0xe4, sp)
      008AC2 0F E5            [ 1] 1605 	clr	(0xe5, sp)
      008AC4 0F E6            [ 1] 1606 	clr	(0xe6, sp)
      008AC6 0F E7            [ 1] 1607 	clr	(0xe7, sp)
      008AC8 0F E8            [ 1] 1608 	clr	(0xe8, sp)
      008ACA 0F E9            [ 1] 1609 	clr	(0xe9, sp)
      008ACC 0F EA            [ 1] 1610 	clr	(0xea, sp)
      008ACE 0F EB            [ 1] 1611 	clr	(0xeb, sp)
      008AD0 0F EC            [ 1] 1612 	clr	(0xec, sp)
      008AD2 0F ED            [ 1] 1613 	clr	(0xed, sp)
      008AD4 0F EE            [ 1] 1614 	clr	(0xee, sp)
      008AD6 0F EF            [ 1] 1615 	clr	(0xef, sp)
      008AD8 0F F0            [ 1] 1616 	clr	(0xf0, sp)
      008ADA 0F F1            [ 1] 1617 	clr	(0xf1, sp)
      008ADC 0F F2            [ 1] 1618 	clr	(0xf2, sp)
      008ADE 0F F3            [ 1] 1619 	clr	(0xf3, sp)
      008AE0 0F F4            [ 1] 1620 	clr	(0xf4, sp)
      008AE2 0F F5            [ 1] 1621 	clr	(0xf5, sp)
      008AE4 0F F6            [ 1] 1622 	clr	(0xf6, sp)
      008AE6 0F F7            [ 1] 1623 	clr	(0xf7, sp)
      008AE8 0F F8            [ 1] 1624 	clr	(0xf8, sp)
      008AEA 0F F9            [ 1] 1625 	clr	(0xf9, sp)
      008AEC 0F FA            [ 1] 1626 	clr	(0xfa, sp)
      008AEE 0F FB            [ 1] 1627 	clr	(0xfb, sp)
      008AF0 0F FC            [ 1] 1628 	clr	(0xfc, sp)
      008AF2 0F FD            [ 1] 1629 	clr	(0xfd, sp)
      008AF4 0F FE            [ 1] 1630 	clr	(0xfe, sp)
      008AF6 0F FF            [ 1] 1631 	clr	(0xff, sp)
      008AF8 90 6F 0D         [ 1] 1632 	clr	(0xd, y)
      008AFB 90 6F 0E         [ 1] 1633 	clr	(0xe, y)
      008AFE 90 6F 0F         [ 1] 1634 	clr	(0xf, y)
      008B01 90 6F 10         [ 1] 1635 	clr	(0x10, y)
      008B04 90 6F 11         [ 1] 1636 	clr	(0x11, y)
      008B07 90 6F 12         [ 1] 1637 	clr	(0x12, y)
      008B0A 90 6F 13         [ 1] 1638 	clr	(0x13, y)
      008B0D 90 6F 14         [ 1] 1639 	clr	(0x14, y)
      008B10 90 6F 15         [ 1] 1640 	clr	(0x15, y)
      008B13 90 6F 16         [ 1] 1641 	clr	(0x16, y)
      008B16 90 6F 17         [ 1] 1642 	clr	(0x17, y)
      008B19 90 6F 18         [ 1] 1643 	clr	(0x18, y)
      008B1C 90 6F 19         [ 1] 1644 	clr	(0x19, y)
      008B1F 90 6F 1A         [ 1] 1645 	clr	(0x1a, y)
      008B22 90 6F 1B         [ 1] 1646 	clr	(0x1b, y)
      008B25 90 6F 1C         [ 1] 1647 	clr	(0x1c, y)
      008B28 90 6F 1D         [ 1] 1648 	clr	(0x1d, y)
      008B2B 90 6F 1E         [ 1] 1649 	clr	(0x1e, y)
      008B2E 90 6F 1F         [ 1] 1650 	clr	(0x1f, y)
      008B31 90 6F 20         [ 1] 1651 	clr	(0x20, y)
      008B34 90 6F 21         [ 1] 1652 	clr	(0x21, y)
      008B37 90 6F 22         [ 1] 1653 	clr	(0x22, y)
      008B3A 90 6F 23         [ 1] 1654 	clr	(0x23, y)
      008B3D 90 6F 24         [ 1] 1655 	clr	(0x24, y)
      008B40 90 6F 25         [ 1] 1656 	clr	(0x25, y)
      008B43 90 6F 26         [ 1] 1657 	clr	(0x26, y)
      008B46 90 6F 27         [ 1] 1658 	clr	(0x27, y)
      008B49 90 6F 28         [ 1] 1659 	clr	(0x28, y)
      008B4C 90 6F 29         [ 1] 1660 	clr	(0x29, y)
      008B4F 90 6F 2A         [ 1] 1661 	clr	(0x2a, y)
      008B52 90 6F 2B         [ 1] 1662 	clr	(0x2b, y)
      008B55 90 6F 2C         [ 1] 1663 	clr	(0x2c, y)
      008B58 90 6F 2D         [ 1] 1664 	clr	(0x2d, y)
      008B5B 90 6F 2E         [ 1] 1665 	clr	(0x2e, y)
      008B5E 90 6F 2F         [ 1] 1666 	clr	(0x2f, y)
      008B61 90 6F 30         [ 1] 1667 	clr	(0x30, y)
      008B64 90 6F 31         [ 1] 1668 	clr	(0x31, y)
      008B67 90 6F 32         [ 1] 1669 	clr	(0x32, y)
      008B6A 90 6F 33         [ 1] 1670 	clr	(0x33, y)
      008B6D 90 6F 34         [ 1] 1671 	clr	(0x34, y)
      008B70 90 6F 35         [ 1] 1672 	clr	(0x35, y)
      008B73 90 6F 36         [ 1] 1673 	clr	(0x36, y)
      008B76 90 6F 37         [ 1] 1674 	clr	(0x37, y)
      008B79 90 6F 38         [ 1] 1675 	clr	(0x38, y)
      008B7C 90 6F 39         [ 1] 1676 	clr	(0x39, y)
      008B7F 90 6F 3A         [ 1] 1677 	clr	(0x3a, y)
      008B82 90 6F 3B         [ 1] 1678 	clr	(0x3b, y)
      008B85 90 6F 3C         [ 1] 1679 	clr	(0x3c, y)
      008B88 90 6F 3D         [ 1] 1680 	clr	(0x3d, y)
      008B8B 90 6F 3E         [ 1] 1681 	clr	(0x3e, y)
      008B8E 90 6F 3F         [ 1] 1682 	clr	(0x3f, y)
      008B91 90 6F 40         [ 1] 1683 	clr	(0x40, y)
      008B94 90 6F 41         [ 1] 1684 	clr	(0x41, y)
      008B97 90 6F 42         [ 1] 1685 	clr	(0x42, y)
      008B9A 90 6F 43         [ 1] 1686 	clr	(0x43, y)
      008B9D 90 6F 44         [ 1] 1687 	clr	(0x44, y)
      008BA0 90 6F 45         [ 1] 1688 	clr	(0x45, y)
      008BA3 90 6F 46         [ 1] 1689 	clr	(0x46, y)
      008BA6 90 6F 47         [ 1] 1690 	clr	(0x47, y)
      008BA9 90 6F 48         [ 1] 1691 	clr	(0x48, y)
      008BAC 90 6F 49         [ 1] 1692 	clr	(0x49, y)
      008BAF 90 6F 4A         [ 1] 1693 	clr	(0x4a, y)
      008BB2 90 6F 4B         [ 1] 1694 	clr	(0x4b, y)
      008BB5 90 6F 4C         [ 1] 1695 	clr	(0x4c, y)
      008BB8 90 6F 4D         [ 1] 1696 	clr	(0x4d, y)
      008BBB 90 6F 4E         [ 1] 1697 	clr	(0x4e, y)
      008BBE 90 6F 4F         [ 1] 1698 	clr	(0x4f, y)
      008BC1 90 6F 50         [ 1] 1699 	clr	(0x50, y)
      008BC4 90 6F 51         [ 1] 1700 	clr	(0x51, y)
      008BC7 90 6F 52         [ 1] 1701 	clr	(0x52, y)
      008BCA 90 6F 53         [ 1] 1702 	clr	(0x53, y)
      008BCD 90 6F 54         [ 1] 1703 	clr	(0x54, y)
      008BD0 90 6F 55         [ 1] 1704 	clr	(0x55, y)
      008BD3 90 6F 56         [ 1] 1705 	clr	(0x56, y)
      008BD6 90 6F 57         [ 1] 1706 	clr	(0x57, y)
      008BD9 90 6F 58         [ 1] 1707 	clr	(0x58, y)
      008BDC 90 6F 59         [ 1] 1708 	clr	(0x59, y)
      008BDF 90 6F 5A         [ 1] 1709 	clr	(0x5a, y)
      008BE2 90 6F 5B         [ 1] 1710 	clr	(0x5b, y)
      008BE5 90 6F 5C         [ 1] 1711 	clr	(0x5c, y)
      008BE8 90 6F 5D         [ 1] 1712 	clr	(0x5d, y)
      008BEB 90 6F 5E         [ 1] 1713 	clr	(0x5e, y)
      008BEE 90 6F 5F         [ 1] 1714 	clr	(0x5f, y)
      008BF1 90 6F 60         [ 1] 1715 	clr	(0x60, y)
      008BF4 90 6F 61         [ 1] 1716 	clr	(0x61, y)
      008BF7 90 6F 62         [ 1] 1717 	clr	(0x62, y)
      008BFA 90 6F 63         [ 1] 1718 	clr	(0x63, y)
      008BFD 90 6F 64         [ 1] 1719 	clr	(0x64, y)
      008C00 90 6F 65         [ 1] 1720 	clr	(0x65, y)
      008C03 90 6F 66         [ 1] 1721 	clr	(0x66, y)
      008C06 90 6F 67         [ 1] 1722 	clr	(0x67, y)
      008C09 90 6F 68         [ 1] 1723 	clr	(0x68, y)
      008C0C 90 6F 69         [ 1] 1724 	clr	(0x69, y)
      008C0F 90 6F 6A         [ 1] 1725 	clr	(0x6a, y)
      008C12 90 6F 6B         [ 1] 1726 	clr	(0x6b, y)
      008C15 90 6F 6C         [ 1] 1727 	clr	(0x6c, y)
      008C18 90 6F 6D         [ 1] 1728 	clr	(0x6d, y)
      008C1B 90 6F 6E         [ 1] 1729 	clr	(0x6e, y)
      008C1E 90 6F 6F         [ 1] 1730 	clr	(0x6f, y)
      008C21 90 6F 70         [ 1] 1731 	clr	(0x70, y)
      008C24 90 6F 71         [ 1] 1732 	clr	(0x71, y)
      008C27 90 6F 72         [ 1] 1733 	clr	(0x72, y)
      008C2A 90 6F 73         [ 1] 1734 	clr	(0x73, y)
      008C2D 90 6F 74         [ 1] 1735 	clr	(0x74, y)
      008C30 90 6F 75         [ 1] 1736 	clr	(0x75, y)
      008C33 90 6F 76         [ 1] 1737 	clr	(0x76, y)
      008C36 90 6F 77         [ 1] 1738 	clr	(0x77, y)
      008C39 90 6F 78         [ 1] 1739 	clr	(0x78, y)
      008C3C 90 6F 79         [ 1] 1740 	clr	(0x79, y)
      008C3F 90 6F 7A         [ 1] 1741 	clr	(0x7a, y)
      008C42 90 6F 7B         [ 1] 1742 	clr	(0x7b, y)
      008C45 90 6F 7C         [ 1] 1743 	clr	(0x7c, y)
      008C48 90 6F 7D         [ 1] 1744 	clr	(0x7d, y)
      008C4B 90 6F 7E         [ 1] 1745 	clr	(0x7e, y)
      008C4E 90 6F 7F         [ 1] 1746 	clr	(0x7f, y)
      008C51 90 6F 80         [ 1] 1747 	clr	(0x80, y)
      008C54 90 6F 81         [ 1] 1748 	clr	(0x81, y)
      008C57 90 6F 82         [ 1] 1749 	clr	(0x82, y)
      008C5A 90 6F 83         [ 1] 1750 	clr	(0x83, y)
      008C5D 90 6F 84         [ 1] 1751 	clr	(0x84, y)
      008C60 90 6F 85         [ 1] 1752 	clr	(0x85, y)
      008C63 90 6F 86         [ 1] 1753 	clr	(0x86, y)
      008C66 90 6F 87         [ 1] 1754 	clr	(0x87, y)
      008C69 90 6F 88         [ 1] 1755 	clr	(0x88, y)
      008C6C 90 6F 89         [ 1] 1756 	clr	(0x89, y)
      008C6F 90 6F 8A         [ 1] 1757 	clr	(0x8a, y)
      008C72 90 6F 8B         [ 1] 1758 	clr	(0x8b, y)
      008C75 90 6F 8C         [ 1] 1759 	clr	(0x8c, y)
      008C78 90 6F 8D         [ 1] 1760 	clr	(0x8d, y)
      008C7B 90 6F 8E         [ 1] 1761 	clr	(0x8e, y)
      008C7E 90 6F 8F         [ 1] 1762 	clr	(0x8f, y)
      008C81 90 6F 90         [ 1] 1763 	clr	(0x90, y)
      008C84 90 6F 91         [ 1] 1764 	clr	(0x91, y)
      008C87 90 6F 92         [ 1] 1765 	clr	(0x92, y)
      008C8A 90 6F 93         [ 1] 1766 	clr	(0x93, y)
      008C8D 90 6F 94         [ 1] 1767 	clr	(0x94, y)
      008C90 90 6F 95         [ 1] 1768 	clr	(0x95, y)
      008C93 90 6F 96         [ 1] 1769 	clr	(0x96, y)
      008C96 90 6F 97         [ 1] 1770 	clr	(0x97, y)
      008C99 90 6F 98         [ 1] 1771 	clr	(0x98, y)
      008C9C 90 6F 99         [ 1] 1772 	clr	(0x99, y)
      008C9F 90 6F 9A         [ 1] 1773 	clr	(0x9a, y)
      008CA2 90 6F 9B         [ 1] 1774 	clr	(0x9b, y)
      008CA5 90 6F 9C         [ 1] 1775 	clr	(0x9c, y)
      008CA8 90 6F 9D         [ 1] 1776 	clr	(0x9d, y)
      008CAB 90 6F 9E         [ 1] 1777 	clr	(0x9e, y)
      008CAE 90 6F 9F         [ 1] 1778 	clr	(0x9f, y)
      008CB1 90 6F A0         [ 1] 1779 	clr	(0xa0, y)
      008CB4 90 6F A1         [ 1] 1780 	clr	(0xa1, y)
      008CB7 90 6F A2         [ 1] 1781 	clr	(0xa2, y)
      008CBA 90 6F A3         [ 1] 1782 	clr	(0xa3, y)
      008CBD 90 6F A4         [ 1] 1783 	clr	(0xa4, y)
      008CC0 90 6F A5         [ 1] 1784 	clr	(0xa5, y)
      008CC3 90 6F A6         [ 1] 1785 	clr	(0xa6, y)
      008CC6 90 6F A7         [ 1] 1786 	clr	(0xa7, y)
      008CC9 90 6F A8         [ 1] 1787 	clr	(0xa8, y)
      008CCC 90 6F A9         [ 1] 1788 	clr	(0xa9, y)
      008CCF 90 6F AA         [ 1] 1789 	clr	(0xaa, y)
      008CD2 90 6F AB         [ 1] 1790 	clr	(0xab, y)
      008CD5 90 6F AC         [ 1] 1791 	clr	(0xac, y)
      008CD8 90 6F AD         [ 1] 1792 	clr	(0xad, y)
      008CDB 90 6F AE         [ 1] 1793 	clr	(0xae, y)
      008CDE 90 6F AF         [ 1] 1794 	clr	(0xaf, y)
      008CE1 90 6F B0         [ 1] 1795 	clr	(0xb0, y)
      008CE4 90 6F B1         [ 1] 1796 	clr	(0xb1, y)
      008CE7 90 6F B2         [ 1] 1797 	clr	(0xb2, y)
      008CEA 90 6F B3         [ 1] 1798 	clr	(0xb3, y)
      008CED 90 6F B4         [ 1] 1799 	clr	(0xb4, y)
      008CF0 90 6F B5         [ 1] 1800 	clr	(0xb5, y)
      008CF3 90 6F B6         [ 1] 1801 	clr	(0xb6, y)
      008CF6 90 6F B7         [ 1] 1802 	clr	(0xb7, y)
      008CF9 90 6F B8         [ 1] 1803 	clr	(0xb8, y)
      008CFC 90 6F B9         [ 1] 1804 	clr	(0xb9, y)
      008CFF 90 6F BA         [ 1] 1805 	clr	(0xba, y)
      008D02 90 6F BB         [ 1] 1806 	clr	(0xbb, y)
      008D05 90 6F BC         [ 1] 1807 	clr	(0xbc, y)
      008D08 90 6F BD         [ 1] 1808 	clr	(0xbd, y)
      008D0B 90 6F BE         [ 1] 1809 	clr	(0xbe, y)
      008D0E 90 6F BF         [ 1] 1810 	clr	(0xbf, y)
      008D11 90 6F C0         [ 1] 1811 	clr	(0xc0, y)
      008D14 90 6F C1         [ 1] 1812 	clr	(0xc1, y)
      008D17 90 6F C2         [ 1] 1813 	clr	(0xc2, y)
      008D1A 90 6F C3         [ 1] 1814 	clr	(0xc3, y)
      008D1D 90 6F C4         [ 1] 1815 	clr	(0xc4, y)
      008D20 90 6F C5         [ 1] 1816 	clr	(0xc5, y)
      008D23 90 6F C6         [ 1] 1817 	clr	(0xc6, y)
      008D26 90 6F C7         [ 1] 1818 	clr	(0xc7, y)
      008D29 90 6F C8         [ 1] 1819 	clr	(0xc8, y)
      008D2C 90 6F C9         [ 1] 1820 	clr	(0xc9, y)
      008D2F 90 6F CA         [ 1] 1821 	clr	(0xca, y)
      008D32 90 6F CB         [ 1] 1822 	clr	(0xcb, y)
      008D35 90 6F CC         [ 1] 1823 	clr	(0xcc, y)
      008D38 90 6F CD         [ 1] 1824 	clr	(0xcd, y)
      008D3B 90 6F CE         [ 1] 1825 	clr	(0xce, y)
      008D3E 90 6F CF         [ 1] 1826 	clr	(0xcf, y)
      008D41 90 6F D0         [ 1] 1827 	clr	(0xd0, y)
      008D44 90 6F D1         [ 1] 1828 	clr	(0xd1, y)
      008D47 90 6F D2         [ 1] 1829 	clr	(0xd2, y)
      008D4A 90 6F D3         [ 1] 1830 	clr	(0xd3, y)
      008D4D 90 6F D4         [ 1] 1831 	clr	(0xd4, y)
      008D50 90 6F D5         [ 1] 1832 	clr	(0xd5, y)
      008D53 90 6F D6         [ 1] 1833 	clr	(0xd6, y)
      008D56 90 6F D7         [ 1] 1834 	clr	(0xd7, y)
      008D59 90 6F D8         [ 1] 1835 	clr	(0xd8, y)
      008D5C 90 6F D9         [ 1] 1836 	clr	(0xd9, y)
      008D5F 90 6F DA         [ 1] 1837 	clr	(0xda, y)
      008D62 90 6F DB         [ 1] 1838 	clr	(0xdb, y)
      008D65 90 6F DC         [ 1] 1839 	clr	(0xdc, y)
      008D68 90 6F DD         [ 1] 1840 	clr	(0xdd, y)
      008D6B 90 6F DE         [ 1] 1841 	clr	(0xde, y)
      008D6E 90 6F DF         [ 1] 1842 	clr	(0xdf, y)
      008D71 90 6F E0         [ 1] 1843 	clr	(0xe0, y)
      008D74 90 6F E1         [ 1] 1844 	clr	(0xe1, y)
      008D77 90 6F E2         [ 1] 1845 	clr	(0xe2, y)
      008D7A 90 6F E3         [ 1] 1846 	clr	(0xe3, y)
      008D7D 90 6F E4         [ 1] 1847 	clr	(0xe4, y)
      008D80 90 6F E5         [ 1] 1848 	clr	(0xe5, y)
      008D83 90 6F E6         [ 1] 1849 	clr	(0xe6, y)
      008D86 90 6F E7         [ 1] 1850 	clr	(0xe7, y)
      008D89 90 6F E8         [ 1] 1851 	clr	(0xe8, y)
      008D8C 90 6F E9         [ 1] 1852 	clr	(0xe9, y)
      008D8F 90 6F EA         [ 1] 1853 	clr	(0xea, y)
      008D92 90 6F EB         [ 1] 1854 	clr	(0xeb, y)
      008D95 90 6F EC         [ 1] 1855 	clr	(0xec, y)
      008D98 90 6F ED         [ 1] 1856 	clr	(0xed, y)
      008D9B 90 6F EE         [ 1] 1857 	clr	(0xee, y)
      008D9E 90 6F EF         [ 1] 1858 	clr	(0xef, y)
      008DA1 90 6F F0         [ 1] 1859 	clr	(0xf0, y)
      008DA4 90 6F F1         [ 1] 1860 	clr	(0xf1, y)
      008DA7 90 6F F2         [ 1] 1861 	clr	(0xf2, y)
      008DAA 90 6F F3         [ 1] 1862 	clr	(0xf3, y)
      008DAD 90 6F F4         [ 1] 1863 	clr	(0xf4, y)
      008DB0 90 6F F5         [ 1] 1864 	clr	(0xf5, y)
      008DB3 90 6F F6         [ 1] 1865 	clr	(0xf6, y)
      008DB6 90 6F F7         [ 1] 1866 	clr	(0xf7, y)
      008DB9 90 6F F8         [ 1] 1867 	clr	(0xf8, y)
      008DBC 90 6F F9         [ 1] 1868 	clr	(0xf9, y)
      008DBF 90 6F FA         [ 1] 1869 	clr	(0xfa, y)
      008DC2 90 6F FB         [ 1] 1870 	clr	(0xfb, y)
      008DC5 90 6F FC         [ 1] 1871 	clr	(0xfc, y)
      008DC8 90 6F FD         [ 1] 1872 	clr	(0xfd, y)
      008DCB 90 6F FE         [ 1] 1873 	clr	(0xfe, y)
      008DCE 90 6F FF         [ 1] 1874 	clr	(0xff, y)
      008DD1 90 4F 01 00      [ 1] 1875 	clr	(0x100, y)
      008DD5 90 4F 01 01      [ 1] 1876 	clr	(0x101, y)
      008DD9 90 4F 01 02      [ 1] 1877 	clr	(0x102, y)
      008DDD 90 4F 01 03      [ 1] 1878 	clr	(0x103, y)
      008DE1 90 4F 01 04      [ 1] 1879 	clr	(0x104, y)
      008DE5 90 4F 01 05      [ 1] 1880 	clr	(0x105, y)
      008DE9 90 4F 01 06      [ 1] 1881 	clr	(0x106, y)
      008DED 90 4F 01 07      [ 1] 1882 	clr	(0x107, y)
      008DF1 90 4F 01 08      [ 1] 1883 	clr	(0x108, y)
      008DF5 90 4F 01 09      [ 1] 1884 	clr	(0x109, y)
      008DF9 90 4F 01 0A      [ 1] 1885 	clr	(0x10a, y)
      008DFD 90 4F 01 0B      [ 1] 1886 	clr	(0x10b, y)
      008E01 90 4F 01 0C      [ 1] 1887 	clr	(0x10c, y)
      008E05 90 4F 01 0D      [ 1] 1888 	clr	(0x10d, y)
                                   1889 ;	main.c: 130: display_buffer_fill(0,0,splash,buffer,128,32,WHITE);
      008E09 90 89            [ 2] 1890 	pushw	y
      008E0B 4B 01            [ 1] 1891 	push	#0x01
      008E0D 4B 20            [ 1] 1892 	push	#0x20
      008E0F 4B 80            [ 1] 1893 	push	#0x80
      008E11 96               [ 1] 1894 	ldw	x, sp
      008E12 1C 00 06         [ 2] 1895 	addw	x, #6
      008E15 89               [ 2] 1896 	pushw	x
      008E16 4B 08            [ 1] 1897 	push	#<(_splash+0)
      008E18 4B 00            [ 1] 1898 	push	#((_splash+0) >> 8)
      008E1A 4B 00            [ 1] 1899 	push	#0x00
      008E1C 4F               [ 1] 1900 	clr	a
      008E1D CD 87 49         [ 4] 1901 	call	_display_buffer_fill
      008E20 90 85            [ 2] 1902 	popw	y
                                   1903 ;	main.c: 132: }
      008E22 5B FF            [ 2] 1904 	addw	sp, #255
      008E24 5B FF            [ 2] 1905 	addw	sp, #255
      008E26 5B 02            [ 2] 1906 	addw	sp, #2
      008E28 81               [ 4] 1907 	ret
                                   1908 ;	main.c: 134: int main(void)
                                   1909 ;	-----------------------------------------
                                   1910 ;	 function main
                                   1911 ;	-----------------------------------------
      008E29                       1912 _main:
                                   1913 ;	main.c: 136: setup();
      008E29 CD 85 D3         [ 4] 1914 	call	_setup
                                   1915 ;	main.c: 137: gg();
      008E2C CD 88 E6         [ 4] 1916 	call	_gg
                                   1917 ;	main.c: 138: while(1);
      008E2F                       1918 00102$:
      008E2F 20 FE            [ 2] 1919 	jra	00102$
                                   1920 ;	main.c: 139: }
      008E31 81               [ 4] 1921 	ret
                                   1922 ;	main.c: 155: void display_splash(void)
                                   1923 ;	-----------------------------------------
                                   1924 ;	 function display_splash
                                   1925 ;	-----------------------------------------
      008E32                       1926 _display_splash:
      008E32 52 14            [ 2] 1927 	sub	sp, #20
                                   1928 ;	main.c: 157: uint8_t black_buf[9] = {0x40};
      008E34 A6 40            [ 1] 1929 	ld	a, #0x40
      008E36 6B 01            [ 1] 1930 	ld	(0x01, sp), a
      008E38 0F 02            [ 1] 1931 	clr	(0x02, sp)
      008E3A 0F 03            [ 1] 1932 	clr	(0x03, sp)
      008E3C 0F 04            [ 1] 1933 	clr	(0x04, sp)
      008E3E 0F 05            [ 1] 1934 	clr	(0x05, sp)
      008E40 0F 06            [ 1] 1935 	clr	(0x06, sp)
      008E42 0F 07            [ 1] 1936 	clr	(0x07, sp)
      008E44 0F 08            [ 1] 1937 	clr	(0x08, sp)
      008E46 0F 09            [ 1] 1938 	clr	(0x09, sp)
                                   1939 ;	main.c: 158: uint8_t white_buf[9] = {0x40};
      008E48 A6 40            [ 1] 1940 	ld	a, #0x40
      008E4A 6B 0A            [ 1] 1941 	ld	(0x0a, sp), a
      008E4C 0F 0B            [ 1] 1942 	clr	(0x0b, sp)
      008E4E 0F 0C            [ 1] 1943 	clr	(0x0c, sp)
      008E50 0F 0D            [ 1] 1944 	clr	(0x0d, sp)
      008E52 0F 0E            [ 1] 1945 	clr	(0x0e, sp)
      008E54 0F 0F            [ 1] 1946 	clr	(0x0f, sp)
      008E56 0F 10            [ 1] 1947 	clr	(0x10, sp)
      008E58 0F 11            [ 1] 1948 	clr	(0x11, sp)
      008E5A 0F 12            [ 1] 1949 	clr	(0x12, sp)
                                   1950 ;	main.c: 159: for(int i = 1;i<9;i++)
      008E5C 5F               [ 1] 1951 	clrw	x
      008E5D 5C               [ 1] 1952 	incw	x
      008E5E 1F 13            [ 2] 1953 	ldw	(0x13, sp), x
      008E60                       1954 00103$:
      008E60 1E 13            [ 2] 1955 	ldw	x, (0x13, sp)
      008E62 A3 00 09         [ 2] 1956 	cpw	x, #0x0009
      008E65 2E 11            [ 1] 1957 	jrsge	00101$
                                   1958 ;	main.c: 160: white_buf[i] = 0xFF;
      008E67 96               [ 1] 1959 	ldw	x, sp
      008E68 1C 00 0A         [ 2] 1960 	addw	x, #10
      008E6B 72 FB 13         [ 2] 1961 	addw	x, (0x13, sp)
      008E6E A6 FF            [ 1] 1962 	ld	a, #0xff
      008E70 F7               [ 1] 1963 	ld	(x), a
                                   1964 ;	main.c: 159: for(int i = 1;i<9;i++)
      008E71 1E 13            [ 2] 1965 	ldw	x, (0x13, sp)
      008E73 5C               [ 1] 1966 	incw	x
      008E74 1F 13            [ 2] 1967 	ldw	(0x13, sp), x
      008E76 20 E8            [ 2] 1968 	jra	00103$
      008E78                       1969 00101$:
                                   1970 ;	main.c: 161: display_set_params_to_write();
      008E78 CD 86 D2         [ 4] 1971 	call	_display_set_params_to_write
                                   1972 ;	main.c: 162: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008E7B 96               [ 1] 1973 	ldw	x, sp
      008E7C 5C               [ 1] 1974 	incw	x
      008E7D 89               [ 2] 1975 	pushw	x
      008E7E 4B 09            [ 1] 1976 	push	#0x09
      008E80 A6 3C            [ 1] 1977 	ld	a, #0x3c
      008E82 CD 85 70         [ 4] 1978 	call	_i2c_write
                                   1979 ;	main.c: 163: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008E85 96               [ 1] 1980 	ldw	x, sp
      008E86 5C               [ 1] 1981 	incw	x
      008E87 89               [ 2] 1982 	pushw	x
      008E88 4B 09            [ 1] 1983 	push	#0x09
      008E8A A6 3C            [ 1] 1984 	ld	a, #0x3c
      008E8C CD 85 70         [ 4] 1985 	call	_i2c_write
                                   1986 ;	main.c: 164: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008E8F 96               [ 1] 1987 	ldw	x, sp
      008E90 1C 00 0A         [ 2] 1988 	addw	x, #10
      008E93 89               [ 2] 1989 	pushw	x
      008E94 4B 09            [ 1] 1990 	push	#0x09
      008E96 A6 3C            [ 1] 1991 	ld	a, #0x3c
      008E98 CD 85 70         [ 4] 1992 	call	_i2c_write
                                   1993 ;	main.c: 165: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008E9B 96               [ 1] 1994 	ldw	x, sp
      008E9C 5C               [ 1] 1995 	incw	x
      008E9D 89               [ 2] 1996 	pushw	x
      008E9E 4B 09            [ 1] 1997 	push	#0x09
      008EA0 A6 3C            [ 1] 1998 	ld	a, #0x3c
      008EA2 CD 85 70         [ 4] 1999 	call	_i2c_write
                                   2000 ;	main.c: 166: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008EA5 96               [ 1] 2001 	ldw	x, sp
      008EA6 1C 00 0A         [ 2] 2002 	addw	x, #10
      008EA9 89               [ 2] 2003 	pushw	x
      008EAA 4B 09            [ 1] 2004 	push	#0x09
      008EAC A6 3C            [ 1] 2005 	ld	a, #0x3c
      008EAE CD 85 70         [ 4] 2006 	call	_i2c_write
                                   2007 ;	main.c: 167: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008EB1 96               [ 1] 2008 	ldw	x, sp
      008EB2 1C 00 0A         [ 2] 2009 	addw	x, #10
      008EB5 89               [ 2] 2010 	pushw	x
      008EB6 4B 09            [ 1] 2011 	push	#0x09
      008EB8 A6 3C            [ 1] 2012 	ld	a, #0x3c
      008EBA CD 85 70         [ 4] 2013 	call	_i2c_write
                                   2014 ;	main.c: 168: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008EBD 96               [ 1] 2015 	ldw	x, sp
      008EBE 1C 00 0A         [ 2] 2016 	addw	x, #10
      008EC1 89               [ 2] 2017 	pushw	x
      008EC2 4B 09            [ 1] 2018 	push	#0x09
      008EC4 A6 3C            [ 1] 2019 	ld	a, #0x3c
      008EC6 CD 85 70         [ 4] 2020 	call	_i2c_write
                                   2021 ;	main.c: 169: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008EC9 96               [ 1] 2022 	ldw	x, sp
      008ECA 1C 00 0A         [ 2] 2023 	addw	x, #10
      008ECD 89               [ 2] 2024 	pushw	x
      008ECE 4B 09            [ 1] 2025 	push	#0x09
      008ED0 A6 3C            [ 1] 2026 	ld	a, #0x3c
      008ED2 CD 85 70         [ 4] 2027 	call	_i2c_write
                                   2028 ;	main.c: 170: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008ED5 96               [ 1] 2029 	ldw	x, sp
      008ED6 1C 00 0A         [ 2] 2030 	addw	x, #10
      008ED9 89               [ 2] 2031 	pushw	x
      008EDA 4B 09            [ 1] 2032 	push	#0x09
      008EDC A6 3C            [ 1] 2033 	ld	a, #0x3c
      008EDE CD 85 70         [ 4] 2034 	call	_i2c_write
                                   2035 ;	main.c: 171: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008EE1 96               [ 1] 2036 	ldw	x, sp
      008EE2 5C               [ 1] 2037 	incw	x
      008EE3 89               [ 2] 2038 	pushw	x
      008EE4 4B 09            [ 1] 2039 	push	#0x09
      008EE6 A6 3C            [ 1] 2040 	ld	a, #0x3c
      008EE8 CD 85 70         [ 4] 2041 	call	_i2c_write
                                   2042 ;	main.c: 172: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008EEB 96               [ 1] 2043 	ldw	x, sp
      008EEC 1C 00 0A         [ 2] 2044 	addw	x, #10
      008EEF 89               [ 2] 2045 	pushw	x
      008EF0 4B 09            [ 1] 2046 	push	#0x09
      008EF2 A6 3C            [ 1] 2047 	ld	a, #0x3c
      008EF4 CD 85 70         [ 4] 2048 	call	_i2c_write
                                   2049 ;	main.c: 173: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008EF7 96               [ 1] 2050 	ldw	x, sp
      008EF8 1C 00 0A         [ 2] 2051 	addw	x, #10
      008EFB 89               [ 2] 2052 	pushw	x
      008EFC 4B 09            [ 1] 2053 	push	#0x09
      008EFE A6 3C            [ 1] 2054 	ld	a, #0x3c
      008F00 CD 85 70         [ 4] 2055 	call	_i2c_write
                                   2056 ;	main.c: 174: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F03 96               [ 1] 2057 	ldw	x, sp
      008F04 1C 00 0A         [ 2] 2058 	addw	x, #10
      008F07 89               [ 2] 2059 	pushw	x
      008F08 4B 09            [ 1] 2060 	push	#0x09
      008F0A A6 3C            [ 1] 2061 	ld	a, #0x3c
      008F0C CD 85 70         [ 4] 2062 	call	_i2c_write
                                   2063 ;	main.c: 175: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F0F 96               [ 1] 2064 	ldw	x, sp
      008F10 5C               [ 1] 2065 	incw	x
      008F11 89               [ 2] 2066 	pushw	x
      008F12 4B 09            [ 1] 2067 	push	#0x09
      008F14 A6 3C            [ 1] 2068 	ld	a, #0x3c
      008F16 CD 85 70         [ 4] 2069 	call	_i2c_write
                                   2070 ;	main.c: 176: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F19 96               [ 1] 2071 	ldw	x, sp
      008F1A 5C               [ 1] 2072 	incw	x
      008F1B 89               [ 2] 2073 	pushw	x
      008F1C 4B 09            [ 1] 2074 	push	#0x09
      008F1E A6 3C            [ 1] 2075 	ld	a, #0x3c
      008F20 CD 85 70         [ 4] 2076 	call	_i2c_write
                                   2077 ;	main.c: 177: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F23 96               [ 1] 2078 	ldw	x, sp
      008F24 5C               [ 1] 2079 	incw	x
      008F25 89               [ 2] 2080 	pushw	x
      008F26 4B 09            [ 1] 2081 	push	#0x09
      008F28 A6 3C            [ 1] 2082 	ld	a, #0x3c
      008F2A CD 85 70         [ 4] 2083 	call	_i2c_write
                                   2084 ;	main.c: 179: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F2D 96               [ 1] 2085 	ldw	x, sp
      008F2E 5C               [ 1] 2086 	incw	x
      008F2F 89               [ 2] 2087 	pushw	x
      008F30 4B 09            [ 1] 2088 	push	#0x09
      008F32 A6 3C            [ 1] 2089 	ld	a, #0x3c
      008F34 CD 85 70         [ 4] 2090 	call	_i2c_write
                                   2091 ;	main.c: 180: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F37 96               [ 1] 2092 	ldw	x, sp
      008F38 5C               [ 1] 2093 	incw	x
      008F39 89               [ 2] 2094 	pushw	x
      008F3A 4B 09            [ 1] 2095 	push	#0x09
      008F3C A6 3C            [ 1] 2096 	ld	a, #0x3c
      008F3E CD 85 70         [ 4] 2097 	call	_i2c_write
                                   2098 ;	main.c: 181: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F41 96               [ 1] 2099 	ldw	x, sp
      008F42 1C 00 0A         [ 2] 2100 	addw	x, #10
      008F45 89               [ 2] 2101 	pushw	x
      008F46 4B 09            [ 1] 2102 	push	#0x09
      008F48 A6 3C            [ 1] 2103 	ld	a, #0x3c
      008F4A CD 85 70         [ 4] 2104 	call	_i2c_write
                                   2105 ;	main.c: 182: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F4D 96               [ 1] 2106 	ldw	x, sp
      008F4E 1C 00 0A         [ 2] 2107 	addw	x, #10
      008F51 89               [ 2] 2108 	pushw	x
      008F52 4B 09            [ 1] 2109 	push	#0x09
      008F54 A6 3C            [ 1] 2110 	ld	a, #0x3c
      008F56 CD 85 70         [ 4] 2111 	call	_i2c_write
                                   2112 ;	main.c: 183: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F59 96               [ 1] 2113 	ldw	x, sp
      008F5A 1C 00 0A         [ 2] 2114 	addw	x, #10
      008F5D 89               [ 2] 2115 	pushw	x
      008F5E 4B 09            [ 1] 2116 	push	#0x09
      008F60 A6 3C            [ 1] 2117 	ld	a, #0x3c
      008F62 CD 85 70         [ 4] 2118 	call	_i2c_write
                                   2119 ;	main.c: 184: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F65 96               [ 1] 2120 	ldw	x, sp
      008F66 5C               [ 1] 2121 	incw	x
      008F67 89               [ 2] 2122 	pushw	x
      008F68 4B 09            [ 1] 2123 	push	#0x09
      008F6A A6 3C            [ 1] 2124 	ld	a, #0x3c
      008F6C CD 85 70         [ 4] 2125 	call	_i2c_write
                                   2126 ;	main.c: 185: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F6F 96               [ 1] 2127 	ldw	x, sp
      008F70 1C 00 0A         [ 2] 2128 	addw	x, #10
      008F73 89               [ 2] 2129 	pushw	x
      008F74 4B 09            [ 1] 2130 	push	#0x09
      008F76 A6 3C            [ 1] 2131 	ld	a, #0x3c
      008F78 CD 85 70         [ 4] 2132 	call	_i2c_write
                                   2133 ;	main.c: 186: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F7B 96               [ 1] 2134 	ldw	x, sp
      008F7C 5C               [ 1] 2135 	incw	x
      008F7D 89               [ 2] 2136 	pushw	x
      008F7E 4B 09            [ 1] 2137 	push	#0x09
      008F80 A6 3C            [ 1] 2138 	ld	a, #0x3c
      008F82 CD 85 70         [ 4] 2139 	call	_i2c_write
                                   2140 ;	main.c: 187: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F85 96               [ 1] 2141 	ldw	x, sp
      008F86 1C 00 0A         [ 2] 2142 	addw	x, #10
      008F89 89               [ 2] 2143 	pushw	x
      008F8A 4B 09            [ 1] 2144 	push	#0x09
      008F8C A6 3C            [ 1] 2145 	ld	a, #0x3c
      008F8E CD 85 70         [ 4] 2146 	call	_i2c_write
                                   2147 ;	main.c: 188: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008F91 96               [ 1] 2148 	ldw	x, sp
      008F92 5C               [ 1] 2149 	incw	x
      008F93 89               [ 2] 2150 	pushw	x
      008F94 4B 09            [ 1] 2151 	push	#0x09
      008F96 A6 3C            [ 1] 2152 	ld	a, #0x3c
      008F98 CD 85 70         [ 4] 2153 	call	_i2c_write
                                   2154 ;	main.c: 189: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008F9B 96               [ 1] 2155 	ldw	x, sp
      008F9C 1C 00 0A         [ 2] 2156 	addw	x, #10
      008F9F 89               [ 2] 2157 	pushw	x
      008FA0 4B 09            [ 1] 2158 	push	#0x09
      008FA2 A6 3C            [ 1] 2159 	ld	a, #0x3c
      008FA4 CD 85 70         [ 4] 2160 	call	_i2c_write
                                   2161 ;	main.c: 190: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FA7 96               [ 1] 2162 	ldw	x, sp
      008FA8 5C               [ 1] 2163 	incw	x
      008FA9 89               [ 2] 2164 	pushw	x
      008FAA 4B 09            [ 1] 2165 	push	#0x09
      008FAC A6 3C            [ 1] 2166 	ld	a, #0x3c
      008FAE CD 85 70         [ 4] 2167 	call	_i2c_write
                                   2168 ;	main.c: 191: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008FB1 96               [ 1] 2169 	ldw	x, sp
      008FB2 1C 00 0A         [ 2] 2170 	addw	x, #10
      008FB5 89               [ 2] 2171 	pushw	x
      008FB6 4B 09            [ 1] 2172 	push	#0x09
      008FB8 A6 3C            [ 1] 2173 	ld	a, #0x3c
      008FBA CD 85 70         [ 4] 2174 	call	_i2c_write
                                   2175 ;	main.c: 192: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FBD 96               [ 1] 2176 	ldw	x, sp
      008FBE 5C               [ 1] 2177 	incw	x
      008FBF 89               [ 2] 2178 	pushw	x
      008FC0 4B 09            [ 1] 2179 	push	#0x09
      008FC2 A6 3C            [ 1] 2180 	ld	a, #0x3c
      008FC4 CD 85 70         [ 4] 2181 	call	_i2c_write
                                   2182 ;	main.c: 193: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FC7 96               [ 1] 2183 	ldw	x, sp
      008FC8 5C               [ 1] 2184 	incw	x
      008FC9 89               [ 2] 2185 	pushw	x
      008FCA 4B 09            [ 1] 2186 	push	#0x09
      008FCC A6 3C            [ 1] 2187 	ld	a, #0x3c
      008FCE CD 85 70         [ 4] 2188 	call	_i2c_write
                                   2189 ;	main.c: 194: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FD1 96               [ 1] 2190 	ldw	x, sp
      008FD2 5C               [ 1] 2191 	incw	x
      008FD3 89               [ 2] 2192 	pushw	x
      008FD4 4B 09            [ 1] 2193 	push	#0x09
      008FD6 A6 3C            [ 1] 2194 	ld	a, #0x3c
      008FD8 CD 85 70         [ 4] 2195 	call	_i2c_write
                                   2196 ;	main.c: 196: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FDB 96               [ 1] 2197 	ldw	x, sp
      008FDC 5C               [ 1] 2198 	incw	x
      008FDD 89               [ 2] 2199 	pushw	x
      008FDE 4B 09            [ 1] 2200 	push	#0x09
      008FE0 A6 3C            [ 1] 2201 	ld	a, #0x3c
      008FE2 CD 85 70         [ 4] 2202 	call	_i2c_write
                                   2203 ;	main.c: 197: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FE5 96               [ 1] 2204 	ldw	x, sp
      008FE6 5C               [ 1] 2205 	incw	x
      008FE7 89               [ 2] 2206 	pushw	x
      008FE8 4B 09            [ 1] 2207 	push	#0x09
      008FEA A6 3C            [ 1] 2208 	ld	a, #0x3c
      008FEC CD 85 70         [ 4] 2209 	call	_i2c_write
                                   2210 ;	main.c: 198: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      008FEF 96               [ 1] 2211 	ldw	x, sp
      008FF0 1C 00 0A         [ 2] 2212 	addw	x, #10
      008FF3 89               [ 2] 2213 	pushw	x
      008FF4 4B 09            [ 1] 2214 	push	#0x09
      008FF6 A6 3C            [ 1] 2215 	ld	a, #0x3c
      008FF8 CD 85 70         [ 4] 2216 	call	_i2c_write
                                   2217 ;	main.c: 199: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      008FFB 96               [ 1] 2218 	ldw	x, sp
      008FFC 5C               [ 1] 2219 	incw	x
      008FFD 89               [ 2] 2220 	pushw	x
      008FFE 4B 09            [ 1] 2221 	push	#0x09
      009000 A6 3C            [ 1] 2222 	ld	a, #0x3c
      009002 CD 85 70         [ 4] 2223 	call	_i2c_write
                                   2224 ;	main.c: 200: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      009005 96               [ 1] 2225 	ldw	x, sp
      009006 1C 00 0A         [ 2] 2226 	addw	x, #10
      009009 89               [ 2] 2227 	pushw	x
      00900A 4B 09            [ 1] 2228 	push	#0x09
      00900C A6 3C            [ 1] 2229 	ld	a, #0x3c
      00900E CD 85 70         [ 4] 2230 	call	_i2c_write
                                   2231 ;	main.c: 201: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009011 96               [ 1] 2232 	ldw	x, sp
      009012 5C               [ 1] 2233 	incw	x
      009013 89               [ 2] 2234 	pushw	x
      009014 4B 09            [ 1] 2235 	push	#0x09
      009016 A6 3C            [ 1] 2236 	ld	a, #0x3c
      009018 CD 85 70         [ 4] 2237 	call	_i2c_write
                                   2238 ;	main.c: 202: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      00901B 96               [ 1] 2239 	ldw	x, sp
      00901C 1C 00 0A         [ 2] 2240 	addw	x, #10
      00901F 89               [ 2] 2241 	pushw	x
      009020 4B 09            [ 1] 2242 	push	#0x09
      009022 A6 3C            [ 1] 2243 	ld	a, #0x3c
      009024 CD 85 70         [ 4] 2244 	call	_i2c_write
                                   2245 ;	main.c: 203: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009027 96               [ 1] 2246 	ldw	x, sp
      009028 5C               [ 1] 2247 	incw	x
      009029 89               [ 2] 2248 	pushw	x
      00902A 4B 09            [ 1] 2249 	push	#0x09
      00902C A6 3C            [ 1] 2250 	ld	a, #0x3c
      00902E CD 85 70         [ 4] 2251 	call	_i2c_write
                                   2252 ;	main.c: 204: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      009031 96               [ 1] 2253 	ldw	x, sp
      009032 1C 00 0A         [ 2] 2254 	addw	x, #10
      009035 89               [ 2] 2255 	pushw	x
      009036 4B 09            [ 1] 2256 	push	#0x09
      009038 A6 3C            [ 1] 2257 	ld	a, #0x3c
      00903A CD 85 70         [ 4] 2258 	call	_i2c_write
                                   2259 ;	main.c: 205: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      00903D 96               [ 1] 2260 	ldw	x, sp
      00903E 1C 00 0A         [ 2] 2261 	addw	x, #10
      009041 89               [ 2] 2262 	pushw	x
      009042 4B 09            [ 1] 2263 	push	#0x09
      009044 A6 3C            [ 1] 2264 	ld	a, #0x3c
      009046 CD 85 70         [ 4] 2265 	call	_i2c_write
                                   2266 ;	main.c: 206: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      009049 96               [ 1] 2267 	ldw	x, sp
      00904A 1C 00 0A         [ 2] 2268 	addw	x, #10
      00904D 89               [ 2] 2269 	pushw	x
      00904E 4B 09            [ 1] 2270 	push	#0x09
      009050 A6 3C            [ 1] 2271 	ld	a, #0x3c
      009052 CD 85 70         [ 4] 2272 	call	_i2c_write
                                   2273 ;	main.c: 207: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      009055 96               [ 1] 2274 	ldw	x, sp
      009056 1C 00 0A         [ 2] 2275 	addw	x, #10
      009059 89               [ 2] 2276 	pushw	x
      00905A 4B 09            [ 1] 2277 	push	#0x09
      00905C A6 3C            [ 1] 2278 	ld	a, #0x3c
      00905E CD 85 70         [ 4] 2279 	call	_i2c_write
                                   2280 ;	main.c: 208: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009061 96               [ 1] 2281 	ldw	x, sp
      009062 5C               [ 1] 2282 	incw	x
      009063 89               [ 2] 2283 	pushw	x
      009064 4B 09            [ 1] 2284 	push	#0x09
      009066 A6 3C            [ 1] 2285 	ld	a, #0x3c
      009068 CD 85 70         [ 4] 2286 	call	_i2c_write
                                   2287 ;	main.c: 209: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      00906B 96               [ 1] 2288 	ldw	x, sp
      00906C 5C               [ 1] 2289 	incw	x
      00906D 89               [ 2] 2290 	pushw	x
      00906E 4B 09            [ 1] 2291 	push	#0x09
      009070 A6 3C            [ 1] 2292 	ld	a, #0x3c
      009072 CD 85 70         [ 4] 2293 	call	_i2c_write
                                   2294 ;	main.c: 210: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009075 96               [ 1] 2295 	ldw	x, sp
      009076 5C               [ 1] 2296 	incw	x
      009077 89               [ 2] 2297 	pushw	x
      009078 4B 09            [ 1] 2298 	push	#0x09
      00907A A6 3C            [ 1] 2299 	ld	a, #0x3c
      00907C CD 85 70         [ 4] 2300 	call	_i2c_write
                                   2301 ;	main.c: 211: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      00907F 96               [ 1] 2302 	ldw	x, sp
      009080 5C               [ 1] 2303 	incw	x
      009081 89               [ 2] 2304 	pushw	x
      009082 4B 09            [ 1] 2305 	push	#0x09
      009084 A6 3C            [ 1] 2306 	ld	a, #0x3c
      009086 CD 85 70         [ 4] 2307 	call	_i2c_write
                                   2308 ;	main.c: 213: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009089 96               [ 1] 2309 	ldw	x, sp
      00908A 5C               [ 1] 2310 	incw	x
      00908B 89               [ 2] 2311 	pushw	x
      00908C 4B 09            [ 1] 2312 	push	#0x09
      00908E A6 3C            [ 1] 2313 	ld	a, #0x3c
      009090 CD 85 70         [ 4] 2314 	call	_i2c_write
                                   2315 ;	main.c: 214: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009093 96               [ 1] 2316 	ldw	x, sp
      009094 5C               [ 1] 2317 	incw	x
      009095 89               [ 2] 2318 	pushw	x
      009096 4B 09            [ 1] 2319 	push	#0x09
      009098 A6 3C            [ 1] 2320 	ld	a, #0x3c
      00909A CD 85 70         [ 4] 2321 	call	_i2c_write
                                   2322 ;	main.c: 215: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      00909D 96               [ 1] 2323 	ldw	x, sp
      00909E 1C 00 0A         [ 2] 2324 	addw	x, #10
      0090A1 89               [ 2] 2325 	pushw	x
      0090A2 4B 09            [ 1] 2326 	push	#0x09
      0090A4 A6 3C            [ 1] 2327 	ld	a, #0x3c
      0090A6 CD 85 70         [ 4] 2328 	call	_i2c_write
                                   2329 ;	main.c: 216: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      0090A9 96               [ 1] 2330 	ldw	x, sp
      0090AA 5C               [ 1] 2331 	incw	x
      0090AB 89               [ 2] 2332 	pushw	x
      0090AC 4B 09            [ 1] 2333 	push	#0x09
      0090AE A6 3C            [ 1] 2334 	ld	a, #0x3c
      0090B0 CD 85 70         [ 4] 2335 	call	_i2c_write
                                   2336 ;	main.c: 217: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      0090B3 96               [ 1] 2337 	ldw	x, sp
      0090B4 1C 00 0A         [ 2] 2338 	addw	x, #10
      0090B7 89               [ 2] 2339 	pushw	x
      0090B8 4B 09            [ 1] 2340 	push	#0x09
      0090BA A6 3C            [ 1] 2341 	ld	a, #0x3c
      0090BC CD 85 70         [ 4] 2342 	call	_i2c_write
                                   2343 ;	main.c: 218: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      0090BF 96               [ 1] 2344 	ldw	x, sp
      0090C0 5C               [ 1] 2345 	incw	x
      0090C1 89               [ 2] 2346 	pushw	x
      0090C2 4B 09            [ 1] 2347 	push	#0x09
      0090C4 A6 3C            [ 1] 2348 	ld	a, #0x3c
      0090C6 CD 85 70         [ 4] 2349 	call	_i2c_write
                                   2350 ;	main.c: 219: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      0090C9 96               [ 1] 2351 	ldw	x, sp
      0090CA 1C 00 0A         [ 2] 2352 	addw	x, #10
      0090CD 89               [ 2] 2353 	pushw	x
      0090CE 4B 09            [ 1] 2354 	push	#0x09
      0090D0 A6 3C            [ 1] 2355 	ld	a, #0x3c
      0090D2 CD 85 70         [ 4] 2356 	call	_i2c_write
                                   2357 ;	main.c: 220: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      0090D5 96               [ 1] 2358 	ldw	x, sp
      0090D6 5C               [ 1] 2359 	incw	x
      0090D7 89               [ 2] 2360 	pushw	x
      0090D8 4B 09            [ 1] 2361 	push	#0x09
      0090DA A6 3C            [ 1] 2362 	ld	a, #0x3c
      0090DC CD 85 70         [ 4] 2363 	call	_i2c_write
                                   2364 ;	main.c: 221: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      0090DF 96               [ 1] 2365 	ldw	x, sp
      0090E0 1C 00 0A         [ 2] 2366 	addw	x, #10
      0090E3 89               [ 2] 2367 	pushw	x
      0090E4 4B 09            [ 1] 2368 	push	#0x09
      0090E6 A6 3C            [ 1] 2369 	ld	a, #0x3c
      0090E8 CD 85 70         [ 4] 2370 	call	_i2c_write
                                   2371 ;	main.c: 222: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      0090EB 96               [ 1] 2372 	ldw	x, sp
      0090EC 5C               [ 1] 2373 	incw	x
      0090ED 89               [ 2] 2374 	pushw	x
      0090EE 4B 09            [ 1] 2375 	push	#0x09
      0090F0 A6 3C            [ 1] 2376 	ld	a, #0x3c
      0090F2 CD 85 70         [ 4] 2377 	call	_i2c_write
                                   2378 ;	main.c: 223: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      0090F5 96               [ 1] 2379 	ldw	x, sp
      0090F6 1C 00 0A         [ 2] 2380 	addw	x, #10
      0090F9 89               [ 2] 2381 	pushw	x
      0090FA 4B 09            [ 1] 2382 	push	#0x09
      0090FC A6 3C            [ 1] 2383 	ld	a, #0x3c
      0090FE CD 85 70         [ 4] 2384 	call	_i2c_write
                                   2385 ;	main.c: 224: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009101 96               [ 1] 2386 	ldw	x, sp
      009102 5C               [ 1] 2387 	incw	x
      009103 89               [ 2] 2388 	pushw	x
      009104 4B 09            [ 1] 2389 	push	#0x09
      009106 A6 3C            [ 1] 2390 	ld	a, #0x3c
      009108 CD 85 70         [ 4] 2391 	call	_i2c_write
                                   2392 ;	main.c: 225: i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
      00910B 96               [ 1] 2393 	ldw	x, sp
      00910C 1C 00 0A         [ 2] 2394 	addw	x, #10
      00910F 89               [ 2] 2395 	pushw	x
      009110 4B 09            [ 1] 2396 	push	#0x09
      009112 A6 3C            [ 1] 2397 	ld	a, #0x3c
      009114 CD 85 70         [ 4] 2398 	call	_i2c_write
                                   2399 ;	main.c: 226: i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
      009117 96               [ 1] 2400 	ldw	x, sp
      009118 5C               [ 1] 2401 	incw	x
      009119 89               [ 2] 2402 	pushw	x
      00911A 4B 09            [ 1] 2403 	push	#0x09
      00911C A6 3C            [ 1] 2404 	ld	a, #0x3c
      00911E CD 85 70         [ 4] 2405 	call	_i2c_write
                                   2406 ;	main.c: 229: }
      009121 5B 14            [ 2] 2407 	addw	sp, #20
      009123 81               [ 4] 2408 	ret
                                   2409 	.area CODE
                                   2410 	.area CONST
                                   2411 	.area CONST
      00807D                       2412 ___str_0:
      00807D 72 78 5F 62 75 66 5F  2413 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808B 0A                    2414 	.db 0x0a
      00808C 00                    2415 	.db 0x00
                                   2416 	.area CODE
                                   2417 	.area CONST
      00808D                       2418 ___str_1:
      00808D 62 75 66 5F 70 6F 73  2419 	.ascii "buf_pos"
      008094 0A                    2420 	.db 0x0a
      008095 00                    2421 	.db 0x00
                                   2422 	.area CODE
                                   2423 	.area CONST
      008096                       2424 ___str_2:
      008096 62 75 66 5F 73 69 7A  2425 	.ascii "buf_size"
             65
      00809E 0A                    2426 	.db 0x0a
      00809F 00                    2427 	.db 0x00
                                   2428 	.area CODE
                                   2429 	.area CONST
      0080A0                       2430 ___str_3:
      0080A0 52 49 45 4E           2431 	.ascii "RIEN"
      0080A4 0A                    2432 	.db 0x0a
      0080A5 00                    2433 	.db 0x00
                                   2434 	.area CODE
                                   2435 	.area INITIALIZER
      0080A6                       2436 __xinit__I2C_IRQ:
      0080A6 00                    2437 	.db #0x00	; 0
      0080A7                       2438 __xinit__splash:
      0080A7 FF                    2439 	.db #0xff	; 255
      0080A8 00                    2440 	.db #0x00	; 0
      0080A9 FF                    2441 	.db #0xff	; 255
      0080AA 00                    2442 	.db #0x00	; 0
      0080AB 00                    2443 	.db #0x00	; 0
      0080AC 00                    2444 	.db #0x00	; 0
      0080AD 00                    2445 	.db #0x00	; 0
      0080AE 00                    2446 	.db #0x00	; 0
      0080AF 00                    2447 	.db #0x00	; 0
      0080B0 00                    2448 	.db #0x00	; 0
      0080B1 00                    2449 	.db #0x00	; 0
      0080B2 00                    2450 	.db #0x00	; 0
      0080B3 00                    2451 	.db #0x00	; 0
      0080B4 00                    2452 	.db #0x00	; 0
      0080B5 00                    2453 	.db #0x00	; 0
      0080B6 00                    2454 	.db #0x00	; 0
      0080B7 00                    2455 	.db #0x00	; 0
      0080B8 00                    2456 	.db #0x00	; 0
      0080B9 00                    2457 	.db #0x00	; 0
      0080BA 00                    2458 	.db #0x00	; 0
      0080BB 00                    2459 	.db #0x00	; 0
      0080BC 00                    2460 	.db #0x00	; 0
      0080BD 00                    2461 	.db #0x00	; 0
      0080BE 00                    2462 	.db #0x00	; 0
      0080BF 00                    2463 	.db #0x00	; 0
      0080C0 00                    2464 	.db #0x00	; 0
      0080C1 00                    2465 	.db #0x00	; 0
      0080C2 00                    2466 	.db #0x00	; 0
      0080C3 00                    2467 	.db #0x00	; 0
      0080C4 00                    2468 	.db #0x00	; 0
      0080C5 00                    2469 	.db #0x00	; 0
      0080C6 00                    2470 	.db #0x00	; 0
      0080C7 00                    2471 	.db #0x00	; 0
      0080C8 00                    2472 	.db #0x00	; 0
      0080C9 00                    2473 	.db #0x00	; 0
      0080CA 00                    2474 	.db #0x00	; 0
      0080CB 00                    2475 	.db #0x00	; 0
      0080CC 00                    2476 	.db #0x00	; 0
      0080CD 00                    2477 	.db #0x00	; 0
      0080CE 00                    2478 	.db #0x00	; 0
      0080CF 00                    2479 	.db #0x00	; 0
      0080D0 00                    2480 	.db #0x00	; 0
      0080D1 00                    2481 	.db #0x00	; 0
      0080D2 00                    2482 	.db #0x00	; 0
      0080D3 00                    2483 	.db #0x00	; 0
      0080D4 00                    2484 	.db #0x00	; 0
      0080D5 00                    2485 	.db #0x00	; 0
      0080D6 00                    2486 	.db #0x00	; 0
      0080D7 00                    2487 	.db #0x00	; 0
      0080D8 00                    2488 	.db #0x00	; 0
      0080D9 00                    2489 	.db #0x00	; 0
      0080DA 00                    2490 	.db #0x00	; 0
      0080DB 00                    2491 	.db #0x00	; 0
      0080DC 00                    2492 	.db #0x00	; 0
      0080DD 00                    2493 	.db #0x00	; 0
      0080DE 00                    2494 	.db #0x00	; 0
      0080DF 00                    2495 	.db #0x00	; 0
      0080E0 00                    2496 	.db #0x00	; 0
      0080E1 00                    2497 	.db #0x00	; 0
      0080E2 00                    2498 	.db #0x00	; 0
      0080E3 00                    2499 	.db #0x00	; 0
      0080E4 00                    2500 	.db #0x00	; 0
      0080E5 00                    2501 	.db #0x00	; 0
      0080E6 00                    2502 	.db #0x00	; 0
      0080E7 00                    2503 	.db #0x00	; 0
      0080E8 00                    2504 	.db #0x00	; 0
      0080E9 00                    2505 	.db #0x00	; 0
      0080EA 00                    2506 	.db #0x00	; 0
      0080EB 00                    2507 	.db #0x00	; 0
      0080EC 00                    2508 	.db #0x00	; 0
      0080ED 00                    2509 	.db #0x00	; 0
      0080EE 00                    2510 	.db #0x00	; 0
      0080EF 00                    2511 	.db #0x00	; 0
      0080F0 00                    2512 	.db #0x00	; 0
      0080F1 00                    2513 	.db #0x00	; 0
      0080F2 00                    2514 	.db #0x00	; 0
      0080F3 00                    2515 	.db #0x00	; 0
      0080F4 00                    2516 	.db #0x00	; 0
      0080F5 00                    2517 	.db #0x00	; 0
      0080F6 00                    2518 	.db #0x00	; 0
      0080F7 00                    2519 	.db #0x00	; 0
      0080F8 00                    2520 	.db #0x00	; 0
      0080F9 00                    2521 	.db #0x00	; 0
      0080FA 00                    2522 	.db #0x00	; 0
      0080FB 00                    2523 	.db #0x00	; 0
      0080FC 00                    2524 	.db #0x00	; 0
      0080FD 00                    2525 	.db #0x00	; 0
      0080FE 00                    2526 	.db #0x00	; 0
      0080FF 00                    2527 	.db #0x00	; 0
      008100 00                    2528 	.db #0x00	; 0
      008101 00                    2529 	.db #0x00	; 0
      008102 00                    2530 	.db #0x00	; 0
      008103 00                    2531 	.db #0x00	; 0
      008104 00                    2532 	.db #0x00	; 0
      008105 00                    2533 	.db #0x00	; 0
      008106 00                    2534 	.db #0x00	; 0
      008107 00                    2535 	.db #0x00	; 0
      008108 00                    2536 	.db #0x00	; 0
      008109 00                    2537 	.db #0x00	; 0
      00810A 00                    2538 	.db #0x00	; 0
      00810B 00                    2539 	.db #0x00	; 0
      00810C 00                    2540 	.db #0x00	; 0
      00810D 00                    2541 	.db #0x00	; 0
      00810E 00                    2542 	.db #0x00	; 0
      00810F 00                    2543 	.db #0x00	; 0
      008110 00                    2544 	.db #0x00	; 0
      008111 00                    2545 	.db #0x00	; 0
      008112 00                    2546 	.db #0x00	; 0
      008113 00                    2547 	.db #0x00	; 0
      008114 00                    2548 	.db #0x00	; 0
      008115 00                    2549 	.db #0x00	; 0
      008116 00                    2550 	.db #0x00	; 0
      008117 00                    2551 	.db #0x00	; 0
      008118 00                    2552 	.db #0x00	; 0
      008119 00                    2553 	.db #0x00	; 0
      00811A 00                    2554 	.db #0x00	; 0
      00811B 00                    2555 	.db #0x00	; 0
      00811C 00                    2556 	.db #0x00	; 0
      00811D 00                    2557 	.db #0x00	; 0
      00811E 00                    2558 	.db #0x00	; 0
      00811F 00                    2559 	.db #0x00	; 0
      008120 00                    2560 	.db #0x00	; 0
      008121 00                    2561 	.db #0x00	; 0
      008122 00                    2562 	.db #0x00	; 0
      008123 00                    2563 	.db #0x00	; 0
      008124 00                    2564 	.db #0x00	; 0
      008125 00                    2565 	.db #0x00	; 0
      008126 00                    2566 	.db #0x00	; 0
      008127 00                    2567 	.db #0x00	; 0
      008128 00                    2568 	.db #0x00	; 0
      008129 00                    2569 	.db #0x00	; 0
      00812A 00                    2570 	.db #0x00	; 0
      00812B 00                    2571 	.db #0x00	; 0
      00812C 00                    2572 	.db #0x00	; 0
      00812D 00                    2573 	.db #0x00	; 0
      00812E 00                    2574 	.db #0x00	; 0
      00812F 00                    2575 	.db #0x00	; 0
      008130 00                    2576 	.db #0x00	; 0
      008131 00                    2577 	.db #0x00	; 0
      008132 00                    2578 	.db #0x00	; 0
      008133 00                    2579 	.db #0x00	; 0
      008134 00                    2580 	.db #0x00	; 0
      008135 00                    2581 	.db #0x00	; 0
      008136 00                    2582 	.db #0x00	; 0
      008137 00                    2583 	.db #0x00	; 0
      008138 00                    2584 	.db #0x00	; 0
      008139 00                    2585 	.db #0x00	; 0
      00813A 00                    2586 	.db #0x00	; 0
      00813B 00                    2587 	.db #0x00	; 0
      00813C 00                    2588 	.db #0x00	; 0
      00813D 00                    2589 	.db #0x00	; 0
      00813E 00                    2590 	.db #0x00	; 0
      00813F 00                    2591 	.db #0x00	; 0
      008140 00                    2592 	.db #0x00	; 0
      008141 00                    2593 	.db #0x00	; 0
      008142 00                    2594 	.db #0x00	; 0
      008143 00                    2595 	.db #0x00	; 0
      008144 00                    2596 	.db #0x00	; 0
      008145 00                    2597 	.db #0x00	; 0
      008146 00                    2598 	.db #0x00	; 0
      008147 00                    2599 	.db #0x00	; 0
      008148 00                    2600 	.db #0x00	; 0
      008149 00                    2601 	.db #0x00	; 0
      00814A 00                    2602 	.db #0x00	; 0
      00814B 00                    2603 	.db #0x00	; 0
      00814C 00                    2604 	.db #0x00	; 0
      00814D 00                    2605 	.db #0x00	; 0
      00814E 00                    2606 	.db #0x00	; 0
      00814F 00                    2607 	.db #0x00	; 0
      008150 00                    2608 	.db #0x00	; 0
      008151 00                    2609 	.db #0x00	; 0
      008152 00                    2610 	.db #0x00	; 0
      008153 00                    2611 	.db #0x00	; 0
      008154 00                    2612 	.db #0x00	; 0
      008155 00                    2613 	.db #0x00	; 0
      008156 00                    2614 	.db #0x00	; 0
      008157 00                    2615 	.db #0x00	; 0
      008158 00                    2616 	.db #0x00	; 0
      008159 00                    2617 	.db #0x00	; 0
      00815A 00                    2618 	.db #0x00	; 0
      00815B 00                    2619 	.db #0x00	; 0
      00815C 00                    2620 	.db #0x00	; 0
      00815D 00                    2621 	.db #0x00	; 0
      00815E 00                    2622 	.db #0x00	; 0
      00815F 00                    2623 	.db #0x00	; 0
      008160 00                    2624 	.db #0x00	; 0
      008161 00                    2625 	.db #0x00	; 0
      008162 00                    2626 	.db #0x00	; 0
      008163 00                    2627 	.db #0x00	; 0
      008164 00                    2628 	.db #0x00	; 0
      008165 00                    2629 	.db #0x00	; 0
      008166 00                    2630 	.db #0x00	; 0
      008167 00                    2631 	.db #0x00	; 0
      008168 00                    2632 	.db #0x00	; 0
      008169 00                    2633 	.db #0x00	; 0
      00816A 00                    2634 	.db #0x00	; 0
      00816B 00                    2635 	.db #0x00	; 0
      00816C 00                    2636 	.db #0x00	; 0
      00816D 00                    2637 	.db #0x00	; 0
      00816E 00                    2638 	.db #0x00	; 0
      00816F 00                    2639 	.db #0x00	; 0
      008170 00                    2640 	.db #0x00	; 0
      008171 00                    2641 	.db #0x00	; 0
      008172 00                    2642 	.db #0x00	; 0
      008173 00                    2643 	.db #0x00	; 0
      008174 00                    2644 	.db #0x00	; 0
      008175 00                    2645 	.db #0x00	; 0
      008176 00                    2646 	.db #0x00	; 0
      008177 00                    2647 	.db #0x00	; 0
      008178 00                    2648 	.db #0x00	; 0
      008179 00                    2649 	.db #0x00	; 0
      00817A 00                    2650 	.db #0x00	; 0
      00817B 00                    2651 	.db #0x00	; 0
      00817C 00                    2652 	.db #0x00	; 0
      00817D 00                    2653 	.db #0x00	; 0
      00817E 00                    2654 	.db #0x00	; 0
      00817F 00                    2655 	.db #0x00	; 0
      008180 00                    2656 	.db #0x00	; 0
      008181 00                    2657 	.db #0x00	; 0
      008182 00                    2658 	.db #0x00	; 0
      008183 00                    2659 	.db #0x00	; 0
      008184 00                    2660 	.db #0x00	; 0
      008185 00                    2661 	.db #0x00	; 0
      008186 00                    2662 	.db #0x00	; 0
      008187 00                    2663 	.db #0x00	; 0
      008188 00                    2664 	.db #0x00	; 0
      008189 00                    2665 	.db #0x00	; 0
      00818A 00                    2666 	.db #0x00	; 0
      00818B 00                    2667 	.db #0x00	; 0
      00818C 00                    2668 	.db #0x00	; 0
      00818D 00                    2669 	.db #0x00	; 0
      00818E 00                    2670 	.db #0x00	; 0
      00818F 00                    2671 	.db #0x00	; 0
      008190 00                    2672 	.db #0x00	; 0
      008191 00                    2673 	.db #0x00	; 0
      008192 00                    2674 	.db #0x00	; 0
      008193 00                    2675 	.db #0x00	; 0
      008194 00                    2676 	.db #0x00	; 0
      008195 00                    2677 	.db #0x00	; 0
      008196 00                    2678 	.db #0x00	; 0
      008197 00                    2679 	.db #0x00	; 0
      008198 00                    2680 	.db #0x00	; 0
      008199 00                    2681 	.db #0x00	; 0
      00819A 00                    2682 	.db #0x00	; 0
      00819B 00                    2683 	.db #0x00	; 0
      00819C 00                    2684 	.db #0x00	; 0
      00819D 00                    2685 	.db #0x00	; 0
      00819E 00                    2686 	.db #0x00	; 0
      00819F 00                    2687 	.db #0x00	; 0
      0081A0 00                    2688 	.db #0x00	; 0
      0081A1 00                    2689 	.db #0x00	; 0
      0081A2 00                    2690 	.db #0x00	; 0
      0081A3 00                    2691 	.db #0x00	; 0
      0081A4 00                    2692 	.db #0x00	; 0
      0081A5 00                    2693 	.db #0x00	; 0
      0081A6 00                    2694 	.db #0x00	; 0
      0081A7 00                    2695 	.db #0x00	; 0
      0081A8 00                    2696 	.db #0x00	; 0
      0081A9 00                    2697 	.db #0x00	; 0
      0081AA 00                    2698 	.db #0x00	; 0
      0081AB 00                    2699 	.db #0x00	; 0
      0081AC 00                    2700 	.db #0x00	; 0
      0081AD 00                    2701 	.db #0x00	; 0
      0081AE 00                    2702 	.db #0x00	; 0
      0081AF 00                    2703 	.db #0x00	; 0
      0081B0 00                    2704 	.db #0x00	; 0
      0081B1 00                    2705 	.db #0x00	; 0
      0081B2 00                    2706 	.db #0x00	; 0
      0081B3 00                    2707 	.db #0x00	; 0
      0081B4 00                    2708 	.db #0x00	; 0
      0081B5 00                    2709 	.db #0x00	; 0
      0081B6 00                    2710 	.db #0x00	; 0
      0081B7 00                    2711 	.db #0x00	; 0
      0081B8 00                    2712 	.db #0x00	; 0
      0081B9 00                    2713 	.db #0x00	; 0
      0081BA 00                    2714 	.db #0x00	; 0
      0081BB 00                    2715 	.db #0x00	; 0
      0081BC 00                    2716 	.db #0x00	; 0
      0081BD 00                    2717 	.db #0x00	; 0
      0081BE 00                    2718 	.db #0x00	; 0
      0081BF 00                    2719 	.db #0x00	; 0
      0081C0 00                    2720 	.db #0x00	; 0
      0081C1 00                    2721 	.db #0x00	; 0
      0081C2 00                    2722 	.db #0x00	; 0
      0081C3 00                    2723 	.db #0x00	; 0
      0081C4 00                    2724 	.db #0x00	; 0
      0081C5 00                    2725 	.db #0x00	; 0
      0081C6 00                    2726 	.db #0x00	; 0
      0081C7 00                    2727 	.db #0x00	; 0
      0081C8 00                    2728 	.db #0x00	; 0
      0081C9 00                    2729 	.db #0x00	; 0
      0081CA 00                    2730 	.db #0x00	; 0
      0081CB 00                    2731 	.db #0x00	; 0
      0081CC 00                    2732 	.db #0x00	; 0
      0081CD 00                    2733 	.db #0x00	; 0
      0081CE 00                    2734 	.db #0x00	; 0
      0081CF 00                    2735 	.db #0x00	; 0
      0081D0 00                    2736 	.db #0x00	; 0
      0081D1 00                    2737 	.db #0x00	; 0
      0081D2 00                    2738 	.db #0x00	; 0
      0081D3 00                    2739 	.db #0x00	; 0
      0081D4 00                    2740 	.db #0x00	; 0
      0081D5 00                    2741 	.db #0x00	; 0
      0081D6 00                    2742 	.db #0x00	; 0
      0081D7 00                    2743 	.db #0x00	; 0
      0081D8 00                    2744 	.db #0x00	; 0
      0081D9 00                    2745 	.db #0x00	; 0
      0081DA 00                    2746 	.db #0x00	; 0
      0081DB 00                    2747 	.db #0x00	; 0
      0081DC 00                    2748 	.db #0x00	; 0
      0081DD 00                    2749 	.db #0x00	; 0
      0081DE 00                    2750 	.db #0x00	; 0
      0081DF 00                    2751 	.db #0x00	; 0
      0081E0 00                    2752 	.db #0x00	; 0
      0081E1 00                    2753 	.db #0x00	; 0
      0081E2 00                    2754 	.db #0x00	; 0
      0081E3 00                    2755 	.db #0x00	; 0
      0081E4 00                    2756 	.db #0x00	; 0
      0081E5 00                    2757 	.db #0x00	; 0
      0081E6 00                    2758 	.db #0x00	; 0
      0081E7 00                    2759 	.db #0x00	; 0
      0081E8 00                    2760 	.db #0x00	; 0
      0081E9 00                    2761 	.db #0x00	; 0
      0081EA 00                    2762 	.db #0x00	; 0
      0081EB 00                    2763 	.db #0x00	; 0
      0081EC 00                    2764 	.db #0x00	; 0
      0081ED 00                    2765 	.db #0x00	; 0
      0081EE 00                    2766 	.db #0x00	; 0
      0081EF 00                    2767 	.db #0x00	; 0
      0081F0 00                    2768 	.db #0x00	; 0
      0081F1 00                    2769 	.db #0x00	; 0
      0081F2 00                    2770 	.db #0x00	; 0
      0081F3 00                    2771 	.db #0x00	; 0
      0081F4 00                    2772 	.db #0x00	; 0
      0081F5 00                    2773 	.db #0x00	; 0
      0081F6 00                    2774 	.db #0x00	; 0
      0081F7 00                    2775 	.db #0x00	; 0
      0081F8 00                    2776 	.db #0x00	; 0
      0081F9 00                    2777 	.db #0x00	; 0
      0081FA 00                    2778 	.db #0x00	; 0
      0081FB 00                    2779 	.db #0x00	; 0
      0081FC 00                    2780 	.db #0x00	; 0
      0081FD 00                    2781 	.db #0x00	; 0
      0081FE 00                    2782 	.db #0x00	; 0
      0081FF 00                    2783 	.db #0x00	; 0
      008200 00                    2784 	.db #0x00	; 0
      008201 00                    2785 	.db #0x00	; 0
      008202 00                    2786 	.db #0x00	; 0
      008203 00                    2787 	.db #0x00	; 0
      008204 00                    2788 	.db #0x00	; 0
      008205 00                    2789 	.db #0x00	; 0
      008206 00                    2790 	.db #0x00	; 0
      008207 00                    2791 	.db #0x00	; 0
      008208 00                    2792 	.db #0x00	; 0
      008209 00                    2793 	.db #0x00	; 0
      00820A 00                    2794 	.db #0x00	; 0
      00820B 00                    2795 	.db #0x00	; 0
      00820C 00                    2796 	.db #0x00	; 0
      00820D 00                    2797 	.db #0x00	; 0
      00820E 00                    2798 	.db #0x00	; 0
      00820F 00                    2799 	.db #0x00	; 0
      008210 00                    2800 	.db #0x00	; 0
      008211 00                    2801 	.db #0x00	; 0
      008212 00                    2802 	.db #0x00	; 0
      008213 00                    2803 	.db #0x00	; 0
      008214 00                    2804 	.db #0x00	; 0
      008215 00                    2805 	.db #0x00	; 0
      008216 00                    2806 	.db #0x00	; 0
      008217 00                    2807 	.db #0x00	; 0
      008218 00                    2808 	.db #0x00	; 0
      008219 00                    2809 	.db #0x00	; 0
      00821A 00                    2810 	.db #0x00	; 0
      00821B 00                    2811 	.db #0x00	; 0
      00821C 00                    2812 	.db #0x00	; 0
      00821D 00                    2813 	.db #0x00	; 0
      00821E 00                    2814 	.db #0x00	; 0
      00821F 00                    2815 	.db #0x00	; 0
      008220 00                    2816 	.db #0x00	; 0
      008221 00                    2817 	.db #0x00	; 0
      008222 00                    2818 	.db #0x00	; 0
      008223 00                    2819 	.db #0x00	; 0
      008224 00                    2820 	.db #0x00	; 0
      008225 00                    2821 	.db #0x00	; 0
      008226 00                    2822 	.db #0x00	; 0
      008227 00                    2823 	.db #0x00	; 0
      008228 00                    2824 	.db #0x00	; 0
      008229 00                    2825 	.db #0x00	; 0
      00822A 00                    2826 	.db #0x00	; 0
      00822B 00                    2827 	.db #0x00	; 0
      00822C 00                    2828 	.db #0x00	; 0
      00822D 00                    2829 	.db #0x00	; 0
      00822E 00                    2830 	.db #0x00	; 0
      00822F 00                    2831 	.db #0x00	; 0
      008230 00                    2832 	.db #0x00	; 0
      008231 00                    2833 	.db #0x00	; 0
      008232 00                    2834 	.db #0x00	; 0
      008233 00                    2835 	.db #0x00	; 0
      008234 00                    2836 	.db #0x00	; 0
      008235 00                    2837 	.db #0x00	; 0
      008236 00                    2838 	.db #0x00	; 0
      008237 00                    2839 	.db #0x00	; 0
      008238 00                    2840 	.db #0x00	; 0
      008239 00                    2841 	.db #0x00	; 0
      00823A 00                    2842 	.db #0x00	; 0
      00823B 00                    2843 	.db #0x00	; 0
      00823C 00                    2844 	.db #0x00	; 0
      00823D 00                    2845 	.db #0x00	; 0
      00823E 00                    2846 	.db #0x00	; 0
      00823F 00                    2847 	.db #0x00	; 0
      008240 00                    2848 	.db #0x00	; 0
      008241 00                    2849 	.db #0x00	; 0
      008242 00                    2850 	.db #0x00	; 0
      008243 00                    2851 	.db #0x00	; 0
      008244 00                    2852 	.db #0x00	; 0
      008245 00                    2853 	.db #0x00	; 0
      008246 00                    2854 	.db #0x00	; 0
      008247 00                    2855 	.db #0x00	; 0
      008248 00                    2856 	.db #0x00	; 0
      008249 00                    2857 	.db #0x00	; 0
      00824A 00                    2858 	.db #0x00	; 0
      00824B 00                    2859 	.db #0x00	; 0
      00824C 00                    2860 	.db #0x00	; 0
      00824D 00                    2861 	.db #0x00	; 0
      00824E 00                    2862 	.db #0x00	; 0
      00824F 00                    2863 	.db #0x00	; 0
      008250 00                    2864 	.db #0x00	; 0
      008251 00                    2865 	.db #0x00	; 0
      008252 00                    2866 	.db #0x00	; 0
      008253 00                    2867 	.db #0x00	; 0
      008254 00                    2868 	.db #0x00	; 0
      008255 00                    2869 	.db #0x00	; 0
      008256 00                    2870 	.db #0x00	; 0
      008257 00                    2871 	.db #0x00	; 0
      008258 00                    2872 	.db #0x00	; 0
      008259 00                    2873 	.db #0x00	; 0
      00825A 00                    2874 	.db #0x00	; 0
      00825B 00                    2875 	.db #0x00	; 0
      00825C 00                    2876 	.db #0x00	; 0
      00825D 00                    2877 	.db #0x00	; 0
      00825E 00                    2878 	.db #0x00	; 0
      00825F 00                    2879 	.db #0x00	; 0
      008260 00                    2880 	.db #0x00	; 0
      008261 00                    2881 	.db #0x00	; 0
      008262 00                    2882 	.db #0x00	; 0
      008263 00                    2883 	.db #0x00	; 0
      008264 00                    2884 	.db #0x00	; 0
      008265 00                    2885 	.db #0x00	; 0
      008266 00                    2886 	.db #0x00	; 0
      008267 00                    2887 	.db #0x00	; 0
      008268 00                    2888 	.db #0x00	; 0
      008269 00                    2889 	.db #0x00	; 0
      00826A 00                    2890 	.db #0x00	; 0
      00826B 00                    2891 	.db #0x00	; 0
      00826C 00                    2892 	.db #0x00	; 0
      00826D 00                    2893 	.db #0x00	; 0
      00826E 00                    2894 	.db #0x00	; 0
      00826F 00                    2895 	.db #0x00	; 0
      008270 00                    2896 	.db #0x00	; 0
      008271 00                    2897 	.db #0x00	; 0
      008272 00                    2898 	.db #0x00	; 0
      008273 00                    2899 	.db #0x00	; 0
      008274 00                    2900 	.db #0x00	; 0
      008275 00                    2901 	.db #0x00	; 0
      008276 00                    2902 	.db #0x00	; 0
      008277 00                    2903 	.db #0x00	; 0
      008278 00                    2904 	.db #0x00	; 0
      008279 00                    2905 	.db #0x00	; 0
      00827A 00                    2906 	.db #0x00	; 0
      00827B 00                    2907 	.db #0x00	; 0
      00827C 00                    2908 	.db #0x00	; 0
      00827D 00                    2909 	.db #0x00	; 0
      00827E 00                    2910 	.db #0x00	; 0
      00827F 00                    2911 	.db #0x00	; 0
      008280 00                    2912 	.db #0x00	; 0
      008281 00                    2913 	.db #0x00	; 0
      008282 00                    2914 	.db #0x00	; 0
      008283 00                    2915 	.db #0x00	; 0
      008284 00                    2916 	.db #0x00	; 0
      008285 00                    2917 	.db #0x00	; 0
      008286 00                    2918 	.db #0x00	; 0
      008287 00                    2919 	.db #0x00	; 0
      008288 00                    2920 	.db #0x00	; 0
      008289 00                    2921 	.db #0x00	; 0
      00828A 00                    2922 	.db #0x00	; 0
      00828B 00                    2923 	.db #0x00	; 0
      00828C 00                    2924 	.db #0x00	; 0
      00828D 00                    2925 	.db #0x00	; 0
      00828E 00                    2926 	.db #0x00	; 0
      00828F 00                    2927 	.db #0x00	; 0
      008290 00                    2928 	.db #0x00	; 0
      008291 00                    2929 	.db #0x00	; 0
      008292 00                    2930 	.db #0x00	; 0
      008293 00                    2931 	.db #0x00	; 0
      008294 00                    2932 	.db #0x00	; 0
      008295 00                    2933 	.db #0x00	; 0
      008296 00                    2934 	.db #0x00	; 0
      008297 00                    2935 	.db #0x00	; 0
      008298 00                    2936 	.db #0x00	; 0
      008299 00                    2937 	.db #0x00	; 0
      00829A 00                    2938 	.db #0x00	; 0
      00829B 00                    2939 	.db #0x00	; 0
      00829C 00                    2940 	.db #0x00	; 0
      00829D 00                    2941 	.db #0x00	; 0
      00829E 00                    2942 	.db #0x00	; 0
      00829F 00                    2943 	.db #0x00	; 0
      0082A0 00                    2944 	.db #0x00	; 0
      0082A1 00                    2945 	.db #0x00	; 0
      0082A2 00                    2946 	.db #0x00	; 0
      0082A3 00                    2947 	.db #0x00	; 0
      0082A4 00                    2948 	.db #0x00	; 0
      0082A5 00                    2949 	.db #0x00	; 0
      0082A6 00                    2950 	.db #0x00	; 0
                                   2951 	.area CABS (ABS)
