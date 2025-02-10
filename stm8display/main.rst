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
                                     14 	.globl _tmr2_irq
                                     15 	.globl _menu_set_paragraph
                                     16 	.globl _menu_set_item_menu
                                     17 	.globl _menu_border_splash
                                     18 	.globl _menu_border
                                     19 	.globl _ssd1306_send_buffer
                                     20 	.globl _ssd1306_buffer_clean
                                     21 	.globl _set_bit
                                     22 	.globl _get_bit
                                     23 	.globl _i2c_irq
                                     24 	.globl _memset
                                     25 	.globl _TIM2_IRQ
                                     26 	.globl _paragraph_item
                                     27 	.globl _current_item
                                     28 	.globl _main_buffer
                                     29 	.globl _ttf_eng_line_down
                                     30 	.globl _ttf_eng_line_up
                                     31 	.globl _ttf_eng_line_left
                                     32 	.globl _ttf_eng_line_right
                                     33 	.globl _ttf_eng_corner_right_down
                                     34 	.globl _ttf_eng_corner_left_down
                                     35 	.globl _ttf_eng_corner_right_up
                                     36 	.globl _ttf_eng_corner_left_up
                                     37 	.globl _ttf_eng_0
                                     38 	.globl _ttf_eng_9
                                     39 	.globl _ttf_eng_8
                                     40 	.globl _ttf_eng_7
                                     41 	.globl _ttf_eng_6
                                     42 	.globl _ttf_eng_5
                                     43 	.globl _ttf_eng_4
                                     44 	.globl _ttf_eng_3
                                     45 	.globl _ttf_eng_2
                                     46 	.globl _ttf_eng_1
                                     47 	.globl _ttf_eng_z
                                     48 	.globl _ttf_eng_y
                                     49 	.globl _ttf_eng_x
                                     50 	.globl _ttf_eng_w
                                     51 	.globl _ttf_eng_v
                                     52 	.globl _ttf_eng_u
                                     53 	.globl _ttf_eng_t
                                     54 	.globl _ttf_eng_s
                                     55 	.globl _ttf_eng_r
                                     56 	.globl _ttf_eng_q
                                     57 	.globl _ttf_eng_p
                                     58 	.globl _ttf_eng_o
                                     59 	.globl _ttf_eng_n
                                     60 	.globl _ttf_eng_m
                                     61 	.globl _ttf_eng_l
                                     62 	.globl _ttf_eng_k
                                     63 	.globl _ttf_eng_j
                                     64 	.globl _ttf_eng_i
                                     65 	.globl _ttf_eng_h
                                     66 	.globl _ttf_eng_g
                                     67 	.globl _ttf_eng_f
                                     68 	.globl _ttf_eng_e
                                     69 	.globl _ttf_eng_d
                                     70 	.globl _ttf_eng_c
                                     71 	.globl _ttf_eng_b
                                     72 	.globl _ttf_eng_a
                                     73 	.globl _ttf_eng_void
                                     74 	.globl _I2C_IRQ
                                     75 	.globl _buf_size
                                     76 	.globl _buf_pos
                                     77 	.globl _rx_buf_pointer
                                     78 	.globl _tx_buf_pointer
                                     79 	.globl _uart_transmission_irq
                                     80 	.globl _uart_reciever_irq
                                     81 	.globl _uart_write_irq
                                     82 	.globl _uart_read_irq
                                     83 	.globl _uart_init
                                     84 	.globl _uart_read_byte
                                     85 	.globl _uart_write_byte
                                     86 	.globl _uart_write
                                     87 	.globl _uart_read
                                     88 	.globl _i2c_init
                                     89 	.globl _i2c_start
                                     90 	.globl _i2c_stop
                                     91 	.globl _i2c_send_address
                                     92 	.globl _i2c_read_byte
                                     93 	.globl _i2c_read
                                     94 	.globl _i2c_send_byte
                                     95 	.globl _i2c_write
                                     96 	.globl _i2c_scan
                                     97 	.globl _i2c_start_irq
                                     98 	.globl _i2c_stop_irq
                                     99 	.globl _ssd1306_init
                                    100 	.globl _ssd1306_set_params_to_write
                                    101 	.globl _ssd1306_draw_pixel
                                    102 	.globl _ssd1306_buffer_write
                                    103 	.globl _ssd1306_clean
                                    104 	.globl _delay_s
                                    105 	.globl _delay_ms
                                    106 ;--------------------------------------------------------
                                    107 ; ram data
                                    108 ;--------------------------------------------------------
                                    109 	.area DATA
      000001                        110 _tx_buf_pointer::
      000001                        111 	.ds 2
      000003                        112 _rx_buf_pointer::
      000003                        113 	.ds 2
      000005                        114 _buf_pos::
      000005                        115 	.ds 1
      000006                        116 _buf_size::
      000006                        117 	.ds 1
                                    118 ;--------------------------------------------------------
                                    119 ; ram data
                                    120 ;--------------------------------------------------------
                                    121 	.area INITIALIZED
      000007                        122 _I2C_IRQ::
      000007                        123 	.ds 1
      000008                        124 _ttf_eng_void::
      000008                        125 	.ds 8
      000010                        126 _ttf_eng_a::
      000010                        127 	.ds 8
      000018                        128 _ttf_eng_b::
      000018                        129 	.ds 8
      000020                        130 _ttf_eng_c::
      000020                        131 	.ds 8
      000028                        132 _ttf_eng_d::
      000028                        133 	.ds 8
      000030                        134 _ttf_eng_e::
      000030                        135 	.ds 8
      000038                        136 _ttf_eng_f::
      000038                        137 	.ds 8
      000040                        138 _ttf_eng_g::
      000040                        139 	.ds 8
      000048                        140 _ttf_eng_h::
      000048                        141 	.ds 8
      000050                        142 _ttf_eng_i::
      000050                        143 	.ds 8
      000058                        144 _ttf_eng_j::
      000058                        145 	.ds 8
      000060                        146 _ttf_eng_k::
      000060                        147 	.ds 8
      000068                        148 _ttf_eng_l::
      000068                        149 	.ds 8
      000070                        150 _ttf_eng_m::
      000070                        151 	.ds 8
      000078                        152 _ttf_eng_n::
      000078                        153 	.ds 8
      000080                        154 _ttf_eng_o::
      000080                        155 	.ds 8
      000088                        156 _ttf_eng_p::
      000088                        157 	.ds 8
      000090                        158 _ttf_eng_q::
      000090                        159 	.ds 8
      000098                        160 _ttf_eng_r::
      000098                        161 	.ds 8
      0000A0                        162 _ttf_eng_s::
      0000A0                        163 	.ds 8
      0000A8                        164 _ttf_eng_t::
      0000A8                        165 	.ds 8
      0000B0                        166 _ttf_eng_u::
      0000B0                        167 	.ds 8
      0000B8                        168 _ttf_eng_v::
      0000B8                        169 	.ds 8
      0000C0                        170 _ttf_eng_w::
      0000C0                        171 	.ds 8
      0000C8                        172 _ttf_eng_x::
      0000C8                        173 	.ds 8
      0000D0                        174 _ttf_eng_y::
      0000D0                        175 	.ds 8
      0000D8                        176 _ttf_eng_z::
      0000D8                        177 	.ds 8
      0000E0                        178 _ttf_eng_1::
      0000E0                        179 	.ds 8
      0000E8                        180 _ttf_eng_2::
      0000E8                        181 	.ds 8
      0000F0                        182 _ttf_eng_3::
      0000F0                        183 	.ds 8
      0000F8                        184 _ttf_eng_4::
      0000F8                        185 	.ds 8
      000100                        186 _ttf_eng_5::
      000100                        187 	.ds 8
      000108                        188 _ttf_eng_6::
      000108                        189 	.ds 8
      000110                        190 _ttf_eng_7::
      000110                        191 	.ds 8
      000118                        192 _ttf_eng_8::
      000118                        193 	.ds 8
      000120                        194 _ttf_eng_9::
      000120                        195 	.ds 8
      000128                        196 _ttf_eng_0::
      000128                        197 	.ds 8
      000130                        198 _ttf_eng_corner_left_up::
      000130                        199 	.ds 8
      000138                        200 _ttf_eng_corner_right_up::
      000138                        201 	.ds 8
      000140                        202 _ttf_eng_corner_left_down::
      000140                        203 	.ds 8
      000148                        204 _ttf_eng_corner_right_down::
      000148                        205 	.ds 8
      000150                        206 _ttf_eng_line_right::
      000150                        207 	.ds 8
      000158                        208 _ttf_eng_line_left::
      000158                        209 	.ds 8
      000160                        210 _ttf_eng_line_up::
      000160                        211 	.ds 8
      000168                        212 _ttf_eng_line_down::
      000168                        213 	.ds 8
      000170                        214 _main_buffer::
      000170                        215 	.ds 512
      000370                        216 _current_item::
      000370                        217 	.ds 1
      000371                        218 _paragraph_item::
      000371                        219 	.ds 1
      000372                        220 _TIM2_IRQ::
      000372                        221 	.ds 1
                                    222 ;--------------------------------------------------------
                                    223 ; Stack segment in internal ram
                                    224 ;--------------------------------------------------------
                                    225 	.area SSEG
      000373                        226 __start__stack:
      000373                        227 	.ds	1
                                    228 
                                    229 ;--------------------------------------------------------
                                    230 ; absolute external ram data
                                    231 ;--------------------------------------------------------
                                    232 	.area DABS (ABS)
                                    233 
                                    234 ; default segment ordering for linker
                                    235 	.area HOME
                                    236 	.area GSINIT
                                    237 	.area GSFINAL
                                    238 	.area CONST
                                    239 	.area INITIALIZER
                                    240 	.area CODE
                                    241 
                                    242 ;--------------------------------------------------------
                                    243 ; interrupt vector
                                    244 ;--------------------------------------------------------
                                    245 	.area HOME
      008000                        246 __interrupt_vect:
      008000 82 00 80 5B            247 	int s_GSINIT ; reset
      008004 82 00 00 00            248 	int 0x000000 ; trap
      008008 82 00 00 00            249 	int 0x000000 ; int0
      00800C 82 00 00 00            250 	int 0x000000 ; int1
      008010 82 00 00 00            251 	int 0x000000 ; int2
      008014 82 00 00 00            252 	int 0x000000 ; int3
      008018 82 00 00 00            253 	int 0x000000 ; int4
      00801C 82 00 00 00            254 	int 0x000000 ; int5
      008020 82 00 00 00            255 	int 0x000000 ; int6
      008024 82 00 00 00            256 	int 0x000000 ; int7
      008028 82 00 00 00            257 	int 0x000000 ; int8
      00802C 82 00 00 00            258 	int 0x000000 ; int9
      008030 82 00 00 00            259 	int 0x000000 ; int10
      008034 82 00 00 00            260 	int 0x000000 ; int11
      008038 82 00 00 00            261 	int 0x000000 ; int12
      00803C 82 00 8E B5            262 	int _tmr2_irq ; int13
      008040 82 00 00 00            263 	int 0x000000 ; int14
      008044 82 00 00 00            264 	int 0x000000 ; int15
      008048 82 00 00 00            265 	int 0x000000 ; int16
      00804C 82 00 83 ED            266 	int _uart_transmission_irq ; int17
      008050 82 00 84 29            267 	int _uart_reciever_irq ; int18
      008054 82 00 86 0B            268 	int _i2c_irq ; int19
                                    269 ;--------------------------------------------------------
                                    270 ; global & static initialisations
                                    271 ;--------------------------------------------------------
                                    272 	.area HOME
                                    273 	.area GSINIT
                                    274 	.area GSFINAL
                                    275 	.area GSINIT
      00805B CD 8F B2         [ 4]  276 	call	___sdcc_external_startup
      00805E 4D               [ 1]  277 	tnz	a
      00805F 27 03            [ 1]  278 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  279 	jp	__sdcc_program_startup
      008064                        280 __sdcc_init_data:
                                    281 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  282 	ldw x, #l_DATA
      008067 27 07            [ 1]  283 	jreq	00002$
      008069                        284 00001$:
      008069 72 4F 00 00      [ 1]  285 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  286 	decw x
      00806E 26 F9            [ 1]  287 	jrne	00001$
      008070                        288 00002$:
      008070 AE 03 6C         [ 2]  289 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  290 	jreq	00004$
      008075                        291 00003$:
      008075 D6 80 80         [ 1]  292 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  293 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  294 	decw	x
      00807C 26 F7            [ 1]  295 	jrne	00003$
      00807E                        296 00004$:
                                    297 ; stm8_genXINIT() end
                                    298 	.area GSFINAL
      00807E CC 80 58         [ 2]  299 	jp	__sdcc_program_startup
                                    300 ;--------------------------------------------------------
                                    301 ; Home
                                    302 ;--------------------------------------------------------
                                    303 	.area HOME
                                    304 	.area HOME
      008058                        305 __sdcc_program_startup:
      008058 CC 8F 87         [ 2]  306 	jp	_main
                                    307 ;	return from main will return to caller
                                    308 ;--------------------------------------------------------
                                    309 ; code
                                    310 ;--------------------------------------------------------
                                    311 	.area CODE
                                    312 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    313 ;	-----------------------------------------
                                    314 ;	 function uart_transmission_irq
                                    315 ;	-----------------------------------------
      0083ED                        316 _uart_transmission_irq:
                                    317 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0083ED AE 52 30         [ 2]  318 	ldw	x, #0x5230
      0083F0 F6               [ 1]  319 	ld	a, (x)
      0083F1 4E               [ 1]  320 	swap	a
      0083F2 44               [ 1]  321 	srl	a
      0083F3 44               [ 1]  322 	srl	a
      0083F4 44               [ 1]  323 	srl	a
      0083F5 A5 01            [ 1]  324 	bcp	a, #0x01
      0083F7 27 2F            [ 1]  325 	jreq	00107$
                                    326 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0083F9 C6 00 02         [ 1]  327 	ld	a, _tx_buf_pointer+1
      0083FC CB 00 05         [ 1]  328 	add	a, _buf_pos+0
      0083FF 97               [ 1]  329 	ld	xl, a
      008400 C6 00 01         [ 1]  330 	ld	a, _tx_buf_pointer+0
      008403 A9 00            [ 1]  331 	adc	a, #0x00
      008405 95               [ 1]  332 	ld	xh, a
      008406 F6               [ 1]  333 	ld	a, (x)
      008407 27 1B            [ 1]  334 	jreq	00102$
      008409 C6 00 05         [ 1]  335 	ld	a, _buf_pos+0
      00840C C1 00 06         [ 1]  336 	cp	a, _buf_size+0
      00840F 24 13            [ 1]  337 	jrnc	00102$
                                    338 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      008411 C6 00 05         [ 1]  339 	ld	a, _buf_pos+0
      008414 72 5C 00 05      [ 1]  340 	inc	_buf_pos+0
      008418 5F               [ 1]  341 	clrw	x
      008419 97               [ 1]  342 	ld	xl, a
      00841A 72 BB 00 01      [ 2]  343 	addw	x, _tx_buf_pointer+0
      00841E F6               [ 1]  344 	ld	a, (x)
      00841F C7 52 31         [ 1]  345 	ld	0x5231, a
      008422 20 04            [ 2]  346 	jra	00107$
      008424                        347 00102$:
                                    348 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      008424 72 1F 52 35      [ 1]  349 	bres	0x5235, #7
      008428                        350 00107$:
                                    351 ;	./libs/uart_lib.c: 14: }
      008428 80               [11]  352 	iret
                                    353 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    354 ;	-----------------------------------------
                                    355 ;	 function uart_reciever_irq
                                    356 ;	-----------------------------------------
      008429                        357 _uart_reciever_irq:
      008429 88               [ 1]  358 	push	a
                                    359 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      00842A C6 52 30         [ 1]  360 	ld	a, 0x5230
      00842D 4E               [ 1]  361 	swap	a
      00842E 44               [ 1]  362 	srl	a
      00842F A5 01            [ 1]  363 	bcp	a, #0x01
      008431 27 27            [ 1]  364 	jreq	00107$
                                    365 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      008433 C6 52 31         [ 1]  366 	ld	a, 0x5231
                                    367 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      008436 6B 01            [ 1]  368 	ld	(0x01, sp), a
      008438 A1 0A            [ 1]  369 	cp	a, #0x0a
      00843A 27 1A            [ 1]  370 	jreq	00102$
      00843C C6 00 05         [ 1]  371 	ld	a, _buf_pos+0
      00843F C1 00 06         [ 1]  372 	cp	a, _buf_size+0
      008442 24 12            [ 1]  373 	jrnc	00102$
                                    374 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      008444 C6 00 05         [ 1]  375 	ld	a, _buf_pos+0
      008447 72 5C 00 05      [ 1]  376 	inc	_buf_pos+0
      00844B 5F               [ 1]  377 	clrw	x
      00844C 97               [ 1]  378 	ld	xl, a
      00844D 72 BB 00 03      [ 2]  379 	addw	x, _rx_buf_pointer+0
      008451 7B 01            [ 1]  380 	ld	a, (0x01, sp)
      008453 F7               [ 1]  381 	ld	(x), a
      008454 20 04            [ 2]  382 	jra	00107$
      008456                        383 00102$:
                                    384 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      008456 72 1B 52 35      [ 1]  385 	bres	0x5235, #5
      00845A                        386 00107$:
                                    387 ;	./libs/uart_lib.c: 30: }
      00845A 84               [ 1]  388 	pop	a
      00845B 80               [11]  389 	iret
                                    390 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    391 ;	-----------------------------------------
                                    392 ;	 function uart_write_irq
                                    393 ;	-----------------------------------------
      00845C                        394 _uart_write_irq:
      00845C 52 02            [ 2]  395 	sub	sp, #2
                                    396 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      00845E 1F 01            [ 2]  397 	ldw	(0x01, sp), x
      008460 CF 00 01         [ 2]  398 	ldw	_tx_buf_pointer+0, x
                                    399 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      008463 72 5F 00 05      [ 1]  400 	clr	_buf_pos+0
                                    401 ;	./libs/uart_lib.c: 36: buf_size = 0;
      008467 72 5F 00 06      [ 1]  402 	clr	_buf_size+0
                                    403 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      00846B                        404 00101$:
      00846B C6 00 06         [ 1]  405 	ld	a, _buf_size+0
      00846E 72 5C 00 06      [ 1]  406 	inc	_buf_size+0
      008472 5F               [ 1]  407 	clrw	x
      008473 97               [ 1]  408 	ld	xl, a
      008474 72 FB 01         [ 2]  409 	addw	x, (0x01, sp)
      008477 F6               [ 1]  410 	ld	a, (x)
      008478 26 F1            [ 1]  411 	jrne	00101$
                                    412 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      00847A 72 1E 52 35      [ 1]  413 	bset	0x5235, #7
                                    414 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      00847E                        415 00104$:
      00847E 72 0E 52 35 FB   [ 2]  416 	btjt	0x5235, #7, 00104$
                                    417 ;	./libs/uart_lib.c: 40: }
      008483 5B 02            [ 2]  418 	addw	sp, #2
      008485 81               [ 4]  419 	ret
                                    420 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    421 ;	-----------------------------------------
                                    422 ;	 function uart_read_irq
                                    423 ;	-----------------------------------------
      008486                        424 _uart_read_irq:
                                    425 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      008486 CF 00 03         [ 2]  426 	ldw	_rx_buf_pointer+0, x
                                    427 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      008489 72 5F 00 05      [ 1]  428 	clr	_buf_pos+0
                                    429 ;	./libs/uart_lib.c: 45: buf_size = size;
      00848D 7B 04            [ 1]  430 	ld	a, (0x04, sp)
      00848F C7 00 06         [ 1]  431 	ld	_buf_size+0, a
                                    432 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      008492 72 1A 52 35      [ 1]  433 	bset	0x5235, #5
                                    434 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      008496                        435 00101$:
      008496 C6 52 35         [ 1]  436 	ld	a, 0x5235
      008499 4E               [ 1]  437 	swap	a
      00849A 44               [ 1]  438 	srl	a
      00849B A4 01            [ 1]  439 	and	a, #0x01
      00849D 26 F7            [ 1]  440 	jrne	00101$
                                    441 ;	./libs/uart_lib.c: 48: }
      00849F 1E 01            [ 2]  442 	ldw	x, (1, sp)
      0084A1 5B 04            [ 2]  443 	addw	sp, #4
      0084A3 FC               [ 2]  444 	jp	(x)
                                    445 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    446 ;	-----------------------------------------
                                    447 ;	 function uart_init
                                    448 ;	-----------------------------------------
      0084A4                        449 _uart_init:
      0084A4 52 02            [ 2]  450 	sub	sp, #2
      0084A6 1F 01            [ 2]  451 	ldw	(0x01, sp), x
                                    452 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      0084A8 AE 52 35         [ 2]  453 	ldw	x, #0x5235
      0084AB 88               [ 1]  454 	push	a
      0084AC F6               [ 1]  455 	ld	a, (x)
      0084AD AA 08            [ 1]  456 	or	a, #0x08
      0084AF F7               [ 1]  457 	ld	(x), a
      0084B0 84               [ 1]  458 	pop	a
                                    459 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      0084B1 AE 52 35         [ 2]  460 	ldw	x, #0x5235
      0084B4 88               [ 1]  461 	push	a
      0084B5 F6               [ 1]  462 	ld	a, (x)
      0084B6 AA 04            [ 1]  463 	or	a, #0x04
      0084B8 F7               [ 1]  464 	ld	(x), a
      0084B9 84               [ 1]  465 	pop	a
                                    466 ;	./libs/uart_lib.c: 56: switch(stopbit)
      0084BA A1 02            [ 1]  467 	cp	a, #0x02
      0084BC 27 06            [ 1]  468 	jreq	00101$
      0084BE A1 03            [ 1]  469 	cp	a, #0x03
      0084C0 27 0E            [ 1]  470 	jreq	00102$
      0084C2 20 16            [ 2]  471 	jra	00103$
                                    472 ;	./libs/uart_lib.c: 58: case 2:
      0084C4                        473 00101$:
                                    474 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      0084C4 C6 52 36         [ 1]  475 	ld	a, 0x5236
      0084C7 A4 CF            [ 1]  476 	and	a, #0xcf
      0084C9 AA 20            [ 1]  477 	or	a, #0x20
      0084CB C7 52 36         [ 1]  478 	ld	0x5236, a
                                    479 ;	./libs/uart_lib.c: 60: break;
      0084CE 20 12            [ 2]  480 	jra	00104$
                                    481 ;	./libs/uart_lib.c: 61: case 3:
      0084D0                        482 00102$:
                                    483 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      0084D0 C6 52 36         [ 1]  484 	ld	a, 0x5236
      0084D3 AA 30            [ 1]  485 	or	a, #0x30
      0084D5 C7 52 36         [ 1]  486 	ld	0x5236, a
                                    487 ;	./libs/uart_lib.c: 63: break;
      0084D8 20 08            [ 2]  488 	jra	00104$
                                    489 ;	./libs/uart_lib.c: 64: default:
      0084DA                        490 00103$:
                                    491 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      0084DA C6 52 36         [ 1]  492 	ld	a, 0x5236
      0084DD A4 CF            [ 1]  493 	and	a, #0xcf
      0084DF C7 52 36         [ 1]  494 	ld	0x5236, a
                                    495 ;	./libs/uart_lib.c: 67: }
      0084E2                        496 00104$:
                                    497 ;	./libs/uart_lib.c: 68: switch(baudrate)
      0084E2 1E 01            [ 2]  498 	ldw	x, (0x01, sp)
      0084E4 A3 08 00         [ 2]  499 	cpw	x, #0x0800
      0084E7 26 03            [ 1]  500 	jrne	00186$
      0084E9 CC 85 75         [ 2]  501 	jp	00110$
      0084EC                        502 00186$:
      0084EC 1E 01            [ 2]  503 	ldw	x, (0x01, sp)
      0084EE A3 09 60         [ 2]  504 	cpw	x, #0x0960
      0084F1 27 28            [ 1]  505 	jreq	00105$
      0084F3 1E 01            [ 2]  506 	ldw	x, (0x01, sp)
      0084F5 A3 10 00         [ 2]  507 	cpw	x, #0x1000
      0084F8 26 03            [ 1]  508 	jrne	00192$
      0084FA CC 85 85         [ 2]  509 	jp	00111$
      0084FD                        510 00192$:
      0084FD 1E 01            [ 2]  511 	ldw	x, (0x01, sp)
      0084FF A3 4B 00         [ 2]  512 	cpw	x, #0x4b00
      008502 27 31            [ 1]  513 	jreq	00106$
      008504 1E 01            [ 2]  514 	ldw	x, (0x01, sp)
      008506 A3 84 00         [ 2]  515 	cpw	x, #0x8400
      008509 27 5A            [ 1]  516 	jreq	00109$
      00850B 1E 01            [ 2]  517 	ldw	x, (0x01, sp)
      00850D A3 C2 00         [ 2]  518 	cpw	x, #0xc200
      008510 27 43            [ 1]  519 	jreq	00108$
      008512 1E 01            [ 2]  520 	ldw	x, (0x01, sp)
      008514 A3 E1 00         [ 2]  521 	cpw	x, #0xe100
      008517 27 2C            [ 1]  522 	jreq	00107$
      008519 20 7A            [ 2]  523 	jra	00112$
                                    524 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      00851B                        525 00105$:
                                    526 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      00851B C6 52 33         [ 1]  527 	ld	a, 0x5233
      00851E A4 0F            [ 1]  528 	and	a, #0x0f
      008520 AA 10            [ 1]  529 	or	a, #0x10
      008522 C7 52 33         [ 1]  530 	ld	0x5233, a
                                    531 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      008525 35 A0 52 32      [ 1]  532 	mov	0x5232+0, #0xa0
                                    533 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      008529 C6 52 33         [ 1]  534 	ld	a, 0x5233
      00852C A4 F0            [ 1]  535 	and	a, #0xf0
      00852E AA 0B            [ 1]  536 	or	a, #0x0b
      008530 C7 52 33         [ 1]  537 	ld	0x5233, a
                                    538 ;	./libs/uart_lib.c: 74: break;
      008533 20 6E            [ 2]  539 	jra	00114$
                                    540 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      008535                        541 00106$:
                                    542 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      008535 35 34 52 32      [ 1]  543 	mov	0x5232+0, #0x34
                                    544 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      008539 C6 52 33         [ 1]  545 	ld	a, 0x5233
      00853C A4 F0            [ 1]  546 	and	a, #0xf0
      00853E AA 01            [ 1]  547 	or	a, #0x01
      008540 C7 52 33         [ 1]  548 	ld	0x5233, a
                                    549 ;	./libs/uart_lib.c: 78: break;
      008543 20 5E            [ 2]  550 	jra	00114$
                                    551 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      008545                        552 00107$:
                                    553 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      008545 35 11 52 32      [ 1]  554 	mov	0x5232+0, #0x11
                                    555 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      008549 C6 52 33         [ 1]  556 	ld	a, 0x5233
      00854C A4 F0            [ 1]  557 	and	a, #0xf0
      00854E AA 06            [ 1]  558 	or	a, #0x06
      008550 C7 52 33         [ 1]  559 	ld	0x5233, a
                                    560 ;	./libs/uart_lib.c: 82: break;
      008553 20 4E            [ 2]  561 	jra	00114$
                                    562 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      008555                        563 00108$:
                                    564 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      008555 35 08 52 32      [ 1]  565 	mov	0x5232+0, #0x08
                                    566 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      008559 C6 52 33         [ 1]  567 	ld	a, 0x5233
      00855C A4 F0            [ 1]  568 	and	a, #0xf0
      00855E AA 0B            [ 1]  569 	or	a, #0x0b
      008560 C7 52 33         [ 1]  570 	ld	0x5233, a
                                    571 ;	./libs/uart_lib.c: 86: break;
      008563 20 3E            [ 2]  572 	jra	00114$
                                    573 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      008565                        574 00109$:
                                    575 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      008565 35 04 52 32      [ 1]  576 	mov	0x5232+0, #0x04
                                    577 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      008569 C6 52 33         [ 1]  578 	ld	a, 0x5233
      00856C A4 F0            [ 1]  579 	and	a, #0xf0
      00856E AA 05            [ 1]  580 	or	a, #0x05
      008570 C7 52 33         [ 1]  581 	ld	0x5233, a
                                    582 ;	./libs/uart_lib.c: 90: break;
      008573 20 2E            [ 2]  583 	jra	00114$
                                    584 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      008575                        585 00110$:
                                    586 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      008575 35 02 52 32      [ 1]  587 	mov	0x5232+0, #0x02
                                    588 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      008579 C6 52 33         [ 1]  589 	ld	a, 0x5233
      00857C A4 F0            [ 1]  590 	and	a, #0xf0
      00857E AA 03            [ 1]  591 	or	a, #0x03
      008580 C7 52 33         [ 1]  592 	ld	0x5233, a
                                    593 ;	./libs/uart_lib.c: 94: break;
      008583 20 1E            [ 2]  594 	jra	00114$
                                    595 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      008585                        596 00111$:
                                    597 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      008585 35 01 52 32      [ 1]  598 	mov	0x5232+0, #0x01
                                    599 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      008589 C6 52 33         [ 1]  600 	ld	a, 0x5233
      00858C A4 F0            [ 1]  601 	and	a, #0xf0
      00858E AA 01            [ 1]  602 	or	a, #0x01
      008590 C7 52 33         [ 1]  603 	ld	0x5233, a
                                    604 ;	./libs/uart_lib.c: 98: break;
      008593 20 0E            [ 2]  605 	jra	00114$
                                    606 ;	./libs/uart_lib.c: 99: default:
      008595                        607 00112$:
                                    608 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      008595 35 68 52 32      [ 1]  609 	mov	0x5232+0, #0x68
                                    610 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      008599 C6 52 33         [ 1]  611 	ld	a, 0x5233
      00859C A4 F0            [ 1]  612 	and	a, #0xf0
      00859E AA 03            [ 1]  613 	or	a, #0x03
      0085A0 C7 52 33         [ 1]  614 	ld	0x5233, a
                                    615 ;	./libs/uart_lib.c: 103: }
      0085A3                        616 00114$:
                                    617 ;	./libs/uart_lib.c: 104: }
      0085A3 5B 02            [ 2]  618 	addw	sp, #2
      0085A5 81               [ 4]  619 	ret
                                    620 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    621 ;	-----------------------------------------
                                    622 ;	 function uart_read_byte
                                    623 ;	-----------------------------------------
      0085A6                        624 _uart_read_byte:
                                    625 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      0085A6                        626 00101$:
      0085A6 72 0B 52 30 FB   [ 2]  627 	btjf	0x5230, #5, 00101$
                                    628 ;	./libs/uart_lib.c: 110: return 1;
      0085AB 5F               [ 1]  629 	clrw	x
      0085AC 5C               [ 1]  630 	incw	x
                                    631 ;	./libs/uart_lib.c: 111: }
      0085AD 81               [ 4]  632 	ret
                                    633 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    634 ;	-----------------------------------------
                                    635 ;	 function uart_write_byte
                                    636 ;	-----------------------------------------
      0085AE                        637 _uart_write_byte:
                                    638 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      0085AE C7 52 31         [ 1]  639 	ld	0x5231, a
                                    640 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      0085B1                        641 00101$:
      0085B1 72 0F 52 30 FB   [ 2]  642 	btjf	0x5230, #7, 00101$
                                    643 ;	./libs/uart_lib.c: 117: return 1;
      0085B6 5F               [ 1]  644 	clrw	x
      0085B7 5C               [ 1]  645 	incw	x
                                    646 ;	./libs/uart_lib.c: 118: }
      0085B8 81               [ 4]  647 	ret
                                    648 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    649 ;	-----------------------------------------
                                    650 ;	 function uart_write
                                    651 ;	-----------------------------------------
      0085B9                        652 _uart_write:
      0085B9 52 04            [ 2]  653 	sub	sp, #4
      0085BB 1F 01            [ 2]  654 	ldw	(0x01, sp), x
                                    655 ;	./libs/uart_lib.c: 122: int count = 0;
      0085BD 5F               [ 1]  656 	clrw	x
      0085BE 1F 03            [ 2]  657 	ldw	(0x03, sp), x
                                    658 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085C0 5F               [ 1]  659 	clrw	x
      0085C1                        660 00103$:
      0085C1 90 93            [ 1]  661 	ldw	y, x
      0085C3 72 F9 01         [ 2]  662 	addw	y, (0x01, sp)
      0085C6 90 F6            [ 1]  663 	ld	a, (y)
      0085C8 27 0E            [ 1]  664 	jreq	00101$
                                    665 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      0085CA 89               [ 2]  666 	pushw	x
      0085CB CD 85 AE         [ 4]  667 	call	_uart_write_byte
      0085CE 51               [ 1]  668 	exgw	x, y
      0085CF 85               [ 2]  669 	popw	x
      0085D0 72 F9 03         [ 2]  670 	addw	y, (0x03, sp)
      0085D3 17 03            [ 2]  671 	ldw	(0x03, sp), y
                                    672 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085D5 5C               [ 1]  673 	incw	x
      0085D6 20 E9            [ 2]  674 	jra	00103$
      0085D8                        675 00101$:
                                    676 ;	./libs/uart_lib.c: 125: return count;
      0085D8 1E 03            [ 2]  677 	ldw	x, (0x03, sp)
                                    678 ;	./libs/uart_lib.c: 126: }
      0085DA 5B 04            [ 2]  679 	addw	sp, #4
      0085DC 81               [ 4]  680 	ret
                                    681 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    682 ;	-----------------------------------------
                                    683 ;	 function uart_read
                                    684 ;	-----------------------------------------
      0085DD                        685 _uart_read:
      0085DD 52 04            [ 2]  686 	sub	sp, #4
      0085DF 1F 01            [ 2]  687 	ldw	(0x01, sp), x
                                    688 ;	./libs/uart_lib.c: 130: int count = 0;
      0085E1 5F               [ 1]  689 	clrw	x
      0085E2 1F 03            [ 2]  690 	ldw	(0x03, sp), x
                                    691 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085E4 5F               [ 1]  692 	clrw	x
      0085E5                        693 00103$:
      0085E5 90 93            [ 1]  694 	ldw	y, x
      0085E7 72 F9 01         [ 2]  695 	addw	y, (0x01, sp)
      0085EA 90 F6            [ 1]  696 	ld	a, (y)
      0085EC 27 13            [ 1]  697 	jreq	00101$
                                    698 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      0085EE 90 5F            [ 1]  699 	clrw	y
      0085F0 90 97            [ 1]  700 	ld	yl, a
      0085F2 89               [ 2]  701 	pushw	x
      0085F3 93               [ 1]  702 	ldw	x, y
      0085F4 CD 85 A6         [ 4]  703 	call	_uart_read_byte
      0085F7 51               [ 1]  704 	exgw	x, y
      0085F8 85               [ 2]  705 	popw	x
      0085F9 72 F9 03         [ 2]  706 	addw	y, (0x03, sp)
      0085FC 17 03            [ 2]  707 	ldw	(0x03, sp), y
                                    708 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085FE 5C               [ 1]  709 	incw	x
      0085FF 20 E4            [ 2]  710 	jra	00103$
      008601                        711 00101$:
                                    712 ;	./libs/uart_lib.c: 133: return count;
      008601 1E 03            [ 2]  713 	ldw	x, (0x03, sp)
                                    714 ;	./libs/uart_lib.c: 134: }
      008603 5B 04            [ 2]  715 	addw	sp, #4
      008605 90 85            [ 2]  716 	popw	y
      008607 5B 02            [ 2]  717 	addw	sp, #2
      008609 90 FC            [ 2]  718 	jp	(y)
                                    719 ;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    720 ;	-----------------------------------------
                                    721 ;	 function i2c_irq
                                    722 ;	-----------------------------------------
      00860B                        723 _i2c_irq:
      00860B 4F               [ 1]  724 	clr	a
      00860C 62               [ 2]  725 	div	x, a
                                    726 ;	./libs/i2c_lib.c: 6: disableInterrupts();
      00860D 9B               [ 1]  727 	sim
                                    728 ;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
      00860E 35 00 00 07      [ 1]  729 	mov	_I2C_IRQ+0, #0x00
                                    730 ;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
      008612 AE 52 17         [ 2]  731 	ldw	x, #0x5217
      008615 F6               [ 1]  732 	ld	a, (x)
      008616 44               [ 1]  733 	srl	a
      008617 A4 01            [ 1]  734 	and	a, #0x01
      008619 27 16            [ 1]  735 	jreq	00102$
                                    736 ;	./libs/i2c_lib.c: 11: clr_sr1();
      00861B C6 52 17         [ 1]  737 	ld	a,0x5217
                                    738 ;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
      00861E 72 12 00 07      [ 1]  739 	bset	_I2C_IRQ+0, #1
                                    740 ;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
      008622 C6 52 19         [ 1]  741 	ld	a,0x5219
                                    742 ;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
      008625 72 13 52 1A      [ 1]  743 	bres	0x521a, #1
                                    744 ;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
      008629 A6 E1            [ 1]  745 	ld	a, #0xe1
      00862B CD 85 AE         [ 4]  746 	call	_uart_write_byte
                                    747 ;	./libs/i2c_lib.c: 16: return;
      00862E CC 86 C4         [ 2]  748 	jp	00113$
      008631                        749 00102$:
                                    750 ;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      008631 C6 52 17         [ 1]  751 	ld	a, 0x5217
      008634 4E               [ 1]  752 	swap	a
      008635 44               [ 1]  753 	srl	a
      008636 44               [ 1]  754 	srl	a
      008637 44               [ 1]  755 	srl	a
      008638 A5 01            [ 1]  756 	bcp	a, #0x01
      00863A 27 17            [ 1]  757 	jreq	00104$
                                    758 ;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
      00863C 72 18 00 07      [ 1]  759 	bset	_I2C_IRQ+0, #4
                                    760 ;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
      008640 72 15 52 1A      [ 1]  761 	bres	0x521a, #2
                                    762 ;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
      008644 72 13 52 1A      [ 1]  763 	bres	0x521a, #1
                                    764 ;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
      008648 72 11 52 1A      [ 1]  765 	bres	0x521a, #0
                                    766 ;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
      00864C A6 EA            [ 1]  767 	ld	a, #0xea
      00864E CD 85 AE         [ 4]  768 	call	_uart_write_byte
                                    769 ;	./libs/i2c_lib.c: 26: return;
      008651 20 71            [ 2]  770 	jra	00113$
      008653                        771 00104$:
                                    772 ;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      008653 C6 52 17         [ 1]  773 	ld	a, 0x5217
      008656 4E               [ 1]  774 	swap	a
      008657 44               [ 1]  775 	srl	a
      008658 44               [ 1]  776 	srl	a
      008659 A5 01            [ 1]  777 	bcp	a, #0x01
      00865B 27 17            [ 1]  778 	jreq	00106$
                                    779 ;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
      00865D 72 16 00 07      [ 1]  780 	bset	_I2C_IRQ+0, #3
                                    781 ;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
      008661 72 15 52 1A      [ 1]  782 	bres	0x521a, #2
                                    783 ;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
      008665 72 13 52 1A      [ 1]  784 	bres	0x521a, #1
                                    785 ;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
      008669 72 11 52 1A      [ 1]  786 	bres	0x521a, #0
                                    787 ;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
      00866D A6 EB            [ 1]  788 	ld	a, #0xeb
      00866F CD 85 AE         [ 4]  789 	call	_uart_write_byte
                                    790 ;	./libs/i2c_lib.c: 35: return;
      008672 20 50            [ 2]  791 	jra	00113$
      008674                        792 00106$:
                                    793 ;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      008674 C6 52 17         [ 1]  794 	ld	a, 0x5217
      008677 A5 01            [ 1]  795 	bcp	a, #0x01
      008679 27 0F            [ 1]  796 	jreq	00108$
                                    797 ;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
      00867B 72 10 00 07      [ 1]  798 	bset	_I2C_IRQ+0, #0
                                    799 ;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
      00867F 72 13 52 1A      [ 1]  800 	bres	0x521a, #1
                                    801 ;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
      008683 A6 E2            [ 1]  802 	ld	a, #0xe2
      008685 CD 85 AE         [ 4]  803 	call	_uart_write_byte
                                    804 ;	./libs/i2c_lib.c: 43: return;
      008688 20 3A            [ 2]  805 	jra	00113$
      00868A                        806 00108$:
                                    807 ;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
      00868A C6 52 17         [ 1]  808 	ld	a, 0x5217
      00868D 44               [ 1]  809 	srl	a
      00868E 44               [ 1]  810 	srl	a
      00868F A5 01            [ 1]  811 	bcp	a, #0x01
      008691 27 0F            [ 1]  812 	jreq	00110$
                                    813 ;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
      008693 72 14 00 07      [ 1]  814 	bset	_I2C_IRQ+0, #2
                                    815 ;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
      008697 72 13 52 1A      [ 1]  816 	bres	0x521a, #1
                                    817 ;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
      00869B A6 E3            [ 1]  818 	ld	a, #0xe3
      00869D CD 85 AE         [ 4]  819 	call	_uart_write_byte
                                    820 ;	./libs/i2c_lib.c: 50: return;
      0086A0 20 22            [ 2]  821 	jra	00113$
      0086A2                        822 00110$:
                                    823 ;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      0086A2 AE 52 18         [ 2]  824 	ldw	x, #0x5218
      0086A5 F6               [ 1]  825 	ld	a, (x)
      0086A6 44               [ 1]  826 	srl	a
      0086A7 44               [ 1]  827 	srl	a
      0086A8 A4 01            [ 1]  828 	and	a, #0x01
      0086AA 27 17            [ 1]  829 	jreq	00112$
                                    830 ;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
      0086AC 72 1A 00 07      [ 1]  831 	bset	_I2C_IRQ+0, #5
                                    832 ;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
      0086B0 72 13 52 1A      [ 1]  833 	bres	0x521a, #1
                                    834 ;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
      0086B4 72 11 52 1A      [ 1]  835 	bres	0x521a, #0
                                    836 ;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
      0086B8 72 15 52 1A      [ 1]  837 	bres	0x521a, #2
                                    838 ;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
      0086BC A6 EE            [ 1]  839 	ld	a, #0xee
      0086BE CD 85 AE         [ 4]  840 	call	_uart_write_byte
                                    841 ;	./libs/i2c_lib.c: 60: return;
      0086C1 20 01            [ 2]  842 	jra	00113$
      0086C3                        843 00112$:
                                    844 ;	./libs/i2c_lib.c: 63: enableInterrupts(); 
      0086C3 9A               [ 1]  845 	rim
      0086C4                        846 00113$:
                                    847 ;	./libs/i2c_lib.c: 64: }
      0086C4 80               [11]  848 	iret
                                    849 ;	./libs/i2c_lib.c: 66: void i2c_init(void)
                                    850 ;	-----------------------------------------
                                    851 ;	 function i2c_init
                                    852 ;	-----------------------------------------
      0086C5                        853 _i2c_init:
                                    854 ;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      0086C5 72 11 52 10      [ 1]  855 	bres	0x5210, #0
                                    856 ;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      0086C9 C6 52 12         [ 1]  857 	ld	a, 0x5212
      0086CC A4 C0            [ 1]  858 	and	a, #0xc0
      0086CE AA 10            [ 1]  859 	or	a, #0x10
      0086D0 C7 52 12         [ 1]  860 	ld	0x5212, a
                                    861 ;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
      0086D3 C6 52 1C         [ 1]  862 	ld	a, 0x521c
      0086D6 A4 F0            [ 1]  863 	and	a, #0xf0
      0086D8 C7 52 1C         [ 1]  864 	ld	0x521c, a
                                    865 ;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0086DB 35 50 52 1B      [ 1]  866 	mov	0x521b+0, #0x50
                                    867 ;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0086DF 72 1F 52 1C      [ 1]  868 	bres	0x521c, #7
                                    869 ;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0086E3 72 1F 52 14      [ 1]  870 	bres	0x5214, #7
                                    871 ;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
      0086E7 72 10 52 14      [ 1]  872 	bset	0x5214, #0
                                    873 ;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0086EB 72 10 52 10      [ 1]  874 	bset	0x5210, #0
                                    875 ;	./libs/i2c_lib.c: 78: }
      0086EF 81               [ 4]  876 	ret
                                    877 ;	./libs/i2c_lib.c: 80: void i2c_start(void)
                                    878 ;	-----------------------------------------
                                    879 ;	 function i2c_start
                                    880 ;	-----------------------------------------
      0086F0                        881 _i2c_start:
                                    882 ;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0086F0 72 10 52 11      [ 1]  883 	bset	0x5211, #0
                                    884 ;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0086F4                        885 00101$:
      0086F4 72 01 52 17 FB   [ 2]  886 	btjf	0x5217, #0, 00101$
                                    887 ;	./libs/i2c_lib.c: 84: }
      0086F9 81               [ 4]  888 	ret
                                    889 ;	./libs/i2c_lib.c: 86: void i2c_stop(void)
                                    890 ;	-----------------------------------------
                                    891 ;	 function i2c_stop
                                    892 ;	-----------------------------------------
      0086FA                        893 _i2c_stop:
                                    894 ;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0086FA 72 12 52 11      [ 1]  895 	bset	0x5211, #1
                                    896 ;	./libs/i2c_lib.c: 89: }
      0086FE 81               [ 4]  897 	ret
                                    898 ;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    899 ;	-----------------------------------------
                                    900 ;	 function i2c_send_address
                                    901 ;	-----------------------------------------
      0086FF                        902 _i2c_send_address:
                                    903 ;	./libs/i2c_lib.c: 96: address = address << 1;
      0086FF 48               [ 1]  904 	sll	a
                                    905 ;	./libs/i2c_lib.c: 93: switch(rw_type)
      008700 88               [ 1]  906 	push	a
      008701 7B 04            [ 1]  907 	ld	a, (0x04, sp)
      008703 4A               [ 1]  908 	dec	a
      008704 84               [ 1]  909 	pop	a
      008705 26 02            [ 1]  910 	jrne	00102$
                                    911 ;	./libs/i2c_lib.c: 96: address = address << 1;
                                    912 ;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
      008707 AA 01            [ 1]  913 	or	a, #0x01
                                    914 ;	./libs/i2c_lib.c: 98: break;
                                    915 ;	./libs/i2c_lib.c: 99: default:
                                    916 ;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
                                    917 ;	./libs/i2c_lib.c: 102: }
      008709                        918 00102$:
                                    919 ;	./libs/i2c_lib.c: 103: i2c_start();
      008709 88               [ 1]  920 	push	a
      00870A CD 86 F0         [ 4]  921 	call	_i2c_start
      00870D 84               [ 1]  922 	pop	a
                                    923 ;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
      00870E C7 52 16         [ 1]  924 	ld	0x5216, a
                                    925 ;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
      008711                        926 00106$:
      008711 AE 52 17         [ 2]  927 	ldw	x, #0x5217
      008714 F6               [ 1]  928 	ld	a, (x)
      008715 44               [ 1]  929 	srl	a
      008716 A4 01            [ 1]  930 	and	a, #0x01
      008718 26 08            [ 1]  931 	jrne	00108$
                                    932 ;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
      00871A 72 05 52 18 F2   [ 2]  933 	btjf	0x5218, #2, 00106$
                                    934 ;	./libs/i2c_lib.c: 107: return 0;
      00871F 4F               [ 1]  935 	clr	a
      008720 20 08            [ 2]  936 	jra	00109$
      008722                        937 00108$:
                                    938 ;	./libs/i2c_lib.c: 108: clr_sr1();
      008722 C6 52 17         [ 1]  939 	ld	a,0x5217
                                    940 ;	./libs/i2c_lib.c: 109: clr_sr3();
      008725 C6 52 19         [ 1]  941 	ld	a,0x5219
                                    942 ;	./libs/i2c_lib.c: 110: return 1;
      008728 A6 01            [ 1]  943 	ld	a, #0x01
      00872A                        944 00109$:
                                    945 ;	./libs/i2c_lib.c: 111: }
      00872A 85               [ 2]  946 	popw	x
      00872B 5B 01            [ 2]  947 	addw	sp, #1
      00872D FC               [ 2]  948 	jp	(x)
                                    949 ;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
                                    950 ;	-----------------------------------------
                                    951 ;	 function i2c_read_byte
                                    952 ;	-----------------------------------------
      00872E                        953 _i2c_read_byte:
                                    954 ;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
      00872E                        955 00101$:
      00872E 72 0D 52 17 FB   [ 2]  956 	btjf	0x5217, #6, 00101$
                                    957 ;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
      008733 C6 52 16         [ 1]  958 	ld	a, 0x5216
                                    959 ;	./libs/i2c_lib.c: 117: }
      008736 81               [ 4]  960 	ret
                                    961 ;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    962 ;	-----------------------------------------
                                    963 ;	 function i2c_read
                                    964 ;	-----------------------------------------
      008737                        965 _i2c_read:
      008737 52 04            [ 2]  966 	sub	sp, #4
                                    967 ;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      008739 4B 01            [ 1]  968 	push	#0x01
      00873B CD 86 FF         [ 4]  969 	call	_i2c_send_address
      00873E 4D               [ 1]  970 	tnz	a
      00873F 27 3C            [ 1]  971 	jreq	00103$
                                    972 ;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008741 72 14 52 11      [ 1]  973 	bset	0x5211, #2
                                    974 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008745 5F               [ 1]  975 	clrw	x
      008746 1F 03            [ 2]  976 	ldw	(0x03, sp), x
      008748                        977 00105$:
      008748 5F               [ 1]  978 	clrw	x
      008749 7B 07            [ 1]  979 	ld	a, (0x07, sp)
      00874B 97               [ 1]  980 	ld	xl, a
      00874C 5A               [ 2]  981 	decw	x
      00874D 1F 01            [ 2]  982 	ldw	(0x01, sp), x
      00874F 1E 03            [ 2]  983 	ldw	x, (0x03, sp)
      008751 13 01            [ 2]  984 	cpw	x, (0x01, sp)
      008753 2E 12            [ 1]  985 	jrsge	00101$
                                    986 ;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      008755 1E 08            [ 2]  987 	ldw	x, (0x08, sp)
      008757 72 FB 03         [ 2]  988 	addw	x, (0x03, sp)
      00875A 89               [ 2]  989 	pushw	x
      00875B CD 87 2E         [ 4]  990 	call	_i2c_read_byte
      00875E 85               [ 2]  991 	popw	x
      00875F F7               [ 1]  992 	ld	(x), a
                                    993 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008760 1E 03            [ 2]  994 	ldw	x, (0x03, sp)
      008762 5C               [ 1]  995 	incw	x
      008763 1F 03            [ 2]  996 	ldw	(0x03, sp), x
      008765 20 E1            [ 2]  997 	jra	00105$
      008767                        998 00101$:
                                    999 ;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      008767 C6 52 11         [ 1] 1000 	ld	a, 0x5211
      00876A A4 FB            [ 1] 1001 	and	a, #0xfb
      00876C C7 52 11         [ 1] 1002 	ld	0x5211, a
                                   1003 ;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
      00876F 1E 08            [ 2] 1004 	ldw	x, (0x08, sp)
      008771 72 FB 01         [ 2] 1005 	addw	x, (0x01, sp)
      008774 89               [ 2] 1006 	pushw	x
      008775 CD 87 2E         [ 4] 1007 	call	_i2c_read_byte
      008778 85               [ 2] 1008 	popw	x
      008779 F7               [ 1] 1009 	ld	(x), a
                                   1010 ;	./libs/i2c_lib.c: 132: i2c_stop();
      00877A CD 86 FA         [ 4] 1011 	call	_i2c_stop
      00877D                       1012 00103$:
                                   1013 ;	./libs/i2c_lib.c: 135: i2c_stop();
      00877D 1E 05            [ 2] 1014 	ldw	x, (5, sp)
      00877F 1F 08            [ 2] 1015 	ldw	(8, sp), x
      008781 5B 07            [ 2] 1016 	addw	sp, #7
                                   1017 ;	./libs/i2c_lib.c: 137: }
      008783 CC 86 FA         [ 2] 1018 	jp	_i2c_stop
                                   1019 ;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
                                   1020 ;	-----------------------------------------
                                   1021 ;	 function i2c_send_byte
                                   1022 ;	-----------------------------------------
      008786                       1023 _i2c_send_byte:
                                   1024 ;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
      008786 C7 52 16         [ 1] 1025 	ld	0x5216, a
                                   1026 ;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
      008789                       1027 00103$:
      008789 72 0E 52 17 08   [ 2] 1028 	btjt	0x5217, #7, 00105$
                                   1029 ;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
      00878E 72 05 52 18 F6   [ 2] 1030 	btjf	0x5218, #2, 00103$
                                   1031 ;	./libs/i2c_lib.c: 144: return 1;
      008793 A6 01            [ 1] 1032 	ld	a, #0x01
      008795 81               [ 4] 1033 	ret
      008796                       1034 00105$:
                                   1035 ;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
      008796 4F               [ 1] 1036 	clr	a
                                   1037 ;	./libs/i2c_lib.c: 146: }
      008797 81               [ 4] 1038 	ret
                                   1039 ;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                   1040 ;	-----------------------------------------
                                   1041 ;	 function i2c_write
                                   1042 ;	-----------------------------------------
      008798                       1043 _i2c_write:
      008798 52 02            [ 2] 1044 	sub	sp, #2
                                   1045 ;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      00879A 4B 00            [ 1] 1046 	push	#0x00
      00879C CD 86 FF         [ 4] 1047 	call	_i2c_send_address
      00879F 4D               [ 1] 1048 	tnz	a
      0087A0 27 1D            [ 1] 1049 	jreq	00105$
                                   1050 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      0087A2 5F               [ 1] 1051 	clrw	x
      0087A3                       1052 00107$:
      0087A3 7B 05            [ 1] 1053 	ld	a, (0x05, sp)
      0087A5 6B 02            [ 1] 1054 	ld	(0x02, sp), a
      0087A7 0F 01            [ 1] 1055 	clr	(0x01, sp)
      0087A9 13 01            [ 2] 1056 	cpw	x, (0x01, sp)
      0087AB 2E 12            [ 1] 1057 	jrsge	00105$
                                   1058 ;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      0087AD 90 93            [ 1] 1059 	ldw	y, x
      0087AF 72 F9 06         [ 2] 1060 	addw	y, (0x06, sp)
      0087B2 90 F6            [ 1] 1061 	ld	a, (y)
      0087B4 89               [ 2] 1062 	pushw	x
      0087B5 CD 87 86         [ 4] 1063 	call	_i2c_send_byte
      0087B8 85               [ 2] 1064 	popw	x
      0087B9 4D               [ 1] 1065 	tnz	a
      0087BA 26 03            [ 1] 1066 	jrne	00105$
                                   1067 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      0087BC 5C               [ 1] 1068 	incw	x
      0087BD 20 E4            [ 2] 1069 	jra	00107$
      0087BF                       1070 00105$:
                                   1071 ;	./libs/i2c_lib.c: 158: i2c_stop();
      0087BF 1E 03            [ 2] 1072 	ldw	x, (3, sp)
      0087C1 1F 06            [ 2] 1073 	ldw	(6, sp), x
      0087C3 5B 05            [ 2] 1074 	addw	sp, #5
                                   1075 ;	./libs/i2c_lib.c: 159: }
      0087C5 CC 86 FA         [ 2] 1076 	jp	_i2c_stop
                                   1077 ;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
                                   1078 ;	-----------------------------------------
                                   1079 ;	 function i2c_scan
                                   1080 ;	-----------------------------------------
      0087C8                       1081 _i2c_scan:
      0087C8 52 02            [ 2] 1082 	sub	sp, #2
                                   1083 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087CA A6 01            [ 1] 1084 	ld	a, #0x01
      0087CC 6B 01            [ 1] 1085 	ld	(0x01, sp), a
      0087CE                       1086 00105$:
      0087CE A1 7F            [ 1] 1087 	cp	a, #0x7f
      0087D0 24 22            [ 1] 1088 	jrnc	00103$
                                   1089 ;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0087D2 88               [ 1] 1090 	push	a
      0087D3 4B 00            [ 1] 1091 	push	#0x00
      0087D5 CD 86 FF         [ 4] 1092 	call	_i2c_send_address
      0087D8 6B 03            [ 1] 1093 	ld	(0x03, sp), a
      0087DA 84               [ 1] 1094 	pop	a
      0087DB 0D 02            [ 1] 1095 	tnz	(0x02, sp)
      0087DD 27 07            [ 1] 1096 	jreq	00102$
                                   1097 ;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
      0087DF CD 86 FA         [ 4] 1098 	call	_i2c_stop
                                   1099 ;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
      0087E2 7B 01            [ 1] 1100 	ld	a, (0x01, sp)
      0087E4 20 12            [ 2] 1101 	jra	00107$
      0087E6                       1102 00102$:
                                   1103 ;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0087E6 AE 52 18         [ 2] 1104 	ldw	x, #0x5218
      0087E9 88               [ 1] 1105 	push	a
      0087EA F6               [ 1] 1106 	ld	a, (x)
      0087EB A4 FB            [ 1] 1107 	and	a, #0xfb
      0087ED F7               [ 1] 1108 	ld	(x), a
      0087EE 84               [ 1] 1109 	pop	a
                                   1110 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087EF 4C               [ 1] 1111 	inc	a
      0087F0 6B 01            [ 1] 1112 	ld	(0x01, sp), a
      0087F2 20 DA            [ 2] 1113 	jra	00105$
      0087F4                       1114 00103$:
                                   1115 ;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
      0087F4 CD 86 FA         [ 4] 1116 	call	_i2c_stop
                                   1117 ;	./libs/i2c_lib.c: 173: return 0;
      0087F7 4F               [ 1] 1118 	clr	a
      0087F8                       1119 00107$:
                                   1120 ;	./libs/i2c_lib.c: 174: }
      0087F8 5B 02            [ 2] 1121 	addw	sp, #2
      0087FA 81               [ 4] 1122 	ret
                                   1123 ;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
                                   1124 ;	-----------------------------------------
                                   1125 ;	 function i2c_start_irq
                                   1126 ;	-----------------------------------------
      0087FB                       1127 _i2c_start_irq:
                                   1128 ;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      0087FB 72 12 52 1A      [ 1] 1129 	bset	0x521a, #1
                                   1130 ;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0087FF 72 10 52 11      [ 1] 1131 	bset	0x5211, #0
                                   1132 ;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      008803                       1133 00101$:
      008803 C6 52 1A         [ 1] 1134 	ld	a, 0x521a
      008806 A5 02            [ 1] 1135 	bcp	a, #2
      008808 26 F9            [ 1] 1136 	jrne	00101$
                                   1137 ;	./libs/i2c_lib.c: 182: }
      00880A 81               [ 4] 1138 	ret
                                   1139 ;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
                                   1140 ;	-----------------------------------------
                                   1141 ;	 function i2c_stop_irq
                                   1142 ;	-----------------------------------------
      00880B                       1143 _i2c_stop_irq:
                                   1144 ;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      00880B 72 12 52 11      [ 1] 1145 	bset	0x5211, #1
                                   1146 ;	./libs/i2c_lib.c: 187: }
      00880F 81               [ 4] 1147 	ret
                                   1148 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                   1149 ;	-----------------------------------------
                                   1150 ;	 function get_bit
                                   1151 ;	-----------------------------------------
      008810                       1152 _get_bit:
                                   1153 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      008810 7B 04            [ 1] 1154 	ld	a, (0x04, sp)
      008812 27 04            [ 1] 1155 	jreq	00113$
      008814                       1156 00112$:
      008814 57               [ 2] 1157 	sraw	x
      008815 4A               [ 1] 1158 	dec	a
      008816 26 FC            [ 1] 1159 	jrne	00112$
      008818                       1160 00113$:
      008818 54               [ 2] 1161 	srlw	x
      008819 24 03            [ 1] 1162 	jrnc	00103$
      00881B 5F               [ 1] 1163 	clrw	x
      00881C 5C               [ 1] 1164 	incw	x
      00881D 21                    1165 	.byte 0x21
      00881E                       1166 00103$:
      00881E 5F               [ 1] 1167 	clrw	x
      00881F                       1168 00104$:
                                   1169 ;	./libs/ssd1306_lib.c: 6: }
      00881F 90 85            [ 2] 1170 	popw	y
      008821 5B 02            [ 2] 1171 	addw	sp, #2
      008823 90 FC            [ 2] 1172 	jp	(y)
                                   1173 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                   1174 ;	-----------------------------------------
                                   1175 ;	 function set_bit
                                   1176 ;	-----------------------------------------
      008825                       1177 _set_bit:
      008825 52 04            [ 2] 1178 	sub	sp, #4
      008827 1F 01            [ 2] 1179 	ldw	(0x01, sp), x
                                   1180 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      008829 5F               [ 1] 1181 	clrw	x
      00882A 5C               [ 1] 1182 	incw	x
      00882B 1F 03            [ 2] 1183 	ldw	(0x03, sp), x
      00882D 7B 08            [ 1] 1184 	ld	a, (0x08, sp)
      00882F 27 07            [ 1] 1185 	jreq	00114$
      008831                       1186 00113$:
      008831 08 04            [ 1] 1187 	sll	(0x04, sp)
      008833 09 03            [ 1] 1188 	rlc	(0x03, sp)
      008835 4A               [ 1] 1189 	dec	a
      008836 26 F9            [ 1] 1190 	jrne	00113$
      008838                       1191 00114$:
                                   1192 ;	./libs/ssd1306_lib.c: 10: switch(value)
      008838 1E 09            [ 2] 1193 	ldw	x, (0x09, sp)
      00883A 5A               [ 2] 1194 	decw	x
      00883B 26 0B            [ 1] 1195 	jrne	00102$
                                   1196 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      00883D 7B 02            [ 1] 1197 	ld	a, (0x02, sp)
      00883F 1A 04            [ 1] 1198 	or	a, (0x04, sp)
      008841 97               [ 1] 1199 	ld	xl, a
      008842 7B 01            [ 1] 1200 	ld	a, (0x01, sp)
      008844 1A 03            [ 1] 1201 	or	a, (0x03, sp)
                                   1202 ;	./libs/ssd1306_lib.c: 14: break;
      008846 20 09            [ 2] 1203 	jra	00103$
                                   1204 ;	./libs/ssd1306_lib.c: 16: default:
      008848                       1205 00102$:
                                   1206 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      008848 1E 03            [ 2] 1207 	ldw	x, (0x03, sp)
      00884A 53               [ 2] 1208 	cplw	x
      00884B 9F               [ 1] 1209 	ld	a, xl
      00884C 14 02            [ 1] 1210 	and	a, (0x02, sp)
      00884E 02               [ 1] 1211 	rlwa	x
      00884F 14 01            [ 1] 1212 	and	a, (0x01, sp)
                                   1213 ;	./libs/ssd1306_lib.c: 19: }
      008851                       1214 00103$:
                                   1215 ;	./libs/ssd1306_lib.c: 20: return data;
      008851 95               [ 1] 1216 	ld	xh, a
                                   1217 ;	./libs/ssd1306_lib.c: 21: }
      008852 16 05            [ 2] 1218 	ldw	y, (5, sp)
      008854 5B 0A            [ 2] 1219 	addw	sp, #10
      008856 90 FC            [ 2] 1220 	jp	(y)
                                   1221 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                   1222 ;	-----------------------------------------
                                   1223 ;	 function ssd1306_init
                                   1224 ;	-----------------------------------------
      008858                       1225 _ssd1306_init:
      008858 52 1B            [ 2] 1226 	sub	sp, #27
                                   1227 ;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
      00885A 96               [ 1] 1228 	ldw	x, sp
      00885B 5C               [ 1] 1229 	incw	x
      00885C 7F               [ 1] 1230 	clr	(x)
      00885D A6 AE            [ 1] 1231 	ld	a, #0xae
      00885F 6B 02            [ 1] 1232 	ld	(0x02, sp), a
      008861 A6 D5            [ 1] 1233 	ld	a, #0xd5
      008863 6B 03            [ 1] 1234 	ld	(0x03, sp), a
      008865 A6 80            [ 1] 1235 	ld	a, #0x80
      008867 6B 04            [ 1] 1236 	ld	(0x04, sp), a
      008869 A6 A8            [ 1] 1237 	ld	a, #0xa8
      00886B 6B 05            [ 1] 1238 	ld	(0x05, sp), a
      00886D A6 1F            [ 1] 1239 	ld	a, #0x1f
      00886F 6B 06            [ 1] 1240 	ld	(0x06, sp), a
      008871 A6 D3            [ 1] 1241 	ld	a, #0xd3
      008873 6B 07            [ 1] 1242 	ld	(0x07, sp), a
      008875 0F 08            [ 1] 1243 	clr	(0x08, sp)
      008877 A6 40            [ 1] 1244 	ld	a, #0x40
      008879 6B 09            [ 1] 1245 	ld	(0x09, sp), a
      00887B A6 8D            [ 1] 1246 	ld	a, #0x8d
      00887D 6B 0A            [ 1] 1247 	ld	(0x0a, sp), a
      00887F A6 14            [ 1] 1248 	ld	a, #0x14
      008881 6B 0B            [ 1] 1249 	ld	(0x0b, sp), a
      008883 A6 DB            [ 1] 1250 	ld	a, #0xdb
      008885 6B 0C            [ 1] 1251 	ld	(0x0c, sp), a
      008887 A6 40            [ 1] 1252 	ld	a, #0x40
      008889 6B 0D            [ 1] 1253 	ld	(0x0d, sp), a
      00888B A6 A4            [ 1] 1254 	ld	a, #0xa4
      00888D 6B 0E            [ 1] 1255 	ld	(0x0e, sp), a
      00888F A6 A6            [ 1] 1256 	ld	a, #0xa6
      008891 6B 0F            [ 1] 1257 	ld	(0x0f, sp), a
      008893 A6 DA            [ 1] 1258 	ld	a, #0xda
      008895 6B 10            [ 1] 1259 	ld	(0x10, sp), a
      008897 A6 02            [ 1] 1260 	ld	a, #0x02
      008899 6B 11            [ 1] 1261 	ld	(0x11, sp), a
      00889B A6 81            [ 1] 1262 	ld	a, #0x81
      00889D 6B 12            [ 1] 1263 	ld	(0x12, sp), a
      00889F A6 8F            [ 1] 1264 	ld	a, #0x8f
      0088A1 6B 13            [ 1] 1265 	ld	(0x13, sp), a
      0088A3 A6 D9            [ 1] 1266 	ld	a, #0xd9
      0088A5 6B 14            [ 1] 1267 	ld	(0x14, sp), a
      0088A7 A6 F1            [ 1] 1268 	ld	a, #0xf1
      0088A9 6B 15            [ 1] 1269 	ld	(0x15, sp), a
      0088AB A6 20            [ 1] 1270 	ld	a, #0x20
      0088AD 6B 16            [ 1] 1271 	ld	(0x16, sp), a
      0088AF 0F 17            [ 1] 1272 	clr	(0x17, sp)
      0088B1 A6 A0            [ 1] 1273 	ld	a, #0xa0
      0088B3 6B 18            [ 1] 1274 	ld	(0x18, sp), a
      0088B5 A6 C0            [ 1] 1275 	ld	a, #0xc0
      0088B7 6B 19            [ 1] 1276 	ld	(0x19, sp), a
      0088B9 A6 1F            [ 1] 1277 	ld	a, #0x1f
      0088BB 6B 1A            [ 1] 1278 	ld	(0x1a, sp), a
      0088BD A6 AF            [ 1] 1279 	ld	a, #0xaf
      0088BF 6B 1B            [ 1] 1280 	ld	(0x1b, sp), a
                                   1281 ;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
      0088C1 89               [ 2] 1282 	pushw	x
      0088C2 4B 1B            [ 1] 1283 	push	#0x1b
      0088C4 A6 3C            [ 1] 1284 	ld	a, #0x3c
      0088C6 CD 87 98         [ 4] 1285 	call	_i2c_write
                                   1286 ;	./libs/ssd1306_lib.c: 43: }
      0088C9 5B 1B            [ 2] 1287 	addw	sp, #27
      0088CB 81               [ 4] 1288 	ret
                                   1289 ;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
                                   1290 ;	-----------------------------------------
                                   1291 ;	 function ssd1306_set_params_to_write
                                   1292 ;	-----------------------------------------
      0088CC                       1293 _ssd1306_set_params_to_write:
      0088CC 52 07            [ 2] 1294 	sub	sp, #7
                                   1295 ;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
      0088CE 96               [ 1] 1296 	ldw	x, sp
      0088CF 5C               [ 1] 1297 	incw	x
      0088D0 7F               [ 1] 1298 	clr	(x)
      0088D1 A6 22            [ 1] 1299 	ld	a, #0x22
      0088D3 6B 02            [ 1] 1300 	ld	(0x02, sp), a
      0088D5 0F 03            [ 1] 1301 	clr	(0x03, sp)
      0088D7 A6 03            [ 1] 1302 	ld	a, #0x03
      0088D9 6B 04            [ 1] 1303 	ld	(0x04, sp), a
      0088DB A6 21            [ 1] 1304 	ld	a, #0x21
      0088DD 6B 05            [ 1] 1305 	ld	(0x05, sp), a
      0088DF 0F 06            [ 1] 1306 	clr	(0x06, sp)
      0088E1 A6 7F            [ 1] 1307 	ld	a, #0x7f
      0088E3 6B 07            [ 1] 1308 	ld	(0x07, sp), a
                                   1309 ;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      0088E5 89               [ 2] 1310 	pushw	x
      0088E6 4B 07            [ 1] 1311 	push	#0x07
      0088E8 A6 3C            [ 1] 1312 	ld	a, #0x3c
      0088EA CD 87 98         [ 4] 1313 	call	_i2c_write
                                   1314 ;	./libs/ssd1306_lib.c: 52: }
      0088ED 5B 07            [ 2] 1315 	addw	sp, #7
      0088EF 81               [ 4] 1316 	ret
                                   1317 ;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1318 ;	-----------------------------------------
                                   1319 ;	 function ssd1306_draw_pixel
                                   1320 ;	-----------------------------------------
      0088F0                       1321 _ssd1306_draw_pixel:
      0088F0 52 08            [ 2] 1322 	sub	sp, #8
      0088F2 1F 07            [ 2] 1323 	ldw	(0x07, sp), x
                                   1324 ;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      0088F4 6B 06            [ 1] 1325 	ld	(0x06, sp), a
      0088F6 0F 05            [ 1] 1326 	clr	(0x05, sp)
      0088F8 7B 0B            [ 1] 1327 	ld	a, (0x0b, sp)
      0088FA 0F 01            [ 1] 1328 	clr	(0x01, sp)
      0088FC 97               [ 1] 1329 	ld	xl, a
      0088FD 02               [ 1] 1330 	rlwa	x
      0088FE 4F               [ 1] 1331 	clr	a
      0088FF 01               [ 1] 1332 	rrwa	x
      008900 5D               [ 2] 1333 	tnzw	x
      008901 2A 03            [ 1] 1334 	jrpl	00103$
      008903 1C 00 07         [ 2] 1335 	addw	x, #0x0007
      008906                       1336 00103$:
      008906 57               [ 2] 1337 	sraw	x
      008907 57               [ 2] 1338 	sraw	x
      008908 57               [ 2] 1339 	sraw	x
      008909 58               [ 2] 1340 	sllw	x
      00890A 58               [ 2] 1341 	sllw	x
      00890B 58               [ 2] 1342 	sllw	x
      00890C 58               [ 2] 1343 	sllw	x
      00890D 58               [ 2] 1344 	sllw	x
      00890E 58               [ 2] 1345 	sllw	x
      00890F 58               [ 2] 1346 	sllw	x
      008910 72 FB 05         [ 2] 1347 	addw	x, (0x05, sp)
      008913 72 FB 07         [ 2] 1348 	addw	x, (0x07, sp)
      008916 1F 03            [ 2] 1349 	ldw	(0x03, sp), x
      008918 90 5F            [ 1] 1350 	clrw	y
      00891A 61               [ 1] 1351 	exg	a, yl
      00891B 7B 0C            [ 1] 1352 	ld	a, (0x0c, sp)
      00891D 61               [ 1] 1353 	exg	a, yl
      00891E A4 07            [ 1] 1354 	and	a, #0x07
      008920 6B 06            [ 1] 1355 	ld	(0x06, sp), a
      008922 0F 05            [ 1] 1356 	clr	(0x05, sp)
      008924 1E 03            [ 2] 1357 	ldw	x, (0x03, sp)
      008926 F6               [ 1] 1358 	ld	a, (x)
      008927 5F               [ 1] 1359 	clrw	x
      008928 90 89            [ 2] 1360 	pushw	y
      00892A 16 07            [ 2] 1361 	ldw	y, (0x07, sp)
      00892C 90 89            [ 2] 1362 	pushw	y
      00892E 97               [ 1] 1363 	ld	xl, a
      00892F CD 88 25         [ 4] 1364 	call	_set_bit
      008932 9F               [ 1] 1365 	ld	a, xl
      008933 1E 03            [ 2] 1366 	ldw	x, (0x03, sp)
      008935 F7               [ 1] 1367 	ld	(x), a
                                   1368 ;	./libs/ssd1306_lib.c: 57: }
      008936 1E 09            [ 2] 1369 	ldw	x, (9, sp)
      008938 5B 0C            [ 2] 1370 	addw	sp, #12
      00893A FC               [ 2] 1371 	jp	(x)
                                   1372 ;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
                                   1373 ;	-----------------------------------------
                                   1374 ;	 function ssd1306_buffer_clean
                                   1375 ;	-----------------------------------------
      00893B                       1376 _ssd1306_buffer_clean:
                                   1377 ;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
      00893B 4B 00            [ 1] 1378 	push	#0x00
      00893D 4B 02            [ 1] 1379 	push	#0x02
      00893F 5F               [ 1] 1380 	clrw	x
      008940 89               [ 2] 1381 	pushw	x
      008941 AE 01 70         [ 2] 1382 	ldw	x, #(_main_buffer+0)
      008944 CD 8F 90         [ 4] 1383 	call	_memset
                                   1384 ;	./libs/ssd1306_lib.c: 62: }
      008947 81               [ 4] 1385 	ret
                                   1386 ;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
                                   1387 ;	-----------------------------------------
                                   1388 ;	 function ssd1306_send_buffer
                                   1389 ;	-----------------------------------------
      008948                       1390 _ssd1306_send_buffer:
      008948 52 04            [ 2] 1391 	sub	sp, #4
                                   1392 ;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
      00894A CD 88 CC         [ 4] 1393 	call	_ssd1306_set_params_to_write
                                   1394 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      00894D 5F               [ 1] 1395 	clrw	x
      00894E 1F 03            [ 2] 1396 	ldw	(0x03, sp), x
      008950                       1397 00112$:
      008950 1E 03            [ 2] 1398 	ldw	x, (0x03, sp)
      008952 A3 00 04         [ 2] 1399 	cpw	x, #0x0004
      008955 2E 43            [ 1] 1400 	jrsge	00114$
                                   1401 ;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
      008957 4B 00            [ 1] 1402 	push	#0x00
      008959 A6 3C            [ 1] 1403 	ld	a, #0x3c
      00895B CD 86 FF         [ 4] 1404 	call	_i2c_send_address
      00895E 4D               [ 1] 1405 	tnz	a
      00895F 27 2F            [ 1] 1406 	jreq	00105$
                                   1407 ;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
      008961 A6 40            [ 1] 1408 	ld	a, #0x40
      008963 CD 87 86         [ 4] 1409 	call	_i2c_send_byte
                                   1410 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      008966 1E 03            [ 2] 1411 	ldw	x, (0x03, sp)
      008968 58               [ 2] 1412 	sllw	x
      008969 58               [ 2] 1413 	sllw	x
      00896A 58               [ 2] 1414 	sllw	x
      00896B 58               [ 2] 1415 	sllw	x
      00896C 58               [ 2] 1416 	sllw	x
      00896D 58               [ 2] 1417 	sllw	x
      00896E 58               [ 2] 1418 	sllw	x
      00896F 1F 01            [ 2] 1419 	ldw	(0x01, sp), x
      008971 5F               [ 1] 1420 	clrw	x
      008972                       1421 00109$:
      008972 A3 00 80         [ 2] 1422 	cpw	x, #0x0080
      008975 2E 14            [ 1] 1423 	jrsge	00103$
                                   1424 ;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i+(128*j)]))//Проверка на АСК бит
      008977 90 93            [ 1] 1425 	ldw	y, x
      008979 72 F9 01         [ 2] 1426 	addw	y, (0x01, sp)
      00897C 90 D6 01 70      [ 1] 1427 	ld	a, (_main_buffer+0, y)
      008980 89               [ 2] 1428 	pushw	x
      008981 CD 87 86         [ 4] 1429 	call	_i2c_send_byte
      008984 85               [ 2] 1430 	popw	x
      008985 4D               [ 1] 1431 	tnz	a
      008986 26 03            [ 1] 1432 	jrne	00103$
                                   1433 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      008988 5C               [ 1] 1434 	incw	x
      008989 20 E7            [ 2] 1435 	jra	00109$
      00898B                       1436 00103$:
                                   1437 ;	./libs/ssd1306_lib.c: 78: i2c_stop();
      00898B CD 86 FA         [ 4] 1438 	call	_i2c_stop
      00898E 20 03            [ 2] 1439 	jra	00113$
      008990                       1440 00105$:
                                   1441 ;	./libs/ssd1306_lib.c: 81: i2c_stop();
      008990 CD 86 FA         [ 4] 1442 	call	_i2c_stop
      008993                       1443 00113$:
                                   1444 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008993 1E 03            [ 2] 1445 	ldw	x, (0x03, sp)
      008995 5C               [ 1] 1446 	incw	x
      008996 1F 03            [ 2] 1447 	ldw	(0x03, sp), x
      008998 20 B6            [ 2] 1448 	jra	00112$
      00899A                       1449 00114$:
                                   1450 ;	./libs/ssd1306_lib.c: 83: }
      00899A 5B 04            [ 2] 1451 	addw	sp, #4
      00899C 81               [ 4] 1452 	ret
                                   1453 ;	./libs/ssd1306_lib.c: 85: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
                                   1454 ;	-----------------------------------------
                                   1455 ;	 function ssd1306_buffer_write
                                   1456 ;	-----------------------------------------
      00899D                       1457 _ssd1306_buffer_write:
      00899D 52 0D            [ 2] 1458 	sub	sp, #13
      00899F 1F 08            [ 2] 1459 	ldw	(0x08, sp), x
                                   1460 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      0089A1 5F               [ 1] 1461 	clrw	x
      0089A2 1F 0A            [ 2] 1462 	ldw	(0x0a, sp), x
      0089A4                       1463 00109$:
      0089A4 1E 0A            [ 2] 1464 	ldw	x, (0x0a, sp)
      0089A6 A3 00 08         [ 2] 1465 	cpw	x, #0x0008
      0089A9 2F 03            [ 1] 1466 	jrslt	00150$
      0089AB CC 8A 2D         [ 2] 1467 	jp	00111$
      0089AE                       1468 00150$:
                                   1469 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      0089AE 1E 12            [ 2] 1470 	ldw	x, (0x12, sp)
      0089B0 72 FB 0A         [ 2] 1471 	addw	x, (0x0a, sp)
      0089B3 1F 05            [ 2] 1472 	ldw	(0x05, sp), x
      0089B5 5F               [ 1] 1473 	clrw	x
      0089B6 1F 0C            [ 2] 1474 	ldw	(0x0c, sp), x
      0089B8                       1475 00106$:
      0089B8 1E 0C            [ 2] 1476 	ldw	x, (0x0c, sp)
      0089BA A3 00 08         [ 2] 1477 	cpw	x, #0x0008
      0089BD 2E 66            [ 1] 1478 	jrsge	00110$
                                   1479 ;	./libs/ssd1306_lib.c: 90: if(data[height + width / 8] & (128 >> (width & 7)))
      0089BF 1E 0A            [ 2] 1480 	ldw	x, (0x0a, sp)
      0089C1 72 FB 12         [ 2] 1481 	addw	x, (0x12, sp)
      0089C4 F6               [ 1] 1482 	ld	a, (x)
      0089C5 6B 07            [ 1] 1483 	ld	(0x07, sp), a
      0089C7 7B 0D            [ 1] 1484 	ld	a, (0x0d, sp)
      0089C9 A4 07            [ 1] 1485 	and	a, #0x07
      0089CB AE 00 80         [ 2] 1486 	ldw	x, #0x0080
      0089CE 4D               [ 1] 1487 	tnz	a
      0089CF 27 04            [ 1] 1488 	jreq	00153$
      0089D1                       1489 00152$:
      0089D1 57               [ 2] 1490 	sraw	x
      0089D2 4A               [ 1] 1491 	dec	a
      0089D3 26 FC            [ 1] 1492 	jrne	00152$
      0089D5                       1493 00153$:
      0089D5 1F 01            [ 2] 1494 	ldw	(0x01, sp), x
      0089D7 7B 07            [ 1] 1495 	ld	a, (0x07, sp)
      0089D9 14 02            [ 1] 1496 	and	a, (0x02, sp)
      0089DB 6B 04            [ 1] 1497 	ld	(0x04, sp), a
      0089DD 0F 03            [ 1] 1498 	clr	(0x03, sp)
      0089DF 1E 03            [ 2] 1499 	ldw	x, (0x03, sp)
      0089E1 27 3B            [ 1] 1500 	jreq	00107$
                                   1501 ;	./libs/ssd1306_lib.c: 91: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(data[height], 7 - (width % 8)));
      0089E3 4B 08            [ 1] 1502 	push	#0x08
      0089E5 4B 00            [ 1] 1503 	push	#0x00
      0089E7 1E 0E            [ 2] 1504 	ldw	x, (0x0e, sp)
      0089E9 CD 8F B4         [ 4] 1505 	call	__modsint
      0089EC 1F 03            [ 2] 1506 	ldw	(0x03, sp), x
      0089EE 90 AE 00 07      [ 2] 1507 	ldw	y, #0x0007
      0089F2 72 F2 03         [ 2] 1508 	subw	y, (0x03, sp)
      0089F5 1E 05            [ 2] 1509 	ldw	x, (0x05, sp)
      0089F7 F6               [ 1] 1510 	ld	a, (x)
      0089F8 5F               [ 1] 1511 	clrw	x
      0089F9 90 89            [ 2] 1512 	pushw	y
      0089FB 97               [ 1] 1513 	ld	xl, a
      0089FC CD 88 10         [ 4] 1514 	call	_get_bit
      0089FF 7B 11            [ 1] 1515 	ld	a, (0x11, sp)
      008A01 6B 07            [ 1] 1516 	ld	(0x07, sp), a
      008A03 7B 0B            [ 1] 1517 	ld	a, (0x0b, sp)
      008A05 1B 07            [ 1] 1518 	add	a, (0x07, sp)
      008A07 95               [ 1] 1519 	ld	xh, a
      008A08 7B 09            [ 1] 1520 	ld	a, (0x09, sp)
      008A0A 6B 07            [ 1] 1521 	ld	(0x07, sp), a
      008A0C 7B 0D            [ 1] 1522 	ld	a, (0x0d, sp)
      008A0E 1B 07            [ 1] 1523 	add	a, (0x07, sp)
      008A10 6B 07            [ 1] 1524 	ld	(0x07, sp), a
      008A12 9F               [ 1] 1525 	ld	a, xl
      008A13 88               [ 1] 1526 	push	a
      008A14 9E               [ 1] 1527 	ld	a, xh
      008A15 88               [ 1] 1528 	push	a
      008A16 7B 09            [ 1] 1529 	ld	a, (0x09, sp)
      008A18 AE 01 70         [ 2] 1530 	ldw	x, #(_main_buffer+0)
      008A1B CD 88 F0         [ 4] 1531 	call	_ssd1306_draw_pixel
      008A1E                       1532 00107$:
                                   1533 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      008A1E 1E 0C            [ 2] 1534 	ldw	x, (0x0c, sp)
      008A20 5C               [ 1] 1535 	incw	x
      008A21 1F 0C            [ 2] 1536 	ldw	(0x0c, sp), x
      008A23 20 93            [ 2] 1537 	jra	00106$
      008A25                       1538 00110$:
                                   1539 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      008A25 1E 0A            [ 2] 1540 	ldw	x, (0x0a, sp)
      008A27 5C               [ 1] 1541 	incw	x
      008A28 1F 0A            [ 2] 1542 	ldw	(0x0a, sp), x
      008A2A CC 89 A4         [ 2] 1543 	jp	00109$
      008A2D                       1544 00111$:
                                   1545 ;	./libs/ssd1306_lib.c: 93: }
      008A2D 1E 0E            [ 2] 1546 	ldw	x, (14, sp)
      008A2F 5B 13            [ 2] 1547 	addw	sp, #19
      008A31 FC               [ 2] 1548 	jp	(x)
                                   1549 ;	./libs/ssd1306_lib.c: 95: void ssd1306_clean(void)
                                   1550 ;	-----------------------------------------
                                   1551 ;	 function ssd1306_clean
                                   1552 ;	-----------------------------------------
      008A32                       1553 _ssd1306_clean:
                                   1554 ;	./libs/ssd1306_lib.c: 97: ssd1306_buffer_clean();
      008A32 CD 89 3B         [ 4] 1555 	call	_ssd1306_buffer_clean
                                   1556 ;	./libs/ssd1306_lib.c: 98: ssd1306_send_buffer();
                                   1557 ;	./libs/ssd1306_lib.c: 99: }
      008A35 CC 89 48         [ 2] 1558 	jp	_ssd1306_send_buffer
                                   1559 ;	./libs/menu_lib.c: 3: void menu_border(void)
                                   1560 ;	-----------------------------------------
                                   1561 ;	 function menu_border
                                   1562 ;	-----------------------------------------
      008A38                       1563 _menu_border:
      008A38 52 04            [ 2] 1564 	sub	sp, #4
                                   1565 ;	./libs/menu_lib.c: 5: ssd1306_buffer_write(0,0,ttf_eng_corner_left_up);
      008A3A 4B 30            [ 1] 1566 	push	#<(_ttf_eng_corner_left_up+0)
      008A3C 4B 01            [ 1] 1567 	push	#((_ttf_eng_corner_left_up+0) >> 8)
      008A3E 5F               [ 1] 1568 	clrw	x
      008A3F 89               [ 2] 1569 	pushw	x
      008A40 5F               [ 1] 1570 	clrw	x
      008A41 CD 89 9D         [ 4] 1571 	call	_ssd1306_buffer_write
                                   1572 ;	./libs/menu_lib.c: 6: for(int x = 1;x<15;x++)
      008A44 5F               [ 1] 1573 	clrw	x
      008A45 5C               [ 1] 1574 	incw	x
      008A46 1F 03            [ 2] 1575 	ldw	(0x03, sp), x
      008A48                       1576 00104$:
      008A48 1E 03            [ 2] 1577 	ldw	x, (0x03, sp)
      008A4A A3 00 0F         [ 2] 1578 	cpw	x, #0x000f
      008A4D 2E 19            [ 1] 1579 	jrsge	00101$
                                   1580 ;	./libs/menu_lib.c: 7: ssd1306_buffer_write(x*8,0,ttf_eng_line_up);
      008A4F 1E 03            [ 2] 1581 	ldw	x, (0x03, sp)
      008A51 58               [ 2] 1582 	sllw	x
      008A52 58               [ 2] 1583 	sllw	x
      008A53 58               [ 2] 1584 	sllw	x
      008A54 1F 01            [ 2] 1585 	ldw	(0x01, sp), x
      008A56 4B 60            [ 1] 1586 	push	#<(_ttf_eng_line_up+0)
      008A58 4B 01            [ 1] 1587 	push	#((_ttf_eng_line_up+0) >> 8)
      008A5A 5F               [ 1] 1588 	clrw	x
      008A5B 89               [ 2] 1589 	pushw	x
      008A5C 1E 05            [ 2] 1590 	ldw	x, (0x05, sp)
      008A5E CD 89 9D         [ 4] 1591 	call	_ssd1306_buffer_write
                                   1592 ;	./libs/menu_lib.c: 6: for(int x = 1;x<15;x++)
      008A61 1E 03            [ 2] 1593 	ldw	x, (0x03, sp)
      008A63 5C               [ 1] 1594 	incw	x
      008A64 1F 03            [ 2] 1595 	ldw	(0x03, sp), x
      008A66 20 E0            [ 2] 1596 	jra	00104$
      008A68                       1597 00101$:
                                   1598 ;	./libs/menu_lib.c: 8: ssd1306_buffer_write(120,0,ttf_eng_corner_right_up);
      008A68 4B 38            [ 1] 1599 	push	#<(_ttf_eng_corner_right_up+0)
      008A6A 4B 01            [ 1] 1600 	push	#((_ttf_eng_corner_right_up+0) >> 8)
      008A6C 5F               [ 1] 1601 	clrw	x
      008A6D 89               [ 2] 1602 	pushw	x
      008A6E AE 00 78         [ 2] 1603 	ldw	x, #0x0078
      008A71 CD 89 9D         [ 4] 1604 	call	_ssd1306_buffer_write
                                   1605 ;	./libs/menu_lib.c: 10: ssd1306_buffer_write(0,8,ttf_eng_line_left);
      008A74 4B 58            [ 1] 1606 	push	#<(_ttf_eng_line_left+0)
      008A76 4B 01            [ 1] 1607 	push	#((_ttf_eng_line_left+0) >> 8)
      008A78 4B 08            [ 1] 1608 	push	#0x08
      008A7A 4B 00            [ 1] 1609 	push	#0x00
      008A7C 5F               [ 1] 1610 	clrw	x
      008A7D CD 89 9D         [ 4] 1611 	call	_ssd1306_buffer_write
                                   1612 ;	./libs/menu_lib.c: 11: ssd1306_buffer_write(0,16,ttf_eng_line_left);
      008A80 4B 58            [ 1] 1613 	push	#<(_ttf_eng_line_left+0)
      008A82 4B 01            [ 1] 1614 	push	#((_ttf_eng_line_left+0) >> 8)
      008A84 4B 10            [ 1] 1615 	push	#0x10
      008A86 4B 00            [ 1] 1616 	push	#0x00
      008A88 5F               [ 1] 1617 	clrw	x
      008A89 CD 89 9D         [ 4] 1618 	call	_ssd1306_buffer_write
                                   1619 ;	./libs/menu_lib.c: 13: ssd1306_buffer_write(120,8,ttf_eng_line_right);
      008A8C 4B 50            [ 1] 1620 	push	#<(_ttf_eng_line_right+0)
      008A8E 4B 01            [ 1] 1621 	push	#((_ttf_eng_line_right+0) >> 8)
      008A90 4B 08            [ 1] 1622 	push	#0x08
      008A92 4B 00            [ 1] 1623 	push	#0x00
      008A94 AE 00 78         [ 2] 1624 	ldw	x, #0x0078
      008A97 CD 89 9D         [ 4] 1625 	call	_ssd1306_buffer_write
                                   1626 ;	./libs/menu_lib.c: 14: ssd1306_buffer_write(120,16,ttf_eng_line_right);
      008A9A 4B 50            [ 1] 1627 	push	#<(_ttf_eng_line_right+0)
      008A9C 4B 01            [ 1] 1628 	push	#((_ttf_eng_line_right+0) >> 8)
      008A9E 4B 10            [ 1] 1629 	push	#0x10
      008AA0 4B 00            [ 1] 1630 	push	#0x00
      008AA2 AE 00 78         [ 2] 1631 	ldw	x, #0x0078
      008AA5 CD 89 9D         [ 4] 1632 	call	_ssd1306_buffer_write
                                   1633 ;	./libs/menu_lib.c: 16: ssd1306_buffer_write(0,24,ttf_eng_corner_left_down);
      008AA8 4B 40            [ 1] 1634 	push	#<(_ttf_eng_corner_left_down+0)
      008AAA 4B 01            [ 1] 1635 	push	#((_ttf_eng_corner_left_down+0) >> 8)
      008AAC 4B 18            [ 1] 1636 	push	#0x18
      008AAE 4B 00            [ 1] 1637 	push	#0x00
      008AB0 5F               [ 1] 1638 	clrw	x
      008AB1 CD 89 9D         [ 4] 1639 	call	_ssd1306_buffer_write
                                   1640 ;	./libs/menu_lib.c: 17: for(int x = 1;x<15;x++)
      008AB4 5F               [ 1] 1641 	clrw	x
      008AB5 5C               [ 1] 1642 	incw	x
      008AB6                       1643 00107$:
      008AB6 A3 00 0F         [ 2] 1644 	cpw	x, #0x000f
      008AB9 2E 19            [ 1] 1645 	jrsge	00102$
                                   1646 ;	./libs/menu_lib.c: 18: ssd1306_buffer_write(x*8,24,ttf_eng_line_down);
      008ABB 90 93            [ 1] 1647 	ldw	y, x
      008ABD 90 58            [ 2] 1648 	sllw	y
      008ABF 90 58            [ 2] 1649 	sllw	y
      008AC1 90 58            [ 2] 1650 	sllw	y
      008AC3 89               [ 2] 1651 	pushw	x
      008AC4 4B 68            [ 1] 1652 	push	#<(_ttf_eng_line_down+0)
      008AC6 4B 01            [ 1] 1653 	push	#((_ttf_eng_line_down+0) >> 8)
      008AC8 4B 18            [ 1] 1654 	push	#0x18
      008ACA 4B 00            [ 1] 1655 	push	#0x00
      008ACC 93               [ 1] 1656 	ldw	x, y
      008ACD CD 89 9D         [ 4] 1657 	call	_ssd1306_buffer_write
      008AD0 85               [ 2] 1658 	popw	x
                                   1659 ;	./libs/menu_lib.c: 17: for(int x = 1;x<15;x++)
      008AD1 5C               [ 1] 1660 	incw	x
      008AD2 20 E2            [ 2] 1661 	jra	00107$
      008AD4                       1662 00102$:
                                   1663 ;	./libs/menu_lib.c: 19: ssd1306_buffer_write(120,24,ttf_eng_corner_right_down);
      008AD4 4B 48            [ 1] 1664 	push	#<(_ttf_eng_corner_right_down+0)
      008AD6 4B 01            [ 1] 1665 	push	#((_ttf_eng_corner_right_down+0) >> 8)
      008AD8 4B 18            [ 1] 1666 	push	#0x18
      008ADA 4B 00            [ 1] 1667 	push	#0x00
      008ADC AE 00 78         [ 2] 1668 	ldw	x, #0x0078
      008ADF CD 89 9D         [ 4] 1669 	call	_ssd1306_buffer_write
                                   1670 ;	./libs/menu_lib.c: 21: }
      008AE2 5B 04            [ 2] 1671 	addw	sp, #4
      008AE4 81               [ 4] 1672 	ret
                                   1673 ;	./libs/menu_lib.c: 23: void menu_border_splash(uint8_t number_of_letters)
                                   1674 ;	-----------------------------------------
                                   1675 ;	 function menu_border_splash
                                   1676 ;	-----------------------------------------
      008AE5                       1677 _menu_border_splash:
      008AE5 52 07            [ 2] 1678 	sub	sp, #7
      008AE7 6B 07            [ 1] 1679 	ld	(0x07, sp), a
                                   1680 ;	./libs/menu_lib.c: 25: ssd1306_buffer_write(6,8,ttf_eng_corner_left_up);
      008AE9 4B 30            [ 1] 1681 	push	#<(_ttf_eng_corner_left_up+0)
      008AEB 4B 01            [ 1] 1682 	push	#((_ttf_eng_corner_left_up+0) >> 8)
      008AED 4B 08            [ 1] 1683 	push	#0x08
      008AEF 4B 00            [ 1] 1684 	push	#0x00
      008AF1 AE 00 06         [ 2] 1685 	ldw	x, #0x0006
      008AF4 CD 89 9D         [ 4] 1686 	call	_ssd1306_buffer_write
                                   1687 ;	./libs/menu_lib.c: 26: ssd1306_buffer_write(6,16,ttf_eng_corner_left_down);
      008AF7 4B 40            [ 1] 1688 	push	#<(_ttf_eng_corner_left_down+0)
      008AF9 4B 01            [ 1] 1689 	push	#((_ttf_eng_corner_left_down+0) >> 8)
      008AFB 4B 10            [ 1] 1690 	push	#0x10
      008AFD 4B 00            [ 1] 1691 	push	#0x00
      008AFF AE 00 06         [ 2] 1692 	ldw	x, #0x0006
      008B02 CD 89 9D         [ 4] 1693 	call	_ssd1306_buffer_write
                                   1694 ;	./libs/menu_lib.c: 27: for(int x = 1;x<number_of_letters+1;x++)
      008B05 5F               [ 1] 1695 	clrw	x
      008B06 5C               [ 1] 1696 	incw	x
      008B07 1F 05            [ 2] 1697 	ldw	(0x05, sp), x
      008B09                       1698 00104$:
      008B09 90 5F            [ 1] 1699 	clrw	y
      008B0B 7B 07            [ 1] 1700 	ld	a, (0x07, sp)
      008B0D 90 97            [ 1] 1701 	ld	yl, a
      008B0F 93               [ 1] 1702 	ldw	x, y
      008B10 5C               [ 1] 1703 	incw	x
      008B11 1F 01            [ 2] 1704 	ldw	(0x01, sp), x
      008B13 1E 05            [ 2] 1705 	ldw	x, (0x05, sp)
      008B15 13 01            [ 2] 1706 	cpw	x, (0x01, sp)
      008B17 2E 20            [ 1] 1707 	jrsge	00101$
                                   1708 ;	./libs/menu_lib.c: 28: ssd1306_buffer_write(6+x*8,8,ttf_eng_line_up);
      008B19 1E 05            [ 2] 1709 	ldw	x, (0x05, sp)
      008B1B 58               [ 2] 1710 	sllw	x
      008B1C 58               [ 2] 1711 	sllw	x
      008B1D 58               [ 2] 1712 	sllw	x
      008B1E 1F 01            [ 2] 1713 	ldw	(0x01, sp), x
      008B20 1C 00 06         [ 2] 1714 	addw	x, #0x0006
      008B23 1F 03            [ 2] 1715 	ldw	(0x03, sp), x
      008B25 4B 60            [ 1] 1716 	push	#<(_ttf_eng_line_up+0)
      008B27 4B 01            [ 1] 1717 	push	#((_ttf_eng_line_up+0) >> 8)
      008B29 4B 08            [ 1] 1718 	push	#0x08
      008B2B 4B 00            [ 1] 1719 	push	#0x00
      008B2D 1E 07            [ 2] 1720 	ldw	x, (0x07, sp)
      008B2F CD 89 9D         [ 4] 1721 	call	_ssd1306_buffer_write
                                   1722 ;	./libs/menu_lib.c: 27: for(int x = 1;x<number_of_letters+1;x++)
      008B32 1E 05            [ 2] 1723 	ldw	x, (0x05, sp)
      008B34 5C               [ 1] 1724 	incw	x
      008B35 1F 05            [ 2] 1725 	ldw	(0x05, sp), x
      008B37 20 D0            [ 2] 1726 	jra	00104$
      008B39                       1727 00101$:
                                   1728 ;	./libs/menu_lib.c: 29: ssd1306_buffer_write(6+number_of_letters*8,8,ttf_eng_corner_right_up);
      008B39 93               [ 1] 1729 	ldw	x, y
      008B3A 58               [ 2] 1730 	sllw	x
      008B3B 58               [ 2] 1731 	sllw	x
      008B3C 58               [ 2] 1732 	sllw	x
      008B3D 9F               [ 1] 1733 	ld	a, xl
      008B3E AB 06            [ 1] 1734 	add	a, #0x06
      008B40 6B 04            [ 1] 1735 	ld	(0x04, sp), a
      008B42 9E               [ 1] 1736 	ld	a, xh
      008B43 A9 00            [ 1] 1737 	adc	a, #0x00
      008B45 6B 03            [ 1] 1738 	ld	(0x03, sp), a
      008B47 89               [ 2] 1739 	pushw	x
      008B48 4B 38            [ 1] 1740 	push	#<(_ttf_eng_corner_right_up+0)
      008B4A 4B 01            [ 1] 1741 	push	#((_ttf_eng_corner_right_up+0) >> 8)
      008B4C 4B 08            [ 1] 1742 	push	#0x08
      008B4E 4B 00            [ 1] 1743 	push	#0x00
      008B50 1E 09            [ 2] 1744 	ldw	x, (0x09, sp)
      008B52 CD 89 9D         [ 4] 1745 	call	_ssd1306_buffer_write
      008B55 85               [ 2] 1746 	popw	x
                                   1747 ;	./libs/menu_lib.c: 30: ssd1306_buffer_write(12+number_of_letters*8,0,ttf_eng_line_left);
      008B56 1C 00 0C         [ 2] 1748 	addw	x, #0x000c
      008B59 1F 05            [ 2] 1749 	ldw	(0x05, sp), x
      008B5B 4B 58            [ 1] 1750 	push	#<(_ttf_eng_line_left+0)
      008B5D 4B 01            [ 1] 1751 	push	#((_ttf_eng_line_left+0) >> 8)
      008B5F 5F               [ 1] 1752 	clrw	x
      008B60 89               [ 2] 1753 	pushw	x
      008B61 1E 09            [ 2] 1754 	ldw	x, (0x09, sp)
      008B63 CD 89 9D         [ 4] 1755 	call	_ssd1306_buffer_write
                                   1756 ;	./libs/menu_lib.c: 33: ssd1306_buffer_write(6,16,ttf_eng_corner_left_down);
      008B66 4B 40            [ 1] 1757 	push	#<(_ttf_eng_corner_left_down+0)
      008B68 4B 01            [ 1] 1758 	push	#((_ttf_eng_corner_left_down+0) >> 8)
      008B6A 4B 10            [ 1] 1759 	push	#0x10
      008B6C 4B 00            [ 1] 1760 	push	#0x00
      008B6E AE 00 06         [ 2] 1761 	ldw	x, #0x0006
      008B71 CD 89 9D         [ 4] 1762 	call	_ssd1306_buffer_write
                                   1763 ;	./libs/menu_lib.c: 34: for(int x = 1;x<number_of_letters+1;x++)
      008B74 5F               [ 1] 1764 	clrw	x
      008B75 5C               [ 1] 1765 	incw	x
      008B76                       1766 00107$:
      008B76 13 01            [ 2] 1767 	cpw	x, (0x01, sp)
      008B78 2E 1D            [ 1] 1768 	jrsge	00102$
                                   1769 ;	./libs/menu_lib.c: 35: ssd1306_buffer_write(6+x*8,16,ttf_eng_line_down);
      008B7A 90 93            [ 1] 1770 	ldw	y, x
      008B7C 90 58            [ 2] 1771 	sllw	y
      008B7E 90 58            [ 2] 1772 	sllw	y
      008B80 90 58            [ 2] 1773 	sllw	y
      008B82 72 A9 00 06      [ 2] 1774 	addw	y, #0x0006
      008B86 89               [ 2] 1775 	pushw	x
      008B87 4B 68            [ 1] 1776 	push	#<(_ttf_eng_line_down+0)
      008B89 4B 01            [ 1] 1777 	push	#((_ttf_eng_line_down+0) >> 8)
      008B8B 4B 10            [ 1] 1778 	push	#0x10
      008B8D 4B 00            [ 1] 1779 	push	#0x00
      008B8F 93               [ 1] 1780 	ldw	x, y
      008B90 CD 89 9D         [ 4] 1781 	call	_ssd1306_buffer_write
      008B93 85               [ 2] 1782 	popw	x
                                   1783 ;	./libs/menu_lib.c: 34: for(int x = 1;x<number_of_letters+1;x++)
      008B94 5C               [ 1] 1784 	incw	x
      008B95 20 DF            [ 2] 1785 	jra	00107$
      008B97                       1786 00102$:
                                   1787 ;	./libs/menu_lib.c: 36: ssd1306_buffer_write(6+number_of_letters*8,16,ttf_eng_corner_right_down);
      008B97 4B 48            [ 1] 1788 	push	#<(_ttf_eng_corner_right_down+0)
      008B99 4B 01            [ 1] 1789 	push	#((_ttf_eng_corner_right_down+0) >> 8)
      008B9B 4B 10            [ 1] 1790 	push	#0x10
      008B9D 4B 00            [ 1] 1791 	push	#0x00
      008B9F 1E 07            [ 2] 1792 	ldw	x, (0x07, sp)
      008BA1 CD 89 9D         [ 4] 1793 	call	_ssd1306_buffer_write
                                   1794 ;	./libs/menu_lib.c: 37: ssd1306_buffer_write(12+number_of_letters*8,24,ttf_eng_line_left);
      008BA4 4B 58            [ 1] 1795 	push	#<(_ttf_eng_line_left+0)
      008BA6 4B 01            [ 1] 1796 	push	#((_ttf_eng_line_left+0) >> 8)
      008BA8 4B 18            [ 1] 1797 	push	#0x18
      008BAA 4B 00            [ 1] 1798 	push	#0x00
      008BAC 1E 09            [ 2] 1799 	ldw	x, (0x09, sp)
      008BAE CD 89 9D         [ 4] 1800 	call	_ssd1306_buffer_write
                                   1801 ;	./libs/menu_lib.c: 41: }
      008BB1 5B 07            [ 2] 1802 	addw	sp, #7
      008BB3 81               [ 4] 1803 	ret
                                   1804 ;	./libs/menu_lib.c: 42: void menu_set_item_menu(uint8_t item)
                                   1805 ;	-----------------------------------------
                                   1806 ;	 function menu_set_item_menu
                                   1807 ;	-----------------------------------------
      008BB4                       1808 _menu_set_item_menu:
                                   1809 ;	./libs/menu_lib.c: 45: switch(item)
      008BB4 A1 07            [ 1] 1810 	cp	a, #0x07
      008BB6 23 01            [ 2] 1811 	jrule	00118$
      008BB8 81               [ 4] 1812 	ret
      008BB9                       1813 00118$:
      008BB9 5F               [ 1] 1814 	clrw	x
      008BBA 97               [ 1] 1815 	ld	xl, a
      008BBB 58               [ 2] 1816 	sllw	x
      008BBC DE 8B C0         [ 2] 1817 	ldw	x, (#00119$, x)
      008BBF FC               [ 2] 1818 	jp	(x)
      008BC0                       1819 00119$:
      008BC0 8B D0                 1820 	.dw	#00109$
      008BC2 8B D0                 1821 	.dw	#00109$
      008BC4 8B D0                 1822 	.dw	#00109$
      008BC6 8B D0                 1823 	.dw	#00109$
      008BC8 8B D0                 1824 	.dw	#00109$
      008BCA 8B D0                 1825 	.dw	#00109$
      008BCC 8B D0                 1826 	.dw	#00109$
      008BCE 8B D0                 1827 	.dw	#00109$
                                   1828 ;	./libs/menu_lib.c: 68: }
      008BD0                       1829 00109$:
                                   1830 ;	./libs/menu_lib.c: 70: }
      008BD0 81               [ 4] 1831 	ret
                                   1832 ;	./libs/menu_lib.c: 71: void menu_set_paragraph(uint8_t paragraph)
                                   1833 ;	-----------------------------------------
                                   1834 ;	 function menu_set_paragraph
                                   1835 ;	-----------------------------------------
      008BD1                       1836 _menu_set_paragraph:
                                   1837 ;	./libs/menu_lib.c: 73: switch(paragraph)
      008BD1 A1 00            [ 1] 1838 	cp	a, #0x00
      008BD3 27 16            [ 1] 1839 	jreq	00101$
      008BD5 A1 01            [ 1] 1840 	cp	a, #0x01
      008BD7 26 03            [ 1] 1841 	jrne	00140$
      008BD9 CC 8D 73         [ 2] 1842 	jp	00102$
      008BDC                       1843 00140$:
      008BDC A1 02            [ 1] 1844 	cp	a, #0x02
      008BDE 26 03            [ 1] 1845 	jrne	00143$
      008BE0 CC 8D C7         [ 2] 1846 	jp	00103$
      008BE3                       1847 00143$:
      008BE3 A1 03            [ 1] 1848 	cp	a, #0x03
      008BE5 26 03            [ 1] 1849 	jrne	00146$
      008BE7 CC 8E 37         [ 2] 1850 	jp	00104$
      008BEA                       1851 00146$:
      008BEA 81               [ 4] 1852 	ret
                                   1853 ;	./libs/menu_lib.c: 75: case menu:
      008BEB                       1854 00101$:
                                   1855 ;	./libs/menu_lib.c: 76: ssd1306_buffer_clean();
      008BEB CD 89 3B         [ 4] 1856 	call	_ssd1306_buffer_clean
                                   1857 ;	./libs/menu_lib.c: 77: menu_border();
      008BEE CD 8A 38         [ 4] 1858 	call	_menu_border
                                   1859 ;	./libs/menu_lib.c: 78: menu_border_splash(4);
      008BF1 A6 04            [ 1] 1860 	ld	a, #0x04
      008BF3 CD 8A E5         [ 4] 1861 	call	_menu_border_splash
                                   1862 ;	./libs/menu_lib.c: 80: ssd1306_buffer_write(10,12,ttf_eng_m);
      008BF6 4B 70            [ 1] 1863 	push	#<(_ttf_eng_m+0)
      008BF8 4B 00            [ 1] 1864 	push	#((_ttf_eng_m+0) >> 8)
      008BFA 4B 0C            [ 1] 1865 	push	#0x0c
      008BFC 4B 00            [ 1] 1866 	push	#0x00
      008BFE AE 00 0A         [ 2] 1867 	ldw	x, #0x000a
      008C01 CD 89 9D         [ 4] 1868 	call	_ssd1306_buffer_write
                                   1869 ;	./libs/menu_lib.c: 81: ssd1306_buffer_write(18,12,ttf_eng_e);
      008C04 4B 30            [ 1] 1870 	push	#<(_ttf_eng_e+0)
      008C06 4B 00            [ 1] 1871 	push	#((_ttf_eng_e+0) >> 8)
      008C08 4B 0C            [ 1] 1872 	push	#0x0c
      008C0A 4B 00            [ 1] 1873 	push	#0x00
      008C0C AE 00 12         [ 2] 1874 	ldw	x, #0x0012
      008C0F CD 89 9D         [ 4] 1875 	call	_ssd1306_buffer_write
                                   1876 ;	./libs/menu_lib.c: 82: ssd1306_buffer_write(26,12,ttf_eng_n);
      008C12 4B 78            [ 1] 1877 	push	#<(_ttf_eng_n+0)
      008C14 4B 00            [ 1] 1878 	push	#((_ttf_eng_n+0) >> 8)
      008C16 4B 0C            [ 1] 1879 	push	#0x0c
      008C18 4B 00            [ 1] 1880 	push	#0x00
      008C1A AE 00 1A         [ 2] 1881 	ldw	x, #0x001a
      008C1D CD 89 9D         [ 4] 1882 	call	_ssd1306_buffer_write
                                   1883 ;	./libs/menu_lib.c: 83: ssd1306_buffer_write(34,12,ttf_eng_u);
      008C20 4B B0            [ 1] 1884 	push	#<(_ttf_eng_u+0)
      008C22 4B 00            [ 1] 1885 	push	#((_ttf_eng_u+0) >> 8)
      008C24 4B 0C            [ 1] 1886 	push	#0x0c
      008C26 4B 00            [ 1] 1887 	push	#0x00
      008C28 AE 00 22         [ 2] 1888 	ldw	x, #0x0022
      008C2B CD 89 9D         [ 4] 1889 	call	_ssd1306_buffer_write
                                   1890 ;	./libs/menu_lib.c: 85: ssd1306_buffer_write(48,4,ttf_eng_c);
      008C2E 4B 20            [ 1] 1891 	push	#<(_ttf_eng_c+0)
      008C30 4B 00            [ 1] 1892 	push	#((_ttf_eng_c+0) >> 8)
      008C32 4B 04            [ 1] 1893 	push	#0x04
      008C34 4B 00            [ 1] 1894 	push	#0x00
      008C36 AE 00 30         [ 2] 1895 	ldw	x, #0x0030
      008C39 CD 89 9D         [ 4] 1896 	call	_ssd1306_buffer_write
                                   1897 ;	./libs/menu_lib.c: 86: ssd1306_buffer_write(56,4,ttf_eng_o);
      008C3C 4B 80            [ 1] 1898 	push	#<(_ttf_eng_o+0)
      008C3E 4B 00            [ 1] 1899 	push	#((_ttf_eng_o+0) >> 8)
      008C40 4B 04            [ 1] 1900 	push	#0x04
      008C42 4B 00            [ 1] 1901 	push	#0x00
      008C44 AE 00 38         [ 2] 1902 	ldw	x, #0x0038
      008C47 CD 89 9D         [ 4] 1903 	call	_ssd1306_buffer_write
                                   1904 ;	./libs/menu_lib.c: 87: ssd1306_buffer_write(64,4,ttf_eng_l);
      008C4A 4B 68            [ 1] 1905 	push	#<(_ttf_eng_l+0)
      008C4C 4B 00            [ 1] 1906 	push	#((_ttf_eng_l+0) >> 8)
      008C4E 4B 04            [ 1] 1907 	push	#0x04
      008C50 4B 00            [ 1] 1908 	push	#0x00
      008C52 AE 00 40         [ 2] 1909 	ldw	x, #0x0040
      008C55 CD 89 9D         [ 4] 1910 	call	_ssd1306_buffer_write
                                   1911 ;	./libs/menu_lib.c: 88: ssd1306_buffer_write(72,4,ttf_eng_o);
      008C58 4B 80            [ 1] 1912 	push	#<(_ttf_eng_o+0)
      008C5A 4B 00            [ 1] 1913 	push	#((_ttf_eng_o+0) >> 8)
      008C5C 4B 04            [ 1] 1914 	push	#0x04
      008C5E 4B 00            [ 1] 1915 	push	#0x00
      008C60 AE 00 48         [ 2] 1916 	ldw	x, #0x0048
      008C63 CD 89 9D         [ 4] 1917 	call	_ssd1306_buffer_write
                                   1918 ;	./libs/menu_lib.c: 89: ssd1306_buffer_write(80,4,ttf_eng_r);
      008C66 4B 98            [ 1] 1919 	push	#<(_ttf_eng_r+0)
      008C68 4B 00            [ 1] 1920 	push	#((_ttf_eng_r+0) >> 8)
      008C6A 4B 04            [ 1] 1921 	push	#0x04
      008C6C 4B 00            [ 1] 1922 	push	#0x00
      008C6E AE 00 50         [ 2] 1923 	ldw	x, #0x0050
      008C71 CD 89 9D         [ 4] 1924 	call	_ssd1306_buffer_write
                                   1925 ;	./libs/menu_lib.c: 90: ssd1306_buffer_write(114,4,ttf_eng_line_left);
      008C74 4B 58            [ 1] 1926 	push	#<(_ttf_eng_line_left+0)
      008C76 4B 01            [ 1] 1927 	push	#((_ttf_eng_line_left+0) >> 8)
      008C78 4B 04            [ 1] 1928 	push	#0x04
      008C7A 4B 00            [ 1] 1929 	push	#0x00
      008C7C AE 00 72         [ 2] 1930 	ldw	x, #0x0072
      008C7F CD 89 9D         [ 4] 1931 	call	_ssd1306_buffer_write
                                   1932 ;	./libs/menu_lib.c: 92: ssd1306_buffer_write(48,12,ttf_eng_s);
      008C82 4B A0            [ 1] 1933 	push	#<(_ttf_eng_s+0)
      008C84 4B 00            [ 1] 1934 	push	#((_ttf_eng_s+0) >> 8)
      008C86 4B 0C            [ 1] 1935 	push	#0x0c
      008C88 4B 00            [ 1] 1936 	push	#0x00
      008C8A AE 00 30         [ 2] 1937 	ldw	x, #0x0030
      008C8D CD 89 9D         [ 4] 1938 	call	_ssd1306_buffer_write
                                   1939 ;	./libs/menu_lib.c: 93: ssd1306_buffer_write(56,12,ttf_eng_e);
      008C90 4B 30            [ 1] 1940 	push	#<(_ttf_eng_e+0)
      008C92 4B 00            [ 1] 1941 	push	#((_ttf_eng_e+0) >> 8)
      008C94 4B 0C            [ 1] 1942 	push	#0x0c
      008C96 4B 00            [ 1] 1943 	push	#0x00
      008C98 AE 00 38         [ 2] 1944 	ldw	x, #0x0038
      008C9B CD 89 9D         [ 4] 1945 	call	_ssd1306_buffer_write
                                   1946 ;	./libs/menu_lib.c: 94: ssd1306_buffer_write(64,12,ttf_eng_g);
      008C9E 4B 40            [ 1] 1947 	push	#<(_ttf_eng_g+0)
      008CA0 4B 00            [ 1] 1948 	push	#((_ttf_eng_g+0) >> 8)
      008CA2 4B 0C            [ 1] 1949 	push	#0x0c
      008CA4 4B 00            [ 1] 1950 	push	#0x00
      008CA6 AE 00 40         [ 2] 1951 	ldw	x, #0x0040
      008CA9 CD 89 9D         [ 4] 1952 	call	_ssd1306_buffer_write
                                   1953 ;	./libs/menu_lib.c: 95: ssd1306_buffer_write(72,12,ttf_eng_m);
      008CAC 4B 70            [ 1] 1954 	push	#<(_ttf_eng_m+0)
      008CAE 4B 00            [ 1] 1955 	push	#((_ttf_eng_m+0) >> 8)
      008CB0 4B 0C            [ 1] 1956 	push	#0x0c
      008CB2 4B 00            [ 1] 1957 	push	#0x00
      008CB4 AE 00 48         [ 2] 1958 	ldw	x, #0x0048
      008CB7 CD 89 9D         [ 4] 1959 	call	_ssd1306_buffer_write
                                   1960 ;	./libs/menu_lib.c: 96: ssd1306_buffer_write(80,12,ttf_eng_e);
      008CBA 4B 30            [ 1] 1961 	push	#<(_ttf_eng_e+0)
      008CBC 4B 00            [ 1] 1962 	push	#((_ttf_eng_e+0) >> 8)
      008CBE 4B 0C            [ 1] 1963 	push	#0x0c
      008CC0 4B 00            [ 1] 1964 	push	#0x00
      008CC2 AE 00 50         [ 2] 1965 	ldw	x, #0x0050
      008CC5 CD 89 9D         [ 4] 1966 	call	_ssd1306_buffer_write
                                   1967 ;	./libs/menu_lib.c: 97: ssd1306_buffer_write(88,12,ttf_eng_n);
      008CC8 4B 78            [ 1] 1968 	push	#<(_ttf_eng_n+0)
      008CCA 4B 00            [ 1] 1969 	push	#((_ttf_eng_n+0) >> 8)
      008CCC 4B 0C            [ 1] 1970 	push	#0x0c
      008CCE 4B 00            [ 1] 1971 	push	#0x00
      008CD0 AE 00 58         [ 2] 1972 	ldw	x, #0x0058
      008CD3 CD 89 9D         [ 4] 1973 	call	_ssd1306_buffer_write
                                   1974 ;	./libs/menu_lib.c: 98: ssd1306_buffer_write(96,12,ttf_eng_t);
      008CD6 4B A8            [ 1] 1975 	push	#<(_ttf_eng_t+0)
      008CD8 4B 00            [ 1] 1976 	push	#((_ttf_eng_t+0) >> 8)
      008CDA 4B 0C            [ 1] 1977 	push	#0x0c
      008CDC 4B 00            [ 1] 1978 	push	#0x00
      008CDE AE 00 60         [ 2] 1979 	ldw	x, #0x0060
      008CE1 CD 89 9D         [ 4] 1980 	call	_ssd1306_buffer_write
                                   1981 ;	./libs/menu_lib.c: 99: ssd1306_buffer_write(114,12,ttf_eng_void);
      008CE4 4B 08            [ 1] 1982 	push	#<(_ttf_eng_void+0)
      008CE6 4B 00            [ 1] 1983 	push	#((_ttf_eng_void+0) >> 8)
      008CE8 4B 0C            [ 1] 1984 	push	#0x0c
      008CEA 4B 00            [ 1] 1985 	push	#0x00
      008CEC AE 00 72         [ 2] 1986 	ldw	x, #0x0072
      008CEF CD 89 9D         [ 4] 1987 	call	_ssd1306_buffer_write
                                   1988 ;	./libs/menu_lib.c: 101: ssd1306_buffer_write(48,20,ttf_eng_s);
      008CF2 4B A0            [ 1] 1989 	push	#<(_ttf_eng_s+0)
      008CF4 4B 00            [ 1] 1990 	push	#((_ttf_eng_s+0) >> 8)
      008CF6 4B 14            [ 1] 1991 	push	#0x14
      008CF8 4B 00            [ 1] 1992 	push	#0x00
      008CFA AE 00 30         [ 2] 1993 	ldw	x, #0x0030
      008CFD CD 89 9D         [ 4] 1994 	call	_ssd1306_buffer_write
                                   1995 ;	./libs/menu_lib.c: 102: ssd1306_buffer_write(56,20,ttf_eng_e);
      008D00 4B 30            [ 1] 1996 	push	#<(_ttf_eng_e+0)
      008D02 4B 00            [ 1] 1997 	push	#((_ttf_eng_e+0) >> 8)
      008D04 4B 14            [ 1] 1998 	push	#0x14
      008D06 4B 00            [ 1] 1999 	push	#0x00
      008D08 AE 00 38         [ 2] 2000 	ldw	x, #0x0038
      008D0B CD 89 9D         [ 4] 2001 	call	_ssd1306_buffer_write
                                   2002 ;	./libs/menu_lib.c: 103: ssd1306_buffer_write(64,20,ttf_eng_t);
      008D0E 4B A8            [ 1] 2003 	push	#<(_ttf_eng_t+0)
      008D10 4B 00            [ 1] 2004 	push	#((_ttf_eng_t+0) >> 8)
      008D12 4B 14            [ 1] 2005 	push	#0x14
      008D14 4B 00            [ 1] 2006 	push	#0x00
      008D16 AE 00 40         [ 2] 2007 	ldw	x, #0x0040
      008D19 CD 89 9D         [ 4] 2008 	call	_ssd1306_buffer_write
                                   2009 ;	./libs/menu_lib.c: 104: ssd1306_buffer_write(72,20,ttf_eng_t);
      008D1C 4B A8            [ 1] 2010 	push	#<(_ttf_eng_t+0)
      008D1E 4B 00            [ 1] 2011 	push	#((_ttf_eng_t+0) >> 8)
      008D20 4B 14            [ 1] 2012 	push	#0x14
      008D22 4B 00            [ 1] 2013 	push	#0x00
      008D24 AE 00 48         [ 2] 2014 	ldw	x, #0x0048
      008D27 CD 89 9D         [ 4] 2015 	call	_ssd1306_buffer_write
                                   2016 ;	./libs/menu_lib.c: 105: ssd1306_buffer_write(80,20,ttf_eng_i);
      008D2A 4B 50            [ 1] 2017 	push	#<(_ttf_eng_i+0)
      008D2C 4B 00            [ 1] 2018 	push	#((_ttf_eng_i+0) >> 8)
      008D2E 4B 14            [ 1] 2019 	push	#0x14
      008D30 4B 00            [ 1] 2020 	push	#0x00
      008D32 AE 00 50         [ 2] 2021 	ldw	x, #0x0050
      008D35 CD 89 9D         [ 4] 2022 	call	_ssd1306_buffer_write
                                   2023 ;	./libs/menu_lib.c: 106: ssd1306_buffer_write(88,20,ttf_eng_n);
      008D38 4B 78            [ 1] 2024 	push	#<(_ttf_eng_n+0)
      008D3A 4B 00            [ 1] 2025 	push	#((_ttf_eng_n+0) >> 8)
      008D3C 4B 14            [ 1] 2026 	push	#0x14
      008D3E 4B 00            [ 1] 2027 	push	#0x00
      008D40 AE 00 58         [ 2] 2028 	ldw	x, #0x0058
      008D43 CD 89 9D         [ 4] 2029 	call	_ssd1306_buffer_write
                                   2030 ;	./libs/menu_lib.c: 107: ssd1306_buffer_write(96,20,ttf_eng_g);
      008D46 4B 40            [ 1] 2031 	push	#<(_ttf_eng_g+0)
      008D48 4B 00            [ 1] 2032 	push	#((_ttf_eng_g+0) >> 8)
      008D4A 4B 14            [ 1] 2033 	push	#0x14
      008D4C 4B 00            [ 1] 2034 	push	#0x00
      008D4E AE 00 60         [ 2] 2035 	ldw	x, #0x0060
      008D51 CD 89 9D         [ 4] 2036 	call	_ssd1306_buffer_write
                                   2037 ;	./libs/menu_lib.c: 108: ssd1306_buffer_write(104,20,ttf_eng_s);
      008D54 4B A0            [ 1] 2038 	push	#<(_ttf_eng_s+0)
      008D56 4B 00            [ 1] 2039 	push	#((_ttf_eng_s+0) >> 8)
      008D58 4B 14            [ 1] 2040 	push	#0x14
      008D5A 4B 00            [ 1] 2041 	push	#0x00
      008D5C AE 00 68         [ 2] 2042 	ldw	x, #0x0068
      008D5F CD 89 9D         [ 4] 2043 	call	_ssd1306_buffer_write
                                   2044 ;	./libs/menu_lib.c: 109: ssd1306_buffer_write(114,20,ttf_eng_void);
      008D62 4B 08            [ 1] 2045 	push	#<(_ttf_eng_void+0)
      008D64 4B 00            [ 1] 2046 	push	#((_ttf_eng_void+0) >> 8)
      008D66 4B 14            [ 1] 2047 	push	#0x14
      008D68 4B 00            [ 1] 2048 	push	#0x00
      008D6A AE 00 72         [ 2] 2049 	ldw	x, #0x0072
      008D6D CD 89 9D         [ 4] 2050 	call	_ssd1306_buffer_write
                                   2051 ;	./libs/menu_lib.c: 111: ssd1306_send_buffer();
                                   2052 ;	./libs/menu_lib.c: 112: break;
      008D70 CC 89 48         [ 2] 2053 	jp	_ssd1306_send_buffer
                                   2054 ;	./libs/menu_lib.c: 113: case color:
      008D73                       2055 00102$:
                                   2056 ;	./libs/menu_lib.c: 114: ssd1306_buffer_clean();
      008D73 CD 89 3B         [ 4] 2057 	call	_ssd1306_buffer_clean
                                   2058 ;	./libs/menu_lib.c: 115: menu_border();
      008D76 CD 8A 38         [ 4] 2059 	call	_menu_border
                                   2060 ;	./libs/menu_lib.c: 116: menu_border_splash(5);
      008D79 A6 05            [ 1] 2061 	ld	a, #0x05
      008D7B CD 8A E5         [ 4] 2062 	call	_menu_border_splash
                                   2063 ;	./libs/menu_lib.c: 118: ssd1306_buffer_write(10,12,ttf_eng_c);
      008D7E 4B 20            [ 1] 2064 	push	#<(_ttf_eng_c+0)
      008D80 4B 00            [ 1] 2065 	push	#((_ttf_eng_c+0) >> 8)
      008D82 4B 0C            [ 1] 2066 	push	#0x0c
      008D84 4B 00            [ 1] 2067 	push	#0x00
      008D86 AE 00 0A         [ 2] 2068 	ldw	x, #0x000a
      008D89 CD 89 9D         [ 4] 2069 	call	_ssd1306_buffer_write
                                   2070 ;	./libs/menu_lib.c: 119: ssd1306_buffer_write(18,12,ttf_eng_o);
      008D8C 4B 80            [ 1] 2071 	push	#<(_ttf_eng_o+0)
      008D8E 4B 00            [ 1] 2072 	push	#((_ttf_eng_o+0) >> 8)
      008D90 4B 0C            [ 1] 2073 	push	#0x0c
      008D92 4B 00            [ 1] 2074 	push	#0x00
      008D94 AE 00 12         [ 2] 2075 	ldw	x, #0x0012
      008D97 CD 89 9D         [ 4] 2076 	call	_ssd1306_buffer_write
                                   2077 ;	./libs/menu_lib.c: 120: ssd1306_buffer_write(26,12,ttf_eng_l);
      008D9A 4B 68            [ 1] 2078 	push	#<(_ttf_eng_l+0)
      008D9C 4B 00            [ 1] 2079 	push	#((_ttf_eng_l+0) >> 8)
      008D9E 4B 0C            [ 1] 2080 	push	#0x0c
      008DA0 4B 00            [ 1] 2081 	push	#0x00
      008DA2 AE 00 1A         [ 2] 2082 	ldw	x, #0x001a
      008DA5 CD 89 9D         [ 4] 2083 	call	_ssd1306_buffer_write
                                   2084 ;	./libs/menu_lib.c: 121: ssd1306_buffer_write(34,12,ttf_eng_o);
      008DA8 4B 80            [ 1] 2085 	push	#<(_ttf_eng_o+0)
      008DAA 4B 00            [ 1] 2086 	push	#((_ttf_eng_o+0) >> 8)
      008DAC 4B 0C            [ 1] 2087 	push	#0x0c
      008DAE 4B 00            [ 1] 2088 	push	#0x00
      008DB0 AE 00 22         [ 2] 2089 	ldw	x, #0x0022
      008DB3 CD 89 9D         [ 4] 2090 	call	_ssd1306_buffer_write
                                   2091 ;	./libs/menu_lib.c: 122: ssd1306_buffer_write(42,12,ttf_eng_r);
      008DB6 4B 98            [ 1] 2092 	push	#<(_ttf_eng_r+0)
      008DB8 4B 00            [ 1] 2093 	push	#((_ttf_eng_r+0) >> 8)
      008DBA 4B 0C            [ 1] 2094 	push	#0x0c
      008DBC 4B 00            [ 1] 2095 	push	#0x00
      008DBE AE 00 2A         [ 2] 2096 	ldw	x, #0x002a
      008DC1 CD 89 9D         [ 4] 2097 	call	_ssd1306_buffer_write
                                   2098 ;	./libs/menu_lib.c: 124: ssd1306_send_buffer();
                                   2099 ;	./libs/menu_lib.c: 125: break;
      008DC4 CC 89 48         [ 2] 2100 	jp	_ssd1306_send_buffer
                                   2101 ;	./libs/menu_lib.c: 126: case segment:
      008DC7                       2102 00103$:
                                   2103 ;	./libs/menu_lib.c: 127: ssd1306_buffer_clean();
      008DC7 CD 89 3B         [ 4] 2104 	call	_ssd1306_buffer_clean
                                   2105 ;	./libs/menu_lib.c: 128: menu_border();
      008DCA CD 8A 38         [ 4] 2106 	call	_menu_border
                                   2107 ;	./libs/menu_lib.c: 129: menu_border_splash(7);
      008DCD A6 07            [ 1] 2108 	ld	a, #0x07
      008DCF CD 8A E5         [ 4] 2109 	call	_menu_border_splash
                                   2110 ;	./libs/menu_lib.c: 131: ssd1306_buffer_write(10,12,ttf_eng_s);
      008DD2 4B A0            [ 1] 2111 	push	#<(_ttf_eng_s+0)
      008DD4 4B 00            [ 1] 2112 	push	#((_ttf_eng_s+0) >> 8)
      008DD6 4B 0C            [ 1] 2113 	push	#0x0c
      008DD8 4B 00            [ 1] 2114 	push	#0x00
      008DDA AE 00 0A         [ 2] 2115 	ldw	x, #0x000a
      008DDD CD 89 9D         [ 4] 2116 	call	_ssd1306_buffer_write
                                   2117 ;	./libs/menu_lib.c: 132: ssd1306_buffer_write(18,12,ttf_eng_e);
      008DE0 4B 30            [ 1] 2118 	push	#<(_ttf_eng_e+0)
      008DE2 4B 00            [ 1] 2119 	push	#((_ttf_eng_e+0) >> 8)
      008DE4 4B 0C            [ 1] 2120 	push	#0x0c
      008DE6 4B 00            [ 1] 2121 	push	#0x00
      008DE8 AE 00 12         [ 2] 2122 	ldw	x, #0x0012
      008DEB CD 89 9D         [ 4] 2123 	call	_ssd1306_buffer_write
                                   2124 ;	./libs/menu_lib.c: 133: ssd1306_buffer_write(26,12,ttf_eng_g);
      008DEE 4B 40            [ 1] 2125 	push	#<(_ttf_eng_g+0)
      008DF0 4B 00            [ 1] 2126 	push	#((_ttf_eng_g+0) >> 8)
      008DF2 4B 0C            [ 1] 2127 	push	#0x0c
      008DF4 4B 00            [ 1] 2128 	push	#0x00
      008DF6 AE 00 1A         [ 2] 2129 	ldw	x, #0x001a
      008DF9 CD 89 9D         [ 4] 2130 	call	_ssd1306_buffer_write
                                   2131 ;	./libs/menu_lib.c: 134: ssd1306_buffer_write(34,12,ttf_eng_m);
      008DFC 4B 70            [ 1] 2132 	push	#<(_ttf_eng_m+0)
      008DFE 4B 00            [ 1] 2133 	push	#((_ttf_eng_m+0) >> 8)
      008E00 4B 0C            [ 1] 2134 	push	#0x0c
      008E02 4B 00            [ 1] 2135 	push	#0x00
      008E04 AE 00 22         [ 2] 2136 	ldw	x, #0x0022
      008E07 CD 89 9D         [ 4] 2137 	call	_ssd1306_buffer_write
                                   2138 ;	./libs/menu_lib.c: 135: ssd1306_buffer_write(42,12,ttf_eng_e);
      008E0A 4B 30            [ 1] 2139 	push	#<(_ttf_eng_e+0)
      008E0C 4B 00            [ 1] 2140 	push	#((_ttf_eng_e+0) >> 8)
      008E0E 4B 0C            [ 1] 2141 	push	#0x0c
      008E10 4B 00            [ 1] 2142 	push	#0x00
      008E12 AE 00 2A         [ 2] 2143 	ldw	x, #0x002a
      008E15 CD 89 9D         [ 4] 2144 	call	_ssd1306_buffer_write
                                   2145 ;	./libs/menu_lib.c: 136: ssd1306_buffer_write(50,12,ttf_eng_n);
      008E18 4B 78            [ 1] 2146 	push	#<(_ttf_eng_n+0)
      008E1A 4B 00            [ 1] 2147 	push	#((_ttf_eng_n+0) >> 8)
      008E1C 4B 0C            [ 1] 2148 	push	#0x0c
      008E1E 4B 00            [ 1] 2149 	push	#0x00
      008E20 AE 00 32         [ 2] 2150 	ldw	x, #0x0032
      008E23 CD 89 9D         [ 4] 2151 	call	_ssd1306_buffer_write
                                   2152 ;	./libs/menu_lib.c: 137: ssd1306_buffer_write(58,12,ttf_eng_t);
      008E26 4B A8            [ 1] 2153 	push	#<(_ttf_eng_t+0)
      008E28 4B 00            [ 1] 2154 	push	#((_ttf_eng_t+0) >> 8)
      008E2A 4B 0C            [ 1] 2155 	push	#0x0c
      008E2C 4B 00            [ 1] 2156 	push	#0x00
      008E2E AE 00 3A         [ 2] 2157 	ldw	x, #0x003a
      008E31 CD 89 9D         [ 4] 2158 	call	_ssd1306_buffer_write
                                   2159 ;	./libs/menu_lib.c: 139: ssd1306_send_buffer();
                                   2160 ;	./libs/menu_lib.c: 142: break;
      008E34 CC 89 48         [ 2] 2161 	jp	_ssd1306_send_buffer
                                   2162 ;	./libs/menu_lib.c: 143: case settings:
      008E37                       2163 00104$:
                                   2164 ;	./libs/menu_lib.c: 144: ssd1306_buffer_clean();
      008E37 CD 89 3B         [ 4] 2165 	call	_ssd1306_buffer_clean
                                   2166 ;	./libs/menu_lib.c: 145: menu_border();
      008E3A CD 8A 38         [ 4] 2167 	call	_menu_border
                                   2168 ;	./libs/menu_lib.c: 146: menu_border_splash(8);
      008E3D A6 08            [ 1] 2169 	ld	a, #0x08
      008E3F CD 8A E5         [ 4] 2170 	call	_menu_border_splash
                                   2171 ;	./libs/menu_lib.c: 148: ssd1306_buffer_write(10,12,ttf_eng_s);
      008E42 4B A0            [ 1] 2172 	push	#<(_ttf_eng_s+0)
      008E44 4B 00            [ 1] 2173 	push	#((_ttf_eng_s+0) >> 8)
      008E46 4B 0C            [ 1] 2174 	push	#0x0c
      008E48 4B 00            [ 1] 2175 	push	#0x00
      008E4A AE 00 0A         [ 2] 2176 	ldw	x, #0x000a
      008E4D CD 89 9D         [ 4] 2177 	call	_ssd1306_buffer_write
                                   2178 ;	./libs/menu_lib.c: 149: ssd1306_buffer_write(18,12,ttf_eng_e);
      008E50 4B 30            [ 1] 2179 	push	#<(_ttf_eng_e+0)
      008E52 4B 00            [ 1] 2180 	push	#((_ttf_eng_e+0) >> 8)
      008E54 4B 0C            [ 1] 2181 	push	#0x0c
      008E56 4B 00            [ 1] 2182 	push	#0x00
      008E58 AE 00 12         [ 2] 2183 	ldw	x, #0x0012
      008E5B CD 89 9D         [ 4] 2184 	call	_ssd1306_buffer_write
                                   2185 ;	./libs/menu_lib.c: 150: ssd1306_buffer_write(26,12,ttf_eng_t);
      008E5E 4B A8            [ 1] 2186 	push	#<(_ttf_eng_t+0)
      008E60 4B 00            [ 1] 2187 	push	#((_ttf_eng_t+0) >> 8)
      008E62 4B 0C            [ 1] 2188 	push	#0x0c
      008E64 4B 00            [ 1] 2189 	push	#0x00
      008E66 AE 00 1A         [ 2] 2190 	ldw	x, #0x001a
      008E69 CD 89 9D         [ 4] 2191 	call	_ssd1306_buffer_write
                                   2192 ;	./libs/menu_lib.c: 151: ssd1306_buffer_write(34,12,ttf_eng_t);
      008E6C 4B A8            [ 1] 2193 	push	#<(_ttf_eng_t+0)
      008E6E 4B 00            [ 1] 2194 	push	#((_ttf_eng_t+0) >> 8)
      008E70 4B 0C            [ 1] 2195 	push	#0x0c
      008E72 4B 00            [ 1] 2196 	push	#0x00
      008E74 AE 00 22         [ 2] 2197 	ldw	x, #0x0022
      008E77 CD 89 9D         [ 4] 2198 	call	_ssd1306_buffer_write
                                   2199 ;	./libs/menu_lib.c: 152: ssd1306_buffer_write(42,12,ttf_eng_i);
      008E7A 4B 50            [ 1] 2200 	push	#<(_ttf_eng_i+0)
      008E7C 4B 00            [ 1] 2201 	push	#((_ttf_eng_i+0) >> 8)
      008E7E 4B 0C            [ 1] 2202 	push	#0x0c
      008E80 4B 00            [ 1] 2203 	push	#0x00
      008E82 AE 00 2A         [ 2] 2204 	ldw	x, #0x002a
      008E85 CD 89 9D         [ 4] 2205 	call	_ssd1306_buffer_write
                                   2206 ;	./libs/menu_lib.c: 153: ssd1306_buffer_write(50,12,ttf_eng_n);
      008E88 4B 78            [ 1] 2207 	push	#<(_ttf_eng_n+0)
      008E8A 4B 00            [ 1] 2208 	push	#((_ttf_eng_n+0) >> 8)
      008E8C 4B 0C            [ 1] 2209 	push	#0x0c
      008E8E 4B 00            [ 1] 2210 	push	#0x00
      008E90 AE 00 32         [ 2] 2211 	ldw	x, #0x0032
      008E93 CD 89 9D         [ 4] 2212 	call	_ssd1306_buffer_write
                                   2213 ;	./libs/menu_lib.c: 154: ssd1306_buffer_write(58,12,ttf_eng_g);
      008E96 4B 40            [ 1] 2214 	push	#<(_ttf_eng_g+0)
      008E98 4B 00            [ 1] 2215 	push	#((_ttf_eng_g+0) >> 8)
      008E9A 4B 0C            [ 1] 2216 	push	#0x0c
      008E9C 4B 00            [ 1] 2217 	push	#0x00
      008E9E AE 00 3A         [ 2] 2218 	ldw	x, #0x003a
      008EA1 CD 89 9D         [ 4] 2219 	call	_ssd1306_buffer_write
                                   2220 ;	./libs/menu_lib.c: 155: ssd1306_buffer_write(66,12,ttf_eng_s);
      008EA4 4B A0            [ 1] 2221 	push	#<(_ttf_eng_s+0)
      008EA6 4B 00            [ 1] 2222 	push	#((_ttf_eng_s+0) >> 8)
      008EA8 4B 0C            [ 1] 2223 	push	#0x0c
      008EAA 4B 00            [ 1] 2224 	push	#0x00
      008EAC AE 00 42         [ 2] 2225 	ldw	x, #0x0042
      008EAF CD 89 9D         [ 4] 2226 	call	_ssd1306_buffer_write
                                   2227 ;	./libs/menu_lib.c: 157: ssd1306_send_buffer();
                                   2228 ;	./libs/menu_lib.c: 159: }
                                   2229 ;	./libs/menu_lib.c: 160: }
      008EB2 CC 89 48         [ 2] 2230 	jp	_ssd1306_send_buffer
                                   2231 ;	./libs/tmr2_lib.c: 3: void tmr2_irq(void) __interrupt(TIM2_vector)
                                   2232 ;	-----------------------------------------
                                   2233 ;	 function tmr2_irq
                                   2234 ;	-----------------------------------------
      008EB5                       2235 _tmr2_irq:
      008EB5 4F               [ 1] 2236 	clr	a
      008EB6 62               [ 2] 2237 	div	x, a
                                   2238 ;	./libs/tmr2_lib.c: 6: disableInterrupts();
      008EB7 9B               [ 1] 2239 	sim
                                   2240 ;	./libs/tmr2_lib.c: 7: TIM2_IRQ.all = 0;//обнуление флагов регистров
      008EB8 35 00 03 72      [ 1] 2241 	mov	_TIM2_IRQ+0, #0x00
                                   2242 ;	./libs/tmr2_lib.c: 9: if(TIM2_SR1 -> UIF)//прерывание таймера
      008EBC AE 53 04         [ 2] 2243 	ldw	x, #0x5304
      008EBF F6               [ 1] 2244 	ld	a, (x)
      008EC0 A4 01            [ 1] 2245 	and	a, #0x01
      008EC2 27 0B            [ 1] 2246 	jreq	00102$
                                   2247 ;	./libs/tmr2_lib.c: 11: TIM2_IRQ.UIF = 1;
      008EC4 72 1E 03 72      [ 1] 2248 	bset	_TIM2_IRQ+0, #7
                                   2249 ;	./libs/tmr2_lib.c: 12: TIM2_IER -> UIE = 0;
      008EC8 AE 53 03         [ 2] 2250 	ldw	x, #0x5303
      008ECB F6               [ 1] 2251 	ld	a, (x)
      008ECC A4 FE            [ 1] 2252 	and	a, #0xfe
      008ECE F7               [ 1] 2253 	ld	(x), a
      008ECF                       2254 00102$:
                                   2255 ;	./libs/tmr2_lib.c: 14: enableInterrupts();
      008ECF 9A               [ 1] 2256 	rim
                                   2257 ;	./libs/tmr2_lib.c: 15: }
      008ED0 80               [11] 2258 	iret
                                   2259 ;	./libs/tmr2_lib.c: 16: void delay_s(uint8_t ticks)
                                   2260 ;	-----------------------------------------
                                   2261 ;	 function delay_s
                                   2262 ;	-----------------------------------------
      008ED1                       2263 _delay_s:
      008ED1 52 07            [ 2] 2264 	sub	sp, #7
      008ED3 6B 05            [ 1] 2265 	ld	(0x05, sp), a
                                   2266 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks+1;i++)//блять в душе не ебу почему так сработало, но почему-то если на один больше, то таймер нормально работает
      008ED5 5F               [ 1] 2267 	clrw	x
      008ED6 1F 06            [ 2] 2268 	ldw	(0x06, sp), x
      008ED8                       2269 00106$:
      008ED8 7B 05            [ 1] 2270 	ld	a, (0x05, sp)
      008EDA 6B 02            [ 1] 2271 	ld	(0x02, sp), a
      008EDC 0F 01            [ 1] 2272 	clr	(0x01, sp)
      008EDE 1E 01            [ 2] 2273 	ldw	x, (0x01, sp)
      008EE0 5C               [ 1] 2274 	incw	x
      008EE1 1F 03            [ 2] 2275 	ldw	(0x03, sp), x
      008EE3 1E 06            [ 2] 2276 	ldw	x, (0x06, sp)
      008EE5 13 03            [ 2] 2277 	cpw	x, (0x03, sp)
      008EE7 2E 2A            [ 1] 2278 	jrsge	00104$
                                   2279 ;	./libs/tmr2_lib.c: 20: TIM2_SR1 -> UIF = 0;
      008EE9 72 11 53 04      [ 1] 2280 	bres	0x5304, #0
                                   2281 ;	./libs/tmr2_lib.c: 21: TIM2_ARRH->ARR = 0x03;
      008EED 35 03 53 0F      [ 1] 2282 	mov	0x530f+0, #0x03
                                   2283 ;	./libs/tmr2_lib.c: 22: TIM2_ARRL->ARR = 0xD1;
      008EF1 35 D1 53 10      [ 1] 2284 	mov	0x5310+0, #0xd1
                                   2285 ;	./libs/tmr2_lib.c: 23: TIM2_PSCR -> PSC = 0x0E;
      008EF5 C6 53 0E         [ 1] 2286 	ld	a, 0x530e
      008EF8 A4 F0            [ 1] 2287 	and	a, #0xf0
      008EFA AA 0E            [ 1] 2288 	or	a, #0x0e
      008EFC C7 53 0E         [ 1] 2289 	ld	0x530e, a
                                   2290 ;	./libs/tmr2_lib.c: 24: TIM2_IER -> UIE = 1;
      008EFF 72 10 53 03      [ 1] 2291 	bset	0x5303, #0
                                   2292 ;	./libs/tmr2_lib.c: 25: TIM2_CR1-> CEN = 1;
      008F03 72 10 53 00      [ 1] 2293 	bset	0x5300, #0
                                   2294 ;	./libs/tmr2_lib.c: 26: while(TIM2_IER -> UIE);	
      008F07                       2295 00101$:
      008F07 72 00 53 03 FB   [ 2] 2296 	btjt	0x5303, #0, 00101$
                                   2297 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks+1;i++)//блять в душе не ебу почему так сработало, но почему-то если на один больше, то таймер нормально работает
      008F0C 1E 06            [ 2] 2298 	ldw	x, (0x06, sp)
      008F0E 5C               [ 1] 2299 	incw	x
      008F0F 1F 06            [ 2] 2300 	ldw	(0x06, sp), x
      008F11 20 C5            [ 2] 2301 	jra	00106$
      008F13                       2302 00104$:
                                   2303 ;	./libs/tmr2_lib.c: 28: TIM2_CR1-> CEN = 0;
      008F13 72 11 53 00      [ 1] 2304 	bres	0x5300, #0
                                   2305 ;	./libs/tmr2_lib.c: 29: }
      008F17 5B 07            [ 2] 2306 	addw	sp, #7
      008F19 81               [ 4] 2307 	ret
                                   2308 ;	./libs/tmr2_lib.c: 30: void delay_ms(uint8_t ticks)
                                   2309 ;	-----------------------------------------
                                   2310 ;	 function delay_ms
                                   2311 ;	-----------------------------------------
      008F1A                       2312 _delay_ms:
      008F1A 52 07            [ 2] 2313 	sub	sp, #7
      008F1C 6B 05            [ 1] 2314 	ld	(0x05, sp), a
                                   2315 ;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks+1;i++)
      008F1E 5F               [ 1] 2316 	clrw	x
      008F1F 1F 06            [ 2] 2317 	ldw	(0x06, sp), x
      008F21                       2318 00106$:
      008F21 7B 05            [ 1] 2319 	ld	a, (0x05, sp)
      008F23 6B 02            [ 1] 2320 	ld	(0x02, sp), a
      008F25 0F 01            [ 1] 2321 	clr	(0x01, sp)
      008F27 1E 01            [ 2] 2322 	ldw	x, (0x01, sp)
      008F29 5C               [ 1] 2323 	incw	x
      008F2A 1F 03            [ 2] 2324 	ldw	(0x03, sp), x
      008F2C 1E 06            [ 2] 2325 	ldw	x, (0x06, sp)
      008F2E 13 03            [ 2] 2326 	cpw	x, (0x03, sp)
      008F30 2E 2A            [ 1] 2327 	jrsge	00104$
                                   2328 ;	./libs/tmr2_lib.c: 34: TIM2_SR1 -> UIF = 0;
      008F32 72 11 53 04      [ 1] 2329 	bres	0x5304, #0
                                   2330 ;	./libs/tmr2_lib.c: 35: TIM2_ARRH->ARR = 0x03;
      008F36 35 03 53 0F      [ 1] 2331 	mov	0x530f+0, #0x03
                                   2332 ;	./libs/tmr2_lib.c: 36: TIM2_ARRL->ARR = 0xD1;
      008F3A 35 D1 53 10      [ 1] 2333 	mov	0x5310+0, #0xd1
                                   2334 ;	./libs/tmr2_lib.c: 37: TIM2_PSCR -> PSC = 0x0E;
      008F3E C6 53 0E         [ 1] 2335 	ld	a, 0x530e
      008F41 A4 F0            [ 1] 2336 	and	a, #0xf0
      008F43 AA 0E            [ 1] 2337 	or	a, #0x0e
      008F45 C7 53 0E         [ 1] 2338 	ld	0x530e, a
                                   2339 ;	./libs/tmr2_lib.c: 38: TIM2_IER -> UIE = 1;
      008F48 72 10 53 03      [ 1] 2340 	bset	0x5303, #0
                                   2341 ;	./libs/tmr2_lib.c: 39: TIM2_CR1-> CEN = 1;
      008F4C 72 10 53 00      [ 1] 2342 	bset	0x5300, #0
                                   2343 ;	./libs/tmr2_lib.c: 40: while(TIM2_IER -> UIE);	
      008F50                       2344 00101$:
      008F50 72 00 53 03 FB   [ 2] 2345 	btjt	0x5303, #0, 00101$
                                   2346 ;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks+1;i++)
      008F55 1E 06            [ 2] 2347 	ldw	x, (0x06, sp)
      008F57 5C               [ 1] 2348 	incw	x
      008F58 1F 06            [ 2] 2349 	ldw	(0x06, sp), x
      008F5A 20 C5            [ 2] 2350 	jra	00106$
      008F5C                       2351 00104$:
                                   2352 ;	./libs/tmr2_lib.c: 42: TIM2_CR1-> CEN = 0;
      008F5C 72 11 53 00      [ 1] 2353 	bres	0x5300, #0
                                   2354 ;	./libs/tmr2_lib.c: 43: }
      008F60 5B 07            [ 2] 2355 	addw	sp, #7
      008F62 81               [ 4] 2356 	ret
                                   2357 ;	main.c: 3: void setup(void)
                                   2358 ;	-----------------------------------------
                                   2359 ;	 function setup
                                   2360 ;	-----------------------------------------
      008F63                       2361 _setup:
                                   2362 ;	main.c: 6: CLK_CKDIVR = 0;
      008F63 35 00 50 C6      [ 1] 2363 	mov	0x50c6+0, #0x00
                                   2364 ;	main.c: 8: uart_init(9600,0);
      008F67 4F               [ 1] 2365 	clr	a
      008F68 AE 25 80         [ 2] 2366 	ldw	x, #0x2580
      008F6B CD 84 A4         [ 4] 2367 	call	_uart_init
                                   2368 ;	main.c: 9: i2c_init();
      008F6E CD 86 C5         [ 4] 2369 	call	_i2c_init
                                   2370 ;	main.c: 11: enableInterrupts();
      008F71 9A               [ 1] 2371 	rim
                                   2372 ;	main.c: 12: }
      008F72 81               [ 4] 2373 	ret
                                   2374 ;	main.c: 14: void gg(void)
                                   2375 ;	-----------------------------------------
                                   2376 ;	 function gg
                                   2377 ;	-----------------------------------------
      008F73                       2378 _gg:
                                   2379 ;	main.c: 16: ssd1306_init();
      008F73 CD 88 58         [ 4] 2380 	call	_ssd1306_init
                                   2381 ;	main.c: 17: ssd1306_send_buffer();
      008F76 CD 89 48         [ 4] 2382 	call	_ssd1306_send_buffer
                                   2383 ;	main.c: 18: delay_s(1);
      008F79 A6 01            [ 1] 2384 	ld	a, #0x01
      008F7B CD 8E D1         [ 4] 2385 	call	_delay_s
                                   2386 ;	main.c: 20: menu_set_paragraph(menu);
      008F7E 4F               [ 1] 2387 	clr	a
      008F7F CD 8B D1         [ 4] 2388 	call	_menu_set_paragraph
                                   2389 ;	main.c: 21: delay_s(1);
      008F82 A6 01            [ 1] 2390 	ld	a, #0x01
                                   2391 ;	main.c: 36: }
      008F84 CC 8E D1         [ 2] 2392 	jp	_delay_s
                                   2393 ;	main.c: 38: int main(void)
                                   2394 ;	-----------------------------------------
                                   2395 ;	 function main
                                   2396 ;	-----------------------------------------
      008F87                       2397 _main:
                                   2398 ;	main.c: 40: setup();
      008F87 CD 8F 63         [ 4] 2399 	call	_setup
                                   2400 ;	main.c: 41: gg();
      008F8A CD 8F 73         [ 4] 2401 	call	_gg
                                   2402 ;	main.c: 42: while(1);
      008F8D                       2403 00102$:
      008F8D 20 FE            [ 2] 2404 	jra	00102$
                                   2405 ;	main.c: 43: }
      008F8F 81               [ 4] 2406 	ret
                                   2407 	.area CODE
                                   2408 	.area CONST
                                   2409 	.area INITIALIZER
      008081                       2410 __xinit__I2C_IRQ:
      008081 00                    2411 	.db #0x00	; 0
      008082                       2412 __xinit__ttf_eng_void:
      008082 00                    2413 	.db #0x00	; 0
      008083 00                    2414 	.db #0x00	; 0
      008084 00                    2415 	.db #0x00	; 0
      008085 00                    2416 	.db #0x00	; 0
      008086 00                    2417 	.db #0x00	; 0
      008087 00                    2418 	.db #0x00	; 0
      008088 00                    2419 	.db #0x00	; 0
      008089 00                    2420 	.db #0x00	; 0
      00808A                       2421 __xinit__ttf_eng_a:
      00808A 00                    2422 	.db #0x00	; 0
      00808B 7E                    2423 	.db #0x7e	; 126
      00808C 42                    2424 	.db #0x42	; 66	'B'
      00808D 42                    2425 	.db #0x42	; 66	'B'
      00808E 7E                    2426 	.db #0x7e	; 126
      00808F 42                    2427 	.db #0x42	; 66	'B'
      008090 42                    2428 	.db #0x42	; 66	'B'
      008091 00                    2429 	.db #0x00	; 0
      008092                       2430 __xinit__ttf_eng_b:
      008092 00                    2431 	.db #0x00	; 0
      008093 7C                    2432 	.db #0x7c	; 124
      008094 42                    2433 	.db #0x42	; 66	'B'
      008095 7C                    2434 	.db #0x7c	; 124
      008096 42                    2435 	.db #0x42	; 66	'B'
      008097 42                    2436 	.db #0x42	; 66	'B'
      008098 7C                    2437 	.db #0x7c	; 124
      008099 00                    2438 	.db #0x00	; 0
      00809A                       2439 __xinit__ttf_eng_c:
      00809A 00                    2440 	.db #0x00	; 0
      00809B 7E                    2441 	.db #0x7e	; 126
      00809C 40                    2442 	.db #0x40	; 64
      00809D 40                    2443 	.db #0x40	; 64
      00809E 40                    2444 	.db #0x40	; 64
      00809F 40                    2445 	.db #0x40	; 64
      0080A0 7E                    2446 	.db #0x7e	; 126
      0080A1 00                    2447 	.db #0x00	; 0
      0080A2                       2448 __xinit__ttf_eng_d:
      0080A2 00                    2449 	.db #0x00	; 0
      0080A3 7C                    2450 	.db #0x7c	; 124
      0080A4 42                    2451 	.db #0x42	; 66	'B'
      0080A5 42                    2452 	.db #0x42	; 66	'B'
      0080A6 42                    2453 	.db #0x42	; 66	'B'
      0080A7 42                    2454 	.db #0x42	; 66	'B'
      0080A8 7C                    2455 	.db #0x7c	; 124
      0080A9 00                    2456 	.db #0x00	; 0
      0080AA                       2457 __xinit__ttf_eng_e:
      0080AA 00                    2458 	.db #0x00	; 0
      0080AB 7E                    2459 	.db #0x7e	; 126
      0080AC 40                    2460 	.db #0x40	; 64
      0080AD 7C                    2461 	.db #0x7c	; 124
      0080AE 40                    2462 	.db #0x40	; 64
      0080AF 40                    2463 	.db #0x40	; 64
      0080B0 7E                    2464 	.db #0x7e	; 126
      0080B1 00                    2465 	.db #0x00	; 0
      0080B2                       2466 __xinit__ttf_eng_f:
      0080B2 00                    2467 	.db #0x00	; 0
      0080B3 7E                    2468 	.db #0x7e	; 126
      0080B4 40                    2469 	.db #0x40	; 64
      0080B5 40                    2470 	.db #0x40	; 64
      0080B6 7C                    2471 	.db #0x7c	; 124
      0080B7 40                    2472 	.db #0x40	; 64
      0080B8 40                    2473 	.db #0x40	; 64
      0080B9 00                    2474 	.db #0x00	; 0
      0080BA                       2475 __xinit__ttf_eng_g:
      0080BA 00                    2476 	.db #0x00	; 0
      0080BB 7E                    2477 	.db #0x7e	; 126
      0080BC 42                    2478 	.db #0x42	; 66	'B'
      0080BD 40                    2479 	.db #0x40	; 64
      0080BE 4E                    2480 	.db #0x4e	; 78	'N'
      0080BF 42                    2481 	.db #0x42	; 66	'B'
      0080C0 7E                    2482 	.db #0x7e	; 126
      0080C1 00                    2483 	.db #0x00	; 0
      0080C2                       2484 __xinit__ttf_eng_h:
      0080C2 00                    2485 	.db #0x00	; 0
      0080C3 42                    2486 	.db #0x42	; 66	'B'
      0080C4 42                    2487 	.db #0x42	; 66	'B'
      0080C5 42                    2488 	.db #0x42	; 66	'B'
      0080C6 7E                    2489 	.db #0x7e	; 126
      0080C7 42                    2490 	.db #0x42	; 66	'B'
      0080C8 42                    2491 	.db #0x42	; 66	'B'
      0080C9 00                    2492 	.db #0x00	; 0
      0080CA                       2493 __xinit__ttf_eng_i:
      0080CA 00                    2494 	.db #0x00	; 0
      0080CB 7E                    2495 	.db #0x7e	; 126
      0080CC 18                    2496 	.db #0x18	; 24
      0080CD 18                    2497 	.db #0x18	; 24
      0080CE 18                    2498 	.db #0x18	; 24
      0080CF 18                    2499 	.db #0x18	; 24
      0080D0 7E                    2500 	.db #0x7e	; 126
      0080D1 00                    2501 	.db #0x00	; 0
      0080D2                       2502 __xinit__ttf_eng_j:
      0080D2 00                    2503 	.db #0x00	; 0
      0080D3 0C                    2504 	.db #0x0c	; 12
      0080D4 0C                    2505 	.db #0x0c	; 12
      0080D5 0C                    2506 	.db #0x0c	; 12
      0080D6 0C                    2507 	.db #0x0c	; 12
      0080D7 6C                    2508 	.db #0x6c	; 108	'l'
      0080D8 7C                    2509 	.db #0x7c	; 124
      0080D9 00                    2510 	.db #0x00	; 0
      0080DA                       2511 __xinit__ttf_eng_k:
      0080DA 00                    2512 	.db #0x00	; 0
      0080DB 66                    2513 	.db #0x66	; 102	'f'
      0080DC 68                    2514 	.db #0x68	; 104	'h'
      0080DD 70                    2515 	.db #0x70	; 112	'p'
      0080DE 70                    2516 	.db #0x70	; 112	'p'
      0080DF 68                    2517 	.db #0x68	; 104	'h'
      0080E0 66                    2518 	.db #0x66	; 102	'f'
      0080E1 00                    2519 	.db #0x00	; 0
      0080E2                       2520 __xinit__ttf_eng_l:
      0080E2 00                    2521 	.db #0x00	; 0
      0080E3 40                    2522 	.db #0x40	; 64
      0080E4 40                    2523 	.db #0x40	; 64
      0080E5 40                    2524 	.db #0x40	; 64
      0080E6 40                    2525 	.db #0x40	; 64
      0080E7 40                    2526 	.db #0x40	; 64
      0080E8 7E                    2527 	.db #0x7e	; 126
      0080E9 00                    2528 	.db #0x00	; 0
      0080EA                       2529 __xinit__ttf_eng_m:
      0080EA 00                    2530 	.db #0x00	; 0
      0080EB 42                    2531 	.db #0x42	; 66	'B'
      0080EC 66                    2532 	.db #0x66	; 102	'f'
      0080ED 5A                    2533 	.db #0x5a	; 90	'Z'
      0080EE 42                    2534 	.db #0x42	; 66	'B'
      0080EF 42                    2535 	.db #0x42	; 66	'B'
      0080F0 42                    2536 	.db #0x42	; 66	'B'
      0080F1 00                    2537 	.db #0x00	; 0
      0080F2                       2538 __xinit__ttf_eng_n:
      0080F2 00                    2539 	.db #0x00	; 0
      0080F3 42                    2540 	.db #0x42	; 66	'B'
      0080F4 62                    2541 	.db #0x62	; 98	'b'
      0080F5 52                    2542 	.db #0x52	; 82	'R'
      0080F6 4A                    2543 	.db #0x4a	; 74	'J'
      0080F7 46                    2544 	.db #0x46	; 70	'F'
      0080F8 42                    2545 	.db #0x42	; 66	'B'
      0080F9 00                    2546 	.db #0x00	; 0
      0080FA                       2547 __xinit__ttf_eng_o:
      0080FA 00                    2548 	.db #0x00	; 0
      0080FB 7E                    2549 	.db #0x7e	; 126
      0080FC 42                    2550 	.db #0x42	; 66	'B'
      0080FD 42                    2551 	.db #0x42	; 66	'B'
      0080FE 42                    2552 	.db #0x42	; 66	'B'
      0080FF 42                    2553 	.db #0x42	; 66	'B'
      008100 7E                    2554 	.db #0x7e	; 126
      008101 00                    2555 	.db #0x00	; 0
      008102                       2556 __xinit__ttf_eng_p:
      008102 00                    2557 	.db #0x00	; 0
      008103 7E                    2558 	.db #0x7e	; 126
      008104 42                    2559 	.db #0x42	; 66	'B'
      008105 42                    2560 	.db #0x42	; 66	'B'
      008106 7E                    2561 	.db #0x7e	; 126
      008107 40                    2562 	.db #0x40	; 64
      008108 40                    2563 	.db #0x40	; 64
      008109 00                    2564 	.db #0x00	; 0
      00810A                       2565 __xinit__ttf_eng_q:
      00810A 00                    2566 	.db #0x00	; 0
      00810B 7E                    2567 	.db #0x7e	; 126
      00810C 42                    2568 	.db #0x42	; 66	'B'
      00810D 42                    2569 	.db #0x42	; 66	'B'
      00810E 42                    2570 	.db #0x42	; 66	'B'
      00810F 7E                    2571 	.db #0x7e	; 126
      008110 04                    2572 	.db #0x04	; 4
      008111 00                    2573 	.db #0x00	; 0
      008112                       2574 __xinit__ttf_eng_r:
      008112 00                    2575 	.db #0x00	; 0
      008113 7E                    2576 	.db #0x7e	; 126
      008114 42                    2577 	.db #0x42	; 66	'B'
      008115 42                    2578 	.db #0x42	; 66	'B'
      008116 7C                    2579 	.db #0x7c	; 124
      008117 42                    2580 	.db #0x42	; 66	'B'
      008118 42                    2581 	.db #0x42	; 66	'B'
      008119 00                    2582 	.db #0x00	; 0
      00811A                       2583 __xinit__ttf_eng_s:
      00811A 00                    2584 	.db #0x00	; 0
      00811B 3E                    2585 	.db #0x3e	; 62
      00811C 40                    2586 	.db #0x40	; 64
      00811D 3C                    2587 	.db #0x3c	; 60
      00811E 02                    2588 	.db #0x02	; 2
      00811F 02                    2589 	.db #0x02	; 2
      008120 7C                    2590 	.db #0x7c	; 124
      008121 00                    2591 	.db #0x00	; 0
      008122                       2592 __xinit__ttf_eng_t:
      008122 00                    2593 	.db #0x00	; 0
      008123 7E                    2594 	.db #0x7e	; 126
      008124 18                    2595 	.db #0x18	; 24
      008125 18                    2596 	.db #0x18	; 24
      008126 18                    2597 	.db #0x18	; 24
      008127 18                    2598 	.db #0x18	; 24
      008128 18                    2599 	.db #0x18	; 24
      008129 00                    2600 	.db #0x00	; 0
      00812A                       2601 __xinit__ttf_eng_u:
      00812A 00                    2602 	.db #0x00	; 0
      00812B 42                    2603 	.db #0x42	; 66	'B'
      00812C 42                    2604 	.db #0x42	; 66	'B'
      00812D 42                    2605 	.db #0x42	; 66	'B'
      00812E 42                    2606 	.db #0x42	; 66	'B'
      00812F 42                    2607 	.db #0x42	; 66	'B'
      008130 3E                    2608 	.db #0x3e	; 62
      008131 00                    2609 	.db #0x00	; 0
      008132                       2610 __xinit__ttf_eng_v:
      008132 00                    2611 	.db #0x00	; 0
      008133 42                    2612 	.db #0x42	; 66	'B'
      008134 42                    2613 	.db #0x42	; 66	'B'
      008135 42                    2614 	.db #0x42	; 66	'B'
      008136 24                    2615 	.db #0x24	; 36
      008137 24                    2616 	.db #0x24	; 36
      008138 18                    2617 	.db #0x18	; 24
      008139 00                    2618 	.db #0x00	; 0
      00813A                       2619 __xinit__ttf_eng_w:
      00813A 00                    2620 	.db #0x00	; 0
      00813B 42                    2621 	.db #0x42	; 66	'B'
      00813C 42                    2622 	.db #0x42	; 66	'B'
      00813D 42                    2623 	.db #0x42	; 66	'B'
      00813E 5A                    2624 	.db #0x5a	; 90	'Z'
      00813F 5A                    2625 	.db #0x5a	; 90	'Z'
      008140 24                    2626 	.db #0x24	; 36
      008141 00                    2627 	.db #0x00	; 0
      008142                       2628 __xinit__ttf_eng_x:
      008142 00                    2629 	.db #0x00	; 0
      008143 42                    2630 	.db #0x42	; 66	'B'
      008144 24                    2631 	.db #0x24	; 36
      008145 18                    2632 	.db #0x18	; 24
      008146 18                    2633 	.db #0x18	; 24
      008147 22                    2634 	.db #0x22	; 34
      008148 42                    2635 	.db #0x42	; 66	'B'
      008149 00                    2636 	.db #0x00	; 0
      00814A                       2637 __xinit__ttf_eng_y:
      00814A 00                    2638 	.db #0x00	; 0
      00814B 42                    2639 	.db #0x42	; 66	'B'
      00814C 24                    2640 	.db #0x24	; 36
      00814D 18                    2641 	.db #0x18	; 24
      00814E 18                    2642 	.db #0x18	; 24
      00814F 18                    2643 	.db #0x18	; 24
      008150 18                    2644 	.db #0x18	; 24
      008151 00                    2645 	.db #0x00	; 0
      008152                       2646 __xinit__ttf_eng_z:
      008152 00                    2647 	.db #0x00	; 0
      008153 7E                    2648 	.db #0x7e	; 126
      008154 04                    2649 	.db #0x04	; 4
      008155 08                    2650 	.db #0x08	; 8
      008156 10                    2651 	.db #0x10	; 16
      008157 20                    2652 	.db #0x20	; 32
      008158 7E                    2653 	.db #0x7e	; 126
      008159 00                    2654 	.db #0x00	; 0
      00815A                       2655 __xinit__ttf_eng_1:
      00815A 00                    2656 	.db #0x00	; 0
      00815B 18                    2657 	.db #0x18	; 24
      00815C 38                    2658 	.db #0x38	; 56	'8'
      00815D 38                    2659 	.db #0x38	; 56	'8'
      00815E 18                    2660 	.db #0x18	; 24
      00815F 18                    2661 	.db #0x18	; 24
      008160 18                    2662 	.db #0x18	; 24
      008161 00                    2663 	.db #0x00	; 0
      008162                       2664 __xinit__ttf_eng_2:
      008162 00                    2665 	.db #0x00	; 0
      008163 38                    2666 	.db #0x38	; 56	'8'
      008164 44                    2667 	.db #0x44	; 68	'D'
      008165 08                    2668 	.db #0x08	; 8
      008166 10                    2669 	.db #0x10	; 16
      008167 20                    2670 	.db #0x20	; 32
      008168 7C                    2671 	.db #0x7c	; 124
      008169 00                    2672 	.db #0x00	; 0
      00816A                       2673 __xinit__ttf_eng_3:
      00816A 00                    2674 	.db #0x00	; 0
      00816B 7C                    2675 	.db #0x7c	; 124
      00816C 02                    2676 	.db #0x02	; 2
      00816D 3C                    2677 	.db #0x3c	; 60
      00816E 02                    2678 	.db #0x02	; 2
      00816F 02                    2679 	.db #0x02	; 2
      008170 7C                    2680 	.db #0x7c	; 124
      008171 00                    2681 	.db #0x00	; 0
      008172                       2682 __xinit__ttf_eng_4:
      008172 00                    2683 	.db #0x00	; 0
      008173 42                    2684 	.db #0x42	; 66	'B'
      008174 42                    2685 	.db #0x42	; 66	'B'
      008175 7E                    2686 	.db #0x7e	; 126
      008176 02                    2687 	.db #0x02	; 2
      008177 02                    2688 	.db #0x02	; 2
      008178 02                    2689 	.db #0x02	; 2
      008179 00                    2690 	.db #0x00	; 0
      00817A                       2691 __xinit__ttf_eng_5:
      00817A 00                    2692 	.db #0x00	; 0
      00817B 7E                    2693 	.db #0x7e	; 126
      00817C 40                    2694 	.db #0x40	; 64
      00817D 7C                    2695 	.db #0x7c	; 124
      00817E 02                    2696 	.db #0x02	; 2
      00817F 02                    2697 	.db #0x02	; 2
      008180 7C                    2698 	.db #0x7c	; 124
      008181 00                    2699 	.db #0x00	; 0
      008182                       2700 __xinit__ttf_eng_6:
      008182 00                    2701 	.db #0x00	; 0
      008183 3C                    2702 	.db #0x3c	; 60
      008184 40                    2703 	.db #0x40	; 64
      008185 7C                    2704 	.db #0x7c	; 124
      008186 42                    2705 	.db #0x42	; 66	'B'
      008187 42                    2706 	.db #0x42	; 66	'B'
      008188 3C                    2707 	.db #0x3c	; 60
      008189 00                    2708 	.db #0x00	; 0
      00818A                       2709 __xinit__ttf_eng_7:
      00818A 00                    2710 	.db #0x00	; 0
      00818B 7E                    2711 	.db #0x7e	; 126
      00818C 02                    2712 	.db #0x02	; 2
      00818D 04                    2713 	.db #0x04	; 4
      00818E 08                    2714 	.db #0x08	; 8
      00818F 10                    2715 	.db #0x10	; 16
      008190 20                    2716 	.db #0x20	; 32
      008191 00                    2717 	.db #0x00	; 0
      008192                       2718 __xinit__ttf_eng_8:
      008192 00                    2719 	.db #0x00	; 0
      008193 3C                    2720 	.db #0x3c	; 60
      008194 42                    2721 	.db #0x42	; 66	'B'
      008195 3C                    2722 	.db #0x3c	; 60
      008196 42                    2723 	.db #0x42	; 66	'B'
      008197 42                    2724 	.db #0x42	; 66	'B'
      008198 3C                    2725 	.db #0x3c	; 60
      008199 00                    2726 	.db #0x00	; 0
      00819A                       2727 __xinit__ttf_eng_9:
      00819A 00                    2728 	.db #0x00	; 0
      00819B 3C                    2729 	.db #0x3c	; 60
      00819C 42                    2730 	.db #0x42	; 66	'B'
      00819D 42                    2731 	.db #0x42	; 66	'B'
      00819E 3E                    2732 	.db #0x3e	; 62
      00819F 02                    2733 	.db #0x02	; 2
      0081A0 3C                    2734 	.db #0x3c	; 60
      0081A1 00                    2735 	.db #0x00	; 0
      0081A2                       2736 __xinit__ttf_eng_0:
      0081A2 00                    2737 	.db #0x00	; 0
      0081A3 3C                    2738 	.db #0x3c	; 60
      0081A4 46                    2739 	.db #0x46	; 70	'F'
      0081A5 4A                    2740 	.db #0x4a	; 74	'J'
      0081A6 52                    2741 	.db #0x52	; 82	'R'
      0081A7 62                    2742 	.db #0x62	; 98	'b'
      0081A8 3C                    2743 	.db #0x3c	; 60
      0081A9 00                    2744 	.db #0x00	; 0
      0081AA                       2745 __xinit__ttf_eng_corner_left_up:
      0081AA FF                    2746 	.db #0xff	; 255
      0081AB FF                    2747 	.db #0xff	; 255
      0081AC C0                    2748 	.db #0xc0	; 192
      0081AD C0                    2749 	.db #0xc0	; 192
      0081AE C0                    2750 	.db #0xc0	; 192
      0081AF C0                    2751 	.db #0xc0	; 192
      0081B0 C0                    2752 	.db #0xc0	; 192
      0081B1 C0                    2753 	.db #0xc0	; 192
      0081B2                       2754 __xinit__ttf_eng_corner_right_up:
      0081B2 FF                    2755 	.db #0xff	; 255
      0081B3 FF                    2756 	.db #0xff	; 255
      0081B4 03                    2757 	.db #0x03	; 3
      0081B5 03                    2758 	.db #0x03	; 3
      0081B6 03                    2759 	.db #0x03	; 3
      0081B7 03                    2760 	.db #0x03	; 3
      0081B8 03                    2761 	.db #0x03	; 3
      0081B9 03                    2762 	.db #0x03	; 3
      0081BA                       2763 __xinit__ttf_eng_corner_left_down:
      0081BA C0                    2764 	.db #0xc0	; 192
      0081BB C0                    2765 	.db #0xc0	; 192
      0081BC C0                    2766 	.db #0xc0	; 192
      0081BD C0                    2767 	.db #0xc0	; 192
      0081BE C0                    2768 	.db #0xc0	; 192
      0081BF C0                    2769 	.db #0xc0	; 192
      0081C0 FF                    2770 	.db #0xff	; 255
      0081C1 FF                    2771 	.db #0xff	; 255
      0081C2                       2772 __xinit__ttf_eng_corner_right_down:
      0081C2 03                    2773 	.db #0x03	; 3
      0081C3 03                    2774 	.db #0x03	; 3
      0081C4 03                    2775 	.db #0x03	; 3
      0081C5 03                    2776 	.db #0x03	; 3
      0081C6 03                    2777 	.db #0x03	; 3
      0081C7 03                    2778 	.db #0x03	; 3
      0081C8 FF                    2779 	.db #0xff	; 255
      0081C9 FF                    2780 	.db #0xff	; 255
      0081CA                       2781 __xinit__ttf_eng_line_right:
      0081CA 03                    2782 	.db #0x03	; 3
      0081CB 03                    2783 	.db #0x03	; 3
      0081CC 03                    2784 	.db #0x03	; 3
      0081CD 03                    2785 	.db #0x03	; 3
      0081CE 03                    2786 	.db #0x03	; 3
      0081CF 03                    2787 	.db #0x03	; 3
      0081D0 03                    2788 	.db #0x03	; 3
      0081D1 03                    2789 	.db #0x03	; 3
      0081D2                       2790 __xinit__ttf_eng_line_left:
      0081D2 C0                    2791 	.db #0xc0	; 192
      0081D3 C0                    2792 	.db #0xc0	; 192
      0081D4 C0                    2793 	.db #0xc0	; 192
      0081D5 C0                    2794 	.db #0xc0	; 192
      0081D6 C0                    2795 	.db #0xc0	; 192
      0081D7 C0                    2796 	.db #0xc0	; 192
      0081D8 C0                    2797 	.db #0xc0	; 192
      0081D9 C0                    2798 	.db #0xc0	; 192
      0081DA                       2799 __xinit__ttf_eng_line_up:
      0081DA FF                    2800 	.db #0xff	; 255
      0081DB FF                    2801 	.db #0xff	; 255
      0081DC 00                    2802 	.db #0x00	; 0
      0081DD 00                    2803 	.db #0x00	; 0
      0081DE 00                    2804 	.db #0x00	; 0
      0081DF 00                    2805 	.db #0x00	; 0
      0081E0 00                    2806 	.db #0x00	; 0
      0081E1 00                    2807 	.db #0x00	; 0
      0081E2                       2808 __xinit__ttf_eng_line_down:
      0081E2 00                    2809 	.db #0x00	; 0
      0081E3 00                    2810 	.db #0x00	; 0
      0081E4 00                    2811 	.db #0x00	; 0
      0081E5 00                    2812 	.db #0x00	; 0
      0081E6 00                    2813 	.db #0x00	; 0
      0081E7 00                    2814 	.db #0x00	; 0
      0081E8 FF                    2815 	.db #0xff	; 255
      0081E9 FF                    2816 	.db #0xff	; 255
      0081EA                       2817 __xinit__main_buffer:
      0081EA FF                    2818 	.db #0xff	; 255
      0081EB 01                    2819 	.db #0x01	; 1
      0081EC 01                    2820 	.db #0x01	; 1
      0081ED 01                    2821 	.db #0x01	; 1
      0081EE 01                    2822 	.db #0x01	; 1
      0081EF 01                    2823 	.db #0x01	; 1
      0081F0 01                    2824 	.db #0x01	; 1
      0081F1 01                    2825 	.db #0x01	; 1
      0081F2 FD                    2826 	.db #0xfd	; 253
      0081F3 FD                    2827 	.db #0xfd	; 253
      0081F4 FD                    2828 	.db #0xfd	; 253
      0081F5 FD                    2829 	.db #0xfd	; 253
      0081F6 FD                    2830 	.db #0xfd	; 253
      0081F7 FD                    2831 	.db #0xfd	; 253
      0081F8 FD                    2832 	.db #0xfd	; 253
      0081F9 01                    2833 	.db #0x01	; 1
      0081FA 01                    2834 	.db #0x01	; 1
      0081FB 01                    2835 	.db #0x01	; 1
      0081FC 01                    2836 	.db #0x01	; 1
      0081FD 01                    2837 	.db #0x01	; 1
      0081FE 01                    2838 	.db #0x01	; 1
      0081FF 01                    2839 	.db #0x01	; 1
      008200 FD                    2840 	.db #0xfd	; 253
      008201 FD                    2841 	.db #0xfd	; 253
      008202 FD                    2842 	.db #0xfd	; 253
      008203 FD                    2843 	.db #0xfd	; 253
      008204 FD                    2844 	.db #0xfd	; 253
      008205 FD                    2845 	.db #0xfd	; 253
      008206 FD                    2846 	.db #0xfd	; 253
      008207 FD                    2847 	.db #0xfd	; 253
      008208 FD                    2848 	.db #0xfd	; 253
      008209 FD                    2849 	.db #0xfd	; 253
      00820A FD                    2850 	.db #0xfd	; 253
      00820B FD                    2851 	.db #0xfd	; 253
      00820C FD                    2852 	.db #0xfd	; 253
      00820D FD                    2853 	.db #0xfd	; 253
      00820E FD                    2854 	.db #0xfd	; 253
      00820F FD                    2855 	.db #0xfd	; 253
      008210 FD                    2856 	.db #0xfd	; 253
      008211 FD                    2857 	.db #0xfd	; 253
      008212 FD                    2858 	.db #0xfd	; 253
      008213 FD                    2859 	.db #0xfd	; 253
      008214 FD                    2860 	.db #0xfd	; 253
      008215 FD                    2861 	.db #0xfd	; 253
      008216 FD                    2862 	.db #0xfd	; 253
      008217 FD                    2863 	.db #0xfd	; 253
      008218 FD                    2864 	.db #0xfd	; 253
      008219 FD                    2865 	.db #0xfd	; 253
      00821A FD                    2866 	.db #0xfd	; 253
      00821B FD                    2867 	.db #0xfd	; 253
      00821C FD                    2868 	.db #0xfd	; 253
      00821D FD                    2869 	.db #0xfd	; 253
      00821E FD                    2870 	.db #0xfd	; 253
      00821F FD                    2871 	.db #0xfd	; 253
      008220 FD                    2872 	.db #0xfd	; 253
      008221 FD                    2873 	.db #0xfd	; 253
      008222 FD                    2874 	.db #0xfd	; 253
      008223 01                    2875 	.db #0x01	; 1
      008224 01                    2876 	.db #0x01	; 1
      008225 01                    2877 	.db #0x01	; 1
      008226 01                    2878 	.db #0x01	; 1
      008227 01                    2879 	.db #0x01	; 1
      008228 01                    2880 	.db #0x01	; 1
      008229 01                    2881 	.db #0x01	; 1
      00822A FD                    2882 	.db #0xfd	; 253
      00822B FD                    2883 	.db #0xfd	; 253
      00822C FD                    2884 	.db #0xfd	; 253
      00822D FD                    2885 	.db #0xfd	; 253
      00822E FD                    2886 	.db #0xfd	; 253
      00822F FD                    2887 	.db #0xfd	; 253
      008230 FD                    2888 	.db #0xfd	; 253
      008231 FD                    2889 	.db #0xfd	; 253
      008232 FD                    2890 	.db #0xfd	; 253
      008233 FD                    2891 	.db #0xfd	; 253
      008234 FD                    2892 	.db #0xfd	; 253
      008235 FD                    2893 	.db #0xfd	; 253
      008236 FD                    2894 	.db #0xfd	; 253
      008237 FD                    2895 	.db #0xfd	; 253
      008238 FD                    2896 	.db #0xfd	; 253
      008239 FD                    2897 	.db #0xfd	; 253
      00823A FD                    2898 	.db #0xfd	; 253
      00823B FD                    2899 	.db #0xfd	; 253
      00823C FD                    2900 	.db #0xfd	; 253
      00823D FD                    2901 	.db #0xfd	; 253
      00823E FD                    2902 	.db #0xfd	; 253
      00823F 01                    2903 	.db #0x01	; 1
      008240 01                    2904 	.db #0x01	; 1
      008241 01                    2905 	.db #0x01	; 1
      008242 01                    2906 	.db #0x01	; 1
      008243 01                    2907 	.db #0x01	; 1
      008244 01                    2908 	.db #0x01	; 1
      008245 01                    2909 	.db #0x01	; 1
      008246 01                    2910 	.db #0x01	; 1
      008247 01                    2911 	.db #0x01	; 1
      008248 01                    2912 	.db #0x01	; 1
      008249 01                    2913 	.db #0x01	; 1
      00824A 01                    2914 	.db #0x01	; 1
      00824B 01                    2915 	.db #0x01	; 1
      00824C 01                    2916 	.db #0x01	; 1
      00824D 3D                    2917 	.db #0x3d	; 61
      00824E 15                    2918 	.db #0x15	; 21
      00824F 3D                    2919 	.db #0x3d	; 61
      008250 01                    2920 	.db #0x01	; 1
      008251 3D                    2921 	.db #0x3d	; 61
      008252 21                    2922 	.db #0x21	; 33
      008253 21                    2923 	.db #0x21	; 33
      008254 01                    2924 	.db #0x01	; 1
      008255 3D                    2925 	.db #0x3d	; 61
      008256 15                    2926 	.db #0x15	; 21
      008257 1D                    2927 	.db #0x1d	; 29
      008258 01                    2928 	.db #0x01	; 1
      008259 3D                    2929 	.db #0x3d	; 61
      00825A 11                    2930 	.db #0x11	; 17
      00825B 3D                    2931 	.db #0x3d	; 61
      00825C 01                    2932 	.db #0x01	; 1
      00825D 3D                    2933 	.db #0x3d	; 61
      00825E 15                    2934 	.db #0x15	; 21
      00825F 3D                    2935 	.db #0x3d	; 61
      008260 01                    2936 	.db #0x01	; 1
      008261 01                    2937 	.db #0x01	; 1
      008262 3D                    2938 	.db #0x3d	; 61
      008263 25                    2939 	.db #0x25	; 37
      008264 3D                    2940 	.db #0x3d	; 61
      008265 01                    2941 	.db #0x01	; 1
      008266 05                    2942 	.db #0x05	; 5
      008267 3D                    2943 	.db #0x3d	; 61
      008268 01                    2944 	.db #0x01	; 1
      008269 FF                    2945 	.db #0xff	; 255
      00826A FF                    2946 	.db #0xff	; 255
      00826B 00                    2947 	.db #0x00	; 0
      00826C 00                    2948 	.db #0x00	; 0
      00826D 00                    2949 	.db #0x00	; 0
      00826E 00                    2950 	.db #0x00	; 0
      00826F 00                    2951 	.db #0x00	; 0
      008270 00                    2952 	.db #0x00	; 0
      008271 00                    2953 	.db #0x00	; 0
      008272 FF                    2954 	.db #0xff	; 255
      008273 FF                    2955 	.db #0xff	; 255
      008274 FF                    2956 	.db #0xff	; 255
      008275 FF                    2957 	.db #0xff	; 255
      008276 FF                    2958 	.db #0xff	; 255
      008277 FF                    2959 	.db #0xff	; 255
      008278 FF                    2960 	.db #0xff	; 255
      008279 FE                    2961 	.db #0xfe	; 254
      00827A FE                    2962 	.db #0xfe	; 254
      00827B FE                    2963 	.db #0xfe	; 254
      00827C FE                    2964 	.db #0xfe	; 254
      00827D FE                    2965 	.db #0xfe	; 254
      00827E FE                    2966 	.db #0xfe	; 254
      00827F FE                    2967 	.db #0xfe	; 254
      008280 FF                    2968 	.db #0xff	; 255
      008281 FF                    2969 	.db #0xff	; 255
      008282 FF                    2970 	.db #0xff	; 255
      008283 FF                    2971 	.db #0xff	; 255
      008284 FF                    2972 	.db #0xff	; 255
      008285 FF                    2973 	.db #0xff	; 255
      008286 FF                    2974 	.db #0xff	; 255
      008287 01                    2975 	.db #0x01	; 1
      008288 01                    2976 	.db #0x01	; 1
      008289 01                    2977 	.db #0x01	; 1
      00828A 01                    2978 	.db #0x01	; 1
      00828B 01                    2979 	.db #0x01	; 1
      00828C 01                    2980 	.db #0x01	; 1
      00828D 01                    2981 	.db #0x01	; 1
      00828E FF                    2982 	.db #0xff	; 255
      00828F FF                    2983 	.db #0xff	; 255
      008290 FF                    2984 	.db #0xff	; 255
      008291 FF                    2985 	.db #0xff	; 255
      008292 FF                    2986 	.db #0xff	; 255
      008293 FF                    2987 	.db #0xff	; 255
      008294 FF                    2988 	.db #0xff	; 255
      008295 01                    2989 	.db #0x01	; 1
      008296 01                    2990 	.db #0x01	; 1
      008297 01                    2991 	.db #0x01	; 1
      008298 01                    2992 	.db #0x01	; 1
      008299 01                    2993 	.db #0x01	; 1
      00829A 01                    2994 	.db #0x01	; 1
      00829B 01                    2995 	.db #0x01	; 1
      00829C FF                    2996 	.db #0xff	; 255
      00829D FF                    2997 	.db #0xff	; 255
      00829E FF                    2998 	.db #0xff	; 255
      00829F FF                    2999 	.db #0xff	; 255
      0082A0 FF                    3000 	.db #0xff	; 255
      0082A1 FF                    3001 	.db #0xff	; 255
      0082A2 FF                    3002 	.db #0xff	; 255
      0082A3 00                    3003 	.db #0x00	; 0
      0082A4 00                    3004 	.db #0x00	; 0
      0082A5 00                    3005 	.db #0x00	; 0
      0082A6 00                    3006 	.db #0x00	; 0
      0082A7 00                    3007 	.db #0x00	; 0
      0082A8 00                    3008 	.db #0x00	; 0
      0082A9 00                    3009 	.db #0x00	; 0
      0082AA FF                    3010 	.db #0xff	; 255
      0082AB FF                    3011 	.db #0xff	; 255
      0082AC FF                    3012 	.db #0xff	; 255
      0082AD FF                    3013 	.db #0xff	; 255
      0082AE FF                    3014 	.db #0xff	; 255
      0082AF FF                    3015 	.db #0xff	; 255
      0082B0 FF                    3016 	.db #0xff	; 255
      0082B1 01                    3017 	.db #0x01	; 1
      0082B2 01                    3018 	.db #0x01	; 1
      0082B3 01                    3019 	.db #0x01	; 1
      0082B4 01                    3020 	.db #0x01	; 1
      0082B5 01                    3021 	.db #0x01	; 1
      0082B6 01                    3022 	.db #0x01	; 1
      0082B7 01                    3023 	.db #0x01	; 1
      0082B8 FF                    3024 	.db #0xff	; 255
      0082B9 FF                    3025 	.db #0xff	; 255
      0082BA FF                    3026 	.db #0xff	; 255
      0082BB FF                    3027 	.db #0xff	; 255
      0082BC FF                    3028 	.db #0xff	; 255
      0082BD FF                    3029 	.db #0xff	; 255
      0082BE FF                    3030 	.db #0xff	; 255
      0082BF 00                    3031 	.db #0x00	; 0
      0082C0 00                    3032 	.db #0x00	; 0
      0082C1 00                    3033 	.db #0x00	; 0
      0082C2 00                    3034 	.db #0x00	; 0
      0082C3 00                    3035 	.db #0x00	; 0
      0082C4 00                    3036 	.db #0x00	; 0
      0082C5 00                    3037 	.db #0x00	; 0
      0082C6 00                    3038 	.db #0x00	; 0
      0082C7 00                    3039 	.db #0x00	; 0
      0082C8 00                    3040 	.db #0x00	; 0
      0082C9 00                    3041 	.db #0x00	; 0
      0082CA 00                    3042 	.db #0x00	; 0
      0082CB 00                    3043 	.db #0x00	; 0
      0082CC 00                    3044 	.db #0x00	; 0
      0082CD 00                    3045 	.db #0x00	; 0
      0082CE 00                    3046 	.db #0x00	; 0
      0082CF 00                    3047 	.db #0x00	; 0
      0082D0 00                    3048 	.db #0x00	; 0
      0082D1 00                    3049 	.db #0x00	; 0
      0082D2 00                    3050 	.db #0x00	; 0
      0082D3 00                    3051 	.db #0x00	; 0
      0082D4 00                    3052 	.db #0x00	; 0
      0082D5 00                    3053 	.db #0x00	; 0
      0082D6 00                    3054 	.db #0x00	; 0
      0082D7 00                    3055 	.db #0x00	; 0
      0082D8 00                    3056 	.db #0x00	; 0
      0082D9 00                    3057 	.db #0x00	; 0
      0082DA 00                    3058 	.db #0x00	; 0
      0082DB 00                    3059 	.db #0x00	; 0
      0082DC 00                    3060 	.db #0x00	; 0
      0082DD 00                    3061 	.db #0x00	; 0
      0082DE 00                    3062 	.db #0x00	; 0
      0082DF 00                    3063 	.db #0x00	; 0
      0082E0 00                    3064 	.db #0x00	; 0
      0082E1 00                    3065 	.db #0x00	; 0
      0082E2 00                    3066 	.db #0x00	; 0
      0082E3 00                    3067 	.db #0x00	; 0
      0082E4 00                    3068 	.db #0x00	; 0
      0082E5 00                    3069 	.db #0x00	; 0
      0082E6 00                    3070 	.db #0x00	; 0
      0082E7 00                    3071 	.db #0x00	; 0
      0082E8 00                    3072 	.db #0x00	; 0
      0082E9 FF                    3073 	.db #0xff	; 255
      0082EA FF                    3074 	.db #0xff	; 255
      0082EB 00                    3075 	.db #0x00	; 0
      0082EC 00                    3076 	.db #0x00	; 0
      0082ED 00                    3077 	.db #0x00	; 0
      0082EE 00                    3078 	.db #0x00	; 0
      0082EF 00                    3079 	.db #0x00	; 0
      0082F0 00                    3080 	.db #0x00	; 0
      0082F1 00                    3081 	.db #0x00	; 0
      0082F2 FF                    3082 	.db #0xff	; 255
      0082F3 FF                    3083 	.db #0xff	; 255
      0082F4 FF                    3084 	.db #0xff	; 255
      0082F5 FF                    3085 	.db #0xff	; 255
      0082F6 FF                    3086 	.db #0xff	; 255
      0082F7 FF                    3087 	.db #0xff	; 255
      0082F8 FF                    3088 	.db #0xff	; 255
      0082F9 00                    3089 	.db #0x00	; 0
      0082FA 00                    3090 	.db #0x00	; 0
      0082FB 00                    3091 	.db #0x00	; 0
      0082FC 00                    3092 	.db #0x00	; 0
      0082FD 00                    3093 	.db #0x00	; 0
      0082FE 00                    3094 	.db #0x00	; 0
      0082FF 00                    3095 	.db #0x00	; 0
      008300 FF                    3096 	.db #0xff	; 255
      008301 FF                    3097 	.db #0xff	; 255
      008302 FF                    3098 	.db #0xff	; 255
      008303 FF                    3099 	.db #0xff	; 255
      008304 FF                    3100 	.db #0xff	; 255
      008305 FF                    3101 	.db #0xff	; 255
      008306 FF                    3102 	.db #0xff	; 255
      008307 00                    3103 	.db #0x00	; 0
      008308 00                    3104 	.db #0x00	; 0
      008309 00                    3105 	.db #0x00	; 0
      00830A 00                    3106 	.db #0x00	; 0
      00830B 00                    3107 	.db #0x00	; 0
      00830C 00                    3108 	.db #0x00	; 0
      00830D 00                    3109 	.db #0x00	; 0
      00830E FF                    3110 	.db #0xff	; 255
      00830F FF                    3111 	.db #0xff	; 255
      008310 FF                    3112 	.db #0xff	; 255
      008311 FF                    3113 	.db #0xff	; 255
      008312 FF                    3114 	.db #0xff	; 255
      008313 FF                    3115 	.db #0xff	; 255
      008314 FF                    3116 	.db #0xff	; 255
      008315 00                    3117 	.db #0x00	; 0
      008316 00                    3118 	.db #0x00	; 0
      008317 00                    3119 	.db #0x00	; 0
      008318 00                    3120 	.db #0x00	; 0
      008319 00                    3121 	.db #0x00	; 0
      00831A 00                    3122 	.db #0x00	; 0
      00831B 00                    3123 	.db #0x00	; 0
      00831C FF                    3124 	.db #0xff	; 255
      00831D FF                    3125 	.db #0xff	; 255
      00831E FF                    3126 	.db #0xff	; 255
      00831F FF                    3127 	.db #0xff	; 255
      008320 FF                    3128 	.db #0xff	; 255
      008321 FF                    3129 	.db #0xff	; 255
      008322 FF                    3130 	.db #0xff	; 255
      008323 7F                    3131 	.db #0x7f	; 127
      008324 7F                    3132 	.db #0x7f	; 127
      008325 7F                    3133 	.db #0x7f	; 127
      008326 7F                    3134 	.db #0x7f	; 127
      008327 7F                    3135 	.db #0x7f	; 127
      008328 7F                    3136 	.db #0x7f	; 127
      008329 7F                    3137 	.db #0x7f	; 127
      00832A FF                    3138 	.db #0xff	; 255
      00832B FF                    3139 	.db #0xff	; 255
      00832C FF                    3140 	.db #0xff	; 255
      00832D FF                    3141 	.db #0xff	; 255
      00832E FF                    3142 	.db #0xff	; 255
      00832F FF                    3143 	.db #0xff	; 255
      008330 FF                    3144 	.db #0xff	; 255
      008331 7F                    3145 	.db #0x7f	; 127
      008332 7F                    3146 	.db #0x7f	; 127
      008333 7F                    3147 	.db #0x7f	; 127
      008334 7F                    3148 	.db #0x7f	; 127
      008335 7F                    3149 	.db #0x7f	; 127
      008336 7F                    3150 	.db #0x7f	; 127
      008337 7F                    3151 	.db #0x7f	; 127
      008338 80                    3152 	.db #0x80	; 128
      008339 80                    3153 	.db #0x80	; 128
      00833A 80                    3154 	.db #0x80	; 128
      00833B 80                    3155 	.db #0x80	; 128
      00833C 80                    3156 	.db #0x80	; 128
      00833D 80                    3157 	.db #0x80	; 128
      00833E 80                    3158 	.db #0x80	; 128
      00833F 00                    3159 	.db #0x00	; 0
      008340 00                    3160 	.db #0x00	; 0
      008341 00                    3161 	.db #0x00	; 0
      008342 80                    3162 	.db #0x80	; 128
      008343 80                    3163 	.db #0x80	; 128
      008344 80                    3164 	.db #0x80	; 128
      008345 80                    3165 	.db #0x80	; 128
      008346 80                    3166 	.db #0x80	; 128
      008347 80                    3167 	.db #0x80	; 128
      008348 80                    3168 	.db #0x80	; 128
      008349 00                    3169 	.db #0x00	; 0
      00834A 00                    3170 	.db #0x00	; 0
      00834B 00                    3171 	.db #0x00	; 0
      00834C 00                    3172 	.db #0x00	; 0
      00834D 00                    3173 	.db #0x00	; 0
      00834E 00                    3174 	.db #0x00	; 0
      00834F 00                    3175 	.db #0x00	; 0
      008350 00                    3176 	.db #0x00	; 0
      008351 00                    3177 	.db #0x00	; 0
      008352 00                    3178 	.db #0x00	; 0
      008353 00                    3179 	.db #0x00	; 0
      008354 00                    3180 	.db #0x00	; 0
      008355 00                    3181 	.db #0x00	; 0
      008356 00                    3182 	.db #0x00	; 0
      008357 00                    3183 	.db #0x00	; 0
      008358 00                    3184 	.db #0x00	; 0
      008359 00                    3185 	.db #0x00	; 0
      00835A 00                    3186 	.db #0x00	; 0
      00835B 00                    3187 	.db #0x00	; 0
      00835C 00                    3188 	.db #0x00	; 0
      00835D 00                    3189 	.db #0x00	; 0
      00835E 00                    3190 	.db #0x00	; 0
      00835F 00                    3191 	.db #0x00	; 0
      008360 00                    3192 	.db #0x00	; 0
      008361 00                    3193 	.db #0x00	; 0
      008362 00                    3194 	.db #0x00	; 0
      008363 00                    3195 	.db #0x00	; 0
      008364 00                    3196 	.db #0x00	; 0
      008365 00                    3197 	.db #0x00	; 0
      008366 00                    3198 	.db #0x00	; 0
      008367 00                    3199 	.db #0x00	; 0
      008368 00                    3200 	.db #0x00	; 0
      008369 FF                    3201 	.db #0xff	; 255
      00836A FF                    3202 	.db #0xff	; 255
      00836B 80                    3203 	.db #0x80	; 128
      00836C 80                    3204 	.db #0x80	; 128
      00836D 80                    3205 	.db #0x80	; 128
      00836E 80                    3206 	.db #0x80	; 128
      00836F 80                    3207 	.db #0x80	; 128
      008370 80                    3208 	.db #0x80	; 128
      008371 80                    3209 	.db #0x80	; 128
      008372 BF                    3210 	.db #0xbf	; 191
      008373 BF                    3211 	.db #0xbf	; 191
      008374 BF                    3212 	.db #0xbf	; 191
      008375 BF                    3213 	.db #0xbf	; 191
      008376 BF                    3214 	.db #0xbf	; 191
      008377 BF                    3215 	.db #0xbf	; 191
      008378 BF                    3216 	.db #0xbf	; 191
      008379 80                    3217 	.db #0x80	; 128
      00837A 80                    3218 	.db #0x80	; 128
      00837B 80                    3219 	.db #0x80	; 128
      00837C 80                    3220 	.db #0x80	; 128
      00837D 80                    3221 	.db #0x80	; 128
      00837E 80                    3222 	.db #0x80	; 128
      00837F 80                    3223 	.db #0x80	; 128
      008380 BF                    3224 	.db #0xbf	; 191
      008381 BF                    3225 	.db #0xbf	; 191
      008382 BF                    3226 	.db #0xbf	; 191
      008383 BF                    3227 	.db #0xbf	; 191
      008384 BF                    3228 	.db #0xbf	; 191
      008385 BF                    3229 	.db #0xbf	; 191
      008386 BF                    3230 	.db #0xbf	; 191
      008387 80                    3231 	.db #0x80	; 128
      008388 80                    3232 	.db #0x80	; 128
      008389 80                    3233 	.db #0x80	; 128
      00838A 80                    3234 	.db #0x80	; 128
      00838B 80                    3235 	.db #0x80	; 128
      00838C 80                    3236 	.db #0x80	; 128
      00838D 80                    3237 	.db #0x80	; 128
      00838E BF                    3238 	.db #0xbf	; 191
      00838F BF                    3239 	.db #0xbf	; 191
      008390 BF                    3240 	.db #0xbf	; 191
      008391 BF                    3241 	.db #0xbf	; 191
      008392 BF                    3242 	.db #0xbf	; 191
      008393 BF                    3243 	.db #0xbf	; 191
      008394 BF                    3244 	.db #0xbf	; 191
      008395 80                    3245 	.db #0x80	; 128
      008396 80                    3246 	.db #0x80	; 128
      008397 80                    3247 	.db #0x80	; 128
      008398 80                    3248 	.db #0x80	; 128
      008399 80                    3249 	.db #0x80	; 128
      00839A 80                    3250 	.db #0x80	; 128
      00839B 80                    3251 	.db #0x80	; 128
      00839C BF                    3252 	.db #0xbf	; 191
      00839D BF                    3253 	.db #0xbf	; 191
      00839E BF                    3254 	.db #0xbf	; 191
      00839F BF                    3255 	.db #0xbf	; 191
      0083A0 BF                    3256 	.db #0xbf	; 191
      0083A1 BF                    3257 	.db #0xbf	; 191
      0083A2 BF                    3258 	.db #0xbf	; 191
      0083A3 80                    3259 	.db #0x80	; 128
      0083A4 80                    3260 	.db #0x80	; 128
      0083A5 80                    3261 	.db #0x80	; 128
      0083A6 80                    3262 	.db #0x80	; 128
      0083A7 80                    3263 	.db #0x80	; 128
      0083A8 80                    3264 	.db #0x80	; 128
      0083A9 80                    3265 	.db #0x80	; 128
      0083AA BF                    3266 	.db #0xbf	; 191
      0083AB BF                    3267 	.db #0xbf	; 191
      0083AC BF                    3268 	.db #0xbf	; 191
      0083AD BF                    3269 	.db #0xbf	; 191
      0083AE BF                    3270 	.db #0xbf	; 191
      0083AF BF                    3271 	.db #0xbf	; 191
      0083B0 BF                    3272 	.db #0xbf	; 191
      0083B1 80                    3273 	.db #0x80	; 128
      0083B2 80                    3274 	.db #0x80	; 128
      0083B3 80                    3275 	.db #0x80	; 128
      0083B4 80                    3276 	.db #0x80	; 128
      0083B5 80                    3277 	.db #0x80	; 128
      0083B6 80                    3278 	.db #0x80	; 128
      0083B7 80                    3279 	.db #0x80	; 128
      0083B8 BF                    3280 	.db #0xbf	; 191
      0083B9 BF                    3281 	.db #0xbf	; 191
      0083BA BF                    3282 	.db #0xbf	; 191
      0083BB BF                    3283 	.db #0xbf	; 191
      0083BC BF                    3284 	.db #0xbf	; 191
      0083BD BF                    3285 	.db #0xbf	; 191
      0083BE BF                    3286 	.db #0xbf	; 191
      0083BF 80                    3287 	.db #0x80	; 128
      0083C0 80                    3288 	.db #0x80	; 128
      0083C1 80                    3289 	.db #0x80	; 128
      0083C2 B1                    3290 	.db #0xb1	; 177
      0083C3 B1                    3291 	.db #0xb1	; 177
      0083C4 BF                    3292 	.db #0xbf	; 191
      0083C5 BF                    3293 	.db #0xbf	; 191
      0083C6 BF                    3294 	.db #0xbf	; 191
      0083C7 B1                    3295 	.db #0xb1	; 177
      0083C8 B1                    3296 	.db #0xb1	; 177
      0083C9 80                    3297 	.db #0x80	; 128
      0083CA 80                    3298 	.db #0x80	; 128
      0083CB BF                    3299 	.db #0xbf	; 191
      0083CC BF                    3300 	.db #0xbf	; 191
      0083CD 83                    3301 	.db #0x83	; 131
      0083CE 83                    3302 	.db #0x83	; 131
      0083CF BF                    3303 	.db #0xbf	; 191
      0083D0 BE                    3304 	.db #0xbe	; 190
      0083D1 80                    3305 	.db #0x80	; 128
      0083D2 80                    3306 	.db #0x80	; 128
      0083D3 BF                    3307 	.db #0xbf	; 191
      0083D4 BF                    3308 	.db #0xbf	; 191
      0083D5 B3                    3309 	.db #0xb3	; 179
      0083D6 B3                    3310 	.db #0xb3	; 179
      0083D7 B3                    3311 	.db #0xb3	; 179
      0083D8 B3                    3312 	.db #0xb3	; 179
      0083D9 80                    3313 	.db #0x80	; 128
      0083DA 80                    3314 	.db #0x80	; 128
      0083DB 80                    3315 	.db #0x80	; 128
      0083DC 80                    3316 	.db #0x80	; 128
      0083DD B0                    3317 	.db #0xb0	; 176
      0083DE B0                    3318 	.db #0xb0	; 176
      0083DF 80                    3319 	.db #0x80	; 128
      0083E0 80                    3320 	.db #0x80	; 128
      0083E1 80                    3321 	.db #0x80	; 128
      0083E2 80                    3322 	.db #0x80	; 128
      0083E3 80                    3323 	.db #0x80	; 128
      0083E4 80                    3324 	.db #0x80	; 128
      0083E5 80                    3325 	.db #0x80	; 128
      0083E6 80                    3326 	.db #0x80	; 128
      0083E7 80                    3327 	.db #0x80	; 128
      0083E8 80                    3328 	.db #0x80	; 128
      0083E9 FF                    3329 	.db #0xff	; 255
      0083EA                       3330 __xinit__current_item:
      0083EA 00                    3331 	.db #0x00	; 0
      0083EB                       3332 __xinit__paragraph_item:
      0083EB 00                    3333 	.db #0x00	; 0
      0083EC                       3334 __xinit__TIM2_IRQ:
      0083EC 00                    3335 	.db #0x00	; 0
                                   3336 	.area CABS (ABS)
