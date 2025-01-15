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
                                     14 	.globl _display_set
                                     15 	.globl _display_buffer_fill_entire
                                     16 	.globl _display_draw_pixel
                                     17 	.globl _display_set_params_to_write
                                     18 	.globl _display_init
                                     19 	.globl _delay
                                     20 	.globl _set_bit
                                     21 	.globl _get_bit
                                     22 	.globl _setup
                                     23 	.globl _i2c_scan
                                     24 	.globl _i2c_write
                                     25 	.globl _i2c_send_byte
                                     26 	.globl _i2c_read
                                     27 	.globl _i2c_read_byte
                                     28 	.globl _i2c_send_address
                                     29 	.globl _i2c_stop
                                     30 	.globl _i2c_start
                                     31 	.globl _i2c_init
                                     32 	.globl _uart_read
                                     33 	.globl _uart_write_byte
                                     34 	.globl _uart_read_byte
                                     35 	.globl _uart_init
                                     36 	.globl _uart_reciever_irq
                                     37 	.globl _uart_transmission_irq
                                     38 	.globl _splash
                                     39 	.globl _I2C_IRQ
                                     40 	.globl _buf_size
                                     41 	.globl _buf_pos
                                     42 	.globl _rx_buf_pointer
                                     43 	.globl _tx_buf_pointer
                                     44 	.globl _uart_write
                                     45 ;--------------------------------------------------------
                                     46 ; ram data
                                     47 ;--------------------------------------------------------
                                     48 	.area DATA
      000001                         49 _tx_buf_pointer::
      000001                         50 	.ds 2
      000003                         51 _rx_buf_pointer::
      000003                         52 	.ds 2
      000005                         53 _buf_pos::
      000005                         54 	.ds 1
      000006                         55 _buf_size::
      000006                         56 	.ds 1
                                     57 ;--------------------------------------------------------
                                     58 ; ram data
                                     59 ;--------------------------------------------------------
                                     60 	.area INITIALIZED
      000007                         61 _I2C_IRQ::
      000007                         62 	.ds 1
      000008                         63 _splash::
      000008                         64 	.ds 512
                                     65 ;--------------------------------------------------------
                                     66 ; Stack segment in internal ram
                                     67 ;--------------------------------------------------------
                                     68 	.area SSEG
      000208                         69 __start__stack:
      000208                         70 	.ds	1
                                     71 
                                     72 ;--------------------------------------------------------
                                     73 ; absolute external ram data
                                     74 ;--------------------------------------------------------
                                     75 	.area DABS (ABS)
                                     76 
                                     77 ; default segment ordering for linker
                                     78 	.area HOME
                                     79 	.area GSINIT
                                     80 	.area GSFINAL
                                     81 	.area CONST
                                     82 	.area INITIALIZER
                                     83 	.area CODE
                                     84 
                                     85 ;--------------------------------------------------------
                                     86 ; interrupt vector
                                     87 ;--------------------------------------------------------
                                     88 	.area HOME
      008000                         89 __interrupt_vect:
      008000 82 00 80 57             90 	int s_GSINIT ; reset
      008004 82 00 00 00             91 	int 0x000000 ; trap
      008008 82 00 00 00             92 	int 0x000000 ; int0
      00800C 82 00 00 00             93 	int 0x000000 ; int1
      008010 82 00 00 00             94 	int 0x000000 ; int2
      008014 82 00 00 00             95 	int 0x000000 ; int3
      008018 82 00 00 00             96 	int 0x000000 ; int4
      00801C 82 00 00 00             97 	int 0x000000 ; int5
      008020 82 00 00 00             98 	int 0x000000 ; int6
      008024 82 00 00 00             99 	int 0x000000 ; int7
      008028 82 00 00 00            100 	int 0x000000 ; int8
      00802C 82 00 00 00            101 	int 0x000000 ; int9
      008030 82 00 00 00            102 	int 0x000000 ; int10
      008034 82 00 00 00            103 	int 0x000000 ; int11
      008038 82 00 00 00            104 	int 0x000000 ; int12
      00803C 82 00 00 00            105 	int 0x000000 ; int13
      008040 82 00 00 00            106 	int 0x000000 ; int14
      008044 82 00 00 00            107 	int 0x000000 ; int15
      008048 82 00 00 00            108 	int 0x000000 ; int16
      00804C 82 00 82 A7            109 	int _uart_transmission_irq ; int17
      008050 82 00 82 E3            110 	int _uart_reciever_irq ; int18
                                    111 ;--------------------------------------------------------
                                    112 ; global & static initialisations
                                    113 ;--------------------------------------------------------
                                    114 	.area HOME
                                    115 	.area GSINIT
                                    116 	.area GSFINAL
                                    117 	.area GSINIT
      008057 CD 8E 2E         [ 4]  118 	call	___sdcc_external_startup
      00805A 4D               [ 1]  119 	tnz	a
      00805B 27 03            [ 1]  120 	jreq	__sdcc_init_data
      00805D CC 80 54         [ 2]  121 	jp	__sdcc_program_startup
      008060                        122 __sdcc_init_data:
                                    123 ; stm8_genXINIT() start
      008060 AE 00 06         [ 2]  124 	ldw x, #l_DATA
      008063 27 07            [ 1]  125 	jreq	00002$
      008065                        126 00001$:
      008065 72 4F 00 00      [ 1]  127 	clr (s_DATA - 1, x)
      008069 5A               [ 2]  128 	decw x
      00806A 26 F9            [ 1]  129 	jrne	00001$
      00806C                        130 00002$:
      00806C AE 02 01         [ 2]  131 	ldw	x, #l_INITIALIZER
      00806F 27 09            [ 1]  132 	jreq	00004$
      008071                        133 00003$:
      008071 D6 80 A5         [ 1]  134 	ld	a, (s_INITIALIZER - 1, x)
      008074 D7 00 06         [ 1]  135 	ld	(s_INITIALIZED - 1, x), a
      008077 5A               [ 2]  136 	decw	x
      008078 26 F7            [ 1]  137 	jrne	00003$
      00807A                        138 00004$:
                                    139 ; stm8_genXINIT() end
                                    140 	.area GSFINAL
      00807A CC 80 54         [ 2]  141 	jp	__sdcc_program_startup
                                    142 ;--------------------------------------------------------
                                    143 ; Home
                                    144 ;--------------------------------------------------------
                                    145 	.area HOME
                                    146 	.area HOME
      008054                        147 __sdcc_program_startup:
      008054 CC 8E 25         [ 2]  148 	jp	_main
                                    149 ;	return from main will return to caller
                                    150 ;--------------------------------------------------------
                                    151 ; code
                                    152 ;--------------------------------------------------------
                                    153 	.area CODE
                                    154 ;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    155 ;	-----------------------------------------
                                    156 ;	 function uart_transmission_irq
                                    157 ;	-----------------------------------------
      0082A7                        158 _uart_transmission_irq:
                                    159 ;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0082A7 AE 52 30         [ 2]  160 	ldw	x, #0x5230
      0082AA F6               [ 1]  161 	ld	a, (x)
      0082AB 4E               [ 1]  162 	swap	a
      0082AC 44               [ 1]  163 	srl	a
      0082AD 44               [ 1]  164 	srl	a
      0082AE 44               [ 1]  165 	srl	a
      0082AF A5 01            [ 1]  166 	bcp	a, #0x01
      0082B1 27 2F            [ 1]  167 	jreq	00107$
                                    168 ;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0082B3 C6 00 02         [ 1]  169 	ld	a, _tx_buf_pointer+1
      0082B6 CB 00 05         [ 1]  170 	add	a, _buf_pos+0
      0082B9 97               [ 1]  171 	ld	xl, a
      0082BA C6 00 01         [ 1]  172 	ld	a, _tx_buf_pointer+0
      0082BD A9 00            [ 1]  173 	adc	a, #0x00
      0082BF 95               [ 1]  174 	ld	xh, a
      0082C0 F6               [ 1]  175 	ld	a, (x)
      0082C1 27 1B            [ 1]  176 	jreq	00102$
      0082C3 C6 00 05         [ 1]  177 	ld	a, _buf_pos+0
      0082C6 C1 00 06         [ 1]  178 	cp	a, _buf_size+0
      0082C9 24 13            [ 1]  179 	jrnc	00102$
                                    180 ;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0082CB C6 00 05         [ 1]  181 	ld	a, _buf_pos+0
      0082CE 72 5C 00 05      [ 1]  182 	inc	_buf_pos+0
      0082D2 5F               [ 1]  183 	clrw	x
      0082D3 97               [ 1]  184 	ld	xl, a
      0082D4 72 BB 00 01      [ 2]  185 	addw	x, _tx_buf_pointer+0
      0082D8 F6               [ 1]  186 	ld	a, (x)
      0082D9 C7 52 31         [ 1]  187 	ld	0x5231, a
      0082DC 20 04            [ 2]  188 	jra	00107$
      0082DE                        189 00102$:
                                    190 ;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0082DE 72 1F 52 35      [ 1]  191 	bres	0x5235, #7
      0082E2                        192 00107$:
                                    193 ;	libs/uart_lib.c: 14: }
      0082E2 80               [11]  194 	iret
                                    195 ;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    196 ;	-----------------------------------------
                                    197 ;	 function uart_reciever_irq
                                    198 ;	-----------------------------------------
      0082E3                        199 _uart_reciever_irq:
      0082E3 88               [ 1]  200 	push	a
                                    201 ;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
      0082E4 C6 52 30         [ 1]  202 	ld	a, 0x5230
      0082E7 4E               [ 1]  203 	swap	a
      0082E8 44               [ 1]  204 	srl	a
      0082E9 A5 01            [ 1]  205 	bcp	a, #0x01
      0082EB 27 27            [ 1]  206 	jreq	00107$
                                    207 ;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
      0082ED C6 52 31         [ 1]  208 	ld	a, 0x5231
                                    209 ;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
      0082F0 6B 01            [ 1]  210 	ld	(0x01, sp), a
      0082F2 A1 0A            [ 1]  211 	cp	a, #0x0a
      0082F4 27 1A            [ 1]  212 	jreq	00102$
      0082F6 C6 00 05         [ 1]  213 	ld	a, _buf_pos+0
      0082F9 C1 00 06         [ 1]  214 	cp	a, _buf_size+0
      0082FC 24 12            [ 1]  215 	jrnc	00102$
                                    216 ;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
      0082FE C6 00 05         [ 1]  217 	ld	a, _buf_pos+0
      008301 72 5C 00 05      [ 1]  218 	inc	_buf_pos+0
      008305 5F               [ 1]  219 	clrw	x
      008306 97               [ 1]  220 	ld	xl, a
      008307 72 BB 00 03      [ 2]  221 	addw	x, _rx_buf_pointer+0
      00830B 7B 01            [ 1]  222 	ld	a, (0x01, sp)
      00830D F7               [ 1]  223 	ld	(x), a
      00830E 20 04            [ 2]  224 	jra	00107$
      008310                        225 00102$:
                                    226 ;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
      008310 72 1B 52 35      [ 1]  227 	bres	0x5235, #5
      008314                        228 00107$:
                                    229 ;	libs/uart_lib.c: 29: }
      008314 84               [ 1]  230 	pop	a
      008315 80               [11]  231 	iret
                                    232 ;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    233 ;	-----------------------------------------
                                    234 ;	 function uart_init
                                    235 ;	-----------------------------------------
      008316                        236 _uart_init:
      008316 52 02            [ 2]  237 	sub	sp, #2
      008318 1F 01            [ 2]  238 	ldw	(0x01, sp), x
                                    239 ;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
      00831A AE 52 35         [ 2]  240 	ldw	x, #0x5235
      00831D 88               [ 1]  241 	push	a
      00831E F6               [ 1]  242 	ld	a, (x)
      00831F AA 08            [ 1]  243 	or	a, #0x08
      008321 F7               [ 1]  244 	ld	(x), a
      008322 84               [ 1]  245 	pop	a
                                    246 ;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
      008323 AE 52 35         [ 2]  247 	ldw	x, #0x5235
      008326 88               [ 1]  248 	push	a
      008327 F6               [ 1]  249 	ld	a, (x)
      008328 AA 04            [ 1]  250 	or	a, #0x04
      00832A F7               [ 1]  251 	ld	(x), a
      00832B 84               [ 1]  252 	pop	a
                                    253 ;	libs/uart_lib.c: 36: switch(stopbit)
      00832C A1 02            [ 1]  254 	cp	a, #0x02
      00832E 27 06            [ 1]  255 	jreq	00101$
      008330 A1 03            [ 1]  256 	cp	a, #0x03
      008332 27 0E            [ 1]  257 	jreq	00102$
      008334 20 16            [ 2]  258 	jra	00103$
                                    259 ;	libs/uart_lib.c: 38: case 2:
      008336                        260 00101$:
                                    261 ;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
      008336 C6 52 36         [ 1]  262 	ld	a, 0x5236
      008339 A4 CF            [ 1]  263 	and	a, #0xcf
      00833B AA 20            [ 1]  264 	or	a, #0x20
      00833D C7 52 36         [ 1]  265 	ld	0x5236, a
                                    266 ;	libs/uart_lib.c: 40: break;
      008340 20 12            [ 2]  267 	jra	00104$
                                    268 ;	libs/uart_lib.c: 41: case 3:
      008342                        269 00102$:
                                    270 ;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
      008342 C6 52 36         [ 1]  271 	ld	a, 0x5236
      008345 AA 30            [ 1]  272 	or	a, #0x30
      008347 C7 52 36         [ 1]  273 	ld	0x5236, a
                                    274 ;	libs/uart_lib.c: 43: break;
      00834A 20 08            [ 2]  275 	jra	00104$
                                    276 ;	libs/uart_lib.c: 44: default:
      00834C                        277 00103$:
                                    278 ;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
      00834C C6 52 36         [ 1]  279 	ld	a, 0x5236
      00834F A4 CF            [ 1]  280 	and	a, #0xcf
      008351 C7 52 36         [ 1]  281 	ld	0x5236, a
                                    282 ;	libs/uart_lib.c: 47: }
      008354                        283 00104$:
                                    284 ;	libs/uart_lib.c: 48: switch(baudrate)
      008354 1E 01            [ 2]  285 	ldw	x, (0x01, sp)
      008356 A3 08 00         [ 2]  286 	cpw	x, #0x0800
      008359 26 03            [ 1]  287 	jrne	00186$
      00835B CC 83 E7         [ 2]  288 	jp	00110$
      00835E                        289 00186$:
      00835E 1E 01            [ 2]  290 	ldw	x, (0x01, sp)
      008360 A3 09 60         [ 2]  291 	cpw	x, #0x0960
      008363 27 28            [ 1]  292 	jreq	00105$
      008365 1E 01            [ 2]  293 	ldw	x, (0x01, sp)
      008367 A3 10 00         [ 2]  294 	cpw	x, #0x1000
      00836A 26 03            [ 1]  295 	jrne	00192$
      00836C CC 83 F7         [ 2]  296 	jp	00111$
      00836F                        297 00192$:
      00836F 1E 01            [ 2]  298 	ldw	x, (0x01, sp)
      008371 A3 4B 00         [ 2]  299 	cpw	x, #0x4b00
      008374 27 31            [ 1]  300 	jreq	00106$
      008376 1E 01            [ 2]  301 	ldw	x, (0x01, sp)
      008378 A3 84 00         [ 2]  302 	cpw	x, #0x8400
      00837B 27 5A            [ 1]  303 	jreq	00109$
      00837D 1E 01            [ 2]  304 	ldw	x, (0x01, sp)
      00837F A3 C2 00         [ 2]  305 	cpw	x, #0xc200
      008382 27 43            [ 1]  306 	jreq	00108$
      008384 1E 01            [ 2]  307 	ldw	x, (0x01, sp)
      008386 A3 E1 00         [ 2]  308 	cpw	x, #0xe100
      008389 27 2C            [ 1]  309 	jreq	00107$
      00838B 20 7A            [ 2]  310 	jra	00112$
                                    311 ;	libs/uart_lib.c: 50: case (unsigned int)2400:
      00838D                        312 00105$:
                                    313 ;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
      00838D C6 52 33         [ 1]  314 	ld	a, 0x5233
      008390 A4 0F            [ 1]  315 	and	a, #0x0f
      008392 AA 10            [ 1]  316 	or	a, #0x10
      008394 C7 52 33         [ 1]  317 	ld	0x5233, a
                                    318 ;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
      008397 35 A0 52 32      [ 1]  319 	mov	0x5232+0, #0xa0
                                    320 ;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
      00839B C6 52 33         [ 1]  321 	ld	a, 0x5233
      00839E A4 F0            [ 1]  322 	and	a, #0xf0
      0083A0 AA 0B            [ 1]  323 	or	a, #0x0b
      0083A2 C7 52 33         [ 1]  324 	ld	0x5233, a
                                    325 ;	libs/uart_lib.c: 54: break;
      0083A5 20 6E            [ 2]  326 	jra	00114$
                                    327 ;	libs/uart_lib.c: 55: case (unsigned int)19200:
      0083A7                        328 00106$:
                                    329 ;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
      0083A7 35 34 52 32      [ 1]  330 	mov	0x5232+0, #0x34
                                    331 ;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
      0083AB C6 52 33         [ 1]  332 	ld	a, 0x5233
      0083AE A4 F0            [ 1]  333 	and	a, #0xf0
      0083B0 AA 01            [ 1]  334 	or	a, #0x01
      0083B2 C7 52 33         [ 1]  335 	ld	0x5233, a
                                    336 ;	libs/uart_lib.c: 58: break;
      0083B5 20 5E            [ 2]  337 	jra	00114$
                                    338 ;	libs/uart_lib.c: 59: case (unsigned int)57600:
      0083B7                        339 00107$:
                                    340 ;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
      0083B7 35 11 52 32      [ 1]  341 	mov	0x5232+0, #0x11
                                    342 ;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
      0083BB C6 52 33         [ 1]  343 	ld	a, 0x5233
      0083BE A4 F0            [ 1]  344 	and	a, #0xf0
      0083C0 AA 06            [ 1]  345 	or	a, #0x06
      0083C2 C7 52 33         [ 1]  346 	ld	0x5233, a
                                    347 ;	libs/uart_lib.c: 62: break;
      0083C5 20 4E            [ 2]  348 	jra	00114$
                                    349 ;	libs/uart_lib.c: 63: case (unsigned int)115200:
      0083C7                        350 00108$:
                                    351 ;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
      0083C7 35 08 52 32      [ 1]  352 	mov	0x5232+0, #0x08
                                    353 ;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
      0083CB C6 52 33         [ 1]  354 	ld	a, 0x5233
      0083CE A4 F0            [ 1]  355 	and	a, #0xf0
      0083D0 AA 0B            [ 1]  356 	or	a, #0x0b
      0083D2 C7 52 33         [ 1]  357 	ld	0x5233, a
                                    358 ;	libs/uart_lib.c: 66: break;
      0083D5 20 3E            [ 2]  359 	jra	00114$
                                    360 ;	libs/uart_lib.c: 67: case (unsigned int)230400:
      0083D7                        361 00109$:
                                    362 ;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
      0083D7 35 04 52 32      [ 1]  363 	mov	0x5232+0, #0x04
                                    364 ;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
      0083DB C6 52 33         [ 1]  365 	ld	a, 0x5233
      0083DE A4 F0            [ 1]  366 	and	a, #0xf0
      0083E0 AA 05            [ 1]  367 	or	a, #0x05
      0083E2 C7 52 33         [ 1]  368 	ld	0x5233, a
                                    369 ;	libs/uart_lib.c: 70: break;
      0083E5 20 2E            [ 2]  370 	jra	00114$
                                    371 ;	libs/uart_lib.c: 71: case (unsigned int)460800:
      0083E7                        372 00110$:
                                    373 ;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
      0083E7 35 02 52 32      [ 1]  374 	mov	0x5232+0, #0x02
                                    375 ;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
      0083EB C6 52 33         [ 1]  376 	ld	a, 0x5233
      0083EE A4 F0            [ 1]  377 	and	a, #0xf0
      0083F0 AA 03            [ 1]  378 	or	a, #0x03
      0083F2 C7 52 33         [ 1]  379 	ld	0x5233, a
                                    380 ;	libs/uart_lib.c: 74: break;
      0083F5 20 1E            [ 2]  381 	jra	00114$
                                    382 ;	libs/uart_lib.c: 75: case (unsigned int)921600:
      0083F7                        383 00111$:
                                    384 ;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
      0083F7 35 01 52 32      [ 1]  385 	mov	0x5232+0, #0x01
                                    386 ;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      0083FB C6 52 33         [ 1]  387 	ld	a, 0x5233
      0083FE A4 F0            [ 1]  388 	and	a, #0xf0
      008400 AA 01            [ 1]  389 	or	a, #0x01
      008402 C7 52 33         [ 1]  390 	ld	0x5233, a
                                    391 ;	libs/uart_lib.c: 78: break;
      008405 20 0E            [ 2]  392 	jra	00114$
                                    393 ;	libs/uart_lib.c: 79: default:
      008407                        394 00112$:
                                    395 ;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
      008407 35 68 52 32      [ 1]  396 	mov	0x5232+0, #0x68
                                    397 ;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
      00840B C6 52 33         [ 1]  398 	ld	a, 0x5233
      00840E A4 F0            [ 1]  399 	and	a, #0xf0
      008410 AA 03            [ 1]  400 	or	a, #0x03
      008412 C7 52 33         [ 1]  401 	ld	0x5233, a
                                    402 ;	libs/uart_lib.c: 83: }
      008415                        403 00114$:
                                    404 ;	libs/uart_lib.c: 84: }
      008415 5B 02            [ 2]  405 	addw	sp, #2
      008417 81               [ 4]  406 	ret
                                    407 ;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
                                    408 ;	-----------------------------------------
                                    409 ;	 function uart_read_byte
                                    410 ;	-----------------------------------------
      008418                        411 _uart_read_byte:
                                    412 ;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
      008418                        413 00101$:
      008418 72 0B 52 30 FB   [ 2]  414 	btjf	0x5230, #5, 00101$
                                    415 ;	libs/uart_lib.c: 90: return 1;
      00841D 5F               [ 1]  416 	clrw	x
      00841E 5C               [ 1]  417 	incw	x
                                    418 ;	libs/uart_lib.c: 91: }
      00841F 81               [ 4]  419 	ret
                                    420 ;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
                                    421 ;	-----------------------------------------
                                    422 ;	 function uart_write_byte
                                    423 ;	-----------------------------------------
      008420                        424 _uart_write_byte:
                                    425 ;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
      008420 C7 52 31         [ 1]  426 	ld	0x5231, a
                                    427 ;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
      008423                        428 00101$:
      008423 72 0F 52 30 FB   [ 2]  429 	btjf	0x5230, #7, 00101$
                                    430 ;	libs/uart_lib.c: 97: return 1;
      008428 5F               [ 1]  431 	clrw	x
      008429 5C               [ 1]  432 	incw	x
                                    433 ;	libs/uart_lib.c: 98: }
      00842A 81               [ 4]  434 	ret
                                    435 ;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
                                    436 ;	-----------------------------------------
                                    437 ;	 function uart_write
                                    438 ;	-----------------------------------------
      00842B                        439 _uart_write:
      00842B 52 02            [ 2]  440 	sub	sp, #2
                                    441 ;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
      00842D 1F 01            [ 2]  442 	ldw	(0x01, sp), x
      00842F CF 00 01         [ 2]  443 	ldw	_tx_buf_pointer+0, x
                                    444 ;	libs/uart_lib.c: 103: buf_pos = 0;
      008432 72 5F 00 05      [ 1]  445 	clr	_buf_pos+0
                                    446 ;	libs/uart_lib.c: 104: buf_size = 0;
      008436 72 5F 00 06      [ 1]  447 	clr	_buf_size+0
                                    448 ;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
      00843A                        449 00101$:
      00843A C6 00 06         [ 1]  450 	ld	a, _buf_size+0
      00843D 72 5C 00 06      [ 1]  451 	inc	_buf_size+0
      008441 5F               [ 1]  452 	clrw	x
      008442 97               [ 1]  453 	ld	xl, a
      008443 72 FB 01         [ 2]  454 	addw	x, (0x01, sp)
      008446 F6               [ 1]  455 	ld	a, (x)
      008447 26 F1            [ 1]  456 	jrne	00101$
                                    457 ;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
      008449 72 1E 52 35      [ 1]  458 	bset	0x5235, #7
                                    459 ;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
      00844D                        460 00104$:
      00844D 72 0E 52 35 FB   [ 2]  461 	btjt	0x5235, #7, 00104$
                                    462 ;	libs/uart_lib.c: 108: }
      008452 5B 02            [ 2]  463 	addw	sp, #2
      008454 81               [ 4]  464 	ret
                                    465 ;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
                                    466 ;	-----------------------------------------
                                    467 ;	 function uart_read
                                    468 ;	-----------------------------------------
      008455                        469 _uart_read:
                                    470 ;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
      008455 CF 00 03         [ 2]  471 	ldw	_rx_buf_pointer+0, x
                                    472 ;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
      008458 AE 80 7D         [ 2]  473 	ldw	x, #(___str_0+0)
      00845B CD 84 2B         [ 4]  474 	call	_uart_write
                                    475 ;	libs/uart_lib.c: 113: buf_pos = 0;
      00845E 72 5F 00 05      [ 1]  476 	clr	_buf_pos+0
                                    477 ;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
      008462 AE 80 8D         [ 2]  478 	ldw	x, #(___str_1+0)
      008465 CD 84 2B         [ 4]  479 	call	_uart_write
                                    480 ;	libs/uart_lib.c: 115: buf_size = size;
      008468 7B 04            [ 1]  481 	ld	a, (0x04, sp)
      00846A C7 00 06         [ 1]  482 	ld	_buf_size+0, a
                                    483 ;	libs/uart_lib.c: 116: uart_write("buf_size\n");
      00846D AE 80 96         [ 2]  484 	ldw	x, #(___str_2+0)
      008470 CD 84 2B         [ 4]  485 	call	_uart_write
                                    486 ;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
      008473 72 1A 52 35      [ 1]  487 	bset	0x5235, #5
                                    488 ;	libs/uart_lib.c: 118: uart_write("RIEN\n");
      008477 AE 80 A0         [ 2]  489 	ldw	x, #(___str_3+0)
      00847A CD 84 2B         [ 4]  490 	call	_uart_write
                                    491 ;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
      00847D                        492 00101$:
      00847D C6 52 35         [ 1]  493 	ld	a, 0x5235
      008480 4E               [ 1]  494 	swap	a
      008481 44               [ 1]  495 	srl	a
      008482 A4 01            [ 1]  496 	and	a, #0x01
      008484 26 F7            [ 1]  497 	jrne	00101$
                                    498 ;	libs/uart_lib.c: 120: }
      008486 1E 01            [ 2]  499 	ldw	x, (1, sp)
      008488 5B 04            [ 2]  500 	addw	sp, #4
      00848A FC               [ 2]  501 	jp	(x)
                                    502 ;	libs/i2c_lib.c: 3: void i2c_init(void)
                                    503 ;	-----------------------------------------
                                    504 ;	 function i2c_init
                                    505 ;	-----------------------------------------
      00848B                        506 _i2c_init:
                                    507 ;	libs/i2c_lib.c: 7: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      00848B 72 11 52 10      [ 1]  508 	bres	0x5210, #0
                                    509 ;	libs/i2c_lib.c: 8: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      00848F C6 52 12         [ 1]  510 	ld	a, 0x5212
      008492 A4 C0            [ 1]  511 	and	a, #0xc0
      008494 AA 10            [ 1]  512 	or	a, #0x10
      008496 C7 52 12         [ 1]  513 	ld	0x5212, a
                                    514 ;	libs/i2c_lib.c: 9: I2C_CCRH -> CCR = 0;// =0
      008499 C6 52 1C         [ 1]  515 	ld	a, 0x521c
      00849C A4 F0            [ 1]  516 	and	a, #0xf0
      00849E C7 52 1C         [ 1]  517 	ld	0x521c, a
                                    518 ;	libs/i2c_lib.c: 10: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0084A1 35 50 52 1B      [ 1]  519 	mov	0x521b+0, #0x50
                                    520 ;	libs/i2c_lib.c: 11: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0084A5 72 1F 52 1C      [ 1]  521 	bres	0x521c, #7
                                    522 ;	libs/i2c_lib.c: 12: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0084A9 72 1F 52 14      [ 1]  523 	bres	0x5214, #7
                                    524 ;	libs/i2c_lib.c: 13: I2C_OARH -> ADDCONF = 1;// see reference manual
      0084AD 72 10 52 14      [ 1]  525 	bset	0x5214, #0
                                    526 ;	libs/i2c_lib.c: 14: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0084B1 72 10 52 10      [ 1]  527 	bset	0x5210, #0
                                    528 ;	libs/i2c_lib.c: 15: }
      0084B5 81               [ 4]  529 	ret
                                    530 ;	libs/i2c_lib.c: 17: void i2c_start(void)
                                    531 ;	-----------------------------------------
                                    532 ;	 function i2c_start
                                    533 ;	-----------------------------------------
      0084B6                        534 _i2c_start:
                                    535 ;	libs/i2c_lib.c: 19: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0084B6 72 10 52 11      [ 1]  536 	bset	0x5211, #0
                                    537 ;	libs/i2c_lib.c: 20: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0084BA                        538 00101$:
      0084BA 72 01 52 17 FB   [ 2]  539 	btjf	0x5217, #0, 00101$
                                    540 ;	libs/i2c_lib.c: 21: }
      0084BF 81               [ 4]  541 	ret
                                    542 ;	libs/i2c_lib.c: 23: void i2c_stop(void)
                                    543 ;	-----------------------------------------
                                    544 ;	 function i2c_stop
                                    545 ;	-----------------------------------------
      0084C0                        546 _i2c_stop:
                                    547 ;	libs/i2c_lib.c: 25: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0084C0 72 12 52 11      [ 1]  548 	bset	0x5211, #1
                                    549 ;	libs/i2c_lib.c: 26: }
      0084C4 81               [ 4]  550 	ret
                                    551 ;	libs/i2c_lib.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    552 ;	-----------------------------------------
                                    553 ;	 function i2c_send_address
                                    554 ;	-----------------------------------------
      0084C5                        555 _i2c_send_address:
                                    556 ;	libs/i2c_lib.c: 33: address = address << 1;
      0084C5 48               [ 1]  557 	sll	a
                                    558 ;	libs/i2c_lib.c: 30: switch(rw_type)
      0084C6 88               [ 1]  559 	push	a
      0084C7 7B 04            [ 1]  560 	ld	a, (0x04, sp)
      0084C9 4A               [ 1]  561 	dec	a
      0084CA 84               [ 1]  562 	pop	a
      0084CB 26 02            [ 1]  563 	jrne	00102$
                                    564 ;	libs/i2c_lib.c: 33: address = address << 1;
                                    565 ;	libs/i2c_lib.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0084CD AA 01            [ 1]  566 	or	a, #0x01
                                    567 ;	libs/i2c_lib.c: 35: break;
                                    568 ;	libs/i2c_lib.c: 36: default:
                                    569 ;	libs/i2c_lib.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
                                    570 ;	libs/i2c_lib.c: 39: }
      0084CF                        571 00102$:
                                    572 ;	libs/i2c_lib.c: 40: i2c_start();
      0084CF 88               [ 1]  573 	push	a
      0084D0 CD 84 B6         [ 4]  574 	call	_i2c_start
      0084D3 84               [ 1]  575 	pop	a
                                    576 ;	libs/i2c_lib.c: 41: I2C_DR -> DR = address;
      0084D4 C7 52 16         [ 1]  577 	ld	0x5216, a
                                    578 ;	libs/i2c_lib.c: 42: while(!I2C_SR1 -> ADDR)
      0084D7                        579 00106$:
      0084D7 AE 52 17         [ 2]  580 	ldw	x, #0x5217
      0084DA F6               [ 1]  581 	ld	a, (x)
      0084DB 44               [ 1]  582 	srl	a
      0084DC A4 01            [ 1]  583 	and	a, #0x01
      0084DE 26 08            [ 1]  584 	jrne	00108$
                                    585 ;	libs/i2c_lib.c: 43: if(I2C_SR2 -> AF)
      0084E0 72 05 52 18 F2   [ 2]  586 	btjf	0x5218, #2, 00106$
                                    587 ;	libs/i2c_lib.c: 44: return 0;
      0084E5 4F               [ 1]  588 	clr	a
      0084E6 20 08            [ 2]  589 	jra	00109$
      0084E8                        590 00108$:
                                    591 ;	libs/i2c_lib.c: 45: clr_sr1();
      0084E8 C6 52 17         [ 1]  592 	ld	a,0x5217
                                    593 ;	libs/i2c_lib.c: 46: clr_sr3();
      0084EB C6 52 19         [ 1]  594 	ld	a,0x5219
                                    595 ;	libs/i2c_lib.c: 47: return 1;
      0084EE A6 01            [ 1]  596 	ld	a, #0x01
      0084F0                        597 00109$:
                                    598 ;	libs/i2c_lib.c: 48: }
      0084F0 85               [ 2]  599 	popw	x
      0084F1 5B 01            [ 2]  600 	addw	sp, #1
      0084F3 FC               [ 2]  601 	jp	(x)
                                    602 ;	libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void){
                                    603 ;	-----------------------------------------
                                    604 ;	 function i2c_read_byte
                                    605 ;	-----------------------------------------
      0084F4                        606 _i2c_read_byte:
                                    607 ;	libs/i2c_lib.c: 51: while(!I2C_SR1 -> RXNE);
      0084F4                        608 00101$:
      0084F4 72 0D 52 17 FB   [ 2]  609 	btjf	0x5217, #6, 00101$
                                    610 ;	libs/i2c_lib.c: 52: return I2C_DR -> DR;
      0084F9 C6 52 16         [ 1]  611 	ld	a, 0x5216
                                    612 ;	libs/i2c_lib.c: 53: }
      0084FC 81               [ 4]  613 	ret
                                    614 ;	libs/i2c_lib.c: 55: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    615 ;	-----------------------------------------
                                    616 ;	 function i2c_read
                                    617 ;	-----------------------------------------
      0084FD                        618 _i2c_read:
      0084FD 52 04            [ 2]  619 	sub	sp, #4
                                    620 ;	libs/i2c_lib.c: 57: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      0084FF 4B 01            [ 1]  621 	push	#0x01
      008501 CD 84 C5         [ 4]  622 	call	_i2c_send_address
      008504 4D               [ 1]  623 	tnz	a
      008505 27 41            [ 1]  624 	jreq	00103$
                                    625 ;	libs/i2c_lib.c: 59: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008507 72 14 52 11      [ 1]  626 	bset	0x5211, #2
                                    627 ;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00850B 5F               [ 1]  628 	clrw	x
      00850C 1F 03            [ 2]  629 	ldw	(0x03, sp), x
      00850E                        630 00105$:
      00850E 5F               [ 1]  631 	clrw	x
      00850F 7B 07            [ 1]  632 	ld	a, (0x07, sp)
      008511 97               [ 1]  633 	ld	xl, a
      008512 5A               [ 2]  634 	decw	x
      008513 1F 01            [ 2]  635 	ldw	(0x01, sp), x
      008515 1E 03            [ 2]  636 	ldw	x, (0x03, sp)
      008517 13 01            [ 2]  637 	cpw	x, (0x01, sp)
      008519 2E 12            [ 1]  638 	jrsge	00101$
                                    639 ;	libs/i2c_lib.c: 62: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00851B 1E 08            [ 2]  640 	ldw	x, (0x08, sp)
      00851D 72 FB 03         [ 2]  641 	addw	x, (0x03, sp)
      008520 89               [ 2]  642 	pushw	x
      008521 CD 84 F4         [ 4]  643 	call	_i2c_read_byte
      008524 85               [ 2]  644 	popw	x
      008525 F7               [ 1]  645 	ld	(x), a
                                    646 ;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008526 1E 03            [ 2]  647 	ldw	x, (0x03, sp)
      008528 5C               [ 1]  648 	incw	x
      008529 1F 03            [ 2]  649 	ldw	(0x03, sp), x
      00852B 20 E1            [ 2]  650 	jra	00105$
      00852D                        651 00101$:
                                    652 ;	libs/i2c_lib.c: 64: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00852D 72 15 52 11      [ 1]  653 	bres	0x5211, #2
                                    654 ;	libs/i2c_lib.c: 65: uart_write_byte(0x00);
      008531 4F               [ 1]  655 	clr	a
      008532 CD 84 20         [ 4]  656 	call	_uart_write_byte
                                    657 ;	libs/i2c_lib.c: 66: data[size-1] = i2c_read_byte();
      008535 1E 08            [ 2]  658 	ldw	x, (0x08, sp)
      008537 72 FB 01         [ 2]  659 	addw	x, (0x01, sp)
      00853A 89               [ 2]  660 	pushw	x
      00853B CD 84 F4         [ 4]  661 	call	_i2c_read_byte
      00853E 85               [ 2]  662 	popw	x
      00853F F7               [ 1]  663 	ld	(x), a
                                    664 ;	libs/i2c_lib.c: 67: uart_write_byte(0x01);
      008540 A6 01            [ 1]  665 	ld	a, #0x01
      008542 CD 84 20         [ 4]  666 	call	_uart_write_byte
                                    667 ;	libs/i2c_lib.c: 68: i2c_stop();
      008545 CD 84 C0         [ 4]  668 	call	_i2c_stop
      008548                        669 00103$:
                                    670 ;	libs/i2c_lib.c: 70: uart_write_byte(0x02);
      008548 A6 02            [ 1]  671 	ld	a, #0x02
      00854A CD 84 20         [ 4]  672 	call	_uart_write_byte
                                    673 ;	libs/i2c_lib.c: 71: i2c_stop();
      00854D CD 84 C0         [ 4]  674 	call	_i2c_stop
                                    675 ;	libs/i2c_lib.c: 72: i2c_stop();
      008550 CD 84 C0         [ 4]  676 	call	_i2c_stop
                                    677 ;	libs/i2c_lib.c: 73: uart_write_byte(0x03); 
      008553 A6 03            [ 1]  678 	ld	a, #0x03
      008555 1E 05            [ 2]  679 	ldw	x, (5, sp)
      008557 1F 08            [ 2]  680 	ldw	(8, sp), x
      008559 5B 07            [ 2]  681 	addw	sp, #7
                                    682 ;	libs/i2c_lib.c: 74: }
      00855B CC 84 20         [ 2]  683 	jp	_uart_write_byte
                                    684 ;	libs/i2c_lib.c: 76: uint8_t i2c_send_byte(uint8_t data)
                                    685 ;	-----------------------------------------
                                    686 ;	 function i2c_send_byte
                                    687 ;	-----------------------------------------
      00855E                        688 _i2c_send_byte:
                                    689 ;	libs/i2c_lib.c: 78: I2C_DR -> DR = data; //Отправка данных
      00855E C7 52 16         [ 1]  690 	ld	0x5216, a
                                    691 ;	libs/i2c_lib.c: 79: while(!I2C_SR1 -> TXE)
      008561                        692 00103$:
      008561 72 0E 52 17 08   [ 2]  693 	btjt	0x5217, #7, 00105$
                                    694 ;	libs/i2c_lib.c: 80: if(I2C_SR2 -> AF)
      008566 72 05 52 18 F6   [ 2]  695 	btjf	0x5218, #2, 00103$
                                    696 ;	libs/i2c_lib.c: 81: return 1;
      00856B A6 01            [ 1]  697 	ld	a, #0x01
      00856D 81               [ 4]  698 	ret
      00856E                        699 00105$:
                                    700 ;	libs/i2c_lib.c: 82: return 0;//флаг ответа
      00856E 4F               [ 1]  701 	clr	a
                                    702 ;	libs/i2c_lib.c: 83: }
      00856F 81               [ 4]  703 	ret
                                    704 ;	libs/i2c_lib.c: 85: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    705 ;	-----------------------------------------
                                    706 ;	 function i2c_write
                                    707 ;	-----------------------------------------
      008570                        708 _i2c_write:
      008570 52 02            [ 2]  709 	sub	sp, #2
                                    710 ;	libs/i2c_lib.c: 87: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008572 4B 00            [ 1]  711 	push	#0x00
      008574 CD 84 C5         [ 4]  712 	call	_i2c_send_address
      008577 4D               [ 1]  713 	tnz	a
      008578 27 1D            [ 1]  714 	jreq	00105$
                                    715 ;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      00857A 5F               [ 1]  716 	clrw	x
      00857B                        717 00107$:
      00857B 7B 05            [ 1]  718 	ld	a, (0x05, sp)
      00857D 6B 02            [ 1]  719 	ld	(0x02, sp), a
      00857F 0F 01            [ 1]  720 	clr	(0x01, sp)
      008581 13 01            [ 2]  721 	cpw	x, (0x01, sp)
      008583 2E 12            [ 1]  722 	jrsge	00105$
                                    723 ;	libs/i2c_lib.c: 90: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008585 90 93            [ 1]  724 	ldw	y, x
      008587 72 F9 06         [ 2]  725 	addw	y, (0x06, sp)
      00858A 90 F6            [ 1]  726 	ld	a, (y)
      00858C 89               [ 2]  727 	pushw	x
      00858D CD 85 5E         [ 4]  728 	call	_i2c_send_byte
      008590 85               [ 2]  729 	popw	x
      008591 4D               [ 1]  730 	tnz	a
      008592 26 03            [ 1]  731 	jrne	00105$
                                    732 ;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      008594 5C               [ 1]  733 	incw	x
      008595 20 E4            [ 2]  734 	jra	00107$
      008597                        735 00105$:
                                    736 ;	libs/i2c_lib.c: 95: i2c_stop();
      008597 1E 03            [ 2]  737 	ldw	x, (3, sp)
      008599 1F 06            [ 2]  738 	ldw	(6, sp), x
      00859B 5B 05            [ 2]  739 	addw	sp, #5
                                    740 ;	libs/i2c_lib.c: 96: }
      00859D CC 84 C0         [ 2]  741 	jp	_i2c_stop
                                    742 ;	libs/i2c_lib.c: 98: uint8_t i2c_scan(void) 
                                    743 ;	-----------------------------------------
                                    744 ;	 function i2c_scan
                                    745 ;	-----------------------------------------
      0085A0                        746 _i2c_scan:
      0085A0 52 02            [ 2]  747 	sub	sp, #2
                                    748 ;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0085A2 A6 01            [ 1]  749 	ld	a, #0x01
      0085A4 6B 01            [ 1]  750 	ld	(0x01, sp), a
      0085A6                        751 00105$:
      0085A6 A1 7F            [ 1]  752 	cp	a, #0x7f
      0085A8 24 22            [ 1]  753 	jrnc	00103$
                                    754 ;	libs/i2c_lib.c: 102: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0085AA 88               [ 1]  755 	push	a
      0085AB 4B 00            [ 1]  756 	push	#0x00
      0085AD CD 84 C5         [ 4]  757 	call	_i2c_send_address
      0085B0 6B 03            [ 1]  758 	ld	(0x03, sp), a
      0085B2 84               [ 1]  759 	pop	a
      0085B3 0D 02            [ 1]  760 	tnz	(0x02, sp)
      0085B5 27 07            [ 1]  761 	jreq	00102$
                                    762 ;	libs/i2c_lib.c: 104: i2c_stop();//адрес совпал 
      0085B7 CD 84 C0         [ 4]  763 	call	_i2c_stop
                                    764 ;	libs/i2c_lib.c: 105: return addr;// выход из цикла
      0085BA 7B 01            [ 1]  765 	ld	a, (0x01, sp)
      0085BC 20 12            [ 2]  766 	jra	00107$
      0085BE                        767 00102$:
                                    768 ;	libs/i2c_lib.c: 107: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0085BE AE 52 18         [ 2]  769 	ldw	x, #0x5218
      0085C1 88               [ 1]  770 	push	a
      0085C2 F6               [ 1]  771 	ld	a, (x)
      0085C3 A4 FB            [ 1]  772 	and	a, #0xfb
      0085C5 F7               [ 1]  773 	ld	(x), a
      0085C6 84               [ 1]  774 	pop	a
                                    775 ;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0085C7 4C               [ 1]  776 	inc	a
      0085C8 6B 01            [ 1]  777 	ld	(0x01, sp), a
      0085CA 20 DA            [ 2]  778 	jra	00105$
      0085CC                        779 00103$:
                                    780 ;	libs/i2c_lib.c: 109: i2c_stop();//совпадений нет выход из функции
      0085CC CD 84 C0         [ 4]  781 	call	_i2c_stop
                                    782 ;	libs/i2c_lib.c: 110: return 0;
      0085CF 4F               [ 1]  783 	clr	a
      0085D0                        784 00107$:
                                    785 ;	libs/i2c_lib.c: 111: }
      0085D0 5B 02            [ 2]  786 	addw	sp, #2
      0085D2 81               [ 4]  787 	ret
                                    788 ;	main.c: 4: void setup(void)
                                    789 ;	-----------------------------------------
                                    790 ;	 function setup
                                    791 ;	-----------------------------------------
      0085D3                        792 _setup:
                                    793 ;	main.c: 7: CLK_CKDIVR = 0;
      0085D3 35 00 50 C6      [ 1]  794 	mov	0x50c6+0, #0x00
                                    795 ;	main.c: 9: uart_init(9600,0);
      0085D7 4F               [ 1]  796 	clr	a
      0085D8 AE 25 80         [ 2]  797 	ldw	x, #0x2580
      0085DB CD 83 16         [ 4]  798 	call	_uart_init
                                    799 ;	main.c: 10: i2c_init();
      0085DE CD 84 8B         [ 4]  800 	call	_i2c_init
                                    801 ;	main.c: 12: enableInterrupts();
      0085E1 9A               [ 1]  802 	rim
                                    803 ;	main.c: 13: }
      0085E2 81               [ 4]  804 	ret
                                    805 ;	main.c: 15: int get_bit(int data,int bit)
                                    806 ;	-----------------------------------------
                                    807 ;	 function get_bit
                                    808 ;	-----------------------------------------
      0085E3                        809 _get_bit:
                                    810 ;	main.c: 17: return ((data >> bit) & 1) ? 1 : 0;
      0085E3 7B 04            [ 1]  811 	ld	a, (0x04, sp)
      0085E5 27 04            [ 1]  812 	jreq	00113$
      0085E7                        813 00112$:
      0085E7 57               [ 2]  814 	sraw	x
      0085E8 4A               [ 1]  815 	dec	a
      0085E9 26 FC            [ 1]  816 	jrne	00112$
      0085EB                        817 00113$:
      0085EB 54               [ 2]  818 	srlw	x
      0085EC 24 03            [ 1]  819 	jrnc	00103$
      0085EE 5F               [ 1]  820 	clrw	x
      0085EF 5C               [ 1]  821 	incw	x
      0085F0 21                     822 	.byte 0x21
      0085F1                        823 00103$:
      0085F1 5F               [ 1]  824 	clrw	x
      0085F2                        825 00104$:
                                    826 ;	main.c: 18: }
      0085F2 90 85            [ 2]  827 	popw	y
      0085F4 5B 02            [ 2]  828 	addw	sp, #2
      0085F6 90 FC            [ 2]  829 	jp	(y)
                                    830 ;	main.c: 19: int set_bit(int data,int bit, int value)
                                    831 ;	-----------------------------------------
                                    832 ;	 function set_bit
                                    833 ;	-----------------------------------------
      0085F8                        834 _set_bit:
      0085F8 52 04            [ 2]  835 	sub	sp, #4
      0085FA 1F 01            [ 2]  836 	ldw	(0x01, sp), x
                                    837 ;	main.c: 21: int mask = 1 << bit ;
      0085FC 5F               [ 1]  838 	clrw	x
      0085FD 5C               [ 1]  839 	incw	x
      0085FE 1F 03            [ 2]  840 	ldw	(0x03, sp), x
      008600 7B 08            [ 1]  841 	ld	a, (0x08, sp)
      008602 27 07            [ 1]  842 	jreq	00114$
      008604                        843 00113$:
      008604 08 04            [ 1]  844 	sll	(0x04, sp)
      008606 09 03            [ 1]  845 	rlc	(0x03, sp)
      008608 4A               [ 1]  846 	dec	a
      008609 26 F9            [ 1]  847 	jrne	00113$
      00860B                        848 00114$:
                                    849 ;	main.c: 22: switch(value)
      00860B 1E 09            [ 2]  850 	ldw	x, (0x09, sp)
      00860D 5A               [ 2]  851 	decw	x
      00860E 26 0B            [ 1]  852 	jrne	00102$
                                    853 ;	main.c: 25: data |= mask;
      008610 7B 02            [ 1]  854 	ld	a, (0x02, sp)
      008612 1A 04            [ 1]  855 	or	a, (0x04, sp)
      008614 97               [ 1]  856 	ld	xl, a
      008615 7B 01            [ 1]  857 	ld	a, (0x01, sp)
      008617 1A 03            [ 1]  858 	or	a, (0x03, sp)
                                    859 ;	main.c: 26: break;
      008619 20 09            [ 2]  860 	jra	00103$
                                    861 ;	main.c: 28: default:
      00861B                        862 00102$:
                                    863 ;	main.c: 29: data &= ~mask;
      00861B 1E 03            [ 2]  864 	ldw	x, (0x03, sp)
      00861D 53               [ 2]  865 	cplw	x
      00861E 9F               [ 1]  866 	ld	a, xl
      00861F 14 02            [ 1]  867 	and	a, (0x02, sp)
      008621 02               [ 1]  868 	rlwa	x
      008622 14 01            [ 1]  869 	and	a, (0x01, sp)
                                    870 ;	main.c: 31: }
      008624                        871 00103$:
                                    872 ;	main.c: 32: return data;
      008624 95               [ 1]  873 	ld	xh, a
                                    874 ;	main.c: 33: }
      008625 16 05            [ 2]  875 	ldw	y, (5, sp)
      008627 5B 0A            [ 2]  876 	addw	sp, #10
      008629 90 FC            [ 2]  877 	jp	(y)
                                    878 ;	main.c: 34: void delay(uint16_t ticks)
                                    879 ;	-----------------------------------------
                                    880 ;	 function delay
                                    881 ;	-----------------------------------------
      00862B                        882 _delay:
                                    883 ;	main.c: 36: while(ticks > 0)
      00862B                        884 00101$:
      00862B 5D               [ 2]  885 	tnzw	x
      00862C 26 01            [ 1]  886 	jrne	00120$
      00862E 81               [ 4]  887 	ret
      00862F                        888 00120$:
                                    889 ;	main.c: 38: ticks-=2;
      00862F 5A               [ 2]  890 	decw	x
      008630 5A               [ 2]  891 	decw	x
                                    892 ;	main.c: 39: ticks+=1;
      008631 5C               [ 1]  893 	incw	x
      008632 20 F7            [ 2]  894 	jra	00101$
                                    895 ;	main.c: 41: }
      008634 81               [ 4]  896 	ret
                                    897 ;	main.c: 43: void display_init(void)
                                    898 ;	-----------------------------------------
                                    899 ;	 function display_init
                                    900 ;	-----------------------------------------
      008635                        901 _display_init:
      008635 52 07            [ 2]  902 	sub	sp, #7
                                    903 ;	main.c: 45: uint8_t setup_buf[7] = {0x00,0xAE,0xD5,0x80,0xA8,0x1F,0xAF};
      008637 0F 01            [ 1]  904 	clr	(0x01, sp)
      008639 A6 AE            [ 1]  905 	ld	a, #0xae
      00863B 6B 02            [ 1]  906 	ld	(0x02, sp), a
      00863D A6 D5            [ 1]  907 	ld	a, #0xd5
      00863F 6B 03            [ 1]  908 	ld	(0x03, sp), a
      008641 A6 80            [ 1]  909 	ld	a, #0x80
      008643 6B 04            [ 1]  910 	ld	(0x04, sp), a
      008645 A6 A8            [ 1]  911 	ld	a, #0xa8
      008647 6B 05            [ 1]  912 	ld	(0x05, sp), a
      008649 A6 1F            [ 1]  913 	ld	a, #0x1f
      00864B 6B 06            [ 1]  914 	ld	(0x06, sp), a
      00864D A6 AF            [ 1]  915 	ld	a, #0xaf
      00864F 6B 07            [ 1]  916 	ld	(0x07, sp), a
                                    917 ;	main.c: 46: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      008651 96               [ 1]  918 	ldw	x, sp
      008652 5C               [ 1]  919 	incw	x
      008653 89               [ 2]  920 	pushw	x
      008654 4B 05            [ 1]  921 	push	#0x05
      008656 A6 3C            [ 1]  922 	ld	a, #0x3c
      008658 CD 85 70         [ 4]  923 	call	_i2c_write
                                    924 ;	main.c: 47: setup_buf[1] = 0x1F;
      00865B A6 1F            [ 1]  925 	ld	a, #0x1f
      00865D 6B 02            [ 1]  926 	ld	(0x02, sp), a
                                    927 ;	main.c: 48: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      00865F 96               [ 1]  928 	ldw	x, sp
      008660 5C               [ 1]  929 	incw	x
      008661 89               [ 2]  930 	pushw	x
      008662 4B 02            [ 1]  931 	push	#0x02
      008664 A6 3C            [ 1]  932 	ld	a, #0x3c
      008666 CD 85 70         [ 4]  933 	call	_i2c_write
                                    934 ;	main.c: 49: setup_buf[1] = 0xD3;
      008669 A6 D3            [ 1]  935 	ld	a, #0xd3
      00866B 6B 02            [ 1]  936 	ld	(0x02, sp), a
                                    937 ;	main.c: 50: setup_buf[2] = 0x00;
      00866D 0F 03            [ 1]  938 	clr	(0x03, sp)
                                    939 ;	main.c: 51: setup_buf[3] = 0x40;
      00866F A6 40            [ 1]  940 	ld	a, #0x40
      008671 6B 04            [ 1]  941 	ld	(0x04, sp), a
                                    942 ;	main.c: 52: setup_buf[4] = 0x8D;
      008673 A6 8D            [ 1]  943 	ld	a, #0x8d
      008675 6B 05            [ 1]  944 	ld	(0x05, sp), a
                                    945 ;	main.c: 53: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      008677 96               [ 1]  946 	ldw	x, sp
      008678 5C               [ 1]  947 	incw	x
      008679 89               [ 2]  948 	pushw	x
      00867A 4B 05            [ 1]  949 	push	#0x05
      00867C A6 3C            [ 1]  950 	ld	a, #0x3c
      00867E CD 85 70         [ 4]  951 	call	_i2c_write
                                    952 ;	main.c: 54: setup_buf[1] = 0x14;
      008681 A6 14            [ 1]  953 	ld	a, #0x14
      008683 6B 02            [ 1]  954 	ld	(0x02, sp), a
                                    955 ;	main.c: 55: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      008685 96               [ 1]  956 	ldw	x, sp
      008686 5C               [ 1]  957 	incw	x
      008687 89               [ 2]  958 	pushw	x
      008688 4B 02            [ 1]  959 	push	#0x02
      00868A A6 3C            [ 1]  960 	ld	a, #0x3c
      00868C CD 85 70         [ 4]  961 	call	_i2c_write
                                    962 ;	main.c: 56: setup_buf[1] = 0xDB;
      00868F A6 DB            [ 1]  963 	ld	a, #0xdb
      008691 6B 02            [ 1]  964 	ld	(0x02, sp), a
                                    965 ;	main.c: 57: setup_buf[2] = 0x40;
      008693 A6 40            [ 1]  966 	ld	a, #0x40
      008695 6B 03            [ 1]  967 	ld	(0x03, sp), a
                                    968 ;	main.c: 58: setup_buf[3] = 0xA4;
      008697 A6 A4            [ 1]  969 	ld	a, #0xa4
      008699 6B 04            [ 1]  970 	ld	(0x04, sp), a
                                    971 ;	main.c: 59: setup_buf[4] = 0xA6;
      00869B A6 A6            [ 1]  972 	ld	a, #0xa6
      00869D 6B 05            [ 1]  973 	ld	(0x05, sp), a
                                    974 ;	main.c: 60: i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
      00869F 96               [ 1]  975 	ldw	x, sp
      0086A0 5C               [ 1]  976 	incw	x
      0086A1 89               [ 2]  977 	pushw	x
      0086A2 4B 05            [ 1]  978 	push	#0x05
      0086A4 A6 3C            [ 1]  979 	ld	a, #0x3c
      0086A6 CD 85 70         [ 4]  980 	call	_i2c_write
                                    981 ;	main.c: 61: setup_buf[1] = 0xDA;
      0086A9 A6 DA            [ 1]  982 	ld	a, #0xda
      0086AB 6B 02            [ 1]  983 	ld	(0x02, sp), a
                                    984 ;	main.c: 62: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086AD 96               [ 1]  985 	ldw	x, sp
      0086AE 5C               [ 1]  986 	incw	x
      0086AF 89               [ 2]  987 	pushw	x
      0086B0 4B 02            [ 1]  988 	push	#0x02
      0086B2 A6 3C            [ 1]  989 	ld	a, #0x3c
      0086B4 CD 85 70         [ 4]  990 	call	_i2c_write
                                    991 ;	main.c: 63: setup_buf[1] = 0x02;
      0086B7 A6 02            [ 1]  992 	ld	a, #0x02
      0086B9 6B 02            [ 1]  993 	ld	(0x02, sp), a
                                    994 ;	main.c: 64: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086BB 96               [ 1]  995 	ldw	x, sp
      0086BC 5C               [ 1]  996 	incw	x
      0086BD 89               [ 2]  997 	pushw	x
      0086BE 4B 02            [ 1]  998 	push	#0x02
      0086C0 A6 3C            [ 1]  999 	ld	a, #0x3c
      0086C2 CD 85 70         [ 4] 1000 	call	_i2c_write
                                   1001 ;	main.c: 65: setup_buf[1] = 0x81;
      0086C5 A6 81            [ 1] 1002 	ld	a, #0x81
      0086C7 6B 02            [ 1] 1003 	ld	(0x02, sp), a
                                   1004 ;	main.c: 66: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086C9 96               [ 1] 1005 	ldw	x, sp
      0086CA 5C               [ 1] 1006 	incw	x
      0086CB 89               [ 2] 1007 	pushw	x
      0086CC 4B 02            [ 1] 1008 	push	#0x02
      0086CE A6 3C            [ 1] 1009 	ld	a, #0x3c
      0086D0 CD 85 70         [ 4] 1010 	call	_i2c_write
                                   1011 ;	main.c: 67: setup_buf[1] = 0x8F;
      0086D3 A6 8F            [ 1] 1012 	ld	a, #0x8f
      0086D5 6B 02            [ 1] 1013 	ld	(0x02, sp), a
                                   1014 ;	main.c: 68: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086D7 96               [ 1] 1015 	ldw	x, sp
      0086D8 5C               [ 1] 1016 	incw	x
      0086D9 89               [ 2] 1017 	pushw	x
      0086DA 4B 02            [ 1] 1018 	push	#0x02
      0086DC A6 3C            [ 1] 1019 	ld	a, #0x3c
      0086DE CD 85 70         [ 4] 1020 	call	_i2c_write
                                   1021 ;	main.c: 69: setup_buf[1] = 0xD9;
      0086E1 A6 D9            [ 1] 1022 	ld	a, #0xd9
      0086E3 6B 02            [ 1] 1023 	ld	(0x02, sp), a
                                   1024 ;	main.c: 70: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086E5 96               [ 1] 1025 	ldw	x, sp
      0086E6 5C               [ 1] 1026 	incw	x
      0086E7 89               [ 2] 1027 	pushw	x
      0086E8 4B 02            [ 1] 1028 	push	#0x02
      0086EA A6 3C            [ 1] 1029 	ld	a, #0x3c
      0086EC CD 85 70         [ 4] 1030 	call	_i2c_write
                                   1031 ;	main.c: 71: setup_buf[1] = 0xF1;
      0086EF A6 F1            [ 1] 1032 	ld	a, #0xf1
      0086F1 6B 02            [ 1] 1033 	ld	(0x02, sp), a
                                   1034 ;	main.c: 72: i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
      0086F3 96               [ 1] 1035 	ldw	x, sp
      0086F4 5C               [ 1] 1036 	incw	x
      0086F5 89               [ 2] 1037 	pushw	x
      0086F6 4B 02            [ 1] 1038 	push	#0x02
      0086F8 A6 3C            [ 1] 1039 	ld	a, #0x3c
      0086FA CD 85 70         [ 4] 1040 	call	_i2c_write
                                   1041 ;	main.c: 73: setup_buf[1] = 0x20;
      0086FD A6 20            [ 1] 1042 	ld	a, #0x20
      0086FF 6B 02            [ 1] 1043 	ld	(0x02, sp), a
                                   1044 ;	main.c: 74: setup_buf[2] = 0x00;
      008701 0F 03            [ 1] 1045 	clr	(0x03, sp)
                                   1046 ;	main.c: 75: setup_buf[3] = 0xA1;
      008703 A6 A1            [ 1] 1047 	ld	a, #0xa1
      008705 6B 04            [ 1] 1048 	ld	(0x04, sp), a
                                   1049 ;	main.c: 76: setup_buf[4] = 0xC8;
      008707 A6 C8            [ 1] 1050 	ld	a, #0xc8
      008709 6B 05            [ 1] 1051 	ld	(0x05, sp), a
                                   1052 ;	main.c: 77: i2c_write(I2C_DISPLAY_ADDR,7,setup_buf);
      00870B 96               [ 1] 1053 	ldw	x, sp
      00870C 5C               [ 1] 1054 	incw	x
      00870D 89               [ 2] 1055 	pushw	x
      00870E 4B 07            [ 1] 1056 	push	#0x07
      008710 A6 3C            [ 1] 1057 	ld	a, #0x3c
      008712 CD 85 70         [ 4] 1058 	call	_i2c_write
                                   1059 ;	main.c: 78: }
      008715 5B 07            [ 2] 1060 	addw	sp, #7
      008717 81               [ 4] 1061 	ret
                                   1062 ;	main.c: 80: void display_set_params_to_write(void)
                                   1063 ;	-----------------------------------------
                                   1064 ;	 function display_set_params_to_write
                                   1065 ;	-----------------------------------------
      008718                       1066 _display_set_params_to_write:
      008718 52 08            [ 2] 1067 	sub	sp, #8
                                   1068 ;	main.c: 82: uint8_t set_params_buf[8] = {0x00,0x22,0x00,0x03,0x00,0x21,0x00,0x7F};
      00871A 96               [ 1] 1069 	ldw	x, sp
      00871B 5C               [ 1] 1070 	incw	x
      00871C 7F               [ 1] 1071 	clr	(x)
      00871D A6 22            [ 1] 1072 	ld	a, #0x22
      00871F 6B 02            [ 1] 1073 	ld	(0x02, sp), a
      008721 0F 03            [ 1] 1074 	clr	(0x03, sp)
      008723 A6 03            [ 1] 1075 	ld	a, #0x03
      008725 6B 04            [ 1] 1076 	ld	(0x04, sp), a
      008727 0F 05            [ 1] 1077 	clr	(0x05, sp)
      008729 A6 21            [ 1] 1078 	ld	a, #0x21
      00872B 6B 06            [ 1] 1079 	ld	(0x06, sp), a
      00872D 0F 07            [ 1] 1080 	clr	(0x07, sp)
      00872F A6 7F            [ 1] 1081 	ld	a, #0x7f
      008731 6B 08            [ 1] 1082 	ld	(0x08, sp), a
                                   1083 ;	main.c: 83: i2c_write(I2C_DISPLAY_ADDR,8,set_params_buf);
      008733 89               [ 2] 1084 	pushw	x
      008734 4B 08            [ 1] 1085 	push	#0x08
      008736 A6 3C            [ 1] 1086 	ld	a, #0x3c
      008738 CD 85 70         [ 4] 1087 	call	_i2c_write
                                   1088 ;	main.c: 84: }
      00873B 5B 08            [ 2] 1089 	addw	sp, #8
      00873D 81               [ 4] 1090 	ret
                                   1091 ;	main.c: 91: void display_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1092 ;	-----------------------------------------
                                   1093 ;	 function display_draw_pixel
                                   1094 ;	-----------------------------------------
      00873E                       1095 _display_draw_pixel:
      00873E 52 08            [ 2] 1096 	sub	sp, #8
      008740 1F 07            [ 2] 1097 	ldw	(0x07, sp), x
                                   1098 ;	main.c: 93: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      008742 6B 06            [ 1] 1099 	ld	(0x06, sp), a
      008744 0F 05            [ 1] 1100 	clr	(0x05, sp)
      008746 7B 0B            [ 1] 1101 	ld	a, (0x0b, sp)
      008748 0F 01            [ 1] 1102 	clr	(0x01, sp)
      00874A 97               [ 1] 1103 	ld	xl, a
      00874B 02               [ 1] 1104 	rlwa	x
      00874C 4F               [ 1] 1105 	clr	a
      00874D 01               [ 1] 1106 	rrwa	x
      00874E 5D               [ 2] 1107 	tnzw	x
      00874F 2A 03            [ 1] 1108 	jrpl	00103$
      008751 1C 00 07         [ 2] 1109 	addw	x, #0x0007
      008754                       1110 00103$:
      008754 57               [ 2] 1111 	sraw	x
      008755 57               [ 2] 1112 	sraw	x
      008756 57               [ 2] 1113 	sraw	x
      008757 58               [ 2] 1114 	sllw	x
      008758 58               [ 2] 1115 	sllw	x
      008759 58               [ 2] 1116 	sllw	x
      00875A 58               [ 2] 1117 	sllw	x
      00875B 58               [ 2] 1118 	sllw	x
      00875C 58               [ 2] 1119 	sllw	x
      00875D 58               [ 2] 1120 	sllw	x
      00875E 72 FB 05         [ 2] 1121 	addw	x, (0x05, sp)
      008761 72 FB 07         [ 2] 1122 	addw	x, (0x07, sp)
      008764 1F 03            [ 2] 1123 	ldw	(0x03, sp), x
      008766 90 5F            [ 1] 1124 	clrw	y
      008768 61               [ 1] 1125 	exg	a, yl
      008769 7B 0C            [ 1] 1126 	ld	a, (0x0c, sp)
      00876B 61               [ 1] 1127 	exg	a, yl
      00876C A4 07            [ 1] 1128 	and	a, #0x07
      00876E 6B 06            [ 1] 1129 	ld	(0x06, sp), a
      008770 0F 05            [ 1] 1130 	clr	(0x05, sp)
      008772 1E 03            [ 2] 1131 	ldw	x, (0x03, sp)
      008774 F6               [ 1] 1132 	ld	a, (x)
      008775 5F               [ 1] 1133 	clrw	x
      008776 90 89            [ 2] 1134 	pushw	y
      008778 16 07            [ 2] 1135 	ldw	y, (0x07, sp)
      00877A 90 89            [ 2] 1136 	pushw	y
      00877C 97               [ 1] 1137 	ld	xl, a
      00877D CD 85 F8         [ 4] 1138 	call	_set_bit
      008780 9F               [ 1] 1139 	ld	a, xl
      008781 1E 03            [ 2] 1140 	ldw	x, (0x03, sp)
      008783 F7               [ 1] 1141 	ld	(x), a
                                   1142 ;	main.c: 94: }
      008784 1E 09            [ 2] 1143 	ldw	x, (9, sp)
      008786 5B 0C            [ 2] 1144 	addw	sp, #12
      008788 FC               [ 2] 1145 	jp	(x)
                                   1146 ;	main.c: 96: void display_buffer_fill_entire(uint8_t *in_data, uint8_t *out_data) {
                                   1147 ;	-----------------------------------------
                                   1148 ;	 function display_buffer_fill_entire
                                   1149 ;	-----------------------------------------
      008789                       1150 _display_buffer_fill_entire:
      008789 52 0A            [ 2] 1151 	sub	sp, #10
      00878B 1F 05            [ 2] 1152 	ldw	(0x05, sp), x
                                   1153 ;	main.c: 98: for (int height = 0; height < SSD1306_LCDHEIGHT; height++) {
      00878D 5F               [ 1] 1154 	clrw	x
      00878E 1F 07            [ 2] 1155 	ldw	(0x07, sp), x
      008790                       1156 00107$:
      008790 1E 07            [ 2] 1157 	ldw	x, (0x07, sp)
      008792 A3 00 20         [ 2] 1158 	cpw	x, #0x0020
      008795 2E 5A            [ 1] 1159 	jrsge	00109$
                                   1160 ;	main.c: 99: for (int width = 0; width < SSD1306_LCDWIDTH; width++) {
      008797 1E 07            [ 2] 1161 	ldw	x, (0x07, sp)
      008799 58               [ 2] 1162 	sllw	x
      00879A 58               [ 2] 1163 	sllw	x
      00879B 58               [ 2] 1164 	sllw	x
      00879C 58               [ 2] 1165 	sllw	x
      00879D 1F 01            [ 2] 1166 	ldw	(0x01, sp), x
      00879F 5F               [ 1] 1167 	clrw	x
      0087A0 1F 09            [ 2] 1168 	ldw	(0x09, sp), x
      0087A2                       1169 00104$:
      0087A2 1E 09            [ 2] 1170 	ldw	x, (0x09, sp)
      0087A4 A3 00 80         [ 2] 1171 	cpw	x, #0x0080
      0087A7 2E 41            [ 1] 1172 	jrsge	00108$
                                   1173 ;	main.c: 101: display_draw_pixel(out_data, width, height, get_bit(in_data[(height * 16) + (width / 8)], 7 - (width % 8)));
      0087A9 4B 08            [ 1] 1174 	push	#0x08
      0087AB 4B 00            [ 1] 1175 	push	#0x00
      0087AD 1E 0B            [ 2] 1176 	ldw	x, (0x0b, sp)
      0087AF CD 8E 30         [ 4] 1177 	call	__modsint
      0087B2 1F 03            [ 2] 1178 	ldw	(0x03, sp), x
      0087B4 90 AE 00 07      [ 2] 1179 	ldw	y, #0x0007
      0087B8 72 F2 03         [ 2] 1180 	subw	y, (0x03, sp)
      0087BB 1E 09            [ 2] 1181 	ldw	x, (0x09, sp)
      0087BD 2A 03            [ 1] 1182 	jrpl	00143$
      0087BF 1C 00 07         [ 2] 1183 	addw	x, #0x0007
      0087C2                       1184 00143$:
      0087C2 57               [ 2] 1185 	sraw	x
      0087C3 57               [ 2] 1186 	sraw	x
      0087C4 57               [ 2] 1187 	sraw	x
      0087C5 72 FB 01         [ 2] 1188 	addw	x, (0x01, sp)
      0087C8 72 FB 05         [ 2] 1189 	addw	x, (0x05, sp)
      0087CB F6               [ 1] 1190 	ld	a, (x)
      0087CC 5F               [ 1] 1191 	clrw	x
      0087CD 90 89            [ 2] 1192 	pushw	y
      0087CF 97               [ 1] 1193 	ld	xl, a
      0087D0 CD 85 E3         [ 4] 1194 	call	_get_bit
      0087D3 7B 08            [ 1] 1195 	ld	a, (0x08, sp)
      0087D5 02               [ 1] 1196 	rlwa	x
      0087D6 7B 0A            [ 1] 1197 	ld	a, (0x0a, sp)
      0087D8 01               [ 1] 1198 	rrwa	x
      0087D9 89               [ 2] 1199 	pushw	x
      0087DA 5B 01            [ 2] 1200 	addw	sp, #1
      0087DC 88               [ 1] 1201 	push	a
      0087DD 9E               [ 1] 1202 	ld	a, xh
      0087DE 1E 0F            [ 2] 1203 	ldw	x, (0x0f, sp)
      0087E0 CD 87 3E         [ 4] 1204 	call	_display_draw_pixel
                                   1205 ;	main.c: 99: for (int width = 0; width < SSD1306_LCDWIDTH; width++) {
      0087E3 1E 09            [ 2] 1206 	ldw	x, (0x09, sp)
      0087E5 5C               [ 1] 1207 	incw	x
      0087E6 1F 09            [ 2] 1208 	ldw	(0x09, sp), x
      0087E8 20 B8            [ 2] 1209 	jra	00104$
      0087EA                       1210 00108$:
                                   1211 ;	main.c: 98: for (int height = 0; height < SSD1306_LCDHEIGHT; height++) {
      0087EA 1E 07            [ 2] 1212 	ldw	x, (0x07, sp)
      0087EC 5C               [ 1] 1213 	incw	x
      0087ED 1F 07            [ 2] 1214 	ldw	(0x07, sp), x
      0087EF 20 9F            [ 2] 1215 	jra	00107$
      0087F1                       1216 00109$:
                                   1217 ;	main.c: 106: }
      0087F1 1E 0B            [ 2] 1218 	ldw	x, (11, sp)
      0087F3 5B 0E            [ 2] 1219 	addw	sp, #14
      0087F5 FC               [ 2] 1220 	jp	(x)
                                   1221 ;	main.c: 113: void display_set(uint8_t *data) {
                                   1222 ;	-----------------------------------------
                                   1223 ;	 function display_set
                                   1224 ;	-----------------------------------------
      0087F6                       1225 _display_set:
      0087F6 52 29            [ 2] 1226 	sub	sp, #41
      0087F8 1F 26            [ 2] 1227 	ldw	(0x26, sp), x
                                   1228 ;	main.c: 115: display_set_params_to_write();
      0087FA CD 87 18         [ 4] 1229 	call	_display_set_params_to_write
                                   1230 ;	main.c: 117: do {
      0087FD 5F               [ 1] 1231 	clrw	x
      0087FE 1F 28            [ 2] 1232 	ldw	(0x28, sp), x
      008800                       1233 00102$:
                                   1234 ;	main.c: 118: uint8_t set_buf[33] = {0x40};
      008800 A6 40            [ 1] 1235 	ld	a, #0x40
      008802 6B 01            [ 1] 1236 	ld	(0x01, sp), a
      008804 0F 02            [ 1] 1237 	clr	(0x02, sp)
      008806 0F 03            [ 1] 1238 	clr	(0x03, sp)
      008808 0F 04            [ 1] 1239 	clr	(0x04, sp)
      00880A 0F 05            [ 1] 1240 	clr	(0x05, sp)
      00880C 0F 06            [ 1] 1241 	clr	(0x06, sp)
      00880E 0F 07            [ 1] 1242 	clr	(0x07, sp)
      008810 0F 08            [ 1] 1243 	clr	(0x08, sp)
      008812 0F 09            [ 1] 1244 	clr	(0x09, sp)
      008814 0F 0A            [ 1] 1245 	clr	(0x0a, sp)
      008816 0F 0B            [ 1] 1246 	clr	(0x0b, sp)
      008818 0F 0C            [ 1] 1247 	clr	(0x0c, sp)
      00881A 0F 0D            [ 1] 1248 	clr	(0x0d, sp)
      00881C 0F 0E            [ 1] 1249 	clr	(0x0e, sp)
      00881E 0F 0F            [ 1] 1250 	clr	(0x0f, sp)
      008820 0F 10            [ 1] 1251 	clr	(0x10, sp)
      008822 0F 11            [ 1] 1252 	clr	(0x11, sp)
      008824 0F 12            [ 1] 1253 	clr	(0x12, sp)
      008826 0F 13            [ 1] 1254 	clr	(0x13, sp)
      008828 0F 14            [ 1] 1255 	clr	(0x14, sp)
      00882A 0F 15            [ 1] 1256 	clr	(0x15, sp)
      00882C 0F 16            [ 1] 1257 	clr	(0x16, sp)
      00882E 0F 17            [ 1] 1258 	clr	(0x17, sp)
      008830 0F 18            [ 1] 1259 	clr	(0x18, sp)
      008832 0F 19            [ 1] 1260 	clr	(0x19, sp)
      008834 0F 1A            [ 1] 1261 	clr	(0x1a, sp)
      008836 0F 1B            [ 1] 1262 	clr	(0x1b, sp)
      008838 0F 1C            [ 1] 1263 	clr	(0x1c, sp)
      00883A 0F 1D            [ 1] 1264 	clr	(0x1d, sp)
      00883C 0F 1E            [ 1] 1265 	clr	(0x1e, sp)
      00883E 0F 1F            [ 1] 1266 	clr	(0x1f, sp)
      008840 0F 20            [ 1] 1267 	clr	(0x20, sp)
      008842 0F 21            [ 1] 1268 	clr	(0x21, sp)
                                   1269 ;	main.c: 119: for (int o = 0; o < 32; o++) {
      008844 5F               [ 1] 1270 	clrw	x
      008845                       1271 00106$:
      008845 A3 00 20         [ 2] 1272 	cpw	x, #0x0020
      008848 2E 24            [ 1] 1273 	jrsge	00101$
                                   1274 ;	main.c: 120: set_buf[o + 1] = data[i + o];
      00884A 9F               [ 1] 1275 	ld	a, xl
      00884B 4C               [ 1] 1276 	inc	a
      00884C 6B 23            [ 1] 1277 	ld	(0x23, sp), a
      00884E 49               [ 1] 1278 	rlc	a
      00884F 4F               [ 1] 1279 	clr	a
      008850 A2 00            [ 1] 1280 	sbc	a, #0x00
      008852 6B 22            [ 1] 1281 	ld	(0x22, sp), a
      008854 90 96            [ 1] 1282 	ldw	y, sp
      008856 90 5C            [ 1] 1283 	incw	y
      008858 72 F9 22         [ 2] 1284 	addw	y, (0x22, sp)
      00885B 17 24            [ 2] 1285 	ldw	(0x24, sp), y
      00885D 90 93            [ 1] 1286 	ldw	y, x
      00885F 72 F9 28         [ 2] 1287 	addw	y, (0x28, sp)
      008862 72 F9 26         [ 2] 1288 	addw	y, (0x26, sp)
      008865 90 F6            [ 1] 1289 	ld	a, (y)
      008867 16 24            [ 2] 1290 	ldw	y, (0x24, sp)
      008869 90 F7            [ 1] 1291 	ld	(y), a
                                   1292 ;	main.c: 119: for (int o = 0; o < 32; o++) {
      00886B 5C               [ 1] 1293 	incw	x
      00886C 20 D7            [ 2] 1294 	jra	00106$
      00886E                       1295 00101$:
                                   1296 ;	main.c: 122: i2c_write(I2C_DISPLAY_ADDR, 33, set_buf);
      00886E 96               [ 1] 1297 	ldw	x, sp
      00886F 5C               [ 1] 1298 	incw	x
      008870 89               [ 2] 1299 	pushw	x
      008871 4B 21            [ 1] 1300 	push	#0x21
      008873 A6 3C            [ 1] 1301 	ld	a, #0x3c
      008875 CD 85 70         [ 4] 1302 	call	_i2c_write
                                   1303 ;	main.c: 123: i += 32;
      008878 1E 28            [ 2] 1304 	ldw	x, (0x28, sp)
      00887A 1C 00 20         [ 2] 1305 	addw	x, #0x0020
                                   1306 ;	main.c: 124: } while (i < 512);
      00887D 1F 28            [ 2] 1307 	ldw	(0x28, sp), x
      00887F A3 02 00         [ 2] 1308 	cpw	x, #0x0200
      008882 2E 03            [ 1] 1309 	jrsge	00134$
      008884 CC 88 00         [ 2] 1310 	jp	00102$
      008887                       1311 00134$:
                                   1312 ;	main.c: 125: }
      008887 5B 29            [ 2] 1313 	addw	sp, #41
      008889 81               [ 4] 1314 	ret
                                   1315 ;	main.c: 128: void display_clean(void)
                                   1316 ;	-----------------------------------------
                                   1317 ;	 function display_clean
                                   1318 ;	-----------------------------------------
      00888A                       1319 _display_clean:
      00888A 52 21            [ 2] 1320 	sub	sp, #33
                                   1321 ;	main.c: 130: uint8_t clean_buf[33] = {0x40};
      00888C A6 40            [ 1] 1322 	ld	a, #0x40
      00888E 6B 01            [ 1] 1323 	ld	(0x01, sp), a
      008890 0F 02            [ 1] 1324 	clr	(0x02, sp)
      008892 0F 03            [ 1] 1325 	clr	(0x03, sp)
      008894 0F 04            [ 1] 1326 	clr	(0x04, sp)
      008896 0F 05            [ 1] 1327 	clr	(0x05, sp)
      008898 0F 06            [ 1] 1328 	clr	(0x06, sp)
      00889A 0F 07            [ 1] 1329 	clr	(0x07, sp)
      00889C 0F 08            [ 1] 1330 	clr	(0x08, sp)
      00889E 0F 09            [ 1] 1331 	clr	(0x09, sp)
      0088A0 0F 0A            [ 1] 1332 	clr	(0x0a, sp)
      0088A2 0F 0B            [ 1] 1333 	clr	(0x0b, sp)
      0088A4 0F 0C            [ 1] 1334 	clr	(0x0c, sp)
      0088A6 0F 0D            [ 1] 1335 	clr	(0x0d, sp)
      0088A8 0F 0E            [ 1] 1336 	clr	(0x0e, sp)
      0088AA 0F 0F            [ 1] 1337 	clr	(0x0f, sp)
      0088AC 0F 10            [ 1] 1338 	clr	(0x10, sp)
      0088AE 0F 11            [ 1] 1339 	clr	(0x11, sp)
      0088B0 0F 12            [ 1] 1340 	clr	(0x12, sp)
      0088B2 0F 13            [ 1] 1341 	clr	(0x13, sp)
      0088B4 0F 14            [ 1] 1342 	clr	(0x14, sp)
      0088B6 0F 15            [ 1] 1343 	clr	(0x15, sp)
      0088B8 0F 16            [ 1] 1344 	clr	(0x16, sp)
      0088BA 0F 17            [ 1] 1345 	clr	(0x17, sp)
      0088BC 0F 18            [ 1] 1346 	clr	(0x18, sp)
      0088BE 0F 19            [ 1] 1347 	clr	(0x19, sp)
      0088C0 0F 1A            [ 1] 1348 	clr	(0x1a, sp)
      0088C2 0F 1B            [ 1] 1349 	clr	(0x1b, sp)
      0088C4 0F 1C            [ 1] 1350 	clr	(0x1c, sp)
      0088C6 0F 1D            [ 1] 1351 	clr	(0x1d, sp)
      0088C8 0F 1E            [ 1] 1352 	clr	(0x1e, sp)
      0088CA 0F 1F            [ 1] 1353 	clr	(0x1f, sp)
      0088CC 0F 20            [ 1] 1354 	clr	(0x20, sp)
      0088CE 0F 21            [ 1] 1355 	clr	(0x21, sp)
                                   1356 ;	main.c: 132: display_set_params_to_write();
      0088D0 CD 87 18         [ 4] 1357 	call	_display_set_params_to_write
                                   1358 ;	main.c: 134: for(int i = 0;i<16;i++)
      0088D3 4F               [ 1] 1359 	clr	a
      0088D4                       1360 00103$:
      0088D4 A1 10            [ 1] 1361 	cp	a, #0x10
      0088D6 24 10            [ 1] 1362 	jrnc	00105$
                                   1363 ;	main.c: 135: i2c_write(I2C_DISPLAY_ADDR,33,clean_buf);
      0088D8 88               [ 1] 1364 	push	a
      0088D9 96               [ 1] 1365 	ldw	x, sp
      0088DA 5C               [ 1] 1366 	incw	x
      0088DB 5C               [ 1] 1367 	incw	x
      0088DC 89               [ 2] 1368 	pushw	x
      0088DD 4B 21            [ 1] 1369 	push	#0x21
      0088DF A6 3C            [ 1] 1370 	ld	a, #0x3c
      0088E1 CD 85 70         [ 4] 1371 	call	_i2c_write
      0088E4 84               [ 1] 1372 	pop	a
                                   1373 ;	main.c: 134: for(int i = 0;i<16;i++)
      0088E5 4C               [ 1] 1374 	inc	a
      0088E6 20 EC            [ 2] 1375 	jra	00103$
      0088E8                       1376 00105$:
                                   1377 ;	main.c: 137: }
      0088E8 5B 21            [ 2] 1378 	addw	sp, #33
      0088EA 81               [ 4] 1379 	ret
                                   1380 ;	main.c: 139: void gg(void)
                                   1381 ;	-----------------------------------------
                                   1382 ;	 function gg
                                   1383 ;	-----------------------------------------
      0088EB                       1384 _gg:
      0088EB 90 96            [ 1] 1385 	ldw	y, sp
      0088ED 72 A2 01 07      [ 2] 1386 	subw	y, #263
      0088F1 90 94            [ 1] 1387 	ldw	sp, y
      0088F3 52 F9            [ 2] 1388 	sub	sp, #249
                                   1389 ;	main.c: 141: display_init();
      0088F5 90 89            [ 2] 1390 	pushw	y
      0088F7 CD 86 35         [ 4] 1391 	call	_display_init
      0088FA CD 88 8A         [ 4] 1392 	call	_display_clean
      0088FD 90 85            [ 2] 1393 	popw	y
                                   1394 ;	main.c: 144: uint8_t buffer[512] = {0};
      0088FF 0F 01            [ 1] 1395 	clr	(0x01, sp)
      008901 0F 02            [ 1] 1396 	clr	(0x02, sp)
      008903 0F 03            [ 1] 1397 	clr	(0x03, sp)
      008905 0F 04            [ 1] 1398 	clr	(0x04, sp)
      008907 0F 05            [ 1] 1399 	clr	(0x05, sp)
      008909 0F 06            [ 1] 1400 	clr	(0x06, sp)
      00890B 0F 07            [ 1] 1401 	clr	(0x07, sp)
      00890D 0F 08            [ 1] 1402 	clr	(0x08, sp)
      00890F 0F 09            [ 1] 1403 	clr	(0x09, sp)
      008911 0F 0A            [ 1] 1404 	clr	(0x0a, sp)
      008913 0F 0B            [ 1] 1405 	clr	(0x0b, sp)
      008915 0F 0C            [ 1] 1406 	clr	(0x0c, sp)
      008917 0F 0D            [ 1] 1407 	clr	(0x0d, sp)
      008919 0F 0E            [ 1] 1408 	clr	(0x0e, sp)
      00891B 0F 0F            [ 1] 1409 	clr	(0x0f, sp)
      00891D 0F 10            [ 1] 1410 	clr	(0x10, sp)
      00891F 0F 11            [ 1] 1411 	clr	(0x11, sp)
      008921 0F 12            [ 1] 1412 	clr	(0x12, sp)
      008923 0F 13            [ 1] 1413 	clr	(0x13, sp)
      008925 0F 14            [ 1] 1414 	clr	(0x14, sp)
      008927 0F 15            [ 1] 1415 	clr	(0x15, sp)
      008929 0F 16            [ 1] 1416 	clr	(0x16, sp)
      00892B 0F 17            [ 1] 1417 	clr	(0x17, sp)
      00892D 0F 18            [ 1] 1418 	clr	(0x18, sp)
      00892F 0F 19            [ 1] 1419 	clr	(0x19, sp)
      008931 0F 1A            [ 1] 1420 	clr	(0x1a, sp)
      008933 0F 1B            [ 1] 1421 	clr	(0x1b, sp)
      008935 0F 1C            [ 1] 1422 	clr	(0x1c, sp)
      008937 0F 1D            [ 1] 1423 	clr	(0x1d, sp)
      008939 0F 1E            [ 1] 1424 	clr	(0x1e, sp)
      00893B 0F 1F            [ 1] 1425 	clr	(0x1f, sp)
      00893D 0F 20            [ 1] 1426 	clr	(0x20, sp)
      00893F 0F 21            [ 1] 1427 	clr	(0x21, sp)
      008941 0F 22            [ 1] 1428 	clr	(0x22, sp)
      008943 0F 23            [ 1] 1429 	clr	(0x23, sp)
      008945 0F 24            [ 1] 1430 	clr	(0x24, sp)
      008947 0F 25            [ 1] 1431 	clr	(0x25, sp)
      008949 0F 26            [ 1] 1432 	clr	(0x26, sp)
      00894B 0F 27            [ 1] 1433 	clr	(0x27, sp)
      00894D 0F 28            [ 1] 1434 	clr	(0x28, sp)
      00894F 0F 29            [ 1] 1435 	clr	(0x29, sp)
      008951 0F 2A            [ 1] 1436 	clr	(0x2a, sp)
      008953 0F 2B            [ 1] 1437 	clr	(0x2b, sp)
      008955 0F 2C            [ 1] 1438 	clr	(0x2c, sp)
      008957 0F 2D            [ 1] 1439 	clr	(0x2d, sp)
      008959 0F 2E            [ 1] 1440 	clr	(0x2e, sp)
      00895B 0F 2F            [ 1] 1441 	clr	(0x2f, sp)
      00895D 0F 30            [ 1] 1442 	clr	(0x30, sp)
      00895F 0F 31            [ 1] 1443 	clr	(0x31, sp)
      008961 0F 32            [ 1] 1444 	clr	(0x32, sp)
      008963 0F 33            [ 1] 1445 	clr	(0x33, sp)
      008965 0F 34            [ 1] 1446 	clr	(0x34, sp)
      008967 0F 35            [ 1] 1447 	clr	(0x35, sp)
      008969 0F 36            [ 1] 1448 	clr	(0x36, sp)
      00896B 0F 37            [ 1] 1449 	clr	(0x37, sp)
      00896D 0F 38            [ 1] 1450 	clr	(0x38, sp)
      00896F 0F 39            [ 1] 1451 	clr	(0x39, sp)
      008971 0F 3A            [ 1] 1452 	clr	(0x3a, sp)
      008973 0F 3B            [ 1] 1453 	clr	(0x3b, sp)
      008975 0F 3C            [ 1] 1454 	clr	(0x3c, sp)
      008977 0F 3D            [ 1] 1455 	clr	(0x3d, sp)
      008979 0F 3E            [ 1] 1456 	clr	(0x3e, sp)
      00897B 0F 3F            [ 1] 1457 	clr	(0x3f, sp)
      00897D 0F 40            [ 1] 1458 	clr	(0x40, sp)
      00897F 0F 41            [ 1] 1459 	clr	(0x41, sp)
      008981 0F 42            [ 1] 1460 	clr	(0x42, sp)
      008983 0F 43            [ 1] 1461 	clr	(0x43, sp)
      008985 0F 44            [ 1] 1462 	clr	(0x44, sp)
      008987 0F 45            [ 1] 1463 	clr	(0x45, sp)
      008989 0F 46            [ 1] 1464 	clr	(0x46, sp)
      00898B 0F 47            [ 1] 1465 	clr	(0x47, sp)
      00898D 0F 48            [ 1] 1466 	clr	(0x48, sp)
      00898F 0F 49            [ 1] 1467 	clr	(0x49, sp)
      008991 0F 4A            [ 1] 1468 	clr	(0x4a, sp)
      008993 0F 4B            [ 1] 1469 	clr	(0x4b, sp)
      008995 0F 4C            [ 1] 1470 	clr	(0x4c, sp)
      008997 0F 4D            [ 1] 1471 	clr	(0x4d, sp)
      008999 0F 4E            [ 1] 1472 	clr	(0x4e, sp)
      00899B 0F 4F            [ 1] 1473 	clr	(0x4f, sp)
      00899D 0F 50            [ 1] 1474 	clr	(0x50, sp)
      00899F 0F 51            [ 1] 1475 	clr	(0x51, sp)
      0089A1 0F 52            [ 1] 1476 	clr	(0x52, sp)
      0089A3 0F 53            [ 1] 1477 	clr	(0x53, sp)
      0089A5 0F 54            [ 1] 1478 	clr	(0x54, sp)
      0089A7 0F 55            [ 1] 1479 	clr	(0x55, sp)
      0089A9 0F 56            [ 1] 1480 	clr	(0x56, sp)
      0089AB 0F 57            [ 1] 1481 	clr	(0x57, sp)
      0089AD 0F 58            [ 1] 1482 	clr	(0x58, sp)
      0089AF 0F 59            [ 1] 1483 	clr	(0x59, sp)
      0089B1 0F 5A            [ 1] 1484 	clr	(0x5a, sp)
      0089B3 0F 5B            [ 1] 1485 	clr	(0x5b, sp)
      0089B5 0F 5C            [ 1] 1486 	clr	(0x5c, sp)
      0089B7 0F 5D            [ 1] 1487 	clr	(0x5d, sp)
      0089B9 0F 5E            [ 1] 1488 	clr	(0x5e, sp)
      0089BB 0F 5F            [ 1] 1489 	clr	(0x5f, sp)
      0089BD 0F 60            [ 1] 1490 	clr	(0x60, sp)
      0089BF 0F 61            [ 1] 1491 	clr	(0x61, sp)
      0089C1 0F 62            [ 1] 1492 	clr	(0x62, sp)
      0089C3 0F 63            [ 1] 1493 	clr	(0x63, sp)
      0089C5 0F 64            [ 1] 1494 	clr	(0x64, sp)
      0089C7 0F 65            [ 1] 1495 	clr	(0x65, sp)
      0089C9 0F 66            [ 1] 1496 	clr	(0x66, sp)
      0089CB 0F 67            [ 1] 1497 	clr	(0x67, sp)
      0089CD 0F 68            [ 1] 1498 	clr	(0x68, sp)
      0089CF 0F 69            [ 1] 1499 	clr	(0x69, sp)
      0089D1 0F 6A            [ 1] 1500 	clr	(0x6a, sp)
      0089D3 0F 6B            [ 1] 1501 	clr	(0x6b, sp)
      0089D5 0F 6C            [ 1] 1502 	clr	(0x6c, sp)
      0089D7 0F 6D            [ 1] 1503 	clr	(0x6d, sp)
      0089D9 0F 6E            [ 1] 1504 	clr	(0x6e, sp)
      0089DB 0F 6F            [ 1] 1505 	clr	(0x6f, sp)
      0089DD 0F 70            [ 1] 1506 	clr	(0x70, sp)
      0089DF 0F 71            [ 1] 1507 	clr	(0x71, sp)
      0089E1 0F 72            [ 1] 1508 	clr	(0x72, sp)
      0089E3 0F 73            [ 1] 1509 	clr	(0x73, sp)
      0089E5 0F 74            [ 1] 1510 	clr	(0x74, sp)
      0089E7 0F 75            [ 1] 1511 	clr	(0x75, sp)
      0089E9 0F 76            [ 1] 1512 	clr	(0x76, sp)
      0089EB 0F 77            [ 1] 1513 	clr	(0x77, sp)
      0089ED 0F 78            [ 1] 1514 	clr	(0x78, sp)
      0089EF 0F 79            [ 1] 1515 	clr	(0x79, sp)
      0089F1 0F 7A            [ 1] 1516 	clr	(0x7a, sp)
      0089F3 0F 7B            [ 1] 1517 	clr	(0x7b, sp)
      0089F5 0F 7C            [ 1] 1518 	clr	(0x7c, sp)
      0089F7 0F 7D            [ 1] 1519 	clr	(0x7d, sp)
      0089F9 0F 7E            [ 1] 1520 	clr	(0x7e, sp)
      0089FB 0F 7F            [ 1] 1521 	clr	(0x7f, sp)
      0089FD 0F 80            [ 1] 1522 	clr	(0x80, sp)
      0089FF 0F 81            [ 1] 1523 	clr	(0x81, sp)
      008A01 0F 82            [ 1] 1524 	clr	(0x82, sp)
      008A03 0F 83            [ 1] 1525 	clr	(0x83, sp)
      008A05 0F 84            [ 1] 1526 	clr	(0x84, sp)
      008A07 0F 85            [ 1] 1527 	clr	(0x85, sp)
      008A09 0F 86            [ 1] 1528 	clr	(0x86, sp)
      008A0B 0F 87            [ 1] 1529 	clr	(0x87, sp)
      008A0D 0F 88            [ 1] 1530 	clr	(0x88, sp)
      008A0F 0F 89            [ 1] 1531 	clr	(0x89, sp)
      008A11 0F 8A            [ 1] 1532 	clr	(0x8a, sp)
      008A13 0F 8B            [ 1] 1533 	clr	(0x8b, sp)
      008A15 0F 8C            [ 1] 1534 	clr	(0x8c, sp)
      008A17 0F 8D            [ 1] 1535 	clr	(0x8d, sp)
      008A19 0F 8E            [ 1] 1536 	clr	(0x8e, sp)
      008A1B 0F 8F            [ 1] 1537 	clr	(0x8f, sp)
      008A1D 0F 90            [ 1] 1538 	clr	(0x90, sp)
      008A1F 0F 91            [ 1] 1539 	clr	(0x91, sp)
      008A21 0F 92            [ 1] 1540 	clr	(0x92, sp)
      008A23 0F 93            [ 1] 1541 	clr	(0x93, sp)
      008A25 0F 94            [ 1] 1542 	clr	(0x94, sp)
      008A27 0F 95            [ 1] 1543 	clr	(0x95, sp)
      008A29 0F 96            [ 1] 1544 	clr	(0x96, sp)
      008A2B 0F 97            [ 1] 1545 	clr	(0x97, sp)
      008A2D 0F 98            [ 1] 1546 	clr	(0x98, sp)
      008A2F 0F 99            [ 1] 1547 	clr	(0x99, sp)
      008A31 0F 9A            [ 1] 1548 	clr	(0x9a, sp)
      008A33 0F 9B            [ 1] 1549 	clr	(0x9b, sp)
      008A35 0F 9C            [ 1] 1550 	clr	(0x9c, sp)
      008A37 0F 9D            [ 1] 1551 	clr	(0x9d, sp)
      008A39 0F 9E            [ 1] 1552 	clr	(0x9e, sp)
      008A3B 0F 9F            [ 1] 1553 	clr	(0x9f, sp)
      008A3D 0F A0            [ 1] 1554 	clr	(0xa0, sp)
      008A3F 0F A1            [ 1] 1555 	clr	(0xa1, sp)
      008A41 0F A2            [ 1] 1556 	clr	(0xa2, sp)
      008A43 0F A3            [ 1] 1557 	clr	(0xa3, sp)
      008A45 0F A4            [ 1] 1558 	clr	(0xa4, sp)
      008A47 0F A5            [ 1] 1559 	clr	(0xa5, sp)
      008A49 0F A6            [ 1] 1560 	clr	(0xa6, sp)
      008A4B 0F A7            [ 1] 1561 	clr	(0xa7, sp)
      008A4D 0F A8            [ 1] 1562 	clr	(0xa8, sp)
      008A4F 0F A9            [ 1] 1563 	clr	(0xa9, sp)
      008A51 0F AA            [ 1] 1564 	clr	(0xaa, sp)
      008A53 0F AB            [ 1] 1565 	clr	(0xab, sp)
      008A55 0F AC            [ 1] 1566 	clr	(0xac, sp)
      008A57 0F AD            [ 1] 1567 	clr	(0xad, sp)
      008A59 0F AE            [ 1] 1568 	clr	(0xae, sp)
      008A5B 0F AF            [ 1] 1569 	clr	(0xaf, sp)
      008A5D 0F B0            [ 1] 1570 	clr	(0xb0, sp)
      008A5F 0F B1            [ 1] 1571 	clr	(0xb1, sp)
      008A61 0F B2            [ 1] 1572 	clr	(0xb2, sp)
      008A63 0F B3            [ 1] 1573 	clr	(0xb3, sp)
      008A65 0F B4            [ 1] 1574 	clr	(0xb4, sp)
      008A67 0F B5            [ 1] 1575 	clr	(0xb5, sp)
      008A69 0F B6            [ 1] 1576 	clr	(0xb6, sp)
      008A6B 0F B7            [ 1] 1577 	clr	(0xb7, sp)
      008A6D 0F B8            [ 1] 1578 	clr	(0xb8, sp)
      008A6F 0F B9            [ 1] 1579 	clr	(0xb9, sp)
      008A71 0F BA            [ 1] 1580 	clr	(0xba, sp)
      008A73 0F BB            [ 1] 1581 	clr	(0xbb, sp)
      008A75 0F BC            [ 1] 1582 	clr	(0xbc, sp)
      008A77 0F BD            [ 1] 1583 	clr	(0xbd, sp)
      008A79 0F BE            [ 1] 1584 	clr	(0xbe, sp)
      008A7B 0F BF            [ 1] 1585 	clr	(0xbf, sp)
      008A7D 0F C0            [ 1] 1586 	clr	(0xc0, sp)
      008A7F 0F C1            [ 1] 1587 	clr	(0xc1, sp)
      008A81 0F C2            [ 1] 1588 	clr	(0xc2, sp)
      008A83 0F C3            [ 1] 1589 	clr	(0xc3, sp)
      008A85 0F C4            [ 1] 1590 	clr	(0xc4, sp)
      008A87 0F C5            [ 1] 1591 	clr	(0xc5, sp)
      008A89 0F C6            [ 1] 1592 	clr	(0xc6, sp)
      008A8B 0F C7            [ 1] 1593 	clr	(0xc7, sp)
      008A8D 0F C8            [ 1] 1594 	clr	(0xc8, sp)
      008A8F 0F C9            [ 1] 1595 	clr	(0xc9, sp)
      008A91 0F CA            [ 1] 1596 	clr	(0xca, sp)
      008A93 0F CB            [ 1] 1597 	clr	(0xcb, sp)
      008A95 0F CC            [ 1] 1598 	clr	(0xcc, sp)
      008A97 0F CD            [ 1] 1599 	clr	(0xcd, sp)
      008A99 0F CE            [ 1] 1600 	clr	(0xce, sp)
      008A9B 0F CF            [ 1] 1601 	clr	(0xcf, sp)
      008A9D 0F D0            [ 1] 1602 	clr	(0xd0, sp)
      008A9F 0F D1            [ 1] 1603 	clr	(0xd1, sp)
      008AA1 0F D2            [ 1] 1604 	clr	(0xd2, sp)
      008AA3 0F D3            [ 1] 1605 	clr	(0xd3, sp)
      008AA5 0F D4            [ 1] 1606 	clr	(0xd4, sp)
      008AA7 0F D5            [ 1] 1607 	clr	(0xd5, sp)
      008AA9 0F D6            [ 1] 1608 	clr	(0xd6, sp)
      008AAB 0F D7            [ 1] 1609 	clr	(0xd7, sp)
      008AAD 0F D8            [ 1] 1610 	clr	(0xd8, sp)
      008AAF 0F D9            [ 1] 1611 	clr	(0xd9, sp)
      008AB1 0F DA            [ 1] 1612 	clr	(0xda, sp)
      008AB3 0F DB            [ 1] 1613 	clr	(0xdb, sp)
      008AB5 0F DC            [ 1] 1614 	clr	(0xdc, sp)
      008AB7 0F DD            [ 1] 1615 	clr	(0xdd, sp)
      008AB9 0F DE            [ 1] 1616 	clr	(0xde, sp)
      008ABB 0F DF            [ 1] 1617 	clr	(0xdf, sp)
      008ABD 0F E0            [ 1] 1618 	clr	(0xe0, sp)
      008ABF 0F E1            [ 1] 1619 	clr	(0xe1, sp)
      008AC1 0F E2            [ 1] 1620 	clr	(0xe2, sp)
      008AC3 0F E3            [ 1] 1621 	clr	(0xe3, sp)
      008AC5 0F E4            [ 1] 1622 	clr	(0xe4, sp)
      008AC7 0F E5            [ 1] 1623 	clr	(0xe5, sp)
      008AC9 0F E6            [ 1] 1624 	clr	(0xe6, sp)
      008ACB 0F E7            [ 1] 1625 	clr	(0xe7, sp)
      008ACD 0F E8            [ 1] 1626 	clr	(0xe8, sp)
      008ACF 0F E9            [ 1] 1627 	clr	(0xe9, sp)
      008AD1 0F EA            [ 1] 1628 	clr	(0xea, sp)
      008AD3 0F EB            [ 1] 1629 	clr	(0xeb, sp)
      008AD5 0F EC            [ 1] 1630 	clr	(0xec, sp)
      008AD7 0F ED            [ 1] 1631 	clr	(0xed, sp)
      008AD9 0F EE            [ 1] 1632 	clr	(0xee, sp)
      008ADB 0F EF            [ 1] 1633 	clr	(0xef, sp)
      008ADD 0F F0            [ 1] 1634 	clr	(0xf0, sp)
      008ADF 0F F1            [ 1] 1635 	clr	(0xf1, sp)
      008AE1 0F F2            [ 1] 1636 	clr	(0xf2, sp)
      008AE3 0F F3            [ 1] 1637 	clr	(0xf3, sp)
      008AE5 0F F4            [ 1] 1638 	clr	(0xf4, sp)
      008AE7 0F F5            [ 1] 1639 	clr	(0xf5, sp)
      008AE9 0F F6            [ 1] 1640 	clr	(0xf6, sp)
      008AEB 0F F7            [ 1] 1641 	clr	(0xf7, sp)
      008AED 0F F8            [ 1] 1642 	clr	(0xf8, sp)
      008AEF 0F F9            [ 1] 1643 	clr	(0xf9, sp)
      008AF1 0F FA            [ 1] 1644 	clr	(0xfa, sp)
      008AF3 0F FB            [ 1] 1645 	clr	(0xfb, sp)
      008AF5 0F FC            [ 1] 1646 	clr	(0xfc, sp)
      008AF7 0F FD            [ 1] 1647 	clr	(0xfd, sp)
      008AF9 0F FE            [ 1] 1648 	clr	(0xfe, sp)
      008AFB 0F FF            [ 1] 1649 	clr	(0xff, sp)
      008AFD 90 6F 07         [ 1] 1650 	clr	(0x7, y)
      008B00 90 6F 08         [ 1] 1651 	clr	(0x8, y)
      008B03 90 6F 09         [ 1] 1652 	clr	(0x9, y)
      008B06 90 6F 0A         [ 1] 1653 	clr	(0xa, y)
      008B09 90 6F 0B         [ 1] 1654 	clr	(0xb, y)
      008B0C 90 6F 0C         [ 1] 1655 	clr	(0xc, y)
      008B0F 90 6F 0D         [ 1] 1656 	clr	(0xd, y)
      008B12 90 6F 0E         [ 1] 1657 	clr	(0xe, y)
      008B15 90 6F 0F         [ 1] 1658 	clr	(0xf, y)
      008B18 90 6F 10         [ 1] 1659 	clr	(0x10, y)
      008B1B 90 6F 11         [ 1] 1660 	clr	(0x11, y)
      008B1E 90 6F 12         [ 1] 1661 	clr	(0x12, y)
      008B21 90 6F 13         [ 1] 1662 	clr	(0x13, y)
      008B24 90 6F 14         [ 1] 1663 	clr	(0x14, y)
      008B27 90 6F 15         [ 1] 1664 	clr	(0x15, y)
      008B2A 90 6F 16         [ 1] 1665 	clr	(0x16, y)
      008B2D 90 6F 17         [ 1] 1666 	clr	(0x17, y)
      008B30 90 6F 18         [ 1] 1667 	clr	(0x18, y)
      008B33 90 6F 19         [ 1] 1668 	clr	(0x19, y)
      008B36 90 6F 1A         [ 1] 1669 	clr	(0x1a, y)
      008B39 90 6F 1B         [ 1] 1670 	clr	(0x1b, y)
      008B3C 90 6F 1C         [ 1] 1671 	clr	(0x1c, y)
      008B3F 90 6F 1D         [ 1] 1672 	clr	(0x1d, y)
      008B42 90 6F 1E         [ 1] 1673 	clr	(0x1e, y)
      008B45 90 6F 1F         [ 1] 1674 	clr	(0x1f, y)
      008B48 90 6F 20         [ 1] 1675 	clr	(0x20, y)
      008B4B 90 6F 21         [ 1] 1676 	clr	(0x21, y)
      008B4E 90 6F 22         [ 1] 1677 	clr	(0x22, y)
      008B51 90 6F 23         [ 1] 1678 	clr	(0x23, y)
      008B54 90 6F 24         [ 1] 1679 	clr	(0x24, y)
      008B57 90 6F 25         [ 1] 1680 	clr	(0x25, y)
      008B5A 90 6F 26         [ 1] 1681 	clr	(0x26, y)
      008B5D 90 6F 27         [ 1] 1682 	clr	(0x27, y)
      008B60 90 6F 28         [ 1] 1683 	clr	(0x28, y)
      008B63 90 6F 29         [ 1] 1684 	clr	(0x29, y)
      008B66 90 6F 2A         [ 1] 1685 	clr	(0x2a, y)
      008B69 90 6F 2B         [ 1] 1686 	clr	(0x2b, y)
      008B6C 90 6F 2C         [ 1] 1687 	clr	(0x2c, y)
      008B6F 90 6F 2D         [ 1] 1688 	clr	(0x2d, y)
      008B72 90 6F 2E         [ 1] 1689 	clr	(0x2e, y)
      008B75 90 6F 2F         [ 1] 1690 	clr	(0x2f, y)
      008B78 90 6F 30         [ 1] 1691 	clr	(0x30, y)
      008B7B 90 6F 31         [ 1] 1692 	clr	(0x31, y)
      008B7E 90 6F 32         [ 1] 1693 	clr	(0x32, y)
      008B81 90 6F 33         [ 1] 1694 	clr	(0x33, y)
      008B84 90 6F 34         [ 1] 1695 	clr	(0x34, y)
      008B87 90 6F 35         [ 1] 1696 	clr	(0x35, y)
      008B8A 90 6F 36         [ 1] 1697 	clr	(0x36, y)
      008B8D 90 6F 37         [ 1] 1698 	clr	(0x37, y)
      008B90 90 6F 38         [ 1] 1699 	clr	(0x38, y)
      008B93 90 6F 39         [ 1] 1700 	clr	(0x39, y)
      008B96 90 6F 3A         [ 1] 1701 	clr	(0x3a, y)
      008B99 90 6F 3B         [ 1] 1702 	clr	(0x3b, y)
      008B9C 90 6F 3C         [ 1] 1703 	clr	(0x3c, y)
      008B9F 90 6F 3D         [ 1] 1704 	clr	(0x3d, y)
      008BA2 90 6F 3E         [ 1] 1705 	clr	(0x3e, y)
      008BA5 90 6F 3F         [ 1] 1706 	clr	(0x3f, y)
      008BA8 90 6F 40         [ 1] 1707 	clr	(0x40, y)
      008BAB 90 6F 41         [ 1] 1708 	clr	(0x41, y)
      008BAE 90 6F 42         [ 1] 1709 	clr	(0x42, y)
      008BB1 90 6F 43         [ 1] 1710 	clr	(0x43, y)
      008BB4 90 6F 44         [ 1] 1711 	clr	(0x44, y)
      008BB7 90 6F 45         [ 1] 1712 	clr	(0x45, y)
      008BBA 90 6F 46         [ 1] 1713 	clr	(0x46, y)
      008BBD 90 6F 47         [ 1] 1714 	clr	(0x47, y)
      008BC0 90 6F 48         [ 1] 1715 	clr	(0x48, y)
      008BC3 90 6F 49         [ 1] 1716 	clr	(0x49, y)
      008BC6 90 6F 4A         [ 1] 1717 	clr	(0x4a, y)
      008BC9 90 6F 4B         [ 1] 1718 	clr	(0x4b, y)
      008BCC 90 6F 4C         [ 1] 1719 	clr	(0x4c, y)
      008BCF 90 6F 4D         [ 1] 1720 	clr	(0x4d, y)
      008BD2 90 6F 4E         [ 1] 1721 	clr	(0x4e, y)
      008BD5 90 6F 4F         [ 1] 1722 	clr	(0x4f, y)
      008BD8 90 6F 50         [ 1] 1723 	clr	(0x50, y)
      008BDB 90 6F 51         [ 1] 1724 	clr	(0x51, y)
      008BDE 90 6F 52         [ 1] 1725 	clr	(0x52, y)
      008BE1 90 6F 53         [ 1] 1726 	clr	(0x53, y)
      008BE4 90 6F 54         [ 1] 1727 	clr	(0x54, y)
      008BE7 90 6F 55         [ 1] 1728 	clr	(0x55, y)
      008BEA 90 6F 56         [ 1] 1729 	clr	(0x56, y)
      008BED 90 6F 57         [ 1] 1730 	clr	(0x57, y)
      008BF0 90 6F 58         [ 1] 1731 	clr	(0x58, y)
      008BF3 90 6F 59         [ 1] 1732 	clr	(0x59, y)
      008BF6 90 6F 5A         [ 1] 1733 	clr	(0x5a, y)
      008BF9 90 6F 5B         [ 1] 1734 	clr	(0x5b, y)
      008BFC 90 6F 5C         [ 1] 1735 	clr	(0x5c, y)
      008BFF 90 6F 5D         [ 1] 1736 	clr	(0x5d, y)
      008C02 90 6F 5E         [ 1] 1737 	clr	(0x5e, y)
      008C05 90 6F 5F         [ 1] 1738 	clr	(0x5f, y)
      008C08 90 6F 60         [ 1] 1739 	clr	(0x60, y)
      008C0B 90 6F 61         [ 1] 1740 	clr	(0x61, y)
      008C0E 90 6F 62         [ 1] 1741 	clr	(0x62, y)
      008C11 90 6F 63         [ 1] 1742 	clr	(0x63, y)
      008C14 90 6F 64         [ 1] 1743 	clr	(0x64, y)
      008C17 90 6F 65         [ 1] 1744 	clr	(0x65, y)
      008C1A 90 6F 66         [ 1] 1745 	clr	(0x66, y)
      008C1D 90 6F 67         [ 1] 1746 	clr	(0x67, y)
      008C20 90 6F 68         [ 1] 1747 	clr	(0x68, y)
      008C23 90 6F 69         [ 1] 1748 	clr	(0x69, y)
      008C26 90 6F 6A         [ 1] 1749 	clr	(0x6a, y)
      008C29 90 6F 6B         [ 1] 1750 	clr	(0x6b, y)
      008C2C 90 6F 6C         [ 1] 1751 	clr	(0x6c, y)
      008C2F 90 6F 6D         [ 1] 1752 	clr	(0x6d, y)
      008C32 90 6F 6E         [ 1] 1753 	clr	(0x6e, y)
      008C35 90 6F 6F         [ 1] 1754 	clr	(0x6f, y)
      008C38 90 6F 70         [ 1] 1755 	clr	(0x70, y)
      008C3B 90 6F 71         [ 1] 1756 	clr	(0x71, y)
      008C3E 90 6F 72         [ 1] 1757 	clr	(0x72, y)
      008C41 90 6F 73         [ 1] 1758 	clr	(0x73, y)
      008C44 90 6F 74         [ 1] 1759 	clr	(0x74, y)
      008C47 90 6F 75         [ 1] 1760 	clr	(0x75, y)
      008C4A 90 6F 76         [ 1] 1761 	clr	(0x76, y)
      008C4D 90 6F 77         [ 1] 1762 	clr	(0x77, y)
      008C50 90 6F 78         [ 1] 1763 	clr	(0x78, y)
      008C53 90 6F 79         [ 1] 1764 	clr	(0x79, y)
      008C56 90 6F 7A         [ 1] 1765 	clr	(0x7a, y)
      008C59 90 6F 7B         [ 1] 1766 	clr	(0x7b, y)
      008C5C 90 6F 7C         [ 1] 1767 	clr	(0x7c, y)
      008C5F 90 6F 7D         [ 1] 1768 	clr	(0x7d, y)
      008C62 90 6F 7E         [ 1] 1769 	clr	(0x7e, y)
      008C65 90 6F 7F         [ 1] 1770 	clr	(0x7f, y)
      008C68 90 6F 80         [ 1] 1771 	clr	(0x80, y)
      008C6B 90 6F 81         [ 1] 1772 	clr	(0x81, y)
      008C6E 90 6F 82         [ 1] 1773 	clr	(0x82, y)
      008C71 90 6F 83         [ 1] 1774 	clr	(0x83, y)
      008C74 90 6F 84         [ 1] 1775 	clr	(0x84, y)
      008C77 90 6F 85         [ 1] 1776 	clr	(0x85, y)
      008C7A 90 6F 86         [ 1] 1777 	clr	(0x86, y)
      008C7D 90 6F 87         [ 1] 1778 	clr	(0x87, y)
      008C80 90 6F 88         [ 1] 1779 	clr	(0x88, y)
      008C83 90 6F 89         [ 1] 1780 	clr	(0x89, y)
      008C86 90 6F 8A         [ 1] 1781 	clr	(0x8a, y)
      008C89 90 6F 8B         [ 1] 1782 	clr	(0x8b, y)
      008C8C 90 6F 8C         [ 1] 1783 	clr	(0x8c, y)
      008C8F 90 6F 8D         [ 1] 1784 	clr	(0x8d, y)
      008C92 90 6F 8E         [ 1] 1785 	clr	(0x8e, y)
      008C95 90 6F 8F         [ 1] 1786 	clr	(0x8f, y)
      008C98 90 6F 90         [ 1] 1787 	clr	(0x90, y)
      008C9B 90 6F 91         [ 1] 1788 	clr	(0x91, y)
      008C9E 90 6F 92         [ 1] 1789 	clr	(0x92, y)
      008CA1 90 6F 93         [ 1] 1790 	clr	(0x93, y)
      008CA4 90 6F 94         [ 1] 1791 	clr	(0x94, y)
      008CA7 90 6F 95         [ 1] 1792 	clr	(0x95, y)
      008CAA 90 6F 96         [ 1] 1793 	clr	(0x96, y)
      008CAD 90 6F 97         [ 1] 1794 	clr	(0x97, y)
      008CB0 90 6F 98         [ 1] 1795 	clr	(0x98, y)
      008CB3 90 6F 99         [ 1] 1796 	clr	(0x99, y)
      008CB6 90 6F 9A         [ 1] 1797 	clr	(0x9a, y)
      008CB9 90 6F 9B         [ 1] 1798 	clr	(0x9b, y)
      008CBC 90 6F 9C         [ 1] 1799 	clr	(0x9c, y)
      008CBF 90 6F 9D         [ 1] 1800 	clr	(0x9d, y)
      008CC2 90 6F 9E         [ 1] 1801 	clr	(0x9e, y)
      008CC5 90 6F 9F         [ 1] 1802 	clr	(0x9f, y)
      008CC8 90 6F A0         [ 1] 1803 	clr	(0xa0, y)
      008CCB 90 6F A1         [ 1] 1804 	clr	(0xa1, y)
      008CCE 90 6F A2         [ 1] 1805 	clr	(0xa2, y)
      008CD1 90 6F A3         [ 1] 1806 	clr	(0xa3, y)
      008CD4 90 6F A4         [ 1] 1807 	clr	(0xa4, y)
      008CD7 90 6F A5         [ 1] 1808 	clr	(0xa5, y)
      008CDA 90 6F A6         [ 1] 1809 	clr	(0xa6, y)
      008CDD 90 6F A7         [ 1] 1810 	clr	(0xa7, y)
      008CE0 90 6F A8         [ 1] 1811 	clr	(0xa8, y)
      008CE3 90 6F A9         [ 1] 1812 	clr	(0xa9, y)
      008CE6 90 6F AA         [ 1] 1813 	clr	(0xaa, y)
      008CE9 90 6F AB         [ 1] 1814 	clr	(0xab, y)
      008CEC 90 6F AC         [ 1] 1815 	clr	(0xac, y)
      008CEF 90 6F AD         [ 1] 1816 	clr	(0xad, y)
      008CF2 90 6F AE         [ 1] 1817 	clr	(0xae, y)
      008CF5 90 6F AF         [ 1] 1818 	clr	(0xaf, y)
      008CF8 90 6F B0         [ 1] 1819 	clr	(0xb0, y)
      008CFB 90 6F B1         [ 1] 1820 	clr	(0xb1, y)
      008CFE 90 6F B2         [ 1] 1821 	clr	(0xb2, y)
      008D01 90 6F B3         [ 1] 1822 	clr	(0xb3, y)
      008D04 90 6F B4         [ 1] 1823 	clr	(0xb4, y)
      008D07 90 6F B5         [ 1] 1824 	clr	(0xb5, y)
      008D0A 90 6F B6         [ 1] 1825 	clr	(0xb6, y)
      008D0D 90 6F B7         [ 1] 1826 	clr	(0xb7, y)
      008D10 90 6F B8         [ 1] 1827 	clr	(0xb8, y)
      008D13 90 6F B9         [ 1] 1828 	clr	(0xb9, y)
      008D16 90 6F BA         [ 1] 1829 	clr	(0xba, y)
      008D19 90 6F BB         [ 1] 1830 	clr	(0xbb, y)
      008D1C 90 6F BC         [ 1] 1831 	clr	(0xbc, y)
      008D1F 90 6F BD         [ 1] 1832 	clr	(0xbd, y)
      008D22 90 6F BE         [ 1] 1833 	clr	(0xbe, y)
      008D25 90 6F BF         [ 1] 1834 	clr	(0xbf, y)
      008D28 90 6F C0         [ 1] 1835 	clr	(0xc0, y)
      008D2B 90 6F C1         [ 1] 1836 	clr	(0xc1, y)
      008D2E 90 6F C2         [ 1] 1837 	clr	(0xc2, y)
      008D31 90 6F C3         [ 1] 1838 	clr	(0xc3, y)
      008D34 90 6F C4         [ 1] 1839 	clr	(0xc4, y)
      008D37 90 6F C5         [ 1] 1840 	clr	(0xc5, y)
      008D3A 90 6F C6         [ 1] 1841 	clr	(0xc6, y)
      008D3D 90 6F C7         [ 1] 1842 	clr	(0xc7, y)
      008D40 90 6F C8         [ 1] 1843 	clr	(0xc8, y)
      008D43 90 6F C9         [ 1] 1844 	clr	(0xc9, y)
      008D46 90 6F CA         [ 1] 1845 	clr	(0xca, y)
      008D49 90 6F CB         [ 1] 1846 	clr	(0xcb, y)
      008D4C 90 6F CC         [ 1] 1847 	clr	(0xcc, y)
      008D4F 90 6F CD         [ 1] 1848 	clr	(0xcd, y)
      008D52 90 6F CE         [ 1] 1849 	clr	(0xce, y)
      008D55 90 6F CF         [ 1] 1850 	clr	(0xcf, y)
      008D58 90 6F D0         [ 1] 1851 	clr	(0xd0, y)
      008D5B 90 6F D1         [ 1] 1852 	clr	(0xd1, y)
      008D5E 90 6F D2         [ 1] 1853 	clr	(0xd2, y)
      008D61 90 6F D3         [ 1] 1854 	clr	(0xd3, y)
      008D64 90 6F D4         [ 1] 1855 	clr	(0xd4, y)
      008D67 90 6F D5         [ 1] 1856 	clr	(0xd5, y)
      008D6A 90 6F D6         [ 1] 1857 	clr	(0xd6, y)
      008D6D 90 6F D7         [ 1] 1858 	clr	(0xd7, y)
      008D70 90 6F D8         [ 1] 1859 	clr	(0xd8, y)
      008D73 90 6F D9         [ 1] 1860 	clr	(0xd9, y)
      008D76 90 6F DA         [ 1] 1861 	clr	(0xda, y)
      008D79 90 6F DB         [ 1] 1862 	clr	(0xdb, y)
      008D7C 90 6F DC         [ 1] 1863 	clr	(0xdc, y)
      008D7F 90 6F DD         [ 1] 1864 	clr	(0xdd, y)
      008D82 90 6F DE         [ 1] 1865 	clr	(0xde, y)
      008D85 90 6F DF         [ 1] 1866 	clr	(0xdf, y)
      008D88 90 6F E0         [ 1] 1867 	clr	(0xe0, y)
      008D8B 90 6F E1         [ 1] 1868 	clr	(0xe1, y)
      008D8E 90 6F E2         [ 1] 1869 	clr	(0xe2, y)
      008D91 90 6F E3         [ 1] 1870 	clr	(0xe3, y)
      008D94 90 6F E4         [ 1] 1871 	clr	(0xe4, y)
      008D97 90 6F E5         [ 1] 1872 	clr	(0xe5, y)
      008D9A 90 6F E6         [ 1] 1873 	clr	(0xe6, y)
      008D9D 90 6F E7         [ 1] 1874 	clr	(0xe7, y)
      008DA0 90 6F E8         [ 1] 1875 	clr	(0xe8, y)
      008DA3 90 6F E9         [ 1] 1876 	clr	(0xe9, y)
      008DA6 90 6F EA         [ 1] 1877 	clr	(0xea, y)
      008DA9 90 6F EB         [ 1] 1878 	clr	(0xeb, y)
      008DAC 90 6F EC         [ 1] 1879 	clr	(0xec, y)
      008DAF 90 6F ED         [ 1] 1880 	clr	(0xed, y)
      008DB2 90 6F EE         [ 1] 1881 	clr	(0xee, y)
      008DB5 90 6F EF         [ 1] 1882 	clr	(0xef, y)
      008DB8 90 6F F0         [ 1] 1883 	clr	(0xf0, y)
      008DBB 90 6F F1         [ 1] 1884 	clr	(0xf1, y)
      008DBE 90 6F F2         [ 1] 1885 	clr	(0xf2, y)
      008DC1 90 6F F3         [ 1] 1886 	clr	(0xf3, y)
      008DC4 90 6F F4         [ 1] 1887 	clr	(0xf4, y)
      008DC7 90 6F F5         [ 1] 1888 	clr	(0xf5, y)
      008DCA 90 6F F6         [ 1] 1889 	clr	(0xf6, y)
      008DCD 90 6F F7         [ 1] 1890 	clr	(0xf7, y)
      008DD0 90 6F F8         [ 1] 1891 	clr	(0xf8, y)
      008DD3 90 6F F9         [ 1] 1892 	clr	(0xf9, y)
      008DD6 90 6F FA         [ 1] 1893 	clr	(0xfa, y)
      008DD9 90 6F FB         [ 1] 1894 	clr	(0xfb, y)
      008DDC 90 6F FC         [ 1] 1895 	clr	(0xfc, y)
      008DDF 90 6F FD         [ 1] 1896 	clr	(0xfd, y)
      008DE2 90 6F FE         [ 1] 1897 	clr	(0xfe, y)
      008DE5 90 6F FF         [ 1] 1898 	clr	(0xff, y)
      008DE8 90 4F 01 00      [ 1] 1899 	clr	(0x100, y)
      008DEC 90 4F 01 01      [ 1] 1900 	clr	(0x101, y)
      008DF0 90 4F 01 02      [ 1] 1901 	clr	(0x102, y)
      008DF4 90 4F 01 03      [ 1] 1902 	clr	(0x103, y)
      008DF8 90 4F 01 04      [ 1] 1903 	clr	(0x104, y)
      008DFC 90 4F 01 05      [ 1] 1904 	clr	(0x105, y)
      008E00 90 4F 01 06      [ 1] 1905 	clr	(0x106, y)
      008E04 90 4F 01 07      [ 1] 1906 	clr	(0x107, y)
                                   1907 ;	main.c: 145: display_buffer_fill_entire(splash,buffer);
      008E08 90 89            [ 2] 1908 	pushw	y
      008E0A 96               [ 1] 1909 	ldw	x, sp
      008E0B 1C 00 03         [ 2] 1910 	addw	x, #3
      008E0E 89               [ 2] 1911 	pushw	x
      008E0F AE 00 08         [ 2] 1912 	ldw	x, #(_splash+0)
      008E12 CD 87 89         [ 4] 1913 	call	_display_buffer_fill_entire
      008E15 96               [ 1] 1914 	ldw	x, sp
      008E16 1C 00 03         [ 2] 1915 	addw	x, #3
      008E19 CD 87 F6         [ 4] 1916 	call	_display_set
      008E1C 90 85            [ 2] 1917 	popw	y
                                   1918 ;	main.c: 147: }
      008E1E 5B FF            [ 2] 1919 	addw	sp, #255
      008E20 5B FF            [ 2] 1920 	addw	sp, #255
      008E22 5B 02            [ 2] 1921 	addw	sp, #2
      008E24 81               [ 4] 1922 	ret
                                   1923 ;	main.c: 149: int main(void)
                                   1924 ;	-----------------------------------------
                                   1925 ;	 function main
                                   1926 ;	-----------------------------------------
      008E25                       1927 _main:
                                   1928 ;	main.c: 151: setup();
      008E25 CD 85 D3         [ 4] 1929 	call	_setup
                                   1930 ;	main.c: 152: gg();
      008E28 CD 88 EB         [ 4] 1931 	call	_gg
                                   1932 ;	main.c: 153: while(1);
      008E2B                       1933 00102$:
      008E2B 20 FE            [ 2] 1934 	jra	00102$
                                   1935 ;	main.c: 154: }
      008E2D 81               [ 4] 1936 	ret
                                   1937 	.area CODE
                                   1938 	.area CONST
                                   1939 	.area CONST
      00807D                       1940 ___str_0:
      00807D 72 78 5F 62 75 66 5F  1941 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808B 0A                    1942 	.db 0x0a
      00808C 00                    1943 	.db 0x00
                                   1944 	.area CODE
                                   1945 	.area CONST
      00808D                       1946 ___str_1:
      00808D 62 75 66 5F 70 6F 73  1947 	.ascii "buf_pos"
      008094 0A                    1948 	.db 0x0a
      008095 00                    1949 	.db 0x00
                                   1950 	.area CODE
                                   1951 	.area CONST
      008096                       1952 ___str_2:
      008096 62 75 66 5F 73 69 7A  1953 	.ascii "buf_size"
             65
      00809E 0A                    1954 	.db 0x0a
      00809F 00                    1955 	.db 0x00
                                   1956 	.area CODE
                                   1957 	.area CONST
      0080A0                       1958 ___str_3:
      0080A0 52 49 45 4E           1959 	.ascii "RIEN"
      0080A4 0A                    1960 	.db 0x0a
      0080A5 00                    1961 	.db 0x00
                                   1962 	.area CODE
                                   1963 	.area INITIALIZER
      0080A6                       1964 __xinit__I2C_IRQ:
      0080A6 00                    1965 	.db #0x00	; 0
      0080A7                       1966 __xinit__splash:
      0080A7 FF                    1967 	.db #0xff	; 255
      0080A8 FF                    1968 	.db #0xff	; 255
      0080A9 FF                    1969 	.db #0xff	; 255
      0080AA FF                    1970 	.db #0xff	; 255
      0080AB FF                    1971 	.db #0xff	; 255
      0080AC FF                    1972 	.db #0xff	; 255
      0080AD FF                    1973 	.db #0xff	; 255
      0080AE FF                    1974 	.db #0xff	; 255
      0080AF FF                    1975 	.db #0xff	; 255
      0080B0 FF                    1976 	.db #0xff	; 255
      0080B1 FF                    1977 	.db #0xff	; 255
      0080B2 FF                    1978 	.db #0xff	; 255
      0080B3 FF                    1979 	.db #0xff	; 255
      0080B4 FF                    1980 	.db #0xff	; 255
      0080B5 FF                    1981 	.db #0xff	; 255
      0080B6 FF                    1982 	.db #0xff	; 255
      0080B7 80                    1983 	.db #0x80	; 128
      0080B8 00                    1984 	.db #0x00	; 0
      0080B9 00                    1985 	.db #0x00	; 0
      0080BA 00                    1986 	.db #0x00	; 0
      0080BB 00                    1987 	.db #0x00	; 0
      0080BC 00                    1988 	.db #0x00	; 0
      0080BD 00                    1989 	.db #0x00	; 0
      0080BE 00                    1990 	.db #0x00	; 0
      0080BF 00                    1991 	.db #0x00	; 0
      0080C0 00                    1992 	.db #0x00	; 0
      0080C1 00                    1993 	.db #0x00	; 0
      0080C2 00                    1994 	.db #0x00	; 0
      0080C3 00                    1995 	.db #0x00	; 0
      0080C4 00                    1996 	.db #0x00	; 0
      0080C5 00                    1997 	.db #0x00	; 0
      0080C6 01                    1998 	.db #0x01	; 1
      0080C7 80                    1999 	.db #0x80	; 128
      0080C8 FE                    2000 	.db #0xfe	; 254
      0080C9 03                    2001 	.db #0x03	; 3
      0080CA FF                    2002 	.db #0xff	; 255
      0080CB FF                    2003 	.db #0xff	; 255
      0080CC FF                    2004 	.db #0xff	; 255
      0080CD FF                    2005 	.db #0xff	; 255
      0080CE 80                    2006 	.db #0x80	; 128
      0080CF FF                    2007 	.db #0xff	; 255
      0080D0 FF                    2008 	.db #0xff	; 255
      0080D1 F8                    2009 	.db #0xf8	; 248
      0080D2 00                    2010 	.db #0x00	; 0
      0080D3 00                    2011 	.db #0x00	; 0
      0080D4 00                    2012 	.db #0x00	; 0
      0080D5 00                    2013 	.db #0x00	; 0
      0080D6 01                    2014 	.db #0x01	; 1
      0080D7 80                    2015 	.db #0x80	; 128
      0080D8 FE                    2016 	.db #0xfe	; 254
      0080D9 03                    2017 	.db #0x03	; 3
      0080DA FF                    2018 	.db #0xff	; 255
      0080DB FF                    2019 	.db #0xff	; 255
      0080DC FF                    2020 	.db #0xff	; 255
      0080DD FF                    2021 	.db #0xff	; 255
      0080DE 80                    2022 	.db #0x80	; 128
      0080DF FF                    2023 	.db #0xff	; 255
      0080E0 FF                    2024 	.db #0xff	; 255
      0080E1 F8                    2025 	.db #0xf8	; 248
      0080E2 00                    2026 	.db #0x00	; 0
      0080E3 00                    2027 	.db #0x00	; 0
      0080E4 00                    2028 	.db #0x00	; 0
      0080E5 00                    2029 	.db #0x00	; 0
      0080E6 01                    2030 	.db #0x01	; 1
      0080E7 80                    2031 	.db #0x80	; 128
      0080E8 FE                    2032 	.db #0xfe	; 254
      0080E9 03                    2033 	.db #0x03	; 3
      0080EA FF                    2034 	.db #0xff	; 255
      0080EB FF                    2035 	.db #0xff	; 255
      0080EC FF                    2036 	.db #0xff	; 255
      0080ED FF                    2037 	.db #0xff	; 255
      0080EE 80                    2038 	.db #0x80	; 128
      0080EF FF                    2039 	.db #0xff	; 255
      0080F0 FF                    2040 	.db #0xff	; 255
      0080F1 F8                    2041 	.db #0xf8	; 248
      0080F2 00                    2042 	.db #0x00	; 0
      0080F3 00                    2043 	.db #0x00	; 0
      0080F4 00                    2044 	.db #0x00	; 0
      0080F5 00                    2045 	.db #0x00	; 0
      0080F6 01                    2046 	.db #0x01	; 1
      0080F7 80                    2047 	.db #0x80	; 128
      0080F8 FE                    2048 	.db #0xfe	; 254
      0080F9 03                    2049 	.db #0x03	; 3
      0080FA FF                    2050 	.db #0xff	; 255
      0080FB FF                    2051 	.db #0xff	; 255
      0080FC FF                    2052 	.db #0xff	; 255
      0080FD FF                    2053 	.db #0xff	; 255
      0080FE 80                    2054 	.db #0x80	; 128
      0080FF FF                    2055 	.db #0xff	; 255
      008100 FF                    2056 	.db #0xff	; 255
      008101 F8                    2057 	.db #0xf8	; 248
      008102 00                    2058 	.db #0x00	; 0
      008103 00                    2059 	.db #0x00	; 0
      008104 00                    2060 	.db #0x00	; 0
      008105 00                    2061 	.db #0x00	; 0
      008106 01                    2062 	.db #0x01	; 1
      008107 80                    2063 	.db #0x80	; 128
      008108 FE                    2064 	.db #0xfe	; 254
      008109 03                    2065 	.db #0x03	; 3
      00810A FF                    2066 	.db #0xff	; 255
      00810B FF                    2067 	.db #0xff	; 255
      00810C FF                    2068 	.db #0xff	; 255
      00810D FF                    2069 	.db #0xff	; 255
      00810E 80                    2070 	.db #0x80	; 128
      00810F FF                    2071 	.db #0xff	; 255
      008110 FF                    2072 	.db #0xff	; 255
      008111 F8                    2073 	.db #0xf8	; 248
      008112 00                    2074 	.db #0x00	; 0
      008113 00                    2075 	.db #0x00	; 0
      008114 00                    2076 	.db #0x00	; 0
      008115 00                    2077 	.db #0x00	; 0
      008116 01                    2078 	.db #0x01	; 1
      008117 80                    2079 	.db #0x80	; 128
      008118 FE                    2080 	.db #0xfe	; 254
      008119 03                    2081 	.db #0x03	; 3
      00811A FF                    2082 	.db #0xff	; 255
      00811B FF                    2083 	.db #0xff	; 255
      00811C FF                    2084 	.db #0xff	; 255
      00811D FF                    2085 	.db #0xff	; 255
      00811E 80                    2086 	.db #0x80	; 128
      00811F FF                    2087 	.db #0xff	; 255
      008120 FF                    2088 	.db #0xff	; 255
      008121 F8                    2089 	.db #0xf8	; 248
      008122 00                    2090 	.db #0x00	; 0
      008123 00                    2091 	.db #0x00	; 0
      008124 00                    2092 	.db #0x00	; 0
      008125 00                    2093 	.db #0x00	; 0
      008126 01                    2094 	.db #0x01	; 1
      008127 80                    2095 	.db #0x80	; 128
      008128 FE                    2096 	.db #0xfe	; 254
      008129 03                    2097 	.db #0x03	; 3
      00812A FF                    2098 	.db #0xff	; 255
      00812B FF                    2099 	.db #0xff	; 255
      00812C FF                    2100 	.db #0xff	; 255
      00812D FF                    2101 	.db #0xff	; 255
      00812E 80                    2102 	.db #0x80	; 128
      00812F FF                    2103 	.db #0xff	; 255
      008130 FF                    2104 	.db #0xff	; 255
      008131 F8                    2105 	.db #0xf8	; 248
      008132 00                    2106 	.db #0x00	; 0
      008133 00                    2107 	.db #0x00	; 0
      008134 00                    2108 	.db #0x00	; 0
      008135 00                    2109 	.db #0x00	; 0
      008136 01                    2110 	.db #0x01	; 1
      008137 80                    2111 	.db #0x80	; 128
      008138 FF                    2112 	.db #0xff	; 255
      008139 FF                    2113 	.db #0xff	; 255
      00813A F8                    2114 	.db #0xf8	; 248
      00813B 0F                    2115 	.db #0x0f	; 15
      00813C E0                    2116 	.db #0xe0	; 224
      00813D 3F                    2117 	.db #0x3f	; 63
      00813E 80                    2118 	.db #0x80	; 128
      00813F FE                    2119 	.db #0xfe	; 254
      008140 03                    2120 	.db #0x03	; 3
      008141 F8                    2121 	.db #0xf8	; 248
      008142 00                    2122 	.db #0x00	; 0
      008143 00                    2123 	.db #0x00	; 0
      008144 00                    2124 	.db #0x00	; 0
      008145 00                    2125 	.db #0x00	; 0
      008146 01                    2126 	.db #0x01	; 1
      008147 80                    2127 	.db #0x80	; 128
      008148 FF                    2128 	.db #0xff	; 255
      008149 FF                    2129 	.db #0xff	; 255
      00814A F8                    2130 	.db #0xf8	; 248
      00814B 0F                    2131 	.db #0x0f	; 15
      00814C E0                    2132 	.db #0xe0	; 224
      00814D 3F                    2133 	.db #0x3f	; 63
      00814E 80                    2134 	.db #0x80	; 128
      00814F FE                    2135 	.db #0xfe	; 254
      008150 03                    2136 	.db #0x03	; 3
      008151 F8                    2137 	.db #0xf8	; 248
      008152 00                    2138 	.db #0x00	; 0
      008153 00                    2139 	.db #0x00	; 0
      008154 00                    2140 	.db #0x00	; 0
      008155 00                    2141 	.db #0x00	; 0
      008156 01                    2142 	.db #0x01	; 1
      008157 80                    2143 	.db #0x80	; 128
      008158 FF                    2144 	.db #0xff	; 255
      008159 FF                    2145 	.db #0xff	; 255
      00815A F8                    2146 	.db #0xf8	; 248
      00815B 0F                    2147 	.db #0x0f	; 15
      00815C E0                    2148 	.db #0xe0	; 224
      00815D 3F                    2149 	.db #0x3f	; 63
      00815E 80                    2150 	.db #0x80	; 128
      00815F FE                    2151 	.db #0xfe	; 254
      008160 03                    2152 	.db #0x03	; 3
      008161 F8                    2153 	.db #0xf8	; 248
      008162 00                    2154 	.db #0x00	; 0
      008163 00                    2155 	.db #0x00	; 0
      008164 00                    2156 	.db #0x00	; 0
      008165 00                    2157 	.db #0x00	; 0
      008166 01                    2158 	.db #0x01	; 1
      008167 80                    2159 	.db #0x80	; 128
      008168 FF                    2160 	.db #0xff	; 255
      008169 FF                    2161 	.db #0xff	; 255
      00816A F8                    2162 	.db #0xf8	; 248
      00816B 0F                    2163 	.db #0x0f	; 15
      00816C E0                    2164 	.db #0xe0	; 224
      00816D 3F                    2165 	.db #0x3f	; 63
      00816E 80                    2166 	.db #0x80	; 128
      00816F FE                    2167 	.db #0xfe	; 254
      008170 03                    2168 	.db #0x03	; 3
      008171 F8                    2169 	.db #0xf8	; 248
      008172 00                    2170 	.db #0x00	; 0
      008173 00                    2171 	.db #0x00	; 0
      008174 00                    2172 	.db #0x00	; 0
      008175 00                    2173 	.db #0x00	; 0
      008176 01                    2174 	.db #0x01	; 1
      008177 80                    2175 	.db #0x80	; 128
      008178 FF                    2176 	.db #0xff	; 255
      008179 FF                    2177 	.db #0xff	; 255
      00817A F8                    2178 	.db #0xf8	; 248
      00817B 0F                    2179 	.db #0x0f	; 15
      00817C E0                    2180 	.db #0xe0	; 224
      00817D 3F                    2181 	.db #0x3f	; 63
      00817E 80                    2182 	.db #0x80	; 128
      00817F FE                    2183 	.db #0xfe	; 254
      008180 03                    2184 	.db #0x03	; 3
      008181 F8                    2185 	.db #0xf8	; 248
      008182 00                    2186 	.db #0x00	; 0
      008183 00                    2187 	.db #0x00	; 0
      008184 00                    2188 	.db #0x00	; 0
      008185 00                    2189 	.db #0x00	; 0
      008186 01                    2190 	.db #0x01	; 1
      008187 80                    2191 	.db #0x80	; 128
      008188 FF                    2192 	.db #0xff	; 255
      008189 FF                    2193 	.db #0xff	; 255
      00818A F8                    2194 	.db #0xf8	; 248
      00818B 0F                    2195 	.db #0x0f	; 15
      00818C E0                    2196 	.db #0xe0	; 224
      00818D 3F                    2197 	.db #0x3f	; 63
      00818E 80                    2198 	.db #0x80	; 128
      00818F FE                    2199 	.db #0xfe	; 254
      008190 03                    2200 	.db #0x03	; 3
      008191 F8                    2201 	.db #0xf8	; 248
      008192 00                    2202 	.db #0x00	; 0
      008193 00                    2203 	.db #0x00	; 0
      008194 00                    2204 	.db #0x00	; 0
      008195 00                    2205 	.db #0x00	; 0
      008196 01                    2206 	.db #0x01	; 1
      008197 80                    2207 	.db #0x80	; 128
      008198 FF                    2208 	.db #0xff	; 255
      008199 FF                    2209 	.db #0xff	; 255
      00819A F8                    2210 	.db #0xf8	; 248
      00819B 0F                    2211 	.db #0x0f	; 15
      00819C E0                    2212 	.db #0xe0	; 224
      00819D 3F                    2213 	.db #0x3f	; 63
      00819E 80                    2214 	.db #0x80	; 128
      00819F FE                    2215 	.db #0xfe	; 254
      0081A0 03                    2216 	.db #0x03	; 3
      0081A1 F8                    2217 	.db #0xf8	; 248
      0081A2 00                    2218 	.db #0x00	; 0
      0081A3 00                    2219 	.db #0x00	; 0
      0081A4 00                    2220 	.db #0x00	; 0
      0081A5 00                    2221 	.db #0x00	; 0
      0081A6 01                    2222 	.db #0x01	; 1
      0081A7 80                    2223 	.db #0x80	; 128
      0081A8 FE                    2224 	.db #0xfe	; 254
      0081A9 03                    2225 	.db #0x03	; 3
      0081AA F8                    2226 	.db #0xf8	; 248
      0081AB 0F                    2227 	.db #0x0f	; 15
      0081AC E0                    2228 	.db #0xe0	; 224
      0081AD 3F                    2229 	.db #0x3f	; 63
      0081AE FF                    2230 	.db #0xff	; 255
      0081AF FF                    2231 	.db #0xff	; 255
      0081B0 FC                    2232 	.db #0xfc	; 252
      0081B1 00                    2233 	.db #0x00	; 0
      0081B2 00                    2234 	.db #0x00	; 0
      0081B3 00                    2235 	.db #0x00	; 0
      0081B4 00                    2236 	.db #0x00	; 0
      0081B5 00                    2237 	.db #0x00	; 0
      0081B6 01                    2238 	.db #0x01	; 1
      0081B7 80                    2239 	.db #0x80	; 128
      0081B8 FE                    2240 	.db #0xfe	; 254
      0081B9 03                    2241 	.db #0x03	; 3
      0081BA F8                    2242 	.db #0xf8	; 248
      0081BB 0F                    2243 	.db #0x0f	; 15
      0081BC E0                    2244 	.db #0xe0	; 224
      0081BD 3F                    2245 	.db #0x3f	; 63
      0081BE FF                    2246 	.db #0xff	; 255
      0081BF FF                    2247 	.db #0xff	; 255
      0081C0 FC                    2248 	.db #0xfc	; 252
      0081C1 00                    2249 	.db #0x00	; 0
      0081C2 00                    2250 	.db #0x00	; 0
      0081C3 00                    2251 	.db #0x00	; 0
      0081C4 00                    2252 	.db #0x00	; 0
      0081C5 00                    2253 	.db #0x00	; 0
      0081C6 01                    2254 	.db #0x01	; 1
      0081C7 80                    2255 	.db #0x80	; 128
      0081C8 FE                    2256 	.db #0xfe	; 254
      0081C9 03                    2257 	.db #0x03	; 3
      0081CA F8                    2258 	.db #0xf8	; 248
      0081CB 0F                    2259 	.db #0x0f	; 15
      0081CC E0                    2260 	.db #0xe0	; 224
      0081CD 3F                    2261 	.db #0x3f	; 63
      0081CE FF                    2262 	.db #0xff	; 255
      0081CF FF                    2263 	.db #0xff	; 255
      0081D0 FC                    2264 	.db #0xfc	; 252
      0081D1 00                    2265 	.db #0x00	; 0
      0081D2 00                    2266 	.db #0x00	; 0
      0081D3 00                    2267 	.db #0x00	; 0
      0081D4 00                    2268 	.db #0x00	; 0
      0081D5 00                    2269 	.db #0x00	; 0
      0081D6 01                    2270 	.db #0x01	; 1
      0081D7 80                    2271 	.db #0x80	; 128
      0081D8 FE                    2272 	.db #0xfe	; 254
      0081D9 03                    2273 	.db #0x03	; 3
      0081DA F8                    2274 	.db #0xf8	; 248
      0081DB 0F                    2275 	.db #0x0f	; 15
      0081DC E0                    2276 	.db #0xe0	; 224
      0081DD 3F                    2277 	.db #0x3f	; 63
      0081DE FF                    2278 	.db #0xff	; 255
      0081DF FF                    2279 	.db #0xff	; 255
      0081E0 FC                    2280 	.db #0xfc	; 252
      0081E1 00                    2281 	.db #0x00	; 0
      0081E2 00                    2282 	.db #0x00	; 0
      0081E3 00                    2283 	.db #0x00	; 0
      0081E4 00                    2284 	.db #0x00	; 0
      0081E5 00                    2285 	.db #0x00	; 0
      0081E6 01                    2286 	.db #0x01	; 1
      0081E7 80                    2287 	.db #0x80	; 128
      0081E8 FE                    2288 	.db #0xfe	; 254
      0081E9 03                    2289 	.db #0x03	; 3
      0081EA F8                    2290 	.db #0xf8	; 248
      0081EB 0F                    2291 	.db #0x0f	; 15
      0081EC E0                    2292 	.db #0xe0	; 224
      0081ED 3F                    2293 	.db #0x3f	; 63
      0081EE FF                    2294 	.db #0xff	; 255
      0081EF FF                    2295 	.db #0xff	; 255
      0081F0 FC                    2296 	.db #0xfc	; 252
      0081F1 00                    2297 	.db #0x00	; 0
      0081F2 00                    2298 	.db #0x00	; 0
      0081F3 00                    2299 	.db #0x00	; 0
      0081F4 00                    2300 	.db #0x00	; 0
      0081F5 00                    2301 	.db #0x00	; 0
      0081F6 01                    2302 	.db #0x01	; 1
      0081F7 80                    2303 	.db #0x80	; 128
      0081F8 FE                    2304 	.db #0xfe	; 254
      0081F9 03                    2305 	.db #0x03	; 3
      0081FA F8                    2306 	.db #0xf8	; 248
      0081FB 0F                    2307 	.db #0x0f	; 15
      0081FC E0                    2308 	.db #0xe0	; 224
      0081FD 3F                    2309 	.db #0x3f	; 63
      0081FE FF                    2310 	.db #0xff	; 255
      0081FF FF                    2311 	.db #0xff	; 255
      008200 FC                    2312 	.db #0xfc	; 252
      008201 00                    2313 	.db #0x00	; 0
      008202 00                    2314 	.db #0x00	; 0
      008203 00                    2315 	.db #0x00	; 0
      008204 00                    2316 	.db #0x00	; 0
      008205 00                    2317 	.db #0x00	; 0
      008206 01                    2318 	.db #0x01	; 1
      008207 80                    2319 	.db #0x80	; 128
      008208 FE                    2320 	.db #0xfe	; 254
      008209 03                    2321 	.db #0x03	; 3
      00820A F8                    2322 	.db #0xf8	; 248
      00820B 0F                    2323 	.db #0x0f	; 15
      00820C E0                    2324 	.db #0xe0	; 224
      00820D 3F                    2325 	.db #0x3f	; 63
      00820E FF                    2326 	.db #0xff	; 255
      00820F FF                    2327 	.db #0xff	; 255
      008210 FC                    2328 	.db #0xfc	; 252
      008211 00                    2329 	.db #0x00	; 0
      008212 00                    2330 	.db #0x00	; 0
      008213 00                    2331 	.db #0x00	; 0
      008214 00                    2332 	.db #0x00	; 0
      008215 00                    2333 	.db #0x00	; 0
      008216 01                    2334 	.db #0x01	; 1
      008217 80                    2335 	.db #0x80	; 128
      008218 FE                    2336 	.db #0xfe	; 254
      008219 03                    2337 	.db #0x03	; 3
      00821A F8                    2338 	.db #0xf8	; 248
      00821B 0F                    2339 	.db #0x0f	; 15
      00821C E0                    2340 	.db #0xe0	; 224
      00821D 3F                    2341 	.db #0x3f	; 63
      00821E 80                    2342 	.db #0x80	; 128
      00821F FE                    2343 	.db #0xfe	; 254
      008220 03                    2344 	.db #0x03	; 3
      008221 F8                    2345 	.db #0xf8	; 248
      008222 FE                    2346 	.db #0xfe	; 254
      008223 00                    2347 	.db #0x00	; 0
      008224 00                    2348 	.db #0x00	; 0
      008225 00                    2349 	.db #0x00	; 0
      008226 01                    2350 	.db #0x01	; 1
      008227 80                    2351 	.db #0x80	; 128
      008228 FE                    2352 	.db #0xfe	; 254
      008229 03                    2353 	.db #0x03	; 3
      00822A F8                    2354 	.db #0xf8	; 248
      00822B 0F                    2355 	.db #0x0f	; 15
      00822C E0                    2356 	.db #0xe0	; 224
      00822D 3F                    2357 	.db #0x3f	; 63
      00822E 80                    2358 	.db #0x80	; 128
      00822F FE                    2359 	.db #0xfe	; 254
      008230 03                    2360 	.db #0x03	; 3
      008231 F8                    2361 	.db #0xf8	; 248
      008232 FE                    2362 	.db #0xfe	; 254
      008233 7C                    2363 	.db #0x7c	; 124
      008234 7E                    2364 	.db #0x7e	; 126
      008235 00                    2365 	.db #0x00	; 0
      008236 01                    2366 	.db #0x01	; 1
      008237 80                    2367 	.db #0x80	; 128
      008238 FE                    2368 	.db #0xfe	; 254
      008239 03                    2369 	.db #0x03	; 3
      00823A F8                    2370 	.db #0xf8	; 248
      00823B 0F                    2371 	.db #0x0f	; 15
      00823C E0                    2372 	.db #0xe0	; 224
      00823D 3F                    2373 	.db #0x3f	; 63
      00823E 80                    2374 	.db #0x80	; 128
      00823F FE                    2375 	.db #0xfe	; 254
      008240 03                    2376 	.db #0x03	; 3
      008241 F8                    2377 	.db #0xf8	; 248
      008242 38                    2378 	.db #0x38	; 56	'8'
      008243 7E                    2379 	.db #0x7e	; 126
      008244 7E                    2380 	.db #0x7e	; 126
      008245 00                    2381 	.db #0x00	; 0
      008246 01                    2382 	.db #0x01	; 1
      008247 80                    2383 	.db #0x80	; 128
      008248 FE                    2384 	.db #0xfe	; 254
      008249 03                    2385 	.db #0x03	; 3
      00824A F8                    2386 	.db #0xf8	; 248
      00824B 0F                    2387 	.db #0x0f	; 15
      00824C E0                    2388 	.db #0xe0	; 224
      00824D 3F                    2389 	.db #0x3f	; 63
      00824E 80                    2390 	.db #0x80	; 128
      00824F FE                    2391 	.db #0xfe	; 254
      008250 03                    2392 	.db #0x03	; 3
      008251 F8                    2393 	.db #0xf8	; 248
      008252 38                    2394 	.db #0x38	; 56	'8'
      008253 66                    2395 	.db #0x66	; 102	'f'
      008254 60                    2396 	.db #0x60	; 96
      008255 00                    2397 	.db #0x00	; 0
      008256 01                    2398 	.db #0x01	; 1
      008257 80                    2399 	.db #0x80	; 128
      008258 FE                    2400 	.db #0xfe	; 254
      008259 03                    2401 	.db #0x03	; 3
      00825A F8                    2402 	.db #0xf8	; 248
      00825B 0F                    2403 	.db #0x0f	; 15
      00825C E0                    2404 	.db #0xe0	; 224
      00825D 3F                    2405 	.db #0x3f	; 63
      00825E 80                    2406 	.db #0x80	; 128
      00825F FE                    2407 	.db #0xfe	; 254
      008260 03                    2408 	.db #0x03	; 3
      008261 F8                    2409 	.db #0xf8	; 248
      008262 38                    2410 	.db #0x38	; 56	'8'
      008263 66                    2411 	.db #0x66	; 102	'f'
      008264 60                    2412 	.db #0x60	; 96
      008265 00                    2413 	.db #0x00	; 0
      008266 01                    2414 	.db #0x01	; 1
      008267 80                    2415 	.db #0x80	; 128
      008268 FE                    2416 	.db #0xfe	; 254
      008269 03                    2417 	.db #0x03	; 3
      00826A F8                    2418 	.db #0xf8	; 248
      00826B 0F                    2419 	.db #0x0f	; 15
      00826C E0                    2420 	.db #0xe0	; 224
      00826D 3F                    2421 	.db #0x3f	; 63
      00826E 80                    2422 	.db #0x80	; 128
      00826F FE                    2423 	.db #0xfe	; 254
      008270 03                    2424 	.db #0x03	; 3
      008271 F8                    2425 	.db #0xf8	; 248
      008272 FE                    2426 	.db #0xfe	; 254
      008273 66                    2427 	.db #0x66	; 102	'f'
      008274 7E                    2428 	.db #0x7e	; 126
      008275 18                    2429 	.db #0x18	; 24
      008276 01                    2430 	.db #0x01	; 1
      008277 80                    2431 	.db #0x80	; 128
      008278 FE                    2432 	.db #0xfe	; 254
      008279 03                    2433 	.db #0x03	; 3
      00827A F8                    2434 	.db #0xf8	; 248
      00827B 0F                    2435 	.db #0x0f	; 15
      00827C E0                    2436 	.db #0xe0	; 224
      00827D 3F                    2437 	.db #0x3f	; 63
      00827E 80                    2438 	.db #0x80	; 128
      00827F FE                    2439 	.db #0xfe	; 254
      008280 03                    2440 	.db #0x03	; 3
      008281 F8                    2441 	.db #0xf8	; 248
      008282 FE                    2442 	.db #0xfe	; 254
      008283 66                    2443 	.db #0x66	; 102	'f'
      008284 7E                    2444 	.db #0x7e	; 126
      008285 18                    2445 	.db #0x18	; 24
      008286 01                    2446 	.db #0x01	; 1
      008287 80                    2447 	.db #0x80	; 128
      008288 00                    2448 	.db #0x00	; 0
      008289 00                    2449 	.db #0x00	; 0
      00828A 00                    2450 	.db #0x00	; 0
      00828B 00                    2451 	.db #0x00	; 0
      00828C 00                    2452 	.db #0x00	; 0
      00828D 00                    2453 	.db #0x00	; 0
      00828E 00                    2454 	.db #0x00	; 0
      00828F 00                    2455 	.db #0x00	; 0
      008290 00                    2456 	.db #0x00	; 0
      008291 00                    2457 	.db #0x00	; 0
      008292 00                    2458 	.db #0x00	; 0
      008293 00                    2459 	.db #0x00	; 0
      008294 00                    2460 	.db #0x00	; 0
      008295 00                    2461 	.db #0x00	; 0
      008296 01                    2462 	.db #0x01	; 1
      008297 FF                    2463 	.db #0xff	; 255
      008298 FF                    2464 	.db #0xff	; 255
      008299 FF                    2465 	.db #0xff	; 255
      00829A FF                    2466 	.db #0xff	; 255
      00829B FF                    2467 	.db #0xff	; 255
      00829C FF                    2468 	.db #0xff	; 255
      00829D FF                    2469 	.db #0xff	; 255
      00829E FF                    2470 	.db #0xff	; 255
      00829F FF                    2471 	.db #0xff	; 255
      0082A0 FF                    2472 	.db #0xff	; 255
      0082A1 FF                    2473 	.db #0xff	; 255
      0082A2 FF                    2474 	.db #0xff	; 255
      0082A3 FF                    2475 	.db #0xff	; 255
      0082A4 FF                    2476 	.db #0xff	; 255
      0082A5 FF                    2477 	.db #0xff	; 255
      0082A6 FF                    2478 	.db #0xff	; 255
                                   2479 	.area CABS (ABS)
