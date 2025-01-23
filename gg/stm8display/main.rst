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
                                     13 	.globl _setup
                                     14 	.globl _set_bit
                                     15 	.globl _get_bit
                                     16 	.globl _I2C_IRQ
                                     17 	.globl _splash
                                     18 	.globl _buf_size
                                     19 	.globl _buf_pos
                                     20 	.globl _rx_buf_pointer
                                     21 	.globl _tx_buf_pointer
                                     22 	.globl _uart_transmission_irq
                                     23 	.globl _uart_reciever_irq
                                     24 	.globl _uart_write_irq
                                     25 	.globl _uart_read_irq
                                     26 	.globl _uart_init
                                     27 	.globl _uart_read_byte
                                     28 	.globl _uart_write_byte
                                     29 	.globl _uart_write
                                     30 	.globl _uart_read
                                     31 	.globl _i2c_init
                                     32 	.globl _i2c_start
                                     33 	.globl _i2c_stop
                                     34 	.globl _i2c_send_address
                                     35 	.globl _i2c_read_byte
                                     36 	.globl _i2c_read
                                     37 	.globl _i2c_send_byte
                                     38 	.globl _i2c_write
                                     39 	.globl _i2c_scan
                                     40 	.globl _ssd1306_init
                                     41 	.globl _ssd1306_set_params_to_write
                                     42 	.globl _ssd1306_draw_pixel
                                     43 	.globl _ssd1306_buffer_fill_entire
                                     44 	.globl _ssd1306_clean
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
      000007                         61 _splash::
      000007                         62 	.ds 512
      000207                         63 _I2C_IRQ::
      000207                         64 	.ds 1
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
      00804C 82 00 82 7E            109 	int _uart_transmission_irq ; int17
      008050 82 00 82 BA            110 	int _uart_reciever_irq ; int18
                                    111 ;--------------------------------------------------------
                                    112 ; global & static initialisations
                                    113 ;--------------------------------------------------------
                                    114 	.area HOME
                                    115 	.area GSINIT
                                    116 	.area GSFINAL
                                    117 	.area GSINIT
      008057 CD 89 D4         [ 4]  118 	call	___sdcc_external_startup
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
      008071 D6 80 7C         [ 1]  134 	ld	a, (s_INITIALIZER - 1, x)
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
      008054 CC 89 CB         [ 2]  148 	jp	_main
                                    149 ;	return from main will return to caller
                                    150 ;--------------------------------------------------------
                                    151 ; code
                                    152 ;--------------------------------------------------------
                                    153 	.area CODE
                                    154 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    155 ;	-----------------------------------------
                                    156 ;	 function uart_transmission_irq
                                    157 ;	-----------------------------------------
      00827E                        158 _uart_transmission_irq:
                                    159 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      00827E AE 52 30         [ 2]  160 	ldw	x, #0x5230
      008281 F6               [ 1]  161 	ld	a, (x)
      008282 4E               [ 1]  162 	swap	a
      008283 44               [ 1]  163 	srl	a
      008284 44               [ 1]  164 	srl	a
      008285 44               [ 1]  165 	srl	a
      008286 A5 01            [ 1]  166 	bcp	a, #0x01
      008288 27 2F            [ 1]  167 	jreq	00107$
                                    168 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      00828A C6 00 02         [ 1]  169 	ld	a, _tx_buf_pointer+1
      00828D CB 00 05         [ 1]  170 	add	a, _buf_pos+0
      008290 97               [ 1]  171 	ld	xl, a
      008291 C6 00 01         [ 1]  172 	ld	a, _tx_buf_pointer+0
      008294 A9 00            [ 1]  173 	adc	a, #0x00
      008296 95               [ 1]  174 	ld	xh, a
      008297 F6               [ 1]  175 	ld	a, (x)
      008298 27 1B            [ 1]  176 	jreq	00102$
      00829A C6 00 05         [ 1]  177 	ld	a, _buf_pos+0
      00829D C1 00 06         [ 1]  178 	cp	a, _buf_size+0
      0082A0 24 13            [ 1]  179 	jrnc	00102$
                                    180 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0082A2 C6 00 05         [ 1]  181 	ld	a, _buf_pos+0
      0082A5 72 5C 00 05      [ 1]  182 	inc	_buf_pos+0
      0082A9 5F               [ 1]  183 	clrw	x
      0082AA 97               [ 1]  184 	ld	xl, a
      0082AB 72 BB 00 01      [ 2]  185 	addw	x, _tx_buf_pointer+0
      0082AF F6               [ 1]  186 	ld	a, (x)
      0082B0 C7 52 31         [ 1]  187 	ld	0x5231, a
      0082B3 20 04            [ 2]  188 	jra	00107$
      0082B5                        189 00102$:
                                    190 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0082B5 72 1F 52 35      [ 1]  191 	bres	0x5235, #7
      0082B9                        192 00107$:
                                    193 ;	./libs/uart_lib.c: 14: }
      0082B9 80               [11]  194 	iret
                                    195 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    196 ;	-----------------------------------------
                                    197 ;	 function uart_reciever_irq
                                    198 ;	-----------------------------------------
      0082BA                        199 _uart_reciever_irq:
      0082BA 88               [ 1]  200 	push	a
                                    201 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      0082BB C6 52 30         [ 1]  202 	ld	a, 0x5230
      0082BE 4E               [ 1]  203 	swap	a
      0082BF 44               [ 1]  204 	srl	a
      0082C0 A5 01            [ 1]  205 	bcp	a, #0x01
      0082C2 27 27            [ 1]  206 	jreq	00107$
                                    207 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      0082C4 C6 52 31         [ 1]  208 	ld	a, 0x5231
                                    209 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      0082C7 6B 01            [ 1]  210 	ld	(0x01, sp), a
      0082C9 A1 0A            [ 1]  211 	cp	a, #0x0a
      0082CB 27 1A            [ 1]  212 	jreq	00102$
      0082CD C6 00 05         [ 1]  213 	ld	a, _buf_pos+0
      0082D0 C1 00 06         [ 1]  214 	cp	a, _buf_size+0
      0082D3 24 12            [ 1]  215 	jrnc	00102$
                                    216 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      0082D5 C6 00 05         [ 1]  217 	ld	a, _buf_pos+0
      0082D8 72 5C 00 05      [ 1]  218 	inc	_buf_pos+0
      0082DC 5F               [ 1]  219 	clrw	x
      0082DD 97               [ 1]  220 	ld	xl, a
      0082DE 72 BB 00 03      [ 2]  221 	addw	x, _rx_buf_pointer+0
      0082E2 7B 01            [ 1]  222 	ld	a, (0x01, sp)
      0082E4 F7               [ 1]  223 	ld	(x), a
      0082E5 20 04            [ 2]  224 	jra	00107$
      0082E7                        225 00102$:
                                    226 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      0082E7 72 1B 52 35      [ 1]  227 	bres	0x5235, #5
      0082EB                        228 00107$:
                                    229 ;	./libs/uart_lib.c: 30: }
      0082EB 84               [ 1]  230 	pop	a
      0082EC 80               [11]  231 	iret
                                    232 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    233 ;	-----------------------------------------
                                    234 ;	 function uart_write_irq
                                    235 ;	-----------------------------------------
      0082ED                        236 _uart_write_irq:
      0082ED 52 02            [ 2]  237 	sub	sp, #2
                                    238 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      0082EF 1F 01            [ 2]  239 	ldw	(0x01, sp), x
      0082F1 CF 00 01         [ 2]  240 	ldw	_tx_buf_pointer+0, x
                                    241 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      0082F4 72 5F 00 05      [ 1]  242 	clr	_buf_pos+0
                                    243 ;	./libs/uart_lib.c: 36: buf_size = 0;
      0082F8 72 5F 00 06      [ 1]  244 	clr	_buf_size+0
                                    245 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      0082FC                        246 00101$:
      0082FC C6 00 06         [ 1]  247 	ld	a, _buf_size+0
      0082FF 72 5C 00 06      [ 1]  248 	inc	_buf_size+0
      008303 5F               [ 1]  249 	clrw	x
      008304 97               [ 1]  250 	ld	xl, a
      008305 72 FB 01         [ 2]  251 	addw	x, (0x01, sp)
      008308 F6               [ 1]  252 	ld	a, (x)
      008309 26 F1            [ 1]  253 	jrne	00101$
                                    254 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      00830B 72 1E 52 35      [ 1]  255 	bset	0x5235, #7
                                    256 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      00830F                        257 00104$:
      00830F 72 0E 52 35 FB   [ 2]  258 	btjt	0x5235, #7, 00104$
                                    259 ;	./libs/uart_lib.c: 40: }
      008314 5B 02            [ 2]  260 	addw	sp, #2
      008316 81               [ 4]  261 	ret
                                    262 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    263 ;	-----------------------------------------
                                    264 ;	 function uart_read_irq
                                    265 ;	-----------------------------------------
      008317                        266 _uart_read_irq:
                                    267 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      008317 CF 00 03         [ 2]  268 	ldw	_rx_buf_pointer+0, x
                                    269 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      00831A 72 5F 00 05      [ 1]  270 	clr	_buf_pos+0
                                    271 ;	./libs/uart_lib.c: 45: buf_size = size;
      00831E 7B 04            [ 1]  272 	ld	a, (0x04, sp)
      008320 C7 00 06         [ 1]  273 	ld	_buf_size+0, a
                                    274 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      008323 72 1A 52 35      [ 1]  275 	bset	0x5235, #5
                                    276 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      008327                        277 00101$:
      008327 C6 52 35         [ 1]  278 	ld	a, 0x5235
      00832A 4E               [ 1]  279 	swap	a
      00832B 44               [ 1]  280 	srl	a
      00832C A4 01            [ 1]  281 	and	a, #0x01
      00832E 26 F7            [ 1]  282 	jrne	00101$
                                    283 ;	./libs/uart_lib.c: 48: }
      008330 1E 01            [ 2]  284 	ldw	x, (1, sp)
      008332 5B 04            [ 2]  285 	addw	sp, #4
      008334 FC               [ 2]  286 	jp	(x)
                                    287 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    288 ;	-----------------------------------------
                                    289 ;	 function uart_init
                                    290 ;	-----------------------------------------
      008335                        291 _uart_init:
      008335 52 02            [ 2]  292 	sub	sp, #2
      008337 1F 01            [ 2]  293 	ldw	(0x01, sp), x
                                    294 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      008339 AE 52 35         [ 2]  295 	ldw	x, #0x5235
      00833C 88               [ 1]  296 	push	a
      00833D F6               [ 1]  297 	ld	a, (x)
      00833E AA 08            [ 1]  298 	or	a, #0x08
      008340 F7               [ 1]  299 	ld	(x), a
      008341 84               [ 1]  300 	pop	a
                                    301 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      008342 AE 52 35         [ 2]  302 	ldw	x, #0x5235
      008345 88               [ 1]  303 	push	a
      008346 F6               [ 1]  304 	ld	a, (x)
      008347 AA 04            [ 1]  305 	or	a, #0x04
      008349 F7               [ 1]  306 	ld	(x), a
      00834A 84               [ 1]  307 	pop	a
                                    308 ;	./libs/uart_lib.c: 56: switch(stopbit)
      00834B A1 02            [ 1]  309 	cp	a, #0x02
      00834D 27 06            [ 1]  310 	jreq	00101$
      00834F A1 03            [ 1]  311 	cp	a, #0x03
      008351 27 0E            [ 1]  312 	jreq	00102$
      008353 20 16            [ 2]  313 	jra	00103$
                                    314 ;	./libs/uart_lib.c: 58: case 2:
      008355                        315 00101$:
                                    316 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      008355 C6 52 36         [ 1]  317 	ld	a, 0x5236
      008358 A4 CF            [ 1]  318 	and	a, #0xcf
      00835A AA 20            [ 1]  319 	or	a, #0x20
      00835C C7 52 36         [ 1]  320 	ld	0x5236, a
                                    321 ;	./libs/uart_lib.c: 60: break;
      00835F 20 12            [ 2]  322 	jra	00104$
                                    323 ;	./libs/uart_lib.c: 61: case 3:
      008361                        324 00102$:
                                    325 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      008361 C6 52 36         [ 1]  326 	ld	a, 0x5236
      008364 AA 30            [ 1]  327 	or	a, #0x30
      008366 C7 52 36         [ 1]  328 	ld	0x5236, a
                                    329 ;	./libs/uart_lib.c: 63: break;
      008369 20 08            [ 2]  330 	jra	00104$
                                    331 ;	./libs/uart_lib.c: 64: default:
      00836B                        332 00103$:
                                    333 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      00836B C6 52 36         [ 1]  334 	ld	a, 0x5236
      00836E A4 CF            [ 1]  335 	and	a, #0xcf
      008370 C7 52 36         [ 1]  336 	ld	0x5236, a
                                    337 ;	./libs/uart_lib.c: 67: }
      008373                        338 00104$:
                                    339 ;	./libs/uart_lib.c: 68: switch(baudrate)
      008373 1E 01            [ 2]  340 	ldw	x, (0x01, sp)
      008375 A3 08 00         [ 2]  341 	cpw	x, #0x0800
      008378 26 03            [ 1]  342 	jrne	00186$
      00837A CC 84 06         [ 2]  343 	jp	00110$
      00837D                        344 00186$:
      00837D 1E 01            [ 2]  345 	ldw	x, (0x01, sp)
      00837F A3 09 60         [ 2]  346 	cpw	x, #0x0960
      008382 27 28            [ 1]  347 	jreq	00105$
      008384 1E 01            [ 2]  348 	ldw	x, (0x01, sp)
      008386 A3 10 00         [ 2]  349 	cpw	x, #0x1000
      008389 26 03            [ 1]  350 	jrne	00192$
      00838B CC 84 16         [ 2]  351 	jp	00111$
      00838E                        352 00192$:
      00838E 1E 01            [ 2]  353 	ldw	x, (0x01, sp)
      008390 A3 4B 00         [ 2]  354 	cpw	x, #0x4b00
      008393 27 31            [ 1]  355 	jreq	00106$
      008395 1E 01            [ 2]  356 	ldw	x, (0x01, sp)
      008397 A3 84 00         [ 2]  357 	cpw	x, #0x8400
      00839A 27 5A            [ 1]  358 	jreq	00109$
      00839C 1E 01            [ 2]  359 	ldw	x, (0x01, sp)
      00839E A3 C2 00         [ 2]  360 	cpw	x, #0xc200
      0083A1 27 43            [ 1]  361 	jreq	00108$
      0083A3 1E 01            [ 2]  362 	ldw	x, (0x01, sp)
      0083A5 A3 E1 00         [ 2]  363 	cpw	x, #0xe100
      0083A8 27 2C            [ 1]  364 	jreq	00107$
      0083AA 20 7A            [ 2]  365 	jra	00112$
                                    366 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      0083AC                        367 00105$:
                                    368 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      0083AC C6 52 33         [ 1]  369 	ld	a, 0x5233
      0083AF A4 0F            [ 1]  370 	and	a, #0x0f
      0083B1 AA 10            [ 1]  371 	or	a, #0x10
      0083B3 C7 52 33         [ 1]  372 	ld	0x5233, a
                                    373 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      0083B6 35 A0 52 32      [ 1]  374 	mov	0x5232+0, #0xa0
                                    375 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      0083BA C6 52 33         [ 1]  376 	ld	a, 0x5233
      0083BD A4 F0            [ 1]  377 	and	a, #0xf0
      0083BF AA 0B            [ 1]  378 	or	a, #0x0b
      0083C1 C7 52 33         [ 1]  379 	ld	0x5233, a
                                    380 ;	./libs/uart_lib.c: 74: break;
      0083C4 20 6E            [ 2]  381 	jra	00114$
                                    382 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      0083C6                        383 00106$:
                                    384 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      0083C6 35 34 52 32      [ 1]  385 	mov	0x5232+0, #0x34
                                    386 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      0083CA C6 52 33         [ 1]  387 	ld	a, 0x5233
      0083CD A4 F0            [ 1]  388 	and	a, #0xf0
      0083CF AA 01            [ 1]  389 	or	a, #0x01
      0083D1 C7 52 33         [ 1]  390 	ld	0x5233, a
                                    391 ;	./libs/uart_lib.c: 78: break;
      0083D4 20 5E            [ 2]  392 	jra	00114$
                                    393 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      0083D6                        394 00107$:
                                    395 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      0083D6 35 11 52 32      [ 1]  396 	mov	0x5232+0, #0x11
                                    397 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      0083DA C6 52 33         [ 1]  398 	ld	a, 0x5233
      0083DD A4 F0            [ 1]  399 	and	a, #0xf0
      0083DF AA 06            [ 1]  400 	or	a, #0x06
      0083E1 C7 52 33         [ 1]  401 	ld	0x5233, a
                                    402 ;	./libs/uart_lib.c: 82: break;
      0083E4 20 4E            [ 2]  403 	jra	00114$
                                    404 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      0083E6                        405 00108$:
                                    406 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      0083E6 35 08 52 32      [ 1]  407 	mov	0x5232+0, #0x08
                                    408 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      0083EA C6 52 33         [ 1]  409 	ld	a, 0x5233
      0083ED A4 F0            [ 1]  410 	and	a, #0xf0
      0083EF AA 0B            [ 1]  411 	or	a, #0x0b
      0083F1 C7 52 33         [ 1]  412 	ld	0x5233, a
                                    413 ;	./libs/uart_lib.c: 86: break;
      0083F4 20 3E            [ 2]  414 	jra	00114$
                                    415 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      0083F6                        416 00109$:
                                    417 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      0083F6 35 04 52 32      [ 1]  418 	mov	0x5232+0, #0x04
                                    419 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      0083FA C6 52 33         [ 1]  420 	ld	a, 0x5233
      0083FD A4 F0            [ 1]  421 	and	a, #0xf0
      0083FF AA 05            [ 1]  422 	or	a, #0x05
      008401 C7 52 33         [ 1]  423 	ld	0x5233, a
                                    424 ;	./libs/uart_lib.c: 90: break;
      008404 20 2E            [ 2]  425 	jra	00114$
                                    426 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      008406                        427 00110$:
                                    428 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      008406 35 02 52 32      [ 1]  429 	mov	0x5232+0, #0x02
                                    430 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      00840A C6 52 33         [ 1]  431 	ld	a, 0x5233
      00840D A4 F0            [ 1]  432 	and	a, #0xf0
      00840F AA 03            [ 1]  433 	or	a, #0x03
      008411 C7 52 33         [ 1]  434 	ld	0x5233, a
                                    435 ;	./libs/uart_lib.c: 94: break;
      008414 20 1E            [ 2]  436 	jra	00114$
                                    437 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      008416                        438 00111$:
                                    439 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      008416 35 01 52 32      [ 1]  440 	mov	0x5232+0, #0x01
                                    441 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      00841A C6 52 33         [ 1]  442 	ld	a, 0x5233
      00841D A4 F0            [ 1]  443 	and	a, #0xf0
      00841F AA 01            [ 1]  444 	or	a, #0x01
      008421 C7 52 33         [ 1]  445 	ld	0x5233, a
                                    446 ;	./libs/uart_lib.c: 98: break;
      008424 20 0E            [ 2]  447 	jra	00114$
                                    448 ;	./libs/uart_lib.c: 99: default:
      008426                        449 00112$:
                                    450 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      008426 35 68 52 32      [ 1]  451 	mov	0x5232+0, #0x68
                                    452 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      00842A C6 52 33         [ 1]  453 	ld	a, 0x5233
      00842D A4 F0            [ 1]  454 	and	a, #0xf0
      00842F AA 03            [ 1]  455 	or	a, #0x03
      008431 C7 52 33         [ 1]  456 	ld	0x5233, a
                                    457 ;	./libs/uart_lib.c: 103: }
      008434                        458 00114$:
                                    459 ;	./libs/uart_lib.c: 104: }
      008434 5B 02            [ 2]  460 	addw	sp, #2
      008436 81               [ 4]  461 	ret
                                    462 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    463 ;	-----------------------------------------
                                    464 ;	 function uart_read_byte
                                    465 ;	-----------------------------------------
      008437                        466 _uart_read_byte:
                                    467 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      008437                        468 00101$:
      008437 72 0B 52 30 FB   [ 2]  469 	btjf	0x5230, #5, 00101$
                                    470 ;	./libs/uart_lib.c: 110: return 1;
      00843C 5F               [ 1]  471 	clrw	x
      00843D 5C               [ 1]  472 	incw	x
                                    473 ;	./libs/uart_lib.c: 111: }
      00843E 81               [ 4]  474 	ret
                                    475 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    476 ;	-----------------------------------------
                                    477 ;	 function uart_write_byte
                                    478 ;	-----------------------------------------
      00843F                        479 _uart_write_byte:
                                    480 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      00843F C7 52 31         [ 1]  481 	ld	0x5231, a
                                    482 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      008442                        483 00101$:
      008442 72 0F 52 30 FB   [ 2]  484 	btjf	0x5230, #7, 00101$
                                    485 ;	./libs/uart_lib.c: 117: return 1;
      008447 5F               [ 1]  486 	clrw	x
      008448 5C               [ 1]  487 	incw	x
                                    488 ;	./libs/uart_lib.c: 118: }
      008449 81               [ 4]  489 	ret
                                    490 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    491 ;	-----------------------------------------
                                    492 ;	 function uart_write
                                    493 ;	-----------------------------------------
      00844A                        494 _uart_write:
      00844A 52 04            [ 2]  495 	sub	sp, #4
      00844C 1F 01            [ 2]  496 	ldw	(0x01, sp), x
                                    497 ;	./libs/uart_lib.c: 122: int count = 0;
      00844E 5F               [ 1]  498 	clrw	x
      00844F 1F 03            [ 2]  499 	ldw	(0x03, sp), x
                                    500 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008451 5F               [ 1]  501 	clrw	x
      008452                        502 00103$:
      008452 90 93            [ 1]  503 	ldw	y, x
      008454 72 F9 01         [ 2]  504 	addw	y, (0x01, sp)
      008457 90 F6            [ 1]  505 	ld	a, (y)
      008459 27 0E            [ 1]  506 	jreq	00101$
                                    507 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      00845B 89               [ 2]  508 	pushw	x
      00845C CD 84 3F         [ 4]  509 	call	_uart_write_byte
      00845F 51               [ 1]  510 	exgw	x, y
      008460 85               [ 2]  511 	popw	x
      008461 72 F9 03         [ 2]  512 	addw	y, (0x03, sp)
      008464 17 03            [ 2]  513 	ldw	(0x03, sp), y
                                    514 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008466 5C               [ 1]  515 	incw	x
      008467 20 E9            [ 2]  516 	jra	00103$
      008469                        517 00101$:
                                    518 ;	./libs/uart_lib.c: 125: return count;
      008469 1E 03            [ 2]  519 	ldw	x, (0x03, sp)
                                    520 ;	./libs/uart_lib.c: 126: }
      00846B 5B 04            [ 2]  521 	addw	sp, #4
      00846D 81               [ 4]  522 	ret
                                    523 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    524 ;	-----------------------------------------
                                    525 ;	 function uart_read
                                    526 ;	-----------------------------------------
      00846E                        527 _uart_read:
      00846E 52 04            [ 2]  528 	sub	sp, #4
      008470 1F 01            [ 2]  529 	ldw	(0x01, sp), x
                                    530 ;	./libs/uart_lib.c: 130: int count = 0;
      008472 5F               [ 1]  531 	clrw	x
      008473 1F 03            [ 2]  532 	ldw	(0x03, sp), x
                                    533 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008475 5F               [ 1]  534 	clrw	x
      008476                        535 00103$:
      008476 90 93            [ 1]  536 	ldw	y, x
      008478 72 F9 01         [ 2]  537 	addw	y, (0x01, sp)
      00847B 90 F6            [ 1]  538 	ld	a, (y)
      00847D 27 13            [ 1]  539 	jreq	00101$
                                    540 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      00847F 90 5F            [ 1]  541 	clrw	y
      008481 90 97            [ 1]  542 	ld	yl, a
      008483 89               [ 2]  543 	pushw	x
      008484 93               [ 1]  544 	ldw	x, y
      008485 CD 84 37         [ 4]  545 	call	_uart_read_byte
      008488 51               [ 1]  546 	exgw	x, y
      008489 85               [ 2]  547 	popw	x
      00848A 72 F9 03         [ 2]  548 	addw	y, (0x03, sp)
      00848D 17 03            [ 2]  549 	ldw	(0x03, sp), y
                                    550 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      00848F 5C               [ 1]  551 	incw	x
      008490 20 E4            [ 2]  552 	jra	00103$
      008492                        553 00101$:
                                    554 ;	./libs/uart_lib.c: 133: return count;
      008492 1E 03            [ 2]  555 	ldw	x, (0x03, sp)
                                    556 ;	./libs/uart_lib.c: 134: }
      008494 5B 04            [ 2]  557 	addw	sp, #4
      008496 90 85            [ 2]  558 	popw	y
      008498 5B 02            [ 2]  559 	addw	sp, #2
      00849A 90 FC            [ 2]  560 	jp	(y)
                                    561 ;	./libs/i2c_lib.c: 3: void i2c_init(void)
                                    562 ;	-----------------------------------------
                                    563 ;	 function i2c_init
                                    564 ;	-----------------------------------------
      00849C                        565 _i2c_init:
                                    566 ;	./libs/i2c_lib.c: 7: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      00849C 72 11 52 10      [ 1]  567 	bres	0x5210, #0
                                    568 ;	./libs/i2c_lib.c: 8: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      0084A0 C6 52 12         [ 1]  569 	ld	a, 0x5212
      0084A3 A4 C0            [ 1]  570 	and	a, #0xc0
      0084A5 AA 10            [ 1]  571 	or	a, #0x10
      0084A7 C7 52 12         [ 1]  572 	ld	0x5212, a
                                    573 ;	./libs/i2c_lib.c: 9: I2C_CCRH -> CCR = 0;// =0
      0084AA C6 52 1C         [ 1]  574 	ld	a, 0x521c
      0084AD A4 F0            [ 1]  575 	and	a, #0xf0
      0084AF C7 52 1C         [ 1]  576 	ld	0x521c, a
                                    577 ;	./libs/i2c_lib.c: 10: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0084B2 35 50 52 1B      [ 1]  578 	mov	0x521b+0, #0x50
                                    579 ;	./libs/i2c_lib.c: 11: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0084B6 72 1F 52 1C      [ 1]  580 	bres	0x521c, #7
                                    581 ;	./libs/i2c_lib.c: 12: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0084BA 72 1F 52 14      [ 1]  582 	bres	0x5214, #7
                                    583 ;	./libs/i2c_lib.c: 13: I2C_OARH -> ADDCONF = 1;// see reference manual
      0084BE 72 10 52 14      [ 1]  584 	bset	0x5214, #0
                                    585 ;	./libs/i2c_lib.c: 14: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0084C2 72 10 52 10      [ 1]  586 	bset	0x5210, #0
                                    587 ;	./libs/i2c_lib.c: 15: }
      0084C6 81               [ 4]  588 	ret
                                    589 ;	./libs/i2c_lib.c: 17: void i2c_start(void)
                                    590 ;	-----------------------------------------
                                    591 ;	 function i2c_start
                                    592 ;	-----------------------------------------
      0084C7                        593 _i2c_start:
                                    594 ;	./libs/i2c_lib.c: 19: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0084C7 72 10 52 11      [ 1]  595 	bset	0x5211, #0
                                    596 ;	./libs/i2c_lib.c: 20: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0084CB                        597 00101$:
      0084CB 72 01 52 17 FB   [ 2]  598 	btjf	0x5217, #0, 00101$
                                    599 ;	./libs/i2c_lib.c: 21: }
      0084D0 81               [ 4]  600 	ret
                                    601 ;	./libs/i2c_lib.c: 23: void i2c_stop(void)
                                    602 ;	-----------------------------------------
                                    603 ;	 function i2c_stop
                                    604 ;	-----------------------------------------
      0084D1                        605 _i2c_stop:
                                    606 ;	./libs/i2c_lib.c: 25: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0084D1 72 12 52 11      [ 1]  607 	bset	0x5211, #1
                                    608 ;	./libs/i2c_lib.c: 26: }
      0084D5 81               [ 4]  609 	ret
                                    610 ;	./libs/i2c_lib.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    611 ;	-----------------------------------------
                                    612 ;	 function i2c_send_address
                                    613 ;	-----------------------------------------
      0084D6                        614 _i2c_send_address:
                                    615 ;	./libs/i2c_lib.c: 33: address = address << 1;
      0084D6 48               [ 1]  616 	sll	a
                                    617 ;	./libs/i2c_lib.c: 30: switch(rw_type)
      0084D7 88               [ 1]  618 	push	a
      0084D8 7B 04            [ 1]  619 	ld	a, (0x04, sp)
      0084DA 4A               [ 1]  620 	dec	a
      0084DB 84               [ 1]  621 	pop	a
      0084DC 26 02            [ 1]  622 	jrne	00102$
                                    623 ;	./libs/i2c_lib.c: 33: address = address << 1;
                                    624 ;	./libs/i2c_lib.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0084DE AA 01            [ 1]  625 	or	a, #0x01
                                    626 ;	./libs/i2c_lib.c: 35: break;
                                    627 ;	./libs/i2c_lib.c: 36: default:
                                    628 ;	./libs/i2c_lib.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
                                    629 ;	./libs/i2c_lib.c: 39: }
      0084E0                        630 00102$:
                                    631 ;	./libs/i2c_lib.c: 40: i2c_start();
      0084E0 88               [ 1]  632 	push	a
      0084E1 CD 84 C7         [ 4]  633 	call	_i2c_start
      0084E4 84               [ 1]  634 	pop	a
                                    635 ;	./libs/i2c_lib.c: 41: I2C_DR -> DR = address;
      0084E5 C7 52 16         [ 1]  636 	ld	0x5216, a
                                    637 ;	./libs/i2c_lib.c: 42: while(!I2C_SR1 -> ADDR)
      0084E8                        638 00106$:
      0084E8 AE 52 17         [ 2]  639 	ldw	x, #0x5217
      0084EB F6               [ 1]  640 	ld	a, (x)
      0084EC 44               [ 1]  641 	srl	a
      0084ED A4 01            [ 1]  642 	and	a, #0x01
      0084EF 26 08            [ 1]  643 	jrne	00108$
                                    644 ;	./libs/i2c_lib.c: 43: if(I2C_SR2 -> AF)
      0084F1 72 05 52 18 F2   [ 2]  645 	btjf	0x5218, #2, 00106$
                                    646 ;	./libs/i2c_lib.c: 44: return 0;
      0084F6 4F               [ 1]  647 	clr	a
      0084F7 20 08            [ 2]  648 	jra	00109$
      0084F9                        649 00108$:
                                    650 ;	./libs/i2c_lib.c: 45: clr_sr1();
      0084F9 C6 52 17         [ 1]  651 	ld	a,0x5217
                                    652 ;	./libs/i2c_lib.c: 46: clr_sr3();
      0084FC C6 52 19         [ 1]  653 	ld	a,0x5219
                                    654 ;	./libs/i2c_lib.c: 47: return 1;
      0084FF A6 01            [ 1]  655 	ld	a, #0x01
      008501                        656 00109$:
                                    657 ;	./libs/i2c_lib.c: 48: }
      008501 85               [ 2]  658 	popw	x
      008502 5B 01            [ 2]  659 	addw	sp, #1
      008504 FC               [ 2]  660 	jp	(x)
                                    661 ;	./libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void)
                                    662 ;	-----------------------------------------
                                    663 ;	 function i2c_read_byte
                                    664 ;	-----------------------------------------
      008505                        665 _i2c_read_byte:
                                    666 ;	./libs/i2c_lib.c: 52: while(!I2C_SR1 -> RXNE);
      008505                        667 00101$:
      008505 72 0D 52 17 FB   [ 2]  668 	btjf	0x5217, #6, 00101$
                                    669 ;	./libs/i2c_lib.c: 53: return I2C_DR -> DR;
      00850A C6 52 16         [ 1]  670 	ld	a, 0x5216
                                    671 ;	./libs/i2c_lib.c: 54: }
      00850D 81               [ 4]  672 	ret
                                    673 ;	./libs/i2c_lib.c: 56: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    674 ;	-----------------------------------------
                                    675 ;	 function i2c_read
                                    676 ;	-----------------------------------------
      00850E                        677 _i2c_read:
      00850E 52 04            [ 2]  678 	sub	sp, #4
                                    679 ;	./libs/i2c_lib.c: 58: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      008510 4B 01            [ 1]  680 	push	#0x01
      008512 CD 84 D6         [ 4]  681 	call	_i2c_send_address
      008515 4D               [ 1]  682 	tnz	a
      008516 27 3C            [ 1]  683 	jreq	00103$
                                    684 ;	./libs/i2c_lib.c: 60: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008518 72 14 52 11      [ 1]  685 	bset	0x5211, #2
                                    686 ;	./libs/i2c_lib.c: 61: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00851C 5F               [ 1]  687 	clrw	x
      00851D 1F 03            [ 2]  688 	ldw	(0x03, sp), x
      00851F                        689 00105$:
      00851F 5F               [ 1]  690 	clrw	x
      008520 7B 07            [ 1]  691 	ld	a, (0x07, sp)
      008522 97               [ 1]  692 	ld	xl, a
      008523 5A               [ 2]  693 	decw	x
      008524 1F 01            [ 2]  694 	ldw	(0x01, sp), x
      008526 1E 03            [ 2]  695 	ldw	x, (0x03, sp)
      008528 13 01            [ 2]  696 	cpw	x, (0x01, sp)
      00852A 2E 12            [ 1]  697 	jrsge	00101$
                                    698 ;	./libs/i2c_lib.c: 63: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00852C 1E 08            [ 2]  699 	ldw	x, (0x08, sp)
      00852E 72 FB 03         [ 2]  700 	addw	x, (0x03, sp)
      008531 89               [ 2]  701 	pushw	x
      008532 CD 85 05         [ 4]  702 	call	_i2c_read_byte
      008535 85               [ 2]  703 	popw	x
      008536 F7               [ 1]  704 	ld	(x), a
                                    705 ;	./libs/i2c_lib.c: 61: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008537 1E 03            [ 2]  706 	ldw	x, (0x03, sp)
      008539 5C               [ 1]  707 	incw	x
      00853A 1F 03            [ 2]  708 	ldw	(0x03, sp), x
      00853C 20 E1            [ 2]  709 	jra	00105$
      00853E                        710 00101$:
                                    711 ;	./libs/i2c_lib.c: 65: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00853E C6 52 11         [ 1]  712 	ld	a, 0x5211
      008541 A4 FB            [ 1]  713 	and	a, #0xfb
      008543 C7 52 11         [ 1]  714 	ld	0x5211, a
                                    715 ;	./libs/i2c_lib.c: 67: data[size-1] = i2c_read_byte();
      008546 1E 08            [ 2]  716 	ldw	x, (0x08, sp)
      008548 72 FB 01         [ 2]  717 	addw	x, (0x01, sp)
      00854B 89               [ 2]  718 	pushw	x
      00854C CD 85 05         [ 4]  719 	call	_i2c_read_byte
      00854F 85               [ 2]  720 	popw	x
      008550 F7               [ 1]  721 	ld	(x), a
                                    722 ;	./libs/i2c_lib.c: 69: i2c_stop();
      008551 CD 84 D1         [ 4]  723 	call	_i2c_stop
      008554                        724 00103$:
                                    725 ;	./libs/i2c_lib.c: 72: i2c_stop();
      008554 1E 05            [ 2]  726 	ldw	x, (5, sp)
      008556 1F 08            [ 2]  727 	ldw	(8, sp), x
      008558 5B 07            [ 2]  728 	addw	sp, #7
                                    729 ;	./libs/i2c_lib.c: 74: }
      00855A CC 84 D1         [ 2]  730 	jp	_i2c_stop
                                    731 ;	./libs/i2c_lib.c: 76: uint8_t i2c_send_byte(uint8_t data)
                                    732 ;	-----------------------------------------
                                    733 ;	 function i2c_send_byte
                                    734 ;	-----------------------------------------
      00855D                        735 _i2c_send_byte:
                                    736 ;	./libs/i2c_lib.c: 78: I2C_DR -> DR = data; //Отправка данных
      00855D C7 52 16         [ 1]  737 	ld	0x5216, a
                                    738 ;	./libs/i2c_lib.c: 79: while(!I2C_SR1 -> TXE)
      008560                        739 00103$:
      008560 72 0E 52 17 08   [ 2]  740 	btjt	0x5217, #7, 00105$
                                    741 ;	./libs/i2c_lib.c: 80: if(I2C_SR2 -> AF)
      008565 72 05 52 18 F6   [ 2]  742 	btjf	0x5218, #2, 00103$
                                    743 ;	./libs/i2c_lib.c: 81: return 1;
      00856A A6 01            [ 1]  744 	ld	a, #0x01
      00856C 81               [ 4]  745 	ret
      00856D                        746 00105$:
                                    747 ;	./libs/i2c_lib.c: 82: return 0;//флаг ответа
      00856D 4F               [ 1]  748 	clr	a
                                    749 ;	./libs/i2c_lib.c: 83: }
      00856E 81               [ 4]  750 	ret
                                    751 ;	./libs/i2c_lib.c: 85: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    752 ;	-----------------------------------------
                                    753 ;	 function i2c_write
                                    754 ;	-----------------------------------------
      00856F                        755 _i2c_write:
      00856F 52 02            [ 2]  756 	sub	sp, #2
                                    757 ;	./libs/i2c_lib.c: 87: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008571 4B 00            [ 1]  758 	push	#0x00
      008573 CD 84 D6         [ 4]  759 	call	_i2c_send_address
      008576 4D               [ 1]  760 	tnz	a
      008577 27 1D            [ 1]  761 	jreq	00105$
                                    762 ;	./libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      008579 5F               [ 1]  763 	clrw	x
      00857A                        764 00107$:
      00857A 7B 05            [ 1]  765 	ld	a, (0x05, sp)
      00857C 6B 02            [ 1]  766 	ld	(0x02, sp), a
      00857E 0F 01            [ 1]  767 	clr	(0x01, sp)
      008580 13 01            [ 2]  768 	cpw	x, (0x01, sp)
      008582 2E 12            [ 1]  769 	jrsge	00105$
                                    770 ;	./libs/i2c_lib.c: 90: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008584 90 93            [ 1]  771 	ldw	y, x
      008586 72 F9 06         [ 2]  772 	addw	y, (0x06, sp)
      008589 90 F6            [ 1]  773 	ld	a, (y)
      00858B 89               [ 2]  774 	pushw	x
      00858C CD 85 5D         [ 4]  775 	call	_i2c_send_byte
      00858F 85               [ 2]  776 	popw	x
      008590 4D               [ 1]  777 	tnz	a
      008591 26 03            [ 1]  778 	jrne	00105$
                                    779 ;	./libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      008593 5C               [ 1]  780 	incw	x
      008594 20 E4            [ 2]  781 	jra	00107$
      008596                        782 00105$:
                                    783 ;	./libs/i2c_lib.c: 95: i2c_stop();
      008596 1E 03            [ 2]  784 	ldw	x, (3, sp)
      008598 1F 06            [ 2]  785 	ldw	(6, sp), x
      00859A 5B 05            [ 2]  786 	addw	sp, #5
                                    787 ;	./libs/i2c_lib.c: 96: }
      00859C CC 84 D1         [ 2]  788 	jp	_i2c_stop
                                    789 ;	./libs/i2c_lib.c: 98: uint8_t i2c_scan(void) 
                                    790 ;	-----------------------------------------
                                    791 ;	 function i2c_scan
                                    792 ;	-----------------------------------------
      00859F                        793 _i2c_scan:
      00859F 52 02            [ 2]  794 	sub	sp, #2
                                    795 ;	./libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0085A1 A6 01            [ 1]  796 	ld	a, #0x01
      0085A3 6B 01            [ 1]  797 	ld	(0x01, sp), a
      0085A5                        798 00105$:
      0085A5 A1 7F            [ 1]  799 	cp	a, #0x7f
      0085A7 24 22            [ 1]  800 	jrnc	00103$
                                    801 ;	./libs/i2c_lib.c: 102: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0085A9 88               [ 1]  802 	push	a
      0085AA 4B 00            [ 1]  803 	push	#0x00
      0085AC CD 84 D6         [ 4]  804 	call	_i2c_send_address
      0085AF 6B 03            [ 1]  805 	ld	(0x03, sp), a
      0085B1 84               [ 1]  806 	pop	a
      0085B2 0D 02            [ 1]  807 	tnz	(0x02, sp)
      0085B4 27 07            [ 1]  808 	jreq	00102$
                                    809 ;	./libs/i2c_lib.c: 104: i2c_stop();//адрес совпал 
      0085B6 CD 84 D1         [ 4]  810 	call	_i2c_stop
                                    811 ;	./libs/i2c_lib.c: 105: return addr;// выход из цикла
      0085B9 7B 01            [ 1]  812 	ld	a, (0x01, sp)
      0085BB 20 12            [ 2]  813 	jra	00107$
      0085BD                        814 00102$:
                                    815 ;	./libs/i2c_lib.c: 107: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0085BD AE 52 18         [ 2]  816 	ldw	x, #0x5218
      0085C0 88               [ 1]  817 	push	a
      0085C1 F6               [ 1]  818 	ld	a, (x)
      0085C2 A4 FB            [ 1]  819 	and	a, #0xfb
      0085C4 F7               [ 1]  820 	ld	(x), a
      0085C5 84               [ 1]  821 	pop	a
                                    822 ;	./libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0085C6 4C               [ 1]  823 	inc	a
      0085C7 6B 01            [ 1]  824 	ld	(0x01, sp), a
      0085C9 20 DA            [ 2]  825 	jra	00105$
      0085CB                        826 00103$:
                                    827 ;	./libs/i2c_lib.c: 109: i2c_stop();//совпадений нет выход из функции
      0085CB CD 84 D1         [ 4]  828 	call	_i2c_stop
                                    829 ;	./libs/i2c_lib.c: 110: return 0;
      0085CE 4F               [ 1]  830 	clr	a
      0085CF                        831 00107$:
                                    832 ;	./libs/i2c_lib.c: 111: }
      0085CF 5B 02            [ 2]  833 	addw	sp, #2
      0085D1 81               [ 4]  834 	ret
                                    835 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                    836 ;	-----------------------------------------
                                    837 ;	 function get_bit
                                    838 ;	-----------------------------------------
      0085D2                        839 _get_bit:
                                    840 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      0085D2 7B 04            [ 1]  841 	ld	a, (0x04, sp)
      0085D4 27 04            [ 1]  842 	jreq	00113$
      0085D6                        843 00112$:
      0085D6 57               [ 2]  844 	sraw	x
      0085D7 4A               [ 1]  845 	dec	a
      0085D8 26 FC            [ 1]  846 	jrne	00112$
      0085DA                        847 00113$:
      0085DA 54               [ 2]  848 	srlw	x
      0085DB 24 03            [ 1]  849 	jrnc	00103$
      0085DD 5F               [ 1]  850 	clrw	x
      0085DE 5C               [ 1]  851 	incw	x
      0085DF 21                     852 	.byte 0x21
      0085E0                        853 00103$:
      0085E0 5F               [ 1]  854 	clrw	x
      0085E1                        855 00104$:
                                    856 ;	./libs/ssd1306_lib.c: 6: }
      0085E1 90 85            [ 2]  857 	popw	y
      0085E3 5B 02            [ 2]  858 	addw	sp, #2
      0085E5 90 FC            [ 2]  859 	jp	(y)
                                    860 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                    861 ;	-----------------------------------------
                                    862 ;	 function set_bit
                                    863 ;	-----------------------------------------
      0085E7                        864 _set_bit:
      0085E7 52 04            [ 2]  865 	sub	sp, #4
      0085E9 1F 01            [ 2]  866 	ldw	(0x01, sp), x
                                    867 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      0085EB 5F               [ 1]  868 	clrw	x
      0085EC 5C               [ 1]  869 	incw	x
      0085ED 1F 03            [ 2]  870 	ldw	(0x03, sp), x
      0085EF 7B 08            [ 1]  871 	ld	a, (0x08, sp)
      0085F1 27 07            [ 1]  872 	jreq	00114$
      0085F3                        873 00113$:
      0085F3 08 04            [ 1]  874 	sll	(0x04, sp)
      0085F5 09 03            [ 1]  875 	rlc	(0x03, sp)
      0085F7 4A               [ 1]  876 	dec	a
      0085F8 26 F9            [ 1]  877 	jrne	00113$
      0085FA                        878 00114$:
                                    879 ;	./libs/ssd1306_lib.c: 10: switch(value)
      0085FA 1E 09            [ 2]  880 	ldw	x, (0x09, sp)
      0085FC 5A               [ 2]  881 	decw	x
      0085FD 26 0B            [ 1]  882 	jrne	00102$
                                    883 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      0085FF 7B 02            [ 1]  884 	ld	a, (0x02, sp)
      008601 1A 04            [ 1]  885 	or	a, (0x04, sp)
      008603 97               [ 1]  886 	ld	xl, a
      008604 7B 01            [ 1]  887 	ld	a, (0x01, sp)
      008606 1A 03            [ 1]  888 	or	a, (0x03, sp)
                                    889 ;	./libs/ssd1306_lib.c: 14: break;
      008608 20 09            [ 2]  890 	jra	00103$
                                    891 ;	./libs/ssd1306_lib.c: 16: default:
      00860A                        892 00102$:
                                    893 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      00860A 1E 03            [ 2]  894 	ldw	x, (0x03, sp)
      00860C 53               [ 2]  895 	cplw	x
      00860D 9F               [ 1]  896 	ld	a, xl
      00860E 14 02            [ 1]  897 	and	a, (0x02, sp)
      008610 02               [ 1]  898 	rlwa	x
      008611 14 01            [ 1]  899 	and	a, (0x01, sp)
                                    900 ;	./libs/ssd1306_lib.c: 19: }
      008613                        901 00103$:
                                    902 ;	./libs/ssd1306_lib.c: 20: return data;
      008613 95               [ 1]  903 	ld	xh, a
                                    904 ;	./libs/ssd1306_lib.c: 21: }
      008614 16 05            [ 2]  905 	ldw	y, (5, sp)
      008616 5B 0A            [ 2]  906 	addw	sp, #10
      008618 90 FC            [ 2]  907 	jp	(y)
                                    908 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                    909 ;	-----------------------------------------
                                    910 ;	 function ssd1306_init
                                    911 ;	-----------------------------------------
      00861A                        912 _ssd1306_init:
      00861A 52 1B            [ 2]  913 	sub	sp, #27
                                    914 ;	./libs/ssd1306_lib.c: 26: uint8_t setup_buf[27] = {COMMAND, DISPLAY_OFF, 
      00861C 96               [ 1]  915 	ldw	x, sp
      00861D 5C               [ 1]  916 	incw	x
      00861E 7F               [ 1]  917 	clr	(x)
      00861F A6 AE            [ 1]  918 	ld	a, #0xae
      008621 6B 02            [ 1]  919 	ld	(0x02, sp), a
      008623 A6 D5            [ 1]  920 	ld	a, #0xd5
      008625 6B 03            [ 1]  921 	ld	(0x03, sp), a
      008627 A6 80            [ 1]  922 	ld	a, #0x80
      008629 6B 04            [ 1]  923 	ld	(0x04, sp), a
      00862B A6 A8            [ 1]  924 	ld	a, #0xa8
      00862D 6B 05            [ 1]  925 	ld	(0x05, sp), a
      00862F A6 1F            [ 1]  926 	ld	a, #0x1f
      008631 6B 06            [ 1]  927 	ld	(0x06, sp), a
      008633 A6 D3            [ 1]  928 	ld	a, #0xd3
      008635 6B 07            [ 1]  929 	ld	(0x07, sp), a
      008637 0F 08            [ 1]  930 	clr	(0x08, sp)
      008639 A6 40            [ 1]  931 	ld	a, #0x40
      00863B 6B 09            [ 1]  932 	ld	(0x09, sp), a
      00863D A6 8D            [ 1]  933 	ld	a, #0x8d
      00863F 6B 0A            [ 1]  934 	ld	(0x0a, sp), a
      008641 A6 14            [ 1]  935 	ld	a, #0x14
      008643 6B 0B            [ 1]  936 	ld	(0x0b, sp), a
      008645 A6 DB            [ 1]  937 	ld	a, #0xdb
      008647 6B 0C            [ 1]  938 	ld	(0x0c, sp), a
      008649 A6 40            [ 1]  939 	ld	a, #0x40
      00864B 6B 0D            [ 1]  940 	ld	(0x0d, sp), a
      00864D A6 A4            [ 1]  941 	ld	a, #0xa4
      00864F 6B 0E            [ 1]  942 	ld	(0x0e, sp), a
      008651 A6 A6            [ 1]  943 	ld	a, #0xa6
      008653 6B 0F            [ 1]  944 	ld	(0x0f, sp), a
      008655 A6 DA            [ 1]  945 	ld	a, #0xda
      008657 6B 10            [ 1]  946 	ld	(0x10, sp), a
      008659 A6 02            [ 1]  947 	ld	a, #0x02
      00865B 6B 11            [ 1]  948 	ld	(0x11, sp), a
      00865D A6 81            [ 1]  949 	ld	a, #0x81
      00865F 6B 12            [ 1]  950 	ld	(0x12, sp), a
      008661 A6 8F            [ 1]  951 	ld	a, #0x8f
      008663 6B 13            [ 1]  952 	ld	(0x13, sp), a
      008665 A6 D9            [ 1]  953 	ld	a, #0xd9
      008667 6B 14            [ 1]  954 	ld	(0x14, sp), a
      008669 A6 F1            [ 1]  955 	ld	a, #0xf1
      00866B 6B 15            [ 1]  956 	ld	(0x15, sp), a
      00866D A6 20            [ 1]  957 	ld	a, #0x20
      00866F 6B 16            [ 1]  958 	ld	(0x16, sp), a
      008671 0F 17            [ 1]  959 	clr	(0x17, sp)
      008673 A6 A0            [ 1]  960 	ld	a, #0xa0
      008675 6B 18            [ 1]  961 	ld	(0x18, sp), a
      008677 A6 C0            [ 1]  962 	ld	a, #0xc0
      008679 6B 19            [ 1]  963 	ld	(0x19, sp), a
      00867B A6 1F            [ 1]  964 	ld	a, #0x1f
      00867D 6B 1A            [ 1]  965 	ld	(0x1a, sp), a
      00867F A6 AF            [ 1]  966 	ld	a, #0xaf
      008681 6B 1B            [ 1]  967 	ld	(0x1b, sp), a
                                    968 ;	./libs/ssd1306_lib.c: 43: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buf);
      008683 89               [ 2]  969 	pushw	x
      008684 4B 1B            [ 1]  970 	push	#0x1b
      008686 A6 3C            [ 1]  971 	ld	a, #0x3c
      008688 CD 85 6F         [ 4]  972 	call	_i2c_write
                                    973 ;	./libs/ssd1306_lib.c: 44: }
      00868B 5B 1B            [ 2]  974 	addw	sp, #27
      00868D 81               [ 4]  975 	ret
                                    976 ;	./libs/ssd1306_lib.c: 46: void ssd1306_set_params_to_write(void)
                                    977 ;	-----------------------------------------
                                    978 ;	 function ssd1306_set_params_to_write
                                    979 ;	-----------------------------------------
      00868E                        980 _ssd1306_set_params_to_write:
      00868E 52 07            [ 2]  981 	sub	sp, #7
                                    982 ;	./libs/ssd1306_lib.c: 48: uint8_t set_params_buf[7] = {COMMAND,
      008690 96               [ 1]  983 	ldw	x, sp
      008691 5C               [ 1]  984 	incw	x
      008692 7F               [ 1]  985 	clr	(x)
      008693 A6 22            [ 1]  986 	ld	a, #0x22
      008695 6B 02            [ 1]  987 	ld	(0x02, sp), a
      008697 0F 03            [ 1]  988 	clr	(0x03, sp)
      008699 A6 03            [ 1]  989 	ld	a, #0x03
      00869B 6B 04            [ 1]  990 	ld	(0x04, sp), a
      00869D A6 21            [ 1]  991 	ld	a, #0x21
      00869F 6B 05            [ 1]  992 	ld	(0x05, sp), a
      0086A1 0F 06            [ 1]  993 	clr	(0x06, sp)
      0086A3 A6 7F            [ 1]  994 	ld	a, #0x7f
      0086A5 6B 07            [ 1]  995 	ld	(0x07, sp), a
                                    996 ;	./libs/ssd1306_lib.c: 52: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      0086A7 89               [ 2]  997 	pushw	x
      0086A8 4B 07            [ 1]  998 	push	#0x07
      0086AA A6 3C            [ 1]  999 	ld	a, #0x3c
      0086AC CD 85 6F         [ 4] 1000 	call	_i2c_write
                                   1001 ;	./libs/ssd1306_lib.c: 53: }
      0086AF 5B 07            [ 2] 1002 	addw	sp, #7
      0086B1 81               [ 4] 1003 	ret
                                   1004 ;	./libs/ssd1306_lib.c: 55: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1005 ;	-----------------------------------------
                                   1006 ;	 function ssd1306_draw_pixel
                                   1007 ;	-----------------------------------------
      0086B2                       1008 _ssd1306_draw_pixel:
      0086B2 52 08            [ 2] 1009 	sub	sp, #8
      0086B4 1F 07            [ 2] 1010 	ldw	(0x07, sp), x
                                   1011 ;	./libs/ssd1306_lib.c: 57: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      0086B6 6B 06            [ 1] 1012 	ld	(0x06, sp), a
      0086B8 0F 05            [ 1] 1013 	clr	(0x05, sp)
      0086BA 7B 0B            [ 1] 1014 	ld	a, (0x0b, sp)
      0086BC 0F 01            [ 1] 1015 	clr	(0x01, sp)
      0086BE 97               [ 1] 1016 	ld	xl, a
      0086BF 02               [ 1] 1017 	rlwa	x
      0086C0 4F               [ 1] 1018 	clr	a
      0086C1 01               [ 1] 1019 	rrwa	x
      0086C2 5D               [ 2] 1020 	tnzw	x
      0086C3 2A 03            [ 1] 1021 	jrpl	00103$
      0086C5 1C 00 07         [ 2] 1022 	addw	x, #0x0007
      0086C8                       1023 00103$:
      0086C8 57               [ 2] 1024 	sraw	x
      0086C9 57               [ 2] 1025 	sraw	x
      0086CA 57               [ 2] 1026 	sraw	x
      0086CB 58               [ 2] 1027 	sllw	x
      0086CC 58               [ 2] 1028 	sllw	x
      0086CD 58               [ 2] 1029 	sllw	x
      0086CE 58               [ 2] 1030 	sllw	x
      0086CF 58               [ 2] 1031 	sllw	x
      0086D0 58               [ 2] 1032 	sllw	x
      0086D1 58               [ 2] 1033 	sllw	x
      0086D2 72 FB 05         [ 2] 1034 	addw	x, (0x05, sp)
      0086D5 72 FB 07         [ 2] 1035 	addw	x, (0x07, sp)
      0086D8 1F 03            [ 2] 1036 	ldw	(0x03, sp), x
      0086DA 90 5F            [ 1] 1037 	clrw	y
      0086DC 61               [ 1] 1038 	exg	a, yl
      0086DD 7B 0C            [ 1] 1039 	ld	a, (0x0c, sp)
      0086DF 61               [ 1] 1040 	exg	a, yl
      0086E0 A4 07            [ 1] 1041 	and	a, #0x07
      0086E2 6B 06            [ 1] 1042 	ld	(0x06, sp), a
      0086E4 0F 05            [ 1] 1043 	clr	(0x05, sp)
      0086E6 1E 03            [ 2] 1044 	ldw	x, (0x03, sp)
      0086E8 F6               [ 1] 1045 	ld	a, (x)
      0086E9 5F               [ 1] 1046 	clrw	x
      0086EA 90 89            [ 2] 1047 	pushw	y
      0086EC 16 07            [ 2] 1048 	ldw	y, (0x07, sp)
      0086EE 90 89            [ 2] 1049 	pushw	y
      0086F0 97               [ 1] 1050 	ld	xl, a
      0086F1 CD 85 E7         [ 4] 1051 	call	_set_bit
      0086F4 9F               [ 1] 1052 	ld	a, xl
      0086F5 1E 03            [ 2] 1053 	ldw	x, (0x03, sp)
      0086F7 F7               [ 1] 1054 	ld	(x), a
                                   1055 ;	./libs/ssd1306_lib.c: 58: }
      0086F8 1E 09            [ 2] 1056 	ldw	x, (9, sp)
      0086FA 5B 0C            [ 2] 1057 	addw	sp, #12
      0086FC FC               [ 2] 1058 	jp	(x)
                                   1059 ;	./libs/ssd1306_lib.c: 60: void ssd1306_buffer_fill_entire(uint8_t *in_data)
                                   1060 ;	-----------------------------------------
                                   1061 ;	 function ssd1306_buffer_fill_entire
                                   1062 ;	-----------------------------------------
      0086FD                       1063 _ssd1306_buffer_fill_entire:
      0086FD 52 8D            [ 2] 1064 	sub	sp, #141
      0086FF 1F 86            [ 2] 1065 	ldw	(0x86, sp), x
                                   1066 ;	./libs/ssd1306_lib.c: 63: ssd1306_set_params_to_write();
      008701 CD 86 8E         [ 4] 1067 	call	_ssd1306_set_params_to_write
                                   1068 ;	./libs/ssd1306_lib.c: 64: uint8_t part[129]={SET_DISPLAY_START_LINE};
      008704 A6 40            [ 1] 1069 	ld	a, #0x40
      008706 6B 01            [ 1] 1070 	ld	(0x01, sp), a
      008708 0F 02            [ 1] 1071 	clr	(0x02, sp)
      00870A 0F 03            [ 1] 1072 	clr	(0x03, sp)
      00870C 0F 04            [ 1] 1073 	clr	(0x04, sp)
      00870E 0F 05            [ 1] 1074 	clr	(0x05, sp)
      008710 0F 06            [ 1] 1075 	clr	(0x06, sp)
      008712 0F 07            [ 1] 1076 	clr	(0x07, sp)
      008714 0F 08            [ 1] 1077 	clr	(0x08, sp)
      008716 0F 09            [ 1] 1078 	clr	(0x09, sp)
      008718 0F 0A            [ 1] 1079 	clr	(0x0a, sp)
      00871A 0F 0B            [ 1] 1080 	clr	(0x0b, sp)
      00871C 0F 0C            [ 1] 1081 	clr	(0x0c, sp)
      00871E 0F 0D            [ 1] 1082 	clr	(0x0d, sp)
      008720 0F 0E            [ 1] 1083 	clr	(0x0e, sp)
      008722 0F 0F            [ 1] 1084 	clr	(0x0f, sp)
      008724 0F 10            [ 1] 1085 	clr	(0x10, sp)
      008726 0F 11            [ 1] 1086 	clr	(0x11, sp)
      008728 0F 12            [ 1] 1087 	clr	(0x12, sp)
      00872A 0F 13            [ 1] 1088 	clr	(0x13, sp)
      00872C 0F 14            [ 1] 1089 	clr	(0x14, sp)
      00872E 0F 15            [ 1] 1090 	clr	(0x15, sp)
      008730 0F 16            [ 1] 1091 	clr	(0x16, sp)
      008732 0F 17            [ 1] 1092 	clr	(0x17, sp)
      008734 0F 18            [ 1] 1093 	clr	(0x18, sp)
      008736 0F 19            [ 1] 1094 	clr	(0x19, sp)
      008738 0F 1A            [ 1] 1095 	clr	(0x1a, sp)
      00873A 0F 1B            [ 1] 1096 	clr	(0x1b, sp)
      00873C 0F 1C            [ 1] 1097 	clr	(0x1c, sp)
      00873E 0F 1D            [ 1] 1098 	clr	(0x1d, sp)
      008740 0F 1E            [ 1] 1099 	clr	(0x1e, sp)
      008742 0F 1F            [ 1] 1100 	clr	(0x1f, sp)
      008744 0F 20            [ 1] 1101 	clr	(0x20, sp)
      008746 0F 21            [ 1] 1102 	clr	(0x21, sp)
      008748 0F 22            [ 1] 1103 	clr	(0x22, sp)
      00874A 0F 23            [ 1] 1104 	clr	(0x23, sp)
      00874C 0F 24            [ 1] 1105 	clr	(0x24, sp)
      00874E 0F 25            [ 1] 1106 	clr	(0x25, sp)
      008750 0F 26            [ 1] 1107 	clr	(0x26, sp)
      008752 0F 27            [ 1] 1108 	clr	(0x27, sp)
      008754 0F 28            [ 1] 1109 	clr	(0x28, sp)
      008756 0F 29            [ 1] 1110 	clr	(0x29, sp)
      008758 0F 2A            [ 1] 1111 	clr	(0x2a, sp)
      00875A 0F 2B            [ 1] 1112 	clr	(0x2b, sp)
      00875C 0F 2C            [ 1] 1113 	clr	(0x2c, sp)
      00875E 0F 2D            [ 1] 1114 	clr	(0x2d, sp)
      008760 0F 2E            [ 1] 1115 	clr	(0x2e, sp)
      008762 0F 2F            [ 1] 1116 	clr	(0x2f, sp)
      008764 0F 30            [ 1] 1117 	clr	(0x30, sp)
      008766 0F 31            [ 1] 1118 	clr	(0x31, sp)
      008768 0F 32            [ 1] 1119 	clr	(0x32, sp)
      00876A 0F 33            [ 1] 1120 	clr	(0x33, sp)
      00876C 0F 34            [ 1] 1121 	clr	(0x34, sp)
      00876E 0F 35            [ 1] 1122 	clr	(0x35, sp)
      008770 0F 36            [ 1] 1123 	clr	(0x36, sp)
      008772 0F 37            [ 1] 1124 	clr	(0x37, sp)
      008774 0F 38            [ 1] 1125 	clr	(0x38, sp)
      008776 0F 39            [ 1] 1126 	clr	(0x39, sp)
      008778 0F 3A            [ 1] 1127 	clr	(0x3a, sp)
      00877A 0F 3B            [ 1] 1128 	clr	(0x3b, sp)
      00877C 0F 3C            [ 1] 1129 	clr	(0x3c, sp)
      00877E 0F 3D            [ 1] 1130 	clr	(0x3d, sp)
      008780 0F 3E            [ 1] 1131 	clr	(0x3e, sp)
      008782 0F 3F            [ 1] 1132 	clr	(0x3f, sp)
      008784 0F 40            [ 1] 1133 	clr	(0x40, sp)
      008786 0F 41            [ 1] 1134 	clr	(0x41, sp)
      008788 0F 42            [ 1] 1135 	clr	(0x42, sp)
      00878A 0F 43            [ 1] 1136 	clr	(0x43, sp)
      00878C 0F 44            [ 1] 1137 	clr	(0x44, sp)
      00878E 0F 45            [ 1] 1138 	clr	(0x45, sp)
      008790 0F 46            [ 1] 1139 	clr	(0x46, sp)
      008792 0F 47            [ 1] 1140 	clr	(0x47, sp)
      008794 0F 48            [ 1] 1141 	clr	(0x48, sp)
      008796 0F 49            [ 1] 1142 	clr	(0x49, sp)
      008798 0F 4A            [ 1] 1143 	clr	(0x4a, sp)
      00879A 0F 4B            [ 1] 1144 	clr	(0x4b, sp)
      00879C 0F 4C            [ 1] 1145 	clr	(0x4c, sp)
      00879E 0F 4D            [ 1] 1146 	clr	(0x4d, sp)
      0087A0 0F 4E            [ 1] 1147 	clr	(0x4e, sp)
      0087A2 0F 4F            [ 1] 1148 	clr	(0x4f, sp)
      0087A4 0F 50            [ 1] 1149 	clr	(0x50, sp)
      0087A6 0F 51            [ 1] 1150 	clr	(0x51, sp)
      0087A8 0F 52            [ 1] 1151 	clr	(0x52, sp)
      0087AA 0F 53            [ 1] 1152 	clr	(0x53, sp)
      0087AC 0F 54            [ 1] 1153 	clr	(0x54, sp)
      0087AE 0F 55            [ 1] 1154 	clr	(0x55, sp)
      0087B0 0F 56            [ 1] 1155 	clr	(0x56, sp)
      0087B2 0F 57            [ 1] 1156 	clr	(0x57, sp)
      0087B4 0F 58            [ 1] 1157 	clr	(0x58, sp)
      0087B6 0F 59            [ 1] 1158 	clr	(0x59, sp)
      0087B8 0F 5A            [ 1] 1159 	clr	(0x5a, sp)
      0087BA 0F 5B            [ 1] 1160 	clr	(0x5b, sp)
      0087BC 0F 5C            [ 1] 1161 	clr	(0x5c, sp)
      0087BE 0F 5D            [ 1] 1162 	clr	(0x5d, sp)
      0087C0 0F 5E            [ 1] 1163 	clr	(0x5e, sp)
      0087C2 0F 5F            [ 1] 1164 	clr	(0x5f, sp)
      0087C4 0F 60            [ 1] 1165 	clr	(0x60, sp)
      0087C6 0F 61            [ 1] 1166 	clr	(0x61, sp)
      0087C8 0F 62            [ 1] 1167 	clr	(0x62, sp)
      0087CA 0F 63            [ 1] 1168 	clr	(0x63, sp)
      0087CC 0F 64            [ 1] 1169 	clr	(0x64, sp)
      0087CE 0F 65            [ 1] 1170 	clr	(0x65, sp)
      0087D0 0F 66            [ 1] 1171 	clr	(0x66, sp)
      0087D2 0F 67            [ 1] 1172 	clr	(0x67, sp)
      0087D4 0F 68            [ 1] 1173 	clr	(0x68, sp)
      0087D6 0F 69            [ 1] 1174 	clr	(0x69, sp)
      0087D8 0F 6A            [ 1] 1175 	clr	(0x6a, sp)
      0087DA 0F 6B            [ 1] 1176 	clr	(0x6b, sp)
      0087DC 0F 6C            [ 1] 1177 	clr	(0x6c, sp)
      0087DE 0F 6D            [ 1] 1178 	clr	(0x6d, sp)
      0087E0 0F 6E            [ 1] 1179 	clr	(0x6e, sp)
      0087E2 0F 6F            [ 1] 1180 	clr	(0x6f, sp)
      0087E4 0F 70            [ 1] 1181 	clr	(0x70, sp)
      0087E6 0F 71            [ 1] 1182 	clr	(0x71, sp)
      0087E8 0F 72            [ 1] 1183 	clr	(0x72, sp)
      0087EA 0F 73            [ 1] 1184 	clr	(0x73, sp)
      0087EC 0F 74            [ 1] 1185 	clr	(0x74, sp)
      0087EE 0F 75            [ 1] 1186 	clr	(0x75, sp)
      0087F0 0F 76            [ 1] 1187 	clr	(0x76, sp)
      0087F2 0F 77            [ 1] 1188 	clr	(0x77, sp)
      0087F4 0F 78            [ 1] 1189 	clr	(0x78, sp)
      0087F6 0F 79            [ 1] 1190 	clr	(0x79, sp)
      0087F8 0F 7A            [ 1] 1191 	clr	(0x7a, sp)
      0087FA 0F 7B            [ 1] 1192 	clr	(0x7b, sp)
      0087FC 0F 7C            [ 1] 1193 	clr	(0x7c, sp)
      0087FE 0F 7D            [ 1] 1194 	clr	(0x7d, sp)
      008800 0F 7E            [ 1] 1195 	clr	(0x7e, sp)
      008802 0F 7F            [ 1] 1196 	clr	(0x7f, sp)
      008804 0F 80            [ 1] 1197 	clr	(0x80, sp)
      008806 0F 81            [ 1] 1198 	clr	(0x81, sp)
                                   1199 ;	./libs/ssd1306_lib.c: 66: for(int page = 0;page <= 384;page+=128)
      008808 5F               [ 1] 1200 	clrw	x
      008809 1F 88            [ 2] 1201 	ldw	(0x88, sp), x
      00880B                       1202 00111$:
      00880B 1E 88            [ 2] 1203 	ldw	x, (0x88, sp)
      00880D A3 01 80         [ 2] 1204 	cpw	x, #0x0180
      008810 2D 03            [ 1] 1205 	jrsle	00160$
      008812 CC 88 92         [ 2] 1206 	jp	00113$
      008815                       1207 00160$:
                                   1208 ;	./libs/ssd1306_lib.c: 68: for (int height = 0; height < 8; height++) 
      008815 5F               [ 1] 1209 	clrw	x
      008816 1F 8A            [ 2] 1210 	ldw	(0x8a, sp), x
      008818                       1211 00108$:
      008818 1E 8A            [ 2] 1212 	ldw	x, (0x8a, sp)
      00881A A3 00 08         [ 2] 1213 	cpw	x, #0x0008
      00881D 2E 5F            [ 1] 1214 	jrsge	00102$
                                   1215 ;	./libs/ssd1306_lib.c: 70: for (int width = 0; width < 128; width++) 
      00881F 1E 8A            [ 2] 1216 	ldw	x, (0x8a, sp)
      008821 58               [ 2] 1217 	sllw	x
      008822 58               [ 2] 1218 	sllw	x
      008823 58               [ 2] 1219 	sllw	x
      008824 58               [ 2] 1220 	sllw	x
      008825 72 FB 88         [ 2] 1221 	addw	x, (0x88, sp)
      008828 1F 82            [ 2] 1222 	ldw	(0x82, sp), x
      00882A 5F               [ 1] 1223 	clrw	x
      00882B 1F 8C            [ 2] 1224 	ldw	(0x8c, sp), x
      00882D                       1225 00105$:
      00882D 1E 8C            [ 2] 1226 	ldw	x, (0x8c, sp)
      00882F A3 00 80         [ 2] 1227 	cpw	x, #0x0080
      008832 2E 43            [ 1] 1228 	jrsge	00109$
                                   1229 ;	./libs/ssd1306_lib.c: 72: ssd1306_draw_pixel(&part[1], width, height, get_bit(in_data[page+(height*16) + (width / 8)], 7 - (width % 8)));
      008834 4B 08            [ 1] 1230 	push	#0x08
      008836 4B 00            [ 1] 1231 	push	#0x00
      008838 1E 8E            [ 2] 1232 	ldw	x, (0x8e, sp)
      00883A CD 89 D6         [ 4] 1233 	call	__modsint
      00883D 1F 84            [ 2] 1234 	ldw	(0x84, sp), x
      00883F 90 AE 00 07      [ 2] 1235 	ldw	y, #0x0007
      008843 72 F2 84         [ 2] 1236 	subw	y, (0x84, sp)
      008846 1E 8C            [ 2] 1237 	ldw	x, (0x8c, sp)
      008848 2A 03            [ 1] 1238 	jrpl	00163$
      00884A 1C 00 07         [ 2] 1239 	addw	x, #0x0007
      00884D                       1240 00163$:
      00884D 57               [ 2] 1241 	sraw	x
      00884E 57               [ 2] 1242 	sraw	x
      00884F 57               [ 2] 1243 	sraw	x
      008850 72 FB 82         [ 2] 1244 	addw	x, (0x82, sp)
      008853 72 FB 86         [ 2] 1245 	addw	x, (0x86, sp)
      008856 F6               [ 1] 1246 	ld	a, (x)
      008857 5F               [ 1] 1247 	clrw	x
      008858 90 89            [ 2] 1248 	pushw	y
      00885A 97               [ 1] 1249 	ld	xl, a
      00885B CD 85 D2         [ 4] 1250 	call	_get_bit
      00885E 7B 8B            [ 1] 1251 	ld	a, (0x8b, sp)
      008860 02               [ 1] 1252 	rlwa	x
      008861 7B 8D            [ 1] 1253 	ld	a, (0x8d, sp)
      008863 01               [ 1] 1254 	rrwa	x
      008864 89               [ 2] 1255 	pushw	x
      008865 5B 01            [ 2] 1256 	addw	sp, #1
      008867 88               [ 1] 1257 	push	a
      008868 9E               [ 1] 1258 	ld	a, xh
      008869 96               [ 1] 1259 	ldw	x, sp
      00886A 1C 00 04         [ 2] 1260 	addw	x, #4
      00886D CD 86 B2         [ 4] 1261 	call	_ssd1306_draw_pixel
                                   1262 ;	./libs/ssd1306_lib.c: 70: for (int width = 0; width < 128; width++) 
      008870 1E 8C            [ 2] 1263 	ldw	x, (0x8c, sp)
      008872 5C               [ 1] 1264 	incw	x
      008873 1F 8C            [ 2] 1265 	ldw	(0x8c, sp), x
      008875 20 B6            [ 2] 1266 	jra	00105$
      008877                       1267 00109$:
                                   1268 ;	./libs/ssd1306_lib.c: 68: for (int height = 0; height < 8; height++) 
      008877 1E 8A            [ 2] 1269 	ldw	x, (0x8a, sp)
      008879 5C               [ 1] 1270 	incw	x
      00887A 1F 8A            [ 2] 1271 	ldw	(0x8a, sp), x
      00887C 20 9A            [ 2] 1272 	jra	00108$
      00887E                       1273 00102$:
                                   1274 ;	./libs/ssd1306_lib.c: 75: i2c_write(I2C_DISPLAY_ADDR, 129, part);
      00887E 96               [ 1] 1275 	ldw	x, sp
      00887F 5C               [ 1] 1276 	incw	x
      008880 89               [ 2] 1277 	pushw	x
      008881 4B 81            [ 1] 1278 	push	#0x81
      008883 A6 3C            [ 1] 1279 	ld	a, #0x3c
      008885 CD 85 6F         [ 4] 1280 	call	_i2c_write
                                   1281 ;	./libs/ssd1306_lib.c: 66: for(int page = 0;page <= 384;page+=128)
      008888 1E 88            [ 2] 1282 	ldw	x, (0x88, sp)
      00888A 1C 00 80         [ 2] 1283 	addw	x, #0x0080
      00888D 1F 88            [ 2] 1284 	ldw	(0x88, sp), x
      00888F CC 88 0B         [ 2] 1285 	jp	00111$
      008892                       1286 00113$:
                                   1287 ;	./libs/ssd1306_lib.c: 77: }
      008892 5B 8D            [ 2] 1288 	addw	sp, #141
      008894 81               [ 4] 1289 	ret
                                   1290 ;	./libs/ssd1306_lib.c: 79: void ssd1306_clean(void)
                                   1291 ;	-----------------------------------------
                                   1292 ;	 function ssd1306_clean
                                   1293 ;	-----------------------------------------
      008895                       1294 _ssd1306_clean:
      008895 52 81            [ 2] 1295 	sub	sp, #129
                                   1296 ;	./libs/ssd1306_lib.c: 81: uint8_t clean_buf[129] = {SET_DISPLAY_START_LINE};
      008897 A6 40            [ 1] 1297 	ld	a, #0x40
      008899 6B 01            [ 1] 1298 	ld	(0x01, sp), a
      00889B 0F 02            [ 1] 1299 	clr	(0x02, sp)
      00889D 0F 03            [ 1] 1300 	clr	(0x03, sp)
      00889F 0F 04            [ 1] 1301 	clr	(0x04, sp)
      0088A1 0F 05            [ 1] 1302 	clr	(0x05, sp)
      0088A3 0F 06            [ 1] 1303 	clr	(0x06, sp)
      0088A5 0F 07            [ 1] 1304 	clr	(0x07, sp)
      0088A7 0F 08            [ 1] 1305 	clr	(0x08, sp)
      0088A9 0F 09            [ 1] 1306 	clr	(0x09, sp)
      0088AB 0F 0A            [ 1] 1307 	clr	(0x0a, sp)
      0088AD 0F 0B            [ 1] 1308 	clr	(0x0b, sp)
      0088AF 0F 0C            [ 1] 1309 	clr	(0x0c, sp)
      0088B1 0F 0D            [ 1] 1310 	clr	(0x0d, sp)
      0088B3 0F 0E            [ 1] 1311 	clr	(0x0e, sp)
      0088B5 0F 0F            [ 1] 1312 	clr	(0x0f, sp)
      0088B7 0F 10            [ 1] 1313 	clr	(0x10, sp)
      0088B9 0F 11            [ 1] 1314 	clr	(0x11, sp)
      0088BB 0F 12            [ 1] 1315 	clr	(0x12, sp)
      0088BD 0F 13            [ 1] 1316 	clr	(0x13, sp)
      0088BF 0F 14            [ 1] 1317 	clr	(0x14, sp)
      0088C1 0F 15            [ 1] 1318 	clr	(0x15, sp)
      0088C3 0F 16            [ 1] 1319 	clr	(0x16, sp)
      0088C5 0F 17            [ 1] 1320 	clr	(0x17, sp)
      0088C7 0F 18            [ 1] 1321 	clr	(0x18, sp)
      0088C9 0F 19            [ 1] 1322 	clr	(0x19, sp)
      0088CB 0F 1A            [ 1] 1323 	clr	(0x1a, sp)
      0088CD 0F 1B            [ 1] 1324 	clr	(0x1b, sp)
      0088CF 0F 1C            [ 1] 1325 	clr	(0x1c, sp)
      0088D1 0F 1D            [ 1] 1326 	clr	(0x1d, sp)
      0088D3 0F 1E            [ 1] 1327 	clr	(0x1e, sp)
      0088D5 0F 1F            [ 1] 1328 	clr	(0x1f, sp)
      0088D7 0F 20            [ 1] 1329 	clr	(0x20, sp)
      0088D9 0F 21            [ 1] 1330 	clr	(0x21, sp)
      0088DB 0F 22            [ 1] 1331 	clr	(0x22, sp)
      0088DD 0F 23            [ 1] 1332 	clr	(0x23, sp)
      0088DF 0F 24            [ 1] 1333 	clr	(0x24, sp)
      0088E1 0F 25            [ 1] 1334 	clr	(0x25, sp)
      0088E3 0F 26            [ 1] 1335 	clr	(0x26, sp)
      0088E5 0F 27            [ 1] 1336 	clr	(0x27, sp)
      0088E7 0F 28            [ 1] 1337 	clr	(0x28, sp)
      0088E9 0F 29            [ 1] 1338 	clr	(0x29, sp)
      0088EB 0F 2A            [ 1] 1339 	clr	(0x2a, sp)
      0088ED 0F 2B            [ 1] 1340 	clr	(0x2b, sp)
      0088EF 0F 2C            [ 1] 1341 	clr	(0x2c, sp)
      0088F1 0F 2D            [ 1] 1342 	clr	(0x2d, sp)
      0088F3 0F 2E            [ 1] 1343 	clr	(0x2e, sp)
      0088F5 0F 2F            [ 1] 1344 	clr	(0x2f, sp)
      0088F7 0F 30            [ 1] 1345 	clr	(0x30, sp)
      0088F9 0F 31            [ 1] 1346 	clr	(0x31, sp)
      0088FB 0F 32            [ 1] 1347 	clr	(0x32, sp)
      0088FD 0F 33            [ 1] 1348 	clr	(0x33, sp)
      0088FF 0F 34            [ 1] 1349 	clr	(0x34, sp)
      008901 0F 35            [ 1] 1350 	clr	(0x35, sp)
      008903 0F 36            [ 1] 1351 	clr	(0x36, sp)
      008905 0F 37            [ 1] 1352 	clr	(0x37, sp)
      008907 0F 38            [ 1] 1353 	clr	(0x38, sp)
      008909 0F 39            [ 1] 1354 	clr	(0x39, sp)
      00890B 0F 3A            [ 1] 1355 	clr	(0x3a, sp)
      00890D 0F 3B            [ 1] 1356 	clr	(0x3b, sp)
      00890F 0F 3C            [ 1] 1357 	clr	(0x3c, sp)
      008911 0F 3D            [ 1] 1358 	clr	(0x3d, sp)
      008913 0F 3E            [ 1] 1359 	clr	(0x3e, sp)
      008915 0F 3F            [ 1] 1360 	clr	(0x3f, sp)
      008917 0F 40            [ 1] 1361 	clr	(0x40, sp)
      008919 0F 41            [ 1] 1362 	clr	(0x41, sp)
      00891B 0F 42            [ 1] 1363 	clr	(0x42, sp)
      00891D 0F 43            [ 1] 1364 	clr	(0x43, sp)
      00891F 0F 44            [ 1] 1365 	clr	(0x44, sp)
      008921 0F 45            [ 1] 1366 	clr	(0x45, sp)
      008923 0F 46            [ 1] 1367 	clr	(0x46, sp)
      008925 0F 47            [ 1] 1368 	clr	(0x47, sp)
      008927 0F 48            [ 1] 1369 	clr	(0x48, sp)
      008929 0F 49            [ 1] 1370 	clr	(0x49, sp)
      00892B 0F 4A            [ 1] 1371 	clr	(0x4a, sp)
      00892D 0F 4B            [ 1] 1372 	clr	(0x4b, sp)
      00892F 0F 4C            [ 1] 1373 	clr	(0x4c, sp)
      008931 0F 4D            [ 1] 1374 	clr	(0x4d, sp)
      008933 0F 4E            [ 1] 1375 	clr	(0x4e, sp)
      008935 0F 4F            [ 1] 1376 	clr	(0x4f, sp)
      008937 0F 50            [ 1] 1377 	clr	(0x50, sp)
      008939 0F 51            [ 1] 1378 	clr	(0x51, sp)
      00893B 0F 52            [ 1] 1379 	clr	(0x52, sp)
      00893D 0F 53            [ 1] 1380 	clr	(0x53, sp)
      00893F 0F 54            [ 1] 1381 	clr	(0x54, sp)
      008941 0F 55            [ 1] 1382 	clr	(0x55, sp)
      008943 0F 56            [ 1] 1383 	clr	(0x56, sp)
      008945 0F 57            [ 1] 1384 	clr	(0x57, sp)
      008947 0F 58            [ 1] 1385 	clr	(0x58, sp)
      008949 0F 59            [ 1] 1386 	clr	(0x59, sp)
      00894B 0F 5A            [ 1] 1387 	clr	(0x5a, sp)
      00894D 0F 5B            [ 1] 1388 	clr	(0x5b, sp)
      00894F 0F 5C            [ 1] 1389 	clr	(0x5c, sp)
      008951 0F 5D            [ 1] 1390 	clr	(0x5d, sp)
      008953 0F 5E            [ 1] 1391 	clr	(0x5e, sp)
      008955 0F 5F            [ 1] 1392 	clr	(0x5f, sp)
      008957 0F 60            [ 1] 1393 	clr	(0x60, sp)
      008959 0F 61            [ 1] 1394 	clr	(0x61, sp)
      00895B 0F 62            [ 1] 1395 	clr	(0x62, sp)
      00895D 0F 63            [ 1] 1396 	clr	(0x63, sp)
      00895F 0F 64            [ 1] 1397 	clr	(0x64, sp)
      008961 0F 65            [ 1] 1398 	clr	(0x65, sp)
      008963 0F 66            [ 1] 1399 	clr	(0x66, sp)
      008965 0F 67            [ 1] 1400 	clr	(0x67, sp)
      008967 0F 68            [ 1] 1401 	clr	(0x68, sp)
      008969 0F 69            [ 1] 1402 	clr	(0x69, sp)
      00896B 0F 6A            [ 1] 1403 	clr	(0x6a, sp)
      00896D 0F 6B            [ 1] 1404 	clr	(0x6b, sp)
      00896F 0F 6C            [ 1] 1405 	clr	(0x6c, sp)
      008971 0F 6D            [ 1] 1406 	clr	(0x6d, sp)
      008973 0F 6E            [ 1] 1407 	clr	(0x6e, sp)
      008975 0F 6F            [ 1] 1408 	clr	(0x6f, sp)
      008977 0F 70            [ 1] 1409 	clr	(0x70, sp)
      008979 0F 71            [ 1] 1410 	clr	(0x71, sp)
      00897B 0F 72            [ 1] 1411 	clr	(0x72, sp)
      00897D 0F 73            [ 1] 1412 	clr	(0x73, sp)
      00897F 0F 74            [ 1] 1413 	clr	(0x74, sp)
      008981 0F 75            [ 1] 1414 	clr	(0x75, sp)
      008983 0F 76            [ 1] 1415 	clr	(0x76, sp)
      008985 0F 77            [ 1] 1416 	clr	(0x77, sp)
      008987 0F 78            [ 1] 1417 	clr	(0x78, sp)
      008989 0F 79            [ 1] 1418 	clr	(0x79, sp)
      00898B 0F 7A            [ 1] 1419 	clr	(0x7a, sp)
      00898D 0F 7B            [ 1] 1420 	clr	(0x7b, sp)
      00898F 0F 7C            [ 1] 1421 	clr	(0x7c, sp)
      008991 0F 7D            [ 1] 1422 	clr	(0x7d, sp)
      008993 0F 7E            [ 1] 1423 	clr	(0x7e, sp)
      008995 0F 7F            [ 1] 1424 	clr	(0x7f, sp)
      008997 0F 80            [ 1] 1425 	clr	(0x80, sp)
      008999 0F 81            [ 1] 1426 	clr	(0x81, sp)
                                   1427 ;	./libs/ssd1306_lib.c: 83: ssd1306_set_params_to_write();
      00899B CD 86 8E         [ 4] 1428 	call	_ssd1306_set_params_to_write
                                   1429 ;	./libs/ssd1306_lib.c: 85: for(int i = 0;i<4;i++)
      00899E 4F               [ 1] 1430 	clr	a
      00899F                       1431 00103$:
      00899F A1 04            [ 1] 1432 	cp	a, #0x04
      0089A1 24 10            [ 1] 1433 	jrnc	00105$
                                   1434 ;	./libs/ssd1306_lib.c: 86: i2c_write(I2C_DISPLAY_ADDR,129,clean_buf);
      0089A3 88               [ 1] 1435 	push	a
      0089A4 96               [ 1] 1436 	ldw	x, sp
      0089A5 5C               [ 1] 1437 	incw	x
      0089A6 5C               [ 1] 1438 	incw	x
      0089A7 89               [ 2] 1439 	pushw	x
      0089A8 4B 81            [ 1] 1440 	push	#0x81
      0089AA A6 3C            [ 1] 1441 	ld	a, #0x3c
      0089AC CD 85 6F         [ 4] 1442 	call	_i2c_write
      0089AF 84               [ 1] 1443 	pop	a
                                   1444 ;	./libs/ssd1306_lib.c: 85: for(int i = 0;i<4;i++)
      0089B0 4C               [ 1] 1445 	inc	a
      0089B1 20 EC            [ 2] 1446 	jra	00103$
      0089B3                       1447 00105$:
                                   1448 ;	./libs/ssd1306_lib.c: 88: }
      0089B3 5B 81            [ 2] 1449 	addw	sp, #129
      0089B5 81               [ 4] 1450 	ret
                                   1451 ;	main.c: 3: void setup(void)
                                   1452 ;	-----------------------------------------
                                   1453 ;	 function setup
                                   1454 ;	-----------------------------------------
      0089B6                       1455 _setup:
                                   1456 ;	main.c: 6: CLK_CKDIVR = 0;
      0089B6 35 00 50 C6      [ 1] 1457 	mov	0x50c6+0, #0x00
                                   1458 ;	main.c: 9: i2c_init();
      0089BA CD 84 9C         [ 4] 1459 	call	_i2c_init
                                   1460 ;	main.c: 11: enableInterrupts();
      0089BD 9A               [ 1] 1461 	rim
                                   1462 ;	main.c: 12: }
      0089BE 81               [ 4] 1463 	ret
                                   1464 ;	main.c: 14: void gg(void)
                                   1465 ;	-----------------------------------------
                                   1466 ;	 function gg
                                   1467 ;	-----------------------------------------
      0089BF                       1468 _gg:
                                   1469 ;	main.c: 16: ssd1306_init();
      0089BF CD 86 1A         [ 4] 1470 	call	_ssd1306_init
                                   1471 ;	main.c: 17: ssd1306_clean();
      0089C2 CD 88 95         [ 4] 1472 	call	_ssd1306_clean
                                   1473 ;	main.c: 18: ssd1306_buffer_fill_entire(splash);
      0089C5 AE 00 07         [ 2] 1474 	ldw	x, #(_splash+0)
                                   1475 ;	main.c: 20: }
      0089C8 CC 86 FD         [ 2] 1476 	jp	_ssd1306_buffer_fill_entire
                                   1477 ;	main.c: 22: int main(void)
                                   1478 ;	-----------------------------------------
                                   1479 ;	 function main
                                   1480 ;	-----------------------------------------
      0089CB                       1481 _main:
                                   1482 ;	main.c: 24: setup();
      0089CB CD 89 B6         [ 4] 1483 	call	_setup
                                   1484 ;	main.c: 25: gg();
      0089CE CD 89 BF         [ 4] 1485 	call	_gg
                                   1486 ;	main.c: 26: while(1);
      0089D1                       1487 00102$:
      0089D1 20 FE            [ 2] 1488 	jra	00102$
                                   1489 ;	main.c: 27: }
      0089D3 81               [ 4] 1490 	ret
                                   1491 	.area CODE
                                   1492 	.area CONST
                                   1493 	.area INITIALIZER
      00807D                       1494 __xinit__splash:
      00807D FF                    1495 	.db #0xff	; 255
      00807E FF                    1496 	.db #0xff	; 255
      00807F FF                    1497 	.db #0xff	; 255
      008080 FF                    1498 	.db #0xff	; 255
      008081 FF                    1499 	.db #0xff	; 255
      008082 FF                    1500 	.db #0xff	; 255
      008083 FF                    1501 	.db #0xff	; 255
      008084 FF                    1502 	.db #0xff	; 255
      008085 FF                    1503 	.db #0xff	; 255
      008086 FF                    1504 	.db #0xff	; 255
      008087 FF                    1505 	.db #0xff	; 255
      008088 FF                    1506 	.db #0xff	; 255
      008089 FF                    1507 	.db #0xff	; 255
      00808A FF                    1508 	.db #0xff	; 255
      00808B FF                    1509 	.db #0xff	; 255
      00808C FF                    1510 	.db #0xff	; 255
      00808D 80                    1511 	.db #0x80	; 128
      00808E 00                    1512 	.db #0x00	; 0
      00808F 00                    1513 	.db #0x00	; 0
      008090 00                    1514 	.db #0x00	; 0
      008091 00                    1515 	.db #0x00	; 0
      008092 00                    1516 	.db #0x00	; 0
      008093 00                    1517 	.db #0x00	; 0
      008094 00                    1518 	.db #0x00	; 0
      008095 00                    1519 	.db #0x00	; 0
      008096 00                    1520 	.db #0x00	; 0
      008097 00                    1521 	.db #0x00	; 0
      008098 00                    1522 	.db #0x00	; 0
      008099 00                    1523 	.db #0x00	; 0
      00809A 00                    1524 	.db #0x00	; 0
      00809B 00                    1525 	.db #0x00	; 0
      00809C 01                    1526 	.db #0x01	; 1
      00809D 80                    1527 	.db #0x80	; 128
      00809E FE                    1528 	.db #0xfe	; 254
      00809F 03                    1529 	.db #0x03	; 3
      0080A0 FF                    1530 	.db #0xff	; 255
      0080A1 FF                    1531 	.db #0xff	; 255
      0080A2 FF                    1532 	.db #0xff	; 255
      0080A3 FF                    1533 	.db #0xff	; 255
      0080A4 80                    1534 	.db #0x80	; 128
      0080A5 FF                    1535 	.db #0xff	; 255
      0080A6 FF                    1536 	.db #0xff	; 255
      0080A7 F8                    1537 	.db #0xf8	; 248
      0080A8 00                    1538 	.db #0x00	; 0
      0080A9 1D                    1539 	.db #0x1d	; 29
      0080AA 1D                    1540 	.db #0x1d	; 29
      0080AB 5C                    1541 	.db #0x5c	; 92
      0080AC ED                    1542 	.db #0xed	; 237
      0080AD 80                    1543 	.db #0x80	; 128
      0080AE FE                    1544 	.db #0xfe	; 254
      0080AF 03                    1545 	.db #0x03	; 3
      0080B0 FF                    1546 	.db #0xff	; 255
      0080B1 FF                    1547 	.db #0xff	; 255
      0080B2 FF                    1548 	.db #0xff	; 255
      0080B3 FF                    1549 	.db #0xff	; 255
      0080B4 80                    1550 	.db #0x80	; 128
      0080B5 FF                    1551 	.db #0xff	; 255
      0080B6 FF                    1552 	.db #0xff	; 255
      0080B7 F8                    1553 	.db #0xf8	; 248
      0080B8 00                    1554 	.db #0x00	; 0
      0080B9 15                    1555 	.db #0x15	; 21
      0080BA 15                    1556 	.db #0x15	; 21
      0080BB 54                    1557 	.db #0x54	; 84	'T'
      0080BC A5                    1558 	.db #0xa5	; 165
      0080BD 80                    1559 	.db #0x80	; 128
      0080BE FE                    1560 	.db #0xfe	; 254
      0080BF 03                    1561 	.db #0x03	; 3
      0080C0 FF                    1562 	.db #0xff	; 255
      0080C1 FF                    1563 	.db #0xff	; 255
      0080C2 FF                    1564 	.db #0xff	; 255
      0080C3 FF                    1565 	.db #0xff	; 255
      0080C4 80                    1566 	.db #0x80	; 128
      0080C5 FF                    1567 	.db #0xff	; 255
      0080C6 FF                    1568 	.db #0xff	; 255
      0080C7 F8                    1569 	.db #0xf8	; 248
      0080C8 00                    1570 	.db #0x00	; 0
      0080C9 1D                    1571 	.db #0x1d	; 29
      0080CA 1D                    1572 	.db #0x1d	; 29
      0080CB DC                    1573 	.db #0xdc	; 220
      0080CC A5                    1574 	.db #0xa5	; 165
      0080CD 80                    1575 	.db #0x80	; 128
      0080CE FE                    1576 	.db #0xfe	; 254
      0080CF 03                    1577 	.db #0x03	; 3
      0080D0 FF                    1578 	.db #0xff	; 255
      0080D1 FF                    1579 	.db #0xff	; 255
      0080D2 FF                    1580 	.db #0xff	; 255
      0080D3 FF                    1581 	.db #0xff	; 255
      0080D4 80                    1582 	.db #0x80	; 128
      0080D5 FF                    1583 	.db #0xff	; 255
      0080D6 FF                    1584 	.db #0xff	; 255
      0080D7 F8                    1585 	.db #0xf8	; 248
      0080D8 00                    1586 	.db #0x00	; 0
      0080D9 15                    1587 	.db #0x15	; 21
      0080DA D1                    1588 	.db #0xd1	; 209
      0080DB 54                    1589 	.db #0x54	; 84	'T'
      0080DC E5                    1590 	.db #0xe5	; 229
      0080DD 80                    1591 	.db #0x80	; 128
      0080DE FE                    1592 	.db #0xfe	; 254
      0080DF 03                    1593 	.db #0x03	; 3
      0080E0 FF                    1594 	.db #0xff	; 255
      0080E1 FF                    1595 	.db #0xff	; 255
      0080E2 FF                    1596 	.db #0xff	; 255
      0080E3 FF                    1597 	.db #0xff	; 255
      0080E4 80                    1598 	.db #0x80	; 128
      0080E5 FF                    1599 	.db #0xff	; 255
      0080E6 FF                    1600 	.db #0xff	; 255
      0080E7 F8                    1601 	.db #0xf8	; 248
      0080E8 00                    1602 	.db #0x00	; 0
      0080E9 00                    1603 	.db #0x00	; 0
      0080EA 00                    1604 	.db #0x00	; 0
      0080EB 00                    1605 	.db #0x00	; 0
      0080EC 01                    1606 	.db #0x01	; 1
      0080ED 80                    1607 	.db #0x80	; 128
      0080EE FE                    1608 	.db #0xfe	; 254
      0080EF 03                    1609 	.db #0x03	; 3
      0080F0 FF                    1610 	.db #0xff	; 255
      0080F1 FF                    1611 	.db #0xff	; 255
      0080F2 FF                    1612 	.db #0xff	; 255
      0080F3 FF                    1613 	.db #0xff	; 255
      0080F4 80                    1614 	.db #0x80	; 128
      0080F5 FF                    1615 	.db #0xff	; 255
      0080F6 FF                    1616 	.db #0xff	; 255
      0080F7 F8                    1617 	.db #0xf8	; 248
      0080F8 00                    1618 	.db #0x00	; 0
      0080F9 00                    1619 	.db #0x00	; 0
      0080FA 00                    1620 	.db #0x00	; 0
      0080FB 00                    1621 	.db #0x00	; 0
      0080FC 01                    1622 	.db #0x01	; 1
      0080FD 80                    1623 	.db #0x80	; 128
      0080FE FE                    1624 	.db #0xfe	; 254
      0080FF 03                    1625 	.db #0x03	; 3
      008100 FF                    1626 	.db #0xff	; 255
      008101 FF                    1627 	.db #0xff	; 255
      008102 FF                    1628 	.db #0xff	; 255
      008103 FF                    1629 	.db #0xff	; 255
      008104 80                    1630 	.db #0x80	; 128
      008105 FF                    1631 	.db #0xff	; 255
      008106 FF                    1632 	.db #0xff	; 255
      008107 F8                    1633 	.db #0xf8	; 248
      008108 00                    1634 	.db #0x00	; 0
      008109 00                    1635 	.db #0x00	; 0
      00810A 00                    1636 	.db #0x00	; 0
      00810B 00                    1637 	.db #0x00	; 0
      00810C 01                    1638 	.db #0x01	; 1
      00810D 80                    1639 	.db #0x80	; 128
      00810E FF                    1640 	.db #0xff	; 255
      00810F FF                    1641 	.db #0xff	; 255
      008110 F8                    1642 	.db #0xf8	; 248
      008111 0F                    1643 	.db #0x0f	; 15
      008112 E0                    1644 	.db #0xe0	; 224
      008113 3F                    1645 	.db #0x3f	; 63
      008114 80                    1646 	.db #0x80	; 128
      008115 FE                    1647 	.db #0xfe	; 254
      008116 03                    1648 	.db #0x03	; 3
      008117 F8                    1649 	.db #0xf8	; 248
      008118 00                    1650 	.db #0x00	; 0
      008119 00                    1651 	.db #0x00	; 0
      00811A 00                    1652 	.db #0x00	; 0
      00811B 00                    1653 	.db #0x00	; 0
      00811C 01                    1654 	.db #0x01	; 1
      00811D 80                    1655 	.db #0x80	; 128
      00811E FF                    1656 	.db #0xff	; 255
      00811F FF                    1657 	.db #0xff	; 255
      008120 F8                    1658 	.db #0xf8	; 248
      008121 0F                    1659 	.db #0x0f	; 15
      008122 E0                    1660 	.db #0xe0	; 224
      008123 3F                    1661 	.db #0x3f	; 63
      008124 80                    1662 	.db #0x80	; 128
      008125 FE                    1663 	.db #0xfe	; 254
      008126 03                    1664 	.db #0x03	; 3
      008127 F8                    1665 	.db #0xf8	; 248
      008128 00                    1666 	.db #0x00	; 0
      008129 00                    1667 	.db #0x00	; 0
      00812A 00                    1668 	.db #0x00	; 0
      00812B 00                    1669 	.db #0x00	; 0
      00812C 01                    1670 	.db #0x01	; 1
      00812D 80                    1671 	.db #0x80	; 128
      00812E FF                    1672 	.db #0xff	; 255
      00812F FF                    1673 	.db #0xff	; 255
      008130 F8                    1674 	.db #0xf8	; 248
      008131 0F                    1675 	.db #0x0f	; 15
      008132 E0                    1676 	.db #0xe0	; 224
      008133 3F                    1677 	.db #0x3f	; 63
      008134 80                    1678 	.db #0x80	; 128
      008135 FE                    1679 	.db #0xfe	; 254
      008136 03                    1680 	.db #0x03	; 3
      008137 F8                    1681 	.db #0xf8	; 248
      008138 00                    1682 	.db #0x00	; 0
      008139 00                    1683 	.db #0x00	; 0
      00813A 00                    1684 	.db #0x00	; 0
      00813B 00                    1685 	.db #0x00	; 0
      00813C 01                    1686 	.db #0x01	; 1
      00813D 80                    1687 	.db #0x80	; 128
      00813E FF                    1688 	.db #0xff	; 255
      00813F FF                    1689 	.db #0xff	; 255
      008140 F8                    1690 	.db #0xf8	; 248
      008141 0F                    1691 	.db #0x0f	; 15
      008142 E0                    1692 	.db #0xe0	; 224
      008143 3F                    1693 	.db #0x3f	; 63
      008144 80                    1694 	.db #0x80	; 128
      008145 FE                    1695 	.db #0xfe	; 254
      008146 03                    1696 	.db #0x03	; 3
      008147 F8                    1697 	.db #0xf8	; 248
      008148 00                    1698 	.db #0x00	; 0
      008149 00                    1699 	.db #0x00	; 0
      00814A 00                    1700 	.db #0x00	; 0
      00814B 00                    1701 	.db #0x00	; 0
      00814C 01                    1702 	.db #0x01	; 1
      00814D 80                    1703 	.db #0x80	; 128
      00814E FF                    1704 	.db #0xff	; 255
      00814F FF                    1705 	.db #0xff	; 255
      008150 F8                    1706 	.db #0xf8	; 248
      008151 0F                    1707 	.db #0x0f	; 15
      008152 E0                    1708 	.db #0xe0	; 224
      008153 3F                    1709 	.db #0x3f	; 63
      008154 80                    1710 	.db #0x80	; 128
      008155 FE                    1711 	.db #0xfe	; 254
      008156 03                    1712 	.db #0x03	; 3
      008157 F8                    1713 	.db #0xf8	; 248
      008158 00                    1714 	.db #0x00	; 0
      008159 00                    1715 	.db #0x00	; 0
      00815A 00                    1716 	.db #0x00	; 0
      00815B 00                    1717 	.db #0x00	; 0
      00815C 01                    1718 	.db #0x01	; 1
      00815D 80                    1719 	.db #0x80	; 128
      00815E FF                    1720 	.db #0xff	; 255
      00815F FF                    1721 	.db #0xff	; 255
      008160 F8                    1722 	.db #0xf8	; 248
      008161 0F                    1723 	.db #0x0f	; 15
      008162 E0                    1724 	.db #0xe0	; 224
      008163 3F                    1725 	.db #0x3f	; 63
      008164 80                    1726 	.db #0x80	; 128
      008165 FE                    1727 	.db #0xfe	; 254
      008166 03                    1728 	.db #0x03	; 3
      008167 F8                    1729 	.db #0xf8	; 248
      008168 00                    1730 	.db #0x00	; 0
      008169 00                    1731 	.db #0x00	; 0
      00816A 00                    1732 	.db #0x00	; 0
      00816B 00                    1733 	.db #0x00	; 0
      00816C 01                    1734 	.db #0x01	; 1
      00816D 80                    1735 	.db #0x80	; 128
      00816E FF                    1736 	.db #0xff	; 255
      00816F FF                    1737 	.db #0xff	; 255
      008170 F8                    1738 	.db #0xf8	; 248
      008171 0F                    1739 	.db #0x0f	; 15
      008172 E0                    1740 	.db #0xe0	; 224
      008173 3F                    1741 	.db #0x3f	; 63
      008174 80                    1742 	.db #0x80	; 128
      008175 FE                    1743 	.db #0xfe	; 254
      008176 03                    1744 	.db #0x03	; 3
      008177 F8                    1745 	.db #0xf8	; 248
      008178 00                    1746 	.db #0x00	; 0
      008179 00                    1747 	.db #0x00	; 0
      00817A 00                    1748 	.db #0x00	; 0
      00817B 00                    1749 	.db #0x00	; 0
      00817C 01                    1750 	.db #0x01	; 1
      00817D 80                    1751 	.db #0x80	; 128
      00817E FE                    1752 	.db #0xfe	; 254
      00817F 03                    1753 	.db #0x03	; 3
      008180 F8                    1754 	.db #0xf8	; 248
      008181 0F                    1755 	.db #0x0f	; 15
      008182 E0                    1756 	.db #0xe0	; 224
      008183 3F                    1757 	.db #0x3f	; 63
      008184 FF                    1758 	.db #0xff	; 255
      008185 FF                    1759 	.db #0xff	; 255
      008186 FC                    1760 	.db #0xfc	; 252
      008187 00                    1761 	.db #0x00	; 0
      008188 00                    1762 	.db #0x00	; 0
      008189 00                    1763 	.db #0x00	; 0
      00818A 00                    1764 	.db #0x00	; 0
      00818B 00                    1765 	.db #0x00	; 0
      00818C 01                    1766 	.db #0x01	; 1
      00818D 80                    1767 	.db #0x80	; 128
      00818E FE                    1768 	.db #0xfe	; 254
      00818F 03                    1769 	.db #0x03	; 3
      008190 F8                    1770 	.db #0xf8	; 248
      008191 0F                    1771 	.db #0x0f	; 15
      008192 E0                    1772 	.db #0xe0	; 224
      008193 3F                    1773 	.db #0x3f	; 63
      008194 FF                    1774 	.db #0xff	; 255
      008195 FF                    1775 	.db #0xff	; 255
      008196 FC                    1776 	.db #0xfc	; 252
      008197 00                    1777 	.db #0x00	; 0
      008198 00                    1778 	.db #0x00	; 0
      008199 00                    1779 	.db #0x00	; 0
      00819A 00                    1780 	.db #0x00	; 0
      00819B 00                    1781 	.db #0x00	; 0
      00819C 01                    1782 	.db #0x01	; 1
      00819D 80                    1783 	.db #0x80	; 128
      00819E FE                    1784 	.db #0xfe	; 254
      00819F 03                    1785 	.db #0x03	; 3
      0081A0 F8                    1786 	.db #0xf8	; 248
      0081A1 0F                    1787 	.db #0x0f	; 15
      0081A2 E0                    1788 	.db #0xe0	; 224
      0081A3 3F                    1789 	.db #0x3f	; 63
      0081A4 FF                    1790 	.db #0xff	; 255
      0081A5 FF                    1791 	.db #0xff	; 255
      0081A6 FC                    1792 	.db #0xfc	; 252
      0081A7 00                    1793 	.db #0x00	; 0
      0081A8 00                    1794 	.db #0x00	; 0
      0081A9 00                    1795 	.db #0x00	; 0
      0081AA 00                    1796 	.db #0x00	; 0
      0081AB 00                    1797 	.db #0x00	; 0
      0081AC 01                    1798 	.db #0x01	; 1
      0081AD 80                    1799 	.db #0x80	; 128
      0081AE FE                    1800 	.db #0xfe	; 254
      0081AF 03                    1801 	.db #0x03	; 3
      0081B0 F8                    1802 	.db #0xf8	; 248
      0081B1 0F                    1803 	.db #0x0f	; 15
      0081B2 E0                    1804 	.db #0xe0	; 224
      0081B3 3F                    1805 	.db #0x3f	; 63
      0081B4 FF                    1806 	.db #0xff	; 255
      0081B5 FF                    1807 	.db #0xff	; 255
      0081B6 FC                    1808 	.db #0xfc	; 252
      0081B7 00                    1809 	.db #0x00	; 0
      0081B8 00                    1810 	.db #0x00	; 0
      0081B9 00                    1811 	.db #0x00	; 0
      0081BA 00                    1812 	.db #0x00	; 0
      0081BB 00                    1813 	.db #0x00	; 0
      0081BC 01                    1814 	.db #0x01	; 1
      0081BD 80                    1815 	.db #0x80	; 128
      0081BE FE                    1816 	.db #0xfe	; 254
      0081BF 03                    1817 	.db #0x03	; 3
      0081C0 F8                    1818 	.db #0xf8	; 248
      0081C1 0F                    1819 	.db #0x0f	; 15
      0081C2 E0                    1820 	.db #0xe0	; 224
      0081C3 3F                    1821 	.db #0x3f	; 63
      0081C4 FF                    1822 	.db #0xff	; 255
      0081C5 FF                    1823 	.db #0xff	; 255
      0081C6 FC                    1824 	.db #0xfc	; 252
      0081C7 00                    1825 	.db #0x00	; 0
      0081C8 00                    1826 	.db #0x00	; 0
      0081C9 00                    1827 	.db #0x00	; 0
      0081CA 00                    1828 	.db #0x00	; 0
      0081CB 00                    1829 	.db #0x00	; 0
      0081CC 01                    1830 	.db #0x01	; 1
      0081CD 80                    1831 	.db #0x80	; 128
      0081CE FE                    1832 	.db #0xfe	; 254
      0081CF 03                    1833 	.db #0x03	; 3
      0081D0 F8                    1834 	.db #0xf8	; 248
      0081D1 0F                    1835 	.db #0x0f	; 15
      0081D2 E0                    1836 	.db #0xe0	; 224
      0081D3 3F                    1837 	.db #0x3f	; 63
      0081D4 FF                    1838 	.db #0xff	; 255
      0081D5 FF                    1839 	.db #0xff	; 255
      0081D6 FC                    1840 	.db #0xfc	; 252
      0081D7 00                    1841 	.db #0x00	; 0
      0081D8 00                    1842 	.db #0x00	; 0
      0081D9 00                    1843 	.db #0x00	; 0
      0081DA 00                    1844 	.db #0x00	; 0
      0081DB 00                    1845 	.db #0x00	; 0
      0081DC 01                    1846 	.db #0x01	; 1
      0081DD 80                    1847 	.db #0x80	; 128
      0081DE FE                    1848 	.db #0xfe	; 254
      0081DF 03                    1849 	.db #0x03	; 3
      0081E0 F8                    1850 	.db #0xf8	; 248
      0081E1 0F                    1851 	.db #0x0f	; 15
      0081E2 E0                    1852 	.db #0xe0	; 224
      0081E3 3F                    1853 	.db #0x3f	; 63
      0081E4 FF                    1854 	.db #0xff	; 255
      0081E5 FF                    1855 	.db #0xff	; 255
      0081E6 FC                    1856 	.db #0xfc	; 252
      0081E7 00                    1857 	.db #0x00	; 0
      0081E8 00                    1858 	.db #0x00	; 0
      0081E9 00                    1859 	.db #0x00	; 0
      0081EA 00                    1860 	.db #0x00	; 0
      0081EB 00                    1861 	.db #0x00	; 0
      0081EC 01                    1862 	.db #0x01	; 1
      0081ED 80                    1863 	.db #0x80	; 128
      0081EE FE                    1864 	.db #0xfe	; 254
      0081EF 03                    1865 	.db #0x03	; 3
      0081F0 F8                    1866 	.db #0xf8	; 248
      0081F1 0F                    1867 	.db #0x0f	; 15
      0081F2 E0                    1868 	.db #0xe0	; 224
      0081F3 3F                    1869 	.db #0x3f	; 63
      0081F4 80                    1870 	.db #0x80	; 128
      0081F5 FE                    1871 	.db #0xfe	; 254
      0081F6 03                    1872 	.db #0x03	; 3
      0081F7 F8                    1873 	.db #0xf8	; 248
      0081F8 FE                    1874 	.db #0xfe	; 254
      0081F9 00                    1875 	.db #0x00	; 0
      0081FA 00                    1876 	.db #0x00	; 0
      0081FB 00                    1877 	.db #0x00	; 0
      0081FC 01                    1878 	.db #0x01	; 1
      0081FD 80                    1879 	.db #0x80	; 128
      0081FE FE                    1880 	.db #0xfe	; 254
      0081FF 03                    1881 	.db #0x03	; 3
      008200 F8                    1882 	.db #0xf8	; 248
      008201 0F                    1883 	.db #0x0f	; 15
      008202 E0                    1884 	.db #0xe0	; 224
      008203 3F                    1885 	.db #0x3f	; 63
      008204 80                    1886 	.db #0x80	; 128
      008205 FE                    1887 	.db #0xfe	; 254
      008206 03                    1888 	.db #0x03	; 3
      008207 F8                    1889 	.db #0xf8	; 248
      008208 FE                    1890 	.db #0xfe	; 254
      008209 7C                    1891 	.db #0x7c	; 124
      00820A 7E                    1892 	.db #0x7e	; 126
      00820B 00                    1893 	.db #0x00	; 0
      00820C 01                    1894 	.db #0x01	; 1
      00820D 80                    1895 	.db #0x80	; 128
      00820E FE                    1896 	.db #0xfe	; 254
      00820F 03                    1897 	.db #0x03	; 3
      008210 F8                    1898 	.db #0xf8	; 248
      008211 0F                    1899 	.db #0x0f	; 15
      008212 E0                    1900 	.db #0xe0	; 224
      008213 3F                    1901 	.db #0x3f	; 63
      008214 80                    1902 	.db #0x80	; 128
      008215 FE                    1903 	.db #0xfe	; 254
      008216 03                    1904 	.db #0x03	; 3
      008217 F8                    1905 	.db #0xf8	; 248
      008218 38                    1906 	.db #0x38	; 56	'8'
      008219 7E                    1907 	.db #0x7e	; 126
      00821A 7E                    1908 	.db #0x7e	; 126
      00821B 00                    1909 	.db #0x00	; 0
      00821C 01                    1910 	.db #0x01	; 1
      00821D 80                    1911 	.db #0x80	; 128
      00821E FE                    1912 	.db #0xfe	; 254
      00821F 03                    1913 	.db #0x03	; 3
      008220 F8                    1914 	.db #0xf8	; 248
      008221 0F                    1915 	.db #0x0f	; 15
      008222 E0                    1916 	.db #0xe0	; 224
      008223 3F                    1917 	.db #0x3f	; 63
      008224 80                    1918 	.db #0x80	; 128
      008225 FE                    1919 	.db #0xfe	; 254
      008226 03                    1920 	.db #0x03	; 3
      008227 F8                    1921 	.db #0xf8	; 248
      008228 38                    1922 	.db #0x38	; 56	'8'
      008229 66                    1923 	.db #0x66	; 102	'f'
      00822A 60                    1924 	.db #0x60	; 96
      00822B 00                    1925 	.db #0x00	; 0
      00822C 01                    1926 	.db #0x01	; 1
      00822D 80                    1927 	.db #0x80	; 128
      00822E FE                    1928 	.db #0xfe	; 254
      00822F 03                    1929 	.db #0x03	; 3
      008230 F8                    1930 	.db #0xf8	; 248
      008231 0F                    1931 	.db #0x0f	; 15
      008232 E0                    1932 	.db #0xe0	; 224
      008233 3F                    1933 	.db #0x3f	; 63
      008234 80                    1934 	.db #0x80	; 128
      008235 FE                    1935 	.db #0xfe	; 254
      008236 03                    1936 	.db #0x03	; 3
      008237 F8                    1937 	.db #0xf8	; 248
      008238 38                    1938 	.db #0x38	; 56	'8'
      008239 66                    1939 	.db #0x66	; 102	'f'
      00823A 60                    1940 	.db #0x60	; 96
      00823B 00                    1941 	.db #0x00	; 0
      00823C 01                    1942 	.db #0x01	; 1
      00823D 80                    1943 	.db #0x80	; 128
      00823E FE                    1944 	.db #0xfe	; 254
      00823F 03                    1945 	.db #0x03	; 3
      008240 F8                    1946 	.db #0xf8	; 248
      008241 0F                    1947 	.db #0x0f	; 15
      008242 E0                    1948 	.db #0xe0	; 224
      008243 3F                    1949 	.db #0x3f	; 63
      008244 80                    1950 	.db #0x80	; 128
      008245 FE                    1951 	.db #0xfe	; 254
      008246 03                    1952 	.db #0x03	; 3
      008247 F8                    1953 	.db #0xf8	; 248
      008248 FE                    1954 	.db #0xfe	; 254
      008249 66                    1955 	.db #0x66	; 102	'f'
      00824A 7E                    1956 	.db #0x7e	; 126
      00824B 18                    1957 	.db #0x18	; 24
      00824C 01                    1958 	.db #0x01	; 1
      00824D 80                    1959 	.db #0x80	; 128
      00824E FE                    1960 	.db #0xfe	; 254
      00824F 03                    1961 	.db #0x03	; 3
      008250 F8                    1962 	.db #0xf8	; 248
      008251 0F                    1963 	.db #0x0f	; 15
      008252 E0                    1964 	.db #0xe0	; 224
      008253 3F                    1965 	.db #0x3f	; 63
      008254 80                    1966 	.db #0x80	; 128
      008255 FE                    1967 	.db #0xfe	; 254
      008256 03                    1968 	.db #0x03	; 3
      008257 F8                    1969 	.db #0xf8	; 248
      008258 FE                    1970 	.db #0xfe	; 254
      008259 66                    1971 	.db #0x66	; 102	'f'
      00825A 7E                    1972 	.db #0x7e	; 126
      00825B 18                    1973 	.db #0x18	; 24
      00825C 01                    1974 	.db #0x01	; 1
      00825D 80                    1975 	.db #0x80	; 128
      00825E 00                    1976 	.db #0x00	; 0
      00825F 00                    1977 	.db #0x00	; 0
      008260 00                    1978 	.db #0x00	; 0
      008261 00                    1979 	.db #0x00	; 0
      008262 00                    1980 	.db #0x00	; 0
      008263 00                    1981 	.db #0x00	; 0
      008264 00                    1982 	.db #0x00	; 0
      008265 00                    1983 	.db #0x00	; 0
      008266 00                    1984 	.db #0x00	; 0
      008267 00                    1985 	.db #0x00	; 0
      008268 00                    1986 	.db #0x00	; 0
      008269 00                    1987 	.db #0x00	; 0
      00826A 00                    1988 	.db #0x00	; 0
      00826B 00                    1989 	.db #0x00	; 0
      00826C 01                    1990 	.db #0x01	; 1
      00826D FF                    1991 	.db #0xff	; 255
      00826E FF                    1992 	.db #0xff	; 255
      00826F FF                    1993 	.db #0xff	; 255
      008270 FF                    1994 	.db #0xff	; 255
      008271 FF                    1995 	.db #0xff	; 255
      008272 FF                    1996 	.db #0xff	; 255
      008273 FF                    1997 	.db #0xff	; 255
      008274 FF                    1998 	.db #0xff	; 255
      008275 FF                    1999 	.db #0xff	; 255
      008276 FF                    2000 	.db #0xff	; 255
      008277 FF                    2001 	.db #0xff	; 255
      008278 FF                    2002 	.db #0xff	; 255
      008279 FF                    2003 	.db #0xff	; 255
      00827A FF                    2004 	.db #0xff	; 255
      00827B FF                    2005 	.db #0xff	; 255
      00827C FF                    2006 	.db #0xff	; 255
      00827D                       2007 __xinit__I2C_IRQ:
      00827D 00                    2008 	.db #0x00	; 0
                                   2009 	.area CABS (ABS)
