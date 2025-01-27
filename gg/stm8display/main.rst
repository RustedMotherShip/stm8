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
                                     15 	.globl _ssd1306_send_buffer
                                     16 	.globl _ssd1306_buffer_clean
                                     17 	.globl _set_bit
                                     18 	.globl _get_bit
                                     19 	.globl _i2c_irq
                                     20 	.globl _memset
                                     21 	.globl _TIM2_IRQ
                                     22 	.globl _main_buffer
                                     23 	.globl _ttf_eng_line_down
                                     24 	.globl _ttf_eng_line_up
                                     25 	.globl _ttf_eng_line_left
                                     26 	.globl _ttf_eng_line_right
                                     27 	.globl _ttf_eng_corner_right_down
                                     28 	.globl _ttf_eng_corner_left_down
                                     29 	.globl _ttf_eng_corner_right_up
                                     30 	.globl _ttf_eng_corner_left_up
                                     31 	.globl _ttf_eng_0
                                     32 	.globl _ttf_eng_9
                                     33 	.globl _ttf_eng_8
                                     34 	.globl _ttf_eng_7
                                     35 	.globl _ttf_eng_6
                                     36 	.globl _ttf_eng_5
                                     37 	.globl _ttf_eng_4
                                     38 	.globl _ttf_eng_3
                                     39 	.globl _ttf_eng_2
                                     40 	.globl _ttf_eng_1
                                     41 	.globl _ttf_eng_z
                                     42 	.globl _ttf_eng_y
                                     43 	.globl _ttf_eng_x
                                     44 	.globl _ttf_eng_w
                                     45 	.globl _ttf_eng_v
                                     46 	.globl _ttf_eng_u
                                     47 	.globl _ttf_eng_t
                                     48 	.globl _ttf_eng_s
                                     49 	.globl _ttf_eng_r
                                     50 	.globl _ttf_eng_q
                                     51 	.globl _ttf_eng_p
                                     52 	.globl _ttf_eng_o
                                     53 	.globl _ttf_eng_n
                                     54 	.globl _ttf_eng_m
                                     55 	.globl _ttf_eng_l
                                     56 	.globl _ttf_eng_k
                                     57 	.globl _ttf_eng_j
                                     58 	.globl _ttf_eng_i
                                     59 	.globl _ttf_eng_h
                                     60 	.globl _ttf_eng_g
                                     61 	.globl _ttf_eng_f
                                     62 	.globl _ttf_eng_e
                                     63 	.globl _ttf_eng_d
                                     64 	.globl _ttf_eng_c
                                     65 	.globl _ttf_eng_b
                                     66 	.globl _ttf_eng_a
                                     67 	.globl _I2C_IRQ
                                     68 	.globl _buf_size
                                     69 	.globl _buf_pos
                                     70 	.globl _rx_buf_pointer
                                     71 	.globl _tx_buf_pointer
                                     72 	.globl _uart_transmission_irq
                                     73 	.globl _uart_reciever_irq
                                     74 	.globl _uart_write_irq
                                     75 	.globl _uart_read_irq
                                     76 	.globl _uart_init
                                     77 	.globl _uart_read_byte
                                     78 	.globl _uart_write_byte
                                     79 	.globl _uart_write
                                     80 	.globl _uart_read
                                     81 	.globl _i2c_init
                                     82 	.globl _i2c_start
                                     83 	.globl _i2c_stop
                                     84 	.globl _i2c_send_address
                                     85 	.globl _i2c_read_byte
                                     86 	.globl _i2c_read
                                     87 	.globl _i2c_send_byte
                                     88 	.globl _i2c_write
                                     89 	.globl _i2c_scan
                                     90 	.globl _i2c_start_irq
                                     91 	.globl _i2c_stop_irq
                                     92 	.globl _ssd1306_init
                                     93 	.globl _ssd1306_set_params_to_write
                                     94 	.globl _ssd1306_draw_pixel
                                     95 	.globl _ssd1306_buffer_write
                                     96 	.globl _ssd1306_clean
                                     97 	.globl _delay_s
                                     98 ;--------------------------------------------------------
                                     99 ; ram data
                                    100 ;--------------------------------------------------------
                                    101 	.area DATA
      000001                        102 _tx_buf_pointer::
      000001                        103 	.ds 2
      000003                        104 _rx_buf_pointer::
      000003                        105 	.ds 2
      000005                        106 _buf_pos::
      000005                        107 	.ds 1
      000006                        108 _buf_size::
      000006                        109 	.ds 1
                                    110 ;--------------------------------------------------------
                                    111 ; ram data
                                    112 ;--------------------------------------------------------
                                    113 	.area INITIALIZED
      000007                        114 _I2C_IRQ::
      000007                        115 	.ds 1
      000008                        116 _ttf_eng_a::
      000008                        117 	.ds 8
      000010                        118 _ttf_eng_b::
      000010                        119 	.ds 8
      000018                        120 _ttf_eng_c::
      000018                        121 	.ds 8
      000020                        122 _ttf_eng_d::
      000020                        123 	.ds 8
      000028                        124 _ttf_eng_e::
      000028                        125 	.ds 8
      000030                        126 _ttf_eng_f::
      000030                        127 	.ds 8
      000038                        128 _ttf_eng_g::
      000038                        129 	.ds 8
      000040                        130 _ttf_eng_h::
      000040                        131 	.ds 8
      000048                        132 _ttf_eng_i::
      000048                        133 	.ds 8
      000050                        134 _ttf_eng_j::
      000050                        135 	.ds 8
      000058                        136 _ttf_eng_k::
      000058                        137 	.ds 8
      000060                        138 _ttf_eng_l::
      000060                        139 	.ds 8
      000068                        140 _ttf_eng_m::
      000068                        141 	.ds 8
      000070                        142 _ttf_eng_n::
      000070                        143 	.ds 8
      000078                        144 _ttf_eng_o::
      000078                        145 	.ds 8
      000080                        146 _ttf_eng_p::
      000080                        147 	.ds 8
      000088                        148 _ttf_eng_q::
      000088                        149 	.ds 8
      000090                        150 _ttf_eng_r::
      000090                        151 	.ds 8
      000098                        152 _ttf_eng_s::
      000098                        153 	.ds 8
      0000A0                        154 _ttf_eng_t::
      0000A0                        155 	.ds 8
      0000A8                        156 _ttf_eng_u::
      0000A8                        157 	.ds 8
      0000B0                        158 _ttf_eng_v::
      0000B0                        159 	.ds 8
      0000B8                        160 _ttf_eng_w::
      0000B8                        161 	.ds 8
      0000C0                        162 _ttf_eng_x::
      0000C0                        163 	.ds 8
      0000C8                        164 _ttf_eng_y::
      0000C8                        165 	.ds 8
      0000D0                        166 _ttf_eng_z::
      0000D0                        167 	.ds 8
      0000D8                        168 _ttf_eng_1::
      0000D8                        169 	.ds 8
      0000E0                        170 _ttf_eng_2::
      0000E0                        171 	.ds 8
      0000E8                        172 _ttf_eng_3::
      0000E8                        173 	.ds 8
      0000F0                        174 _ttf_eng_4::
      0000F0                        175 	.ds 8
      0000F8                        176 _ttf_eng_5::
      0000F8                        177 	.ds 8
      000100                        178 _ttf_eng_6::
      000100                        179 	.ds 8
      000108                        180 _ttf_eng_7::
      000108                        181 	.ds 8
      000110                        182 _ttf_eng_8::
      000110                        183 	.ds 8
      000118                        184 _ttf_eng_9::
      000118                        185 	.ds 8
      000120                        186 _ttf_eng_0::
      000120                        187 	.ds 8
      000128                        188 _ttf_eng_corner_left_up::
      000128                        189 	.ds 8
      000130                        190 _ttf_eng_corner_right_up::
      000130                        191 	.ds 8
      000138                        192 _ttf_eng_corner_left_down::
      000138                        193 	.ds 8
      000140                        194 _ttf_eng_corner_right_down::
      000140                        195 	.ds 8
      000148                        196 _ttf_eng_line_right::
      000148                        197 	.ds 8
      000150                        198 _ttf_eng_line_left::
      000150                        199 	.ds 8
      000158                        200 _ttf_eng_line_up::
      000158                        201 	.ds 8
      000160                        202 _ttf_eng_line_down::
      000160                        203 	.ds 8
      000168                        204 _main_buffer::
      000168                        205 	.ds 512
      000368                        206 _TIM2_IRQ::
      000368                        207 	.ds 1
                                    208 ;--------------------------------------------------------
                                    209 ; Stack segment in internal ram
                                    210 ;--------------------------------------------------------
                                    211 	.area SSEG
      000369                        212 __start__stack:
      000369                        213 	.ds	1
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
      00803C 82 00 8A 2D            248 	int _tmr2_irq ; int13
      008040 82 00 00 00            249 	int 0x000000 ; int14
      008044 82 00 00 00            250 	int 0x000000 ; int15
      008048 82 00 00 00            251 	int 0x000000 ; int16
      00804C 82 00 83 E3            252 	int _uart_transmission_irq ; int17
      008050 82 00 84 1F            253 	int _uart_reciever_irq ; int18
      008054 82 00 86 01            254 	int _i2c_irq ; int19
                                    255 ;--------------------------------------------------------
                                    256 ; global & static initialisations
                                    257 ;--------------------------------------------------------
                                    258 	.area HOME
                                    259 	.area GSINIT
                                    260 	.area GSFINAL
                                    261 	.area GSINIT
      00805B CD 8A D5         [ 4]  262 	call	___sdcc_external_startup
      00805E 4D               [ 1]  263 	tnz	a
      00805F 27 03            [ 1]  264 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  265 	jp	__sdcc_program_startup
      008064                        266 __sdcc_init_data:
                                    267 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  268 	ldw x, #l_DATA
      008067 27 07            [ 1]  269 	jreq	00002$
      008069                        270 00001$:
      008069 72 4F 00 00      [ 1]  271 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  272 	decw x
      00806E 26 F9            [ 1]  273 	jrne	00001$
      008070                        274 00002$:
      008070 AE 03 62         [ 2]  275 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  276 	jreq	00004$
      008075                        277 00003$:
      008075 D6 80 80         [ 1]  278 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  279 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  280 	decw	x
      00807C 26 F7            [ 1]  281 	jrne	00003$
      00807E                        282 00004$:
                                    283 ; stm8_genXINIT() end
                                    284 	.area GSFINAL
      00807E CC 80 58         [ 2]  285 	jp	__sdcc_program_startup
                                    286 ;--------------------------------------------------------
                                    287 ; Home
                                    288 ;--------------------------------------------------------
                                    289 	.area HOME
                                    290 	.area HOME
      008058                        291 __sdcc_program_startup:
      008058 CC 8A AA         [ 2]  292 	jp	_main
                                    293 ;	return from main will return to caller
                                    294 ;--------------------------------------------------------
                                    295 ; code
                                    296 ;--------------------------------------------------------
                                    297 	.area CODE
                                    298 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    299 ;	-----------------------------------------
                                    300 ;	 function uart_transmission_irq
                                    301 ;	-----------------------------------------
      0083E3                        302 _uart_transmission_irq:
                                    303 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0083E3 AE 52 30         [ 2]  304 	ldw	x, #0x5230
      0083E6 F6               [ 1]  305 	ld	a, (x)
      0083E7 4E               [ 1]  306 	swap	a
      0083E8 44               [ 1]  307 	srl	a
      0083E9 44               [ 1]  308 	srl	a
      0083EA 44               [ 1]  309 	srl	a
      0083EB A5 01            [ 1]  310 	bcp	a, #0x01
      0083ED 27 2F            [ 1]  311 	jreq	00107$
                                    312 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0083EF C6 00 02         [ 1]  313 	ld	a, _tx_buf_pointer+1
      0083F2 CB 00 05         [ 1]  314 	add	a, _buf_pos+0
      0083F5 97               [ 1]  315 	ld	xl, a
      0083F6 C6 00 01         [ 1]  316 	ld	a, _tx_buf_pointer+0
      0083F9 A9 00            [ 1]  317 	adc	a, #0x00
      0083FB 95               [ 1]  318 	ld	xh, a
      0083FC F6               [ 1]  319 	ld	a, (x)
      0083FD 27 1B            [ 1]  320 	jreq	00102$
      0083FF C6 00 05         [ 1]  321 	ld	a, _buf_pos+0
      008402 C1 00 06         [ 1]  322 	cp	a, _buf_size+0
      008405 24 13            [ 1]  323 	jrnc	00102$
                                    324 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      008407 C6 00 05         [ 1]  325 	ld	a, _buf_pos+0
      00840A 72 5C 00 05      [ 1]  326 	inc	_buf_pos+0
      00840E 5F               [ 1]  327 	clrw	x
      00840F 97               [ 1]  328 	ld	xl, a
      008410 72 BB 00 01      [ 2]  329 	addw	x, _tx_buf_pointer+0
      008414 F6               [ 1]  330 	ld	a, (x)
      008415 C7 52 31         [ 1]  331 	ld	0x5231, a
      008418 20 04            [ 2]  332 	jra	00107$
      00841A                        333 00102$:
                                    334 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      00841A 72 1F 52 35      [ 1]  335 	bres	0x5235, #7
      00841E                        336 00107$:
                                    337 ;	./libs/uart_lib.c: 14: }
      00841E 80               [11]  338 	iret
                                    339 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    340 ;	-----------------------------------------
                                    341 ;	 function uart_reciever_irq
                                    342 ;	-----------------------------------------
      00841F                        343 _uart_reciever_irq:
      00841F 88               [ 1]  344 	push	a
                                    345 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      008420 C6 52 30         [ 1]  346 	ld	a, 0x5230
      008423 4E               [ 1]  347 	swap	a
      008424 44               [ 1]  348 	srl	a
      008425 A5 01            [ 1]  349 	bcp	a, #0x01
      008427 27 27            [ 1]  350 	jreq	00107$
                                    351 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      008429 C6 52 31         [ 1]  352 	ld	a, 0x5231
                                    353 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      00842C 6B 01            [ 1]  354 	ld	(0x01, sp), a
      00842E A1 0A            [ 1]  355 	cp	a, #0x0a
      008430 27 1A            [ 1]  356 	jreq	00102$
      008432 C6 00 05         [ 1]  357 	ld	a, _buf_pos+0
      008435 C1 00 06         [ 1]  358 	cp	a, _buf_size+0
      008438 24 12            [ 1]  359 	jrnc	00102$
                                    360 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      00843A C6 00 05         [ 1]  361 	ld	a, _buf_pos+0
      00843D 72 5C 00 05      [ 1]  362 	inc	_buf_pos+0
      008441 5F               [ 1]  363 	clrw	x
      008442 97               [ 1]  364 	ld	xl, a
      008443 72 BB 00 03      [ 2]  365 	addw	x, _rx_buf_pointer+0
      008447 7B 01            [ 1]  366 	ld	a, (0x01, sp)
      008449 F7               [ 1]  367 	ld	(x), a
      00844A 20 04            [ 2]  368 	jra	00107$
      00844C                        369 00102$:
                                    370 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      00844C 72 1B 52 35      [ 1]  371 	bres	0x5235, #5
      008450                        372 00107$:
                                    373 ;	./libs/uart_lib.c: 30: }
      008450 84               [ 1]  374 	pop	a
      008451 80               [11]  375 	iret
                                    376 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    377 ;	-----------------------------------------
                                    378 ;	 function uart_write_irq
                                    379 ;	-----------------------------------------
      008452                        380 _uart_write_irq:
      008452 52 02            [ 2]  381 	sub	sp, #2
                                    382 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      008454 1F 01            [ 2]  383 	ldw	(0x01, sp), x
      008456 CF 00 01         [ 2]  384 	ldw	_tx_buf_pointer+0, x
                                    385 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      008459 72 5F 00 05      [ 1]  386 	clr	_buf_pos+0
                                    387 ;	./libs/uart_lib.c: 36: buf_size = 0;
      00845D 72 5F 00 06      [ 1]  388 	clr	_buf_size+0
                                    389 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      008461                        390 00101$:
      008461 C6 00 06         [ 1]  391 	ld	a, _buf_size+0
      008464 72 5C 00 06      [ 1]  392 	inc	_buf_size+0
      008468 5F               [ 1]  393 	clrw	x
      008469 97               [ 1]  394 	ld	xl, a
      00846A 72 FB 01         [ 2]  395 	addw	x, (0x01, sp)
      00846D F6               [ 1]  396 	ld	a, (x)
      00846E 26 F1            [ 1]  397 	jrne	00101$
                                    398 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      008470 72 1E 52 35      [ 1]  399 	bset	0x5235, #7
                                    400 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      008474                        401 00104$:
      008474 72 0E 52 35 FB   [ 2]  402 	btjt	0x5235, #7, 00104$
                                    403 ;	./libs/uart_lib.c: 40: }
      008479 5B 02            [ 2]  404 	addw	sp, #2
      00847B 81               [ 4]  405 	ret
                                    406 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    407 ;	-----------------------------------------
                                    408 ;	 function uart_read_irq
                                    409 ;	-----------------------------------------
      00847C                        410 _uart_read_irq:
                                    411 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      00847C CF 00 03         [ 2]  412 	ldw	_rx_buf_pointer+0, x
                                    413 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      00847F 72 5F 00 05      [ 1]  414 	clr	_buf_pos+0
                                    415 ;	./libs/uart_lib.c: 45: buf_size = size;
      008483 7B 04            [ 1]  416 	ld	a, (0x04, sp)
      008485 C7 00 06         [ 1]  417 	ld	_buf_size+0, a
                                    418 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      008488 72 1A 52 35      [ 1]  419 	bset	0x5235, #5
                                    420 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      00848C                        421 00101$:
      00848C C6 52 35         [ 1]  422 	ld	a, 0x5235
      00848F 4E               [ 1]  423 	swap	a
      008490 44               [ 1]  424 	srl	a
      008491 A4 01            [ 1]  425 	and	a, #0x01
      008493 26 F7            [ 1]  426 	jrne	00101$
                                    427 ;	./libs/uart_lib.c: 48: }
      008495 1E 01            [ 2]  428 	ldw	x, (1, sp)
      008497 5B 04            [ 2]  429 	addw	sp, #4
      008499 FC               [ 2]  430 	jp	(x)
                                    431 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    432 ;	-----------------------------------------
                                    433 ;	 function uart_init
                                    434 ;	-----------------------------------------
      00849A                        435 _uart_init:
      00849A 52 02            [ 2]  436 	sub	sp, #2
      00849C 1F 01            [ 2]  437 	ldw	(0x01, sp), x
                                    438 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      00849E AE 52 35         [ 2]  439 	ldw	x, #0x5235
      0084A1 88               [ 1]  440 	push	a
      0084A2 F6               [ 1]  441 	ld	a, (x)
      0084A3 AA 08            [ 1]  442 	or	a, #0x08
      0084A5 F7               [ 1]  443 	ld	(x), a
      0084A6 84               [ 1]  444 	pop	a
                                    445 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      0084A7 AE 52 35         [ 2]  446 	ldw	x, #0x5235
      0084AA 88               [ 1]  447 	push	a
      0084AB F6               [ 1]  448 	ld	a, (x)
      0084AC AA 04            [ 1]  449 	or	a, #0x04
      0084AE F7               [ 1]  450 	ld	(x), a
      0084AF 84               [ 1]  451 	pop	a
                                    452 ;	./libs/uart_lib.c: 56: switch(stopbit)
      0084B0 A1 02            [ 1]  453 	cp	a, #0x02
      0084B2 27 06            [ 1]  454 	jreq	00101$
      0084B4 A1 03            [ 1]  455 	cp	a, #0x03
      0084B6 27 0E            [ 1]  456 	jreq	00102$
      0084B8 20 16            [ 2]  457 	jra	00103$
                                    458 ;	./libs/uart_lib.c: 58: case 2:
      0084BA                        459 00101$:
                                    460 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      0084BA C6 52 36         [ 1]  461 	ld	a, 0x5236
      0084BD A4 CF            [ 1]  462 	and	a, #0xcf
      0084BF AA 20            [ 1]  463 	or	a, #0x20
      0084C1 C7 52 36         [ 1]  464 	ld	0x5236, a
                                    465 ;	./libs/uart_lib.c: 60: break;
      0084C4 20 12            [ 2]  466 	jra	00104$
                                    467 ;	./libs/uart_lib.c: 61: case 3:
      0084C6                        468 00102$:
                                    469 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      0084C6 C6 52 36         [ 1]  470 	ld	a, 0x5236
      0084C9 AA 30            [ 1]  471 	or	a, #0x30
      0084CB C7 52 36         [ 1]  472 	ld	0x5236, a
                                    473 ;	./libs/uart_lib.c: 63: break;
      0084CE 20 08            [ 2]  474 	jra	00104$
                                    475 ;	./libs/uart_lib.c: 64: default:
      0084D0                        476 00103$:
                                    477 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      0084D0 C6 52 36         [ 1]  478 	ld	a, 0x5236
      0084D3 A4 CF            [ 1]  479 	and	a, #0xcf
      0084D5 C7 52 36         [ 1]  480 	ld	0x5236, a
                                    481 ;	./libs/uart_lib.c: 67: }
      0084D8                        482 00104$:
                                    483 ;	./libs/uart_lib.c: 68: switch(baudrate)
      0084D8 1E 01            [ 2]  484 	ldw	x, (0x01, sp)
      0084DA A3 08 00         [ 2]  485 	cpw	x, #0x0800
      0084DD 26 03            [ 1]  486 	jrne	00186$
      0084DF CC 85 6B         [ 2]  487 	jp	00110$
      0084E2                        488 00186$:
      0084E2 1E 01            [ 2]  489 	ldw	x, (0x01, sp)
      0084E4 A3 09 60         [ 2]  490 	cpw	x, #0x0960
      0084E7 27 28            [ 1]  491 	jreq	00105$
      0084E9 1E 01            [ 2]  492 	ldw	x, (0x01, sp)
      0084EB A3 10 00         [ 2]  493 	cpw	x, #0x1000
      0084EE 26 03            [ 1]  494 	jrne	00192$
      0084F0 CC 85 7B         [ 2]  495 	jp	00111$
      0084F3                        496 00192$:
      0084F3 1E 01            [ 2]  497 	ldw	x, (0x01, sp)
      0084F5 A3 4B 00         [ 2]  498 	cpw	x, #0x4b00
      0084F8 27 31            [ 1]  499 	jreq	00106$
      0084FA 1E 01            [ 2]  500 	ldw	x, (0x01, sp)
      0084FC A3 84 00         [ 2]  501 	cpw	x, #0x8400
      0084FF 27 5A            [ 1]  502 	jreq	00109$
      008501 1E 01            [ 2]  503 	ldw	x, (0x01, sp)
      008503 A3 C2 00         [ 2]  504 	cpw	x, #0xc200
      008506 27 43            [ 1]  505 	jreq	00108$
      008508 1E 01            [ 2]  506 	ldw	x, (0x01, sp)
      00850A A3 E1 00         [ 2]  507 	cpw	x, #0xe100
      00850D 27 2C            [ 1]  508 	jreq	00107$
      00850F 20 7A            [ 2]  509 	jra	00112$
                                    510 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      008511                        511 00105$:
                                    512 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      008511 C6 52 33         [ 1]  513 	ld	a, 0x5233
      008514 A4 0F            [ 1]  514 	and	a, #0x0f
      008516 AA 10            [ 1]  515 	or	a, #0x10
      008518 C7 52 33         [ 1]  516 	ld	0x5233, a
                                    517 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      00851B 35 A0 52 32      [ 1]  518 	mov	0x5232+0, #0xa0
                                    519 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      00851F C6 52 33         [ 1]  520 	ld	a, 0x5233
      008522 A4 F0            [ 1]  521 	and	a, #0xf0
      008524 AA 0B            [ 1]  522 	or	a, #0x0b
      008526 C7 52 33         [ 1]  523 	ld	0x5233, a
                                    524 ;	./libs/uart_lib.c: 74: break;
      008529 20 6E            [ 2]  525 	jra	00114$
                                    526 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      00852B                        527 00106$:
                                    528 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      00852B 35 34 52 32      [ 1]  529 	mov	0x5232+0, #0x34
                                    530 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      00852F C6 52 33         [ 1]  531 	ld	a, 0x5233
      008532 A4 F0            [ 1]  532 	and	a, #0xf0
      008534 AA 01            [ 1]  533 	or	a, #0x01
      008536 C7 52 33         [ 1]  534 	ld	0x5233, a
                                    535 ;	./libs/uart_lib.c: 78: break;
      008539 20 5E            [ 2]  536 	jra	00114$
                                    537 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      00853B                        538 00107$:
                                    539 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      00853B 35 11 52 32      [ 1]  540 	mov	0x5232+0, #0x11
                                    541 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      00853F C6 52 33         [ 1]  542 	ld	a, 0x5233
      008542 A4 F0            [ 1]  543 	and	a, #0xf0
      008544 AA 06            [ 1]  544 	or	a, #0x06
      008546 C7 52 33         [ 1]  545 	ld	0x5233, a
                                    546 ;	./libs/uart_lib.c: 82: break;
      008549 20 4E            [ 2]  547 	jra	00114$
                                    548 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      00854B                        549 00108$:
                                    550 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      00854B 35 08 52 32      [ 1]  551 	mov	0x5232+0, #0x08
                                    552 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      00854F C6 52 33         [ 1]  553 	ld	a, 0x5233
      008552 A4 F0            [ 1]  554 	and	a, #0xf0
      008554 AA 0B            [ 1]  555 	or	a, #0x0b
      008556 C7 52 33         [ 1]  556 	ld	0x5233, a
                                    557 ;	./libs/uart_lib.c: 86: break;
      008559 20 3E            [ 2]  558 	jra	00114$
                                    559 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      00855B                        560 00109$:
                                    561 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      00855B 35 04 52 32      [ 1]  562 	mov	0x5232+0, #0x04
                                    563 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      00855F C6 52 33         [ 1]  564 	ld	a, 0x5233
      008562 A4 F0            [ 1]  565 	and	a, #0xf0
      008564 AA 05            [ 1]  566 	or	a, #0x05
      008566 C7 52 33         [ 1]  567 	ld	0x5233, a
                                    568 ;	./libs/uart_lib.c: 90: break;
      008569 20 2E            [ 2]  569 	jra	00114$
                                    570 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      00856B                        571 00110$:
                                    572 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      00856B 35 02 52 32      [ 1]  573 	mov	0x5232+0, #0x02
                                    574 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      00856F C6 52 33         [ 1]  575 	ld	a, 0x5233
      008572 A4 F0            [ 1]  576 	and	a, #0xf0
      008574 AA 03            [ 1]  577 	or	a, #0x03
      008576 C7 52 33         [ 1]  578 	ld	0x5233, a
                                    579 ;	./libs/uart_lib.c: 94: break;
      008579 20 1E            [ 2]  580 	jra	00114$
                                    581 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      00857B                        582 00111$:
                                    583 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      00857B 35 01 52 32      [ 1]  584 	mov	0x5232+0, #0x01
                                    585 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      00857F C6 52 33         [ 1]  586 	ld	a, 0x5233
      008582 A4 F0            [ 1]  587 	and	a, #0xf0
      008584 AA 01            [ 1]  588 	or	a, #0x01
      008586 C7 52 33         [ 1]  589 	ld	0x5233, a
                                    590 ;	./libs/uart_lib.c: 98: break;
      008589 20 0E            [ 2]  591 	jra	00114$
                                    592 ;	./libs/uart_lib.c: 99: default:
      00858B                        593 00112$:
                                    594 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      00858B 35 68 52 32      [ 1]  595 	mov	0x5232+0, #0x68
                                    596 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      00858F C6 52 33         [ 1]  597 	ld	a, 0x5233
      008592 A4 F0            [ 1]  598 	and	a, #0xf0
      008594 AA 03            [ 1]  599 	or	a, #0x03
      008596 C7 52 33         [ 1]  600 	ld	0x5233, a
                                    601 ;	./libs/uart_lib.c: 103: }
      008599                        602 00114$:
                                    603 ;	./libs/uart_lib.c: 104: }
      008599 5B 02            [ 2]  604 	addw	sp, #2
      00859B 81               [ 4]  605 	ret
                                    606 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    607 ;	-----------------------------------------
                                    608 ;	 function uart_read_byte
                                    609 ;	-----------------------------------------
      00859C                        610 _uart_read_byte:
                                    611 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      00859C                        612 00101$:
      00859C 72 0B 52 30 FB   [ 2]  613 	btjf	0x5230, #5, 00101$
                                    614 ;	./libs/uart_lib.c: 110: return 1;
      0085A1 5F               [ 1]  615 	clrw	x
      0085A2 5C               [ 1]  616 	incw	x
                                    617 ;	./libs/uart_lib.c: 111: }
      0085A3 81               [ 4]  618 	ret
                                    619 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    620 ;	-----------------------------------------
                                    621 ;	 function uart_write_byte
                                    622 ;	-----------------------------------------
      0085A4                        623 _uart_write_byte:
                                    624 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      0085A4 C7 52 31         [ 1]  625 	ld	0x5231, a
                                    626 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      0085A7                        627 00101$:
      0085A7 72 0F 52 30 FB   [ 2]  628 	btjf	0x5230, #7, 00101$
                                    629 ;	./libs/uart_lib.c: 117: return 1;
      0085AC 5F               [ 1]  630 	clrw	x
      0085AD 5C               [ 1]  631 	incw	x
                                    632 ;	./libs/uart_lib.c: 118: }
      0085AE 81               [ 4]  633 	ret
                                    634 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    635 ;	-----------------------------------------
                                    636 ;	 function uart_write
                                    637 ;	-----------------------------------------
      0085AF                        638 _uart_write:
      0085AF 52 04            [ 2]  639 	sub	sp, #4
      0085B1 1F 01            [ 2]  640 	ldw	(0x01, sp), x
                                    641 ;	./libs/uart_lib.c: 122: int count = 0;
      0085B3 5F               [ 1]  642 	clrw	x
      0085B4 1F 03            [ 2]  643 	ldw	(0x03, sp), x
                                    644 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085B6 5F               [ 1]  645 	clrw	x
      0085B7                        646 00103$:
      0085B7 90 93            [ 1]  647 	ldw	y, x
      0085B9 72 F9 01         [ 2]  648 	addw	y, (0x01, sp)
      0085BC 90 F6            [ 1]  649 	ld	a, (y)
      0085BE 27 0E            [ 1]  650 	jreq	00101$
                                    651 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      0085C0 89               [ 2]  652 	pushw	x
      0085C1 CD 85 A4         [ 4]  653 	call	_uart_write_byte
      0085C4 51               [ 1]  654 	exgw	x, y
      0085C5 85               [ 2]  655 	popw	x
      0085C6 72 F9 03         [ 2]  656 	addw	y, (0x03, sp)
      0085C9 17 03            [ 2]  657 	ldw	(0x03, sp), y
                                    658 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085CB 5C               [ 1]  659 	incw	x
      0085CC 20 E9            [ 2]  660 	jra	00103$
      0085CE                        661 00101$:
                                    662 ;	./libs/uart_lib.c: 125: return count;
      0085CE 1E 03            [ 2]  663 	ldw	x, (0x03, sp)
                                    664 ;	./libs/uart_lib.c: 126: }
      0085D0 5B 04            [ 2]  665 	addw	sp, #4
      0085D2 81               [ 4]  666 	ret
                                    667 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    668 ;	-----------------------------------------
                                    669 ;	 function uart_read
                                    670 ;	-----------------------------------------
      0085D3                        671 _uart_read:
      0085D3 52 04            [ 2]  672 	sub	sp, #4
      0085D5 1F 01            [ 2]  673 	ldw	(0x01, sp), x
                                    674 ;	./libs/uart_lib.c: 130: int count = 0;
      0085D7 5F               [ 1]  675 	clrw	x
      0085D8 1F 03            [ 2]  676 	ldw	(0x03, sp), x
                                    677 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085DA 5F               [ 1]  678 	clrw	x
      0085DB                        679 00103$:
      0085DB 90 93            [ 1]  680 	ldw	y, x
      0085DD 72 F9 01         [ 2]  681 	addw	y, (0x01, sp)
      0085E0 90 F6            [ 1]  682 	ld	a, (y)
      0085E2 27 13            [ 1]  683 	jreq	00101$
                                    684 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      0085E4 90 5F            [ 1]  685 	clrw	y
      0085E6 90 97            [ 1]  686 	ld	yl, a
      0085E8 89               [ 2]  687 	pushw	x
      0085E9 93               [ 1]  688 	ldw	x, y
      0085EA CD 85 9C         [ 4]  689 	call	_uart_read_byte
      0085ED 51               [ 1]  690 	exgw	x, y
      0085EE 85               [ 2]  691 	popw	x
      0085EF 72 F9 03         [ 2]  692 	addw	y, (0x03, sp)
      0085F2 17 03            [ 2]  693 	ldw	(0x03, sp), y
                                    694 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085F4 5C               [ 1]  695 	incw	x
      0085F5 20 E4            [ 2]  696 	jra	00103$
      0085F7                        697 00101$:
                                    698 ;	./libs/uart_lib.c: 133: return count;
      0085F7 1E 03            [ 2]  699 	ldw	x, (0x03, sp)
                                    700 ;	./libs/uart_lib.c: 134: }
      0085F9 5B 04            [ 2]  701 	addw	sp, #4
      0085FB 90 85            [ 2]  702 	popw	y
      0085FD 5B 02            [ 2]  703 	addw	sp, #2
      0085FF 90 FC            [ 2]  704 	jp	(y)
                                    705 ;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    706 ;	-----------------------------------------
                                    707 ;	 function i2c_irq
                                    708 ;	-----------------------------------------
      008601                        709 _i2c_irq:
      008601 4F               [ 1]  710 	clr	a
      008602 62               [ 2]  711 	div	x, a
                                    712 ;	./libs/i2c_lib.c: 6: disableInterrupts();
      008603 9B               [ 1]  713 	sim
                                    714 ;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
      008604 35 00 00 07      [ 1]  715 	mov	_I2C_IRQ+0, #0x00
                                    716 ;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
      008608 AE 52 17         [ 2]  717 	ldw	x, #0x5217
      00860B F6               [ 1]  718 	ld	a, (x)
      00860C 44               [ 1]  719 	srl	a
      00860D A4 01            [ 1]  720 	and	a, #0x01
      00860F 27 16            [ 1]  721 	jreq	00102$
                                    722 ;	./libs/i2c_lib.c: 11: clr_sr1();
      008611 C6 52 17         [ 1]  723 	ld	a,0x5217
                                    724 ;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
      008614 72 12 00 07      [ 1]  725 	bset	_I2C_IRQ+0, #1
                                    726 ;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
      008618 C6 52 19         [ 1]  727 	ld	a,0x5219
                                    728 ;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
      00861B 72 13 52 1A      [ 1]  729 	bres	0x521a, #1
                                    730 ;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
      00861F A6 E1            [ 1]  731 	ld	a, #0xe1
      008621 CD 85 A4         [ 4]  732 	call	_uart_write_byte
                                    733 ;	./libs/i2c_lib.c: 16: return;
      008624 CC 86 BA         [ 2]  734 	jp	00113$
      008627                        735 00102$:
                                    736 ;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      008627 C6 52 17         [ 1]  737 	ld	a, 0x5217
      00862A 4E               [ 1]  738 	swap	a
      00862B 44               [ 1]  739 	srl	a
      00862C 44               [ 1]  740 	srl	a
      00862D 44               [ 1]  741 	srl	a
      00862E A5 01            [ 1]  742 	bcp	a, #0x01
      008630 27 17            [ 1]  743 	jreq	00104$
                                    744 ;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
      008632 72 18 00 07      [ 1]  745 	bset	_I2C_IRQ+0, #4
                                    746 ;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
      008636 72 15 52 1A      [ 1]  747 	bres	0x521a, #2
                                    748 ;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
      00863A 72 13 52 1A      [ 1]  749 	bres	0x521a, #1
                                    750 ;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
      00863E 72 11 52 1A      [ 1]  751 	bres	0x521a, #0
                                    752 ;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
      008642 A6 EA            [ 1]  753 	ld	a, #0xea
      008644 CD 85 A4         [ 4]  754 	call	_uart_write_byte
                                    755 ;	./libs/i2c_lib.c: 26: return;
      008647 20 71            [ 2]  756 	jra	00113$
      008649                        757 00104$:
                                    758 ;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      008649 C6 52 17         [ 1]  759 	ld	a, 0x5217
      00864C 4E               [ 1]  760 	swap	a
      00864D 44               [ 1]  761 	srl	a
      00864E 44               [ 1]  762 	srl	a
      00864F A5 01            [ 1]  763 	bcp	a, #0x01
      008651 27 17            [ 1]  764 	jreq	00106$
                                    765 ;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
      008653 72 16 00 07      [ 1]  766 	bset	_I2C_IRQ+0, #3
                                    767 ;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
      008657 72 15 52 1A      [ 1]  768 	bres	0x521a, #2
                                    769 ;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
      00865B 72 13 52 1A      [ 1]  770 	bres	0x521a, #1
                                    771 ;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
      00865F 72 11 52 1A      [ 1]  772 	bres	0x521a, #0
                                    773 ;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
      008663 A6 EB            [ 1]  774 	ld	a, #0xeb
      008665 CD 85 A4         [ 4]  775 	call	_uart_write_byte
                                    776 ;	./libs/i2c_lib.c: 35: return;
      008668 20 50            [ 2]  777 	jra	00113$
      00866A                        778 00106$:
                                    779 ;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      00866A C6 52 17         [ 1]  780 	ld	a, 0x5217
      00866D A5 01            [ 1]  781 	bcp	a, #0x01
      00866F 27 0F            [ 1]  782 	jreq	00108$
                                    783 ;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
      008671 72 10 00 07      [ 1]  784 	bset	_I2C_IRQ+0, #0
                                    785 ;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
      008675 72 13 52 1A      [ 1]  786 	bres	0x521a, #1
                                    787 ;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
      008679 A6 E2            [ 1]  788 	ld	a, #0xe2
      00867B CD 85 A4         [ 4]  789 	call	_uart_write_byte
                                    790 ;	./libs/i2c_lib.c: 43: return;
      00867E 20 3A            [ 2]  791 	jra	00113$
      008680                        792 00108$:
                                    793 ;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
      008680 C6 52 17         [ 1]  794 	ld	a, 0x5217
      008683 44               [ 1]  795 	srl	a
      008684 44               [ 1]  796 	srl	a
      008685 A5 01            [ 1]  797 	bcp	a, #0x01
      008687 27 0F            [ 1]  798 	jreq	00110$
                                    799 ;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
      008689 72 14 00 07      [ 1]  800 	bset	_I2C_IRQ+0, #2
                                    801 ;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
      00868D 72 13 52 1A      [ 1]  802 	bres	0x521a, #1
                                    803 ;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
      008691 A6 E3            [ 1]  804 	ld	a, #0xe3
      008693 CD 85 A4         [ 4]  805 	call	_uart_write_byte
                                    806 ;	./libs/i2c_lib.c: 50: return;
      008696 20 22            [ 2]  807 	jra	00113$
      008698                        808 00110$:
                                    809 ;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      008698 AE 52 18         [ 2]  810 	ldw	x, #0x5218
      00869B F6               [ 1]  811 	ld	a, (x)
      00869C 44               [ 1]  812 	srl	a
      00869D 44               [ 1]  813 	srl	a
      00869E A4 01            [ 1]  814 	and	a, #0x01
      0086A0 27 17            [ 1]  815 	jreq	00112$
                                    816 ;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
      0086A2 72 1A 00 07      [ 1]  817 	bset	_I2C_IRQ+0, #5
                                    818 ;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
      0086A6 72 13 52 1A      [ 1]  819 	bres	0x521a, #1
                                    820 ;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
      0086AA 72 11 52 1A      [ 1]  821 	bres	0x521a, #0
                                    822 ;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
      0086AE 72 15 52 1A      [ 1]  823 	bres	0x521a, #2
                                    824 ;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
      0086B2 A6 EE            [ 1]  825 	ld	a, #0xee
      0086B4 CD 85 A4         [ 4]  826 	call	_uart_write_byte
                                    827 ;	./libs/i2c_lib.c: 60: return;
      0086B7 20 01            [ 2]  828 	jra	00113$
      0086B9                        829 00112$:
                                    830 ;	./libs/i2c_lib.c: 63: enableInterrupts(); 
      0086B9 9A               [ 1]  831 	rim
      0086BA                        832 00113$:
                                    833 ;	./libs/i2c_lib.c: 64: }
      0086BA 80               [11]  834 	iret
                                    835 ;	./libs/i2c_lib.c: 66: void i2c_init(void)
                                    836 ;	-----------------------------------------
                                    837 ;	 function i2c_init
                                    838 ;	-----------------------------------------
      0086BB                        839 _i2c_init:
                                    840 ;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      0086BB 72 11 52 10      [ 1]  841 	bres	0x5210, #0
                                    842 ;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      0086BF C6 52 12         [ 1]  843 	ld	a, 0x5212
      0086C2 A4 C0            [ 1]  844 	and	a, #0xc0
      0086C4 AA 10            [ 1]  845 	or	a, #0x10
      0086C6 C7 52 12         [ 1]  846 	ld	0x5212, a
                                    847 ;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
      0086C9 C6 52 1C         [ 1]  848 	ld	a, 0x521c
      0086CC A4 F0            [ 1]  849 	and	a, #0xf0
      0086CE C7 52 1C         [ 1]  850 	ld	0x521c, a
                                    851 ;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0086D1 35 50 52 1B      [ 1]  852 	mov	0x521b+0, #0x50
                                    853 ;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0086D5 72 1F 52 1C      [ 1]  854 	bres	0x521c, #7
                                    855 ;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0086D9 72 1F 52 14      [ 1]  856 	bres	0x5214, #7
                                    857 ;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
      0086DD 72 10 52 14      [ 1]  858 	bset	0x5214, #0
                                    859 ;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0086E1 72 10 52 10      [ 1]  860 	bset	0x5210, #0
                                    861 ;	./libs/i2c_lib.c: 78: }
      0086E5 81               [ 4]  862 	ret
                                    863 ;	./libs/i2c_lib.c: 80: void i2c_start(void)
                                    864 ;	-----------------------------------------
                                    865 ;	 function i2c_start
                                    866 ;	-----------------------------------------
      0086E6                        867 _i2c_start:
                                    868 ;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0086E6 72 10 52 11      [ 1]  869 	bset	0x5211, #0
                                    870 ;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0086EA                        871 00101$:
      0086EA 72 01 52 17 FB   [ 2]  872 	btjf	0x5217, #0, 00101$
                                    873 ;	./libs/i2c_lib.c: 84: }
      0086EF 81               [ 4]  874 	ret
                                    875 ;	./libs/i2c_lib.c: 86: void i2c_stop(void)
                                    876 ;	-----------------------------------------
                                    877 ;	 function i2c_stop
                                    878 ;	-----------------------------------------
      0086F0                        879 _i2c_stop:
                                    880 ;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0086F0 72 12 52 11      [ 1]  881 	bset	0x5211, #1
                                    882 ;	./libs/i2c_lib.c: 89: }
      0086F4 81               [ 4]  883 	ret
                                    884 ;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    885 ;	-----------------------------------------
                                    886 ;	 function i2c_send_address
                                    887 ;	-----------------------------------------
      0086F5                        888 _i2c_send_address:
                                    889 ;	./libs/i2c_lib.c: 96: address = address << 1;
      0086F5 48               [ 1]  890 	sll	a
                                    891 ;	./libs/i2c_lib.c: 93: switch(rw_type)
      0086F6 88               [ 1]  892 	push	a
      0086F7 7B 04            [ 1]  893 	ld	a, (0x04, sp)
      0086F9 4A               [ 1]  894 	dec	a
      0086FA 84               [ 1]  895 	pop	a
      0086FB 26 02            [ 1]  896 	jrne	00102$
                                    897 ;	./libs/i2c_lib.c: 96: address = address << 1;
                                    898 ;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0086FD AA 01            [ 1]  899 	or	a, #0x01
                                    900 ;	./libs/i2c_lib.c: 98: break;
                                    901 ;	./libs/i2c_lib.c: 99: default:
                                    902 ;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
                                    903 ;	./libs/i2c_lib.c: 102: }
      0086FF                        904 00102$:
                                    905 ;	./libs/i2c_lib.c: 103: i2c_start();
      0086FF 88               [ 1]  906 	push	a
      008700 CD 86 E6         [ 4]  907 	call	_i2c_start
      008703 84               [ 1]  908 	pop	a
                                    909 ;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
      008704 C7 52 16         [ 1]  910 	ld	0x5216, a
                                    911 ;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
      008707                        912 00106$:
      008707 AE 52 17         [ 2]  913 	ldw	x, #0x5217
      00870A F6               [ 1]  914 	ld	a, (x)
      00870B 44               [ 1]  915 	srl	a
      00870C A4 01            [ 1]  916 	and	a, #0x01
      00870E 26 08            [ 1]  917 	jrne	00108$
                                    918 ;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
      008710 72 05 52 18 F2   [ 2]  919 	btjf	0x5218, #2, 00106$
                                    920 ;	./libs/i2c_lib.c: 107: return 0;
      008715 4F               [ 1]  921 	clr	a
      008716 20 08            [ 2]  922 	jra	00109$
      008718                        923 00108$:
                                    924 ;	./libs/i2c_lib.c: 108: clr_sr1();
      008718 C6 52 17         [ 1]  925 	ld	a,0x5217
                                    926 ;	./libs/i2c_lib.c: 109: clr_sr3();
      00871B C6 52 19         [ 1]  927 	ld	a,0x5219
                                    928 ;	./libs/i2c_lib.c: 110: return 1;
      00871E A6 01            [ 1]  929 	ld	a, #0x01
      008720                        930 00109$:
                                    931 ;	./libs/i2c_lib.c: 111: }
      008720 85               [ 2]  932 	popw	x
      008721 5B 01            [ 2]  933 	addw	sp, #1
      008723 FC               [ 2]  934 	jp	(x)
                                    935 ;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
                                    936 ;	-----------------------------------------
                                    937 ;	 function i2c_read_byte
                                    938 ;	-----------------------------------------
      008724                        939 _i2c_read_byte:
                                    940 ;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
      008724                        941 00101$:
      008724 72 0D 52 17 FB   [ 2]  942 	btjf	0x5217, #6, 00101$
                                    943 ;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
      008729 C6 52 16         [ 1]  944 	ld	a, 0x5216
                                    945 ;	./libs/i2c_lib.c: 117: }
      00872C 81               [ 4]  946 	ret
                                    947 ;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    948 ;	-----------------------------------------
                                    949 ;	 function i2c_read
                                    950 ;	-----------------------------------------
      00872D                        951 _i2c_read:
      00872D 52 04            [ 2]  952 	sub	sp, #4
                                    953 ;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      00872F 4B 01            [ 1]  954 	push	#0x01
      008731 CD 86 F5         [ 4]  955 	call	_i2c_send_address
      008734 4D               [ 1]  956 	tnz	a
      008735 27 3C            [ 1]  957 	jreq	00103$
                                    958 ;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008737 72 14 52 11      [ 1]  959 	bset	0x5211, #2
                                    960 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00873B 5F               [ 1]  961 	clrw	x
      00873C 1F 03            [ 2]  962 	ldw	(0x03, sp), x
      00873E                        963 00105$:
      00873E 5F               [ 1]  964 	clrw	x
      00873F 7B 07            [ 1]  965 	ld	a, (0x07, sp)
      008741 97               [ 1]  966 	ld	xl, a
      008742 5A               [ 2]  967 	decw	x
      008743 1F 01            [ 2]  968 	ldw	(0x01, sp), x
      008745 1E 03            [ 2]  969 	ldw	x, (0x03, sp)
      008747 13 01            [ 2]  970 	cpw	x, (0x01, sp)
      008749 2E 12            [ 1]  971 	jrsge	00101$
                                    972 ;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00874B 1E 08            [ 2]  973 	ldw	x, (0x08, sp)
      00874D 72 FB 03         [ 2]  974 	addw	x, (0x03, sp)
      008750 89               [ 2]  975 	pushw	x
      008751 CD 87 24         [ 4]  976 	call	_i2c_read_byte
      008754 85               [ 2]  977 	popw	x
      008755 F7               [ 1]  978 	ld	(x), a
                                    979 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008756 1E 03            [ 2]  980 	ldw	x, (0x03, sp)
      008758 5C               [ 1]  981 	incw	x
      008759 1F 03            [ 2]  982 	ldw	(0x03, sp), x
      00875B 20 E1            [ 2]  983 	jra	00105$
      00875D                        984 00101$:
                                    985 ;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00875D C6 52 11         [ 1]  986 	ld	a, 0x5211
      008760 A4 FB            [ 1]  987 	and	a, #0xfb
      008762 C7 52 11         [ 1]  988 	ld	0x5211, a
                                    989 ;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
      008765 1E 08            [ 2]  990 	ldw	x, (0x08, sp)
      008767 72 FB 01         [ 2]  991 	addw	x, (0x01, sp)
      00876A 89               [ 2]  992 	pushw	x
      00876B CD 87 24         [ 4]  993 	call	_i2c_read_byte
      00876E 85               [ 2]  994 	popw	x
      00876F F7               [ 1]  995 	ld	(x), a
                                    996 ;	./libs/i2c_lib.c: 132: i2c_stop();
      008770 CD 86 F0         [ 4]  997 	call	_i2c_stop
      008773                        998 00103$:
                                    999 ;	./libs/i2c_lib.c: 135: i2c_stop();
      008773 1E 05            [ 2] 1000 	ldw	x, (5, sp)
      008775 1F 08            [ 2] 1001 	ldw	(8, sp), x
      008777 5B 07            [ 2] 1002 	addw	sp, #7
                                   1003 ;	./libs/i2c_lib.c: 137: }
      008779 CC 86 F0         [ 2] 1004 	jp	_i2c_stop
                                   1005 ;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
                                   1006 ;	-----------------------------------------
                                   1007 ;	 function i2c_send_byte
                                   1008 ;	-----------------------------------------
      00877C                       1009 _i2c_send_byte:
                                   1010 ;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
      00877C C7 52 16         [ 1] 1011 	ld	0x5216, a
                                   1012 ;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
      00877F                       1013 00103$:
      00877F 72 0E 52 17 08   [ 2] 1014 	btjt	0x5217, #7, 00105$
                                   1015 ;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
      008784 72 05 52 18 F6   [ 2] 1016 	btjf	0x5218, #2, 00103$
                                   1017 ;	./libs/i2c_lib.c: 144: return 1;
      008789 A6 01            [ 1] 1018 	ld	a, #0x01
      00878B 81               [ 4] 1019 	ret
      00878C                       1020 00105$:
                                   1021 ;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
      00878C 4F               [ 1] 1022 	clr	a
                                   1023 ;	./libs/i2c_lib.c: 146: }
      00878D 81               [ 4] 1024 	ret
                                   1025 ;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                   1026 ;	-----------------------------------------
                                   1027 ;	 function i2c_write
                                   1028 ;	-----------------------------------------
      00878E                       1029 _i2c_write:
      00878E 52 02            [ 2] 1030 	sub	sp, #2
                                   1031 ;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008790 4B 00            [ 1] 1032 	push	#0x00
      008792 CD 86 F5         [ 4] 1033 	call	_i2c_send_address
      008795 4D               [ 1] 1034 	tnz	a
      008796 27 1D            [ 1] 1035 	jreq	00105$
                                   1036 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      008798 5F               [ 1] 1037 	clrw	x
      008799                       1038 00107$:
      008799 7B 05            [ 1] 1039 	ld	a, (0x05, sp)
      00879B 6B 02            [ 1] 1040 	ld	(0x02, sp), a
      00879D 0F 01            [ 1] 1041 	clr	(0x01, sp)
      00879F 13 01            [ 2] 1042 	cpw	x, (0x01, sp)
      0087A1 2E 12            [ 1] 1043 	jrsge	00105$
                                   1044 ;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      0087A3 90 93            [ 1] 1045 	ldw	y, x
      0087A5 72 F9 06         [ 2] 1046 	addw	y, (0x06, sp)
      0087A8 90 F6            [ 1] 1047 	ld	a, (y)
      0087AA 89               [ 2] 1048 	pushw	x
      0087AB CD 87 7C         [ 4] 1049 	call	_i2c_send_byte
      0087AE 85               [ 2] 1050 	popw	x
      0087AF 4D               [ 1] 1051 	tnz	a
      0087B0 26 03            [ 1] 1052 	jrne	00105$
                                   1053 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      0087B2 5C               [ 1] 1054 	incw	x
      0087B3 20 E4            [ 2] 1055 	jra	00107$
      0087B5                       1056 00105$:
                                   1057 ;	./libs/i2c_lib.c: 158: i2c_stop();
      0087B5 1E 03            [ 2] 1058 	ldw	x, (3, sp)
      0087B7 1F 06            [ 2] 1059 	ldw	(6, sp), x
      0087B9 5B 05            [ 2] 1060 	addw	sp, #5
                                   1061 ;	./libs/i2c_lib.c: 159: }
      0087BB CC 86 F0         [ 2] 1062 	jp	_i2c_stop
                                   1063 ;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
                                   1064 ;	-----------------------------------------
                                   1065 ;	 function i2c_scan
                                   1066 ;	-----------------------------------------
      0087BE                       1067 _i2c_scan:
      0087BE 52 02            [ 2] 1068 	sub	sp, #2
                                   1069 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087C0 A6 01            [ 1] 1070 	ld	a, #0x01
      0087C2 6B 01            [ 1] 1071 	ld	(0x01, sp), a
      0087C4                       1072 00105$:
      0087C4 A1 7F            [ 1] 1073 	cp	a, #0x7f
      0087C6 24 22            [ 1] 1074 	jrnc	00103$
                                   1075 ;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0087C8 88               [ 1] 1076 	push	a
      0087C9 4B 00            [ 1] 1077 	push	#0x00
      0087CB CD 86 F5         [ 4] 1078 	call	_i2c_send_address
      0087CE 6B 03            [ 1] 1079 	ld	(0x03, sp), a
      0087D0 84               [ 1] 1080 	pop	a
      0087D1 0D 02            [ 1] 1081 	tnz	(0x02, sp)
      0087D3 27 07            [ 1] 1082 	jreq	00102$
                                   1083 ;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
      0087D5 CD 86 F0         [ 4] 1084 	call	_i2c_stop
                                   1085 ;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
      0087D8 7B 01            [ 1] 1086 	ld	a, (0x01, sp)
      0087DA 20 12            [ 2] 1087 	jra	00107$
      0087DC                       1088 00102$:
                                   1089 ;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0087DC AE 52 18         [ 2] 1090 	ldw	x, #0x5218
      0087DF 88               [ 1] 1091 	push	a
      0087E0 F6               [ 1] 1092 	ld	a, (x)
      0087E1 A4 FB            [ 1] 1093 	and	a, #0xfb
      0087E3 F7               [ 1] 1094 	ld	(x), a
      0087E4 84               [ 1] 1095 	pop	a
                                   1096 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087E5 4C               [ 1] 1097 	inc	a
      0087E6 6B 01            [ 1] 1098 	ld	(0x01, sp), a
      0087E8 20 DA            [ 2] 1099 	jra	00105$
      0087EA                       1100 00103$:
                                   1101 ;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
      0087EA CD 86 F0         [ 4] 1102 	call	_i2c_stop
                                   1103 ;	./libs/i2c_lib.c: 173: return 0;
      0087ED 4F               [ 1] 1104 	clr	a
      0087EE                       1105 00107$:
                                   1106 ;	./libs/i2c_lib.c: 174: }
      0087EE 5B 02            [ 2] 1107 	addw	sp, #2
      0087F0 81               [ 4] 1108 	ret
                                   1109 ;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
                                   1110 ;	-----------------------------------------
                                   1111 ;	 function i2c_start_irq
                                   1112 ;	-----------------------------------------
      0087F1                       1113 _i2c_start_irq:
                                   1114 ;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      0087F1 72 12 52 1A      [ 1] 1115 	bset	0x521a, #1
                                   1116 ;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0087F5 72 10 52 11      [ 1] 1117 	bset	0x5211, #0
                                   1118 ;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      0087F9                       1119 00101$:
      0087F9 C6 52 1A         [ 1] 1120 	ld	a, 0x521a
      0087FC A5 02            [ 1] 1121 	bcp	a, #2
      0087FE 26 F9            [ 1] 1122 	jrne	00101$
                                   1123 ;	./libs/i2c_lib.c: 182: }
      008800 81               [ 4] 1124 	ret
                                   1125 ;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
                                   1126 ;	-----------------------------------------
                                   1127 ;	 function i2c_stop_irq
                                   1128 ;	-----------------------------------------
      008801                       1129 _i2c_stop_irq:
                                   1130 ;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      008801 72 12 52 11      [ 1] 1131 	bset	0x5211, #1
                                   1132 ;	./libs/i2c_lib.c: 187: }
      008805 81               [ 4] 1133 	ret
                                   1134 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                   1135 ;	-----------------------------------------
                                   1136 ;	 function get_bit
                                   1137 ;	-----------------------------------------
      008806                       1138 _get_bit:
                                   1139 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      008806 7B 04            [ 1] 1140 	ld	a, (0x04, sp)
      008808 27 04            [ 1] 1141 	jreq	00113$
      00880A                       1142 00112$:
      00880A 57               [ 2] 1143 	sraw	x
      00880B 4A               [ 1] 1144 	dec	a
      00880C 26 FC            [ 1] 1145 	jrne	00112$
      00880E                       1146 00113$:
      00880E 54               [ 2] 1147 	srlw	x
      00880F 24 03            [ 1] 1148 	jrnc	00103$
      008811 5F               [ 1] 1149 	clrw	x
      008812 5C               [ 1] 1150 	incw	x
      008813 21                    1151 	.byte 0x21
      008814                       1152 00103$:
      008814 5F               [ 1] 1153 	clrw	x
      008815                       1154 00104$:
                                   1155 ;	./libs/ssd1306_lib.c: 6: }
      008815 90 85            [ 2] 1156 	popw	y
      008817 5B 02            [ 2] 1157 	addw	sp, #2
      008819 90 FC            [ 2] 1158 	jp	(y)
                                   1159 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                   1160 ;	-----------------------------------------
                                   1161 ;	 function set_bit
                                   1162 ;	-----------------------------------------
      00881B                       1163 _set_bit:
      00881B 52 04            [ 2] 1164 	sub	sp, #4
      00881D 1F 01            [ 2] 1165 	ldw	(0x01, sp), x
                                   1166 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      00881F 5F               [ 1] 1167 	clrw	x
      008820 5C               [ 1] 1168 	incw	x
      008821 1F 03            [ 2] 1169 	ldw	(0x03, sp), x
      008823 7B 08            [ 1] 1170 	ld	a, (0x08, sp)
      008825 27 07            [ 1] 1171 	jreq	00114$
      008827                       1172 00113$:
      008827 08 04            [ 1] 1173 	sll	(0x04, sp)
      008829 09 03            [ 1] 1174 	rlc	(0x03, sp)
      00882B 4A               [ 1] 1175 	dec	a
      00882C 26 F9            [ 1] 1176 	jrne	00113$
      00882E                       1177 00114$:
                                   1178 ;	./libs/ssd1306_lib.c: 10: switch(value)
      00882E 1E 09            [ 2] 1179 	ldw	x, (0x09, sp)
      008830 5A               [ 2] 1180 	decw	x
      008831 26 0B            [ 1] 1181 	jrne	00102$
                                   1182 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      008833 7B 02            [ 1] 1183 	ld	a, (0x02, sp)
      008835 1A 04            [ 1] 1184 	or	a, (0x04, sp)
      008837 97               [ 1] 1185 	ld	xl, a
      008838 7B 01            [ 1] 1186 	ld	a, (0x01, sp)
      00883A 1A 03            [ 1] 1187 	or	a, (0x03, sp)
                                   1188 ;	./libs/ssd1306_lib.c: 14: break;
      00883C 20 09            [ 2] 1189 	jra	00103$
                                   1190 ;	./libs/ssd1306_lib.c: 16: default:
      00883E                       1191 00102$:
                                   1192 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      00883E 1E 03            [ 2] 1193 	ldw	x, (0x03, sp)
      008840 53               [ 2] 1194 	cplw	x
      008841 9F               [ 1] 1195 	ld	a, xl
      008842 14 02            [ 1] 1196 	and	a, (0x02, sp)
      008844 02               [ 1] 1197 	rlwa	x
      008845 14 01            [ 1] 1198 	and	a, (0x01, sp)
                                   1199 ;	./libs/ssd1306_lib.c: 19: }
      008847                       1200 00103$:
                                   1201 ;	./libs/ssd1306_lib.c: 20: return data;
      008847 95               [ 1] 1202 	ld	xh, a
                                   1203 ;	./libs/ssd1306_lib.c: 21: }
      008848 16 05            [ 2] 1204 	ldw	y, (5, sp)
      00884A 5B 0A            [ 2] 1205 	addw	sp, #10
      00884C 90 FC            [ 2] 1206 	jp	(y)
                                   1207 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                   1208 ;	-----------------------------------------
                                   1209 ;	 function ssd1306_init
                                   1210 ;	-----------------------------------------
      00884E                       1211 _ssd1306_init:
      00884E 52 1B            [ 2] 1212 	sub	sp, #27
                                   1213 ;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
      008850 96               [ 1] 1214 	ldw	x, sp
      008851 5C               [ 1] 1215 	incw	x
      008852 7F               [ 1] 1216 	clr	(x)
      008853 A6 AE            [ 1] 1217 	ld	a, #0xae
      008855 6B 02            [ 1] 1218 	ld	(0x02, sp), a
      008857 A6 D5            [ 1] 1219 	ld	a, #0xd5
      008859 6B 03            [ 1] 1220 	ld	(0x03, sp), a
      00885B A6 80            [ 1] 1221 	ld	a, #0x80
      00885D 6B 04            [ 1] 1222 	ld	(0x04, sp), a
      00885F A6 A8            [ 1] 1223 	ld	a, #0xa8
      008861 6B 05            [ 1] 1224 	ld	(0x05, sp), a
      008863 A6 1F            [ 1] 1225 	ld	a, #0x1f
      008865 6B 06            [ 1] 1226 	ld	(0x06, sp), a
      008867 A6 D3            [ 1] 1227 	ld	a, #0xd3
      008869 6B 07            [ 1] 1228 	ld	(0x07, sp), a
      00886B 0F 08            [ 1] 1229 	clr	(0x08, sp)
      00886D A6 40            [ 1] 1230 	ld	a, #0x40
      00886F 6B 09            [ 1] 1231 	ld	(0x09, sp), a
      008871 A6 8D            [ 1] 1232 	ld	a, #0x8d
      008873 6B 0A            [ 1] 1233 	ld	(0x0a, sp), a
      008875 A6 14            [ 1] 1234 	ld	a, #0x14
      008877 6B 0B            [ 1] 1235 	ld	(0x0b, sp), a
      008879 A6 DB            [ 1] 1236 	ld	a, #0xdb
      00887B 6B 0C            [ 1] 1237 	ld	(0x0c, sp), a
      00887D A6 40            [ 1] 1238 	ld	a, #0x40
      00887F 6B 0D            [ 1] 1239 	ld	(0x0d, sp), a
      008881 A6 A4            [ 1] 1240 	ld	a, #0xa4
      008883 6B 0E            [ 1] 1241 	ld	(0x0e, sp), a
      008885 A6 A6            [ 1] 1242 	ld	a, #0xa6
      008887 6B 0F            [ 1] 1243 	ld	(0x0f, sp), a
      008889 A6 DA            [ 1] 1244 	ld	a, #0xda
      00888B 6B 10            [ 1] 1245 	ld	(0x10, sp), a
      00888D A6 02            [ 1] 1246 	ld	a, #0x02
      00888F 6B 11            [ 1] 1247 	ld	(0x11, sp), a
      008891 A6 81            [ 1] 1248 	ld	a, #0x81
      008893 6B 12            [ 1] 1249 	ld	(0x12, sp), a
      008895 A6 8F            [ 1] 1250 	ld	a, #0x8f
      008897 6B 13            [ 1] 1251 	ld	(0x13, sp), a
      008899 A6 D9            [ 1] 1252 	ld	a, #0xd9
      00889B 6B 14            [ 1] 1253 	ld	(0x14, sp), a
      00889D A6 F1            [ 1] 1254 	ld	a, #0xf1
      00889F 6B 15            [ 1] 1255 	ld	(0x15, sp), a
      0088A1 A6 20            [ 1] 1256 	ld	a, #0x20
      0088A3 6B 16            [ 1] 1257 	ld	(0x16, sp), a
      0088A5 0F 17            [ 1] 1258 	clr	(0x17, sp)
      0088A7 A6 A0            [ 1] 1259 	ld	a, #0xa0
      0088A9 6B 18            [ 1] 1260 	ld	(0x18, sp), a
      0088AB A6 C0            [ 1] 1261 	ld	a, #0xc0
      0088AD 6B 19            [ 1] 1262 	ld	(0x19, sp), a
      0088AF A6 1F            [ 1] 1263 	ld	a, #0x1f
      0088B1 6B 1A            [ 1] 1264 	ld	(0x1a, sp), a
      0088B3 A6 AF            [ 1] 1265 	ld	a, #0xaf
      0088B5 6B 1B            [ 1] 1266 	ld	(0x1b, sp), a
                                   1267 ;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
      0088B7 89               [ 2] 1268 	pushw	x
      0088B8 4B 1B            [ 1] 1269 	push	#0x1b
      0088BA A6 3C            [ 1] 1270 	ld	a, #0x3c
      0088BC CD 87 8E         [ 4] 1271 	call	_i2c_write
                                   1272 ;	./libs/ssd1306_lib.c: 43: }
      0088BF 5B 1B            [ 2] 1273 	addw	sp, #27
      0088C1 81               [ 4] 1274 	ret
                                   1275 ;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
                                   1276 ;	-----------------------------------------
                                   1277 ;	 function ssd1306_set_params_to_write
                                   1278 ;	-----------------------------------------
      0088C2                       1279 _ssd1306_set_params_to_write:
      0088C2 52 07            [ 2] 1280 	sub	sp, #7
                                   1281 ;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
      0088C4 96               [ 1] 1282 	ldw	x, sp
      0088C5 5C               [ 1] 1283 	incw	x
      0088C6 7F               [ 1] 1284 	clr	(x)
      0088C7 A6 22            [ 1] 1285 	ld	a, #0x22
      0088C9 6B 02            [ 1] 1286 	ld	(0x02, sp), a
      0088CB 0F 03            [ 1] 1287 	clr	(0x03, sp)
      0088CD A6 03            [ 1] 1288 	ld	a, #0x03
      0088CF 6B 04            [ 1] 1289 	ld	(0x04, sp), a
      0088D1 A6 21            [ 1] 1290 	ld	a, #0x21
      0088D3 6B 05            [ 1] 1291 	ld	(0x05, sp), a
      0088D5 0F 06            [ 1] 1292 	clr	(0x06, sp)
      0088D7 A6 7F            [ 1] 1293 	ld	a, #0x7f
      0088D9 6B 07            [ 1] 1294 	ld	(0x07, sp), a
                                   1295 ;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      0088DB 89               [ 2] 1296 	pushw	x
      0088DC 4B 07            [ 1] 1297 	push	#0x07
      0088DE A6 3C            [ 1] 1298 	ld	a, #0x3c
      0088E0 CD 87 8E         [ 4] 1299 	call	_i2c_write
                                   1300 ;	./libs/ssd1306_lib.c: 52: }
      0088E3 5B 07            [ 2] 1301 	addw	sp, #7
      0088E5 81               [ 4] 1302 	ret
                                   1303 ;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1304 ;	-----------------------------------------
                                   1305 ;	 function ssd1306_draw_pixel
                                   1306 ;	-----------------------------------------
      0088E6                       1307 _ssd1306_draw_pixel:
      0088E6 52 08            [ 2] 1308 	sub	sp, #8
      0088E8 1F 07            [ 2] 1309 	ldw	(0x07, sp), x
                                   1310 ;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      0088EA 6B 06            [ 1] 1311 	ld	(0x06, sp), a
      0088EC 0F 05            [ 1] 1312 	clr	(0x05, sp)
      0088EE 7B 0B            [ 1] 1313 	ld	a, (0x0b, sp)
      0088F0 0F 01            [ 1] 1314 	clr	(0x01, sp)
      0088F2 97               [ 1] 1315 	ld	xl, a
      0088F3 02               [ 1] 1316 	rlwa	x
      0088F4 4F               [ 1] 1317 	clr	a
      0088F5 01               [ 1] 1318 	rrwa	x
      0088F6 5D               [ 2] 1319 	tnzw	x
      0088F7 2A 03            [ 1] 1320 	jrpl	00103$
      0088F9 1C 00 07         [ 2] 1321 	addw	x, #0x0007
      0088FC                       1322 00103$:
      0088FC 57               [ 2] 1323 	sraw	x
      0088FD 57               [ 2] 1324 	sraw	x
      0088FE 57               [ 2] 1325 	sraw	x
      0088FF 58               [ 2] 1326 	sllw	x
      008900 58               [ 2] 1327 	sllw	x
      008901 58               [ 2] 1328 	sllw	x
      008902 58               [ 2] 1329 	sllw	x
      008903 58               [ 2] 1330 	sllw	x
      008904 58               [ 2] 1331 	sllw	x
      008905 58               [ 2] 1332 	sllw	x
      008906 72 FB 05         [ 2] 1333 	addw	x, (0x05, sp)
      008909 72 FB 07         [ 2] 1334 	addw	x, (0x07, sp)
      00890C 1F 03            [ 2] 1335 	ldw	(0x03, sp), x
      00890E 90 5F            [ 1] 1336 	clrw	y
      008910 61               [ 1] 1337 	exg	a, yl
      008911 7B 0C            [ 1] 1338 	ld	a, (0x0c, sp)
      008913 61               [ 1] 1339 	exg	a, yl
      008914 A4 07            [ 1] 1340 	and	a, #0x07
      008916 6B 06            [ 1] 1341 	ld	(0x06, sp), a
      008918 0F 05            [ 1] 1342 	clr	(0x05, sp)
      00891A 1E 03            [ 2] 1343 	ldw	x, (0x03, sp)
      00891C F6               [ 1] 1344 	ld	a, (x)
      00891D 5F               [ 1] 1345 	clrw	x
      00891E 90 89            [ 2] 1346 	pushw	y
      008920 16 07            [ 2] 1347 	ldw	y, (0x07, sp)
      008922 90 89            [ 2] 1348 	pushw	y
      008924 97               [ 1] 1349 	ld	xl, a
      008925 CD 88 1B         [ 4] 1350 	call	_set_bit
      008928 9F               [ 1] 1351 	ld	a, xl
      008929 1E 03            [ 2] 1352 	ldw	x, (0x03, sp)
      00892B F7               [ 1] 1353 	ld	(x), a
                                   1354 ;	./libs/ssd1306_lib.c: 57: }
      00892C 1E 09            [ 2] 1355 	ldw	x, (9, sp)
      00892E 5B 0C            [ 2] 1356 	addw	sp, #12
      008930 FC               [ 2] 1357 	jp	(x)
                                   1358 ;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
                                   1359 ;	-----------------------------------------
                                   1360 ;	 function ssd1306_buffer_clean
                                   1361 ;	-----------------------------------------
      008931                       1362 _ssd1306_buffer_clean:
                                   1363 ;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
      008931 4B 00            [ 1] 1364 	push	#0x00
      008933 4B 02            [ 1] 1365 	push	#0x02
      008935 5F               [ 1] 1366 	clrw	x
      008936 89               [ 2] 1367 	pushw	x
      008937 AE 01 68         [ 2] 1368 	ldw	x, #(_main_buffer+0)
      00893A CD 8A B3         [ 4] 1369 	call	_memset
                                   1370 ;	./libs/ssd1306_lib.c: 62: }
      00893D 81               [ 4] 1371 	ret
                                   1372 ;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
                                   1373 ;	-----------------------------------------
                                   1374 ;	 function ssd1306_send_buffer
                                   1375 ;	-----------------------------------------
      00893E                       1376 _ssd1306_send_buffer:
      00893E 52 04            [ 2] 1377 	sub	sp, #4
                                   1378 ;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
      008940 CD 88 C2         [ 4] 1379 	call	_ssd1306_set_params_to_write
                                   1380 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008943 5F               [ 1] 1381 	clrw	x
      008944 1F 03            [ 2] 1382 	ldw	(0x03, sp), x
      008946                       1383 00112$:
      008946 1E 03            [ 2] 1384 	ldw	x, (0x03, sp)
      008948 A3 00 04         [ 2] 1385 	cpw	x, #0x0004
      00894B 2E 43            [ 1] 1386 	jrsge	00114$
                                   1387 ;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
      00894D 4B 00            [ 1] 1388 	push	#0x00
      00894F A6 3C            [ 1] 1389 	ld	a, #0x3c
      008951 CD 86 F5         [ 4] 1390 	call	_i2c_send_address
      008954 4D               [ 1] 1391 	tnz	a
      008955 27 2F            [ 1] 1392 	jreq	00105$
                                   1393 ;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
      008957 A6 40            [ 1] 1394 	ld	a, #0x40
      008959 CD 87 7C         [ 4] 1395 	call	_i2c_send_byte
                                   1396 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      00895C 1E 03            [ 2] 1397 	ldw	x, (0x03, sp)
      00895E 58               [ 2] 1398 	sllw	x
      00895F 58               [ 2] 1399 	sllw	x
      008960 58               [ 2] 1400 	sllw	x
      008961 58               [ 2] 1401 	sllw	x
      008962 58               [ 2] 1402 	sllw	x
      008963 58               [ 2] 1403 	sllw	x
      008964 58               [ 2] 1404 	sllw	x
      008965 1F 01            [ 2] 1405 	ldw	(0x01, sp), x
      008967 5F               [ 1] 1406 	clrw	x
      008968                       1407 00109$:
      008968 A3 00 80         [ 2] 1408 	cpw	x, #0x0080
      00896B 2E 14            [ 1] 1409 	jrsge	00103$
                                   1410 ;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i+(128*j)]))//Проверка на АСК бит
      00896D 90 93            [ 1] 1411 	ldw	y, x
      00896F 72 F9 01         [ 2] 1412 	addw	y, (0x01, sp)
      008972 90 D6 01 68      [ 1] 1413 	ld	a, (_main_buffer+0, y)
      008976 89               [ 2] 1414 	pushw	x
      008977 CD 87 7C         [ 4] 1415 	call	_i2c_send_byte
      00897A 85               [ 2] 1416 	popw	x
      00897B 4D               [ 1] 1417 	tnz	a
      00897C 26 03            [ 1] 1418 	jrne	00103$
                                   1419 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      00897E 5C               [ 1] 1420 	incw	x
      00897F 20 E7            [ 2] 1421 	jra	00109$
      008981                       1422 00103$:
                                   1423 ;	./libs/ssd1306_lib.c: 78: i2c_stop();
      008981 CD 86 F0         [ 4] 1424 	call	_i2c_stop
      008984 20 03            [ 2] 1425 	jra	00113$
      008986                       1426 00105$:
                                   1427 ;	./libs/ssd1306_lib.c: 81: i2c_stop();
      008986 CD 86 F0         [ 4] 1428 	call	_i2c_stop
      008989                       1429 00113$:
                                   1430 ;	./libs/ssd1306_lib.c: 66: for(int j = 0;j<4;j++)
      008989 1E 03            [ 2] 1431 	ldw	x, (0x03, sp)
      00898B 5C               [ 1] 1432 	incw	x
      00898C 1F 03            [ 2] 1433 	ldw	(0x03, sp), x
      00898E 20 B6            [ 2] 1434 	jra	00112$
      008990                       1435 00114$:
                                   1436 ;	./libs/ssd1306_lib.c: 83: }
      008990 5B 04            [ 2] 1437 	addw	sp, #4
      008992 81               [ 4] 1438 	ret
                                   1439 ;	./libs/ssd1306_lib.c: 85: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
                                   1440 ;	-----------------------------------------
                                   1441 ;	 function ssd1306_buffer_write
                                   1442 ;	-----------------------------------------
      008993                       1443 _ssd1306_buffer_write:
      008993 52 0A            [ 2] 1444 	sub	sp, #10
      008995 1F 05            [ 2] 1445 	ldw	(0x05, sp), x
                                   1446 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      008997 5F               [ 1] 1447 	clrw	x
      008998 1F 07            [ 2] 1448 	ldw	(0x07, sp), x
      00899A                       1449 00109$:
      00899A 1E 07            [ 2] 1450 	ldw	x, (0x07, sp)
      00899C A3 00 08         [ 2] 1451 	cpw	x, #0x0008
      00899F 2F 03            [ 1] 1452 	jrslt	00150$
      0089A1 CC 8A 22         [ 2] 1453 	jp	00111$
      0089A4                       1454 00150$:
                                   1455 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      0089A4 5F               [ 1] 1456 	clrw	x
      0089A5 1F 09            [ 2] 1457 	ldw	(0x09, sp), x
      0089A7                       1458 00106$:
      0089A7 1E 09            [ 2] 1459 	ldw	x, (0x09, sp)
      0089A9 A3 00 08         [ 2] 1460 	cpw	x, #0x0008
      0089AC 2E 6C            [ 1] 1461 	jrsge	00110$
                                   1462 ;	./libs/ssd1306_lib.c: 90: if(data[height + width / 8] & (128 >> (width & 7)))
      0089AE 1E 07            [ 2] 1463 	ldw	x, (0x07, sp)
      0089B0 72 FB 0F         [ 2] 1464 	addw	x, (0x0f, sp)
      0089B3 F6               [ 1] 1465 	ld	a, (x)
      0089B4 97               [ 1] 1466 	ld	xl, a
      0089B5 7B 0A            [ 1] 1467 	ld	a, (0x0a, sp)
      0089B7 A4 07            [ 1] 1468 	and	a, #0x07
      0089B9 90 AE 00 80      [ 2] 1469 	ldw	y, #0x0080
      0089BD 4D               [ 1] 1470 	tnz	a
      0089BE 27 05            [ 1] 1471 	jreq	00153$
      0089C0                       1472 00152$:
      0089C0 90 57            [ 2] 1473 	sraw	y
      0089C2 4A               [ 1] 1474 	dec	a
      0089C3 26 FB            [ 1] 1475 	jrne	00152$
      0089C5                       1476 00153$:
      0089C5 17 01            [ 2] 1477 	ldw	(0x01, sp), y
      0089C7 9F               [ 1] 1478 	ld	a, xl
      0089C8 14 02            [ 1] 1479 	and	a, (0x02, sp)
      0089CA 6B 04            [ 1] 1480 	ld	(0x04, sp), a
      0089CC 0F 03            [ 1] 1481 	clr	(0x03, sp)
      0089CE 1E 03            [ 2] 1482 	ldw	x, (0x03, sp)
      0089D0 27 41            [ 1] 1483 	jreq	00107$
                                   1484 ;	./libs/ssd1306_lib.c: 91: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(data[height + width], 7 - (width % 8)));
      0089D2 4B 08            [ 1] 1485 	push	#0x08
      0089D4 4B 00            [ 1] 1486 	push	#0x00
      0089D6 1E 0B            [ 2] 1487 	ldw	x, (0x0b, sp)
      0089D8 CD 8A D7         [ 4] 1488 	call	__modsint
      0089DB 1F 03            [ 2] 1489 	ldw	(0x03, sp), x
      0089DD 90 AE 00 07      [ 2] 1490 	ldw	y, #0x0007
      0089E1 72 F2 03         [ 2] 1491 	subw	y, (0x03, sp)
      0089E4 1E 07            [ 2] 1492 	ldw	x, (0x07, sp)
      0089E6 72 FB 09         [ 2] 1493 	addw	x, (0x09, sp)
      0089E9 72 FB 0F         [ 2] 1494 	addw	x, (0x0f, sp)
      0089EC F6               [ 1] 1495 	ld	a, (x)
      0089ED 5F               [ 1] 1496 	clrw	x
      0089EE 90 89            [ 2] 1497 	pushw	y
      0089F0 97               [ 1] 1498 	ld	xl, a
      0089F1 CD 88 06         [ 4] 1499 	call	_get_bit
      0089F4 7B 0E            [ 1] 1500 	ld	a, (0x0e, sp)
      0089F6 6B 04            [ 1] 1501 	ld	(0x04, sp), a
      0089F8 7B 08            [ 1] 1502 	ld	a, (0x08, sp)
      0089FA 1B 04            [ 1] 1503 	add	a, (0x04, sp)
      0089FC 95               [ 1] 1504 	ld	xh, a
      0089FD 7B 06            [ 1] 1505 	ld	a, (0x06, sp)
      0089FF 6B 04            [ 1] 1506 	ld	(0x04, sp), a
      008A01 7B 0A            [ 1] 1507 	ld	a, (0x0a, sp)
      008A03 1B 04            [ 1] 1508 	add	a, (0x04, sp)
      008A05 6B 04            [ 1] 1509 	ld	(0x04, sp), a
      008A07 9F               [ 1] 1510 	ld	a, xl
      008A08 88               [ 1] 1511 	push	a
      008A09 9E               [ 1] 1512 	ld	a, xh
      008A0A 88               [ 1] 1513 	push	a
      008A0B 7B 06            [ 1] 1514 	ld	a, (0x06, sp)
      008A0D AE 01 68         [ 2] 1515 	ldw	x, #(_main_buffer+0)
      008A10 CD 88 E6         [ 4] 1516 	call	_ssd1306_draw_pixel
      008A13                       1517 00107$:
                                   1518 ;	./libs/ssd1306_lib.c: 89: for (int width = 0; width < 8; width++)
      008A13 1E 09            [ 2] 1519 	ldw	x, (0x09, sp)
      008A15 5C               [ 1] 1520 	incw	x
      008A16 1F 09            [ 2] 1521 	ldw	(0x09, sp), x
      008A18 20 8D            [ 2] 1522 	jra	00106$
      008A1A                       1523 00110$:
                                   1524 ;	./libs/ssd1306_lib.c: 87: for (int height = 0; height < 8; height++)
      008A1A 1E 07            [ 2] 1525 	ldw	x, (0x07, sp)
      008A1C 5C               [ 1] 1526 	incw	x
      008A1D 1F 07            [ 2] 1527 	ldw	(0x07, sp), x
      008A1F CC 89 9A         [ 2] 1528 	jp	00109$
      008A22                       1529 00111$:
                                   1530 ;	./libs/ssd1306_lib.c: 93: }
      008A22 1E 0B            [ 2] 1531 	ldw	x, (11, sp)
      008A24 5B 10            [ 2] 1532 	addw	sp, #16
      008A26 FC               [ 2] 1533 	jp	(x)
                                   1534 ;	./libs/ssd1306_lib.c: 95: void ssd1306_clean(void)
                                   1535 ;	-----------------------------------------
                                   1536 ;	 function ssd1306_clean
                                   1537 ;	-----------------------------------------
      008A27                       1538 _ssd1306_clean:
                                   1539 ;	./libs/ssd1306_lib.c: 97: ssd1306_buffer_clean();
      008A27 CD 89 31         [ 4] 1540 	call	_ssd1306_buffer_clean
                                   1541 ;	./libs/ssd1306_lib.c: 98: ssd1306_send_buffer();
                                   1542 ;	./libs/ssd1306_lib.c: 99: }
      008A2A CC 89 3E         [ 2] 1543 	jp	_ssd1306_send_buffer
                                   1544 ;	./libs/tmr2_lib.c: 3: void tmr2_irq(void) __interrupt(TIM2_vector)
                                   1545 ;	-----------------------------------------
                                   1546 ;	 function tmr2_irq
                                   1547 ;	-----------------------------------------
      008A2D                       1548 _tmr2_irq:
      008A2D 4F               [ 1] 1549 	clr	a
      008A2E 62               [ 2] 1550 	div	x, a
                                   1551 ;	./libs/tmr2_lib.c: 5: TIM2_CR1->CEN = 0;
      008A2F AE 53 00         [ 2] 1552 	ldw	x, #0x5300
      008A32 F6               [ 1] 1553 	ld	a, (x)
      008A33 A4 FE            [ 1] 1554 	and	a, #0xfe
      008A35 F7               [ 1] 1555 	ld	(x), a
                                   1556 ;	./libs/tmr2_lib.c: 6: disableInterrupts();
      008A36 9B               [ 1] 1557 	sim
                                   1558 ;	./libs/tmr2_lib.c: 7: TIM2_IRQ.all = 0;//обнуление флагов регистров
      008A37 35 00 03 68      [ 1] 1559 	mov	_TIM2_IRQ+0, #0x00
                                   1560 ;	./libs/tmr2_lib.c: 9: if(TIM2_SR1 -> UIF)//прерывание таймера
      008A3B AE 53 04         [ 2] 1561 	ldw	x, #0x5304
      008A3E F6               [ 1] 1562 	ld	a, (x)
      008A3F A4 01            [ 1] 1563 	and	a, #0x01
      008A41 27 0B            [ 1] 1564 	jreq	00102$
                                   1565 ;	./libs/tmr2_lib.c: 11: TIM2_IRQ.UIF = 1;
      008A43 72 1E 03 68      [ 1] 1566 	bset	_TIM2_IRQ+0, #7
                                   1567 ;	./libs/tmr2_lib.c: 12: TIM2_IER -> UIE = 0;
      008A47 AE 53 03         [ 2] 1568 	ldw	x, #0x5303
      008A4A F6               [ 1] 1569 	ld	a, (x)
      008A4B A4 FE            [ 1] 1570 	and	a, #0xfe
      008A4D F7               [ 1] 1571 	ld	(x), a
      008A4E                       1572 00102$:
                                   1573 ;	./libs/tmr2_lib.c: 14: enableInterrupts();
      008A4E 9A               [ 1] 1574 	rim
                                   1575 ;	./libs/tmr2_lib.c: 15: }
      008A4F 80               [11] 1576 	iret
                                   1577 ;	./libs/tmr2_lib.c: 16: void delay_s(uint8_t ticks)
                                   1578 ;	-----------------------------------------
                                   1579 ;	 function delay_s
                                   1580 ;	-----------------------------------------
      008A50                       1581 _delay_s:
      008A50 52 05            [ 2] 1582 	sub	sp, #5
      008A52 6B 03            [ 1] 1583 	ld	(0x03, sp), a
                                   1584 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks;i++)
      008A54 5F               [ 1] 1585 	clrw	x
      008A55 1F 04            [ 2] 1586 	ldw	(0x04, sp), x
      008A57                       1587 00106$:
      008A57 7B 03            [ 1] 1588 	ld	a, (0x03, sp)
      008A59 6B 02            [ 1] 1589 	ld	(0x02, sp), a
      008A5B 0F 01            [ 1] 1590 	clr	(0x01, sp)
      008A5D 1E 04            [ 2] 1591 	ldw	x, (0x04, sp)
      008A5F 13 01            [ 2] 1592 	cpw	x, (0x01, sp)
      008A61 2E 26            [ 1] 1593 	jrsge	00108$
                                   1594 ;	./libs/tmr2_lib.c: 20: TIM2_ARRH->ARR = 0x00;
      008A63 35 00 53 0F      [ 1] 1595 	mov	0x530f+0, #0x00
                                   1596 ;	./libs/tmr2_lib.c: 21: TIM2_ARRL->ARR = 0x01;
      008A67 35 01 53 10      [ 1] 1597 	mov	0x5310+0, #0x01
                                   1598 ;	./libs/tmr2_lib.c: 22: TIM2_PSCR -> PSC = 0x0E;
      008A6B C6 53 0E         [ 1] 1599 	ld	a, 0x530e
      008A6E A4 F0            [ 1] 1600 	and	a, #0xf0
      008A70 AA 0E            [ 1] 1601 	or	a, #0x0e
      008A72 C7 53 0E         [ 1] 1602 	ld	0x530e, a
                                   1603 ;	./libs/tmr2_lib.c: 23: TIM2_IER -> UIE = 1;
      008A75 72 10 53 03      [ 1] 1604 	bset	0x5303, #0
                                   1605 ;	./libs/tmr2_lib.c: 24: TIM2_CR1-> CEN = 1;
      008A79 72 10 53 00      [ 1] 1606 	bset	0x5300, #0
                                   1607 ;	./libs/tmr2_lib.c: 25: while(TIM2_IER -> UIE);
      008A7D                       1608 00101$:
      008A7D 72 00 53 03 FB   [ 2] 1609 	btjt	0x5303, #0, 00101$
                                   1610 ;	./libs/tmr2_lib.c: 18: for(int i = 0;i<ticks;i++)
      008A82 1E 04            [ 2] 1611 	ldw	x, (0x04, sp)
      008A84 5C               [ 1] 1612 	incw	x
      008A85 1F 04            [ 2] 1613 	ldw	(0x04, sp), x
      008A87 20 CE            [ 2] 1614 	jra	00106$
      008A89                       1615 00108$:
                                   1616 ;	./libs/tmr2_lib.c: 28: }
      008A89 5B 05            [ 2] 1617 	addw	sp, #5
      008A8B 81               [ 4] 1618 	ret
                                   1619 ;	main.c: 3: void setup(void)
                                   1620 ;	-----------------------------------------
                                   1621 ;	 function setup
                                   1622 ;	-----------------------------------------
      008A8C                       1623 _setup:
                                   1624 ;	main.c: 6: CLK_CKDIVR = 0;
      008A8C 35 00 50 C6      [ 1] 1625 	mov	0x50c6+0, #0x00
                                   1626 ;	main.c: 8: uart_init(9600,0);
      008A90 4F               [ 1] 1627 	clr	a
      008A91 AE 25 80         [ 2] 1628 	ldw	x, #0x2580
      008A94 CD 84 9A         [ 4] 1629 	call	_uart_init
                                   1630 ;	main.c: 9: i2c_init();
      008A97 CD 86 BB         [ 4] 1631 	call	_i2c_init
                                   1632 ;	main.c: 11: enableInterrupts();
      008A9A 9A               [ 1] 1633 	rim
                                   1634 ;	main.c: 12: }
      008A9B 81               [ 4] 1635 	ret
                                   1636 ;	main.c: 14: void gg(void)
                                   1637 ;	-----------------------------------------
                                   1638 ;	 function gg
                                   1639 ;	-----------------------------------------
      008A9C                       1640 _gg:
                                   1641 ;	main.c: 16: ssd1306_init();
      008A9C CD 88 4E         [ 4] 1642 	call	_ssd1306_init
                                   1643 ;	main.c: 17: ssd1306_send_buffer();
      008A9F CD 89 3E         [ 4] 1644 	call	_ssd1306_send_buffer
                                   1645 ;	main.c: 18: delay_s(0x01);
      008AA2 A6 01            [ 1] 1646 	ld	a, #0x01
      008AA4 CD 8A 50         [ 4] 1647 	call	_delay_s
                                   1648 ;	main.c: 19: ssd1306_clean();
                                   1649 ;	main.c: 21: }
      008AA7 CC 8A 27         [ 2] 1650 	jp	_ssd1306_clean
                                   1651 ;	main.c: 23: int main(void)
                                   1652 ;	-----------------------------------------
                                   1653 ;	 function main
                                   1654 ;	-----------------------------------------
      008AAA                       1655 _main:
                                   1656 ;	main.c: 25: setup();
      008AAA CD 8A 8C         [ 4] 1657 	call	_setup
                                   1658 ;	main.c: 26: gg();
      008AAD CD 8A 9C         [ 4] 1659 	call	_gg
                                   1660 ;	main.c: 27: while(1);
      008AB0                       1661 00102$:
      008AB0 20 FE            [ 2] 1662 	jra	00102$
                                   1663 ;	main.c: 28: }
      008AB2 81               [ 4] 1664 	ret
                                   1665 	.area CODE
                                   1666 	.area CONST
                                   1667 	.area INITIALIZER
      008081                       1668 __xinit__I2C_IRQ:
      008081 00                    1669 	.db #0x00	; 0
      008082                       1670 __xinit__ttf_eng_a:
      008082 00                    1671 	.db #0x00	; 0
      008083 7E                    1672 	.db #0x7e	; 126
      008084 42                    1673 	.db #0x42	; 66	'B'
      008085 42                    1674 	.db #0x42	; 66	'B'
      008086 7E                    1675 	.db #0x7e	; 126
      008087 42                    1676 	.db #0x42	; 66	'B'
      008088 42                    1677 	.db #0x42	; 66	'B'
      008089 00                    1678 	.db #0x00	; 0
      00808A                       1679 __xinit__ttf_eng_b:
      00808A 00                    1680 	.db #0x00	; 0
      00808B 7C                    1681 	.db #0x7c	; 124
      00808C 42                    1682 	.db #0x42	; 66	'B'
      00808D 7C                    1683 	.db #0x7c	; 124
      00808E 42                    1684 	.db #0x42	; 66	'B'
      00808F 42                    1685 	.db #0x42	; 66	'B'
      008090 7C                    1686 	.db #0x7c	; 124
      008091 00                    1687 	.db #0x00	; 0
      008092                       1688 __xinit__ttf_eng_c:
      008092 00                    1689 	.db #0x00	; 0
      008093 7E                    1690 	.db #0x7e	; 126
      008094 40                    1691 	.db #0x40	; 64
      008095 40                    1692 	.db #0x40	; 64
      008096 40                    1693 	.db #0x40	; 64
      008097 40                    1694 	.db #0x40	; 64
      008098 7E                    1695 	.db #0x7e	; 126
      008099 00                    1696 	.db #0x00	; 0
      00809A                       1697 __xinit__ttf_eng_d:
      00809A 00                    1698 	.db #0x00	; 0
      00809B 7C                    1699 	.db #0x7c	; 124
      00809C 42                    1700 	.db #0x42	; 66	'B'
      00809D 42                    1701 	.db #0x42	; 66	'B'
      00809E 42                    1702 	.db #0x42	; 66	'B'
      00809F 42                    1703 	.db #0x42	; 66	'B'
      0080A0 7C                    1704 	.db #0x7c	; 124
      0080A1 00                    1705 	.db #0x00	; 0
      0080A2                       1706 __xinit__ttf_eng_e:
      0080A2 00                    1707 	.db #0x00	; 0
      0080A3 7E                    1708 	.db #0x7e	; 126
      0080A4 40                    1709 	.db #0x40	; 64
      0080A5 7C                    1710 	.db #0x7c	; 124
      0080A6 40                    1711 	.db #0x40	; 64
      0080A7 40                    1712 	.db #0x40	; 64
      0080A8 7E                    1713 	.db #0x7e	; 126
      0080A9 00                    1714 	.db #0x00	; 0
      0080AA                       1715 __xinit__ttf_eng_f:
      0080AA 00                    1716 	.db #0x00	; 0
      0080AB 7E                    1717 	.db #0x7e	; 126
      0080AC 40                    1718 	.db #0x40	; 64
      0080AD 40                    1719 	.db #0x40	; 64
      0080AE 7C                    1720 	.db #0x7c	; 124
      0080AF 40                    1721 	.db #0x40	; 64
      0080B0 40                    1722 	.db #0x40	; 64
      0080B1 00                    1723 	.db #0x00	; 0
      0080B2                       1724 __xinit__ttf_eng_g:
      0080B2 00                    1725 	.db #0x00	; 0
      0080B3 7E                    1726 	.db #0x7e	; 126
      0080B4 42                    1727 	.db #0x42	; 66	'B'
      0080B5 40                    1728 	.db #0x40	; 64
      0080B6 4E                    1729 	.db #0x4e	; 78	'N'
      0080B7 42                    1730 	.db #0x42	; 66	'B'
      0080B8 7E                    1731 	.db #0x7e	; 126
      0080B9 00                    1732 	.db #0x00	; 0
      0080BA                       1733 __xinit__ttf_eng_h:
      0080BA 00                    1734 	.db #0x00	; 0
      0080BB 42                    1735 	.db #0x42	; 66	'B'
      0080BC 42                    1736 	.db #0x42	; 66	'B'
      0080BD 42                    1737 	.db #0x42	; 66	'B'
      0080BE 7E                    1738 	.db #0x7e	; 126
      0080BF 42                    1739 	.db #0x42	; 66	'B'
      0080C0 42                    1740 	.db #0x42	; 66	'B'
      0080C1 00                    1741 	.db #0x00	; 0
      0080C2                       1742 __xinit__ttf_eng_i:
      0080C2 00                    1743 	.db #0x00	; 0
      0080C3 7E                    1744 	.db #0x7e	; 126
      0080C4 18                    1745 	.db #0x18	; 24
      0080C5 18                    1746 	.db #0x18	; 24
      0080C6 18                    1747 	.db #0x18	; 24
      0080C7 18                    1748 	.db #0x18	; 24
      0080C8 7E                    1749 	.db #0x7e	; 126
      0080C9 00                    1750 	.db #0x00	; 0
      0080CA                       1751 __xinit__ttf_eng_j:
      0080CA 00                    1752 	.db #0x00	; 0
      0080CB 0C                    1753 	.db #0x0c	; 12
      0080CC 0C                    1754 	.db #0x0c	; 12
      0080CD 0C                    1755 	.db #0x0c	; 12
      0080CE 0C                    1756 	.db #0x0c	; 12
      0080CF 6C                    1757 	.db #0x6c	; 108	'l'
      0080D0 7C                    1758 	.db #0x7c	; 124
      0080D1 00                    1759 	.db #0x00	; 0
      0080D2                       1760 __xinit__ttf_eng_k:
      0080D2 00                    1761 	.db #0x00	; 0
      0080D3 66                    1762 	.db #0x66	; 102	'f'
      0080D4 68                    1763 	.db #0x68	; 104	'h'
      0080D5 70                    1764 	.db #0x70	; 112	'p'
      0080D6 70                    1765 	.db #0x70	; 112	'p'
      0080D7 68                    1766 	.db #0x68	; 104	'h'
      0080D8 66                    1767 	.db #0x66	; 102	'f'
      0080D9 00                    1768 	.db #0x00	; 0
      0080DA                       1769 __xinit__ttf_eng_l:
      0080DA 00                    1770 	.db #0x00	; 0
      0080DB 40                    1771 	.db #0x40	; 64
      0080DC 40                    1772 	.db #0x40	; 64
      0080DD 40                    1773 	.db #0x40	; 64
      0080DE 40                    1774 	.db #0x40	; 64
      0080DF 40                    1775 	.db #0x40	; 64
      0080E0 7E                    1776 	.db #0x7e	; 126
      0080E1 00                    1777 	.db #0x00	; 0
      0080E2                       1778 __xinit__ttf_eng_m:
      0080E2 00                    1779 	.db #0x00	; 0
      0080E3 42                    1780 	.db #0x42	; 66	'B'
      0080E4 66                    1781 	.db #0x66	; 102	'f'
      0080E5 5A                    1782 	.db #0x5a	; 90	'Z'
      0080E6 42                    1783 	.db #0x42	; 66	'B'
      0080E7 42                    1784 	.db #0x42	; 66	'B'
      0080E8 42                    1785 	.db #0x42	; 66	'B'
      0080E9 00                    1786 	.db #0x00	; 0
      0080EA                       1787 __xinit__ttf_eng_n:
      0080EA 00                    1788 	.db #0x00	; 0
      0080EB 42                    1789 	.db #0x42	; 66	'B'
      0080EC 62                    1790 	.db #0x62	; 98	'b'
      0080ED 52                    1791 	.db #0x52	; 82	'R'
      0080EE 4A                    1792 	.db #0x4a	; 74	'J'
      0080EF 46                    1793 	.db #0x46	; 70	'F'
      0080F0 42                    1794 	.db #0x42	; 66	'B'
      0080F1 00                    1795 	.db #0x00	; 0
      0080F2                       1796 __xinit__ttf_eng_o:
      0080F2 00                    1797 	.db #0x00	; 0
      0080F3 7E                    1798 	.db #0x7e	; 126
      0080F4 42                    1799 	.db #0x42	; 66	'B'
      0080F5 42                    1800 	.db #0x42	; 66	'B'
      0080F6 42                    1801 	.db #0x42	; 66	'B'
      0080F7 42                    1802 	.db #0x42	; 66	'B'
      0080F8 7E                    1803 	.db #0x7e	; 126
      0080F9 00                    1804 	.db #0x00	; 0
      0080FA                       1805 __xinit__ttf_eng_p:
      0080FA 00                    1806 	.db #0x00	; 0
      0080FB 7E                    1807 	.db #0x7e	; 126
      0080FC 42                    1808 	.db #0x42	; 66	'B'
      0080FD 42                    1809 	.db #0x42	; 66	'B'
      0080FE 7E                    1810 	.db #0x7e	; 126
      0080FF 40                    1811 	.db #0x40	; 64
      008100 40                    1812 	.db #0x40	; 64
      008101 00                    1813 	.db #0x00	; 0
      008102                       1814 __xinit__ttf_eng_q:
      008102 00                    1815 	.db #0x00	; 0
      008103 7E                    1816 	.db #0x7e	; 126
      008104 42                    1817 	.db #0x42	; 66	'B'
      008105 42                    1818 	.db #0x42	; 66	'B'
      008106 42                    1819 	.db #0x42	; 66	'B'
      008107 7E                    1820 	.db #0x7e	; 126
      008108 04                    1821 	.db #0x04	; 4
      008109 00                    1822 	.db #0x00	; 0
      00810A                       1823 __xinit__ttf_eng_r:
      00810A 00                    1824 	.db #0x00	; 0
      00810B 7E                    1825 	.db #0x7e	; 126
      00810C 42                    1826 	.db #0x42	; 66	'B'
      00810D 42                    1827 	.db #0x42	; 66	'B'
      00810E 7C                    1828 	.db #0x7c	; 124
      00810F 42                    1829 	.db #0x42	; 66	'B'
      008110 42                    1830 	.db #0x42	; 66	'B'
      008111 00                    1831 	.db #0x00	; 0
      008112                       1832 __xinit__ttf_eng_s:
      008112 00                    1833 	.db #0x00	; 0
      008113 3E                    1834 	.db #0x3e	; 62
      008114 40                    1835 	.db #0x40	; 64
      008115 3C                    1836 	.db #0x3c	; 60
      008116 02                    1837 	.db #0x02	; 2
      008117 02                    1838 	.db #0x02	; 2
      008118 7C                    1839 	.db #0x7c	; 124
      008119 00                    1840 	.db #0x00	; 0
      00811A                       1841 __xinit__ttf_eng_t:
      00811A 00                    1842 	.db #0x00	; 0
      00811B 7E                    1843 	.db #0x7e	; 126
      00811C 18                    1844 	.db #0x18	; 24
      00811D 18                    1845 	.db #0x18	; 24
      00811E 18                    1846 	.db #0x18	; 24
      00811F 18                    1847 	.db #0x18	; 24
      008120 18                    1848 	.db #0x18	; 24
      008121 00                    1849 	.db #0x00	; 0
      008122                       1850 __xinit__ttf_eng_u:
      008122 00                    1851 	.db #0x00	; 0
      008123 42                    1852 	.db #0x42	; 66	'B'
      008124 42                    1853 	.db #0x42	; 66	'B'
      008125 42                    1854 	.db #0x42	; 66	'B'
      008126 42                    1855 	.db #0x42	; 66	'B'
      008127 42                    1856 	.db #0x42	; 66	'B'
      008128 3E                    1857 	.db #0x3e	; 62
      008129 00                    1858 	.db #0x00	; 0
      00812A                       1859 __xinit__ttf_eng_v:
      00812A 00                    1860 	.db #0x00	; 0
      00812B 42                    1861 	.db #0x42	; 66	'B'
      00812C 42                    1862 	.db #0x42	; 66	'B'
      00812D 42                    1863 	.db #0x42	; 66	'B'
      00812E 24                    1864 	.db #0x24	; 36
      00812F 24                    1865 	.db #0x24	; 36
      008130 18                    1866 	.db #0x18	; 24
      008131 00                    1867 	.db #0x00	; 0
      008132                       1868 __xinit__ttf_eng_w:
      008132 00                    1869 	.db #0x00	; 0
      008133 42                    1870 	.db #0x42	; 66	'B'
      008134 42                    1871 	.db #0x42	; 66	'B'
      008135 42                    1872 	.db #0x42	; 66	'B'
      008136 5A                    1873 	.db #0x5a	; 90	'Z'
      008137 5A                    1874 	.db #0x5a	; 90	'Z'
      008138 24                    1875 	.db #0x24	; 36
      008139 00                    1876 	.db #0x00	; 0
      00813A                       1877 __xinit__ttf_eng_x:
      00813A 00                    1878 	.db #0x00	; 0
      00813B 42                    1879 	.db #0x42	; 66	'B'
      00813C 24                    1880 	.db #0x24	; 36
      00813D 18                    1881 	.db #0x18	; 24
      00813E 18                    1882 	.db #0x18	; 24
      00813F 22                    1883 	.db #0x22	; 34
      008140 42                    1884 	.db #0x42	; 66	'B'
      008141 00                    1885 	.db #0x00	; 0
      008142                       1886 __xinit__ttf_eng_y:
      008142 00                    1887 	.db #0x00	; 0
      008143 42                    1888 	.db #0x42	; 66	'B'
      008144 24                    1889 	.db #0x24	; 36
      008145 18                    1890 	.db #0x18	; 24
      008146 18                    1891 	.db #0x18	; 24
      008147 18                    1892 	.db #0x18	; 24
      008148 18                    1893 	.db #0x18	; 24
      008149 00                    1894 	.db #0x00	; 0
      00814A                       1895 __xinit__ttf_eng_z:
      00814A 00                    1896 	.db #0x00	; 0
      00814B 7E                    1897 	.db #0x7e	; 126
      00814C 04                    1898 	.db #0x04	; 4
      00814D 08                    1899 	.db #0x08	; 8
      00814E 10                    1900 	.db #0x10	; 16
      00814F 20                    1901 	.db #0x20	; 32
      008150 7E                    1902 	.db #0x7e	; 126
      008151 00                    1903 	.db #0x00	; 0
      008152                       1904 __xinit__ttf_eng_1:
      008152 00                    1905 	.db #0x00	; 0
      008153 18                    1906 	.db #0x18	; 24
      008154 38                    1907 	.db #0x38	; 56	'8'
      008155 38                    1908 	.db #0x38	; 56	'8'
      008156 18                    1909 	.db #0x18	; 24
      008157 18                    1910 	.db #0x18	; 24
      008158 18                    1911 	.db #0x18	; 24
      008159 00                    1912 	.db #0x00	; 0
      00815A                       1913 __xinit__ttf_eng_2:
      00815A 00                    1914 	.db #0x00	; 0
      00815B 38                    1915 	.db #0x38	; 56	'8'
      00815C 44                    1916 	.db #0x44	; 68	'D'
      00815D 08                    1917 	.db #0x08	; 8
      00815E 10                    1918 	.db #0x10	; 16
      00815F 20                    1919 	.db #0x20	; 32
      008160 7C                    1920 	.db #0x7c	; 124
      008161 00                    1921 	.db #0x00	; 0
      008162                       1922 __xinit__ttf_eng_3:
      008162 00                    1923 	.db #0x00	; 0
      008163 7C                    1924 	.db #0x7c	; 124
      008164 02                    1925 	.db #0x02	; 2
      008165 3C                    1926 	.db #0x3c	; 60
      008166 02                    1927 	.db #0x02	; 2
      008167 02                    1928 	.db #0x02	; 2
      008168 7C                    1929 	.db #0x7c	; 124
      008169 00                    1930 	.db #0x00	; 0
      00816A                       1931 __xinit__ttf_eng_4:
      00816A 00                    1932 	.db #0x00	; 0
      00816B 42                    1933 	.db #0x42	; 66	'B'
      00816C 42                    1934 	.db #0x42	; 66	'B'
      00816D 7E                    1935 	.db #0x7e	; 126
      00816E 02                    1936 	.db #0x02	; 2
      00816F 02                    1937 	.db #0x02	; 2
      008170 02                    1938 	.db #0x02	; 2
      008171 00                    1939 	.db #0x00	; 0
      008172                       1940 __xinit__ttf_eng_5:
      008172 00                    1941 	.db #0x00	; 0
      008173 7E                    1942 	.db #0x7e	; 126
      008174 40                    1943 	.db #0x40	; 64
      008175 7C                    1944 	.db #0x7c	; 124
      008176 02                    1945 	.db #0x02	; 2
      008177 02                    1946 	.db #0x02	; 2
      008178 7C                    1947 	.db #0x7c	; 124
      008179 00                    1948 	.db #0x00	; 0
      00817A                       1949 __xinit__ttf_eng_6:
      00817A 00                    1950 	.db #0x00	; 0
      00817B 3C                    1951 	.db #0x3c	; 60
      00817C 40                    1952 	.db #0x40	; 64
      00817D 7C                    1953 	.db #0x7c	; 124
      00817E 42                    1954 	.db #0x42	; 66	'B'
      00817F 42                    1955 	.db #0x42	; 66	'B'
      008180 3C                    1956 	.db #0x3c	; 60
      008181 00                    1957 	.db #0x00	; 0
      008182                       1958 __xinit__ttf_eng_7:
      008182 00                    1959 	.db #0x00	; 0
      008183 7E                    1960 	.db #0x7e	; 126
      008184 02                    1961 	.db #0x02	; 2
      008185 04                    1962 	.db #0x04	; 4
      008186 08                    1963 	.db #0x08	; 8
      008187 10                    1964 	.db #0x10	; 16
      008188 20                    1965 	.db #0x20	; 32
      008189 00                    1966 	.db #0x00	; 0
      00818A                       1967 __xinit__ttf_eng_8:
      00818A 00                    1968 	.db #0x00	; 0
      00818B 3C                    1969 	.db #0x3c	; 60
      00818C 42                    1970 	.db #0x42	; 66	'B'
      00818D 3C                    1971 	.db #0x3c	; 60
      00818E 42                    1972 	.db #0x42	; 66	'B'
      00818F 42                    1973 	.db #0x42	; 66	'B'
      008190 3C                    1974 	.db #0x3c	; 60
      008191 00                    1975 	.db #0x00	; 0
      008192                       1976 __xinit__ttf_eng_9:
      008192 00                    1977 	.db #0x00	; 0
      008193 3C                    1978 	.db #0x3c	; 60
      008194 42                    1979 	.db #0x42	; 66	'B'
      008195 42                    1980 	.db #0x42	; 66	'B'
      008196 3E                    1981 	.db #0x3e	; 62
      008197 02                    1982 	.db #0x02	; 2
      008198 3C                    1983 	.db #0x3c	; 60
      008199 00                    1984 	.db #0x00	; 0
      00819A                       1985 __xinit__ttf_eng_0:
      00819A 00                    1986 	.db #0x00	; 0
      00819B 3C                    1987 	.db #0x3c	; 60
      00819C 46                    1988 	.db #0x46	; 70	'F'
      00819D 4A                    1989 	.db #0x4a	; 74	'J'
      00819E 52                    1990 	.db #0x52	; 82	'R'
      00819F 62                    1991 	.db #0x62	; 98	'b'
      0081A0 3C                    1992 	.db #0x3c	; 60
      0081A1 00                    1993 	.db #0x00	; 0
      0081A2                       1994 __xinit__ttf_eng_corner_left_up:
      0081A2 FF                    1995 	.db #0xff	; 255
      0081A3 FF                    1996 	.db #0xff	; 255
      0081A4 C0                    1997 	.db #0xc0	; 192
      0081A5 C0                    1998 	.db #0xc0	; 192
      0081A6 C0                    1999 	.db #0xc0	; 192
      0081A7 C0                    2000 	.db #0xc0	; 192
      0081A8 C0                    2001 	.db #0xc0	; 192
      0081A9 C0                    2002 	.db #0xc0	; 192
      0081AA                       2003 __xinit__ttf_eng_corner_right_up:
      0081AA FF                    2004 	.db #0xff	; 255
      0081AB FF                    2005 	.db #0xff	; 255
      0081AC 03                    2006 	.db #0x03	; 3
      0081AD 03                    2007 	.db #0x03	; 3
      0081AE 03                    2008 	.db #0x03	; 3
      0081AF 03                    2009 	.db #0x03	; 3
      0081B0 03                    2010 	.db #0x03	; 3
      0081B1 03                    2011 	.db #0x03	; 3
      0081B2                       2012 __xinit__ttf_eng_corner_left_down:
      0081B2 C0                    2013 	.db #0xc0	; 192
      0081B3 C0                    2014 	.db #0xc0	; 192
      0081B4 C0                    2015 	.db #0xc0	; 192
      0081B5 C0                    2016 	.db #0xc0	; 192
      0081B6 C0                    2017 	.db #0xc0	; 192
      0081B7 C0                    2018 	.db #0xc0	; 192
      0081B8 FF                    2019 	.db #0xff	; 255
      0081B9 FF                    2020 	.db #0xff	; 255
      0081BA                       2021 __xinit__ttf_eng_corner_right_down:
      0081BA 03                    2022 	.db #0x03	; 3
      0081BB 03                    2023 	.db #0x03	; 3
      0081BC 03                    2024 	.db #0x03	; 3
      0081BD 03                    2025 	.db #0x03	; 3
      0081BE 03                    2026 	.db #0x03	; 3
      0081BF 03                    2027 	.db #0x03	; 3
      0081C0 FF                    2028 	.db #0xff	; 255
      0081C1 FF                    2029 	.db #0xff	; 255
      0081C2                       2030 __xinit__ttf_eng_line_right:
      0081C2 03                    2031 	.db #0x03	; 3
      0081C3 03                    2032 	.db #0x03	; 3
      0081C4 03                    2033 	.db #0x03	; 3
      0081C5 03                    2034 	.db #0x03	; 3
      0081C6 03                    2035 	.db #0x03	; 3
      0081C7 03                    2036 	.db #0x03	; 3
      0081C8 03                    2037 	.db #0x03	; 3
      0081C9 03                    2038 	.db #0x03	; 3
      0081CA                       2039 __xinit__ttf_eng_line_left:
      0081CA C0                    2040 	.db #0xc0	; 192
      0081CB C0                    2041 	.db #0xc0	; 192
      0081CC C0                    2042 	.db #0xc0	; 192
      0081CD C0                    2043 	.db #0xc0	; 192
      0081CE C0                    2044 	.db #0xc0	; 192
      0081CF C0                    2045 	.db #0xc0	; 192
      0081D0 C0                    2046 	.db #0xc0	; 192
      0081D1 C0                    2047 	.db #0xc0	; 192
      0081D2                       2048 __xinit__ttf_eng_line_up:
      0081D2 FF                    2049 	.db #0xff	; 255
      0081D3 FF                    2050 	.db #0xff	; 255
      0081D4 00                    2051 	.db #0x00	; 0
      0081D5 00                    2052 	.db #0x00	; 0
      0081D6 00                    2053 	.db #0x00	; 0
      0081D7 00                    2054 	.db #0x00	; 0
      0081D8 00                    2055 	.db #0x00	; 0
      0081D9 00                    2056 	.db #0x00	; 0
      0081DA                       2057 __xinit__ttf_eng_line_down:
      0081DA 00                    2058 	.db #0x00	; 0
      0081DB 00                    2059 	.db #0x00	; 0
      0081DC 00                    2060 	.db #0x00	; 0
      0081DD 00                    2061 	.db #0x00	; 0
      0081DE 00                    2062 	.db #0x00	; 0
      0081DF 00                    2063 	.db #0x00	; 0
      0081E0 FF                    2064 	.db #0xff	; 255
      0081E1 FF                    2065 	.db #0xff	; 255
      0081E2                       2066 __xinit__main_buffer:
      0081E2 FF                    2067 	.db #0xff	; 255
      0081E3 01                    2068 	.db #0x01	; 1
      0081E4 01                    2069 	.db #0x01	; 1
      0081E5 01                    2070 	.db #0x01	; 1
      0081E6 01                    2071 	.db #0x01	; 1
      0081E7 01                    2072 	.db #0x01	; 1
      0081E8 01                    2073 	.db #0x01	; 1
      0081E9 01                    2074 	.db #0x01	; 1
      0081EA FD                    2075 	.db #0xfd	; 253
      0081EB FD                    2076 	.db #0xfd	; 253
      0081EC FD                    2077 	.db #0xfd	; 253
      0081ED FD                    2078 	.db #0xfd	; 253
      0081EE FD                    2079 	.db #0xfd	; 253
      0081EF FD                    2080 	.db #0xfd	; 253
      0081F0 FD                    2081 	.db #0xfd	; 253
      0081F1 01                    2082 	.db #0x01	; 1
      0081F2 01                    2083 	.db #0x01	; 1
      0081F3 01                    2084 	.db #0x01	; 1
      0081F4 01                    2085 	.db #0x01	; 1
      0081F5 01                    2086 	.db #0x01	; 1
      0081F6 01                    2087 	.db #0x01	; 1
      0081F7 01                    2088 	.db #0x01	; 1
      0081F8 FD                    2089 	.db #0xfd	; 253
      0081F9 FD                    2090 	.db #0xfd	; 253
      0081FA FD                    2091 	.db #0xfd	; 253
      0081FB FD                    2092 	.db #0xfd	; 253
      0081FC FD                    2093 	.db #0xfd	; 253
      0081FD FD                    2094 	.db #0xfd	; 253
      0081FE FD                    2095 	.db #0xfd	; 253
      0081FF FD                    2096 	.db #0xfd	; 253
      008200 FD                    2097 	.db #0xfd	; 253
      008201 FD                    2098 	.db #0xfd	; 253
      008202 FD                    2099 	.db #0xfd	; 253
      008203 FD                    2100 	.db #0xfd	; 253
      008204 FD                    2101 	.db #0xfd	; 253
      008205 FD                    2102 	.db #0xfd	; 253
      008206 FD                    2103 	.db #0xfd	; 253
      008207 FD                    2104 	.db #0xfd	; 253
      008208 FD                    2105 	.db #0xfd	; 253
      008209 FD                    2106 	.db #0xfd	; 253
      00820A FD                    2107 	.db #0xfd	; 253
      00820B FD                    2108 	.db #0xfd	; 253
      00820C FD                    2109 	.db #0xfd	; 253
      00820D FD                    2110 	.db #0xfd	; 253
      00820E FD                    2111 	.db #0xfd	; 253
      00820F FD                    2112 	.db #0xfd	; 253
      008210 FD                    2113 	.db #0xfd	; 253
      008211 FD                    2114 	.db #0xfd	; 253
      008212 FD                    2115 	.db #0xfd	; 253
      008213 FD                    2116 	.db #0xfd	; 253
      008214 FD                    2117 	.db #0xfd	; 253
      008215 FD                    2118 	.db #0xfd	; 253
      008216 FD                    2119 	.db #0xfd	; 253
      008217 FD                    2120 	.db #0xfd	; 253
      008218 FD                    2121 	.db #0xfd	; 253
      008219 FD                    2122 	.db #0xfd	; 253
      00821A FD                    2123 	.db #0xfd	; 253
      00821B 01                    2124 	.db #0x01	; 1
      00821C 01                    2125 	.db #0x01	; 1
      00821D 01                    2126 	.db #0x01	; 1
      00821E 01                    2127 	.db #0x01	; 1
      00821F 01                    2128 	.db #0x01	; 1
      008220 01                    2129 	.db #0x01	; 1
      008221 01                    2130 	.db #0x01	; 1
      008222 FD                    2131 	.db #0xfd	; 253
      008223 FD                    2132 	.db #0xfd	; 253
      008224 FD                    2133 	.db #0xfd	; 253
      008225 FD                    2134 	.db #0xfd	; 253
      008226 FD                    2135 	.db #0xfd	; 253
      008227 FD                    2136 	.db #0xfd	; 253
      008228 FD                    2137 	.db #0xfd	; 253
      008229 FD                    2138 	.db #0xfd	; 253
      00822A FD                    2139 	.db #0xfd	; 253
      00822B FD                    2140 	.db #0xfd	; 253
      00822C FD                    2141 	.db #0xfd	; 253
      00822D FD                    2142 	.db #0xfd	; 253
      00822E FD                    2143 	.db #0xfd	; 253
      00822F FD                    2144 	.db #0xfd	; 253
      008230 FD                    2145 	.db #0xfd	; 253
      008231 FD                    2146 	.db #0xfd	; 253
      008232 FD                    2147 	.db #0xfd	; 253
      008233 FD                    2148 	.db #0xfd	; 253
      008234 FD                    2149 	.db #0xfd	; 253
      008235 FD                    2150 	.db #0xfd	; 253
      008236 FD                    2151 	.db #0xfd	; 253
      008237 01                    2152 	.db #0x01	; 1
      008238 01                    2153 	.db #0x01	; 1
      008239 01                    2154 	.db #0x01	; 1
      00823A 01                    2155 	.db #0x01	; 1
      00823B 01                    2156 	.db #0x01	; 1
      00823C 01                    2157 	.db #0x01	; 1
      00823D 01                    2158 	.db #0x01	; 1
      00823E 01                    2159 	.db #0x01	; 1
      00823F 01                    2160 	.db #0x01	; 1
      008240 01                    2161 	.db #0x01	; 1
      008241 01                    2162 	.db #0x01	; 1
      008242 01                    2163 	.db #0x01	; 1
      008243 01                    2164 	.db #0x01	; 1
      008244 01                    2165 	.db #0x01	; 1
      008245 3D                    2166 	.db #0x3d	; 61
      008246 15                    2167 	.db #0x15	; 21
      008247 3D                    2168 	.db #0x3d	; 61
      008248 01                    2169 	.db #0x01	; 1
      008249 3D                    2170 	.db #0x3d	; 61
      00824A 21                    2171 	.db #0x21	; 33
      00824B 21                    2172 	.db #0x21	; 33
      00824C 01                    2173 	.db #0x01	; 1
      00824D 3D                    2174 	.db #0x3d	; 61
      00824E 15                    2175 	.db #0x15	; 21
      00824F 1D                    2176 	.db #0x1d	; 29
      008250 01                    2177 	.db #0x01	; 1
      008251 3D                    2178 	.db #0x3d	; 61
      008252 11                    2179 	.db #0x11	; 17
      008253 3D                    2180 	.db #0x3d	; 61
      008254 01                    2181 	.db #0x01	; 1
      008255 3D                    2182 	.db #0x3d	; 61
      008256 15                    2183 	.db #0x15	; 21
      008257 3D                    2184 	.db #0x3d	; 61
      008258 01                    2185 	.db #0x01	; 1
      008259 01                    2186 	.db #0x01	; 1
      00825A 3D                    2187 	.db #0x3d	; 61
      00825B 25                    2188 	.db #0x25	; 37
      00825C 3D                    2189 	.db #0x3d	; 61
      00825D 01                    2190 	.db #0x01	; 1
      00825E 05                    2191 	.db #0x05	; 5
      00825F 3D                    2192 	.db #0x3d	; 61
      008260 01                    2193 	.db #0x01	; 1
      008261 FF                    2194 	.db #0xff	; 255
      008262 FF                    2195 	.db #0xff	; 255
      008263 00                    2196 	.db #0x00	; 0
      008264 00                    2197 	.db #0x00	; 0
      008265 00                    2198 	.db #0x00	; 0
      008266 00                    2199 	.db #0x00	; 0
      008267 00                    2200 	.db #0x00	; 0
      008268 00                    2201 	.db #0x00	; 0
      008269 00                    2202 	.db #0x00	; 0
      00826A FF                    2203 	.db #0xff	; 255
      00826B FF                    2204 	.db #0xff	; 255
      00826C FF                    2205 	.db #0xff	; 255
      00826D FF                    2206 	.db #0xff	; 255
      00826E FF                    2207 	.db #0xff	; 255
      00826F FF                    2208 	.db #0xff	; 255
      008270 FF                    2209 	.db #0xff	; 255
      008271 FE                    2210 	.db #0xfe	; 254
      008272 FE                    2211 	.db #0xfe	; 254
      008273 FE                    2212 	.db #0xfe	; 254
      008274 FE                    2213 	.db #0xfe	; 254
      008275 FE                    2214 	.db #0xfe	; 254
      008276 FE                    2215 	.db #0xfe	; 254
      008277 FE                    2216 	.db #0xfe	; 254
      008278 FF                    2217 	.db #0xff	; 255
      008279 FF                    2218 	.db #0xff	; 255
      00827A FF                    2219 	.db #0xff	; 255
      00827B FF                    2220 	.db #0xff	; 255
      00827C FF                    2221 	.db #0xff	; 255
      00827D FF                    2222 	.db #0xff	; 255
      00827E FF                    2223 	.db #0xff	; 255
      00827F 01                    2224 	.db #0x01	; 1
      008280 01                    2225 	.db #0x01	; 1
      008281 01                    2226 	.db #0x01	; 1
      008282 01                    2227 	.db #0x01	; 1
      008283 01                    2228 	.db #0x01	; 1
      008284 01                    2229 	.db #0x01	; 1
      008285 01                    2230 	.db #0x01	; 1
      008286 FF                    2231 	.db #0xff	; 255
      008287 FF                    2232 	.db #0xff	; 255
      008288 FF                    2233 	.db #0xff	; 255
      008289 FF                    2234 	.db #0xff	; 255
      00828A FF                    2235 	.db #0xff	; 255
      00828B FF                    2236 	.db #0xff	; 255
      00828C FF                    2237 	.db #0xff	; 255
      00828D 01                    2238 	.db #0x01	; 1
      00828E 01                    2239 	.db #0x01	; 1
      00828F 01                    2240 	.db #0x01	; 1
      008290 01                    2241 	.db #0x01	; 1
      008291 01                    2242 	.db #0x01	; 1
      008292 01                    2243 	.db #0x01	; 1
      008293 01                    2244 	.db #0x01	; 1
      008294 FF                    2245 	.db #0xff	; 255
      008295 FF                    2246 	.db #0xff	; 255
      008296 FF                    2247 	.db #0xff	; 255
      008297 FF                    2248 	.db #0xff	; 255
      008298 FF                    2249 	.db #0xff	; 255
      008299 FF                    2250 	.db #0xff	; 255
      00829A FF                    2251 	.db #0xff	; 255
      00829B 00                    2252 	.db #0x00	; 0
      00829C 00                    2253 	.db #0x00	; 0
      00829D 00                    2254 	.db #0x00	; 0
      00829E 00                    2255 	.db #0x00	; 0
      00829F 00                    2256 	.db #0x00	; 0
      0082A0 00                    2257 	.db #0x00	; 0
      0082A1 00                    2258 	.db #0x00	; 0
      0082A2 FF                    2259 	.db #0xff	; 255
      0082A3 FF                    2260 	.db #0xff	; 255
      0082A4 FF                    2261 	.db #0xff	; 255
      0082A5 FF                    2262 	.db #0xff	; 255
      0082A6 FF                    2263 	.db #0xff	; 255
      0082A7 FF                    2264 	.db #0xff	; 255
      0082A8 FF                    2265 	.db #0xff	; 255
      0082A9 01                    2266 	.db #0x01	; 1
      0082AA 01                    2267 	.db #0x01	; 1
      0082AB 01                    2268 	.db #0x01	; 1
      0082AC 01                    2269 	.db #0x01	; 1
      0082AD 01                    2270 	.db #0x01	; 1
      0082AE 01                    2271 	.db #0x01	; 1
      0082AF 01                    2272 	.db #0x01	; 1
      0082B0 FF                    2273 	.db #0xff	; 255
      0082B1 FF                    2274 	.db #0xff	; 255
      0082B2 FF                    2275 	.db #0xff	; 255
      0082B3 FF                    2276 	.db #0xff	; 255
      0082B4 FF                    2277 	.db #0xff	; 255
      0082B5 FF                    2278 	.db #0xff	; 255
      0082B6 FF                    2279 	.db #0xff	; 255
      0082B7 00                    2280 	.db #0x00	; 0
      0082B8 00                    2281 	.db #0x00	; 0
      0082B9 00                    2282 	.db #0x00	; 0
      0082BA 00                    2283 	.db #0x00	; 0
      0082BB 00                    2284 	.db #0x00	; 0
      0082BC 00                    2285 	.db #0x00	; 0
      0082BD 00                    2286 	.db #0x00	; 0
      0082BE 00                    2287 	.db #0x00	; 0
      0082BF 00                    2288 	.db #0x00	; 0
      0082C0 00                    2289 	.db #0x00	; 0
      0082C1 00                    2290 	.db #0x00	; 0
      0082C2 00                    2291 	.db #0x00	; 0
      0082C3 00                    2292 	.db #0x00	; 0
      0082C4 00                    2293 	.db #0x00	; 0
      0082C5 00                    2294 	.db #0x00	; 0
      0082C6 00                    2295 	.db #0x00	; 0
      0082C7 00                    2296 	.db #0x00	; 0
      0082C8 00                    2297 	.db #0x00	; 0
      0082C9 00                    2298 	.db #0x00	; 0
      0082CA 00                    2299 	.db #0x00	; 0
      0082CB 00                    2300 	.db #0x00	; 0
      0082CC 00                    2301 	.db #0x00	; 0
      0082CD 00                    2302 	.db #0x00	; 0
      0082CE 00                    2303 	.db #0x00	; 0
      0082CF 00                    2304 	.db #0x00	; 0
      0082D0 00                    2305 	.db #0x00	; 0
      0082D1 00                    2306 	.db #0x00	; 0
      0082D2 00                    2307 	.db #0x00	; 0
      0082D3 00                    2308 	.db #0x00	; 0
      0082D4 00                    2309 	.db #0x00	; 0
      0082D5 00                    2310 	.db #0x00	; 0
      0082D6 00                    2311 	.db #0x00	; 0
      0082D7 00                    2312 	.db #0x00	; 0
      0082D8 00                    2313 	.db #0x00	; 0
      0082D9 00                    2314 	.db #0x00	; 0
      0082DA 00                    2315 	.db #0x00	; 0
      0082DB 00                    2316 	.db #0x00	; 0
      0082DC 00                    2317 	.db #0x00	; 0
      0082DD 00                    2318 	.db #0x00	; 0
      0082DE 00                    2319 	.db #0x00	; 0
      0082DF 00                    2320 	.db #0x00	; 0
      0082E0 00                    2321 	.db #0x00	; 0
      0082E1 FF                    2322 	.db #0xff	; 255
      0082E2 FF                    2323 	.db #0xff	; 255
      0082E3 00                    2324 	.db #0x00	; 0
      0082E4 00                    2325 	.db #0x00	; 0
      0082E5 00                    2326 	.db #0x00	; 0
      0082E6 00                    2327 	.db #0x00	; 0
      0082E7 00                    2328 	.db #0x00	; 0
      0082E8 00                    2329 	.db #0x00	; 0
      0082E9 00                    2330 	.db #0x00	; 0
      0082EA FF                    2331 	.db #0xff	; 255
      0082EB FF                    2332 	.db #0xff	; 255
      0082EC FF                    2333 	.db #0xff	; 255
      0082ED FF                    2334 	.db #0xff	; 255
      0082EE FF                    2335 	.db #0xff	; 255
      0082EF FF                    2336 	.db #0xff	; 255
      0082F0 FF                    2337 	.db #0xff	; 255
      0082F1 00                    2338 	.db #0x00	; 0
      0082F2 00                    2339 	.db #0x00	; 0
      0082F3 00                    2340 	.db #0x00	; 0
      0082F4 00                    2341 	.db #0x00	; 0
      0082F5 00                    2342 	.db #0x00	; 0
      0082F6 00                    2343 	.db #0x00	; 0
      0082F7 00                    2344 	.db #0x00	; 0
      0082F8 FF                    2345 	.db #0xff	; 255
      0082F9 FF                    2346 	.db #0xff	; 255
      0082FA FF                    2347 	.db #0xff	; 255
      0082FB FF                    2348 	.db #0xff	; 255
      0082FC FF                    2349 	.db #0xff	; 255
      0082FD FF                    2350 	.db #0xff	; 255
      0082FE FF                    2351 	.db #0xff	; 255
      0082FF 00                    2352 	.db #0x00	; 0
      008300 00                    2353 	.db #0x00	; 0
      008301 00                    2354 	.db #0x00	; 0
      008302 00                    2355 	.db #0x00	; 0
      008303 00                    2356 	.db #0x00	; 0
      008304 00                    2357 	.db #0x00	; 0
      008305 00                    2358 	.db #0x00	; 0
      008306 FF                    2359 	.db #0xff	; 255
      008307 FF                    2360 	.db #0xff	; 255
      008308 FF                    2361 	.db #0xff	; 255
      008309 FF                    2362 	.db #0xff	; 255
      00830A FF                    2363 	.db #0xff	; 255
      00830B FF                    2364 	.db #0xff	; 255
      00830C FF                    2365 	.db #0xff	; 255
      00830D 00                    2366 	.db #0x00	; 0
      00830E 00                    2367 	.db #0x00	; 0
      00830F 00                    2368 	.db #0x00	; 0
      008310 00                    2369 	.db #0x00	; 0
      008311 00                    2370 	.db #0x00	; 0
      008312 00                    2371 	.db #0x00	; 0
      008313 00                    2372 	.db #0x00	; 0
      008314 FF                    2373 	.db #0xff	; 255
      008315 FF                    2374 	.db #0xff	; 255
      008316 FF                    2375 	.db #0xff	; 255
      008317 FF                    2376 	.db #0xff	; 255
      008318 FF                    2377 	.db #0xff	; 255
      008319 FF                    2378 	.db #0xff	; 255
      00831A FF                    2379 	.db #0xff	; 255
      00831B 7F                    2380 	.db #0x7f	; 127
      00831C 7F                    2381 	.db #0x7f	; 127
      00831D 7F                    2382 	.db #0x7f	; 127
      00831E 7F                    2383 	.db #0x7f	; 127
      00831F 7F                    2384 	.db #0x7f	; 127
      008320 7F                    2385 	.db #0x7f	; 127
      008321 7F                    2386 	.db #0x7f	; 127
      008322 FF                    2387 	.db #0xff	; 255
      008323 FF                    2388 	.db #0xff	; 255
      008324 FF                    2389 	.db #0xff	; 255
      008325 FF                    2390 	.db #0xff	; 255
      008326 FF                    2391 	.db #0xff	; 255
      008327 FF                    2392 	.db #0xff	; 255
      008328 FF                    2393 	.db #0xff	; 255
      008329 7F                    2394 	.db #0x7f	; 127
      00832A 7F                    2395 	.db #0x7f	; 127
      00832B 7F                    2396 	.db #0x7f	; 127
      00832C 7F                    2397 	.db #0x7f	; 127
      00832D 7F                    2398 	.db #0x7f	; 127
      00832E 7F                    2399 	.db #0x7f	; 127
      00832F 7F                    2400 	.db #0x7f	; 127
      008330 80                    2401 	.db #0x80	; 128
      008331 80                    2402 	.db #0x80	; 128
      008332 80                    2403 	.db #0x80	; 128
      008333 80                    2404 	.db #0x80	; 128
      008334 80                    2405 	.db #0x80	; 128
      008335 80                    2406 	.db #0x80	; 128
      008336 80                    2407 	.db #0x80	; 128
      008337 00                    2408 	.db #0x00	; 0
      008338 00                    2409 	.db #0x00	; 0
      008339 00                    2410 	.db #0x00	; 0
      00833A 80                    2411 	.db #0x80	; 128
      00833B 80                    2412 	.db #0x80	; 128
      00833C 80                    2413 	.db #0x80	; 128
      00833D 80                    2414 	.db #0x80	; 128
      00833E 80                    2415 	.db #0x80	; 128
      00833F 80                    2416 	.db #0x80	; 128
      008340 80                    2417 	.db #0x80	; 128
      008341 00                    2418 	.db #0x00	; 0
      008342 00                    2419 	.db #0x00	; 0
      008343 00                    2420 	.db #0x00	; 0
      008344 00                    2421 	.db #0x00	; 0
      008345 00                    2422 	.db #0x00	; 0
      008346 00                    2423 	.db #0x00	; 0
      008347 00                    2424 	.db #0x00	; 0
      008348 00                    2425 	.db #0x00	; 0
      008349 00                    2426 	.db #0x00	; 0
      00834A 00                    2427 	.db #0x00	; 0
      00834B 00                    2428 	.db #0x00	; 0
      00834C 00                    2429 	.db #0x00	; 0
      00834D 00                    2430 	.db #0x00	; 0
      00834E 00                    2431 	.db #0x00	; 0
      00834F 00                    2432 	.db #0x00	; 0
      008350 00                    2433 	.db #0x00	; 0
      008351 00                    2434 	.db #0x00	; 0
      008352 00                    2435 	.db #0x00	; 0
      008353 00                    2436 	.db #0x00	; 0
      008354 00                    2437 	.db #0x00	; 0
      008355 00                    2438 	.db #0x00	; 0
      008356 00                    2439 	.db #0x00	; 0
      008357 00                    2440 	.db #0x00	; 0
      008358 00                    2441 	.db #0x00	; 0
      008359 00                    2442 	.db #0x00	; 0
      00835A 00                    2443 	.db #0x00	; 0
      00835B 00                    2444 	.db #0x00	; 0
      00835C 00                    2445 	.db #0x00	; 0
      00835D 00                    2446 	.db #0x00	; 0
      00835E 00                    2447 	.db #0x00	; 0
      00835F 00                    2448 	.db #0x00	; 0
      008360 00                    2449 	.db #0x00	; 0
      008361 FF                    2450 	.db #0xff	; 255
      008362 FF                    2451 	.db #0xff	; 255
      008363 80                    2452 	.db #0x80	; 128
      008364 80                    2453 	.db #0x80	; 128
      008365 80                    2454 	.db #0x80	; 128
      008366 80                    2455 	.db #0x80	; 128
      008367 80                    2456 	.db #0x80	; 128
      008368 80                    2457 	.db #0x80	; 128
      008369 80                    2458 	.db #0x80	; 128
      00836A BF                    2459 	.db #0xbf	; 191
      00836B BF                    2460 	.db #0xbf	; 191
      00836C BF                    2461 	.db #0xbf	; 191
      00836D BF                    2462 	.db #0xbf	; 191
      00836E BF                    2463 	.db #0xbf	; 191
      00836F BF                    2464 	.db #0xbf	; 191
      008370 BF                    2465 	.db #0xbf	; 191
      008371 80                    2466 	.db #0x80	; 128
      008372 80                    2467 	.db #0x80	; 128
      008373 80                    2468 	.db #0x80	; 128
      008374 80                    2469 	.db #0x80	; 128
      008375 80                    2470 	.db #0x80	; 128
      008376 80                    2471 	.db #0x80	; 128
      008377 80                    2472 	.db #0x80	; 128
      008378 BF                    2473 	.db #0xbf	; 191
      008379 BF                    2474 	.db #0xbf	; 191
      00837A BF                    2475 	.db #0xbf	; 191
      00837B BF                    2476 	.db #0xbf	; 191
      00837C BF                    2477 	.db #0xbf	; 191
      00837D BF                    2478 	.db #0xbf	; 191
      00837E BF                    2479 	.db #0xbf	; 191
      00837F 80                    2480 	.db #0x80	; 128
      008380 80                    2481 	.db #0x80	; 128
      008381 80                    2482 	.db #0x80	; 128
      008382 80                    2483 	.db #0x80	; 128
      008383 80                    2484 	.db #0x80	; 128
      008384 80                    2485 	.db #0x80	; 128
      008385 80                    2486 	.db #0x80	; 128
      008386 BF                    2487 	.db #0xbf	; 191
      008387 BF                    2488 	.db #0xbf	; 191
      008388 BF                    2489 	.db #0xbf	; 191
      008389 BF                    2490 	.db #0xbf	; 191
      00838A BF                    2491 	.db #0xbf	; 191
      00838B BF                    2492 	.db #0xbf	; 191
      00838C BF                    2493 	.db #0xbf	; 191
      00838D 80                    2494 	.db #0x80	; 128
      00838E 80                    2495 	.db #0x80	; 128
      00838F 80                    2496 	.db #0x80	; 128
      008390 80                    2497 	.db #0x80	; 128
      008391 80                    2498 	.db #0x80	; 128
      008392 80                    2499 	.db #0x80	; 128
      008393 80                    2500 	.db #0x80	; 128
      008394 BF                    2501 	.db #0xbf	; 191
      008395 BF                    2502 	.db #0xbf	; 191
      008396 BF                    2503 	.db #0xbf	; 191
      008397 BF                    2504 	.db #0xbf	; 191
      008398 BF                    2505 	.db #0xbf	; 191
      008399 BF                    2506 	.db #0xbf	; 191
      00839A BF                    2507 	.db #0xbf	; 191
      00839B 80                    2508 	.db #0x80	; 128
      00839C 80                    2509 	.db #0x80	; 128
      00839D 80                    2510 	.db #0x80	; 128
      00839E 80                    2511 	.db #0x80	; 128
      00839F 80                    2512 	.db #0x80	; 128
      0083A0 80                    2513 	.db #0x80	; 128
      0083A1 80                    2514 	.db #0x80	; 128
      0083A2 BF                    2515 	.db #0xbf	; 191
      0083A3 BF                    2516 	.db #0xbf	; 191
      0083A4 BF                    2517 	.db #0xbf	; 191
      0083A5 BF                    2518 	.db #0xbf	; 191
      0083A6 BF                    2519 	.db #0xbf	; 191
      0083A7 BF                    2520 	.db #0xbf	; 191
      0083A8 BF                    2521 	.db #0xbf	; 191
      0083A9 80                    2522 	.db #0x80	; 128
      0083AA 80                    2523 	.db #0x80	; 128
      0083AB 80                    2524 	.db #0x80	; 128
      0083AC 80                    2525 	.db #0x80	; 128
      0083AD 80                    2526 	.db #0x80	; 128
      0083AE 80                    2527 	.db #0x80	; 128
      0083AF 80                    2528 	.db #0x80	; 128
      0083B0 BF                    2529 	.db #0xbf	; 191
      0083B1 BF                    2530 	.db #0xbf	; 191
      0083B2 BF                    2531 	.db #0xbf	; 191
      0083B3 BF                    2532 	.db #0xbf	; 191
      0083B4 BF                    2533 	.db #0xbf	; 191
      0083B5 BF                    2534 	.db #0xbf	; 191
      0083B6 BF                    2535 	.db #0xbf	; 191
      0083B7 80                    2536 	.db #0x80	; 128
      0083B8 80                    2537 	.db #0x80	; 128
      0083B9 80                    2538 	.db #0x80	; 128
      0083BA B1                    2539 	.db #0xb1	; 177
      0083BB B1                    2540 	.db #0xb1	; 177
      0083BC BF                    2541 	.db #0xbf	; 191
      0083BD BF                    2542 	.db #0xbf	; 191
      0083BE BF                    2543 	.db #0xbf	; 191
      0083BF B1                    2544 	.db #0xb1	; 177
      0083C0 B1                    2545 	.db #0xb1	; 177
      0083C1 80                    2546 	.db #0x80	; 128
      0083C2 80                    2547 	.db #0x80	; 128
      0083C3 BF                    2548 	.db #0xbf	; 191
      0083C4 BF                    2549 	.db #0xbf	; 191
      0083C5 83                    2550 	.db #0x83	; 131
      0083C6 83                    2551 	.db #0x83	; 131
      0083C7 BF                    2552 	.db #0xbf	; 191
      0083C8 BE                    2553 	.db #0xbe	; 190
      0083C9 80                    2554 	.db #0x80	; 128
      0083CA 80                    2555 	.db #0x80	; 128
      0083CB BF                    2556 	.db #0xbf	; 191
      0083CC BF                    2557 	.db #0xbf	; 191
      0083CD B3                    2558 	.db #0xb3	; 179
      0083CE B3                    2559 	.db #0xb3	; 179
      0083CF B3                    2560 	.db #0xb3	; 179
      0083D0 B3                    2561 	.db #0xb3	; 179
      0083D1 80                    2562 	.db #0x80	; 128
      0083D2 80                    2563 	.db #0x80	; 128
      0083D3 80                    2564 	.db #0x80	; 128
      0083D4 80                    2565 	.db #0x80	; 128
      0083D5 B0                    2566 	.db #0xb0	; 176
      0083D6 B0                    2567 	.db #0xb0	; 176
      0083D7 80                    2568 	.db #0x80	; 128
      0083D8 80                    2569 	.db #0x80	; 128
      0083D9 80                    2570 	.db #0x80	; 128
      0083DA 80                    2571 	.db #0x80	; 128
      0083DB 80                    2572 	.db #0x80	; 128
      0083DC 80                    2573 	.db #0x80	; 128
      0083DD 80                    2574 	.db #0x80	; 128
      0083DE 80                    2575 	.db #0x80	; 128
      0083DF 80                    2576 	.db #0x80	; 128
      0083E0 80                    2577 	.db #0x80	; 128
      0083E1 FF                    2578 	.db #0xff	; 255
      0083E2                       2579 __xinit__TIM2_IRQ:
      0083E2 00                    2580 	.db #0x00	; 0
                                   2581 	.area CABS (ABS)
