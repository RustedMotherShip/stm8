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
                                     21 	.globl _ttf_eng_0
                                     22 	.globl _ttf_eng_9
                                     23 	.globl _ttf_eng_8
                                     24 	.globl _ttf_eng_7
                                     25 	.globl _ttf_eng_6
                                     26 	.globl _ttf_eng_5
                                     27 	.globl _ttf_eng_4
                                     28 	.globl _ttf_eng_3
                                     29 	.globl _ttf_eng_2
                                     30 	.globl _ttf_eng_1
                                     31 	.globl _ttf_eng_z
                                     32 	.globl _ttf_eng_y
                                     33 	.globl _ttf_eng_x
                                     34 	.globl _ttf_eng_w
                                     35 	.globl _ttf_eng_v
                                     36 	.globl _ttf_eng_u
                                     37 	.globl _ttf_eng_t
                                     38 	.globl _ttf_eng_s
                                     39 	.globl _ttf_eng_r
                                     40 	.globl _ttf_eng_q
                                     41 	.globl _ttf_eng_p
                                     42 	.globl _ttf_eng_o
                                     43 	.globl _ttf_eng_n
                                     44 	.globl _ttf_eng_m
                                     45 	.globl _ttf_eng_l
                                     46 	.globl _ttf_eng_k
                                     47 	.globl _ttf_eng_j
                                     48 	.globl _ttf_eng_i
                                     49 	.globl _ttf_eng_h
                                     50 	.globl _ttf_eng_g
                                     51 	.globl _ttf_eng_f
                                     52 	.globl _ttf_eng_e
                                     53 	.globl _ttf_eng_d
                                     54 	.globl _ttf_eng_c
                                     55 	.globl _ttf_eng_b
                                     56 	.globl _ttf_eng_a
                                     57 	.globl _I2C_IRQ
                                     58 	.globl _buf_size
                                     59 	.globl _buf_pos
                                     60 	.globl _rx_buf_pointer
                                     61 	.globl _tx_buf_pointer
                                     62 	.globl _uart_transmission_irq
                                     63 	.globl _uart_reciever_irq
                                     64 	.globl _uart_write_irq
                                     65 	.globl _uart_read_irq
                                     66 	.globl _uart_init
                                     67 	.globl _uart_read_byte
                                     68 	.globl _uart_write_byte
                                     69 	.globl _uart_write
                                     70 	.globl _uart_read
                                     71 	.globl _i2c_init
                                     72 	.globl _i2c_start
                                     73 	.globl _i2c_stop
                                     74 	.globl _i2c_send_address
                                     75 	.globl _i2c_read_byte
                                     76 	.globl _i2c_read
                                     77 	.globl _i2c_send_byte
                                     78 	.globl _i2c_write
                                     79 	.globl _i2c_scan
                                     80 	.globl _i2c_start_irq
                                     81 	.globl _i2c_stop_irq
                                     82 	.globl _ssd1306_init
                                     83 	.globl _ssd1306_set_params_to_write
                                     84 	.globl _ssd1306_draw_pixel
                                     85 	.globl _ssd1306_buffer_splash
                                     86 	.globl _ssd1306_buffer_write
                                     87 	.globl _ssd1306_clean
                                     88 ;--------------------------------------------------------
                                     89 ; ram data
                                     90 ;--------------------------------------------------------
                                     91 	.area DATA
      000001                         92 _tx_buf_pointer::
      000001                         93 	.ds 2
      000003                         94 _rx_buf_pointer::
      000003                         95 	.ds 2
      000005                         96 _buf_pos::
      000005                         97 	.ds 1
      000006                         98 _buf_size::
      000006                         99 	.ds 1
                                    100 ;--------------------------------------------------------
                                    101 ; ram data
                                    102 ;--------------------------------------------------------
                                    103 	.area INITIALIZED
      000007                        104 _I2C_IRQ::
      000007                        105 	.ds 1
      000008                        106 _ttf_eng_a::
      000008                        107 	.ds 8
      000010                        108 _ttf_eng_b::
      000010                        109 	.ds 8
      000018                        110 _ttf_eng_c::
      000018                        111 	.ds 8
      000020                        112 _ttf_eng_d::
      000020                        113 	.ds 8
      000028                        114 _ttf_eng_e::
      000028                        115 	.ds 8
      000030                        116 _ttf_eng_f::
      000030                        117 	.ds 8
      000038                        118 _ttf_eng_g::
      000038                        119 	.ds 8
      000040                        120 _ttf_eng_h::
      000040                        121 	.ds 8
      000048                        122 _ttf_eng_i::
      000048                        123 	.ds 8
      000050                        124 _ttf_eng_j::
      000050                        125 	.ds 8
      000058                        126 _ttf_eng_k::
      000058                        127 	.ds 8
      000060                        128 _ttf_eng_l::
      000060                        129 	.ds 8
      000068                        130 _ttf_eng_m::
      000068                        131 	.ds 8
      000070                        132 _ttf_eng_n::
      000070                        133 	.ds 8
      000078                        134 _ttf_eng_o::
      000078                        135 	.ds 8
      000080                        136 _ttf_eng_p::
      000080                        137 	.ds 8
      000088                        138 _ttf_eng_q::
      000088                        139 	.ds 8
      000090                        140 _ttf_eng_r::
      000090                        141 	.ds 8
      000098                        142 _ttf_eng_s::
      000098                        143 	.ds 8
      0000A0                        144 _ttf_eng_t::
      0000A0                        145 	.ds 8
      0000A8                        146 _ttf_eng_u::
      0000A8                        147 	.ds 8
      0000B0                        148 _ttf_eng_v::
      0000B0                        149 	.ds 8
      0000B8                        150 _ttf_eng_w::
      0000B8                        151 	.ds 8
      0000C0                        152 _ttf_eng_x::
      0000C0                        153 	.ds 8
      0000C8                        154 _ttf_eng_y::
      0000C8                        155 	.ds 8
      0000D0                        156 _ttf_eng_z::
      0000D0                        157 	.ds 8
      0000D8                        158 _ttf_eng_1::
      0000D8                        159 	.ds 8
      0000E0                        160 _ttf_eng_2::
      0000E0                        161 	.ds 8
      0000E8                        162 _ttf_eng_3::
      0000E8                        163 	.ds 8
      0000F0                        164 _ttf_eng_4::
      0000F0                        165 	.ds 8
      0000F8                        166 _ttf_eng_5::
      0000F8                        167 	.ds 8
      000100                        168 _ttf_eng_6::
      000100                        169 	.ds 8
      000108                        170 _ttf_eng_7::
      000108                        171 	.ds 8
      000110                        172 _ttf_eng_8::
      000110                        173 	.ds 8
      000118                        174 _ttf_eng_9::
      000118                        175 	.ds 8
      000120                        176 _ttf_eng_0::
      000120                        177 	.ds 8
      000128                        178 _main_buffer::
      000128                        179 	.ds 512
                                    180 ;--------------------------------------------------------
                                    181 ; Stack segment in internal ram
                                    182 ;--------------------------------------------------------
                                    183 	.area SSEG
      000328                        184 __start__stack:
      000328                        185 	.ds	1
                                    186 
                                    187 ;--------------------------------------------------------
                                    188 ; absolute external ram data
                                    189 ;--------------------------------------------------------
                                    190 	.area DABS (ABS)
                                    191 
                                    192 ; default segment ordering for linker
                                    193 	.area HOME
                                    194 	.area GSINIT
                                    195 	.area GSFINAL
                                    196 	.area CONST
                                    197 	.area INITIALIZER
                                    198 	.area CODE
                                    199 
                                    200 ;--------------------------------------------------------
                                    201 ; interrupt vector
                                    202 ;--------------------------------------------------------
                                    203 	.area HOME
      008000                        204 __interrupt_vect:
      008000 82 00 80 5B            205 	int s_GSINIT ; reset
      008004 82 00 00 00            206 	int 0x000000 ; trap
      008008 82 00 00 00            207 	int 0x000000 ; int0
      00800C 82 00 00 00            208 	int 0x000000 ; int1
      008010 82 00 00 00            209 	int 0x000000 ; int2
      008014 82 00 00 00            210 	int 0x000000 ; int3
      008018 82 00 00 00            211 	int 0x000000 ; int4
      00801C 82 00 00 00            212 	int 0x000000 ; int5
      008020 82 00 00 00            213 	int 0x000000 ; int6
      008024 82 00 00 00            214 	int 0x000000 ; int7
      008028 82 00 00 00            215 	int 0x000000 ; int8
      00802C 82 00 00 00            216 	int 0x000000 ; int9
      008030 82 00 00 00            217 	int 0x000000 ; int10
      008034 82 00 00 00            218 	int 0x000000 ; int11
      008038 82 00 00 00            219 	int 0x000000 ; int12
      00803C 82 00 00 00            220 	int 0x000000 ; int13
      008040 82 00 00 00            221 	int 0x000000 ; int14
      008044 82 00 00 00            222 	int 0x000000 ; int15
      008048 82 00 00 00            223 	int 0x000000 ; int16
      00804C 82 00 83 A2            224 	int _uart_transmission_irq ; int17
      008050 82 00 83 DE            225 	int _uart_reciever_irq ; int18
      008054 82 00 85 C0            226 	int _i2c_irq ; int19
                                    227 ;--------------------------------------------------------
                                    228 ; global & static initialisations
                                    229 ;--------------------------------------------------------
                                    230 	.area HOME
                                    231 	.area GSINIT
                                    232 	.area GSFINAL
                                    233 	.area GSINIT
      00805B CD 8B D4         [ 4]  234 	call	___sdcc_external_startup
      00805E 4D               [ 1]  235 	tnz	a
      00805F 27 03            [ 1]  236 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  237 	jp	__sdcc_program_startup
      008064                        238 __sdcc_init_data:
                                    239 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  240 	ldw x, #l_DATA
      008067 27 07            [ 1]  241 	jreq	00002$
      008069                        242 00001$:
      008069 72 4F 00 00      [ 1]  243 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  244 	decw x
      00806E 26 F9            [ 1]  245 	jrne	00001$
      008070                        246 00002$:
      008070 AE 03 21         [ 2]  247 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  248 	jreq	00004$
      008075                        249 00003$:
      008075 D6 80 80         [ 1]  250 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  251 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  252 	decw	x
      00807C 26 F7            [ 1]  253 	jrne	00003$
      00807E                        254 00004$:
                                    255 ; stm8_genXINIT() end
                                    256 	.area GSFINAL
      00807E CC 80 58         [ 2]  257 	jp	__sdcc_program_startup
                                    258 ;--------------------------------------------------------
                                    259 ; Home
                                    260 ;--------------------------------------------------------
                                    261 	.area HOME
                                    262 	.area HOME
      008058                        263 __sdcc_program_startup:
      008058 CC 8B 8C         [ 2]  264 	jp	_main
                                    265 ;	return from main will return to caller
                                    266 ;--------------------------------------------------------
                                    267 ; code
                                    268 ;--------------------------------------------------------
                                    269 	.area CODE
                                    270 ;	./libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    271 ;	-----------------------------------------
                                    272 ;	 function uart_transmission_irq
                                    273 ;	-----------------------------------------
      0083A2                        274 _uart_transmission_irq:
                                    275 ;	./libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0083A2 AE 52 30         [ 2]  276 	ldw	x, #0x5230
      0083A5 F6               [ 1]  277 	ld	a, (x)
      0083A6 4E               [ 1]  278 	swap	a
      0083A7 44               [ 1]  279 	srl	a
      0083A8 44               [ 1]  280 	srl	a
      0083A9 44               [ 1]  281 	srl	a
      0083AA A5 01            [ 1]  282 	bcp	a, #0x01
      0083AC 27 2F            [ 1]  283 	jreq	00107$
                                    284 ;	./libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0083AE C6 00 02         [ 1]  285 	ld	a, _tx_buf_pointer+1
      0083B1 CB 00 05         [ 1]  286 	add	a, _buf_pos+0
      0083B4 97               [ 1]  287 	ld	xl, a
      0083B5 C6 00 01         [ 1]  288 	ld	a, _tx_buf_pointer+0
      0083B8 A9 00            [ 1]  289 	adc	a, #0x00
      0083BA 95               [ 1]  290 	ld	xh, a
      0083BB F6               [ 1]  291 	ld	a, (x)
      0083BC 27 1B            [ 1]  292 	jreq	00102$
      0083BE C6 00 05         [ 1]  293 	ld	a, _buf_pos+0
      0083C1 C1 00 06         [ 1]  294 	cp	a, _buf_size+0
      0083C4 24 13            [ 1]  295 	jrnc	00102$
                                    296 ;	./libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0083C6 C6 00 05         [ 1]  297 	ld	a, _buf_pos+0
      0083C9 72 5C 00 05      [ 1]  298 	inc	_buf_pos+0
      0083CD 5F               [ 1]  299 	clrw	x
      0083CE 97               [ 1]  300 	ld	xl, a
      0083CF 72 BB 00 01      [ 2]  301 	addw	x, _tx_buf_pointer+0
      0083D3 F6               [ 1]  302 	ld	a, (x)
      0083D4 C7 52 31         [ 1]  303 	ld	0x5231, a
      0083D7 20 04            [ 2]  304 	jra	00107$
      0083D9                        305 00102$:
                                    306 ;	./libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0083D9 72 1F 52 35      [ 1]  307 	bres	0x5235, #7
      0083DD                        308 00107$:
                                    309 ;	./libs/uart_lib.c: 14: }
      0083DD 80               [11]  310 	iret
                                    311 ;	./libs/uart_lib.c: 16: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    312 ;	-----------------------------------------
                                    313 ;	 function uart_reciever_irq
                                    314 ;	-----------------------------------------
      0083DE                        315 _uart_reciever_irq:
      0083DE 88               [ 1]  316 	push	a
                                    317 ;	./libs/uart_lib.c: 20: if(UART1_SR -> RXNE)
      0083DF C6 52 30         [ 1]  318 	ld	a, 0x5230
      0083E2 4E               [ 1]  319 	swap	a
      0083E3 44               [ 1]  320 	srl	a
      0083E4 A5 01            [ 1]  321 	bcp	a, #0x01
      0083E6 27 27            [ 1]  322 	jreq	00107$
                                    323 ;	./libs/uart_lib.c: 22: trash_reg = UART1_DR -> DR;
      0083E8 C6 52 31         [ 1]  324 	ld	a, 0x5231
                                    325 ;	./libs/uart_lib.c: 23: if(trash_reg != '\n' && buf_size>buf_pos)
      0083EB 6B 01            [ 1]  326 	ld	(0x01, sp), a
      0083ED A1 0A            [ 1]  327 	cp	a, #0x0a
      0083EF 27 1A            [ 1]  328 	jreq	00102$
      0083F1 C6 00 05         [ 1]  329 	ld	a, _buf_pos+0
      0083F4 C1 00 06         [ 1]  330 	cp	a, _buf_size+0
      0083F7 24 12            [ 1]  331 	jrnc	00102$
                                    332 ;	./libs/uart_lib.c: 24: rx_buf_pointer[buf_pos++] = trash_reg;
      0083F9 C6 00 05         [ 1]  333 	ld	a, _buf_pos+0
      0083FC 72 5C 00 05      [ 1]  334 	inc	_buf_pos+0
      008400 5F               [ 1]  335 	clrw	x
      008401 97               [ 1]  336 	ld	xl, a
      008402 72 BB 00 03      [ 2]  337 	addw	x, _rx_buf_pointer+0
      008406 7B 01            [ 1]  338 	ld	a, (0x01, sp)
      008408 F7               [ 1]  339 	ld	(x), a
      008409 20 04            [ 2]  340 	jra	00107$
      00840B                        341 00102$:
                                    342 ;	./libs/uart_lib.c: 26: UART1_CR2 -> RIEN = 0;
      00840B 72 1B 52 35      [ 1]  343 	bres	0x5235, #5
      00840F                        344 00107$:
                                    345 ;	./libs/uart_lib.c: 30: }
      00840F 84               [ 1]  346 	pop	a
      008410 80               [11]  347 	iret
                                    348 ;	./libs/uart_lib.c: 32: void uart_write_irq(uint8_t *data_buf)
                                    349 ;	-----------------------------------------
                                    350 ;	 function uart_write_irq
                                    351 ;	-----------------------------------------
      008411                        352 _uart_write_irq:
      008411 52 02            [ 2]  353 	sub	sp, #2
                                    354 ;	./libs/uart_lib.c: 34: tx_buf_pointer = data_buf;
      008413 1F 01            [ 2]  355 	ldw	(0x01, sp), x
      008415 CF 00 01         [ 2]  356 	ldw	_tx_buf_pointer+0, x
                                    357 ;	./libs/uart_lib.c: 35: buf_pos = 0;
      008418 72 5F 00 05      [ 1]  358 	clr	_buf_pos+0
                                    359 ;	./libs/uart_lib.c: 36: buf_size = 0;
      00841C 72 5F 00 06      [ 1]  360 	clr	_buf_size+0
                                    361 ;	./libs/uart_lib.c: 37: while (data_buf[buf_size++] != '\0');
      008420                        362 00101$:
      008420 C6 00 06         [ 1]  363 	ld	a, _buf_size+0
      008423 72 5C 00 06      [ 1]  364 	inc	_buf_size+0
      008427 5F               [ 1]  365 	clrw	x
      008428 97               [ 1]  366 	ld	xl, a
      008429 72 FB 01         [ 2]  367 	addw	x, (0x01, sp)
      00842C F6               [ 1]  368 	ld	a, (x)
      00842D 26 F1            [ 1]  369 	jrne	00101$
                                    370 ;	./libs/uart_lib.c: 38: UART1_CR2 -> TIEN = 1;
      00842F 72 1E 52 35      [ 1]  371 	bset	0x5235, #7
                                    372 ;	./libs/uart_lib.c: 39: while(UART1_CR2 -> TIEN);
      008433                        373 00104$:
      008433 72 0E 52 35 FB   [ 2]  374 	btjt	0x5235, #7, 00104$
                                    375 ;	./libs/uart_lib.c: 40: }
      008438 5B 02            [ 2]  376 	addw	sp, #2
      00843A 81               [ 4]  377 	ret
                                    378 ;	./libs/uart_lib.c: 41: void uart_read_irq(uint8_t *data_buf,int size)
                                    379 ;	-----------------------------------------
                                    380 ;	 function uart_read_irq
                                    381 ;	-----------------------------------------
      00843B                        382 _uart_read_irq:
                                    383 ;	./libs/uart_lib.c: 43: rx_buf_pointer = data_buf;
      00843B CF 00 03         [ 2]  384 	ldw	_rx_buf_pointer+0, x
                                    385 ;	./libs/uart_lib.c: 44: buf_pos = 0;
      00843E 72 5F 00 05      [ 1]  386 	clr	_buf_pos+0
                                    387 ;	./libs/uart_lib.c: 45: buf_size = size;
      008442 7B 04            [ 1]  388 	ld	a, (0x04, sp)
      008444 C7 00 06         [ 1]  389 	ld	_buf_size+0, a
                                    390 ;	./libs/uart_lib.c: 46: UART1_CR2 -> RIEN = 1;
      008447 72 1A 52 35      [ 1]  391 	bset	0x5235, #5
                                    392 ;	./libs/uart_lib.c: 47: while(UART1_CR2 -> RIEN);
      00844B                        393 00101$:
      00844B C6 52 35         [ 1]  394 	ld	a, 0x5235
      00844E 4E               [ 1]  395 	swap	a
      00844F 44               [ 1]  396 	srl	a
      008450 A4 01            [ 1]  397 	and	a, #0x01
      008452 26 F7            [ 1]  398 	jrne	00101$
                                    399 ;	./libs/uart_lib.c: 48: }
      008454 1E 01            [ 2]  400 	ldw	x, (1, sp)
      008456 5B 04            [ 2]  401 	addw	sp, #4
      008458 FC               [ 2]  402 	jp	(x)
                                    403 ;	./libs/uart_lib.c: 50: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    404 ;	-----------------------------------------
                                    405 ;	 function uart_init
                                    406 ;	-----------------------------------------
      008459                        407 _uart_init:
      008459 52 02            [ 2]  408 	sub	sp, #2
      00845B 1F 01            [ 2]  409 	ldw	(0x01, sp), x
                                    410 ;	./libs/uart_lib.c: 54: UART1_CR2 -> TEN = 1; // Transmitter enable
      00845D AE 52 35         [ 2]  411 	ldw	x, #0x5235
      008460 88               [ 1]  412 	push	a
      008461 F6               [ 1]  413 	ld	a, (x)
      008462 AA 08            [ 1]  414 	or	a, #0x08
      008464 F7               [ 1]  415 	ld	(x), a
      008465 84               [ 1]  416 	pop	a
                                    417 ;	./libs/uart_lib.c: 55: UART1_CR2 -> REN = 1; // Receiver enable
      008466 AE 52 35         [ 2]  418 	ldw	x, #0x5235
      008469 88               [ 1]  419 	push	a
      00846A F6               [ 1]  420 	ld	a, (x)
      00846B AA 04            [ 1]  421 	or	a, #0x04
      00846D F7               [ 1]  422 	ld	(x), a
      00846E 84               [ 1]  423 	pop	a
                                    424 ;	./libs/uart_lib.c: 56: switch(stopbit)
      00846F A1 02            [ 1]  425 	cp	a, #0x02
      008471 27 06            [ 1]  426 	jreq	00101$
      008473 A1 03            [ 1]  427 	cp	a, #0x03
      008475 27 0E            [ 1]  428 	jreq	00102$
      008477 20 16            [ 2]  429 	jra	00103$
                                    430 ;	./libs/uart_lib.c: 58: case 2:
      008479                        431 00101$:
                                    432 ;	./libs/uart_lib.c: 59: UART1_CR3 -> STOP = 2;
      008479 C6 52 36         [ 1]  433 	ld	a, 0x5236
      00847C A4 CF            [ 1]  434 	and	a, #0xcf
      00847E AA 20            [ 1]  435 	or	a, #0x20
      008480 C7 52 36         [ 1]  436 	ld	0x5236, a
                                    437 ;	./libs/uart_lib.c: 60: break;
      008483 20 12            [ 2]  438 	jra	00104$
                                    439 ;	./libs/uart_lib.c: 61: case 3:
      008485                        440 00102$:
                                    441 ;	./libs/uart_lib.c: 62: UART1_CR3 -> STOP = 3;
      008485 C6 52 36         [ 1]  442 	ld	a, 0x5236
      008488 AA 30            [ 1]  443 	or	a, #0x30
      00848A C7 52 36         [ 1]  444 	ld	0x5236, a
                                    445 ;	./libs/uart_lib.c: 63: break;
      00848D 20 08            [ 2]  446 	jra	00104$
                                    447 ;	./libs/uart_lib.c: 64: default:
      00848F                        448 00103$:
                                    449 ;	./libs/uart_lib.c: 65: UART1_CR3 -> STOP = 0;
      00848F C6 52 36         [ 1]  450 	ld	a, 0x5236
      008492 A4 CF            [ 1]  451 	and	a, #0xcf
      008494 C7 52 36         [ 1]  452 	ld	0x5236, a
                                    453 ;	./libs/uart_lib.c: 67: }
      008497                        454 00104$:
                                    455 ;	./libs/uart_lib.c: 68: switch(baudrate)
      008497 1E 01            [ 2]  456 	ldw	x, (0x01, sp)
      008499 A3 08 00         [ 2]  457 	cpw	x, #0x0800
      00849C 26 03            [ 1]  458 	jrne	00186$
      00849E CC 85 2A         [ 2]  459 	jp	00110$
      0084A1                        460 00186$:
      0084A1 1E 01            [ 2]  461 	ldw	x, (0x01, sp)
      0084A3 A3 09 60         [ 2]  462 	cpw	x, #0x0960
      0084A6 27 28            [ 1]  463 	jreq	00105$
      0084A8 1E 01            [ 2]  464 	ldw	x, (0x01, sp)
      0084AA A3 10 00         [ 2]  465 	cpw	x, #0x1000
      0084AD 26 03            [ 1]  466 	jrne	00192$
      0084AF CC 85 3A         [ 2]  467 	jp	00111$
      0084B2                        468 00192$:
      0084B2 1E 01            [ 2]  469 	ldw	x, (0x01, sp)
      0084B4 A3 4B 00         [ 2]  470 	cpw	x, #0x4b00
      0084B7 27 31            [ 1]  471 	jreq	00106$
      0084B9 1E 01            [ 2]  472 	ldw	x, (0x01, sp)
      0084BB A3 84 00         [ 2]  473 	cpw	x, #0x8400
      0084BE 27 5A            [ 1]  474 	jreq	00109$
      0084C0 1E 01            [ 2]  475 	ldw	x, (0x01, sp)
      0084C2 A3 C2 00         [ 2]  476 	cpw	x, #0xc200
      0084C5 27 43            [ 1]  477 	jreq	00108$
      0084C7 1E 01            [ 2]  478 	ldw	x, (0x01, sp)
      0084C9 A3 E1 00         [ 2]  479 	cpw	x, #0xe100
      0084CC 27 2C            [ 1]  480 	jreq	00107$
      0084CE 20 7A            [ 2]  481 	jra	00112$
                                    482 ;	./libs/uart_lib.c: 70: case (unsigned int)2400:
      0084D0                        483 00105$:
                                    484 ;	./libs/uart_lib.c: 71: UART1_BRR2 -> MSB = 0x01;
      0084D0 C6 52 33         [ 1]  485 	ld	a, 0x5233
      0084D3 A4 0F            [ 1]  486 	and	a, #0x0f
      0084D5 AA 10            [ 1]  487 	or	a, #0x10
      0084D7 C7 52 33         [ 1]  488 	ld	0x5233, a
                                    489 ;	./libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0xA0;
      0084DA 35 A0 52 32      [ 1]  490 	mov	0x5232+0, #0xa0
                                    491 ;	./libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x0B; 
      0084DE C6 52 33         [ 1]  492 	ld	a, 0x5233
      0084E1 A4 F0            [ 1]  493 	and	a, #0xf0
      0084E3 AA 0B            [ 1]  494 	or	a, #0x0b
      0084E5 C7 52 33         [ 1]  495 	ld	0x5233, a
                                    496 ;	./libs/uart_lib.c: 74: break;
      0084E8 20 6E            [ 2]  497 	jra	00114$
                                    498 ;	./libs/uart_lib.c: 75: case (unsigned int)19200:
      0084EA                        499 00106$:
                                    500 ;	./libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x34;
      0084EA 35 34 52 32      [ 1]  501 	mov	0x5232+0, #0x34
                                    502 ;	./libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      0084EE C6 52 33         [ 1]  503 	ld	a, 0x5233
      0084F1 A4 F0            [ 1]  504 	and	a, #0xf0
      0084F3 AA 01            [ 1]  505 	or	a, #0x01
      0084F5 C7 52 33         [ 1]  506 	ld	0x5233, a
                                    507 ;	./libs/uart_lib.c: 78: break;
      0084F8 20 5E            [ 2]  508 	jra	00114$
                                    509 ;	./libs/uart_lib.c: 79: case (unsigned int)57600:
      0084FA                        510 00107$:
                                    511 ;	./libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x11;
      0084FA 35 11 52 32      [ 1]  512 	mov	0x5232+0, #0x11
                                    513 ;	./libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x06;
      0084FE C6 52 33         [ 1]  514 	ld	a, 0x5233
      008501 A4 F0            [ 1]  515 	and	a, #0xf0
      008503 AA 06            [ 1]  516 	or	a, #0x06
      008505 C7 52 33         [ 1]  517 	ld	0x5233, a
                                    518 ;	./libs/uart_lib.c: 82: break;
      008508 20 4E            [ 2]  519 	jra	00114$
                                    520 ;	./libs/uart_lib.c: 83: case (unsigned int)115200:
      00850A                        521 00108$:
                                    522 ;	./libs/uart_lib.c: 84: UART1_BRR1 -> DIV = 0x08;
      00850A 35 08 52 32      [ 1]  523 	mov	0x5232+0, #0x08
                                    524 ;	./libs/uart_lib.c: 85: UART1_BRR2 -> LSB = 0x0B;
      00850E C6 52 33         [ 1]  525 	ld	a, 0x5233
      008511 A4 F0            [ 1]  526 	and	a, #0xf0
      008513 AA 0B            [ 1]  527 	or	a, #0x0b
      008515 C7 52 33         [ 1]  528 	ld	0x5233, a
                                    529 ;	./libs/uart_lib.c: 86: break;
      008518 20 3E            [ 2]  530 	jra	00114$
                                    531 ;	./libs/uart_lib.c: 87: case (unsigned int)230400:
      00851A                        532 00109$:
                                    533 ;	./libs/uart_lib.c: 88: UART1_BRR1 -> DIV = 0x04;
      00851A 35 04 52 32      [ 1]  534 	mov	0x5232+0, #0x04
                                    535 ;	./libs/uart_lib.c: 89: UART1_BRR2 -> LSB = 0x05;
      00851E C6 52 33         [ 1]  536 	ld	a, 0x5233
      008521 A4 F0            [ 1]  537 	and	a, #0xf0
      008523 AA 05            [ 1]  538 	or	a, #0x05
      008525 C7 52 33         [ 1]  539 	ld	0x5233, a
                                    540 ;	./libs/uart_lib.c: 90: break;
      008528 20 2E            [ 2]  541 	jra	00114$
                                    542 ;	./libs/uart_lib.c: 91: case (unsigned int)460800:
      00852A                        543 00110$:
                                    544 ;	./libs/uart_lib.c: 92: UART1_BRR1 -> DIV = 0x02;
      00852A 35 02 52 32      [ 1]  545 	mov	0x5232+0, #0x02
                                    546 ;	./libs/uart_lib.c: 93: UART1_BRR2 -> LSB = 0x03;
      00852E C6 52 33         [ 1]  547 	ld	a, 0x5233
      008531 A4 F0            [ 1]  548 	and	a, #0xf0
      008533 AA 03            [ 1]  549 	or	a, #0x03
      008535 C7 52 33         [ 1]  550 	ld	0x5233, a
                                    551 ;	./libs/uart_lib.c: 94: break;
      008538 20 1E            [ 2]  552 	jra	00114$
                                    553 ;	./libs/uart_lib.c: 95: case (unsigned int)921600:
      00853A                        554 00111$:
                                    555 ;	./libs/uart_lib.c: 96: UART1_BRR1 -> DIV = 0x01;
      00853A 35 01 52 32      [ 1]  556 	mov	0x5232+0, #0x01
                                    557 ;	./libs/uart_lib.c: 97: UART1_BRR2 -> LSB = 0x01;
      00853E C6 52 33         [ 1]  558 	ld	a, 0x5233
      008541 A4 F0            [ 1]  559 	and	a, #0xf0
      008543 AA 01            [ 1]  560 	or	a, #0x01
      008545 C7 52 33         [ 1]  561 	ld	0x5233, a
                                    562 ;	./libs/uart_lib.c: 98: break;
      008548 20 0E            [ 2]  563 	jra	00114$
                                    564 ;	./libs/uart_lib.c: 99: default:
      00854A                        565 00112$:
                                    566 ;	./libs/uart_lib.c: 100: UART1_BRR1 -> DIV = 0x68;
      00854A 35 68 52 32      [ 1]  567 	mov	0x5232+0, #0x68
                                    568 ;	./libs/uart_lib.c: 101: UART1_BRR2 -> LSB = 0x03;
      00854E C6 52 33         [ 1]  569 	ld	a, 0x5233
      008551 A4 F0            [ 1]  570 	and	a, #0xf0
      008553 AA 03            [ 1]  571 	or	a, #0x03
      008555 C7 52 33         [ 1]  572 	ld	0x5233, a
                                    573 ;	./libs/uart_lib.c: 103: }
      008558                        574 00114$:
                                    575 ;	./libs/uart_lib.c: 104: }
      008558 5B 02            [ 2]  576 	addw	sp, #2
      00855A 81               [ 4]  577 	ret
                                    578 ;	./libs/uart_lib.c: 106: int uart_read_byte(uint8_t *data)
                                    579 ;	-----------------------------------------
                                    580 ;	 function uart_read_byte
                                    581 ;	-----------------------------------------
      00855B                        582 _uart_read_byte:
                                    583 ;	./libs/uart_lib.c: 108: while(!(UART1_SR -> RXNE));
      00855B                        584 00101$:
      00855B 72 0B 52 30 FB   [ 2]  585 	btjf	0x5230, #5, 00101$
                                    586 ;	./libs/uart_lib.c: 110: return 1;
      008560 5F               [ 1]  587 	clrw	x
      008561 5C               [ 1]  588 	incw	x
                                    589 ;	./libs/uart_lib.c: 111: }
      008562 81               [ 4]  590 	ret
                                    591 ;	./libs/uart_lib.c: 113: int uart_write_byte(uint8_t data)
                                    592 ;	-----------------------------------------
                                    593 ;	 function uart_write_byte
                                    594 ;	-----------------------------------------
      008563                        595 _uart_write_byte:
                                    596 ;	./libs/uart_lib.c: 115: UART1_DR -> DR = data;
      008563 C7 52 31         [ 1]  597 	ld	0x5231, a
                                    598 ;	./libs/uart_lib.c: 116: while(!(UART1_SR -> TXE));
      008566                        599 00101$:
      008566 72 0F 52 30 FB   [ 2]  600 	btjf	0x5230, #7, 00101$
                                    601 ;	./libs/uart_lib.c: 117: return 1;
      00856B 5F               [ 1]  602 	clrw	x
      00856C 5C               [ 1]  603 	incw	x
                                    604 ;	./libs/uart_lib.c: 118: }
      00856D 81               [ 4]  605 	ret
                                    606 ;	./libs/uart_lib.c: 120: int uart_write(uint8_t *data_buf)
                                    607 ;	-----------------------------------------
                                    608 ;	 function uart_write
                                    609 ;	-----------------------------------------
      00856E                        610 _uart_write:
      00856E 52 04            [ 2]  611 	sub	sp, #4
      008570 1F 01            [ 2]  612 	ldw	(0x01, sp), x
                                    613 ;	./libs/uart_lib.c: 122: int count = 0;
      008572 5F               [ 1]  614 	clrw	x
      008573 1F 03            [ 2]  615 	ldw	(0x03, sp), x
                                    616 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008575 5F               [ 1]  617 	clrw	x
      008576                        618 00103$:
      008576 90 93            [ 1]  619 	ldw	y, x
      008578 72 F9 01         [ 2]  620 	addw	y, (0x01, sp)
      00857B 90 F6            [ 1]  621 	ld	a, (y)
      00857D 27 0E            [ 1]  622 	jreq	00101$
                                    623 ;	./libs/uart_lib.c: 124: count += uart_write_byte(data_buf[i]);
      00857F 89               [ 2]  624 	pushw	x
      008580 CD 85 63         [ 4]  625 	call	_uart_write_byte
      008583 51               [ 1]  626 	exgw	x, y
      008584 85               [ 2]  627 	popw	x
      008585 72 F9 03         [ 2]  628 	addw	y, (0x03, sp)
      008588 17 03            [ 2]  629 	ldw	(0x03, sp), y
                                    630 ;	./libs/uart_lib.c: 123: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      00858A 5C               [ 1]  631 	incw	x
      00858B 20 E9            [ 2]  632 	jra	00103$
      00858D                        633 00101$:
                                    634 ;	./libs/uart_lib.c: 125: return count;
      00858D 1E 03            [ 2]  635 	ldw	x, (0x03, sp)
                                    636 ;	./libs/uart_lib.c: 126: }
      00858F 5B 04            [ 2]  637 	addw	sp, #4
      008591 81               [ 4]  638 	ret
                                    639 ;	./libs/uart_lib.c: 127: int uart_read(uint8_t *data_buf,int size)
                                    640 ;	-----------------------------------------
                                    641 ;	 function uart_read
                                    642 ;	-----------------------------------------
      008592                        643 _uart_read:
      008592 52 04            [ 2]  644 	sub	sp, #4
      008594 1F 01            [ 2]  645 	ldw	(0x01, sp), x
                                    646 ;	./libs/uart_lib.c: 130: int count = 0;
      008596 5F               [ 1]  647 	clrw	x
      008597 1F 03            [ 2]  648 	ldw	(0x03, sp), x
                                    649 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008599 5F               [ 1]  650 	clrw	x
      00859A                        651 00103$:
      00859A 90 93            [ 1]  652 	ldw	y, x
      00859C 72 F9 01         [ 2]  653 	addw	y, (0x01, sp)
      00859F 90 F6            [ 1]  654 	ld	a, (y)
      0085A1 27 13            [ 1]  655 	jreq	00101$
                                    656 ;	./libs/uart_lib.c: 132: count += uart_read_byte((unsigned char *)data_buf[i]);
      0085A3 90 5F            [ 1]  657 	clrw	y
      0085A5 90 97            [ 1]  658 	ld	yl, a
      0085A7 89               [ 2]  659 	pushw	x
      0085A8 93               [ 1]  660 	ldw	x, y
      0085A9 CD 85 5B         [ 4]  661 	call	_uart_read_byte
      0085AC 51               [ 1]  662 	exgw	x, y
      0085AD 85               [ 2]  663 	popw	x
      0085AE 72 F9 03         [ 2]  664 	addw	y, (0x03, sp)
      0085B1 17 03            [ 2]  665 	ldw	(0x03, sp), y
                                    666 ;	./libs/uart_lib.c: 131: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0085B3 5C               [ 1]  667 	incw	x
      0085B4 20 E4            [ 2]  668 	jra	00103$
      0085B6                        669 00101$:
                                    670 ;	./libs/uart_lib.c: 133: return count;
      0085B6 1E 03            [ 2]  671 	ldw	x, (0x03, sp)
                                    672 ;	./libs/uart_lib.c: 134: }
      0085B8 5B 04            [ 2]  673 	addw	sp, #4
      0085BA 90 85            [ 2]  674 	popw	y
      0085BC 5B 02            [ 2]  675 	addw	sp, #2
      0085BE 90 FC            [ 2]  676 	jp	(y)
                                    677 ;	./libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    678 ;	-----------------------------------------
                                    679 ;	 function i2c_irq
                                    680 ;	-----------------------------------------
      0085C0                        681 _i2c_irq:
      0085C0 4F               [ 1]  682 	clr	a
      0085C1 62               [ 2]  683 	div	x, a
                                    684 ;	./libs/i2c_lib.c: 6: disableInterrupts();
      0085C2 9B               [ 1]  685 	sim
                                    686 ;	./libs/i2c_lib.c: 7: I2C_IRQ.all = 0;//обнуление флагов регистров
      0085C3 35 00 00 07      [ 1]  687 	mov	_I2C_IRQ+0, #0x00
                                    688 ;	./libs/i2c_lib.c: 9: if(I2C_SR1 -> ADDR)//прерывание адреса
      0085C7 AE 52 17         [ 2]  689 	ldw	x, #0x5217
      0085CA F6               [ 1]  690 	ld	a, (x)
      0085CB 44               [ 1]  691 	srl	a
      0085CC A4 01            [ 1]  692 	and	a, #0x01
      0085CE 27 16            [ 1]  693 	jreq	00102$
                                    694 ;	./libs/i2c_lib.c: 11: clr_sr1();
      0085D0 C6 52 17         [ 1]  695 	ld	a,0x5217
                                    696 ;	./libs/i2c_lib.c: 12: I2C_IRQ.ADDR = 1;
      0085D3 72 12 00 07      [ 1]  697 	bset	_I2C_IRQ+0, #1
                                    698 ;	./libs/i2c_lib.c: 13: clr_sr3();//EV6
      0085D7 C6 52 19         [ 1]  699 	ld	a,0x5219
                                    700 ;	./libs/i2c_lib.c: 14: I2C_ITR -> ITEVTEN = 0;
      0085DA 72 13 52 1A      [ 1]  701 	bres	0x521a, #1
                                    702 ;	./libs/i2c_lib.c: 15: uart_write_byte(0xE1);
      0085DE A6 E1            [ 1]  703 	ld	a, #0xe1
      0085E0 CD 85 63         [ 4]  704 	call	_uart_write_byte
                                    705 ;	./libs/i2c_lib.c: 16: return;
      0085E3 CC 86 79         [ 2]  706 	jp	00113$
      0085E6                        707 00102$:
                                    708 ;	./libs/i2c_lib.c: 19: if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
      0085E6 C6 52 17         [ 1]  709 	ld	a, 0x5217
      0085E9 4E               [ 1]  710 	swap	a
      0085EA 44               [ 1]  711 	srl	a
      0085EB 44               [ 1]  712 	srl	a
      0085EC 44               [ 1]  713 	srl	a
      0085ED A5 01            [ 1]  714 	bcp	a, #0x01
      0085EF 27 17            [ 1]  715 	jreq	00104$
                                    716 ;	./libs/i2c_lib.c: 21: I2C_IRQ.TXE = 1;
      0085F1 72 18 00 07      [ 1]  717 	bset	_I2C_IRQ+0, #4
                                    718 ;	./libs/i2c_lib.c: 22: I2C_ITR -> ITBUFEN = 0;
      0085F5 72 15 52 1A      [ 1]  719 	bres	0x521a, #2
                                    720 ;	./libs/i2c_lib.c: 23: I2C_ITR -> ITEVTEN = 0;
      0085F9 72 13 52 1A      [ 1]  721 	bres	0x521a, #1
                                    722 ;	./libs/i2c_lib.c: 24: I2C_ITR -> ITERREN = 0;
      0085FD 72 11 52 1A      [ 1]  723 	bres	0x521a, #0
                                    724 ;	./libs/i2c_lib.c: 25: uart_write_byte(0xEA);
      008601 A6 EA            [ 1]  725 	ld	a, #0xea
      008603 CD 85 63         [ 4]  726 	call	_uart_write_byte
                                    727 ;	./libs/i2c_lib.c: 26: return;
      008606 20 71            [ 2]  728 	jra	00113$
      008608                        729 00104$:
                                    730 ;	./libs/i2c_lib.c: 28: if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
      008608 C6 52 17         [ 1]  731 	ld	a, 0x5217
      00860B 4E               [ 1]  732 	swap	a
      00860C 44               [ 1]  733 	srl	a
      00860D 44               [ 1]  734 	srl	a
      00860E A5 01            [ 1]  735 	bcp	a, #0x01
      008610 27 17            [ 1]  736 	jreq	00106$
                                    737 ;	./libs/i2c_lib.c: 30: I2C_IRQ.RXNE = 1;
      008612 72 16 00 07      [ 1]  738 	bset	_I2C_IRQ+0, #3
                                    739 ;	./libs/i2c_lib.c: 31: I2C_ITR -> ITBUFEN = 0;
      008616 72 15 52 1A      [ 1]  740 	bres	0x521a, #2
                                    741 ;	./libs/i2c_lib.c: 32: I2C_ITR -> ITEVTEN = 0;
      00861A 72 13 52 1A      [ 1]  742 	bres	0x521a, #1
                                    743 ;	./libs/i2c_lib.c: 33: I2C_ITR -> ITERREN = 0;
      00861E 72 11 52 1A      [ 1]  744 	bres	0x521a, #0
                                    745 ;	./libs/i2c_lib.c: 34: uart_write_byte(0xEB);
      008622 A6 EB            [ 1]  746 	ld	a, #0xeb
      008624 CD 85 63         [ 4]  747 	call	_uart_write_byte
                                    748 ;	./libs/i2c_lib.c: 35: return;
      008627 20 50            [ 2]  749 	jra	00113$
      008629                        750 00106$:
                                    751 ;	./libs/i2c_lib.c: 38: if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
      008629 C6 52 17         [ 1]  752 	ld	a, 0x5217
      00862C A5 01            [ 1]  753 	bcp	a, #0x01
      00862E 27 0F            [ 1]  754 	jreq	00108$
                                    755 ;	./libs/i2c_lib.c: 40: I2C_IRQ.SB = 1;
      008630 72 10 00 07      [ 1]  756 	bset	_I2C_IRQ+0, #0
                                    757 ;	./libs/i2c_lib.c: 41: I2C_ITR -> ITEVTEN = 0;
      008634 72 13 52 1A      [ 1]  758 	bres	0x521a, #1
                                    759 ;	./libs/i2c_lib.c: 42: uart_write_byte(0xE2);
      008638 A6 E2            [ 1]  760 	ld	a, #0xe2
      00863A CD 85 63         [ 4]  761 	call	_uart_write_byte
                                    762 ;	./libs/i2c_lib.c: 43: return;
      00863D 20 3A            [ 2]  763 	jra	00113$
      00863F                        764 00108$:
                                    765 ;	./libs/i2c_lib.c: 45: if(I2C_SR1 -> BTF) //прерывание отправки данных
      00863F C6 52 17         [ 1]  766 	ld	a, 0x5217
      008642 44               [ 1]  767 	srl	a
      008643 44               [ 1]  768 	srl	a
      008644 A5 01            [ 1]  769 	bcp	a, #0x01
      008646 27 0F            [ 1]  770 	jreq	00110$
                                    771 ;	./libs/i2c_lib.c: 47: I2C_IRQ.BTF = 1;
      008648 72 14 00 07      [ 1]  772 	bset	_I2C_IRQ+0, #2
                                    773 ;	./libs/i2c_lib.c: 48: I2C_ITR -> ITEVTEN = 0;
      00864C 72 13 52 1A      [ 1]  774 	bres	0x521a, #1
                                    775 ;	./libs/i2c_lib.c: 49: uart_write_byte(0xE3);
      008650 A6 E3            [ 1]  776 	ld	a, #0xe3
      008652 CD 85 63         [ 4]  777 	call	_uart_write_byte
                                    778 ;	./libs/i2c_lib.c: 50: return;
      008655 20 22            [ 2]  779 	jra	00113$
      008657                        780 00110$:
                                    781 ;	./libs/i2c_lib.c: 53: if(I2C_SR2 -> AF) //прерывание ошибки NACK
      008657 AE 52 18         [ 2]  782 	ldw	x, #0x5218
      00865A F6               [ 1]  783 	ld	a, (x)
      00865B 44               [ 1]  784 	srl	a
      00865C 44               [ 1]  785 	srl	a
      00865D A4 01            [ 1]  786 	and	a, #0x01
      00865F 27 17            [ 1]  787 	jreq	00112$
                                    788 ;	./libs/i2c_lib.c: 55: I2C_IRQ.AF = 1;
      008661 72 1A 00 07      [ 1]  789 	bset	_I2C_IRQ+0, #5
                                    790 ;	./libs/i2c_lib.c: 56: I2C_ITR -> ITEVTEN = 0;
      008665 72 13 52 1A      [ 1]  791 	bres	0x521a, #1
                                    792 ;	./libs/i2c_lib.c: 57: I2C_ITR -> ITERREN = 0;
      008669 72 11 52 1A      [ 1]  793 	bres	0x521a, #0
                                    794 ;	./libs/i2c_lib.c: 58: I2C_ITR -> ITBUFEN = 0;
      00866D 72 15 52 1A      [ 1]  795 	bres	0x521a, #2
                                    796 ;	./libs/i2c_lib.c: 59: uart_write_byte(0xEE);
      008671 A6 EE            [ 1]  797 	ld	a, #0xee
      008673 CD 85 63         [ 4]  798 	call	_uart_write_byte
                                    799 ;	./libs/i2c_lib.c: 60: return;
      008676 20 01            [ 2]  800 	jra	00113$
      008678                        801 00112$:
                                    802 ;	./libs/i2c_lib.c: 63: enableInterrupts(); 
      008678 9A               [ 1]  803 	rim
      008679                        804 00113$:
                                    805 ;	./libs/i2c_lib.c: 64: }
      008679 80               [11]  806 	iret
                                    807 ;	./libs/i2c_lib.c: 66: void i2c_init(void)
                                    808 ;	-----------------------------------------
                                    809 ;	 function i2c_init
                                    810 ;	-----------------------------------------
      00867A                        811 _i2c_init:
                                    812 ;	./libs/i2c_lib.c: 70: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      00867A 72 11 52 10      [ 1]  813 	bres	0x5210, #0
                                    814 ;	./libs/i2c_lib.c: 71: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      00867E C6 52 12         [ 1]  815 	ld	a, 0x5212
      008681 A4 C0            [ 1]  816 	and	a, #0xc0
      008683 AA 10            [ 1]  817 	or	a, #0x10
      008685 C7 52 12         [ 1]  818 	ld	0x5212, a
                                    819 ;	./libs/i2c_lib.c: 72: I2C_CCRH -> CCR = 0;// =0
      008688 C6 52 1C         [ 1]  820 	ld	a, 0x521c
      00868B A4 F0            [ 1]  821 	and	a, #0xf0
      00868D C7 52 1C         [ 1]  822 	ld	0x521c, a
                                    823 ;	./libs/i2c_lib.c: 73: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008690 35 50 52 1B      [ 1]  824 	mov	0x521b+0, #0x50
                                    825 ;	./libs/i2c_lib.c: 74: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      008694 72 1F 52 1C      [ 1]  826 	bres	0x521c, #7
                                    827 ;	./libs/i2c_lib.c: 75: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      008698 72 1F 52 14      [ 1]  828 	bres	0x5214, #7
                                    829 ;	./libs/i2c_lib.c: 76: I2C_OARH -> ADDCONF = 1;// see reference manual
      00869C 72 10 52 14      [ 1]  830 	bset	0x5214, #0
                                    831 ;	./libs/i2c_lib.c: 77: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0086A0 72 10 52 10      [ 1]  832 	bset	0x5210, #0
                                    833 ;	./libs/i2c_lib.c: 78: }
      0086A4 81               [ 4]  834 	ret
                                    835 ;	./libs/i2c_lib.c: 80: void i2c_start(void)
                                    836 ;	-----------------------------------------
                                    837 ;	 function i2c_start
                                    838 ;	-----------------------------------------
      0086A5                        839 _i2c_start:
                                    840 ;	./libs/i2c_lib.c: 82: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0086A5 72 10 52 11      [ 1]  841 	bset	0x5211, #0
                                    842 ;	./libs/i2c_lib.c: 83: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0086A9                        843 00101$:
      0086A9 72 01 52 17 FB   [ 2]  844 	btjf	0x5217, #0, 00101$
                                    845 ;	./libs/i2c_lib.c: 84: }
      0086AE 81               [ 4]  846 	ret
                                    847 ;	./libs/i2c_lib.c: 86: void i2c_stop(void)
                                    848 ;	-----------------------------------------
                                    849 ;	 function i2c_stop
                                    850 ;	-----------------------------------------
      0086AF                        851 _i2c_stop:
                                    852 ;	./libs/i2c_lib.c: 88: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0086AF 72 12 52 11      [ 1]  853 	bset	0x5211, #1
                                    854 ;	./libs/i2c_lib.c: 89: }
      0086B3 81               [ 4]  855 	ret
                                    856 ;	./libs/i2c_lib.c: 91: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    857 ;	-----------------------------------------
                                    858 ;	 function i2c_send_address
                                    859 ;	-----------------------------------------
      0086B4                        860 _i2c_send_address:
                                    861 ;	./libs/i2c_lib.c: 96: address = address << 1;
      0086B4 48               [ 1]  862 	sll	a
                                    863 ;	./libs/i2c_lib.c: 93: switch(rw_type)
      0086B5 88               [ 1]  864 	push	a
      0086B6 7B 04            [ 1]  865 	ld	a, (0x04, sp)
      0086B8 4A               [ 1]  866 	dec	a
      0086B9 84               [ 1]  867 	pop	a
      0086BA 26 02            [ 1]  868 	jrne	00102$
                                    869 ;	./libs/i2c_lib.c: 96: address = address << 1;
                                    870 ;	./libs/i2c_lib.c: 97: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0086BC AA 01            [ 1]  871 	or	a, #0x01
                                    872 ;	./libs/i2c_lib.c: 98: break;
                                    873 ;	./libs/i2c_lib.c: 99: default:
                                    874 ;	./libs/i2c_lib.c: 100: address = address << 1; // Отправка адреса устройства с битом на запись
                                    875 ;	./libs/i2c_lib.c: 102: }
      0086BE                        876 00102$:
                                    877 ;	./libs/i2c_lib.c: 103: i2c_start();
      0086BE 88               [ 1]  878 	push	a
      0086BF CD 86 A5         [ 4]  879 	call	_i2c_start
      0086C2 84               [ 1]  880 	pop	a
                                    881 ;	./libs/i2c_lib.c: 104: I2C_DR -> DR = address;
      0086C3 C7 52 16         [ 1]  882 	ld	0x5216, a
                                    883 ;	./libs/i2c_lib.c: 105: while(!I2C_SR1 -> ADDR)
      0086C6                        884 00106$:
      0086C6 AE 52 17         [ 2]  885 	ldw	x, #0x5217
      0086C9 F6               [ 1]  886 	ld	a, (x)
      0086CA 44               [ 1]  887 	srl	a
      0086CB A4 01            [ 1]  888 	and	a, #0x01
      0086CD 26 08            [ 1]  889 	jrne	00108$
                                    890 ;	./libs/i2c_lib.c: 106: if(I2C_SR2 -> AF)
      0086CF 72 05 52 18 F2   [ 2]  891 	btjf	0x5218, #2, 00106$
                                    892 ;	./libs/i2c_lib.c: 107: return 0;
      0086D4 4F               [ 1]  893 	clr	a
      0086D5 20 08            [ 2]  894 	jra	00109$
      0086D7                        895 00108$:
                                    896 ;	./libs/i2c_lib.c: 108: clr_sr1();
      0086D7 C6 52 17         [ 1]  897 	ld	a,0x5217
                                    898 ;	./libs/i2c_lib.c: 109: clr_sr3();
      0086DA C6 52 19         [ 1]  899 	ld	a,0x5219
                                    900 ;	./libs/i2c_lib.c: 110: return 1;
      0086DD A6 01            [ 1]  901 	ld	a, #0x01
      0086DF                        902 00109$:
                                    903 ;	./libs/i2c_lib.c: 111: }
      0086DF 85               [ 2]  904 	popw	x
      0086E0 5B 01            [ 2]  905 	addw	sp, #1
      0086E2 FC               [ 2]  906 	jp	(x)
                                    907 ;	./libs/i2c_lib.c: 113: uint8_t i2c_read_byte(void)
                                    908 ;	-----------------------------------------
                                    909 ;	 function i2c_read_byte
                                    910 ;	-----------------------------------------
      0086E3                        911 _i2c_read_byte:
                                    912 ;	./libs/i2c_lib.c: 115: while(!I2C_SR1 -> RXNE);
      0086E3                        913 00101$:
      0086E3 72 0D 52 17 FB   [ 2]  914 	btjf	0x5217, #6, 00101$
                                    915 ;	./libs/i2c_lib.c: 116: return I2C_DR -> DR;
      0086E8 C6 52 16         [ 1]  916 	ld	a, 0x5216
                                    917 ;	./libs/i2c_lib.c: 117: }
      0086EB 81               [ 4]  918 	ret
                                    919 ;	./libs/i2c_lib.c: 119: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    920 ;	-----------------------------------------
                                    921 ;	 function i2c_read
                                    922 ;	-----------------------------------------
      0086EC                        923 _i2c_read:
      0086EC 52 04            [ 2]  924 	sub	sp, #4
                                    925 ;	./libs/i2c_lib.c: 121: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      0086EE 4B 01            [ 1]  926 	push	#0x01
      0086F0 CD 86 B4         [ 4]  927 	call	_i2c_send_address
      0086F3 4D               [ 1]  928 	tnz	a
      0086F4 27 3C            [ 1]  929 	jreq	00103$
                                    930 ;	./libs/i2c_lib.c: 123: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      0086F6 72 14 52 11      [ 1]  931 	bset	0x5211, #2
                                    932 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      0086FA 5F               [ 1]  933 	clrw	x
      0086FB 1F 03            [ 2]  934 	ldw	(0x03, sp), x
      0086FD                        935 00105$:
      0086FD 5F               [ 1]  936 	clrw	x
      0086FE 7B 07            [ 1]  937 	ld	a, (0x07, sp)
      008700 97               [ 1]  938 	ld	xl, a
      008701 5A               [ 2]  939 	decw	x
      008702 1F 01            [ 2]  940 	ldw	(0x01, sp), x
      008704 1E 03            [ 2]  941 	ldw	x, (0x03, sp)
      008706 13 01            [ 2]  942 	cpw	x, (0x01, sp)
      008708 2E 12            [ 1]  943 	jrsge	00101$
                                    944 ;	./libs/i2c_lib.c: 126: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00870A 1E 08            [ 2]  945 	ldw	x, (0x08, sp)
      00870C 72 FB 03         [ 2]  946 	addw	x, (0x03, sp)
      00870F 89               [ 2]  947 	pushw	x
      008710 CD 86 E3         [ 4]  948 	call	_i2c_read_byte
      008713 85               [ 2]  949 	popw	x
      008714 F7               [ 1]  950 	ld	(x), a
                                    951 ;	./libs/i2c_lib.c: 124: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008715 1E 03            [ 2]  952 	ldw	x, (0x03, sp)
      008717 5C               [ 1]  953 	incw	x
      008718 1F 03            [ 2]  954 	ldw	(0x03, sp), x
      00871A 20 E1            [ 2]  955 	jra	00105$
      00871C                        956 00101$:
                                    957 ;	./libs/i2c_lib.c: 128: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00871C C6 52 11         [ 1]  958 	ld	a, 0x5211
      00871F A4 FB            [ 1]  959 	and	a, #0xfb
      008721 C7 52 11         [ 1]  960 	ld	0x5211, a
                                    961 ;	./libs/i2c_lib.c: 130: data[size-1] = i2c_read_byte();
      008724 1E 08            [ 2]  962 	ldw	x, (0x08, sp)
      008726 72 FB 01         [ 2]  963 	addw	x, (0x01, sp)
      008729 89               [ 2]  964 	pushw	x
      00872A CD 86 E3         [ 4]  965 	call	_i2c_read_byte
      00872D 85               [ 2]  966 	popw	x
      00872E F7               [ 1]  967 	ld	(x), a
                                    968 ;	./libs/i2c_lib.c: 132: i2c_stop();
      00872F CD 86 AF         [ 4]  969 	call	_i2c_stop
      008732                        970 00103$:
                                    971 ;	./libs/i2c_lib.c: 135: i2c_stop();
      008732 1E 05            [ 2]  972 	ldw	x, (5, sp)
      008734 1F 08            [ 2]  973 	ldw	(8, sp), x
      008736 5B 07            [ 2]  974 	addw	sp, #7
                                    975 ;	./libs/i2c_lib.c: 137: }
      008738 CC 86 AF         [ 2]  976 	jp	_i2c_stop
                                    977 ;	./libs/i2c_lib.c: 139: uint8_t i2c_send_byte(uint8_t data)
                                    978 ;	-----------------------------------------
                                    979 ;	 function i2c_send_byte
                                    980 ;	-----------------------------------------
      00873B                        981 _i2c_send_byte:
                                    982 ;	./libs/i2c_lib.c: 141: I2C_DR -> DR = data; //Отправка данных
      00873B C7 52 16         [ 1]  983 	ld	0x5216, a
                                    984 ;	./libs/i2c_lib.c: 142: while(!I2C_SR1 -> TXE)
      00873E                        985 00103$:
      00873E 72 0E 52 17 08   [ 2]  986 	btjt	0x5217, #7, 00105$
                                    987 ;	./libs/i2c_lib.c: 143: if(I2C_SR2 -> AF)
      008743 72 05 52 18 F6   [ 2]  988 	btjf	0x5218, #2, 00103$
                                    989 ;	./libs/i2c_lib.c: 144: return 1;
      008748 A6 01            [ 1]  990 	ld	a, #0x01
      00874A 81               [ 4]  991 	ret
      00874B                        992 00105$:
                                    993 ;	./libs/i2c_lib.c: 145: return 0;//флаг ответа
      00874B 4F               [ 1]  994 	clr	a
                                    995 ;	./libs/i2c_lib.c: 146: }
      00874C 81               [ 4]  996 	ret
                                    997 ;	./libs/i2c_lib.c: 148: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    998 ;	-----------------------------------------
                                    999 ;	 function i2c_write
                                   1000 ;	-----------------------------------------
      00874D                       1001 _i2c_write:
      00874D 52 02            [ 2] 1002 	sub	sp, #2
                                   1003 ;	./libs/i2c_lib.c: 150: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      00874F 4B 00            [ 1] 1004 	push	#0x00
      008751 CD 86 B4         [ 4] 1005 	call	_i2c_send_address
      008754 4D               [ 1] 1006 	tnz	a
      008755 27 1D            [ 1] 1007 	jreq	00105$
                                   1008 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      008757 5F               [ 1] 1009 	clrw	x
      008758                       1010 00107$:
      008758 7B 05            [ 1] 1011 	ld	a, (0x05, sp)
      00875A 6B 02            [ 1] 1012 	ld	(0x02, sp), a
      00875C 0F 01            [ 1] 1013 	clr	(0x01, sp)
      00875E 13 01            [ 2] 1014 	cpw	x, (0x01, sp)
      008760 2E 12            [ 1] 1015 	jrsge	00105$
                                   1016 ;	./libs/i2c_lib.c: 153: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008762 90 93            [ 1] 1017 	ldw	y, x
      008764 72 F9 06         [ 2] 1018 	addw	y, (0x06, sp)
      008767 90 F6            [ 1] 1019 	ld	a, (y)
      008769 89               [ 2] 1020 	pushw	x
      00876A CD 87 3B         [ 4] 1021 	call	_i2c_send_byte
      00876D 85               [ 2] 1022 	popw	x
      00876E 4D               [ 1] 1023 	tnz	a
      00876F 26 03            [ 1] 1024 	jrne	00105$
                                   1025 ;	./libs/i2c_lib.c: 151: for(int i = 0;i < size;i++)
      008771 5C               [ 1] 1026 	incw	x
      008772 20 E4            [ 2] 1027 	jra	00107$
      008774                       1028 00105$:
                                   1029 ;	./libs/i2c_lib.c: 158: i2c_stop();
      008774 1E 03            [ 2] 1030 	ldw	x, (3, sp)
      008776 1F 06            [ 2] 1031 	ldw	(6, sp), x
      008778 5B 05            [ 2] 1032 	addw	sp, #5
                                   1033 ;	./libs/i2c_lib.c: 159: }
      00877A CC 86 AF         [ 2] 1034 	jp	_i2c_stop
                                   1035 ;	./libs/i2c_lib.c: 161: uint8_t i2c_scan(void) 
                                   1036 ;	-----------------------------------------
                                   1037 ;	 function i2c_scan
                                   1038 ;	-----------------------------------------
      00877D                       1039 _i2c_scan:
      00877D 52 02            [ 2] 1040 	sub	sp, #2
                                   1041 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      00877F A6 01            [ 1] 1042 	ld	a, #0x01
      008781 6B 01            [ 1] 1043 	ld	(0x01, sp), a
      008783                       1044 00105$:
      008783 A1 7F            [ 1] 1045 	cp	a, #0x7f
      008785 24 22            [ 1] 1046 	jrnc	00103$
                                   1047 ;	./libs/i2c_lib.c: 165: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      008787 88               [ 1] 1048 	push	a
      008788 4B 00            [ 1] 1049 	push	#0x00
      00878A CD 86 B4         [ 4] 1050 	call	_i2c_send_address
      00878D 6B 03            [ 1] 1051 	ld	(0x03, sp), a
      00878F 84               [ 1] 1052 	pop	a
      008790 0D 02            [ 1] 1053 	tnz	(0x02, sp)
      008792 27 07            [ 1] 1054 	jreq	00102$
                                   1055 ;	./libs/i2c_lib.c: 167: i2c_stop();//адрес совпал 
      008794 CD 86 AF         [ 4] 1056 	call	_i2c_stop
                                   1057 ;	./libs/i2c_lib.c: 168: return addr;// выход из цикла
      008797 7B 01            [ 1] 1058 	ld	a, (0x01, sp)
      008799 20 12            [ 2] 1059 	jra	00107$
      00879B                       1060 00102$:
                                   1061 ;	./libs/i2c_lib.c: 170: I2C_SR2 -> AF = 0;//очистка флага ошибки
      00879B AE 52 18         [ 2] 1062 	ldw	x, #0x5218
      00879E 88               [ 1] 1063 	push	a
      00879F F6               [ 1] 1064 	ld	a, (x)
      0087A0 A4 FB            [ 1] 1065 	and	a, #0xfb
      0087A2 F7               [ 1] 1066 	ld	(x), a
      0087A3 84               [ 1] 1067 	pop	a
                                   1068 ;	./libs/i2c_lib.c: 163: for (uint8_t addr = 1; addr < 127; addr++)
      0087A4 4C               [ 1] 1069 	inc	a
      0087A5 6B 01            [ 1] 1070 	ld	(0x01, sp), a
      0087A7 20 DA            [ 2] 1071 	jra	00105$
      0087A9                       1072 00103$:
                                   1073 ;	./libs/i2c_lib.c: 172: i2c_stop();//совпадений нет выход из функции
      0087A9 CD 86 AF         [ 4] 1074 	call	_i2c_stop
                                   1075 ;	./libs/i2c_lib.c: 173: return 0;
      0087AC 4F               [ 1] 1076 	clr	a
      0087AD                       1077 00107$:
                                   1078 ;	./libs/i2c_lib.c: 174: }
      0087AD 5B 02            [ 2] 1079 	addw	sp, #2
      0087AF 81               [ 4] 1080 	ret
                                   1081 ;	./libs/i2c_lib.c: 176: void i2c_start_irq(void)
                                   1082 ;	-----------------------------------------
                                   1083 ;	 function i2c_start_irq
                                   1084 ;	-----------------------------------------
      0087B0                       1085 _i2c_start_irq:
                                   1086 ;	./libs/i2c_lib.c: 179: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      0087B0 72 12 52 1A      [ 1] 1087 	bset	0x521a, #1
                                   1088 ;	./libs/i2c_lib.c: 180: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0087B4 72 10 52 11      [ 1] 1089 	bset	0x5211, #0
                                   1090 ;	./libs/i2c_lib.c: 181: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      0087B8                       1091 00101$:
      0087B8 C6 52 1A         [ 1] 1092 	ld	a, 0x521a
      0087BB A5 02            [ 1] 1093 	bcp	a, #2
      0087BD 26 F9            [ 1] 1094 	jrne	00101$
                                   1095 ;	./libs/i2c_lib.c: 182: }
      0087BF 81               [ 4] 1096 	ret
                                   1097 ;	./libs/i2c_lib.c: 184: void i2c_stop_irq(void)
                                   1098 ;	-----------------------------------------
                                   1099 ;	 function i2c_stop_irq
                                   1100 ;	-----------------------------------------
      0087C0                       1101 _i2c_stop_irq:
                                   1102 ;	./libs/i2c_lib.c: 186: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0087C0 72 12 52 11      [ 1] 1103 	bset	0x5211, #1
                                   1104 ;	./libs/i2c_lib.c: 187: }
      0087C4 81               [ 4] 1105 	ret
                                   1106 ;	./libs/ssd1306_lib.c: 3: int get_bit(int data,int bit)
                                   1107 ;	-----------------------------------------
                                   1108 ;	 function get_bit
                                   1109 ;	-----------------------------------------
      0087C5                       1110 _get_bit:
                                   1111 ;	./libs/ssd1306_lib.c: 5: return ((data >> bit) & 1) ? 1 : 0;
      0087C5 7B 04            [ 1] 1112 	ld	a, (0x04, sp)
      0087C7 27 04            [ 1] 1113 	jreq	00113$
      0087C9                       1114 00112$:
      0087C9 57               [ 2] 1115 	sraw	x
      0087CA 4A               [ 1] 1116 	dec	a
      0087CB 26 FC            [ 1] 1117 	jrne	00112$
      0087CD                       1118 00113$:
      0087CD 54               [ 2] 1119 	srlw	x
      0087CE 24 03            [ 1] 1120 	jrnc	00103$
      0087D0 5F               [ 1] 1121 	clrw	x
      0087D1 5C               [ 1] 1122 	incw	x
      0087D2 21                    1123 	.byte 0x21
      0087D3                       1124 00103$:
      0087D3 5F               [ 1] 1125 	clrw	x
      0087D4                       1126 00104$:
                                   1127 ;	./libs/ssd1306_lib.c: 6: }
      0087D4 90 85            [ 2] 1128 	popw	y
      0087D6 5B 02            [ 2] 1129 	addw	sp, #2
      0087D8 90 FC            [ 2] 1130 	jp	(y)
                                   1131 ;	./libs/ssd1306_lib.c: 7: int set_bit(int data,int bit, int value)
                                   1132 ;	-----------------------------------------
                                   1133 ;	 function set_bit
                                   1134 ;	-----------------------------------------
      0087DA                       1135 _set_bit:
      0087DA 52 04            [ 2] 1136 	sub	sp, #4
      0087DC 1F 01            [ 2] 1137 	ldw	(0x01, sp), x
                                   1138 ;	./libs/ssd1306_lib.c: 9: int mask = 1 << bit ;
      0087DE 5F               [ 1] 1139 	clrw	x
      0087DF 5C               [ 1] 1140 	incw	x
      0087E0 1F 03            [ 2] 1141 	ldw	(0x03, sp), x
      0087E2 7B 08            [ 1] 1142 	ld	a, (0x08, sp)
      0087E4 27 07            [ 1] 1143 	jreq	00114$
      0087E6                       1144 00113$:
      0087E6 08 04            [ 1] 1145 	sll	(0x04, sp)
      0087E8 09 03            [ 1] 1146 	rlc	(0x03, sp)
      0087EA 4A               [ 1] 1147 	dec	a
      0087EB 26 F9            [ 1] 1148 	jrne	00113$
      0087ED                       1149 00114$:
                                   1150 ;	./libs/ssd1306_lib.c: 10: switch(value)
      0087ED 1E 09            [ 2] 1151 	ldw	x, (0x09, sp)
      0087EF 5A               [ 2] 1152 	decw	x
      0087F0 26 0B            [ 1] 1153 	jrne	00102$
                                   1154 ;	./libs/ssd1306_lib.c: 13: data |= mask;
      0087F2 7B 02            [ 1] 1155 	ld	a, (0x02, sp)
      0087F4 1A 04            [ 1] 1156 	or	a, (0x04, sp)
      0087F6 97               [ 1] 1157 	ld	xl, a
      0087F7 7B 01            [ 1] 1158 	ld	a, (0x01, sp)
      0087F9 1A 03            [ 1] 1159 	or	a, (0x03, sp)
                                   1160 ;	./libs/ssd1306_lib.c: 14: break;
      0087FB 20 09            [ 2] 1161 	jra	00103$
                                   1162 ;	./libs/ssd1306_lib.c: 16: default:
      0087FD                       1163 00102$:
                                   1164 ;	./libs/ssd1306_lib.c: 17: data &= ~mask;
      0087FD 1E 03            [ 2] 1165 	ldw	x, (0x03, sp)
      0087FF 53               [ 2] 1166 	cplw	x
      008800 9F               [ 1] 1167 	ld	a, xl
      008801 14 02            [ 1] 1168 	and	a, (0x02, sp)
      008803 02               [ 1] 1169 	rlwa	x
      008804 14 01            [ 1] 1170 	and	a, (0x01, sp)
                                   1171 ;	./libs/ssd1306_lib.c: 19: }
      008806                       1172 00103$:
                                   1173 ;	./libs/ssd1306_lib.c: 20: return data;
      008806 95               [ 1] 1174 	ld	xh, a
                                   1175 ;	./libs/ssd1306_lib.c: 21: }
      008807 16 05            [ 2] 1176 	ldw	y, (5, sp)
      008809 5B 0A            [ 2] 1177 	addw	sp, #10
      00880B 90 FC            [ 2] 1178 	jp	(y)
                                   1179 ;	./libs/ssd1306_lib.c: 23: void ssd1306_init(void)
                                   1180 ;	-----------------------------------------
                                   1181 ;	 function ssd1306_init
                                   1182 ;	-----------------------------------------
      00880D                       1183 _ssd1306_init:
      00880D 52 1B            [ 2] 1184 	sub	sp, #27
                                   1185 ;	./libs/ssd1306_lib.c: 25: uint8_t setup_buffer[27] = {COMMAND, DISPLAY_OFF, 
      00880F 96               [ 1] 1186 	ldw	x, sp
      008810 5C               [ 1] 1187 	incw	x
      008811 7F               [ 1] 1188 	clr	(x)
      008812 A6 AE            [ 1] 1189 	ld	a, #0xae
      008814 6B 02            [ 1] 1190 	ld	(0x02, sp), a
      008816 A6 D5            [ 1] 1191 	ld	a, #0xd5
      008818 6B 03            [ 1] 1192 	ld	(0x03, sp), a
      00881A A6 80            [ 1] 1193 	ld	a, #0x80
      00881C 6B 04            [ 1] 1194 	ld	(0x04, sp), a
      00881E A6 A8            [ 1] 1195 	ld	a, #0xa8
      008820 6B 05            [ 1] 1196 	ld	(0x05, sp), a
      008822 A6 1F            [ 1] 1197 	ld	a, #0x1f
      008824 6B 06            [ 1] 1198 	ld	(0x06, sp), a
      008826 A6 D3            [ 1] 1199 	ld	a, #0xd3
      008828 6B 07            [ 1] 1200 	ld	(0x07, sp), a
      00882A 0F 08            [ 1] 1201 	clr	(0x08, sp)
      00882C A6 40            [ 1] 1202 	ld	a, #0x40
      00882E 6B 09            [ 1] 1203 	ld	(0x09, sp), a
      008830 A6 8D            [ 1] 1204 	ld	a, #0x8d
      008832 6B 0A            [ 1] 1205 	ld	(0x0a, sp), a
      008834 A6 14            [ 1] 1206 	ld	a, #0x14
      008836 6B 0B            [ 1] 1207 	ld	(0x0b, sp), a
      008838 A6 DB            [ 1] 1208 	ld	a, #0xdb
      00883A 6B 0C            [ 1] 1209 	ld	(0x0c, sp), a
      00883C A6 40            [ 1] 1210 	ld	a, #0x40
      00883E 6B 0D            [ 1] 1211 	ld	(0x0d, sp), a
      008840 A6 A4            [ 1] 1212 	ld	a, #0xa4
      008842 6B 0E            [ 1] 1213 	ld	(0x0e, sp), a
      008844 A6 A6            [ 1] 1214 	ld	a, #0xa6
      008846 6B 0F            [ 1] 1215 	ld	(0x0f, sp), a
      008848 A6 DA            [ 1] 1216 	ld	a, #0xda
      00884A 6B 10            [ 1] 1217 	ld	(0x10, sp), a
      00884C A6 02            [ 1] 1218 	ld	a, #0x02
      00884E 6B 11            [ 1] 1219 	ld	(0x11, sp), a
      008850 A6 81            [ 1] 1220 	ld	a, #0x81
      008852 6B 12            [ 1] 1221 	ld	(0x12, sp), a
      008854 A6 8F            [ 1] 1222 	ld	a, #0x8f
      008856 6B 13            [ 1] 1223 	ld	(0x13, sp), a
      008858 A6 D9            [ 1] 1224 	ld	a, #0xd9
      00885A 6B 14            [ 1] 1225 	ld	(0x14, sp), a
      00885C A6 F1            [ 1] 1226 	ld	a, #0xf1
      00885E 6B 15            [ 1] 1227 	ld	(0x15, sp), a
      008860 A6 20            [ 1] 1228 	ld	a, #0x20
      008862 6B 16            [ 1] 1229 	ld	(0x16, sp), a
      008864 0F 17            [ 1] 1230 	clr	(0x17, sp)
      008866 A6 A0            [ 1] 1231 	ld	a, #0xa0
      008868 6B 18            [ 1] 1232 	ld	(0x18, sp), a
      00886A A6 C0            [ 1] 1233 	ld	a, #0xc0
      00886C 6B 19            [ 1] 1234 	ld	(0x19, sp), a
      00886E A6 1F            [ 1] 1235 	ld	a, #0x1f
      008870 6B 1A            [ 1] 1236 	ld	(0x1a, sp), a
      008872 A6 AF            [ 1] 1237 	ld	a, #0xaf
      008874 6B 1B            [ 1] 1238 	ld	(0x1b, sp), a
                                   1239 ;	./libs/ssd1306_lib.c: 41: i2c_write(I2C_DISPLAY_ADDR, 27, setup_buffer);
      008876 89               [ 2] 1240 	pushw	x
      008877 4B 1B            [ 1] 1241 	push	#0x1b
      008879 A6 3C            [ 1] 1242 	ld	a, #0x3c
      00887B CD 87 4D         [ 4] 1243 	call	_i2c_write
                                   1244 ;	./libs/ssd1306_lib.c: 43: }
      00887E 5B 1B            [ 2] 1245 	addw	sp, #27
      008880 81               [ 4] 1246 	ret
                                   1247 ;	./libs/ssd1306_lib.c: 45: void ssd1306_set_params_to_write(void)
                                   1248 ;	-----------------------------------------
                                   1249 ;	 function ssd1306_set_params_to_write
                                   1250 ;	-----------------------------------------
      008881                       1251 _ssd1306_set_params_to_write:
      008881 52 07            [ 2] 1252 	sub	sp, #7
                                   1253 ;	./libs/ssd1306_lib.c: 47: uint8_t set_params_buf[7] = {COMMAND,
      008883 96               [ 1] 1254 	ldw	x, sp
      008884 5C               [ 1] 1255 	incw	x
      008885 7F               [ 1] 1256 	clr	(x)
      008886 A6 22            [ 1] 1257 	ld	a, #0x22
      008888 6B 02            [ 1] 1258 	ld	(0x02, sp), a
      00888A 0F 03            [ 1] 1259 	clr	(0x03, sp)
      00888C A6 03            [ 1] 1260 	ld	a, #0x03
      00888E 6B 04            [ 1] 1261 	ld	(0x04, sp), a
      008890 A6 21            [ 1] 1262 	ld	a, #0x21
      008892 6B 05            [ 1] 1263 	ld	(0x05, sp), a
      008894 0F 06            [ 1] 1264 	clr	(0x06, sp)
      008896 A6 7F            [ 1] 1265 	ld	a, #0x7f
      008898 6B 07            [ 1] 1266 	ld	(0x07, sp), a
                                   1267 ;	./libs/ssd1306_lib.c: 51: i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
      00889A 89               [ 2] 1268 	pushw	x
      00889B 4B 07            [ 1] 1269 	push	#0x07
      00889D A6 3C            [ 1] 1270 	ld	a, #0x3c
      00889F CD 87 4D         [ 4] 1271 	call	_i2c_write
                                   1272 ;	./libs/ssd1306_lib.c: 52: }
      0088A2 5B 07            [ 2] 1273 	addw	sp, #7
      0088A4 81               [ 4] 1274 	ret
                                   1275 ;	./libs/ssd1306_lib.c: 54: void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
                                   1276 ;	-----------------------------------------
                                   1277 ;	 function ssd1306_draw_pixel
                                   1278 ;	-----------------------------------------
      0088A5                       1279 _ssd1306_draw_pixel:
      0088A5 52 08            [ 2] 1280 	sub	sp, #8
      0088A7 1F 07            [ 2] 1281 	ldw	(0x07, sp), x
                                   1282 ;	./libs/ssd1306_lib.c: 56: buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
      0088A9 6B 06            [ 1] 1283 	ld	(0x06, sp), a
      0088AB 0F 05            [ 1] 1284 	clr	(0x05, sp)
      0088AD 7B 0B            [ 1] 1285 	ld	a, (0x0b, sp)
      0088AF 0F 01            [ 1] 1286 	clr	(0x01, sp)
      0088B1 97               [ 1] 1287 	ld	xl, a
      0088B2 02               [ 1] 1288 	rlwa	x
      0088B3 4F               [ 1] 1289 	clr	a
      0088B4 01               [ 1] 1290 	rrwa	x
      0088B5 5D               [ 2] 1291 	tnzw	x
      0088B6 2A 03            [ 1] 1292 	jrpl	00103$
      0088B8 1C 00 07         [ 2] 1293 	addw	x, #0x0007
      0088BB                       1294 00103$:
      0088BB 57               [ 2] 1295 	sraw	x
      0088BC 57               [ 2] 1296 	sraw	x
      0088BD 57               [ 2] 1297 	sraw	x
      0088BE 58               [ 2] 1298 	sllw	x
      0088BF 58               [ 2] 1299 	sllw	x
      0088C0 58               [ 2] 1300 	sllw	x
      0088C1 58               [ 2] 1301 	sllw	x
      0088C2 58               [ 2] 1302 	sllw	x
      0088C3 58               [ 2] 1303 	sllw	x
      0088C4 58               [ 2] 1304 	sllw	x
      0088C5 72 FB 05         [ 2] 1305 	addw	x, (0x05, sp)
      0088C8 72 FB 07         [ 2] 1306 	addw	x, (0x07, sp)
      0088CB 1F 03            [ 2] 1307 	ldw	(0x03, sp), x
      0088CD 90 5F            [ 1] 1308 	clrw	y
      0088CF 61               [ 1] 1309 	exg	a, yl
      0088D0 7B 0C            [ 1] 1310 	ld	a, (0x0c, sp)
      0088D2 61               [ 1] 1311 	exg	a, yl
      0088D3 A4 07            [ 1] 1312 	and	a, #0x07
      0088D5 6B 06            [ 1] 1313 	ld	(0x06, sp), a
      0088D7 0F 05            [ 1] 1314 	clr	(0x05, sp)
      0088D9 1E 03            [ 2] 1315 	ldw	x, (0x03, sp)
      0088DB F6               [ 1] 1316 	ld	a, (x)
      0088DC 5F               [ 1] 1317 	clrw	x
      0088DD 90 89            [ 2] 1318 	pushw	y
      0088DF 16 07            [ 2] 1319 	ldw	y, (0x07, sp)
      0088E1 90 89            [ 2] 1320 	pushw	y
      0088E3 97               [ 1] 1321 	ld	xl, a
      0088E4 CD 87 DA         [ 4] 1322 	call	_set_bit
      0088E7 9F               [ 1] 1323 	ld	a, xl
      0088E8 1E 03            [ 2] 1324 	ldw	x, (0x03, sp)
      0088EA F7               [ 1] 1325 	ld	(x), a
                                   1326 ;	./libs/ssd1306_lib.c: 57: }
      0088EB 1E 09            [ 2] 1327 	ldw	x, (9, sp)
      0088ED 5B 0C            [ 2] 1328 	addw	sp, #12
      0088EF FC               [ 2] 1329 	jp	(x)
                                   1330 ;	./libs/ssd1306_lib.c: 59: void ssd1306_buffer_clean(void)
                                   1331 ;	-----------------------------------------
                                   1332 ;	 function ssd1306_buffer_clean
                                   1333 ;	-----------------------------------------
      0088F0                       1334 _ssd1306_buffer_clean:
                                   1335 ;	./libs/ssd1306_lib.c: 61: memset(main_buffer,0,512);
      0088F0 4B 00            [ 1] 1336 	push	#0x00
      0088F2 4B 02            [ 1] 1337 	push	#0x02
      0088F4 5F               [ 1] 1338 	clrw	x
      0088F5 89               [ 2] 1339 	pushw	x
      0088F6 AE 01 28         [ 2] 1340 	ldw	x, #(_main_buffer+0)
      0088F9 CD 8B B2         [ 4] 1341 	call	_memset
                                   1342 ;	./libs/ssd1306_lib.c: 62: }
      0088FC 81               [ 4] 1343 	ret
                                   1344 ;	./libs/ssd1306_lib.c: 63: void ssd1306_send_buffer(void)
                                   1345 ;	-----------------------------------------
                                   1346 ;	 function ssd1306_send_buffer
                                   1347 ;	-----------------------------------------
      0088FD                       1348 _ssd1306_send_buffer:
      0088FD 52 02            [ 2] 1349 	sub	sp, #2
                                   1350 ;	./libs/ssd1306_lib.c: 65: ssd1306_set_params_to_write();
      0088FF CD 88 81         [ 4] 1351 	call	_ssd1306_set_params_to_write
                                   1352 ;	./libs/ssd1306_lib.c: 66: for(int j = 1;j<5;j++)
      008902 5F               [ 1] 1353 	clrw	x
      008903 5C               [ 1] 1354 	incw	x
      008904 1F 01            [ 2] 1355 	ldw	(0x01, sp), x
      008906                       1356 00112$:
      008906 1E 01            [ 2] 1357 	ldw	x, (0x01, sp)
      008908 A3 00 05         [ 2] 1358 	cpw	x, #0x0005
      00890B 2E 3D            [ 1] 1359 	jrsge	00114$
                                   1360 ;	./libs/ssd1306_lib.c: 68: if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
      00890D 4B 00            [ 1] 1361 	push	#0x00
      00890F A6 3C            [ 1] 1362 	ld	a, #0x3c
      008911 CD 86 B4         [ 4] 1363 	call	_i2c_send_address
      008914 4D               [ 1] 1364 	tnz	a
      008915 27 29            [ 1] 1365 	jreq	00105$
                                   1366 ;	./libs/ssd1306_lib.c: 70: i2c_send_byte(SET_DISPLAY_START_LINE);
      008917 A6 40            [ 1] 1367 	ld	a, #0x40
      008919 CD 87 3B         [ 4] 1368 	call	_i2c_send_byte
                                   1369 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      00891C 5F               [ 1] 1370 	clrw	x
      00891D                       1371 00109$:
      00891D A3 00 80         [ 2] 1372 	cpw	x, #0x0080
      008920 2E 19            [ 1] 1373 	jrsge	00103$
                                   1374 ;	./libs/ssd1306_lib.c: 73: if(i2c_send_byte(main_buffer[i*j]))//Проверка на АСК бит
      008922 89               [ 2] 1375 	pushw	x
      008923 16 03            [ 2] 1376 	ldw	y, (0x03, sp)
      008925 90 89            [ 2] 1377 	pushw	y
      008927 CD 8B 95         [ 4] 1378 	call	__mulint
      00892A 51               [ 1] 1379 	exgw	x, y
      00892B 85               [ 2] 1380 	popw	x
      00892C 90 D6 01 28      [ 1] 1381 	ld	a, (_main_buffer+0, y)
      008930 89               [ 2] 1382 	pushw	x
      008931 CD 87 3B         [ 4] 1383 	call	_i2c_send_byte
      008934 85               [ 2] 1384 	popw	x
      008935 4D               [ 1] 1385 	tnz	a
      008936 26 03            [ 1] 1386 	jrne	00103$
                                   1387 ;	./libs/ssd1306_lib.c: 71: for(int i = 0;i < 128;i++)
      008938 5C               [ 1] 1388 	incw	x
      008939 20 E2            [ 2] 1389 	jra	00109$
      00893B                       1390 00103$:
                                   1391 ;	./libs/ssd1306_lib.c: 78: i2c_stop();
      00893B CD 86 AF         [ 4] 1392 	call	_i2c_stop
      00893E 20 03            [ 2] 1393 	jra	00113$
      008940                       1394 00105$:
                                   1395 ;	./libs/ssd1306_lib.c: 81: i2c_stop();
      008940 CD 86 AF         [ 4] 1396 	call	_i2c_stop
      008943                       1397 00113$:
                                   1398 ;	./libs/ssd1306_lib.c: 66: for(int j = 1;j<5;j++)
      008943 1E 01            [ 2] 1399 	ldw	x, (0x01, sp)
      008945 5C               [ 1] 1400 	incw	x
      008946 1F 01            [ 2] 1401 	ldw	(0x01, sp), x
      008948 20 BC            [ 2] 1402 	jra	00112$
      00894A                       1403 00114$:
                                   1404 ;	./libs/ssd1306_lib.c: 83: }
      00894A 5B 02            [ 2] 1405 	addw	sp, #2
      00894C 81               [ 4] 1406 	ret
                                   1407 ;	./libs/ssd1306_lib.c: 84: void ssd1306_buffer_splash(void)
                                   1408 ;	-----------------------------------------
                                   1409 ;	 function ssd1306_buffer_splash
                                   1410 ;	-----------------------------------------
      00894D                       1411 _ssd1306_buffer_splash:
      00894D 52 8B            [ 2] 1412 	sub	sp, #139
                                   1413 ;	./libs/ssd1306_lib.c: 87: ssd1306_set_params_to_write();
      00894F CD 88 81         [ 4] 1414 	call	_ssd1306_set_params_to_write
                                   1415 ;	./libs/ssd1306_lib.c: 88: uint8_t part[129]={SET_DISPLAY_START_LINE};
      008952 A6 40            [ 1] 1416 	ld	a, #0x40
      008954 6B 01            [ 1] 1417 	ld	(0x01, sp), a
      008956 0F 02            [ 1] 1418 	clr	(0x02, sp)
      008958 0F 03            [ 1] 1419 	clr	(0x03, sp)
      00895A 0F 04            [ 1] 1420 	clr	(0x04, sp)
      00895C 0F 05            [ 1] 1421 	clr	(0x05, sp)
      00895E 0F 06            [ 1] 1422 	clr	(0x06, sp)
      008960 0F 07            [ 1] 1423 	clr	(0x07, sp)
      008962 0F 08            [ 1] 1424 	clr	(0x08, sp)
      008964 0F 09            [ 1] 1425 	clr	(0x09, sp)
      008966 0F 0A            [ 1] 1426 	clr	(0x0a, sp)
      008968 0F 0B            [ 1] 1427 	clr	(0x0b, sp)
      00896A 0F 0C            [ 1] 1428 	clr	(0x0c, sp)
      00896C 0F 0D            [ 1] 1429 	clr	(0x0d, sp)
      00896E 0F 0E            [ 1] 1430 	clr	(0x0e, sp)
      008970 0F 0F            [ 1] 1431 	clr	(0x0f, sp)
      008972 0F 10            [ 1] 1432 	clr	(0x10, sp)
      008974 0F 11            [ 1] 1433 	clr	(0x11, sp)
      008976 0F 12            [ 1] 1434 	clr	(0x12, sp)
      008978 0F 13            [ 1] 1435 	clr	(0x13, sp)
      00897A 0F 14            [ 1] 1436 	clr	(0x14, sp)
      00897C 0F 15            [ 1] 1437 	clr	(0x15, sp)
      00897E 0F 16            [ 1] 1438 	clr	(0x16, sp)
      008980 0F 17            [ 1] 1439 	clr	(0x17, sp)
      008982 0F 18            [ 1] 1440 	clr	(0x18, sp)
      008984 0F 19            [ 1] 1441 	clr	(0x19, sp)
      008986 0F 1A            [ 1] 1442 	clr	(0x1a, sp)
      008988 0F 1B            [ 1] 1443 	clr	(0x1b, sp)
      00898A 0F 1C            [ 1] 1444 	clr	(0x1c, sp)
      00898C 0F 1D            [ 1] 1445 	clr	(0x1d, sp)
      00898E 0F 1E            [ 1] 1446 	clr	(0x1e, sp)
      008990 0F 1F            [ 1] 1447 	clr	(0x1f, sp)
      008992 0F 20            [ 1] 1448 	clr	(0x20, sp)
      008994 0F 21            [ 1] 1449 	clr	(0x21, sp)
      008996 0F 22            [ 1] 1450 	clr	(0x22, sp)
      008998 0F 23            [ 1] 1451 	clr	(0x23, sp)
      00899A 0F 24            [ 1] 1452 	clr	(0x24, sp)
      00899C 0F 25            [ 1] 1453 	clr	(0x25, sp)
      00899E 0F 26            [ 1] 1454 	clr	(0x26, sp)
      0089A0 0F 27            [ 1] 1455 	clr	(0x27, sp)
      0089A2 0F 28            [ 1] 1456 	clr	(0x28, sp)
      0089A4 0F 29            [ 1] 1457 	clr	(0x29, sp)
      0089A6 0F 2A            [ 1] 1458 	clr	(0x2a, sp)
      0089A8 0F 2B            [ 1] 1459 	clr	(0x2b, sp)
      0089AA 0F 2C            [ 1] 1460 	clr	(0x2c, sp)
      0089AC 0F 2D            [ 1] 1461 	clr	(0x2d, sp)
      0089AE 0F 2E            [ 1] 1462 	clr	(0x2e, sp)
      0089B0 0F 2F            [ 1] 1463 	clr	(0x2f, sp)
      0089B2 0F 30            [ 1] 1464 	clr	(0x30, sp)
      0089B4 0F 31            [ 1] 1465 	clr	(0x31, sp)
      0089B6 0F 32            [ 1] 1466 	clr	(0x32, sp)
      0089B8 0F 33            [ 1] 1467 	clr	(0x33, sp)
      0089BA 0F 34            [ 1] 1468 	clr	(0x34, sp)
      0089BC 0F 35            [ 1] 1469 	clr	(0x35, sp)
      0089BE 0F 36            [ 1] 1470 	clr	(0x36, sp)
      0089C0 0F 37            [ 1] 1471 	clr	(0x37, sp)
      0089C2 0F 38            [ 1] 1472 	clr	(0x38, sp)
      0089C4 0F 39            [ 1] 1473 	clr	(0x39, sp)
      0089C6 0F 3A            [ 1] 1474 	clr	(0x3a, sp)
      0089C8 0F 3B            [ 1] 1475 	clr	(0x3b, sp)
      0089CA 0F 3C            [ 1] 1476 	clr	(0x3c, sp)
      0089CC 0F 3D            [ 1] 1477 	clr	(0x3d, sp)
      0089CE 0F 3E            [ 1] 1478 	clr	(0x3e, sp)
      0089D0 0F 3F            [ 1] 1479 	clr	(0x3f, sp)
      0089D2 0F 40            [ 1] 1480 	clr	(0x40, sp)
      0089D4 0F 41            [ 1] 1481 	clr	(0x41, sp)
      0089D6 0F 42            [ 1] 1482 	clr	(0x42, sp)
      0089D8 0F 43            [ 1] 1483 	clr	(0x43, sp)
      0089DA 0F 44            [ 1] 1484 	clr	(0x44, sp)
      0089DC 0F 45            [ 1] 1485 	clr	(0x45, sp)
      0089DE 0F 46            [ 1] 1486 	clr	(0x46, sp)
      0089E0 0F 47            [ 1] 1487 	clr	(0x47, sp)
      0089E2 0F 48            [ 1] 1488 	clr	(0x48, sp)
      0089E4 0F 49            [ 1] 1489 	clr	(0x49, sp)
      0089E6 0F 4A            [ 1] 1490 	clr	(0x4a, sp)
      0089E8 0F 4B            [ 1] 1491 	clr	(0x4b, sp)
      0089EA 0F 4C            [ 1] 1492 	clr	(0x4c, sp)
      0089EC 0F 4D            [ 1] 1493 	clr	(0x4d, sp)
      0089EE 0F 4E            [ 1] 1494 	clr	(0x4e, sp)
      0089F0 0F 4F            [ 1] 1495 	clr	(0x4f, sp)
      0089F2 0F 50            [ 1] 1496 	clr	(0x50, sp)
      0089F4 0F 51            [ 1] 1497 	clr	(0x51, sp)
      0089F6 0F 52            [ 1] 1498 	clr	(0x52, sp)
      0089F8 0F 53            [ 1] 1499 	clr	(0x53, sp)
      0089FA 0F 54            [ 1] 1500 	clr	(0x54, sp)
      0089FC 0F 55            [ 1] 1501 	clr	(0x55, sp)
      0089FE 0F 56            [ 1] 1502 	clr	(0x56, sp)
      008A00 0F 57            [ 1] 1503 	clr	(0x57, sp)
      008A02 0F 58            [ 1] 1504 	clr	(0x58, sp)
      008A04 0F 59            [ 1] 1505 	clr	(0x59, sp)
      008A06 0F 5A            [ 1] 1506 	clr	(0x5a, sp)
      008A08 0F 5B            [ 1] 1507 	clr	(0x5b, sp)
      008A0A 0F 5C            [ 1] 1508 	clr	(0x5c, sp)
      008A0C 0F 5D            [ 1] 1509 	clr	(0x5d, sp)
      008A0E 0F 5E            [ 1] 1510 	clr	(0x5e, sp)
      008A10 0F 5F            [ 1] 1511 	clr	(0x5f, sp)
      008A12 0F 60            [ 1] 1512 	clr	(0x60, sp)
      008A14 0F 61            [ 1] 1513 	clr	(0x61, sp)
      008A16 0F 62            [ 1] 1514 	clr	(0x62, sp)
      008A18 0F 63            [ 1] 1515 	clr	(0x63, sp)
      008A1A 0F 64            [ 1] 1516 	clr	(0x64, sp)
      008A1C 0F 65            [ 1] 1517 	clr	(0x65, sp)
      008A1E 0F 66            [ 1] 1518 	clr	(0x66, sp)
      008A20 0F 67            [ 1] 1519 	clr	(0x67, sp)
      008A22 0F 68            [ 1] 1520 	clr	(0x68, sp)
      008A24 0F 69            [ 1] 1521 	clr	(0x69, sp)
      008A26 0F 6A            [ 1] 1522 	clr	(0x6a, sp)
      008A28 0F 6B            [ 1] 1523 	clr	(0x6b, sp)
      008A2A 0F 6C            [ 1] 1524 	clr	(0x6c, sp)
      008A2C 0F 6D            [ 1] 1525 	clr	(0x6d, sp)
      008A2E 0F 6E            [ 1] 1526 	clr	(0x6e, sp)
      008A30 0F 6F            [ 1] 1527 	clr	(0x6f, sp)
      008A32 0F 70            [ 1] 1528 	clr	(0x70, sp)
      008A34 0F 71            [ 1] 1529 	clr	(0x71, sp)
      008A36 0F 72            [ 1] 1530 	clr	(0x72, sp)
      008A38 0F 73            [ 1] 1531 	clr	(0x73, sp)
      008A3A 0F 74            [ 1] 1532 	clr	(0x74, sp)
      008A3C 0F 75            [ 1] 1533 	clr	(0x75, sp)
      008A3E 0F 76            [ 1] 1534 	clr	(0x76, sp)
      008A40 0F 77            [ 1] 1535 	clr	(0x77, sp)
      008A42 0F 78            [ 1] 1536 	clr	(0x78, sp)
      008A44 0F 79            [ 1] 1537 	clr	(0x79, sp)
      008A46 0F 7A            [ 1] 1538 	clr	(0x7a, sp)
      008A48 0F 7B            [ 1] 1539 	clr	(0x7b, sp)
      008A4A 0F 7C            [ 1] 1540 	clr	(0x7c, sp)
      008A4C 0F 7D            [ 1] 1541 	clr	(0x7d, sp)
      008A4E 0F 7E            [ 1] 1542 	clr	(0x7e, sp)
      008A50 0F 7F            [ 1] 1543 	clr	(0x7f, sp)
      008A52 0F 80            [ 1] 1544 	clr	(0x80, sp)
      008A54 0F 81            [ 1] 1545 	clr	(0x81, sp)
                                   1546 ;	./libs/ssd1306_lib.c: 90: for(int page = 0;page <= 384;page+=128)
      008A56 5F               [ 1] 1547 	clrw	x
      008A57 1F 86            [ 2] 1548 	ldw	(0x86, sp), x
      008A59                       1549 00111$:
      008A59 1E 86            [ 2] 1550 	ldw	x, (0x86, sp)
      008A5B A3 01 80         [ 2] 1551 	cpw	x, #0x0180
      008A5E 2C 7C            [ 1] 1552 	jrsgt	00113$
                                   1553 ;	./libs/ssd1306_lib.c: 92: for (int height = 0; height < 8; height++) 
      008A60 5F               [ 1] 1554 	clrw	x
      008A61 1F 88            [ 2] 1555 	ldw	(0x88, sp), x
      008A63                       1556 00108$:
      008A63 1E 88            [ 2] 1557 	ldw	x, (0x88, sp)
      008A65 A3 00 08         [ 2] 1558 	cpw	x, #0x0008
      008A68 2E 5E            [ 1] 1559 	jrsge	00102$
                                   1560 ;	./libs/ssd1306_lib.c: 94: for (int width = 0; width < 128; width++) 
      008A6A 1E 88            [ 2] 1561 	ldw	x, (0x88, sp)
      008A6C 58               [ 2] 1562 	sllw	x
      008A6D 58               [ 2] 1563 	sllw	x
      008A6E 58               [ 2] 1564 	sllw	x
      008A6F 58               [ 2] 1565 	sllw	x
      008A70 72 FB 86         [ 2] 1566 	addw	x, (0x86, sp)
      008A73 1F 82            [ 2] 1567 	ldw	(0x82, sp), x
      008A75 5F               [ 1] 1568 	clrw	x
      008A76 1F 8A            [ 2] 1569 	ldw	(0x8a, sp), x
      008A78                       1570 00105$:
      008A78 1E 8A            [ 2] 1571 	ldw	x, (0x8a, sp)
      008A7A A3 00 80         [ 2] 1572 	cpw	x, #0x0080
      008A7D 2E 42            [ 1] 1573 	jrsge	00109$
                                   1574 ;	./libs/ssd1306_lib.c: 96: ssd1306_draw_pixel(&part[1], width, height, get_bit(main_buffer[page+(height*16) + (width / 8)], 7 - (width % 8)));
      008A7F 4B 08            [ 1] 1575 	push	#0x08
      008A81 4B 00            [ 1] 1576 	push	#0x00
      008A83 1E 8C            [ 2] 1577 	ldw	x, (0x8c, sp)
      008A85 CD 8B D6         [ 4] 1578 	call	__modsint
      008A88 1F 84            [ 2] 1579 	ldw	(0x84, sp), x
      008A8A 90 AE 00 07      [ 2] 1580 	ldw	y, #0x0007
      008A8E 72 F2 84         [ 2] 1581 	subw	y, (0x84, sp)
      008A91 1E 8A            [ 2] 1582 	ldw	x, (0x8a, sp)
      008A93 2A 03            [ 1] 1583 	jrpl	00163$
      008A95 1C 00 07         [ 2] 1584 	addw	x, #0x0007
      008A98                       1585 00163$:
      008A98 57               [ 2] 1586 	sraw	x
      008A99 57               [ 2] 1587 	sraw	x
      008A9A 57               [ 2] 1588 	sraw	x
      008A9B 72 FB 82         [ 2] 1589 	addw	x, (0x82, sp)
      008A9E D6 01 28         [ 1] 1590 	ld	a, (_main_buffer+0, x)
      008AA1 5F               [ 1] 1591 	clrw	x
      008AA2 90 89            [ 2] 1592 	pushw	y
      008AA4 97               [ 1] 1593 	ld	xl, a
      008AA5 CD 87 C5         [ 4] 1594 	call	_get_bit
      008AA8 7B 89            [ 1] 1595 	ld	a, (0x89, sp)
      008AAA 02               [ 1] 1596 	rlwa	x
      008AAB 7B 8B            [ 1] 1597 	ld	a, (0x8b, sp)
      008AAD 01               [ 1] 1598 	rrwa	x
      008AAE 89               [ 2] 1599 	pushw	x
      008AAF 5B 01            [ 2] 1600 	addw	sp, #1
      008AB1 88               [ 1] 1601 	push	a
      008AB2 9E               [ 1] 1602 	ld	a, xh
      008AB3 96               [ 1] 1603 	ldw	x, sp
      008AB4 1C 00 04         [ 2] 1604 	addw	x, #4
      008AB7 CD 88 A5         [ 4] 1605 	call	_ssd1306_draw_pixel
                                   1606 ;	./libs/ssd1306_lib.c: 94: for (int width = 0; width < 128; width++) 
      008ABA 1E 8A            [ 2] 1607 	ldw	x, (0x8a, sp)
      008ABC 5C               [ 1] 1608 	incw	x
      008ABD 1F 8A            [ 2] 1609 	ldw	(0x8a, sp), x
      008ABF 20 B7            [ 2] 1610 	jra	00105$
      008AC1                       1611 00109$:
                                   1612 ;	./libs/ssd1306_lib.c: 92: for (int height = 0; height < 8; height++) 
      008AC1 1E 88            [ 2] 1613 	ldw	x, (0x88, sp)
      008AC3 5C               [ 1] 1614 	incw	x
      008AC4 1F 88            [ 2] 1615 	ldw	(0x88, sp), x
      008AC6 20 9B            [ 2] 1616 	jra	00108$
      008AC8                       1617 00102$:
                                   1618 ;	./libs/ssd1306_lib.c: 99: i2c_write(I2C_DISPLAY_ADDR, 129, part);
      008AC8 96               [ 1] 1619 	ldw	x, sp
      008AC9 5C               [ 1] 1620 	incw	x
      008ACA 89               [ 2] 1621 	pushw	x
      008ACB 4B 81            [ 1] 1622 	push	#0x81
      008ACD A6 3C            [ 1] 1623 	ld	a, #0x3c
      008ACF CD 87 4D         [ 4] 1624 	call	_i2c_write
                                   1625 ;	./libs/ssd1306_lib.c: 90: for(int page = 0;page <= 384;page+=128)
      008AD2 1E 86            [ 2] 1626 	ldw	x, (0x86, sp)
      008AD4 1C 00 80         [ 2] 1627 	addw	x, #0x0080
      008AD7 1F 86            [ 2] 1628 	ldw	(0x86, sp), x
      008AD9 CC 8A 59         [ 2] 1629 	jp	00111$
      008ADC                       1630 00113$:
                                   1631 ;	./libs/ssd1306_lib.c: 101: }
      008ADC 5B 8B            [ 2] 1632 	addw	sp, #139
      008ADE 81               [ 4] 1633 	ret
                                   1634 ;	./libs/ssd1306_lib.c: 103: void ssd1306_buffer_write(int x, int y, const uint8_t *data)
                                   1635 ;	-----------------------------------------
                                   1636 ;	 function ssd1306_buffer_write
                                   1637 ;	-----------------------------------------
      008ADF                       1638 _ssd1306_buffer_write:
      008ADF 52 0D            [ 2] 1639 	sub	sp, #13
      008AE1 1F 08            [ 2] 1640 	ldw	(0x08, sp), x
                                   1641 ;	./libs/ssd1306_lib.c: 105: for (int height = 0; height < 8; height++)
      008AE3 5F               [ 1] 1642 	clrw	x
      008AE4 1F 0A            [ 2] 1643 	ldw	(0x0a, sp), x
      008AE6                       1644 00109$:
      008AE6 1E 0A            [ 2] 1645 	ldw	x, (0x0a, sp)
      008AE8 A3 00 08         [ 2] 1646 	cpw	x, #0x0008
      008AEB 2F 03            [ 1] 1647 	jrslt	00150$
      008AED CC 8B 72         [ 2] 1648 	jp	00111$
      008AF0                       1649 00150$:
                                   1650 ;	./libs/ssd1306_lib.c: 107: for (int width = 0; width < 8; width++)
      008AF0 1E 0A            [ 2] 1651 	ldw	x, (0x0a, sp)
      008AF2 58               [ 2] 1652 	sllw	x
      008AF3 58               [ 2] 1653 	sllw	x
      008AF4 58               [ 2] 1654 	sllw	x
      008AF5 58               [ 2] 1655 	sllw	x
      008AF6 1F 05            [ 2] 1656 	ldw	(0x05, sp), x
      008AF8 5F               [ 1] 1657 	clrw	x
      008AF9 1F 0C            [ 2] 1658 	ldw	(0x0c, sp), x
      008AFB                       1659 00106$:
      008AFB 1E 0C            [ 2] 1660 	ldw	x, (0x0c, sp)
      008AFD A3 00 08         [ 2] 1661 	cpw	x, #0x0008
      008B00 2E 68            [ 1] 1662 	jrsge	00110$
                                   1663 ;	./libs/ssd1306_lib.c: 108: if(data[height + width / 8] & (128 >> (width & 7)))
      008B02 1E 0A            [ 2] 1664 	ldw	x, (0x0a, sp)
      008B04 72 FB 12         [ 2] 1665 	addw	x, (0x12, sp)
      008B07 F6               [ 1] 1666 	ld	a, (x)
      008B08 97               [ 1] 1667 	ld	xl, a
      008B09 7B 0D            [ 1] 1668 	ld	a, (0x0d, sp)
      008B0B A4 07            [ 1] 1669 	and	a, #0x07
      008B0D 90 AE 00 80      [ 2] 1670 	ldw	y, #0x0080
      008B11 4D               [ 1] 1671 	tnz	a
      008B12 27 05            [ 1] 1672 	jreq	00153$
      008B14                       1673 00152$:
      008B14 90 57            [ 2] 1674 	sraw	y
      008B16 4A               [ 1] 1675 	dec	a
      008B17 26 FB            [ 1] 1676 	jrne	00152$
      008B19                       1677 00153$:
      008B19 17 01            [ 2] 1678 	ldw	(0x01, sp), y
      008B1B 9F               [ 1] 1679 	ld	a, xl
      008B1C 14 02            [ 1] 1680 	and	a, (0x02, sp)
      008B1E 6B 04            [ 1] 1681 	ld	(0x04, sp), a
      008B20 0F 03            [ 1] 1682 	clr	(0x03, sp)
      008B22 1E 03            [ 2] 1683 	ldw	x, (0x03, sp)
      008B24 27 3D            [ 1] 1684 	jreq	00107$
                                   1685 ;	./libs/ssd1306_lib.c: 109: ssd1306_draw_pixel(main_buffer, x + width, y + height, get_bit(main_buffer[(height*16) + (width / 8)], 7 - (width % 8)));
      008B26 4B 08            [ 1] 1686 	push	#0x08
      008B28 4B 00            [ 1] 1687 	push	#0x00
      008B2A 1E 0E            [ 2] 1688 	ldw	x, (0x0e, sp)
      008B2C CD 8B D6         [ 4] 1689 	call	__modsint
      008B2F 1F 03            [ 2] 1690 	ldw	(0x03, sp), x
      008B31 90 AE 00 07      [ 2] 1691 	ldw	y, #0x0007
      008B35 72 F2 03         [ 2] 1692 	subw	y, (0x03, sp)
      008B38 1E 05            [ 2] 1693 	ldw	x, (0x05, sp)
      008B3A D6 01 28         [ 1] 1694 	ld	a, (_main_buffer+0, x)
      008B3D 5F               [ 1] 1695 	clrw	x
      008B3E 90 89            [ 2] 1696 	pushw	y
      008B40 97               [ 1] 1697 	ld	xl, a
      008B41 CD 87 C5         [ 4] 1698 	call	_get_bit
      008B44 7B 11            [ 1] 1699 	ld	a, (0x11, sp)
      008B46 6B 07            [ 1] 1700 	ld	(0x07, sp), a
      008B48 7B 0B            [ 1] 1701 	ld	a, (0x0b, sp)
      008B4A 1B 07            [ 1] 1702 	add	a, (0x07, sp)
      008B4C 95               [ 1] 1703 	ld	xh, a
      008B4D 7B 09            [ 1] 1704 	ld	a, (0x09, sp)
      008B4F 6B 07            [ 1] 1705 	ld	(0x07, sp), a
      008B51 7B 0D            [ 1] 1706 	ld	a, (0x0d, sp)
      008B53 1B 07            [ 1] 1707 	add	a, (0x07, sp)
      008B55 6B 07            [ 1] 1708 	ld	(0x07, sp), a
      008B57 9F               [ 1] 1709 	ld	a, xl
      008B58 88               [ 1] 1710 	push	a
      008B59 9E               [ 1] 1711 	ld	a, xh
      008B5A 88               [ 1] 1712 	push	a
      008B5B 7B 09            [ 1] 1713 	ld	a, (0x09, sp)
      008B5D AE 01 28         [ 2] 1714 	ldw	x, #(_main_buffer+0)
      008B60 CD 88 A5         [ 4] 1715 	call	_ssd1306_draw_pixel
      008B63                       1716 00107$:
                                   1717 ;	./libs/ssd1306_lib.c: 107: for (int width = 0; width < 8; width++)
      008B63 1E 0C            [ 2] 1718 	ldw	x, (0x0c, sp)
      008B65 5C               [ 1] 1719 	incw	x
      008B66 1F 0C            [ 2] 1720 	ldw	(0x0c, sp), x
      008B68 20 91            [ 2] 1721 	jra	00106$
      008B6A                       1722 00110$:
                                   1723 ;	./libs/ssd1306_lib.c: 105: for (int height = 0; height < 8; height++)
      008B6A 1E 0A            [ 2] 1724 	ldw	x, (0x0a, sp)
      008B6C 5C               [ 1] 1725 	incw	x
      008B6D 1F 0A            [ 2] 1726 	ldw	(0x0a, sp), x
      008B6F CC 8A E6         [ 2] 1727 	jp	00109$
      008B72                       1728 00111$:
                                   1729 ;	./libs/ssd1306_lib.c: 111: }
      008B72 1E 0E            [ 2] 1730 	ldw	x, (14, sp)
      008B74 5B 13            [ 2] 1731 	addw	sp, #19
      008B76 FC               [ 2] 1732 	jp	(x)
                                   1733 ;	./libs/ssd1306_lib.c: 113: void ssd1306_clean(void)
                                   1734 ;	-----------------------------------------
                                   1735 ;	 function ssd1306_clean
                                   1736 ;	-----------------------------------------
      008B77                       1737 _ssd1306_clean:
                                   1738 ;	./libs/ssd1306_lib.c: 115: ssd1306_buffer_clean();
      008B77 CD 88 F0         [ 4] 1739 	call	_ssd1306_buffer_clean
                                   1740 ;	./libs/ssd1306_lib.c: 116: ssd1306_send_buffer();
                                   1741 ;	./libs/ssd1306_lib.c: 117: }
      008B7A CC 88 FD         [ 2] 1742 	jp	_ssd1306_send_buffer
                                   1743 ;	main.c: 3: void setup(void)
                                   1744 ;	-----------------------------------------
                                   1745 ;	 function setup
                                   1746 ;	-----------------------------------------
      008B7D                       1747 _setup:
                                   1748 ;	main.c: 6: CLK_CKDIVR = 0;
      008B7D 35 00 50 C6      [ 1] 1749 	mov	0x50c6+0, #0x00
                                   1750 ;	main.c: 9: i2c_init();
      008B81 CD 86 7A         [ 4] 1751 	call	_i2c_init
                                   1752 ;	main.c: 11: enableInterrupts();
      008B84 9A               [ 1] 1753 	rim
                                   1754 ;	main.c: 12: }
      008B85 81               [ 4] 1755 	ret
                                   1756 ;	main.c: 14: void gg(void)
                                   1757 ;	-----------------------------------------
                                   1758 ;	 function gg
                                   1759 ;	-----------------------------------------
      008B86                       1760 _gg:
                                   1761 ;	main.c: 16: ssd1306_init();
      008B86 CD 88 0D         [ 4] 1762 	call	_ssd1306_init
                                   1763 ;	main.c: 17: ssd1306_buffer_splash();
                                   1764 ;	main.c: 21: }
      008B89 CC 89 4D         [ 2] 1765 	jp	_ssd1306_buffer_splash
                                   1766 ;	main.c: 23: int main(void)
                                   1767 ;	-----------------------------------------
                                   1768 ;	 function main
                                   1769 ;	-----------------------------------------
      008B8C                       1770 _main:
                                   1771 ;	main.c: 25: setup();
      008B8C CD 8B 7D         [ 4] 1772 	call	_setup
                                   1773 ;	main.c: 26: gg();
      008B8F CD 8B 86         [ 4] 1774 	call	_gg
                                   1775 ;	main.c: 27: while(1);
      008B92                       1776 00102$:
      008B92 20 FE            [ 2] 1777 	jra	00102$
                                   1778 ;	main.c: 28: }
      008B94 81               [ 4] 1779 	ret
                                   1780 	.area CODE
                                   1781 	.area CONST
                                   1782 	.area INITIALIZER
      008081                       1783 __xinit__I2C_IRQ:
      008081 00                    1784 	.db #0x00	; 0
      008082                       1785 __xinit__ttf_eng_a:
      008082 00                    1786 	.db #0x00	; 0
      008083 7E                    1787 	.db #0x7e	; 126
      008084 42                    1788 	.db #0x42	; 66	'B'
      008085 42                    1789 	.db #0x42	; 66	'B'
      008086 7E                    1790 	.db #0x7e	; 126
      008087 42                    1791 	.db #0x42	; 66	'B'
      008088 42                    1792 	.db #0x42	; 66	'B'
      008089 00                    1793 	.db #0x00	; 0
      00808A                       1794 __xinit__ttf_eng_b:
      00808A 00                    1795 	.db #0x00	; 0
      00808B 7C                    1796 	.db #0x7c	; 124
      00808C 42                    1797 	.db #0x42	; 66	'B'
      00808D 7C                    1798 	.db #0x7c	; 124
      00808E 42                    1799 	.db #0x42	; 66	'B'
      00808F 42                    1800 	.db #0x42	; 66	'B'
      008090 7C                    1801 	.db #0x7c	; 124
      008091 00                    1802 	.db #0x00	; 0
      008092                       1803 __xinit__ttf_eng_c:
      008092 00                    1804 	.db #0x00	; 0
      008093 7E                    1805 	.db #0x7e	; 126
      008094 40                    1806 	.db #0x40	; 64
      008095 40                    1807 	.db #0x40	; 64
      008096 40                    1808 	.db #0x40	; 64
      008097 40                    1809 	.db #0x40	; 64
      008098 7E                    1810 	.db #0x7e	; 126
      008099 00                    1811 	.db #0x00	; 0
      00809A                       1812 __xinit__ttf_eng_d:
      00809A 00                    1813 	.db #0x00	; 0
      00809B 7C                    1814 	.db #0x7c	; 124
      00809C 42                    1815 	.db #0x42	; 66	'B'
      00809D 42                    1816 	.db #0x42	; 66	'B'
      00809E 42                    1817 	.db #0x42	; 66	'B'
      00809F 42                    1818 	.db #0x42	; 66	'B'
      0080A0 7C                    1819 	.db #0x7c	; 124
      0080A1 00                    1820 	.db #0x00	; 0
      0080A2                       1821 __xinit__ttf_eng_e:
      0080A2 00                    1822 	.db #0x00	; 0
      0080A3 7E                    1823 	.db #0x7e	; 126
      0080A4 40                    1824 	.db #0x40	; 64
      0080A5 7C                    1825 	.db #0x7c	; 124
      0080A6 40                    1826 	.db #0x40	; 64
      0080A7 40                    1827 	.db #0x40	; 64
      0080A8 7E                    1828 	.db #0x7e	; 126
      0080A9 00                    1829 	.db #0x00	; 0
      0080AA                       1830 __xinit__ttf_eng_f:
      0080AA 00                    1831 	.db #0x00	; 0
      0080AB 7E                    1832 	.db #0x7e	; 126
      0080AC 40                    1833 	.db #0x40	; 64
      0080AD 40                    1834 	.db #0x40	; 64
      0080AE 7C                    1835 	.db #0x7c	; 124
      0080AF 40                    1836 	.db #0x40	; 64
      0080B0 40                    1837 	.db #0x40	; 64
      0080B1 00                    1838 	.db #0x00	; 0
      0080B2                       1839 __xinit__ttf_eng_g:
      0080B2 00                    1840 	.db #0x00	; 0
      0080B3 7E                    1841 	.db #0x7e	; 126
      0080B4 42                    1842 	.db #0x42	; 66	'B'
      0080B5 40                    1843 	.db #0x40	; 64
      0080B6 4E                    1844 	.db #0x4e	; 78	'N'
      0080B7 42                    1845 	.db #0x42	; 66	'B'
      0080B8 7E                    1846 	.db #0x7e	; 126
      0080B9 00                    1847 	.db #0x00	; 0
      0080BA                       1848 __xinit__ttf_eng_h:
      0080BA 00                    1849 	.db #0x00	; 0
      0080BB 42                    1850 	.db #0x42	; 66	'B'
      0080BC 42                    1851 	.db #0x42	; 66	'B'
      0080BD 42                    1852 	.db #0x42	; 66	'B'
      0080BE 7E                    1853 	.db #0x7e	; 126
      0080BF 42                    1854 	.db #0x42	; 66	'B'
      0080C0 42                    1855 	.db #0x42	; 66	'B'
      0080C1 00                    1856 	.db #0x00	; 0
      0080C2                       1857 __xinit__ttf_eng_i:
      0080C2 00                    1858 	.db #0x00	; 0
      0080C3 7E                    1859 	.db #0x7e	; 126
      0080C4 18                    1860 	.db #0x18	; 24
      0080C5 18                    1861 	.db #0x18	; 24
      0080C6 18                    1862 	.db #0x18	; 24
      0080C7 18                    1863 	.db #0x18	; 24
      0080C8 7E                    1864 	.db #0x7e	; 126
      0080C9 00                    1865 	.db #0x00	; 0
      0080CA                       1866 __xinit__ttf_eng_j:
      0080CA 00                    1867 	.db #0x00	; 0
      0080CB 0C                    1868 	.db #0x0c	; 12
      0080CC 0C                    1869 	.db #0x0c	; 12
      0080CD 0C                    1870 	.db #0x0c	; 12
      0080CE 0C                    1871 	.db #0x0c	; 12
      0080CF 6C                    1872 	.db #0x6c	; 108	'l'
      0080D0 7C                    1873 	.db #0x7c	; 124
      0080D1 00                    1874 	.db #0x00	; 0
      0080D2                       1875 __xinit__ttf_eng_k:
      0080D2 00                    1876 	.db #0x00	; 0
      0080D3 66                    1877 	.db #0x66	; 102	'f'
      0080D4 68                    1878 	.db #0x68	; 104	'h'
      0080D5 70                    1879 	.db #0x70	; 112	'p'
      0080D6 70                    1880 	.db #0x70	; 112	'p'
      0080D7 68                    1881 	.db #0x68	; 104	'h'
      0080D8 66                    1882 	.db #0x66	; 102	'f'
      0080D9 00                    1883 	.db #0x00	; 0
      0080DA                       1884 __xinit__ttf_eng_l:
      0080DA 00                    1885 	.db #0x00	; 0
      0080DB 40                    1886 	.db #0x40	; 64
      0080DC 40                    1887 	.db #0x40	; 64
      0080DD 40                    1888 	.db #0x40	; 64
      0080DE 40                    1889 	.db #0x40	; 64
      0080DF 40                    1890 	.db #0x40	; 64
      0080E0 7E                    1891 	.db #0x7e	; 126
      0080E1 00                    1892 	.db #0x00	; 0
      0080E2                       1893 __xinit__ttf_eng_m:
      0080E2 00                    1894 	.db #0x00	; 0
      0080E3 42                    1895 	.db #0x42	; 66	'B'
      0080E4 66                    1896 	.db #0x66	; 102	'f'
      0080E5 5A                    1897 	.db #0x5a	; 90	'Z'
      0080E6 42                    1898 	.db #0x42	; 66	'B'
      0080E7 42                    1899 	.db #0x42	; 66	'B'
      0080E8 42                    1900 	.db #0x42	; 66	'B'
      0080E9 00                    1901 	.db #0x00	; 0
      0080EA                       1902 __xinit__ttf_eng_n:
      0080EA 00                    1903 	.db #0x00	; 0
      0080EB 42                    1904 	.db #0x42	; 66	'B'
      0080EC 62                    1905 	.db #0x62	; 98	'b'
      0080ED 52                    1906 	.db #0x52	; 82	'R'
      0080EE 4A                    1907 	.db #0x4a	; 74	'J'
      0080EF 46                    1908 	.db #0x46	; 70	'F'
      0080F0 42                    1909 	.db #0x42	; 66	'B'
      0080F1 00                    1910 	.db #0x00	; 0
      0080F2                       1911 __xinit__ttf_eng_o:
      0080F2 00                    1912 	.db #0x00	; 0
      0080F3 7E                    1913 	.db #0x7e	; 126
      0080F4 42                    1914 	.db #0x42	; 66	'B'
      0080F5 42                    1915 	.db #0x42	; 66	'B'
      0080F6 42                    1916 	.db #0x42	; 66	'B'
      0080F7 42                    1917 	.db #0x42	; 66	'B'
      0080F8 7E                    1918 	.db #0x7e	; 126
      0080F9 00                    1919 	.db #0x00	; 0
      0080FA                       1920 __xinit__ttf_eng_p:
      0080FA 00                    1921 	.db #0x00	; 0
      0080FB 7E                    1922 	.db #0x7e	; 126
      0080FC 42                    1923 	.db #0x42	; 66	'B'
      0080FD 42                    1924 	.db #0x42	; 66	'B'
      0080FE 7E                    1925 	.db #0x7e	; 126
      0080FF 40                    1926 	.db #0x40	; 64
      008100 40                    1927 	.db #0x40	; 64
      008101 00                    1928 	.db #0x00	; 0
      008102                       1929 __xinit__ttf_eng_q:
      008102 00                    1930 	.db #0x00	; 0
      008103 7E                    1931 	.db #0x7e	; 126
      008104 42                    1932 	.db #0x42	; 66	'B'
      008105 42                    1933 	.db #0x42	; 66	'B'
      008106 42                    1934 	.db #0x42	; 66	'B'
      008107 7E                    1935 	.db #0x7e	; 126
      008108 04                    1936 	.db #0x04	; 4
      008109 00                    1937 	.db #0x00	; 0
      00810A                       1938 __xinit__ttf_eng_r:
      00810A 00                    1939 	.db #0x00	; 0
      00810B 7E                    1940 	.db #0x7e	; 126
      00810C 42                    1941 	.db #0x42	; 66	'B'
      00810D 42                    1942 	.db #0x42	; 66	'B'
      00810E 7C                    1943 	.db #0x7c	; 124
      00810F 42                    1944 	.db #0x42	; 66	'B'
      008110 42                    1945 	.db #0x42	; 66	'B'
      008111 00                    1946 	.db #0x00	; 0
      008112                       1947 __xinit__ttf_eng_s:
      008112 00                    1948 	.db #0x00	; 0
      008113 3E                    1949 	.db #0x3e	; 62
      008114 40                    1950 	.db #0x40	; 64
      008115 3C                    1951 	.db #0x3c	; 60
      008116 02                    1952 	.db #0x02	; 2
      008117 02                    1953 	.db #0x02	; 2
      008118 7C                    1954 	.db #0x7c	; 124
      008119 00                    1955 	.db #0x00	; 0
      00811A                       1956 __xinit__ttf_eng_t:
      00811A 00                    1957 	.db #0x00	; 0
      00811B 7E                    1958 	.db #0x7e	; 126
      00811C 18                    1959 	.db #0x18	; 24
      00811D 18                    1960 	.db #0x18	; 24
      00811E 18                    1961 	.db #0x18	; 24
      00811F 18                    1962 	.db #0x18	; 24
      008120 18                    1963 	.db #0x18	; 24
      008121 00                    1964 	.db #0x00	; 0
      008122                       1965 __xinit__ttf_eng_u:
      008122 00                    1966 	.db #0x00	; 0
      008123 42                    1967 	.db #0x42	; 66	'B'
      008124 42                    1968 	.db #0x42	; 66	'B'
      008125 42                    1969 	.db #0x42	; 66	'B'
      008126 42                    1970 	.db #0x42	; 66	'B'
      008127 42                    1971 	.db #0x42	; 66	'B'
      008128 3E                    1972 	.db #0x3e	; 62
      008129 00                    1973 	.db #0x00	; 0
      00812A                       1974 __xinit__ttf_eng_v:
      00812A 00                    1975 	.db #0x00	; 0
      00812B 42                    1976 	.db #0x42	; 66	'B'
      00812C 42                    1977 	.db #0x42	; 66	'B'
      00812D 42                    1978 	.db #0x42	; 66	'B'
      00812E 24                    1979 	.db #0x24	; 36
      00812F 24                    1980 	.db #0x24	; 36
      008130 18                    1981 	.db #0x18	; 24
      008131 00                    1982 	.db #0x00	; 0
      008132                       1983 __xinit__ttf_eng_w:
      008132 00                    1984 	.db #0x00	; 0
      008133 42                    1985 	.db #0x42	; 66	'B'
      008134 42                    1986 	.db #0x42	; 66	'B'
      008135 42                    1987 	.db #0x42	; 66	'B'
      008136 5A                    1988 	.db #0x5a	; 90	'Z'
      008137 5A                    1989 	.db #0x5a	; 90	'Z'
      008138 24                    1990 	.db #0x24	; 36
      008139 00                    1991 	.db #0x00	; 0
      00813A                       1992 __xinit__ttf_eng_x:
      00813A 00                    1993 	.db #0x00	; 0
      00813B 42                    1994 	.db #0x42	; 66	'B'
      00813C 24                    1995 	.db #0x24	; 36
      00813D 18                    1996 	.db #0x18	; 24
      00813E 18                    1997 	.db #0x18	; 24
      00813F 22                    1998 	.db #0x22	; 34
      008140 42                    1999 	.db #0x42	; 66	'B'
      008141 00                    2000 	.db #0x00	; 0
      008142                       2001 __xinit__ttf_eng_y:
      008142 00                    2002 	.db #0x00	; 0
      008143 42                    2003 	.db #0x42	; 66	'B'
      008144 24                    2004 	.db #0x24	; 36
      008145 18                    2005 	.db #0x18	; 24
      008146 18                    2006 	.db #0x18	; 24
      008147 18                    2007 	.db #0x18	; 24
      008148 18                    2008 	.db #0x18	; 24
      008149 00                    2009 	.db #0x00	; 0
      00814A                       2010 __xinit__ttf_eng_z:
      00814A 00                    2011 	.db #0x00	; 0
      00814B 7E                    2012 	.db #0x7e	; 126
      00814C 04                    2013 	.db #0x04	; 4
      00814D 08                    2014 	.db #0x08	; 8
      00814E 10                    2015 	.db #0x10	; 16
      00814F 20                    2016 	.db #0x20	; 32
      008150 7E                    2017 	.db #0x7e	; 126
      008151 00                    2018 	.db #0x00	; 0
      008152                       2019 __xinit__ttf_eng_1:
      008152 00                    2020 	.db #0x00	; 0
      008153 18                    2021 	.db #0x18	; 24
      008154 38                    2022 	.db #0x38	; 56	'8'
      008155 38                    2023 	.db #0x38	; 56	'8'
      008156 18                    2024 	.db #0x18	; 24
      008157 18                    2025 	.db #0x18	; 24
      008158 18                    2026 	.db #0x18	; 24
      008159 00                    2027 	.db #0x00	; 0
      00815A                       2028 __xinit__ttf_eng_2:
      00815A 00                    2029 	.db #0x00	; 0
      00815B 38                    2030 	.db #0x38	; 56	'8'
      00815C 44                    2031 	.db #0x44	; 68	'D'
      00815D 08                    2032 	.db #0x08	; 8
      00815E 10                    2033 	.db #0x10	; 16
      00815F 20                    2034 	.db #0x20	; 32
      008160 7C                    2035 	.db #0x7c	; 124
      008161 00                    2036 	.db #0x00	; 0
      008162                       2037 __xinit__ttf_eng_3:
      008162 00                    2038 	.db #0x00	; 0
      008163 7C                    2039 	.db #0x7c	; 124
      008164 02                    2040 	.db #0x02	; 2
      008165 3C                    2041 	.db #0x3c	; 60
      008166 02                    2042 	.db #0x02	; 2
      008167 02                    2043 	.db #0x02	; 2
      008168 7C                    2044 	.db #0x7c	; 124
      008169 00                    2045 	.db #0x00	; 0
      00816A                       2046 __xinit__ttf_eng_4:
      00816A 00                    2047 	.db #0x00	; 0
      00816B 42                    2048 	.db #0x42	; 66	'B'
      00816C 42                    2049 	.db #0x42	; 66	'B'
      00816D 7E                    2050 	.db #0x7e	; 126
      00816E 02                    2051 	.db #0x02	; 2
      00816F 02                    2052 	.db #0x02	; 2
      008170 02                    2053 	.db #0x02	; 2
      008171 00                    2054 	.db #0x00	; 0
      008172                       2055 __xinit__ttf_eng_5:
      008172 00                    2056 	.db #0x00	; 0
      008173 7E                    2057 	.db #0x7e	; 126
      008174 40                    2058 	.db #0x40	; 64
      008175 7C                    2059 	.db #0x7c	; 124
      008176 02                    2060 	.db #0x02	; 2
      008177 02                    2061 	.db #0x02	; 2
      008178 7C                    2062 	.db #0x7c	; 124
      008179 00                    2063 	.db #0x00	; 0
      00817A                       2064 __xinit__ttf_eng_6:
      00817A 00                    2065 	.db #0x00	; 0
      00817B 3C                    2066 	.db #0x3c	; 60
      00817C 40                    2067 	.db #0x40	; 64
      00817D 7C                    2068 	.db #0x7c	; 124
      00817E 42                    2069 	.db #0x42	; 66	'B'
      00817F 42                    2070 	.db #0x42	; 66	'B'
      008180 3C                    2071 	.db #0x3c	; 60
      008181 00                    2072 	.db #0x00	; 0
      008182                       2073 __xinit__ttf_eng_7:
      008182 00                    2074 	.db #0x00	; 0
      008183 7E                    2075 	.db #0x7e	; 126
      008184 02                    2076 	.db #0x02	; 2
      008185 04                    2077 	.db #0x04	; 4
      008186 08                    2078 	.db #0x08	; 8
      008187 10                    2079 	.db #0x10	; 16
      008188 20                    2080 	.db #0x20	; 32
      008189 00                    2081 	.db #0x00	; 0
      00818A                       2082 __xinit__ttf_eng_8:
      00818A 00                    2083 	.db #0x00	; 0
      00818B 3C                    2084 	.db #0x3c	; 60
      00818C 42                    2085 	.db #0x42	; 66	'B'
      00818D 3C                    2086 	.db #0x3c	; 60
      00818E 42                    2087 	.db #0x42	; 66	'B'
      00818F 42                    2088 	.db #0x42	; 66	'B'
      008190 3C                    2089 	.db #0x3c	; 60
      008191 00                    2090 	.db #0x00	; 0
      008192                       2091 __xinit__ttf_eng_9:
      008192 00                    2092 	.db #0x00	; 0
      008193 3C                    2093 	.db #0x3c	; 60
      008194 42                    2094 	.db #0x42	; 66	'B'
      008195 42                    2095 	.db #0x42	; 66	'B'
      008196 3E                    2096 	.db #0x3e	; 62
      008197 02                    2097 	.db #0x02	; 2
      008198 3C                    2098 	.db #0x3c	; 60
      008199 00                    2099 	.db #0x00	; 0
      00819A                       2100 __xinit__ttf_eng_0:
      00819A 00                    2101 	.db #0x00	; 0
      00819B 3C                    2102 	.db #0x3c	; 60
      00819C 46                    2103 	.db #0x46	; 70	'F'
      00819D 4A                    2104 	.db #0x4a	; 74	'J'
      00819E 52                    2105 	.db #0x52	; 82	'R'
      00819F 62                    2106 	.db #0x62	; 98	'b'
      0081A0 3C                    2107 	.db #0x3c	; 60
      0081A1 00                    2108 	.db #0x00	; 0
      0081A2                       2109 __xinit__main_buffer:
      0081A2 FF                    2110 	.db #0xff	; 255
      0081A3 FF                    2111 	.db #0xff	; 255
      0081A4 FF                    2112 	.db #0xff	; 255
      0081A5 FF                    2113 	.db #0xff	; 255
      0081A6 FF                    2114 	.db #0xff	; 255
      0081A7 FF                    2115 	.db #0xff	; 255
      0081A8 FF                    2116 	.db #0xff	; 255
      0081A9 FF                    2117 	.db #0xff	; 255
      0081AA FF                    2118 	.db #0xff	; 255
      0081AB FF                    2119 	.db #0xff	; 255
      0081AC FF                    2120 	.db #0xff	; 255
      0081AD FF                    2121 	.db #0xff	; 255
      0081AE FF                    2122 	.db #0xff	; 255
      0081AF FF                    2123 	.db #0xff	; 255
      0081B0 FF                    2124 	.db #0xff	; 255
      0081B1 FF                    2125 	.db #0xff	; 255
      0081B2 80                    2126 	.db #0x80	; 128
      0081B3 00                    2127 	.db #0x00	; 0
      0081B4 00                    2128 	.db #0x00	; 0
      0081B5 00                    2129 	.db #0x00	; 0
      0081B6 00                    2130 	.db #0x00	; 0
      0081B7 00                    2131 	.db #0x00	; 0
      0081B8 00                    2132 	.db #0x00	; 0
      0081B9 00                    2133 	.db #0x00	; 0
      0081BA 00                    2134 	.db #0x00	; 0
      0081BB 00                    2135 	.db #0x00	; 0
      0081BC 00                    2136 	.db #0x00	; 0
      0081BD 00                    2137 	.db #0x00	; 0
      0081BE 00                    2138 	.db #0x00	; 0
      0081BF 00                    2139 	.db #0x00	; 0
      0081C0 00                    2140 	.db #0x00	; 0
      0081C1 01                    2141 	.db #0x01	; 1
      0081C2 80                    2142 	.db #0x80	; 128
      0081C3 FE                    2143 	.db #0xfe	; 254
      0081C4 03                    2144 	.db #0x03	; 3
      0081C5 FF                    2145 	.db #0xff	; 255
      0081C6 FF                    2146 	.db #0xff	; 255
      0081C7 FF                    2147 	.db #0xff	; 255
      0081C8 FF                    2148 	.db #0xff	; 255
      0081C9 80                    2149 	.db #0x80	; 128
      0081CA FF                    2150 	.db #0xff	; 255
      0081CB FF                    2151 	.db #0xff	; 255
      0081CC F8                    2152 	.db #0xf8	; 248
      0081CD 00                    2153 	.db #0x00	; 0
      0081CE 1D                    2154 	.db #0x1d	; 29
      0081CF 1D                    2155 	.db #0x1d	; 29
      0081D0 5C                    2156 	.db #0x5c	; 92
      0081D1 ED                    2157 	.db #0xed	; 237
      0081D2 80                    2158 	.db #0x80	; 128
      0081D3 FE                    2159 	.db #0xfe	; 254
      0081D4 03                    2160 	.db #0x03	; 3
      0081D5 FF                    2161 	.db #0xff	; 255
      0081D6 FF                    2162 	.db #0xff	; 255
      0081D7 FF                    2163 	.db #0xff	; 255
      0081D8 FF                    2164 	.db #0xff	; 255
      0081D9 80                    2165 	.db #0x80	; 128
      0081DA FF                    2166 	.db #0xff	; 255
      0081DB FF                    2167 	.db #0xff	; 255
      0081DC F8                    2168 	.db #0xf8	; 248
      0081DD 00                    2169 	.db #0x00	; 0
      0081DE 15                    2170 	.db #0x15	; 21
      0081DF 15                    2171 	.db #0x15	; 21
      0081E0 54                    2172 	.db #0x54	; 84	'T'
      0081E1 A5                    2173 	.db #0xa5	; 165
      0081E2 80                    2174 	.db #0x80	; 128
      0081E3 FE                    2175 	.db #0xfe	; 254
      0081E4 03                    2176 	.db #0x03	; 3
      0081E5 FF                    2177 	.db #0xff	; 255
      0081E6 FF                    2178 	.db #0xff	; 255
      0081E7 FF                    2179 	.db #0xff	; 255
      0081E8 FF                    2180 	.db #0xff	; 255
      0081E9 80                    2181 	.db #0x80	; 128
      0081EA FF                    2182 	.db #0xff	; 255
      0081EB FF                    2183 	.db #0xff	; 255
      0081EC F8                    2184 	.db #0xf8	; 248
      0081ED 00                    2185 	.db #0x00	; 0
      0081EE 1D                    2186 	.db #0x1d	; 29
      0081EF 1D                    2187 	.db #0x1d	; 29
      0081F0 DC                    2188 	.db #0xdc	; 220
      0081F1 A5                    2189 	.db #0xa5	; 165
      0081F2 80                    2190 	.db #0x80	; 128
      0081F3 FE                    2191 	.db #0xfe	; 254
      0081F4 03                    2192 	.db #0x03	; 3
      0081F5 FF                    2193 	.db #0xff	; 255
      0081F6 FF                    2194 	.db #0xff	; 255
      0081F7 FF                    2195 	.db #0xff	; 255
      0081F8 FF                    2196 	.db #0xff	; 255
      0081F9 80                    2197 	.db #0x80	; 128
      0081FA FF                    2198 	.db #0xff	; 255
      0081FB FF                    2199 	.db #0xff	; 255
      0081FC F8                    2200 	.db #0xf8	; 248
      0081FD 00                    2201 	.db #0x00	; 0
      0081FE 15                    2202 	.db #0x15	; 21
      0081FF D1                    2203 	.db #0xd1	; 209
      008200 54                    2204 	.db #0x54	; 84	'T'
      008201 E5                    2205 	.db #0xe5	; 229
      008202 80                    2206 	.db #0x80	; 128
      008203 FE                    2207 	.db #0xfe	; 254
      008204 03                    2208 	.db #0x03	; 3
      008205 FF                    2209 	.db #0xff	; 255
      008206 FF                    2210 	.db #0xff	; 255
      008207 FF                    2211 	.db #0xff	; 255
      008208 FF                    2212 	.db #0xff	; 255
      008209 80                    2213 	.db #0x80	; 128
      00820A FF                    2214 	.db #0xff	; 255
      00820B FF                    2215 	.db #0xff	; 255
      00820C F8                    2216 	.db #0xf8	; 248
      00820D 00                    2217 	.db #0x00	; 0
      00820E 00                    2218 	.db #0x00	; 0
      00820F 00                    2219 	.db #0x00	; 0
      008210 00                    2220 	.db #0x00	; 0
      008211 01                    2221 	.db #0x01	; 1
      008212 80                    2222 	.db #0x80	; 128
      008213 FE                    2223 	.db #0xfe	; 254
      008214 03                    2224 	.db #0x03	; 3
      008215 FF                    2225 	.db #0xff	; 255
      008216 FF                    2226 	.db #0xff	; 255
      008217 FF                    2227 	.db #0xff	; 255
      008218 FF                    2228 	.db #0xff	; 255
      008219 80                    2229 	.db #0x80	; 128
      00821A FF                    2230 	.db #0xff	; 255
      00821B FF                    2231 	.db #0xff	; 255
      00821C F8                    2232 	.db #0xf8	; 248
      00821D 00                    2233 	.db #0x00	; 0
      00821E 00                    2234 	.db #0x00	; 0
      00821F 00                    2235 	.db #0x00	; 0
      008220 00                    2236 	.db #0x00	; 0
      008221 01                    2237 	.db #0x01	; 1
      008222 80                    2238 	.db #0x80	; 128
      008223 FE                    2239 	.db #0xfe	; 254
      008224 03                    2240 	.db #0x03	; 3
      008225 FF                    2241 	.db #0xff	; 255
      008226 FF                    2242 	.db #0xff	; 255
      008227 FF                    2243 	.db #0xff	; 255
      008228 FF                    2244 	.db #0xff	; 255
      008229 80                    2245 	.db #0x80	; 128
      00822A FF                    2246 	.db #0xff	; 255
      00822B FF                    2247 	.db #0xff	; 255
      00822C F8                    2248 	.db #0xf8	; 248
      00822D 00                    2249 	.db #0x00	; 0
      00822E 00                    2250 	.db #0x00	; 0
      00822F 00                    2251 	.db #0x00	; 0
      008230 00                    2252 	.db #0x00	; 0
      008231 01                    2253 	.db #0x01	; 1
      008232 80                    2254 	.db #0x80	; 128
      008233 FF                    2255 	.db #0xff	; 255
      008234 FF                    2256 	.db #0xff	; 255
      008235 F8                    2257 	.db #0xf8	; 248
      008236 0F                    2258 	.db #0x0f	; 15
      008237 E0                    2259 	.db #0xe0	; 224
      008238 3F                    2260 	.db #0x3f	; 63
      008239 80                    2261 	.db #0x80	; 128
      00823A FE                    2262 	.db #0xfe	; 254
      00823B 03                    2263 	.db #0x03	; 3
      00823C F8                    2264 	.db #0xf8	; 248
      00823D 00                    2265 	.db #0x00	; 0
      00823E 00                    2266 	.db #0x00	; 0
      00823F 00                    2267 	.db #0x00	; 0
      008240 00                    2268 	.db #0x00	; 0
      008241 01                    2269 	.db #0x01	; 1
      008242 80                    2270 	.db #0x80	; 128
      008243 FF                    2271 	.db #0xff	; 255
      008244 FF                    2272 	.db #0xff	; 255
      008245 F8                    2273 	.db #0xf8	; 248
      008246 0F                    2274 	.db #0x0f	; 15
      008247 E0                    2275 	.db #0xe0	; 224
      008248 3F                    2276 	.db #0x3f	; 63
      008249 80                    2277 	.db #0x80	; 128
      00824A FE                    2278 	.db #0xfe	; 254
      00824B 03                    2279 	.db #0x03	; 3
      00824C F8                    2280 	.db #0xf8	; 248
      00824D 00                    2281 	.db #0x00	; 0
      00824E 00                    2282 	.db #0x00	; 0
      00824F 00                    2283 	.db #0x00	; 0
      008250 00                    2284 	.db #0x00	; 0
      008251 01                    2285 	.db #0x01	; 1
      008252 80                    2286 	.db #0x80	; 128
      008253 FF                    2287 	.db #0xff	; 255
      008254 FF                    2288 	.db #0xff	; 255
      008255 F8                    2289 	.db #0xf8	; 248
      008256 0F                    2290 	.db #0x0f	; 15
      008257 E0                    2291 	.db #0xe0	; 224
      008258 3F                    2292 	.db #0x3f	; 63
      008259 80                    2293 	.db #0x80	; 128
      00825A FE                    2294 	.db #0xfe	; 254
      00825B 03                    2295 	.db #0x03	; 3
      00825C F8                    2296 	.db #0xf8	; 248
      00825D 00                    2297 	.db #0x00	; 0
      00825E 00                    2298 	.db #0x00	; 0
      00825F 00                    2299 	.db #0x00	; 0
      008260 00                    2300 	.db #0x00	; 0
      008261 01                    2301 	.db #0x01	; 1
      008262 80                    2302 	.db #0x80	; 128
      008263 FF                    2303 	.db #0xff	; 255
      008264 FF                    2304 	.db #0xff	; 255
      008265 F8                    2305 	.db #0xf8	; 248
      008266 0F                    2306 	.db #0x0f	; 15
      008267 E0                    2307 	.db #0xe0	; 224
      008268 3F                    2308 	.db #0x3f	; 63
      008269 80                    2309 	.db #0x80	; 128
      00826A FE                    2310 	.db #0xfe	; 254
      00826B 03                    2311 	.db #0x03	; 3
      00826C F8                    2312 	.db #0xf8	; 248
      00826D 00                    2313 	.db #0x00	; 0
      00826E 00                    2314 	.db #0x00	; 0
      00826F 00                    2315 	.db #0x00	; 0
      008270 00                    2316 	.db #0x00	; 0
      008271 01                    2317 	.db #0x01	; 1
      008272 80                    2318 	.db #0x80	; 128
      008273 FF                    2319 	.db #0xff	; 255
      008274 FF                    2320 	.db #0xff	; 255
      008275 F8                    2321 	.db #0xf8	; 248
      008276 0F                    2322 	.db #0x0f	; 15
      008277 E0                    2323 	.db #0xe0	; 224
      008278 3F                    2324 	.db #0x3f	; 63
      008279 80                    2325 	.db #0x80	; 128
      00827A FE                    2326 	.db #0xfe	; 254
      00827B 03                    2327 	.db #0x03	; 3
      00827C F8                    2328 	.db #0xf8	; 248
      00827D 00                    2329 	.db #0x00	; 0
      00827E 00                    2330 	.db #0x00	; 0
      00827F 00                    2331 	.db #0x00	; 0
      008280 00                    2332 	.db #0x00	; 0
      008281 01                    2333 	.db #0x01	; 1
      008282 80                    2334 	.db #0x80	; 128
      008283 FF                    2335 	.db #0xff	; 255
      008284 FF                    2336 	.db #0xff	; 255
      008285 F8                    2337 	.db #0xf8	; 248
      008286 0F                    2338 	.db #0x0f	; 15
      008287 E0                    2339 	.db #0xe0	; 224
      008288 3F                    2340 	.db #0x3f	; 63
      008289 80                    2341 	.db #0x80	; 128
      00828A FE                    2342 	.db #0xfe	; 254
      00828B 03                    2343 	.db #0x03	; 3
      00828C F8                    2344 	.db #0xf8	; 248
      00828D 00                    2345 	.db #0x00	; 0
      00828E 00                    2346 	.db #0x00	; 0
      00828F 00                    2347 	.db #0x00	; 0
      008290 00                    2348 	.db #0x00	; 0
      008291 01                    2349 	.db #0x01	; 1
      008292 80                    2350 	.db #0x80	; 128
      008293 FF                    2351 	.db #0xff	; 255
      008294 FF                    2352 	.db #0xff	; 255
      008295 F8                    2353 	.db #0xf8	; 248
      008296 0F                    2354 	.db #0x0f	; 15
      008297 E0                    2355 	.db #0xe0	; 224
      008298 3F                    2356 	.db #0x3f	; 63
      008299 80                    2357 	.db #0x80	; 128
      00829A FE                    2358 	.db #0xfe	; 254
      00829B 03                    2359 	.db #0x03	; 3
      00829C F8                    2360 	.db #0xf8	; 248
      00829D 00                    2361 	.db #0x00	; 0
      00829E 00                    2362 	.db #0x00	; 0
      00829F 00                    2363 	.db #0x00	; 0
      0082A0 00                    2364 	.db #0x00	; 0
      0082A1 01                    2365 	.db #0x01	; 1
      0082A2 80                    2366 	.db #0x80	; 128
      0082A3 FE                    2367 	.db #0xfe	; 254
      0082A4 03                    2368 	.db #0x03	; 3
      0082A5 F8                    2369 	.db #0xf8	; 248
      0082A6 0F                    2370 	.db #0x0f	; 15
      0082A7 E0                    2371 	.db #0xe0	; 224
      0082A8 3F                    2372 	.db #0x3f	; 63
      0082A9 FF                    2373 	.db #0xff	; 255
      0082AA FF                    2374 	.db #0xff	; 255
      0082AB FC                    2375 	.db #0xfc	; 252
      0082AC 00                    2376 	.db #0x00	; 0
      0082AD 00                    2377 	.db #0x00	; 0
      0082AE 00                    2378 	.db #0x00	; 0
      0082AF 00                    2379 	.db #0x00	; 0
      0082B0 00                    2380 	.db #0x00	; 0
      0082B1 01                    2381 	.db #0x01	; 1
      0082B2 80                    2382 	.db #0x80	; 128
      0082B3 FE                    2383 	.db #0xfe	; 254
      0082B4 03                    2384 	.db #0x03	; 3
      0082B5 F8                    2385 	.db #0xf8	; 248
      0082B6 0F                    2386 	.db #0x0f	; 15
      0082B7 E0                    2387 	.db #0xe0	; 224
      0082B8 3F                    2388 	.db #0x3f	; 63
      0082B9 FF                    2389 	.db #0xff	; 255
      0082BA FF                    2390 	.db #0xff	; 255
      0082BB FC                    2391 	.db #0xfc	; 252
      0082BC 00                    2392 	.db #0x00	; 0
      0082BD 00                    2393 	.db #0x00	; 0
      0082BE 00                    2394 	.db #0x00	; 0
      0082BF 00                    2395 	.db #0x00	; 0
      0082C0 00                    2396 	.db #0x00	; 0
      0082C1 01                    2397 	.db #0x01	; 1
      0082C2 80                    2398 	.db #0x80	; 128
      0082C3 FE                    2399 	.db #0xfe	; 254
      0082C4 03                    2400 	.db #0x03	; 3
      0082C5 F8                    2401 	.db #0xf8	; 248
      0082C6 0F                    2402 	.db #0x0f	; 15
      0082C7 E0                    2403 	.db #0xe0	; 224
      0082C8 3F                    2404 	.db #0x3f	; 63
      0082C9 FF                    2405 	.db #0xff	; 255
      0082CA FF                    2406 	.db #0xff	; 255
      0082CB FC                    2407 	.db #0xfc	; 252
      0082CC 00                    2408 	.db #0x00	; 0
      0082CD 00                    2409 	.db #0x00	; 0
      0082CE 00                    2410 	.db #0x00	; 0
      0082CF 00                    2411 	.db #0x00	; 0
      0082D0 00                    2412 	.db #0x00	; 0
      0082D1 01                    2413 	.db #0x01	; 1
      0082D2 80                    2414 	.db #0x80	; 128
      0082D3 FE                    2415 	.db #0xfe	; 254
      0082D4 03                    2416 	.db #0x03	; 3
      0082D5 F8                    2417 	.db #0xf8	; 248
      0082D6 0F                    2418 	.db #0x0f	; 15
      0082D7 E0                    2419 	.db #0xe0	; 224
      0082D8 3F                    2420 	.db #0x3f	; 63
      0082D9 FF                    2421 	.db #0xff	; 255
      0082DA FF                    2422 	.db #0xff	; 255
      0082DB FC                    2423 	.db #0xfc	; 252
      0082DC 00                    2424 	.db #0x00	; 0
      0082DD 00                    2425 	.db #0x00	; 0
      0082DE 00                    2426 	.db #0x00	; 0
      0082DF 00                    2427 	.db #0x00	; 0
      0082E0 00                    2428 	.db #0x00	; 0
      0082E1 01                    2429 	.db #0x01	; 1
      0082E2 80                    2430 	.db #0x80	; 128
      0082E3 FE                    2431 	.db #0xfe	; 254
      0082E4 03                    2432 	.db #0x03	; 3
      0082E5 F8                    2433 	.db #0xf8	; 248
      0082E6 0F                    2434 	.db #0x0f	; 15
      0082E7 E0                    2435 	.db #0xe0	; 224
      0082E8 3F                    2436 	.db #0x3f	; 63
      0082E9 FF                    2437 	.db #0xff	; 255
      0082EA FF                    2438 	.db #0xff	; 255
      0082EB FC                    2439 	.db #0xfc	; 252
      0082EC 00                    2440 	.db #0x00	; 0
      0082ED 00                    2441 	.db #0x00	; 0
      0082EE 00                    2442 	.db #0x00	; 0
      0082EF 00                    2443 	.db #0x00	; 0
      0082F0 00                    2444 	.db #0x00	; 0
      0082F1 01                    2445 	.db #0x01	; 1
      0082F2 80                    2446 	.db #0x80	; 128
      0082F3 FE                    2447 	.db #0xfe	; 254
      0082F4 03                    2448 	.db #0x03	; 3
      0082F5 F8                    2449 	.db #0xf8	; 248
      0082F6 0F                    2450 	.db #0x0f	; 15
      0082F7 E0                    2451 	.db #0xe0	; 224
      0082F8 3F                    2452 	.db #0x3f	; 63
      0082F9 FF                    2453 	.db #0xff	; 255
      0082FA FF                    2454 	.db #0xff	; 255
      0082FB FC                    2455 	.db #0xfc	; 252
      0082FC 00                    2456 	.db #0x00	; 0
      0082FD 00                    2457 	.db #0x00	; 0
      0082FE 00                    2458 	.db #0x00	; 0
      0082FF 00                    2459 	.db #0x00	; 0
      008300 00                    2460 	.db #0x00	; 0
      008301 01                    2461 	.db #0x01	; 1
      008302 80                    2462 	.db #0x80	; 128
      008303 FE                    2463 	.db #0xfe	; 254
      008304 03                    2464 	.db #0x03	; 3
      008305 F8                    2465 	.db #0xf8	; 248
      008306 0F                    2466 	.db #0x0f	; 15
      008307 E0                    2467 	.db #0xe0	; 224
      008308 3F                    2468 	.db #0x3f	; 63
      008309 FF                    2469 	.db #0xff	; 255
      00830A FF                    2470 	.db #0xff	; 255
      00830B FC                    2471 	.db #0xfc	; 252
      00830C 00                    2472 	.db #0x00	; 0
      00830D 00                    2473 	.db #0x00	; 0
      00830E 00                    2474 	.db #0x00	; 0
      00830F 00                    2475 	.db #0x00	; 0
      008310 00                    2476 	.db #0x00	; 0
      008311 01                    2477 	.db #0x01	; 1
      008312 80                    2478 	.db #0x80	; 128
      008313 FE                    2479 	.db #0xfe	; 254
      008314 03                    2480 	.db #0x03	; 3
      008315 F8                    2481 	.db #0xf8	; 248
      008316 0F                    2482 	.db #0x0f	; 15
      008317 E0                    2483 	.db #0xe0	; 224
      008318 3F                    2484 	.db #0x3f	; 63
      008319 80                    2485 	.db #0x80	; 128
      00831A FE                    2486 	.db #0xfe	; 254
      00831B 03                    2487 	.db #0x03	; 3
      00831C F8                    2488 	.db #0xf8	; 248
      00831D FE                    2489 	.db #0xfe	; 254
      00831E 00                    2490 	.db #0x00	; 0
      00831F 00                    2491 	.db #0x00	; 0
      008320 00                    2492 	.db #0x00	; 0
      008321 01                    2493 	.db #0x01	; 1
      008322 80                    2494 	.db #0x80	; 128
      008323 FE                    2495 	.db #0xfe	; 254
      008324 03                    2496 	.db #0x03	; 3
      008325 F8                    2497 	.db #0xf8	; 248
      008326 0F                    2498 	.db #0x0f	; 15
      008327 E0                    2499 	.db #0xe0	; 224
      008328 3F                    2500 	.db #0x3f	; 63
      008329 80                    2501 	.db #0x80	; 128
      00832A FE                    2502 	.db #0xfe	; 254
      00832B 03                    2503 	.db #0x03	; 3
      00832C F8                    2504 	.db #0xf8	; 248
      00832D FE                    2505 	.db #0xfe	; 254
      00832E 7C                    2506 	.db #0x7c	; 124
      00832F 7E                    2507 	.db #0x7e	; 126
      008330 00                    2508 	.db #0x00	; 0
      008331 01                    2509 	.db #0x01	; 1
      008332 80                    2510 	.db #0x80	; 128
      008333 FE                    2511 	.db #0xfe	; 254
      008334 03                    2512 	.db #0x03	; 3
      008335 F8                    2513 	.db #0xf8	; 248
      008336 0F                    2514 	.db #0x0f	; 15
      008337 E0                    2515 	.db #0xe0	; 224
      008338 3F                    2516 	.db #0x3f	; 63
      008339 80                    2517 	.db #0x80	; 128
      00833A FE                    2518 	.db #0xfe	; 254
      00833B 03                    2519 	.db #0x03	; 3
      00833C F8                    2520 	.db #0xf8	; 248
      00833D 38                    2521 	.db #0x38	; 56	'8'
      00833E 7E                    2522 	.db #0x7e	; 126
      00833F 7E                    2523 	.db #0x7e	; 126
      008340 00                    2524 	.db #0x00	; 0
      008341 01                    2525 	.db #0x01	; 1
      008342 80                    2526 	.db #0x80	; 128
      008343 FE                    2527 	.db #0xfe	; 254
      008344 03                    2528 	.db #0x03	; 3
      008345 F8                    2529 	.db #0xf8	; 248
      008346 0F                    2530 	.db #0x0f	; 15
      008347 E0                    2531 	.db #0xe0	; 224
      008348 3F                    2532 	.db #0x3f	; 63
      008349 80                    2533 	.db #0x80	; 128
      00834A FE                    2534 	.db #0xfe	; 254
      00834B 03                    2535 	.db #0x03	; 3
      00834C F8                    2536 	.db #0xf8	; 248
      00834D 38                    2537 	.db #0x38	; 56	'8'
      00834E 66                    2538 	.db #0x66	; 102	'f'
      00834F 60                    2539 	.db #0x60	; 96
      008350 00                    2540 	.db #0x00	; 0
      008351 01                    2541 	.db #0x01	; 1
      008352 80                    2542 	.db #0x80	; 128
      008353 FE                    2543 	.db #0xfe	; 254
      008354 03                    2544 	.db #0x03	; 3
      008355 F8                    2545 	.db #0xf8	; 248
      008356 0F                    2546 	.db #0x0f	; 15
      008357 E0                    2547 	.db #0xe0	; 224
      008358 3F                    2548 	.db #0x3f	; 63
      008359 80                    2549 	.db #0x80	; 128
      00835A FE                    2550 	.db #0xfe	; 254
      00835B 03                    2551 	.db #0x03	; 3
      00835C F8                    2552 	.db #0xf8	; 248
      00835D 38                    2553 	.db #0x38	; 56	'8'
      00835E 66                    2554 	.db #0x66	; 102	'f'
      00835F 60                    2555 	.db #0x60	; 96
      008360 00                    2556 	.db #0x00	; 0
      008361 01                    2557 	.db #0x01	; 1
      008362 80                    2558 	.db #0x80	; 128
      008363 FE                    2559 	.db #0xfe	; 254
      008364 03                    2560 	.db #0x03	; 3
      008365 F8                    2561 	.db #0xf8	; 248
      008366 0F                    2562 	.db #0x0f	; 15
      008367 E0                    2563 	.db #0xe0	; 224
      008368 3F                    2564 	.db #0x3f	; 63
      008369 80                    2565 	.db #0x80	; 128
      00836A FE                    2566 	.db #0xfe	; 254
      00836B 03                    2567 	.db #0x03	; 3
      00836C F8                    2568 	.db #0xf8	; 248
      00836D FE                    2569 	.db #0xfe	; 254
      00836E 66                    2570 	.db #0x66	; 102	'f'
      00836F 7E                    2571 	.db #0x7e	; 126
      008370 18                    2572 	.db #0x18	; 24
      008371 01                    2573 	.db #0x01	; 1
      008372 80                    2574 	.db #0x80	; 128
      008373 FE                    2575 	.db #0xfe	; 254
      008374 03                    2576 	.db #0x03	; 3
      008375 F8                    2577 	.db #0xf8	; 248
      008376 0F                    2578 	.db #0x0f	; 15
      008377 E0                    2579 	.db #0xe0	; 224
      008378 3F                    2580 	.db #0x3f	; 63
      008379 80                    2581 	.db #0x80	; 128
      00837A FE                    2582 	.db #0xfe	; 254
      00837B 03                    2583 	.db #0x03	; 3
      00837C F8                    2584 	.db #0xf8	; 248
      00837D FE                    2585 	.db #0xfe	; 254
      00837E 66                    2586 	.db #0x66	; 102	'f'
      00837F 7E                    2587 	.db #0x7e	; 126
      008380 18                    2588 	.db #0x18	; 24
      008381 01                    2589 	.db #0x01	; 1
      008382 80                    2590 	.db #0x80	; 128
      008383 00                    2591 	.db #0x00	; 0
      008384 00                    2592 	.db #0x00	; 0
      008385 00                    2593 	.db #0x00	; 0
      008386 00                    2594 	.db #0x00	; 0
      008387 00                    2595 	.db #0x00	; 0
      008388 00                    2596 	.db #0x00	; 0
      008389 00                    2597 	.db #0x00	; 0
      00838A 00                    2598 	.db #0x00	; 0
      00838B 00                    2599 	.db #0x00	; 0
      00838C 00                    2600 	.db #0x00	; 0
      00838D 00                    2601 	.db #0x00	; 0
      00838E 00                    2602 	.db #0x00	; 0
      00838F 00                    2603 	.db #0x00	; 0
      008390 00                    2604 	.db #0x00	; 0
      008391 01                    2605 	.db #0x01	; 1
      008392 FF                    2606 	.db #0xff	; 255
      008393 FF                    2607 	.db #0xff	; 255
      008394 FF                    2608 	.db #0xff	; 255
      008395 FF                    2609 	.db #0xff	; 255
      008396 FF                    2610 	.db #0xff	; 255
      008397 FF                    2611 	.db #0xff	; 255
      008398 FF                    2612 	.db #0xff	; 255
      008399 FF                    2613 	.db #0xff	; 255
      00839A FF                    2614 	.db #0xff	; 255
      00839B FF                    2615 	.db #0xff	; 255
      00839C FF                    2616 	.db #0xff	; 255
      00839D FF                    2617 	.db #0xff	; 255
      00839E FF                    2618 	.db #0xff	; 255
      00839F FF                    2619 	.db #0xff	; 255
      0083A0 FF                    2620 	.db #0xff	; 255
      0083A1 FF                    2621 	.db #0xff	; 255
                                   2622 	.area CABS (ABS)
