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
                                     15 	.globl _menu_set_paragraph
                                     16 	.globl _menu_set_item_menu
                                     17 	.globl _menu_set_params_value
                                     18 	.globl _menu_border_item
                                     19 	.globl _menu_border_paragraph
                                     20 	.globl _menu_border
                                     21 	.globl _ssd1306_send_buffer
                                     22 	.globl _ssd1306_buffer_clean
                                     23 	.globl _set_bit
                                     24 	.globl _get_bit
                                     25 	.globl _i2c_irq
                                     26 	.globl _tmr2_irq
                                     27 	.globl _memset
                                     28 	.globl _main_buffer
                                     29 	.globl _ttf_line_down
                                     30 	.globl _ttf_line_up
                                     31 	.globl _ttf_line_left
                                     32 	.globl _ttf_line_right
                                     33 	.globl _ttf_corner_right_down
                                     34 	.globl _ttf_corner_left_down
                                     35 	.globl _ttf_corner_right_up
                                     36 	.globl _ttf_corner_left_up
                                     37 	.globl _ttf_num_0
                                     38 	.globl _ttf_num_9
                                     39 	.globl _ttf_num_8
                                     40 	.globl _ttf_num_7
                                     41 	.globl _ttf_num_6
                                     42 	.globl _ttf_num_5
                                     43 	.globl _ttf_num_4
                                     44 	.globl _ttf_num_3
                                     45 	.globl _ttf_num_2
                                     46 	.globl _ttf_num_1
                                     47 	.globl _ttf_void
                                     48 	.globl _I2C_IRQ
                                     49 	.globl _TIM2_IRQ
                                     50 	.globl _ttf_rus_20
                                     51 	.globl _ttf_rus_19
                                     52 	.globl _ttf_rus_18
                                     53 	.globl _ttf_rus_17
                                     54 	.globl _ttf_rus_16
                                     55 	.globl _ttf_rus_15
                                     56 	.globl _ttf_rus_14
                                     57 	.globl _ttf_rus_13
                                     58 	.globl _ttf_rus_12
                                     59 	.globl _ttf_rus_11
                                     60 	.globl _ttf_rus_10
                                     61 	.globl _ttf_rus_9
                                     62 	.globl _ttf_rus_8
                                     63 	.globl _ttf_rus_7
                                     64 	.globl _ttf_rus_6
                                     65 	.globl _ttf_rus_5
                                     66 	.globl _ttf_rus_4
                                     67 	.globl _ttf_rus_3
                                     68 	.globl _ttf_rus_2
                                     69 	.globl _ttf_rus_1
                                     70 	.globl _params_value
                                     71 	.globl _buf_size
                                     72 	.globl _buf_pos
                                     73 	.globl _rx_buf_pointer
                                     74 	.globl _tx_buf_pointer
                                     75 	.globl _uart_transmission_irq
                                     76 	.globl _uart_reciever_irq
                                     77 	.globl _uart_write_irq
                                     78 	.globl _uart_read_irq
                                     79 	.globl _uart_init
                                     80 	.globl _uart_read_byte
                                     81 	.globl _uart_write_byte
                                     82 	.globl _uart_write
                                     83 	.globl _uart_read
                                     84 	.globl _delay_s
                                     85 	.globl _delay_ms
                                     86 	.globl _i2c_init
                                     87 	.globl _i2c_start
                                     88 	.globl _i2c_stop
                                     89 	.globl _i2c_send_address
                                     90 	.globl _i2c_read_byte
                                     91 	.globl _i2c_read
                                     92 	.globl _i2c_send_byte
                                     93 	.globl _i2c_write
                                     94 	.globl _i2c_scan
                                     95 	.globl _i2c_start_irq
                                     96 	.globl _i2c_stop_irq
                                     97 	.globl _ssd1306_init
                                     98 	.globl _ssd1306_set_params_to_write
                                     99 	.globl _ssd1306_draw_pixel
                                    100 	.globl _ssd1306_buffer_write
                                    101 	.globl _ssd1306_clean
                                    102 	.globl _adc_init
                                    103 	.globl _adc_read
                                    104 ;--------------------------------------------------------
                                    105 ; ram data
                                    106 ;--------------------------------------------------------
                                    107 	.area DATA
      000001                        108 _tx_buf_pointer::
      000001                        109 	.ds 2
      000003                        110 _rx_buf_pointer::
      000003                        111 	.ds 2
      000005                        112 _buf_pos::
      000005                        113 	.ds 1
      000006                        114 _buf_size::
      000006                        115 	.ds 1
      000007                        116 _params_value::
      000007                        117 	.ds 8
      00000F                        118 _menu_set_params_value_numbers_10000_186:
      00000F                        119 	.ds 20
                                    120 ;--------------------------------------------------------
                                    121 ; ram data
                                    122 ;--------------------------------------------------------
                                    123 	.area INITIALIZED
      000023                        124 _ttf_rus_1::
      000023                        125 	.ds 8
      00002B                        126 _ttf_rus_2::
      00002B                        127 	.ds 8
      000033                        128 _ttf_rus_3::
      000033                        129 	.ds 8
      00003B                        130 _ttf_rus_4::
      00003B                        131 	.ds 8
      000043                        132 _ttf_rus_5::
      000043                        133 	.ds 8
      00004B                        134 _ttf_rus_6::
      00004B                        135 	.ds 8
      000053                        136 _ttf_rus_7::
      000053                        137 	.ds 8
      00005B                        138 _ttf_rus_8::
      00005B                        139 	.ds 8
      000063                        140 _ttf_rus_9::
      000063                        141 	.ds 8
      00006B                        142 _ttf_rus_10::
      00006B                        143 	.ds 8
      000073                        144 _ttf_rus_11::
      000073                        145 	.ds 8
      00007B                        146 _ttf_rus_12::
      00007B                        147 	.ds 8
      000083                        148 _ttf_rus_13::
      000083                        149 	.ds 8
      00008B                        150 _ttf_rus_14::
      00008B                        151 	.ds 8
      000093                        152 _ttf_rus_15::
      000093                        153 	.ds 8
      00009B                        154 _ttf_rus_16::
      00009B                        155 	.ds 8
      0000A3                        156 _ttf_rus_17::
      0000A3                        157 	.ds 8
      0000AB                        158 _ttf_rus_18::
      0000AB                        159 	.ds 8
      0000B3                        160 _ttf_rus_19::
      0000B3                        161 	.ds 8
      0000BB                        162 _ttf_rus_20::
      0000BB                        163 	.ds 8
      0000C3                        164 _TIM2_IRQ::
      0000C3                        165 	.ds 1
      0000C4                        166 _I2C_IRQ::
      0000C4                        167 	.ds 1
      0000C5                        168 _ttf_void::
      0000C5                        169 	.ds 8
      0000CD                        170 _ttf_num_1::
      0000CD                        171 	.ds 8
      0000D5                        172 _ttf_num_2::
      0000D5                        173 	.ds 8
      0000DD                        174 _ttf_num_3::
      0000DD                        175 	.ds 8
      0000E5                        176 _ttf_num_4::
      0000E5                        177 	.ds 8
      0000ED                        178 _ttf_num_5::
      0000ED                        179 	.ds 8
      0000F5                        180 _ttf_num_6::
      0000F5                        181 	.ds 8
      0000FD                        182 _ttf_num_7::
      0000FD                        183 	.ds 8
      000105                        184 _ttf_num_8::
      000105                        185 	.ds 8
      00010D                        186 _ttf_num_9::
      00010D                        187 	.ds 8
      000115                        188 _ttf_num_0::
      000115                        189 	.ds 8
      00011D                        190 _ttf_corner_left_up::
      00011D                        191 	.ds 8
      000125                        192 _ttf_corner_right_up::
      000125                        193 	.ds 8
      00012D                        194 _ttf_corner_left_down::
      00012D                        195 	.ds 8
      000135                        196 _ttf_corner_right_down::
      000135                        197 	.ds 8
      00013D                        198 _ttf_line_right::
      00013D                        199 	.ds 8
      000145                        200 _ttf_line_left::
      000145                        201 	.ds 8
      00014D                        202 _ttf_line_up::
      00014D                        203 	.ds 8
      000155                        204 _ttf_line_down::
      000155                        205 	.ds 8
      00015D                        206 _main_buffer::
      00015D                        207 	.ds 512
                                    208 ;--------------------------------------------------------
                                    209 ; Stack segment in internal ram
                                    210 ;--------------------------------------------------------
                                    211 	.area SSEG
      00035D                        212 __start__stack:
      00035D                        213 	.ds	1
                                    214 
                                    215 ;--------------------------------------------------------
                                    216 ; absolute external ram data
                                    217 ;--------------------------------------------------------
                                    218 	.area DABS (ABS)
                                    219 
                                    220 ; default segment ordering for linker
                                    221 	.area HOME
                                    222 	.area GSINIT
                                    223 	.area GSFINAL
                                    224 	.area CONST
                                    225 	.area INITIALIZER
                                    226 	.area CODE
                                    227 
                                    228 ;--------------------------------------------------------
                                    229 ; interrupt vector
                                    230 ;--------------------------------------------------------
                                    231 	.area HOME
      008000                        232 __interrupt_vect:
      008000 82 00 80 5B            233 	int s_GSINIT ; reset
      008004 82 00 00 00            234 	int 0x000000 ; trap
      008008 82 00 00 00            235 	int 0x000000 ; int0
      00800C 82 00 00 00            236 	int 0x000000 ; int1
      008010 82 00 00 00            237 	int 0x000000 ; int2
      008014 82 00 00 00            238 	int 0x000000 ; int3
      008018 82 00 00 00            239 	int 0x000000 ; int4
      00801C 82 00 00 00            240 	int 0x000000 ; int5
      008020 82 00 00 00            241 	int 0x000000 ; int6
      008024 82 00 00 00            242 	int 0x000000 ; int7
      008028 82 00 00 00            243 	int 0x000000 ; int8
      00802C 82 00 00 00            244 	int 0x000000 ; int9
      008030 82 00 00 00            245 	int 0x000000 ; int10
      008034 82 00 00 00            246 	int 0x000000 ; int11
      008038 82 00 00 00            247 	int 0x000000 ; int12
      00803C 82 00 86 15            248 	int _tmr2_irq ; int13
      008040 82 00 00 00            249 	int 0x000000 ; int14
      008044 82 00 00 00            250 	int 0x000000 ; int15
      008048 82 00 00 00            251 	int 0x000000 ; int16
      00804C 82 00 83 F7            252 	int _uart_transmission_irq ; int17
      008050 82 00 84 33            253 	int _uart_reciever_irq ; int18
      008054 82 00 86 B7            254 	int _i2c_irq ; int19
                                    255 ;--------------------------------------------------------
                                    256 ; global & static initialisations
                                    257 ;--------------------------------------------------------
                                    258 	.area HOME
                                    259 	.area GSINIT
                                    260 	.area GSFINAL
                                    261 	.area GSINIT
      00805B CD 92 35         [ 4]  262 	call	___sdcc_external_startup
      00805E 4D               [ 1]  263 	tnz	a
      00805F 27 03            [ 1]  264 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  265 	jp	__sdcc_program_startup
      008064                        266 __sdcc_init_data:
                                    267 ; stm8_genXINIT() start
      008064 AE 00 22         [ 2]  268 	ldw x, #l_DATA
      008067 27 07            [ 1]  269 	jreq	00002$
      008069                        270 00001$:
      008069 72 4F 00 00      [ 1]  271 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  272 	decw x
      00806E 26 F9            [ 1]  273 	jrne	00001$
      008070                        274 00002$:
      008070 AE 03 3A         [ 2]  275 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  276 	jreq	00004$
      008075                        277 00003$:
      008075 D6 80 BC         [ 1]  278 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 22         [ 1]  279 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  280 	decw	x
      00807C 26 F7            [ 1]  281 	jrne	00003$
      00807E                        282 00004$:
                                    283 ; stm8_genXINIT() end
                                    284 ;	./libs/menu_lib.c: 63: static uint8_t *numbers[] = {&ttf_num_0[0],&ttf_num_1[0],&ttf_num_2[0],&ttf_num_3[0],&ttf_num_4[0],&ttf_num_5[0],&ttf_num_6[0],&ttf_num_7[0],&ttf_num_8[0],&ttf_num_9[0]};
      00807E AE 01 15         [ 2]  285 	ldw	x, #_ttf_num_0+0
      008081 CF 00 0F         [ 2]  286 	ldw	_menu_set_params_value_numbers_10000_186+0, x
      008084 AE 00 CD         [ 2]  287 	ldw	x, #_ttf_num_1+0
      008087 CF 00 11         [ 2]  288 	ldw	_menu_set_params_value_numbers_10000_186+2, x
      00808A AE 00 D5         [ 2]  289 	ldw	x, #_ttf_num_2+0
      00808D CF 00 13         [ 2]  290 	ldw	_menu_set_params_value_numbers_10000_186+4, x
      008090 AE 00 DD         [ 2]  291 	ldw	x, #_ttf_num_3+0
      008093 CF 00 15         [ 2]  292 	ldw	_menu_set_params_value_numbers_10000_186+6, x
      008096 AE 00 E5         [ 2]  293 	ldw	x, #_ttf_num_4+0
      008099 CF 00 17         [ 2]  294 	ldw	_menu_set_params_value_numbers_10000_186+8, x
      00809C AE 00 ED         [ 2]  295 	ldw	x, #_ttf_num_5+0
      00809F CF 00 19         [ 2]  296 	ldw	_menu_set_params_value_numbers_10000_186+10, x
      0080A2 AE 00 F5         [ 2]  297 	ldw	x, #_ttf_num_6+0
      0080A5 CF 00 1B         [ 2]  298 	ldw	_menu_set_params_value_numbers_10000_186+12, x
      0080A8 AE 00 FD         [ 2]  299 	ldw	x, #_ttf_num_7+0
      0080AB CF 00 1D         [ 2]  300 	ldw	_menu_set_params_value_numbers_10000_186+14, x
      0080AE AE 01 05         [ 2]  301 	ldw	x, #_ttf_num_8+0
      0080B1 CF 00 1F         [ 2]  302 	ldw	_menu_set_params_value_numbers_10000_186+16, x
      0080B4 AE 01 0D         [ 2]  303 	ldw	x, #_ttf_num_9+0
      0080B7 CF 00 21         [ 2]  304 	ldw	_menu_set_params_value_numbers_10000_186+18, x
                                    305 	.area GSFINAL
      0080BA CC 80 58         [ 2]  306 	jp	__sdcc_program_startup
                                    307 ;--------------------------------------------------------
                                    308 ; Home
                                    309 ;--------------------------------------------------------
                                    310 	.area HOME
                                    311 	.area HOME
      008058                        312 __sdcc_program_startup:
      008058 CC 91 FE         [ 2]  313 	jp	_main
                                    314 ;	return from main will return to caller
                                    315 ;--------------------------------------------------------
                                    316 ; code
                                    317 ;--------------------------------------------------------
                                    318 	.area CODE
                                    319 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    320 ;	-----------------------------------------
                                    321 ;	 function uart_transmission_irq
                                    322 ;	-----------------------------------------
      0083F7                        323 _uart_transmission_irq:
                                    324 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0083F7 AE 52 30         [ 2]  325 	ldw	x, #0x5230
      0083FA F6               [ 1]  326 	ld	a, (x)
      0083FB 4E               [ 1]  327 	swap	a
      0083FC 44               [ 1]  328 	srl	a
      0083FD 44               [ 1]  329 	srl	a
      0083FE 44               [ 1]  330 	srl	a
      0083FF A5 01            [ 1]  331 	bcp	a, #0x01
      008401 27 2F            [ 1]  332 	jreq	00107$
                                    333 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      008403 C6 00 02         [ 1]  334 	ld	a, _tx_buf_pointer+1
      008406 CB 00 05         [ 1]  335 	add	a, _buf_pos+0
      008409 97               [ 1]  336 	ld	xl, a
      00840A C6 00 01         [ 1]  337 	ld	a, _tx_buf_pointer+0
      00840D A9 00            [ 1]  338 	adc	a, #0x00
      00840F 95               [ 1]  339 	ld	xh, a
      008410 F6               [ 1]  340 	ld	a, (x)
      008411 27 1B            [ 1]  341 	jreq	00102$
      008413 C6 00 05         [ 1]  342 	ld	a, _buf_pos+0
      008416 C1 00 06         [ 1]  343 	cp	a, _buf_size+0
      008419 24 13            [ 1]  344 	jrnc	00102$
                                    345 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      00841B C6 00 05         [ 1]  346 	ld	a, _buf_pos+0
      00841E 72 5C 00 05      [ 1]  347 	inc	_buf_pos+0
      008422 5F               [ 1]  348 	clrw	x
      008423 97               [ 1]  349 	ld	xl, a
      008424 72 BB 00 01      [ 2]  350 	addw	x, _tx_buf_pointer+0
      008428 F6               [ 1]  351 	ld	a, (x)
      008429 C7 52 31         [ 1]  352 	ld	0x5231, a
      00842C 20 04            [ 2]  353 	jra	00107$
      00842E                        354 00102$:
                                    355 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      00842E 72 1F 52 35      [ 1]  356 	bres	0x5235, #7
      008432                        357 00107$:
                                    358 ;	./libs/uart_lib.c: 14: }
      008432 80               [11]  359 	iret
                                    360 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    361 ;	-----------------------------------------
                                    362 ;	 function uart_reciever_irq
                                    363 ;	-----------------------------------------
      008433                        364 _uart_reciever_irq:
      008433 88               [ 1]  365 	push	a
                                    366 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      008434 C6 52 30         [ 1]  367 	ld	a, 0x5230
      008437 4E               [ 1]  368 	swap	a
      008438 44               [ 1]  369 	srl	a
      008439 A5 01            [ 1]  370 	bcp	a, #0x01
      00843B 27 27            [ 1]  371 	jreq	00107$
                                    372 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      00843D C6 52 31         [ 1]  373 	ld	a, 0x5231
                                    374 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      008440 6B 01            [ 1]  375 	ld	(0x01, sp), a
      008442 A1 0A            [ 1]  376 	cp	a, #0x0a
      008444 27 1A            [ 1]  377 	jreq	00102$
      008446 C6 00 05         [ 1]  378 	ld	a, _buf_pos+0
      008449 C1 00 06         [ 1]  379 	cp	a, _buf_size+0
      00844C 24 12            [ 1]  380 	jrnc	00102$
                                    381 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      00844E C6 00 05         [ 1]  382 	ld	a, _buf_pos+0
      008451 72 5C 00 05      [ 1]  383 	inc	_buf_pos+0
      008455 5F               [ 1]  384 	clrw	x
      008456 97               [ 1]  385 	ld	xl, a
      008457 72 BB 00 03      [ 2]  386 	addw	x, _rx_buf_pointer+0
      00845B 7B 01            [ 1]  387 	ld	a, (0x01, sp)
      00845D F7               [ 1]  388 	ld	(x), a
      00845E 20 04            [ 2]  389 	jra	00107$
      008460                        390 00102$:
                                    391 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      008460 72 1B 52 35      [ 1]  392 	bres	0x5235, #5
      008464                        393 00107$:
                                    394 ;	./libs/uart_lib.c: 30: }
      008464 84               [ 1]  395 	pop	a
      008465 80               [11]  396 	iret
                                    397 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    398 ;	-----------------------------------------
                                    399 ;	 function uart_write_irq
                                    400 ;	-----------------------------------------
      008466                        401 _uart_write_irq:
      008466 52 02            [ 2]  402 	sub	sp, #2
                                    403 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      008468 1F 01            [ 2]  404 	ldw	(0x01, sp), x
      00846A CF 00 01         [ 2]  405 	ldw	_tx_buf_pointer+0, x
                                    406 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      00846D 72 5F 00 05      [ 1]  407 	clr	_buf_pos+0
                                    408 ;	./libs/uart_lib.c: 36: buf_size = 0;
      008471 72 5F 00 06      [ 1]  409 	clr	_buf_size+0
                                    410 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      008475                        411 00101$:
      008475 C6 00 06         [ 1]  412 	ld	a, _buf_size+0
      008478 72 5C 00 06      [ 1]  413 	inc	_buf_size+0
      00847C 5F               [ 1]  414 	clrw	x
      00847D 97               [ 1]  415 	ld	xl, a
      00847E 72 FB 01         [ 2]  416 	addw	x, (0x01, sp)
      008481 F6               [ 1]  417 	ld	a, (x)
      008482 26 F1            [ 1]  418 	jrne	00101$
                                    419 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      008484 72 1E 52 35      [ 1]  420 	bset	0x5235, #7
                                    421 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      008488                        422 00104$:
      008488 72 0E 52 35 FB   [ 2]  423 	btjt	0x5235, #7, 00104$
                                    424 ;	./libs/uart_lib.c: 40: }
      00848D 5B 02            [ 2]  425 	addw	sp, #2
      00848F 81               [ 4]  426 	ret
                                    427 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    428 ;	-----------------------------------------
                                    429 ;	 function uart_read_irq
                                    430 ;	-----------------------------------------
      008490                        431 _uart_read_irq:
                                    432 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      008490 CF 00 03         [ 2]  433 	ldw	_rx_buf_pointer+0, x
                                    434 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      008493 72 5F 00 05      [ 1]  435 	clr	_buf_pos+0
                                    436 ;	./libs/uart_lib.c: 45: buf_size = size;
      008497 7B 04            [ 1]  437 	ld	a, (0x04, sp)
      008499 C7 00 06         [ 1]  438 	ld	_buf_size+0, a
                                    439 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      00849C 72 1A 52 35      [ 1]  440 	bset	0x5235, #5
                                    441 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      0084A0                        442 00101$:
      0084A0 C6 52 35         [ 1]  443 	ld	a, 0x5235
      0084A3 4E               [ 1]  444 	swap	a
      0084A4 44               [ 1]  445 	srl	a
      0084A5 A4 01            [ 1]  446 	and	a, #0x01
      0084A7 26 F7            [ 1]  447 	jrne	00101$
                                    448 ;	./libs/uart_lib.c: 48: }
      0084A9 1E 01            [ 2]  449 	ldw	x, (1, sp)
      0084AB 5B 04            [ 2]  450 	addw	sp, #4
      0084AD FC               [ 2]  451 	jp	(x)
                                    452 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    453 ;	-----------------------------------------
                                    454 ;	 function uart_init
                                    455 ;	-----------------------------------------
      0084AE                        456 _uart_init:
      0084AE 52 02            [ 2]  457 	sub	sp, #2
      0084B0 1F 01            [ 2]  458 	ldw	(0x01, sp), x
                                    459 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      0084B2 AE 52 35         [ 2]  460 	ldw	x, #0x5235
      0084B5 88               [ 1]  461 	push	a
      0084B6 F6               [ 1]  462 	ld	a, (x)
      0084B7 AA 08            [ 1]  463 	or	a, #0x08
      0084B9 F7               [ 1]  464 	ld	(x), a
      0084BA 84               [ 1]  465 	pop	a
                                    466 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      0084BB AE 52 35         [ 2]  467 	ldw	x, #0x5235
      0084BE 88               [ 1]  468 	push	a
      0084BF F6               [ 1]  469 	ld	a, (x)
      0084C0 AA 04            [ 1]  470 	or	a, #0x04
      0084C2 F7               [ 1]  471 	ld	(x), a
      0084C3 84               [ 1]  472 	pop	a
                                    473 ;	./libs/uart_lib.c: 56: switch(stopbit)
      0084C4 A1 02            [ 1]  474 	cp	a, #0x02
      0084C6 27 06            [ 1]  475 	jreq	00101$
      0084C8 A1 03            [ 1]  476 	cp	a, #0x03
      0084CA 27 0E            [ 1]  477 	jreq	00102$
      0084CC 20 16            [ 2]  478 	jra	00103$
                                    479 ;	./libs/uart_lib.c: 58: case 2:
      0084CE                        480 00101$:
                                    481 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      0084CE C6 52 36         [ 1]  482 	ld	a, 0x5236
      0084D1 A4 CF            [ 1]  483 	and	a, #0xcf
      0084D3 AA 20            [ 1]  484 	or	a, #0x20
      0084D5 C7 52 36         [ 1]  485 	ld	0x5236, a
                                    486 ;	./libs/uart_lib.c: 60: break;
      0084D8 20 12            [ 2]  487 	jra	00104$
                                    488 ;	./libs/uart_lib.c: 61: case 3:
      0084DA                        489 00102$:
                                    490 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      0084DA C6 52 36         [ 1]  491 	ld	a, 0x5236
      0084DD AA 30            [ 1]  492 	or	a, #0x30
      0084DF C7 52 36         [ 1]  493 	ld	0x5236, a
                                    494 ;	./libs/uart_lib.c: 63: break;
      0084E2 20 08            [ 2]  495 	jra	00104$
                                    496 ;	./libs/uart_lib.c: 64: default:
      0084E4                        497 00103$:
                                    498 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      0084E4 C6 52 36         [ 1]  499 	ld	a, 0x5236
      0084E7 A4 CF            [ 1]  500 	and	a, #0xcf
      0084E9 C7 52 36         [ 1]  501 	ld	0x5236, a
                                    502 ;	./libs/uart_lib.c: 67: }
      0084EC                        503 00104$:
                                    504 ;	./libs/uart_lib.c: 68: switch(baudrate)
      0084EC 1E 01            [ 2]  505 	ldw	x, (0x01, sp)
      0084EE A3 08 00         [ 2]  506 	cpw	x, #0x0800
      0084F1 26 03            [ 1]  507 	jrne	00186$
      0084F3 CC 85 7F         [ 2]  508 	jp	00110$
      0084F6                        509 00186$:
      0084F6 1E 01            [ 2]  510 	ldw	x, (0x01, sp)
      0084F8 A3 09 60         [ 2]  511 	cpw	x, #0x0960
      0084FB 27 28            [ 1]  512 	jreq	00105$
      0084FD 1E 01            [ 2]  513 	ldw	x, (0x01, sp)
      0084FF A3 10 00         [ 2]  514 	cpw	x, #0x1000
      008502 26 03            [ 1]  515 	jrne	00192$
      008504 CC 85 8F         [ 2]  516 	jp	00111$
      008507                        517 00192$:
      008507 1E 01            [ 2]  518 	ldw	x, (0x01, sp)
      008509 A3 4B 00         [ 2]  519 	cpw	x, #0x4b00
      00850C 27 31            [ 1]  520 	jreq	00106$
      00850E 1E 01            [ 2]  521 	ldw	x, (0x01, sp)
      008510 A3 84 00         [ 2]  522 	cpw	x, #0x8400
      008513 27 5A            [ 1]  523 	jreq	00109$
      008515 1E 01            [ 2]  524 	ldw	x, (0x01, sp)
      008517 A3 C2 00         [ 2]  525 	cpw	x, #0xc200
      00851A 27 43            [ 1]  526 	jreq	00108$
      00851C 1E 01            [ 2]  527 	ldw	x, (0x01, sp)
      00851E A3 E1 00         [ 2]  528 	cpw	x, #0xe100
      008521 27 2C            [ 1]  529 	jreq	00107$
      008523 20 7A            [ 2]  530 	jra	00112$
                                    531 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      008525                        532 00105$:
                                    533 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      008525 C6 52 33         [ 1]  534 	ld	a, 0x5233
      008528 A4 0F            [ 1]  535 	and	a, #0x0f
      00852A AA 10            [ 1]  536 	or	a, #0x10
      00852C C7 52 33         [ 1]  537 	ld	0x5233, a
                                    538 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      00852F 35 A0 52 32      [ 1]  539 	mov	0x5232+0, #0xa0
                                    540 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      008533 C6 52 33         [ 1]  541 	ld	a, 0x5233
      008536 A4 F0            [ 1]  542 	and	a, #0xf0
      008538 AA 0B            [ 1]  543 	or	a, #0x0b
      00853A C7 52 33         [ 1]  544 	ld	0x5233, a
                                    545 ;	./libs/uart_lib.c: 74: break;
      00853D 20 6E            [ 2]  546 	jra	00114$
                                    547 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      00853F                        548 00106$:
                                    549 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      00853F 35 34 52 32      [ 1]  550 	mov	0x5232+0, #0x34
                                    551 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      008543 C6 52 33         [ 1]  552 	ld	a, 0x5233
      008546 A4 F0            [ 1]  553 	and	a, #0xf0
      008548 AA 01            [ 1]  554 	or	a, #0x01
      00854A C7 52 33         [ 1]  555 	ld	0x5233, a
                                    556 ;	./libs/uart_lib.c: 78: break;
      00854D 20 5E            [ 2]  557 	jra	00114$
                                    558 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      00854F                        559 00107$:
                                    560 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      00854F 35 11 52 32      [ 1]  561 	mov	0x5232+0, #0x11
                                    562 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      008553 C6 52 33         [ 1]  563 	ld	a, 0x5233
      008556 A4 F0            [ 1]  564 	and	a, #0xf0
      008558 AA 06            [ 1]  565 	or	a, #0x06
      00855A C7 52 33         [ 1]  566 	ld	0x5233, a
                                    567 ;	./libs/uart_lib.c: 82: break;
      00855D 20 4E            [ 2]  568 	jra	00114$
                                    569 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      00855F                        570 00108$:
                                    571 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      00855F 35 08 52 32      [ 1]  572 	mov	0x5232+0, #0x08
                                    573 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      008563 C6 52 33         [ 1]  574 	ld	a, 0x5233
      008566 A4 F0            [ 1]  575 	and	a, #0xf0
      008568 AA 0B            [ 1]  576 	or	a, #0x0b
      00856A C7 52 33         [ 1]  577 	ld	0x5233, a
                                    578 ;	./libs/uart_lib.c: 86: break;
      00856D 20 3E            [ 2]  579 	jra	00114$
                                    580 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      00856F                        581 00109$:
                                    582 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      00856F 35 04 52 32      [ 1]  583 	mov	0x5232+0, #0x04
                                    584 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      008573 C6 52 33         [ 1]  585 	ld	a, 0x5233
      008576 A4 F0            [ 1]  586 	and	a, #0xf0
      008578 AA 05            [ 1]  587 	or	a, #0x05
      00857A C7 52 33         [ 1]  588 	ld	0x5233, a
                                    589 ;	./libs/uart_lib.c: 90: break;
      00857D 20 2E            [ 2]  590 	jra	00114$
                                    591 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      00857F                        592 00110$:
                                    593 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      00857F 35 02 52 32      [ 1]  594 	mov	0x5232+0, #0x02
                                    595 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      008583 C6 52 33         [ 1]  596 	ld	a, 0x5233
      008586 A4 F0            [ 1]  597 	and	a, #0xf0
      008588 AA 03            [ 1]  598 	or	a, #0x03
      00858A C7 52 33         [ 1]  599 	ld	0x5233, a
                                    600 ;	./libs/uart_lib.c: 94: break;
      00858D 20 1E            [ 2]  601 	jra	00114$
                                    602 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      00858F                        603 00111$:
                                    604 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      00858F 35 01 52 32      [ 1]  605 	mov	0x5232+0, #0x01
                                    606 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      008593 C6 52 33         [ 1]  607 	ld	a, 0x5233
      008596 A4 F0            [ 1]  608 	and	a, #0xf0
      008598 AA 01            [ 1]  609 	or	a, #0x01
      00859A C7 52 33         [ 1]  610 	ld	0x5233, a
                                    611 ;	./libs/uart_lib.c: 98: break;
      00859D 20 0E            [ 2]  612 	jra	00114$
                                    613 ;	./libs/uart_lib.c: 99: default:
      00859F                        614 00112$:
                                    615 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      00859F 35 68 52 32      [ 1]  616 	mov	0x5232+0, #0x68
                                    617 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      0085A3 C6 52 33         [ 1]  618 	ld	a, 0x5233
      0085A6 A4 F0            [ 1]  619 	and	a, #0xf0
      0085A8 AA 03            [ 1]  620 	or	a, #0x03
      0085AA C7 52 33         [ 1]  621 	ld	0x5233, a
                                    622 ;	./libs/uart_lib.c: 103: }
      0085AD                        623 00114$:
                                    624 ;	./libs/uart_lib.c: 104: }
      0085AD 5B 02            [ 2]  625 	addw	sp, #2
      0085AF 81               [ 4]  626 	ret
                                    627 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    628 ;	-----------------------------------------
                                    629 ;	 function uart_read_byte
                                    630 ;	-----------------------------------------
      0085B0                        631 _uart_read_byte:
                                    632 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      0085B0                        633 00101$:
      0085B0 72 0B 52 30 FB   [ 2]  634 	btjf	0x5230, #5, 00101$
                                    635 ;	./libs/uart_lib.c: 110: return 1;
      0085B5 5F               [ 1]  636 	clrw	x
      0085B6 5C               [ 1]  637 	incw	x
                                    638 ;	./libs/uart_lib.c: 111: }
      0085B7 81               [ 4]  639 	ret
                                    640 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    641 ;	-----------------------------------------
                                    642 ;	 function uart_write_byte
                                    643 ;	-----------------------------------------
      0085B8                        644 _uart_write_byte:
                                    645 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      0085B8 C7 52 31         [ 1]  646 	ld	0x5231, a
                                    647 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      0085BB                        648 00101$:
      0085BB 72 0F 52 30 FB   [ 2]  649 	btjf	0x5230, #7, 00101$
                                    650 ;	./libs/uart_lib.c: 117: return 1;
      0085C0 5F               [ 1]  651 	clrw	x
      0085C1 5C               [ 1]  652 	incw	x
                                    653 ;	./libs/uart_lib.c: 118: }
      0085C2 81               [ 4]  654 	ret
                                    655 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    656 ;	-----------------------------------------
                                    657 ;	 function uart_write
                                    658 ;	-----------------------------------------
      0085C3                        659 _uart_write:
      0085C3 52 04            [ 2]  660 	sub	sp, #4
      0085C5 1F 01            [ 2]  661 	ldw	(0x01, sp), x
                                    662 ;	./libs/uart_lib.c: 122: int count = 0;
      0085C7 5F               [ 1]  663 	clrw	x
      0085C8 1F 03            [ 2]  664 	ldw	(0x03, sp), x
                                    665 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085CA 5F               [ 1]  666 	clrw	x
      0085CB                        667 00103$:
      0085CB 90 93            [ 1]  668 	ldw	y, x
      0085CD 72 F9 01         [ 2]  669 	addw	y, (0x01, sp)
      0085D0 90 F6            [ 1]  670 	ld	a, (y)
      0085D2 27 0E            [ 1]  671 	jreq	00101$
                                    672 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      0085D4 89               [ 2]  673 	pushw	x
      0085D5 CD 85 B8         [ 4]  674 	call	_uart_write_byte
      0085D8 51               [ 1]  675 	exgw	x, y
      0085D9 85               [ 2]  676 	popw	x
      0085DA 72 F9 03         [ 2]  677 	addw	y, (0x03, sp)
      0085DD 17 03            [ 2]  678 	ldw	(0x03, sp), y
                                    679 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085DF 5C               [ 1]  680 	incw	x
      0085E0 20 E9            [ 2]  681 	jra	00103$
      0085E2                        682 00101$:
                                    683 ;	./libs/uart_lib.c: 125: return count;
      0085E2 1E 03            [ 2]  684 	ldw	x, (0x03, sp)
                                    685 ;	./libs/uart_lib.c: 126: }
      0085E4 5B 04            [ 2]  686 	addw	sp, #4
      0085E6 81               [ 4]  687 	ret
                                    688 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    689 ;	-----------------------------------------
                                    690 ;	 function uart_read
                                    691 ;	-----------------------------------------
      0085E7                        692 _uart_read:
      0085E7 52 04            [ 2]  693 	sub	sp, #4
      0085E9 1F 01            [ 2]  694 	ldw	(0x01, sp), x
                                    695 ;	./libs/uart_lib.c: 130: int count = 0;
      0085EB 5F               [ 1]  696 	clrw	x
      0085EC 1F 03            [ 2]  697 	ldw	(0x03, sp), x
                                    698 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085EE 5F               [ 1]  699 	clrw	x
      0085EF                        700 00103$:
      0085EF 90 93            [ 1]  701 	ldw	y, x
      0085F1 72 F9 01         [ 2]  702 	addw	y, (0x01, sp)
      0085F4 90 F6            [ 1]  703 	ld	a, (y)
      0085F6 27 13            [ 1]  704 	jreq	00101$
                                    705 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      0085F8 90 5F            [ 1]  706 	clrw	y
      0085FA 90 97            [ 1]  707 	ld	yl, a
      0085FC 89               [ 2]  708 	pushw	x
      0085FD 93               [ 1]  709 	ldw	x, y
      0085FE CD 85 B0         [ 4]  710 	call	_uart_read_byte
      008601 51               [ 1]  711 	exgw	x, y
      008602 85               [ 2]  712 	popw	x
      008603 72 F9 03         [ 2]  713 	addw	y, (0x03, sp)
      008606 17 03            [ 2]  714 	ldw	(0x03, sp), y
                                    715 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008608 5C               [ 1]  716 	incw	x
      008609 20 E4            [ 2]  717 	jra	00103$
      00860B                        718 00101$:
                                    719 ;	./libs/uart_lib.c: 133: return count;
      00860B 1E 03            [ 2]  720 	ldw	x, (0x03, sp)
                                    721 ;	./libs/uart_lib.c: 134: }
      00860D 5B 04            [ 2]  722 	addw	sp, #4
      00860F 90 85            [ 2]  723 	popw	y
      008611 5B 02            [ 2]  724 	addw	sp, #2
      008613 90 FC            [ 2]  725 	jp	(y)
                                    726 ;	./libs/tmr2_lib.c: 3: void tmr2_irq(void) __interrupt(TIM2_vector)
                                    727 ;	-----------------------------------------
                                    728 ;	 function tmr2_irq
                                    729 ;	-----------------------------------------
      008615                        730 _tmr2_irq:
      008615 4F               [ 1]  731 	clr	a
      008616 62               [ 2]  732 	div	x, a
                                    733 ;	./libs/tmr2_lib.c: 6: disableInterrupts();
      008617 9B               [ 1]  734 	sim
                                    735 ;	./libs/tmr2_lib.c: 7: TIM2_IRQ.all = 0;//обнуление флагов регистров
      008618 35 00 00 C3      [ 1]  736 	mov	_TIM2_IRQ+0, #0x00
                                    737 ;	./libs/tmr2_lib.c: 9: if(TIM2_SR1 -> UIF)//прерывание таймера
      00861C AE 53 04         [ 2]  738 	ldw	x, #0x5304
      00861F F6               [ 1]  739 	ld	a, (x)
      008620 A4 01            [ 1]  740 	and	a, #0x01
      008622 27 0B            [ 1]  741 	jreq	00102$
                                    742 ;	./libs/tmr2_lib.c: 11: TIM2_IRQ.UIF = 1;
      008624 72 1E 00 C3      [ 1]  743 	bset	_TIM2_IRQ+0, #7
                                    744 ;	./libs/tmr2_lib.c: 12: TIM2_IER -> UIE = 0;
      008628 AE 53 03         [ 2]  745 	ldw	x, #0x5303
      00862B F6               [ 1]  746 	ld	a, (x)
      00862C A4 FE            [ 1]  747 	and	a, #0xfe
      00862E F7               [ 1]  748 	ld	(x), a
      00862F                        749 00102$:
                                    750 ;	./libs/tmr2_lib.c: 14: enableInterrupts();
      00862F 9A               [ 1]  751 	rim
                                    752 ;	./libs/tmr2_lib.c: 15: }
      008630 80               [11]  753 	iret
                                    754 ;	./libs/tmr2_lib.c: 16: void delay_s(uint8_t ticks)
                                    755 ;	-----------------------------------------
                                    756 ;	 function delay_s
                                    757 ;	-----------------------------------------
      008631                        758 _delay_s:
      008631 52 05            [ 2]  759 	sub	sp, #5
      008633 6B 03            [ 1]  760 	ld	(0x03, sp), a
                                    761 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks;i++)
      008635 5F               [ 1]  762 	clrw	x
      008636 1F 04            [ 2]  763 	ldw	(0x04, sp), x
      008638                        764 00106$:
      008638 7B 03            [ 1]  765 	ld	a, (0x03, sp)
      00863A 6B 02            [ 1]  766 	ld	(0x02, sp), a
      00863C 0F 01            [ 1]  767 	clr	(0x01, sp)
      00863E 1E 04            [ 2]  768 	ldw	x, (0x04, sp)
      008640 13 01            [ 2]  769 	cpw	x, (0x01, sp)
      008642 2E 2A            [ 1]  770 	jrsge	00104$
                                    771 ;	./libs/tmr2_lib.c: 20: TIM2_SR1 -> UIF = 0;
      008644 72 11 53 04      [ 1]  772 	bres	0x5304, #0
                                    773 ;	./libs/tmr2_lib.c: 21: TIM2_ARRH->ARR = 0x03;
      008648 35 03 53 0F      [ 1]  774 	mov	0x530f+0, #0x03
                                    775 ;	./libs/tmr2_lib.c: 22: TIM2_ARRL->ARR = 0xD1;
      00864C 35 D1 53 10      [ 1]  776 	mov	0x5310+0, #0xd1
                                    777 ;	./libs/tmr2_lib.c: 23: TIM2_PSCR -> PSC = 0x0E;
      008650 C6 53 0E         [ 1]  778 	ld	a, 0x530e
      008653 A4 F0            [ 1]  779 	and	a, #0xf0
      008655 AA 0E            [ 1]  780 	or	a, #0x0e
      008657 C7 53 0E         [ 1]  781 	ld	0x530e, a
                                    782 ;	./libs/tmr2_lib.c: 24: TIM2_IER -> UIE = 1;
      00865A 72 10 53 03      [ 1]  783 	bset	0x5303, #0
                                    784 ;	./libs/tmr2_lib.c: 25: TIM2_CR1-> CEN = 1;
      00865E 72 10 53 00      [ 1]  785 	bset	0x5300, #0
                                    786 ;	./libs/tmr2_lib.c: 26: while(TIM2_IER -> UIE);	
      008662                        787 00101$:
      008662 72 00 53 03 FB   [ 2]  788 	btjt	0x5303, #0, 00101$
                                    789 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks;i++)
      008667 1E 04            [ 2]  790 	ldw	x, (0x04, sp)
      008669 5C               [ 1]  791 	incw	x
      00866A 1F 04            [ 2]  792 	ldw	(0x04, sp), x
      00866C 20 CA            [ 2]  793 	jra	00106$
      00866E                        794 00104$:
                                    795 ;	./libs/tmr2_lib.c: 28: TIM2_CR1-> CEN = 0;
      00866E 72 11 53 00      [ 1]  796 	bres	0x5300, #0
                                    797 ;	./libs/tmr2_lib.c: 29: }
      008672 5B 05            [ 2]  798 	addw	sp, #5
      008674 81               [ 4]  799 	ret
                                    800 ;	./libs/tmr2_lib.c: 30: void delay_ms(uint8_t ticks)
                                    801 ;	-----------------------------------------
                                    802 ;	 function delay_ms
                                    803 ;	-----------------------------------------
      008675                        804 _delay_ms:
      008675 52 05            [ 2]  805 	sub	sp, #5
      008677 6B 03            [ 1]  806 	ld	(0x03, sp), a
                                    807 ;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks;i++)
      008679 5F               [ 1]  808 	clrw	x
      00867A 1F 04            [ 2]  809 	ldw	(0x04, sp), x
      00867C                        810 00106$:
      00867C 7B 03            [ 1]  811 	ld	a, (0x03, sp)
      00867E 6B 02            [ 1]  812 	ld	(0x02, sp), a
      008680 0F 01            [ 1]  813 	clr	(0x01, sp)
      008682 1E 04            [ 2]  814 	ldw	x, (0x04, sp)
      008684 13 01            [ 2]  815 	cpw	x, (0x01, sp)
      008686 2E 28            [ 1]  816 	jrsge	00104$
                                    817 ;	./libs/tmr2_lib.c: 34: TIM2_SR1 -> UIF = 0;
      008688 72 11 53 04      [ 1]  818 	bres	0x5304, #0
                                    819 ;	./libs/tmr2_lib.c: 35: TIM2_ARRH->ARR = 0x00;
      00868C 35 00 53 0F      [ 1]  820 	mov	0x530f+0, #0x00
                                    821 ;	./libs/tmr2_lib.c: 36: TIM2_ARRL->ARR = 0x7D;
      008690 35 7D 53 10      [ 1]  822 	mov	0x5310+0, #0x7d
                                    823 ;	./libs/tmr2_lib.c: 37: TIM2_PSCR -> PSC = 0x0F;
      008694 C6 53 0E         [ 1]  824 	ld	a, 0x530e
      008697 AA 0F            [ 1]  825 	or	a, #0x0f
      008699 C7 53 0E         [ 1]  826 	ld	0x530e, a
                                    827 ;	./libs/tmr2_lib.c: 38: TIM2_IER -> UIE = 1;
      00869C 72 10 53 03      [ 1]  828 	bset	0x5303, #0
                                    829 ;	./libs/tmr2_lib.c: 39: TIM2_CR1-> CEN = 1;
      0086A0 72 10 53 00      [ 1]  830 	bset	0x5300, #0
                                    831 ;	./libs/tmr2_lib.c: 40: while(TIM2_IER -> UIE);	
      0086A4                        832 00101$:
      0086A4 72 00 53 03 FB   [ 2]  833 	btjt	0x5303, #0, 00101$
                                    834 ;	./libs/tmr2_lib.c: 32: for(int i = 0;i<ticks;i++)
      0086A9 1E 04            [ 2]  835 	ldw	x, (0x04, sp)
      0086AB 5C               [ 1]  836 	incw	x
      0086AC 1F 04            [ 2]  837 	ldw	(0x04, sp), x
      0086AE 20 CC            [ 2]  838 	jra	00106$
      0086B0                        839 00104$:
                                    840 ;	./libs/tmr2_lib.c: 42: TIM2_CR1-> CEN = 0;
      0086B0 72 11 53 00      [ 1]  841 	bres	0x5300, #0
                                    842 ;	./libs/tmr2_lib.c: 43: }
      0086B4 5B 05            [ 2]  843 	addw	sp, #5
      0086B6 81               [ 4]  844 	ret
                                    845 ;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    846 ;	-----------------------------------------
                                    847 ;	 function i2c_irq
                                    848 ;	-----------------------------------------
      0086B7                        849 _i2c_irq:
      0086B7 4F               [ 1]  850 	clr	a
      0086B8 62               [ 2]  851 	div	x, a
                                    852 ;	./libs/i2c_lib.c: 6: disableInterrupts();
      0086B9 9B               [ 1]  853 	sim
                                    854 ;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
      0086BA 35 00 00 C4      [ 1]  855 	mov	_I2C_IRQ+0, #0x00
                                    856 ;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
      0086BE AE 52 17         [ 2]  857 	ldw	x, #0x5217
      0086C1 F6               [ 1]  858 	ld	a, (x)
      0086C2 44               [ 1]  859 	srl	a
      0086C3 A4 01            [ 1]  860 	and	a, #0x01
      0086C5 27 16            [ 1]  861 	jreq	00102$
                                    862 ;	./libs/i2c_lib.c: 11: clr_sr1();
      0086C7 C6 52 17         [ 1]  863 	ld	a,0x5217
                                    864 ;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
      0086CA 72 12 00 C4      [ 1]  865 	bset	_I2C_IRQ+0, #1
                                    866 ;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
      0086CE C6 52 19         [ 1]  867 	ld	a,0x5219
                                    868 ;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
      0086D1 72 13 52 1A      [ 1]  869 	bres	0x521a, #1
                                    870 ;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
      0086D5 A6 E1            [ 1]  871 	ld	a, #0xe1
      0086D7 CD 85 B8         [ 4]  872 	call	_uart_write_byte
                                    873 ;	./libs/i2c_lib.c: 16: return;
      0086DA CC 87 70         [ 2]  874 	jp	00113$
      0086DD                        875 00102$:
                                    876 ;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      0086DD C6 52 17         [ 1]  877 	ld	a, 0x5217
      0086E0 4E               [ 1]  878 	swap	a
      0086E1 44               [ 1]  879 	srl	a
      0086E2 44               [ 1]  880 	srl	a
      0086E3 44               [ 1]  881 	srl	a
      0086E4 A5 01            [ 1]  882 	bcp	a, #0x01
      0086E6 27 17            [ 1]  883 	jreq	00104$
                                    884 ;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
      0086E8 72 18 00 C4      [ 1]  885 	bset	_I2C_IRQ+0, #4
                                    886 ;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
      0086EC 72 15 52 1A      [ 1]  887 	bres	0x521a, #2
                                    888 ;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
      0086F0 72 13 52 1A      [ 1]  889 	bres	0x521a, #1
                                    890 ;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
      0086F4 72 11 52 1A      [ 1]  891 	bres	0x521a, #0
                                    892 ;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
      0086F8 A6 EA            [ 1]  893 	ld	a, #0xea
      0086FA CD 85 B8         [ 4]  894 	call	_uart_write_byte
                                    895 ;	./libs/i2c_lib.c: 26: return;
      0086FD 20 71            [ 2]  896 	jra	00113$
      0086FF                        897 00104$:
                                    898 ;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      0086FF C6 52 17         [ 1]  899 	ld	a, 0x5217
      008702 4E               [ 1]  900 	swap	a
      008703 44               [ 1]  901 	srl	a
      008704 44               [ 1]  902 	srl	a
      008705 A5 01            [ 1]  903 	bcp	a, #0x01
      008707 27 17            [ 1]  904 	jreq	00106$
                                    905 ;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
      008709 72 16 00 C4      [ 1]  906 	bset	_I2C_IRQ+0, #3
                                    907 ;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
      00870D 72 15 52 1A      [ 1]  908 	bres	0x521a, #2
                                    909 ;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
      008711 72 13 52 1A      [ 1]  910 	bres	0x521a, #1
                                    911 ;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
      008715 72 11 52 1A      [ 1]  912 	bres	0x521a, #0
                                    913 ;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
      008719 A6 EB            [ 1]  914 	ld	a, #0xeb
      00871B CD 85 B8         [ 4]  915 	call	_uart_write_byte
                                    916 ;	./libs/i2c_lib.c: 35: return;
      00871E 20 50            [ 2]  917 	jra	00113$
      008720                        918 00106$:
                                    919 ;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      008720 C6 52 17         [ 1]  920 	ld	a, 0x5217
      008723 A5 01            [ 1]  921 	bcp	a, #0x01
      008725 27 0F            [ 1]  922 	jreq	00108$
                                    923 ;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
      008727 72 10 00 C4      [ 1]  924 	bset	_I2C_IRQ+0, #0
                                    925 ;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
      00872B 72 13 52 1A      [ 1]  926 	bres	0x521a, #1
                                    927 ;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
      00872F A6 E2            [ 1]  928 	ld	a, #0xe2
      008731 CD 85 B8         [ 4]  929 	call	_uart_write_byte
                                    930 ;	./libs/i2c_lib.c: 43: return;
      008734 20 3A            [ 2]  931 	jra	00113$
      008736                        932 00108$:
                                    933 ;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
      008736 C6 52 17         [ 1]  934 	ld	a, 0x5217
      008739 44               [ 1]  935 	srl	a
      00873A 44               [ 1]  936 	srl	a
      00873B A5 01            [ 1]  937 	bcp	a, #0x01
      00873D 27 0F            [ 1]  938 	jreq	00110$
                                    939 ;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
      00873F 72 14 00 C4      [ 1]  940 	bset	_I2C_IRQ+0, #2
                                    941 ;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
      008743 72 13 52 1A      [ 1]  942 	bres	0x521a, #1
                                    943 ;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
      008747 A6 E3            [ 1]  944 	ld	a, #0xe3
      008749 CD 85 B8         [ 4]  945 	call	_uart_write_byte
                                    946 ;	./libs/i2c_lib.c: 50: return;
      00874C 20 22            [ 2]  947 	jra	00113$
      00874E                        948 00110$:
                                    949 ;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      00874E AE 52 18         [ 2]  950 	ldw	x, #0x5218
      008751 F6               [ 1]  951 	ld	a, (x)
      008752 44               [ 1]  952 	srl	a
      008753 44               [ 1]  953 	srl	a
      008754 A4 01            [ 1]  954 	and	a, #0x01
      008756 27 17            [ 1]  955 	jreq	00112$
                                    956 ;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
      008758 72 1A 00 C4      [ 1]  957 	bset	_I2C_IRQ+0, #5
                                    958 ;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
      00875C 72 13 52 1A      [ 1]  959 	bres	0x521a, #1
                                    960 ;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
      008760 72 11 52 1A      [ 1]  961 	bres	0x521a, #0
                                    962 ;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
      008764 72 15 52 1A      [ 1]  963 	bres	0x521a, #2
                                    964 ;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
      008768 A6 EE            [ 1]  965 	ld	a, #0xee
      00876A CD 85 B8         [ 4]  966 	call	_uart_write_byte
                                    967 ;	./libs/i2c_lib.c: 60: return;
      00876D 20 01            [ 2]  968 	jra	00113$
      00876F                        969 00112$:
                                    970 ;	./libs/i2c_lib.c: 63: enableInterrupts(); 
      00876F 9A               [ 1]  971 	rim
      008770                        972 00113$:
                                    973 ;	./libs/i2c_lib.c: 64: }
      008770 80               [11]  974 	iret
                                    975 ;	./libs/i2c_lib.c: 66: void i2c_init(void)
                                    976 ;	-----------------------------------------
                                    977 ;	 function i2c_init
                                    978 ;	-----------------------------------------
      008771                        979 _i2c_init:
                                    980 ;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      008771 72 11 52 10      [ 1]  981 	bres	0x5210, #0
                                    982 ;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      008775 C6 52 12         [ 1]  983 	ld	a, 0x5212
      008778 A4 C0            [ 1]  984 	and	a, #0xc0
      00877A AA 10            [ 1]  985 	or	a, #0x10
      00877C C7 52 12         [ 1]  986 	ld	0x5212, a
                                    987 ;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
      00877F C6 52 1C         [ 1]  988 	ld	a, 0x521c
      008782 A4 F0            [ 1]  989 	and	a, #0xf0
      008784 C7 52 1C         [ 1]  990 	ld	0x521c, a
                                    991 ;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008787 35 50 52 1B      [ 1]  992 	mov	0x521b+0, #0x50
                                    993 ;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      00878B 72 1F 52 1C      [ 1]  994 	bres	0x521c, #7
                                    995 ;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      00878F 72 1F 52 14      [ 1]  996 	bres	0x5214, #7
                                    997 ;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
      008793 72 10 52 14      [ 1]  998 	bset	0x5214, #0
                                    999 ;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      008797 72 10 52 10      [ 1] 1000 	bset	0x5210, #0
                                   1001 ;	./libs/i2c_lib.c: 78: }
      00879B 81               [ 4] 1002 	ret
                                   1003 ;	./libs/i2c_lib.c: 80: void i2c_start(void)
                                   1004 ;	-----------------------------------------
                                   1005 ;	 function i2c_start
                                   1006 ;	-----------------------------------------
      00879C                       1007 _i2c_start:
                                   1008 ;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      00879C 72 10 52 11      [ 1] 1009 	bset	0x5211, #0
                                   1010 ;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0087A0                       1011 00101$:
      0087A0 72 01 52 17 FB   [ 2] 1012 	btjf	0x5217, #0, 00101$
                                   1013 ;	./libs/i2c_lib.c: 84: }
      0087A5 81               [ 4] 1014 	ret
                                   1015 ;	./libs/i2c_lib.c: 86: void i2c_stop(void)
                                   1016 ;	-----------------------------------------
                                   1017 ;	 function i2c_stop
                                   1018 ;	-----------------------------------------
      0087A6                       1019 _i2c_stop:
                                   1020 ;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0087A6 72 12 52 11      [ 1] 1021 	bset	0x5211, #1
                                   1022 ;	./libs/i2c_lib.c: 89: }
      0087AA 81               [ 4] 1023 	ret
                                   1024 ;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                   1025 ;	-----------------------------------------
                                   1026 ;	 function i2c_send_address
                                   1027 ;	-----------------------------------------
      0087AB                       1028 _i2c_send_address:
                                   1029 ;	./libs/i2c_lib.c: 96: address = address << 1;
      0087AB 48               [ 1] 1030 	sll	a
                                   1031 ;	./libs/i2c_lib.c: 93: switch(rw_type)
      0087AC 88               [ 1] 1032 	push	a
      0087AD 7B 04            [ 1] 1033 	ld	a, (0x04, sp)
      0087AF 4A               [ 1] 1034 	dec	a
      0087B0 84               [ 1] 1035 	pop	a
      0087B1 26 02            [ 1] 1036 	jrne	00102$
                                   1037 ;	./libs/i2c_lib.c: 96: address = address << 1;
                                   1038 ;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0087B3 AA 01            [ 1] 1039 	or	a, #0x01
                                   1040 ;	./libs/i2c_lib.c: 98: break;
                                   1041 ;	./libs/i2c_lib.c: 99: default:
                                   1042 ;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
                                   1043 ;	./libs/i2c_lib.c: 102: }
      0087B5                       1044 00102$:
                                   1045 ;	./libs/i2c_lib.c: 103: i2c_start();
      0087B5 88               [ 1] 1046 	push	a
      0087B6 CD 87 9C         [ 4] 1047 	call	_i2c_start
      0087B9 84               [ 1] 1048 	pop	a
                                   1049 ;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
      0087BA C7 52 16         [ 1] 1050 	ld	0x5216, a
                                   1051 ;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
      0087BD                       1052 00106$:
      0087BD AE 52 17         [ 2] 1053 	ldw	x, #0x5217
      0087C0 F6               [ 1] 1054 	ld	a, (x)
      0087C1 44               [ 1] 1055 	srl	a
      0087C2 A4 01            [ 1] 1056 	and	a, #0x01
      0087C4 26 08            [ 1] 1057 	jrne	00108$
                                   1058 ;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
      0087C6 72 05 52 18 F2   [ 2] 1059 	btjf	0x5218, #2, 00106$
                                   1060 ;	./libs/i2c_lib.c: 107: return 0;
      0087CB 4F               [ 1] 1061 	clr	a
      0087CC 20 08            [ 2] 1062 	jra	00109$
      0087CE                       1063 00108$:
                                   1064 ;	./libs/i2c_lib.c: 108: clr_sr1();
      0087CE C6 52 17         [ 1] 1065 	ld	a,0x5217
                                   1066 ;	./libs/i2c_lib.c: 109: clr_sr3();
      0087D1 C6 52 19         [ 1] 1067 	ld	a,0x5219
                                   1068 ;	./libs/i2c_lib.c: 110: return 1;
      0087D4 A6 01            [ 1] 1069 	ld	a, #0x01
      0087D6                       1070 00109$:
                                   1071 ;	./libs/i2c_lib.c: 111: }
      0087D6 85               [ 2] 1072 	popw	x
      0087D7 5B 01            [ 2] 1073 	addw	sp, #1
      0087D9 FC               [ 2] 1074 	jp	(x)
                                   1075 ;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
                                   1076 ;	-----------------------------------------
                                   1077 ;	 function i2c_read_byte
                                   1078 ;	-----------------------------------------
      0087DA                       1079 _i2c_read_byte:
                                   1080 ;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
      0087DA                       1081 00101$:
      0087DA 72 0D 52 17 FB   [ 2] 1082 	btjf	0x5217, #6, 00101$
                                   1083 ;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
      0087DF C6 52 16         [ 1] 1084 	ld	a, 0x5216
                                   1085 ;	./libs/i2c_lib.c: 117: }
      0087E2 81               [ 4] 1086 	ret
                                   1087 ;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                   1088 ;	-----------------------------------------
                                   1089 ;	 function i2c_read
                                   1090 ;	-----------------------------------------
      0087E3                       1091 _i2c_read:
      0087E3 52 04            [ 2] 1092 	sub	sp, #4
                                   1093 ;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      0087E5 4B 01            [ 1] 1094 	push	#0x01
      0087E7 CD 87 AB         [ 4] 1095 	call	_i2c_send_address
      0087EA 4D               [ 1] 1096 	tnz	a
      0087EB 27 3C            [ 1] 1097 	jreq	00103$
                                   1098 ;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      0087ED 72 14 52 11      [ 1] 1099 	bset	0x5211, #2
                                   1100 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      0087F1 5F               [ 1] 1101 	clrw	x
      0087F2 1F 03            [ 2] 1102 	ldw	(0x03, sp), x
      0087F4                       1103 00105$:
      0087F4 5F               [ 1] 1104 	clrw	x
      0087F5 7B 07            [ 1] 1105 	ld	a, (0x07, sp)
      0087F7 97               [ 1] 1106 	ld	xl, a
      0087F8 5A               [ 2] 1107 	decw	x
      0087F9 1F 01            [ 2] 1108 	ldw	(0x01, sp), x
      0087FB 1E 03            [ 2] 1109 	ldw	x, (0x03, sp)
      0087FD 13 01            [ 2] 1110 	cpw	x, (0x01, sp)
      0087FF 2E 12            [ 1] 1111 	jrsge	00101$
                                   1112 ;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      008801 1E 08            [ 2] 1113 	ldw	x, (0x08, sp)
      008803 72 FB 03         [ 2] 1114 	addw	x, (0x03, sp)
      008806 89               [ 2] 1115 	pushw	x
      008807 CD 87 DA         [ 4] 1116 	call	_i2c_read_byte
      00880A 85               [ 2] 1117 	popw	x
      00880B F7               [ 1] 1118 	ld	(x), a
                                   1119 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00880C 1E 03            [ 2] 1120 	ldw	x, (0x03, sp)
      00880E 5C               [ 1] 1121 	incw	x
      00880F 1F 03            [ 2] 1122 	ldw	(0x03, sp), x
      008811 20 E1            [ 2] 1123 	jra	00105$
      008813                       1124 00101$:
                                   1125 ;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      008813 C6 52 11         [ 1] 1126 	ld	a, 0x5211
      008816 A4 FB            [ 1] 1127 	and	a, #0xfb
      008818 C7 52 11         [ 1] 1128 	ld	0x5211, a
                                   1129 ;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
      00881B 1E 08            [ 2] 1130 	ldw	x, (0x08, sp)
      00881D 72 FB 01         [ 2] 1131 	addw	x, (0x01, sp)
      008820 89               [ 2] 1132 	pushw	x
      008821 CD 87 DA         [ 4] 1133 	call	_i2c_read_byte
      008824 85               [ 2] 1134 	popw	x
      008825 F7               [ 1] 1135 	ld	(x), a
                                   1136 ;	./libs/i2c_lib.c: 132: i2c_stop();
      008826 CD 87 A6         [ 4] 1137 	call	_i2c_stop
      008829                       1138 00103$:
                                   1139 ;	./libs/i2c_lib.c: 135: i2c_stop();
      008829 1E 05            [ 2] 1140 	ldw	x, (5, sp)
      00882B 1F 08            [ 2] 1141 	ldw	(8, sp), x
      00882D 5B 07            [ 2] 1142 	addw	sp, #7
                                   1143 ;	./libs/i2c_lib.c: 137: }
      00882F CC 87 A6         [ 2] 1144 	jp	_i2c_stop
                                   1145 ;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
                                   1146 ;	-----------------------------------------
                                   1147 ;	 function i2c_send_byte
                                   1148 ;	-----------------------------------------
      008832                       1149 _i2c_send_byte:
                                   1150 ;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
      008832 C7 52 16         [ 1] 1151 	ld	0x5216, a
                                   1152 ;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
      008835                       1153 00103$:
      008835 72 0E 52 17 08   [ 2] 1154 	btjt	0x5217, #7, 00105$
                                   1155 ;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
      00883A 72 05 52 18 F6   [ 2] 1156 	btjf	0x5218, #2, 00103$
                                   1157 ;	./libs/i2c_lib.c: 144: return 1;
      00883F A6 01            [ 1] 1158 	ld	a, #0x01
      008841 81               [ 4] 1159 	ret
      008842                       1160 00105$:
                                   1161 ;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
      008842 4F               [ 1] 1162 	clr	a
                                   1163 ;	./libs/i2c_lib.c: 146: }
      008843 81               [ 4] 1164 	ret
                                   1165 ;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                   1166 ;	-----------------------------------------
                                   1167 ;	 function i2c_write
                                   1168 ;	-----------------------------------------
      008844                       1169 _i2c_write:
      008844 52 02            [ 2] 1170 	sub	sp, #2
                                   1171 ;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008846 4B 00            [ 1] 1172 	push	#0x00
      008848 CD 87 AB         [ 4] 1173 	call	_i2c_send_address
      00884B 4D               [ 1] 1174 	tnz	a
      00884C 27 1D            [ 1] 1175 	jreq	00105$
                                   1176 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      00884E 5F               [ 1] 1177 	clrw	x
      00884F                       1178 00107$:
      00884F 7B 05            [ 1] 1179 	ld	a, (0x05, sp)
      008851 6B 02            [ 1] 1180 	ld	(0x02, sp), a
      008853 0F 01            [ 1] 1181 	clr	(0x01, sp)
      008855 13 01            [ 2] 1182 	cpw	x, (0x01, sp)
      008857 2E 12            [ 1] 1183 	jrsge	00105$
                                   1184 ;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008859 90 93            [ 1] 1185 	ldw	y, x
      00885B 72 F9 06         [ 2] 1186 	addw	y, (0x06, sp)
      00885E 90 F6            [ 1] 1187 	ld	a, (y)
      008860 89               [ 2] 1188 	pushw	x
      008861 CD 88 32         [ 4] 1189 	call	_i2c_send_byte
      008864 85               [ 2] 1190 	popw	x
      008865 4D               [ 1] 1191 	tnz	a
      008866 26 03            [ 1] 1192 	jrne	00105$
                                   1193 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      008868 5C               [ 1] 1194 	incw	x
      008869 20 E4            [ 2] 1195 	jra	00107$
      00886B                       1196 00105$:
                                   1197 ;	./libs/i2c_lib.c: 158: i2c_stop();
      00886B 1E 03            [ 2] 1198 	ldw	x, (3, sp)
      00886D 1F 06            [ 2] 1199 	ldw	(6, sp), x
      00886F 5B 05            [ 2] 1200 	addw	sp, #5
                                   1201 ;	./libs/i2c_lib.c: 159: }
      008871 CC 87 A6         [ 2] 1202 	jp	_i2c_stop
                                   1203 ;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
                                   1204 ;	-----------------------------------------
                                   1205 ;	 function i2c_scan
                                   1206 ;	-----------------------------------------
      008874                       1207 _i2c_scan:
      008874 52 02            [ 2] 1208 	sub	sp, #2
                                   1209 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      008876 A6 01            [ 1] 1210 	ld	a, #0x01
      008878 6B 01            [ 1] 1211 	ld	(0x01, sp), a
      00887A                       1212 00105$:
      00887A A1 7F            [ 1] 1213 	cp	a, #0x7f
      00887C 24 22            [ 1] 1214 	jrnc	00103$
                                   1215 ;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      00887E 88               [ 1] 1216 	push	a
      00887F 4B 00            [ 1] 1217 	push	#0x00
      008881 CD 87 AB         [ 4] 1218 	call	_i2c_send_address
      008884 6B 03            [ 1] 1219 	ld	(0x03, sp), a
      008886 84               [ 1] 1220 	pop	a
      008887 0D 02            [ 1] 1221 	tnz	(0x02, sp)
      008889 27 07            [ 1] 1222 	jreq	00102$
                                   1223 ;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
      00888B CD 87 A6         [ 4] 1224 	call	_i2c_stop
                                   1225 ;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
      00888E 7B 01            [ 1] 1226 	ld	a, (0x01, sp)
      008890 20 12            [ 2] 1227 	jra	00107$
      008892                       1228 00102$:
                                   1229 ;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
      008892 AE 52 18         [ 2] 1230 	ldw	x, #0x5218
      008895 88               [ 1] 1231 	push	a
      008896 F6               [ 1] 1232 	ld	a, (x)
      008897 A4 FB            [ 1] 1233 	and	a, #0xfb
      008899 F7               [ 1] 1234 	ld	(x), a
      00889A 84               [ 1] 1235 	pop	a
                                   1236 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      00889B 4C               [ 1] 1237 	inc	a
      00889C 6B 01            [ 1] 1238 	ld	(0x01, sp), a
      00889E 20 DA            [ 2] 1239 	jra	00105$
      0088A0                       1240 00103$:
                                   1241 ;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
      0088A0 CD 87 A6         [ 4] 1242 	call	_i2c_stop
                                   1243 ;	./libs/i2c_lib.c: 173: return 0;
      0088A3 4F               [ 1] 1244 	clr	a
      0088A4                       1245 00107$:
                                   1246 ;	./libs/i2c_lib.c: 174: }
      0088A4 5B 02            [ 2] 1247 	addw	sp, #2
      0088A6 81               [ 4] 1248 	ret
                                   1249 ;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
                                   1250 ;	-----------------------------------------
                                   1251 ;	 function i2c_start_irq
                                   1252 ;	-----------------------------------------
      0088A7                       1253 _i2c_start_irq:
                                   1254 ;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      0088A7 72 12 52 1A      [ 1] 1255 	bset	0x521a, #1
                                   1256 ;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0088AB 72 10 52 11      [ 1] 1257 	bset	0x5211, #0
                                   1258 ;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      0088AF                       1259 00101$:
      0088AF C6 52 1A         [ 1] 1260 	ld	a, 0x521a
      0088B2 A5 02            [ 1] 1261 	bcp	a, #2
      0088B4 26 F9            [ 1] 1262 	jrne	00101$
                                   1263 ;	./libs/i2c_lib.c: 182: }
      0088B6 81               [ 4] 1264 	ret
                                   1265 ;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
                                   1266 ;	-----------------------------------------
                                   1267 ;	 function i2c_stop_irq
                                   1268 ;	-----------------------------------------
      0088B7                       1269 _i2c_stop_irq:
                                   1270 ;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0088B7 72 12 52 11      [ 1] 1271 	bset	0x5211, #1
                                   1272 ;	./libs/i2c_lib.c: 187: }
      0088BB 81               [ 4] 1273 	ret
                                   1274 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                   1275 ;	-----------------------------------------
                                   1276 ;	 function get_bit
                                   1277 ;	-----------------------------------------
      0088BC                       1278 _get_bit:
                                   1279 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      0088BC 7B 04            [ 1] 1280 	ld	a, (0x04, sp)
      0088BE 27 04            [ 1] 1281 	jreq	00113$
      0088C0                       1282 00112$:
      0088C0 57               [ 2] 1283 	sraw	x
      0088C1 4A               [ 1] 1284 	dec	a
      0088C2 26 FC            [ 1] 1285 	jrne	00112$
      0088C4                       1286 00113$:
      0088C4 54               [ 2] 1287 	srlw	x
      0088C5 24 03            [ 1] 1288 	jrnc	00103$
      0088C7 5F               [ 1] 1289 	clrw	x
      0088C8 5C               [ 1] 1290 	incw	x
      0088C9 21                    1291 	.byte 0x21
      0088CA                       1292 00103$:
      0088CA 5F               [ 1] 1293 	clrw	x
      0088CB                       1294 00104$:
                                   1295 ;	./libs/ssd1306_lib.c: 6: }
      0088CB 90 85            [ 2] 1296 	popw	y
      0088CD 5B 02            [ 2] 1297 	addw	sp, #2
      0088CF 90 FC            [ 2] 1298 	jp	(y)
                                   1299 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                   1300 ;	-----------------------------------------
                                   1301 ;	 function set_bit
                                   1302 ;	-----------------------------------------
      0088D1                       1303 _set_bit:
      0088D1 52 04            [ 2] 1304 	sub	sp, #4
      0088D3 1F 01            [ 2] 1305 	ldw	(0x01, sp), x
                                   1306 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      0088D5 5F               [ 1] 1307 	clrw	x
      0088D6 5C               [ 1] 1308 	incw	x
      0088D7 1F 03            [ 2] 1309 	ldw	(0x03, sp), x
      0088D9 7B 08            [ 1] 1310 	ld	a, (0x08, sp)
      0088DB 27 07            [ 1] 1311 	jreq	00114$
      0088DD                       1312 00113$:
      0088DD 08 04            [ 1] 1313 	sll	(0x04, sp)
      0088DF 09 03            [ 1] 1314 	rlc	(0x03, sp)
      0088E1 4A               [ 1] 1315 	dec	a
      0088E2 26 F9            [ 1] 1316 	jrne	00113$
      0088E4                       1317 00114$:
                                   1318 ;	./libs/ssd1306_lib.c: 10: switch(value)
      0088E4 1E 09            [ 2] 1319 	ldw	x, (0x09, sp)
      0088E6 5A               [ 2] 1320 	decw	x
      0088E7 26 0B            [ 1] 1321 	jrne	00102$
                                   1322 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      0088E9 7B 02            [ 1] 1323 	ld	a, (0x02, sp)
      0088EB 1A 04            [ 1] 1324 	or	a, (0x04, sp)
      0088ED 97               [ 1] 1325 	ld	xl, a
      0088EE 7B 01            [ 1] 1326 	ld	a, (0x01, sp)
      0088F0 1A 03            [ 1] 1327 	or	a, (0x03, sp)
                                   1328 ;	./libs/ssd1306_lib.c: 14: break;
      0088F2 20 09            [ 2] 1329 	jra	00103$
                                   1330 ;	./libs/ssd1306_lib.c: 16: default:
      0088F4                       1331 00102$:
                                   1332 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      0088F4 1E 03            [ 2] 1333 	ldw	x, (0x03, sp)
      0088F6 53               [ 2] 1334 	cplw	x
      0088F7 9F               [ 1] 1335 	ld	a, xl
      0088F8 14 02            [ 1] 1336 	and	a, (0x02, sp)
      0088FA 02               [ 1] 1337 	rlwa	x
      0088FB 14 01            [ 1] 1338 	and	a, (0x01, sp)
                                   1339 ;	./libs/ssd1306_lib.c: 19: }
      0088FD                       1340 00103$:
                                   1341 ;	./libs/ssd1306_lib.c: 20: return data;
      0088FD 95               [ 1] 1342 	ld	xh, a
                                   1343 ;	./libs/ssd1306_lib.c: 21: }
      0088FE 16 05            [ 2] 1344 	ldw	y, (5, sp)
      008900 5B 0A            [ 2] 1345 	addw	sp, #10
      008902 90 FC            [ 2] 1346 	jp	(y)
                                   1347 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                   1348 ;	-----------------------------------------
                                   1349 ;	 function ssd1306_init
                                   1350 ;	-----------------------------------------
      008904                       1351 _ssd1306_init:
      008904 52 1B            [ 2] 1352 	sub	sp, #27
                                   1353 ;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
      008906 96               [ 1] 1354 	ldw	x, sp
      008907 5C               [ 1] 1355 	incw	x
      008908 7F               [ 1] 1356 	clr	(x)
      008909 A6 AE            [ 1] 1357 	ld	a, #0xae
      00890B 6B 02            [ 1] 1358 	ld	(0x02, sp), a
      00890D A6 D5            [ 1] 1359 	ld	a, #0xd5
      00890F 6B 03            [ 1] 1360 	ld	(0x03, sp), a
      008911 A6 80            [ 1] 1361 	ld	a, #0x80
      008913 6B 04            [ 1] 1362 	ld	(0x04, sp), a
      008915 A6 A8            [ 1] 1363 	ld	a, #0xa8
      008917 6B 05            [ 1] 1364 	ld	(0x05, sp), a
      008919 A6 1F            [ 1] 1365 	ld	a, #0x1f
      00891B 6B 06            [ 1] 1366 	ld	(0x06, sp), a
      00891D A6 D3            [ 1] 1367 	ld	a, #0xd3
      00891F 6B 07            [ 1] 1368 	ld	(0x07, sp), a
      008921 0F 08            [ 1] 1369 	clr	(0x08, sp)
      008923 A6 40            [ 1] 1370 	ld	a, #0x40
      008925 6B 09            [ 1] 1371 	ld	(0x09, sp), a
      008927 A6 8D            [ 1] 1372 	ld	a, #0x8d
      008929 6B 0A            [ 1] 1373 	ld	(0x0a, sp), a
      00892B A6 14            [ 1] 1374 	ld	a, #0x14
      00892D 6B 0B            [ 1] 1375 	ld	(0x0b, sp), a
      00892F A6 DB            [ 1] 1376 	ld	a, #0xdb
      008931 6B 0C            [ 1] 1377 	ld	(0x0c, sp), a
      008933 A6 40            [ 1] 1378 	ld	a, #0x40
      008935 6B 0D            [ 1] 1379 	ld	(0x0d, sp), a
      008937 A6 A4            [ 1] 1380 	ld	a, #0xa4
      008939 6B 0E            [ 1] 1381 	ld	(0x0e, sp), a
      00893B A6 A6            [ 1] 1382 	ld	a, #0xa6
      00893D 6B 0F            [ 1] 1383 	ld	(0x0f, sp), a
      00893F A6 DA            [ 1] 1384 	ld	a, #0xda
      008941 6B 10            [ 1] 1385 	ld	(0x10, sp), a
      008943 A6 02            [ 1] 1386 	ld	a, #0x02
      008945 6B 11            [ 1] 1387 	ld	(0x11, sp), a
      008947 A6 81            [ 1] 1388 	ld	a, #0x81
      008949 6B 12            [ 1] 1389 	ld	(0x12, sp), a
      00894B A6 8F            [ 1] 1390 	ld	a, #0x8f
      00894D 6B 13            [ 1] 1391 	ld	(0x13, sp), a
      00894F A6 D9            [ 1] 1392 	ld	a, #0xd9
      008951 6B 14            [ 1] 1393 	ld	(0x14, sp), a
      008953 A6 F1            [ 1] 1394 	ld	a, #0xf1
      008955 6B 15            [ 1] 1395 	ld	(0x15, sp), a
      008957 A6 20            [ 1] 1396 	ld	a, #0x20
      008959 6B 16            [ 1] 1397 	ld	(0x16, sp), a
      00895B 0F 17            [ 1] 1398 	clr	(0x17, sp)
      00895D A6 A0            [ 1] 1399 	ld	a, #0xa0
      00895F 6B 18            [ 1] 1400 	ld	(0x18, sp), a
      008961 A6 C0            [ 1] 1401 	ld	a, #0xc0
      008963 6B 19            [ 1] 1402 	ld	(0x19, sp), a
      008965 A6 1F            [ 1] 1403 	ld	a, #0x1f
      008967 6B 1A            [ 1] 1404 	ld	(0x1a, sp), a
      008969 A6 AF            [ 1] 1405 	ld	a, #0xaf
      00896B 6B 1B            [ 1] 1406 	ld	(0x1b, sp), a
                                   1407 ;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
      00896D 89               [ 2] 1408 	pushw	x
      00896E 4B 1B            [ 1] 1409 	push	#0x1b
      008970 A6 3C            [ 1] 1410 	ld	a, #0x3c
      008972 CD 88 44         [ 4] 1411 	call	_i2c_write
                                   1412 ;	./libs/ssd1306_lib.c: 43: }
      008975 5B 1B            [ 2] 1413 	addw	sp, #27
      008977 81               [ 4] 1414 	ret
                                   1415 ;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
                                   1416 ;	-----------------------------------------
                                   1417 ;	 function ssd1306_set_params_to_write
                                   1418 ;	-----------------------------------------
      008978                       1419 _ssd1306_set_params_to_write:
      008978 52 07            [ 2] 1420 	sub	sp, #7
                                   1421 ;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
      00897A 96               [ 1] 1422 	ldw	x, sp
      00897B 5C               [ 1] 1423 	incw	x
      00897C 7F               [ 1] 1424 	clr	(x)
      00897D A6 22            [ 1] 1425 	ld	a, #0x22
      00897F 6B 02            [ 1] 1426 	ld	(0x02, sp), a
      008981 0F 03            [ 1] 1427 	clr	(0x03, sp)
      008983 A6 03            [ 1] 1428 	ld	a, #0x03
      008985 6B 04            [ 1] 1429 	ld	(0x04, sp), a
      008987 A6 21            [ 1] 1430 	ld	a, #0x21
      008989 6B 05            [ 1] 1431 	ld	(0x05, sp), a
      00898B 0F 06            [ 1] 1432 	clr	(0x06, sp)
      00898D A6 7F            [ 1] 1433 	ld	a, #0x7f
      00898F 6B 07            [ 1] 1434 	ld	(0x07, sp), a
                                   1435 ;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      008991 89               [ 2] 1436 	pushw	x
      008992 4B 07            [ 1] 1437 	push	#0x07
      008994 A6 3C            [ 1] 1438 	ld	a, #0x3c
      008996 CD 88 44         [ 4] 1439 	call	_i2c_write
                                   1440 ;	./libs/ssd1306_lib.c: 52: }
      008999 5B 07            [ 2] 1441 	addw	sp, #7
      00899B 81               [ 4] 1442 	ret
                                   1443 ;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1444 ;	-----------------------------------------
                                   1445 ;	 function ssd1306_draw_pixel
                                   1446 ;	-----------------------------------------
      00899C                       1447 _ssd1306_draw_pixel:
      00899C 52 08            [ 2] 1448 	sub	sp, #8
      00899E 1F 07            [ 2] 1449 	ldw	(0x07, sp), x
                                   1450 ;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      0089A0 6B 06            [ 1] 1451 	ld	(0x06, sp), a
      0089A2 0F 05            [ 1] 1452 	clr	(0x05, sp)
      0089A4 7B 0B            [ 1] 1453 	ld	a, (0x0b, sp)
      0089A6 0F 01            [ 1] 1454 	clr	(0x01, sp)
      0089A8 97               [ 1] 1455 	ld	xl, a
      0089A9 02               [ 1] 1456 	rlwa	x
      0089AA 4F               [ 1] 1457 	clr	a
      0089AB 01               [ 1] 1458 	rrwa	x
      0089AC 5D               [ 2] 1459 	tnzw	x
      0089AD 2A 03            [ 1] 1460 	jrpl	00103$
      0089AF 1C 00 07         [ 2] 1461 	addw	x, #0x0007
      0089B2                       1462 00103$:
      0089B2 57               [ 2] 1463 	sraw	x
      0089B3 57               [ 2] 1464 	sraw	x
      0089B4 57               [ 2] 1465 	sraw	x
      0089B5 58               [ 2] 1466 	sllw	x
      0089B6 58               [ 2] 1467 	sllw	x
      0089B7 58               [ 2] 1468 	sllw	x
      0089B8 58               [ 2] 1469 	sllw	x
      0089B9 58               [ 2] 1470 	sllw	x
      0089BA 58               [ 2] 1471 	sllw	x
      0089BB 58               [ 2] 1472 	sllw	x
      0089BC 72 FB 05         [ 2] 1473 	addw	x, (0x05, sp)
      0089BF 72 FB 07         [ 2] 1474 	addw	x, (0x07, sp)
      0089C2 1F 03            [ 2] 1475 	ldw	(0x03, sp), x
      0089C4 90 5F            [ 1] 1476 	clrw	y
      0089C6 61               [ 1] 1477 	exg	a, yl
      0089C7 7B 0C            [ 1] 1478 	ld	a, (0x0c, sp)
      0089C9 61               [ 1] 1479 	exg	a, yl
      0089CA A4 07            [ 1] 1480 	and	a, #0x07
      0089CC 6B 06            [ 1] 1481 	ld	(0x06, sp), a
      0089CE 0F 05            [ 1] 1482 	clr	(0x05, sp)
      0089D0 1E 03            [ 2] 1483 	ldw	x, (0x03, sp)
      0089D2 F6               [ 1] 1484 	ld	a, (x)
      0089D3 5F               [ 1] 1485 	clrw	x
      0089D4 90 89            [ 2] 1486 	pushw	y
      0089D6 16 07            [ 2] 1487 	ldw	y, (0x07, sp)
      0089D8 90 89            [ 2] 1488 	pushw	y
      0089DA 97               [ 1] 1489 	ld	xl, a
      0089DB CD 88 D1         [ 4] 1490 	call	_set_bit
      0089DE 9F               [ 1] 1491 	ld	a, xl
      0089DF 1E 03            [ 2] 1492 	ldw	x, (0x03, sp)
      0089E1 F7               [ 1] 1493 	ld	(x), a
                                   1494 ;	./libs/ssd1306_lib.c: 57: }
      0089E2 1E 09            [ 2] 1495 	ldw	x, (9, sp)
      0089E4 5B 0C            [ 2] 1496 	addw	sp, #12
      0089E6 FC               [ 2] 1497 	jp	(x)
                                   1498 ;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
                                   1499 ;	-----------------------------------------
                                   1500 ;	 function ssd1306_buffer_clean
                                   1501 ;	-----------------------------------------
      0089E7                       1502 _ssd1306_buffer_clean:
                                   1503 ;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
      0089E7 4B 00            [ 1] 1504 	push	#0x00
      0089E9 4B 02            [ 1] 1505 	push	#0x02
      0089EB 5F               [ 1] 1506 	clrw	x
      0089EC 89               [ 2] 1507 	pushw	x
      0089ED AE 01 5D         [ 2] 1508 	ldw	x, #(_main_buffer+0)
      0089F0 CD 92 13         [ 4] 1509 	call	_memset
                                   1510 ;	./libs/ssd1306_lib.c: 62: }
      0089F3 81               [ 4] 1511 	ret
                                   1512 ;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
                                   1513 ;	-----------------------------------------
                                   1514 ;	 function ssd1306_send_buffer
                                   1515 ;	-----------------------------------------
      0089F4                       1516 _ssd1306_send_buffer:
      0089F4 52 04            [ 2] 1517 	sub	sp, #4
                                   1518 ;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
      0089F6 CD 89 78         [ 4] 1519 	call	_ssd1306_set_params_to_write
                                   1520 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      0089F9 5F               [ 1] 1521 	clrw	x
      0089FA 1F 03            [ 2] 1522 	ldw	(0x03, sp), x
      0089FC                       1523 00112$:
      0089FC 1E 03            [ 2] 1524 	ldw	x, (0x03, sp)
      0089FE A3 00 04         [ 2] 1525 	cpw	x, #0x0004
      008A01 2E 43            [ 1] 1526 	jrsge	00114$
                                   1527 ;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
      008A03 4B 00            [ 1] 1528 	push	#0x00
      008A05 A6 3C            [ 1] 1529 	ld	a, #0x3c
      008A07 CD 87 AB         [ 4] 1530 	call	_i2c_send_address
      008A0A 4D               [ 1] 1531 	tnz	a
      008A0B 27 2F            [ 1] 1532 	jreq	00105$
                                   1533 ;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
      008A0D A6 40            [ 1] 1534 	ld	a, #0x40
      008A0F CD 88 32         [ 4] 1535 	call	_i2c_send_byte
                                   1536 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      008A12 1E 03            [ 2] 1537 	ldw	x, (0x03, sp)
      008A14 58               [ 2] 1538 	sllw	x
      008A15 58               [ 2] 1539 	sllw	x
      008A16 58               [ 2] 1540 	sllw	x
      008A17 58               [ 2] 1541 	sllw	x
      008A18 58               [ 2] 1542 	sllw	x
      008A19 58               [ 2] 1543 	sllw	x
      008A1A 58               [ 2] 1544 	sllw	x
      008A1B 1F 01            [ 2] 1545 	ldw	(0x01, sp), x
      008A1D 5F               [ 1] 1546 	clrw	x
      008A1E                       1547 00109$:
      008A1E A3 00 80         [ 2] 1548 	cpw	x, #0x0080
      008A21 2E 14            [ 1] 1549 	jrsge	00103$
                                   1550 ;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i+(128*j)]))//Проверка на АСК бит
      008A23 90 93            [ 1] 1551 	ldw	y, x
      008A25 72 F9 01         [ 2] 1552 	addw	y, (0x01, sp)
      008A28 90 D6 01 5D      [ 1] 1553 	ld	a, (_main_buffer+0, y)
      008A2C 89               [ 2] 1554 	pushw	x
      008A2D CD 88 32         [ 4] 1555 	call	_i2c_send_byte
      008A30 85               [ 2] 1556 	popw	x
      008A31 4D               [ 1] 1557 	tnz	a
      008A32 26 03            [ 1] 1558 	jrne	00103$
                                   1559 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      008A34 5C               [ 1] 1560 	incw	x
      008A35 20 E7            [ 2] 1561 	jra	00109$
      008A37                       1562 00103$:
                                   1563 ;	./libs/ssd1306_lib.c: 78: i2c_stop();
      008A37 CD 87 A6         [ 4] 1564 	call	_i2c_stop
      008A3A 20 03            [ 2] 1565 	jra	00113$
      008A3C                       1566 00105$:
                                   1567 ;	./libs/ssd1306_lib.c: 81: i2c_stop();
      008A3C CD 87 A6         [ 4] 1568 	call	_i2c_stop
      008A3F                       1569 00113$:
                                   1570 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008A3F 1E 03            [ 2] 1571 	ldw	x, (0x03, sp)
      008A41 5C               [ 1] 1572 	incw	x
      008A42 1F 03            [ 2] 1573 	ldw	(0x03, sp), x
      008A44 20 B6            [ 2] 1574 	jra	00112$
      008A46                       1575 00114$:
                                   1576 ;	./libs/ssd1306_lib.c: 83: }
      008A46 5B 04            [ 2] 1577 	addw	sp, #4
      008A48 81               [ 4] 1578 	ret
                                   1579 ;	./libs/ssd1306_lib.c: 85: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
                                   1580 ;	-----------------------------------------
                                   1581 ;	 function ssd1306_buffer_write
                                   1582 ;	-----------------------------------------
      008A49                       1583 _ssd1306_buffer_write:
      008A49 52 0D            [ 2] 1584 	sub	sp, #13
      008A4B 1F 08            [ 2] 1585 	ldw	(0x08, sp), x
                                   1586 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      008A4D 5F               [ 1] 1587 	clrw	x
      008A4E 1F 0A            [ 2] 1588 	ldw	(0x0a, sp), x
      008A50                       1589 00109$:
      008A50 1E 0A            [ 2] 1590 	ldw	x, (0x0a, sp)
      008A52 A3 00 08         [ 2] 1591 	cpw	x, #0x0008
      008A55 2F 03            [ 1] 1592 	jrslt	00150$
      008A57 CC 8A D9         [ 2] 1593 	jp	00111$
      008A5A                       1594 00150$:
                                   1595 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      008A5A 1E 12            [ 2] 1596 	ldw	x, (0x12, sp)
      008A5C 72 FB 0A         [ 2] 1597 	addw	x, (0x0a, sp)
      008A5F 1F 05            [ 2] 1598 	ldw	(0x05, sp), x
      008A61 5F               [ 1] 1599 	clrw	x
      008A62 1F 0C            [ 2] 1600 	ldw	(0x0c, sp), x
      008A64                       1601 00106$:
      008A64 1E 0C            [ 2] 1602 	ldw	x, (0x0c, sp)
      008A66 A3 00 08         [ 2] 1603 	cpw	x, #0x0008
      008A69 2E 66            [ 1] 1604 	jrsge	00110$
                                   1605 ;	./libs/ssd1306_lib.c: 90: if(data[height + width / 8] & (128 >> (width & 7)))
      008A6B 1E 0A            [ 2] 1606 	ldw	x, (0x0a, sp)
      008A6D 72 FB 12         [ 2] 1607 	addw	x, (0x12, sp)
      008A70 F6               [ 1] 1608 	ld	a, (x)
      008A71 6B 07            [ 1] 1609 	ld	(0x07, sp), a
      008A73 7B 0D            [ 1] 1610 	ld	a, (0x0d, sp)
      008A75 A4 07            [ 1] 1611 	and	a, #0x07
      008A77 AE 00 80         [ 2] 1612 	ldw	x, #0x0080
      008A7A 4D               [ 1] 1613 	tnz	a
      008A7B 27 04            [ 1] 1614 	jreq	00153$
      008A7D                       1615 00152$:
      008A7D 57               [ 2] 1616 	sraw	x
      008A7E 4A               [ 1] 1617 	dec	a
      008A7F 26 FC            [ 1] 1618 	jrne	00152$
      008A81                       1619 00153$:
      008A81 1F 01            [ 2] 1620 	ldw	(0x01, sp), x
      008A83 7B 07            [ 1] 1621 	ld	a, (0x07, sp)
      008A85 14 02            [ 1] 1622 	and	a, (0x02, sp)
      008A87 6B 04            [ 1] 1623 	ld	(0x04, sp), a
      008A89 0F 03            [ 1] 1624 	clr	(0x03, sp)
      008A8B 1E 03            [ 2] 1625 	ldw	x, (0x03, sp)
      008A8D 27 3B            [ 1] 1626 	jreq	00107$
                                   1627 ;	./libs/ssd1306_lib.c: 91: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(data[height], 7 - (width % 8)));
      008A8F 4B 08            [ 1] 1628 	push	#0x08
      008A91 4B 00            [ 1] 1629 	push	#0x00
      008A93 1E 0E            [ 2] 1630 	ldw	x, (0x0e, sp)
      008A95 CD 92 37         [ 4] 1631 	call	__modsint
      008A98 1F 03            [ 2] 1632 	ldw	(0x03, sp), x
      008A9A 90 AE 00 07      [ 2] 1633 	ldw	y, #0x0007
      008A9E 72 F2 03         [ 2] 1634 	subw	y, (0x03, sp)
      008AA1 1E 05            [ 2] 1635 	ldw	x, (0x05, sp)
      008AA3 F6               [ 1] 1636 	ld	a, (x)
      008AA4 5F               [ 1] 1637 	clrw	x
      008AA5 90 89            [ 2] 1638 	pushw	y
      008AA7 97               [ 1] 1639 	ld	xl, a
      008AA8 CD 88 BC         [ 4] 1640 	call	_get_bit
      008AAB 7B 11            [ 1] 1641 	ld	a, (0x11, sp)
      008AAD 6B 07            [ 1] 1642 	ld	(0x07, sp), a
      008AAF 7B 0B            [ 1] 1643 	ld	a, (0x0b, sp)
      008AB1 1B 07            [ 1] 1644 	add	a, (0x07, sp)
      008AB3 95               [ 1] 1645 	ld	xh, a
      008AB4 7B 09            [ 1] 1646 	ld	a, (0x09, sp)
      008AB6 6B 07            [ 1] 1647 	ld	(0x07, sp), a
      008AB8 7B 0D            [ 1] 1648 	ld	a, (0x0d, sp)
      008ABA 1B 07            [ 1] 1649 	add	a, (0x07, sp)
      008ABC 6B 07            [ 1] 1650 	ld	(0x07, sp), a
      008ABE 9F               [ 1] 1651 	ld	a, xl
      008ABF 88               [ 1] 1652 	push	a
      008AC0 9E               [ 1] 1653 	ld	a, xh
      008AC1 88               [ 1] 1654 	push	a
      008AC2 7B 09            [ 1] 1655 	ld	a, (0x09, sp)
      008AC4 AE 01 5D         [ 2] 1656 	ldw	x, #(_main_buffer+0)
      008AC7 CD 89 9C         [ 4] 1657 	call	_ssd1306_draw_pixel
      008ACA                       1658 00107$:
                                   1659 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      008ACA 1E 0C            [ 2] 1660 	ldw	x, (0x0c, sp)
      008ACC 5C               [ 1] 1661 	incw	x
      008ACD 1F 0C            [ 2] 1662 	ldw	(0x0c, sp), x
      008ACF 20 93            [ 2] 1663 	jra	00106$
      008AD1                       1664 00110$:
                                   1665 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      008AD1 1E 0A            [ 2] 1666 	ldw	x, (0x0a, sp)
      008AD3 5C               [ 1] 1667 	incw	x
      008AD4 1F 0A            [ 2] 1668 	ldw	(0x0a, sp), x
      008AD6 CC 8A 50         [ 2] 1669 	jp	00109$
      008AD9                       1670 00111$:
                                   1671 ;	./libs/ssd1306_lib.c: 93: }
      008AD9 1E 0E            [ 2] 1672 	ldw	x, (14, sp)
      008ADB 5B 13            [ 2] 1673 	addw	sp, #19
      008ADD FC               [ 2] 1674 	jp	(x)
                                   1675 ;	./libs/ssd1306_lib.c: 95: void ssd1306_clean(void)
                                   1676 ;	-----------------------------------------
                                   1677 ;	 function ssd1306_clean
                                   1678 ;	-----------------------------------------
      008ADE                       1679 _ssd1306_clean:
                                   1680 ;	./libs/ssd1306_lib.c: 97: ssd1306_buffer_clean();
      008ADE CD 89 E7         [ 4] 1681 	call	_ssd1306_buffer_clean
                                   1682 ;	./libs/ssd1306_lib.c: 98: ssd1306_send_buffer();
                                   1683 ;	./libs/ssd1306_lib.c: 99: }
      008AE1 CC 89 F4         [ 2] 1684 	jp	_ssd1306_send_buffer
                                   1685 ;	./libs/menu_lib.c: 3: void menu_border(void)
                                   1686 ;	-----------------------------------------
                                   1687 ;	 function menu_border
                                   1688 ;	-----------------------------------------
      008AE4                       1689 _menu_border:
      008AE4 52 04            [ 2] 1690 	sub	sp, #4
                                   1691 ;	./libs/menu_lib.c: 6: ssd1306_buffer_write(0,0,ttf_corner_left_up);
      008AE6 4B 1D            [ 1] 1692 	push	#<(_ttf_corner_left_up+0)
      008AE8 4B 01            [ 1] 1693 	push	#((_ttf_corner_left_up+0) >> 8)
      008AEA 5F               [ 1] 1694 	clrw	x
      008AEB 89               [ 2] 1695 	pushw	x
      008AEC 5F               [ 1] 1696 	clrw	x
      008AED CD 8A 49         [ 4] 1697 	call	_ssd1306_buffer_write
                                   1698 ;	./libs/menu_lib.c: 7: for(int x = 1;x<15;x++)
      008AF0 5F               [ 1] 1699 	clrw	x
      008AF1 5C               [ 1] 1700 	incw	x
      008AF2 1F 03            [ 2] 1701 	ldw	(0x03, sp), x
      008AF4                       1702 00104$:
      008AF4 1E 03            [ 2] 1703 	ldw	x, (0x03, sp)
      008AF6 A3 00 0F         [ 2] 1704 	cpw	x, #0x000f
      008AF9 2E 19            [ 1] 1705 	jrsge	00101$
                                   1706 ;	./libs/menu_lib.c: 8: ssd1306_buffer_write(x*8,0,ttf_line_up);
      008AFB 1E 03            [ 2] 1707 	ldw	x, (0x03, sp)
      008AFD 58               [ 2] 1708 	sllw	x
      008AFE 58               [ 2] 1709 	sllw	x
      008AFF 58               [ 2] 1710 	sllw	x
      008B00 1F 01            [ 2] 1711 	ldw	(0x01, sp), x
      008B02 4B 4D            [ 1] 1712 	push	#<(_ttf_line_up+0)
      008B04 4B 01            [ 1] 1713 	push	#((_ttf_line_up+0) >> 8)
      008B06 5F               [ 1] 1714 	clrw	x
      008B07 89               [ 2] 1715 	pushw	x
      008B08 1E 05            [ 2] 1716 	ldw	x, (0x05, sp)
      008B0A CD 8A 49         [ 4] 1717 	call	_ssd1306_buffer_write
                                   1718 ;	./libs/menu_lib.c: 7: for(int x = 1;x<15;x++)
      008B0D 1E 03            [ 2] 1719 	ldw	x, (0x03, sp)
      008B0F 5C               [ 1] 1720 	incw	x
      008B10 1F 03            [ 2] 1721 	ldw	(0x03, sp), x
      008B12 20 E0            [ 2] 1722 	jra	00104$
      008B14                       1723 00101$:
                                   1724 ;	./libs/menu_lib.c: 9: ssd1306_buffer_write(120,0,ttf_corner_right_up);
      008B14 4B 25            [ 1] 1725 	push	#<(_ttf_corner_right_up+0)
      008B16 4B 01            [ 1] 1726 	push	#((_ttf_corner_right_up+0) >> 8)
      008B18 5F               [ 1] 1727 	clrw	x
      008B19 89               [ 2] 1728 	pushw	x
      008B1A AE 00 78         [ 2] 1729 	ldw	x, #0x0078
      008B1D CD 8A 49         [ 4] 1730 	call	_ssd1306_buffer_write
                                   1731 ;	./libs/menu_lib.c: 11: ssd1306_buffer_write(0,8,ttf_line_left);
      008B20 4B 45            [ 1] 1732 	push	#<(_ttf_line_left+0)
      008B22 4B 01            [ 1] 1733 	push	#((_ttf_line_left+0) >> 8)
      008B24 4B 08            [ 1] 1734 	push	#0x08
      008B26 4B 00            [ 1] 1735 	push	#0x00
      008B28 5F               [ 1] 1736 	clrw	x
      008B29 CD 8A 49         [ 4] 1737 	call	_ssd1306_buffer_write
                                   1738 ;	./libs/menu_lib.c: 12: ssd1306_buffer_write(0,16,ttf_line_left);
      008B2C 4B 45            [ 1] 1739 	push	#<(_ttf_line_left+0)
      008B2E 4B 01            [ 1] 1740 	push	#((_ttf_line_left+0) >> 8)
      008B30 4B 10            [ 1] 1741 	push	#0x10
      008B32 4B 00            [ 1] 1742 	push	#0x00
      008B34 5F               [ 1] 1743 	clrw	x
      008B35 CD 8A 49         [ 4] 1744 	call	_ssd1306_buffer_write
                                   1745 ;	./libs/menu_lib.c: 14: ssd1306_buffer_write(120,8,ttf_line_right);
      008B38 4B 3D            [ 1] 1746 	push	#<(_ttf_line_right+0)
      008B3A 4B 01            [ 1] 1747 	push	#((_ttf_line_right+0) >> 8)
      008B3C 4B 08            [ 1] 1748 	push	#0x08
      008B3E 4B 00            [ 1] 1749 	push	#0x00
      008B40 AE 00 78         [ 2] 1750 	ldw	x, #0x0078
      008B43 CD 8A 49         [ 4] 1751 	call	_ssd1306_buffer_write
                                   1752 ;	./libs/menu_lib.c: 15: ssd1306_buffer_write(120,16,ttf_line_right);
      008B46 4B 3D            [ 1] 1753 	push	#<(_ttf_line_right+0)
      008B48 4B 01            [ 1] 1754 	push	#((_ttf_line_right+0) >> 8)
      008B4A 4B 10            [ 1] 1755 	push	#0x10
      008B4C 4B 00            [ 1] 1756 	push	#0x00
      008B4E AE 00 78         [ 2] 1757 	ldw	x, #0x0078
      008B51 CD 8A 49         [ 4] 1758 	call	_ssd1306_buffer_write
                                   1759 ;	./libs/menu_lib.c: 17: ssd1306_buffer_write(0,24,ttf_corner_left_down);
      008B54 4B 2D            [ 1] 1760 	push	#<(_ttf_corner_left_down+0)
      008B56 4B 01            [ 1] 1761 	push	#((_ttf_corner_left_down+0) >> 8)
      008B58 4B 18            [ 1] 1762 	push	#0x18
      008B5A 4B 00            [ 1] 1763 	push	#0x00
      008B5C 5F               [ 1] 1764 	clrw	x
      008B5D CD 8A 49         [ 4] 1765 	call	_ssd1306_buffer_write
                                   1766 ;	./libs/menu_lib.c: 18: for(int x = 1;x<15;x++)
      008B60 5F               [ 1] 1767 	clrw	x
      008B61 5C               [ 1] 1768 	incw	x
      008B62                       1769 00107$:
      008B62 A3 00 0F         [ 2] 1770 	cpw	x, #0x000f
      008B65 2E 19            [ 1] 1771 	jrsge	00102$
                                   1772 ;	./libs/menu_lib.c: 19: ssd1306_buffer_write(x*8,24,ttf_line_down);
      008B67 90 93            [ 1] 1773 	ldw	y, x
      008B69 90 58            [ 2] 1774 	sllw	y
      008B6B 90 58            [ 2] 1775 	sllw	y
      008B6D 90 58            [ 2] 1776 	sllw	y
      008B6F 89               [ 2] 1777 	pushw	x
      008B70 4B 55            [ 1] 1778 	push	#<(_ttf_line_down+0)
      008B72 4B 01            [ 1] 1779 	push	#((_ttf_line_down+0) >> 8)
      008B74 4B 18            [ 1] 1780 	push	#0x18
      008B76 4B 00            [ 1] 1781 	push	#0x00
      008B78 93               [ 1] 1782 	ldw	x, y
      008B79 CD 8A 49         [ 4] 1783 	call	_ssd1306_buffer_write
      008B7C 85               [ 2] 1784 	popw	x
                                   1785 ;	./libs/menu_lib.c: 18: for(int x = 1;x<15;x++)
      008B7D 5C               [ 1] 1786 	incw	x
      008B7E 20 E2            [ 2] 1787 	jra	00107$
      008B80                       1788 00102$:
                                   1789 ;	./libs/menu_lib.c: 20: ssd1306_buffer_write(120,24,ttf_corner_right_down);
      008B80 4B 35            [ 1] 1790 	push	#<(_ttf_corner_right_down+0)
      008B82 4B 01            [ 1] 1791 	push	#((_ttf_corner_right_down+0) >> 8)
      008B84 4B 18            [ 1] 1792 	push	#0x18
      008B86 4B 00            [ 1] 1793 	push	#0x00
      008B88 AE 00 78         [ 2] 1794 	ldw	x, #0x0078
      008B8B CD 8A 49         [ 4] 1795 	call	_ssd1306_buffer_write
                                   1796 ;	./libs/menu_lib.c: 21: }
      008B8E 5B 04            [ 2] 1797 	addw	sp, #4
      008B90 81               [ 4] 1798 	ret
                                   1799 ;	./libs/menu_lib.c: 23: void menu_border_paragraph(uint8_t number_of_letters)
                                   1800 ;	-----------------------------------------
                                   1801 ;	 function menu_border_paragraph
                                   1802 ;	-----------------------------------------
      008B91                       1803 _menu_border_paragraph:
      008B91 52 07            [ 2] 1804 	sub	sp, #7
      008B93 6B 07            [ 1] 1805 	ld	(0x07, sp), a
                                   1806 ;	./libs/menu_lib.c: 26: ssd1306_buffer_write(6,8,ttf_corner_left_up);
      008B95 4B 1D            [ 1] 1807 	push	#<(_ttf_corner_left_up+0)
      008B97 4B 01            [ 1] 1808 	push	#((_ttf_corner_left_up+0) >> 8)
      008B99 4B 08            [ 1] 1809 	push	#0x08
      008B9B 4B 00            [ 1] 1810 	push	#0x00
      008B9D AE 00 06         [ 2] 1811 	ldw	x, #0x0006
      008BA0 CD 8A 49         [ 4] 1812 	call	_ssd1306_buffer_write
                                   1813 ;	./libs/menu_lib.c: 27: ssd1306_buffer_write(6,16,ttf_corner_left_down);
      008BA3 4B 2D            [ 1] 1814 	push	#<(_ttf_corner_left_down+0)
      008BA5 4B 01            [ 1] 1815 	push	#((_ttf_corner_left_down+0) >> 8)
      008BA7 4B 10            [ 1] 1816 	push	#0x10
      008BA9 4B 00            [ 1] 1817 	push	#0x00
      008BAB AE 00 06         [ 2] 1818 	ldw	x, #0x0006
      008BAE CD 8A 49         [ 4] 1819 	call	_ssd1306_buffer_write
                                   1820 ;	./libs/menu_lib.c: 28: for(int x = 1;x<number_of_letters+1;x++)
      008BB1 5F               [ 1] 1821 	clrw	x
      008BB2 5C               [ 1] 1822 	incw	x
      008BB3 1F 05            [ 2] 1823 	ldw	(0x05, sp), x
      008BB5                       1824 00104$:
      008BB5 90 5F            [ 1] 1825 	clrw	y
      008BB7 7B 07            [ 1] 1826 	ld	a, (0x07, sp)
      008BB9 90 97            [ 1] 1827 	ld	yl, a
      008BBB 93               [ 1] 1828 	ldw	x, y
      008BBC 5C               [ 1] 1829 	incw	x
      008BBD 1F 01            [ 2] 1830 	ldw	(0x01, sp), x
      008BBF 1E 05            [ 2] 1831 	ldw	x, (0x05, sp)
      008BC1 13 01            [ 2] 1832 	cpw	x, (0x01, sp)
      008BC3 2E 20            [ 1] 1833 	jrsge	00101$
                                   1834 ;	./libs/menu_lib.c: 29: ssd1306_buffer_write(6+x*8,8,ttf_line_up);
      008BC5 1E 05            [ 2] 1835 	ldw	x, (0x05, sp)
      008BC7 58               [ 2] 1836 	sllw	x
      008BC8 58               [ 2] 1837 	sllw	x
      008BC9 58               [ 2] 1838 	sllw	x
      008BCA 1F 01            [ 2] 1839 	ldw	(0x01, sp), x
      008BCC 1C 00 06         [ 2] 1840 	addw	x, #0x0006
      008BCF 1F 03            [ 2] 1841 	ldw	(0x03, sp), x
      008BD1 4B 4D            [ 1] 1842 	push	#<(_ttf_line_up+0)
      008BD3 4B 01            [ 1] 1843 	push	#((_ttf_line_up+0) >> 8)
      008BD5 4B 08            [ 1] 1844 	push	#0x08
      008BD7 4B 00            [ 1] 1845 	push	#0x00
      008BD9 1E 07            [ 2] 1846 	ldw	x, (0x07, sp)
      008BDB CD 8A 49         [ 4] 1847 	call	_ssd1306_buffer_write
                                   1848 ;	./libs/menu_lib.c: 28: for(int x = 1;x<number_of_letters+1;x++)
      008BDE 1E 05            [ 2] 1849 	ldw	x, (0x05, sp)
      008BE0 5C               [ 1] 1850 	incw	x
      008BE1 1F 05            [ 2] 1851 	ldw	(0x05, sp), x
      008BE3 20 D0            [ 2] 1852 	jra	00104$
      008BE5                       1853 00101$:
                                   1854 ;	./libs/menu_lib.c: 30: ssd1306_buffer_write(6+number_of_letters*8,8,ttf_corner_right_up);
      008BE5 93               [ 1] 1855 	ldw	x, y
      008BE6 58               [ 2] 1856 	sllw	x
      008BE7 58               [ 2] 1857 	sllw	x
      008BE8 58               [ 2] 1858 	sllw	x
      008BE9 9F               [ 1] 1859 	ld	a, xl
      008BEA AB 06            [ 1] 1860 	add	a, #0x06
      008BEC 6B 04            [ 1] 1861 	ld	(0x04, sp), a
      008BEE 9E               [ 1] 1862 	ld	a, xh
      008BEF A9 00            [ 1] 1863 	adc	a, #0x00
      008BF1 6B 03            [ 1] 1864 	ld	(0x03, sp), a
      008BF3 89               [ 2] 1865 	pushw	x
      008BF4 4B 25            [ 1] 1866 	push	#<(_ttf_corner_right_up+0)
      008BF6 4B 01            [ 1] 1867 	push	#((_ttf_corner_right_up+0) >> 8)
      008BF8 4B 08            [ 1] 1868 	push	#0x08
      008BFA 4B 00            [ 1] 1869 	push	#0x00
      008BFC 1E 09            [ 2] 1870 	ldw	x, (0x09, sp)
      008BFE CD 8A 49         [ 4] 1871 	call	_ssd1306_buffer_write
      008C01 85               [ 2] 1872 	popw	x
                                   1873 ;	./libs/menu_lib.c: 31: ssd1306_buffer_write(12+number_of_letters*8,0,ttf_line_left);
      008C02 1C 00 0C         [ 2] 1874 	addw	x, #0x000c
      008C05 1F 05            [ 2] 1875 	ldw	(0x05, sp), x
      008C07 4B 45            [ 1] 1876 	push	#<(_ttf_line_left+0)
      008C09 4B 01            [ 1] 1877 	push	#((_ttf_line_left+0) >> 8)
      008C0B 5F               [ 1] 1878 	clrw	x
      008C0C 89               [ 2] 1879 	pushw	x
      008C0D 1E 09            [ 2] 1880 	ldw	x, (0x09, sp)
      008C0F CD 8A 49         [ 4] 1881 	call	_ssd1306_buffer_write
                                   1882 ;	./libs/menu_lib.c: 34: ssd1306_buffer_write(6,16,ttf_corner_left_down);
      008C12 4B 2D            [ 1] 1883 	push	#<(_ttf_corner_left_down+0)
      008C14 4B 01            [ 1] 1884 	push	#((_ttf_corner_left_down+0) >> 8)
      008C16 4B 10            [ 1] 1885 	push	#0x10
      008C18 4B 00            [ 1] 1886 	push	#0x00
      008C1A AE 00 06         [ 2] 1887 	ldw	x, #0x0006
      008C1D CD 8A 49         [ 4] 1888 	call	_ssd1306_buffer_write
                                   1889 ;	./libs/menu_lib.c: 35: for(int x = 1;x<number_of_letters+1;x++)
      008C20 5F               [ 1] 1890 	clrw	x
      008C21 5C               [ 1] 1891 	incw	x
      008C22                       1892 00107$:
      008C22 13 01            [ 2] 1893 	cpw	x, (0x01, sp)
      008C24 2E 1D            [ 1] 1894 	jrsge	00102$
                                   1895 ;	./libs/menu_lib.c: 36: ssd1306_buffer_write(6+x*8,16,ttf_line_down);
      008C26 90 93            [ 1] 1896 	ldw	y, x
      008C28 90 58            [ 2] 1897 	sllw	y
      008C2A 90 58            [ 2] 1898 	sllw	y
      008C2C 90 58            [ 2] 1899 	sllw	y
      008C2E 72 A9 00 06      [ 2] 1900 	addw	y, #0x0006
      008C32 89               [ 2] 1901 	pushw	x
      008C33 4B 55            [ 1] 1902 	push	#<(_ttf_line_down+0)
      008C35 4B 01            [ 1] 1903 	push	#((_ttf_line_down+0) >> 8)
      008C37 4B 10            [ 1] 1904 	push	#0x10
      008C39 4B 00            [ 1] 1905 	push	#0x00
      008C3B 93               [ 1] 1906 	ldw	x, y
      008C3C CD 8A 49         [ 4] 1907 	call	_ssd1306_buffer_write
      008C3F 85               [ 2] 1908 	popw	x
                                   1909 ;	./libs/menu_lib.c: 35: for(int x = 1;x<number_of_letters+1;x++)
      008C40 5C               [ 1] 1910 	incw	x
      008C41 20 DF            [ 2] 1911 	jra	00107$
      008C43                       1912 00102$:
                                   1913 ;	./libs/menu_lib.c: 37: ssd1306_buffer_write(6+number_of_letters*8,16,ttf_corner_right_down);
      008C43 4B 35            [ 1] 1914 	push	#<(_ttf_corner_right_down+0)
      008C45 4B 01            [ 1] 1915 	push	#((_ttf_corner_right_down+0) >> 8)
      008C47 4B 10            [ 1] 1916 	push	#0x10
      008C49 4B 00            [ 1] 1917 	push	#0x00
      008C4B 1E 07            [ 2] 1918 	ldw	x, (0x07, sp)
      008C4D CD 8A 49         [ 4] 1919 	call	_ssd1306_buffer_write
                                   1920 ;	./libs/menu_lib.c: 38: ssd1306_buffer_write(12+number_of_letters*8,24,ttf_line_left);
      008C50 4B 45            [ 1] 1921 	push	#<(_ttf_line_left+0)
      008C52 4B 01            [ 1] 1922 	push	#((_ttf_line_left+0) >> 8)
      008C54 4B 18            [ 1] 1923 	push	#0x18
      008C56 4B 00            [ 1] 1924 	push	#0x00
      008C58 1E 09            [ 2] 1925 	ldw	x, (0x09, sp)
      008C5A CD 8A 49         [ 4] 1926 	call	_ssd1306_buffer_write
                                   1927 ;	./libs/menu_lib.c: 40: }
      008C5D 5B 07            [ 2] 1928 	addw	sp, #7
      008C5F 81               [ 4] 1929 	ret
                                   1930 ;	./libs/menu_lib.c: 42: void menu_border_item(uint8_t number_of_letters)
                                   1931 ;	-----------------------------------------
                                   1932 ;	 function menu_border_item
                                   1933 ;	-----------------------------------------
      008C60                       1934 _menu_border_item:
      008C60 52 06            [ 2] 1935 	sub	sp, #6
                                   1936 ;	./libs/menu_lib.c: 45: ssd1306_buffer_write(12+number_of_letters*8,7,ttf_corner_left_down);
      008C62 6B 02            [ 1] 1937 	ld	(0x02, sp), a
      008C64 0F 01            [ 1] 1938 	clr	(0x01, sp)
      008C66 1E 01            [ 2] 1939 	ldw	x, (0x01, sp)
      008C68 58               [ 2] 1940 	sllw	x
      008C69 58               [ 2] 1941 	sllw	x
      008C6A 58               [ 2] 1942 	sllw	x
      008C6B 1C 00 0C         [ 2] 1943 	addw	x, #0x000c
      008C6E 1F 03            [ 2] 1944 	ldw	(0x03, sp), x
      008C70 4B 2D            [ 1] 1945 	push	#<(_ttf_corner_left_down+0)
      008C72 4B 01            [ 1] 1946 	push	#((_ttf_corner_left_down+0) >> 8)
      008C74 4B 07            [ 1] 1947 	push	#0x07
      008C76 4B 00            [ 1] 1948 	push	#0x00
      008C78 1E 07            [ 2] 1949 	ldw	x, (0x07, sp)
      008C7A CD 8A 49         [ 4] 1950 	call	_ssd1306_buffer_write
                                   1951 ;	./libs/menu_lib.c: 46: for(int x = 1;x<14-number_of_letters;x++)
      008C7D A6 0E            [ 1] 1952 	ld	a, #0x0e
      008C7F 10 02            [ 1] 1953 	sub	a, (0x02, sp)
      008C81 6B 06            [ 1] 1954 	ld	(0x06, sp), a
      008C83 4F               [ 1] 1955 	clr	a
      008C84 12 01            [ 1] 1956 	sbc	a, (0x01, sp)
      008C86 6B 05            [ 1] 1957 	ld	(0x05, sp), a
      008C88 5F               [ 1] 1958 	clrw	x
      008C89 5C               [ 1] 1959 	incw	x
      008C8A                       1960 00103$:
      008C8A 13 05            [ 2] 1961 	cpw	x, (0x05, sp)
      008C8C 2E 1C            [ 1] 1962 	jrsge	00101$
                                   1963 ;	./libs/menu_lib.c: 47: ssd1306_buffer_write(12+number_of_letters*8+x*8,7,ttf_line_down);
      008C8E 90 93            [ 1] 1964 	ldw	y, x
      008C90 90 58            [ 2] 1965 	sllw	y
      008C92 90 58            [ 2] 1966 	sllw	y
      008C94 90 58            [ 2] 1967 	sllw	y
      008C96 72 F9 03         [ 2] 1968 	addw	y, (0x03, sp)
      008C99 89               [ 2] 1969 	pushw	x
      008C9A 4B 55            [ 1] 1970 	push	#<(_ttf_line_down+0)
      008C9C 4B 01            [ 1] 1971 	push	#((_ttf_line_down+0) >> 8)
      008C9E 4B 07            [ 1] 1972 	push	#0x07
      008CA0 4B 00            [ 1] 1973 	push	#0x00
      008CA2 93               [ 1] 1974 	ldw	x, y
      008CA3 CD 8A 49         [ 4] 1975 	call	_ssd1306_buffer_write
      008CA6 85               [ 2] 1976 	popw	x
                                   1977 ;	./libs/menu_lib.c: 46: for(int x = 1;x<14-number_of_letters;x++)
      008CA7 5C               [ 1] 1978 	incw	x
      008CA8 20 E0            [ 2] 1979 	jra	00103$
      008CAA                       1980 00101$:
                                   1981 ;	./libs/menu_lib.c: 48: ssd1306_buffer_write(120,7,ttf_corner_right_down);
      008CAA 4B 35            [ 1] 1982 	push	#<(_ttf_corner_right_down+0)
      008CAC 4B 01            [ 1] 1983 	push	#((_ttf_corner_right_down+0) >> 8)
      008CAE 4B 07            [ 1] 1984 	push	#0x07
      008CB0 4B 00            [ 1] 1985 	push	#0x00
      008CB2 AE 00 78         [ 2] 1986 	ldw	x, #0x0078
      008CB5 CD 8A 49         [ 4] 1987 	call	_ssd1306_buffer_write
                                   1988 ;	./libs/menu_lib.c: 51: ssd1306_buffer_write(97,15,ttf_line_left);
      008CB8 4B 45            [ 1] 1989 	push	#<(_ttf_line_left+0)
      008CBA 4B 01            [ 1] 1990 	push	#((_ttf_line_left+0) >> 8)
      008CBC 4B 0F            [ 1] 1991 	push	#0x0f
      008CBE 4B 00            [ 1] 1992 	push	#0x00
      008CC0 AE 00 61         [ 2] 1993 	ldw	x, #0x0061
      008CC3 CD 8A 49         [ 4] 1994 	call	_ssd1306_buffer_write
                                   1995 ;	./libs/menu_lib.c: 52: ssd1306_buffer_write(97,17,ttf_corner_left_down);
      008CC6 4B 2D            [ 1] 1996 	push	#<(_ttf_corner_left_down+0)
      008CC8 4B 01            [ 1] 1997 	push	#((_ttf_corner_left_down+0) >> 8)
      008CCA 4B 11            [ 1] 1998 	push	#0x11
      008CCC 4B 00            [ 1] 1999 	push	#0x00
      008CCE AE 00 61         [ 2] 2000 	ldw	x, #0x0061
      008CD1 CD 8A 49         [ 4] 2001 	call	_ssd1306_buffer_write
                                   2002 ;	./libs/menu_lib.c: 53: ssd1306_buffer_write(104,17,ttf_line_down);
      008CD4 4B 55            [ 1] 2003 	push	#<(_ttf_line_down+0)
      008CD6 4B 01            [ 1] 2004 	push	#((_ttf_line_down+0) >> 8)
      008CD8 4B 11            [ 1] 2005 	push	#0x11
      008CDA 4B 00            [ 1] 2006 	push	#0x00
      008CDC AE 00 68         [ 2] 2007 	ldw	x, #0x0068
      008CDF CD 8A 49         [ 4] 2008 	call	_ssd1306_buffer_write
                                   2009 ;	./libs/menu_lib.c: 54: ssd1306_buffer_write(112,17,ttf_line_down);
      008CE2 4B 55            [ 1] 2010 	push	#<(_ttf_line_down+0)
      008CE4 4B 01            [ 1] 2011 	push	#((_ttf_line_down+0) >> 8)
      008CE6 4B 11            [ 1] 2012 	push	#0x11
      008CE8 4B 00            [ 1] 2013 	push	#0x00
      008CEA AE 00 70         [ 2] 2014 	ldw	x, #0x0070
      008CED CD 8A 49         [ 4] 2015 	call	_ssd1306_buffer_write
                                   2016 ;	./libs/menu_lib.c: 55: ssd1306_buffer_write(120,17,ttf_line_down);
      008CF0 4B 55            [ 1] 2017 	push	#<(_ttf_line_down+0)
      008CF2 4B 01            [ 1] 2018 	push	#((_ttf_line_down+0) >> 8)
      008CF4 4B 11            [ 1] 2019 	push	#0x11
      008CF6 4B 00            [ 1] 2020 	push	#0x00
      008CF8 AE 00 78         [ 2] 2021 	ldw	x, #0x0078
      008CFB CD 8A 49         [ 4] 2022 	call	_ssd1306_buffer_write
                                   2023 ;	./libs/menu_lib.c: 58: }
      008CFE 5B 06            [ 2] 2024 	addw	sp, #6
      008D00 81               [ 4] 2025 	ret
                                   2026 ;	./libs/menu_lib.c: 60: void menu_set_params_value(uint8_t number)
                                   2027 ;	-----------------------------------------
                                   2028 ;	 function menu_set_params_value
                                   2029 ;	-----------------------------------------
      008D01                       2030 _menu_set_params_value:
      008D01 52 05            [ 2] 2031 	sub	sp, #5
                                   2032 ;	./libs/menu_lib.c: 64: do {
      008D03 0F 05            [ 1] 2033 	clr	(0x05, sp)
      008D05                       2034 00101$:
                                   2035 ;	./libs/menu_lib.c: 65: ssd1306_buffer_write(117-8*index,15,numbers[number % 10]); // Получаем последнюю цифру
      008D05 6B 02            [ 1] 2036 	ld	(0x02, sp), a
      008D07 0F 01            [ 1] 2037 	clr	(0x01, sp)
      008D09 4B 0A            [ 1] 2038 	push	#0x0a
      008D0B 4B 00            [ 1] 2039 	push	#0x00
      008D0D 1E 03            [ 2] 2040 	ldw	x, (0x03, sp)
      008D0F CD 92 37         [ 4] 2041 	call	__modsint
      008D12 58               [ 2] 2042 	sllw	x
      008D13 DE 00 0F         [ 2] 2043 	ldw	x, (_menu_set_params_value_numbers_10000_186+0, x)
      008D16 90 93            [ 1] 2044 	ldw	y, x
      008D18 5F               [ 1] 2045 	clrw	x
      008D19 7B 05            [ 1] 2046 	ld	a, (0x05, sp)
      008D1B 97               [ 1] 2047 	ld	xl, a
      008D1C 58               [ 2] 2048 	sllw	x
      008D1D 58               [ 2] 2049 	sllw	x
      008D1E 58               [ 2] 2050 	sllw	x
      008D1F 1F 03            [ 2] 2051 	ldw	(0x03, sp), x
      008D21 AE 00 75         [ 2] 2052 	ldw	x, #0x0075
      008D24 72 F0 03         [ 2] 2053 	subw	x, (0x03, sp)
      008D27 90 89            [ 2] 2054 	pushw	y
      008D29 4B 0F            [ 1] 2055 	push	#0x0f
      008D2B 4B 00            [ 1] 2056 	push	#0x00
      008D2D CD 8A 49         [ 4] 2057 	call	_ssd1306_buffer_write
                                   2058 ;	./libs/menu_lib.c: 66: number /= 10; // Убираем последнюю цифру
      008D30 4B 0A            [ 1] 2059 	push	#0x0a
      008D32 4B 00            [ 1] 2060 	push	#0x00
      008D34 1E 03            [ 2] 2061 	ldw	x, (0x03, sp)
      008D36 CD 92 4F         [ 4] 2062 	call	__divsint
      008D39 9F               [ 1] 2063 	ld	a, xl
                                   2064 ;	./libs/menu_lib.c: 67: index++;
      008D3A 0C 05            [ 1] 2065 	inc	(0x05, sp)
                                   2066 ;	./libs/menu_lib.c: 68: } while (number > 0);
      008D3C 4D               [ 1] 2067 	tnz	a
      008D3D 26 C6            [ 1] 2068 	jrne	00101$
                                   2069 ;	./libs/menu_lib.c: 69: }
      008D3F 5B 05            [ 2] 2070 	addw	sp, #5
      008D41 81               [ 4] 2071 	ret
                                   2072 ;	./libs/menu_lib.c: 70: void menu_set_item_menu(uint8_t item)
                                   2073 ;	-----------------------------------------
                                   2074 ;	 function menu_set_item_menu
                                   2075 ;	-----------------------------------------
      008D42                       2076 _menu_set_item_menu:
                                   2077 ;	./libs/menu_lib.c: 73: switch(item)
      008D42 A1 07            [ 1] 2078 	cp	a, #0x07
      008D44 23 01            [ 2] 2079 	jrule	00118$
      008D46 81               [ 4] 2080 	ret
      008D47                       2081 00118$:
      008D47 5F               [ 1] 2082 	clrw	x
      008D48 97               [ 1] 2083 	ld	xl, a
      008D49 58               [ 2] 2084 	sllw	x
      008D4A DE 8D 4E         [ 2] 2085 	ldw	x, (#00119$, x)
      008D4D FC               [ 2] 2086 	jp	(x)
      008D4E                       2087 00119$:
      008D4E 8E BC                 2088 	.dw	#00109$
      008D50 8D 5E                 2089 	.dw	#00101$
      008D52 8D CB                 2090 	.dw	#00102$
      008D54 8E 38                 2091 	.dw	#00103$
      008D56 8E 89                 2092 	.dw	#00104$
      008D58 8E 97                 2093 	.dw	#00105$
      008D5A 8E A6                 2094 	.dw	#00106$
      008D5C 8E B1                 2095 	.dw	#00107$
                                   2096 ;	./libs/menu_lib.c: 75: case red:
      008D5E                       2097 00101$:
                                   2098 ;	./libs/menu_lib.c: 76: menu_border_item(color);
      008D5E A6 04            [ 1] 2099 	ld	a, #0x04
      008D60 CD 8C 60         [ 4] 2100 	call	_menu_border_item
                                   2101 ;	./libs/menu_lib.c: 78: ssd1306_buffer_write(15+color*8,4,ttf_rus_13);
      008D63 4B 83            [ 1] 2102 	push	#<(_ttf_rus_13+0)
      008D65 4B 00            [ 1] 2103 	push	#((_ttf_rus_13+0) >> 8)
      008D67 4B 04            [ 1] 2104 	push	#0x04
      008D69 4B 00            [ 1] 2105 	push	#0x00
      008D6B AE 00 2F         [ 2] 2106 	ldw	x, #0x002f
      008D6E CD 8A 49         [ 4] 2107 	call	_ssd1306_buffer_write
                                   2108 ;	./libs/menu_lib.c: 79: ssd1306_buffer_write(15+color*8+8,4,ttf_rus_14);
      008D71 4B 8B            [ 1] 2109 	push	#<(_ttf_rus_14+0)
      008D73 4B 00            [ 1] 2110 	push	#((_ttf_rus_14+0) >> 8)
      008D75 4B 04            [ 1] 2111 	push	#0x04
      008D77 4B 00            [ 1] 2112 	push	#0x00
      008D79 AE 00 37         [ 2] 2113 	ldw	x, #0x0037
      008D7C CD 8A 49         [ 4] 2114 	call	_ssd1306_buffer_write
                                   2115 ;	./libs/menu_lib.c: 80: ssd1306_buffer_write(15+color*8+16,4,ttf_rus_5);
      008D7F 4B 43            [ 1] 2116 	push	#<(_ttf_rus_5+0)
      008D81 4B 00            [ 1] 2117 	push	#((_ttf_rus_5+0) >> 8)
      008D83 4B 04            [ 1] 2118 	push	#0x04
      008D85 4B 00            [ 1] 2119 	push	#0x00
      008D87 AE 00 3F         [ 2] 2120 	ldw	x, #0x003f
      008D8A CD 8A 49         [ 4] 2121 	call	_ssd1306_buffer_write
                                   2122 ;	./libs/menu_lib.c: 81: ssd1306_buffer_write(15+color*8+24,4,ttf_rus_6);
      008D8D 4B 4B            [ 1] 2123 	push	#<(_ttf_rus_6+0)
      008D8F 4B 00            [ 1] 2124 	push	#((_ttf_rus_6+0) >> 8)
      008D91 4B 04            [ 1] 2125 	push	#0x04
      008D93 4B 00            [ 1] 2126 	push	#0x00
      008D95 AE 00 47         [ 2] 2127 	ldw	x, #0x0047
      008D98 CD 8A 49         [ 4] 2128 	call	_ssd1306_buffer_write
                                   2129 ;	./libs/menu_lib.c: 82: ssd1306_buffer_write(15+color*8+32,4,ttf_rus_9);
      008D9B 4B 63            [ 1] 2130 	push	#<(_ttf_rus_9+0)
      008D9D 4B 00            [ 1] 2131 	push	#((_ttf_rus_9+0) >> 8)
      008D9F 4B 04            [ 1] 2132 	push	#0x04
      008DA1 4B 00            [ 1] 2133 	push	#0x00
      008DA3 AE 00 4F         [ 2] 2134 	ldw	x, #0x004f
      008DA6 CD 8A 49         [ 4] 2135 	call	_ssd1306_buffer_write
                                   2136 ;	./libs/menu_lib.c: 83: ssd1306_buffer_write(15+color*8+40,4,ttf_rus_15);
      008DA9 4B 93            [ 1] 2137 	push	#<(_ttf_rus_15+0)
      008DAB 4B 00            [ 1] 2138 	push	#((_ttf_rus_15+0) >> 8)
      008DAD 4B 04            [ 1] 2139 	push	#0x04
      008DAF 4B 00            [ 1] 2140 	push	#0x00
      008DB1 AE 00 57         [ 2] 2141 	ldw	x, #0x0057
      008DB4 CD 8A 49         [ 4] 2142 	call	_ssd1306_buffer_write
                                   2143 ;	./libs/menu_lib.c: 84: ssd1306_buffer_write(15+color*8+48,4,ttf_rus_16);
      008DB7 4B 9B            [ 1] 2144 	push	#<(_ttf_rus_16+0)
      008DB9 4B 00            [ 1] 2145 	push	#((_ttf_rus_16+0) >> 8)
      008DBB 4B 04            [ 1] 2146 	push	#0x04
      008DBD 4B 00            [ 1] 2147 	push	#0x00
      008DBF AE 00 5F         [ 2] 2148 	ldw	x, #0x005f
      008DC2 CD 8A 49         [ 4] 2149 	call	_ssd1306_buffer_write
                                   2150 ;	./libs/menu_lib.c: 86: menu_set_params_value(params_value.current_red);
      008DC5 C6 00 09         [ 1] 2151 	ld	a, _params_value+2
                                   2152 ;	./libs/menu_lib.c: 88: break;
      008DC8 CC 8D 01         [ 2] 2153 	jp	_menu_set_params_value
                                   2154 ;	./libs/menu_lib.c: 89: case green:
      008DCB                       2155 00102$:
                                   2156 ;	./libs/menu_lib.c: 90: menu_border_item(color);
      008DCB A6 04            [ 1] 2157 	ld	a, #0x04
      008DCD CD 8C 60         [ 4] 2158 	call	_menu_border_item
                                   2159 ;	./libs/menu_lib.c: 92: ssd1306_buffer_write(15+color*8,4,ttf_rus_17);
      008DD0 4B A3            [ 1] 2160 	push	#<(_ttf_rus_17+0)
      008DD2 4B 00            [ 1] 2161 	push	#((_ttf_rus_17+0) >> 8)
      008DD4 4B 04            [ 1] 2162 	push	#0x04
      008DD6 4B 00            [ 1] 2163 	push	#0x00
      008DD8 AE 00 2F         [ 2] 2164 	ldw	x, #0x002f
      008DDB CD 8A 49         [ 4] 2165 	call	_ssd1306_buffer_write
                                   2166 ;	./libs/menu_lib.c: 93: ssd1306_buffer_write(15+color*8+8,4,ttf_rus_3);
      008DDE 4B 33            [ 1] 2167 	push	#<(_ttf_rus_3+0)
      008DE0 4B 00            [ 1] 2168 	push	#((_ttf_rus_3+0) >> 8)
      008DE2 4B 04            [ 1] 2169 	push	#0x04
      008DE4 4B 00            [ 1] 2170 	push	#0x00
      008DE6 AE 00 37         [ 2] 2171 	ldw	x, #0x0037
      008DE9 CD 8A 49         [ 4] 2172 	call	_ssd1306_buffer_write
                                   2173 ;	./libs/menu_lib.c: 94: ssd1306_buffer_write(15+color*8+16,4,ttf_rus_18);
      008DEC 4B AB            [ 1] 2174 	push	#<(_ttf_rus_18+0)
      008DEE 4B 00            [ 1] 2175 	push	#((_ttf_rus_18+0) >> 8)
      008DF0 4B 04            [ 1] 2176 	push	#0x04
      008DF2 4B 00            [ 1] 2177 	push	#0x00
      008DF4 AE 00 3F         [ 2] 2178 	ldw	x, #0x003f
      008DF7 CD 8A 49         [ 4] 2179 	call	_ssd1306_buffer_write
                                   2180 ;	./libs/menu_lib.c: 95: ssd1306_buffer_write(15+color*8+24,4,ttf_rus_3);
      008DFA 4B 33            [ 1] 2181 	push	#<(_ttf_rus_3+0)
      008DFC 4B 00            [ 1] 2182 	push	#((_ttf_rus_3+0) >> 8)
      008DFE 4B 04            [ 1] 2183 	push	#0x04
      008E00 4B 00            [ 1] 2184 	push	#0x00
      008E02 AE 00 47         [ 2] 2185 	ldw	x, #0x0047
      008E05 CD 8A 49         [ 4] 2186 	call	_ssd1306_buffer_write
                                   2187 ;	./libs/menu_lib.c: 96: ssd1306_buffer_write(15+color*8+32,4,ttf_rus_9);
      008E08 4B 63            [ 1] 2188 	push	#<(_ttf_rus_9+0)
      008E0A 4B 00            [ 1] 2189 	push	#((_ttf_rus_9+0) >> 8)
      008E0C 4B 04            [ 1] 2190 	push	#0x04
      008E0E 4B 00            [ 1] 2191 	push	#0x00
      008E10 AE 00 4F         [ 2] 2192 	ldw	x, #0x004f
      008E13 CD 8A 49         [ 4] 2193 	call	_ssd1306_buffer_write
                                   2194 ;	./libs/menu_lib.c: 97: ssd1306_buffer_write(15+color*8+40,4,ttf_rus_15);
      008E16 4B 93            [ 1] 2195 	push	#<(_ttf_rus_15+0)
      008E18 4B 00            [ 1] 2196 	push	#((_ttf_rus_15+0) >> 8)
      008E1A 4B 04            [ 1] 2197 	push	#0x04
      008E1C 4B 00            [ 1] 2198 	push	#0x00
      008E1E AE 00 57         [ 2] 2199 	ldw	x, #0x0057
      008E21 CD 8A 49         [ 4] 2200 	call	_ssd1306_buffer_write
                                   2201 ;	./libs/menu_lib.c: 98: ssd1306_buffer_write(15+color*8+48,4,ttf_rus_16);
      008E24 4B 9B            [ 1] 2202 	push	#<(_ttf_rus_16+0)
      008E26 4B 00            [ 1] 2203 	push	#((_ttf_rus_16+0) >> 8)
      008E28 4B 04            [ 1] 2204 	push	#0x04
      008E2A 4B 00            [ 1] 2205 	push	#0x00
      008E2C AE 00 5F         [ 2] 2206 	ldw	x, #0x005f
      008E2F CD 8A 49         [ 4] 2207 	call	_ssd1306_buffer_write
                                   2208 ;	./libs/menu_lib.c: 100: menu_set_params_value(params_value.current_green);
      008E32 C6 00 0A         [ 1] 2209 	ld	a, _params_value+3
                                   2210 ;	./libs/menu_lib.c: 103: break;
      008E35 CC 8D 01         [ 2] 2211 	jp	_menu_set_params_value
                                   2212 ;	./libs/menu_lib.c: 104: case blue:
      008E38                       2213 00103$:
                                   2214 ;	./libs/menu_lib.c: 105: menu_border_item(color);
      008E38 A6 04            [ 1] 2215 	ld	a, #0x04
      008E3A CD 8C 60         [ 4] 2216 	call	_menu_border_item
                                   2217 ;	./libs/menu_lib.c: 107: ssd1306_buffer_write(15+color*8,4,ttf_rus_6);
      008E3D 4B 4B            [ 1] 2218 	push	#<(_ttf_rus_6+0)
      008E3F 4B 00            [ 1] 2219 	push	#((_ttf_rus_6+0) >> 8)
      008E41 4B 04            [ 1] 2220 	push	#0x04
      008E43 4B 00            [ 1] 2221 	push	#0x00
      008E45 AE 00 2F         [ 2] 2222 	ldw	x, #0x002f
      008E48 CD 8A 49         [ 4] 2223 	call	_ssd1306_buffer_write
                                   2224 ;	./libs/menu_lib.c: 108: ssd1306_buffer_write(15+color*8+8,4,ttf_rus_12);
      008E4B 4B 7B            [ 1] 2225 	push	#<(_ttf_rus_12+0)
      008E4D 4B 00            [ 1] 2226 	push	#((_ttf_rus_12+0) >> 8)
      008E4F 4B 04            [ 1] 2227 	push	#0x04
      008E51 4B 00            [ 1] 2228 	push	#0x00
      008E53 AE 00 37         [ 2] 2229 	ldw	x, #0x0037
      008E56 CD 8A 49         [ 4] 2230 	call	_ssd1306_buffer_write
                                   2231 ;	./libs/menu_lib.c: 109: ssd1306_buffer_write(15+color*8+16,4,ttf_rus_9);
      008E59 4B 63            [ 1] 2232 	push	#<(_ttf_rus_9+0)
      008E5B 4B 00            [ 1] 2233 	push	#((_ttf_rus_9+0) >> 8)
      008E5D 4B 04            [ 1] 2234 	push	#0x04
      008E5F 4B 00            [ 1] 2235 	push	#0x00
      008E61 AE 00 3F         [ 2] 2236 	ldw	x, #0x003f
      008E64 CD 8A 49         [ 4] 2237 	call	_ssd1306_buffer_write
                                   2238 ;	./libs/menu_lib.c: 110: ssd1306_buffer_write(15+color*8+24,4,ttf_rus_12);
      008E67 4B 7B            [ 1] 2239 	push	#<(_ttf_rus_12+0)
      008E69 4B 00            [ 1] 2240 	push	#((_ttf_rus_12+0) >> 8)
      008E6B 4B 04            [ 1] 2241 	push	#0x04
      008E6D 4B 00            [ 1] 2242 	push	#0x00
      008E6F AE 00 47         [ 2] 2243 	ldw	x, #0x0047
      008E72 CD 8A 49         [ 4] 2244 	call	_ssd1306_buffer_write
                                   2245 ;	./libs/menu_lib.c: 111: ssd1306_buffer_write(15+color*8+32,4,ttf_rus_16);
      008E75 4B 9B            [ 1] 2246 	push	#<(_ttf_rus_16+0)
      008E77 4B 00            [ 1] 2247 	push	#((_ttf_rus_16+0) >> 8)
      008E79 4B 04            [ 1] 2248 	push	#0x04
      008E7B 4B 00            [ 1] 2249 	push	#0x00
      008E7D AE 00 4F         [ 2] 2250 	ldw	x, #0x004f
      008E80 CD 8A 49         [ 4] 2251 	call	_ssd1306_buffer_write
                                   2252 ;	./libs/menu_lib.c: 113: menu_set_params_value(params_value.current_blue);
      008E83 C6 00 0B         [ 1] 2253 	ld	a, _params_value+4
                                   2254 ;	./libs/menu_lib.c: 114: break;
      008E86 CC 8D 01         [ 2] 2255 	jp	_menu_set_params_value
                                   2256 ;	./libs/menu_lib.c: 115: case first:
      008E89                       2257 00104$:
                                   2258 ;	./libs/menu_lib.c: 116: menu_border_item(segment);
      008E89 A6 07            [ 1] 2259 	ld	a, #0x07
      008E8B CD 8C 60         [ 4] 2260 	call	_menu_border_item
                                   2261 ;	./libs/menu_lib.c: 124: menu_set_params_value(params_value.current_first);
      008E8E AE 00 0C         [ 2] 2262 	ldw	x, #_params_value+5
      008E91 F6               [ 1] 2263 	ld	a, (x)
      008E92 A4 0F            [ 1] 2264 	and	a, #0x0f
                                   2265 ;	./libs/menu_lib.c: 125: break;
      008E94 CC 8D 01         [ 2] 2266 	jp	_menu_set_params_value
                                   2267 ;	./libs/menu_lib.c: 126: case second:
      008E97                       2268 00105$:
                                   2269 ;	./libs/menu_lib.c: 127: menu_border_item(segment);
      008E97 A6 07            [ 1] 2270 	ld	a, #0x07
      008E99 CD 8C 60         [ 4] 2271 	call	_menu_border_item
                                   2272 ;	./libs/menu_lib.c: 136: menu_set_params_value(params_value.current_second);
      008E9C AE 00 0C         [ 2] 2273 	ldw	x, #_params_value+5
      008E9F F6               [ 1] 2274 	ld	a, (x)
      008EA0 4E               [ 1] 2275 	swap	a
      008EA1 A4 0F            [ 1] 2276 	and	a, #0x0f
                                   2277 ;	./libs/menu_lib.c: 137: break;
      008EA3 CC 8D 01         [ 2] 2278 	jp	_menu_set_params_value
                                   2279 ;	./libs/menu_lib.c: 138: case sens:
      008EA6                       2280 00106$:
                                   2281 ;	./libs/menu_lib.c: 139: menu_border_item(settings);
      008EA6 A6 05            [ 1] 2282 	ld	a, #0x05
      008EA8 CD 8C 60         [ 4] 2283 	call	_menu_border_item
                                   2284 ;	./libs/menu_lib.c: 146: menu_set_params_value(params_value.current_sens);
      008EAB C6 00 0D         [ 1] 2285 	ld	a, _params_value+6
                                   2286 ;	./libs/menu_lib.c: 147: break;
      008EAE CC 8D 01         [ 2] 2287 	jp	_menu_set_params_value
                                   2288 ;	./libs/menu_lib.c: 148: case vers:
      008EB1                       2289 00107$:
                                   2290 ;	./libs/menu_lib.c: 149: menu_border_item(settings);
      008EB1 A6 05            [ 1] 2291 	ld	a, #0x05
      008EB3 CD 8C 60         [ 4] 2292 	call	_menu_border_item
                                   2293 ;	./libs/menu_lib.c: 156: menu_set_params_value(params_value.current_vers);
      008EB6 C6 00 0E         [ 1] 2294 	ld	a, _params_value+7
      008EB9 CC 8D 01         [ 2] 2295 	jp	_menu_set_params_value
                                   2296 ;	./libs/menu_lib.c: 158: }
      008EBC                       2297 00109$:
                                   2298 ;	./libs/menu_lib.c: 160: }
      008EBC 81               [ 4] 2299 	ret
                                   2300 ;	./libs/menu_lib.c: 165: void menu_set_paragraph(uint8_t paragraph)
                                   2301 ;	-----------------------------------------
                                   2302 ;	 function menu_set_paragraph
                                   2303 ;	-----------------------------------------
      008EBD                       2304 _menu_set_paragraph:
                                   2305 ;	./libs/menu_lib.c: 167: switch(paragraph)
      008EBD A1 00            [ 1] 2306 	cp	a, #0x00
      008EBF 27 16            [ 1] 2307 	jreq	00101$
      008EC1 A1 04            [ 1] 2308 	cp	a, #0x04
      008EC3 26 03            [ 1] 2309 	jrne	00140$
      008EC5 CC 90 27         [ 2] 2310 	jp	00102$
      008EC8                       2311 00140$:
      008EC8 A1 05            [ 1] 2312 	cp	a, #0x05
      008ECA 26 03            [ 1] 2313 	jrne	00143$
      008ECC CC 90 E7         [ 2] 2314 	jp	00104$
      008ECF                       2315 00143$:
      008ECF A1 07            [ 1] 2316 	cp	a, #0x07
      008ED1 26 03            [ 1] 2317 	jrne	00146$
      008ED3 CC 90 72         [ 2] 2318 	jp	00103$
      008ED6                       2319 00146$:
      008ED6 81               [ 4] 2320 	ret
                                   2321 ;	./libs/menu_lib.c: 169: case menu:
      008ED7                       2322 00101$:
                                   2323 ;	./libs/menu_lib.c: 170: ssd1306_buffer_clean();
      008ED7 CD 89 E7         [ 4] 2324 	call	_ssd1306_buffer_clean
                                   2325 ;	./libs/menu_lib.c: 171: menu_border();
      008EDA CD 8A E4         [ 4] 2326 	call	_menu_border
                                   2327 ;	./libs/menu_lib.c: 172: menu_border_paragraph(4);
      008EDD A6 04            [ 1] 2328 	ld	a, #0x04
      008EDF CD 8B 91         [ 4] 2329 	call	_menu_border_paragraph
                                   2330 ;	./libs/menu_lib.c: 174: ssd1306_buffer_write(10,12,ttf_rus_8);
      008EE2 4B 5B            [ 1] 2331 	push	#<(_ttf_rus_8+0)
      008EE4 4B 00            [ 1] 2332 	push	#((_ttf_rus_8+0) >> 8)
      008EE6 4B 0C            [ 1] 2333 	push	#0x0c
      008EE8 4B 00            [ 1] 2334 	push	#0x00
      008EEA AE 00 0A         [ 2] 2335 	ldw	x, #0x000a
      008EED CD 8A 49         [ 4] 2336 	call	_ssd1306_buffer_write
                                   2337 ;	./libs/menu_lib.c: 175: ssd1306_buffer_write(18,12,ttf_rus_3);
      008EF0 4B 33            [ 1] 2338 	push	#<(_ttf_rus_3+0)
      008EF2 4B 00            [ 1] 2339 	push	#((_ttf_rus_3+0) >> 8)
      008EF4 4B 0C            [ 1] 2340 	push	#0x0c
      008EF6 4B 00            [ 1] 2341 	push	#0x00
      008EF8 AE 00 12         [ 2] 2342 	ldw	x, #0x0012
      008EFB CD 8A 49         [ 4] 2343 	call	_ssd1306_buffer_write
                                   2344 ;	./libs/menu_lib.c: 176: ssd1306_buffer_write(26,12,ttf_rus_9);
      008EFE 4B 63            [ 1] 2345 	push	#<(_ttf_rus_9+0)
      008F00 4B 00            [ 1] 2346 	push	#((_ttf_rus_9+0) >> 8)
      008F02 4B 0C            [ 1] 2347 	push	#0x0c
      008F04 4B 00            [ 1] 2348 	push	#0x00
      008F06 AE 00 1A         [ 2] 2349 	ldw	x, #0x001a
      008F09 CD 8A 49         [ 4] 2350 	call	_ssd1306_buffer_write
                                   2351 ;	./libs/menu_lib.c: 177: ssd1306_buffer_write(34,12,ttf_rus_20);
      008F0C 4B BB            [ 1] 2352 	push	#<(_ttf_rus_20+0)
      008F0E 4B 00            [ 1] 2353 	push	#((_ttf_rus_20+0) >> 8)
      008F10 4B 0C            [ 1] 2354 	push	#0x0c
      008F12 4B 00            [ 1] 2355 	push	#0x00
      008F14 AE 00 22         [ 2] 2356 	ldw	x, #0x0022
      008F17 CD 8A 49         [ 4] 2357 	call	_ssd1306_buffer_write
                                   2358 ;	./libs/menu_lib.c: 179: ssd1306_buffer_write(48,4,ttf_rus_1);
      008F1A 4B 23            [ 1] 2359 	push	#<(_ttf_rus_1+0)
      008F1C 4B 00            [ 1] 2360 	push	#((_ttf_rus_1+0) >> 8)
      008F1E 4B 04            [ 1] 2361 	push	#0x04
      008F20 4B 00            [ 1] 2362 	push	#0x00
      008F22 AE 00 30         [ 2] 2363 	ldw	x, #0x0030
      008F25 CD 8A 49         [ 4] 2364 	call	_ssd1306_buffer_write
                                   2365 ;	./libs/menu_lib.c: 180: ssd1306_buffer_write(56,4,ttf_rus_2);
      008F28 4B 2B            [ 1] 2366 	push	#<(_ttf_rus_2+0)
      008F2A 4B 00            [ 1] 2367 	push	#((_ttf_rus_2+0) >> 8)
      008F2C 4B 04            [ 1] 2368 	push	#0x04
      008F2E 4B 00            [ 1] 2369 	push	#0x00
      008F30 AE 00 38         [ 2] 2370 	ldw	x, #0x0038
      008F33 CD 8A 49         [ 4] 2371 	call	_ssd1306_buffer_write
                                   2372 ;	./libs/menu_lib.c: 181: ssd1306_buffer_write(64,4,ttf_rus_3);
      008F36 4B 33            [ 1] 2373 	push	#<(_ttf_rus_3+0)
      008F38 4B 00            [ 1] 2374 	push	#((_ttf_rus_3+0) >> 8)
      008F3A 4B 04            [ 1] 2375 	push	#0x04
      008F3C 4B 00            [ 1] 2376 	push	#0x00
      008F3E AE 00 40         [ 2] 2377 	ldw	x, #0x0040
      008F41 CD 8A 49         [ 4] 2378 	call	_ssd1306_buffer_write
                                   2379 ;	./libs/menu_lib.c: 182: ssd1306_buffer_write(72,4,ttf_rus_4);
      008F44 4B 3B            [ 1] 2380 	push	#<(_ttf_rus_4+0)
      008F46 4B 00            [ 1] 2381 	push	#((_ttf_rus_4+0) >> 8)
      008F48 4B 04            [ 1] 2382 	push	#0x04
      008F4A 4B 00            [ 1] 2383 	push	#0x00
      008F4C AE 00 48         [ 2] 2384 	ldw	x, #0x0048
      008F4F CD 8A 49         [ 4] 2385 	call	_ssd1306_buffer_write
                                   2386 ;	./libs/menu_lib.c: 183: ssd1306_buffer_write(114,4,ttf_line_left);
      008F52 4B 45            [ 1] 2387 	push	#<(_ttf_line_left+0)
      008F54 4B 01            [ 1] 2388 	push	#((_ttf_line_left+0) >> 8)
      008F56 4B 04            [ 1] 2389 	push	#0x04
      008F58 4B 00            [ 1] 2390 	push	#0x00
      008F5A AE 00 72         [ 2] 2391 	ldw	x, #0x0072
      008F5D CD 8A 49         [ 4] 2392 	call	_ssd1306_buffer_write
                                   2393 ;	./libs/menu_lib.c: 185: ssd1306_buffer_write(48,12,ttf_rus_6);
      008F60 4B 4B            [ 1] 2394 	push	#<(_ttf_rus_6+0)
      008F62 4B 00            [ 1] 2395 	push	#((_ttf_rus_6+0) >> 8)
      008F64 4B 0C            [ 1] 2396 	push	#0x0c
      008F66 4B 00            [ 1] 2397 	push	#0x00
      008F68 AE 00 30         [ 2] 2398 	ldw	x, #0x0030
      008F6B CD 8A 49         [ 4] 2399 	call	_ssd1306_buffer_write
                                   2400 ;	./libs/menu_lib.c: 186: ssd1306_buffer_write(56,12,ttf_rus_3);
      008F6E 4B 33            [ 1] 2401 	push	#<(_ttf_rus_3+0)
      008F70 4B 00            [ 1] 2402 	push	#((_ttf_rus_3+0) >> 8)
      008F72 4B 0C            [ 1] 2403 	push	#0x0c
      008F74 4B 00            [ 1] 2404 	push	#0x00
      008F76 AE 00 38         [ 2] 2405 	ldw	x, #0x0038
      008F79 CD 8A 49         [ 4] 2406 	call	_ssd1306_buffer_write
                                   2407 ;	./libs/menu_lib.c: 187: ssd1306_buffer_write(64,12,ttf_rus_7);
      008F7C 4B 53            [ 1] 2408 	push	#<(_ttf_rus_7+0)
      008F7E 4B 00            [ 1] 2409 	push	#((_ttf_rus_7+0) >> 8)
      008F80 4B 0C            [ 1] 2410 	push	#0x0c
      008F82 4B 00            [ 1] 2411 	push	#0x00
      008F84 AE 00 40         [ 2] 2412 	ldw	x, #0x0040
      008F87 CD 8A 49         [ 4] 2413 	call	_ssd1306_buffer_write
                                   2414 ;	./libs/menu_lib.c: 188: ssd1306_buffer_write(72,12,ttf_rus_8);
      008F8A 4B 5B            [ 1] 2415 	push	#<(_ttf_rus_8+0)
      008F8C 4B 00            [ 1] 2416 	push	#((_ttf_rus_8+0) >> 8)
      008F8E 4B 0C            [ 1] 2417 	push	#0x0c
      008F90 4B 00            [ 1] 2418 	push	#0x00
      008F92 AE 00 48         [ 2] 2419 	ldw	x, #0x0048
      008F95 CD 8A 49         [ 4] 2420 	call	_ssd1306_buffer_write
                                   2421 ;	./libs/menu_lib.c: 189: ssd1306_buffer_write(80,12,ttf_rus_3);
      008F98 4B 33            [ 1] 2422 	push	#<(_ttf_rus_3+0)
      008F9A 4B 00            [ 1] 2423 	push	#((_ttf_rus_3+0) >> 8)
      008F9C 4B 0C            [ 1] 2424 	push	#0x0c
      008F9E 4B 00            [ 1] 2425 	push	#0x00
      008FA0 AE 00 50         [ 2] 2426 	ldw	x, #0x0050
      008FA3 CD 8A 49         [ 4] 2427 	call	_ssd1306_buffer_write
                                   2428 ;	./libs/menu_lib.c: 190: ssd1306_buffer_write(88,12,ttf_rus_9);
      008FA6 4B 63            [ 1] 2429 	push	#<(_ttf_rus_9+0)
      008FA8 4B 00            [ 1] 2430 	push	#((_ttf_rus_9+0) >> 8)
      008FAA 4B 0C            [ 1] 2431 	push	#0x0c
      008FAC 4B 00            [ 1] 2432 	push	#0x00
      008FAE AE 00 58         [ 2] 2433 	ldw	x, #0x0058
      008FB1 CD 8A 49         [ 4] 2434 	call	_ssd1306_buffer_write
                                   2435 ;	./libs/menu_lib.c: 191: ssd1306_buffer_write(96,12,ttf_rus_4);
      008FB4 4B 3B            [ 1] 2436 	push	#<(_ttf_rus_4+0)
      008FB6 4B 00            [ 1] 2437 	push	#((_ttf_rus_4+0) >> 8)
      008FB8 4B 0C            [ 1] 2438 	push	#0x0c
      008FBA 4B 00            [ 1] 2439 	push	#0x00
      008FBC AE 00 60         [ 2] 2440 	ldw	x, #0x0060
      008FBF CD 8A 49         [ 4] 2441 	call	_ssd1306_buffer_write
                                   2442 ;	./libs/menu_lib.c: 192: ssd1306_buffer_write(106,12,ttf_void);
      008FC2 4B C5            [ 1] 2443 	push	#<(_ttf_void+0)
      008FC4 4B 00            [ 1] 2444 	push	#((_ttf_void+0) >> 8)
      008FC6 4B 0C            [ 1] 2445 	push	#0x0c
      008FC8 4B 00            [ 1] 2446 	push	#0x00
      008FCA AE 00 6A         [ 2] 2447 	ldw	x, #0x006a
      008FCD CD 8A 49         [ 4] 2448 	call	_ssd1306_buffer_write
                                   2449 ;	./libs/menu_lib.c: 194: ssd1306_buffer_write(48,20,ttf_rus_10);
      008FD0 4B 6B            [ 1] 2450 	push	#<(_ttf_rus_10+0)
      008FD2 4B 00            [ 1] 2451 	push	#((_ttf_rus_10+0) >> 8)
      008FD4 4B 14            [ 1] 2452 	push	#0x14
      008FD6 4B 00            [ 1] 2453 	push	#0x00
      008FD8 AE 00 30         [ 2] 2454 	ldw	x, #0x0030
      008FDB CD 8A 49         [ 4] 2455 	call	_ssd1306_buffer_write
                                   2456 ;	./libs/menu_lib.c: 195: ssd1306_buffer_write(56,20,ttf_rus_11);
      008FDE 4B 73            [ 1] 2457 	push	#<(_ttf_rus_11+0)
      008FE0 4B 00            [ 1] 2458 	push	#((_ttf_rus_11+0) >> 8)
      008FE2 4B 14            [ 1] 2459 	push	#0x14
      008FE4 4B 00            [ 1] 2460 	push	#0x00
      008FE6 AE 00 38         [ 2] 2461 	ldw	x, #0x0038
      008FE9 CD 8A 49         [ 4] 2462 	call	_ssd1306_buffer_write
                                   2463 ;	./libs/menu_lib.c: 196: ssd1306_buffer_write(64,20,ttf_rus_1);
      008FEC 4B 23            [ 1] 2464 	push	#<(_ttf_rus_1+0)
      008FEE 4B 00            [ 1] 2465 	push	#((_ttf_rus_1+0) >> 8)
      008FF0 4B 14            [ 1] 2466 	push	#0x14
      008FF2 4B 00            [ 1] 2467 	push	#0x00
      008FF4 AE 00 40         [ 2] 2468 	ldw	x, #0x0040
      008FF7 CD 8A 49         [ 4] 2469 	call	_ssd1306_buffer_write
                                   2470 ;	./libs/menu_lib.c: 197: ssd1306_buffer_write(72,20,ttf_rus_12);
      008FFA 4B 7B            [ 1] 2471 	push	#<(_ttf_rus_12+0)
      008FFC 4B 00            [ 1] 2472 	push	#((_ttf_rus_12+0) >> 8)
      008FFE 4B 14            [ 1] 2473 	push	#0x14
      009000 4B 00            [ 1] 2474 	push	#0x00
      009002 AE 00 48         [ 2] 2475 	ldw	x, #0x0048
      009005 CD 8A 49         [ 4] 2476 	call	_ssd1306_buffer_write
                                   2477 ;	./libs/menu_lib.c: 198: ssd1306_buffer_write(80,20,ttf_rus_12);
      009008 4B 7B            [ 1] 2478 	push	#<(_ttf_rus_12+0)
      00900A 4B 00            [ 1] 2479 	push	#((_ttf_rus_12+0) >> 8)
      00900C 4B 14            [ 1] 2480 	push	#0x14
      00900E 4B 00            [ 1] 2481 	push	#0x00
      009010 AE 00 50         [ 2] 2482 	ldw	x, #0x0050
      009013 CD 8A 49         [ 4] 2483 	call	_ssd1306_buffer_write
                                   2484 ;	./libs/menu_lib.c: 199: ssd1306_buffer_write(106,20,ttf_void);
      009016 4B C5            [ 1] 2485 	push	#<(_ttf_void+0)
      009018 4B 00            [ 1] 2486 	push	#((_ttf_void+0) >> 8)
      00901A 4B 14            [ 1] 2487 	push	#0x14
      00901C 4B 00            [ 1] 2488 	push	#0x00
      00901E AE 00 6A         [ 2] 2489 	ldw	x, #0x006a
      009021 CD 8A 49         [ 4] 2490 	call	_ssd1306_buffer_write
                                   2491 ;	./libs/menu_lib.c: 201: ssd1306_send_buffer();
                                   2492 ;	./libs/menu_lib.c: 202: break;
      009024 CC 89 F4         [ 2] 2493 	jp	_ssd1306_send_buffer
                                   2494 ;	./libs/menu_lib.c: 203: case color:
      009027                       2495 00102$:
                                   2496 ;	./libs/menu_lib.c: 204: ssd1306_buffer_clean();
      009027 CD 89 E7         [ 4] 2497 	call	_ssd1306_buffer_clean
                                   2498 ;	./libs/menu_lib.c: 205: menu_border();
      00902A CD 8A E4         [ 4] 2499 	call	_menu_border
                                   2500 ;	./libs/menu_lib.c: 206: menu_border_paragraph(color);
      00902D A6 04            [ 1] 2501 	ld	a, #0x04
      00902F CD 8B 91         [ 4] 2502 	call	_menu_border_paragraph
                                   2503 ;	./libs/menu_lib.c: 208: ssd1306_buffer_write(10,12,ttf_rus_1);
      009032 4B 23            [ 1] 2504 	push	#<(_ttf_rus_1+0)
      009034 4B 00            [ 1] 2505 	push	#((_ttf_rus_1+0) >> 8)
      009036 4B 0C            [ 1] 2506 	push	#0x0c
      009038 4B 00            [ 1] 2507 	push	#0x00
      00903A AE 00 0A         [ 2] 2508 	ldw	x, #0x000a
      00903D CD 8A 49         [ 4] 2509 	call	_ssd1306_buffer_write
                                   2510 ;	./libs/menu_lib.c: 209: ssd1306_buffer_write(18,12,ttf_rus_2);
      009040 4B 2B            [ 1] 2511 	push	#<(_ttf_rus_2+0)
      009042 4B 00            [ 1] 2512 	push	#((_ttf_rus_2+0) >> 8)
      009044 4B 0C            [ 1] 2513 	push	#0x0c
      009046 4B 00            [ 1] 2514 	push	#0x00
      009048 AE 00 12         [ 2] 2515 	ldw	x, #0x0012
      00904B CD 8A 49         [ 4] 2516 	call	_ssd1306_buffer_write
                                   2517 ;	./libs/menu_lib.c: 210: ssd1306_buffer_write(26,12,ttf_rus_3);
      00904E 4B 33            [ 1] 2518 	push	#<(_ttf_rus_3+0)
      009050 4B 00            [ 1] 2519 	push	#((_ttf_rus_3+0) >> 8)
      009052 4B 0C            [ 1] 2520 	push	#0x0c
      009054 4B 00            [ 1] 2521 	push	#0x00
      009056 AE 00 1A         [ 2] 2522 	ldw	x, #0x001a
      009059 CD 8A 49         [ 4] 2523 	call	_ssd1306_buffer_write
                                   2524 ;	./libs/menu_lib.c: 211: ssd1306_buffer_write(34,12,ttf_rus_4);
      00905C 4B 3B            [ 1] 2525 	push	#<(_ttf_rus_4+0)
      00905E 4B 00            [ 1] 2526 	push	#((_ttf_rus_4+0) >> 8)
      009060 4B 0C            [ 1] 2527 	push	#0x0c
      009062 4B 00            [ 1] 2528 	push	#0x00
      009064 AE 00 22         [ 2] 2529 	ldw	x, #0x0022
      009067 CD 8A 49         [ 4] 2530 	call	_ssd1306_buffer_write
                                   2531 ;	./libs/menu_lib.c: 213: menu_set_item_menu(red);
      00906A A6 01            [ 1] 2532 	ld	a, #0x01
      00906C CD 8D 42         [ 4] 2533 	call	_menu_set_item_menu
                                   2534 ;	./libs/menu_lib.c: 215: ssd1306_send_buffer();
                                   2535 ;	./libs/menu_lib.c: 216: break;
      00906F CC 89 F4         [ 2] 2536 	jp	_ssd1306_send_buffer
                                   2537 ;	./libs/menu_lib.c: 217: case segment:
      009072                       2538 00103$:
                                   2539 ;	./libs/menu_lib.c: 218: ssd1306_buffer_clean();
      009072 CD 89 E7         [ 4] 2540 	call	_ssd1306_buffer_clean
                                   2541 ;	./libs/menu_lib.c: 219: menu_border();
      009075 CD 8A E4         [ 4] 2542 	call	_menu_border
                                   2543 ;	./libs/menu_lib.c: 220: menu_border_paragraph(segment);
      009078 A6 07            [ 1] 2544 	ld	a, #0x07
      00907A CD 8B 91         [ 4] 2545 	call	_menu_border_paragraph
                                   2546 ;	./libs/menu_lib.c: 222: ssd1306_buffer_write(10,12,ttf_rus_6);
      00907D 4B 4B            [ 1] 2547 	push	#<(_ttf_rus_6+0)
      00907F 4B 00            [ 1] 2548 	push	#((_ttf_rus_6+0) >> 8)
      009081 4B 0C            [ 1] 2549 	push	#0x0c
      009083 4B 00            [ 1] 2550 	push	#0x00
      009085 AE 00 0A         [ 2] 2551 	ldw	x, #0x000a
      009088 CD 8A 49         [ 4] 2552 	call	_ssd1306_buffer_write
                                   2553 ;	./libs/menu_lib.c: 223: ssd1306_buffer_write(18,12,ttf_rus_3);
      00908B 4B 33            [ 1] 2554 	push	#<(_ttf_rus_3+0)
      00908D 4B 00            [ 1] 2555 	push	#((_ttf_rus_3+0) >> 8)
      00908F 4B 0C            [ 1] 2556 	push	#0x0c
      009091 4B 00            [ 1] 2557 	push	#0x00
      009093 AE 00 12         [ 2] 2558 	ldw	x, #0x0012
      009096 CD 8A 49         [ 4] 2559 	call	_ssd1306_buffer_write
                                   2560 ;	./libs/menu_lib.c: 224: ssd1306_buffer_write(26,12,ttf_rus_7);
      009099 4B 53            [ 1] 2561 	push	#<(_ttf_rus_7+0)
      00909B 4B 00            [ 1] 2562 	push	#((_ttf_rus_7+0) >> 8)
      00909D 4B 0C            [ 1] 2563 	push	#0x0c
      00909F 4B 00            [ 1] 2564 	push	#0x00
      0090A1 AE 00 1A         [ 2] 2565 	ldw	x, #0x001a
      0090A4 CD 8A 49         [ 4] 2566 	call	_ssd1306_buffer_write
                                   2567 ;	./libs/menu_lib.c: 225: ssd1306_buffer_write(34,12,ttf_rus_8);
      0090A7 4B 5B            [ 1] 2568 	push	#<(_ttf_rus_8+0)
      0090A9 4B 00            [ 1] 2569 	push	#((_ttf_rus_8+0) >> 8)
      0090AB 4B 0C            [ 1] 2570 	push	#0x0c
      0090AD 4B 00            [ 1] 2571 	push	#0x00
      0090AF AE 00 22         [ 2] 2572 	ldw	x, #0x0022
      0090B2 CD 8A 49         [ 4] 2573 	call	_ssd1306_buffer_write
                                   2574 ;	./libs/menu_lib.c: 226: ssd1306_buffer_write(42,12,ttf_rus_3);
      0090B5 4B 33            [ 1] 2575 	push	#<(_ttf_rus_3+0)
      0090B7 4B 00            [ 1] 2576 	push	#((_ttf_rus_3+0) >> 8)
      0090B9 4B 0C            [ 1] 2577 	push	#0x0c
      0090BB 4B 00            [ 1] 2578 	push	#0x00
      0090BD AE 00 2A         [ 2] 2579 	ldw	x, #0x002a
      0090C0 CD 8A 49         [ 4] 2580 	call	_ssd1306_buffer_write
                                   2581 ;	./libs/menu_lib.c: 227: ssd1306_buffer_write(50,12,ttf_rus_9);
      0090C3 4B 63            [ 1] 2582 	push	#<(_ttf_rus_9+0)
      0090C5 4B 00            [ 1] 2583 	push	#((_ttf_rus_9+0) >> 8)
      0090C7 4B 0C            [ 1] 2584 	push	#0x0c
      0090C9 4B 00            [ 1] 2585 	push	#0x00
      0090CB AE 00 32         [ 2] 2586 	ldw	x, #0x0032
      0090CE CD 8A 49         [ 4] 2587 	call	_ssd1306_buffer_write
                                   2588 ;	./libs/menu_lib.c: 228: ssd1306_buffer_write(58,12,ttf_rus_4);
      0090D1 4B 3B            [ 1] 2589 	push	#<(_ttf_rus_4+0)
      0090D3 4B 00            [ 1] 2590 	push	#((_ttf_rus_4+0) >> 8)
      0090D5 4B 0C            [ 1] 2591 	push	#0x0c
      0090D7 4B 00            [ 1] 2592 	push	#0x00
      0090D9 AE 00 3A         [ 2] 2593 	ldw	x, #0x003a
      0090DC CD 8A 49         [ 4] 2594 	call	_ssd1306_buffer_write
                                   2595 ;	./libs/menu_lib.c: 230: menu_set_item_menu(first);
      0090DF A6 04            [ 1] 2596 	ld	a, #0x04
      0090E1 CD 8D 42         [ 4] 2597 	call	_menu_set_item_menu
                                   2598 ;	./libs/menu_lib.c: 232: ssd1306_send_buffer();
                                   2599 ;	./libs/menu_lib.c: 235: break;
      0090E4 CC 89 F4         [ 2] 2600 	jp	_ssd1306_send_buffer
                                   2601 ;	./libs/menu_lib.c: 236: case settings:
      0090E7                       2602 00104$:
                                   2603 ;	./libs/menu_lib.c: 237: ssd1306_buffer_clean();
      0090E7 CD 89 E7         [ 4] 2604 	call	_ssd1306_buffer_clean
                                   2605 ;	./libs/menu_lib.c: 238: menu_border();
      0090EA CD 8A E4         [ 4] 2606 	call	_menu_border
                                   2607 ;	./libs/menu_lib.c: 239: menu_border_paragraph(settings);
      0090ED A6 05            [ 1] 2608 	ld	a, #0x05
      0090EF CD 8B 91         [ 4] 2609 	call	_menu_border_paragraph
                                   2610 ;	./libs/menu_lib.c: 241: ssd1306_buffer_write(10,12,ttf_rus_10);
      0090F2 4B 6B            [ 1] 2611 	push	#<(_ttf_rus_10+0)
      0090F4 4B 00            [ 1] 2612 	push	#((_ttf_rus_10+0) >> 8)
      0090F6 4B 0C            [ 1] 2613 	push	#0x0c
      0090F8 4B 00            [ 1] 2614 	push	#0x00
      0090FA AE 00 0A         [ 2] 2615 	ldw	x, #0x000a
      0090FD CD 8A 49         [ 4] 2616 	call	_ssd1306_buffer_write
                                   2617 ;	./libs/menu_lib.c: 242: ssd1306_buffer_write(18,12,ttf_rus_11);
      009100 4B 73            [ 1] 2618 	push	#<(_ttf_rus_11+0)
      009102 4B 00            [ 1] 2619 	push	#((_ttf_rus_11+0) >> 8)
      009104 4B 0C            [ 1] 2620 	push	#0x0c
      009106 4B 00            [ 1] 2621 	push	#0x00
      009108 AE 00 12         [ 2] 2622 	ldw	x, #0x0012
      00910B CD 8A 49         [ 4] 2623 	call	_ssd1306_buffer_write
                                   2624 ;	./libs/menu_lib.c: 243: ssd1306_buffer_write(26,12,ttf_rus_1);
      00910E 4B 23            [ 1] 2625 	push	#<(_ttf_rus_1+0)
      009110 4B 00            [ 1] 2626 	push	#((_ttf_rus_1+0) >> 8)
      009112 4B 0C            [ 1] 2627 	push	#0x0c
      009114 4B 00            [ 1] 2628 	push	#0x00
      009116 AE 00 1A         [ 2] 2629 	ldw	x, #0x001a
      009119 CD 8A 49         [ 4] 2630 	call	_ssd1306_buffer_write
                                   2631 ;	./libs/menu_lib.c: 244: ssd1306_buffer_write(34,12,ttf_rus_12);
      00911C 4B 7B            [ 1] 2632 	push	#<(_ttf_rus_12+0)
      00911E 4B 00            [ 1] 2633 	push	#((_ttf_rus_12+0) >> 8)
      009120 4B 0C            [ 1] 2634 	push	#0x0c
      009122 4B 00            [ 1] 2635 	push	#0x00
      009124 AE 00 22         [ 2] 2636 	ldw	x, #0x0022
      009127 CD 8A 49         [ 4] 2637 	call	_ssd1306_buffer_write
                                   2638 ;	./libs/menu_lib.c: 245: ssd1306_buffer_write(42,12,ttf_rus_12);
      00912A 4B 7B            [ 1] 2639 	push	#<(_ttf_rus_12+0)
      00912C 4B 00            [ 1] 2640 	push	#((_ttf_rus_12+0) >> 8)
      00912E 4B 0C            [ 1] 2641 	push	#0x0c
      009130 4B 00            [ 1] 2642 	push	#0x00
      009132 AE 00 2A         [ 2] 2643 	ldw	x, #0x002a
      009135 CD 8A 49         [ 4] 2644 	call	_ssd1306_buffer_write
                                   2645 ;	./libs/menu_lib.c: 247: menu_set_item_menu(sens);
      009138 A6 06            [ 1] 2646 	ld	a, #0x06
      00913A CD 8D 42         [ 4] 2647 	call	_menu_set_item_menu
                                   2648 ;	./libs/menu_lib.c: 249: ssd1306_send_buffer();
                                   2649 ;	./libs/menu_lib.c: 251: }
                                   2650 ;	./libs/menu_lib.c: 252: }
      00913D CC 89 F4         [ 2] 2651 	jp	_ssd1306_send_buffer
                                   2652 ;	./libs/adc_lib.c: 2: void adc_init(void) {
                                   2653 ;	-----------------------------------------
                                   2654 ;	 function adc_init
                                   2655 ;	-----------------------------------------
      009140                       2656 _adc_init:
                                   2657 ;	./libs/adc_lib.c: 4: ADC_CSR -> CH = 3; // Select channel 2 (AIN2=PC4)
      009140 C6 54 00         [ 1] 2658 	ld	a, 0x5400
      009143 A4 F0            [ 1] 2659 	and	a, #0xf0
      009145 AA 03            [ 1] 2660 	or	a, #0x03
      009147 C7 54 00         [ 1] 2661 	ld	0x5400, a
                                   2662 ;	./libs/adc_lib.c: 6: ADC_CR1 -> ADON = 1; // ADON
      00914A 72 10 54 01      [ 1] 2663 	bset	0x5401, #0
                                   2664 ;	./libs/adc_lib.c: 7: ADC_CR2 -> ALIGN = 0; // Align left
      00914E AE 54 02         [ 2] 2665 	ldw	x, #0x5402
      009151 72 17 54 02      [ 1] 2666 	bres	0x5402, #3
                                   2667 ;	./libs/adc_lib.c: 9: delay_s(1); // Give little time to be ready for first conversion
      009155 A6 01            [ 1] 2668 	ld	a, #0x01
                                   2669 ;	./libs/adc_lib.c: 10: }
      009157 CC 86 31         [ 2] 2670 	jp	_delay_s
                                   2671 ;	./libs/adc_lib.c: 12: uint16_t adc_read(void) {
                                   2672 ;	-----------------------------------------
                                   2673 ;	 function adc_read
                                   2674 ;	-----------------------------------------
      00915A                       2675 _adc_read:
                                   2676 ;	./libs/adc_lib.c: 13: ADC_CR1 -> CONT = 0; // Single conversion mode
      00915A 72 13 54 01      [ 1] 2677 	bres	0x5401, #1
                                   2678 ;	./libs/adc_lib.c: 14: ADC_CR1 -> ADON = 1; // Start conversion
      00915E 72 10 54 01      [ 1] 2679 	bset	0x5401, #0
                                   2680 ;	./libs/adc_lib.c: 15: while(!(ADC_CSR -> EOC));
      009162                       2681 00101$:
      009162 AE 54 00         [ 2] 2682 	ldw	x, #0x5400
      009165 F6               [ 1] 2683 	ld	a, (x)
      009166 4E               [ 1] 2684 	swap	a
      009167 44               [ 1] 2685 	srl	a
      009168 44               [ 1] 2686 	srl	a
      009169 44               [ 1] 2687 	srl	a
      00916A A4 01            [ 1] 2688 	and	a, #0x01
      00916C 27 F4            [ 1] 2689 	jreq	00101$
                                   2690 ;	./libs/adc_lib.c: 17: nop(); 
      00916E 9D               [ 1] 2691 	nop
                                   2692 ;	./libs/adc_lib.c: 19: ADC_CSR  -> EOC = 0; // Clear "End of conversion"-flag
      00916F 72 1F 54 00      [ 1] 2693 	bres	0x5400, #7
                                   2694 ;	./libs/adc_lib.c: 20: return (ADC_DRL -> DH << 2) | (ADC_DRL -> DH >> 6);  // Left aligned
      009173 C6 54 05         [ 1] 2695 	ld	a, 0x5405
      009176 5F               [ 1] 2696 	clrw	x
      009177 97               [ 1] 2697 	ld	xl, a
      009178 58               [ 2] 2698 	sllw	x
      009179 58               [ 2] 2699 	sllw	x
      00917A 4E               [ 1] 2700 	swap	a
      00917B A4 0F            [ 1] 2701 	and	a, #0x0f
      00917D 44               [ 1] 2702 	srl	a
      00917E 44               [ 1] 2703 	srl	a
      00917F 89               [ 2] 2704 	pushw	x
      009180 1A 02            [ 1] 2705 	or	a, (2, sp)
      009182 85               [ 2] 2706 	popw	x
      009183 97               [ 1] 2707 	ld	xl, a
                                   2708 ;	./libs/adc_lib.c: 21: }
      009184 81               [ 4] 2709 	ret
                                   2710 ;	main.c: 3: void params_default_conf(void)
                                   2711 ;	-----------------------------------------
                                   2712 ;	 function params_default_conf
                                   2713 ;	-----------------------------------------
      009185                       2714 _params_default_conf:
                                   2715 ;	main.c: 5: params_value.current_red = 255;
      009185 35 FF 00 09      [ 1] 2716 	mov	_params_value+2, #0xff
                                   2717 ;	main.c: 6: params_value.current_green = 255;
      009189 35 FF 00 0A      [ 1] 2718 	mov	_params_value+3, #0xff
                                   2719 ;	main.c: 7: params_value.current_blue = 255;
      00918D 35 FF 00 0B      [ 1] 2720 	mov	_params_value+4, #0xff
                                   2721 ;	main.c: 9: params_value.current_first = 0;
      009191 AE 00 0C         [ 2] 2722 	ldw	x, #(_params_value+0)+5
      009194 F6               [ 1] 2723 	ld	a, (x)
      009195 A4 F0            [ 1] 2724 	and	a, #0xf0
                                   2725 ;	main.c: 10: params_value.current_second = 15;
      009197 F7               [ 1] 2726 	ld	(x), a
      009198 AA F0            [ 1] 2727 	or	a, #0xf0
      00919A F7               [ 1] 2728 	ld	(x), a
                                   2729 ;	main.c: 12: params_value.current_sens = 10;
      00919B 35 0A 00 0D      [ 1] 2730 	mov	_params_value+6, #0x0a
                                   2731 ;	main.c: 13: params_value.current_vers = 0xA1;
      00919F 35 A1 00 0E      [ 1] 2732 	mov	_params_value+7, #0xa1
                                   2733 ;	main.c: 14: }
      0091A3 81               [ 4] 2734 	ret
                                   2735 ;	main.c: 16: void setup(void)
                                   2736 ;	-----------------------------------------
                                   2737 ;	 function setup
                                   2738 ;	-----------------------------------------
      0091A4                       2739 _setup:
                                   2740 ;	main.c: 19: CLK_CKDIVR = 0;
      0091A4 35 00 50 C6      [ 1] 2741 	mov	0x50c6+0, #0x00
                                   2742 ;	main.c: 21: params_value.all = 0;
      0091A8 35 00 00 07      [ 1] 2743 	mov	_params_value+0, #0x00
                                   2744 ;	main.c: 24: uart_init(9600,0);
      0091AC 4F               [ 1] 2745 	clr	a
      0091AD AE 25 80         [ 2] 2746 	ldw	x, #0x2580
      0091B0 CD 84 AE         [ 4] 2747 	call	_uart_init
                                   2748 ;	main.c: 25: i2c_init();
      0091B3 CD 87 71         [ 4] 2749 	call	_i2c_init
                                   2750 ;	main.c: 26: ssd1306_init();
      0091B6 CD 89 04         [ 4] 2751 	call	_ssd1306_init
                                   2752 ;	main.c: 27: ssd1306_send_buffer();
      0091B9 CD 89 F4         [ 4] 2753 	call	_ssd1306_send_buffer
                                   2754 ;	main.c: 28: params_default_conf();
      0091BC CD 91 85         [ 4] 2755 	call	_params_default_conf
                                   2756 ;	main.c: 29: enableInterrupts();
      0091BF 9A               [ 1] 2757 	rim
                                   2758 ;	main.c: 30: adc_init();
      0091C0 CD 91 40         [ 4] 2759 	call	_adc_init
                                   2760 ;	main.c: 31: delay_s(1);//блять в душе не ебу почему так сработало, но почему-то если в начале прогнать таймер он не заработает, но последующие разы всё ок
      0091C3 A6 01            [ 1] 2761 	ld	a, #0x01
      0091C5 CD 86 31         [ 4] 2762 	call	_delay_s
                                   2763 ;	main.c: 32: delay_s(1);
      0091C8 A6 01            [ 1] 2764 	ld	a, #0x01
                                   2765 ;	main.c: 33: }
      0091CA CC 86 31         [ 2] 2766 	jp	_delay_s
                                   2767 ;	main.c: 36: void gg(void)
                                   2768 ;	-----------------------------------------
                                   2769 ;	 function gg
                                   2770 ;	-----------------------------------------
      0091CD                       2771 _gg:
                                   2772 ;	main.c: 38: menu_set_paragraph(menu);
      0091CD 4F               [ 1] 2773 	clr	a
      0091CE CD 8E BD         [ 4] 2774 	call	_menu_set_paragraph
                                   2775 ;	main.c: 39: delay_s(1);
      0091D1 A6 01            [ 1] 2776 	ld	a, #0x01
      0091D3 CD 86 31         [ 4] 2777 	call	_delay_s
                                   2778 ;	main.c: 41: menu_set_paragraph(color);
      0091D6 A6 04            [ 1] 2779 	ld	a, #0x04
      0091D8 CD 8E BD         [ 4] 2780 	call	_menu_set_paragraph
                                   2781 ;	main.c: 42: delay_s(1);
      0091DB A6 01            [ 1] 2782 	ld	a, #0x01
      0091DD CD 86 31         [ 4] 2783 	call	_delay_s
                                   2784 ;	main.c: 44: menu_set_paragraph(segment);
      0091E0 A6 07            [ 1] 2785 	ld	a, #0x07
      0091E2 CD 8E BD         [ 4] 2786 	call	_menu_set_paragraph
                                   2787 ;	main.c: 45: delay_s(1);
      0091E5 A6 01            [ 1] 2788 	ld	a, #0x01
      0091E7 CD 86 31         [ 4] 2789 	call	_delay_s
                                   2790 ;	main.c: 47: menu_set_paragraph(settings);
      0091EA A6 05            [ 1] 2791 	ld	a, #0x05
      0091EC CD 8E BD         [ 4] 2792 	call	_menu_set_paragraph
                                   2793 ;	main.c: 48: delay_s(1);
      0091EF A6 01            [ 1] 2794 	ld	a, #0x01
      0091F1 CD 86 31         [ 4] 2795 	call	_delay_s
                                   2796 ;	main.c: 54: menu_set_paragraph(color);
      0091F4 A6 04            [ 1] 2797 	ld	a, #0x04
      0091F6 CD 8E BD         [ 4] 2798 	call	_menu_set_paragraph
                                   2799 ;	main.c: 55: delay_s(1);
      0091F9 A6 01            [ 1] 2800 	ld	a, #0x01
                                   2801 ;	main.c: 58: }
      0091FB CC 86 31         [ 2] 2802 	jp	_delay_s
                                   2803 ;	main.c: 60: int main(void)
                                   2804 ;	-----------------------------------------
                                   2805 ;	 function main
                                   2806 ;	-----------------------------------------
      0091FE                       2807 _main:
                                   2808 ;	main.c: 62: setup();
      0091FE CD 91 A4         [ 4] 2809 	call	_setup
                                   2810 ;	main.c: 63: gg();
      009201 CD 91 CD         [ 4] 2811 	call	_gg
                                   2812 ;	main.c: 64: while(1)
      009204                       2813 00102$:
                                   2814 ;	main.c: 66: uart_write_byte(adc_read());
      009204 CD 91 5A         [ 4] 2815 	call	_adc_read
      009207 9F               [ 1] 2816 	ld	a, xl
      009208 CD 85 B8         [ 4] 2817 	call	_uart_write_byte
                                   2818 ;	main.c: 67: delay_s(1);
      00920B A6 01            [ 1] 2819 	ld	a, #0x01
      00920D CD 86 31         [ 4] 2820 	call	_delay_s
      009210 20 F2            [ 2] 2821 	jra	00102$
                                   2822 ;	main.c: 71: }
      009212 81               [ 4] 2823 	ret
                                   2824 	.area CODE
                                   2825 	.area CONST
                                   2826 	.area INITIALIZER
      0080BD                       2827 __xinit__ttf_rus_1:
      0080BD 00                    2828 	.db #0x00	; 0
      0080BE 44                    2829 	.db #0x44	; 68	'D'
      0080BF 44                    2830 	.db #0x44	; 68	'D'
      0080C0 44                    2831 	.db #0x44	; 68	'D'
      0080C1 44                    2832 	.db #0x44	; 68	'D'
      0080C2 7E                    2833 	.db #0x7e	; 126
      0080C3 02                    2834 	.db #0x02	; 2
      0080C4 00                    2835 	.db #0x00	; 0
      0080C5                       2836 __xinit__ttf_rus_2:
      0080C5 00                    2837 	.db #0x00	; 0
      0080C6 7C                    2838 	.db #0x7c	; 124
      0080C7 42                    2839 	.db #0x42	; 66	'B'
      0080C8 7C                    2840 	.db #0x7c	; 124
      0080C9 42                    2841 	.db #0x42	; 66	'B'
      0080CA 42                    2842 	.db #0x42	; 66	'B'
      0080CB 7C                    2843 	.db #0x7c	; 124
      0080CC 00                    2844 	.db #0x00	; 0
      0080CD                       2845 __xinit__ttf_rus_3:
      0080CD 00                    2846 	.db #0x00	; 0
      0080CE 7E                    2847 	.db #0x7e	; 126
      0080CF 40                    2848 	.db #0x40	; 64
      0080D0 40                    2849 	.db #0x40	; 64
      0080D1 7C                    2850 	.db #0x7c	; 124
      0080D2 40                    2851 	.db #0x40	; 64
      0080D3 7E                    2852 	.db #0x7e	; 126
      0080D4 00                    2853 	.db #0x00	; 0
      0080D5                       2854 __xinit__ttf_rus_4:
      0080D5 00                    2855 	.db #0x00	; 0
      0080D6 7E                    2856 	.db #0x7e	; 126
      0080D7 18                    2857 	.db #0x18	; 24
      0080D8 18                    2858 	.db #0x18	; 24
      0080D9 18                    2859 	.db #0x18	; 24
      0080DA 18                    2860 	.db #0x18	; 24
      0080DB 18                    2861 	.db #0x18	; 24
      0080DC 00                    2862 	.db #0x00	; 0
      0080DD                       2863 __xinit__ttf_rus_5:
      0080DD 00                    2864 	.db #0x00	; 0
      0080DE 7E                    2865 	.db #0x7e	; 126
      0080DF 42                    2866 	.db #0x42	; 66	'B'
      0080E0 42                    2867 	.db #0x42	; 66	'B'
      0080E1 7E                    2868 	.db #0x7e	; 126
      0080E2 42                    2869 	.db #0x42	; 66	'B'
      0080E3 42                    2870 	.db #0x42	; 66	'B'
      0080E4 00                    2871 	.db #0x00	; 0
      0080E5                       2872 __xinit__ttf_rus_6:
      0080E5 00                    2873 	.db #0x00	; 0
      0080E6 7E                    2874 	.db #0x7e	; 126
      0080E7 40                    2875 	.db #0x40	; 64
      0080E8 40                    2876 	.db #0x40	; 64
      0080E9 40                    2877 	.db #0x40	; 64
      0080EA 40                    2878 	.db #0x40	; 64
      0080EB 7E                    2879 	.db #0x7e	; 126
      0080EC 00                    2880 	.db #0x00	; 0
      0080ED                       2881 __xinit__ttf_rus_7:
      0080ED 00                    2882 	.db #0x00	; 0
      0080EE 7E                    2883 	.db #0x7e	; 126
      0080EF 40                    2884 	.db #0x40	; 64
      0080F0 40                    2885 	.db #0x40	; 64
      0080F1 40                    2886 	.db #0x40	; 64
      0080F2 40                    2887 	.db #0x40	; 64
      0080F3 40                    2888 	.db #0x40	; 64
      0080F4 00                    2889 	.db #0x00	; 0
      0080F5                       2890 __xinit__ttf_rus_8:
      0080F5 00                    2891 	.db #0x00	; 0
      0080F6 42                    2892 	.db #0x42	; 66	'B'
      0080F7 66                    2893 	.db #0x66	; 102	'f'
      0080F8 5A                    2894 	.db #0x5a	; 90	'Z'
      0080F9 42                    2895 	.db #0x42	; 66	'B'
      0080FA 42                    2896 	.db #0x42	; 66	'B'
      0080FB 42                    2897 	.db #0x42	; 66	'B'
      0080FC 00                    2898 	.db #0x00	; 0
      0080FD                       2899 __xinit__ttf_rus_9:
      0080FD 00                    2900 	.db #0x00	; 0
      0080FE 42                    2901 	.db #0x42	; 66	'B'
      0080FF 42                    2902 	.db #0x42	; 66	'B'
      008100 42                    2903 	.db #0x42	; 66	'B'
      008101 7E                    2904 	.db #0x7e	; 126
      008102 42                    2905 	.db #0x42	; 66	'B'
      008103 42                    2906 	.db #0x42	; 66	'B'
      008104 00                    2907 	.db #0x00	; 0
      008105                       2908 __xinit__ttf_rus_10:
      008105 00                    2909 	.db #0x00	; 0
      008106 7E                    2910 	.db #0x7e	; 126
      008107 42                    2911 	.db #0x42	; 66	'B'
      008108 42                    2912 	.db #0x42	; 66	'B'
      008109 42                    2913 	.db #0x42	; 66	'B'
      00810A 42                    2914 	.db #0x42	; 66	'B'
      00810B 7E                    2915 	.db #0x7e	; 126
      00810C 00                    2916 	.db #0x00	; 0
      00810D                       2917 __xinit__ttf_rus_11:
      00810D 00                    2918 	.db #0x00	; 0
      00810E 7E                    2919 	.db #0x7e	; 126
      00810F 42                    2920 	.db #0x42	; 66	'B'
      008110 42                    2921 	.db #0x42	; 66	'B'
      008111 42                    2922 	.db #0x42	; 66	'B'
      008112 42                    2923 	.db #0x42	; 66	'B'
      008113 42                    2924 	.db #0x42	; 66	'B'
      008114 00                    2925 	.db #0x00	; 0
      008115                       2926 __xinit__ttf_rus_12:
      008115 00                    2927 	.db #0x00	; 0
      008116 42                    2928 	.db #0x42	; 66	'B'
      008117 46                    2929 	.db #0x46	; 70	'F'
      008118 4A                    2930 	.db #0x4a	; 74	'J'
      008119 52                    2931 	.db #0x52	; 82	'R'
      00811A 62                    2932 	.db #0x62	; 98	'b'
      00811B 42                    2933 	.db #0x42	; 66	'B'
      00811C 00                    2934 	.db #0x00	; 0
      00811D                       2935 __xinit__ttf_rus_13:
      00811D 00                    2936 	.db #0x00	; 0
      00811E 66                    2937 	.db #0x66	; 102	'f'
      00811F 68                    2938 	.db #0x68	; 104	'h'
      008120 70                    2939 	.db #0x70	; 112	'p'
      008121 70                    2940 	.db #0x70	; 112	'p'
      008122 68                    2941 	.db #0x68	; 104	'h'
      008123 66                    2942 	.db #0x66	; 102	'f'
      008124 00                    2943 	.db #0x00	; 0
      008125                       2944 __xinit__ttf_rus_14:
      008125 00                    2945 	.db #0x00	; 0
      008126 7E                    2946 	.db #0x7e	; 126
      008127 42                    2947 	.db #0x42	; 66	'B'
      008128 42                    2948 	.db #0x42	; 66	'B'
      008129 7E                    2949 	.db #0x7e	; 126
      00812A 40                    2950 	.db #0x40	; 64
      00812B 40                    2951 	.db #0x40	; 64
      00812C 00                    2952 	.db #0x00	; 0
      00812D                       2953 __xinit__ttf_rus_15:
      00812D 00                    2954 	.db #0x00	; 0
      00812E 42                    2955 	.db #0x42	; 66	'B'
      00812F 42                    2956 	.db #0x42	; 66	'B'
      008130 42                    2957 	.db #0x42	; 66	'B'
      008131 7A                    2958 	.db #0x7a	; 122	'z'
      008132 4A                    2959 	.db #0x4a	; 74	'J'
      008133 7A                    2960 	.db #0x7a	; 122	'z'
      008134 00                    2961 	.db #0x00	; 0
      008135                       2962 __xinit__ttf_rus_16:
      008135 00                    2963 	.db #0x00	; 0
      008136 18                    2964 	.db #0x18	; 24
      008137 42                    2965 	.db #0x42	; 66	'B'
      008138 46                    2966 	.db #0x46	; 70	'F'
      008139 4A                    2967 	.db #0x4a	; 74	'J'
      00813A 52                    2968 	.db #0x52	; 82	'R'
      00813B 62                    2969 	.db #0x62	; 98	'b'
      00813C 00                    2970 	.db #0x00	; 0
      00813D                       2971 __xinit__ttf_rus_17:
      00813D 00                    2972 	.db #0x00	; 0
      00813E 7E                    2973 	.db #0x7e	; 126
      00813F 02                    2974 	.db #0x02	; 2
      008140 3C                    2975 	.db #0x3c	; 60
      008141 02                    2976 	.db #0x02	; 2
      008142 02                    2977 	.db #0x02	; 2
      008143 7E                    2978 	.db #0x7e	; 126
      008144 00                    2979 	.db #0x00	; 0
      008145                       2980 __xinit__ttf_rus_18:
      008145 00                    2981 	.db #0x00	; 0
      008146 1E                    2982 	.db #0x1e	; 30
      008147 22                    2983 	.db #0x22	; 34
      008148 22                    2984 	.db #0x22	; 34
      008149 22                    2985 	.db #0x22	; 34
      00814A 22                    2986 	.db #0x22	; 34
      00814B 42                    2987 	.db #0x42	; 66	'B'
      00814C 00                    2988 	.db #0x00	; 0
      00814D                       2989 __xinit__ttf_rus_19:
      00814D 00                    2990 	.db #0x00	; 0
      00814E 40                    2991 	.db #0x40	; 64
      00814F 40                    2992 	.db #0x40	; 64
      008150 7E                    2993 	.db #0x7e	; 126
      008151 42                    2994 	.db #0x42	; 66	'B'
      008152 42                    2995 	.db #0x42	; 66	'B'
      008153 7E                    2996 	.db #0x7e	; 126
      008154 00                    2997 	.db #0x00	; 0
      008155                       2998 __xinit__ttf_rus_20:
      008155 00                    2999 	.db #0x00	; 0
      008156 5E                    3000 	.db #0x5e	; 94
      008157 52                    3001 	.db #0x52	; 82	'R'
      008158 72                    3002 	.db #0x72	; 114	'r'
      008159 52                    3003 	.db #0x52	; 82	'R'
      00815A 52                    3004 	.db #0x52	; 82	'R'
      00815B 5E                    3005 	.db #0x5e	; 94
      00815C 00                    3006 	.db #0x00	; 0
      00815D                       3007 __xinit__TIM2_IRQ:
      00815D 00                    3008 	.db #0x00	; 0
      00815E                       3009 __xinit__I2C_IRQ:
      00815E 00                    3010 	.db #0x00	; 0
      00815F                       3011 __xinit__ttf_void:
      00815F 00                    3012 	.db #0x00	; 0
      008160 00                    3013 	.db #0x00	; 0
      008161 00                    3014 	.db #0x00	; 0
      008162 00                    3015 	.db #0x00	; 0
      008163 00                    3016 	.db #0x00	; 0
      008164 00                    3017 	.db #0x00	; 0
      008165 00                    3018 	.db #0x00	; 0
      008166 00                    3019 	.db #0x00	; 0
      008167                       3020 __xinit__ttf_num_1:
      008167 00                    3021 	.db #0x00	; 0
      008168 18                    3022 	.db #0x18	; 24
      008169 38                    3023 	.db #0x38	; 56	'8'
      00816A 38                    3024 	.db #0x38	; 56	'8'
      00816B 18                    3025 	.db #0x18	; 24
      00816C 18                    3026 	.db #0x18	; 24
      00816D 18                    3027 	.db #0x18	; 24
      00816E 00                    3028 	.db #0x00	; 0
      00816F                       3029 __xinit__ttf_num_2:
      00816F 00                    3030 	.db #0x00	; 0
      008170 38                    3031 	.db #0x38	; 56	'8'
      008171 44                    3032 	.db #0x44	; 68	'D'
      008172 08                    3033 	.db #0x08	; 8
      008173 10                    3034 	.db #0x10	; 16
      008174 20                    3035 	.db #0x20	; 32
      008175 7C                    3036 	.db #0x7c	; 124
      008176 00                    3037 	.db #0x00	; 0
      008177                       3038 __xinit__ttf_num_3:
      008177 00                    3039 	.db #0x00	; 0
      008178 7C                    3040 	.db #0x7c	; 124
      008179 02                    3041 	.db #0x02	; 2
      00817A 3C                    3042 	.db #0x3c	; 60
      00817B 02                    3043 	.db #0x02	; 2
      00817C 02                    3044 	.db #0x02	; 2
      00817D 7C                    3045 	.db #0x7c	; 124
      00817E 00                    3046 	.db #0x00	; 0
      00817F                       3047 __xinit__ttf_num_4:
      00817F 00                    3048 	.db #0x00	; 0
      008180 42                    3049 	.db #0x42	; 66	'B'
      008181 42                    3050 	.db #0x42	; 66	'B'
      008182 7E                    3051 	.db #0x7e	; 126
      008183 02                    3052 	.db #0x02	; 2
      008184 02                    3053 	.db #0x02	; 2
      008185 02                    3054 	.db #0x02	; 2
      008186 00                    3055 	.db #0x00	; 0
      008187                       3056 __xinit__ttf_num_5:
      008187 00                    3057 	.db #0x00	; 0
      008188 7E                    3058 	.db #0x7e	; 126
      008189 40                    3059 	.db #0x40	; 64
      00818A 7C                    3060 	.db #0x7c	; 124
      00818B 02                    3061 	.db #0x02	; 2
      00818C 02                    3062 	.db #0x02	; 2
      00818D 7C                    3063 	.db #0x7c	; 124
      00818E 00                    3064 	.db #0x00	; 0
      00818F                       3065 __xinit__ttf_num_6:
      00818F 00                    3066 	.db #0x00	; 0
      008190 3C                    3067 	.db #0x3c	; 60
      008191 40                    3068 	.db #0x40	; 64
      008192 7C                    3069 	.db #0x7c	; 124
      008193 42                    3070 	.db #0x42	; 66	'B'
      008194 42                    3071 	.db #0x42	; 66	'B'
      008195 3C                    3072 	.db #0x3c	; 60
      008196 00                    3073 	.db #0x00	; 0
      008197                       3074 __xinit__ttf_num_7:
      008197 00                    3075 	.db #0x00	; 0
      008198 7E                    3076 	.db #0x7e	; 126
      008199 02                    3077 	.db #0x02	; 2
      00819A 04                    3078 	.db #0x04	; 4
      00819B 08                    3079 	.db #0x08	; 8
      00819C 10                    3080 	.db #0x10	; 16
      00819D 20                    3081 	.db #0x20	; 32
      00819E 00                    3082 	.db #0x00	; 0
      00819F                       3083 __xinit__ttf_num_8:
      00819F 00                    3084 	.db #0x00	; 0
      0081A0 3C                    3085 	.db #0x3c	; 60
      0081A1 42                    3086 	.db #0x42	; 66	'B'
      0081A2 3C                    3087 	.db #0x3c	; 60
      0081A3 42                    3088 	.db #0x42	; 66	'B'
      0081A4 42                    3089 	.db #0x42	; 66	'B'
      0081A5 3C                    3090 	.db #0x3c	; 60
      0081A6 00                    3091 	.db #0x00	; 0
      0081A7                       3092 __xinit__ttf_num_9:
      0081A7 00                    3093 	.db #0x00	; 0
      0081A8 3C                    3094 	.db #0x3c	; 60
      0081A9 42                    3095 	.db #0x42	; 66	'B'
      0081AA 42                    3096 	.db #0x42	; 66	'B'
      0081AB 3E                    3097 	.db #0x3e	; 62
      0081AC 02                    3098 	.db #0x02	; 2
      0081AD 3C                    3099 	.db #0x3c	; 60
      0081AE 00                    3100 	.db #0x00	; 0
      0081AF                       3101 __xinit__ttf_num_0:
      0081AF 00                    3102 	.db #0x00	; 0
      0081B0 3C                    3103 	.db #0x3c	; 60
      0081B1 46                    3104 	.db #0x46	; 70	'F'
      0081B2 4A                    3105 	.db #0x4a	; 74	'J'
      0081B3 52                    3106 	.db #0x52	; 82	'R'
      0081B4 62                    3107 	.db #0x62	; 98	'b'
      0081B5 3C                    3108 	.db #0x3c	; 60
      0081B6 00                    3109 	.db #0x00	; 0
      0081B7                       3110 __xinit__ttf_corner_left_up:
      0081B7 FF                    3111 	.db #0xff	; 255
      0081B8 FF                    3112 	.db #0xff	; 255
      0081B9 C0                    3113 	.db #0xc0	; 192
      0081BA C0                    3114 	.db #0xc0	; 192
      0081BB C0                    3115 	.db #0xc0	; 192
      0081BC C0                    3116 	.db #0xc0	; 192
      0081BD C0                    3117 	.db #0xc0	; 192
      0081BE C0                    3118 	.db #0xc0	; 192
      0081BF                       3119 __xinit__ttf_corner_right_up:
      0081BF FF                    3120 	.db #0xff	; 255
      0081C0 FF                    3121 	.db #0xff	; 255
      0081C1 03                    3122 	.db #0x03	; 3
      0081C2 03                    3123 	.db #0x03	; 3
      0081C3 03                    3124 	.db #0x03	; 3
      0081C4 03                    3125 	.db #0x03	; 3
      0081C5 03                    3126 	.db #0x03	; 3
      0081C6 03                    3127 	.db #0x03	; 3
      0081C7                       3128 __xinit__ttf_corner_left_down:
      0081C7 C0                    3129 	.db #0xc0	; 192
      0081C8 C0                    3130 	.db #0xc0	; 192
      0081C9 C0                    3131 	.db #0xc0	; 192
      0081CA C0                    3132 	.db #0xc0	; 192
      0081CB C0                    3133 	.db #0xc0	; 192
      0081CC C0                    3134 	.db #0xc0	; 192
      0081CD FF                    3135 	.db #0xff	; 255
      0081CE FF                    3136 	.db #0xff	; 255
      0081CF                       3137 __xinit__ttf_corner_right_down:
      0081CF 03                    3138 	.db #0x03	; 3
      0081D0 03                    3139 	.db #0x03	; 3
      0081D1 03                    3140 	.db #0x03	; 3
      0081D2 03                    3141 	.db #0x03	; 3
      0081D3 03                    3142 	.db #0x03	; 3
      0081D4 03                    3143 	.db #0x03	; 3
      0081D5 FF                    3144 	.db #0xff	; 255
      0081D6 FF                    3145 	.db #0xff	; 255
      0081D7                       3146 __xinit__ttf_line_right:
      0081D7 03                    3147 	.db #0x03	; 3
      0081D8 03                    3148 	.db #0x03	; 3
      0081D9 03                    3149 	.db #0x03	; 3
      0081DA 03                    3150 	.db #0x03	; 3
      0081DB 03                    3151 	.db #0x03	; 3
      0081DC 03                    3152 	.db #0x03	; 3
      0081DD 03                    3153 	.db #0x03	; 3
      0081DE 03                    3154 	.db #0x03	; 3
      0081DF                       3155 __xinit__ttf_line_left:
      0081DF C0                    3156 	.db #0xc0	; 192
      0081E0 C0                    3157 	.db #0xc0	; 192
      0081E1 C0                    3158 	.db #0xc0	; 192
      0081E2 C0                    3159 	.db #0xc0	; 192
      0081E3 C0                    3160 	.db #0xc0	; 192
      0081E4 C0                    3161 	.db #0xc0	; 192
      0081E5 C0                    3162 	.db #0xc0	; 192
      0081E6 C0                    3163 	.db #0xc0	; 192
      0081E7                       3164 __xinit__ttf_line_up:
      0081E7 FF                    3165 	.db #0xff	; 255
      0081E8 FF                    3166 	.db #0xff	; 255
      0081E9 00                    3167 	.db #0x00	; 0
      0081EA 00                    3168 	.db #0x00	; 0
      0081EB 00                    3169 	.db #0x00	; 0
      0081EC 00                    3170 	.db #0x00	; 0
      0081ED 00                    3171 	.db #0x00	; 0
      0081EE 00                    3172 	.db #0x00	; 0
      0081EF                       3173 __xinit__ttf_line_down:
      0081EF 00                    3174 	.db #0x00	; 0
      0081F0 00                    3175 	.db #0x00	; 0
      0081F1 00                    3176 	.db #0x00	; 0
      0081F2 00                    3177 	.db #0x00	; 0
      0081F3 00                    3178 	.db #0x00	; 0
      0081F4 00                    3179 	.db #0x00	; 0
      0081F5 FF                    3180 	.db #0xff	; 255
      0081F6 FF                    3181 	.db #0xff	; 255
      0081F7                       3182 __xinit__main_buffer:
      0081F7 FF                    3183 	.db #0xff	; 255
      0081F8 01                    3184 	.db #0x01	; 1
      0081F9 01                    3185 	.db #0x01	; 1
      0081FA 01                    3186 	.db #0x01	; 1
      0081FB 01                    3187 	.db #0x01	; 1
      0081FC 01                    3188 	.db #0x01	; 1
      0081FD 01                    3189 	.db #0x01	; 1
      0081FE 01                    3190 	.db #0x01	; 1
      0081FF FD                    3191 	.db #0xfd	; 253
      008200 FD                    3192 	.db #0xfd	; 253
      008201 FD                    3193 	.db #0xfd	; 253
      008202 FD                    3194 	.db #0xfd	; 253
      008203 FD                    3195 	.db #0xfd	; 253
      008204 FD                    3196 	.db #0xfd	; 253
      008205 FD                    3197 	.db #0xfd	; 253
      008206 01                    3198 	.db #0x01	; 1
      008207 01                    3199 	.db #0x01	; 1
      008208 01                    3200 	.db #0x01	; 1
      008209 01                    3201 	.db #0x01	; 1
      00820A 01                    3202 	.db #0x01	; 1
      00820B 01                    3203 	.db #0x01	; 1
      00820C 01                    3204 	.db #0x01	; 1
      00820D FD                    3205 	.db #0xfd	; 253
      00820E FD                    3206 	.db #0xfd	; 253
      00820F FD                    3207 	.db #0xfd	; 253
      008210 FD                    3208 	.db #0xfd	; 253
      008211 FD                    3209 	.db #0xfd	; 253
      008212 FD                    3210 	.db #0xfd	; 253
      008213 FD                    3211 	.db #0xfd	; 253
      008214 FD                    3212 	.db #0xfd	; 253
      008215 FD                    3213 	.db #0xfd	; 253
      008216 FD                    3214 	.db #0xfd	; 253
      008217 FD                    3215 	.db #0xfd	; 253
      008218 FD                    3216 	.db #0xfd	; 253
      008219 FD                    3217 	.db #0xfd	; 253
      00821A FD                    3218 	.db #0xfd	; 253
      00821B FD                    3219 	.db #0xfd	; 253
      00821C FD                    3220 	.db #0xfd	; 253
      00821D FD                    3221 	.db #0xfd	; 253
      00821E FD                    3222 	.db #0xfd	; 253
      00821F FD                    3223 	.db #0xfd	; 253
      008220 FD                    3224 	.db #0xfd	; 253
      008221 FD                    3225 	.db #0xfd	; 253
      008222 FD                    3226 	.db #0xfd	; 253
      008223 FD                    3227 	.db #0xfd	; 253
      008224 FD                    3228 	.db #0xfd	; 253
      008225 FD                    3229 	.db #0xfd	; 253
      008226 FD                    3230 	.db #0xfd	; 253
      008227 FD                    3231 	.db #0xfd	; 253
      008228 FD                    3232 	.db #0xfd	; 253
      008229 FD                    3233 	.db #0xfd	; 253
      00822A FD                    3234 	.db #0xfd	; 253
      00822B FD                    3235 	.db #0xfd	; 253
      00822C FD                    3236 	.db #0xfd	; 253
      00822D FD                    3237 	.db #0xfd	; 253
      00822E FD                    3238 	.db #0xfd	; 253
      00822F FD                    3239 	.db #0xfd	; 253
      008230 01                    3240 	.db #0x01	; 1
      008231 01                    3241 	.db #0x01	; 1
      008232 01                    3242 	.db #0x01	; 1
      008233 01                    3243 	.db #0x01	; 1
      008234 01                    3244 	.db #0x01	; 1
      008235 01                    3245 	.db #0x01	; 1
      008236 01                    3246 	.db #0x01	; 1
      008237 FD                    3247 	.db #0xfd	; 253
      008238 FD                    3248 	.db #0xfd	; 253
      008239 FD                    3249 	.db #0xfd	; 253
      00823A FD                    3250 	.db #0xfd	; 253
      00823B FD                    3251 	.db #0xfd	; 253
      00823C FD                    3252 	.db #0xfd	; 253
      00823D FD                    3253 	.db #0xfd	; 253
      00823E FD                    3254 	.db #0xfd	; 253
      00823F FD                    3255 	.db #0xfd	; 253
      008240 FD                    3256 	.db #0xfd	; 253
      008241 FD                    3257 	.db #0xfd	; 253
      008242 FD                    3258 	.db #0xfd	; 253
      008243 FD                    3259 	.db #0xfd	; 253
      008244 FD                    3260 	.db #0xfd	; 253
      008245 FD                    3261 	.db #0xfd	; 253
      008246 FD                    3262 	.db #0xfd	; 253
      008247 FD                    3263 	.db #0xfd	; 253
      008248 FD                    3264 	.db #0xfd	; 253
      008249 FD                    3265 	.db #0xfd	; 253
      00824A FD                    3266 	.db #0xfd	; 253
      00824B FD                    3267 	.db #0xfd	; 253
      00824C 01                    3268 	.db #0x01	; 1
      00824D 01                    3269 	.db #0x01	; 1
      00824E 01                    3270 	.db #0x01	; 1
      00824F 01                    3271 	.db #0x01	; 1
      008250 01                    3272 	.db #0x01	; 1
      008251 01                    3273 	.db #0x01	; 1
      008252 01                    3274 	.db #0x01	; 1
      008253 01                    3275 	.db #0x01	; 1
      008254 01                    3276 	.db #0x01	; 1
      008255 01                    3277 	.db #0x01	; 1
      008256 01                    3278 	.db #0x01	; 1
      008257 01                    3279 	.db #0x01	; 1
      008258 01                    3280 	.db #0x01	; 1
      008259 01                    3281 	.db #0x01	; 1
      00825A 3D                    3282 	.db #0x3d	; 61
      00825B 15                    3283 	.db #0x15	; 21
      00825C 3D                    3284 	.db #0x3d	; 61
      00825D 01                    3285 	.db #0x01	; 1
      00825E 3D                    3286 	.db #0x3d	; 61
      00825F 21                    3287 	.db #0x21	; 33
      008260 21                    3288 	.db #0x21	; 33
      008261 01                    3289 	.db #0x01	; 1
      008262 3D                    3290 	.db #0x3d	; 61
      008263 15                    3291 	.db #0x15	; 21
      008264 1D                    3292 	.db #0x1d	; 29
      008265 01                    3293 	.db #0x01	; 1
      008266 3D                    3294 	.db #0x3d	; 61
      008267 11                    3295 	.db #0x11	; 17
      008268 3D                    3296 	.db #0x3d	; 61
      008269 01                    3297 	.db #0x01	; 1
      00826A 3D                    3298 	.db #0x3d	; 61
      00826B 15                    3299 	.db #0x15	; 21
      00826C 3D                    3300 	.db #0x3d	; 61
      00826D 01                    3301 	.db #0x01	; 1
      00826E 01                    3302 	.db #0x01	; 1
      00826F 3D                    3303 	.db #0x3d	; 61
      008270 25                    3304 	.db #0x25	; 37
      008271 3D                    3305 	.db #0x3d	; 61
      008272 01                    3306 	.db #0x01	; 1
      008273 05                    3307 	.db #0x05	; 5
      008274 3D                    3308 	.db #0x3d	; 61
      008275 01                    3309 	.db #0x01	; 1
      008276 FF                    3310 	.db #0xff	; 255
      008277 FF                    3311 	.db #0xff	; 255
      008278 00                    3312 	.db #0x00	; 0
      008279 00                    3313 	.db #0x00	; 0
      00827A 00                    3314 	.db #0x00	; 0
      00827B 00                    3315 	.db #0x00	; 0
      00827C 00                    3316 	.db #0x00	; 0
      00827D 00                    3317 	.db #0x00	; 0
      00827E 00                    3318 	.db #0x00	; 0
      00827F FF                    3319 	.db #0xff	; 255
      008280 FF                    3320 	.db #0xff	; 255
      008281 FF                    3321 	.db #0xff	; 255
      008282 FF                    3322 	.db #0xff	; 255
      008283 FF                    3323 	.db #0xff	; 255
      008284 FF                    3324 	.db #0xff	; 255
      008285 FF                    3325 	.db #0xff	; 255
      008286 FE                    3326 	.db #0xfe	; 254
      008287 FE                    3327 	.db #0xfe	; 254
      008288 FE                    3328 	.db #0xfe	; 254
      008289 FE                    3329 	.db #0xfe	; 254
      00828A FE                    3330 	.db #0xfe	; 254
      00828B FE                    3331 	.db #0xfe	; 254
      00828C FE                    3332 	.db #0xfe	; 254
      00828D FF                    3333 	.db #0xff	; 255
      00828E FF                    3334 	.db #0xff	; 255
      00828F FF                    3335 	.db #0xff	; 255
      008290 FF                    3336 	.db #0xff	; 255
      008291 FF                    3337 	.db #0xff	; 255
      008292 FF                    3338 	.db #0xff	; 255
      008293 FF                    3339 	.db #0xff	; 255
      008294 01                    3340 	.db #0x01	; 1
      008295 01                    3341 	.db #0x01	; 1
      008296 01                    3342 	.db #0x01	; 1
      008297 01                    3343 	.db #0x01	; 1
      008298 01                    3344 	.db #0x01	; 1
      008299 01                    3345 	.db #0x01	; 1
      00829A 01                    3346 	.db #0x01	; 1
      00829B FF                    3347 	.db #0xff	; 255
      00829C FF                    3348 	.db #0xff	; 255
      00829D FF                    3349 	.db #0xff	; 255
      00829E FF                    3350 	.db #0xff	; 255
      00829F FF                    3351 	.db #0xff	; 255
      0082A0 FF                    3352 	.db #0xff	; 255
      0082A1 FF                    3353 	.db #0xff	; 255
      0082A2 01                    3354 	.db #0x01	; 1
      0082A3 01                    3355 	.db #0x01	; 1
      0082A4 01                    3356 	.db #0x01	; 1
      0082A5 01                    3357 	.db #0x01	; 1
      0082A6 01                    3358 	.db #0x01	; 1
      0082A7 01                    3359 	.db #0x01	; 1
      0082A8 01                    3360 	.db #0x01	; 1
      0082A9 FF                    3361 	.db #0xff	; 255
      0082AA FF                    3362 	.db #0xff	; 255
      0082AB FF                    3363 	.db #0xff	; 255
      0082AC FF                    3364 	.db #0xff	; 255
      0082AD FF                    3365 	.db #0xff	; 255
      0082AE FF                    3366 	.db #0xff	; 255
      0082AF FF                    3367 	.db #0xff	; 255
      0082B0 00                    3368 	.db #0x00	; 0
      0082B1 00                    3369 	.db #0x00	; 0
      0082B2 00                    3370 	.db #0x00	; 0
      0082B3 00                    3371 	.db #0x00	; 0
      0082B4 00                    3372 	.db #0x00	; 0
      0082B5 00                    3373 	.db #0x00	; 0
      0082B6 00                    3374 	.db #0x00	; 0
      0082B7 FF                    3375 	.db #0xff	; 255
      0082B8 FF                    3376 	.db #0xff	; 255
      0082B9 FF                    3377 	.db #0xff	; 255
      0082BA FF                    3378 	.db #0xff	; 255
      0082BB FF                    3379 	.db #0xff	; 255
      0082BC FF                    3380 	.db #0xff	; 255
      0082BD FF                    3381 	.db #0xff	; 255
      0082BE 01                    3382 	.db #0x01	; 1
      0082BF 01                    3383 	.db #0x01	; 1
      0082C0 01                    3384 	.db #0x01	; 1
      0082C1 01                    3385 	.db #0x01	; 1
      0082C2 01                    3386 	.db #0x01	; 1
      0082C3 01                    3387 	.db #0x01	; 1
      0082C4 01                    3388 	.db #0x01	; 1
      0082C5 FF                    3389 	.db #0xff	; 255
      0082C6 FF                    3390 	.db #0xff	; 255
      0082C7 FF                    3391 	.db #0xff	; 255
      0082C8 FF                    3392 	.db #0xff	; 255
      0082C9 FF                    3393 	.db #0xff	; 255
      0082CA FF                    3394 	.db #0xff	; 255
      0082CB FF                    3395 	.db #0xff	; 255
      0082CC 00                    3396 	.db #0x00	; 0
      0082CD 00                    3397 	.db #0x00	; 0
      0082CE 00                    3398 	.db #0x00	; 0
      0082CF 00                    3399 	.db #0x00	; 0
      0082D0 00                    3400 	.db #0x00	; 0
      0082D1 00                    3401 	.db #0x00	; 0
      0082D2 00                    3402 	.db #0x00	; 0
      0082D3 00                    3403 	.db #0x00	; 0
      0082D4 00                    3404 	.db #0x00	; 0
      0082D5 00                    3405 	.db #0x00	; 0
      0082D6 00                    3406 	.db #0x00	; 0
      0082D7 00                    3407 	.db #0x00	; 0
      0082D8 00                    3408 	.db #0x00	; 0
      0082D9 00                    3409 	.db #0x00	; 0
      0082DA 00                    3410 	.db #0x00	; 0
      0082DB 00                    3411 	.db #0x00	; 0
      0082DC 00                    3412 	.db #0x00	; 0
      0082DD 00                    3413 	.db #0x00	; 0
      0082DE 00                    3414 	.db #0x00	; 0
      0082DF 00                    3415 	.db #0x00	; 0
      0082E0 00                    3416 	.db #0x00	; 0
      0082E1 00                    3417 	.db #0x00	; 0
      0082E2 00                    3418 	.db #0x00	; 0
      0082E3 00                    3419 	.db #0x00	; 0
      0082E4 00                    3420 	.db #0x00	; 0
      0082E5 00                    3421 	.db #0x00	; 0
      0082E6 00                    3422 	.db #0x00	; 0
      0082E7 00                    3423 	.db #0x00	; 0
      0082E8 00                    3424 	.db #0x00	; 0
      0082E9 00                    3425 	.db #0x00	; 0
      0082EA 00                    3426 	.db #0x00	; 0
      0082EB 00                    3427 	.db #0x00	; 0
      0082EC 00                    3428 	.db #0x00	; 0
      0082ED 00                    3429 	.db #0x00	; 0
      0082EE 00                    3430 	.db #0x00	; 0
      0082EF 00                    3431 	.db #0x00	; 0
      0082F0 00                    3432 	.db #0x00	; 0
      0082F1 00                    3433 	.db #0x00	; 0
      0082F2 00                    3434 	.db #0x00	; 0
      0082F3 00                    3435 	.db #0x00	; 0
      0082F4 00                    3436 	.db #0x00	; 0
      0082F5 00                    3437 	.db #0x00	; 0
      0082F6 FF                    3438 	.db #0xff	; 255
      0082F7 FF                    3439 	.db #0xff	; 255
      0082F8 00                    3440 	.db #0x00	; 0
      0082F9 00                    3441 	.db #0x00	; 0
      0082FA 00                    3442 	.db #0x00	; 0
      0082FB 00                    3443 	.db #0x00	; 0
      0082FC 00                    3444 	.db #0x00	; 0
      0082FD 00                    3445 	.db #0x00	; 0
      0082FE 00                    3446 	.db #0x00	; 0
      0082FF FF                    3447 	.db #0xff	; 255
      008300 FF                    3448 	.db #0xff	; 255
      008301 FF                    3449 	.db #0xff	; 255
      008302 FF                    3450 	.db #0xff	; 255
      008303 FF                    3451 	.db #0xff	; 255
      008304 FF                    3452 	.db #0xff	; 255
      008305 FF                    3453 	.db #0xff	; 255
      008306 00                    3454 	.db #0x00	; 0
      008307 00                    3455 	.db #0x00	; 0
      008308 00                    3456 	.db #0x00	; 0
      008309 00                    3457 	.db #0x00	; 0
      00830A 00                    3458 	.db #0x00	; 0
      00830B 00                    3459 	.db #0x00	; 0
      00830C 00                    3460 	.db #0x00	; 0
      00830D FF                    3461 	.db #0xff	; 255
      00830E FF                    3462 	.db #0xff	; 255
      00830F FF                    3463 	.db #0xff	; 255
      008310 FF                    3464 	.db #0xff	; 255
      008311 FF                    3465 	.db #0xff	; 255
      008312 FF                    3466 	.db #0xff	; 255
      008313 FF                    3467 	.db #0xff	; 255
      008314 00                    3468 	.db #0x00	; 0
      008315 00                    3469 	.db #0x00	; 0
      008316 00                    3470 	.db #0x00	; 0
      008317 00                    3471 	.db #0x00	; 0
      008318 00                    3472 	.db #0x00	; 0
      008319 00                    3473 	.db #0x00	; 0
      00831A 00                    3474 	.db #0x00	; 0
      00831B FF                    3475 	.db #0xff	; 255
      00831C FF                    3476 	.db #0xff	; 255
      00831D FF                    3477 	.db #0xff	; 255
      00831E FF                    3478 	.db #0xff	; 255
      00831F FF                    3479 	.db #0xff	; 255
      008320 FF                    3480 	.db #0xff	; 255
      008321 FF                    3481 	.db #0xff	; 255
      008322 00                    3482 	.db #0x00	; 0
      008323 00                    3483 	.db #0x00	; 0
      008324 00                    3484 	.db #0x00	; 0
      008325 00                    3485 	.db #0x00	; 0
      008326 00                    3486 	.db #0x00	; 0
      008327 00                    3487 	.db #0x00	; 0
      008328 00                    3488 	.db #0x00	; 0
      008329 FF                    3489 	.db #0xff	; 255
      00832A FF                    3490 	.db #0xff	; 255
      00832B FF                    3491 	.db #0xff	; 255
      00832C FF                    3492 	.db #0xff	; 255
      00832D FF                    3493 	.db #0xff	; 255
      00832E FF                    3494 	.db #0xff	; 255
      00832F FF                    3495 	.db #0xff	; 255
      008330 7F                    3496 	.db #0x7f	; 127
      008331 7F                    3497 	.db #0x7f	; 127
      008332 7F                    3498 	.db #0x7f	; 127
      008333 7F                    3499 	.db #0x7f	; 127
      008334 7F                    3500 	.db #0x7f	; 127
      008335 7F                    3501 	.db #0x7f	; 127
      008336 7F                    3502 	.db #0x7f	; 127
      008337 FF                    3503 	.db #0xff	; 255
      008338 FF                    3504 	.db #0xff	; 255
      008339 FF                    3505 	.db #0xff	; 255
      00833A FF                    3506 	.db #0xff	; 255
      00833B FF                    3507 	.db #0xff	; 255
      00833C FF                    3508 	.db #0xff	; 255
      00833D FF                    3509 	.db #0xff	; 255
      00833E 7F                    3510 	.db #0x7f	; 127
      00833F 7F                    3511 	.db #0x7f	; 127
      008340 7F                    3512 	.db #0x7f	; 127
      008341 7F                    3513 	.db #0x7f	; 127
      008342 7F                    3514 	.db #0x7f	; 127
      008343 7F                    3515 	.db #0x7f	; 127
      008344 7F                    3516 	.db #0x7f	; 127
      008345 80                    3517 	.db #0x80	; 128
      008346 80                    3518 	.db #0x80	; 128
      008347 80                    3519 	.db #0x80	; 128
      008348 80                    3520 	.db #0x80	; 128
      008349 80                    3521 	.db #0x80	; 128
      00834A 80                    3522 	.db #0x80	; 128
      00834B 80                    3523 	.db #0x80	; 128
      00834C 00                    3524 	.db #0x00	; 0
      00834D 00                    3525 	.db #0x00	; 0
      00834E 00                    3526 	.db #0x00	; 0
      00834F 80                    3527 	.db #0x80	; 128
      008350 80                    3528 	.db #0x80	; 128
      008351 80                    3529 	.db #0x80	; 128
      008352 80                    3530 	.db #0x80	; 128
      008353 80                    3531 	.db #0x80	; 128
      008354 80                    3532 	.db #0x80	; 128
      008355 80                    3533 	.db #0x80	; 128
      008356 00                    3534 	.db #0x00	; 0
      008357 00                    3535 	.db #0x00	; 0
      008358 00                    3536 	.db #0x00	; 0
      008359 00                    3537 	.db #0x00	; 0
      00835A 00                    3538 	.db #0x00	; 0
      00835B 00                    3539 	.db #0x00	; 0
      00835C 00                    3540 	.db #0x00	; 0
      00835D 00                    3541 	.db #0x00	; 0
      00835E 00                    3542 	.db #0x00	; 0
      00835F 00                    3543 	.db #0x00	; 0
      008360 00                    3544 	.db #0x00	; 0
      008361 00                    3545 	.db #0x00	; 0
      008362 00                    3546 	.db #0x00	; 0
      008363 00                    3547 	.db #0x00	; 0
      008364 00                    3548 	.db #0x00	; 0
      008365 00                    3549 	.db #0x00	; 0
      008366 00                    3550 	.db #0x00	; 0
      008367 00                    3551 	.db #0x00	; 0
      008368 00                    3552 	.db #0x00	; 0
      008369 00                    3553 	.db #0x00	; 0
      00836A 00                    3554 	.db #0x00	; 0
      00836B 00                    3555 	.db #0x00	; 0
      00836C 00                    3556 	.db #0x00	; 0
      00836D 00                    3557 	.db #0x00	; 0
      00836E 00                    3558 	.db #0x00	; 0
      00836F 00                    3559 	.db #0x00	; 0
      008370 00                    3560 	.db #0x00	; 0
      008371 00                    3561 	.db #0x00	; 0
      008372 00                    3562 	.db #0x00	; 0
      008373 00                    3563 	.db #0x00	; 0
      008374 00                    3564 	.db #0x00	; 0
      008375 00                    3565 	.db #0x00	; 0
      008376 FF                    3566 	.db #0xff	; 255
      008377 FF                    3567 	.db #0xff	; 255
      008378 80                    3568 	.db #0x80	; 128
      008379 80                    3569 	.db #0x80	; 128
      00837A 80                    3570 	.db #0x80	; 128
      00837B 80                    3571 	.db #0x80	; 128
      00837C 80                    3572 	.db #0x80	; 128
      00837D 80                    3573 	.db #0x80	; 128
      00837E 80                    3574 	.db #0x80	; 128
      00837F BF                    3575 	.db #0xbf	; 191
      008380 BF                    3576 	.db #0xbf	; 191
      008381 BF                    3577 	.db #0xbf	; 191
      008382 BF                    3578 	.db #0xbf	; 191
      008383 BF                    3579 	.db #0xbf	; 191
      008384 BF                    3580 	.db #0xbf	; 191
      008385 BF                    3581 	.db #0xbf	; 191
      008386 80                    3582 	.db #0x80	; 128
      008387 80                    3583 	.db #0x80	; 128
      008388 80                    3584 	.db #0x80	; 128
      008389 80                    3585 	.db #0x80	; 128
      00838A 80                    3586 	.db #0x80	; 128
      00838B 80                    3587 	.db #0x80	; 128
      00838C 80                    3588 	.db #0x80	; 128
      00838D BF                    3589 	.db #0xbf	; 191
      00838E BF                    3590 	.db #0xbf	; 191
      00838F BF                    3591 	.db #0xbf	; 191
      008390 BF                    3592 	.db #0xbf	; 191
      008391 BF                    3593 	.db #0xbf	; 191
      008392 BF                    3594 	.db #0xbf	; 191
      008393 BF                    3595 	.db #0xbf	; 191
      008394 80                    3596 	.db #0x80	; 128
      008395 80                    3597 	.db #0x80	; 128
      008396 80                    3598 	.db #0x80	; 128
      008397 80                    3599 	.db #0x80	; 128
      008398 80                    3600 	.db #0x80	; 128
      008399 80                    3601 	.db #0x80	; 128
      00839A 80                    3602 	.db #0x80	; 128
      00839B BF                    3603 	.db #0xbf	; 191
      00839C BF                    3604 	.db #0xbf	; 191
      00839D BF                    3605 	.db #0xbf	; 191
      00839E BF                    3606 	.db #0xbf	; 191
      00839F BF                    3607 	.db #0xbf	; 191
      0083A0 BF                    3608 	.db #0xbf	; 191
      0083A1 BF                    3609 	.db #0xbf	; 191
      0083A2 80                    3610 	.db #0x80	; 128
      0083A3 80                    3611 	.db #0x80	; 128
      0083A4 80                    3612 	.db #0x80	; 128
      0083A5 80                    3613 	.db #0x80	; 128
      0083A6 80                    3614 	.db #0x80	; 128
      0083A7 80                    3615 	.db #0x80	; 128
      0083A8 80                    3616 	.db #0x80	; 128
      0083A9 BF                    3617 	.db #0xbf	; 191
      0083AA BF                    3618 	.db #0xbf	; 191
      0083AB BF                    3619 	.db #0xbf	; 191
      0083AC BF                    3620 	.db #0xbf	; 191
      0083AD BF                    3621 	.db #0xbf	; 191
      0083AE BF                    3622 	.db #0xbf	; 191
      0083AF BF                    3623 	.db #0xbf	; 191
      0083B0 80                    3624 	.db #0x80	; 128
      0083B1 80                    3625 	.db #0x80	; 128
      0083B2 80                    3626 	.db #0x80	; 128
      0083B3 80                    3627 	.db #0x80	; 128
      0083B4 80                    3628 	.db #0x80	; 128
      0083B5 80                    3629 	.db #0x80	; 128
      0083B6 80                    3630 	.db #0x80	; 128
      0083B7 BF                    3631 	.db #0xbf	; 191
      0083B8 BF                    3632 	.db #0xbf	; 191
      0083B9 BF                    3633 	.db #0xbf	; 191
      0083BA BF                    3634 	.db #0xbf	; 191
      0083BB BF                    3635 	.db #0xbf	; 191
      0083BC BF                    3636 	.db #0xbf	; 191
      0083BD BF                    3637 	.db #0xbf	; 191
      0083BE 80                    3638 	.db #0x80	; 128
      0083BF 80                    3639 	.db #0x80	; 128
      0083C0 80                    3640 	.db #0x80	; 128
      0083C1 80                    3641 	.db #0x80	; 128
      0083C2 80                    3642 	.db #0x80	; 128
      0083C3 80                    3643 	.db #0x80	; 128
      0083C4 80                    3644 	.db #0x80	; 128
      0083C5 BF                    3645 	.db #0xbf	; 191
      0083C6 BF                    3646 	.db #0xbf	; 191
      0083C7 BF                    3647 	.db #0xbf	; 191
      0083C8 BF                    3648 	.db #0xbf	; 191
      0083C9 BF                    3649 	.db #0xbf	; 191
      0083CA BF                    3650 	.db #0xbf	; 191
      0083CB BF                    3651 	.db #0xbf	; 191
      0083CC 80                    3652 	.db #0x80	; 128
      0083CD 80                    3653 	.db #0x80	; 128
      0083CE 80                    3654 	.db #0x80	; 128
      0083CF B1                    3655 	.db #0xb1	; 177
      0083D0 B1                    3656 	.db #0xb1	; 177
      0083D1 BF                    3657 	.db #0xbf	; 191
      0083D2 BF                    3658 	.db #0xbf	; 191
      0083D3 BF                    3659 	.db #0xbf	; 191
      0083D4 B1                    3660 	.db #0xb1	; 177
      0083D5 B1                    3661 	.db #0xb1	; 177
      0083D6 80                    3662 	.db #0x80	; 128
      0083D7 80                    3663 	.db #0x80	; 128
      0083D8 BF                    3664 	.db #0xbf	; 191
      0083D9 BF                    3665 	.db #0xbf	; 191
      0083DA 83                    3666 	.db #0x83	; 131
      0083DB 83                    3667 	.db #0x83	; 131
      0083DC BF                    3668 	.db #0xbf	; 191
      0083DD BE                    3669 	.db #0xbe	; 190
      0083DE 80                    3670 	.db #0x80	; 128
      0083DF 80                    3671 	.db #0x80	; 128
      0083E0 BF                    3672 	.db #0xbf	; 191
      0083E1 BF                    3673 	.db #0xbf	; 191
      0083E2 B3                    3674 	.db #0xb3	; 179
      0083E3 B3                    3675 	.db #0xb3	; 179
      0083E4 B3                    3676 	.db #0xb3	; 179
      0083E5 B3                    3677 	.db #0xb3	; 179
      0083E6 80                    3678 	.db #0x80	; 128
      0083E7 80                    3679 	.db #0x80	; 128
      0083E8 80                    3680 	.db #0x80	; 128
      0083E9 80                    3681 	.db #0x80	; 128
      0083EA B0                    3682 	.db #0xb0	; 176
      0083EB B0                    3683 	.db #0xb0	; 176
      0083EC 80                    3684 	.db #0x80	; 128
      0083ED 80                    3685 	.db #0x80	; 128
      0083EE 80                    3686 	.db #0x80	; 128
      0083EF 80                    3687 	.db #0x80	; 128
      0083F0 80                    3688 	.db #0x80	; 128
      0083F1 80                    3689 	.db #0x80	; 128
      0083F2 80                    3690 	.db #0x80	; 128
      0083F3 80                    3691 	.db #0x80	; 128
      0083F4 80                    3692 	.db #0x80	; 128
      0083F5 80                    3693 	.db #0x80	; 128
      0083F6 FF                    3694 	.db #0xff	; 255
                                   3695 	.area CABS (ABS)
