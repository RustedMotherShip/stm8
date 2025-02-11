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
                                     14 	.globl _params_default_conf
                                     15 	.globl _tmr2_irq
                                     16 	.globl _menu_set_paragraph
                                     17 	.globl _menu_set_item_menu
                                     18 	.globl _menu_set_params_value
                                     19 	.globl _menu_border_item
                                     20 	.globl _menu_border_paragraph
                                     21 	.globl _menu_border
                                     22 	.globl _ssd1306_send_buffer
                                     23 	.globl _ssd1306_buffer_clean
                                     24 	.globl _set_bit
                                     25 	.globl _get_bit
                                     26 	.globl _i2c_irq
                                     27 	.globl _memset
                                     28 	.globl _TIM2_IRQ
                                     29 	.globl _main_buffer
                                     30 	.globl _ttf_line_down
                                     31 	.globl _ttf_line_up
                                     32 	.globl _ttf_line_left
                                     33 	.globl _ttf_line_right
                                     34 	.globl _ttf_corner_right_down
                                     35 	.globl _ttf_corner_left_down
                                     36 	.globl _ttf_corner_right_up
                                     37 	.globl _ttf_corner_left_up
                                     38 	.globl _ttf_num_0
                                     39 	.globl _ttf_num_9
                                     40 	.globl _ttf_num_8
                                     41 	.globl _ttf_num_7
                                     42 	.globl _ttf_num_6
                                     43 	.globl _ttf_num_5
                                     44 	.globl _ttf_num_4
                                     45 	.globl _ttf_num_3
                                     46 	.globl _ttf_num_2
                                     47 	.globl _ttf_num_1
                                     48 	.globl _ttf_void
                                     49 	.globl _I2C_IRQ
                                     50 	.globl _ttf_eng_z
                                     51 	.globl _ttf_eng_y
                                     52 	.globl _ttf_eng_x
                                     53 	.globl _ttf_eng_w
                                     54 	.globl _ttf_eng_v
                                     55 	.globl _ttf_eng_u
                                     56 	.globl _ttf_eng_t
                                     57 	.globl _ttf_eng_s
                                     58 	.globl _ttf_eng_r
                                     59 	.globl _ttf_eng_q
                                     60 	.globl _ttf_eng_p
                                     61 	.globl _ttf_eng_o
                                     62 	.globl _ttf_eng_n
                                     63 	.globl _ttf_eng_m
                                     64 	.globl _ttf_eng_l
                                     65 	.globl _ttf_eng_k
                                     66 	.globl _ttf_eng_j
                                     67 	.globl _ttf_eng_i
                                     68 	.globl _ttf_eng_h
                                     69 	.globl _ttf_eng_g
                                     70 	.globl _ttf_eng_f
                                     71 	.globl _ttf_eng_e
                                     72 	.globl _ttf_eng_d
                                     73 	.globl _ttf_eng_c
                                     74 	.globl _ttf_eng_b
                                     75 	.globl _ttf_eng_a
                                     76 	.globl _params_value
                                     77 	.globl _buf_size
                                     78 	.globl _buf_pos
                                     79 	.globl _rx_buf_pointer
                                     80 	.globl _tx_buf_pointer
                                     81 	.globl _uart_transmission_irq
                                     82 	.globl _uart_reciever_irq
                                     83 	.globl _uart_write_irq
                                     84 	.globl _uart_read_irq
                                     85 	.globl _uart_init
                                     86 	.globl _uart_read_byte
                                     87 	.globl _uart_write_byte
                                     88 	.globl _uart_write
                                     89 	.globl _uart_read
                                     90 	.globl _i2c_init
                                     91 	.globl _i2c_start
                                     92 	.globl _i2c_stop
                                     93 	.globl _i2c_send_address
                                     94 	.globl _i2c_read_byte
                                     95 	.globl _i2c_read
                                     96 	.globl _i2c_send_byte
                                     97 	.globl _i2c_write
                                     98 	.globl _i2c_scan
                                     99 	.globl _i2c_start_irq
                                    100 	.globl _i2c_stop_irq
                                    101 	.globl _ssd1306_init
                                    102 	.globl _ssd1306_set_params_to_write
                                    103 	.globl _ssd1306_draw_pixel
                                    104 	.globl _ssd1306_buffer_write
                                    105 	.globl _ssd1306_clean
                                    106 	.globl _delay_s
                                    107 	.globl _delay_ms
                                    108 ;--------------------------------------------------------
                                    109 ; ram data
                                    110 ;--------------------------------------------------------
                                    111 	.area DATA
      000001                        112 _tx_buf_pointer::
      000001                        113 	.ds 2
      000003                        114 _rx_buf_pointer::
      000003                        115 	.ds 2
      000005                        116 _buf_pos::
      000005                        117 	.ds 1
      000006                        118 _buf_size::
      000006                        119 	.ds 1
      000007                        120 _params_value::
      000007                        121 	.ds 8
      00000F                        122 _menu_set_params_value_numbers_10000_171:
      00000F                        123 	.ds 20
                                    124 ;--------------------------------------------------------
                                    125 ; ram data
                                    126 ;--------------------------------------------------------
                                    127 	.area INITIALIZED
      000023                        128 _ttf_eng_a::
      000023                        129 	.ds 8
      00002B                        130 _ttf_eng_b::
      00002B                        131 	.ds 8
      000033                        132 _ttf_eng_c::
      000033                        133 	.ds 8
      00003B                        134 _ttf_eng_d::
      00003B                        135 	.ds 8
      000043                        136 _ttf_eng_e::
      000043                        137 	.ds 8
      00004B                        138 _ttf_eng_f::
      00004B                        139 	.ds 8
      000053                        140 _ttf_eng_g::
      000053                        141 	.ds 8
      00005B                        142 _ttf_eng_h::
      00005B                        143 	.ds 8
      000063                        144 _ttf_eng_i::
      000063                        145 	.ds 8
      00006B                        146 _ttf_eng_j::
      00006B                        147 	.ds 8
      000073                        148 _ttf_eng_k::
      000073                        149 	.ds 8
      00007B                        150 _ttf_eng_l::
      00007B                        151 	.ds 8
      000083                        152 _ttf_eng_m::
      000083                        153 	.ds 8
      00008B                        154 _ttf_eng_n::
      00008B                        155 	.ds 8
      000093                        156 _ttf_eng_o::
      000093                        157 	.ds 8
      00009B                        158 _ttf_eng_p::
      00009B                        159 	.ds 8
      0000A3                        160 _ttf_eng_q::
      0000A3                        161 	.ds 8
      0000AB                        162 _ttf_eng_r::
      0000AB                        163 	.ds 8
      0000B3                        164 _ttf_eng_s::
      0000B3                        165 	.ds 8
      0000BB                        166 _ttf_eng_t::
      0000BB                        167 	.ds 8
      0000C3                        168 _ttf_eng_u::
      0000C3                        169 	.ds 8
      0000CB                        170 _ttf_eng_v::
      0000CB                        171 	.ds 8
      0000D3                        172 _ttf_eng_w::
      0000D3                        173 	.ds 8
      0000DB                        174 _ttf_eng_x::
      0000DB                        175 	.ds 8
      0000E3                        176 _ttf_eng_y::
      0000E3                        177 	.ds 8
      0000EB                        178 _ttf_eng_z::
      0000EB                        179 	.ds 8
      0000F3                        180 _I2C_IRQ::
      0000F3                        181 	.ds 1
      0000F4                        182 _ttf_void::
      0000F4                        183 	.ds 8
      0000FC                        184 _ttf_num_1::
      0000FC                        185 	.ds 8
      000104                        186 _ttf_num_2::
      000104                        187 	.ds 8
      00010C                        188 _ttf_num_3::
      00010C                        189 	.ds 8
      000114                        190 _ttf_num_4::
      000114                        191 	.ds 8
      00011C                        192 _ttf_num_5::
      00011C                        193 	.ds 8
      000124                        194 _ttf_num_6::
      000124                        195 	.ds 8
      00012C                        196 _ttf_num_7::
      00012C                        197 	.ds 8
      000134                        198 _ttf_num_8::
      000134                        199 	.ds 8
      00013C                        200 _ttf_num_9::
      00013C                        201 	.ds 8
      000144                        202 _ttf_num_0::
      000144                        203 	.ds 8
      00014C                        204 _ttf_corner_left_up::
      00014C                        205 	.ds 8
      000154                        206 _ttf_corner_right_up::
      000154                        207 	.ds 8
      00015C                        208 _ttf_corner_left_down::
      00015C                        209 	.ds 8
      000164                        210 _ttf_corner_right_down::
      000164                        211 	.ds 8
      00016C                        212 _ttf_line_right::
      00016C                        213 	.ds 8
      000174                        214 _ttf_line_left::
      000174                        215 	.ds 8
      00017C                        216 _ttf_line_up::
      00017C                        217 	.ds 8
      000184                        218 _ttf_line_down::
      000184                        219 	.ds 8
      00018C                        220 _main_buffer::
      00018C                        221 	.ds 512
      00038C                        222 _TIM2_IRQ::
      00038C                        223 	.ds 1
                                    224 ;--------------------------------------------------------
                                    225 ; Stack segment in internal ram
                                    226 ;--------------------------------------------------------
                                    227 	.area SSEG
      00038D                        228 __start__stack:
      00038D                        229 	.ds	1
                                    230 
                                    231 ;--------------------------------------------------------
                                    232 ; absolute external ram data
                                    233 ;--------------------------------------------------------
                                    234 	.area DABS (ABS)
                                    235 
                                    236 ; default segment ordering for linker
                                    237 	.area HOME
                                    238 	.area GSINIT
                                    239 	.area GSFINAL
                                    240 	.area CONST
                                    241 	.area INITIALIZER
                                    242 	.area CODE
                                    243 
                                    244 ;--------------------------------------------------------
                                    245 ; interrupt vector
                                    246 ;--------------------------------------------------------
                                    247 	.area HOME
      008000                        248 __interrupt_vect:
      008000 82 00 80 5B            249 	int s_GSINIT ; reset
      008004 82 00 00 00            250 	int 0x000000 ; trap
      008008 82 00 00 00            251 	int 0x000000 ; int0
      00800C 82 00 00 00            252 	int 0x000000 ; int1
      008010 82 00 00 00            253 	int 0x000000 ; int2
      008014 82 00 00 00            254 	int 0x000000 ; int3
      008018 82 00 00 00            255 	int 0x000000 ; int4
      00801C 82 00 00 00            256 	int 0x000000 ; int5
      008020 82 00 00 00            257 	int 0x000000 ; int6
      008024 82 00 00 00            258 	int 0x000000 ; int7
      008028 82 00 00 00            259 	int 0x000000 ; int8
      00802C 82 00 00 00            260 	int 0x000000 ; int9
      008030 82 00 00 00            261 	int 0x000000 ; int10
      008034 82 00 00 00            262 	int 0x000000 ; int11
      008038 82 00 00 00            263 	int 0x000000 ; int12
      00803C 82 00 91 E6            264 	int _tmr2_irq ; int13
      008040 82 00 00 00            265 	int 0x000000 ; int14
      008044 82 00 00 00            266 	int 0x000000 ; int15
      008048 82 00 00 00            267 	int 0x000000 ; int16
      00804C 82 00 84 27            268 	int _uart_transmission_irq ; int17
      008050 82 00 84 63            269 	int _uart_reciever_irq ; int18
      008054 82 00 86 45            270 	int _i2c_irq ; int19
                                    271 ;--------------------------------------------------------
                                    272 ; global & static initialisations
                                    273 ;--------------------------------------------------------
                                    274 	.area HOME
                                    275 	.area GSINIT
                                    276 	.area GSFINAL
                                    277 	.area GSINIT
      00805B CD 93 13         [ 4]  278 	call	___sdcc_external_startup
      00805E 4D               [ 1]  279 	tnz	a
      00805F 27 03            [ 1]  280 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  281 	jp	__sdcc_program_startup
      008064                        282 __sdcc_init_data:
                                    283 ; stm8_genXINIT() start
      008064 AE 00 22         [ 2]  284 	ldw x, #l_DATA
      008067 27 07            [ 1]  285 	jreq	00002$
      008069                        286 00001$:
      008069 72 4F 00 00      [ 1]  287 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  288 	decw x
      00806E 26 F9            [ 1]  289 	jrne	00001$
      008070                        290 00002$:
      008070 AE 03 6A         [ 2]  291 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  292 	jreq	00004$
      008075                        293 00003$:
      008075 D6 80 BC         [ 1]  294 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 22         [ 1]  295 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  296 	decw	x
      00807C 26 F7            [ 1]  297 	jrne	00003$
      00807E                        298 00004$:
                                    299 ; stm8_genXINIT() end
                                    300 ;	./libs/menu_lib.c: 63: static uint8_t *numbers[] = {&ttf_num_0[0],&ttf_num_1[0],&ttf_num_2[0],&ttf_num_3[0],&ttf_num_4[0],&ttf_num_5[0],&ttf_num_6[0],&ttf_num_7[0],&ttf_num_8[0],&ttf_num_9[0]};
      00807E AE 01 44         [ 2]  301 	ldw	x, #_ttf_num_0+0
      008081 CF 00 0F         [ 2]  302 	ldw	_menu_set_params_value_numbers_10000_171+0, x
      008084 AE 00 FC         [ 2]  303 	ldw	x, #_ttf_num_1+0
      008087 CF 00 11         [ 2]  304 	ldw	_menu_set_params_value_numbers_10000_171+2, x
      00808A AE 01 04         [ 2]  305 	ldw	x, #_ttf_num_2+0
      00808D CF 00 13         [ 2]  306 	ldw	_menu_set_params_value_numbers_10000_171+4, x
      008090 AE 01 0C         [ 2]  307 	ldw	x, #_ttf_num_3+0
      008093 CF 00 15         [ 2]  308 	ldw	_menu_set_params_value_numbers_10000_171+6, x
      008096 AE 01 14         [ 2]  309 	ldw	x, #_ttf_num_4+0
      008099 CF 00 17         [ 2]  310 	ldw	_menu_set_params_value_numbers_10000_171+8, x
      00809C AE 01 1C         [ 2]  311 	ldw	x, #_ttf_num_5+0
      00809F CF 00 19         [ 2]  312 	ldw	_menu_set_params_value_numbers_10000_171+10, x
      0080A2 AE 01 24         [ 2]  313 	ldw	x, #_ttf_num_6+0
      0080A5 CF 00 1B         [ 2]  314 	ldw	_menu_set_params_value_numbers_10000_171+12, x
      0080A8 AE 01 2C         [ 2]  315 	ldw	x, #_ttf_num_7+0
      0080AB CF 00 1D         [ 2]  316 	ldw	_menu_set_params_value_numbers_10000_171+14, x
      0080AE AE 01 34         [ 2]  317 	ldw	x, #_ttf_num_8+0
      0080B1 CF 00 1F         [ 2]  318 	ldw	_menu_set_params_value_numbers_10000_171+16, x
      0080B4 AE 01 3C         [ 2]  319 	ldw	x, #_ttf_num_9+0
      0080B7 CF 00 21         [ 2]  320 	ldw	_menu_set_params_value_numbers_10000_171+18, x
                                    321 	.area GSFINAL
      0080BA CC 80 58         [ 2]  322 	jp	__sdcc_program_startup
                                    323 ;--------------------------------------------------------
                                    324 ; Home
                                    325 ;--------------------------------------------------------
                                    326 	.area HOME
                                    327 	.area HOME
      008058                        328 __sdcc_program_startup:
      008058 CC 92 E8         [ 2]  329 	jp	_main
                                    330 ;	return from main will return to caller
                                    331 ;--------------------------------------------------------
                                    332 ; code
                                    333 ;--------------------------------------------------------
                                    334 	.area CODE
                                    335 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    336 ;	-----------------------------------------
                                    337 ;	 function uart_transmission_irq
                                    338 ;	-----------------------------------------
      008427                        339 _uart_transmission_irq:
                                    340 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      008427 AE 52 30         [ 2]  341 	ldw	x, #0x5230
      00842A F6               [ 1]  342 	ld	a, (x)
      00842B 4E               [ 1]  343 	swap	a
      00842C 44               [ 1]  344 	srl	a
      00842D 44               [ 1]  345 	srl	a
      00842E 44               [ 1]  346 	srl	a
      00842F A5 01            [ 1]  347 	bcp	a, #0x01
      008431 27 2F            [ 1]  348 	jreq	00107$
                                    349 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      008433 C6 00 02         [ 1]  350 	ld	a, _tx_buf_pointer+1
      008436 CB 00 05         [ 1]  351 	add	a, _buf_pos+0
      008439 97               [ 1]  352 	ld	xl, a
      00843A C6 00 01         [ 1]  353 	ld	a, _tx_buf_pointer+0
      00843D A9 00            [ 1]  354 	adc	a, #0x00
      00843F 95               [ 1]  355 	ld	xh, a
      008440 F6               [ 1]  356 	ld	a, (x)
      008441 27 1B            [ 1]  357 	jreq	00102$
      008443 C6 00 05         [ 1]  358 	ld	a, _buf_pos+0
      008446 C1 00 06         [ 1]  359 	cp	a, _buf_size+0
      008449 24 13            [ 1]  360 	jrnc	00102$
                                    361 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      00844B C6 00 05         [ 1]  362 	ld	a, _buf_pos+0
      00844E 72 5C 00 05      [ 1]  363 	inc	_buf_pos+0
      008452 5F               [ 1]  364 	clrw	x
      008453 97               [ 1]  365 	ld	xl, a
      008454 72 BB 00 01      [ 2]  366 	addw	x, _tx_buf_pointer+0
      008458 F6               [ 1]  367 	ld	a, (x)
      008459 C7 52 31         [ 1]  368 	ld	0x5231, a
      00845C 20 04            [ 2]  369 	jra	00107$
      00845E                        370 00102$:
                                    371 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      00845E 72 1F 52 35      [ 1]  372 	bres	0x5235, #7
      008462                        373 00107$:
                                    374 ;	./libs/uart_lib.c: 14: }
      008462 80               [11]  375 	iret
                                    376 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    377 ;	-----------------------------------------
                                    378 ;	 function uart_reciever_irq
                                    379 ;	-----------------------------------------
      008463                        380 _uart_reciever_irq:
      008463 88               [ 1]  381 	push	a
                                    382 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      008464 C6 52 30         [ 1]  383 	ld	a, 0x5230
      008467 4E               [ 1]  384 	swap	a
      008468 44               [ 1]  385 	srl	a
      008469 A5 01            [ 1]  386 	bcp	a, #0x01
      00846B 27 27            [ 1]  387 	jreq	00107$
                                    388 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      00846D C6 52 31         [ 1]  389 	ld	a, 0x5231
                                    390 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      008470 6B 01            [ 1]  391 	ld	(0x01, sp), a
      008472 A1 0A            [ 1]  392 	cp	a, #0x0a
      008474 27 1A            [ 1]  393 	jreq	00102$
      008476 C6 00 05         [ 1]  394 	ld	a, _buf_pos+0
      008479 C1 00 06         [ 1]  395 	cp	a, _buf_size+0
      00847C 24 12            [ 1]  396 	jrnc	00102$
                                    397 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      00847E C6 00 05         [ 1]  398 	ld	a, _buf_pos+0
      008481 72 5C 00 05      [ 1]  399 	inc	_buf_pos+0
      008485 5F               [ 1]  400 	clrw	x
      008486 97               [ 1]  401 	ld	xl, a
      008487 72 BB 00 03      [ 2]  402 	addw	x, _rx_buf_pointer+0
      00848B 7B 01            [ 1]  403 	ld	a, (0x01, sp)
      00848D F7               [ 1]  404 	ld	(x), a
      00848E 20 04            [ 2]  405 	jra	00107$
      008490                        406 00102$:
                                    407 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      008490 72 1B 52 35      [ 1]  408 	bres	0x5235, #5
      008494                        409 00107$:
                                    410 ;	./libs/uart_lib.c: 30: }
      008494 84               [ 1]  411 	pop	a
      008495 80               [11]  412 	iret
                                    413 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    414 ;	-----------------------------------------
                                    415 ;	 function uart_write_irq
                                    416 ;	-----------------------------------------
      008496                        417 _uart_write_irq:
      008496 52 02            [ 2]  418 	sub	sp, #2
                                    419 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      008498 1F 01            [ 2]  420 	ldw	(0x01, sp), x
      00849A CF 00 01         [ 2]  421 	ldw	_tx_buf_pointer+0, x
                                    422 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      00849D 72 5F 00 05      [ 1]  423 	clr	_buf_pos+0
                                    424 ;	./libs/uart_lib.c: 36: buf_size = 0;
      0084A1 72 5F 00 06      [ 1]  425 	clr	_buf_size+0
                                    426 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      0084A5                        427 00101$:
      0084A5 C6 00 06         [ 1]  428 	ld	a, _buf_size+0
      0084A8 72 5C 00 06      [ 1]  429 	inc	_buf_size+0
      0084AC 5F               [ 1]  430 	clrw	x
      0084AD 97               [ 1]  431 	ld	xl, a
      0084AE 72 FB 01         [ 2]  432 	addw	x, (0x01, sp)
      0084B1 F6               [ 1]  433 	ld	a, (x)
      0084B2 26 F1            [ 1]  434 	jrne	00101$
                                    435 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      0084B4 72 1E 52 35      [ 1]  436 	bset	0x5235, #7
                                    437 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      0084B8                        438 00104$:
      0084B8 72 0E 52 35 FB   [ 2]  439 	btjt	0x5235, #7, 00104$
                                    440 ;	./libs/uart_lib.c: 40: }
      0084BD 5B 02            [ 2]  441 	addw	sp, #2
      0084BF 81               [ 4]  442 	ret
                                    443 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    444 ;	-----------------------------------------
                                    445 ;	 function uart_read_irq
                                    446 ;	-----------------------------------------
      0084C0                        447 _uart_read_irq:
                                    448 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      0084C0 CF 00 03         [ 2]  449 	ldw	_rx_buf_pointer+0, x
                                    450 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      0084C3 72 5F 00 05      [ 1]  451 	clr	_buf_pos+0
                                    452 ;	./libs/uart_lib.c: 45: buf_size = size;
      0084C7 7B 04            [ 1]  453 	ld	a, (0x04, sp)
      0084C9 C7 00 06         [ 1]  454 	ld	_buf_size+0, a
                                    455 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      0084CC 72 1A 52 35      [ 1]  456 	bset	0x5235, #5
                                    457 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      0084D0                        458 00101$:
      0084D0 C6 52 35         [ 1]  459 	ld	a, 0x5235
      0084D3 4E               [ 1]  460 	swap	a
      0084D4 44               [ 1]  461 	srl	a
      0084D5 A4 01            [ 1]  462 	and	a, #0x01
      0084D7 26 F7            [ 1]  463 	jrne	00101$
                                    464 ;	./libs/uart_lib.c: 48: }
      0084D9 1E 01            [ 2]  465 	ldw	x, (1, sp)
      0084DB 5B 04            [ 2]  466 	addw	sp, #4
      0084DD FC               [ 2]  467 	jp	(x)
                                    468 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    469 ;	-----------------------------------------
                                    470 ;	 function uart_init
                                    471 ;	-----------------------------------------
      0084DE                        472 _uart_init:
      0084DE 52 02            [ 2]  473 	sub	sp, #2
      0084E0 1F 01            [ 2]  474 	ldw	(0x01, sp), x
                                    475 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      0084E2 AE 52 35         [ 2]  476 	ldw	x, #0x5235
      0084E5 88               [ 1]  477 	push	a
      0084E6 F6               [ 1]  478 	ld	a, (x)
      0084E7 AA 08            [ 1]  479 	or	a, #0x08
      0084E9 F7               [ 1]  480 	ld	(x), a
      0084EA 84               [ 1]  481 	pop	a
                                    482 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      0084EB AE 52 35         [ 2]  483 	ldw	x, #0x5235
      0084EE 88               [ 1]  484 	push	a
      0084EF F6               [ 1]  485 	ld	a, (x)
      0084F0 AA 04            [ 1]  486 	or	a, #0x04
      0084F2 F7               [ 1]  487 	ld	(x), a
      0084F3 84               [ 1]  488 	pop	a
                                    489 ;	./libs/uart_lib.c: 56: switch(stopbit)
      0084F4 A1 02            [ 1]  490 	cp	a, #0x02
      0084F6 27 06            [ 1]  491 	jreq	00101$
      0084F8 A1 03            [ 1]  492 	cp	a, #0x03
      0084FA 27 0E            [ 1]  493 	jreq	00102$
      0084FC 20 16            [ 2]  494 	jra	00103$
                                    495 ;	./libs/uart_lib.c: 58: case 2:
      0084FE                        496 00101$:
                                    497 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      0084FE C6 52 36         [ 1]  498 	ld	a, 0x5236
      008501 A4 CF            [ 1]  499 	and	a, #0xcf
      008503 AA 20            [ 1]  500 	or	a, #0x20
      008505 C7 52 36         [ 1]  501 	ld	0x5236, a
                                    502 ;	./libs/uart_lib.c: 60: break;
      008508 20 12            [ 2]  503 	jra	00104$
                                    504 ;	./libs/uart_lib.c: 61: case 3:
      00850A                        505 00102$:
                                    506 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      00850A C6 52 36         [ 1]  507 	ld	a, 0x5236
      00850D AA 30            [ 1]  508 	or	a, #0x30
      00850F C7 52 36         [ 1]  509 	ld	0x5236, a
                                    510 ;	./libs/uart_lib.c: 63: break;
      008512 20 08            [ 2]  511 	jra	00104$
                                    512 ;	./libs/uart_lib.c: 64: default:
      008514                        513 00103$:
                                    514 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      008514 C6 52 36         [ 1]  515 	ld	a, 0x5236
      008517 A4 CF            [ 1]  516 	and	a, #0xcf
      008519 C7 52 36         [ 1]  517 	ld	0x5236, a
                                    518 ;	./libs/uart_lib.c: 67: }
      00851C                        519 00104$:
                                    520 ;	./libs/uart_lib.c: 68: switch(baudrate)
      00851C 1E 01            [ 2]  521 	ldw	x, (0x01, sp)
      00851E A3 08 00         [ 2]  522 	cpw	x, #0x0800
      008521 26 03            [ 1]  523 	jrne	00186$
      008523 CC 85 AF         [ 2]  524 	jp	00110$
      008526                        525 00186$:
      008526 1E 01            [ 2]  526 	ldw	x, (0x01, sp)
      008528 A3 09 60         [ 2]  527 	cpw	x, #0x0960
      00852B 27 28            [ 1]  528 	jreq	00105$
      00852D 1E 01            [ 2]  529 	ldw	x, (0x01, sp)
      00852F A3 10 00         [ 2]  530 	cpw	x, #0x1000
      008532 26 03            [ 1]  531 	jrne	00192$
      008534 CC 85 BF         [ 2]  532 	jp	00111$
      008537                        533 00192$:
      008537 1E 01            [ 2]  534 	ldw	x, (0x01, sp)
      008539 A3 4B 00         [ 2]  535 	cpw	x, #0x4b00
      00853C 27 31            [ 1]  536 	jreq	00106$
      00853E 1E 01            [ 2]  537 	ldw	x, (0x01, sp)
      008540 A3 84 00         [ 2]  538 	cpw	x, #0x8400
      008543 27 5A            [ 1]  539 	jreq	00109$
      008545 1E 01            [ 2]  540 	ldw	x, (0x01, sp)
      008547 A3 C2 00         [ 2]  541 	cpw	x, #0xc200
      00854A 27 43            [ 1]  542 	jreq	00108$
      00854C 1E 01            [ 2]  543 	ldw	x, (0x01, sp)
      00854E A3 E1 00         [ 2]  544 	cpw	x, #0xe100
      008551 27 2C            [ 1]  545 	jreq	00107$
      008553 20 7A            [ 2]  546 	jra	00112$
                                    547 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      008555                        548 00105$:
                                    549 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      008555 C6 52 33         [ 1]  550 	ld	a, 0x5233
      008558 A4 0F            [ 1]  551 	and	a, #0x0f
      00855A AA 10            [ 1]  552 	or	a, #0x10
      00855C C7 52 33         [ 1]  553 	ld	0x5233, a
                                    554 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      00855F 35 A0 52 32      [ 1]  555 	mov	0x5232+0, #0xa0
                                    556 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      008563 C6 52 33         [ 1]  557 	ld	a, 0x5233
      008566 A4 F0            [ 1]  558 	and	a, #0xf0
      008568 AA 0B            [ 1]  559 	or	a, #0x0b
      00856A C7 52 33         [ 1]  560 	ld	0x5233, a
                                    561 ;	./libs/uart_lib.c: 74: break;
      00856D 20 6E            [ 2]  562 	jra	00114$
                                    563 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      00856F                        564 00106$:
                                    565 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      00856F 35 34 52 32      [ 1]  566 	mov	0x5232+0, #0x34
                                    567 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      008573 C6 52 33         [ 1]  568 	ld	a, 0x5233
      008576 A4 F0            [ 1]  569 	and	a, #0xf0
      008578 AA 01            [ 1]  570 	or	a, #0x01
      00857A C7 52 33         [ 1]  571 	ld	0x5233, a
                                    572 ;	./libs/uart_lib.c: 78: break;
      00857D 20 5E            [ 2]  573 	jra	00114$
                                    574 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      00857F                        575 00107$:
                                    576 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      00857F 35 11 52 32      [ 1]  577 	mov	0x5232+0, #0x11
                                    578 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      008583 C6 52 33         [ 1]  579 	ld	a, 0x5233
      008586 A4 F0            [ 1]  580 	and	a, #0xf0
      008588 AA 06            [ 1]  581 	or	a, #0x06
      00858A C7 52 33         [ 1]  582 	ld	0x5233, a
                                    583 ;	./libs/uart_lib.c: 82: break;
      00858D 20 4E            [ 2]  584 	jra	00114$
                                    585 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      00858F                        586 00108$:
                                    587 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      00858F 35 08 52 32      [ 1]  588 	mov	0x5232+0, #0x08
                                    589 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      008593 C6 52 33         [ 1]  590 	ld	a, 0x5233
      008596 A4 F0            [ 1]  591 	and	a, #0xf0
      008598 AA 0B            [ 1]  592 	or	a, #0x0b
      00859A C7 52 33         [ 1]  593 	ld	0x5233, a
                                    594 ;	./libs/uart_lib.c: 86: break;
      00859D 20 3E            [ 2]  595 	jra	00114$
                                    596 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      00859F                        597 00109$:
                                    598 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      00859F 35 04 52 32      [ 1]  599 	mov	0x5232+0, #0x04
                                    600 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      0085A3 C6 52 33         [ 1]  601 	ld	a, 0x5233
      0085A6 A4 F0            [ 1]  602 	and	a, #0xf0
      0085A8 AA 05            [ 1]  603 	or	a, #0x05
      0085AA C7 52 33         [ 1]  604 	ld	0x5233, a
                                    605 ;	./libs/uart_lib.c: 90: break;
      0085AD 20 2E            [ 2]  606 	jra	00114$
                                    607 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      0085AF                        608 00110$:
                                    609 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      0085AF 35 02 52 32      [ 1]  610 	mov	0x5232+0, #0x02
                                    611 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      0085B3 C6 52 33         [ 1]  612 	ld	a, 0x5233
      0085B6 A4 F0            [ 1]  613 	and	a, #0xf0
      0085B8 AA 03            [ 1]  614 	or	a, #0x03
      0085BA C7 52 33         [ 1]  615 	ld	0x5233, a
                                    616 ;	./libs/uart_lib.c: 94: break;
      0085BD 20 1E            [ 2]  617 	jra	00114$
                                    618 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      0085BF                        619 00111$:
                                    620 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      0085BF 35 01 52 32      [ 1]  621 	mov	0x5232+0, #0x01
                                    622 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      0085C3 C6 52 33         [ 1]  623 	ld	a, 0x5233
      0085C6 A4 F0            [ 1]  624 	and	a, #0xf0
      0085C8 AA 01            [ 1]  625 	or	a, #0x01
      0085CA C7 52 33         [ 1]  626 	ld	0x5233, a
                                    627 ;	./libs/uart_lib.c: 98: break;
      0085CD 20 0E            [ 2]  628 	jra	00114$
                                    629 ;	./libs/uart_lib.c: 99: default:
      0085CF                        630 00112$:
                                    631 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      0085CF 35 68 52 32      [ 1]  632 	mov	0x5232+0, #0x68
                                    633 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      0085D3 C6 52 33         [ 1]  634 	ld	a, 0x5233
      0085D6 A4 F0            [ 1]  635 	and	a, #0xf0
      0085D8 AA 03            [ 1]  636 	or	a, #0x03
      0085DA C7 52 33         [ 1]  637 	ld	0x5233, a
                                    638 ;	./libs/uart_lib.c: 103: }
      0085DD                        639 00114$:
                                    640 ;	./libs/uart_lib.c: 104: }
      0085DD 5B 02            [ 2]  641 	addw	sp, #2
      0085DF 81               [ 4]  642 	ret
                                    643 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    644 ;	-----------------------------------------
                                    645 ;	 function uart_read_byte
                                    646 ;	-----------------------------------------
      0085E0                        647 _uart_read_byte:
                                    648 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      0085E0                        649 00101$:
      0085E0 72 0B 52 30 FB   [ 2]  650 	btjf	0x5230, #5, 00101$
                                    651 ;	./libs/uart_lib.c: 110: return 1;
      0085E5 5F               [ 1]  652 	clrw	x
      0085E6 5C               [ 1]  653 	incw	x
                                    654 ;	./libs/uart_lib.c: 111: }
      0085E7 81               [ 4]  655 	ret
                                    656 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    657 ;	-----------------------------------------
                                    658 ;	 function uart_write_byte
                                    659 ;	-----------------------------------------
      0085E8                        660 _uart_write_byte:
                                    661 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      0085E8 C7 52 31         [ 1]  662 	ld	0x5231, a
                                    663 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      0085EB                        664 00101$:
      0085EB 72 0F 52 30 FB   [ 2]  665 	btjf	0x5230, #7, 00101$
                                    666 ;	./libs/uart_lib.c: 117: return 1;
      0085F0 5F               [ 1]  667 	clrw	x
      0085F1 5C               [ 1]  668 	incw	x
                                    669 ;	./libs/uart_lib.c: 118: }
      0085F2 81               [ 4]  670 	ret
                                    671 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    672 ;	-----------------------------------------
                                    673 ;	 function uart_write
                                    674 ;	-----------------------------------------
      0085F3                        675 _uart_write:
      0085F3 52 04            [ 2]  676 	sub	sp, #4
      0085F5 1F 01            [ 2]  677 	ldw	(0x01, sp), x
                                    678 ;	./libs/uart_lib.c: 122: int count = 0;
      0085F7 5F               [ 1]  679 	clrw	x
      0085F8 1F 03            [ 2]  680 	ldw	(0x03, sp), x
                                    681 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085FA 5F               [ 1]  682 	clrw	x
      0085FB                        683 00103$:
      0085FB 90 93            [ 1]  684 	ldw	y, x
      0085FD 72 F9 01         [ 2]  685 	addw	y, (0x01, sp)
      008600 90 F6            [ 1]  686 	ld	a, (y)
      008602 27 0E            [ 1]  687 	jreq	00101$
                                    688 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      008604 89               [ 2]  689 	pushw	x
      008605 CD 85 E8         [ 4]  690 	call	_uart_write_byte
      008608 51               [ 1]  691 	exgw	x, y
      008609 85               [ 2]  692 	popw	x
      00860A 72 F9 03         [ 2]  693 	addw	y, (0x03, sp)
      00860D 17 03            [ 2]  694 	ldw	(0x03, sp), y
                                    695 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      00860F 5C               [ 1]  696 	incw	x
      008610 20 E9            [ 2]  697 	jra	00103$
      008612                        698 00101$:
                                    699 ;	./libs/uart_lib.c: 125: return count;
      008612 1E 03            [ 2]  700 	ldw	x, (0x03, sp)
                                    701 ;	./libs/uart_lib.c: 126: }
      008614 5B 04            [ 2]  702 	addw	sp, #4
      008616 81               [ 4]  703 	ret
                                    704 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    705 ;	-----------------------------------------
                                    706 ;	 function uart_read
                                    707 ;	-----------------------------------------
      008617                        708 _uart_read:
      008617 52 04            [ 2]  709 	sub	sp, #4
      008619 1F 01            [ 2]  710 	ldw	(0x01, sp), x
                                    711 ;	./libs/uart_lib.c: 130: int count = 0;
      00861B 5F               [ 1]  712 	clrw	x
      00861C 1F 03            [ 2]  713 	ldw	(0x03, sp), x
                                    714 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      00861E 5F               [ 1]  715 	clrw	x
      00861F                        716 00103$:
      00861F 90 93            [ 1]  717 	ldw	y, x
      008621 72 F9 01         [ 2]  718 	addw	y, (0x01, sp)
      008624 90 F6            [ 1]  719 	ld	a, (y)
      008626 27 13            [ 1]  720 	jreq	00101$
                                    721 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      008628 90 5F            [ 1]  722 	clrw	y
      00862A 90 97            [ 1]  723 	ld	yl, a
      00862C 89               [ 2]  724 	pushw	x
      00862D 93               [ 1]  725 	ldw	x, y
      00862E CD 85 E0         [ 4]  726 	call	_uart_read_byte
      008631 51               [ 1]  727 	exgw	x, y
      008632 85               [ 2]  728 	popw	x
      008633 72 F9 03         [ 2]  729 	addw	y, (0x03, sp)
      008636 17 03            [ 2]  730 	ldw	(0x03, sp), y
                                    731 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008638 5C               [ 1]  732 	incw	x
      008639 20 E4            [ 2]  733 	jra	00103$
      00863B                        734 00101$:
                                    735 ;	./libs/uart_lib.c: 133: return count;
      00863B 1E 03            [ 2]  736 	ldw	x, (0x03, sp)
                                    737 ;	./libs/uart_lib.c: 134: }
      00863D 5B 04            [ 2]  738 	addw	sp, #4
      00863F 90 85            [ 2]  739 	popw	y
      008641 5B 02            [ 2]  740 	addw	sp, #2
      008643 90 FC            [ 2]  741 	jp	(y)
                                    742 ;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    743 ;	-----------------------------------------
                                    744 ;	 function i2c_irq
                                    745 ;	-----------------------------------------
      008645                        746 _i2c_irq:
      008645 4F               [ 1]  747 	clr	a
      008646 62               [ 2]  748 	div	x, a
                                    749 ;	./libs/i2c_lib.c: 6: disableInterrupts();
      008647 9B               [ 1]  750 	sim
                                    751 ;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
      008648 35 00 00 F3      [ 1]  752 	mov	_I2C_IRQ+0, #0x00
                                    753 ;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
      00864C AE 52 17         [ 2]  754 	ldw	x, #0x5217
      00864F F6               [ 1]  755 	ld	a, (x)
      008650 44               [ 1]  756 	srl	a
      008651 A4 01            [ 1]  757 	and	a, #0x01
      008653 27 16            [ 1]  758 	jreq	00102$
                                    759 ;	./libs/i2c_lib.c: 11: clr_sr1();
      008655 C6 52 17         [ 1]  760 	ld	a,0x5217
                                    761 ;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
      008658 72 12 00 F3      [ 1]  762 	bset	_I2C_IRQ+0, #1
                                    763 ;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
      00865C C6 52 19         [ 1]  764 	ld	a,0x5219
                                    765 ;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
      00865F 72 13 52 1A      [ 1]  766 	bres	0x521a, #1
                                    767 ;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
      008663 A6 E1            [ 1]  768 	ld	a, #0xe1
      008665 CD 85 E8         [ 4]  769 	call	_uart_write_byte
                                    770 ;	./libs/i2c_lib.c: 16: return;
      008668 CC 86 FE         [ 2]  771 	jp	00113$
      00866B                        772 00102$:
                                    773 ;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      00866B C6 52 17         [ 1]  774 	ld	a, 0x5217
      00866E 4E               [ 1]  775 	swap	a
      00866F 44               [ 1]  776 	srl	a
      008670 44               [ 1]  777 	srl	a
      008671 44               [ 1]  778 	srl	a
      008672 A5 01            [ 1]  779 	bcp	a, #0x01
      008674 27 17            [ 1]  780 	jreq	00104$
                                    781 ;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
      008676 72 18 00 F3      [ 1]  782 	bset	_I2C_IRQ+0, #4
                                    783 ;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
      00867A 72 15 52 1A      [ 1]  784 	bres	0x521a, #2
                                    785 ;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
      00867E 72 13 52 1A      [ 1]  786 	bres	0x521a, #1
                                    787 ;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
      008682 72 11 52 1A      [ 1]  788 	bres	0x521a, #0
                                    789 ;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
      008686 A6 EA            [ 1]  790 	ld	a, #0xea
      008688 CD 85 E8         [ 4]  791 	call	_uart_write_byte
                                    792 ;	./libs/i2c_lib.c: 26: return;
      00868B 20 71            [ 2]  793 	jra	00113$
      00868D                        794 00104$:
                                    795 ;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      00868D C6 52 17         [ 1]  796 	ld	a, 0x5217
      008690 4E               [ 1]  797 	swap	a
      008691 44               [ 1]  798 	srl	a
      008692 44               [ 1]  799 	srl	a
      008693 A5 01            [ 1]  800 	bcp	a, #0x01
      008695 27 17            [ 1]  801 	jreq	00106$
                                    802 ;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
      008697 72 16 00 F3      [ 1]  803 	bset	_I2C_IRQ+0, #3
                                    804 ;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
      00869B 72 15 52 1A      [ 1]  805 	bres	0x521a, #2
                                    806 ;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
      00869F 72 13 52 1A      [ 1]  807 	bres	0x521a, #1
                                    808 ;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
      0086A3 72 11 52 1A      [ 1]  809 	bres	0x521a, #0
                                    810 ;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
      0086A7 A6 EB            [ 1]  811 	ld	a, #0xeb
      0086A9 CD 85 E8         [ 4]  812 	call	_uart_write_byte
                                    813 ;	./libs/i2c_lib.c: 35: return;
      0086AC 20 50            [ 2]  814 	jra	00113$
      0086AE                        815 00106$:
                                    816 ;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      0086AE C6 52 17         [ 1]  817 	ld	a, 0x5217
      0086B1 A5 01            [ 1]  818 	bcp	a, #0x01
      0086B3 27 0F            [ 1]  819 	jreq	00108$
                                    820 ;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
      0086B5 72 10 00 F3      [ 1]  821 	bset	_I2C_IRQ+0, #0
                                    822 ;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
      0086B9 72 13 52 1A      [ 1]  823 	bres	0x521a, #1
                                    824 ;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
      0086BD A6 E2            [ 1]  825 	ld	a, #0xe2
      0086BF CD 85 E8         [ 4]  826 	call	_uart_write_byte
                                    827 ;	./libs/i2c_lib.c: 43: return;
      0086C2 20 3A            [ 2]  828 	jra	00113$
      0086C4                        829 00108$:
                                    830 ;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
      0086C4 C6 52 17         [ 1]  831 	ld	a, 0x5217
      0086C7 44               [ 1]  832 	srl	a
      0086C8 44               [ 1]  833 	srl	a
      0086C9 A5 01            [ 1]  834 	bcp	a, #0x01
      0086CB 27 0F            [ 1]  835 	jreq	00110$
                                    836 ;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
      0086CD 72 14 00 F3      [ 1]  837 	bset	_I2C_IRQ+0, #2
                                    838 ;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
      0086D1 72 13 52 1A      [ 1]  839 	bres	0x521a, #1
                                    840 ;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
      0086D5 A6 E3            [ 1]  841 	ld	a, #0xe3
      0086D7 CD 85 E8         [ 4]  842 	call	_uart_write_byte
                                    843 ;	./libs/i2c_lib.c: 50: return;
      0086DA 20 22            [ 2]  844 	jra	00113$
      0086DC                        845 00110$:
                                    846 ;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      0086DC AE 52 18         [ 2]  847 	ldw	x, #0x5218
      0086DF F6               [ 1]  848 	ld	a, (x)
      0086E0 44               [ 1]  849 	srl	a
      0086E1 44               [ 1]  850 	srl	a
      0086E2 A4 01            [ 1]  851 	and	a, #0x01
      0086E4 27 17            [ 1]  852 	jreq	00112$
                                    853 ;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
      0086E6 72 1A 00 F3      [ 1]  854 	bset	_I2C_IRQ+0, #5
                                    855 ;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
      0086EA 72 13 52 1A      [ 1]  856 	bres	0x521a, #1
                                    857 ;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
      0086EE 72 11 52 1A      [ 1]  858 	bres	0x521a, #0
                                    859 ;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
      0086F2 72 15 52 1A      [ 1]  860 	bres	0x521a, #2
                                    861 ;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
      0086F6 A6 EE            [ 1]  862 	ld	a, #0xee
      0086F8 CD 85 E8         [ 4]  863 	call	_uart_write_byte
                                    864 ;	./libs/i2c_lib.c: 60: return;
      0086FB 20 01            [ 2]  865 	jra	00113$
      0086FD                        866 00112$:
                                    867 ;	./libs/i2c_lib.c: 63: enableInterrupts(); 
      0086FD 9A               [ 1]  868 	rim
      0086FE                        869 00113$:
                                    870 ;	./libs/i2c_lib.c: 64: }
      0086FE 80               [11]  871 	iret
                                    872 ;	./libs/i2c_lib.c: 66: void i2c_init(void)
                                    873 ;	-----------------------------------------
                                    874 ;	 function i2c_init
                                    875 ;	-----------------------------------------
      0086FF                        876 _i2c_init:
                                    877 ;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      0086FF 72 11 52 10      [ 1]  878 	bres	0x5210, #0
                                    879 ;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      008703 C6 52 12         [ 1]  880 	ld	a, 0x5212
      008706 A4 C0            [ 1]  881 	and	a, #0xc0
      008708 AA 10            [ 1]  882 	or	a, #0x10
      00870A C7 52 12         [ 1]  883 	ld	0x5212, a
                                    884 ;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
      00870D C6 52 1C         [ 1]  885 	ld	a, 0x521c
      008710 A4 F0            [ 1]  886 	and	a, #0xf0
      008712 C7 52 1C         [ 1]  887 	ld	0x521c, a
                                    888 ;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008715 35 50 52 1B      [ 1]  889 	mov	0x521b+0, #0x50
                                    890 ;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      008719 72 1F 52 1C      [ 1]  891 	bres	0x521c, #7
                                    892 ;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      00871D 72 1F 52 14      [ 1]  893 	bres	0x5214, #7
                                    894 ;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
      008721 72 10 52 14      [ 1]  895 	bset	0x5214, #0
                                    896 ;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      008725 72 10 52 10      [ 1]  897 	bset	0x5210, #0
                                    898 ;	./libs/i2c_lib.c: 78: }
      008729 81               [ 4]  899 	ret
                                    900 ;	./libs/i2c_lib.c: 80: void i2c_start(void)
                                    901 ;	-----------------------------------------
                                    902 ;	 function i2c_start
                                    903 ;	-----------------------------------------
      00872A                        904 _i2c_start:
                                    905 ;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      00872A 72 10 52 11      [ 1]  906 	bset	0x5211, #0
                                    907 ;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      00872E                        908 00101$:
      00872E 72 01 52 17 FB   [ 2]  909 	btjf	0x5217, #0, 00101$
                                    910 ;	./libs/i2c_lib.c: 84: }
      008733 81               [ 4]  911 	ret
                                    912 ;	./libs/i2c_lib.c: 86: void i2c_stop(void)
                                    913 ;	-----------------------------------------
                                    914 ;	 function i2c_stop
                                    915 ;	-----------------------------------------
      008734                        916 _i2c_stop:
                                    917 ;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      008734 72 12 52 11      [ 1]  918 	bset	0x5211, #1
                                    919 ;	./libs/i2c_lib.c: 89: }
      008738 81               [ 4]  920 	ret
                                    921 ;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    922 ;	-----------------------------------------
                                    923 ;	 function i2c_send_address
                                    924 ;	-----------------------------------------
      008739                        925 _i2c_send_address:
                                    926 ;	./libs/i2c_lib.c: 96: address = address << 1;
      008739 48               [ 1]  927 	sll	a
                                    928 ;	./libs/i2c_lib.c: 93: switch(rw_type)
      00873A 88               [ 1]  929 	push	a
      00873B 7B 04            [ 1]  930 	ld	a, (0x04, sp)
      00873D 4A               [ 1]  931 	dec	a
      00873E 84               [ 1]  932 	pop	a
      00873F 26 02            [ 1]  933 	jrne	00102$
                                    934 ;	./libs/i2c_lib.c: 96: address = address << 1;
                                    935 ;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
      008741 AA 01            [ 1]  936 	or	a, #0x01
                                    937 ;	./libs/i2c_lib.c: 98: break;
                                    938 ;	./libs/i2c_lib.c: 99: default:
                                    939 ;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
                                    940 ;	./libs/i2c_lib.c: 102: }
      008743                        941 00102$:
                                    942 ;	./libs/i2c_lib.c: 103: i2c_start();
      008743 88               [ 1]  943 	push	a
      008744 CD 87 2A         [ 4]  944 	call	_i2c_start
      008747 84               [ 1]  945 	pop	a
                                    946 ;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
      008748 C7 52 16         [ 1]  947 	ld	0x5216, a
                                    948 ;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
      00874B                        949 00106$:
      00874B AE 52 17         [ 2]  950 	ldw	x, #0x5217
      00874E F6               [ 1]  951 	ld	a, (x)
      00874F 44               [ 1]  952 	srl	a
      008750 A4 01            [ 1]  953 	and	a, #0x01
      008752 26 08            [ 1]  954 	jrne	00108$
                                    955 ;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
      008754 72 05 52 18 F2   [ 2]  956 	btjf	0x5218, #2, 00106$
                                    957 ;	./libs/i2c_lib.c: 107: return 0;
      008759 4F               [ 1]  958 	clr	a
      00875A 20 08            [ 2]  959 	jra	00109$
      00875C                        960 00108$:
                                    961 ;	./libs/i2c_lib.c: 108: clr_sr1();
      00875C C6 52 17         [ 1]  962 	ld	a,0x5217
                                    963 ;	./libs/i2c_lib.c: 109: clr_sr3();
      00875F C6 52 19         [ 1]  964 	ld	a,0x5219
                                    965 ;	./libs/i2c_lib.c: 110: return 1;
      008762 A6 01            [ 1]  966 	ld	a, #0x01
      008764                        967 00109$:
                                    968 ;	./libs/i2c_lib.c: 111: }
      008764 85               [ 2]  969 	popw	x
      008765 5B 01            [ 2]  970 	addw	sp, #1
      008767 FC               [ 2]  971 	jp	(x)
                                    972 ;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
                                    973 ;	-----------------------------------------
                                    974 ;	 function i2c_read_byte
                                    975 ;	-----------------------------------------
      008768                        976 _i2c_read_byte:
                                    977 ;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
      008768                        978 00101$:
      008768 72 0D 52 17 FB   [ 2]  979 	btjf	0x5217, #6, 00101$
                                    980 ;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
      00876D C6 52 16         [ 1]  981 	ld	a, 0x5216
                                    982 ;	./libs/i2c_lib.c: 117: }
      008770 81               [ 4]  983 	ret
                                    984 ;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    985 ;	-----------------------------------------
                                    986 ;	 function i2c_read
                                    987 ;	-----------------------------------------
      008771                        988 _i2c_read:
      008771 52 04            [ 2]  989 	sub	sp, #4
                                    990 ;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      008773 4B 01            [ 1]  991 	push	#0x01
      008775 CD 87 39         [ 4]  992 	call	_i2c_send_address
      008778 4D               [ 1]  993 	tnz	a
      008779 27 3C            [ 1]  994 	jreq	00103$
                                    995 ;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      00877B 72 14 52 11      [ 1]  996 	bset	0x5211, #2
                                    997 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00877F 5F               [ 1]  998 	clrw	x
      008780 1F 03            [ 2]  999 	ldw	(0x03, sp), x
      008782                       1000 00105$:
      008782 5F               [ 1] 1001 	clrw	x
      008783 7B 07            [ 1] 1002 	ld	a, (0x07, sp)
      008785 97               [ 1] 1003 	ld	xl, a
      008786 5A               [ 2] 1004 	decw	x
      008787 1F 01            [ 2] 1005 	ldw	(0x01, sp), x
      008789 1E 03            [ 2] 1006 	ldw	x, (0x03, sp)
      00878B 13 01            [ 2] 1007 	cpw	x, (0x01, sp)
      00878D 2E 12            [ 1] 1008 	jrsge	00101$
                                   1009 ;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00878F 1E 08            [ 2] 1010 	ldw	x, (0x08, sp)
      008791 72 FB 03         [ 2] 1011 	addw	x, (0x03, sp)
      008794 89               [ 2] 1012 	pushw	x
      008795 CD 87 68         [ 4] 1013 	call	_i2c_read_byte
      008798 85               [ 2] 1014 	popw	x
      008799 F7               [ 1] 1015 	ld	(x), a
                                   1016 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00879A 1E 03            [ 2] 1017 	ldw	x, (0x03, sp)
      00879C 5C               [ 1] 1018 	incw	x
      00879D 1F 03            [ 2] 1019 	ldw	(0x03, sp), x
      00879F 20 E1            [ 2] 1020 	jra	00105$
      0087A1                       1021 00101$:
                                   1022 ;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      0087A1 C6 52 11         [ 1] 1023 	ld	a, 0x5211
      0087A4 A4 FB            [ 1] 1024 	and	a, #0xfb
      0087A6 C7 52 11         [ 1] 1025 	ld	0x5211, a
                                   1026 ;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
      0087A9 1E 08            [ 2] 1027 	ldw	x, (0x08, sp)
      0087AB 72 FB 01         [ 2] 1028 	addw	x, (0x01, sp)
      0087AE 89               [ 2] 1029 	pushw	x
      0087AF CD 87 68         [ 4] 1030 	call	_i2c_read_byte
      0087B2 85               [ 2] 1031 	popw	x
      0087B3 F7               [ 1] 1032 	ld	(x), a
                                   1033 ;	./libs/i2c_lib.c: 132: i2c_stop();
      0087B4 CD 87 34         [ 4] 1034 	call	_i2c_stop
      0087B7                       1035 00103$:
                                   1036 ;	./libs/i2c_lib.c: 135: i2c_stop();
      0087B7 1E 05            [ 2] 1037 	ldw	x, (5, sp)
      0087B9 1F 08            [ 2] 1038 	ldw	(8, sp), x
      0087BB 5B 07            [ 2] 1039 	addw	sp, #7
                                   1040 ;	./libs/i2c_lib.c: 137: }
      0087BD CC 87 34         [ 2] 1041 	jp	_i2c_stop
                                   1042 ;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
                                   1043 ;	-----------------------------------------
                                   1044 ;	 function i2c_send_byte
                                   1045 ;	-----------------------------------------
      0087C0                       1046 _i2c_send_byte:
                                   1047 ;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
      0087C0 C7 52 16         [ 1] 1048 	ld	0x5216, a
                                   1049 ;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
      0087C3                       1050 00103$:
      0087C3 72 0E 52 17 08   [ 2] 1051 	btjt	0x5217, #7, 00105$
                                   1052 ;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
      0087C8 72 05 52 18 F6   [ 2] 1053 	btjf	0x5218, #2, 00103$
                                   1054 ;	./libs/i2c_lib.c: 144: return 1;
      0087CD A6 01            [ 1] 1055 	ld	a, #0x01
      0087CF 81               [ 4] 1056 	ret
      0087D0                       1057 00105$:
                                   1058 ;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
      0087D0 4F               [ 1] 1059 	clr	a
                                   1060 ;	./libs/i2c_lib.c: 146: }
      0087D1 81               [ 4] 1061 	ret
                                   1062 ;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                   1063 ;	-----------------------------------------
                                   1064 ;	 function i2c_write
                                   1065 ;	-----------------------------------------
      0087D2                       1066 _i2c_write:
      0087D2 52 02            [ 2] 1067 	sub	sp, #2
                                   1068 ;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      0087D4 4B 00            [ 1] 1069 	push	#0x00
      0087D6 CD 87 39         [ 4] 1070 	call	_i2c_send_address
      0087D9 4D               [ 1] 1071 	tnz	a
      0087DA 27 1D            [ 1] 1072 	jreq	00105$
                                   1073 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      0087DC 5F               [ 1] 1074 	clrw	x
      0087DD                       1075 00107$:
      0087DD 7B 05            [ 1] 1076 	ld	a, (0x05, sp)
      0087DF 6B 02            [ 1] 1077 	ld	(0x02, sp), a
      0087E1 0F 01            [ 1] 1078 	clr	(0x01, sp)
      0087E3 13 01            [ 2] 1079 	cpw	x, (0x01, sp)
      0087E5 2E 12            [ 1] 1080 	jrsge	00105$
                                   1081 ;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      0087E7 90 93            [ 1] 1082 	ldw	y, x
      0087E9 72 F9 06         [ 2] 1083 	addw	y, (0x06, sp)
      0087EC 90 F6            [ 1] 1084 	ld	a, (y)
      0087EE 89               [ 2] 1085 	pushw	x
      0087EF CD 87 C0         [ 4] 1086 	call	_i2c_send_byte
      0087F2 85               [ 2] 1087 	popw	x
      0087F3 4D               [ 1] 1088 	tnz	a
      0087F4 26 03            [ 1] 1089 	jrne	00105$
                                   1090 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      0087F6 5C               [ 1] 1091 	incw	x
      0087F7 20 E4            [ 2] 1092 	jra	00107$
      0087F9                       1093 00105$:
                                   1094 ;	./libs/i2c_lib.c: 158: i2c_stop();
      0087F9 1E 03            [ 2] 1095 	ldw	x, (3, sp)
      0087FB 1F 06            [ 2] 1096 	ldw	(6, sp), x
      0087FD 5B 05            [ 2] 1097 	addw	sp, #5
                                   1098 ;	./libs/i2c_lib.c: 159: }
      0087FF CC 87 34         [ 2] 1099 	jp	_i2c_stop
                                   1100 ;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
                                   1101 ;	-----------------------------------------
                                   1102 ;	 function i2c_scan
                                   1103 ;	-----------------------------------------
      008802                       1104 _i2c_scan:
      008802 52 02            [ 2] 1105 	sub	sp, #2
                                   1106 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      008804 A6 01            [ 1] 1107 	ld	a, #0x01
      008806 6B 01            [ 1] 1108 	ld	(0x01, sp), a
      008808                       1109 00105$:
      008808 A1 7F            [ 1] 1110 	cp	a, #0x7f
      00880A 24 22            [ 1] 1111 	jrnc	00103$
                                   1112 ;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      00880C 88               [ 1] 1113 	push	a
      00880D 4B 00            [ 1] 1114 	push	#0x00
      00880F CD 87 39         [ 4] 1115 	call	_i2c_send_address
      008812 6B 03            [ 1] 1116 	ld	(0x03, sp), a
      008814 84               [ 1] 1117 	pop	a
      008815 0D 02            [ 1] 1118 	tnz	(0x02, sp)
      008817 27 07            [ 1] 1119 	jreq	00102$
                                   1120 ;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
      008819 CD 87 34         [ 4] 1121 	call	_i2c_stop
                                   1122 ;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
      00881C 7B 01            [ 1] 1123 	ld	a, (0x01, sp)
      00881E 20 12            [ 2] 1124 	jra	00107$
      008820                       1125 00102$:
                                   1126 ;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
      008820 AE 52 18         [ 2] 1127 	ldw	x, #0x5218
      008823 88               [ 1] 1128 	push	a
      008824 F6               [ 1] 1129 	ld	a, (x)
      008825 A4 FB            [ 1] 1130 	and	a, #0xfb
      008827 F7               [ 1] 1131 	ld	(x), a
      008828 84               [ 1] 1132 	pop	a
                                   1133 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      008829 4C               [ 1] 1134 	inc	a
      00882A 6B 01            [ 1] 1135 	ld	(0x01, sp), a
      00882C 20 DA            [ 2] 1136 	jra	00105$
      00882E                       1137 00103$:
                                   1138 ;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
      00882E CD 87 34         [ 4] 1139 	call	_i2c_stop
                                   1140 ;	./libs/i2c_lib.c: 173: return 0;
      008831 4F               [ 1] 1141 	clr	a
      008832                       1142 00107$:
                                   1143 ;	./libs/i2c_lib.c: 174: }
      008832 5B 02            [ 2] 1144 	addw	sp, #2
      008834 81               [ 4] 1145 	ret
                                   1146 ;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
                                   1147 ;	-----------------------------------------
                                   1148 ;	 function i2c_start_irq
                                   1149 ;	-----------------------------------------
      008835                       1150 _i2c_start_irq:
                                   1151 ;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      008835 72 12 52 1A      [ 1] 1152 	bset	0x521a, #1
                                   1153 ;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      008839 72 10 52 11      [ 1] 1154 	bset	0x5211, #0
                                   1155 ;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      00883D                       1156 00101$:
      00883D C6 52 1A         [ 1] 1157 	ld	a, 0x521a
      008840 A5 02            [ 1] 1158 	bcp	a, #2
      008842 26 F9            [ 1] 1159 	jrne	00101$
                                   1160 ;	./libs/i2c_lib.c: 182: }
      008844 81               [ 4] 1161 	ret
                                   1162 ;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
                                   1163 ;	-----------------------------------------
                                   1164 ;	 function i2c_stop_irq
                                   1165 ;	-----------------------------------------
      008845                       1166 _i2c_stop_irq:
                                   1167 ;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      008845 72 12 52 11      [ 1] 1168 	bset	0x5211, #1
                                   1169 ;	./libs/i2c_lib.c: 187: }
      008849 81               [ 4] 1170 	ret
                                   1171 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                   1172 ;	-----------------------------------------
                                   1173 ;	 function get_bit
                                   1174 ;	-----------------------------------------
      00884A                       1175 _get_bit:
                                   1176 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      00884A 7B 04            [ 1] 1177 	ld	a, (0x04, sp)
      00884C 27 04            [ 1] 1178 	jreq	00113$
      00884E                       1179 00112$:
      00884E 57               [ 2] 1180 	sraw	x
      00884F 4A               [ 1] 1181 	dec	a
      008850 26 FC            [ 1] 1182 	jrne	00112$
      008852                       1183 00113$:
      008852 54               [ 2] 1184 	srlw	x
      008853 24 03            [ 1] 1185 	jrnc	00103$
      008855 5F               [ 1] 1186 	clrw	x
      008856 5C               [ 1] 1187 	incw	x
      008857 21                    1188 	.byte 0x21
      008858                       1189 00103$:
      008858 5F               [ 1] 1190 	clrw	x
      008859                       1191 00104$:
                                   1192 ;	./libs/ssd1306_lib.c: 6: }
      008859 90 85            [ 2] 1193 	popw	y
      00885B 5B 02            [ 2] 1194 	addw	sp, #2
      00885D 90 FC            [ 2] 1195 	jp	(y)
                                   1196 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                   1197 ;	-----------------------------------------
                                   1198 ;	 function set_bit
                                   1199 ;	-----------------------------------------
      00885F                       1200 _set_bit:
      00885F 52 04            [ 2] 1201 	sub	sp, #4
      008861 1F 01            [ 2] 1202 	ldw	(0x01, sp), x
                                   1203 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      008863 5F               [ 1] 1204 	clrw	x
      008864 5C               [ 1] 1205 	incw	x
      008865 1F 03            [ 2] 1206 	ldw	(0x03, sp), x
      008867 7B 08            [ 1] 1207 	ld	a, (0x08, sp)
      008869 27 07            [ 1] 1208 	jreq	00114$
      00886B                       1209 00113$:
      00886B 08 04            [ 1] 1210 	sll	(0x04, sp)
      00886D 09 03            [ 1] 1211 	rlc	(0x03, sp)
      00886F 4A               [ 1] 1212 	dec	a
      008870 26 F9            [ 1] 1213 	jrne	00113$
      008872                       1214 00114$:
                                   1215 ;	./libs/ssd1306_lib.c: 10: switch(value)
      008872 1E 09            [ 2] 1216 	ldw	x, (0x09, sp)
      008874 5A               [ 2] 1217 	decw	x
      008875 26 0B            [ 1] 1218 	jrne	00102$
                                   1219 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      008877 7B 02            [ 1] 1220 	ld	a, (0x02, sp)
      008879 1A 04            [ 1] 1221 	or	a, (0x04, sp)
      00887B 97               [ 1] 1222 	ld	xl, a
      00887C 7B 01            [ 1] 1223 	ld	a, (0x01, sp)
      00887E 1A 03            [ 1] 1224 	or	a, (0x03, sp)
                                   1225 ;	./libs/ssd1306_lib.c: 14: break;
      008880 20 09            [ 2] 1226 	jra	00103$
                                   1227 ;	./libs/ssd1306_lib.c: 16: default:
      008882                       1228 00102$:
                                   1229 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      008882 1E 03            [ 2] 1230 	ldw	x, (0x03, sp)
      008884 53               [ 2] 1231 	cplw	x
      008885 9F               [ 1] 1232 	ld	a, xl
      008886 14 02            [ 1] 1233 	and	a, (0x02, sp)
      008888 02               [ 1] 1234 	rlwa	x
      008889 14 01            [ 1] 1235 	and	a, (0x01, sp)
                                   1236 ;	./libs/ssd1306_lib.c: 19: }
      00888B                       1237 00103$:
                                   1238 ;	./libs/ssd1306_lib.c: 20: return data;
      00888B 95               [ 1] 1239 	ld	xh, a
                                   1240 ;	./libs/ssd1306_lib.c: 21: }
      00888C 16 05            [ 2] 1241 	ldw	y, (5, sp)
      00888E 5B 0A            [ 2] 1242 	addw	sp, #10
      008890 90 FC            [ 2] 1243 	jp	(y)
                                   1244 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                   1245 ;	-----------------------------------------
                                   1246 ;	 function ssd1306_init
                                   1247 ;	-----------------------------------------
      008892                       1248 _ssd1306_init:
      008892 52 1B            [ 2] 1249 	sub	sp, #27
                                   1250 ;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
      008894 96               [ 1] 1251 	ldw	x, sp
      008895 5C               [ 1] 1252 	incw	x
      008896 7F               [ 1] 1253 	clr	(x)
      008897 A6 AE            [ 1] 1254 	ld	a, #0xae
      008899 6B 02            [ 1] 1255 	ld	(0x02, sp), a
      00889B A6 D5            [ 1] 1256 	ld	a, #0xd5
      00889D 6B 03            [ 1] 1257 	ld	(0x03, sp), a
      00889F A6 80            [ 1] 1258 	ld	a, #0x80
      0088A1 6B 04            [ 1] 1259 	ld	(0x04, sp), a
      0088A3 A6 A8            [ 1] 1260 	ld	a, #0xa8
      0088A5 6B 05            [ 1] 1261 	ld	(0x05, sp), a
      0088A7 A6 1F            [ 1] 1262 	ld	a, #0x1f
      0088A9 6B 06            [ 1] 1263 	ld	(0x06, sp), a
      0088AB A6 D3            [ 1] 1264 	ld	a, #0xd3
      0088AD 6B 07            [ 1] 1265 	ld	(0x07, sp), a
      0088AF 0F 08            [ 1] 1266 	clr	(0x08, sp)
      0088B1 A6 40            [ 1] 1267 	ld	a, #0x40
      0088B3 6B 09            [ 1] 1268 	ld	(0x09, sp), a
      0088B5 A6 8D            [ 1] 1269 	ld	a, #0x8d
      0088B7 6B 0A            [ 1] 1270 	ld	(0x0a, sp), a
      0088B9 A6 14            [ 1] 1271 	ld	a, #0x14
      0088BB 6B 0B            [ 1] 1272 	ld	(0x0b, sp), a
      0088BD A6 DB            [ 1] 1273 	ld	a, #0xdb
      0088BF 6B 0C            [ 1] 1274 	ld	(0x0c, sp), a
      0088C1 A6 40            [ 1] 1275 	ld	a, #0x40
      0088C3 6B 0D            [ 1] 1276 	ld	(0x0d, sp), a
      0088C5 A6 A4            [ 1] 1277 	ld	a, #0xa4
      0088C7 6B 0E            [ 1] 1278 	ld	(0x0e, sp), a
      0088C9 A6 A6            [ 1] 1279 	ld	a, #0xa6
      0088CB 6B 0F            [ 1] 1280 	ld	(0x0f, sp), a
      0088CD A6 DA            [ 1] 1281 	ld	a, #0xda
      0088CF 6B 10            [ 1] 1282 	ld	(0x10, sp), a
      0088D1 A6 02            [ 1] 1283 	ld	a, #0x02
      0088D3 6B 11            [ 1] 1284 	ld	(0x11, sp), a
      0088D5 A6 81            [ 1] 1285 	ld	a, #0x81
      0088D7 6B 12            [ 1] 1286 	ld	(0x12, sp), a
      0088D9 A6 8F            [ 1] 1287 	ld	a, #0x8f
      0088DB 6B 13            [ 1] 1288 	ld	(0x13, sp), a
      0088DD A6 D9            [ 1] 1289 	ld	a, #0xd9
      0088DF 6B 14            [ 1] 1290 	ld	(0x14, sp), a
      0088E1 A6 F1            [ 1] 1291 	ld	a, #0xf1
      0088E3 6B 15            [ 1] 1292 	ld	(0x15, sp), a
      0088E5 A6 20            [ 1] 1293 	ld	a, #0x20
      0088E7 6B 16            [ 1] 1294 	ld	(0x16, sp), a
      0088E9 0F 17            [ 1] 1295 	clr	(0x17, sp)
      0088EB A6 A0            [ 1] 1296 	ld	a, #0xa0
      0088ED 6B 18            [ 1] 1297 	ld	(0x18, sp), a
      0088EF A6 C0            [ 1] 1298 	ld	a, #0xc0
      0088F1 6B 19            [ 1] 1299 	ld	(0x19, sp), a
      0088F3 A6 1F            [ 1] 1300 	ld	a, #0x1f
      0088F5 6B 1A            [ 1] 1301 	ld	(0x1a, sp), a
      0088F7 A6 AF            [ 1] 1302 	ld	a, #0xaf
      0088F9 6B 1B            [ 1] 1303 	ld	(0x1b, sp), a
                                   1304 ;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
      0088FB 89               [ 2] 1305 	pushw	x
      0088FC 4B 1B            [ 1] 1306 	push	#0x1b
      0088FE A6 3C            [ 1] 1307 	ld	a, #0x3c
      008900 CD 87 D2         [ 4] 1308 	call	_i2c_write
                                   1309 ;	./libs/ssd1306_lib.c: 43: }
      008903 5B 1B            [ 2] 1310 	addw	sp, #27
      008905 81               [ 4] 1311 	ret
                                   1312 ;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
                                   1313 ;	-----------------------------------------
                                   1314 ;	 function ssd1306_set_params_to_write
                                   1315 ;	-----------------------------------------
      008906                       1316 _ssd1306_set_params_to_write:
      008906 52 07            [ 2] 1317 	sub	sp, #7
                                   1318 ;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
      008908 96               [ 1] 1319 	ldw	x, sp
      008909 5C               [ 1] 1320 	incw	x
      00890A 7F               [ 1] 1321 	clr	(x)
      00890B A6 22            [ 1] 1322 	ld	a, #0x22
      00890D 6B 02            [ 1] 1323 	ld	(0x02, sp), a
      00890F 0F 03            [ 1] 1324 	clr	(0x03, sp)
      008911 A6 03            [ 1] 1325 	ld	a, #0x03
      008913 6B 04            [ 1] 1326 	ld	(0x04, sp), a
      008915 A6 21            [ 1] 1327 	ld	a, #0x21
      008917 6B 05            [ 1] 1328 	ld	(0x05, sp), a
      008919 0F 06            [ 1] 1329 	clr	(0x06, sp)
      00891B A6 7F            [ 1] 1330 	ld	a, #0x7f
      00891D 6B 07            [ 1] 1331 	ld	(0x07, sp), a
                                   1332 ;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      00891F 89               [ 2] 1333 	pushw	x
      008920 4B 07            [ 1] 1334 	push	#0x07
      008922 A6 3C            [ 1] 1335 	ld	a, #0x3c
      008924 CD 87 D2         [ 4] 1336 	call	_i2c_write
                                   1337 ;	./libs/ssd1306_lib.c: 52: }
      008927 5B 07            [ 2] 1338 	addw	sp, #7
      008929 81               [ 4] 1339 	ret
                                   1340 ;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1341 ;	-----------------------------------------
                                   1342 ;	 function ssd1306_draw_pixel
                                   1343 ;	-----------------------------------------
      00892A                       1344 _ssd1306_draw_pixel:
      00892A 52 08            [ 2] 1345 	sub	sp, #8
      00892C 1F 07            [ 2] 1346 	ldw	(0x07, sp), x
                                   1347 ;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      00892E 6B 06            [ 1] 1348 	ld	(0x06, sp), a
      008930 0F 05            [ 1] 1349 	clr	(0x05, sp)
      008932 7B 0B            [ 1] 1350 	ld	a, (0x0b, sp)
      008934 0F 01            [ 1] 1351 	clr	(0x01, sp)
      008936 97               [ 1] 1352 	ld	xl, a
      008937 02               [ 1] 1353 	rlwa	x
      008938 4F               [ 1] 1354 	clr	a
      008939 01               [ 1] 1355 	rrwa	x
      00893A 5D               [ 2] 1356 	tnzw	x
      00893B 2A 03            [ 1] 1357 	jrpl	00103$
      00893D 1C 00 07         [ 2] 1358 	addw	x, #0x0007
      008940                       1359 00103$:
      008940 57               [ 2] 1360 	sraw	x
      008941 57               [ 2] 1361 	sraw	x
      008942 57               [ 2] 1362 	sraw	x
      008943 58               [ 2] 1363 	sllw	x
      008944 58               [ 2] 1364 	sllw	x
      008945 58               [ 2] 1365 	sllw	x
      008946 58               [ 2] 1366 	sllw	x
      008947 58               [ 2] 1367 	sllw	x
      008948 58               [ 2] 1368 	sllw	x
      008949 58               [ 2] 1369 	sllw	x
      00894A 72 FB 05         [ 2] 1370 	addw	x, (0x05, sp)
      00894D 72 FB 07         [ 2] 1371 	addw	x, (0x07, sp)
      008950 1F 03            [ 2] 1372 	ldw	(0x03, sp), x
      008952 90 5F            [ 1] 1373 	clrw	y
      008954 61               [ 1] 1374 	exg	a, yl
      008955 7B 0C            [ 1] 1375 	ld	a, (0x0c, sp)
      008957 61               [ 1] 1376 	exg	a, yl
      008958 A4 07            [ 1] 1377 	and	a, #0x07
      00895A 6B 06            [ 1] 1378 	ld	(0x06, sp), a
      00895C 0F 05            [ 1] 1379 	clr	(0x05, sp)
      00895E 1E 03            [ 2] 1380 	ldw	x, (0x03, sp)
      008960 F6               [ 1] 1381 	ld	a, (x)
      008961 5F               [ 1] 1382 	clrw	x
      008962 90 89            [ 2] 1383 	pushw	y
      008964 16 07            [ 2] 1384 	ldw	y, (0x07, sp)
      008966 90 89            [ 2] 1385 	pushw	y
      008968 97               [ 1] 1386 	ld	xl, a
      008969 CD 88 5F         [ 4] 1387 	call	_set_bit
      00896C 9F               [ 1] 1388 	ld	a, xl
      00896D 1E 03            [ 2] 1389 	ldw	x, (0x03, sp)
      00896F F7               [ 1] 1390 	ld	(x), a
                                   1391 ;	./libs/ssd1306_lib.c: 57: }
      008970 1E 09            [ 2] 1392 	ldw	x, (9, sp)
      008972 5B 0C            [ 2] 1393 	addw	sp, #12
      008974 FC               [ 2] 1394 	jp	(x)
                                   1395 ;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
                                   1396 ;	-----------------------------------------
                                   1397 ;	 function ssd1306_buffer_clean
                                   1398 ;	-----------------------------------------
      008975                       1399 _ssd1306_buffer_clean:
                                   1400 ;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
      008975 4B 00            [ 1] 1401 	push	#0x00
      008977 4B 02            [ 1] 1402 	push	#0x02
      008979 5F               [ 1] 1403 	clrw	x
      00897A 89               [ 2] 1404 	pushw	x
      00897B AE 01 8C         [ 2] 1405 	ldw	x, #(_main_buffer+0)
      00897E CD 92 F1         [ 4] 1406 	call	_memset
                                   1407 ;	./libs/ssd1306_lib.c: 62: }
      008981 81               [ 4] 1408 	ret
                                   1409 ;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
                                   1410 ;	-----------------------------------------
                                   1411 ;	 function ssd1306_send_buffer
                                   1412 ;	-----------------------------------------
      008982                       1413 _ssd1306_send_buffer:
      008982 52 04            [ 2] 1414 	sub	sp, #4
                                   1415 ;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
      008984 CD 89 06         [ 4] 1416 	call	_ssd1306_set_params_to_write
                                   1417 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008987 5F               [ 1] 1418 	clrw	x
      008988 1F 03            [ 2] 1419 	ldw	(0x03, sp), x
      00898A                       1420 00112$:
      00898A 1E 03            [ 2] 1421 	ldw	x, (0x03, sp)
      00898C A3 00 04         [ 2] 1422 	cpw	x, #0x0004
      00898F 2E 43            [ 1] 1423 	jrsge	00114$
                                   1424 ;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
      008991 4B 00            [ 1] 1425 	push	#0x00
      008993 A6 3C            [ 1] 1426 	ld	a, #0x3c
      008995 CD 87 39         [ 4] 1427 	call	_i2c_send_address
      008998 4D               [ 1] 1428 	tnz	a
      008999 27 2F            [ 1] 1429 	jreq	00105$
                                   1430 ;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
      00899B A6 40            [ 1] 1431 	ld	a, #0x40
      00899D CD 87 C0         [ 4] 1432 	call	_i2c_send_byte
                                   1433 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      0089A0 1E 03            [ 2] 1434 	ldw	x, (0x03, sp)
      0089A2 58               [ 2] 1435 	sllw	x
      0089A3 58               [ 2] 1436 	sllw	x
      0089A4 58               [ 2] 1437 	sllw	x
      0089A5 58               [ 2] 1438 	sllw	x
      0089A6 58               [ 2] 1439 	sllw	x
      0089A7 58               [ 2] 1440 	sllw	x
      0089A8 58               [ 2] 1441 	sllw	x
      0089A9 1F 01            [ 2] 1442 	ldw	(0x01, sp), x
      0089AB 5F               [ 1] 1443 	clrw	x
      0089AC                       1444 00109$:
      0089AC A3 00 80         [ 2] 1445 	cpw	x, #0x0080
      0089AF 2E 14            [ 1] 1446 	jrsge	00103$
                                   1447 ;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i+(128*j)]))//Проверка на АСК бит
      0089B1 90 93            [ 1] 1448 	ldw	y, x
      0089B3 72 F9 01         [ 2] 1449 	addw	y, (0x01, sp)
      0089B6 90 D6 01 8C      [ 1] 1450 	ld	a, (_main_buffer+0, y)
      0089BA 89               [ 2] 1451 	pushw	x
      0089BB CD 87 C0         [ 4] 1452 	call	_i2c_send_byte
      0089BE 85               [ 2] 1453 	popw	x
      0089BF 4D               [ 1] 1454 	tnz	a
      0089C0 26 03            [ 1] 1455 	jrne	00103$
                                   1456 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      0089C2 5C               [ 1] 1457 	incw	x
      0089C3 20 E7            [ 2] 1458 	jra	00109$
      0089C5                       1459 00103$:
                                   1460 ;	./libs/ssd1306_lib.c: 78: i2c_stop();
      0089C5 CD 87 34         [ 4] 1461 	call	_i2c_stop
      0089C8 20 03            [ 2] 1462 	jra	00113$
      0089CA                       1463 00105$:
                                   1464 ;	./libs/ssd1306_lib.c: 81: i2c_stop();
      0089CA CD 87 34         [ 4] 1465 	call	_i2c_stop
      0089CD                       1466 00113$:
                                   1467 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      0089CD 1E 03            [ 2] 1468 	ldw	x, (0x03, sp)
      0089CF 5C               [ 1] 1469 	incw	x
      0089D0 1F 03            [ 2] 1470 	ldw	(0x03, sp), x
      0089D2 20 B6            [ 2] 1471 	jra	00112$
      0089D4                       1472 00114$:
                                   1473 ;	./libs/ssd1306_lib.c: 83: }
      0089D4 5B 04            [ 2] 1474 	addw	sp, #4
      0089D6 81               [ 4] 1475 	ret
                                   1476 ;	./libs/ssd1306_lib.c: 85: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
                                   1477 ;	-----------------------------------------
                                   1478 ;	 function ssd1306_buffer_write
                                   1479 ;	-----------------------------------------
      0089D7                       1480 _ssd1306_buffer_write:
      0089D7 52 0D            [ 2] 1481 	sub	sp, #13
      0089D9 1F 08            [ 2] 1482 	ldw	(0x08, sp), x
                                   1483 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      0089DB 5F               [ 1] 1484 	clrw	x
      0089DC 1F 0A            [ 2] 1485 	ldw	(0x0a, sp), x
      0089DE                       1486 00109$:
      0089DE 1E 0A            [ 2] 1487 	ldw	x, (0x0a, sp)
      0089E0 A3 00 08         [ 2] 1488 	cpw	x, #0x0008
      0089E3 2F 03            [ 1] 1489 	jrslt	00150$
      0089E5 CC 8A 67         [ 2] 1490 	jp	00111$
      0089E8                       1491 00150$:
                                   1492 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      0089E8 1E 12            [ 2] 1493 	ldw	x, (0x12, sp)
      0089EA 72 FB 0A         [ 2] 1494 	addw	x, (0x0a, sp)
      0089ED 1F 05            [ 2] 1495 	ldw	(0x05, sp), x
      0089EF 5F               [ 1] 1496 	clrw	x
      0089F0 1F 0C            [ 2] 1497 	ldw	(0x0c, sp), x
      0089F2                       1498 00106$:
      0089F2 1E 0C            [ 2] 1499 	ldw	x, (0x0c, sp)
      0089F4 A3 00 08         [ 2] 1500 	cpw	x, #0x0008
      0089F7 2E 66            [ 1] 1501 	jrsge	00110$
                                   1502 ;	./libs/ssd1306_lib.c: 90: if(data[height + width / 8] & (128 >> (width & 7)))
      0089F9 1E 0A            [ 2] 1503 	ldw	x, (0x0a, sp)
      0089FB 72 FB 12         [ 2] 1504 	addw	x, (0x12, sp)
      0089FE F6               [ 1] 1505 	ld	a, (x)
      0089FF 6B 07            [ 1] 1506 	ld	(0x07, sp), a
      008A01 7B 0D            [ 1] 1507 	ld	a, (0x0d, sp)
      008A03 A4 07            [ 1] 1508 	and	a, #0x07
      008A05 AE 00 80         [ 2] 1509 	ldw	x, #0x0080
      008A08 4D               [ 1] 1510 	tnz	a
      008A09 27 04            [ 1] 1511 	jreq	00153$
      008A0B                       1512 00152$:
      008A0B 57               [ 2] 1513 	sraw	x
      008A0C 4A               [ 1] 1514 	dec	a
      008A0D 26 FC            [ 1] 1515 	jrne	00152$
      008A0F                       1516 00153$:
      008A0F 1F 01            [ 2] 1517 	ldw	(0x01, sp), x
      008A11 7B 07            [ 1] 1518 	ld	a, (0x07, sp)
      008A13 14 02            [ 1] 1519 	and	a, (0x02, sp)
      008A15 6B 04            [ 1] 1520 	ld	(0x04, sp), a
      008A17 0F 03            [ 1] 1521 	clr	(0x03, sp)
      008A19 1E 03            [ 2] 1522 	ldw	x, (0x03, sp)
      008A1B 27 3B            [ 1] 1523 	jreq	00107$
                                   1524 ;	./libs/ssd1306_lib.c: 91: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(data[height], 7 - (width % 8)));
      008A1D 4B 08            [ 1] 1525 	push	#0x08
      008A1F 4B 00            [ 1] 1526 	push	#0x00
      008A21 1E 0E            [ 2] 1527 	ldw	x, (0x0e, sp)
      008A23 CD 93 15         [ 4] 1528 	call	__modsint
      008A26 1F 03            [ 2] 1529 	ldw	(0x03, sp), x
      008A28 90 AE 00 07      [ 2] 1530 	ldw	y, #0x0007
      008A2C 72 F2 03         [ 2] 1531 	subw	y, (0x03, sp)
      008A2F 1E 05            [ 2] 1532 	ldw	x, (0x05, sp)
      008A31 F6               [ 1] 1533 	ld	a, (x)
      008A32 5F               [ 1] 1534 	clrw	x
      008A33 90 89            [ 2] 1535 	pushw	y
      008A35 97               [ 1] 1536 	ld	xl, a
      008A36 CD 88 4A         [ 4] 1537 	call	_get_bit
      008A39 7B 11            [ 1] 1538 	ld	a, (0x11, sp)
      008A3B 6B 07            [ 1] 1539 	ld	(0x07, sp), a
      008A3D 7B 0B            [ 1] 1540 	ld	a, (0x0b, sp)
      008A3F 1B 07            [ 1] 1541 	add	a, (0x07, sp)
      008A41 95               [ 1] 1542 	ld	xh, a
      008A42 7B 09            [ 1] 1543 	ld	a, (0x09, sp)
      008A44 6B 07            [ 1] 1544 	ld	(0x07, sp), a
      008A46 7B 0D            [ 1] 1545 	ld	a, (0x0d, sp)
      008A48 1B 07            [ 1] 1546 	add	a, (0x07, sp)
      008A4A 6B 07            [ 1] 1547 	ld	(0x07, sp), a
      008A4C 9F               [ 1] 1548 	ld	a, xl
      008A4D 88               [ 1] 1549 	push	a
      008A4E 9E               [ 1] 1550 	ld	a, xh
      008A4F 88               [ 1] 1551 	push	a
      008A50 7B 09            [ 1] 1552 	ld	a, (0x09, sp)
      008A52 AE 01 8C         [ 2] 1553 	ldw	x, #(_main_buffer+0)
      008A55 CD 89 2A         [ 4] 1554 	call	_ssd1306_draw_pixel
      008A58                       1555 00107$:
                                   1556 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      008A58 1E 0C            [ 2] 1557 	ldw	x, (0x0c, sp)
      008A5A 5C               [ 1] 1558 	incw	x
      008A5B 1F 0C            [ 2] 1559 	ldw	(0x0c, sp), x
      008A5D 20 93            [ 2] 1560 	jra	00106$
      008A5F                       1561 00110$:
                                   1562 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      008A5F 1E 0A            [ 2] 1563 	ldw	x, (0x0a, sp)
      008A61 5C               [ 1] 1564 	incw	x
      008A62 1F 0A            [ 2] 1565 	ldw	(0x0a, sp), x
      008A64 CC 89 DE         [ 2] 1566 	jp	00109$
      008A67                       1567 00111$:
                                   1568 ;	./libs/ssd1306_lib.c: 93: }
      008A67 1E 0E            [ 2] 1569 	ldw	x, (14, sp)
      008A69 5B 13            [ 2] 1570 	addw	sp, #19
      008A6B FC               [ 2] 1571 	jp	(x)
                                   1572 ;	./libs/ssd1306_lib.c: 95: void ssd1306_clean(void)
                                   1573 ;	-----------------------------------------
                                   1574 ;	 function ssd1306_clean
                                   1575 ;	-----------------------------------------
      008A6C                       1576 _ssd1306_clean:
                                   1577 ;	./libs/ssd1306_lib.c: 97: ssd1306_buffer_clean();
      008A6C CD 89 75         [ 4] 1578 	call	_ssd1306_buffer_clean
                                   1579 ;	./libs/ssd1306_lib.c: 98: ssd1306_send_buffer();
                                   1580 ;	./libs/ssd1306_lib.c: 99: }
      008A6F CC 89 82         [ 2] 1581 	jp	_ssd1306_send_buffer
                                   1582 ;	./libs/menu_lib.c: 3: void menu_border(void)
                                   1583 ;	-----------------------------------------
                                   1584 ;	 function menu_border
                                   1585 ;	-----------------------------------------
      008A72                       1586 _menu_border:
      008A72 52 04            [ 2] 1587 	sub	sp, #4
                                   1588 ;	./libs/menu_lib.c: 6: ssd1306_buffer_write(0,0,ttf_corner_left_up);
      008A74 4B 4C            [ 1] 1589 	push	#<(_ttf_corner_left_up+0)
      008A76 4B 01            [ 1] 1590 	push	#((_ttf_corner_left_up+0) >> 8)
      008A78 5F               [ 1] 1591 	clrw	x
      008A79 89               [ 2] 1592 	pushw	x
      008A7A 5F               [ 1] 1593 	clrw	x
      008A7B CD 89 D7         [ 4] 1594 	call	_ssd1306_buffer_write
                                   1595 ;	./libs/menu_lib.c: 7: for(int x = 1;x<15;x++)
      008A7E 5F               [ 1] 1596 	clrw	x
      008A7F 5C               [ 1] 1597 	incw	x
      008A80 1F 03            [ 2] 1598 	ldw	(0x03, sp), x
      008A82                       1599 00104$:
      008A82 1E 03            [ 2] 1600 	ldw	x, (0x03, sp)
      008A84 A3 00 0F         [ 2] 1601 	cpw	x, #0x000f
      008A87 2E 19            [ 1] 1602 	jrsge	00101$
                                   1603 ;	./libs/menu_lib.c: 8: ssd1306_buffer_write(x*8,0,ttf_line_up);
      008A89 1E 03            [ 2] 1604 	ldw	x, (0x03, sp)
      008A8B 58               [ 2] 1605 	sllw	x
      008A8C 58               [ 2] 1606 	sllw	x
      008A8D 58               [ 2] 1607 	sllw	x
      008A8E 1F 01            [ 2] 1608 	ldw	(0x01, sp), x
      008A90 4B 7C            [ 1] 1609 	push	#<(_ttf_line_up+0)
      008A92 4B 01            [ 1] 1610 	push	#((_ttf_line_up+0) >> 8)
      008A94 5F               [ 1] 1611 	clrw	x
      008A95 89               [ 2] 1612 	pushw	x
      008A96 1E 05            [ 2] 1613 	ldw	x, (0x05, sp)
      008A98 CD 89 D7         [ 4] 1614 	call	_ssd1306_buffer_write
                                   1615 ;	./libs/menu_lib.c: 7: for(int x = 1;x<15;x++)
      008A9B 1E 03            [ 2] 1616 	ldw	x, (0x03, sp)
      008A9D 5C               [ 1] 1617 	incw	x
      008A9E 1F 03            [ 2] 1618 	ldw	(0x03, sp), x
      008AA0 20 E0            [ 2] 1619 	jra	00104$
      008AA2                       1620 00101$:
                                   1621 ;	./libs/menu_lib.c: 9: ssd1306_buffer_write(120,0,ttf_corner_right_up);
      008AA2 4B 54            [ 1] 1622 	push	#<(_ttf_corner_right_up+0)
      008AA4 4B 01            [ 1] 1623 	push	#((_ttf_corner_right_up+0) >> 8)
      008AA6 5F               [ 1] 1624 	clrw	x
      008AA7 89               [ 2] 1625 	pushw	x
      008AA8 AE 00 78         [ 2] 1626 	ldw	x, #0x0078
      008AAB CD 89 D7         [ 4] 1627 	call	_ssd1306_buffer_write
                                   1628 ;	./libs/menu_lib.c: 11: ssd1306_buffer_write(0,8,ttf_line_left);
      008AAE 4B 74            [ 1] 1629 	push	#<(_ttf_line_left+0)
      008AB0 4B 01            [ 1] 1630 	push	#((_ttf_line_left+0) >> 8)
      008AB2 4B 08            [ 1] 1631 	push	#0x08
      008AB4 4B 00            [ 1] 1632 	push	#0x00
      008AB6 5F               [ 1] 1633 	clrw	x
      008AB7 CD 89 D7         [ 4] 1634 	call	_ssd1306_buffer_write
                                   1635 ;	./libs/menu_lib.c: 12: ssd1306_buffer_write(0,16,ttf_line_left);
      008ABA 4B 74            [ 1] 1636 	push	#<(_ttf_line_left+0)
      008ABC 4B 01            [ 1] 1637 	push	#((_ttf_line_left+0) >> 8)
      008ABE 4B 10            [ 1] 1638 	push	#0x10
      008AC0 4B 00            [ 1] 1639 	push	#0x00
      008AC2 5F               [ 1] 1640 	clrw	x
      008AC3 CD 89 D7         [ 4] 1641 	call	_ssd1306_buffer_write
                                   1642 ;	./libs/menu_lib.c: 14: ssd1306_buffer_write(120,8,ttf_line_right);
      008AC6 4B 6C            [ 1] 1643 	push	#<(_ttf_line_right+0)
      008AC8 4B 01            [ 1] 1644 	push	#((_ttf_line_right+0) >> 8)
      008ACA 4B 08            [ 1] 1645 	push	#0x08
      008ACC 4B 00            [ 1] 1646 	push	#0x00
      008ACE AE 00 78         [ 2] 1647 	ldw	x, #0x0078
      008AD1 CD 89 D7         [ 4] 1648 	call	_ssd1306_buffer_write
                                   1649 ;	./libs/menu_lib.c: 15: ssd1306_buffer_write(120,16,ttf_line_right);
      008AD4 4B 6C            [ 1] 1650 	push	#<(_ttf_line_right+0)
      008AD6 4B 01            [ 1] 1651 	push	#((_ttf_line_right+0) >> 8)
      008AD8 4B 10            [ 1] 1652 	push	#0x10
      008ADA 4B 00            [ 1] 1653 	push	#0x00
      008ADC AE 00 78         [ 2] 1654 	ldw	x, #0x0078
      008ADF CD 89 D7         [ 4] 1655 	call	_ssd1306_buffer_write
                                   1656 ;	./libs/menu_lib.c: 17: ssd1306_buffer_write(0,24,ttf_corner_left_down);
      008AE2 4B 5C            [ 1] 1657 	push	#<(_ttf_corner_left_down+0)
      008AE4 4B 01            [ 1] 1658 	push	#((_ttf_corner_left_down+0) >> 8)
      008AE6 4B 18            [ 1] 1659 	push	#0x18
      008AE8 4B 00            [ 1] 1660 	push	#0x00
      008AEA 5F               [ 1] 1661 	clrw	x
      008AEB CD 89 D7         [ 4] 1662 	call	_ssd1306_buffer_write
                                   1663 ;	./libs/menu_lib.c: 18: for(int x = 1;x<15;x++)
      008AEE 5F               [ 1] 1664 	clrw	x
      008AEF 5C               [ 1] 1665 	incw	x
      008AF0                       1666 00107$:
      008AF0 A3 00 0F         [ 2] 1667 	cpw	x, #0x000f
      008AF3 2E 19            [ 1] 1668 	jrsge	00102$
                                   1669 ;	./libs/menu_lib.c: 19: ssd1306_buffer_write(x*8,24,ttf_line_down);
      008AF5 90 93            [ 1] 1670 	ldw	y, x
      008AF7 90 58            [ 2] 1671 	sllw	y
      008AF9 90 58            [ 2] 1672 	sllw	y
      008AFB 90 58            [ 2] 1673 	sllw	y
      008AFD 89               [ 2] 1674 	pushw	x
      008AFE 4B 84            [ 1] 1675 	push	#<(_ttf_line_down+0)
      008B00 4B 01            [ 1] 1676 	push	#((_ttf_line_down+0) >> 8)
      008B02 4B 18            [ 1] 1677 	push	#0x18
      008B04 4B 00            [ 1] 1678 	push	#0x00
      008B06 93               [ 1] 1679 	ldw	x, y
      008B07 CD 89 D7         [ 4] 1680 	call	_ssd1306_buffer_write
      008B0A 85               [ 2] 1681 	popw	x
                                   1682 ;	./libs/menu_lib.c: 18: for(int x = 1;x<15;x++)
      008B0B 5C               [ 1] 1683 	incw	x
      008B0C 20 E2            [ 2] 1684 	jra	00107$
      008B0E                       1685 00102$:
                                   1686 ;	./libs/menu_lib.c: 20: ssd1306_buffer_write(120,24,ttf_corner_right_down);
      008B0E 4B 64            [ 1] 1687 	push	#<(_ttf_corner_right_down+0)
      008B10 4B 01            [ 1] 1688 	push	#((_ttf_corner_right_down+0) >> 8)
      008B12 4B 18            [ 1] 1689 	push	#0x18
      008B14 4B 00            [ 1] 1690 	push	#0x00
      008B16 AE 00 78         [ 2] 1691 	ldw	x, #0x0078
      008B19 CD 89 D7         [ 4] 1692 	call	_ssd1306_buffer_write
                                   1693 ;	./libs/menu_lib.c: 21: }
      008B1C 5B 04            [ 2] 1694 	addw	sp, #4
      008B1E 81               [ 4] 1695 	ret
                                   1696 ;	./libs/menu_lib.c: 23: void menu_border_paragraph(uint8_t number_of_letters)
                                   1697 ;	-----------------------------------------
                                   1698 ;	 function menu_border_paragraph
                                   1699 ;	-----------------------------------------
      008B1F                       1700 _menu_border_paragraph:
      008B1F 52 07            [ 2] 1701 	sub	sp, #7
      008B21 6B 07            [ 1] 1702 	ld	(0x07, sp), a
                                   1703 ;	./libs/menu_lib.c: 26: ssd1306_buffer_write(6,8,ttf_corner_left_up);
      008B23 4B 4C            [ 1] 1704 	push	#<(_ttf_corner_left_up+0)
      008B25 4B 01            [ 1] 1705 	push	#((_ttf_corner_left_up+0) >> 8)
      008B27 4B 08            [ 1] 1706 	push	#0x08
      008B29 4B 00            [ 1] 1707 	push	#0x00
      008B2B AE 00 06         [ 2] 1708 	ldw	x, #0x0006
      008B2E CD 89 D7         [ 4] 1709 	call	_ssd1306_buffer_write
                                   1710 ;	./libs/menu_lib.c: 27: ssd1306_buffer_write(6,16,ttf_corner_left_down);
      008B31 4B 5C            [ 1] 1711 	push	#<(_ttf_corner_left_down+0)
      008B33 4B 01            [ 1] 1712 	push	#((_ttf_corner_left_down+0) >> 8)
      008B35 4B 10            [ 1] 1713 	push	#0x10
      008B37 4B 00            [ 1] 1714 	push	#0x00
      008B39 AE 00 06         [ 2] 1715 	ldw	x, #0x0006
      008B3C CD 89 D7         [ 4] 1716 	call	_ssd1306_buffer_write
                                   1717 ;	./libs/menu_lib.c: 28: for(int x = 1;x<number_of_letters+1;x++)
      008B3F 5F               [ 1] 1718 	clrw	x
      008B40 5C               [ 1] 1719 	incw	x
      008B41 1F 05            [ 2] 1720 	ldw	(0x05, sp), x
      008B43                       1721 00104$:
      008B43 90 5F            [ 1] 1722 	clrw	y
      008B45 7B 07            [ 1] 1723 	ld	a, (0x07, sp)
      008B47 90 97            [ 1] 1724 	ld	yl, a
      008B49 93               [ 1] 1725 	ldw	x, y
      008B4A 5C               [ 1] 1726 	incw	x
      008B4B 1F 01            [ 2] 1727 	ldw	(0x01, sp), x
      008B4D 1E 05            [ 2] 1728 	ldw	x, (0x05, sp)
      008B4F 13 01            [ 2] 1729 	cpw	x, (0x01, sp)
      008B51 2E 20            [ 1] 1730 	jrsge	00101$
                                   1731 ;	./libs/menu_lib.c: 29: ssd1306_buffer_write(6+x*8,8,ttf_line_up);
      008B53 1E 05            [ 2] 1732 	ldw	x, (0x05, sp)
      008B55 58               [ 2] 1733 	sllw	x
      008B56 58               [ 2] 1734 	sllw	x
      008B57 58               [ 2] 1735 	sllw	x
      008B58 1F 01            [ 2] 1736 	ldw	(0x01, sp), x
      008B5A 1C 00 06         [ 2] 1737 	addw	x, #0x0006
      008B5D 1F 03            [ 2] 1738 	ldw	(0x03, sp), x
      008B5F 4B 7C            [ 1] 1739 	push	#<(_ttf_line_up+0)
      008B61 4B 01            [ 1] 1740 	push	#((_ttf_line_up+0) >> 8)
      008B63 4B 08            [ 1] 1741 	push	#0x08
      008B65 4B 00            [ 1] 1742 	push	#0x00
      008B67 1E 07            [ 2] 1743 	ldw	x, (0x07, sp)
      008B69 CD 89 D7         [ 4] 1744 	call	_ssd1306_buffer_write
                                   1745 ;	./libs/menu_lib.c: 28: for(int x = 1;x<number_of_letters+1;x++)
      008B6C 1E 05            [ 2] 1746 	ldw	x, (0x05, sp)
      008B6E 5C               [ 1] 1747 	incw	x
      008B6F 1F 05            [ 2] 1748 	ldw	(0x05, sp), x
      008B71 20 D0            [ 2] 1749 	jra	00104$
      008B73                       1750 00101$:
                                   1751 ;	./libs/menu_lib.c: 30: ssd1306_buffer_write(6+number_of_letters*8,8,ttf_corner_right_up);
      008B73 93               [ 1] 1752 	ldw	x, y
      008B74 58               [ 2] 1753 	sllw	x
      008B75 58               [ 2] 1754 	sllw	x
      008B76 58               [ 2] 1755 	sllw	x
      008B77 9F               [ 1] 1756 	ld	a, xl
      008B78 AB 06            [ 1] 1757 	add	a, #0x06
      008B7A 6B 04            [ 1] 1758 	ld	(0x04, sp), a
      008B7C 9E               [ 1] 1759 	ld	a, xh
      008B7D A9 00            [ 1] 1760 	adc	a, #0x00
      008B7F 6B 03            [ 1] 1761 	ld	(0x03, sp), a
      008B81 89               [ 2] 1762 	pushw	x
      008B82 4B 54            [ 1] 1763 	push	#<(_ttf_corner_right_up+0)
      008B84 4B 01            [ 1] 1764 	push	#((_ttf_corner_right_up+0) >> 8)
      008B86 4B 08            [ 1] 1765 	push	#0x08
      008B88 4B 00            [ 1] 1766 	push	#0x00
      008B8A 1E 09            [ 2] 1767 	ldw	x, (0x09, sp)
      008B8C CD 89 D7         [ 4] 1768 	call	_ssd1306_buffer_write
      008B8F 85               [ 2] 1769 	popw	x
                                   1770 ;	./libs/menu_lib.c: 31: ssd1306_buffer_write(12+number_of_letters*8,0,ttf_line_left);
      008B90 1C 00 0C         [ 2] 1771 	addw	x, #0x000c
      008B93 1F 05            [ 2] 1772 	ldw	(0x05, sp), x
      008B95 4B 74            [ 1] 1773 	push	#<(_ttf_line_left+0)
      008B97 4B 01            [ 1] 1774 	push	#((_ttf_line_left+0) >> 8)
      008B99 5F               [ 1] 1775 	clrw	x
      008B9A 89               [ 2] 1776 	pushw	x
      008B9B 1E 09            [ 2] 1777 	ldw	x, (0x09, sp)
      008B9D CD 89 D7         [ 4] 1778 	call	_ssd1306_buffer_write
                                   1779 ;	./libs/menu_lib.c: 34: ssd1306_buffer_write(6,16,ttf_corner_left_down);
      008BA0 4B 5C            [ 1] 1780 	push	#<(_ttf_corner_left_down+0)
      008BA2 4B 01            [ 1] 1781 	push	#((_ttf_corner_left_down+0) >> 8)
      008BA4 4B 10            [ 1] 1782 	push	#0x10
      008BA6 4B 00            [ 1] 1783 	push	#0x00
      008BA8 AE 00 06         [ 2] 1784 	ldw	x, #0x0006
      008BAB CD 89 D7         [ 4] 1785 	call	_ssd1306_buffer_write
                                   1786 ;	./libs/menu_lib.c: 35: for(int x = 1;x<number_of_letters+1;x++)
      008BAE 5F               [ 1] 1787 	clrw	x
      008BAF 5C               [ 1] 1788 	incw	x
      008BB0                       1789 00107$:
      008BB0 13 01            [ 2] 1790 	cpw	x, (0x01, sp)
      008BB2 2E 1D            [ 1] 1791 	jrsge	00102$
                                   1792 ;	./libs/menu_lib.c: 36: ssd1306_buffer_write(6+x*8,16,ttf_line_down);
      008BB4 90 93            [ 1] 1793 	ldw	y, x
      008BB6 90 58            [ 2] 1794 	sllw	y
      008BB8 90 58            [ 2] 1795 	sllw	y
      008BBA 90 58            [ 2] 1796 	sllw	y
      008BBC 72 A9 00 06      [ 2] 1797 	addw	y, #0x0006
      008BC0 89               [ 2] 1798 	pushw	x
      008BC1 4B 84            [ 1] 1799 	push	#<(_ttf_line_down+0)
      008BC3 4B 01            [ 1] 1800 	push	#((_ttf_line_down+0) >> 8)
      008BC5 4B 10            [ 1] 1801 	push	#0x10
      008BC7 4B 00            [ 1] 1802 	push	#0x00
      008BC9 93               [ 1] 1803 	ldw	x, y
      008BCA CD 89 D7         [ 4] 1804 	call	_ssd1306_buffer_write
      008BCD 85               [ 2] 1805 	popw	x
                                   1806 ;	./libs/menu_lib.c: 35: for(int x = 1;x<number_of_letters+1;x++)
      008BCE 5C               [ 1] 1807 	incw	x
      008BCF 20 DF            [ 2] 1808 	jra	00107$
      008BD1                       1809 00102$:
                                   1810 ;	./libs/menu_lib.c: 37: ssd1306_buffer_write(6+number_of_letters*8,16,ttf_corner_right_down);
      008BD1 4B 64            [ 1] 1811 	push	#<(_ttf_corner_right_down+0)
      008BD3 4B 01            [ 1] 1812 	push	#((_ttf_corner_right_down+0) >> 8)
      008BD5 4B 10            [ 1] 1813 	push	#0x10
      008BD7 4B 00            [ 1] 1814 	push	#0x00
      008BD9 1E 07            [ 2] 1815 	ldw	x, (0x07, sp)
      008BDB CD 89 D7         [ 4] 1816 	call	_ssd1306_buffer_write
                                   1817 ;	./libs/menu_lib.c: 38: ssd1306_buffer_write(12+number_of_letters*8,24,ttf_line_left);
      008BDE 4B 74            [ 1] 1818 	push	#<(_ttf_line_left+0)
      008BE0 4B 01            [ 1] 1819 	push	#((_ttf_line_left+0) >> 8)
      008BE2 4B 18            [ 1] 1820 	push	#0x18
      008BE4 4B 00            [ 1] 1821 	push	#0x00
      008BE6 1E 09            [ 2] 1822 	ldw	x, (0x09, sp)
      008BE8 CD 89 D7         [ 4] 1823 	call	_ssd1306_buffer_write
                                   1824 ;	./libs/menu_lib.c: 40: }
      008BEB 5B 07            [ 2] 1825 	addw	sp, #7
      008BED 81               [ 4] 1826 	ret
                                   1827 ;	./libs/menu_lib.c: 42: void menu_border_item(uint8_t number_of_letters)
                                   1828 ;	-----------------------------------------
                                   1829 ;	 function menu_border_item
                                   1830 ;	-----------------------------------------
      008BEE                       1831 _menu_border_item:
      008BEE 52 06            [ 2] 1832 	sub	sp, #6
                                   1833 ;	./libs/menu_lib.c: 45: ssd1306_buffer_write(12+number_of_letters*8,7,ttf_corner_left_down);
      008BF0 6B 02            [ 1] 1834 	ld	(0x02, sp), a
      008BF2 0F 01            [ 1] 1835 	clr	(0x01, sp)
      008BF4 1E 01            [ 2] 1836 	ldw	x, (0x01, sp)
      008BF6 58               [ 2] 1837 	sllw	x
      008BF7 58               [ 2] 1838 	sllw	x
      008BF8 58               [ 2] 1839 	sllw	x
      008BF9 1C 00 0C         [ 2] 1840 	addw	x, #0x000c
      008BFC 1F 03            [ 2] 1841 	ldw	(0x03, sp), x
      008BFE 4B 5C            [ 1] 1842 	push	#<(_ttf_corner_left_down+0)
      008C00 4B 01            [ 1] 1843 	push	#((_ttf_corner_left_down+0) >> 8)
      008C02 4B 07            [ 1] 1844 	push	#0x07
      008C04 4B 00            [ 1] 1845 	push	#0x00
      008C06 1E 07            [ 2] 1846 	ldw	x, (0x07, sp)
      008C08 CD 89 D7         [ 4] 1847 	call	_ssd1306_buffer_write
                                   1848 ;	./libs/menu_lib.c: 46: for(int x = 1;x<14-number_of_letters;x++)
      008C0B A6 0E            [ 1] 1849 	ld	a, #0x0e
      008C0D 10 02            [ 1] 1850 	sub	a, (0x02, sp)
      008C0F 6B 06            [ 1] 1851 	ld	(0x06, sp), a
      008C11 4F               [ 1] 1852 	clr	a
      008C12 12 01            [ 1] 1853 	sbc	a, (0x01, sp)
      008C14 6B 05            [ 1] 1854 	ld	(0x05, sp), a
      008C16 5F               [ 1] 1855 	clrw	x
      008C17 5C               [ 1] 1856 	incw	x
      008C18                       1857 00103$:
      008C18 13 05            [ 2] 1858 	cpw	x, (0x05, sp)
      008C1A 2E 1C            [ 1] 1859 	jrsge	00101$
                                   1860 ;	./libs/menu_lib.c: 47: ssd1306_buffer_write(12+number_of_letters*8+x*8,7,ttf_line_down);
      008C1C 90 93            [ 1] 1861 	ldw	y, x
      008C1E 90 58            [ 2] 1862 	sllw	y
      008C20 90 58            [ 2] 1863 	sllw	y
      008C22 90 58            [ 2] 1864 	sllw	y
      008C24 72 F9 03         [ 2] 1865 	addw	y, (0x03, sp)
      008C27 89               [ 2] 1866 	pushw	x
      008C28 4B 84            [ 1] 1867 	push	#<(_ttf_line_down+0)
      008C2A 4B 01            [ 1] 1868 	push	#((_ttf_line_down+0) >> 8)
      008C2C 4B 07            [ 1] 1869 	push	#0x07
      008C2E 4B 00            [ 1] 1870 	push	#0x00
      008C30 93               [ 1] 1871 	ldw	x, y
      008C31 CD 89 D7         [ 4] 1872 	call	_ssd1306_buffer_write
      008C34 85               [ 2] 1873 	popw	x
                                   1874 ;	./libs/menu_lib.c: 46: for(int x = 1;x<14-number_of_letters;x++)
      008C35 5C               [ 1] 1875 	incw	x
      008C36 20 E0            [ 2] 1876 	jra	00103$
      008C38                       1877 00101$:
                                   1878 ;	./libs/menu_lib.c: 48: ssd1306_buffer_write(120,7,ttf_corner_right_down);
      008C38 4B 64            [ 1] 1879 	push	#<(_ttf_corner_right_down+0)
      008C3A 4B 01            [ 1] 1880 	push	#((_ttf_corner_right_down+0) >> 8)
      008C3C 4B 07            [ 1] 1881 	push	#0x07
      008C3E 4B 00            [ 1] 1882 	push	#0x00
      008C40 AE 00 78         [ 2] 1883 	ldw	x, #0x0078
      008C43 CD 89 D7         [ 4] 1884 	call	_ssd1306_buffer_write
                                   1885 ;	./libs/menu_lib.c: 51: ssd1306_buffer_write(97,15,ttf_line_left);
      008C46 4B 74            [ 1] 1886 	push	#<(_ttf_line_left+0)
      008C48 4B 01            [ 1] 1887 	push	#((_ttf_line_left+0) >> 8)
      008C4A 4B 0F            [ 1] 1888 	push	#0x0f
      008C4C 4B 00            [ 1] 1889 	push	#0x00
      008C4E AE 00 61         [ 2] 1890 	ldw	x, #0x0061
      008C51 CD 89 D7         [ 4] 1891 	call	_ssd1306_buffer_write
                                   1892 ;	./libs/menu_lib.c: 52: ssd1306_buffer_write(97,17,ttf_corner_left_down);
      008C54 4B 5C            [ 1] 1893 	push	#<(_ttf_corner_left_down+0)
      008C56 4B 01            [ 1] 1894 	push	#((_ttf_corner_left_down+0) >> 8)
      008C58 4B 11            [ 1] 1895 	push	#0x11
      008C5A 4B 00            [ 1] 1896 	push	#0x00
      008C5C AE 00 61         [ 2] 1897 	ldw	x, #0x0061
      008C5F CD 89 D7         [ 4] 1898 	call	_ssd1306_buffer_write
                                   1899 ;	./libs/menu_lib.c: 53: ssd1306_buffer_write(104,17,ttf_line_down);
      008C62 4B 84            [ 1] 1900 	push	#<(_ttf_line_down+0)
      008C64 4B 01            [ 1] 1901 	push	#((_ttf_line_down+0) >> 8)
      008C66 4B 11            [ 1] 1902 	push	#0x11
      008C68 4B 00            [ 1] 1903 	push	#0x00
      008C6A AE 00 68         [ 2] 1904 	ldw	x, #0x0068
      008C6D CD 89 D7         [ 4] 1905 	call	_ssd1306_buffer_write
                                   1906 ;	./libs/menu_lib.c: 54: ssd1306_buffer_write(112,17,ttf_line_down);
      008C70 4B 84            [ 1] 1907 	push	#<(_ttf_line_down+0)
      008C72 4B 01            [ 1] 1908 	push	#((_ttf_line_down+0) >> 8)
      008C74 4B 11            [ 1] 1909 	push	#0x11
      008C76 4B 00            [ 1] 1910 	push	#0x00
      008C78 AE 00 70         [ 2] 1911 	ldw	x, #0x0070
      008C7B CD 89 D7         [ 4] 1912 	call	_ssd1306_buffer_write
                                   1913 ;	./libs/menu_lib.c: 55: ssd1306_buffer_write(120,17,ttf_line_down);
      008C7E 4B 84            [ 1] 1914 	push	#<(_ttf_line_down+0)
      008C80 4B 01            [ 1] 1915 	push	#((_ttf_line_down+0) >> 8)
      008C82 4B 11            [ 1] 1916 	push	#0x11
      008C84 4B 00            [ 1] 1917 	push	#0x00
      008C86 AE 00 78         [ 2] 1918 	ldw	x, #0x0078
      008C89 CD 89 D7         [ 4] 1919 	call	_ssd1306_buffer_write
                                   1920 ;	./libs/menu_lib.c: 58: }
      008C8C 5B 06            [ 2] 1921 	addw	sp, #6
      008C8E 81               [ 4] 1922 	ret
                                   1923 ;	./libs/menu_lib.c: 60: void menu_set_params_value(uint8_t number)
                                   1924 ;	-----------------------------------------
                                   1925 ;	 function menu_set_params_value
                                   1926 ;	-----------------------------------------
      008C8F                       1927 _menu_set_params_value:
      008C8F 52 05            [ 2] 1928 	sub	sp, #5
                                   1929 ;	./libs/menu_lib.c: 64: do {
      008C91 0F 05            [ 1] 1930 	clr	(0x05, sp)
      008C93                       1931 00101$:
                                   1932 ;	./libs/menu_lib.c: 65: ssd1306_buffer_write(117-8*index,15,numbers[number % 10]); // Получаем последнюю цифру
      008C93 6B 02            [ 1] 1933 	ld	(0x02, sp), a
      008C95 0F 01            [ 1] 1934 	clr	(0x01, sp)
      008C97 4B 0A            [ 1] 1935 	push	#0x0a
      008C99 4B 00            [ 1] 1936 	push	#0x00
      008C9B 1E 03            [ 2] 1937 	ldw	x, (0x03, sp)
      008C9D CD 93 15         [ 4] 1938 	call	__modsint
      008CA0 58               [ 2] 1939 	sllw	x
      008CA1 DE 00 0F         [ 2] 1940 	ldw	x, (_menu_set_params_value_numbers_10000_171+0, x)
      008CA4 90 93            [ 1] 1941 	ldw	y, x
      008CA6 5F               [ 1] 1942 	clrw	x
      008CA7 7B 05            [ 1] 1943 	ld	a, (0x05, sp)
      008CA9 97               [ 1] 1944 	ld	xl, a
      008CAA 58               [ 2] 1945 	sllw	x
      008CAB 58               [ 2] 1946 	sllw	x
      008CAC 58               [ 2] 1947 	sllw	x
      008CAD 1F 03            [ 2] 1948 	ldw	(0x03, sp), x
      008CAF AE 00 75         [ 2] 1949 	ldw	x, #0x0075
      008CB2 72 F0 03         [ 2] 1950 	subw	x, (0x03, sp)
      008CB5 90 89            [ 2] 1951 	pushw	y
      008CB7 4B 0F            [ 1] 1952 	push	#0x0f
      008CB9 4B 00            [ 1] 1953 	push	#0x00
      008CBB CD 89 D7         [ 4] 1954 	call	_ssd1306_buffer_write
                                   1955 ;	./libs/menu_lib.c: 66: number /= 10; // Убираем последнюю цифру
      008CBE 4B 0A            [ 1] 1956 	push	#0x0a
      008CC0 4B 00            [ 1] 1957 	push	#0x00
      008CC2 1E 03            [ 2] 1958 	ldw	x, (0x03, sp)
      008CC4 CD 93 2D         [ 4] 1959 	call	__divsint
      008CC7 9F               [ 1] 1960 	ld	a, xl
                                   1961 ;	./libs/menu_lib.c: 67: index++;
      008CC8 0C 05            [ 1] 1962 	inc	(0x05, sp)
                                   1963 ;	./libs/menu_lib.c: 68: } while (number > 0);
      008CCA 4D               [ 1] 1964 	tnz	a
      008CCB 26 C6            [ 1] 1965 	jrne	00101$
                                   1966 ;	./libs/menu_lib.c: 69: }
      008CCD 5B 05            [ 2] 1967 	addw	sp, #5
      008CCF 81               [ 4] 1968 	ret
                                   1969 ;	./libs/menu_lib.c: 70: void menu_set_item_menu(uint8_t item)
                                   1970 ;	-----------------------------------------
                                   1971 ;	 function menu_set_item_menu
                                   1972 ;	-----------------------------------------
      008CD0                       1973 _menu_set_item_menu:
                                   1974 ;	./libs/menu_lib.c: 73: switch(item)
      008CD0 A1 07            [ 1] 1975 	cp	a, #0x07
      008CD2 23 01            [ 2] 1976 	jrule	00118$
      008CD4 81               [ 4] 1977 	ret
      008CD5                       1978 00118$:
      008CD5 5F               [ 1] 1979 	clrw	x
      008CD6 97               [ 1] 1980 	ld	xl, a
      008CD7 58               [ 2] 1981 	sllw	x
      008CD8 DE 8C DC         [ 2] 1982 	ldw	x, (#00119$, x)
      008CDB FC               [ 2] 1983 	jp	(x)
      008CDC                       1984 00119$:
      008CDC 8E F2                 1985 	.dw	#00109$
      008CDE 8C EC                 1986 	.dw	#00101$
      008CE0 8D 21                 1987 	.dw	#00102$
      008CE2 8D 72                 1988 	.dw	#00103$
      008CE4 8D B5                 1989 	.dw	#00104$
      008CE6 8E 09                 1990 	.dw	#00105$
      008CE8 8E 6C                 1991 	.dw	#00106$
      008CEA 8E AF                 1992 	.dw	#00107$
                                   1993 ;	./libs/menu_lib.c: 75: case red:
      008CEC                       1994 00101$:
                                   1995 ;	./libs/menu_lib.c: 76: menu_border_item(color);
      008CEC A6 05            [ 1] 1996 	ld	a, #0x05
      008CEE CD 8B EE         [ 4] 1997 	call	_menu_border_item
                                   1998 ;	./libs/menu_lib.c: 78: ssd1306_buffer_write(15+color*8,4,ttf_eng_r);
      008CF1 4B AB            [ 1] 1999 	push	#<(_ttf_eng_r+0)
      008CF3 4B 00            [ 1] 2000 	push	#((_ttf_eng_r+0) >> 8)
      008CF5 4B 04            [ 1] 2001 	push	#0x04
      008CF7 4B 00            [ 1] 2002 	push	#0x00
      008CF9 AE 00 37         [ 2] 2003 	ldw	x, #0x0037
      008CFC CD 89 D7         [ 4] 2004 	call	_ssd1306_buffer_write
                                   2005 ;	./libs/menu_lib.c: 79: ssd1306_buffer_write(15+color*8+8,4,ttf_eng_e);
      008CFF 4B 43            [ 1] 2006 	push	#<(_ttf_eng_e+0)
      008D01 4B 00            [ 1] 2007 	push	#((_ttf_eng_e+0) >> 8)
      008D03 4B 04            [ 1] 2008 	push	#0x04
      008D05 4B 00            [ 1] 2009 	push	#0x00
      008D07 AE 00 3F         [ 2] 2010 	ldw	x, #0x003f
      008D0A CD 89 D7         [ 4] 2011 	call	_ssd1306_buffer_write
                                   2012 ;	./libs/menu_lib.c: 80: ssd1306_buffer_write(15+color*8+16,4,ttf_eng_d);
      008D0D 4B 3B            [ 1] 2013 	push	#<(_ttf_eng_d+0)
      008D0F 4B 00            [ 1] 2014 	push	#((_ttf_eng_d+0) >> 8)
      008D11 4B 04            [ 1] 2015 	push	#0x04
      008D13 4B 00            [ 1] 2016 	push	#0x00
      008D15 AE 00 47         [ 2] 2017 	ldw	x, #0x0047
      008D18 CD 89 D7         [ 4] 2018 	call	_ssd1306_buffer_write
                                   2019 ;	./libs/menu_lib.c: 82: menu_set_params_value(params_value.current_red);
      008D1B C6 00 09         [ 1] 2020 	ld	a, _params_value+2
                                   2021 ;	./libs/menu_lib.c: 84: break;
      008D1E CC 8C 8F         [ 2] 2022 	jp	_menu_set_params_value
                                   2023 ;	./libs/menu_lib.c: 85: case green:
      008D21                       2024 00102$:
                                   2025 ;	./libs/menu_lib.c: 86: menu_border_item(color);
      008D21 A6 05            [ 1] 2026 	ld	a, #0x05
      008D23 CD 8B EE         [ 4] 2027 	call	_menu_border_item
                                   2028 ;	./libs/menu_lib.c: 88: ssd1306_buffer_write(15+color*8,4,ttf_eng_g);
      008D26 4B 53            [ 1] 2029 	push	#<(_ttf_eng_g+0)
      008D28 4B 00            [ 1] 2030 	push	#((_ttf_eng_g+0) >> 8)
      008D2A 4B 04            [ 1] 2031 	push	#0x04
      008D2C 4B 00            [ 1] 2032 	push	#0x00
      008D2E AE 00 37         [ 2] 2033 	ldw	x, #0x0037
      008D31 CD 89 D7         [ 4] 2034 	call	_ssd1306_buffer_write
                                   2035 ;	./libs/menu_lib.c: 89: ssd1306_buffer_write(15+color*8+8,4,ttf_eng_r);
      008D34 4B AB            [ 1] 2036 	push	#<(_ttf_eng_r+0)
      008D36 4B 00            [ 1] 2037 	push	#((_ttf_eng_r+0) >> 8)
      008D38 4B 04            [ 1] 2038 	push	#0x04
      008D3A 4B 00            [ 1] 2039 	push	#0x00
      008D3C AE 00 3F         [ 2] 2040 	ldw	x, #0x003f
      008D3F CD 89 D7         [ 4] 2041 	call	_ssd1306_buffer_write
                                   2042 ;	./libs/menu_lib.c: 90: ssd1306_buffer_write(15+color*8+16,4,ttf_eng_e);
      008D42 4B 43            [ 1] 2043 	push	#<(_ttf_eng_e+0)
      008D44 4B 00            [ 1] 2044 	push	#((_ttf_eng_e+0) >> 8)
      008D46 4B 04            [ 1] 2045 	push	#0x04
      008D48 4B 00            [ 1] 2046 	push	#0x00
      008D4A AE 00 47         [ 2] 2047 	ldw	x, #0x0047
      008D4D CD 89 D7         [ 4] 2048 	call	_ssd1306_buffer_write
                                   2049 ;	./libs/menu_lib.c: 91: ssd1306_buffer_write(15+color*8+24,4,ttf_eng_e);
      008D50 4B 43            [ 1] 2050 	push	#<(_ttf_eng_e+0)
      008D52 4B 00            [ 1] 2051 	push	#((_ttf_eng_e+0) >> 8)
      008D54 4B 04            [ 1] 2052 	push	#0x04
      008D56 4B 00            [ 1] 2053 	push	#0x00
      008D58 AE 00 4F         [ 2] 2054 	ldw	x, #0x004f
      008D5B CD 89 D7         [ 4] 2055 	call	_ssd1306_buffer_write
                                   2056 ;	./libs/menu_lib.c: 92: ssd1306_buffer_write(15+color*8+32,4,ttf_eng_n);
      008D5E 4B 8B            [ 1] 2057 	push	#<(_ttf_eng_n+0)
      008D60 4B 00            [ 1] 2058 	push	#((_ttf_eng_n+0) >> 8)
      008D62 4B 04            [ 1] 2059 	push	#0x04
      008D64 4B 00            [ 1] 2060 	push	#0x00
      008D66 AE 00 57         [ 2] 2061 	ldw	x, #0x0057
      008D69 CD 89 D7         [ 4] 2062 	call	_ssd1306_buffer_write
                                   2063 ;	./libs/menu_lib.c: 94: menu_set_params_value(params_value.current_green);
      008D6C C6 00 0A         [ 1] 2064 	ld	a, _params_value+3
                                   2065 ;	./libs/menu_lib.c: 97: break;
      008D6F CC 8C 8F         [ 2] 2066 	jp	_menu_set_params_value
                                   2067 ;	./libs/menu_lib.c: 98: case blue:
      008D72                       2068 00103$:
                                   2069 ;	./libs/menu_lib.c: 99: menu_border_item(color);
      008D72 A6 05            [ 1] 2070 	ld	a, #0x05
      008D74 CD 8B EE         [ 4] 2071 	call	_menu_border_item
                                   2072 ;	./libs/menu_lib.c: 101: ssd1306_buffer_write(15+color*8,4,ttf_eng_b);
      008D77 4B 2B            [ 1] 2073 	push	#<(_ttf_eng_b+0)
      008D79 4B 00            [ 1] 2074 	push	#((_ttf_eng_b+0) >> 8)
      008D7B 4B 04            [ 1] 2075 	push	#0x04
      008D7D 4B 00            [ 1] 2076 	push	#0x00
      008D7F AE 00 37         [ 2] 2077 	ldw	x, #0x0037
      008D82 CD 89 D7         [ 4] 2078 	call	_ssd1306_buffer_write
                                   2079 ;	./libs/menu_lib.c: 102: ssd1306_buffer_write(15+color*8+8,4,ttf_eng_l);
      008D85 4B 7B            [ 1] 2080 	push	#<(_ttf_eng_l+0)
      008D87 4B 00            [ 1] 2081 	push	#((_ttf_eng_l+0) >> 8)
      008D89 4B 04            [ 1] 2082 	push	#0x04
      008D8B 4B 00            [ 1] 2083 	push	#0x00
      008D8D AE 00 3F         [ 2] 2084 	ldw	x, #0x003f
      008D90 CD 89 D7         [ 4] 2085 	call	_ssd1306_buffer_write
                                   2086 ;	./libs/menu_lib.c: 103: ssd1306_buffer_write(15+color*8+16,4,ttf_eng_u);
      008D93 4B C3            [ 1] 2087 	push	#<(_ttf_eng_u+0)
      008D95 4B 00            [ 1] 2088 	push	#((_ttf_eng_u+0) >> 8)
      008D97 4B 04            [ 1] 2089 	push	#0x04
      008D99 4B 00            [ 1] 2090 	push	#0x00
      008D9B AE 00 47         [ 2] 2091 	ldw	x, #0x0047
      008D9E CD 89 D7         [ 4] 2092 	call	_ssd1306_buffer_write
                                   2093 ;	./libs/menu_lib.c: 104: ssd1306_buffer_write(15+color*8+24,4,ttf_eng_e);
      008DA1 4B 43            [ 1] 2094 	push	#<(_ttf_eng_e+0)
      008DA3 4B 00            [ 1] 2095 	push	#((_ttf_eng_e+0) >> 8)
      008DA5 4B 04            [ 1] 2096 	push	#0x04
      008DA7 4B 00            [ 1] 2097 	push	#0x00
      008DA9 AE 00 4F         [ 2] 2098 	ldw	x, #0x004f
      008DAC CD 89 D7         [ 4] 2099 	call	_ssd1306_buffer_write
                                   2100 ;	./libs/menu_lib.c: 106: menu_set_params_value(params_value.current_blue);
      008DAF C6 00 0B         [ 1] 2101 	ld	a, _params_value+4
                                   2102 ;	./libs/menu_lib.c: 107: break;
      008DB2 CC 8C 8F         [ 2] 2103 	jp	_menu_set_params_value
                                   2104 ;	./libs/menu_lib.c: 108: case first:
      008DB5                       2105 00104$:
                                   2106 ;	./libs/menu_lib.c: 109: menu_border_item(segment);
      008DB5 A6 07            [ 1] 2107 	ld	a, #0x07
      008DB7 CD 8B EE         [ 4] 2108 	call	_menu_border_item
                                   2109 ;	./libs/menu_lib.c: 111: ssd1306_buffer_write(15+segment*8,4,ttf_eng_f);
      008DBA 4B 4B            [ 1] 2110 	push	#<(_ttf_eng_f+0)
      008DBC 4B 00            [ 1] 2111 	push	#((_ttf_eng_f+0) >> 8)
      008DBE 4B 04            [ 1] 2112 	push	#0x04
      008DC0 4B 00            [ 1] 2113 	push	#0x00
      008DC2 AE 00 47         [ 2] 2114 	ldw	x, #0x0047
      008DC5 CD 89 D7         [ 4] 2115 	call	_ssd1306_buffer_write
                                   2116 ;	./libs/menu_lib.c: 112: ssd1306_buffer_write(15+segment*8+8,4,ttf_eng_i);
      008DC8 4B 63            [ 1] 2117 	push	#<(_ttf_eng_i+0)
      008DCA 4B 00            [ 1] 2118 	push	#((_ttf_eng_i+0) >> 8)
      008DCC 4B 04            [ 1] 2119 	push	#0x04
      008DCE 4B 00            [ 1] 2120 	push	#0x00
      008DD0 AE 00 4F         [ 2] 2121 	ldw	x, #0x004f
      008DD3 CD 89 D7         [ 4] 2122 	call	_ssd1306_buffer_write
                                   2123 ;	./libs/menu_lib.c: 113: ssd1306_buffer_write(15+segment*8+16,4,ttf_eng_r);
      008DD6 4B AB            [ 1] 2124 	push	#<(_ttf_eng_r+0)
      008DD8 4B 00            [ 1] 2125 	push	#((_ttf_eng_r+0) >> 8)
      008DDA 4B 04            [ 1] 2126 	push	#0x04
      008DDC 4B 00            [ 1] 2127 	push	#0x00
      008DDE AE 00 57         [ 2] 2128 	ldw	x, #0x0057
      008DE1 CD 89 D7         [ 4] 2129 	call	_ssd1306_buffer_write
                                   2130 ;	./libs/menu_lib.c: 114: ssd1306_buffer_write(15+segment*8+24,4,ttf_eng_s);
      008DE4 4B B3            [ 1] 2131 	push	#<(_ttf_eng_s+0)
      008DE6 4B 00            [ 1] 2132 	push	#((_ttf_eng_s+0) >> 8)
      008DE8 4B 04            [ 1] 2133 	push	#0x04
      008DEA 4B 00            [ 1] 2134 	push	#0x00
      008DEC AE 00 5F         [ 2] 2135 	ldw	x, #0x005f
      008DEF CD 89 D7         [ 4] 2136 	call	_ssd1306_buffer_write
                                   2137 ;	./libs/menu_lib.c: 115: ssd1306_buffer_write(15+segment*8+32,4,ttf_eng_t);
      008DF2 4B BB            [ 1] 2138 	push	#<(_ttf_eng_t+0)
      008DF4 4B 00            [ 1] 2139 	push	#((_ttf_eng_t+0) >> 8)
      008DF6 4B 04            [ 1] 2140 	push	#0x04
      008DF8 4B 00            [ 1] 2141 	push	#0x00
      008DFA AE 00 67         [ 2] 2142 	ldw	x, #0x0067
      008DFD CD 89 D7         [ 4] 2143 	call	_ssd1306_buffer_write
                                   2144 ;	./libs/menu_lib.c: 117: menu_set_params_value(params_value.current_first);
      008E00 AE 00 0C         [ 2] 2145 	ldw	x, #_params_value+5
      008E03 F6               [ 1] 2146 	ld	a, (x)
      008E04 A4 0F            [ 1] 2147 	and	a, #0x0f
                                   2148 ;	./libs/menu_lib.c: 118: break;
      008E06 CC 8C 8F         [ 2] 2149 	jp	_menu_set_params_value
                                   2150 ;	./libs/menu_lib.c: 119: case second:
      008E09                       2151 00105$:
                                   2152 ;	./libs/menu_lib.c: 120: menu_border_item(segment);
      008E09 A6 07            [ 1] 2153 	ld	a, #0x07
      008E0B CD 8B EE         [ 4] 2154 	call	_menu_border_item
                                   2155 ;	./libs/menu_lib.c: 122: ssd1306_buffer_write(15+segment*8,4,ttf_eng_s);
      008E0E 4B B3            [ 1] 2156 	push	#<(_ttf_eng_s+0)
      008E10 4B 00            [ 1] 2157 	push	#((_ttf_eng_s+0) >> 8)
      008E12 4B 04            [ 1] 2158 	push	#0x04
      008E14 4B 00            [ 1] 2159 	push	#0x00
      008E16 AE 00 47         [ 2] 2160 	ldw	x, #0x0047
      008E19 CD 89 D7         [ 4] 2161 	call	_ssd1306_buffer_write
                                   2162 ;	./libs/menu_lib.c: 123: ssd1306_buffer_write(15+segment*8+8,4,ttf_eng_e);
      008E1C 4B 43            [ 1] 2163 	push	#<(_ttf_eng_e+0)
      008E1E 4B 00            [ 1] 2164 	push	#((_ttf_eng_e+0) >> 8)
      008E20 4B 04            [ 1] 2165 	push	#0x04
      008E22 4B 00            [ 1] 2166 	push	#0x00
      008E24 AE 00 4F         [ 2] 2167 	ldw	x, #0x004f
      008E27 CD 89 D7         [ 4] 2168 	call	_ssd1306_buffer_write
                                   2169 ;	./libs/menu_lib.c: 124: ssd1306_buffer_write(15+segment*8+16,4,ttf_eng_c);
      008E2A 4B 33            [ 1] 2170 	push	#<(_ttf_eng_c+0)
      008E2C 4B 00            [ 1] 2171 	push	#((_ttf_eng_c+0) >> 8)
      008E2E 4B 04            [ 1] 2172 	push	#0x04
      008E30 4B 00            [ 1] 2173 	push	#0x00
      008E32 AE 00 57         [ 2] 2174 	ldw	x, #0x0057
      008E35 CD 89 D7         [ 4] 2175 	call	_ssd1306_buffer_write
                                   2176 ;	./libs/menu_lib.c: 125: ssd1306_buffer_write(15+segment*8+24,4,ttf_eng_o);
      008E38 4B 93            [ 1] 2177 	push	#<(_ttf_eng_o+0)
      008E3A 4B 00            [ 1] 2178 	push	#((_ttf_eng_o+0) >> 8)
      008E3C 4B 04            [ 1] 2179 	push	#0x04
      008E3E 4B 00            [ 1] 2180 	push	#0x00
      008E40 AE 00 5F         [ 2] 2181 	ldw	x, #0x005f
      008E43 CD 89 D7         [ 4] 2182 	call	_ssd1306_buffer_write
                                   2183 ;	./libs/menu_lib.c: 126: ssd1306_buffer_write(15+segment*8+32,4,ttf_eng_n);
      008E46 4B 8B            [ 1] 2184 	push	#<(_ttf_eng_n+0)
      008E48 4B 00            [ 1] 2185 	push	#((_ttf_eng_n+0) >> 8)
      008E4A 4B 04            [ 1] 2186 	push	#0x04
      008E4C 4B 00            [ 1] 2187 	push	#0x00
      008E4E AE 00 67         [ 2] 2188 	ldw	x, #0x0067
      008E51 CD 89 D7         [ 4] 2189 	call	_ssd1306_buffer_write
                                   2190 ;	./libs/menu_lib.c: 127: ssd1306_buffer_write(15+segment*8+40,4,ttf_eng_d);
      008E54 4B 3B            [ 1] 2191 	push	#<(_ttf_eng_d+0)
      008E56 4B 00            [ 1] 2192 	push	#((_ttf_eng_d+0) >> 8)
      008E58 4B 04            [ 1] 2193 	push	#0x04
      008E5A 4B 00            [ 1] 2194 	push	#0x00
      008E5C AE 00 6F         [ 2] 2195 	ldw	x, #0x006f
      008E5F CD 89 D7         [ 4] 2196 	call	_ssd1306_buffer_write
                                   2197 ;	./libs/menu_lib.c: 129: menu_set_params_value(params_value.current_second);
      008E62 AE 00 0C         [ 2] 2198 	ldw	x, #_params_value+5
      008E65 F6               [ 1] 2199 	ld	a, (x)
      008E66 4E               [ 1] 2200 	swap	a
      008E67 A4 0F            [ 1] 2201 	and	a, #0x0f
                                   2202 ;	./libs/menu_lib.c: 130: break;
      008E69 CC 8C 8F         [ 2] 2203 	jp	_menu_set_params_value
                                   2204 ;	./libs/menu_lib.c: 131: case sens:
      008E6C                       2205 00106$:
                                   2206 ;	./libs/menu_lib.c: 132: menu_border_item(settings);
      008E6C A6 06            [ 1] 2207 	ld	a, #0x06
      008E6E CD 8B EE         [ 4] 2208 	call	_menu_border_item
                                   2209 ;	./libs/menu_lib.c: 134: ssd1306_buffer_write(15+settings*8,4,ttf_eng_s);
      008E71 4B B3            [ 1] 2210 	push	#<(_ttf_eng_s+0)
      008E73 4B 00            [ 1] 2211 	push	#((_ttf_eng_s+0) >> 8)
      008E75 4B 04            [ 1] 2212 	push	#0x04
      008E77 4B 00            [ 1] 2213 	push	#0x00
      008E79 AE 00 3F         [ 2] 2214 	ldw	x, #0x003f
      008E7C CD 89 D7         [ 4] 2215 	call	_ssd1306_buffer_write
                                   2216 ;	./libs/menu_lib.c: 135: ssd1306_buffer_write(15+settings*8+8,4,ttf_eng_e);
      008E7F 4B 43            [ 1] 2217 	push	#<(_ttf_eng_e+0)
      008E81 4B 00            [ 1] 2218 	push	#((_ttf_eng_e+0) >> 8)
      008E83 4B 04            [ 1] 2219 	push	#0x04
      008E85 4B 00            [ 1] 2220 	push	#0x00
      008E87 AE 00 47         [ 2] 2221 	ldw	x, #0x0047
      008E8A CD 89 D7         [ 4] 2222 	call	_ssd1306_buffer_write
                                   2223 ;	./libs/menu_lib.c: 136: ssd1306_buffer_write(15+settings*8+16,4,ttf_eng_n);
      008E8D 4B 8B            [ 1] 2224 	push	#<(_ttf_eng_n+0)
      008E8F 4B 00            [ 1] 2225 	push	#((_ttf_eng_n+0) >> 8)
      008E91 4B 04            [ 1] 2226 	push	#0x04
      008E93 4B 00            [ 1] 2227 	push	#0x00
      008E95 AE 00 4F         [ 2] 2228 	ldw	x, #0x004f
      008E98 CD 89 D7         [ 4] 2229 	call	_ssd1306_buffer_write
                                   2230 ;	./libs/menu_lib.c: 137: ssd1306_buffer_write(15+settings*8+24,4,ttf_eng_s);
      008E9B 4B B3            [ 1] 2231 	push	#<(_ttf_eng_s+0)
      008E9D 4B 00            [ 1] 2232 	push	#((_ttf_eng_s+0) >> 8)
      008E9F 4B 04            [ 1] 2233 	push	#0x04
      008EA1 4B 00            [ 1] 2234 	push	#0x00
      008EA3 AE 00 57         [ 2] 2235 	ldw	x, #0x0057
      008EA6 CD 89 D7         [ 4] 2236 	call	_ssd1306_buffer_write
                                   2237 ;	./libs/menu_lib.c: 139: menu_set_params_value(params_value.current_sens);
      008EA9 C6 00 0D         [ 1] 2238 	ld	a, _params_value+6
                                   2239 ;	./libs/menu_lib.c: 140: break;
      008EAC CC 8C 8F         [ 2] 2240 	jp	_menu_set_params_value
                                   2241 ;	./libs/menu_lib.c: 141: case vers:
      008EAF                       2242 00107$:
                                   2243 ;	./libs/menu_lib.c: 142: menu_border_item(settings);
      008EAF A6 06            [ 1] 2244 	ld	a, #0x06
      008EB1 CD 8B EE         [ 4] 2245 	call	_menu_border_item
                                   2246 ;	./libs/menu_lib.c: 144: ssd1306_buffer_write(15+settings*8,4,ttf_eng_v);
      008EB4 4B CB            [ 1] 2247 	push	#<(_ttf_eng_v+0)
      008EB6 4B 00            [ 1] 2248 	push	#((_ttf_eng_v+0) >> 8)
      008EB8 4B 04            [ 1] 2249 	push	#0x04
      008EBA 4B 00            [ 1] 2250 	push	#0x00
      008EBC AE 00 3F         [ 2] 2251 	ldw	x, #0x003f
      008EBF CD 89 D7         [ 4] 2252 	call	_ssd1306_buffer_write
                                   2253 ;	./libs/menu_lib.c: 145: ssd1306_buffer_write(15+settings*8+8,4,ttf_eng_e);
      008EC2 4B 43            [ 1] 2254 	push	#<(_ttf_eng_e+0)
      008EC4 4B 00            [ 1] 2255 	push	#((_ttf_eng_e+0) >> 8)
      008EC6 4B 04            [ 1] 2256 	push	#0x04
      008EC8 4B 00            [ 1] 2257 	push	#0x00
      008ECA AE 00 47         [ 2] 2258 	ldw	x, #0x0047
      008ECD CD 89 D7         [ 4] 2259 	call	_ssd1306_buffer_write
                                   2260 ;	./libs/menu_lib.c: 146: ssd1306_buffer_write(15+settings*8+16,4,ttf_eng_r);
      008ED0 4B AB            [ 1] 2261 	push	#<(_ttf_eng_r+0)
      008ED2 4B 00            [ 1] 2262 	push	#((_ttf_eng_r+0) >> 8)
      008ED4 4B 04            [ 1] 2263 	push	#0x04
      008ED6 4B 00            [ 1] 2264 	push	#0x00
      008ED8 AE 00 4F         [ 2] 2265 	ldw	x, #0x004f
      008EDB CD 89 D7         [ 4] 2266 	call	_ssd1306_buffer_write
                                   2267 ;	./libs/menu_lib.c: 147: ssd1306_buffer_write(15+settings*8+24,4,ttf_eng_s);
      008EDE 4B B3            [ 1] 2268 	push	#<(_ttf_eng_s+0)
      008EE0 4B 00            [ 1] 2269 	push	#((_ttf_eng_s+0) >> 8)
      008EE2 4B 04            [ 1] 2270 	push	#0x04
      008EE4 4B 00            [ 1] 2271 	push	#0x00
      008EE6 AE 00 57         [ 2] 2272 	ldw	x, #0x0057
      008EE9 CD 89 D7         [ 4] 2273 	call	_ssd1306_buffer_write
                                   2274 ;	./libs/menu_lib.c: 149: menu_set_params_value(params_value.current_vers);
      008EEC C6 00 0E         [ 1] 2275 	ld	a, _params_value+7
      008EEF CC 8C 8F         [ 2] 2276 	jp	_menu_set_params_value
                                   2277 ;	./libs/menu_lib.c: 151: }
      008EF2                       2278 00109$:
                                   2279 ;	./libs/menu_lib.c: 153: }
      008EF2 81               [ 4] 2280 	ret
                                   2281 ;	./libs/menu_lib.c: 158: void menu_set_paragraph(uint8_t paragraph)
                                   2282 ;	-----------------------------------------
                                   2283 ;	 function menu_set_paragraph
                                   2284 ;	-----------------------------------------
      008EF3                       2285 _menu_set_paragraph:
                                   2286 ;	./libs/menu_lib.c: 160: switch(paragraph)
      008EF3 A1 04            [ 1] 2287 	cp	a, #0x04
      008EF5 27 16            [ 1] 2288 	jreq	00101$
      008EF7 A1 05            [ 1] 2289 	cp	a, #0x05
      008EF9 26 03            [ 1] 2290 	jrne	00140$
      008EFB CC 90 95         [ 2] 2291 	jp	00102$
      008EFE                       2292 00140$:
      008EFE A1 06            [ 1] 2293 	cp	a, #0x06
      008F00 26 03            [ 1] 2294 	jrne	00143$
      008F02 CC 91 63         [ 2] 2295 	jp	00104$
      008F05                       2296 00143$:
      008F05 A1 07            [ 1] 2297 	cp	a, #0x07
      008F07 26 03            [ 1] 2298 	jrne	00146$
      008F09 CC 90 EE         [ 2] 2299 	jp	00103$
      008F0C                       2300 00146$:
      008F0C 81               [ 4] 2301 	ret
                                   2302 ;	./libs/menu_lib.c: 162: case menu:
      008F0D                       2303 00101$:
                                   2304 ;	./libs/menu_lib.c: 163: ssd1306_buffer_clean();
      008F0D CD 89 75         [ 4] 2305 	call	_ssd1306_buffer_clean
                                   2306 ;	./libs/menu_lib.c: 164: menu_border();
      008F10 CD 8A 72         [ 4] 2307 	call	_menu_border
                                   2308 ;	./libs/menu_lib.c: 165: menu_border_paragraph(menu);
      008F13 A6 04            [ 1] 2309 	ld	a, #0x04
      008F15 CD 8B 1F         [ 4] 2310 	call	_menu_border_paragraph
                                   2311 ;	./libs/menu_lib.c: 167: ssd1306_buffer_write(10,12,ttf_eng_m);
      008F18 4B 83            [ 1] 2312 	push	#<(_ttf_eng_m+0)
      008F1A 4B 00            [ 1] 2313 	push	#((_ttf_eng_m+0) >> 8)
      008F1C 4B 0C            [ 1] 2314 	push	#0x0c
      008F1E 4B 00            [ 1] 2315 	push	#0x00
      008F20 AE 00 0A         [ 2] 2316 	ldw	x, #0x000a
      008F23 CD 89 D7         [ 4] 2317 	call	_ssd1306_buffer_write
                                   2318 ;	./libs/menu_lib.c: 168: ssd1306_buffer_write(18,12,ttf_eng_e);
      008F26 4B 43            [ 1] 2319 	push	#<(_ttf_eng_e+0)
      008F28 4B 00            [ 1] 2320 	push	#((_ttf_eng_e+0) >> 8)
      008F2A 4B 0C            [ 1] 2321 	push	#0x0c
      008F2C 4B 00            [ 1] 2322 	push	#0x00
      008F2E AE 00 12         [ 2] 2323 	ldw	x, #0x0012
      008F31 CD 89 D7         [ 4] 2324 	call	_ssd1306_buffer_write
                                   2325 ;	./libs/menu_lib.c: 169: ssd1306_buffer_write(26,12,ttf_eng_n);
      008F34 4B 8B            [ 1] 2326 	push	#<(_ttf_eng_n+0)
      008F36 4B 00            [ 1] 2327 	push	#((_ttf_eng_n+0) >> 8)
      008F38 4B 0C            [ 1] 2328 	push	#0x0c
      008F3A 4B 00            [ 1] 2329 	push	#0x00
      008F3C AE 00 1A         [ 2] 2330 	ldw	x, #0x001a
      008F3F CD 89 D7         [ 4] 2331 	call	_ssd1306_buffer_write
                                   2332 ;	./libs/menu_lib.c: 170: ssd1306_buffer_write(34,12,ttf_eng_u);
      008F42 4B C3            [ 1] 2333 	push	#<(_ttf_eng_u+0)
      008F44 4B 00            [ 1] 2334 	push	#((_ttf_eng_u+0) >> 8)
      008F46 4B 0C            [ 1] 2335 	push	#0x0c
      008F48 4B 00            [ 1] 2336 	push	#0x00
      008F4A AE 00 22         [ 2] 2337 	ldw	x, #0x0022
      008F4D CD 89 D7         [ 4] 2338 	call	_ssd1306_buffer_write
                                   2339 ;	./libs/menu_lib.c: 172: ssd1306_buffer_write(48,4,ttf_eng_c);
      008F50 4B 33            [ 1] 2340 	push	#<(_ttf_eng_c+0)
      008F52 4B 00            [ 1] 2341 	push	#((_ttf_eng_c+0) >> 8)
      008F54 4B 04            [ 1] 2342 	push	#0x04
      008F56 4B 00            [ 1] 2343 	push	#0x00
      008F58 AE 00 30         [ 2] 2344 	ldw	x, #0x0030
      008F5B CD 89 D7         [ 4] 2345 	call	_ssd1306_buffer_write
                                   2346 ;	./libs/menu_lib.c: 173: ssd1306_buffer_write(56,4,ttf_eng_o);
      008F5E 4B 93            [ 1] 2347 	push	#<(_ttf_eng_o+0)
      008F60 4B 00            [ 1] 2348 	push	#((_ttf_eng_o+0) >> 8)
      008F62 4B 04            [ 1] 2349 	push	#0x04
      008F64 4B 00            [ 1] 2350 	push	#0x00
      008F66 AE 00 38         [ 2] 2351 	ldw	x, #0x0038
      008F69 CD 89 D7         [ 4] 2352 	call	_ssd1306_buffer_write
                                   2353 ;	./libs/menu_lib.c: 174: ssd1306_buffer_write(64,4,ttf_eng_l);
      008F6C 4B 7B            [ 1] 2354 	push	#<(_ttf_eng_l+0)
      008F6E 4B 00            [ 1] 2355 	push	#((_ttf_eng_l+0) >> 8)
      008F70 4B 04            [ 1] 2356 	push	#0x04
      008F72 4B 00            [ 1] 2357 	push	#0x00
      008F74 AE 00 40         [ 2] 2358 	ldw	x, #0x0040
      008F77 CD 89 D7         [ 4] 2359 	call	_ssd1306_buffer_write
                                   2360 ;	./libs/menu_lib.c: 175: ssd1306_buffer_write(72,4,ttf_eng_o);
      008F7A 4B 93            [ 1] 2361 	push	#<(_ttf_eng_o+0)
      008F7C 4B 00            [ 1] 2362 	push	#((_ttf_eng_o+0) >> 8)
      008F7E 4B 04            [ 1] 2363 	push	#0x04
      008F80 4B 00            [ 1] 2364 	push	#0x00
      008F82 AE 00 48         [ 2] 2365 	ldw	x, #0x0048
      008F85 CD 89 D7         [ 4] 2366 	call	_ssd1306_buffer_write
                                   2367 ;	./libs/menu_lib.c: 176: ssd1306_buffer_write(80,4,ttf_eng_r);
      008F88 4B AB            [ 1] 2368 	push	#<(_ttf_eng_r+0)
      008F8A 4B 00            [ 1] 2369 	push	#((_ttf_eng_r+0) >> 8)
      008F8C 4B 04            [ 1] 2370 	push	#0x04
      008F8E 4B 00            [ 1] 2371 	push	#0x00
      008F90 AE 00 50         [ 2] 2372 	ldw	x, #0x0050
      008F93 CD 89 D7         [ 4] 2373 	call	_ssd1306_buffer_write
                                   2374 ;	./libs/menu_lib.c: 177: ssd1306_buffer_write(114,4,ttf_line_left);
      008F96 4B 74            [ 1] 2375 	push	#<(_ttf_line_left+0)
      008F98 4B 01            [ 1] 2376 	push	#((_ttf_line_left+0) >> 8)
      008F9A 4B 04            [ 1] 2377 	push	#0x04
      008F9C 4B 00            [ 1] 2378 	push	#0x00
      008F9E AE 00 72         [ 2] 2379 	ldw	x, #0x0072
      008FA1 CD 89 D7         [ 4] 2380 	call	_ssd1306_buffer_write
                                   2381 ;	./libs/menu_lib.c: 179: ssd1306_buffer_write(48,12,ttf_eng_s);
      008FA4 4B B3            [ 1] 2382 	push	#<(_ttf_eng_s+0)
      008FA6 4B 00            [ 1] 2383 	push	#((_ttf_eng_s+0) >> 8)
      008FA8 4B 0C            [ 1] 2384 	push	#0x0c
      008FAA 4B 00            [ 1] 2385 	push	#0x00
      008FAC AE 00 30         [ 2] 2386 	ldw	x, #0x0030
      008FAF CD 89 D7         [ 4] 2387 	call	_ssd1306_buffer_write
                                   2388 ;	./libs/menu_lib.c: 180: ssd1306_buffer_write(56,12,ttf_eng_e);
      008FB2 4B 43            [ 1] 2389 	push	#<(_ttf_eng_e+0)
      008FB4 4B 00            [ 1] 2390 	push	#((_ttf_eng_e+0) >> 8)
      008FB6 4B 0C            [ 1] 2391 	push	#0x0c
      008FB8 4B 00            [ 1] 2392 	push	#0x00
      008FBA AE 00 38         [ 2] 2393 	ldw	x, #0x0038
      008FBD CD 89 D7         [ 4] 2394 	call	_ssd1306_buffer_write
                                   2395 ;	./libs/menu_lib.c: 181: ssd1306_buffer_write(64,12,ttf_eng_g);
      008FC0 4B 53            [ 1] 2396 	push	#<(_ttf_eng_g+0)
      008FC2 4B 00            [ 1] 2397 	push	#((_ttf_eng_g+0) >> 8)
      008FC4 4B 0C            [ 1] 2398 	push	#0x0c
      008FC6 4B 00            [ 1] 2399 	push	#0x00
      008FC8 AE 00 40         [ 2] 2400 	ldw	x, #0x0040
      008FCB CD 89 D7         [ 4] 2401 	call	_ssd1306_buffer_write
                                   2402 ;	./libs/menu_lib.c: 182: ssd1306_buffer_write(72,12,ttf_eng_m);
      008FCE 4B 83            [ 1] 2403 	push	#<(_ttf_eng_m+0)
      008FD0 4B 00            [ 1] 2404 	push	#((_ttf_eng_m+0) >> 8)
      008FD2 4B 0C            [ 1] 2405 	push	#0x0c
      008FD4 4B 00            [ 1] 2406 	push	#0x00
      008FD6 AE 00 48         [ 2] 2407 	ldw	x, #0x0048
      008FD9 CD 89 D7         [ 4] 2408 	call	_ssd1306_buffer_write
                                   2409 ;	./libs/menu_lib.c: 183: ssd1306_buffer_write(80,12,ttf_eng_e);
      008FDC 4B 43            [ 1] 2410 	push	#<(_ttf_eng_e+0)
      008FDE 4B 00            [ 1] 2411 	push	#((_ttf_eng_e+0) >> 8)
      008FE0 4B 0C            [ 1] 2412 	push	#0x0c
      008FE2 4B 00            [ 1] 2413 	push	#0x00
      008FE4 AE 00 50         [ 2] 2414 	ldw	x, #0x0050
      008FE7 CD 89 D7         [ 4] 2415 	call	_ssd1306_buffer_write
                                   2416 ;	./libs/menu_lib.c: 184: ssd1306_buffer_write(88,12,ttf_eng_n);
      008FEA 4B 8B            [ 1] 2417 	push	#<(_ttf_eng_n+0)
      008FEC 4B 00            [ 1] 2418 	push	#((_ttf_eng_n+0) >> 8)
      008FEE 4B 0C            [ 1] 2419 	push	#0x0c
      008FF0 4B 00            [ 1] 2420 	push	#0x00
      008FF2 AE 00 58         [ 2] 2421 	ldw	x, #0x0058
      008FF5 CD 89 D7         [ 4] 2422 	call	_ssd1306_buffer_write
                                   2423 ;	./libs/menu_lib.c: 185: ssd1306_buffer_write(96,12,ttf_eng_t);
      008FF8 4B BB            [ 1] 2424 	push	#<(_ttf_eng_t+0)
      008FFA 4B 00            [ 1] 2425 	push	#((_ttf_eng_t+0) >> 8)
      008FFC 4B 0C            [ 1] 2426 	push	#0x0c
      008FFE 4B 00            [ 1] 2427 	push	#0x00
      009000 AE 00 60         [ 2] 2428 	ldw	x, #0x0060
      009003 CD 89 D7         [ 4] 2429 	call	_ssd1306_buffer_write
                                   2430 ;	./libs/menu_lib.c: 186: ssd1306_buffer_write(114,12,ttf_void);
      009006 4B F4            [ 1] 2431 	push	#<(_ttf_void+0)
      009008 4B 00            [ 1] 2432 	push	#((_ttf_void+0) >> 8)
      00900A 4B 0C            [ 1] 2433 	push	#0x0c
      00900C 4B 00            [ 1] 2434 	push	#0x00
      00900E AE 00 72         [ 2] 2435 	ldw	x, #0x0072
      009011 CD 89 D7         [ 4] 2436 	call	_ssd1306_buffer_write
                                   2437 ;	./libs/menu_lib.c: 188: ssd1306_buffer_write(48,20,ttf_eng_s);
      009014 4B B3            [ 1] 2438 	push	#<(_ttf_eng_s+0)
      009016 4B 00            [ 1] 2439 	push	#((_ttf_eng_s+0) >> 8)
      009018 4B 14            [ 1] 2440 	push	#0x14
      00901A 4B 00            [ 1] 2441 	push	#0x00
      00901C AE 00 30         [ 2] 2442 	ldw	x, #0x0030
      00901F CD 89 D7         [ 4] 2443 	call	_ssd1306_buffer_write
                                   2444 ;	./libs/menu_lib.c: 189: ssd1306_buffer_write(56,20,ttf_eng_e);
      009022 4B 43            [ 1] 2445 	push	#<(_ttf_eng_e+0)
      009024 4B 00            [ 1] 2446 	push	#((_ttf_eng_e+0) >> 8)
      009026 4B 14            [ 1] 2447 	push	#0x14
      009028 4B 00            [ 1] 2448 	push	#0x00
      00902A AE 00 38         [ 2] 2449 	ldw	x, #0x0038
      00902D CD 89 D7         [ 4] 2450 	call	_ssd1306_buffer_write
                                   2451 ;	./libs/menu_lib.c: 190: ssd1306_buffer_write(64,20,ttf_eng_t);
      009030 4B BB            [ 1] 2452 	push	#<(_ttf_eng_t+0)
      009032 4B 00            [ 1] 2453 	push	#((_ttf_eng_t+0) >> 8)
      009034 4B 14            [ 1] 2454 	push	#0x14
      009036 4B 00            [ 1] 2455 	push	#0x00
      009038 AE 00 40         [ 2] 2456 	ldw	x, #0x0040
      00903B CD 89 D7         [ 4] 2457 	call	_ssd1306_buffer_write
                                   2458 ;	./libs/menu_lib.c: 191: ssd1306_buffer_write(72,20,ttf_eng_t);
      00903E 4B BB            [ 1] 2459 	push	#<(_ttf_eng_t+0)
      009040 4B 00            [ 1] 2460 	push	#((_ttf_eng_t+0) >> 8)
      009042 4B 14            [ 1] 2461 	push	#0x14
      009044 4B 00            [ 1] 2462 	push	#0x00
      009046 AE 00 48         [ 2] 2463 	ldw	x, #0x0048
      009049 CD 89 D7         [ 4] 2464 	call	_ssd1306_buffer_write
                                   2465 ;	./libs/menu_lib.c: 192: ssd1306_buffer_write(80,20,ttf_eng_i);
      00904C 4B 63            [ 1] 2466 	push	#<(_ttf_eng_i+0)
      00904E 4B 00            [ 1] 2467 	push	#((_ttf_eng_i+0) >> 8)
      009050 4B 14            [ 1] 2468 	push	#0x14
      009052 4B 00            [ 1] 2469 	push	#0x00
      009054 AE 00 50         [ 2] 2470 	ldw	x, #0x0050
      009057 CD 89 D7         [ 4] 2471 	call	_ssd1306_buffer_write
                                   2472 ;	./libs/menu_lib.c: 193: ssd1306_buffer_write(88,20,ttf_eng_n);
      00905A 4B 8B            [ 1] 2473 	push	#<(_ttf_eng_n+0)
      00905C 4B 00            [ 1] 2474 	push	#((_ttf_eng_n+0) >> 8)
      00905E 4B 14            [ 1] 2475 	push	#0x14
      009060 4B 00            [ 1] 2476 	push	#0x00
      009062 AE 00 58         [ 2] 2477 	ldw	x, #0x0058
      009065 CD 89 D7         [ 4] 2478 	call	_ssd1306_buffer_write
                                   2479 ;	./libs/menu_lib.c: 194: ssd1306_buffer_write(96,20,ttf_eng_g);
      009068 4B 53            [ 1] 2480 	push	#<(_ttf_eng_g+0)
      00906A 4B 00            [ 1] 2481 	push	#((_ttf_eng_g+0) >> 8)
      00906C 4B 14            [ 1] 2482 	push	#0x14
      00906E 4B 00            [ 1] 2483 	push	#0x00
      009070 AE 00 60         [ 2] 2484 	ldw	x, #0x0060
      009073 CD 89 D7         [ 4] 2485 	call	_ssd1306_buffer_write
                                   2486 ;	./libs/menu_lib.c: 195: ssd1306_buffer_write(104,20,ttf_eng_s);
      009076 4B B3            [ 1] 2487 	push	#<(_ttf_eng_s+0)
      009078 4B 00            [ 1] 2488 	push	#((_ttf_eng_s+0) >> 8)
      00907A 4B 14            [ 1] 2489 	push	#0x14
      00907C 4B 00            [ 1] 2490 	push	#0x00
      00907E AE 00 68         [ 2] 2491 	ldw	x, #0x0068
      009081 CD 89 D7         [ 4] 2492 	call	_ssd1306_buffer_write
                                   2493 ;	./libs/menu_lib.c: 196: ssd1306_buffer_write(114,20,ttf_void);
      009084 4B F4            [ 1] 2494 	push	#<(_ttf_void+0)
      009086 4B 00            [ 1] 2495 	push	#((_ttf_void+0) >> 8)
      009088 4B 14            [ 1] 2496 	push	#0x14
      00908A 4B 00            [ 1] 2497 	push	#0x00
      00908C AE 00 72         [ 2] 2498 	ldw	x, #0x0072
      00908F CD 89 D7         [ 4] 2499 	call	_ssd1306_buffer_write
                                   2500 ;	./libs/menu_lib.c: 198: ssd1306_send_buffer();
                                   2501 ;	./libs/menu_lib.c: 199: break;
      009092 CC 89 82         [ 2] 2502 	jp	_ssd1306_send_buffer
                                   2503 ;	./libs/menu_lib.c: 200: case color:
      009095                       2504 00102$:
                                   2505 ;	./libs/menu_lib.c: 201: ssd1306_buffer_clean();
      009095 CD 89 75         [ 4] 2506 	call	_ssd1306_buffer_clean
                                   2507 ;	./libs/menu_lib.c: 202: menu_border();
      009098 CD 8A 72         [ 4] 2508 	call	_menu_border
                                   2509 ;	./libs/menu_lib.c: 203: menu_border_paragraph(color);
      00909B A6 05            [ 1] 2510 	ld	a, #0x05
      00909D CD 8B 1F         [ 4] 2511 	call	_menu_border_paragraph
                                   2512 ;	./libs/menu_lib.c: 205: ssd1306_buffer_write(10,12,ttf_eng_c);
      0090A0 4B 33            [ 1] 2513 	push	#<(_ttf_eng_c+0)
      0090A2 4B 00            [ 1] 2514 	push	#((_ttf_eng_c+0) >> 8)
      0090A4 4B 0C            [ 1] 2515 	push	#0x0c
      0090A6 4B 00            [ 1] 2516 	push	#0x00
      0090A8 AE 00 0A         [ 2] 2517 	ldw	x, #0x000a
      0090AB CD 89 D7         [ 4] 2518 	call	_ssd1306_buffer_write
                                   2519 ;	./libs/menu_lib.c: 206: ssd1306_buffer_write(18,12,ttf_eng_o);
      0090AE 4B 93            [ 1] 2520 	push	#<(_ttf_eng_o+0)
      0090B0 4B 00            [ 1] 2521 	push	#((_ttf_eng_o+0) >> 8)
      0090B2 4B 0C            [ 1] 2522 	push	#0x0c
      0090B4 4B 00            [ 1] 2523 	push	#0x00
      0090B6 AE 00 12         [ 2] 2524 	ldw	x, #0x0012
      0090B9 CD 89 D7         [ 4] 2525 	call	_ssd1306_buffer_write
                                   2526 ;	./libs/menu_lib.c: 207: ssd1306_buffer_write(26,12,ttf_eng_l);
      0090BC 4B 7B            [ 1] 2527 	push	#<(_ttf_eng_l+0)
      0090BE 4B 00            [ 1] 2528 	push	#((_ttf_eng_l+0) >> 8)
      0090C0 4B 0C            [ 1] 2529 	push	#0x0c
      0090C2 4B 00            [ 1] 2530 	push	#0x00
      0090C4 AE 00 1A         [ 2] 2531 	ldw	x, #0x001a
      0090C7 CD 89 D7         [ 4] 2532 	call	_ssd1306_buffer_write
                                   2533 ;	./libs/menu_lib.c: 208: ssd1306_buffer_write(34,12,ttf_eng_o);
      0090CA 4B 93            [ 1] 2534 	push	#<(_ttf_eng_o+0)
      0090CC 4B 00            [ 1] 2535 	push	#((_ttf_eng_o+0) >> 8)
      0090CE 4B 0C            [ 1] 2536 	push	#0x0c
      0090D0 4B 00            [ 1] 2537 	push	#0x00
      0090D2 AE 00 22         [ 2] 2538 	ldw	x, #0x0022
      0090D5 CD 89 D7         [ 4] 2539 	call	_ssd1306_buffer_write
                                   2540 ;	./libs/menu_lib.c: 209: ssd1306_buffer_write(42,12,ttf_eng_r);
      0090D8 4B AB            [ 1] 2541 	push	#<(_ttf_eng_r+0)
      0090DA 4B 00            [ 1] 2542 	push	#((_ttf_eng_r+0) >> 8)
      0090DC 4B 0C            [ 1] 2543 	push	#0x0c
      0090DE 4B 00            [ 1] 2544 	push	#0x00
      0090E0 AE 00 2A         [ 2] 2545 	ldw	x, #0x002a
      0090E3 CD 89 D7         [ 4] 2546 	call	_ssd1306_buffer_write
                                   2547 ;	./libs/menu_lib.c: 211: menu_set_item_menu(red);
      0090E6 A6 01            [ 1] 2548 	ld	a, #0x01
      0090E8 CD 8C D0         [ 4] 2549 	call	_menu_set_item_menu
                                   2550 ;	./libs/menu_lib.c: 213: ssd1306_send_buffer();
                                   2551 ;	./libs/menu_lib.c: 214: break;
      0090EB CC 89 82         [ 2] 2552 	jp	_ssd1306_send_buffer
                                   2553 ;	./libs/menu_lib.c: 215: case segment:
      0090EE                       2554 00103$:
                                   2555 ;	./libs/menu_lib.c: 216: ssd1306_buffer_clean();
      0090EE CD 89 75         [ 4] 2556 	call	_ssd1306_buffer_clean
                                   2557 ;	./libs/menu_lib.c: 217: menu_border();
      0090F1 CD 8A 72         [ 4] 2558 	call	_menu_border
                                   2559 ;	./libs/menu_lib.c: 218: menu_border_paragraph(segment);
      0090F4 A6 07            [ 1] 2560 	ld	a, #0x07
      0090F6 CD 8B 1F         [ 4] 2561 	call	_menu_border_paragraph
                                   2562 ;	./libs/menu_lib.c: 220: ssd1306_buffer_write(10,12,ttf_eng_s);
      0090F9 4B B3            [ 1] 2563 	push	#<(_ttf_eng_s+0)
      0090FB 4B 00            [ 1] 2564 	push	#((_ttf_eng_s+0) >> 8)
      0090FD 4B 0C            [ 1] 2565 	push	#0x0c
      0090FF 4B 00            [ 1] 2566 	push	#0x00
      009101 AE 00 0A         [ 2] 2567 	ldw	x, #0x000a
      009104 CD 89 D7         [ 4] 2568 	call	_ssd1306_buffer_write
                                   2569 ;	./libs/menu_lib.c: 221: ssd1306_buffer_write(18,12,ttf_eng_e);
      009107 4B 43            [ 1] 2570 	push	#<(_ttf_eng_e+0)
      009109 4B 00            [ 1] 2571 	push	#((_ttf_eng_e+0) >> 8)
      00910B 4B 0C            [ 1] 2572 	push	#0x0c
      00910D 4B 00            [ 1] 2573 	push	#0x00
      00910F AE 00 12         [ 2] 2574 	ldw	x, #0x0012
      009112 CD 89 D7         [ 4] 2575 	call	_ssd1306_buffer_write
                                   2576 ;	./libs/menu_lib.c: 222: ssd1306_buffer_write(26,12,ttf_eng_g);
      009115 4B 53            [ 1] 2577 	push	#<(_ttf_eng_g+0)
      009117 4B 00            [ 1] 2578 	push	#((_ttf_eng_g+0) >> 8)
      009119 4B 0C            [ 1] 2579 	push	#0x0c
      00911B 4B 00            [ 1] 2580 	push	#0x00
      00911D AE 00 1A         [ 2] 2581 	ldw	x, #0x001a
      009120 CD 89 D7         [ 4] 2582 	call	_ssd1306_buffer_write
                                   2583 ;	./libs/menu_lib.c: 223: ssd1306_buffer_write(34,12,ttf_eng_m);
      009123 4B 83            [ 1] 2584 	push	#<(_ttf_eng_m+0)
      009125 4B 00            [ 1] 2585 	push	#((_ttf_eng_m+0) >> 8)
      009127 4B 0C            [ 1] 2586 	push	#0x0c
      009129 4B 00            [ 1] 2587 	push	#0x00
      00912B AE 00 22         [ 2] 2588 	ldw	x, #0x0022
      00912E CD 89 D7         [ 4] 2589 	call	_ssd1306_buffer_write
                                   2590 ;	./libs/menu_lib.c: 224: ssd1306_buffer_write(42,12,ttf_eng_e);
      009131 4B 43            [ 1] 2591 	push	#<(_ttf_eng_e+0)
      009133 4B 00            [ 1] 2592 	push	#((_ttf_eng_e+0) >> 8)
      009135 4B 0C            [ 1] 2593 	push	#0x0c
      009137 4B 00            [ 1] 2594 	push	#0x00
      009139 AE 00 2A         [ 2] 2595 	ldw	x, #0x002a
      00913C CD 89 D7         [ 4] 2596 	call	_ssd1306_buffer_write
                                   2597 ;	./libs/menu_lib.c: 225: ssd1306_buffer_write(50,12,ttf_eng_n);
      00913F 4B 8B            [ 1] 2598 	push	#<(_ttf_eng_n+0)
      009141 4B 00            [ 1] 2599 	push	#((_ttf_eng_n+0) >> 8)
      009143 4B 0C            [ 1] 2600 	push	#0x0c
      009145 4B 00            [ 1] 2601 	push	#0x00
      009147 AE 00 32         [ 2] 2602 	ldw	x, #0x0032
      00914A CD 89 D7         [ 4] 2603 	call	_ssd1306_buffer_write
                                   2604 ;	./libs/menu_lib.c: 226: ssd1306_buffer_write(58,12,ttf_eng_t);
      00914D 4B BB            [ 1] 2605 	push	#<(_ttf_eng_t+0)
      00914F 4B 00            [ 1] 2606 	push	#((_ttf_eng_t+0) >> 8)
      009151 4B 0C            [ 1] 2607 	push	#0x0c
      009153 4B 00            [ 1] 2608 	push	#0x00
      009155 AE 00 3A         [ 2] 2609 	ldw	x, #0x003a
      009158 CD 89 D7         [ 4] 2610 	call	_ssd1306_buffer_write
                                   2611 ;	./libs/menu_lib.c: 228: menu_set_item_menu(first);
      00915B A6 04            [ 1] 2612 	ld	a, #0x04
      00915D CD 8C D0         [ 4] 2613 	call	_menu_set_item_menu
                                   2614 ;	./libs/menu_lib.c: 230: ssd1306_send_buffer();
                                   2615 ;	./libs/menu_lib.c: 233: break;
      009160 CC 89 82         [ 2] 2616 	jp	_ssd1306_send_buffer
                                   2617 ;	./libs/menu_lib.c: 234: case settings:
      009163                       2618 00104$:
                                   2619 ;	./libs/menu_lib.c: 235: ssd1306_buffer_clean();
      009163 CD 89 75         [ 4] 2620 	call	_ssd1306_buffer_clean
                                   2621 ;	./libs/menu_lib.c: 236: menu_border();
      009166 CD 8A 72         [ 4] 2622 	call	_menu_border
                                   2623 ;	./libs/menu_lib.c: 237: menu_border_paragraph(settings);
      009169 A6 06            [ 1] 2624 	ld	a, #0x06
      00916B CD 8B 1F         [ 4] 2625 	call	_menu_border_paragraph
                                   2626 ;	./libs/menu_lib.c: 239: ssd1306_buffer_write(10,12,ttf_eng_s);
      00916E 4B B3            [ 1] 2627 	push	#<(_ttf_eng_s+0)
      009170 4B 00            [ 1] 2628 	push	#((_ttf_eng_s+0) >> 8)
      009172 4B 0C            [ 1] 2629 	push	#0x0c
      009174 4B 00            [ 1] 2630 	push	#0x00
      009176 AE 00 0A         [ 2] 2631 	ldw	x, #0x000a
      009179 CD 89 D7         [ 4] 2632 	call	_ssd1306_buffer_write
                                   2633 ;	./libs/menu_lib.c: 240: ssd1306_buffer_write(18,12,ttf_eng_e);
      00917C 4B 43            [ 1] 2634 	push	#<(_ttf_eng_e+0)
      00917E 4B 00            [ 1] 2635 	push	#((_ttf_eng_e+0) >> 8)
      009180 4B 0C            [ 1] 2636 	push	#0x0c
      009182 4B 00            [ 1] 2637 	push	#0x00
      009184 AE 00 12         [ 2] 2638 	ldw	x, #0x0012
      009187 CD 89 D7         [ 4] 2639 	call	_ssd1306_buffer_write
                                   2640 ;	./libs/menu_lib.c: 241: ssd1306_buffer_write(26,12,ttf_eng_t);
      00918A 4B BB            [ 1] 2641 	push	#<(_ttf_eng_t+0)
      00918C 4B 00            [ 1] 2642 	push	#((_ttf_eng_t+0) >> 8)
      00918E 4B 0C            [ 1] 2643 	push	#0x0c
      009190 4B 00            [ 1] 2644 	push	#0x00
      009192 AE 00 1A         [ 2] 2645 	ldw	x, #0x001a
      009195 CD 89 D7         [ 4] 2646 	call	_ssd1306_buffer_write
                                   2647 ;	./libs/menu_lib.c: 242: ssd1306_buffer_write(34,12,ttf_eng_t);
      009198 4B BB            [ 1] 2648 	push	#<(_ttf_eng_t+0)
      00919A 4B 00            [ 1] 2649 	push	#((_ttf_eng_t+0) >> 8)
      00919C 4B 0C            [ 1] 2650 	push	#0x0c
      00919E 4B 00            [ 1] 2651 	push	#0x00
      0091A0 AE 00 22         [ 2] 2652 	ldw	x, #0x0022
      0091A3 CD 89 D7         [ 4] 2653 	call	_ssd1306_buffer_write
                                   2654 ;	./libs/menu_lib.c: 243: ssd1306_buffer_write(42,12,ttf_eng_i);
      0091A6 4B 63            [ 1] 2655 	push	#<(_ttf_eng_i+0)
      0091A8 4B 00            [ 1] 2656 	push	#((_ttf_eng_i+0) >> 8)
      0091AA 4B 0C            [ 1] 2657 	push	#0x0c
      0091AC 4B 00            [ 1] 2658 	push	#0x00
      0091AE AE 00 2A         [ 2] 2659 	ldw	x, #0x002a
      0091B1 CD 89 D7         [ 4] 2660 	call	_ssd1306_buffer_write
                                   2661 ;	./libs/menu_lib.c: 244: ssd1306_buffer_write(50,12,ttf_eng_n);
      0091B4 4B 8B            [ 1] 2662 	push	#<(_ttf_eng_n+0)
      0091B6 4B 00            [ 1] 2663 	push	#((_ttf_eng_n+0) >> 8)
      0091B8 4B 0C            [ 1] 2664 	push	#0x0c
      0091BA 4B 00            [ 1] 2665 	push	#0x00
      0091BC AE 00 32         [ 2] 2666 	ldw	x, #0x0032
      0091BF CD 89 D7         [ 4] 2667 	call	_ssd1306_buffer_write
                                   2668 ;	./libs/menu_lib.c: 245: ssd1306_buffer_write(58,12,ttf_eng_g);
      0091C2 4B 53            [ 1] 2669 	push	#<(_ttf_eng_g+0)
      0091C4 4B 00            [ 1] 2670 	push	#((_ttf_eng_g+0) >> 8)
      0091C6 4B 0C            [ 1] 2671 	push	#0x0c
      0091C8 4B 00            [ 1] 2672 	push	#0x00
      0091CA AE 00 3A         [ 2] 2673 	ldw	x, #0x003a
      0091CD CD 89 D7         [ 4] 2674 	call	_ssd1306_buffer_write
                                   2675 ;	./libs/menu_lib.c: 246: ssd1306_buffer_write(66,12,ttf_eng_s);
      0091D0 4B B3            [ 1] 2676 	push	#<(_ttf_eng_s+0)
      0091D2 4B 00            [ 1] 2677 	push	#((_ttf_eng_s+0) >> 8)
      0091D4 4B 0C            [ 1] 2678 	push	#0x0c
      0091D6 4B 00            [ 1] 2679 	push	#0x00
      0091D8 AE 00 42         [ 2] 2680 	ldw	x, #0x0042
      0091DB CD 89 D7         [ 4] 2681 	call	_ssd1306_buffer_write
                                   2682 ;	./libs/menu_lib.c: 248: menu_set_item_menu(sens);
      0091DE A6 06            [ 1] 2683 	ld	a, #0x06
      0091E0 CD 8C D0         [ 4] 2684 	call	_menu_set_item_menu
                                   2685 ;	./libs/menu_lib.c: 250: ssd1306_send_buffer();
                                   2686 ;	./libs/menu_lib.c: 252: }
                                   2687 ;	./libs/menu_lib.c: 253: }
      0091E3 CC 89 82         [ 2] 2688 	jp	_ssd1306_send_buffer
                                   2689 ;	./libs/tmr2_lib.c: 3: void tmr2_irq(void) __interrupt(TIM2_vector)
                                   2690 ;	-----------------------------------------
                                   2691 ;	 function tmr2_irq
                                   2692 ;	-----------------------------------------
      0091E6                       2693 _tmr2_irq:
      0091E6 4F               [ 1] 2694 	clr	a
      0091E7 62               [ 2] 2695 	div	x, a
                                   2696 ;	./libs/tmr2_lib.c: 6: disableInterrupts();
      0091E8 9B               [ 1] 2697 	sim
                                   2698 ;	./libs/tmr2_lib.c: 7: TIM2_IRQ.all = 0;//обнуление флагов регистров
      0091E9 35 00 03 8C      [ 1] 2699 	mov	_TIM2_IRQ+0, #0x00
                                   2700 ;	./libs/tmr2_lib.c: 9: if(TIM2_SR1 -> UIF)//прерывание таймера
      0091ED AE 53 04         [ 2] 2701 	ldw	x, #0x5304
      0091F0 F6               [ 1] 2702 	ld	a, (x)
      0091F1 A4 01            [ 1] 2703 	and	a, #0x01
      0091F3 27 0B            [ 1] 2704 	jreq	00102$
                                   2705 ;	./libs/tmr2_lib.c: 11: TIM2_IRQ.UIF = 1;
      0091F5 72 1E 03 8C      [ 1] 2706 	bset	_TIM2_IRQ+0, #7
                                   2707 ;	./libs/tmr2_lib.c: 12: TIM2_IER -> UIE = 0;
      0091F9 AE 53 03         [ 2] 2708 	ldw	x, #0x5303
      0091FC F6               [ 1] 2709 	ld	a, (x)
      0091FD A4 FE            [ 1] 2710 	and	a, #0xfe
      0091FF F7               [ 1] 2711 	ld	(x), a
      009200                       2712 00102$:
                                   2713 ;	./libs/tmr2_lib.c: 14: enableInterrupts();
      009200 9A               [ 1] 2714 	rim
                                   2715 ;	./libs/tmr2_lib.c: 15: }
      009201 80               [11] 2716 	iret
                                   2717 ;	./libs/tmr2_lib.c: 16: void delay_s(uint8_t ticks)
                                   2718 ;	-----------------------------------------
                                   2719 ;	 function delay_s
                                   2720 ;	-----------------------------------------
      009202                       2721 _delay_s:
      009202 52 07            [ 2] 2722 	sub	sp, #7
      009204 6B 05            [ 1] 2723 	ld	(0x05, sp), a
                                   2724 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks+1;i++)//блять в душе не ебу почему так сработало, но почему-то если на один больше, то таймер нормально работает
      009206 5F               [ 1] 2725 	clrw	x
      009207 1F 06            [ 2] 2726 	ldw	(0x06, sp), x
      009209                       2727 00106$:
      009209 7B 05            [ 1] 2728 	ld	a, (0x05, sp)
      00920B 6B 02            [ 1] 2729 	ld	(0x02, sp), a
      00920D 0F 01            [ 1] 2730 	clr	(0x01, sp)
      00920F 1E 01            [ 2] 2731 	ldw	x, (0x01, sp)
      009211 5C               [ 1] 2732 	incw	x
      009212 1F 03            [ 2] 2733 	ldw	(0x03, sp), x
      009214 1E 06            [ 2] 2734 	ldw	x, (0x06, sp)
      009216 13 03            [ 2] 2735 	cpw	x, (0x03, sp)
      009218 2E 2A            [ 1] 2736 	jrsge	00104$
                                   2737 ;	./libs/tmr2_lib.c: 20: TIM2_SR1 -> UIF = 0;
      00921A 72 11 53 04      [ 1] 2738 	bres	0x5304, #0
                                   2739 ;	./libs/tmr2_lib.c: 21: TIM2_ARRH->ARR = 0x03;
      00921E 35 03 53 0F      [ 1] 2740 	mov	0x530f+0, #0x03
                                   2741 ;	./libs/tmr2_lib.c: 22: TIM2_ARRL->ARR = 0xD1;
      009222 35 D1 53 10      [ 1] 2742 	mov	0x5310+0, #0xd1
                                   2743 ;	./libs/tmr2_lib.c: 23: TIM2_PSCR -> PSC = 0x0E;
      009226 C6 53 0E         [ 1] 2744 	ld	a, 0x530e
      009229 A4 F0            [ 1] 2745 	and	a, #0xf0
      00922B AA 0E            [ 1] 2746 	or	a, #0x0e
      00922D C7 53 0E         [ 1] 2747 	ld	0x530e, a
                                   2748 ;	./libs/tmr2_lib.c: 24: TIM2_IER -> UIE = 1;
      009230 72 10 53 03      [ 1] 2749 	bset	0x5303, #0
                                   2750 ;	./libs/tmr2_lib.c: 25: TIM2_CR1-> CEN = 1;
      009234 72 10 53 00      [ 1] 2751 	bset	0x5300, #0
                                   2752 ;	./libs/tmr2_lib.c: 26: while(TIM2_IER -> UIE);	
      009238                       2753 00101$:
      009238 72 00 53 03 FB   [ 2] 2754 	btjt	0x5303, #0, 00101$
                                   2755 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks+1;i++)//блять в душе не ебу почему так сработало, но почему-то если на один больше, то таймер нормально работает
      00923D 1E 06            [ 2] 2756 	ldw	x, (0x06, sp)
      00923F 5C               [ 1] 2757 	incw	x
      009240 1F 06            [ 2] 2758 	ldw	(0x06, sp), x
      009242 20 C5            [ 2] 2759 	jra	00106$
      009244                       2760 00104$:
                                   2761 ;	./libs/tmr2_lib.c: 28: TIM2_CR1-> CEN = 0;
      009244 72 11 53 00      [ 1] 2762 	bres	0x5300, #0
                                   2763 ;	./libs/tmr2_lib.c: 29: }
      009248 5B 07            [ 2] 2764 	addw	sp, #7
      00924A 81               [ 4] 2765 	ret
                                   2766 ;	./libs/tmr2_lib.c: 30: void delay_ms(uint8_t ticks)
                                   2767 ;	-----------------------------------------
                                   2768 ;	 function delay_ms
                                   2769 ;	-----------------------------------------
      00924B                       2770 _delay_ms:
      00924B 52 07            [ 2] 2771 	sub	sp, #7
      00924D 6B 05            [ 1] 2772 	ld	(0x05, sp), a
                                   2773 ;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks+1;i++)
      00924F 5F               [ 1] 2774 	clrw	x
      009250 1F 06            [ 2] 2775 	ldw	(0x06, sp), x
      009252                       2776 00106$:
      009252 7B 05            [ 1] 2777 	ld	a, (0x05, sp)
      009254 6B 02            [ 1] 2778 	ld	(0x02, sp), a
      009256 0F 01            [ 1] 2779 	clr	(0x01, sp)
      009258 1E 01            [ 2] 2780 	ldw	x, (0x01, sp)
      00925A 5C               [ 1] 2781 	incw	x
      00925B 1F 03            [ 2] 2782 	ldw	(0x03, sp), x
      00925D 1E 06            [ 2] 2783 	ldw	x, (0x06, sp)
      00925F 13 03            [ 2] 2784 	cpw	x, (0x03, sp)
      009261 2E 2A            [ 1] 2785 	jrsge	00104$
                                   2786 ;	./libs/tmr2_lib.c: 34: TIM2_SR1 -> UIF = 0;
      009263 72 11 53 04      [ 1] 2787 	bres	0x5304, #0
                                   2788 ;	./libs/tmr2_lib.c: 35: TIM2_ARRH->ARR = 0x03;
      009267 35 03 53 0F      [ 1] 2789 	mov	0x530f+0, #0x03
                                   2790 ;	./libs/tmr2_lib.c: 36: TIM2_ARRL->ARR = 0xD1;
      00926B 35 D1 53 10      [ 1] 2791 	mov	0x5310+0, #0xd1
                                   2792 ;	./libs/tmr2_lib.c: 37: TIM2_PSCR -> PSC = 0x0E;
      00926F C6 53 0E         [ 1] 2793 	ld	a, 0x530e
      009272 A4 F0            [ 1] 2794 	and	a, #0xf0
      009274 AA 0E            [ 1] 2795 	or	a, #0x0e
      009276 C7 53 0E         [ 1] 2796 	ld	0x530e, a
                                   2797 ;	./libs/tmr2_lib.c: 38: TIM2_IER -> UIE = 1;
      009279 72 10 53 03      [ 1] 2798 	bset	0x5303, #0
                                   2799 ;	./libs/tmr2_lib.c: 39: TIM2_CR1-> CEN = 1;
      00927D 72 10 53 00      [ 1] 2800 	bset	0x5300, #0
                                   2801 ;	./libs/tmr2_lib.c: 40: while(TIM2_IER -> UIE);	
      009281                       2802 00101$:
      009281 72 00 53 03 FB   [ 2] 2803 	btjt	0x5303, #0, 00101$
                                   2804 ;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks+1;i++)
      009286 1E 06            [ 2] 2805 	ldw	x, (0x06, sp)
      009288 5C               [ 1] 2806 	incw	x
      009289 1F 06            [ 2] 2807 	ldw	(0x06, sp), x
      00928B 20 C5            [ 2] 2808 	jra	00106$
      00928D                       2809 00104$:
                                   2810 ;	./libs/tmr2_lib.c: 42: TIM2_CR1-> CEN = 0;
      00928D 72 11 53 00      [ 1] 2811 	bres	0x5300, #0
                                   2812 ;	./libs/tmr2_lib.c: 43: }
      009291 5B 07            [ 2] 2813 	addw	sp, #7
      009293 81               [ 4] 2814 	ret
                                   2815 ;	main.c: 3: void params_default_conf(void)
                                   2816 ;	-----------------------------------------
                                   2817 ;	 function params_default_conf
                                   2818 ;	-----------------------------------------
      009294                       2819 _params_default_conf:
                                   2820 ;	main.c: 5: params_value.current_red = 255;
      009294 35 FF 00 09      [ 1] 2821 	mov	_params_value+2, #0xff
                                   2822 ;	main.c: 6: params_value.current_green = 255;
      009298 35 FF 00 0A      [ 1] 2823 	mov	_params_value+3, #0xff
                                   2824 ;	main.c: 7: params_value.current_blue = 255;
      00929C 35 FF 00 0B      [ 1] 2825 	mov	_params_value+4, #0xff
                                   2826 ;	main.c: 9: params_value.current_first = 0;
      0092A0 AE 00 0C         [ 2] 2827 	ldw	x, #(_params_value+0)+5
      0092A3 F6               [ 1] 2828 	ld	a, (x)
      0092A4 A4 F0            [ 1] 2829 	and	a, #0xf0
                                   2830 ;	main.c: 10: params_value.current_second = 15;
      0092A6 F7               [ 1] 2831 	ld	(x), a
      0092A7 AA F0            [ 1] 2832 	or	a, #0xf0
      0092A9 F7               [ 1] 2833 	ld	(x), a
                                   2834 ;	main.c: 12: params_value.current_sens = 10;
      0092AA 35 0A 00 0D      [ 1] 2835 	mov	_params_value+6, #0x0a
                                   2836 ;	main.c: 13: params_value.current_vers = 0xA1;
      0092AE 35 A1 00 0E      [ 1] 2837 	mov	_params_value+7, #0xa1
                                   2838 ;	main.c: 14: }
      0092B2 81               [ 4] 2839 	ret
                                   2840 ;	main.c: 16: void setup(void)
                                   2841 ;	-----------------------------------------
                                   2842 ;	 function setup
                                   2843 ;	-----------------------------------------
      0092B3                       2844 _setup:
                                   2845 ;	main.c: 19: CLK_CKDIVR = 0;
      0092B3 35 00 50 C6      [ 1] 2846 	mov	0x50c6+0, #0x00
                                   2847 ;	main.c: 21: params_value.all = 0;
      0092B7 35 00 00 07      [ 1] 2848 	mov	_params_value+0, #0x00
                                   2849 ;	main.c: 23: uart_init(9600,0);
      0092BB 4F               [ 1] 2850 	clr	a
      0092BC AE 25 80         [ 2] 2851 	ldw	x, #0x2580
      0092BF CD 84 DE         [ 4] 2852 	call	_uart_init
                                   2853 ;	main.c: 24: i2c_init();
      0092C2 CD 86 FF         [ 4] 2854 	call	_i2c_init
                                   2855 ;	main.c: 25: ssd1306_init();
      0092C5 CD 88 92         [ 4] 2856 	call	_ssd1306_init
                                   2857 ;	main.c: 26: ssd1306_send_buffer();
      0092C8 CD 89 82         [ 4] 2858 	call	_ssd1306_send_buffer
                                   2859 ;	main.c: 27: params_default_conf();
      0092CB CD 92 94         [ 4] 2860 	call	_params_default_conf
                                   2861 ;	main.c: 29: enableInterrupts();
      0092CE 9A               [ 1] 2862 	rim
                                   2863 ;	main.c: 30: delay_s(1);
      0092CF A6 01            [ 1] 2864 	ld	a, #0x01
                                   2865 ;	main.c: 31: }
      0092D1 CC 92 02         [ 2] 2866 	jp	_delay_s
                                   2867 ;	main.c: 34: void gg(void)
                                   2868 ;	-----------------------------------------
                                   2869 ;	 function gg
                                   2870 ;	-----------------------------------------
      0092D4                       2871 _gg:
                                   2872 ;	main.c: 36: menu_set_paragraph(menu);
      0092D4 A6 04            [ 1] 2873 	ld	a, #0x04
      0092D6 CD 8E F3         [ 4] 2874 	call	_menu_set_paragraph
                                   2875 ;	main.c: 37: delay_s(1);
      0092D9 A6 01            [ 1] 2876 	ld	a, #0x01
      0092DB CD 92 02         [ 4] 2877 	call	_delay_s
                                   2878 ;	main.c: 39: menu_set_paragraph(color);
      0092DE A6 05            [ 1] 2879 	ld	a, #0x05
      0092E0 CD 8E F3         [ 4] 2880 	call	_menu_set_paragraph
                                   2881 ;	main.c: 40: delay_s(1);
      0092E3 A6 01            [ 1] 2882 	ld	a, #0x01
                                   2883 ;	main.c: 52: }
      0092E5 CC 92 02         [ 2] 2884 	jp	_delay_s
                                   2885 ;	main.c: 54: int main(void)
                                   2886 ;	-----------------------------------------
                                   2887 ;	 function main
                                   2888 ;	-----------------------------------------
      0092E8                       2889 _main:
                                   2890 ;	main.c: 56: setup();
      0092E8 CD 92 B3         [ 4] 2891 	call	_setup
                                   2892 ;	main.c: 57: gg();
      0092EB CD 92 D4         [ 4] 2893 	call	_gg
                                   2894 ;	main.c: 58: while(1);
      0092EE                       2895 00102$:
      0092EE 20 FE            [ 2] 2896 	jra	00102$
                                   2897 ;	main.c: 59: }
      0092F0 81               [ 4] 2898 	ret
                                   2899 	.area CODE
                                   2900 	.area CONST
                                   2901 	.area INITIALIZER
      0080BD                       2902 __xinit__ttf_eng_a:
      0080BD 00                    2903 	.db #0x00	; 0
      0080BE 7E                    2904 	.db #0x7e	; 126
      0080BF 42                    2905 	.db #0x42	; 66	'B'
      0080C0 42                    2906 	.db #0x42	; 66	'B'
      0080C1 7E                    2907 	.db #0x7e	; 126
      0080C2 42                    2908 	.db #0x42	; 66	'B'
      0080C3 42                    2909 	.db #0x42	; 66	'B'
      0080C4 00                    2910 	.db #0x00	; 0
      0080C5                       2911 __xinit__ttf_eng_b:
      0080C5 00                    2912 	.db #0x00	; 0
      0080C6 7C                    2913 	.db #0x7c	; 124
      0080C7 42                    2914 	.db #0x42	; 66	'B'
      0080C8 7C                    2915 	.db #0x7c	; 124
      0080C9 42                    2916 	.db #0x42	; 66	'B'
      0080CA 42                    2917 	.db #0x42	; 66	'B'
      0080CB 7C                    2918 	.db #0x7c	; 124
      0080CC 00                    2919 	.db #0x00	; 0
      0080CD                       2920 __xinit__ttf_eng_c:
      0080CD 00                    2921 	.db #0x00	; 0
      0080CE 7E                    2922 	.db #0x7e	; 126
      0080CF 40                    2923 	.db #0x40	; 64
      0080D0 40                    2924 	.db #0x40	; 64
      0080D1 40                    2925 	.db #0x40	; 64
      0080D2 40                    2926 	.db #0x40	; 64
      0080D3 7E                    2927 	.db #0x7e	; 126
      0080D4 00                    2928 	.db #0x00	; 0
      0080D5                       2929 __xinit__ttf_eng_d:
      0080D5 00                    2930 	.db #0x00	; 0
      0080D6 7C                    2931 	.db #0x7c	; 124
      0080D7 42                    2932 	.db #0x42	; 66	'B'
      0080D8 42                    2933 	.db #0x42	; 66	'B'
      0080D9 42                    2934 	.db #0x42	; 66	'B'
      0080DA 42                    2935 	.db #0x42	; 66	'B'
      0080DB 7C                    2936 	.db #0x7c	; 124
      0080DC 00                    2937 	.db #0x00	; 0
      0080DD                       2938 __xinit__ttf_eng_e:
      0080DD 00                    2939 	.db #0x00	; 0
      0080DE 7E                    2940 	.db #0x7e	; 126
      0080DF 40                    2941 	.db #0x40	; 64
      0080E0 7C                    2942 	.db #0x7c	; 124
      0080E1 40                    2943 	.db #0x40	; 64
      0080E2 40                    2944 	.db #0x40	; 64
      0080E3 7E                    2945 	.db #0x7e	; 126
      0080E4 00                    2946 	.db #0x00	; 0
      0080E5                       2947 __xinit__ttf_eng_f:
      0080E5 00                    2948 	.db #0x00	; 0
      0080E6 7E                    2949 	.db #0x7e	; 126
      0080E7 40                    2950 	.db #0x40	; 64
      0080E8 40                    2951 	.db #0x40	; 64
      0080E9 7C                    2952 	.db #0x7c	; 124
      0080EA 40                    2953 	.db #0x40	; 64
      0080EB 40                    2954 	.db #0x40	; 64
      0080EC 00                    2955 	.db #0x00	; 0
      0080ED                       2956 __xinit__ttf_eng_g:
      0080ED 00                    2957 	.db #0x00	; 0
      0080EE 7E                    2958 	.db #0x7e	; 126
      0080EF 42                    2959 	.db #0x42	; 66	'B'
      0080F0 40                    2960 	.db #0x40	; 64
      0080F1 4E                    2961 	.db #0x4e	; 78	'N'
      0080F2 42                    2962 	.db #0x42	; 66	'B'
      0080F3 7E                    2963 	.db #0x7e	; 126
      0080F4 00                    2964 	.db #0x00	; 0
      0080F5                       2965 __xinit__ttf_eng_h:
      0080F5 00                    2966 	.db #0x00	; 0
      0080F6 42                    2967 	.db #0x42	; 66	'B'
      0080F7 42                    2968 	.db #0x42	; 66	'B'
      0080F8 42                    2969 	.db #0x42	; 66	'B'
      0080F9 7E                    2970 	.db #0x7e	; 126
      0080FA 42                    2971 	.db #0x42	; 66	'B'
      0080FB 42                    2972 	.db #0x42	; 66	'B'
      0080FC 00                    2973 	.db #0x00	; 0
      0080FD                       2974 __xinit__ttf_eng_i:
      0080FD 00                    2975 	.db #0x00	; 0
      0080FE 7E                    2976 	.db #0x7e	; 126
      0080FF 18                    2977 	.db #0x18	; 24
      008100 18                    2978 	.db #0x18	; 24
      008101 18                    2979 	.db #0x18	; 24
      008102 18                    2980 	.db #0x18	; 24
      008103 7E                    2981 	.db #0x7e	; 126
      008104 00                    2982 	.db #0x00	; 0
      008105                       2983 __xinit__ttf_eng_j:
      008105 00                    2984 	.db #0x00	; 0
      008106 0C                    2985 	.db #0x0c	; 12
      008107 0C                    2986 	.db #0x0c	; 12
      008108 0C                    2987 	.db #0x0c	; 12
      008109 0C                    2988 	.db #0x0c	; 12
      00810A 6C                    2989 	.db #0x6c	; 108	'l'
      00810B 7C                    2990 	.db #0x7c	; 124
      00810C 00                    2991 	.db #0x00	; 0
      00810D                       2992 __xinit__ttf_eng_k:
      00810D 00                    2993 	.db #0x00	; 0
      00810E 66                    2994 	.db #0x66	; 102	'f'
      00810F 68                    2995 	.db #0x68	; 104	'h'
      008110 70                    2996 	.db #0x70	; 112	'p'
      008111 70                    2997 	.db #0x70	; 112	'p'
      008112 68                    2998 	.db #0x68	; 104	'h'
      008113 66                    2999 	.db #0x66	; 102	'f'
      008114 00                    3000 	.db #0x00	; 0
      008115                       3001 __xinit__ttf_eng_l:
      008115 00                    3002 	.db #0x00	; 0
      008116 40                    3003 	.db #0x40	; 64
      008117 40                    3004 	.db #0x40	; 64
      008118 40                    3005 	.db #0x40	; 64
      008119 40                    3006 	.db #0x40	; 64
      00811A 40                    3007 	.db #0x40	; 64
      00811B 7E                    3008 	.db #0x7e	; 126
      00811C 00                    3009 	.db #0x00	; 0
      00811D                       3010 __xinit__ttf_eng_m:
      00811D 00                    3011 	.db #0x00	; 0
      00811E 42                    3012 	.db #0x42	; 66	'B'
      00811F 66                    3013 	.db #0x66	; 102	'f'
      008120 5A                    3014 	.db #0x5a	; 90	'Z'
      008121 42                    3015 	.db #0x42	; 66	'B'
      008122 42                    3016 	.db #0x42	; 66	'B'
      008123 42                    3017 	.db #0x42	; 66	'B'
      008124 00                    3018 	.db #0x00	; 0
      008125                       3019 __xinit__ttf_eng_n:
      008125 00                    3020 	.db #0x00	; 0
      008126 42                    3021 	.db #0x42	; 66	'B'
      008127 62                    3022 	.db #0x62	; 98	'b'
      008128 52                    3023 	.db #0x52	; 82	'R'
      008129 4A                    3024 	.db #0x4a	; 74	'J'
      00812A 46                    3025 	.db #0x46	; 70	'F'
      00812B 42                    3026 	.db #0x42	; 66	'B'
      00812C 00                    3027 	.db #0x00	; 0
      00812D                       3028 __xinit__ttf_eng_o:
      00812D 00                    3029 	.db #0x00	; 0
      00812E 7E                    3030 	.db #0x7e	; 126
      00812F 42                    3031 	.db #0x42	; 66	'B'
      008130 42                    3032 	.db #0x42	; 66	'B'
      008131 42                    3033 	.db #0x42	; 66	'B'
      008132 42                    3034 	.db #0x42	; 66	'B'
      008133 7E                    3035 	.db #0x7e	; 126
      008134 00                    3036 	.db #0x00	; 0
      008135                       3037 __xinit__ttf_eng_p:
      008135 00                    3038 	.db #0x00	; 0
      008136 7E                    3039 	.db #0x7e	; 126
      008137 42                    3040 	.db #0x42	; 66	'B'
      008138 42                    3041 	.db #0x42	; 66	'B'
      008139 7E                    3042 	.db #0x7e	; 126
      00813A 40                    3043 	.db #0x40	; 64
      00813B 40                    3044 	.db #0x40	; 64
      00813C 00                    3045 	.db #0x00	; 0
      00813D                       3046 __xinit__ttf_eng_q:
      00813D 00                    3047 	.db #0x00	; 0
      00813E 7E                    3048 	.db #0x7e	; 126
      00813F 42                    3049 	.db #0x42	; 66	'B'
      008140 42                    3050 	.db #0x42	; 66	'B'
      008141 42                    3051 	.db #0x42	; 66	'B'
      008142 7E                    3052 	.db #0x7e	; 126
      008143 04                    3053 	.db #0x04	; 4
      008144 00                    3054 	.db #0x00	; 0
      008145                       3055 __xinit__ttf_eng_r:
      008145 00                    3056 	.db #0x00	; 0
      008146 7E                    3057 	.db #0x7e	; 126
      008147 42                    3058 	.db #0x42	; 66	'B'
      008148 42                    3059 	.db #0x42	; 66	'B'
      008149 7C                    3060 	.db #0x7c	; 124
      00814A 42                    3061 	.db #0x42	; 66	'B'
      00814B 42                    3062 	.db #0x42	; 66	'B'
      00814C 00                    3063 	.db #0x00	; 0
      00814D                       3064 __xinit__ttf_eng_s:
      00814D 00                    3065 	.db #0x00	; 0
      00814E 3E                    3066 	.db #0x3e	; 62
      00814F 40                    3067 	.db #0x40	; 64
      008150 3C                    3068 	.db #0x3c	; 60
      008151 02                    3069 	.db #0x02	; 2
      008152 02                    3070 	.db #0x02	; 2
      008153 7C                    3071 	.db #0x7c	; 124
      008154 00                    3072 	.db #0x00	; 0
      008155                       3073 __xinit__ttf_eng_t:
      008155 00                    3074 	.db #0x00	; 0
      008156 7E                    3075 	.db #0x7e	; 126
      008157 18                    3076 	.db #0x18	; 24
      008158 18                    3077 	.db #0x18	; 24
      008159 18                    3078 	.db #0x18	; 24
      00815A 18                    3079 	.db #0x18	; 24
      00815B 18                    3080 	.db #0x18	; 24
      00815C 00                    3081 	.db #0x00	; 0
      00815D                       3082 __xinit__ttf_eng_u:
      00815D 00                    3083 	.db #0x00	; 0
      00815E 42                    3084 	.db #0x42	; 66	'B'
      00815F 42                    3085 	.db #0x42	; 66	'B'
      008160 42                    3086 	.db #0x42	; 66	'B'
      008161 42                    3087 	.db #0x42	; 66	'B'
      008162 42                    3088 	.db #0x42	; 66	'B'
      008163 3E                    3089 	.db #0x3e	; 62
      008164 00                    3090 	.db #0x00	; 0
      008165                       3091 __xinit__ttf_eng_v:
      008165 00                    3092 	.db #0x00	; 0
      008166 42                    3093 	.db #0x42	; 66	'B'
      008167 42                    3094 	.db #0x42	; 66	'B'
      008168 42                    3095 	.db #0x42	; 66	'B'
      008169 24                    3096 	.db #0x24	; 36
      00816A 24                    3097 	.db #0x24	; 36
      00816B 18                    3098 	.db #0x18	; 24
      00816C 00                    3099 	.db #0x00	; 0
      00816D                       3100 __xinit__ttf_eng_w:
      00816D 00                    3101 	.db #0x00	; 0
      00816E 42                    3102 	.db #0x42	; 66	'B'
      00816F 42                    3103 	.db #0x42	; 66	'B'
      008170 42                    3104 	.db #0x42	; 66	'B'
      008171 5A                    3105 	.db #0x5a	; 90	'Z'
      008172 5A                    3106 	.db #0x5a	; 90	'Z'
      008173 24                    3107 	.db #0x24	; 36
      008174 00                    3108 	.db #0x00	; 0
      008175                       3109 __xinit__ttf_eng_x:
      008175 00                    3110 	.db #0x00	; 0
      008176 42                    3111 	.db #0x42	; 66	'B'
      008177 24                    3112 	.db #0x24	; 36
      008178 18                    3113 	.db #0x18	; 24
      008179 18                    3114 	.db #0x18	; 24
      00817A 22                    3115 	.db #0x22	; 34
      00817B 42                    3116 	.db #0x42	; 66	'B'
      00817C 00                    3117 	.db #0x00	; 0
      00817D                       3118 __xinit__ttf_eng_y:
      00817D 00                    3119 	.db #0x00	; 0
      00817E 42                    3120 	.db #0x42	; 66	'B'
      00817F 24                    3121 	.db #0x24	; 36
      008180 18                    3122 	.db #0x18	; 24
      008181 18                    3123 	.db #0x18	; 24
      008182 18                    3124 	.db #0x18	; 24
      008183 18                    3125 	.db #0x18	; 24
      008184 00                    3126 	.db #0x00	; 0
      008185                       3127 __xinit__ttf_eng_z:
      008185 00                    3128 	.db #0x00	; 0
      008186 7E                    3129 	.db #0x7e	; 126
      008187 04                    3130 	.db #0x04	; 4
      008188 08                    3131 	.db #0x08	; 8
      008189 10                    3132 	.db #0x10	; 16
      00818A 20                    3133 	.db #0x20	; 32
      00818B 7E                    3134 	.db #0x7e	; 126
      00818C 00                    3135 	.db #0x00	; 0
      00818D                       3136 __xinit__I2C_IRQ:
      00818D 00                    3137 	.db #0x00	; 0
      00818E                       3138 __xinit__ttf_void:
      00818E 00                    3139 	.db #0x00	; 0
      00818F 00                    3140 	.db #0x00	; 0
      008190 00                    3141 	.db #0x00	; 0
      008191 00                    3142 	.db #0x00	; 0
      008192 00                    3143 	.db #0x00	; 0
      008193 00                    3144 	.db #0x00	; 0
      008194 00                    3145 	.db #0x00	; 0
      008195 00                    3146 	.db #0x00	; 0
      008196                       3147 __xinit__ttf_num_1:
      008196 00                    3148 	.db #0x00	; 0
      008197 18                    3149 	.db #0x18	; 24
      008198 38                    3150 	.db #0x38	; 56	'8'
      008199 38                    3151 	.db #0x38	; 56	'8'
      00819A 18                    3152 	.db #0x18	; 24
      00819B 18                    3153 	.db #0x18	; 24
      00819C 18                    3154 	.db #0x18	; 24
      00819D 00                    3155 	.db #0x00	; 0
      00819E                       3156 __xinit__ttf_num_2:
      00819E 00                    3157 	.db #0x00	; 0
      00819F 38                    3158 	.db #0x38	; 56	'8'
      0081A0 44                    3159 	.db #0x44	; 68	'D'
      0081A1 08                    3160 	.db #0x08	; 8
      0081A2 10                    3161 	.db #0x10	; 16
      0081A3 20                    3162 	.db #0x20	; 32
      0081A4 7C                    3163 	.db #0x7c	; 124
      0081A5 00                    3164 	.db #0x00	; 0
      0081A6                       3165 __xinit__ttf_num_3:
      0081A6 00                    3166 	.db #0x00	; 0
      0081A7 7C                    3167 	.db #0x7c	; 124
      0081A8 02                    3168 	.db #0x02	; 2
      0081A9 3C                    3169 	.db #0x3c	; 60
      0081AA 02                    3170 	.db #0x02	; 2
      0081AB 02                    3171 	.db #0x02	; 2
      0081AC 7C                    3172 	.db #0x7c	; 124
      0081AD 00                    3173 	.db #0x00	; 0
      0081AE                       3174 __xinit__ttf_num_4:
      0081AE 00                    3175 	.db #0x00	; 0
      0081AF 42                    3176 	.db #0x42	; 66	'B'
      0081B0 42                    3177 	.db #0x42	; 66	'B'
      0081B1 7E                    3178 	.db #0x7e	; 126
      0081B2 02                    3179 	.db #0x02	; 2
      0081B3 02                    3180 	.db #0x02	; 2
      0081B4 02                    3181 	.db #0x02	; 2
      0081B5 00                    3182 	.db #0x00	; 0
      0081B6                       3183 __xinit__ttf_num_5:
      0081B6 00                    3184 	.db #0x00	; 0
      0081B7 7E                    3185 	.db #0x7e	; 126
      0081B8 40                    3186 	.db #0x40	; 64
      0081B9 7C                    3187 	.db #0x7c	; 124
      0081BA 02                    3188 	.db #0x02	; 2
      0081BB 02                    3189 	.db #0x02	; 2
      0081BC 7C                    3190 	.db #0x7c	; 124
      0081BD 00                    3191 	.db #0x00	; 0
      0081BE                       3192 __xinit__ttf_num_6:
      0081BE 00                    3193 	.db #0x00	; 0
      0081BF 3C                    3194 	.db #0x3c	; 60
      0081C0 40                    3195 	.db #0x40	; 64
      0081C1 7C                    3196 	.db #0x7c	; 124
      0081C2 42                    3197 	.db #0x42	; 66	'B'
      0081C3 42                    3198 	.db #0x42	; 66	'B'
      0081C4 3C                    3199 	.db #0x3c	; 60
      0081C5 00                    3200 	.db #0x00	; 0
      0081C6                       3201 __xinit__ttf_num_7:
      0081C6 00                    3202 	.db #0x00	; 0
      0081C7 7E                    3203 	.db #0x7e	; 126
      0081C8 02                    3204 	.db #0x02	; 2
      0081C9 04                    3205 	.db #0x04	; 4
      0081CA 08                    3206 	.db #0x08	; 8
      0081CB 10                    3207 	.db #0x10	; 16
      0081CC 20                    3208 	.db #0x20	; 32
      0081CD 00                    3209 	.db #0x00	; 0
      0081CE                       3210 __xinit__ttf_num_8:
      0081CE 00                    3211 	.db #0x00	; 0
      0081CF 3C                    3212 	.db #0x3c	; 60
      0081D0 42                    3213 	.db #0x42	; 66	'B'
      0081D1 3C                    3214 	.db #0x3c	; 60
      0081D2 42                    3215 	.db #0x42	; 66	'B'
      0081D3 42                    3216 	.db #0x42	; 66	'B'
      0081D4 3C                    3217 	.db #0x3c	; 60
      0081D5 00                    3218 	.db #0x00	; 0
      0081D6                       3219 __xinit__ttf_num_9:
      0081D6 00                    3220 	.db #0x00	; 0
      0081D7 3C                    3221 	.db #0x3c	; 60
      0081D8 42                    3222 	.db #0x42	; 66	'B'
      0081D9 42                    3223 	.db #0x42	; 66	'B'
      0081DA 3E                    3224 	.db #0x3e	; 62
      0081DB 02                    3225 	.db #0x02	; 2
      0081DC 3C                    3226 	.db #0x3c	; 60
      0081DD 00                    3227 	.db #0x00	; 0
      0081DE                       3228 __xinit__ttf_num_0:
      0081DE 00                    3229 	.db #0x00	; 0
      0081DF 3C                    3230 	.db #0x3c	; 60
      0081E0 46                    3231 	.db #0x46	; 70	'F'
      0081E1 4A                    3232 	.db #0x4a	; 74	'J'
      0081E2 52                    3233 	.db #0x52	; 82	'R'
      0081E3 62                    3234 	.db #0x62	; 98	'b'
      0081E4 3C                    3235 	.db #0x3c	; 60
      0081E5 00                    3236 	.db #0x00	; 0
      0081E6                       3237 __xinit__ttf_corner_left_up:
      0081E6 FF                    3238 	.db #0xff	; 255
      0081E7 FF                    3239 	.db #0xff	; 255
      0081E8 C0                    3240 	.db #0xc0	; 192
      0081E9 C0                    3241 	.db #0xc0	; 192
      0081EA C0                    3242 	.db #0xc0	; 192
      0081EB C0                    3243 	.db #0xc0	; 192
      0081EC C0                    3244 	.db #0xc0	; 192
      0081ED C0                    3245 	.db #0xc0	; 192
      0081EE                       3246 __xinit__ttf_corner_right_up:
      0081EE FF                    3247 	.db #0xff	; 255
      0081EF FF                    3248 	.db #0xff	; 255
      0081F0 03                    3249 	.db #0x03	; 3
      0081F1 03                    3250 	.db #0x03	; 3
      0081F2 03                    3251 	.db #0x03	; 3
      0081F3 03                    3252 	.db #0x03	; 3
      0081F4 03                    3253 	.db #0x03	; 3
      0081F5 03                    3254 	.db #0x03	; 3
      0081F6                       3255 __xinit__ttf_corner_left_down:
      0081F6 C0                    3256 	.db #0xc0	; 192
      0081F7 C0                    3257 	.db #0xc0	; 192
      0081F8 C0                    3258 	.db #0xc0	; 192
      0081F9 C0                    3259 	.db #0xc0	; 192
      0081FA C0                    3260 	.db #0xc0	; 192
      0081FB C0                    3261 	.db #0xc0	; 192
      0081FC FF                    3262 	.db #0xff	; 255
      0081FD FF                    3263 	.db #0xff	; 255
      0081FE                       3264 __xinit__ttf_corner_right_down:
      0081FE 03                    3265 	.db #0x03	; 3
      0081FF 03                    3266 	.db #0x03	; 3
      008200 03                    3267 	.db #0x03	; 3
      008201 03                    3268 	.db #0x03	; 3
      008202 03                    3269 	.db #0x03	; 3
      008203 03                    3270 	.db #0x03	; 3
      008204 FF                    3271 	.db #0xff	; 255
      008205 FF                    3272 	.db #0xff	; 255
      008206                       3273 __xinit__ttf_line_right:
      008206 03                    3274 	.db #0x03	; 3
      008207 03                    3275 	.db #0x03	; 3
      008208 03                    3276 	.db #0x03	; 3
      008209 03                    3277 	.db #0x03	; 3
      00820A 03                    3278 	.db #0x03	; 3
      00820B 03                    3279 	.db #0x03	; 3
      00820C 03                    3280 	.db #0x03	; 3
      00820D 03                    3281 	.db #0x03	; 3
      00820E                       3282 __xinit__ttf_line_left:
      00820E C0                    3283 	.db #0xc0	; 192
      00820F C0                    3284 	.db #0xc0	; 192
      008210 C0                    3285 	.db #0xc0	; 192
      008211 C0                    3286 	.db #0xc0	; 192
      008212 C0                    3287 	.db #0xc0	; 192
      008213 C0                    3288 	.db #0xc0	; 192
      008214 C0                    3289 	.db #0xc0	; 192
      008215 C0                    3290 	.db #0xc0	; 192
      008216                       3291 __xinit__ttf_line_up:
      008216 FF                    3292 	.db #0xff	; 255
      008217 FF                    3293 	.db #0xff	; 255
      008218 00                    3294 	.db #0x00	; 0
      008219 00                    3295 	.db #0x00	; 0
      00821A 00                    3296 	.db #0x00	; 0
      00821B 00                    3297 	.db #0x00	; 0
      00821C 00                    3298 	.db #0x00	; 0
      00821D 00                    3299 	.db #0x00	; 0
      00821E                       3300 __xinit__ttf_line_down:
      00821E 00                    3301 	.db #0x00	; 0
      00821F 00                    3302 	.db #0x00	; 0
      008220 00                    3303 	.db #0x00	; 0
      008221 00                    3304 	.db #0x00	; 0
      008222 00                    3305 	.db #0x00	; 0
      008223 00                    3306 	.db #0x00	; 0
      008224 FF                    3307 	.db #0xff	; 255
      008225 FF                    3308 	.db #0xff	; 255
      008226                       3309 __xinit__main_buffer:
      008226 FF                    3310 	.db #0xff	; 255
      008227 01                    3311 	.db #0x01	; 1
      008228 01                    3312 	.db #0x01	; 1
      008229 01                    3313 	.db #0x01	; 1
      00822A 01                    3314 	.db #0x01	; 1
      00822B 01                    3315 	.db #0x01	; 1
      00822C 01                    3316 	.db #0x01	; 1
      00822D 01                    3317 	.db #0x01	; 1
      00822E FD                    3318 	.db #0xfd	; 253
      00822F FD                    3319 	.db #0xfd	; 253
      008230 FD                    3320 	.db #0xfd	; 253
      008231 FD                    3321 	.db #0xfd	; 253
      008232 FD                    3322 	.db #0xfd	; 253
      008233 FD                    3323 	.db #0xfd	; 253
      008234 FD                    3324 	.db #0xfd	; 253
      008235 01                    3325 	.db #0x01	; 1
      008236 01                    3326 	.db #0x01	; 1
      008237 01                    3327 	.db #0x01	; 1
      008238 01                    3328 	.db #0x01	; 1
      008239 01                    3329 	.db #0x01	; 1
      00823A 01                    3330 	.db #0x01	; 1
      00823B 01                    3331 	.db #0x01	; 1
      00823C FD                    3332 	.db #0xfd	; 253
      00823D FD                    3333 	.db #0xfd	; 253
      00823E FD                    3334 	.db #0xfd	; 253
      00823F FD                    3335 	.db #0xfd	; 253
      008240 FD                    3336 	.db #0xfd	; 253
      008241 FD                    3337 	.db #0xfd	; 253
      008242 FD                    3338 	.db #0xfd	; 253
      008243 FD                    3339 	.db #0xfd	; 253
      008244 FD                    3340 	.db #0xfd	; 253
      008245 FD                    3341 	.db #0xfd	; 253
      008246 FD                    3342 	.db #0xfd	; 253
      008247 FD                    3343 	.db #0xfd	; 253
      008248 FD                    3344 	.db #0xfd	; 253
      008249 FD                    3345 	.db #0xfd	; 253
      00824A FD                    3346 	.db #0xfd	; 253
      00824B FD                    3347 	.db #0xfd	; 253
      00824C FD                    3348 	.db #0xfd	; 253
      00824D FD                    3349 	.db #0xfd	; 253
      00824E FD                    3350 	.db #0xfd	; 253
      00824F FD                    3351 	.db #0xfd	; 253
      008250 FD                    3352 	.db #0xfd	; 253
      008251 FD                    3353 	.db #0xfd	; 253
      008252 FD                    3354 	.db #0xfd	; 253
      008253 FD                    3355 	.db #0xfd	; 253
      008254 FD                    3356 	.db #0xfd	; 253
      008255 FD                    3357 	.db #0xfd	; 253
      008256 FD                    3358 	.db #0xfd	; 253
      008257 FD                    3359 	.db #0xfd	; 253
      008258 FD                    3360 	.db #0xfd	; 253
      008259 FD                    3361 	.db #0xfd	; 253
      00825A FD                    3362 	.db #0xfd	; 253
      00825B FD                    3363 	.db #0xfd	; 253
      00825C FD                    3364 	.db #0xfd	; 253
      00825D FD                    3365 	.db #0xfd	; 253
      00825E FD                    3366 	.db #0xfd	; 253
      00825F 01                    3367 	.db #0x01	; 1
      008260 01                    3368 	.db #0x01	; 1
      008261 01                    3369 	.db #0x01	; 1
      008262 01                    3370 	.db #0x01	; 1
      008263 01                    3371 	.db #0x01	; 1
      008264 01                    3372 	.db #0x01	; 1
      008265 01                    3373 	.db #0x01	; 1
      008266 FD                    3374 	.db #0xfd	; 253
      008267 FD                    3375 	.db #0xfd	; 253
      008268 FD                    3376 	.db #0xfd	; 253
      008269 FD                    3377 	.db #0xfd	; 253
      00826A FD                    3378 	.db #0xfd	; 253
      00826B FD                    3379 	.db #0xfd	; 253
      00826C FD                    3380 	.db #0xfd	; 253
      00826D FD                    3381 	.db #0xfd	; 253
      00826E FD                    3382 	.db #0xfd	; 253
      00826F FD                    3383 	.db #0xfd	; 253
      008270 FD                    3384 	.db #0xfd	; 253
      008271 FD                    3385 	.db #0xfd	; 253
      008272 FD                    3386 	.db #0xfd	; 253
      008273 FD                    3387 	.db #0xfd	; 253
      008274 FD                    3388 	.db #0xfd	; 253
      008275 FD                    3389 	.db #0xfd	; 253
      008276 FD                    3390 	.db #0xfd	; 253
      008277 FD                    3391 	.db #0xfd	; 253
      008278 FD                    3392 	.db #0xfd	; 253
      008279 FD                    3393 	.db #0xfd	; 253
      00827A FD                    3394 	.db #0xfd	; 253
      00827B 01                    3395 	.db #0x01	; 1
      00827C 01                    3396 	.db #0x01	; 1
      00827D 01                    3397 	.db #0x01	; 1
      00827E 01                    3398 	.db #0x01	; 1
      00827F 01                    3399 	.db #0x01	; 1
      008280 01                    3400 	.db #0x01	; 1
      008281 01                    3401 	.db #0x01	; 1
      008282 01                    3402 	.db #0x01	; 1
      008283 01                    3403 	.db #0x01	; 1
      008284 01                    3404 	.db #0x01	; 1
      008285 01                    3405 	.db #0x01	; 1
      008286 01                    3406 	.db #0x01	; 1
      008287 01                    3407 	.db #0x01	; 1
      008288 01                    3408 	.db #0x01	; 1
      008289 3D                    3409 	.db #0x3d	; 61
      00828A 15                    3410 	.db #0x15	; 21
      00828B 3D                    3411 	.db #0x3d	; 61
      00828C 01                    3412 	.db #0x01	; 1
      00828D 3D                    3413 	.db #0x3d	; 61
      00828E 21                    3414 	.db #0x21	; 33
      00828F 21                    3415 	.db #0x21	; 33
      008290 01                    3416 	.db #0x01	; 1
      008291 3D                    3417 	.db #0x3d	; 61
      008292 15                    3418 	.db #0x15	; 21
      008293 1D                    3419 	.db #0x1d	; 29
      008294 01                    3420 	.db #0x01	; 1
      008295 3D                    3421 	.db #0x3d	; 61
      008296 11                    3422 	.db #0x11	; 17
      008297 3D                    3423 	.db #0x3d	; 61
      008298 01                    3424 	.db #0x01	; 1
      008299 3D                    3425 	.db #0x3d	; 61
      00829A 15                    3426 	.db #0x15	; 21
      00829B 3D                    3427 	.db #0x3d	; 61
      00829C 01                    3428 	.db #0x01	; 1
      00829D 01                    3429 	.db #0x01	; 1
      00829E 3D                    3430 	.db #0x3d	; 61
      00829F 25                    3431 	.db #0x25	; 37
      0082A0 3D                    3432 	.db #0x3d	; 61
      0082A1 01                    3433 	.db #0x01	; 1
      0082A2 05                    3434 	.db #0x05	; 5
      0082A3 3D                    3435 	.db #0x3d	; 61
      0082A4 01                    3436 	.db #0x01	; 1
      0082A5 FF                    3437 	.db #0xff	; 255
      0082A6 FF                    3438 	.db #0xff	; 255
      0082A7 00                    3439 	.db #0x00	; 0
      0082A8 00                    3440 	.db #0x00	; 0
      0082A9 00                    3441 	.db #0x00	; 0
      0082AA 00                    3442 	.db #0x00	; 0
      0082AB 00                    3443 	.db #0x00	; 0
      0082AC 00                    3444 	.db #0x00	; 0
      0082AD 00                    3445 	.db #0x00	; 0
      0082AE FF                    3446 	.db #0xff	; 255
      0082AF FF                    3447 	.db #0xff	; 255
      0082B0 FF                    3448 	.db #0xff	; 255
      0082B1 FF                    3449 	.db #0xff	; 255
      0082B2 FF                    3450 	.db #0xff	; 255
      0082B3 FF                    3451 	.db #0xff	; 255
      0082B4 FF                    3452 	.db #0xff	; 255
      0082B5 FE                    3453 	.db #0xfe	; 254
      0082B6 FE                    3454 	.db #0xfe	; 254
      0082B7 FE                    3455 	.db #0xfe	; 254
      0082B8 FE                    3456 	.db #0xfe	; 254
      0082B9 FE                    3457 	.db #0xfe	; 254
      0082BA FE                    3458 	.db #0xfe	; 254
      0082BB FE                    3459 	.db #0xfe	; 254
      0082BC FF                    3460 	.db #0xff	; 255
      0082BD FF                    3461 	.db #0xff	; 255
      0082BE FF                    3462 	.db #0xff	; 255
      0082BF FF                    3463 	.db #0xff	; 255
      0082C0 FF                    3464 	.db #0xff	; 255
      0082C1 FF                    3465 	.db #0xff	; 255
      0082C2 FF                    3466 	.db #0xff	; 255
      0082C3 01                    3467 	.db #0x01	; 1
      0082C4 01                    3468 	.db #0x01	; 1
      0082C5 01                    3469 	.db #0x01	; 1
      0082C6 01                    3470 	.db #0x01	; 1
      0082C7 01                    3471 	.db #0x01	; 1
      0082C8 01                    3472 	.db #0x01	; 1
      0082C9 01                    3473 	.db #0x01	; 1
      0082CA FF                    3474 	.db #0xff	; 255
      0082CB FF                    3475 	.db #0xff	; 255
      0082CC FF                    3476 	.db #0xff	; 255
      0082CD FF                    3477 	.db #0xff	; 255
      0082CE FF                    3478 	.db #0xff	; 255
      0082CF FF                    3479 	.db #0xff	; 255
      0082D0 FF                    3480 	.db #0xff	; 255
      0082D1 01                    3481 	.db #0x01	; 1
      0082D2 01                    3482 	.db #0x01	; 1
      0082D3 01                    3483 	.db #0x01	; 1
      0082D4 01                    3484 	.db #0x01	; 1
      0082D5 01                    3485 	.db #0x01	; 1
      0082D6 01                    3486 	.db #0x01	; 1
      0082D7 01                    3487 	.db #0x01	; 1
      0082D8 FF                    3488 	.db #0xff	; 255
      0082D9 FF                    3489 	.db #0xff	; 255
      0082DA FF                    3490 	.db #0xff	; 255
      0082DB FF                    3491 	.db #0xff	; 255
      0082DC FF                    3492 	.db #0xff	; 255
      0082DD FF                    3493 	.db #0xff	; 255
      0082DE FF                    3494 	.db #0xff	; 255
      0082DF 00                    3495 	.db #0x00	; 0
      0082E0 00                    3496 	.db #0x00	; 0
      0082E1 00                    3497 	.db #0x00	; 0
      0082E2 00                    3498 	.db #0x00	; 0
      0082E3 00                    3499 	.db #0x00	; 0
      0082E4 00                    3500 	.db #0x00	; 0
      0082E5 00                    3501 	.db #0x00	; 0
      0082E6 FF                    3502 	.db #0xff	; 255
      0082E7 FF                    3503 	.db #0xff	; 255
      0082E8 FF                    3504 	.db #0xff	; 255
      0082E9 FF                    3505 	.db #0xff	; 255
      0082EA FF                    3506 	.db #0xff	; 255
      0082EB FF                    3507 	.db #0xff	; 255
      0082EC FF                    3508 	.db #0xff	; 255
      0082ED 01                    3509 	.db #0x01	; 1
      0082EE 01                    3510 	.db #0x01	; 1
      0082EF 01                    3511 	.db #0x01	; 1
      0082F0 01                    3512 	.db #0x01	; 1
      0082F1 01                    3513 	.db #0x01	; 1
      0082F2 01                    3514 	.db #0x01	; 1
      0082F3 01                    3515 	.db #0x01	; 1
      0082F4 FF                    3516 	.db #0xff	; 255
      0082F5 FF                    3517 	.db #0xff	; 255
      0082F6 FF                    3518 	.db #0xff	; 255
      0082F7 FF                    3519 	.db #0xff	; 255
      0082F8 FF                    3520 	.db #0xff	; 255
      0082F9 FF                    3521 	.db #0xff	; 255
      0082FA FF                    3522 	.db #0xff	; 255
      0082FB 00                    3523 	.db #0x00	; 0
      0082FC 00                    3524 	.db #0x00	; 0
      0082FD 00                    3525 	.db #0x00	; 0
      0082FE 00                    3526 	.db #0x00	; 0
      0082FF 00                    3527 	.db #0x00	; 0
      008300 00                    3528 	.db #0x00	; 0
      008301 00                    3529 	.db #0x00	; 0
      008302 00                    3530 	.db #0x00	; 0
      008303 00                    3531 	.db #0x00	; 0
      008304 00                    3532 	.db #0x00	; 0
      008305 00                    3533 	.db #0x00	; 0
      008306 00                    3534 	.db #0x00	; 0
      008307 00                    3535 	.db #0x00	; 0
      008308 00                    3536 	.db #0x00	; 0
      008309 00                    3537 	.db #0x00	; 0
      00830A 00                    3538 	.db #0x00	; 0
      00830B 00                    3539 	.db #0x00	; 0
      00830C 00                    3540 	.db #0x00	; 0
      00830D 00                    3541 	.db #0x00	; 0
      00830E 00                    3542 	.db #0x00	; 0
      00830F 00                    3543 	.db #0x00	; 0
      008310 00                    3544 	.db #0x00	; 0
      008311 00                    3545 	.db #0x00	; 0
      008312 00                    3546 	.db #0x00	; 0
      008313 00                    3547 	.db #0x00	; 0
      008314 00                    3548 	.db #0x00	; 0
      008315 00                    3549 	.db #0x00	; 0
      008316 00                    3550 	.db #0x00	; 0
      008317 00                    3551 	.db #0x00	; 0
      008318 00                    3552 	.db #0x00	; 0
      008319 00                    3553 	.db #0x00	; 0
      00831A 00                    3554 	.db #0x00	; 0
      00831B 00                    3555 	.db #0x00	; 0
      00831C 00                    3556 	.db #0x00	; 0
      00831D 00                    3557 	.db #0x00	; 0
      00831E 00                    3558 	.db #0x00	; 0
      00831F 00                    3559 	.db #0x00	; 0
      008320 00                    3560 	.db #0x00	; 0
      008321 00                    3561 	.db #0x00	; 0
      008322 00                    3562 	.db #0x00	; 0
      008323 00                    3563 	.db #0x00	; 0
      008324 00                    3564 	.db #0x00	; 0
      008325 FF                    3565 	.db #0xff	; 255
      008326 FF                    3566 	.db #0xff	; 255
      008327 00                    3567 	.db #0x00	; 0
      008328 00                    3568 	.db #0x00	; 0
      008329 00                    3569 	.db #0x00	; 0
      00832A 00                    3570 	.db #0x00	; 0
      00832B 00                    3571 	.db #0x00	; 0
      00832C 00                    3572 	.db #0x00	; 0
      00832D 00                    3573 	.db #0x00	; 0
      00832E FF                    3574 	.db #0xff	; 255
      00832F FF                    3575 	.db #0xff	; 255
      008330 FF                    3576 	.db #0xff	; 255
      008331 FF                    3577 	.db #0xff	; 255
      008332 FF                    3578 	.db #0xff	; 255
      008333 FF                    3579 	.db #0xff	; 255
      008334 FF                    3580 	.db #0xff	; 255
      008335 00                    3581 	.db #0x00	; 0
      008336 00                    3582 	.db #0x00	; 0
      008337 00                    3583 	.db #0x00	; 0
      008338 00                    3584 	.db #0x00	; 0
      008339 00                    3585 	.db #0x00	; 0
      00833A 00                    3586 	.db #0x00	; 0
      00833B 00                    3587 	.db #0x00	; 0
      00833C FF                    3588 	.db #0xff	; 255
      00833D FF                    3589 	.db #0xff	; 255
      00833E FF                    3590 	.db #0xff	; 255
      00833F FF                    3591 	.db #0xff	; 255
      008340 FF                    3592 	.db #0xff	; 255
      008341 FF                    3593 	.db #0xff	; 255
      008342 FF                    3594 	.db #0xff	; 255
      008343 00                    3595 	.db #0x00	; 0
      008344 00                    3596 	.db #0x00	; 0
      008345 00                    3597 	.db #0x00	; 0
      008346 00                    3598 	.db #0x00	; 0
      008347 00                    3599 	.db #0x00	; 0
      008348 00                    3600 	.db #0x00	; 0
      008349 00                    3601 	.db #0x00	; 0
      00834A FF                    3602 	.db #0xff	; 255
      00834B FF                    3603 	.db #0xff	; 255
      00834C FF                    3604 	.db #0xff	; 255
      00834D FF                    3605 	.db #0xff	; 255
      00834E FF                    3606 	.db #0xff	; 255
      00834F FF                    3607 	.db #0xff	; 255
      008350 FF                    3608 	.db #0xff	; 255
      008351 00                    3609 	.db #0x00	; 0
      008352 00                    3610 	.db #0x00	; 0
      008353 00                    3611 	.db #0x00	; 0
      008354 00                    3612 	.db #0x00	; 0
      008355 00                    3613 	.db #0x00	; 0
      008356 00                    3614 	.db #0x00	; 0
      008357 00                    3615 	.db #0x00	; 0
      008358 FF                    3616 	.db #0xff	; 255
      008359 FF                    3617 	.db #0xff	; 255
      00835A FF                    3618 	.db #0xff	; 255
      00835B FF                    3619 	.db #0xff	; 255
      00835C FF                    3620 	.db #0xff	; 255
      00835D FF                    3621 	.db #0xff	; 255
      00835E FF                    3622 	.db #0xff	; 255
      00835F 7F                    3623 	.db #0x7f	; 127
      008360 7F                    3624 	.db #0x7f	; 127
      008361 7F                    3625 	.db #0x7f	; 127
      008362 7F                    3626 	.db #0x7f	; 127
      008363 7F                    3627 	.db #0x7f	; 127
      008364 7F                    3628 	.db #0x7f	; 127
      008365 7F                    3629 	.db #0x7f	; 127
      008366 FF                    3630 	.db #0xff	; 255
      008367 FF                    3631 	.db #0xff	; 255
      008368 FF                    3632 	.db #0xff	; 255
      008369 FF                    3633 	.db #0xff	; 255
      00836A FF                    3634 	.db #0xff	; 255
      00836B FF                    3635 	.db #0xff	; 255
      00836C FF                    3636 	.db #0xff	; 255
      00836D 7F                    3637 	.db #0x7f	; 127
      00836E 7F                    3638 	.db #0x7f	; 127
      00836F 7F                    3639 	.db #0x7f	; 127
      008370 7F                    3640 	.db #0x7f	; 127
      008371 7F                    3641 	.db #0x7f	; 127
      008372 7F                    3642 	.db #0x7f	; 127
      008373 7F                    3643 	.db #0x7f	; 127
      008374 80                    3644 	.db #0x80	; 128
      008375 80                    3645 	.db #0x80	; 128
      008376 80                    3646 	.db #0x80	; 128
      008377 80                    3647 	.db #0x80	; 128
      008378 80                    3648 	.db #0x80	; 128
      008379 80                    3649 	.db #0x80	; 128
      00837A 80                    3650 	.db #0x80	; 128
      00837B 00                    3651 	.db #0x00	; 0
      00837C 00                    3652 	.db #0x00	; 0
      00837D 00                    3653 	.db #0x00	; 0
      00837E 80                    3654 	.db #0x80	; 128
      00837F 80                    3655 	.db #0x80	; 128
      008380 80                    3656 	.db #0x80	; 128
      008381 80                    3657 	.db #0x80	; 128
      008382 80                    3658 	.db #0x80	; 128
      008383 80                    3659 	.db #0x80	; 128
      008384 80                    3660 	.db #0x80	; 128
      008385 00                    3661 	.db #0x00	; 0
      008386 00                    3662 	.db #0x00	; 0
      008387 00                    3663 	.db #0x00	; 0
      008388 00                    3664 	.db #0x00	; 0
      008389 00                    3665 	.db #0x00	; 0
      00838A 00                    3666 	.db #0x00	; 0
      00838B 00                    3667 	.db #0x00	; 0
      00838C 00                    3668 	.db #0x00	; 0
      00838D 00                    3669 	.db #0x00	; 0
      00838E 00                    3670 	.db #0x00	; 0
      00838F 00                    3671 	.db #0x00	; 0
      008390 00                    3672 	.db #0x00	; 0
      008391 00                    3673 	.db #0x00	; 0
      008392 00                    3674 	.db #0x00	; 0
      008393 00                    3675 	.db #0x00	; 0
      008394 00                    3676 	.db #0x00	; 0
      008395 00                    3677 	.db #0x00	; 0
      008396 00                    3678 	.db #0x00	; 0
      008397 00                    3679 	.db #0x00	; 0
      008398 00                    3680 	.db #0x00	; 0
      008399 00                    3681 	.db #0x00	; 0
      00839A 00                    3682 	.db #0x00	; 0
      00839B 00                    3683 	.db #0x00	; 0
      00839C 00                    3684 	.db #0x00	; 0
      00839D 00                    3685 	.db #0x00	; 0
      00839E 00                    3686 	.db #0x00	; 0
      00839F 00                    3687 	.db #0x00	; 0
      0083A0 00                    3688 	.db #0x00	; 0
      0083A1 00                    3689 	.db #0x00	; 0
      0083A2 00                    3690 	.db #0x00	; 0
      0083A3 00                    3691 	.db #0x00	; 0
      0083A4 00                    3692 	.db #0x00	; 0
      0083A5 FF                    3693 	.db #0xff	; 255
      0083A6 FF                    3694 	.db #0xff	; 255
      0083A7 80                    3695 	.db #0x80	; 128
      0083A8 80                    3696 	.db #0x80	; 128
      0083A9 80                    3697 	.db #0x80	; 128
      0083AA 80                    3698 	.db #0x80	; 128
      0083AB 80                    3699 	.db #0x80	; 128
      0083AC 80                    3700 	.db #0x80	; 128
      0083AD 80                    3701 	.db #0x80	; 128
      0083AE BF                    3702 	.db #0xbf	; 191
      0083AF BF                    3703 	.db #0xbf	; 191
      0083B0 BF                    3704 	.db #0xbf	; 191
      0083B1 BF                    3705 	.db #0xbf	; 191
      0083B2 BF                    3706 	.db #0xbf	; 191
      0083B3 BF                    3707 	.db #0xbf	; 191
      0083B4 BF                    3708 	.db #0xbf	; 191
      0083B5 80                    3709 	.db #0x80	; 128
      0083B6 80                    3710 	.db #0x80	; 128
      0083B7 80                    3711 	.db #0x80	; 128
      0083B8 80                    3712 	.db #0x80	; 128
      0083B9 80                    3713 	.db #0x80	; 128
      0083BA 80                    3714 	.db #0x80	; 128
      0083BB 80                    3715 	.db #0x80	; 128
      0083BC BF                    3716 	.db #0xbf	; 191
      0083BD BF                    3717 	.db #0xbf	; 191
      0083BE BF                    3718 	.db #0xbf	; 191
      0083BF BF                    3719 	.db #0xbf	; 191
      0083C0 BF                    3720 	.db #0xbf	; 191
      0083C1 BF                    3721 	.db #0xbf	; 191
      0083C2 BF                    3722 	.db #0xbf	; 191
      0083C3 80                    3723 	.db #0x80	; 128
      0083C4 80                    3724 	.db #0x80	; 128
      0083C5 80                    3725 	.db #0x80	; 128
      0083C6 80                    3726 	.db #0x80	; 128
      0083C7 80                    3727 	.db #0x80	; 128
      0083C8 80                    3728 	.db #0x80	; 128
      0083C9 80                    3729 	.db #0x80	; 128
      0083CA BF                    3730 	.db #0xbf	; 191
      0083CB BF                    3731 	.db #0xbf	; 191
      0083CC BF                    3732 	.db #0xbf	; 191
      0083CD BF                    3733 	.db #0xbf	; 191
      0083CE BF                    3734 	.db #0xbf	; 191
      0083CF BF                    3735 	.db #0xbf	; 191
      0083D0 BF                    3736 	.db #0xbf	; 191
      0083D1 80                    3737 	.db #0x80	; 128
      0083D2 80                    3738 	.db #0x80	; 128
      0083D3 80                    3739 	.db #0x80	; 128
      0083D4 80                    3740 	.db #0x80	; 128
      0083D5 80                    3741 	.db #0x80	; 128
      0083D6 80                    3742 	.db #0x80	; 128
      0083D7 80                    3743 	.db #0x80	; 128
      0083D8 BF                    3744 	.db #0xbf	; 191
      0083D9 BF                    3745 	.db #0xbf	; 191
      0083DA BF                    3746 	.db #0xbf	; 191
      0083DB BF                    3747 	.db #0xbf	; 191
      0083DC BF                    3748 	.db #0xbf	; 191
      0083DD BF                    3749 	.db #0xbf	; 191
      0083DE BF                    3750 	.db #0xbf	; 191
      0083DF 80                    3751 	.db #0x80	; 128
      0083E0 80                    3752 	.db #0x80	; 128
      0083E1 80                    3753 	.db #0x80	; 128
      0083E2 80                    3754 	.db #0x80	; 128
      0083E3 80                    3755 	.db #0x80	; 128
      0083E4 80                    3756 	.db #0x80	; 128
      0083E5 80                    3757 	.db #0x80	; 128
      0083E6 BF                    3758 	.db #0xbf	; 191
      0083E7 BF                    3759 	.db #0xbf	; 191
      0083E8 BF                    3760 	.db #0xbf	; 191
      0083E9 BF                    3761 	.db #0xbf	; 191
      0083EA BF                    3762 	.db #0xbf	; 191
      0083EB BF                    3763 	.db #0xbf	; 191
      0083EC BF                    3764 	.db #0xbf	; 191
      0083ED 80                    3765 	.db #0x80	; 128
      0083EE 80                    3766 	.db #0x80	; 128
      0083EF 80                    3767 	.db #0x80	; 128
      0083F0 80                    3768 	.db #0x80	; 128
      0083F1 80                    3769 	.db #0x80	; 128
      0083F2 80                    3770 	.db #0x80	; 128
      0083F3 80                    3771 	.db #0x80	; 128
      0083F4 BF                    3772 	.db #0xbf	; 191
      0083F5 BF                    3773 	.db #0xbf	; 191
      0083F6 BF                    3774 	.db #0xbf	; 191
      0083F7 BF                    3775 	.db #0xbf	; 191
      0083F8 BF                    3776 	.db #0xbf	; 191
      0083F9 BF                    3777 	.db #0xbf	; 191
      0083FA BF                    3778 	.db #0xbf	; 191
      0083FB 80                    3779 	.db #0x80	; 128
      0083FC 80                    3780 	.db #0x80	; 128
      0083FD 80                    3781 	.db #0x80	; 128
      0083FE B1                    3782 	.db #0xb1	; 177
      0083FF B1                    3783 	.db #0xb1	; 177
      008400 BF                    3784 	.db #0xbf	; 191
      008401 BF                    3785 	.db #0xbf	; 191
      008402 BF                    3786 	.db #0xbf	; 191
      008403 B1                    3787 	.db #0xb1	; 177
      008404 B1                    3788 	.db #0xb1	; 177
      008405 80                    3789 	.db #0x80	; 128
      008406 80                    3790 	.db #0x80	; 128
      008407 BF                    3791 	.db #0xbf	; 191
      008408 BF                    3792 	.db #0xbf	; 191
      008409 83                    3793 	.db #0x83	; 131
      00840A 83                    3794 	.db #0x83	; 131
      00840B BF                    3795 	.db #0xbf	; 191
      00840C BE                    3796 	.db #0xbe	; 190
      00840D 80                    3797 	.db #0x80	; 128
      00840E 80                    3798 	.db #0x80	; 128
      00840F BF                    3799 	.db #0xbf	; 191
      008410 BF                    3800 	.db #0xbf	; 191
      008411 B3                    3801 	.db #0xb3	; 179
      008412 B3                    3802 	.db #0xb3	; 179
      008413 B3                    3803 	.db #0xb3	; 179
      008414 B3                    3804 	.db #0xb3	; 179
      008415 80                    3805 	.db #0x80	; 128
      008416 80                    3806 	.db #0x80	; 128
      008417 80                    3807 	.db #0x80	; 128
      008418 80                    3808 	.db #0x80	; 128
      008419 B0                    3809 	.db #0xb0	; 176
      00841A B0                    3810 	.db #0xb0	; 176
      00841B 80                    3811 	.db #0x80	; 128
      00841C 80                    3812 	.db #0x80	; 128
      00841D 80                    3813 	.db #0x80	; 128
      00841E 80                    3814 	.db #0x80	; 128
      00841F 80                    3815 	.db #0x80	; 128
      008420 80                    3816 	.db #0x80	; 128
      008421 80                    3817 	.db #0x80	; 128
      008422 80                    3818 	.db #0x80	; 128
      008423 80                    3819 	.db #0x80	; 128
      008424 80                    3820 	.db #0x80	; 128
      008425 FF                    3821 	.db #0xff	; 255
      008426                       3822 __xinit__TIM2_IRQ:
      008426 00                    3823 	.db #0x00	; 0
                                   3824 	.area CABS (ABS)
