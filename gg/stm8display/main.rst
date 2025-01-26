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
                                     14 	.globl _ssd1306_send_buffer
                                     15 	.globl _ssd1306_buffer_clean
                                     16 	.globl _set_bit
                                     17 	.globl _get_bit
                                     18 	.globl _i2c_irq
                                     19 	.globl _memset
                                     20 	.globl _main_buffer
                                     21 	.globl _ttf_eng_line_down
                                     22 	.globl _ttf_eng_line_up
                                     23 	.globl _ttf_eng_line_left
                                     24 	.globl _ttf_eng_line_right
                                     25 	.globl _ttf_eng_corner_right_down
                                     26 	.globl _ttf_eng_corner_left_down
                                     27 	.globl _ttf_eng_corner_right_up
                                     28 	.globl _ttf_eng_corner_left_up
                                     29 	.globl _ttf_eng_0
                                     30 	.globl _ttf_eng_9
                                     31 	.globl _ttf_eng_8
                                     32 	.globl _ttf_eng_7
                                     33 	.globl _ttf_eng_6
                                     34 	.globl _ttf_eng_5
                                     35 	.globl _ttf_eng_4
                                     36 	.globl _ttf_eng_3
                                     37 	.globl _ttf_eng_2
                                     38 	.globl _ttf_eng_1
                                     39 	.globl _ttf_eng_z
                                     40 	.globl _ttf_eng_y
                                     41 	.globl _ttf_eng_x
                                     42 	.globl _ttf_eng_w
                                     43 	.globl _ttf_eng_v
                                     44 	.globl _ttf_eng_u
                                     45 	.globl _ttf_eng_t
                                     46 	.globl _ttf_eng_s
                                     47 	.globl _ttf_eng_r
                                     48 	.globl _ttf_eng_q
                                     49 	.globl _ttf_eng_p
                                     50 	.globl _ttf_eng_o
                                     51 	.globl _ttf_eng_n
                                     52 	.globl _ttf_eng_m
                                     53 	.globl _ttf_eng_l
                                     54 	.globl _ttf_eng_k
                                     55 	.globl _ttf_eng_j
                                     56 	.globl _ttf_eng_i
                                     57 	.globl _ttf_eng_h
                                     58 	.globl _ttf_eng_g
                                     59 	.globl _ttf_eng_f
                                     60 	.globl _ttf_eng_e
                                     61 	.globl _ttf_eng_d
                                     62 	.globl _ttf_eng_c
                                     63 	.globl _ttf_eng_b
                                     64 	.globl _ttf_eng_a
                                     65 	.globl _I2C_IRQ
                                     66 	.globl _buf_size
                                     67 	.globl _buf_pos
                                     68 	.globl _rx_buf_pointer
                                     69 	.globl _tx_buf_pointer
                                     70 	.globl _uart_transmission_irq
                                     71 	.globl _uart_reciever_irq
                                     72 	.globl _uart_write_irq
                                     73 	.globl _uart_read_irq
                                     74 	.globl _uart_init
                                     75 	.globl _uart_read_byte
                                     76 	.globl _uart_write_byte
                                     77 	.globl _uart_write
                                     78 	.globl _uart_read
                                     79 	.globl _i2c_init
                                     80 	.globl _i2c_start
                                     81 	.globl _i2c_stop
                                     82 	.globl _i2c_send_address
                                     83 	.globl _i2c_read_byte
                                     84 	.globl _i2c_read
                                     85 	.globl _i2c_send_byte
                                     86 	.globl _i2c_write
                                     87 	.globl _i2c_scan
                                     88 	.globl _i2c_start_irq
                                     89 	.globl _i2c_stop_irq
                                     90 	.globl _ssd1306_init
                                     91 	.globl _ssd1306_set_params_to_write
                                     92 	.globl _ssd1306_draw_pixel
                                     93 	.globl _ssd1306_buffer_write
                                     94 	.globl _ssd1306_clean
                                     95 ;--------------------------------------------------------
                                     96 ; ram data
                                     97 ;--------------------------------------------------------
                                     98 	.area DATA
      000001                         99 _tx_buf_pointer::
      000001                        100 	.ds 2
      000003                        101 _rx_buf_pointer::
      000003                        102 	.ds 2
      000005                        103 _buf_pos::
      000005                        104 	.ds 1
      000006                        105 _buf_size::
      000006                        106 	.ds 1
                                    107 ;--------------------------------------------------------
                                    108 ; ram data
                                    109 ;--------------------------------------------------------
                                    110 	.area INITIALIZED
      000007                        111 _I2C_IRQ::
      000007                        112 	.ds 1
      000008                        113 _ttf_eng_a::
      000008                        114 	.ds 8
      000010                        115 _ttf_eng_b::
      000010                        116 	.ds 8
      000018                        117 _ttf_eng_c::
      000018                        118 	.ds 8
      000020                        119 _ttf_eng_d::
      000020                        120 	.ds 8
      000028                        121 _ttf_eng_e::
      000028                        122 	.ds 8
      000030                        123 _ttf_eng_f::
      000030                        124 	.ds 8
      000038                        125 _ttf_eng_g::
      000038                        126 	.ds 8
      000040                        127 _ttf_eng_h::
      000040                        128 	.ds 8
      000048                        129 _ttf_eng_i::
      000048                        130 	.ds 8
      000050                        131 _ttf_eng_j::
      000050                        132 	.ds 8
      000058                        133 _ttf_eng_k::
      000058                        134 	.ds 8
      000060                        135 _ttf_eng_l::
      000060                        136 	.ds 8
      000068                        137 _ttf_eng_m::
      000068                        138 	.ds 8
      000070                        139 _ttf_eng_n::
      000070                        140 	.ds 8
      000078                        141 _ttf_eng_o::
      000078                        142 	.ds 8
      000080                        143 _ttf_eng_p::
      000080                        144 	.ds 8
      000088                        145 _ttf_eng_q::
      000088                        146 	.ds 8
      000090                        147 _ttf_eng_r::
      000090                        148 	.ds 8
      000098                        149 _ttf_eng_s::
      000098                        150 	.ds 8
      0000A0                        151 _ttf_eng_t::
      0000A0                        152 	.ds 8
      0000A8                        153 _ttf_eng_u::
      0000A8                        154 	.ds 8
      0000B0                        155 _ttf_eng_v::
      0000B0                        156 	.ds 8
      0000B8                        157 _ttf_eng_w::
      0000B8                        158 	.ds 8
      0000C0                        159 _ttf_eng_x::
      0000C0                        160 	.ds 8
      0000C8                        161 _ttf_eng_y::
      0000C8                        162 	.ds 8
      0000D0                        163 _ttf_eng_z::
      0000D0                        164 	.ds 8
      0000D8                        165 _ttf_eng_1::
      0000D8                        166 	.ds 8
      0000E0                        167 _ttf_eng_2::
      0000E0                        168 	.ds 8
      0000E8                        169 _ttf_eng_3::
      0000E8                        170 	.ds 8
      0000F0                        171 _ttf_eng_4::
      0000F0                        172 	.ds 8
      0000F8                        173 _ttf_eng_5::
      0000F8                        174 	.ds 8
      000100                        175 _ttf_eng_6::
      000100                        176 	.ds 8
      000108                        177 _ttf_eng_7::
      000108                        178 	.ds 8
      000110                        179 _ttf_eng_8::
      000110                        180 	.ds 8
      000118                        181 _ttf_eng_9::
      000118                        182 	.ds 8
      000120                        183 _ttf_eng_0::
      000120                        184 	.ds 8
      000128                        185 _ttf_eng_corner_left_up::
      000128                        186 	.ds 8
      000130                        187 _ttf_eng_corner_right_up::
      000130                        188 	.ds 8
      000138                        189 _ttf_eng_corner_left_down::
      000138                        190 	.ds 8
      000140                        191 _ttf_eng_corner_right_down::
      000140                        192 	.ds 8
      000148                        193 _ttf_eng_line_right::
      000148                        194 	.ds 8
      000150                        195 _ttf_eng_line_left::
      000150                        196 	.ds 8
      000158                        197 _ttf_eng_line_up::
      000158                        198 	.ds 8
      000160                        199 _ttf_eng_line_down::
      000160                        200 	.ds 8
      000168                        201 _main_buffer::
      000168                        202 	.ds 512
                                    203 ;--------------------------------------------------------
                                    204 ; Stack segment in internal ram
                                    205 ;--------------------------------------------------------
                                    206 	.area SSEG
      000368                        207 __start__stack:
      000368                        208 	.ds	1
                                    209 
                                    210 ;--------------------------------------------------------
                                    211 ; absolute external ram data
                                    212 ;--------------------------------------------------------
                                    213 	.area DABS (ABS)
                                    214 
                                    215 ; default segment ordering for linker
                                    216 	.area HOME
                                    217 	.area GSINIT
                                    218 	.area GSFINAL
                                    219 	.area CONST
                                    220 	.area INITIALIZER
                                    221 	.area CODE
                                    222 
                                    223 ;--------------------------------------------------------
                                    224 ; interrupt vector
                                    225 ;--------------------------------------------------------
                                    226 	.area HOME
      008000                        227 __interrupt_vect:
      008000 82 00 80 5B            228 	int s_GSINIT ; reset
      008004 82 00 00 00            229 	int 0x000000 ; trap
      008008 82 00 00 00            230 	int 0x000000 ; int0
      00800C 82 00 00 00            231 	int 0x000000 ; int1
      008010 82 00 00 00            232 	int 0x000000 ; int2
      008014 82 00 00 00            233 	int 0x000000 ; int3
      008018 82 00 00 00            234 	int 0x000000 ; int4
      00801C 82 00 00 00            235 	int 0x000000 ; int5
      008020 82 00 00 00            236 	int 0x000000 ; int6
      008024 82 00 00 00            237 	int 0x000000 ; int7
      008028 82 00 00 00            238 	int 0x000000 ; int8
      00802C 82 00 00 00            239 	int 0x000000 ; int9
      008030 82 00 00 00            240 	int 0x000000 ; int10
      008034 82 00 00 00            241 	int 0x000000 ; int11
      008038 82 00 00 00            242 	int 0x000000 ; int12
      00803C 82 00 00 00            243 	int 0x000000 ; int13
      008040 82 00 00 00            244 	int 0x000000 ; int14
      008044 82 00 00 00            245 	int 0x000000 ; int15
      008048 82 00 00 00            246 	int 0x000000 ; int16
      00804C 82 00 83 E2            247 	int _uart_transmission_irq ; int17
      008050 82 00 84 1E            248 	int _uart_reciever_irq ; int18
      008054 82 00 86 00            249 	int _i2c_irq ; int19
                                    250 ;--------------------------------------------------------
                                    251 ; global & static initialisations
                                    252 ;--------------------------------------------------------
                                    253 	.area HOME
                                    254 	.area GSINIT
                                    255 	.area GSFINAL
                                    256 	.area GSINIT
      00805B CD 8A 71         [ 4]  257 	call	___sdcc_external_startup
      00805E 4D               [ 1]  258 	tnz	a
      00805F 27 03            [ 1]  259 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  260 	jp	__sdcc_program_startup
      008064                        261 __sdcc_init_data:
                                    262 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  263 	ldw x, #l_DATA
      008067 27 07            [ 1]  264 	jreq	00002$
      008069                        265 00001$:
      008069 72 4F 00 00      [ 1]  266 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  267 	decw x
      00806E 26 F9            [ 1]  268 	jrne	00001$
      008070                        269 00002$:
      008070 AE 03 61         [ 2]  270 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  271 	jreq	00004$
      008075                        272 00003$:
      008075 D6 80 80         [ 1]  273 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  274 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  275 	decw	x
      00807C 26 F7            [ 1]  276 	jrne	00003$
      00807E                        277 00004$:
                                    278 ; stm8_genXINIT() end
                                    279 	.area GSFINAL
      00807E CC 80 58         [ 2]  280 	jp	__sdcc_program_startup
                                    281 ;--------------------------------------------------------
                                    282 ; Home
                                    283 ;--------------------------------------------------------
                                    284 	.area HOME
                                    285 	.area HOME
      008058                        286 __sdcc_program_startup:
      008058 CC 8A 46         [ 2]  287 	jp	_main
                                    288 ;	return from main will return to caller
                                    289 ;--------------------------------------------------------
                                    290 ; code
                                    291 ;--------------------------------------------------------
                                    292 	.area CODE
                                    293 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    294 ;	-----------------------------------------
                                    295 ;	 function uart_transmission_irq
                                    296 ;	-----------------------------------------
      0083E2                        297 _uart_transmission_irq:
                                    298 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0083E2 AE 52 30         [ 2]  299 	ldw	x, #0x5230
      0083E5 F6               [ 1]  300 	ld	a, (x)
      0083E6 4E               [ 1]  301 	swap	a
      0083E7 44               [ 1]  302 	srl	a
      0083E8 44               [ 1]  303 	srl	a
      0083E9 44               [ 1]  304 	srl	a
      0083EA A5 01            [ 1]  305 	bcp	a, #0x01
      0083EC 27 2F            [ 1]  306 	jreq	00107$
                                    307 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0083EE C6 00 02         [ 1]  308 	ld	a, _tx_buf_pointer+1
      0083F1 CB 00 05         [ 1]  309 	add	a, _buf_pos+0
      0083F4 97               [ 1]  310 	ld	xl, a
      0083F5 C6 00 01         [ 1]  311 	ld	a, _tx_buf_pointer+0
      0083F8 A9 00            [ 1]  312 	adc	a, #0x00
      0083FA 95               [ 1]  313 	ld	xh, a
      0083FB F6               [ 1]  314 	ld	a, (x)
      0083FC 27 1B            [ 1]  315 	jreq	00102$
      0083FE C6 00 05         [ 1]  316 	ld	a, _buf_pos+0
      008401 C1 00 06         [ 1]  317 	cp	a, _buf_size+0
      008404 24 13            [ 1]  318 	jrnc	00102$
                                    319 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      008406 C6 00 05         [ 1]  320 	ld	a, _buf_pos+0
      008409 72 5C 00 05      [ 1]  321 	inc	_buf_pos+0
      00840D 5F               [ 1]  322 	clrw	x
      00840E 97               [ 1]  323 	ld	xl, a
      00840F 72 BB 00 01      [ 2]  324 	addw	x, _tx_buf_pointer+0
      008413 F6               [ 1]  325 	ld	a, (x)
      008414 C7 52 31         [ 1]  326 	ld	0x5231, a
      008417 20 04            [ 2]  327 	jra	00107$
      008419                        328 00102$:
                                    329 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      008419 72 1F 52 35      [ 1]  330 	bres	0x5235, #7
      00841D                        331 00107$:
                                    332 ;	./libs/uart_lib.c: 14: }
      00841D 80               [11]  333 	iret
                                    334 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    335 ;	-----------------------------------------
                                    336 ;	 function uart_reciever_irq
                                    337 ;	-----------------------------------------
      00841E                        338 _uart_reciever_irq:
      00841E 88               [ 1]  339 	push	a
                                    340 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      00841F C6 52 30         [ 1]  341 	ld	a, 0x5230
      008422 4E               [ 1]  342 	swap	a
      008423 44               [ 1]  343 	srl	a
      008424 A5 01            [ 1]  344 	bcp	a, #0x01
      008426 27 27            [ 1]  345 	jreq	00107$
                                    346 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      008428 C6 52 31         [ 1]  347 	ld	a, 0x5231
                                    348 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      00842B 6B 01            [ 1]  349 	ld	(0x01, sp), a
      00842D A1 0A            [ 1]  350 	cp	a, #0x0a
      00842F 27 1A            [ 1]  351 	jreq	00102$
      008431 C6 00 05         [ 1]  352 	ld	a, _buf_pos+0
      008434 C1 00 06         [ 1]  353 	cp	a, _buf_size+0
      008437 24 12            [ 1]  354 	jrnc	00102$
                                    355 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      008439 C6 00 05         [ 1]  356 	ld	a, _buf_pos+0
      00843C 72 5C 00 05      [ 1]  357 	inc	_buf_pos+0
      008440 5F               [ 1]  358 	clrw	x
      008441 97               [ 1]  359 	ld	xl, a
      008442 72 BB 00 03      [ 2]  360 	addw	x, _rx_buf_pointer+0
      008446 7B 01            [ 1]  361 	ld	a, (0x01, sp)
      008448 F7               [ 1]  362 	ld	(x), a
      008449 20 04            [ 2]  363 	jra	00107$
      00844B                        364 00102$:
                                    365 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      00844B 72 1B 52 35      [ 1]  366 	bres	0x5235, #5
      00844F                        367 00107$:
                                    368 ;	./libs/uart_lib.c: 30: }
      00844F 84               [ 1]  369 	pop	a
      008450 80               [11]  370 	iret
                                    371 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    372 ;	-----------------------------------------
                                    373 ;	 function uart_write_irq
                                    374 ;	-----------------------------------------
      008451                        375 _uart_write_irq:
      008451 52 02            [ 2]  376 	sub	sp, #2
                                    377 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      008453 1F 01            [ 2]  378 	ldw	(0x01, sp), x
      008455 CF 00 01         [ 2]  379 	ldw	_tx_buf_pointer+0, x
                                    380 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      008458 72 5F 00 05      [ 1]  381 	clr	_buf_pos+0
                                    382 ;	./libs/uart_lib.c: 36: buf_size = 0;
      00845C 72 5F 00 06      [ 1]  383 	clr	_buf_size+0
                                    384 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      008460                        385 00101$:
      008460 C6 00 06         [ 1]  386 	ld	a, _buf_size+0
      008463 72 5C 00 06      [ 1]  387 	inc	_buf_size+0
      008467 5F               [ 1]  388 	clrw	x
      008468 97               [ 1]  389 	ld	xl, a
      008469 72 FB 01         [ 2]  390 	addw	x, (0x01, sp)
      00846C F6               [ 1]  391 	ld	a, (x)
      00846D 26 F1            [ 1]  392 	jrne	00101$
                                    393 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      00846F 72 1E 52 35      [ 1]  394 	bset	0x5235, #7
                                    395 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      008473                        396 00104$:
      008473 72 0E 52 35 FB   [ 2]  397 	btjt	0x5235, #7, 00104$
                                    398 ;	./libs/uart_lib.c: 40: }
      008478 5B 02            [ 2]  399 	addw	sp, #2
      00847A 81               [ 4]  400 	ret
                                    401 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    402 ;	-----------------------------------------
                                    403 ;	 function uart_read_irq
                                    404 ;	-----------------------------------------
      00847B                        405 _uart_read_irq:
                                    406 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      00847B CF 00 03         [ 2]  407 	ldw	_rx_buf_pointer+0, x
                                    408 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      00847E 72 5F 00 05      [ 1]  409 	clr	_buf_pos+0
                                    410 ;	./libs/uart_lib.c: 45: buf_size = size;
      008482 7B 04            [ 1]  411 	ld	a, (0x04, sp)
      008484 C7 00 06         [ 1]  412 	ld	_buf_size+0, a
                                    413 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      008487 72 1A 52 35      [ 1]  414 	bset	0x5235, #5
                                    415 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      00848B                        416 00101$:
      00848B C6 52 35         [ 1]  417 	ld	a, 0x5235
      00848E 4E               [ 1]  418 	swap	a
      00848F 44               [ 1]  419 	srl	a
      008490 A4 01            [ 1]  420 	and	a, #0x01
      008492 26 F7            [ 1]  421 	jrne	00101$
                                    422 ;	./libs/uart_lib.c: 48: }
      008494 1E 01            [ 2]  423 	ldw	x, (1, sp)
      008496 5B 04            [ 2]  424 	addw	sp, #4
      008498 FC               [ 2]  425 	jp	(x)
                                    426 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    427 ;	-----------------------------------------
                                    428 ;	 function uart_init
                                    429 ;	-----------------------------------------
      008499                        430 _uart_init:
      008499 52 02            [ 2]  431 	sub	sp, #2
      00849B 1F 01            [ 2]  432 	ldw	(0x01, sp), x
                                    433 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      00849D AE 52 35         [ 2]  434 	ldw	x, #0x5235
      0084A0 88               [ 1]  435 	push	a
      0084A1 F6               [ 1]  436 	ld	a, (x)
      0084A2 AA 08            [ 1]  437 	or	a, #0x08
      0084A4 F7               [ 1]  438 	ld	(x), a
      0084A5 84               [ 1]  439 	pop	a
                                    440 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      0084A6 AE 52 35         [ 2]  441 	ldw	x, #0x5235
      0084A9 88               [ 1]  442 	push	a
      0084AA F6               [ 1]  443 	ld	a, (x)
      0084AB AA 04            [ 1]  444 	or	a, #0x04
      0084AD F7               [ 1]  445 	ld	(x), a
      0084AE 84               [ 1]  446 	pop	a
                                    447 ;	./libs/uart_lib.c: 56: switch(stopbit)
      0084AF A1 02            [ 1]  448 	cp	a, #0x02
      0084B1 27 06            [ 1]  449 	jreq	00101$
      0084B3 A1 03            [ 1]  450 	cp	a, #0x03
      0084B5 27 0E            [ 1]  451 	jreq	00102$
      0084B7 20 16            [ 2]  452 	jra	00103$
                                    453 ;	./libs/uart_lib.c: 58: case 2:
      0084B9                        454 00101$:
                                    455 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      0084B9 C6 52 36         [ 1]  456 	ld	a, 0x5236
      0084BC A4 CF            [ 1]  457 	and	a, #0xcf
      0084BE AA 20            [ 1]  458 	or	a, #0x20
      0084C0 C7 52 36         [ 1]  459 	ld	0x5236, a
                                    460 ;	./libs/uart_lib.c: 60: break;
      0084C3 20 12            [ 2]  461 	jra	00104$
                                    462 ;	./libs/uart_lib.c: 61: case 3:
      0084C5                        463 00102$:
                                    464 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      0084C5 C6 52 36         [ 1]  465 	ld	a, 0x5236
      0084C8 AA 30            [ 1]  466 	or	a, #0x30
      0084CA C7 52 36         [ 1]  467 	ld	0x5236, a
                                    468 ;	./libs/uart_lib.c: 63: break;
      0084CD 20 08            [ 2]  469 	jra	00104$
                                    470 ;	./libs/uart_lib.c: 64: default:
      0084CF                        471 00103$:
                                    472 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      0084CF C6 52 36         [ 1]  473 	ld	a, 0x5236
      0084D2 A4 CF            [ 1]  474 	and	a, #0xcf
      0084D4 C7 52 36         [ 1]  475 	ld	0x5236, a
                                    476 ;	./libs/uart_lib.c: 67: }
      0084D7                        477 00104$:
                                    478 ;	./libs/uart_lib.c: 68: switch(baudrate)
      0084D7 1E 01            [ 2]  479 	ldw	x, (0x01, sp)
      0084D9 A3 08 00         [ 2]  480 	cpw	x, #0x0800
      0084DC 26 03            [ 1]  481 	jrne	00186$
      0084DE CC 85 6A         [ 2]  482 	jp	00110$
      0084E1                        483 00186$:
      0084E1 1E 01            [ 2]  484 	ldw	x, (0x01, sp)
      0084E3 A3 09 60         [ 2]  485 	cpw	x, #0x0960
      0084E6 27 28            [ 1]  486 	jreq	00105$
      0084E8 1E 01            [ 2]  487 	ldw	x, (0x01, sp)
      0084EA A3 10 00         [ 2]  488 	cpw	x, #0x1000
      0084ED 26 03            [ 1]  489 	jrne	00192$
      0084EF CC 85 7A         [ 2]  490 	jp	00111$
      0084F2                        491 00192$:
      0084F2 1E 01            [ 2]  492 	ldw	x, (0x01, sp)
      0084F4 A3 4B 00         [ 2]  493 	cpw	x, #0x4b00
      0084F7 27 31            [ 1]  494 	jreq	00106$
      0084F9 1E 01            [ 2]  495 	ldw	x, (0x01, sp)
      0084FB A3 84 00         [ 2]  496 	cpw	x, #0x8400
      0084FE 27 5A            [ 1]  497 	jreq	00109$
      008500 1E 01            [ 2]  498 	ldw	x, (0x01, sp)
      008502 A3 C2 00         [ 2]  499 	cpw	x, #0xc200
      008505 27 43            [ 1]  500 	jreq	00108$
      008507 1E 01            [ 2]  501 	ldw	x, (0x01, sp)
      008509 A3 E1 00         [ 2]  502 	cpw	x, #0xe100
      00850C 27 2C            [ 1]  503 	jreq	00107$
      00850E 20 7A            [ 2]  504 	jra	00112$
                                    505 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      008510                        506 00105$:
                                    507 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      008510 C6 52 33         [ 1]  508 	ld	a, 0x5233
      008513 A4 0F            [ 1]  509 	and	a, #0x0f
      008515 AA 10            [ 1]  510 	or	a, #0x10
      008517 C7 52 33         [ 1]  511 	ld	0x5233, a
                                    512 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      00851A 35 A0 52 32      [ 1]  513 	mov	0x5232+0, #0xa0
                                    514 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      00851E C6 52 33         [ 1]  515 	ld	a, 0x5233
      008521 A4 F0            [ 1]  516 	and	a, #0xf0
      008523 AA 0B            [ 1]  517 	or	a, #0x0b
      008525 C7 52 33         [ 1]  518 	ld	0x5233, a
                                    519 ;	./libs/uart_lib.c: 74: break;
      008528 20 6E            [ 2]  520 	jra	00114$
                                    521 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      00852A                        522 00106$:
                                    523 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      00852A 35 34 52 32      [ 1]  524 	mov	0x5232+0, #0x34
                                    525 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      00852E C6 52 33         [ 1]  526 	ld	a, 0x5233
      008531 A4 F0            [ 1]  527 	and	a, #0xf0
      008533 AA 01            [ 1]  528 	or	a, #0x01
      008535 C7 52 33         [ 1]  529 	ld	0x5233, a
                                    530 ;	./libs/uart_lib.c: 78: break;
      008538 20 5E            [ 2]  531 	jra	00114$
                                    532 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      00853A                        533 00107$:
                                    534 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      00853A 35 11 52 32      [ 1]  535 	mov	0x5232+0, #0x11
                                    536 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      00853E C6 52 33         [ 1]  537 	ld	a, 0x5233
      008541 A4 F0            [ 1]  538 	and	a, #0xf0
      008543 AA 06            [ 1]  539 	or	a, #0x06
      008545 C7 52 33         [ 1]  540 	ld	0x5233, a
                                    541 ;	./libs/uart_lib.c: 82: break;
      008548 20 4E            [ 2]  542 	jra	00114$
                                    543 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      00854A                        544 00108$:
                                    545 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      00854A 35 08 52 32      [ 1]  546 	mov	0x5232+0, #0x08
                                    547 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      00854E C6 52 33         [ 1]  548 	ld	a, 0x5233
      008551 A4 F0            [ 1]  549 	and	a, #0xf0
      008553 AA 0B            [ 1]  550 	or	a, #0x0b
      008555 C7 52 33         [ 1]  551 	ld	0x5233, a
                                    552 ;	./libs/uart_lib.c: 86: break;
      008558 20 3E            [ 2]  553 	jra	00114$
                                    554 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      00855A                        555 00109$:
                                    556 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      00855A 35 04 52 32      [ 1]  557 	mov	0x5232+0, #0x04
                                    558 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      00855E C6 52 33         [ 1]  559 	ld	a, 0x5233
      008561 A4 F0            [ 1]  560 	and	a, #0xf0
      008563 AA 05            [ 1]  561 	or	a, #0x05
      008565 C7 52 33         [ 1]  562 	ld	0x5233, a
                                    563 ;	./libs/uart_lib.c: 90: break;
      008568 20 2E            [ 2]  564 	jra	00114$
                                    565 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      00856A                        566 00110$:
                                    567 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      00856A 35 02 52 32      [ 1]  568 	mov	0x5232+0, #0x02
                                    569 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      00856E C6 52 33         [ 1]  570 	ld	a, 0x5233
      008571 A4 F0            [ 1]  571 	and	a, #0xf0
      008573 AA 03            [ 1]  572 	or	a, #0x03
      008575 C7 52 33         [ 1]  573 	ld	0x5233, a
                                    574 ;	./libs/uart_lib.c: 94: break;
      008578 20 1E            [ 2]  575 	jra	00114$
                                    576 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      00857A                        577 00111$:
                                    578 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      00857A 35 01 52 32      [ 1]  579 	mov	0x5232+0, #0x01
                                    580 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      00857E C6 52 33         [ 1]  581 	ld	a, 0x5233
      008581 A4 F0            [ 1]  582 	and	a, #0xf0
      008583 AA 01            [ 1]  583 	or	a, #0x01
      008585 C7 52 33         [ 1]  584 	ld	0x5233, a
                                    585 ;	./libs/uart_lib.c: 98: break;
      008588 20 0E            [ 2]  586 	jra	00114$
                                    587 ;	./libs/uart_lib.c: 99: default:
      00858A                        588 00112$:
                                    589 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      00858A 35 68 52 32      [ 1]  590 	mov	0x5232+0, #0x68
                                    591 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      00858E C6 52 33         [ 1]  592 	ld	a, 0x5233
      008591 A4 F0            [ 1]  593 	and	a, #0xf0
      008593 AA 03            [ 1]  594 	or	a, #0x03
      008595 C7 52 33         [ 1]  595 	ld	0x5233, a
                                    596 ;	./libs/uart_lib.c: 103: }
      008598                        597 00114$:
                                    598 ;	./libs/uart_lib.c: 104: }
      008598 5B 02            [ 2]  599 	addw	sp, #2
      00859A 81               [ 4]  600 	ret
                                    601 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    602 ;	-----------------------------------------
                                    603 ;	 function uart_read_byte
                                    604 ;	-----------------------------------------
      00859B                        605 _uart_read_byte:
                                    606 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      00859B                        607 00101$:
      00859B 72 0B 52 30 FB   [ 2]  608 	btjf	0x5230, #5, 00101$
                                    609 ;	./libs/uart_lib.c: 110: return 1;
      0085A0 5F               [ 1]  610 	clrw	x
      0085A1 5C               [ 1]  611 	incw	x
                                    612 ;	./libs/uart_lib.c: 111: }
      0085A2 81               [ 4]  613 	ret
                                    614 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    615 ;	-----------------------------------------
                                    616 ;	 function uart_write_byte
                                    617 ;	-----------------------------------------
      0085A3                        618 _uart_write_byte:
                                    619 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      0085A3 C7 52 31         [ 1]  620 	ld	0x5231, a
                                    621 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      0085A6                        622 00101$:
      0085A6 72 0F 52 30 FB   [ 2]  623 	btjf	0x5230, #7, 00101$
                                    624 ;	./libs/uart_lib.c: 117: return 1;
      0085AB 5F               [ 1]  625 	clrw	x
      0085AC 5C               [ 1]  626 	incw	x
                                    627 ;	./libs/uart_lib.c: 118: }
      0085AD 81               [ 4]  628 	ret
                                    629 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    630 ;	-----------------------------------------
                                    631 ;	 function uart_write
                                    632 ;	-----------------------------------------
      0085AE                        633 _uart_write:
      0085AE 52 04            [ 2]  634 	sub	sp, #4
      0085B0 1F 01            [ 2]  635 	ldw	(0x01, sp), x
                                    636 ;	./libs/uart_lib.c: 122: int count = 0;
      0085B2 5F               [ 1]  637 	clrw	x
      0085B3 1F 03            [ 2]  638 	ldw	(0x03, sp), x
                                    639 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085B5 5F               [ 1]  640 	clrw	x
      0085B6                        641 00103$:
      0085B6 90 93            [ 1]  642 	ldw	y, x
      0085B8 72 F9 01         [ 2]  643 	addw	y, (0x01, sp)
      0085BB 90 F6            [ 1]  644 	ld	a, (y)
      0085BD 27 0E            [ 1]  645 	jreq	00101$
                                    646 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      0085BF 89               [ 2]  647 	pushw	x
      0085C0 CD 85 A3         [ 4]  648 	call	_uart_write_byte
      0085C3 51               [ 1]  649 	exgw	x, y
      0085C4 85               [ 2]  650 	popw	x
      0085C5 72 F9 03         [ 2]  651 	addw	y, (0x03, sp)
      0085C8 17 03            [ 2]  652 	ldw	(0x03, sp), y
                                    653 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085CA 5C               [ 1]  654 	incw	x
      0085CB 20 E9            [ 2]  655 	jra	00103$
      0085CD                        656 00101$:
                                    657 ;	./libs/uart_lib.c: 125: return count;
      0085CD 1E 03            [ 2]  658 	ldw	x, (0x03, sp)
                                    659 ;	./libs/uart_lib.c: 126: }
      0085CF 5B 04            [ 2]  660 	addw	sp, #4
      0085D1 81               [ 4]  661 	ret
                                    662 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    663 ;	-----------------------------------------
                                    664 ;	 function uart_read
                                    665 ;	-----------------------------------------
      0085D2                        666 _uart_read:
      0085D2 52 04            [ 2]  667 	sub	sp, #4
      0085D4 1F 01            [ 2]  668 	ldw	(0x01, sp), x
                                    669 ;	./libs/uart_lib.c: 130: int count = 0;
      0085D6 5F               [ 1]  670 	clrw	x
      0085D7 1F 03            [ 2]  671 	ldw	(0x03, sp), x
                                    672 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085D9 5F               [ 1]  673 	clrw	x
      0085DA                        674 00103$:
      0085DA 90 93            [ 1]  675 	ldw	y, x
      0085DC 72 F9 01         [ 2]  676 	addw	y, (0x01, sp)
      0085DF 90 F6            [ 1]  677 	ld	a, (y)
      0085E1 27 13            [ 1]  678 	jreq	00101$
                                    679 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      0085E3 90 5F            [ 1]  680 	clrw	y
      0085E5 90 97            [ 1]  681 	ld	yl, a
      0085E7 89               [ 2]  682 	pushw	x
      0085E8 93               [ 1]  683 	ldw	x, y
      0085E9 CD 85 9B         [ 4]  684 	call	_uart_read_byte
      0085EC 51               [ 1]  685 	exgw	x, y
      0085ED 85               [ 2]  686 	popw	x
      0085EE 72 F9 03         [ 2]  687 	addw	y, (0x03, sp)
      0085F1 17 03            [ 2]  688 	ldw	(0x03, sp), y
                                    689 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085F3 5C               [ 1]  690 	incw	x
      0085F4 20 E4            [ 2]  691 	jra	00103$
      0085F6                        692 00101$:
                                    693 ;	./libs/uart_lib.c: 133: return count;
      0085F6 1E 03            [ 2]  694 	ldw	x, (0x03, sp)
                                    695 ;	./libs/uart_lib.c: 134: }
      0085F8 5B 04            [ 2]  696 	addw	sp, #4
      0085FA 90 85            [ 2]  697 	popw	y
      0085FC 5B 02            [ 2]  698 	addw	sp, #2
      0085FE 90 FC            [ 2]  699 	jp	(y)
                                    700 ;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    701 ;	-----------------------------------------
                                    702 ;	 function i2c_irq
                                    703 ;	-----------------------------------------
      008600                        704 _i2c_irq:
      008600 4F               [ 1]  705 	clr	a
      008601 62               [ 2]  706 	div	x, a
                                    707 ;	./libs/i2c_lib.c: 6: disableInterrupts();
      008602 9B               [ 1]  708 	sim
                                    709 ;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
      008603 35 00 00 07      [ 1]  710 	mov	_I2C_IRQ+0, #0x00
                                    711 ;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
      008607 AE 52 17         [ 2]  712 	ldw	x, #0x5217
      00860A F6               [ 1]  713 	ld	a, (x)
      00860B 44               [ 1]  714 	srl	a
      00860C A4 01            [ 1]  715 	and	a, #0x01
      00860E 27 16            [ 1]  716 	jreq	00102$
                                    717 ;	./libs/i2c_lib.c: 11: clr_sr1();
      008610 C6 52 17         [ 1]  718 	ld	a,0x5217
                                    719 ;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
      008613 72 12 00 07      [ 1]  720 	bset	_I2C_IRQ+0, #1
                                    721 ;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
      008617 C6 52 19         [ 1]  722 	ld	a,0x5219
                                    723 ;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
      00861A 72 13 52 1A      [ 1]  724 	bres	0x521a, #1
                                    725 ;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
      00861E A6 E1            [ 1]  726 	ld	a, #0xe1
      008620 CD 85 A3         [ 4]  727 	call	_uart_write_byte
                                    728 ;	./libs/i2c_lib.c: 16: return;
      008623 CC 86 B9         [ 2]  729 	jp	00113$
      008626                        730 00102$:
                                    731 ;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      008626 C6 52 17         [ 1]  732 	ld	a, 0x5217
      008629 4E               [ 1]  733 	swap	a
      00862A 44               [ 1]  734 	srl	a
      00862B 44               [ 1]  735 	srl	a
      00862C 44               [ 1]  736 	srl	a
      00862D A5 01            [ 1]  737 	bcp	a, #0x01
      00862F 27 17            [ 1]  738 	jreq	00104$
                                    739 ;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
      008631 72 18 00 07      [ 1]  740 	bset	_I2C_IRQ+0, #4
                                    741 ;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
      008635 72 15 52 1A      [ 1]  742 	bres	0x521a, #2
                                    743 ;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
      008639 72 13 52 1A      [ 1]  744 	bres	0x521a, #1
                                    745 ;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
      00863D 72 11 52 1A      [ 1]  746 	bres	0x521a, #0
                                    747 ;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
      008641 A6 EA            [ 1]  748 	ld	a, #0xea
      008643 CD 85 A3         [ 4]  749 	call	_uart_write_byte
                                    750 ;	./libs/i2c_lib.c: 26: return;
      008646 20 71            [ 2]  751 	jra	00113$
      008648                        752 00104$:
                                    753 ;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      008648 C6 52 17         [ 1]  754 	ld	a, 0x5217
      00864B 4E               [ 1]  755 	swap	a
      00864C 44               [ 1]  756 	srl	a
      00864D 44               [ 1]  757 	srl	a
      00864E A5 01            [ 1]  758 	bcp	a, #0x01
      008650 27 17            [ 1]  759 	jreq	00106$
                                    760 ;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
      008652 72 16 00 07      [ 1]  761 	bset	_I2C_IRQ+0, #3
                                    762 ;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
      008656 72 15 52 1A      [ 1]  763 	bres	0x521a, #2
                                    764 ;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
      00865A 72 13 52 1A      [ 1]  765 	bres	0x521a, #1
                                    766 ;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
      00865E 72 11 52 1A      [ 1]  767 	bres	0x521a, #0
                                    768 ;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
      008662 A6 EB            [ 1]  769 	ld	a, #0xeb
      008664 CD 85 A3         [ 4]  770 	call	_uart_write_byte
                                    771 ;	./libs/i2c_lib.c: 35: return;
      008667 20 50            [ 2]  772 	jra	00113$
      008669                        773 00106$:
                                    774 ;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      008669 C6 52 17         [ 1]  775 	ld	a, 0x5217
      00866C A5 01            [ 1]  776 	bcp	a, #0x01
      00866E 27 0F            [ 1]  777 	jreq	00108$
                                    778 ;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
      008670 72 10 00 07      [ 1]  779 	bset	_I2C_IRQ+0, #0
                                    780 ;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
      008674 72 13 52 1A      [ 1]  781 	bres	0x521a, #1
                                    782 ;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
      008678 A6 E2            [ 1]  783 	ld	a, #0xe2
      00867A CD 85 A3         [ 4]  784 	call	_uart_write_byte
                                    785 ;	./libs/i2c_lib.c: 43: return;
      00867D 20 3A            [ 2]  786 	jra	00113$
      00867F                        787 00108$:
                                    788 ;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
      00867F C6 52 17         [ 1]  789 	ld	a, 0x5217
      008682 44               [ 1]  790 	srl	a
      008683 44               [ 1]  791 	srl	a
      008684 A5 01            [ 1]  792 	bcp	a, #0x01
      008686 27 0F            [ 1]  793 	jreq	00110$
                                    794 ;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
      008688 72 14 00 07      [ 1]  795 	bset	_I2C_IRQ+0, #2
                                    796 ;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
      00868C 72 13 52 1A      [ 1]  797 	bres	0x521a, #1
                                    798 ;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
      008690 A6 E3            [ 1]  799 	ld	a, #0xe3
      008692 CD 85 A3         [ 4]  800 	call	_uart_write_byte
                                    801 ;	./libs/i2c_lib.c: 50: return;
      008695 20 22            [ 2]  802 	jra	00113$
      008697                        803 00110$:
                                    804 ;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      008697 AE 52 18         [ 2]  805 	ldw	x, #0x5218
      00869A F6               [ 1]  806 	ld	a, (x)
      00869B 44               [ 1]  807 	srl	a
      00869C 44               [ 1]  808 	srl	a
      00869D A4 01            [ 1]  809 	and	a, #0x01
      00869F 27 17            [ 1]  810 	jreq	00112$
                                    811 ;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
      0086A1 72 1A 00 07      [ 1]  812 	bset	_I2C_IRQ+0, #5
                                    813 ;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
      0086A5 72 13 52 1A      [ 1]  814 	bres	0x521a, #1
                                    815 ;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
      0086A9 72 11 52 1A      [ 1]  816 	bres	0x521a, #0
                                    817 ;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
      0086AD 72 15 52 1A      [ 1]  818 	bres	0x521a, #2
                                    819 ;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
      0086B1 A6 EE            [ 1]  820 	ld	a, #0xee
      0086B3 CD 85 A3         [ 4]  821 	call	_uart_write_byte
                                    822 ;	./libs/i2c_lib.c: 60: return;
      0086B6 20 01            [ 2]  823 	jra	00113$
      0086B8                        824 00112$:
                                    825 ;	./libs/i2c_lib.c: 63: enableInterrupts(); 
      0086B8 9A               [ 1]  826 	rim
      0086B9                        827 00113$:
                                    828 ;	./libs/i2c_lib.c: 64: }
      0086B9 80               [11]  829 	iret
                                    830 ;	./libs/i2c_lib.c: 66: void i2c_init(void)
                                    831 ;	-----------------------------------------
                                    832 ;	 function i2c_init
                                    833 ;	-----------------------------------------
      0086BA                        834 _i2c_init:
                                    835 ;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      0086BA 72 11 52 10      [ 1]  836 	bres	0x5210, #0
                                    837 ;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      0086BE C6 52 12         [ 1]  838 	ld	a, 0x5212
      0086C1 A4 C0            [ 1]  839 	and	a, #0xc0
      0086C3 AA 10            [ 1]  840 	or	a, #0x10
      0086C5 C7 52 12         [ 1]  841 	ld	0x5212, a
                                    842 ;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
      0086C8 C6 52 1C         [ 1]  843 	ld	a, 0x521c
      0086CB A4 F0            [ 1]  844 	and	a, #0xf0
      0086CD C7 52 1C         [ 1]  845 	ld	0x521c, a
                                    846 ;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0086D0 35 50 52 1B      [ 1]  847 	mov	0x521b+0, #0x50
                                    848 ;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0086D4 72 1F 52 1C      [ 1]  849 	bres	0x521c, #7
                                    850 ;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0086D8 72 1F 52 14      [ 1]  851 	bres	0x5214, #7
                                    852 ;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
      0086DC 72 10 52 14      [ 1]  853 	bset	0x5214, #0
                                    854 ;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0086E0 72 10 52 10      [ 1]  855 	bset	0x5210, #0
                                    856 ;	./libs/i2c_lib.c: 78: }
      0086E4 81               [ 4]  857 	ret
                                    858 ;	./libs/i2c_lib.c: 80: void i2c_start(void)
                                    859 ;	-----------------------------------------
                                    860 ;	 function i2c_start
                                    861 ;	-----------------------------------------
      0086E5                        862 _i2c_start:
                                    863 ;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0086E5 72 10 52 11      [ 1]  864 	bset	0x5211, #0
                                    865 ;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0086E9                        866 00101$:
      0086E9 72 01 52 17 FB   [ 2]  867 	btjf	0x5217, #0, 00101$
                                    868 ;	./libs/i2c_lib.c: 84: }
      0086EE 81               [ 4]  869 	ret
                                    870 ;	./libs/i2c_lib.c: 86: void i2c_stop(void)
                                    871 ;	-----------------------------------------
                                    872 ;	 function i2c_stop
                                    873 ;	-----------------------------------------
      0086EF                        874 _i2c_stop:
                                    875 ;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0086EF 72 12 52 11      [ 1]  876 	bset	0x5211, #1
                                    877 ;	./libs/i2c_lib.c: 89: }
      0086F3 81               [ 4]  878 	ret
                                    879 ;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    880 ;	-----------------------------------------
                                    881 ;	 function i2c_send_address
                                    882 ;	-----------------------------------------
      0086F4                        883 _i2c_send_address:
                                    884 ;	./libs/i2c_lib.c: 96: address = address << 1;
      0086F4 48               [ 1]  885 	sll	a
                                    886 ;	./libs/i2c_lib.c: 93: switch(rw_type)
      0086F5 88               [ 1]  887 	push	a
      0086F6 7B 04            [ 1]  888 	ld	a, (0x04, sp)
      0086F8 4A               [ 1]  889 	dec	a
      0086F9 84               [ 1]  890 	pop	a
      0086FA 26 02            [ 1]  891 	jrne	00102$
                                    892 ;	./libs/i2c_lib.c: 96: address = address << 1;
                                    893 ;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0086FC AA 01            [ 1]  894 	or	a, #0x01
                                    895 ;	./libs/i2c_lib.c: 98: break;
                                    896 ;	./libs/i2c_lib.c: 99: default:
                                    897 ;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
                                    898 ;	./libs/i2c_lib.c: 102: }
      0086FE                        899 00102$:
                                    900 ;	./libs/i2c_lib.c: 103: i2c_start();
      0086FE 88               [ 1]  901 	push	a
      0086FF CD 86 E5         [ 4]  902 	call	_i2c_start
      008702 84               [ 1]  903 	pop	a
                                    904 ;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
      008703 C7 52 16         [ 1]  905 	ld	0x5216, a
                                    906 ;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
      008706                        907 00106$:
      008706 AE 52 17         [ 2]  908 	ldw	x, #0x5217
      008709 F6               [ 1]  909 	ld	a, (x)
      00870A 44               [ 1]  910 	srl	a
      00870B A4 01            [ 1]  911 	and	a, #0x01
      00870D 26 08            [ 1]  912 	jrne	00108$
                                    913 ;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
      00870F 72 05 52 18 F2   [ 2]  914 	btjf	0x5218, #2, 00106$
                                    915 ;	./libs/i2c_lib.c: 107: return 0;
      008714 4F               [ 1]  916 	clr	a
      008715 20 08            [ 2]  917 	jra	00109$
      008717                        918 00108$:
                                    919 ;	./libs/i2c_lib.c: 108: clr_sr1();
      008717 C6 52 17         [ 1]  920 	ld	a,0x5217
                                    921 ;	./libs/i2c_lib.c: 109: clr_sr3();
      00871A C6 52 19         [ 1]  922 	ld	a,0x5219
                                    923 ;	./libs/i2c_lib.c: 110: return 1;
      00871D A6 01            [ 1]  924 	ld	a, #0x01
      00871F                        925 00109$:
                                    926 ;	./libs/i2c_lib.c: 111: }
      00871F 85               [ 2]  927 	popw	x
      008720 5B 01            [ 2]  928 	addw	sp, #1
      008722 FC               [ 2]  929 	jp	(x)
                                    930 ;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
                                    931 ;	-----------------------------------------
                                    932 ;	 function i2c_read_byte
                                    933 ;	-----------------------------------------
      008723                        934 _i2c_read_byte:
                                    935 ;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
      008723                        936 00101$:
      008723 72 0D 52 17 FB   [ 2]  937 	btjf	0x5217, #6, 00101$
                                    938 ;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
      008728 C6 52 16         [ 1]  939 	ld	a, 0x5216
                                    940 ;	./libs/i2c_lib.c: 117: }
      00872B 81               [ 4]  941 	ret
                                    942 ;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    943 ;	-----------------------------------------
                                    944 ;	 function i2c_read
                                    945 ;	-----------------------------------------
      00872C                        946 _i2c_read:
      00872C 52 04            [ 2]  947 	sub	sp, #4
                                    948 ;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      00872E 4B 01            [ 1]  949 	push	#0x01
      008730 CD 86 F4         [ 4]  950 	call	_i2c_send_address
      008733 4D               [ 1]  951 	tnz	a
      008734 27 3C            [ 1]  952 	jreq	00103$
                                    953 ;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008736 72 14 52 11      [ 1]  954 	bset	0x5211, #2
                                    955 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00873A 5F               [ 1]  956 	clrw	x
      00873B 1F 03            [ 2]  957 	ldw	(0x03, sp), x
      00873D                        958 00105$:
      00873D 5F               [ 1]  959 	clrw	x
      00873E 7B 07            [ 1]  960 	ld	a, (0x07, sp)
      008740 97               [ 1]  961 	ld	xl, a
      008741 5A               [ 2]  962 	decw	x
      008742 1F 01            [ 2]  963 	ldw	(0x01, sp), x
      008744 1E 03            [ 2]  964 	ldw	x, (0x03, sp)
      008746 13 01            [ 2]  965 	cpw	x, (0x01, sp)
      008748 2E 12            [ 1]  966 	jrsge	00101$
                                    967 ;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00874A 1E 08            [ 2]  968 	ldw	x, (0x08, sp)
      00874C 72 FB 03         [ 2]  969 	addw	x, (0x03, sp)
      00874F 89               [ 2]  970 	pushw	x
      008750 CD 87 23         [ 4]  971 	call	_i2c_read_byte
      008753 85               [ 2]  972 	popw	x
      008754 F7               [ 1]  973 	ld	(x), a
                                    974 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008755 1E 03            [ 2]  975 	ldw	x, (0x03, sp)
      008757 5C               [ 1]  976 	incw	x
      008758 1F 03            [ 2]  977 	ldw	(0x03, sp), x
      00875A 20 E1            [ 2]  978 	jra	00105$
      00875C                        979 00101$:
                                    980 ;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00875C C6 52 11         [ 1]  981 	ld	a, 0x5211
      00875F A4 FB            [ 1]  982 	and	a, #0xfb
      008761 C7 52 11         [ 1]  983 	ld	0x5211, a
                                    984 ;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
      008764 1E 08            [ 2]  985 	ldw	x, (0x08, sp)
      008766 72 FB 01         [ 2]  986 	addw	x, (0x01, sp)
      008769 89               [ 2]  987 	pushw	x
      00876A CD 87 23         [ 4]  988 	call	_i2c_read_byte
      00876D 85               [ 2]  989 	popw	x
      00876E F7               [ 1]  990 	ld	(x), a
                                    991 ;	./libs/i2c_lib.c: 132: i2c_stop();
      00876F CD 86 EF         [ 4]  992 	call	_i2c_stop
      008772                        993 00103$:
                                    994 ;	./libs/i2c_lib.c: 135: i2c_stop();
      008772 1E 05            [ 2]  995 	ldw	x, (5, sp)
      008774 1F 08            [ 2]  996 	ldw	(8, sp), x
      008776 5B 07            [ 2]  997 	addw	sp, #7
                                    998 ;	./libs/i2c_lib.c: 137: }
      008778 CC 86 EF         [ 2]  999 	jp	_i2c_stop
                                   1000 ;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
                                   1001 ;	-----------------------------------------
                                   1002 ;	 function i2c_send_byte
                                   1003 ;	-----------------------------------------
      00877B                       1004 _i2c_send_byte:
                                   1005 ;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
      00877B C7 52 16         [ 1] 1006 	ld	0x5216, a
                                   1007 ;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
      00877E                       1008 00103$:
      00877E 72 0E 52 17 08   [ 2] 1009 	btjt	0x5217, #7, 00105$
                                   1010 ;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
      008783 72 05 52 18 F6   [ 2] 1011 	btjf	0x5218, #2, 00103$
                                   1012 ;	./libs/i2c_lib.c: 144: return 1;
      008788 A6 01            [ 1] 1013 	ld	a, #0x01
      00878A 81               [ 4] 1014 	ret
      00878B                       1015 00105$:
                                   1016 ;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
      00878B 4F               [ 1] 1017 	clr	a
                                   1018 ;	./libs/i2c_lib.c: 146: }
      00878C 81               [ 4] 1019 	ret
                                   1020 ;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                   1021 ;	-----------------------------------------
                                   1022 ;	 function i2c_write
                                   1023 ;	-----------------------------------------
      00878D                       1024 _i2c_write:
      00878D 52 02            [ 2] 1025 	sub	sp, #2
                                   1026 ;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      00878F 4B 00            [ 1] 1027 	push	#0x00
      008791 CD 86 F4         [ 4] 1028 	call	_i2c_send_address
      008794 4D               [ 1] 1029 	tnz	a
      008795 27 1D            [ 1] 1030 	jreq	00105$
                                   1031 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      008797 5F               [ 1] 1032 	clrw	x
      008798                       1033 00107$:
      008798 7B 05            [ 1] 1034 	ld	a, (0x05, sp)
      00879A 6B 02            [ 1] 1035 	ld	(0x02, sp), a
      00879C 0F 01            [ 1] 1036 	clr	(0x01, sp)
      00879E 13 01            [ 2] 1037 	cpw	x, (0x01, sp)
      0087A0 2E 12            [ 1] 1038 	jrsge	00105$
                                   1039 ;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      0087A2 90 93            [ 1] 1040 	ldw	y, x
      0087A4 72 F9 06         [ 2] 1041 	addw	y, (0x06, sp)
      0087A7 90 F6            [ 1] 1042 	ld	a, (y)
      0087A9 89               [ 2] 1043 	pushw	x
      0087AA CD 87 7B         [ 4] 1044 	call	_i2c_send_byte
      0087AD 85               [ 2] 1045 	popw	x
      0087AE 4D               [ 1] 1046 	tnz	a
      0087AF 26 03            [ 1] 1047 	jrne	00105$
                                   1048 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      0087B1 5C               [ 1] 1049 	incw	x
      0087B2 20 E4            [ 2] 1050 	jra	00107$
      0087B4                       1051 00105$:
                                   1052 ;	./libs/i2c_lib.c: 158: i2c_stop();
      0087B4 1E 03            [ 2] 1053 	ldw	x, (3, sp)
      0087B6 1F 06            [ 2] 1054 	ldw	(6, sp), x
      0087B8 5B 05            [ 2] 1055 	addw	sp, #5
                                   1056 ;	./libs/i2c_lib.c: 159: }
      0087BA CC 86 EF         [ 2] 1057 	jp	_i2c_stop
                                   1058 ;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
                                   1059 ;	-----------------------------------------
                                   1060 ;	 function i2c_scan
                                   1061 ;	-----------------------------------------
      0087BD                       1062 _i2c_scan:
      0087BD 52 02            [ 2] 1063 	sub	sp, #2
                                   1064 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087BF A6 01            [ 1] 1065 	ld	a, #0x01
      0087C1 6B 01            [ 1] 1066 	ld	(0x01, sp), a
      0087C3                       1067 00105$:
      0087C3 A1 7F            [ 1] 1068 	cp	a, #0x7f
      0087C5 24 22            [ 1] 1069 	jrnc	00103$
                                   1070 ;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0087C7 88               [ 1] 1071 	push	a
      0087C8 4B 00            [ 1] 1072 	push	#0x00
      0087CA CD 86 F4         [ 4] 1073 	call	_i2c_send_address
      0087CD 6B 03            [ 1] 1074 	ld	(0x03, sp), a
      0087CF 84               [ 1] 1075 	pop	a
      0087D0 0D 02            [ 1] 1076 	tnz	(0x02, sp)
      0087D2 27 07            [ 1] 1077 	jreq	00102$
                                   1078 ;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
      0087D4 CD 86 EF         [ 4] 1079 	call	_i2c_stop
                                   1080 ;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
      0087D7 7B 01            [ 1] 1081 	ld	a, (0x01, sp)
      0087D9 20 12            [ 2] 1082 	jra	00107$
      0087DB                       1083 00102$:
                                   1084 ;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0087DB AE 52 18         [ 2] 1085 	ldw	x, #0x5218
      0087DE 88               [ 1] 1086 	push	a
      0087DF F6               [ 1] 1087 	ld	a, (x)
      0087E0 A4 FB            [ 1] 1088 	and	a, #0xfb
      0087E2 F7               [ 1] 1089 	ld	(x), a
      0087E3 84               [ 1] 1090 	pop	a
                                   1091 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087E4 4C               [ 1] 1092 	inc	a
      0087E5 6B 01            [ 1] 1093 	ld	(0x01, sp), a
      0087E7 20 DA            [ 2] 1094 	jra	00105$
      0087E9                       1095 00103$:
                                   1096 ;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
      0087E9 CD 86 EF         [ 4] 1097 	call	_i2c_stop
                                   1098 ;	./libs/i2c_lib.c: 173: return 0;
      0087EC 4F               [ 1] 1099 	clr	a
      0087ED                       1100 00107$:
                                   1101 ;	./libs/i2c_lib.c: 174: }
      0087ED 5B 02            [ 2] 1102 	addw	sp, #2
      0087EF 81               [ 4] 1103 	ret
                                   1104 ;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
                                   1105 ;	-----------------------------------------
                                   1106 ;	 function i2c_start_irq
                                   1107 ;	-----------------------------------------
      0087F0                       1108 _i2c_start_irq:
                                   1109 ;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      0087F0 72 12 52 1A      [ 1] 1110 	bset	0x521a, #1
                                   1111 ;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0087F4 72 10 52 11      [ 1] 1112 	bset	0x5211, #0
                                   1113 ;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      0087F8                       1114 00101$:
      0087F8 C6 52 1A         [ 1] 1115 	ld	a, 0x521a
      0087FB A5 02            [ 1] 1116 	bcp	a, #2
      0087FD 26 F9            [ 1] 1117 	jrne	00101$
                                   1118 ;	./libs/i2c_lib.c: 182: }
      0087FF 81               [ 4] 1119 	ret
                                   1120 ;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
                                   1121 ;	-----------------------------------------
                                   1122 ;	 function i2c_stop_irq
                                   1123 ;	-----------------------------------------
      008800                       1124 _i2c_stop_irq:
                                   1125 ;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      008800 72 12 52 11      [ 1] 1126 	bset	0x5211, #1
                                   1127 ;	./libs/i2c_lib.c: 187: }
      008804 81               [ 4] 1128 	ret
                                   1129 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                   1130 ;	-----------------------------------------
                                   1131 ;	 function get_bit
                                   1132 ;	-----------------------------------------
      008805                       1133 _get_bit:
                                   1134 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      008805 7B 04            [ 1] 1135 	ld	a, (0x04, sp)
      008807 27 04            [ 1] 1136 	jreq	00113$
      008809                       1137 00112$:
      008809 57               [ 2] 1138 	sraw	x
      00880A 4A               [ 1] 1139 	dec	a
      00880B 26 FC            [ 1] 1140 	jrne	00112$
      00880D                       1141 00113$:
      00880D 54               [ 2] 1142 	srlw	x
      00880E 24 03            [ 1] 1143 	jrnc	00103$
      008810 5F               [ 1] 1144 	clrw	x
      008811 5C               [ 1] 1145 	incw	x
      008812 21                    1146 	.byte 0x21
      008813                       1147 00103$:
      008813 5F               [ 1] 1148 	clrw	x
      008814                       1149 00104$:
                                   1150 ;	./libs/ssd1306_lib.c: 6: }
      008814 90 85            [ 2] 1151 	popw	y
      008816 5B 02            [ 2] 1152 	addw	sp, #2
      008818 90 FC            [ 2] 1153 	jp	(y)
                                   1154 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                   1155 ;	-----------------------------------------
                                   1156 ;	 function set_bit
                                   1157 ;	-----------------------------------------
      00881A                       1158 _set_bit:
      00881A 52 04            [ 2] 1159 	sub	sp, #4
      00881C 1F 01            [ 2] 1160 	ldw	(0x01, sp), x
                                   1161 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      00881E 5F               [ 1] 1162 	clrw	x
      00881F 5C               [ 1] 1163 	incw	x
      008820 1F 03            [ 2] 1164 	ldw	(0x03, sp), x
      008822 7B 08            [ 1] 1165 	ld	a, (0x08, sp)
      008824 27 07            [ 1] 1166 	jreq	00114$
      008826                       1167 00113$:
      008826 08 04            [ 1] 1168 	sll	(0x04, sp)
      008828 09 03            [ 1] 1169 	rlc	(0x03, sp)
      00882A 4A               [ 1] 1170 	dec	a
      00882B 26 F9            [ 1] 1171 	jrne	00113$
      00882D                       1172 00114$:
                                   1173 ;	./libs/ssd1306_lib.c: 10: switch(value)
      00882D 1E 09            [ 2] 1174 	ldw	x, (0x09, sp)
      00882F 5A               [ 2] 1175 	decw	x
      008830 26 0B            [ 1] 1176 	jrne	00102$
                                   1177 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      008832 7B 02            [ 1] 1178 	ld	a, (0x02, sp)
      008834 1A 04            [ 1] 1179 	or	a, (0x04, sp)
      008836 97               [ 1] 1180 	ld	xl, a
      008837 7B 01            [ 1] 1181 	ld	a, (0x01, sp)
      008839 1A 03            [ 1] 1182 	or	a, (0x03, sp)
                                   1183 ;	./libs/ssd1306_lib.c: 14: break;
      00883B 20 09            [ 2] 1184 	jra	00103$
                                   1185 ;	./libs/ssd1306_lib.c: 16: default:
      00883D                       1186 00102$:
                                   1187 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      00883D 1E 03            [ 2] 1188 	ldw	x, (0x03, sp)
      00883F 53               [ 2] 1189 	cplw	x
      008840 9F               [ 1] 1190 	ld	a, xl
      008841 14 02            [ 1] 1191 	and	a, (0x02, sp)
      008843 02               [ 1] 1192 	rlwa	x
      008844 14 01            [ 1] 1193 	and	a, (0x01, sp)
                                   1194 ;	./libs/ssd1306_lib.c: 19: }
      008846                       1195 00103$:
                                   1196 ;	./libs/ssd1306_lib.c: 20: return data;
      008846 95               [ 1] 1197 	ld	xh, a
                                   1198 ;	./libs/ssd1306_lib.c: 21: }
      008847 16 05            [ 2] 1199 	ldw	y, (5, sp)
      008849 5B 0A            [ 2] 1200 	addw	sp, #10
      00884B 90 FC            [ 2] 1201 	jp	(y)
                                   1202 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                   1203 ;	-----------------------------------------
                                   1204 ;	 function ssd1306_init
                                   1205 ;	-----------------------------------------
      00884D                       1206 _ssd1306_init:
      00884D 52 1B            [ 2] 1207 	sub	sp, #27
                                   1208 ;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
      00884F 96               [ 1] 1209 	ldw	x, sp
      008850 5C               [ 1] 1210 	incw	x
      008851 7F               [ 1] 1211 	clr	(x)
      008852 A6 AE            [ 1] 1212 	ld	a, #0xae
      008854 6B 02            [ 1] 1213 	ld	(0x02, sp), a
      008856 A6 D5            [ 1] 1214 	ld	a, #0xd5
      008858 6B 03            [ 1] 1215 	ld	(0x03, sp), a
      00885A A6 80            [ 1] 1216 	ld	a, #0x80
      00885C 6B 04            [ 1] 1217 	ld	(0x04, sp), a
      00885E A6 A8            [ 1] 1218 	ld	a, #0xa8
      008860 6B 05            [ 1] 1219 	ld	(0x05, sp), a
      008862 A6 1F            [ 1] 1220 	ld	a, #0x1f
      008864 6B 06            [ 1] 1221 	ld	(0x06, sp), a
      008866 A6 D3            [ 1] 1222 	ld	a, #0xd3
      008868 6B 07            [ 1] 1223 	ld	(0x07, sp), a
      00886A 0F 08            [ 1] 1224 	clr	(0x08, sp)
      00886C A6 40            [ 1] 1225 	ld	a, #0x40
      00886E 6B 09            [ 1] 1226 	ld	(0x09, sp), a
      008870 A6 8D            [ 1] 1227 	ld	a, #0x8d
      008872 6B 0A            [ 1] 1228 	ld	(0x0a, sp), a
      008874 A6 14            [ 1] 1229 	ld	a, #0x14
      008876 6B 0B            [ 1] 1230 	ld	(0x0b, sp), a
      008878 A6 DB            [ 1] 1231 	ld	a, #0xdb
      00887A 6B 0C            [ 1] 1232 	ld	(0x0c, sp), a
      00887C A6 40            [ 1] 1233 	ld	a, #0x40
      00887E 6B 0D            [ 1] 1234 	ld	(0x0d, sp), a
      008880 A6 A4            [ 1] 1235 	ld	a, #0xa4
      008882 6B 0E            [ 1] 1236 	ld	(0x0e, sp), a
      008884 A6 A6            [ 1] 1237 	ld	a, #0xa6
      008886 6B 0F            [ 1] 1238 	ld	(0x0f, sp), a
      008888 A6 DA            [ 1] 1239 	ld	a, #0xda
      00888A 6B 10            [ 1] 1240 	ld	(0x10, sp), a
      00888C A6 02            [ 1] 1241 	ld	a, #0x02
      00888E 6B 11            [ 1] 1242 	ld	(0x11, sp), a
      008890 A6 81            [ 1] 1243 	ld	a, #0x81
      008892 6B 12            [ 1] 1244 	ld	(0x12, sp), a
      008894 A6 8F            [ 1] 1245 	ld	a, #0x8f
      008896 6B 13            [ 1] 1246 	ld	(0x13, sp), a
      008898 A6 D9            [ 1] 1247 	ld	a, #0xd9
      00889A 6B 14            [ 1] 1248 	ld	(0x14, sp), a
      00889C A6 F1            [ 1] 1249 	ld	a, #0xf1
      00889E 6B 15            [ 1] 1250 	ld	(0x15, sp), a
      0088A0 A6 20            [ 1] 1251 	ld	a, #0x20
      0088A2 6B 16            [ 1] 1252 	ld	(0x16, sp), a
      0088A4 0F 17            [ 1] 1253 	clr	(0x17, sp)
      0088A6 A6 A0            [ 1] 1254 	ld	a, #0xa0
      0088A8 6B 18            [ 1] 1255 	ld	(0x18, sp), a
      0088AA A6 C0            [ 1] 1256 	ld	a, #0xc0
      0088AC 6B 19            [ 1] 1257 	ld	(0x19, sp), a
      0088AE A6 1F            [ 1] 1258 	ld	a, #0x1f
      0088B0 6B 1A            [ 1] 1259 	ld	(0x1a, sp), a
      0088B2 A6 AF            [ 1] 1260 	ld	a, #0xaf
      0088B4 6B 1B            [ 1] 1261 	ld	(0x1b, sp), a
                                   1262 ;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
      0088B6 89               [ 2] 1263 	pushw	x
      0088B7 4B 1B            [ 1] 1264 	push	#0x1b
      0088B9 A6 3C            [ 1] 1265 	ld	a, #0x3c
      0088BB CD 87 8D         [ 4] 1266 	call	_i2c_write
                                   1267 ;	./libs/ssd1306_lib.c: 43: }
      0088BE 5B 1B            [ 2] 1268 	addw	sp, #27
      0088C0 81               [ 4] 1269 	ret
                                   1270 ;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
                                   1271 ;	-----------------------------------------
                                   1272 ;	 function ssd1306_set_params_to_write
                                   1273 ;	-----------------------------------------
      0088C1                       1274 _ssd1306_set_params_to_write:
      0088C1 52 07            [ 2] 1275 	sub	sp, #7
                                   1276 ;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
      0088C3 96               [ 1] 1277 	ldw	x, sp
      0088C4 5C               [ 1] 1278 	incw	x
      0088C5 7F               [ 1] 1279 	clr	(x)
      0088C6 A6 22            [ 1] 1280 	ld	a, #0x22
      0088C8 6B 02            [ 1] 1281 	ld	(0x02, sp), a
      0088CA 0F 03            [ 1] 1282 	clr	(0x03, sp)
      0088CC A6 03            [ 1] 1283 	ld	a, #0x03
      0088CE 6B 04            [ 1] 1284 	ld	(0x04, sp), a
      0088D0 A6 21            [ 1] 1285 	ld	a, #0x21
      0088D2 6B 05            [ 1] 1286 	ld	(0x05, sp), a
      0088D4 0F 06            [ 1] 1287 	clr	(0x06, sp)
      0088D6 A6 7F            [ 1] 1288 	ld	a, #0x7f
      0088D8 6B 07            [ 1] 1289 	ld	(0x07, sp), a
                                   1290 ;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      0088DA 89               [ 2] 1291 	pushw	x
      0088DB 4B 07            [ 1] 1292 	push	#0x07
      0088DD A6 3C            [ 1] 1293 	ld	a, #0x3c
      0088DF CD 87 8D         [ 4] 1294 	call	_i2c_write
                                   1295 ;	./libs/ssd1306_lib.c: 52: }
      0088E2 5B 07            [ 2] 1296 	addw	sp, #7
      0088E4 81               [ 4] 1297 	ret
                                   1298 ;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1299 ;	-----------------------------------------
                                   1300 ;	 function ssd1306_draw_pixel
                                   1301 ;	-----------------------------------------
      0088E5                       1302 _ssd1306_draw_pixel:
      0088E5 52 08            [ 2] 1303 	sub	sp, #8
      0088E7 1F 07            [ 2] 1304 	ldw	(0x07, sp), x
                                   1305 ;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      0088E9 6B 06            [ 1] 1306 	ld	(0x06, sp), a
      0088EB 0F 05            [ 1] 1307 	clr	(0x05, sp)
      0088ED 7B 0B            [ 1] 1308 	ld	a, (0x0b, sp)
      0088EF 0F 01            [ 1] 1309 	clr	(0x01, sp)
      0088F1 97               [ 1] 1310 	ld	xl, a
      0088F2 02               [ 1] 1311 	rlwa	x
      0088F3 4F               [ 1] 1312 	clr	a
      0088F4 01               [ 1] 1313 	rrwa	x
      0088F5 5D               [ 2] 1314 	tnzw	x
      0088F6 2A 03            [ 1] 1315 	jrpl	00103$
      0088F8 1C 00 07         [ 2] 1316 	addw	x, #0x0007
      0088FB                       1317 00103$:
      0088FB 57               [ 2] 1318 	sraw	x
      0088FC 57               [ 2] 1319 	sraw	x
      0088FD 57               [ 2] 1320 	sraw	x
      0088FE 58               [ 2] 1321 	sllw	x
      0088FF 58               [ 2] 1322 	sllw	x
      008900 58               [ 2] 1323 	sllw	x
      008901 58               [ 2] 1324 	sllw	x
      008902 58               [ 2] 1325 	sllw	x
      008903 58               [ 2] 1326 	sllw	x
      008904 58               [ 2] 1327 	sllw	x
      008905 72 FB 05         [ 2] 1328 	addw	x, (0x05, sp)
      008908 72 FB 07         [ 2] 1329 	addw	x, (0x07, sp)
      00890B 1F 03            [ 2] 1330 	ldw	(0x03, sp), x
      00890D 90 5F            [ 1] 1331 	clrw	y
      00890F 61               [ 1] 1332 	exg	a, yl
      008910 7B 0C            [ 1] 1333 	ld	a, (0x0c, sp)
      008912 61               [ 1] 1334 	exg	a, yl
      008913 A4 07            [ 1] 1335 	and	a, #0x07
      008915 6B 06            [ 1] 1336 	ld	(0x06, sp), a
      008917 0F 05            [ 1] 1337 	clr	(0x05, sp)
      008919 1E 03            [ 2] 1338 	ldw	x, (0x03, sp)
      00891B F6               [ 1] 1339 	ld	a, (x)
      00891C 5F               [ 1] 1340 	clrw	x
      00891D 90 89            [ 2] 1341 	pushw	y
      00891F 16 07            [ 2] 1342 	ldw	y, (0x07, sp)
      008921 90 89            [ 2] 1343 	pushw	y
      008923 97               [ 1] 1344 	ld	xl, a
      008924 CD 88 1A         [ 4] 1345 	call	_set_bit
      008927 9F               [ 1] 1346 	ld	a, xl
      008928 1E 03            [ 2] 1347 	ldw	x, (0x03, sp)
      00892A F7               [ 1] 1348 	ld	(x), a
                                   1349 ;	./libs/ssd1306_lib.c: 57: }
      00892B 1E 09            [ 2] 1350 	ldw	x, (9, sp)
      00892D 5B 0C            [ 2] 1351 	addw	sp, #12
      00892F FC               [ 2] 1352 	jp	(x)
                                   1353 ;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
                                   1354 ;	-----------------------------------------
                                   1355 ;	 function ssd1306_buffer_clean
                                   1356 ;	-----------------------------------------
      008930                       1357 _ssd1306_buffer_clean:
                                   1358 ;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
      008930 4B 00            [ 1] 1359 	push	#0x00
      008932 4B 02            [ 1] 1360 	push	#0x02
      008934 5F               [ 1] 1361 	clrw	x
      008935 89               [ 2] 1362 	pushw	x
      008936 AE 01 68         [ 2] 1363 	ldw	x, #(_main_buffer+0)
      008939 CD 8A 4F         [ 4] 1364 	call	_memset
                                   1365 ;	./libs/ssd1306_lib.c: 62: }
      00893C 81               [ 4] 1366 	ret
                                   1367 ;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
                                   1368 ;	-----------------------------------------
                                   1369 ;	 function ssd1306_send_buffer
                                   1370 ;	-----------------------------------------
      00893D                       1371 _ssd1306_send_buffer:
      00893D 52 04            [ 2] 1372 	sub	sp, #4
                                   1373 ;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
      00893F CD 88 C1         [ 4] 1374 	call	_ssd1306_set_params_to_write
                                   1375 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008942 5F               [ 1] 1376 	clrw	x
      008943 1F 03            [ 2] 1377 	ldw	(0x03, sp), x
      008945                       1378 00112$:
      008945 1E 03            [ 2] 1379 	ldw	x, (0x03, sp)
      008947 A3 00 04         [ 2] 1380 	cpw	x, #0x0004
      00894A 2E 43            [ 1] 1381 	jrsge	00114$
                                   1382 ;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
      00894C 4B 00            [ 1] 1383 	push	#0x00
      00894E A6 3C            [ 1] 1384 	ld	a, #0x3c
      008950 CD 86 F4         [ 4] 1385 	call	_i2c_send_address
      008953 4D               [ 1] 1386 	tnz	a
      008954 27 2F            [ 1] 1387 	jreq	00105$
                                   1388 ;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
      008956 A6 40            [ 1] 1389 	ld	a, #0x40
      008958 CD 87 7B         [ 4] 1390 	call	_i2c_send_byte
                                   1391 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      00895B 1E 03            [ 2] 1392 	ldw	x, (0x03, sp)
      00895D 58               [ 2] 1393 	sllw	x
      00895E 58               [ 2] 1394 	sllw	x
      00895F 58               [ 2] 1395 	sllw	x
      008960 58               [ 2] 1396 	sllw	x
      008961 58               [ 2] 1397 	sllw	x
      008962 58               [ 2] 1398 	sllw	x
      008963 58               [ 2] 1399 	sllw	x
      008964 1F 01            [ 2] 1400 	ldw	(0x01, sp), x
      008966 5F               [ 1] 1401 	clrw	x
      008967                       1402 00109$:
      008967 A3 00 80         [ 2] 1403 	cpw	x, #0x0080
      00896A 2E 14            [ 1] 1404 	jrsge	00103$
                                   1405 ;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i+(128*j)]))//Проверка на АСК бит
      00896C 90 93            [ 1] 1406 	ldw	y, x
      00896E 72 F9 01         [ 2] 1407 	addw	y, (0x01, sp)
      008971 90 D6 01 68      [ 1] 1408 	ld	a, (_main_buffer+0, y)
      008975 89               [ 2] 1409 	pushw	x
      008976 CD 87 7B         [ 4] 1410 	call	_i2c_send_byte
      008979 85               [ 2] 1411 	popw	x
      00897A 4D               [ 1] 1412 	tnz	a
      00897B 26 03            [ 1] 1413 	jrne	00103$
                                   1414 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      00897D 5C               [ 1] 1415 	incw	x
      00897E 20 E7            [ 2] 1416 	jra	00109$
      008980                       1417 00103$:
                                   1418 ;	./libs/ssd1306_lib.c: 78: i2c_stop();
      008980 CD 86 EF         [ 4] 1419 	call	_i2c_stop
      008983 20 03            [ 2] 1420 	jra	00113$
      008985                       1421 00105$:
                                   1422 ;	./libs/ssd1306_lib.c: 81: i2c_stop();
      008985 CD 86 EF         [ 4] 1423 	call	_i2c_stop
      008988                       1424 00113$:
                                   1425 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008988 1E 03            [ 2] 1426 	ldw	x, (0x03, sp)
      00898A 5C               [ 1] 1427 	incw	x
      00898B 1F 03            [ 2] 1428 	ldw	(0x03, sp), x
      00898D 20 B6            [ 2] 1429 	jra	00112$
      00898F                       1430 00114$:
                                   1431 ;	./libs/ssd1306_lib.c: 83: }
      00898F 5B 04            [ 2] 1432 	addw	sp, #4
      008991 81               [ 4] 1433 	ret
                                   1434 ;	./libs/ssd1306_lib.c: 105: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
                                   1435 ;	-----------------------------------------
                                   1436 ;	 function ssd1306_buffer_write
                                   1437 ;	-----------------------------------------
      008992                       1438 _ssd1306_buffer_write:
      008992 52 0D            [ 2] 1439 	sub	sp, #13
      008994 1F 08            [ 2] 1440 	ldw	(0x08, sp), x
                                   1441 ;	./libs/ssd1306_lib.c: 107: for (int height = 0; height < 8; height++)
      008996 5F               [ 1] 1442 	clrw	x
      008997 1F 0A            [ 2] 1443 	ldw	(0x0a, sp), x
      008999                       1444 00109$:
      008999 1E 0A            [ 2] 1445 	ldw	x, (0x0a, sp)
      00899B A3 00 08         [ 2] 1446 	cpw	x, #0x0008
      00899E 2F 03            [ 1] 1447 	jrslt	00150$
      0089A0 CC 8A 25         [ 2] 1448 	jp	00111$
      0089A3                       1449 00150$:
                                   1450 ;	./libs/ssd1306_lib.c: 109: for (int width = 0; width < 8; width++)
      0089A3 1E 0A            [ 2] 1451 	ldw	x, (0x0a, sp)
      0089A5 58               [ 2] 1452 	sllw	x
      0089A6 58               [ 2] 1453 	sllw	x
      0089A7 58               [ 2] 1454 	sllw	x
      0089A8 58               [ 2] 1455 	sllw	x
      0089A9 1F 05            [ 2] 1456 	ldw	(0x05, sp), x
      0089AB 5F               [ 1] 1457 	clrw	x
      0089AC 1F 0C            [ 2] 1458 	ldw	(0x0c, sp), x
      0089AE                       1459 00106$:
      0089AE 1E 0C            [ 2] 1460 	ldw	x, (0x0c, sp)
      0089B0 A3 00 08         [ 2] 1461 	cpw	x, #0x0008
      0089B3 2E 68            [ 1] 1462 	jrsge	00110$
                                   1463 ;	./libs/ssd1306_lib.c: 110: if(data[height + width / 8] & (128 >> (width & 7)))
      0089B5 1E 0A            [ 2] 1464 	ldw	x, (0x0a, sp)
      0089B7 72 FB 12         [ 2] 1465 	addw	x, (0x12, sp)
      0089BA F6               [ 1] 1466 	ld	a, (x)
      0089BB 97               [ 1] 1467 	ld	xl, a
      0089BC 7B 0D            [ 1] 1468 	ld	a, (0x0d, sp)
      0089BE A4 07            [ 1] 1469 	and	a, #0x07
      0089C0 90 AE 00 80      [ 2] 1470 	ldw	y, #0x0080
      0089C4 4D               [ 1] 1471 	tnz	a
      0089C5 27 05            [ 1] 1472 	jreq	00153$
      0089C7                       1473 00152$:
      0089C7 90 57            [ 2] 1474 	sraw	y
      0089C9 4A               [ 1] 1475 	dec	a
      0089CA 26 FB            [ 1] 1476 	jrne	00152$
      0089CC                       1477 00153$:
      0089CC 17 01            [ 2] 1478 	ldw	(0x01, sp), y
      0089CE 9F               [ 1] 1479 	ld	a, xl
      0089CF 14 02            [ 1] 1480 	and	a, (0x02, sp)
      0089D1 6B 04            [ 1] 1481 	ld	(0x04, sp), a
      0089D3 0F 03            [ 1] 1482 	clr	(0x03, sp)
      0089D5 1E 03            [ 2] 1483 	ldw	x, (0x03, sp)
      0089D7 27 3D            [ 1] 1484 	jreq	00107$
                                   1485 ;	./libs/ssd1306_lib.c: 111: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(main_buffer[(height*16) + (width / 8)], 7 - (width % 8)));
      0089D9 4B 08            [ 1] 1486 	push	#0x08
      0089DB 4B 00            [ 1] 1487 	push	#0x00
      0089DD 1E 0E            [ 2] 1488 	ldw	x, (0x0e, sp)
      0089DF CD 8A 73         [ 4] 1489 	call	__modsint
      0089E2 1F 03            [ 2] 1490 	ldw	(0x03, sp), x
      0089E4 90 AE 00 07      [ 2] 1491 	ldw	y, #0x0007
      0089E8 72 F2 03         [ 2] 1492 	subw	y, (0x03, sp)
      0089EB 1E 05            [ 2] 1493 	ldw	x, (0x05, sp)
      0089ED D6 01 68         [ 1] 1494 	ld	a, (_main_buffer+0, x)
      0089F0 5F               [ 1] 1495 	clrw	x
      0089F1 90 89            [ 2] 1496 	pushw	y
      0089F3 97               [ 1] 1497 	ld	xl, a
      0089F4 CD 88 05         [ 4] 1498 	call	_get_bit
      0089F7 7B 11            [ 1] 1499 	ld	a, (0x11, sp)
      0089F9 6B 07            [ 1] 1500 	ld	(0x07, sp), a
      0089FB 7B 0B            [ 1] 1501 	ld	a, (0x0b, sp)
      0089FD 1B 07            [ 1] 1502 	add	a, (0x07, sp)
      0089FF 95               [ 1] 1503 	ld	xh, a
      008A00 7B 09            [ 1] 1504 	ld	a, (0x09, sp)
      008A02 6B 07            [ 1] 1505 	ld	(0x07, sp), a
      008A04 7B 0D            [ 1] 1506 	ld	a, (0x0d, sp)
      008A06 1B 07            [ 1] 1507 	add	a, (0x07, sp)
      008A08 6B 07            [ 1] 1508 	ld	(0x07, sp), a
      008A0A 9F               [ 1] 1509 	ld	a, xl
      008A0B 88               [ 1] 1510 	push	a
      008A0C 9E               [ 1] 1511 	ld	a, xh
      008A0D 88               [ 1] 1512 	push	a
      008A0E 7B 09            [ 1] 1513 	ld	a, (0x09, sp)
      008A10 AE 01 68         [ 2] 1514 	ldw	x, #(_main_buffer+0)
      008A13 CD 88 E5         [ 4] 1515 	call	_ssd1306_draw_pixel
      008A16                       1516 00107$:
                                   1517 ;	./libs/ssd1306_lib.c: 109: for (int width = 0; width < 8; width++)
      008A16 1E 0C            [ 2] 1518 	ldw	x, (0x0c, sp)
      008A18 5C               [ 1] 1519 	incw	x
      008A19 1F 0C            [ 2] 1520 	ldw	(0x0c, sp), x
      008A1B 20 91            [ 2] 1521 	jra	00106$
      008A1D                       1522 00110$:
                                   1523 ;	./libs/ssd1306_lib.c: 107: for (int height = 0; height < 8; height++)
      008A1D 1E 0A            [ 2] 1524 	ldw	x, (0x0a, sp)
      008A1F 5C               [ 1] 1525 	incw	x
      008A20 1F 0A            [ 2] 1526 	ldw	(0x0a, sp), x
      008A22 CC 89 99         [ 2] 1527 	jp	00109$
      008A25                       1528 00111$:
                                   1529 ;	./libs/ssd1306_lib.c: 113: }
      008A25 1E 0E            [ 2] 1530 	ldw	x, (14, sp)
      008A27 5B 13            [ 2] 1531 	addw	sp, #19
      008A29 FC               [ 2] 1532 	jp	(x)
                                   1533 ;	./libs/ssd1306_lib.c: 115: void ssd1306_clean(void)
                                   1534 ;	-----------------------------------------
                                   1535 ;	 function ssd1306_clean
                                   1536 ;	-----------------------------------------
      008A2A                       1537 _ssd1306_clean:
                                   1538 ;	./libs/ssd1306_lib.c: 117: ssd1306_buffer_clean();
      008A2A CD 89 30         [ 4] 1539 	call	_ssd1306_buffer_clean
                                   1540 ;	./libs/ssd1306_lib.c: 118: ssd1306_send_buffer();
                                   1541 ;	./libs/ssd1306_lib.c: 119: }
      008A2D CC 89 3D         [ 2] 1542 	jp	_ssd1306_send_buffer
                                   1543 ;	main.c: 3: void setup(void)
                                   1544 ;	-----------------------------------------
                                   1545 ;	 function setup
                                   1546 ;	-----------------------------------------
      008A30                       1547 _setup:
                                   1548 ;	main.c: 6: CLK_CKDIVR = 0;
      008A30 35 00 50 C6      [ 1] 1549 	mov	0x50c6+0, #0x00
                                   1550 ;	main.c: 8: uart_init(9600,0);
      008A34 4F               [ 1] 1551 	clr	a
      008A35 AE 25 80         [ 2] 1552 	ldw	x, #0x2580
      008A38 CD 84 99         [ 4] 1553 	call	_uart_init
                                   1554 ;	main.c: 9: i2c_init();
      008A3B CD 86 BA         [ 4] 1555 	call	_i2c_init
                                   1556 ;	main.c: 11: enableInterrupts();
      008A3E 9A               [ 1] 1557 	rim
                                   1558 ;	main.c: 12: }
      008A3F 81               [ 4] 1559 	ret
                                   1560 ;	main.c: 14: void gg(void)
                                   1561 ;	-----------------------------------------
                                   1562 ;	 function gg
                                   1563 ;	-----------------------------------------
      008A40                       1564 _gg:
                                   1565 ;	main.c: 16: ssd1306_init();
      008A40 CD 88 4D         [ 4] 1566 	call	_ssd1306_init
                                   1567 ;	main.c: 17: ssd1306_send_buffer();
                                   1568 ;	main.c: 21: }
      008A43 CC 89 3D         [ 2] 1569 	jp	_ssd1306_send_buffer
                                   1570 ;	main.c: 23: int main(void)
                                   1571 ;	-----------------------------------------
                                   1572 ;	 function main
                                   1573 ;	-----------------------------------------
      008A46                       1574 _main:
                                   1575 ;	main.c: 25: setup();
      008A46 CD 8A 30         [ 4] 1576 	call	_setup
                                   1577 ;	main.c: 26: gg();
      008A49 CD 8A 40         [ 4] 1578 	call	_gg
                                   1579 ;	main.c: 27: while(1);
      008A4C                       1580 00102$:
      008A4C 20 FE            [ 2] 1581 	jra	00102$
                                   1582 ;	main.c: 28: }
      008A4E 81               [ 4] 1583 	ret
                                   1584 	.area CODE
                                   1585 	.area CONST
                                   1586 	.area INITIALIZER
      008081                       1587 __xinit__I2C_IRQ:
      008081 00                    1588 	.db #0x00	; 0
      008082                       1589 __xinit__ttf_eng_a:
      008082 00                    1590 	.db #0x00	; 0
      008083 7E                    1591 	.db #0x7e	; 126
      008084 42                    1592 	.db #0x42	; 66	'B'
      008085 42                    1593 	.db #0x42	; 66	'B'
      008086 7E                    1594 	.db #0x7e	; 126
      008087 42                    1595 	.db #0x42	; 66	'B'
      008088 42                    1596 	.db #0x42	; 66	'B'
      008089 00                    1597 	.db #0x00	; 0
      00808A                       1598 __xinit__ttf_eng_b:
      00808A 00                    1599 	.db #0x00	; 0
      00808B 7C                    1600 	.db #0x7c	; 124
      00808C 42                    1601 	.db #0x42	; 66	'B'
      00808D 7C                    1602 	.db #0x7c	; 124
      00808E 42                    1603 	.db #0x42	; 66	'B'
      00808F 42                    1604 	.db #0x42	; 66	'B'
      008090 7C                    1605 	.db #0x7c	; 124
      008091 00                    1606 	.db #0x00	; 0
      008092                       1607 __xinit__ttf_eng_c:
      008092 00                    1608 	.db #0x00	; 0
      008093 7E                    1609 	.db #0x7e	; 126
      008094 40                    1610 	.db #0x40	; 64
      008095 40                    1611 	.db #0x40	; 64
      008096 40                    1612 	.db #0x40	; 64
      008097 40                    1613 	.db #0x40	; 64
      008098 7E                    1614 	.db #0x7e	; 126
      008099 00                    1615 	.db #0x00	; 0
      00809A                       1616 __xinit__ttf_eng_d:
      00809A 00                    1617 	.db #0x00	; 0
      00809B 7C                    1618 	.db #0x7c	; 124
      00809C 42                    1619 	.db #0x42	; 66	'B'
      00809D 42                    1620 	.db #0x42	; 66	'B'
      00809E 42                    1621 	.db #0x42	; 66	'B'
      00809F 42                    1622 	.db #0x42	; 66	'B'
      0080A0 7C                    1623 	.db #0x7c	; 124
      0080A1 00                    1624 	.db #0x00	; 0
      0080A2                       1625 __xinit__ttf_eng_e:
      0080A2 00                    1626 	.db #0x00	; 0
      0080A3 7E                    1627 	.db #0x7e	; 126
      0080A4 40                    1628 	.db #0x40	; 64
      0080A5 7C                    1629 	.db #0x7c	; 124
      0080A6 40                    1630 	.db #0x40	; 64
      0080A7 40                    1631 	.db #0x40	; 64
      0080A8 7E                    1632 	.db #0x7e	; 126
      0080A9 00                    1633 	.db #0x00	; 0
      0080AA                       1634 __xinit__ttf_eng_f:
      0080AA 00                    1635 	.db #0x00	; 0
      0080AB 7E                    1636 	.db #0x7e	; 126
      0080AC 40                    1637 	.db #0x40	; 64
      0080AD 40                    1638 	.db #0x40	; 64
      0080AE 7C                    1639 	.db #0x7c	; 124
      0080AF 40                    1640 	.db #0x40	; 64
      0080B0 40                    1641 	.db #0x40	; 64
      0080B1 00                    1642 	.db #0x00	; 0
      0080B2                       1643 __xinit__ttf_eng_g:
      0080B2 00                    1644 	.db #0x00	; 0
      0080B3 7E                    1645 	.db #0x7e	; 126
      0080B4 42                    1646 	.db #0x42	; 66	'B'
      0080B5 40                    1647 	.db #0x40	; 64
      0080B6 4E                    1648 	.db #0x4e	; 78	'N'
      0080B7 42                    1649 	.db #0x42	; 66	'B'
      0080B8 7E                    1650 	.db #0x7e	; 126
      0080B9 00                    1651 	.db #0x00	; 0
      0080BA                       1652 __xinit__ttf_eng_h:
      0080BA 00                    1653 	.db #0x00	; 0
      0080BB 42                    1654 	.db #0x42	; 66	'B'
      0080BC 42                    1655 	.db #0x42	; 66	'B'
      0080BD 42                    1656 	.db #0x42	; 66	'B'
      0080BE 7E                    1657 	.db #0x7e	; 126
      0080BF 42                    1658 	.db #0x42	; 66	'B'
      0080C0 42                    1659 	.db #0x42	; 66	'B'
      0080C1 00                    1660 	.db #0x00	; 0
      0080C2                       1661 __xinit__ttf_eng_i:
      0080C2 00                    1662 	.db #0x00	; 0
      0080C3 7E                    1663 	.db #0x7e	; 126
      0080C4 18                    1664 	.db #0x18	; 24
      0080C5 18                    1665 	.db #0x18	; 24
      0080C6 18                    1666 	.db #0x18	; 24
      0080C7 18                    1667 	.db #0x18	; 24
      0080C8 7E                    1668 	.db #0x7e	; 126
      0080C9 00                    1669 	.db #0x00	; 0
      0080CA                       1670 __xinit__ttf_eng_j:
      0080CA 00                    1671 	.db #0x00	; 0
      0080CB 0C                    1672 	.db #0x0c	; 12
      0080CC 0C                    1673 	.db #0x0c	; 12
      0080CD 0C                    1674 	.db #0x0c	; 12
      0080CE 0C                    1675 	.db #0x0c	; 12
      0080CF 6C                    1676 	.db #0x6c	; 108	'l'
      0080D0 7C                    1677 	.db #0x7c	; 124
      0080D1 00                    1678 	.db #0x00	; 0
      0080D2                       1679 __xinit__ttf_eng_k:
      0080D2 00                    1680 	.db #0x00	; 0
      0080D3 66                    1681 	.db #0x66	; 102	'f'
      0080D4 68                    1682 	.db #0x68	; 104	'h'
      0080D5 70                    1683 	.db #0x70	; 112	'p'
      0080D6 70                    1684 	.db #0x70	; 112	'p'
      0080D7 68                    1685 	.db #0x68	; 104	'h'
      0080D8 66                    1686 	.db #0x66	; 102	'f'
      0080D9 00                    1687 	.db #0x00	; 0
      0080DA                       1688 __xinit__ttf_eng_l:
      0080DA 00                    1689 	.db #0x00	; 0
      0080DB 40                    1690 	.db #0x40	; 64
      0080DC 40                    1691 	.db #0x40	; 64
      0080DD 40                    1692 	.db #0x40	; 64
      0080DE 40                    1693 	.db #0x40	; 64
      0080DF 40                    1694 	.db #0x40	; 64
      0080E0 7E                    1695 	.db #0x7e	; 126
      0080E1 00                    1696 	.db #0x00	; 0
      0080E2                       1697 __xinit__ttf_eng_m:
      0080E2 00                    1698 	.db #0x00	; 0
      0080E3 42                    1699 	.db #0x42	; 66	'B'
      0080E4 66                    1700 	.db #0x66	; 102	'f'
      0080E5 5A                    1701 	.db #0x5a	; 90	'Z'
      0080E6 42                    1702 	.db #0x42	; 66	'B'
      0080E7 42                    1703 	.db #0x42	; 66	'B'
      0080E8 42                    1704 	.db #0x42	; 66	'B'
      0080E9 00                    1705 	.db #0x00	; 0
      0080EA                       1706 __xinit__ttf_eng_n:
      0080EA 00                    1707 	.db #0x00	; 0
      0080EB 42                    1708 	.db #0x42	; 66	'B'
      0080EC 62                    1709 	.db #0x62	; 98	'b'
      0080ED 52                    1710 	.db #0x52	; 82	'R'
      0080EE 4A                    1711 	.db #0x4a	; 74	'J'
      0080EF 46                    1712 	.db #0x46	; 70	'F'
      0080F0 42                    1713 	.db #0x42	; 66	'B'
      0080F1 00                    1714 	.db #0x00	; 0
      0080F2                       1715 __xinit__ttf_eng_o:
      0080F2 00                    1716 	.db #0x00	; 0
      0080F3 7E                    1717 	.db #0x7e	; 126
      0080F4 42                    1718 	.db #0x42	; 66	'B'
      0080F5 42                    1719 	.db #0x42	; 66	'B'
      0080F6 42                    1720 	.db #0x42	; 66	'B'
      0080F7 42                    1721 	.db #0x42	; 66	'B'
      0080F8 7E                    1722 	.db #0x7e	; 126
      0080F9 00                    1723 	.db #0x00	; 0
      0080FA                       1724 __xinit__ttf_eng_p:
      0080FA 00                    1725 	.db #0x00	; 0
      0080FB 7E                    1726 	.db #0x7e	; 126
      0080FC 42                    1727 	.db #0x42	; 66	'B'
      0080FD 42                    1728 	.db #0x42	; 66	'B'
      0080FE 7E                    1729 	.db #0x7e	; 126
      0080FF 40                    1730 	.db #0x40	; 64
      008100 40                    1731 	.db #0x40	; 64
      008101 00                    1732 	.db #0x00	; 0
      008102                       1733 __xinit__ttf_eng_q:
      008102 00                    1734 	.db #0x00	; 0
      008103 7E                    1735 	.db #0x7e	; 126
      008104 42                    1736 	.db #0x42	; 66	'B'
      008105 42                    1737 	.db #0x42	; 66	'B'
      008106 42                    1738 	.db #0x42	; 66	'B'
      008107 7E                    1739 	.db #0x7e	; 126
      008108 04                    1740 	.db #0x04	; 4
      008109 00                    1741 	.db #0x00	; 0
      00810A                       1742 __xinit__ttf_eng_r:
      00810A 00                    1743 	.db #0x00	; 0
      00810B 7E                    1744 	.db #0x7e	; 126
      00810C 42                    1745 	.db #0x42	; 66	'B'
      00810D 42                    1746 	.db #0x42	; 66	'B'
      00810E 7C                    1747 	.db #0x7c	; 124
      00810F 42                    1748 	.db #0x42	; 66	'B'
      008110 42                    1749 	.db #0x42	; 66	'B'
      008111 00                    1750 	.db #0x00	; 0
      008112                       1751 __xinit__ttf_eng_s:
      008112 00                    1752 	.db #0x00	; 0
      008113 3E                    1753 	.db #0x3e	; 62
      008114 40                    1754 	.db #0x40	; 64
      008115 3C                    1755 	.db #0x3c	; 60
      008116 02                    1756 	.db #0x02	; 2
      008117 02                    1757 	.db #0x02	; 2
      008118 7C                    1758 	.db #0x7c	; 124
      008119 00                    1759 	.db #0x00	; 0
      00811A                       1760 __xinit__ttf_eng_t:
      00811A 00                    1761 	.db #0x00	; 0
      00811B 7E                    1762 	.db #0x7e	; 126
      00811C 18                    1763 	.db #0x18	; 24
      00811D 18                    1764 	.db #0x18	; 24
      00811E 18                    1765 	.db #0x18	; 24
      00811F 18                    1766 	.db #0x18	; 24
      008120 18                    1767 	.db #0x18	; 24
      008121 00                    1768 	.db #0x00	; 0
      008122                       1769 __xinit__ttf_eng_u:
      008122 00                    1770 	.db #0x00	; 0
      008123 42                    1771 	.db #0x42	; 66	'B'
      008124 42                    1772 	.db #0x42	; 66	'B'
      008125 42                    1773 	.db #0x42	; 66	'B'
      008126 42                    1774 	.db #0x42	; 66	'B'
      008127 42                    1775 	.db #0x42	; 66	'B'
      008128 3E                    1776 	.db #0x3e	; 62
      008129 00                    1777 	.db #0x00	; 0
      00812A                       1778 __xinit__ttf_eng_v:
      00812A 00                    1779 	.db #0x00	; 0
      00812B 42                    1780 	.db #0x42	; 66	'B'
      00812C 42                    1781 	.db #0x42	; 66	'B'
      00812D 42                    1782 	.db #0x42	; 66	'B'
      00812E 24                    1783 	.db #0x24	; 36
      00812F 24                    1784 	.db #0x24	; 36
      008130 18                    1785 	.db #0x18	; 24
      008131 00                    1786 	.db #0x00	; 0
      008132                       1787 __xinit__ttf_eng_w:
      008132 00                    1788 	.db #0x00	; 0
      008133 42                    1789 	.db #0x42	; 66	'B'
      008134 42                    1790 	.db #0x42	; 66	'B'
      008135 42                    1791 	.db #0x42	; 66	'B'
      008136 5A                    1792 	.db #0x5a	; 90	'Z'
      008137 5A                    1793 	.db #0x5a	; 90	'Z'
      008138 24                    1794 	.db #0x24	; 36
      008139 00                    1795 	.db #0x00	; 0
      00813A                       1796 __xinit__ttf_eng_x:
      00813A 00                    1797 	.db #0x00	; 0
      00813B 42                    1798 	.db #0x42	; 66	'B'
      00813C 24                    1799 	.db #0x24	; 36
      00813D 18                    1800 	.db #0x18	; 24
      00813E 18                    1801 	.db #0x18	; 24
      00813F 22                    1802 	.db #0x22	; 34
      008140 42                    1803 	.db #0x42	; 66	'B'
      008141 00                    1804 	.db #0x00	; 0
      008142                       1805 __xinit__ttf_eng_y:
      008142 00                    1806 	.db #0x00	; 0
      008143 42                    1807 	.db #0x42	; 66	'B'
      008144 24                    1808 	.db #0x24	; 36
      008145 18                    1809 	.db #0x18	; 24
      008146 18                    1810 	.db #0x18	; 24
      008147 18                    1811 	.db #0x18	; 24
      008148 18                    1812 	.db #0x18	; 24
      008149 00                    1813 	.db #0x00	; 0
      00814A                       1814 __xinit__ttf_eng_z:
      00814A 00                    1815 	.db #0x00	; 0
      00814B 7E                    1816 	.db #0x7e	; 126
      00814C 04                    1817 	.db #0x04	; 4
      00814D 08                    1818 	.db #0x08	; 8
      00814E 10                    1819 	.db #0x10	; 16
      00814F 20                    1820 	.db #0x20	; 32
      008150 7E                    1821 	.db #0x7e	; 126
      008151 00                    1822 	.db #0x00	; 0
      008152                       1823 __xinit__ttf_eng_1:
      008152 00                    1824 	.db #0x00	; 0
      008153 18                    1825 	.db #0x18	; 24
      008154 38                    1826 	.db #0x38	; 56	'8'
      008155 38                    1827 	.db #0x38	; 56	'8'
      008156 18                    1828 	.db #0x18	; 24
      008157 18                    1829 	.db #0x18	; 24
      008158 18                    1830 	.db #0x18	; 24
      008159 00                    1831 	.db #0x00	; 0
      00815A                       1832 __xinit__ttf_eng_2:
      00815A 00                    1833 	.db #0x00	; 0
      00815B 38                    1834 	.db #0x38	; 56	'8'
      00815C 44                    1835 	.db #0x44	; 68	'D'
      00815D 08                    1836 	.db #0x08	; 8
      00815E 10                    1837 	.db #0x10	; 16
      00815F 20                    1838 	.db #0x20	; 32
      008160 7C                    1839 	.db #0x7c	; 124
      008161 00                    1840 	.db #0x00	; 0
      008162                       1841 __xinit__ttf_eng_3:
      008162 00                    1842 	.db #0x00	; 0
      008163 7C                    1843 	.db #0x7c	; 124
      008164 02                    1844 	.db #0x02	; 2
      008165 3C                    1845 	.db #0x3c	; 60
      008166 02                    1846 	.db #0x02	; 2
      008167 02                    1847 	.db #0x02	; 2
      008168 7C                    1848 	.db #0x7c	; 124
      008169 00                    1849 	.db #0x00	; 0
      00816A                       1850 __xinit__ttf_eng_4:
      00816A 00                    1851 	.db #0x00	; 0
      00816B 42                    1852 	.db #0x42	; 66	'B'
      00816C 42                    1853 	.db #0x42	; 66	'B'
      00816D 7E                    1854 	.db #0x7e	; 126
      00816E 02                    1855 	.db #0x02	; 2
      00816F 02                    1856 	.db #0x02	; 2
      008170 02                    1857 	.db #0x02	; 2
      008171 00                    1858 	.db #0x00	; 0
      008172                       1859 __xinit__ttf_eng_5:
      008172 00                    1860 	.db #0x00	; 0
      008173 7E                    1861 	.db #0x7e	; 126
      008174 40                    1862 	.db #0x40	; 64
      008175 7C                    1863 	.db #0x7c	; 124
      008176 02                    1864 	.db #0x02	; 2
      008177 02                    1865 	.db #0x02	; 2
      008178 7C                    1866 	.db #0x7c	; 124
      008179 00                    1867 	.db #0x00	; 0
      00817A                       1868 __xinit__ttf_eng_6:
      00817A 00                    1869 	.db #0x00	; 0
      00817B 3C                    1870 	.db #0x3c	; 60
      00817C 40                    1871 	.db #0x40	; 64
      00817D 7C                    1872 	.db #0x7c	; 124
      00817E 42                    1873 	.db #0x42	; 66	'B'
      00817F 42                    1874 	.db #0x42	; 66	'B'
      008180 3C                    1875 	.db #0x3c	; 60
      008181 00                    1876 	.db #0x00	; 0
      008182                       1877 __xinit__ttf_eng_7:
      008182 00                    1878 	.db #0x00	; 0
      008183 7E                    1879 	.db #0x7e	; 126
      008184 02                    1880 	.db #0x02	; 2
      008185 04                    1881 	.db #0x04	; 4
      008186 08                    1882 	.db #0x08	; 8
      008187 10                    1883 	.db #0x10	; 16
      008188 20                    1884 	.db #0x20	; 32
      008189 00                    1885 	.db #0x00	; 0
      00818A                       1886 __xinit__ttf_eng_8:
      00818A 00                    1887 	.db #0x00	; 0
      00818B 3C                    1888 	.db #0x3c	; 60
      00818C 42                    1889 	.db #0x42	; 66	'B'
      00818D 3C                    1890 	.db #0x3c	; 60
      00818E 42                    1891 	.db #0x42	; 66	'B'
      00818F 42                    1892 	.db #0x42	; 66	'B'
      008190 3C                    1893 	.db #0x3c	; 60
      008191 00                    1894 	.db #0x00	; 0
      008192                       1895 __xinit__ttf_eng_9:
      008192 00                    1896 	.db #0x00	; 0
      008193 3C                    1897 	.db #0x3c	; 60
      008194 42                    1898 	.db #0x42	; 66	'B'
      008195 42                    1899 	.db #0x42	; 66	'B'
      008196 3E                    1900 	.db #0x3e	; 62
      008197 02                    1901 	.db #0x02	; 2
      008198 3C                    1902 	.db #0x3c	; 60
      008199 00                    1903 	.db #0x00	; 0
      00819A                       1904 __xinit__ttf_eng_0:
      00819A 00                    1905 	.db #0x00	; 0
      00819B 3C                    1906 	.db #0x3c	; 60
      00819C 46                    1907 	.db #0x46	; 70	'F'
      00819D 4A                    1908 	.db #0x4a	; 74	'J'
      00819E 52                    1909 	.db #0x52	; 82	'R'
      00819F 62                    1910 	.db #0x62	; 98	'b'
      0081A0 3C                    1911 	.db #0x3c	; 60
      0081A1 00                    1912 	.db #0x00	; 0
      0081A2                       1913 __xinit__ttf_eng_corner_left_up:
      0081A2 FF                    1914 	.db #0xff	; 255
      0081A3 FF                    1915 	.db #0xff	; 255
      0081A4 C0                    1916 	.db #0xc0	; 192
      0081A5 C0                    1917 	.db #0xc0	; 192
      0081A6 C0                    1918 	.db #0xc0	; 192
      0081A7 C0                    1919 	.db #0xc0	; 192
      0081A8 C0                    1920 	.db #0xc0	; 192
      0081A9 C0                    1921 	.db #0xc0	; 192
      0081AA                       1922 __xinit__ttf_eng_corner_right_up:
      0081AA FF                    1923 	.db #0xff	; 255
      0081AB FF                    1924 	.db #0xff	; 255
      0081AC 03                    1925 	.db #0x03	; 3
      0081AD 03                    1926 	.db #0x03	; 3
      0081AE 03                    1927 	.db #0x03	; 3
      0081AF 03                    1928 	.db #0x03	; 3
      0081B0 03                    1929 	.db #0x03	; 3
      0081B1 03                    1930 	.db #0x03	; 3
      0081B2                       1931 __xinit__ttf_eng_corner_left_down:
      0081B2 C0                    1932 	.db #0xc0	; 192
      0081B3 C0                    1933 	.db #0xc0	; 192
      0081B4 C0                    1934 	.db #0xc0	; 192
      0081B5 C0                    1935 	.db #0xc0	; 192
      0081B6 C0                    1936 	.db #0xc0	; 192
      0081B7 C0                    1937 	.db #0xc0	; 192
      0081B8 FF                    1938 	.db #0xff	; 255
      0081B9 FF                    1939 	.db #0xff	; 255
      0081BA                       1940 __xinit__ttf_eng_corner_right_down:
      0081BA 03                    1941 	.db #0x03	; 3
      0081BB 03                    1942 	.db #0x03	; 3
      0081BC 03                    1943 	.db #0x03	; 3
      0081BD 03                    1944 	.db #0x03	; 3
      0081BE 03                    1945 	.db #0x03	; 3
      0081BF 03                    1946 	.db #0x03	; 3
      0081C0 FF                    1947 	.db #0xff	; 255
      0081C1 FF                    1948 	.db #0xff	; 255
      0081C2                       1949 __xinit__ttf_eng_line_right:
      0081C2 03                    1950 	.db #0x03	; 3
      0081C3 03                    1951 	.db #0x03	; 3
      0081C4 03                    1952 	.db #0x03	; 3
      0081C5 03                    1953 	.db #0x03	; 3
      0081C6 03                    1954 	.db #0x03	; 3
      0081C7 03                    1955 	.db #0x03	; 3
      0081C8 03                    1956 	.db #0x03	; 3
      0081C9 03                    1957 	.db #0x03	; 3
      0081CA                       1958 __xinit__ttf_eng_line_left:
      0081CA C0                    1959 	.db #0xc0	; 192
      0081CB C0                    1960 	.db #0xc0	; 192
      0081CC C0                    1961 	.db #0xc0	; 192
      0081CD C0                    1962 	.db #0xc0	; 192
      0081CE C0                    1963 	.db #0xc0	; 192
      0081CF C0                    1964 	.db #0xc0	; 192
      0081D0 C0                    1965 	.db #0xc0	; 192
      0081D1 C0                    1966 	.db #0xc0	; 192
      0081D2                       1967 __xinit__ttf_eng_line_up:
      0081D2 FF                    1968 	.db #0xff	; 255
      0081D3 FF                    1969 	.db #0xff	; 255
      0081D4 00                    1970 	.db #0x00	; 0
      0081D5 00                    1971 	.db #0x00	; 0
      0081D6 00                    1972 	.db #0x00	; 0
      0081D7 00                    1973 	.db #0x00	; 0
      0081D8 00                    1974 	.db #0x00	; 0
      0081D9 00                    1975 	.db #0x00	; 0
      0081DA                       1976 __xinit__ttf_eng_line_down:
      0081DA 00                    1977 	.db #0x00	; 0
      0081DB 00                    1978 	.db #0x00	; 0
      0081DC 00                    1979 	.db #0x00	; 0
      0081DD 00                    1980 	.db #0x00	; 0
      0081DE 00                    1981 	.db #0x00	; 0
      0081DF 00                    1982 	.db #0x00	; 0
      0081E0 FF                    1983 	.db #0xff	; 255
      0081E1 FF                    1984 	.db #0xff	; 255
      0081E2                       1985 __xinit__main_buffer:
      0081E2 FF                    1986 	.db #0xff	; 255
      0081E3 01                    1987 	.db #0x01	; 1
      0081E4 01                    1988 	.db #0x01	; 1
      0081E5 01                    1989 	.db #0x01	; 1
      0081E6 01                    1990 	.db #0x01	; 1
      0081E7 01                    1991 	.db #0x01	; 1
      0081E8 01                    1992 	.db #0x01	; 1
      0081E9 01                    1993 	.db #0x01	; 1
      0081EA FD                    1994 	.db #0xfd	; 253
      0081EB FD                    1995 	.db #0xfd	; 253
      0081EC FD                    1996 	.db #0xfd	; 253
      0081ED FD                    1997 	.db #0xfd	; 253
      0081EE FD                    1998 	.db #0xfd	; 253
      0081EF FD                    1999 	.db #0xfd	; 253
      0081F0 FD                    2000 	.db #0xfd	; 253
      0081F1 01                    2001 	.db #0x01	; 1
      0081F2 01                    2002 	.db #0x01	; 1
      0081F3 01                    2003 	.db #0x01	; 1
      0081F4 01                    2004 	.db #0x01	; 1
      0081F5 01                    2005 	.db #0x01	; 1
      0081F6 01                    2006 	.db #0x01	; 1
      0081F7 01                    2007 	.db #0x01	; 1
      0081F8 FD                    2008 	.db #0xfd	; 253
      0081F9 FD                    2009 	.db #0xfd	; 253
      0081FA FD                    2010 	.db #0xfd	; 253
      0081FB FD                    2011 	.db #0xfd	; 253
      0081FC FD                    2012 	.db #0xfd	; 253
      0081FD FD                    2013 	.db #0xfd	; 253
      0081FE FD                    2014 	.db #0xfd	; 253
      0081FF FD                    2015 	.db #0xfd	; 253
      008200 FD                    2016 	.db #0xfd	; 253
      008201 FD                    2017 	.db #0xfd	; 253
      008202 FD                    2018 	.db #0xfd	; 253
      008203 FD                    2019 	.db #0xfd	; 253
      008204 FD                    2020 	.db #0xfd	; 253
      008205 FD                    2021 	.db #0xfd	; 253
      008206 FD                    2022 	.db #0xfd	; 253
      008207 FD                    2023 	.db #0xfd	; 253
      008208 FD                    2024 	.db #0xfd	; 253
      008209 FD                    2025 	.db #0xfd	; 253
      00820A FD                    2026 	.db #0xfd	; 253
      00820B FD                    2027 	.db #0xfd	; 253
      00820C FD                    2028 	.db #0xfd	; 253
      00820D FD                    2029 	.db #0xfd	; 253
      00820E FD                    2030 	.db #0xfd	; 253
      00820F FD                    2031 	.db #0xfd	; 253
      008210 FD                    2032 	.db #0xfd	; 253
      008211 FD                    2033 	.db #0xfd	; 253
      008212 FD                    2034 	.db #0xfd	; 253
      008213 FD                    2035 	.db #0xfd	; 253
      008214 FD                    2036 	.db #0xfd	; 253
      008215 FD                    2037 	.db #0xfd	; 253
      008216 FD                    2038 	.db #0xfd	; 253
      008217 FD                    2039 	.db #0xfd	; 253
      008218 FD                    2040 	.db #0xfd	; 253
      008219 FD                    2041 	.db #0xfd	; 253
      00821A FD                    2042 	.db #0xfd	; 253
      00821B 01                    2043 	.db #0x01	; 1
      00821C 01                    2044 	.db #0x01	; 1
      00821D 01                    2045 	.db #0x01	; 1
      00821E 01                    2046 	.db #0x01	; 1
      00821F 01                    2047 	.db #0x01	; 1
      008220 01                    2048 	.db #0x01	; 1
      008221 01                    2049 	.db #0x01	; 1
      008222 FD                    2050 	.db #0xfd	; 253
      008223 FD                    2051 	.db #0xfd	; 253
      008224 FD                    2052 	.db #0xfd	; 253
      008225 FD                    2053 	.db #0xfd	; 253
      008226 FD                    2054 	.db #0xfd	; 253
      008227 FD                    2055 	.db #0xfd	; 253
      008228 FD                    2056 	.db #0xfd	; 253
      008229 FD                    2057 	.db #0xfd	; 253
      00822A FD                    2058 	.db #0xfd	; 253
      00822B FD                    2059 	.db #0xfd	; 253
      00822C FD                    2060 	.db #0xfd	; 253
      00822D FD                    2061 	.db #0xfd	; 253
      00822E FD                    2062 	.db #0xfd	; 253
      00822F FD                    2063 	.db #0xfd	; 253
      008230 FD                    2064 	.db #0xfd	; 253
      008231 FD                    2065 	.db #0xfd	; 253
      008232 FD                    2066 	.db #0xfd	; 253
      008233 FD                    2067 	.db #0xfd	; 253
      008234 FD                    2068 	.db #0xfd	; 253
      008235 FD                    2069 	.db #0xfd	; 253
      008236 FD                    2070 	.db #0xfd	; 253
      008237 01                    2071 	.db #0x01	; 1
      008238 01                    2072 	.db #0x01	; 1
      008239 01                    2073 	.db #0x01	; 1
      00823A 01                    2074 	.db #0x01	; 1
      00823B 01                    2075 	.db #0x01	; 1
      00823C 01                    2076 	.db #0x01	; 1
      00823D 01                    2077 	.db #0x01	; 1
      00823E 01                    2078 	.db #0x01	; 1
      00823F 01                    2079 	.db #0x01	; 1
      008240 01                    2080 	.db #0x01	; 1
      008241 01                    2081 	.db #0x01	; 1
      008242 01                    2082 	.db #0x01	; 1
      008243 01                    2083 	.db #0x01	; 1
      008244 01                    2084 	.db #0x01	; 1
      008245 3D                    2085 	.db #0x3d	; 61
      008246 15                    2086 	.db #0x15	; 21
      008247 3D                    2087 	.db #0x3d	; 61
      008248 01                    2088 	.db #0x01	; 1
      008249 3D                    2089 	.db #0x3d	; 61
      00824A 21                    2090 	.db #0x21	; 33
      00824B 21                    2091 	.db #0x21	; 33
      00824C 01                    2092 	.db #0x01	; 1
      00824D 3D                    2093 	.db #0x3d	; 61
      00824E 15                    2094 	.db #0x15	; 21
      00824F 1D                    2095 	.db #0x1d	; 29
      008250 01                    2096 	.db #0x01	; 1
      008251 3D                    2097 	.db #0x3d	; 61
      008252 11                    2098 	.db #0x11	; 17
      008253 3D                    2099 	.db #0x3d	; 61
      008254 01                    2100 	.db #0x01	; 1
      008255 3D                    2101 	.db #0x3d	; 61
      008256 15                    2102 	.db #0x15	; 21
      008257 3D                    2103 	.db #0x3d	; 61
      008258 01                    2104 	.db #0x01	; 1
      008259 01                    2105 	.db #0x01	; 1
      00825A 3D                    2106 	.db #0x3d	; 61
      00825B 25                    2107 	.db #0x25	; 37
      00825C 3D                    2108 	.db #0x3d	; 61
      00825D 01                    2109 	.db #0x01	; 1
      00825E 05                    2110 	.db #0x05	; 5
      00825F 3D                    2111 	.db #0x3d	; 61
      008260 01                    2112 	.db #0x01	; 1
      008261 FF                    2113 	.db #0xff	; 255
      008262 FF                    2114 	.db #0xff	; 255
      008263 00                    2115 	.db #0x00	; 0
      008264 00                    2116 	.db #0x00	; 0
      008265 00                    2117 	.db #0x00	; 0
      008266 00                    2118 	.db #0x00	; 0
      008267 00                    2119 	.db #0x00	; 0
      008268 00                    2120 	.db #0x00	; 0
      008269 00                    2121 	.db #0x00	; 0
      00826A FF                    2122 	.db #0xff	; 255
      00826B FF                    2123 	.db #0xff	; 255
      00826C FF                    2124 	.db #0xff	; 255
      00826D FF                    2125 	.db #0xff	; 255
      00826E FF                    2126 	.db #0xff	; 255
      00826F FF                    2127 	.db #0xff	; 255
      008270 FF                    2128 	.db #0xff	; 255
      008271 FE                    2129 	.db #0xfe	; 254
      008272 FE                    2130 	.db #0xfe	; 254
      008273 FE                    2131 	.db #0xfe	; 254
      008274 FE                    2132 	.db #0xfe	; 254
      008275 FE                    2133 	.db #0xfe	; 254
      008276 FE                    2134 	.db #0xfe	; 254
      008277 FE                    2135 	.db #0xfe	; 254
      008278 FF                    2136 	.db #0xff	; 255
      008279 FF                    2137 	.db #0xff	; 255
      00827A FF                    2138 	.db #0xff	; 255
      00827B FF                    2139 	.db #0xff	; 255
      00827C FF                    2140 	.db #0xff	; 255
      00827D FF                    2141 	.db #0xff	; 255
      00827E FF                    2142 	.db #0xff	; 255
      00827F 01                    2143 	.db #0x01	; 1
      008280 01                    2144 	.db #0x01	; 1
      008281 01                    2145 	.db #0x01	; 1
      008282 01                    2146 	.db #0x01	; 1
      008283 01                    2147 	.db #0x01	; 1
      008284 01                    2148 	.db #0x01	; 1
      008285 01                    2149 	.db #0x01	; 1
      008286 FF                    2150 	.db #0xff	; 255
      008287 FF                    2151 	.db #0xff	; 255
      008288 FF                    2152 	.db #0xff	; 255
      008289 FF                    2153 	.db #0xff	; 255
      00828A FF                    2154 	.db #0xff	; 255
      00828B FF                    2155 	.db #0xff	; 255
      00828C FF                    2156 	.db #0xff	; 255
      00828D 01                    2157 	.db #0x01	; 1
      00828E 01                    2158 	.db #0x01	; 1
      00828F 01                    2159 	.db #0x01	; 1
      008290 01                    2160 	.db #0x01	; 1
      008291 01                    2161 	.db #0x01	; 1
      008292 01                    2162 	.db #0x01	; 1
      008293 01                    2163 	.db #0x01	; 1
      008294 FF                    2164 	.db #0xff	; 255
      008295 FF                    2165 	.db #0xff	; 255
      008296 FF                    2166 	.db #0xff	; 255
      008297 FF                    2167 	.db #0xff	; 255
      008298 FF                    2168 	.db #0xff	; 255
      008299 FF                    2169 	.db #0xff	; 255
      00829A FF                    2170 	.db #0xff	; 255
      00829B 00                    2171 	.db #0x00	; 0
      00829C 00                    2172 	.db #0x00	; 0
      00829D 00                    2173 	.db #0x00	; 0
      00829E 00                    2174 	.db #0x00	; 0
      00829F 00                    2175 	.db #0x00	; 0
      0082A0 00                    2176 	.db #0x00	; 0
      0082A1 00                    2177 	.db #0x00	; 0
      0082A2 FF                    2178 	.db #0xff	; 255
      0082A3 FF                    2179 	.db #0xff	; 255
      0082A4 FF                    2180 	.db #0xff	; 255
      0082A5 FF                    2181 	.db #0xff	; 255
      0082A6 FF                    2182 	.db #0xff	; 255
      0082A7 FF                    2183 	.db #0xff	; 255
      0082A8 FF                    2184 	.db #0xff	; 255
      0082A9 01                    2185 	.db #0x01	; 1
      0082AA 01                    2186 	.db #0x01	; 1
      0082AB 01                    2187 	.db #0x01	; 1
      0082AC 01                    2188 	.db #0x01	; 1
      0082AD 01                    2189 	.db #0x01	; 1
      0082AE 01                    2190 	.db #0x01	; 1
      0082AF 01                    2191 	.db #0x01	; 1
      0082B0 FF                    2192 	.db #0xff	; 255
      0082B1 FF                    2193 	.db #0xff	; 255
      0082B2 FF                    2194 	.db #0xff	; 255
      0082B3 FF                    2195 	.db #0xff	; 255
      0082B4 FF                    2196 	.db #0xff	; 255
      0082B5 FF                    2197 	.db #0xff	; 255
      0082B6 FF                    2198 	.db #0xff	; 255
      0082B7 00                    2199 	.db #0x00	; 0
      0082B8 00                    2200 	.db #0x00	; 0
      0082B9 00                    2201 	.db #0x00	; 0
      0082BA 00                    2202 	.db #0x00	; 0
      0082BB 00                    2203 	.db #0x00	; 0
      0082BC 00                    2204 	.db #0x00	; 0
      0082BD 00                    2205 	.db #0x00	; 0
      0082BE 00                    2206 	.db #0x00	; 0
      0082BF 00                    2207 	.db #0x00	; 0
      0082C0 00                    2208 	.db #0x00	; 0
      0082C1 00                    2209 	.db #0x00	; 0
      0082C2 00                    2210 	.db #0x00	; 0
      0082C3 00                    2211 	.db #0x00	; 0
      0082C4 00                    2212 	.db #0x00	; 0
      0082C5 00                    2213 	.db #0x00	; 0
      0082C6 00                    2214 	.db #0x00	; 0
      0082C7 00                    2215 	.db #0x00	; 0
      0082C8 00                    2216 	.db #0x00	; 0
      0082C9 00                    2217 	.db #0x00	; 0
      0082CA 00                    2218 	.db #0x00	; 0
      0082CB 00                    2219 	.db #0x00	; 0
      0082CC 00                    2220 	.db #0x00	; 0
      0082CD 00                    2221 	.db #0x00	; 0
      0082CE 00                    2222 	.db #0x00	; 0
      0082CF 00                    2223 	.db #0x00	; 0
      0082D0 00                    2224 	.db #0x00	; 0
      0082D1 00                    2225 	.db #0x00	; 0
      0082D2 00                    2226 	.db #0x00	; 0
      0082D3 00                    2227 	.db #0x00	; 0
      0082D4 00                    2228 	.db #0x00	; 0
      0082D5 00                    2229 	.db #0x00	; 0
      0082D6 00                    2230 	.db #0x00	; 0
      0082D7 00                    2231 	.db #0x00	; 0
      0082D8 00                    2232 	.db #0x00	; 0
      0082D9 00                    2233 	.db #0x00	; 0
      0082DA 00                    2234 	.db #0x00	; 0
      0082DB 00                    2235 	.db #0x00	; 0
      0082DC 00                    2236 	.db #0x00	; 0
      0082DD 00                    2237 	.db #0x00	; 0
      0082DE 00                    2238 	.db #0x00	; 0
      0082DF 00                    2239 	.db #0x00	; 0
      0082E0 00                    2240 	.db #0x00	; 0
      0082E1 FF                    2241 	.db #0xff	; 255
      0082E2 FF                    2242 	.db #0xff	; 255
      0082E3 00                    2243 	.db #0x00	; 0
      0082E4 00                    2244 	.db #0x00	; 0
      0082E5 00                    2245 	.db #0x00	; 0
      0082E6 00                    2246 	.db #0x00	; 0
      0082E7 00                    2247 	.db #0x00	; 0
      0082E8 00                    2248 	.db #0x00	; 0
      0082E9 00                    2249 	.db #0x00	; 0
      0082EA FF                    2250 	.db #0xff	; 255
      0082EB FF                    2251 	.db #0xff	; 255
      0082EC FF                    2252 	.db #0xff	; 255
      0082ED FF                    2253 	.db #0xff	; 255
      0082EE FF                    2254 	.db #0xff	; 255
      0082EF FF                    2255 	.db #0xff	; 255
      0082F0 FF                    2256 	.db #0xff	; 255
      0082F1 00                    2257 	.db #0x00	; 0
      0082F2 00                    2258 	.db #0x00	; 0
      0082F3 00                    2259 	.db #0x00	; 0
      0082F4 00                    2260 	.db #0x00	; 0
      0082F5 00                    2261 	.db #0x00	; 0
      0082F6 00                    2262 	.db #0x00	; 0
      0082F7 00                    2263 	.db #0x00	; 0
      0082F8 FF                    2264 	.db #0xff	; 255
      0082F9 FF                    2265 	.db #0xff	; 255
      0082FA FF                    2266 	.db #0xff	; 255
      0082FB FF                    2267 	.db #0xff	; 255
      0082FC FF                    2268 	.db #0xff	; 255
      0082FD FF                    2269 	.db #0xff	; 255
      0082FE FF                    2270 	.db #0xff	; 255
      0082FF 00                    2271 	.db #0x00	; 0
      008300 00                    2272 	.db #0x00	; 0
      008301 00                    2273 	.db #0x00	; 0
      008302 00                    2274 	.db #0x00	; 0
      008303 00                    2275 	.db #0x00	; 0
      008304 00                    2276 	.db #0x00	; 0
      008305 00                    2277 	.db #0x00	; 0
      008306 FF                    2278 	.db #0xff	; 255
      008307 FF                    2279 	.db #0xff	; 255
      008308 FF                    2280 	.db #0xff	; 255
      008309 FF                    2281 	.db #0xff	; 255
      00830A FF                    2282 	.db #0xff	; 255
      00830B FF                    2283 	.db #0xff	; 255
      00830C FF                    2284 	.db #0xff	; 255
      00830D 00                    2285 	.db #0x00	; 0
      00830E 00                    2286 	.db #0x00	; 0
      00830F 00                    2287 	.db #0x00	; 0
      008310 00                    2288 	.db #0x00	; 0
      008311 00                    2289 	.db #0x00	; 0
      008312 00                    2290 	.db #0x00	; 0
      008313 00                    2291 	.db #0x00	; 0
      008314 FF                    2292 	.db #0xff	; 255
      008315 FF                    2293 	.db #0xff	; 255
      008316 FF                    2294 	.db #0xff	; 255
      008317 FF                    2295 	.db #0xff	; 255
      008318 FF                    2296 	.db #0xff	; 255
      008319 FF                    2297 	.db #0xff	; 255
      00831A FF                    2298 	.db #0xff	; 255
      00831B 7F                    2299 	.db #0x7f	; 127
      00831C 7F                    2300 	.db #0x7f	; 127
      00831D 7F                    2301 	.db #0x7f	; 127
      00831E 7F                    2302 	.db #0x7f	; 127
      00831F 7F                    2303 	.db #0x7f	; 127
      008320 7F                    2304 	.db #0x7f	; 127
      008321 7F                    2305 	.db #0x7f	; 127
      008322 FF                    2306 	.db #0xff	; 255
      008323 FF                    2307 	.db #0xff	; 255
      008324 FF                    2308 	.db #0xff	; 255
      008325 FF                    2309 	.db #0xff	; 255
      008326 FF                    2310 	.db #0xff	; 255
      008327 FF                    2311 	.db #0xff	; 255
      008328 FF                    2312 	.db #0xff	; 255
      008329 7F                    2313 	.db #0x7f	; 127
      00832A 7F                    2314 	.db #0x7f	; 127
      00832B 7F                    2315 	.db #0x7f	; 127
      00832C 7F                    2316 	.db #0x7f	; 127
      00832D 7F                    2317 	.db #0x7f	; 127
      00832E 7F                    2318 	.db #0x7f	; 127
      00832F 7F                    2319 	.db #0x7f	; 127
      008330 80                    2320 	.db #0x80	; 128
      008331 80                    2321 	.db #0x80	; 128
      008332 80                    2322 	.db #0x80	; 128
      008333 80                    2323 	.db #0x80	; 128
      008334 80                    2324 	.db #0x80	; 128
      008335 80                    2325 	.db #0x80	; 128
      008336 80                    2326 	.db #0x80	; 128
      008337 00                    2327 	.db #0x00	; 0
      008338 00                    2328 	.db #0x00	; 0
      008339 00                    2329 	.db #0x00	; 0
      00833A 80                    2330 	.db #0x80	; 128
      00833B 80                    2331 	.db #0x80	; 128
      00833C 80                    2332 	.db #0x80	; 128
      00833D 80                    2333 	.db #0x80	; 128
      00833E 80                    2334 	.db #0x80	; 128
      00833F 80                    2335 	.db #0x80	; 128
      008340 80                    2336 	.db #0x80	; 128
      008341 00                    2337 	.db #0x00	; 0
      008342 00                    2338 	.db #0x00	; 0
      008343 00                    2339 	.db #0x00	; 0
      008344 00                    2340 	.db #0x00	; 0
      008345 00                    2341 	.db #0x00	; 0
      008346 00                    2342 	.db #0x00	; 0
      008347 00                    2343 	.db #0x00	; 0
      008348 00                    2344 	.db #0x00	; 0
      008349 00                    2345 	.db #0x00	; 0
      00834A 00                    2346 	.db #0x00	; 0
      00834B 00                    2347 	.db #0x00	; 0
      00834C 00                    2348 	.db #0x00	; 0
      00834D 00                    2349 	.db #0x00	; 0
      00834E 00                    2350 	.db #0x00	; 0
      00834F 00                    2351 	.db #0x00	; 0
      008350 00                    2352 	.db #0x00	; 0
      008351 00                    2353 	.db #0x00	; 0
      008352 00                    2354 	.db #0x00	; 0
      008353 00                    2355 	.db #0x00	; 0
      008354 00                    2356 	.db #0x00	; 0
      008355 00                    2357 	.db #0x00	; 0
      008356 00                    2358 	.db #0x00	; 0
      008357 00                    2359 	.db #0x00	; 0
      008358 00                    2360 	.db #0x00	; 0
      008359 00                    2361 	.db #0x00	; 0
      00835A 00                    2362 	.db #0x00	; 0
      00835B 00                    2363 	.db #0x00	; 0
      00835C 00                    2364 	.db #0x00	; 0
      00835D 00                    2365 	.db #0x00	; 0
      00835E 00                    2366 	.db #0x00	; 0
      00835F 00                    2367 	.db #0x00	; 0
      008360 00                    2368 	.db #0x00	; 0
      008361 FF                    2369 	.db #0xff	; 255
      008362 FF                    2370 	.db #0xff	; 255
      008363 80                    2371 	.db #0x80	; 128
      008364 80                    2372 	.db #0x80	; 128
      008365 80                    2373 	.db #0x80	; 128
      008366 80                    2374 	.db #0x80	; 128
      008367 80                    2375 	.db #0x80	; 128
      008368 80                    2376 	.db #0x80	; 128
      008369 80                    2377 	.db #0x80	; 128
      00836A BF                    2378 	.db #0xbf	; 191
      00836B BF                    2379 	.db #0xbf	; 191
      00836C BF                    2380 	.db #0xbf	; 191
      00836D BF                    2381 	.db #0xbf	; 191
      00836E BF                    2382 	.db #0xbf	; 191
      00836F BF                    2383 	.db #0xbf	; 191
      008370 BF                    2384 	.db #0xbf	; 191
      008371 80                    2385 	.db #0x80	; 128
      008372 80                    2386 	.db #0x80	; 128
      008373 80                    2387 	.db #0x80	; 128
      008374 80                    2388 	.db #0x80	; 128
      008375 80                    2389 	.db #0x80	; 128
      008376 80                    2390 	.db #0x80	; 128
      008377 80                    2391 	.db #0x80	; 128
      008378 BF                    2392 	.db #0xbf	; 191
      008379 BF                    2393 	.db #0xbf	; 191
      00837A BF                    2394 	.db #0xbf	; 191
      00837B BF                    2395 	.db #0xbf	; 191
      00837C BF                    2396 	.db #0xbf	; 191
      00837D BF                    2397 	.db #0xbf	; 191
      00837E BF                    2398 	.db #0xbf	; 191
      00837F 80                    2399 	.db #0x80	; 128
      008380 80                    2400 	.db #0x80	; 128
      008381 80                    2401 	.db #0x80	; 128
      008382 80                    2402 	.db #0x80	; 128
      008383 80                    2403 	.db #0x80	; 128
      008384 80                    2404 	.db #0x80	; 128
      008385 80                    2405 	.db #0x80	; 128
      008386 BF                    2406 	.db #0xbf	; 191
      008387 BF                    2407 	.db #0xbf	; 191
      008388 BF                    2408 	.db #0xbf	; 191
      008389 BF                    2409 	.db #0xbf	; 191
      00838A BF                    2410 	.db #0xbf	; 191
      00838B BF                    2411 	.db #0xbf	; 191
      00838C BF                    2412 	.db #0xbf	; 191
      00838D 80                    2413 	.db #0x80	; 128
      00838E 80                    2414 	.db #0x80	; 128
      00838F 80                    2415 	.db #0x80	; 128
      008390 80                    2416 	.db #0x80	; 128
      008391 80                    2417 	.db #0x80	; 128
      008392 80                    2418 	.db #0x80	; 128
      008393 80                    2419 	.db #0x80	; 128
      008394 BF                    2420 	.db #0xbf	; 191
      008395 BF                    2421 	.db #0xbf	; 191
      008396 BF                    2422 	.db #0xbf	; 191
      008397 BF                    2423 	.db #0xbf	; 191
      008398 BF                    2424 	.db #0xbf	; 191
      008399 BF                    2425 	.db #0xbf	; 191
      00839A BF                    2426 	.db #0xbf	; 191
      00839B 80                    2427 	.db #0x80	; 128
      00839C 80                    2428 	.db #0x80	; 128
      00839D 80                    2429 	.db #0x80	; 128
      00839E 80                    2430 	.db #0x80	; 128
      00839F 80                    2431 	.db #0x80	; 128
      0083A0 80                    2432 	.db #0x80	; 128
      0083A1 80                    2433 	.db #0x80	; 128
      0083A2 BF                    2434 	.db #0xbf	; 191
      0083A3 BF                    2435 	.db #0xbf	; 191
      0083A4 BF                    2436 	.db #0xbf	; 191
      0083A5 BF                    2437 	.db #0xbf	; 191
      0083A6 BF                    2438 	.db #0xbf	; 191
      0083A7 BF                    2439 	.db #0xbf	; 191
      0083A8 BF                    2440 	.db #0xbf	; 191
      0083A9 80                    2441 	.db #0x80	; 128
      0083AA 80                    2442 	.db #0x80	; 128
      0083AB 80                    2443 	.db #0x80	; 128
      0083AC 80                    2444 	.db #0x80	; 128
      0083AD 80                    2445 	.db #0x80	; 128
      0083AE 80                    2446 	.db #0x80	; 128
      0083AF 80                    2447 	.db #0x80	; 128
      0083B0 BF                    2448 	.db #0xbf	; 191
      0083B1 BF                    2449 	.db #0xbf	; 191
      0083B2 BF                    2450 	.db #0xbf	; 191
      0083B3 BF                    2451 	.db #0xbf	; 191
      0083B4 BF                    2452 	.db #0xbf	; 191
      0083B5 BF                    2453 	.db #0xbf	; 191
      0083B6 BF                    2454 	.db #0xbf	; 191
      0083B7 80                    2455 	.db #0x80	; 128
      0083B8 80                    2456 	.db #0x80	; 128
      0083B9 80                    2457 	.db #0x80	; 128
      0083BA B1                    2458 	.db #0xb1	; 177
      0083BB B1                    2459 	.db #0xb1	; 177
      0083BC BF                    2460 	.db #0xbf	; 191
      0083BD BF                    2461 	.db #0xbf	; 191
      0083BE BF                    2462 	.db #0xbf	; 191
      0083BF B1                    2463 	.db #0xb1	; 177
      0083C0 B1                    2464 	.db #0xb1	; 177
      0083C1 80                    2465 	.db #0x80	; 128
      0083C2 80                    2466 	.db #0x80	; 128
      0083C3 BF                    2467 	.db #0xbf	; 191
      0083C4 BF                    2468 	.db #0xbf	; 191
      0083C5 83                    2469 	.db #0x83	; 131
      0083C6 83                    2470 	.db #0x83	; 131
      0083C7 BF                    2471 	.db #0xbf	; 191
      0083C8 BE                    2472 	.db #0xbe	; 190
      0083C9 80                    2473 	.db #0x80	; 128
      0083CA 80                    2474 	.db #0x80	; 128
      0083CB BF                    2475 	.db #0xbf	; 191
      0083CC BF                    2476 	.db #0xbf	; 191
      0083CD B3                    2477 	.db #0xb3	; 179
      0083CE B3                    2478 	.db #0xb3	; 179
      0083CF B3                    2479 	.db #0xb3	; 179
      0083D0 B3                    2480 	.db #0xb3	; 179
      0083D1 80                    2481 	.db #0x80	; 128
      0083D2 80                    2482 	.db #0x80	; 128
      0083D3 80                    2483 	.db #0x80	; 128
      0083D4 80                    2484 	.db #0x80	; 128
      0083D5 B0                    2485 	.db #0xb0	; 176
      0083D6 B0                    2486 	.db #0xb0	; 176
      0083D7 80                    2487 	.db #0x80	; 128
      0083D8 80                    2488 	.db #0x80	; 128
      0083D9 80                    2489 	.db #0x80	; 128
      0083DA 80                    2490 	.db #0x80	; 128
      0083DB 80                    2491 	.db #0x80	; 128
      0083DC 80                    2492 	.db #0x80	; 128
      0083DD 80                    2493 	.db #0x80	; 128
      0083DE 80                    2494 	.db #0x80	; 128
      0083DF 80                    2495 	.db #0x80	; 128
      0083E0 80                    2496 	.db #0x80	; 128
      0083E1 FF                    2497 	.db #0xff	; 255
                                   2498 	.area CABS (ABS)
