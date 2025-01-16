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
                                     12 	.globl _gg
                                     13 	.globl _display_clean
                                     14 	.globl _display_buffer_fill_entire
                                     15 	.globl _display_draw_pixel
                                     16 	.globl _display_set_params_to_write
                                     17 	.globl _display_init
                                     18 	.globl _delay
                                     19 	.globl _set_bit
                                     20 	.globl _get_bit
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
      008057 CD 8A 57         [ 4]  117 	call	___sdcc_external_startup
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
      008054 CC 8A 4E         [ 2]  147 	jp	_main
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
                                    804 ;	main.c: 15: int get_bit(int data,int bit)
                                    805 ;	-----------------------------------------
                                    806 ;	 function get_bit
                                    807 ;	-----------------------------------------
      0085E3                        808 _get_bit:
                                    809 ;	main.c: 17: return ((data >> bit) & 1) ? 1 : 0;
      0085E3 7B 04            [ 1]  810 	ld	a, (0x04, sp)
      0085E5 27 04            [ 1]  811 	jreq	00113$
      0085E7                        812 00112$:
      0085E7 57               [ 2]  813 	sraw	x
      0085E8 4A               [ 1]  814 	dec	a
      0085E9 26 FC            [ 1]  815 	jrne	00112$
      0085EB                        816 00113$:
      0085EB 54               [ 2]  817 	srlw	x
      0085EC 24 03            [ 1]  818 	jrnc	00103$
      0085EE 5F               [ 1]  819 	clrw	x
      0085EF 5C               [ 1]  820 	incw	x
      0085F0 21                     821 	.byte 0x21
      0085F1                        822 00103$:
      0085F1 5F               [ 1]  823 	clrw	x
      0085F2                        824 00104$:
                                    825 ;	main.c: 18: }
      0085F2 90 85            [ 2]  826 	popw	y
      0085F4 5B 02            [ 2]  827 	addw	sp, #2
      0085F6 90 FC            [ 2]  828 	jp	(y)
                                    829 ;	main.c: 19: int set_bit(int data,int bit, int value)
                                    830 ;	-----------------------------------------
                                    831 ;	 function set_bit
                                    832 ;	-----------------------------------------
      0085F8                        833 _set_bit:
      0085F8 52 04            [ 2]  834 	sub	sp, #4
      0085FA 1F 01            [ 2]  835 	ldw	(0x01, sp), x
                                    836 ;	main.c: 21: int mask = 1 << bit ;
      0085FC 5F               [ 1]  837 	clrw	x
      0085FD 5C               [ 1]  838 	incw	x
      0085FE 1F 03            [ 2]  839 	ldw	(0x03, sp), x
      008600 7B 08            [ 1]  840 	ld	a, (0x08, sp)
      008602 27 07            [ 1]  841 	jreq	00114$
      008604                        842 00113$:
      008604 08 04            [ 1]  843 	sll	(0x04, sp)
      008606 09 03            [ 1]  844 	rlc	(0x03, sp)
      008608 4A               [ 1]  845 	dec	a
      008609 26 F9            [ 1]  846 	jrne	00113$
      00860B                        847 00114$:
                                    848 ;	main.c: 22: switch(value)
      00860B 1E 09            [ 2]  849 	ldw	x, (0x09, sp)
      00860D 5A               [ 2]  850 	decw	x
      00860E 26 0B            [ 1]  851 	jrne	00102$
                                    852 ;	main.c: 25: data |= mask;
      008610 7B 02            [ 1]  853 	ld	a, (0x02, sp)
      008612 1A 04            [ 1]  854 	or	a, (0x04, sp)
      008614 97               [ 1]  855 	ld	xl, a
      008615 7B 01            [ 1]  856 	ld	a, (0x01, sp)
      008617 1A 03            [ 1]  857 	or	a, (0x03, sp)
                                    858 ;	main.c: 26: break;
      008619 20 09            [ 2]  859 	jra	00103$
                                    860 ;	main.c: 28: default:
      00861B                        861 00102$:
                                    862 ;	main.c: 29: data &= ~mask;
      00861B 1E 03            [ 2]  863 	ldw	x, (0x03, sp)
      00861D 53               [ 2]  864 	cplw	x
      00861E 9F               [ 1]  865 	ld	a, xl
      00861F 14 02            [ 1]  866 	and	a, (0x02, sp)
      008621 02               [ 1]  867 	rlwa	x
      008622 14 01            [ 1]  868 	and	a, (0x01, sp)
                                    869 ;	main.c: 31: }
      008624                        870 00103$:
                                    871 ;	main.c: 32: return data;
      008624 95               [ 1]  872 	ld	xh, a
                                    873 ;	main.c: 33: }
      008625 16 05            [ 2]  874 	ldw	y, (5, sp)
      008627 5B 0A            [ 2]  875 	addw	sp, #10
      008629 90 FC            [ 2]  876 	jp	(y)
                                    877 ;	main.c: 34: void delay(uint16_t ticks)
                                    878 ;	-----------------------------------------
                                    879 ;	 function delay
                                    880 ;	-----------------------------------------
      00862B                        881 _delay:
                                    882 ;	main.c: 36: while(ticks > 0)
      00862B                        883 00101$:
      00862B 5D               [ 2]  884 	tnzw	x
      00862C 26 01            [ 1]  885 	jrne	00120$
      00862E 81               [ 4]  886 	ret
      00862F                        887 00120$:
                                    888 ;	main.c: 38: ticks-=2;
      00862F 5A               [ 2]  889 	decw	x
      008630 5A               [ 2]  890 	decw	x
                                    891 ;	main.c: 39: ticks+=1;
      008631 5C               [ 1]  892 	incw	x
      008632 20 F7            [ 2]  893 	jra	00101$
                                    894 ;	main.c: 41: }
      008634 81               [ 4]  895 	ret
                                    896 ;	main.c: 43: void display_init(void)
                                    897 ;	-----------------------------------------
                                    898 ;	 function display_init
                                    899 ;	-----------------------------------------
      008635                        900 _display_init:
      008635 52 07            [ 2]  901 	sub	sp, #7
                                    902 ;	main.c: 45: uint8_t setup_buf[7] = {0x00,0xAE,0xD5,0x80,0xA8,0x1F,0xAF};
      008637 0F 01            [ 1]  903 	clr	(0x01, sp)
      008639 A6 AE            [ 1]  904 	ld	a, #0xae
      00863B 6B 02            [ 1]  905 	ld	(0x02, sp), a
      00863D A6 D5            [ 1]  906 	ld	a, #0xd5
      00863F 6B 03            [ 1]  907 	ld	(0x03, sp), a
      008641 A6 80            [ 1]  908 	ld	a, #0x80
      008643 6B 04            [ 1]  909 	ld	(0x04, sp), a
      008645 A6 A8            [ 1]  910 	ld	a, #0xa8
      008647 6B 05            [ 1]  911 	ld	(0x05, sp), a
      008649 A6 1F            [ 1]  912 	ld	a, #0x1f
      00864B 6B 06            [ 1]  913 	ld	(0x06, sp), a
      00864D A6 AF            [ 1]  914 	ld	a, #0xaf
      00864F 6B 07            [ 1]  915 	ld	(0x07, sp), a
                                    916 ;	main.c: 46: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      008651 96               [ 1]  917 	ldw	x, sp
      008652 5C               [ 1]  918 	incw	x
      008653 89               [ 2]  919 	pushw	x
      008654 4B 05            [ 1]  920 	push	#0x05
      008656 A6 3C            [ 1]  921 	ld	a, #0x3c
      008658 CD 85 70         [ 4]  922 	call	_i2c_write
                                    923 ;	main.c: 47: setup_buf[1] = 0x1F;
      00865B A6 1F            [ 1]  924 	ld	a, #0x1f
      00865D 6B 02            [ 1]  925 	ld	(0x02, sp), a
                                    926 ;	main.c: 48: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      00865F 96               [ 1]  927 	ldw	x, sp
      008660 5C               [ 1]  928 	incw	x
      008661 89               [ 2]  929 	pushw	x
      008662 4B 02            [ 1]  930 	push	#0x02
      008664 A6 3C            [ 1]  931 	ld	a, #0x3c
      008666 CD 85 70         [ 4]  932 	call	_i2c_write
                                    933 ;	main.c: 49: setup_buf[1] = 0xD3;
      008669 A6 D3            [ 1]  934 	ld	a, #0xd3
      00866B 6B 02            [ 1]  935 	ld	(0x02, sp), a
                                    936 ;	main.c: 50: setup_buf[2] = 0x00;
      00866D 0F 03            [ 1]  937 	clr	(0x03, sp)
                                    938 ;	main.c: 51: setup_buf[3] = 0x40;
      00866F A6 40            [ 1]  939 	ld	a, #0x40
      008671 6B 04            [ 1]  940 	ld	(0x04, sp), a
                                    941 ;	main.c: 52: setup_buf[4] = 0x8D;
      008673 A6 8D            [ 1]  942 	ld	a, #0x8d
      008675 6B 05            [ 1]  943 	ld	(0x05, sp), a
                                    944 ;	main.c: 53: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      008677 96               [ 1]  945 	ldw	x, sp
      008678 5C               [ 1]  946 	incw	x
      008679 89               [ 2]  947 	pushw	x
      00867A 4B 05            [ 1]  948 	push	#0x05
      00867C A6 3C            [ 1]  949 	ld	a, #0x3c
      00867E CD 85 70         [ 4]  950 	call	_i2c_write
                                    951 ;	main.c: 54: setup_buf[1] = 0x14;
      008681 A6 14            [ 1]  952 	ld	a, #0x14
      008683 6B 02            [ 1]  953 	ld	(0x02, sp), a
                                    954 ;	main.c: 55: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      008685 96               [ 1]  955 	ldw	x, sp
      008686 5C               [ 1]  956 	incw	x
      008687 89               [ 2]  957 	pushw	x
      008688 4B 02            [ 1]  958 	push	#0x02
      00868A A6 3C            [ 1]  959 	ld	a, #0x3c
      00868C CD 85 70         [ 4]  960 	call	_i2c_write
                                    961 ;	main.c: 56: setup_buf[1] = 0xDB;
      00868F A6 DB            [ 1]  962 	ld	a, #0xdb
      008691 6B 02            [ 1]  963 	ld	(0x02, sp), a
                                    964 ;	main.c: 57: setup_buf[2] = 0x40;
      008693 A6 40            [ 1]  965 	ld	a, #0x40
      008695 6B 03            [ 1]  966 	ld	(0x03, sp), a
                                    967 ;	main.c: 58: setup_buf[3] = 0xA4;
      008697 A6 A4            [ 1]  968 	ld	a, #0xa4
      008699 6B 04            [ 1]  969 	ld	(0x04, sp), a
                                    970 ;	main.c: 59: setup_buf[4] = 0xA6;
      00869B A6 A6            [ 1]  971 	ld	a, #0xa6
      00869D 6B 05            [ 1]  972 	ld	(0x05, sp), a
                                    973 ;	main.c: 60: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      00869F 96               [ 1]  974 	ldw	x, sp
      0086A0 5C               [ 1]  975 	incw	x
      0086A1 89               [ 2]  976 	pushw	x
      0086A2 4B 05            [ 1]  977 	push	#0x05
      0086A4 A6 3C            [ 1]  978 	ld	a, #0x3c
      0086A6 CD 85 70         [ 4]  979 	call	_i2c_write
                                    980 ;	main.c: 61: setup_buf[1] = 0xDA;
      0086A9 A6 DA            [ 1]  981 	ld	a, #0xda
      0086AB 6B 02            [ 1]  982 	ld	(0x02, sp), a
                                    983 ;	main.c: 62: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086AD 96               [ 1]  984 	ldw	x, sp
      0086AE 5C               [ 1]  985 	incw	x
      0086AF 89               [ 2]  986 	pushw	x
      0086B0 4B 02            [ 1]  987 	push	#0x02
      0086B2 A6 3C            [ 1]  988 	ld	a, #0x3c
      0086B4 CD 85 70         [ 4]  989 	call	_i2c_write
                                    990 ;	main.c: 63: setup_buf[1] = 0x02;
      0086B7 A6 02            [ 1]  991 	ld	a, #0x02
      0086B9 6B 02            [ 1]  992 	ld	(0x02, sp), a
                                    993 ;	main.c: 64: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086BB 96               [ 1]  994 	ldw	x, sp
      0086BC 5C               [ 1]  995 	incw	x
      0086BD 89               [ 2]  996 	pushw	x
      0086BE 4B 02            [ 1]  997 	push	#0x02
      0086C0 A6 3C            [ 1]  998 	ld	a, #0x3c
      0086C2 CD 85 70         [ 4]  999 	call	_i2c_write
                                   1000 ;	main.c: 65: setup_buf[1] = 0x81;
      0086C5 A6 81            [ 1] 1001 	ld	a, #0x81
      0086C7 6B 02            [ 1] 1002 	ld	(0x02, sp), a
                                   1003 ;	main.c: 66: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086C9 96               [ 1] 1004 	ldw	x, sp
      0086CA 5C               [ 1] 1005 	incw	x
      0086CB 89               [ 2] 1006 	pushw	x
      0086CC 4B 02            [ 1] 1007 	push	#0x02
      0086CE A6 3C            [ 1] 1008 	ld	a, #0x3c
      0086D0 CD 85 70         [ 4] 1009 	call	_i2c_write
                                   1010 ;	main.c: 67: setup_buf[1] = 0x8F;
      0086D3 A6 8F            [ 1] 1011 	ld	a, #0x8f
      0086D5 6B 02            [ 1] 1012 	ld	(0x02, sp), a
                                   1013 ;	main.c: 68: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086D7 96               [ 1] 1014 	ldw	x, sp
      0086D8 5C               [ 1] 1015 	incw	x
      0086D9 89               [ 2] 1016 	pushw	x
      0086DA 4B 02            [ 1] 1017 	push	#0x02
      0086DC A6 3C            [ 1] 1018 	ld	a, #0x3c
      0086DE CD 85 70         [ 4] 1019 	call	_i2c_write
                                   1020 ;	main.c: 69: setup_buf[1] = 0xD9;
      0086E1 A6 D9            [ 1] 1021 	ld	a, #0xd9
      0086E3 6B 02            [ 1] 1022 	ld	(0x02, sp), a
                                   1023 ;	main.c: 70: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086E5 96               [ 1] 1024 	ldw	x, sp
      0086E6 5C               [ 1] 1025 	incw	x
      0086E7 89               [ 2] 1026 	pushw	x
      0086E8 4B 02            [ 1] 1027 	push	#0x02
      0086EA A6 3C            [ 1] 1028 	ld	a, #0x3c
      0086EC CD 85 70         [ 4] 1029 	call	_i2c_write
                                   1030 ;	main.c: 71: setup_buf[1] = 0xF1;
      0086EF A6 F1            [ 1] 1031 	ld	a, #0xf1
      0086F1 6B 02            [ 1] 1032 	ld	(0x02, sp), a
                                   1033 ;	main.c: 72: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086F3 96               [ 1] 1034 	ldw	x, sp
      0086F4 5C               [ 1] 1035 	incw	x
      0086F5 89               [ 2] 1036 	pushw	x
      0086F6 4B 02            [ 1] 1037 	push	#0x02
      0086F8 A6 3C            [ 1] 1038 	ld	a, #0x3c
      0086FA CD 85 70         [ 4] 1039 	call	_i2c_write
                                   1040 ;	main.c: 73: setup_buf[1] = 0x20;
      0086FD A6 20            [ 1] 1041 	ld	a, #0x20
      0086FF 6B 02            [ 1] 1042 	ld	(0x02, sp), a
                                   1043 ;	main.c: 74: setup_buf[2] = 0x00;
      008701 0F 03            [ 1] 1044 	clr	(0x03, sp)
                                   1045 ;	main.c: 75: setup_buf[3] = 0xA1;
      008703 A6 A1            [ 1] 1046 	ld	a, #0xa1
      008705 6B 04            [ 1] 1047 	ld	(0x04, sp), a
                                   1048 ;	main.c: 76: setup_buf[4] = 0xC8;
      008707 A6 C8            [ 1] 1049 	ld	a, #0xc8
      008709 6B 05            [ 1] 1050 	ld	(0x05, sp), a
                                   1051 ;	main.c: 77: i2c_write(I2C_DISPLAY_ADDR,7,setup_buf);
      00870B 96               [ 1] 1052 	ldw	x, sp
      00870C 5C               [ 1] 1053 	incw	x
      00870D 89               [ 2] 1054 	pushw	x
      00870E 4B 07            [ 1] 1055 	push	#0x07
      008710 A6 3C            [ 1] 1056 	ld	a, #0x3c
      008712 CD 85 70         [ 4] 1057 	call	_i2c_write
                                   1058 ;	main.c: 78: }
      008715 5B 07            [ 2] 1059 	addw	sp, #7
      008717 81               [ 4] 1060 	ret
                                   1061 ;	main.c: 80: void display_set_params_to_write(void)
                                   1062 ;	-----------------------------------------
                                   1063 ;	 function display_set_params_to_write
                                   1064 ;	-----------------------------------------
      008718                       1065 _display_set_params_to_write:
      008718 52 08            [ 2] 1066 	sub	sp, #8
                                   1067 ;	main.c: 82: uint8_t set_params_buf[8] = {0x00,0x22,0x00,0x03,0x00,0x21,0x00,0x7F};
      00871A 96               [ 1] 1068 	ldw	x, sp
      00871B 5C               [ 1] 1069 	incw	x
      00871C 7F               [ 1] 1070 	clr	(x)
      00871D A6 22            [ 1] 1071 	ld	a, #0x22
      00871F 6B 02            [ 1] 1072 	ld	(0x02, sp), a
      008721 0F 03            [ 1] 1073 	clr	(0x03, sp)
      008723 A6 03            [ 1] 1074 	ld	a, #0x03
      008725 6B 04            [ 1] 1075 	ld	(0x04, sp), a
      008727 0F 05            [ 1] 1076 	clr	(0x05, sp)
      008729 A6 21            [ 1] 1077 	ld	a, #0x21
      00872B 6B 06            [ 1] 1078 	ld	(0x06, sp), a
      00872D 0F 07            [ 1] 1079 	clr	(0x07, sp)
      00872F A6 7F            [ 1] 1080 	ld	a, #0x7f
      008731 6B 08            [ 1] 1081 	ld	(0x08, sp), a
                                   1082 ;	main.c: 83: i2c_write(I2C_DISPLAY_ADDR,8,set_params_buf);
      008733 89               [ 2] 1083 	pushw	x
      008734 4B 08            [ 1] 1084 	push	#0x08
      008736 A6 3C            [ 1] 1085 	ld	a, #0x3c
      008738 CD 85 70         [ 4] 1086 	call	_i2c_write
                                   1087 ;	main.c: 84: }
      00873B 5B 08            [ 2] 1088 	addw	sp, #8
      00873D 81               [ 4] 1089 	ret
                                   1090 ;	main.c: 91: void display_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1091 ;	-----------------------------------------
                                   1092 ;	 function display_draw_pixel
                                   1093 ;	-----------------------------------------
      00873E                       1094 _display_draw_pixel:
      00873E 52 08            [ 2] 1095 	sub	sp, #8
      008740 1F 07            [ 2] 1096 	ldw	(0x07, sp), x
                                   1097 ;	main.c: 93: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      008742 6B 06            [ 1] 1098 	ld	(0x06, sp), a
      008744 0F 05            [ 1] 1099 	clr	(0x05, sp)
      008746 7B 0B            [ 1] 1100 	ld	a, (0x0b, sp)
      008748 0F 01            [ 1] 1101 	clr	(0x01, sp)
      00874A 97               [ 1] 1102 	ld	xl, a
      00874B 02               [ 1] 1103 	rlwa	x
      00874C 4F               [ 1] 1104 	clr	a
      00874D 01               [ 1] 1105 	rrwa	x
      00874E 5D               [ 2] 1106 	tnzw	x
      00874F 2A 03            [ 1] 1107 	jrpl	00103$
      008751 1C 00 07         [ 2] 1108 	addw	x, #0x0007
      008754                       1109 00103$:
      008754 57               [ 2] 1110 	sraw	x
      008755 57               [ 2] 1111 	sraw	x
      008756 57               [ 2] 1112 	sraw	x
      008757 58               [ 2] 1113 	sllw	x
      008758 58               [ 2] 1114 	sllw	x
      008759 58               [ 2] 1115 	sllw	x
      00875A 58               [ 2] 1116 	sllw	x
      00875B 58               [ 2] 1117 	sllw	x
      00875C 58               [ 2] 1118 	sllw	x
      00875D 58               [ 2] 1119 	sllw	x
      00875E 72 FB 05         [ 2] 1120 	addw	x, (0x05, sp)
      008761 72 FB 07         [ 2] 1121 	addw	x, (0x07, sp)
      008764 1F 03            [ 2] 1122 	ldw	(0x03, sp), x
      008766 90 5F            [ 1] 1123 	clrw	y
      008768 61               [ 1] 1124 	exg	a, yl
      008769 7B 0C            [ 1] 1125 	ld	a, (0x0c, sp)
      00876B 61               [ 1] 1126 	exg	a, yl
      00876C A4 07            [ 1] 1127 	and	a, #0x07
      00876E 6B 06            [ 1] 1128 	ld	(0x06, sp), a
      008770 0F 05            [ 1] 1129 	clr	(0x05, sp)
      008772 1E 03            [ 2] 1130 	ldw	x, (0x03, sp)
      008774 F6               [ 1] 1131 	ld	a, (x)
      008775 5F               [ 1] 1132 	clrw	x
      008776 90 89            [ 2] 1133 	pushw	y
      008778 16 07            [ 2] 1134 	ldw	y, (0x07, sp)
      00877A 90 89            [ 2] 1135 	pushw	y
      00877C 97               [ 1] 1136 	ld	xl, a
      00877D CD 85 F8         [ 4] 1137 	call	_set_bit
      008780 9F               [ 1] 1138 	ld	a, xl
      008781 1E 03            [ 2] 1139 	ldw	x, (0x03, sp)
      008783 F7               [ 1] 1140 	ld	(x), a
                                   1141 ;	main.c: 94: }
      008784 1E 09            [ 2] 1142 	ldw	x, (9, sp)
      008786 5B 0C            [ 2] 1143 	addw	sp, #12
      008788 FC               [ 2] 1144 	jp	(x)
                                   1145 ;	main.c: 96: void display_buffer_fill_entire(uint8_t *in_data) {
                                   1146 ;	-----------------------------------------
                                   1147 ;	 function display_buffer_fill_entire
                                   1148 ;	-----------------------------------------
      008789                       1149 _display_buffer_fill_entire:
      008789 52 8D            [ 2] 1150 	sub	sp, #141
      00878B 1F 86            [ 2] 1151 	ldw	(0x86, sp), x
                                   1152 ;	main.c: 98: display_set_params_to_write();
      00878D CD 87 18         [ 4] 1153 	call	_display_set_params_to_write
                                   1154 ;	main.c: 99: uint8_t part[129]={0x40};
      008790 A6 40            [ 1] 1155 	ld	a, #0x40
      008792 6B 01            [ 1] 1156 	ld	(0x01, sp), a
      008794 0F 02            [ 1] 1157 	clr	(0x02, sp)
      008796 0F 03            [ 1] 1158 	clr	(0x03, sp)
      008798 0F 04            [ 1] 1159 	clr	(0x04, sp)
      00879A 0F 05            [ 1] 1160 	clr	(0x05, sp)
      00879C 0F 06            [ 1] 1161 	clr	(0x06, sp)
      00879E 0F 07            [ 1] 1162 	clr	(0x07, sp)
      0087A0 0F 08            [ 1] 1163 	clr	(0x08, sp)
      0087A2 0F 09            [ 1] 1164 	clr	(0x09, sp)
      0087A4 0F 0A            [ 1] 1165 	clr	(0x0a, sp)
      0087A6 0F 0B            [ 1] 1166 	clr	(0x0b, sp)
      0087A8 0F 0C            [ 1] 1167 	clr	(0x0c, sp)
      0087AA 0F 0D            [ 1] 1168 	clr	(0x0d, sp)
      0087AC 0F 0E            [ 1] 1169 	clr	(0x0e, sp)
      0087AE 0F 0F            [ 1] 1170 	clr	(0x0f, sp)
      0087B0 0F 10            [ 1] 1171 	clr	(0x10, sp)
      0087B2 0F 11            [ 1] 1172 	clr	(0x11, sp)
      0087B4 0F 12            [ 1] 1173 	clr	(0x12, sp)
      0087B6 0F 13            [ 1] 1174 	clr	(0x13, sp)
      0087B8 0F 14            [ 1] 1175 	clr	(0x14, sp)
      0087BA 0F 15            [ 1] 1176 	clr	(0x15, sp)
      0087BC 0F 16            [ 1] 1177 	clr	(0x16, sp)
      0087BE 0F 17            [ 1] 1178 	clr	(0x17, sp)
      0087C0 0F 18            [ 1] 1179 	clr	(0x18, sp)
      0087C2 0F 19            [ 1] 1180 	clr	(0x19, sp)
      0087C4 0F 1A            [ 1] 1181 	clr	(0x1a, sp)
      0087C6 0F 1B            [ 1] 1182 	clr	(0x1b, sp)
      0087C8 0F 1C            [ 1] 1183 	clr	(0x1c, sp)
      0087CA 0F 1D            [ 1] 1184 	clr	(0x1d, sp)
      0087CC 0F 1E            [ 1] 1185 	clr	(0x1e, sp)
      0087CE 0F 1F            [ 1] 1186 	clr	(0x1f, sp)
      0087D0 0F 20            [ 1] 1187 	clr	(0x20, sp)
      0087D2 0F 21            [ 1] 1188 	clr	(0x21, sp)
      0087D4 0F 22            [ 1] 1189 	clr	(0x22, sp)
      0087D6 0F 23            [ 1] 1190 	clr	(0x23, sp)
      0087D8 0F 24            [ 1] 1191 	clr	(0x24, sp)
      0087DA 0F 25            [ 1] 1192 	clr	(0x25, sp)
      0087DC 0F 26            [ 1] 1193 	clr	(0x26, sp)
      0087DE 0F 27            [ 1] 1194 	clr	(0x27, sp)
      0087E0 0F 28            [ 1] 1195 	clr	(0x28, sp)
      0087E2 0F 29            [ 1] 1196 	clr	(0x29, sp)
      0087E4 0F 2A            [ 1] 1197 	clr	(0x2a, sp)
      0087E6 0F 2B            [ 1] 1198 	clr	(0x2b, sp)
      0087E8 0F 2C            [ 1] 1199 	clr	(0x2c, sp)
      0087EA 0F 2D            [ 1] 1200 	clr	(0x2d, sp)
      0087EC 0F 2E            [ 1] 1201 	clr	(0x2e, sp)
      0087EE 0F 2F            [ 1] 1202 	clr	(0x2f, sp)
      0087F0 0F 30            [ 1] 1203 	clr	(0x30, sp)
      0087F2 0F 31            [ 1] 1204 	clr	(0x31, sp)
      0087F4 0F 32            [ 1] 1205 	clr	(0x32, sp)
      0087F6 0F 33            [ 1] 1206 	clr	(0x33, sp)
      0087F8 0F 34            [ 1] 1207 	clr	(0x34, sp)
      0087FA 0F 35            [ 1] 1208 	clr	(0x35, sp)
      0087FC 0F 36            [ 1] 1209 	clr	(0x36, sp)
      0087FE 0F 37            [ 1] 1210 	clr	(0x37, sp)
      008800 0F 38            [ 1] 1211 	clr	(0x38, sp)
      008802 0F 39            [ 1] 1212 	clr	(0x39, sp)
      008804 0F 3A            [ 1] 1213 	clr	(0x3a, sp)
      008806 0F 3B            [ 1] 1214 	clr	(0x3b, sp)
      008808 0F 3C            [ 1] 1215 	clr	(0x3c, sp)
      00880A 0F 3D            [ 1] 1216 	clr	(0x3d, sp)
      00880C 0F 3E            [ 1] 1217 	clr	(0x3e, sp)
      00880E 0F 3F            [ 1] 1218 	clr	(0x3f, sp)
      008810 0F 40            [ 1] 1219 	clr	(0x40, sp)
      008812 0F 41            [ 1] 1220 	clr	(0x41, sp)
      008814 0F 42            [ 1] 1221 	clr	(0x42, sp)
      008816 0F 43            [ 1] 1222 	clr	(0x43, sp)
      008818 0F 44            [ 1] 1223 	clr	(0x44, sp)
      00881A 0F 45            [ 1] 1224 	clr	(0x45, sp)
      00881C 0F 46            [ 1] 1225 	clr	(0x46, sp)
      00881E 0F 47            [ 1] 1226 	clr	(0x47, sp)
      008820 0F 48            [ 1] 1227 	clr	(0x48, sp)
      008822 0F 49            [ 1] 1228 	clr	(0x49, sp)
      008824 0F 4A            [ 1] 1229 	clr	(0x4a, sp)
      008826 0F 4B            [ 1] 1230 	clr	(0x4b, sp)
      008828 0F 4C            [ 1] 1231 	clr	(0x4c, sp)
      00882A 0F 4D            [ 1] 1232 	clr	(0x4d, sp)
      00882C 0F 4E            [ 1] 1233 	clr	(0x4e, sp)
      00882E 0F 4F            [ 1] 1234 	clr	(0x4f, sp)
      008830 0F 50            [ 1] 1235 	clr	(0x50, sp)
      008832 0F 51            [ 1] 1236 	clr	(0x51, sp)
      008834 0F 52            [ 1] 1237 	clr	(0x52, sp)
      008836 0F 53            [ 1] 1238 	clr	(0x53, sp)
      008838 0F 54            [ 1] 1239 	clr	(0x54, sp)
      00883A 0F 55            [ 1] 1240 	clr	(0x55, sp)
      00883C 0F 56            [ 1] 1241 	clr	(0x56, sp)
      00883E 0F 57            [ 1] 1242 	clr	(0x57, sp)
      008840 0F 58            [ 1] 1243 	clr	(0x58, sp)
      008842 0F 59            [ 1] 1244 	clr	(0x59, sp)
      008844 0F 5A            [ 1] 1245 	clr	(0x5a, sp)
      008846 0F 5B            [ 1] 1246 	clr	(0x5b, sp)
      008848 0F 5C            [ 1] 1247 	clr	(0x5c, sp)
      00884A 0F 5D            [ 1] 1248 	clr	(0x5d, sp)
      00884C 0F 5E            [ 1] 1249 	clr	(0x5e, sp)
      00884E 0F 5F            [ 1] 1250 	clr	(0x5f, sp)
      008850 0F 60            [ 1] 1251 	clr	(0x60, sp)
      008852 0F 61            [ 1] 1252 	clr	(0x61, sp)
      008854 0F 62            [ 1] 1253 	clr	(0x62, sp)
      008856 0F 63            [ 1] 1254 	clr	(0x63, sp)
      008858 0F 64            [ 1] 1255 	clr	(0x64, sp)
      00885A 0F 65            [ 1] 1256 	clr	(0x65, sp)
      00885C 0F 66            [ 1] 1257 	clr	(0x66, sp)
      00885E 0F 67            [ 1] 1258 	clr	(0x67, sp)
      008860 0F 68            [ 1] 1259 	clr	(0x68, sp)
      008862 0F 69            [ 1] 1260 	clr	(0x69, sp)
      008864 0F 6A            [ 1] 1261 	clr	(0x6a, sp)
      008866 0F 6B            [ 1] 1262 	clr	(0x6b, sp)
      008868 0F 6C            [ 1] 1263 	clr	(0x6c, sp)
      00886A 0F 6D            [ 1] 1264 	clr	(0x6d, sp)
      00886C 0F 6E            [ 1] 1265 	clr	(0x6e, sp)
      00886E 0F 6F            [ 1] 1266 	clr	(0x6f, sp)
      008870 0F 70            [ 1] 1267 	clr	(0x70, sp)
      008872 0F 71            [ 1] 1268 	clr	(0x71, sp)
      008874 0F 72            [ 1] 1269 	clr	(0x72, sp)
      008876 0F 73            [ 1] 1270 	clr	(0x73, sp)
      008878 0F 74            [ 1] 1271 	clr	(0x74, sp)
      00887A 0F 75            [ 1] 1272 	clr	(0x75, sp)
      00887C 0F 76            [ 1] 1273 	clr	(0x76, sp)
      00887E 0F 77            [ 1] 1274 	clr	(0x77, sp)
      008880 0F 78            [ 1] 1275 	clr	(0x78, sp)
      008882 0F 79            [ 1] 1276 	clr	(0x79, sp)
      008884 0F 7A            [ 1] 1277 	clr	(0x7a, sp)
      008886 0F 7B            [ 1] 1278 	clr	(0x7b, sp)
      008888 0F 7C            [ 1] 1279 	clr	(0x7c, sp)
      00888A 0F 7D            [ 1] 1280 	clr	(0x7d, sp)
      00888C 0F 7E            [ 1] 1281 	clr	(0x7e, sp)
      00888E 0F 7F            [ 1] 1282 	clr	(0x7f, sp)
      008890 0F 80            [ 1] 1283 	clr	(0x80, sp)
      008892 0F 81            [ 1] 1284 	clr	(0x81, sp)
                                   1285 ;	main.c: 101: for(int page = 0;page <= 384;page+=128)
      008894 5F               [ 1] 1286 	clrw	x
      008895 1F 88            [ 2] 1287 	ldw	(0x88, sp), x
      008897                       1288 00111$:
      008897 1E 88            [ 2] 1289 	ldw	x, (0x88, sp)
      008899 A3 01 80         [ 2] 1290 	cpw	x, #0x0180
      00889C 2D 03            [ 1] 1291 	jrsle	00160$
      00889E CC 89 1E         [ 2] 1292 	jp	00113$
      0088A1                       1293 00160$:
                                   1294 ;	main.c: 103: for (int height = 0; height < 8; height++) 
      0088A1 5F               [ 1] 1295 	clrw	x
      0088A2 1F 8A            [ 2] 1296 	ldw	(0x8a, sp), x
      0088A4                       1297 00108$:
      0088A4 1E 8A            [ 2] 1298 	ldw	x, (0x8a, sp)
      0088A6 A3 00 08         [ 2] 1299 	cpw	x, #0x0008
      0088A9 2E 5F            [ 1] 1300 	jrsge	00102$
                                   1301 ;	main.c: 105: for (int width = 0; width < 128; width++) 
      0088AB 1E 8A            [ 2] 1302 	ldw	x, (0x8a, sp)
      0088AD 58               [ 2] 1303 	sllw	x
      0088AE 58               [ 2] 1304 	sllw	x
      0088AF 58               [ 2] 1305 	sllw	x
      0088B0 58               [ 2] 1306 	sllw	x
      0088B1 72 FB 88         [ 2] 1307 	addw	x, (0x88, sp)
      0088B4 1F 82            [ 2] 1308 	ldw	(0x82, sp), x
      0088B6 5F               [ 1] 1309 	clrw	x
      0088B7 1F 8C            [ 2] 1310 	ldw	(0x8c, sp), x
      0088B9                       1311 00105$:
      0088B9 1E 8C            [ 2] 1312 	ldw	x, (0x8c, sp)
      0088BB A3 00 80         [ 2] 1313 	cpw	x, #0x0080
      0088BE 2E 43            [ 1] 1314 	jrsge	00109$
                                   1315 ;	main.c: 108: display_draw_pixel(&part[1], width, height, get_bit(in_data[page+(height*16) + (width / 8)], 7 - (width % 8)));
      0088C0 4B 08            [ 1] 1316 	push	#0x08
      0088C2 4B 00            [ 1] 1317 	push	#0x00
      0088C4 1E 8E            [ 2] 1318 	ldw	x, (0x8e, sp)
      0088C6 CD 8A 59         [ 4] 1319 	call	__modsint
      0088C9 1F 84            [ 2] 1320 	ldw	(0x84, sp), x
      0088CB 90 AE 00 07      [ 2] 1321 	ldw	y, #0x0007
      0088CF 72 F2 84         [ 2] 1322 	subw	y, (0x84, sp)
      0088D2 1E 8C            [ 2] 1323 	ldw	x, (0x8c, sp)
      0088D4 2A 03            [ 1] 1324 	jrpl	00163$
      0088D6 1C 00 07         [ 2] 1325 	addw	x, #0x0007
      0088D9                       1326 00163$:
      0088D9 57               [ 2] 1327 	sraw	x
      0088DA 57               [ 2] 1328 	sraw	x
      0088DB 57               [ 2] 1329 	sraw	x
      0088DC 72 FB 82         [ 2] 1330 	addw	x, (0x82, sp)
      0088DF 72 FB 86         [ 2] 1331 	addw	x, (0x86, sp)
      0088E2 F6               [ 1] 1332 	ld	a, (x)
      0088E3 5F               [ 1] 1333 	clrw	x
      0088E4 90 89            [ 2] 1334 	pushw	y
      0088E6 97               [ 1] 1335 	ld	xl, a
      0088E7 CD 85 E3         [ 4] 1336 	call	_get_bit
      0088EA 7B 8B            [ 1] 1337 	ld	a, (0x8b, sp)
      0088EC 02               [ 1] 1338 	rlwa	x
      0088ED 7B 8D            [ 1] 1339 	ld	a, (0x8d, sp)
      0088EF 01               [ 1] 1340 	rrwa	x
      0088F0 89               [ 2] 1341 	pushw	x
      0088F1 5B 01            [ 2] 1342 	addw	sp, #1
      0088F3 88               [ 1] 1343 	push	a
      0088F4 9E               [ 1] 1344 	ld	a, xh
      0088F5 96               [ 1] 1345 	ldw	x, sp
      0088F6 1C 00 04         [ 2] 1346 	addw	x, #4
      0088F9 CD 87 3E         [ 4] 1347 	call	_display_draw_pixel
                                   1348 ;	main.c: 105: for (int width = 0; width < 128; width++) 
      0088FC 1E 8C            [ 2] 1349 	ldw	x, (0x8c, sp)
      0088FE 5C               [ 1] 1350 	incw	x
      0088FF 1F 8C            [ 2] 1351 	ldw	(0x8c, sp), x
      008901 20 B6            [ 2] 1352 	jra	00105$
      008903                       1353 00109$:
                                   1354 ;	main.c: 103: for (int height = 0; height < 8; height++) 
      008903 1E 8A            [ 2] 1355 	ldw	x, (0x8a, sp)
      008905 5C               [ 1] 1356 	incw	x
      008906 1F 8A            [ 2] 1357 	ldw	(0x8a, sp), x
      008908 20 9A            [ 2] 1358 	jra	00108$
      00890A                       1359 00102$:
                                   1360 ;	main.c: 113: i2c_write(I2C_DISPLAY_ADDR, 129, part);
      00890A 96               [ 1] 1361 	ldw	x, sp
      00890B 5C               [ 1] 1362 	incw	x
      00890C 89               [ 2] 1363 	pushw	x
      00890D 4B 81            [ 1] 1364 	push	#0x81
      00890F A6 3C            [ 1] 1365 	ld	a, #0x3c
      008911 CD 85 70         [ 4] 1366 	call	_i2c_write
                                   1367 ;	main.c: 101: for(int page = 0;page <= 384;page+=128)
      008914 1E 88            [ 2] 1368 	ldw	x, (0x88, sp)
      008916 1C 00 80         [ 2] 1369 	addw	x, #0x0080
      008919 1F 88            [ 2] 1370 	ldw	(0x88, sp), x
      00891B CC 88 97         [ 2] 1371 	jp	00111$
      00891E                       1372 00113$:
                                   1373 ;	main.c: 115: }
      00891E 5B 8D            [ 2] 1374 	addw	sp, #141
      008920 81               [ 4] 1375 	ret
                                   1376 ;	main.c: 117: void display_clean(void)
                                   1377 ;	-----------------------------------------
                                   1378 ;	 function display_clean
                                   1379 ;	-----------------------------------------
      008921                       1380 _display_clean:
      008921 52 81            [ 2] 1381 	sub	sp, #129
                                   1382 ;	main.c: 119: uint8_t clean_buf[129] = {0x40};
      008923 A6 40            [ 1] 1383 	ld	a, #0x40
      008925 6B 01            [ 1] 1384 	ld	(0x01, sp), a
      008927 0F 02            [ 1] 1385 	clr	(0x02, sp)
      008929 0F 03            [ 1] 1386 	clr	(0x03, sp)
      00892B 0F 04            [ 1] 1387 	clr	(0x04, sp)
      00892D 0F 05            [ 1] 1388 	clr	(0x05, sp)
      00892F 0F 06            [ 1] 1389 	clr	(0x06, sp)
      008931 0F 07            [ 1] 1390 	clr	(0x07, sp)
      008933 0F 08            [ 1] 1391 	clr	(0x08, sp)
      008935 0F 09            [ 1] 1392 	clr	(0x09, sp)
      008937 0F 0A            [ 1] 1393 	clr	(0x0a, sp)
      008939 0F 0B            [ 1] 1394 	clr	(0x0b, sp)
      00893B 0F 0C            [ 1] 1395 	clr	(0x0c, sp)
      00893D 0F 0D            [ 1] 1396 	clr	(0x0d, sp)
      00893F 0F 0E            [ 1] 1397 	clr	(0x0e, sp)
      008941 0F 0F            [ 1] 1398 	clr	(0x0f, sp)
      008943 0F 10            [ 1] 1399 	clr	(0x10, sp)
      008945 0F 11            [ 1] 1400 	clr	(0x11, sp)
      008947 0F 12            [ 1] 1401 	clr	(0x12, sp)
      008949 0F 13            [ 1] 1402 	clr	(0x13, sp)
      00894B 0F 14            [ 1] 1403 	clr	(0x14, sp)
      00894D 0F 15            [ 1] 1404 	clr	(0x15, sp)
      00894F 0F 16            [ 1] 1405 	clr	(0x16, sp)
      008951 0F 17            [ 1] 1406 	clr	(0x17, sp)
      008953 0F 18            [ 1] 1407 	clr	(0x18, sp)
      008955 0F 19            [ 1] 1408 	clr	(0x19, sp)
      008957 0F 1A            [ 1] 1409 	clr	(0x1a, sp)
      008959 0F 1B            [ 1] 1410 	clr	(0x1b, sp)
      00895B 0F 1C            [ 1] 1411 	clr	(0x1c, sp)
      00895D 0F 1D            [ 1] 1412 	clr	(0x1d, sp)
      00895F 0F 1E            [ 1] 1413 	clr	(0x1e, sp)
      008961 0F 1F            [ 1] 1414 	clr	(0x1f, sp)
      008963 0F 20            [ 1] 1415 	clr	(0x20, sp)
      008965 0F 21            [ 1] 1416 	clr	(0x21, sp)
      008967 0F 22            [ 1] 1417 	clr	(0x22, sp)
      008969 0F 23            [ 1] 1418 	clr	(0x23, sp)
      00896B 0F 24            [ 1] 1419 	clr	(0x24, sp)
      00896D 0F 25            [ 1] 1420 	clr	(0x25, sp)
      00896F 0F 26            [ 1] 1421 	clr	(0x26, sp)
      008971 0F 27            [ 1] 1422 	clr	(0x27, sp)
      008973 0F 28            [ 1] 1423 	clr	(0x28, sp)
      008975 0F 29            [ 1] 1424 	clr	(0x29, sp)
      008977 0F 2A            [ 1] 1425 	clr	(0x2a, sp)
      008979 0F 2B            [ 1] 1426 	clr	(0x2b, sp)
      00897B 0F 2C            [ 1] 1427 	clr	(0x2c, sp)
      00897D 0F 2D            [ 1] 1428 	clr	(0x2d, sp)
      00897F 0F 2E            [ 1] 1429 	clr	(0x2e, sp)
      008981 0F 2F            [ 1] 1430 	clr	(0x2f, sp)
      008983 0F 30            [ 1] 1431 	clr	(0x30, sp)
      008985 0F 31            [ 1] 1432 	clr	(0x31, sp)
      008987 0F 32            [ 1] 1433 	clr	(0x32, sp)
      008989 0F 33            [ 1] 1434 	clr	(0x33, sp)
      00898B 0F 34            [ 1] 1435 	clr	(0x34, sp)
      00898D 0F 35            [ 1] 1436 	clr	(0x35, sp)
      00898F 0F 36            [ 1] 1437 	clr	(0x36, sp)
      008991 0F 37            [ 1] 1438 	clr	(0x37, sp)
      008993 0F 38            [ 1] 1439 	clr	(0x38, sp)
      008995 0F 39            [ 1] 1440 	clr	(0x39, sp)
      008997 0F 3A            [ 1] 1441 	clr	(0x3a, sp)
      008999 0F 3B            [ 1] 1442 	clr	(0x3b, sp)
      00899B 0F 3C            [ 1] 1443 	clr	(0x3c, sp)
      00899D 0F 3D            [ 1] 1444 	clr	(0x3d, sp)
      00899F 0F 3E            [ 1] 1445 	clr	(0x3e, sp)
      0089A1 0F 3F            [ 1] 1446 	clr	(0x3f, sp)
      0089A3 0F 40            [ 1] 1447 	clr	(0x40, sp)
      0089A5 0F 41            [ 1] 1448 	clr	(0x41, sp)
      0089A7 0F 42            [ 1] 1449 	clr	(0x42, sp)
      0089A9 0F 43            [ 1] 1450 	clr	(0x43, sp)
      0089AB 0F 44            [ 1] 1451 	clr	(0x44, sp)
      0089AD 0F 45            [ 1] 1452 	clr	(0x45, sp)
      0089AF 0F 46            [ 1] 1453 	clr	(0x46, sp)
      0089B1 0F 47            [ 1] 1454 	clr	(0x47, sp)
      0089B3 0F 48            [ 1] 1455 	clr	(0x48, sp)
      0089B5 0F 49            [ 1] 1456 	clr	(0x49, sp)
      0089B7 0F 4A            [ 1] 1457 	clr	(0x4a, sp)
      0089B9 0F 4B            [ 1] 1458 	clr	(0x4b, sp)
      0089BB 0F 4C            [ 1] 1459 	clr	(0x4c, sp)
      0089BD 0F 4D            [ 1] 1460 	clr	(0x4d, sp)
      0089BF 0F 4E            [ 1] 1461 	clr	(0x4e, sp)
      0089C1 0F 4F            [ 1] 1462 	clr	(0x4f, sp)
      0089C3 0F 50            [ 1] 1463 	clr	(0x50, sp)
      0089C5 0F 51            [ 1] 1464 	clr	(0x51, sp)
      0089C7 0F 52            [ 1] 1465 	clr	(0x52, sp)
      0089C9 0F 53            [ 1] 1466 	clr	(0x53, sp)
      0089CB 0F 54            [ 1] 1467 	clr	(0x54, sp)
      0089CD 0F 55            [ 1] 1468 	clr	(0x55, sp)
      0089CF 0F 56            [ 1] 1469 	clr	(0x56, sp)
      0089D1 0F 57            [ 1] 1470 	clr	(0x57, sp)
      0089D3 0F 58            [ 1] 1471 	clr	(0x58, sp)
      0089D5 0F 59            [ 1] 1472 	clr	(0x59, sp)
      0089D7 0F 5A            [ 1] 1473 	clr	(0x5a, sp)
      0089D9 0F 5B            [ 1] 1474 	clr	(0x5b, sp)
      0089DB 0F 5C            [ 1] 1475 	clr	(0x5c, sp)
      0089DD 0F 5D            [ 1] 1476 	clr	(0x5d, sp)
      0089DF 0F 5E            [ 1] 1477 	clr	(0x5e, sp)
      0089E1 0F 5F            [ 1] 1478 	clr	(0x5f, sp)
      0089E3 0F 60            [ 1] 1479 	clr	(0x60, sp)
      0089E5 0F 61            [ 1] 1480 	clr	(0x61, sp)
      0089E7 0F 62            [ 1] 1481 	clr	(0x62, sp)
      0089E9 0F 63            [ 1] 1482 	clr	(0x63, sp)
      0089EB 0F 64            [ 1] 1483 	clr	(0x64, sp)
      0089ED 0F 65            [ 1] 1484 	clr	(0x65, sp)
      0089EF 0F 66            [ 1] 1485 	clr	(0x66, sp)
      0089F1 0F 67            [ 1] 1486 	clr	(0x67, sp)
      0089F3 0F 68            [ 1] 1487 	clr	(0x68, sp)
      0089F5 0F 69            [ 1] 1488 	clr	(0x69, sp)
      0089F7 0F 6A            [ 1] 1489 	clr	(0x6a, sp)
      0089F9 0F 6B            [ 1] 1490 	clr	(0x6b, sp)
      0089FB 0F 6C            [ 1] 1491 	clr	(0x6c, sp)
      0089FD 0F 6D            [ 1] 1492 	clr	(0x6d, sp)
      0089FF 0F 6E            [ 1] 1493 	clr	(0x6e, sp)
      008A01 0F 6F            [ 1] 1494 	clr	(0x6f, sp)
      008A03 0F 70            [ 1] 1495 	clr	(0x70, sp)
      008A05 0F 71            [ 1] 1496 	clr	(0x71, sp)
      008A07 0F 72            [ 1] 1497 	clr	(0x72, sp)
      008A09 0F 73            [ 1] 1498 	clr	(0x73, sp)
      008A0B 0F 74            [ 1] 1499 	clr	(0x74, sp)
      008A0D 0F 75            [ 1] 1500 	clr	(0x75, sp)
      008A0F 0F 76            [ 1] 1501 	clr	(0x76, sp)
      008A11 0F 77            [ 1] 1502 	clr	(0x77, sp)
      008A13 0F 78            [ 1] 1503 	clr	(0x78, sp)
      008A15 0F 79            [ 1] 1504 	clr	(0x79, sp)
      008A17 0F 7A            [ 1] 1505 	clr	(0x7a, sp)
      008A19 0F 7B            [ 1] 1506 	clr	(0x7b, sp)
      008A1B 0F 7C            [ 1] 1507 	clr	(0x7c, sp)
      008A1D 0F 7D            [ 1] 1508 	clr	(0x7d, sp)
      008A1F 0F 7E            [ 1] 1509 	clr	(0x7e, sp)
      008A21 0F 7F            [ 1] 1510 	clr	(0x7f, sp)
      008A23 0F 80            [ 1] 1511 	clr	(0x80, sp)
      008A25 0F 81            [ 1] 1512 	clr	(0x81, sp)
                                   1513 ;	main.c: 121: display_set_params_to_write();
      008A27 CD 87 18         [ 4] 1514 	call	_display_set_params_to_write
                                   1515 ;	main.c: 123: for(int i = 0;i<4;i++)
      008A2A 4F               [ 1] 1516 	clr	a
      008A2B                       1517 00103$:
      008A2B A1 04            [ 1] 1518 	cp	a, #0x04
      008A2D 24 10            [ 1] 1519 	jrnc	00105$
                                   1520 ;	main.c: 124: i2c_write(I2C_DISPLAY_ADDR,129,clean_buf);
      008A2F 88               [ 1] 1521 	push	a
      008A30 96               [ 1] 1522 	ldw	x, sp
      008A31 5C               [ 1] 1523 	incw	x
      008A32 5C               [ 1] 1524 	incw	x
      008A33 89               [ 2] 1525 	pushw	x
      008A34 4B 81            [ 1] 1526 	push	#0x81
      008A36 A6 3C            [ 1] 1527 	ld	a, #0x3c
      008A38 CD 85 70         [ 4] 1528 	call	_i2c_write
      008A3B 84               [ 1] 1529 	pop	a
                                   1530 ;	main.c: 123: for(int i = 0;i<4;i++)
      008A3C 4C               [ 1] 1531 	inc	a
      008A3D 20 EC            [ 2] 1532 	jra	00103$
      008A3F                       1533 00105$:
                                   1534 ;	main.c: 126: }
      008A3F 5B 81            [ 2] 1535 	addw	sp, #129
      008A41 81               [ 4] 1536 	ret
                                   1537 ;	main.c: 128: void gg(void)
                                   1538 ;	-----------------------------------------
                                   1539 ;	 function gg
                                   1540 ;	-----------------------------------------
      008A42                       1541 _gg:
                                   1542 ;	main.c: 130: display_init();
      008A42 CD 86 35         [ 4] 1543 	call	_display_init
                                   1544 ;	main.c: 131: display_clean();
      008A45 CD 89 21         [ 4] 1545 	call	_display_clean
                                   1546 ;	main.c: 132: display_buffer_fill_entire(splash);
      008A48 AE 00 08         [ 2] 1547 	ldw	x, #(_splash+0)
                                   1548 ;	main.c: 133: }
      008A4B CC 87 89         [ 2] 1549 	jp	_display_buffer_fill_entire
                                   1550 ;	main.c: 135: int main(void)
                                   1551 ;	-----------------------------------------
                                   1552 ;	 function main
                                   1553 ;	-----------------------------------------
      008A4E                       1554 _main:
                                   1555 ;	main.c: 137: setup();
      008A4E CD 85 D3         [ 4] 1556 	call	_setup
                                   1557 ;	main.c: 138: gg();
      008A51 CD 8A 42         [ 4] 1558 	call	_gg
                                   1559 ;	main.c: 139: while(1);
      008A54                       1560 00102$:
      008A54 20 FE            [ 2] 1561 	jra	00102$
                                   1562 ;	main.c: 140: }
      008A56 81               [ 4] 1563 	ret
                                   1564 	.area CODE
                                   1565 	.area CONST
                                   1566 	.area CONST
      00807D                       1567 ___str_0:
      00807D 72 78 5F 62 75 66 5F  1568 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808B 0A                    1569 	.db 0x0a
      00808C 00                    1570 	.db 0x00
                                   1571 	.area CODE
                                   1572 	.area CONST
      00808D                       1573 ___str_1:
      00808D 62 75 66 5F 70 6F 73  1574 	.ascii "buf_pos"
      008094 0A                    1575 	.db 0x0a
      008095 00                    1576 	.db 0x00
                                   1577 	.area CODE
                                   1578 	.area CONST
      008096                       1579 ___str_2:
      008096 62 75 66 5F 73 69 7A  1580 	.ascii "buf_size"
             65
      00809E 0A                    1581 	.db 0x0a
      00809F 00                    1582 	.db 0x00
                                   1583 	.area CODE
                                   1584 	.area CONST
      0080A0                       1585 ___str_3:
      0080A0 52 49 45 4E           1586 	.ascii "RIEN"
      0080A4 0A                    1587 	.db 0x0a
      0080A5 00                    1588 	.db 0x00
                                   1589 	.area CODE
                                   1590 	.area INITIALIZER
      0080A6                       1591 __xinit__I2C_IRQ:
      0080A6 00                    1592 	.db #0x00	; 0
      0080A7                       1593 __xinit__splash:
      0080A7 FF                    1594 	.db #0xff	; 255
      0080A8 FF                    1595 	.db #0xff	; 255
      0080A9 FF                    1596 	.db #0xff	; 255
      0080AA FF                    1597 	.db #0xff	; 255
      0080AB FF                    1598 	.db #0xff	; 255
      0080AC FF                    1599 	.db #0xff	; 255
      0080AD FF                    1600 	.db #0xff	; 255
      0080AE FF                    1601 	.db #0xff	; 255
      0080AF FF                    1602 	.db #0xff	; 255
      0080B0 FF                    1603 	.db #0xff	; 255
      0080B1 FF                    1604 	.db #0xff	; 255
      0080B2 FF                    1605 	.db #0xff	; 255
      0080B3 FF                    1606 	.db #0xff	; 255
      0080B4 FF                    1607 	.db #0xff	; 255
      0080B5 FF                    1608 	.db #0xff	; 255
      0080B6 FF                    1609 	.db #0xff	; 255
      0080B7 80                    1610 	.db #0x80	; 128
      0080B8 00                    1611 	.db #0x00	; 0
      0080B9 00                    1612 	.db #0x00	; 0
      0080BA 00                    1613 	.db #0x00	; 0
      0080BB 00                    1614 	.db #0x00	; 0
      0080BC 00                    1615 	.db #0x00	; 0
      0080BD 00                    1616 	.db #0x00	; 0
      0080BE 00                    1617 	.db #0x00	; 0
      0080BF 00                    1618 	.db #0x00	; 0
      0080C0 00                    1619 	.db #0x00	; 0
      0080C1 00                    1620 	.db #0x00	; 0
      0080C2 00                    1621 	.db #0x00	; 0
      0080C3 00                    1622 	.db #0x00	; 0
      0080C4 00                    1623 	.db #0x00	; 0
      0080C5 00                    1624 	.db #0x00	; 0
      0080C6 01                    1625 	.db #0x01	; 1
      0080C7 80                    1626 	.db #0x80	; 128
      0080C8 FE                    1627 	.db #0xfe	; 254
      0080C9 03                    1628 	.db #0x03	; 3
      0080CA FF                    1629 	.db #0xff	; 255
      0080CB FF                    1630 	.db #0xff	; 255
      0080CC FF                    1631 	.db #0xff	; 255
      0080CD FF                    1632 	.db #0xff	; 255
      0080CE 80                    1633 	.db #0x80	; 128
      0080CF FF                    1634 	.db #0xff	; 255
      0080D0 FF                    1635 	.db #0xff	; 255
      0080D1 F8                    1636 	.db #0xf8	; 248
      0080D2 00                    1637 	.db #0x00	; 0
      0080D3 1D                    1638 	.db #0x1d	; 29
      0080D4 1D                    1639 	.db #0x1d	; 29
      0080D5 5C                    1640 	.db #0x5c	; 92
      0080D6 ED                    1641 	.db #0xed	; 237
      0080D7 80                    1642 	.db #0x80	; 128
      0080D8 FE                    1643 	.db #0xfe	; 254
      0080D9 03                    1644 	.db #0x03	; 3
      0080DA FF                    1645 	.db #0xff	; 255
      0080DB FF                    1646 	.db #0xff	; 255
      0080DC FF                    1647 	.db #0xff	; 255
      0080DD FF                    1648 	.db #0xff	; 255
      0080DE 80                    1649 	.db #0x80	; 128
      0080DF FF                    1650 	.db #0xff	; 255
      0080E0 FF                    1651 	.db #0xff	; 255
      0080E1 F8                    1652 	.db #0xf8	; 248
      0080E2 00                    1653 	.db #0x00	; 0
      0080E3 15                    1654 	.db #0x15	; 21
      0080E4 15                    1655 	.db #0x15	; 21
      0080E5 54                    1656 	.db #0x54	; 84	'T'
      0080E6 A5                    1657 	.db #0xa5	; 165
      0080E7 80                    1658 	.db #0x80	; 128
      0080E8 FE                    1659 	.db #0xfe	; 254
      0080E9 03                    1660 	.db #0x03	; 3
      0080EA FF                    1661 	.db #0xff	; 255
      0080EB FF                    1662 	.db #0xff	; 255
      0080EC FF                    1663 	.db #0xff	; 255
      0080ED FF                    1664 	.db #0xff	; 255
      0080EE 80                    1665 	.db #0x80	; 128
      0080EF FF                    1666 	.db #0xff	; 255
      0080F0 FF                    1667 	.db #0xff	; 255
      0080F1 F8                    1668 	.db #0xf8	; 248
      0080F2 00                    1669 	.db #0x00	; 0
      0080F3 1D                    1670 	.db #0x1d	; 29
      0080F4 1D                    1671 	.db #0x1d	; 29
      0080F5 DC                    1672 	.db #0xdc	; 220
      0080F6 A5                    1673 	.db #0xa5	; 165
      0080F7 80                    1674 	.db #0x80	; 128
      0080F8 FE                    1675 	.db #0xfe	; 254
      0080F9 03                    1676 	.db #0x03	; 3
      0080FA FF                    1677 	.db #0xff	; 255
      0080FB FF                    1678 	.db #0xff	; 255
      0080FC FF                    1679 	.db #0xff	; 255
      0080FD FF                    1680 	.db #0xff	; 255
      0080FE 80                    1681 	.db #0x80	; 128
      0080FF FF                    1682 	.db #0xff	; 255
      008100 FF                    1683 	.db #0xff	; 255
      008101 F8                    1684 	.db #0xf8	; 248
      008102 00                    1685 	.db #0x00	; 0
      008103 15                    1686 	.db #0x15	; 21
      008104 D1                    1687 	.db #0xd1	; 209
      008105 54                    1688 	.db #0x54	; 84	'T'
      008106 E5                    1689 	.db #0xe5	; 229
      008107 80                    1690 	.db #0x80	; 128
      008108 FE                    1691 	.db #0xfe	; 254
      008109 03                    1692 	.db #0x03	; 3
      00810A FF                    1693 	.db #0xff	; 255
      00810B FF                    1694 	.db #0xff	; 255
      00810C FF                    1695 	.db #0xff	; 255
      00810D FF                    1696 	.db #0xff	; 255
      00810E 80                    1697 	.db #0x80	; 128
      00810F FF                    1698 	.db #0xff	; 255
      008110 FF                    1699 	.db #0xff	; 255
      008111 F8                    1700 	.db #0xf8	; 248
      008112 00                    1701 	.db #0x00	; 0
      008113 00                    1702 	.db #0x00	; 0
      008114 00                    1703 	.db #0x00	; 0
      008115 00                    1704 	.db #0x00	; 0
      008116 01                    1705 	.db #0x01	; 1
      008117 80                    1706 	.db #0x80	; 128
      008118 FE                    1707 	.db #0xfe	; 254
      008119 03                    1708 	.db #0x03	; 3
      00811A FF                    1709 	.db #0xff	; 255
      00811B FF                    1710 	.db #0xff	; 255
      00811C FF                    1711 	.db #0xff	; 255
      00811D FF                    1712 	.db #0xff	; 255
      00811E 80                    1713 	.db #0x80	; 128
      00811F FF                    1714 	.db #0xff	; 255
      008120 FF                    1715 	.db #0xff	; 255
      008121 F8                    1716 	.db #0xf8	; 248
      008122 00                    1717 	.db #0x00	; 0
      008123 00                    1718 	.db #0x00	; 0
      008124 00                    1719 	.db #0x00	; 0
      008125 00                    1720 	.db #0x00	; 0
      008126 01                    1721 	.db #0x01	; 1
      008127 80                    1722 	.db #0x80	; 128
      008128 FE                    1723 	.db #0xfe	; 254
      008129 03                    1724 	.db #0x03	; 3
      00812A FF                    1725 	.db #0xff	; 255
      00812B FF                    1726 	.db #0xff	; 255
      00812C FF                    1727 	.db #0xff	; 255
      00812D FF                    1728 	.db #0xff	; 255
      00812E 80                    1729 	.db #0x80	; 128
      00812F FF                    1730 	.db #0xff	; 255
      008130 FF                    1731 	.db #0xff	; 255
      008131 F8                    1732 	.db #0xf8	; 248
      008132 00                    1733 	.db #0x00	; 0
      008133 00                    1734 	.db #0x00	; 0
      008134 00                    1735 	.db #0x00	; 0
      008135 00                    1736 	.db #0x00	; 0
      008136 01                    1737 	.db #0x01	; 1
      008137 80                    1738 	.db #0x80	; 128
      008138 FF                    1739 	.db #0xff	; 255
      008139 FF                    1740 	.db #0xff	; 255
      00813A F8                    1741 	.db #0xf8	; 248
      00813B 0F                    1742 	.db #0x0f	; 15
      00813C E0                    1743 	.db #0xe0	; 224
      00813D 3F                    1744 	.db #0x3f	; 63
      00813E 80                    1745 	.db #0x80	; 128
      00813F FE                    1746 	.db #0xfe	; 254
      008140 03                    1747 	.db #0x03	; 3
      008141 F8                    1748 	.db #0xf8	; 248
      008142 00                    1749 	.db #0x00	; 0
      008143 00                    1750 	.db #0x00	; 0
      008144 00                    1751 	.db #0x00	; 0
      008145 00                    1752 	.db #0x00	; 0
      008146 01                    1753 	.db #0x01	; 1
      008147 80                    1754 	.db #0x80	; 128
      008148 FF                    1755 	.db #0xff	; 255
      008149 FF                    1756 	.db #0xff	; 255
      00814A F8                    1757 	.db #0xf8	; 248
      00814B 0F                    1758 	.db #0x0f	; 15
      00814C E0                    1759 	.db #0xe0	; 224
      00814D 3F                    1760 	.db #0x3f	; 63
      00814E 80                    1761 	.db #0x80	; 128
      00814F FE                    1762 	.db #0xfe	; 254
      008150 03                    1763 	.db #0x03	; 3
      008151 F8                    1764 	.db #0xf8	; 248
      008152 00                    1765 	.db #0x00	; 0
      008153 00                    1766 	.db #0x00	; 0
      008154 00                    1767 	.db #0x00	; 0
      008155 00                    1768 	.db #0x00	; 0
      008156 01                    1769 	.db #0x01	; 1
      008157 80                    1770 	.db #0x80	; 128
      008158 FF                    1771 	.db #0xff	; 255
      008159 FF                    1772 	.db #0xff	; 255
      00815A F8                    1773 	.db #0xf8	; 248
      00815B 0F                    1774 	.db #0x0f	; 15
      00815C E0                    1775 	.db #0xe0	; 224
      00815D 3F                    1776 	.db #0x3f	; 63
      00815E 80                    1777 	.db #0x80	; 128
      00815F FE                    1778 	.db #0xfe	; 254
      008160 03                    1779 	.db #0x03	; 3
      008161 F8                    1780 	.db #0xf8	; 248
      008162 00                    1781 	.db #0x00	; 0
      008163 00                    1782 	.db #0x00	; 0
      008164 00                    1783 	.db #0x00	; 0
      008165 00                    1784 	.db #0x00	; 0
      008166 01                    1785 	.db #0x01	; 1
      008167 80                    1786 	.db #0x80	; 128
      008168 FF                    1787 	.db #0xff	; 255
      008169 FF                    1788 	.db #0xff	; 255
      00816A F8                    1789 	.db #0xf8	; 248
      00816B 0F                    1790 	.db #0x0f	; 15
      00816C E0                    1791 	.db #0xe0	; 224
      00816D 3F                    1792 	.db #0x3f	; 63
      00816E 80                    1793 	.db #0x80	; 128
      00816F FE                    1794 	.db #0xfe	; 254
      008170 03                    1795 	.db #0x03	; 3
      008171 F8                    1796 	.db #0xf8	; 248
      008172 00                    1797 	.db #0x00	; 0
      008173 00                    1798 	.db #0x00	; 0
      008174 00                    1799 	.db #0x00	; 0
      008175 00                    1800 	.db #0x00	; 0
      008176 01                    1801 	.db #0x01	; 1
      008177 80                    1802 	.db #0x80	; 128
      008178 FF                    1803 	.db #0xff	; 255
      008179 FF                    1804 	.db #0xff	; 255
      00817A F8                    1805 	.db #0xf8	; 248
      00817B 0F                    1806 	.db #0x0f	; 15
      00817C E0                    1807 	.db #0xe0	; 224
      00817D 3F                    1808 	.db #0x3f	; 63
      00817E 80                    1809 	.db #0x80	; 128
      00817F FE                    1810 	.db #0xfe	; 254
      008180 03                    1811 	.db #0x03	; 3
      008181 F8                    1812 	.db #0xf8	; 248
      008182 00                    1813 	.db #0x00	; 0
      008183 00                    1814 	.db #0x00	; 0
      008184 00                    1815 	.db #0x00	; 0
      008185 00                    1816 	.db #0x00	; 0
      008186 01                    1817 	.db #0x01	; 1
      008187 80                    1818 	.db #0x80	; 128
      008188 FF                    1819 	.db #0xff	; 255
      008189 FF                    1820 	.db #0xff	; 255
      00818A F8                    1821 	.db #0xf8	; 248
      00818B 0F                    1822 	.db #0x0f	; 15
      00818C E0                    1823 	.db #0xe0	; 224
      00818D 3F                    1824 	.db #0x3f	; 63
      00818E 80                    1825 	.db #0x80	; 128
      00818F FE                    1826 	.db #0xfe	; 254
      008190 03                    1827 	.db #0x03	; 3
      008191 F8                    1828 	.db #0xf8	; 248
      008192 00                    1829 	.db #0x00	; 0
      008193 00                    1830 	.db #0x00	; 0
      008194 00                    1831 	.db #0x00	; 0
      008195 00                    1832 	.db #0x00	; 0
      008196 01                    1833 	.db #0x01	; 1
      008197 80                    1834 	.db #0x80	; 128
      008198 FF                    1835 	.db #0xff	; 255
      008199 FF                    1836 	.db #0xff	; 255
      00819A F8                    1837 	.db #0xf8	; 248
      00819B 0F                    1838 	.db #0x0f	; 15
      00819C E0                    1839 	.db #0xe0	; 224
      00819D 3F                    1840 	.db #0x3f	; 63
      00819E 80                    1841 	.db #0x80	; 128
      00819F FE                    1842 	.db #0xfe	; 254
      0081A0 03                    1843 	.db #0x03	; 3
      0081A1 F8                    1844 	.db #0xf8	; 248
      0081A2 00                    1845 	.db #0x00	; 0
      0081A3 00                    1846 	.db #0x00	; 0
      0081A4 00                    1847 	.db #0x00	; 0
      0081A5 00                    1848 	.db #0x00	; 0
      0081A6 01                    1849 	.db #0x01	; 1
      0081A7 80                    1850 	.db #0x80	; 128
      0081A8 FE                    1851 	.db #0xfe	; 254
      0081A9 03                    1852 	.db #0x03	; 3
      0081AA F8                    1853 	.db #0xf8	; 248
      0081AB 0F                    1854 	.db #0x0f	; 15
      0081AC E0                    1855 	.db #0xe0	; 224
      0081AD 3F                    1856 	.db #0x3f	; 63
      0081AE FF                    1857 	.db #0xff	; 255
      0081AF FF                    1858 	.db #0xff	; 255
      0081B0 FC                    1859 	.db #0xfc	; 252
      0081B1 00                    1860 	.db #0x00	; 0
      0081B2 00                    1861 	.db #0x00	; 0
      0081B3 00                    1862 	.db #0x00	; 0
      0081B4 00                    1863 	.db #0x00	; 0
      0081B5 00                    1864 	.db #0x00	; 0
      0081B6 01                    1865 	.db #0x01	; 1
      0081B7 80                    1866 	.db #0x80	; 128
      0081B8 FE                    1867 	.db #0xfe	; 254
      0081B9 03                    1868 	.db #0x03	; 3
      0081BA F8                    1869 	.db #0xf8	; 248
      0081BB 0F                    1870 	.db #0x0f	; 15
      0081BC E0                    1871 	.db #0xe0	; 224
      0081BD 3F                    1872 	.db #0x3f	; 63
      0081BE FF                    1873 	.db #0xff	; 255
      0081BF FF                    1874 	.db #0xff	; 255
      0081C0 FC                    1875 	.db #0xfc	; 252
      0081C1 00                    1876 	.db #0x00	; 0
      0081C2 00                    1877 	.db #0x00	; 0
      0081C3 00                    1878 	.db #0x00	; 0
      0081C4 00                    1879 	.db #0x00	; 0
      0081C5 00                    1880 	.db #0x00	; 0
      0081C6 01                    1881 	.db #0x01	; 1
      0081C7 80                    1882 	.db #0x80	; 128
      0081C8 FE                    1883 	.db #0xfe	; 254
      0081C9 03                    1884 	.db #0x03	; 3
      0081CA F8                    1885 	.db #0xf8	; 248
      0081CB 0F                    1886 	.db #0x0f	; 15
      0081CC E0                    1887 	.db #0xe0	; 224
      0081CD 3F                    1888 	.db #0x3f	; 63
      0081CE FF                    1889 	.db #0xff	; 255
      0081CF FF                    1890 	.db #0xff	; 255
      0081D0 FC                    1891 	.db #0xfc	; 252
      0081D1 00                    1892 	.db #0x00	; 0
      0081D2 00                    1893 	.db #0x00	; 0
      0081D3 00                    1894 	.db #0x00	; 0
      0081D4 00                    1895 	.db #0x00	; 0
      0081D5 00                    1896 	.db #0x00	; 0
      0081D6 01                    1897 	.db #0x01	; 1
      0081D7 80                    1898 	.db #0x80	; 128
      0081D8 FE                    1899 	.db #0xfe	; 254
      0081D9 03                    1900 	.db #0x03	; 3
      0081DA F8                    1901 	.db #0xf8	; 248
      0081DB 0F                    1902 	.db #0x0f	; 15
      0081DC E0                    1903 	.db #0xe0	; 224
      0081DD 3F                    1904 	.db #0x3f	; 63
      0081DE FF                    1905 	.db #0xff	; 255
      0081DF FF                    1906 	.db #0xff	; 255
      0081E0 FC                    1907 	.db #0xfc	; 252
      0081E1 00                    1908 	.db #0x00	; 0
      0081E2 00                    1909 	.db #0x00	; 0
      0081E3 00                    1910 	.db #0x00	; 0
      0081E4 00                    1911 	.db #0x00	; 0
      0081E5 00                    1912 	.db #0x00	; 0
      0081E6 01                    1913 	.db #0x01	; 1
      0081E7 80                    1914 	.db #0x80	; 128
      0081E8 FE                    1915 	.db #0xfe	; 254
      0081E9 03                    1916 	.db #0x03	; 3
      0081EA F8                    1917 	.db #0xf8	; 248
      0081EB 0F                    1918 	.db #0x0f	; 15
      0081EC E0                    1919 	.db #0xe0	; 224
      0081ED 3F                    1920 	.db #0x3f	; 63
      0081EE FF                    1921 	.db #0xff	; 255
      0081EF FF                    1922 	.db #0xff	; 255
      0081F0 FC                    1923 	.db #0xfc	; 252
      0081F1 00                    1924 	.db #0x00	; 0
      0081F2 00                    1925 	.db #0x00	; 0
      0081F3 00                    1926 	.db #0x00	; 0
      0081F4 00                    1927 	.db #0x00	; 0
      0081F5 00                    1928 	.db #0x00	; 0
      0081F6 01                    1929 	.db #0x01	; 1
      0081F7 80                    1930 	.db #0x80	; 128
      0081F8 FE                    1931 	.db #0xfe	; 254
      0081F9 03                    1932 	.db #0x03	; 3
      0081FA F8                    1933 	.db #0xf8	; 248
      0081FB 0F                    1934 	.db #0x0f	; 15
      0081FC E0                    1935 	.db #0xe0	; 224
      0081FD 3F                    1936 	.db #0x3f	; 63
      0081FE FF                    1937 	.db #0xff	; 255
      0081FF FF                    1938 	.db #0xff	; 255
      008200 FC                    1939 	.db #0xfc	; 252
      008201 00                    1940 	.db #0x00	; 0
      008202 00                    1941 	.db #0x00	; 0
      008203 00                    1942 	.db #0x00	; 0
      008204 00                    1943 	.db #0x00	; 0
      008205 00                    1944 	.db #0x00	; 0
      008206 01                    1945 	.db #0x01	; 1
      008207 80                    1946 	.db #0x80	; 128
      008208 FE                    1947 	.db #0xfe	; 254
      008209 03                    1948 	.db #0x03	; 3
      00820A F8                    1949 	.db #0xf8	; 248
      00820B 0F                    1950 	.db #0x0f	; 15
      00820C E0                    1951 	.db #0xe0	; 224
      00820D 3F                    1952 	.db #0x3f	; 63
      00820E FF                    1953 	.db #0xff	; 255
      00820F FF                    1954 	.db #0xff	; 255
      008210 FC                    1955 	.db #0xfc	; 252
      008211 00                    1956 	.db #0x00	; 0
      008212 00                    1957 	.db #0x00	; 0
      008213 00                    1958 	.db #0x00	; 0
      008214 00                    1959 	.db #0x00	; 0
      008215 00                    1960 	.db #0x00	; 0
      008216 01                    1961 	.db #0x01	; 1
      008217 80                    1962 	.db #0x80	; 128
      008218 FE                    1963 	.db #0xfe	; 254
      008219 03                    1964 	.db #0x03	; 3
      00821A F8                    1965 	.db #0xf8	; 248
      00821B 0F                    1966 	.db #0x0f	; 15
      00821C E0                    1967 	.db #0xe0	; 224
      00821D 3F                    1968 	.db #0x3f	; 63
      00821E 80                    1969 	.db #0x80	; 128
      00821F FE                    1970 	.db #0xfe	; 254
      008220 03                    1971 	.db #0x03	; 3
      008221 F8                    1972 	.db #0xf8	; 248
      008222 FE                    1973 	.db #0xfe	; 254
      008223 00                    1974 	.db #0x00	; 0
      008224 00                    1975 	.db #0x00	; 0
      008225 00                    1976 	.db #0x00	; 0
      008226 01                    1977 	.db #0x01	; 1
      008227 80                    1978 	.db #0x80	; 128
      008228 FE                    1979 	.db #0xfe	; 254
      008229 03                    1980 	.db #0x03	; 3
      00822A F8                    1981 	.db #0xf8	; 248
      00822B 0F                    1982 	.db #0x0f	; 15
      00822C E0                    1983 	.db #0xe0	; 224
      00822D 3F                    1984 	.db #0x3f	; 63
      00822E 80                    1985 	.db #0x80	; 128
      00822F FE                    1986 	.db #0xfe	; 254
      008230 03                    1987 	.db #0x03	; 3
      008231 F8                    1988 	.db #0xf8	; 248
      008232 FE                    1989 	.db #0xfe	; 254
      008233 7C                    1990 	.db #0x7c	; 124
      008234 7E                    1991 	.db #0x7e	; 126
      008235 00                    1992 	.db #0x00	; 0
      008236 01                    1993 	.db #0x01	; 1
      008237 80                    1994 	.db #0x80	; 128
      008238 FE                    1995 	.db #0xfe	; 254
      008239 03                    1996 	.db #0x03	; 3
      00823A F8                    1997 	.db #0xf8	; 248
      00823B 0F                    1998 	.db #0x0f	; 15
      00823C E0                    1999 	.db #0xe0	; 224
      00823D 3F                    2000 	.db #0x3f	; 63
      00823E 80                    2001 	.db #0x80	; 128
      00823F FE                    2002 	.db #0xfe	; 254
      008240 03                    2003 	.db #0x03	; 3
      008241 F8                    2004 	.db #0xf8	; 248
      008242 38                    2005 	.db #0x38	; 56	'8'
      008243 7E                    2006 	.db #0x7e	; 126
      008244 7E                    2007 	.db #0x7e	; 126
      008245 00                    2008 	.db #0x00	; 0
      008246 01                    2009 	.db #0x01	; 1
      008247 80                    2010 	.db #0x80	; 128
      008248 FE                    2011 	.db #0xfe	; 254
      008249 03                    2012 	.db #0x03	; 3
      00824A F8                    2013 	.db #0xf8	; 248
      00824B 0F                    2014 	.db #0x0f	; 15
      00824C E0                    2015 	.db #0xe0	; 224
      00824D 3F                    2016 	.db #0x3f	; 63
      00824E 80                    2017 	.db #0x80	; 128
      00824F FE                    2018 	.db #0xfe	; 254
      008250 03                    2019 	.db #0x03	; 3
      008251 F8                    2020 	.db #0xf8	; 248
      008252 38                    2021 	.db #0x38	; 56	'8'
      008253 66                    2022 	.db #0x66	; 102	'f'
      008254 60                    2023 	.db #0x60	; 96
      008255 00                    2024 	.db #0x00	; 0
      008256 01                    2025 	.db #0x01	; 1
      008257 80                    2026 	.db #0x80	; 128
      008258 FE                    2027 	.db #0xfe	; 254
      008259 03                    2028 	.db #0x03	; 3
      00825A F8                    2029 	.db #0xf8	; 248
      00825B 0F                    2030 	.db #0x0f	; 15
      00825C E0                    2031 	.db #0xe0	; 224
      00825D 3F                    2032 	.db #0x3f	; 63
      00825E 80                    2033 	.db #0x80	; 128
      00825F FE                    2034 	.db #0xfe	; 254
      008260 03                    2035 	.db #0x03	; 3
      008261 F8                    2036 	.db #0xf8	; 248
      008262 38                    2037 	.db #0x38	; 56	'8'
      008263 66                    2038 	.db #0x66	; 102	'f'
      008264 60                    2039 	.db #0x60	; 96
      008265 00                    2040 	.db #0x00	; 0
      008266 01                    2041 	.db #0x01	; 1
      008267 80                    2042 	.db #0x80	; 128
      008268 FE                    2043 	.db #0xfe	; 254
      008269 03                    2044 	.db #0x03	; 3
      00826A F8                    2045 	.db #0xf8	; 248
      00826B 0F                    2046 	.db #0x0f	; 15
      00826C E0                    2047 	.db #0xe0	; 224
      00826D 3F                    2048 	.db #0x3f	; 63
      00826E 80                    2049 	.db #0x80	; 128
      00826F FE                    2050 	.db #0xfe	; 254
      008270 03                    2051 	.db #0x03	; 3
      008271 F8                    2052 	.db #0xf8	; 248
      008272 FE                    2053 	.db #0xfe	; 254
      008273 66                    2054 	.db #0x66	; 102	'f'
      008274 7E                    2055 	.db #0x7e	; 126
      008275 18                    2056 	.db #0x18	; 24
      008276 01                    2057 	.db #0x01	; 1
      008277 80                    2058 	.db #0x80	; 128
      008278 FE                    2059 	.db #0xfe	; 254
      008279 03                    2060 	.db #0x03	; 3
      00827A F8                    2061 	.db #0xf8	; 248
      00827B 0F                    2062 	.db #0x0f	; 15
      00827C E0                    2063 	.db #0xe0	; 224
      00827D 3F                    2064 	.db #0x3f	; 63
      00827E 80                    2065 	.db #0x80	; 128
      00827F FE                    2066 	.db #0xfe	; 254
      008280 03                    2067 	.db #0x03	; 3
      008281 F8                    2068 	.db #0xf8	; 248
      008282 FE                    2069 	.db #0xfe	; 254
      008283 66                    2070 	.db #0x66	; 102	'f'
      008284 7E                    2071 	.db #0x7e	; 126
      008285 18                    2072 	.db #0x18	; 24
      008286 01                    2073 	.db #0x01	; 1
      008287 80                    2074 	.db #0x80	; 128
      008288 00                    2075 	.db #0x00	; 0
      008289 00                    2076 	.db #0x00	; 0
      00828A 00                    2077 	.db #0x00	; 0
      00828B 00                    2078 	.db #0x00	; 0
      00828C 00                    2079 	.db #0x00	; 0
      00828D 00                    2080 	.db #0x00	; 0
      00828E 00                    2081 	.db #0x00	; 0
      00828F 00                    2082 	.db #0x00	; 0
      008290 00                    2083 	.db #0x00	; 0
      008291 00                    2084 	.db #0x00	; 0
      008292 00                    2085 	.db #0x00	; 0
      008293 00                    2086 	.db #0x00	; 0
      008294 00                    2087 	.db #0x00	; 0
      008295 00                    2088 	.db #0x00	; 0
      008296 01                    2089 	.db #0x01	; 1
      008297 FF                    2090 	.db #0xff	; 255
      008298 FF                    2091 	.db #0xff	; 255
      008299 FF                    2092 	.db #0xff	; 255
      00829A FF                    2093 	.db #0xff	; 255
      00829B FF                    2094 	.db #0xff	; 255
      00829C FF                    2095 	.db #0xff	; 255
      00829D FF                    2096 	.db #0xff	; 255
      00829E FF                    2097 	.db #0xff	; 255
      00829F FF                    2098 	.db #0xff	; 255
      0082A0 FF                    2099 	.db #0xff	; 255
      0082A1 FF                    2100 	.db #0xff	; 255
      0082A2 FF                    2101 	.db #0xff	; 255
      0082A3 FF                    2102 	.db #0xff	; 255
      0082A4 FF                    2103 	.db #0xff	; 255
      0082A5 FF                    2104 	.db #0xff	; 255
      0082A6 FF                    2105 	.db #0xff	; 255
                                   2106 	.area CABS (ABS)
