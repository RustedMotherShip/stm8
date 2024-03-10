                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.3.0 #14184 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _command_switcher
                                     13 	.globl _data_handler
                                     14 	.globl _cm_SW
                                     15 	.globl _cm_SR
                                     16 	.globl _cm_ST
                                     17 	.globl _cm_DB
                                     18 	.globl _cm_RM
                                     19 	.globl _cm_SN
                                     20 	.globl _cm_SM
                                     21 	.globl _i2c_scan
                                     22 	.globl _i2c_read
                                     23 	.globl _i2c_write
                                     24 	.globl _i2c_stop
                                     25 	.globl _i2c_send_address
                                     26 	.globl _i2c_start
                                     27 	.globl _i2c_init
                                     28 	.globl _uart_init
                                     29 	.globl _status_check
                                     30 	.globl _char_buffer_to_int
                                     31 	.globl _get_size_from_buff
                                     32 	.globl _get_addr_from_buff
                                     33 	.globl _convert_int_to_binary
                                     34 	.globl _convert_chars_to_int
                                     35 	.globl _convert_int_to_chars
                                     36 	.globl _uart_read
                                     37 	.globl _uart_write
                                     38 	.globl _UART_RX
                                     39 	.globl _UART_TX
                                     40 	.globl _delay
                                     41 	.globl ___memcpy
                                     42 	.globl _strlen
                                     43 	.globl _memset
                                     44 	.globl _memcmp
                                     45 	.globl _current_dev
                                     46 	.globl _data_buf
                                     47 	.globl _p_bytes
                                     48 	.globl _d_size
                                     49 	.globl _p_size
                                     50 	.globl _d_addr
                                     51 	.globl _a
                                     52 	.globl _buffer
                                     53 ;--------------------------------------------------------
                                     54 ; ram data
                                     55 ;--------------------------------------------------------
                                     56 	.area DATA
                                     57 ;--------------------------------------------------------
                                     58 ; ram data
                                     59 ;--------------------------------------------------------
                                     60 	.area INITIALIZED
      000001                         61 _buffer::
      000001                         62 	.ds 256
      000101                         63 _a::
      000101                         64 	.ds 3
      000104                         65 _d_addr::
      000104                         66 	.ds 1
      000105                         67 _p_size::
      000105                         68 	.ds 1
      000106                         69 _d_size::
      000106                         70 	.ds 1
      000107                         71 _p_bytes::
      000107                         72 	.ds 1
      000108                         73 _data_buf::
      000108                         74 	.ds 256
      000208                         75 _current_dev::
      000208                         76 	.ds 1
                                     77 ;--------------------------------------------------------
                                     78 ; Stack segment in internal ram
                                     79 ;--------------------------------------------------------
                                     80 	.area SSEG
      000209                         81 __start__stack:
      000209                         82 	.ds	1
                                     83 
                                     84 ;--------------------------------------------------------
                                     85 ; absolute external ram data
                                     86 ;--------------------------------------------------------
                                     87 	.area DABS (ABS)
                                     88 
                                     89 ; default segment ordering for linker
                                     90 	.area HOME
                                     91 	.area GSINIT
                                     92 	.area GSFINAL
                                     93 	.area CONST
                                     94 	.area INITIALIZER
                                     95 	.area CODE
                                     96 
                                     97 ;--------------------------------------------------------
                                     98 ; interrupt vector
                                     99 ;--------------------------------------------------------
                                    100 	.area HOME
      008000                        101 __interrupt_vect:
      008000 82 00 80 07            102 	int s_GSINIT ; reset
                                    103 ;--------------------------------------------------------
                                    104 ; global & static initialisations
                                    105 ;--------------------------------------------------------
                                    106 	.area HOME
                                    107 	.area GSINIT
                                    108 	.area GSFINAL
                                    109 	.area GSINIT
      008007 CD 8C 1C         [ 4]  110 	call	___sdcc_external_startup
      00800A 4D               [ 1]  111 	tnz	a
      00800B 27 03            [ 1]  112 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]  113 	jp	__sdcc_program_startup
      008010                        114 __sdcc_init_data:
                                    115 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]  116 	ldw x, #l_DATA
      008013 27 07            [ 1]  117 	jreq	00002$
      008015                        118 00001$:
      008015 72 4F 00 00      [ 1]  119 	clr (s_DATA - 1, x)
      008019 5A               [ 2]  120 	decw x
      00801A 26 F9            [ 1]  121 	jrne	00001$
      00801C                        122 00002$:
      00801C AE 02 08         [ 2]  123 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]  124 	jreq	00004$
      008021                        125 00003$:
      008021 D6 81 38         [ 1]  126 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]  127 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]  128 	decw	x
      008028 26 F7            [ 1]  129 	jrne	00003$
      00802A                        130 00004$:
                                    131 ; stm8_genXINIT() end
                                    132 	.area GSFINAL
      00802A CC 80 04         [ 2]  133 	jp	__sdcc_program_startup
                                    134 ;--------------------------------------------------------
                                    135 ; Home
                                    136 ;--------------------------------------------------------
                                    137 	.area HOME
                                    138 	.area HOME
      008004                        139 __sdcc_program_startup:
      008004 CC 8B 4F         [ 2]  140 	jp	_main
                                    141 ;	return from main will return to caller
                                    142 ;--------------------------------------------------------
                                    143 ; code
                                    144 ;--------------------------------------------------------
                                    145 	.area CODE
                                    146 ;	main.c: 26: void delay(unsigned long count) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function delay
                                    149 ;	-----------------------------------------
      008341                        150 _delay:
      008341 52 08            [ 2]  151 	sub	sp, #8
                                    152 ;	main.c: 27: while (count--)
      008343 16 0D            [ 2]  153 	ldw	y, (0x0d, sp)
      008345 17 07            [ 2]  154 	ldw	(0x07, sp), y
      008347 1E 0B            [ 2]  155 	ldw	x, (0x0b, sp)
      008349                        156 00101$:
      008349 1F 01            [ 2]  157 	ldw	(0x01, sp), x
      00834B 7B 07            [ 1]  158 	ld	a, (0x07, sp)
      00834D 6B 03            [ 1]  159 	ld	(0x03, sp), a
      00834F 7B 08            [ 1]  160 	ld	a, (0x08, sp)
      008351 16 07            [ 2]  161 	ldw	y, (0x07, sp)
      008353 72 A2 00 01      [ 2]  162 	subw	y, #0x0001
      008357 17 07            [ 2]  163 	ldw	(0x07, sp), y
      008359 24 01            [ 1]  164 	jrnc	00117$
      00835B 5A               [ 2]  165 	decw	x
      00835C                        166 00117$:
      00835C 4D               [ 1]  167 	tnz	a
      00835D 26 08            [ 1]  168 	jrne	00118$
      00835F 16 02            [ 2]  169 	ldw	y, (0x02, sp)
      008361 26 04            [ 1]  170 	jrne	00118$
      008363 0D 01            [ 1]  171 	tnz	(0x01, sp)
      008365 27 03            [ 1]  172 	jreq	00104$
      008367                        173 00118$:
                                    174 ;	main.c: 28: nop();
      008367 9D               [ 1]  175 	nop
      008368 20 DF            [ 2]  176 	jra	00101$
      00836A                        177 00104$:
                                    178 ;	main.c: 29: }
      00836A 1E 09            [ 2]  179 	ldw	x, (9, sp)
      00836C 5B 0E            [ 2]  180 	addw	sp, #14
      00836E FC               [ 2]  181 	jp	(x)
                                    182 ;	main.c: 37: void UART_TX(unsigned char value)
                                    183 ;	-----------------------------------------
                                    184 ;	 function UART_TX
                                    185 ;	-----------------------------------------
      00836F                        186 _UART_TX:
                                    187 ;	main.c: 39: UART1_DR = value;
      00836F C7 52 31         [ 1]  188 	ld	0x5231, a
                                    189 ;	main.c: 40: while(!(UART1_SR & UART_SR_TXE));
      008372                        190 00101$:
      008372 C6 52 30         [ 1]  191 	ld	a, 0x5230
      008375 2A FB            [ 1]  192 	jrpl	00101$
                                    193 ;	main.c: 41: }
      008377 81               [ 4]  194 	ret
                                    195 ;	main.c: 42: unsigned char UART_RX(void)
                                    196 ;	-----------------------------------------
                                    197 ;	 function UART_RX
                                    198 ;	-----------------------------------------
      008378                        199 _UART_RX:
                                    200 ;	main.c: 44: while(!(UART1_SR & UART_SR_TXE));
      008378                        201 00101$:
      008378 C6 52 30         [ 1]  202 	ld	a, 0x5230
      00837B 2A FB            [ 1]  203 	jrpl	00101$
                                    204 ;	main.c: 45: return UART1_DR;
      00837D C6 52 31         [ 1]  205 	ld	a, 0x5231
                                    206 ;	main.c: 46: }
      008380 81               [ 4]  207 	ret
                                    208 ;	main.c: 47: int uart_write(const char *str) {
                                    209 ;	-----------------------------------------
                                    210 ;	 function uart_write
                                    211 ;	-----------------------------------------
      008381                        212 _uart_write:
      008381 52 05            [ 2]  213 	sub	sp, #5
      008383 1F 03            [ 2]  214 	ldw	(0x03, sp), x
                                    215 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      008385 0F 05            [ 1]  216 	clr	(0x05, sp)
      008387                        217 00103$:
      008387 1E 03            [ 2]  218 	ldw	x, (0x03, sp)
      008389 CD 8C 1E         [ 4]  219 	call	_strlen
      00838C 1F 01            [ 2]  220 	ldw	(0x01, sp), x
      00838E 7B 05            [ 1]  221 	ld	a, (0x05, sp)
      008390 5F               [ 1]  222 	clrw	x
      008391 97               [ 1]  223 	ld	xl, a
      008392 13 01            [ 2]  224 	cpw	x, (0x01, sp)
      008394 24 0F            [ 1]  225 	jrnc	00101$
                                    226 ;	main.c: 51: UART_TX(str[i]);
      008396 5F               [ 1]  227 	clrw	x
      008397 7B 05            [ 1]  228 	ld	a, (0x05, sp)
      008399 97               [ 1]  229 	ld	xl, a
      00839A 72 FB 03         [ 2]  230 	addw	x, (0x03, sp)
      00839D F6               [ 1]  231 	ld	a, (x)
      00839E CD 83 6F         [ 4]  232 	call	_UART_TX
                                    233 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      0083A1 0C 05            [ 1]  234 	inc	(0x05, sp)
      0083A3 20 E2            [ 2]  235 	jra	00103$
      0083A5                        236 00101$:
                                    237 ;	main.c: 53: return(i); // Bytes sent
      0083A5 7B 05            [ 1]  238 	ld	a, (0x05, sp)
      0083A7 5F               [ 1]  239 	clrw	x
      0083A8 97               [ 1]  240 	ld	xl, a
                                    241 ;	main.c: 54: }
      0083A9 5B 05            [ 2]  242 	addw	sp, #5
      0083AB 81               [ 4]  243 	ret
                                    244 ;	main.c: 55: int uart_read(void)
                                    245 ;	-----------------------------------------
                                    246 ;	 function uart_read
                                    247 ;	-----------------------------------------
      0083AC                        248 _uart_read:
                                    249 ;	main.c: 57: memset(buffer, 0, sizeof(buffer));
      0083AC 4B 00            [ 1]  250 	push	#0x00
      0083AE 4B 01            [ 1]  251 	push	#0x01
      0083B0 5F               [ 1]  252 	clrw	x
      0083B1 89               [ 2]  253 	pushw	x
      0083B2 AE 00 01         [ 2]  254 	ldw	x, #(_buffer+0)
      0083B5 CD 8B FA         [ 4]  255 	call	_memset
                                    256 ;	main.c: 59: while(i<256)
      0083B8 5F               [ 1]  257 	clrw	x
      0083B9                        258 00105$:
      0083B9 A3 01 00         [ 2]  259 	cpw	x, #0x0100
      0083BC 2E 22            [ 1]  260 	jrsge	00107$
                                    261 ;	main.c: 61: if(UART1_SR & UART_SR_RXNE)
      0083BE C6 52 30         [ 1]  262 	ld	a, 0x5230
      0083C1 A5 20            [ 1]  263 	bcp	a, #0x20
      0083C3 27 F4            [ 1]  264 	jreq	00105$
                                    265 ;	main.c: 63: buffer[i] = UART_RX();
      0083C5 90 93            [ 1]  266 	ldw	y, x
      0083C7 72 A9 00 01      [ 2]  267 	addw	y, #(_buffer+0)
      0083CB 89               [ 2]  268 	pushw	x
      0083CC 90 89            [ 2]  269 	pushw	y
      0083CE CD 83 78         [ 4]  270 	call	_UART_RX
      0083D1 90 85            [ 2]  271 	popw	y
      0083D3 85               [ 2]  272 	popw	x
      0083D4 90 F7            [ 1]  273 	ld	(y), a
                                    274 ;	main.c: 64: if(buffer[i] == '\r\n' )
      0083D6 A1 0D            [ 1]  275 	cp	a, #0x0d
      0083D8 26 03            [ 1]  276 	jrne	00102$
                                    277 ;	main.c: 66: return 1;
      0083DA 5F               [ 1]  278 	clrw	x
      0083DB 5C               [ 1]  279 	incw	x
      0083DC 81               [ 4]  280 	ret
                                    281 ;	main.c: 67: break;
      0083DD                        282 00102$:
                                    283 ;	main.c: 69: i++;
      0083DD 5C               [ 1]  284 	incw	x
      0083DE 20 D9            [ 2]  285 	jra	00105$
      0083E0                        286 00107$:
                                    287 ;	main.c: 72: return 0;
      0083E0 5F               [ 1]  288 	clrw	x
                                    289 ;	main.c: 73: }
      0083E1 81               [ 4]  290 	ret
                                    291 ;	main.c: 82: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    292 ;	-----------------------------------------
                                    293 ;	 function convert_int_to_chars
                                    294 ;	-----------------------------------------
      0083E2                        295 _convert_int_to_chars:
      0083E2 52 0D            [ 2]  296 	sub	sp, #13
      0083E4 6B 0D            [ 1]  297 	ld	(0x0d, sp), a
      0083E6 1F 0B            [ 2]  298 	ldw	(0x0b, sp), x
                                    299 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      0083E8 7B 0D            [ 1]  300 	ld	a, (0x0d, sp)
      0083EA 6B 02            [ 1]  301 	ld	(0x02, sp), a
      0083EC 0F 01            [ 1]  302 	clr	(0x01, sp)
                                    303 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083EE 1E 0B            [ 2]  304 	ldw	x, (0x0b, sp)
      0083F0 5C               [ 1]  305 	incw	x
      0083F1 1F 03            [ 2]  306 	ldw	(0x03, sp), x
                                    307 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083F3 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      0083F5 5C               [ 1]  309 	incw	x
      0083F6 5C               [ 1]  310 	incw	x
      0083F7 1F 05            [ 2]  311 	ldw	(0x05, sp), x
                                    312 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083F9 4B 0A            [ 1]  313 	push	#0x0a
      0083FB 4B 00            [ 1]  314 	push	#0x00
      0083FD 1E 03            [ 2]  315 	ldw	x, (0x03, sp)
                                    316 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083FF CD 8C 43         [ 4]  317 	call	__divsint
      008402 1F 07            [ 2]  318 	ldw	(0x07, sp), x
      008404 4B 0A            [ 1]  319 	push	#0x0a
      008406 4B 00            [ 1]  320 	push	#0x00
      008408 1E 03            [ 2]  321 	ldw	x, (0x03, sp)
      00840A CD 8C 2B         [ 4]  322 	call	__modsint
      00840D 9F               [ 1]  323 	ld	a, xl
      00840E AB 30            [ 1]  324 	add	a, #0x30
      008410 6B 09            [ 1]  325 	ld	(0x09, sp), a
                                    326 ;	main.c: 83: if (num > 99) {
      008412 7B 0D            [ 1]  327 	ld	a, (0x0d, sp)
      008414 A1 63            [ 1]  328 	cp	a, #0x63
      008416 23 29            [ 2]  329 	jrule	00105$
                                    330 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      008418 4B 64            [ 1]  331 	push	#0x64
      00841A 4B 00            [ 1]  332 	push	#0x00
      00841C 1E 03            [ 2]  333 	ldw	x, (0x03, sp)
      00841E CD 8C 43         [ 4]  334 	call	__divsint
      008421 9F               [ 1]  335 	ld	a, xl
      008422 AB 30            [ 1]  336 	add	a, #0x30
      008424 1E 0B            [ 2]  337 	ldw	x, (0x0b, sp)
      008426 F7               [ 1]  338 	ld	(x), a
                                    339 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      008427 4B 0A            [ 1]  340 	push	#0x0a
      008429 4B 00            [ 1]  341 	push	#0x00
      00842B 1E 09            [ 2]  342 	ldw	x, (0x09, sp)
      00842D CD 8C 2B         [ 4]  343 	call	__modsint
      008430 9F               [ 1]  344 	ld	a, xl
      008431 AB 30            [ 1]  345 	add	a, #0x30
      008433 1E 03            [ 2]  346 	ldw	x, (0x03, sp)
      008435 F7               [ 1]  347 	ld	(x), a
                                    348 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      008436 1E 05            [ 2]  349 	ldw	x, (0x05, sp)
      008438 7B 09            [ 1]  350 	ld	a, (0x09, sp)
      00843A F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 88: rx_int_chars[3] ='\0';
      00843B 1E 0B            [ 2]  353 	ldw	x, (0x0b, sp)
      00843D 6F 03            [ 1]  354 	clr	(0x0003, x)
      00843F 20 23            [ 2]  355 	jra	00107$
      008441                        356 00105$:
                                    357 ;	main.c: 90: } else if (num > 9) {
      008441 7B 0D            [ 1]  358 	ld	a, (0x0d, sp)
      008443 A1 09            [ 1]  359 	cp	a, #0x09
      008445 23 13            [ 2]  360 	jrule	00102$
                                    361 ;	main.c: 92: rx_int_chars[0] = num / 10 + '0';
      008447 7B 08            [ 1]  362 	ld	a, (0x08, sp)
      008449 6B 0A            [ 1]  363 	ld	(0x0a, sp), a
      00844B AB 30            [ 1]  364 	add	a, #0x30
      00844D 1E 0B            [ 2]  365 	ldw	x, (0x0b, sp)
      00844F F7               [ 1]  366 	ld	(x), a
                                    367 ;	main.c: 93: rx_int_chars[1] = num % 10 + '0';
      008450 1E 03            [ 2]  368 	ldw	x, (0x03, sp)
      008452 7B 09            [ 1]  369 	ld	a, (0x09, sp)
      008454 F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 94: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      008455 1E 05            [ 2]  372 	ldw	x, (0x05, sp)
      008457 7F               [ 1]  373 	clr	(x)
      008458 20 0A            [ 2]  374 	jra	00107$
      00845A                        375 00102$:
                                    376 ;	main.c: 97: rx_int_chars[0] = num + '0';
      00845A 7B 0D            [ 1]  377 	ld	a, (0x0d, sp)
      00845C AB 30            [ 1]  378 	add	a, #0x30
      00845E 1E 0B            [ 2]  379 	ldw	x, (0x0b, sp)
      008460 F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 98: rx_int_chars[1] ='\0';
      008461 1E 03            [ 2]  382 	ldw	x, (0x03, sp)
      008463 7F               [ 1]  383 	clr	(x)
      008464                        384 00107$:
                                    385 ;	main.c: 100: }
      008464 5B 0D            [ 2]  386 	addw	sp, #13
      008466 81               [ 4]  387 	ret
                                    388 ;	main.c: 102: int convert_chars_to_int(char* rx_chars_int) {
                                    389 ;	-----------------------------------------
                                    390 ;	 function convert_chars_to_int
                                    391 ;	-----------------------------------------
      008467                        392 _convert_chars_to_int:
      008467 52 03            [ 2]  393 	sub	sp, #3
      008469 1F 02            [ 2]  394 	ldw	(0x02, sp), x
                                    395 ;	main.c: 103: uint8_t result = 0;
      00846B 5F               [ 1]  396 	clrw	x
                                    397 ;	main.c: 105: for (int i = 0; i < 3; i++) {
      00846C 90 5F            [ 1]  398 	clrw	y
      00846E                        399 00103$:
      00846E 90 A3 00 03      [ 2]  400 	cpw	y, #0x0003
      008472 2E 15            [ 1]  401 	jrsge	00101$
                                    402 ;	main.c: 106: result = (result * 10) + (rx_chars_int[i] - '0');
      008474 A6 0A            [ 1]  403 	ld	a, #0x0a
      008476 42               [ 4]  404 	mul	x, a
      008477 41               [ 1]  405 	exg	a, xl
      008478 6B 01            [ 1]  406 	ld	(0x01, sp), a
      00847A 41               [ 1]  407 	exg	a, xl
      00847B 93               [ 1]  408 	ldw	x, y
      00847C 72 FB 02         [ 2]  409 	addw	x, (0x02, sp)
      00847F F6               [ 1]  410 	ld	a, (x)
      008480 A0 30            [ 1]  411 	sub	a, #0x30
      008482 1B 01            [ 1]  412 	add	a, (0x01, sp)
      008484 97               [ 1]  413 	ld	xl, a
                                    414 ;	main.c: 105: for (int i = 0; i < 3; i++) {
      008485 90 5C            [ 1]  415 	incw	y
      008487 20 E5            [ 2]  416 	jra	00103$
      008489                        417 00101$:
                                    418 ;	main.c: 109: return result;
      008489 4F               [ 1]  419 	clr	a
      00848A 95               [ 1]  420 	ld	xh, a
                                    421 ;	main.c: 110: }
      00848B 5B 03            [ 2]  422 	addw	sp, #3
      00848D 81               [ 4]  423 	ret
                                    424 ;	main.c: 113: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    425 ;	-----------------------------------------
                                    426 ;	 function convert_int_to_binary
                                    427 ;	-----------------------------------------
      00848E                        428 _convert_int_to_binary:
      00848E 52 04            [ 2]  429 	sub	sp, #4
      008490 1F 01            [ 2]  430 	ldw	(0x01, sp), x
                                    431 ;	main.c: 115: for(int i = 7; i >= 0; i--) {
      008492 AE 00 07         [ 2]  432 	ldw	x, #0x0007
      008495 1F 03            [ 2]  433 	ldw	(0x03, sp), x
      008497                        434 00103$:
      008497 0D 03            [ 1]  435 	tnz	(0x03, sp)
      008499 2B 22            [ 1]  436 	jrmi	00101$
                                    437 ;	main.c: 117: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      00849B AE 00 07         [ 2]  438 	ldw	x, #0x0007
      00849E 72 F0 03         [ 2]  439 	subw	x, (0x03, sp)
      0084A1 72 FB 07         [ 2]  440 	addw	x, (0x07, sp)
      0084A4 16 01            [ 2]  441 	ldw	y, (0x01, sp)
      0084A6 7B 04            [ 1]  442 	ld	a, (0x04, sp)
      0084A8 27 05            [ 1]  443 	jreq	00120$
      0084AA                        444 00119$:
      0084AA 90 57            [ 2]  445 	sraw	y
      0084AC 4A               [ 1]  446 	dec	a
      0084AD 26 FB            [ 1]  447 	jrne	00119$
      0084AF                        448 00120$:
      0084AF 90 9F            [ 1]  449 	ld	a, yl
      0084B1 A4 01            [ 1]  450 	and	a, #0x01
      0084B3 AB 30            [ 1]  451 	add	a, #0x30
      0084B5 F7               [ 1]  452 	ld	(x), a
                                    453 ;	main.c: 115: for(int i = 7; i >= 0; i--) {
      0084B6 1E 03            [ 2]  454 	ldw	x, (0x03, sp)
      0084B8 5A               [ 2]  455 	decw	x
      0084B9 1F 03            [ 2]  456 	ldw	(0x03, sp), x
      0084BB 20 DA            [ 2]  457 	jra	00103$
      0084BD                        458 00101$:
                                    459 ;	main.c: 119: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      0084BD 1E 07            [ 2]  460 	ldw	x, (0x07, sp)
      0084BF 6F 08            [ 1]  461 	clr	(0x0008, x)
                                    462 ;	main.c: 120: }
      0084C1 1E 05            [ 2]  463 	ldw	x, (5, sp)
      0084C3 5B 08            [ 2]  464 	addw	sp, #8
      0084C5 FC               [ 2]  465 	jp	(x)
                                    466 ;	main.c: 129: void get_addr_from_buff(void)
                                    467 ;	-----------------------------------------
                                    468 ;	 function get_addr_from_buff
                                    469 ;	-----------------------------------------
      0084C6                        470 _get_addr_from_buff:
      0084C6 52 02            [ 2]  471 	sub	sp, #2
                                    472 ;	main.c: 133: while(1)
      0084C8 A6 04            [ 1]  473 	ld	a, #0x04
      0084CA 6B 01            [ 1]  474 	ld	(0x01, sp), a
      0084CC 0F 02            [ 1]  475 	clr	(0x02, sp)
      0084CE                        476 00105$:
                                    477 ;	main.c: 135: if(buffer[i] == 32 || buffer[i] == 10)
      0084CE 5F               [ 1]  478 	clrw	x
      0084CF 7B 01            [ 1]  479 	ld	a, (0x01, sp)
      0084D1 97               [ 1]  480 	ld	xl, a
      0084D2 D6 00 01         [ 1]  481 	ld	a, (_buffer+0, x)
      0084D5 A1 20            [ 1]  482 	cp	a, #0x20
      0084D7 27 04            [ 1]  483 	jreq	00101$
      0084D9 A1 0A            [ 1]  484 	cp	a, #0x0a
      0084DB 26 08            [ 1]  485 	jrne	00102$
      0084DD                        486 00101$:
                                    487 ;	main.c: 137: p_size = i+1;
      0084DD 7B 01            [ 1]  488 	ld	a, (0x01, sp)
      0084DF 4C               [ 1]  489 	inc	a
      0084E0 C7 01 05         [ 1]  490 	ld	_p_size+0, a
                                    491 ;	main.c: 138: break;
      0084E3 20 06            [ 2]  492 	jra	00106$
      0084E5                        493 00102$:
                                    494 ;	main.c: 140: i++;
      0084E5 0C 01            [ 1]  495 	inc	(0x01, sp)
                                    496 ;	main.c: 141: counter++;
      0084E7 0C 02            [ 1]  497 	inc	(0x02, sp)
      0084E9 20 E3            [ 2]  498 	jra	00105$
      0084EB                        499 00106$:
                                    500 ;	main.c: 143: memcpy(a, &buffer[3], counter);
      0084EB 5F               [ 1]  501 	clrw	x
      0084EC 7B 02            [ 1]  502 	ld	a, (0x02, sp)
      0084EE 97               [ 1]  503 	ld	xl, a
      0084EF 89               [ 2]  504 	pushw	x
      0084F0 4B 04            [ 1]  505 	push	#<(_buffer+3)
      0084F2 4B 00            [ 1]  506 	push	#((_buffer+3) >> 8)
      0084F4 AE 01 01         [ 2]  507 	ldw	x, #(_a+0)
      0084F7 CD 8B A7         [ 4]  508 	call	___memcpy
                                    509 ;	main.c: 144: d_addr = convert_chars_to_int(a);
      0084FA AE 01 01         [ 2]  510 	ldw	x, #(_a+0)
      0084FD CD 84 67         [ 4]  511 	call	_convert_chars_to_int
      008500 9F               [ 1]  512 	ld	a, xl
      008501 C7 01 04         [ 1]  513 	ld	_d_addr+0, a
                                    514 ;	main.c: 145: }
      008504 5B 02            [ 2]  515 	addw	sp, #2
      008506 81               [ 4]  516 	ret
                                    517 ;	main.c: 147: void get_size_from_buff(void)
                                    518 ;	-----------------------------------------
                                    519 ;	 function get_size_from_buff
                                    520 ;	-----------------------------------------
      008507                        521 _get_size_from_buff:
      008507 88               [ 1]  522 	push	a
                                    523 ;	main.c: 150: uint8_t i = p_size;
      008508 C6 01 05         [ 1]  524 	ld	a, _p_size+0
      00850B 6B 01            [ 1]  525 	ld	(0x01, sp), a
                                    526 ;	main.c: 151: while(1)
      00850D 90 5F            [ 1]  527 	clrw	y
      00850F                        528 00105$:
                                    529 ;	main.c: 153: if(buffer[i] == 32 || buffer[i] == 10)
      00850F 5F               [ 1]  530 	clrw	x
      008510 7B 01            [ 1]  531 	ld	a, (0x01, sp)
      008512 97               [ 1]  532 	ld	xl, a
      008513 D6 00 01         [ 1]  533 	ld	a, (_buffer+0, x)
      008516 A1 20            [ 1]  534 	cp	a, #0x20
      008518 27 04            [ 1]  535 	jreq	00101$
      00851A A1 0A            [ 1]  536 	cp	a, #0x0a
      00851C 26 08            [ 1]  537 	jrne	00102$
      00851E                        538 00101$:
                                    539 ;	main.c: 155: p_bytes = i+1;
      00851E 7B 01            [ 1]  540 	ld	a, (0x01, sp)
      008520 4C               [ 1]  541 	inc	a
      008521 C7 01 07         [ 1]  542 	ld	_p_bytes+0, a
                                    543 ;	main.c: 156: break;
      008524 20 06            [ 2]  544 	jra	00106$
      008526                        545 00102$:
                                    546 ;	main.c: 158: i++;
      008526 0C 01            [ 1]  547 	inc	(0x01, sp)
                                    548 ;	main.c: 159: counter++;
      008528 90 5C            [ 1]  549 	incw	y
      00852A 20 E3            [ 2]  550 	jra	00105$
      00852C                        551 00106$:
                                    552 ;	main.c: 161: memcpy(a, &buffer[p_size], counter);
      00852C 4F               [ 1]  553 	clr	a
      00852D 90 95            [ 1]  554 	ld	yh, a
      00852F 5F               [ 1]  555 	clrw	x
      008530 C6 01 05         [ 1]  556 	ld	a, _p_size+0
      008533 97               [ 1]  557 	ld	xl, a
      008534 1C 00 01         [ 2]  558 	addw	x, #(_buffer+0)
      008537 90 89            [ 2]  559 	pushw	y
      008539 89               [ 2]  560 	pushw	x
      00853A AE 01 01         [ 2]  561 	ldw	x, #(_a+0)
      00853D CD 8B A7         [ 4]  562 	call	___memcpy
                                    563 ;	main.c: 162: d_size = convert_chars_to_int(a);
      008540 AE 01 01         [ 2]  564 	ldw	x, #(_a+0)
      008543 CD 84 67         [ 4]  565 	call	_convert_chars_to_int
      008546 9F               [ 1]  566 	ld	a, xl
      008547 C7 01 06         [ 1]  567 	ld	_d_size+0, a
                                    568 ;	main.c: 163: }
      00854A 84               [ 1]  569 	pop	a
      00854B 81               [ 4]  570 	ret
                                    571 ;	main.c: 164: void char_buffer_to_int(void)
                                    572 ;	-----------------------------------------
                                    573 ;	 function char_buffer_to_int
                                    574 ;	-----------------------------------------
      00854C                        575 _char_buffer_to_int:
      00854C 52 0A            [ 2]  576 	sub	sp, #10
                                    577 ;	main.c: 166: uint8_t counter = d_size;
      00854E C6 01 06         [ 1]  578 	ld	a, _d_size+0
      008551 6B 07            [ 1]  579 	ld	(0x07, sp), a
                                    580 ;	main.c: 167: uint8_t i = p_bytes;
      008553 C6 01 07         [ 1]  581 	ld	a, _p_bytes+0
      008556 6B 08            [ 1]  582 	ld	(0x08, sp), a
                                    583 ;	main.c: 169: while(counter > 0)
      008558 0F 09            [ 1]  584 	clr	(0x09, sp)
      00855A                        585 00111$:
      00855A 0D 07            [ 1]  586 	tnz	(0x07, sp)
      00855C 27 6F            [ 1]  587 	jreq	00114$
                                    588 ;	main.c: 171: if(buffer[i] == 32)
      00855E 5F               [ 1]  589 	clrw	x
      00855F 7B 08            [ 1]  590 	ld	a, (0x08, sp)
      008561 97               [ 1]  591 	ld	xl, a
      008562 1C 00 01         [ 2]  592 	addw	x, #(_buffer+0)
      008565 1F 05            [ 2]  593 	ldw	(0x05, sp), x
      008567 F6               [ 1]  594 	ld	a, (x)
      008568 A1 20            [ 1]  595 	cp	a, #0x20
      00856A 26 53            [ 1]  596 	jrne	00109$
                                    597 ;	main.c: 174: while(1)
      00856C 0F 0A            [ 1]  598 	clr	(0x0a, sp)
      00856E                        599 00104$:
                                    600 ;	main.c: 176: if(buffer[i+1] == 32)
      00856E 7B 08            [ 1]  601 	ld	a, (0x08, sp)
      008570 5F               [ 1]  602 	clrw	x
      008571 97               [ 1]  603 	ld	xl, a
      008572 5C               [ 1]  604 	incw	x
      008573 D6 00 01         [ 1]  605 	ld	a, (_buffer+0, x)
      008576 A1 20            [ 1]  606 	cp	a, #0x20
      008578 27 04            [ 1]  607 	jreq	00105$
                                    608 ;	main.c: 178: buf_counter++;
      00857A 0C 0A            [ 1]  609 	inc	(0x0a, sp)
      00857C 20 F0            [ 2]  610 	jra	00104$
      00857E                        611 00105$:
                                    612 ;	main.c: 180: char ar[4]={0};
      00857E 0F 01            [ 1]  613 	clr	(0x01, sp)
      008580 0F 02            [ 1]  614 	clr	(0x02, sp)
      008582 0F 03            [ 1]  615 	clr	(0x03, sp)
      008584 0F 04            [ 1]  616 	clr	(0x04, sp)
                                    617 ;	main.c: 181: memcpy(a, &buffer[i], buf_counter);
      008586 5F               [ 1]  618 	clrw	x
      008587 7B 0A            [ 1]  619 	ld	a, (0x0a, sp)
      008589 97               [ 1]  620 	ld	xl, a
      00858A 16 05            [ 2]  621 	ldw	y, (0x05, sp)
      00858C 89               [ 2]  622 	pushw	x
      00858D 90 89            [ 2]  623 	pushw	y
      00858F AE 01 01         [ 2]  624 	ldw	x, #(_a+0)
      008592 CD 8B A7         [ 4]  625 	call	___memcpy
                                    626 ;	main.c: 182: data_buf[buf_i] = convert_chars_to_int(a);
      008595 5F               [ 1]  627 	clrw	x
      008596 7B 09            [ 1]  628 	ld	a, (0x09, sp)
      008598 97               [ 1]  629 	ld	xl, a
      008599 1C 01 08         [ 2]  630 	addw	x, #(_data_buf+0)
      00859C 1F 05            [ 2]  631 	ldw	(0x05, sp), x
      00859E AE 01 01         [ 2]  632 	ldw	x, #(_a+0)
      0085A1 CD 84 67         [ 4]  633 	call	_convert_chars_to_int
      0085A4 9F               [ 1]  634 	ld	a, xl
      0085A5 1E 05            [ 2]  635 	ldw	x, (0x05, sp)
      0085A7 F7               [ 1]  636 	ld	(x), a
                                    637 ;	main.c: 183: counter--;
      0085A8 0A 07            [ 1]  638 	dec	(0x07, sp)
                                    639 ;	main.c: 184: buf_i++;
      0085AA 0C 09            [ 1]  640 	inc	(0x09, sp)
                                    641 ;	main.c: 185: convert_int_to_chars(data_buf[buf_i], ar);
      0085AC 5F               [ 1]  642 	clrw	x
      0085AD 7B 09            [ 1]  643 	ld	a, (0x09, sp)
      0085AF 97               [ 1]  644 	ld	xl, a
      0085B0 D6 01 08         [ 1]  645 	ld	a, (_data_buf+0, x)
      0085B3 96               [ 1]  646 	ldw	x, sp
      0085B4 5C               [ 1]  647 	incw	x
      0085B5 CD 83 E2         [ 4]  648 	call	_convert_int_to_chars
                                    649 ;	main.c: 186: uart_write(ar);
      0085B8 96               [ 1]  650 	ldw	x, sp
      0085B9 5C               [ 1]  651 	incw	x
      0085BA CD 83 81         [ 4]  652 	call	_uart_write
      0085BD 20 04            [ 2]  653 	jra	00110$
      0085BF                        654 00109$:
                                    655 ;	main.c: 188: else if(buffer[i] == 10)
      0085BF A1 0A            [ 1]  656 	cp	a, #0x0a
      0085C1 27 0A            [ 1]  657 	jreq	00114$
                                    658 ;	main.c: 190: break;
      0085C3                        659 00110$:
                                    660 ;	main.c: 192: i++;
      0085C3 0C 08            [ 1]  661 	inc	(0x08, sp)
                                    662 ;	main.c: 193: uart_write("while");
      0085C5 AE 80 2D         [ 2]  663 	ldw	x, #(___str_0+0)
      0085C8 CD 83 81         [ 4]  664 	call	_uart_write
      0085CB 20 8D            [ 2]  665 	jra	00111$
      0085CD                        666 00114$:
                                    667 ;	main.c: 196: }
      0085CD 5B 0A            [ 2]  668 	addw	sp, #10
      0085CF 81               [ 4]  669 	ret
                                    670 ;	main.c: 204: void status_check(void){
                                    671 ;	-----------------------------------------
                                    672 ;	 function status_check
                                    673 ;	-----------------------------------------
      0085D0                        674 _status_check:
      0085D0 52 09            [ 2]  675 	sub	sp, #9
                                    676 ;	main.c: 205: char rx_binary_chars[9]={0};
      0085D2 0F 01            [ 1]  677 	clr	(0x01, sp)
      0085D4 0F 02            [ 1]  678 	clr	(0x02, sp)
      0085D6 0F 03            [ 1]  679 	clr	(0x03, sp)
      0085D8 0F 04            [ 1]  680 	clr	(0x04, sp)
      0085DA 0F 05            [ 1]  681 	clr	(0x05, sp)
      0085DC 0F 06            [ 1]  682 	clr	(0x06, sp)
      0085DE 0F 07            [ 1]  683 	clr	(0x07, sp)
      0085E0 0F 08            [ 1]  684 	clr	(0x08, sp)
      0085E2 0F 09            [ 1]  685 	clr	(0x09, sp)
                                    686 ;	main.c: 206: uart_write("\nI2C_REGS >.<\n");
      0085E4 AE 80 33         [ 2]  687 	ldw	x, #(___str_1+0)
      0085E7 CD 83 81         [ 4]  688 	call	_uart_write
                                    689 ;	main.c: 207: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0085EA 96               [ 1]  690 	ldw	x, sp
      0085EB 5C               [ 1]  691 	incw	x
      0085EC 51               [ 1]  692 	exgw	x, y
      0085ED C6 52 17         [ 1]  693 	ld	a, 0x5217
      0085F0 5F               [ 1]  694 	clrw	x
      0085F1 90 89            [ 2]  695 	pushw	y
      0085F3 97               [ 1]  696 	ld	xl, a
      0085F4 CD 84 8E         [ 4]  697 	call	_convert_int_to_binary
                                    698 ;	main.c: 208: uart_write("\nSR1 -> ");
      0085F7 AE 80 42         [ 2]  699 	ldw	x, #(___str_2+0)
      0085FA CD 83 81         [ 4]  700 	call	_uart_write
                                    701 ;	main.c: 209: uart_write(rx_binary_chars);
      0085FD 96               [ 1]  702 	ldw	x, sp
      0085FE 5C               [ 1]  703 	incw	x
      0085FF CD 83 81         [ 4]  704 	call	_uart_write
                                    705 ;	main.c: 210: uart_write(" <-\n");
      008602 AE 80 4B         [ 2]  706 	ldw	x, #(___str_3+0)
      008605 CD 83 81         [ 4]  707 	call	_uart_write
                                    708 ;	main.c: 211: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008608 96               [ 1]  709 	ldw	x, sp
      008609 5C               [ 1]  710 	incw	x
      00860A 51               [ 1]  711 	exgw	x, y
      00860B C6 52 18         [ 1]  712 	ld	a, 0x5218
      00860E 5F               [ 1]  713 	clrw	x
      00860F 90 89            [ 2]  714 	pushw	y
      008611 97               [ 1]  715 	ld	xl, a
      008612 CD 84 8E         [ 4]  716 	call	_convert_int_to_binary
                                    717 ;	main.c: 212: uart_write("SR2 -> ");
      008615 AE 80 50         [ 2]  718 	ldw	x, #(___str_4+0)
      008618 CD 83 81         [ 4]  719 	call	_uart_write
                                    720 ;	main.c: 213: uart_write(rx_binary_chars);
      00861B 96               [ 1]  721 	ldw	x, sp
      00861C 5C               [ 1]  722 	incw	x
      00861D CD 83 81         [ 4]  723 	call	_uart_write
                                    724 ;	main.c: 214: uart_write(" <-\n");
      008620 AE 80 4B         [ 2]  725 	ldw	x, #(___str_3+0)
      008623 CD 83 81         [ 4]  726 	call	_uart_write
                                    727 ;	main.c: 215: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008626 96               [ 1]  728 	ldw	x, sp
      008627 5C               [ 1]  729 	incw	x
      008628 51               [ 1]  730 	exgw	x, y
      008629 C6 52 19         [ 1]  731 	ld	a, 0x5219
      00862C 5F               [ 1]  732 	clrw	x
      00862D 90 89            [ 2]  733 	pushw	y
      00862F 97               [ 1]  734 	ld	xl, a
      008630 CD 84 8E         [ 4]  735 	call	_convert_int_to_binary
                                    736 ;	main.c: 216: uart_write("SR3 -> ");
      008633 AE 80 58         [ 2]  737 	ldw	x, #(___str_5+0)
      008636 CD 83 81         [ 4]  738 	call	_uart_write
                                    739 ;	main.c: 217: uart_write(rx_binary_chars);
      008639 96               [ 1]  740 	ldw	x, sp
      00863A 5C               [ 1]  741 	incw	x
      00863B CD 83 81         [ 4]  742 	call	_uart_write
                                    743 ;	main.c: 218: uart_write(" <-\n");
      00863E AE 80 4B         [ 2]  744 	ldw	x, #(___str_3+0)
      008641 CD 83 81         [ 4]  745 	call	_uart_write
                                    746 ;	main.c: 219: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      008644 96               [ 1]  747 	ldw	x, sp
      008645 5C               [ 1]  748 	incw	x
      008646 51               [ 1]  749 	exgw	x, y
      008647 C6 52 10         [ 1]  750 	ld	a, 0x5210
      00864A 5F               [ 1]  751 	clrw	x
      00864B 90 89            [ 2]  752 	pushw	y
      00864D 97               [ 1]  753 	ld	xl, a
      00864E CD 84 8E         [ 4]  754 	call	_convert_int_to_binary
                                    755 ;	main.c: 220: uart_write("CR1 -> ");
      008651 AE 80 60         [ 2]  756 	ldw	x, #(___str_6+0)
      008654 CD 83 81         [ 4]  757 	call	_uart_write
                                    758 ;	main.c: 221: uart_write(rx_binary_chars);
      008657 96               [ 1]  759 	ldw	x, sp
      008658 5C               [ 1]  760 	incw	x
      008659 CD 83 81         [ 4]  761 	call	_uart_write
                                    762 ;	main.c: 222: uart_write(" <-\n");
      00865C AE 80 4B         [ 2]  763 	ldw	x, #(___str_3+0)
      00865F CD 83 81         [ 4]  764 	call	_uart_write
                                    765 ;	main.c: 223: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008662 96               [ 1]  766 	ldw	x, sp
      008663 5C               [ 1]  767 	incw	x
      008664 51               [ 1]  768 	exgw	x, y
      008665 C6 52 11         [ 1]  769 	ld	a, 0x5211
      008668 5F               [ 1]  770 	clrw	x
      008669 90 89            [ 2]  771 	pushw	y
      00866B 97               [ 1]  772 	ld	xl, a
      00866C CD 84 8E         [ 4]  773 	call	_convert_int_to_binary
                                    774 ;	main.c: 224: uart_write("CR2 -> ");
      00866F AE 80 68         [ 2]  775 	ldw	x, #(___str_7+0)
      008672 CD 83 81         [ 4]  776 	call	_uart_write
                                    777 ;	main.c: 225: uart_write(rx_binary_chars);
      008675 96               [ 1]  778 	ldw	x, sp
      008676 5C               [ 1]  779 	incw	x
      008677 CD 83 81         [ 4]  780 	call	_uart_write
                                    781 ;	main.c: 226: uart_write(" <-\n");
      00867A AE 80 4B         [ 2]  782 	ldw	x, #(___str_3+0)
      00867D CD 83 81         [ 4]  783 	call	_uart_write
                                    784 ;	main.c: 227: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008680 96               [ 1]  785 	ldw	x, sp
      008681 5C               [ 1]  786 	incw	x
      008682 51               [ 1]  787 	exgw	x, y
      008683 C6 52 16         [ 1]  788 	ld	a, 0x5216
      008686 5F               [ 1]  789 	clrw	x
      008687 90 89            [ 2]  790 	pushw	y
      008689 97               [ 1]  791 	ld	xl, a
      00868A CD 84 8E         [ 4]  792 	call	_convert_int_to_binary
                                    793 ;	main.c: 228: uart_write("DR -> ");
      00868D AE 80 70         [ 2]  794 	ldw	x, #(___str_8+0)
      008690 CD 83 81         [ 4]  795 	call	_uart_write
                                    796 ;	main.c: 229: uart_write(rx_binary_chars);
      008693 96               [ 1]  797 	ldw	x, sp
      008694 5C               [ 1]  798 	incw	x
      008695 CD 83 81         [ 4]  799 	call	_uart_write
                                    800 ;	main.c: 230: uart_write(" <-\n");
      008698 AE 80 4B         [ 2]  801 	ldw	x, #(___str_3+0)
      00869B CD 83 81         [ 4]  802 	call	_uart_write
                                    803 ;	main.c: 231: uart_write("UART_REGS >.<\n");
      00869E AE 80 77         [ 2]  804 	ldw	x, #(___str_9+0)
      0086A1 CD 83 81         [ 4]  805 	call	_uart_write
                                    806 ;	main.c: 232: convert_int_to_binary(UART1_SR, rx_binary_chars);
      0086A4 96               [ 1]  807 	ldw	x, sp
      0086A5 5C               [ 1]  808 	incw	x
      0086A6 51               [ 1]  809 	exgw	x, y
      0086A7 C6 52 30         [ 1]  810 	ld	a, 0x5230
      0086AA 5F               [ 1]  811 	clrw	x
      0086AB 90 89            [ 2]  812 	pushw	y
      0086AD 97               [ 1]  813 	ld	xl, a
      0086AE CD 84 8E         [ 4]  814 	call	_convert_int_to_binary
                                    815 ;	main.c: 233: uart_write("\nSR -> ");
      0086B1 AE 80 86         [ 2]  816 	ldw	x, #(___str_10+0)
      0086B4 CD 83 81         [ 4]  817 	call	_uart_write
                                    818 ;	main.c: 234: uart_write(rx_binary_chars);
      0086B7 96               [ 1]  819 	ldw	x, sp
      0086B8 5C               [ 1]  820 	incw	x
      0086B9 CD 83 81         [ 4]  821 	call	_uart_write
                                    822 ;	main.c: 235: uart_write(" <-\n");
      0086BC AE 80 4B         [ 2]  823 	ldw	x, #(___str_3+0)
      0086BF CD 83 81         [ 4]  824 	call	_uart_write
                                    825 ;	main.c: 236: convert_int_to_binary(UART1_DR, rx_binary_chars);
      0086C2 96               [ 1]  826 	ldw	x, sp
      0086C3 5C               [ 1]  827 	incw	x
      0086C4 51               [ 1]  828 	exgw	x, y
      0086C5 C6 52 31         [ 1]  829 	ld	a, 0x5231
      0086C8 5F               [ 1]  830 	clrw	x
      0086C9 90 89            [ 2]  831 	pushw	y
      0086CB 97               [ 1]  832 	ld	xl, a
      0086CC CD 84 8E         [ 4]  833 	call	_convert_int_to_binary
                                    834 ;	main.c: 237: uart_write("DR -> ");
      0086CF AE 80 70         [ 2]  835 	ldw	x, #(___str_8+0)
      0086D2 CD 83 81         [ 4]  836 	call	_uart_write
                                    837 ;	main.c: 238: uart_write(rx_binary_chars);
      0086D5 96               [ 1]  838 	ldw	x, sp
      0086D6 5C               [ 1]  839 	incw	x
      0086D7 CD 83 81         [ 4]  840 	call	_uart_write
                                    841 ;	main.c: 239: uart_write(" <-\n");
      0086DA AE 80 4B         [ 2]  842 	ldw	x, #(___str_3+0)
      0086DD CD 83 81         [ 4]  843 	call	_uart_write
                                    844 ;	main.c: 240: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
      0086E0 96               [ 1]  845 	ldw	x, sp
      0086E1 5C               [ 1]  846 	incw	x
      0086E2 51               [ 1]  847 	exgw	x, y
      0086E3 C6 52 32         [ 1]  848 	ld	a, 0x5232
      0086E6 5F               [ 1]  849 	clrw	x
      0086E7 90 89            [ 2]  850 	pushw	y
      0086E9 97               [ 1]  851 	ld	xl, a
      0086EA CD 84 8E         [ 4]  852 	call	_convert_int_to_binary
                                    853 ;	main.c: 241: uart_write("BRR1 -> ");
      0086ED AE 80 8E         [ 2]  854 	ldw	x, #(___str_11+0)
      0086F0 CD 83 81         [ 4]  855 	call	_uart_write
                                    856 ;	main.c: 242: uart_write(rx_binary_chars);
      0086F3 96               [ 1]  857 	ldw	x, sp
      0086F4 5C               [ 1]  858 	incw	x
      0086F5 CD 83 81         [ 4]  859 	call	_uart_write
                                    860 ;	main.c: 243: uart_write(" <-\n");
      0086F8 AE 80 4B         [ 2]  861 	ldw	x, #(___str_3+0)
      0086FB CD 83 81         [ 4]  862 	call	_uart_write
                                    863 ;	main.c: 244: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
      0086FE 96               [ 1]  864 	ldw	x, sp
      0086FF 5C               [ 1]  865 	incw	x
      008700 51               [ 1]  866 	exgw	x, y
      008701 C6 52 33         [ 1]  867 	ld	a, 0x5233
      008704 5F               [ 1]  868 	clrw	x
      008705 90 89            [ 2]  869 	pushw	y
      008707 97               [ 1]  870 	ld	xl, a
      008708 CD 84 8E         [ 4]  871 	call	_convert_int_to_binary
                                    872 ;	main.c: 245: uart_write("BRR2 -> ");
      00870B AE 80 97         [ 2]  873 	ldw	x, #(___str_12+0)
      00870E CD 83 81         [ 4]  874 	call	_uart_write
                                    875 ;	main.c: 246: uart_write(rx_binary_chars);
      008711 96               [ 1]  876 	ldw	x, sp
      008712 5C               [ 1]  877 	incw	x
      008713 CD 83 81         [ 4]  878 	call	_uart_write
                                    879 ;	main.c: 247: uart_write(" <-\n");
      008716 AE 80 4B         [ 2]  880 	ldw	x, #(___str_3+0)
      008719 CD 83 81         [ 4]  881 	call	_uart_write
                                    882 ;	main.c: 248: convert_int_to_binary(UART1_CR1, rx_binary_chars);
      00871C 96               [ 1]  883 	ldw	x, sp
      00871D 5C               [ 1]  884 	incw	x
      00871E 51               [ 1]  885 	exgw	x, y
      00871F C6 52 34         [ 1]  886 	ld	a, 0x5234
      008722 5F               [ 1]  887 	clrw	x
      008723 90 89            [ 2]  888 	pushw	y
      008725 97               [ 1]  889 	ld	xl, a
      008726 CD 84 8E         [ 4]  890 	call	_convert_int_to_binary
                                    891 ;	main.c: 249: uart_write("CR1 -> ");
      008729 AE 80 60         [ 2]  892 	ldw	x, #(___str_6+0)
      00872C CD 83 81         [ 4]  893 	call	_uart_write
                                    894 ;	main.c: 250: uart_write(rx_binary_chars);
      00872F 96               [ 1]  895 	ldw	x, sp
      008730 5C               [ 1]  896 	incw	x
      008731 CD 83 81         [ 4]  897 	call	_uart_write
                                    898 ;	main.c: 251: uart_write(" <-\n");
      008734 AE 80 4B         [ 2]  899 	ldw	x, #(___str_3+0)
      008737 CD 83 81         [ 4]  900 	call	_uart_write
                                    901 ;	main.c: 252: convert_int_to_binary(UART1_CR2, rx_binary_chars);
      00873A 96               [ 1]  902 	ldw	x, sp
      00873B 5C               [ 1]  903 	incw	x
      00873C 51               [ 1]  904 	exgw	x, y
      00873D C6 52 35         [ 1]  905 	ld	a, 0x5235
      008740 5F               [ 1]  906 	clrw	x
      008741 90 89            [ 2]  907 	pushw	y
      008743 97               [ 1]  908 	ld	xl, a
      008744 CD 84 8E         [ 4]  909 	call	_convert_int_to_binary
                                    910 ;	main.c: 253: uart_write("CR2 -> ");
      008747 AE 80 68         [ 2]  911 	ldw	x, #(___str_7+0)
      00874A CD 83 81         [ 4]  912 	call	_uart_write
                                    913 ;	main.c: 254: uart_write(rx_binary_chars);
      00874D 96               [ 1]  914 	ldw	x, sp
      00874E 5C               [ 1]  915 	incw	x
      00874F CD 83 81         [ 4]  916 	call	_uart_write
                                    917 ;	main.c: 255: uart_write(" <-\n");
      008752 AE 80 4B         [ 2]  918 	ldw	x, #(___str_3+0)
      008755 CD 83 81         [ 4]  919 	call	_uart_write
                                    920 ;	main.c: 256: convert_int_to_binary(UART1_CR3, rx_binary_chars);
      008758 96               [ 1]  921 	ldw	x, sp
      008759 5C               [ 1]  922 	incw	x
      00875A 51               [ 1]  923 	exgw	x, y
      00875B C6 52 36         [ 1]  924 	ld	a, 0x5236
      00875E 5F               [ 1]  925 	clrw	x
      00875F 90 89            [ 2]  926 	pushw	y
      008761 97               [ 1]  927 	ld	xl, a
      008762 CD 84 8E         [ 4]  928 	call	_convert_int_to_binary
                                    929 ;	main.c: 257: uart_write("CR3 -> ");
      008765 AE 80 A0         [ 2]  930 	ldw	x, #(___str_13+0)
      008768 CD 83 81         [ 4]  931 	call	_uart_write
                                    932 ;	main.c: 258: uart_write(rx_binary_chars);
      00876B 96               [ 1]  933 	ldw	x, sp
      00876C 5C               [ 1]  934 	incw	x
      00876D CD 83 81         [ 4]  935 	call	_uart_write
                                    936 ;	main.c: 259: uart_write(" <-\n");
      008770 AE 80 4B         [ 2]  937 	ldw	x, #(___str_3+0)
      008773 CD 83 81         [ 4]  938 	call	_uart_write
                                    939 ;	main.c: 260: convert_int_to_binary(UART1_CR4, rx_binary_chars);
      008776 96               [ 1]  940 	ldw	x, sp
      008777 5C               [ 1]  941 	incw	x
      008778 51               [ 1]  942 	exgw	x, y
      008779 C6 52 37         [ 1]  943 	ld	a, 0x5237
      00877C 5F               [ 1]  944 	clrw	x
      00877D 90 89            [ 2]  945 	pushw	y
      00877F 97               [ 1]  946 	ld	xl, a
      008780 CD 84 8E         [ 4]  947 	call	_convert_int_to_binary
                                    948 ;	main.c: 261: uart_write("CR4 -> ");
      008783 AE 80 A8         [ 2]  949 	ldw	x, #(___str_14+0)
      008786 CD 83 81         [ 4]  950 	call	_uart_write
                                    951 ;	main.c: 262: uart_write(rx_binary_chars);
      008789 96               [ 1]  952 	ldw	x, sp
      00878A 5C               [ 1]  953 	incw	x
      00878B CD 83 81         [ 4]  954 	call	_uart_write
                                    955 ;	main.c: 263: uart_write(" <-\n");
      00878E AE 80 4B         [ 2]  956 	ldw	x, #(___str_3+0)
      008791 CD 83 81         [ 4]  957 	call	_uart_write
                                    958 ;	main.c: 264: convert_int_to_binary(UART1_CR5, rx_binary_chars);
      008794 96               [ 1]  959 	ldw	x, sp
      008795 5C               [ 1]  960 	incw	x
      008796 51               [ 1]  961 	exgw	x, y
      008797 C6 52 38         [ 1]  962 	ld	a, 0x5238
      00879A 5F               [ 1]  963 	clrw	x
      00879B 90 89            [ 2]  964 	pushw	y
      00879D 97               [ 1]  965 	ld	xl, a
      00879E CD 84 8E         [ 4]  966 	call	_convert_int_to_binary
                                    967 ;	main.c: 265: uart_write("CR5 -> ");
      0087A1 AE 80 B0         [ 2]  968 	ldw	x, #(___str_15+0)
      0087A4 CD 83 81         [ 4]  969 	call	_uart_write
                                    970 ;	main.c: 266: uart_write(rx_binary_chars);
      0087A7 96               [ 1]  971 	ldw	x, sp
      0087A8 5C               [ 1]  972 	incw	x
      0087A9 CD 83 81         [ 4]  973 	call	_uart_write
                                    974 ;	main.c: 267: uart_write(" <-\n");
      0087AC AE 80 4B         [ 2]  975 	ldw	x, #(___str_3+0)
      0087AF CD 83 81         [ 4]  976 	call	_uart_write
                                    977 ;	main.c: 268: convert_int_to_binary(UART1_GTR, rx_binary_chars);
      0087B2 96               [ 1]  978 	ldw	x, sp
      0087B3 5C               [ 1]  979 	incw	x
      0087B4 51               [ 1]  980 	exgw	x, y
      0087B5 C6 52 39         [ 1]  981 	ld	a, 0x5239
      0087B8 5F               [ 1]  982 	clrw	x
      0087B9 90 89            [ 2]  983 	pushw	y
      0087BB 97               [ 1]  984 	ld	xl, a
      0087BC CD 84 8E         [ 4]  985 	call	_convert_int_to_binary
                                    986 ;	main.c: 269: uart_write("GTR -> ");
      0087BF AE 80 B8         [ 2]  987 	ldw	x, #(___str_16+0)
      0087C2 CD 83 81         [ 4]  988 	call	_uart_write
                                    989 ;	main.c: 270: uart_write(rx_binary_chars);
      0087C5 96               [ 1]  990 	ldw	x, sp
      0087C6 5C               [ 1]  991 	incw	x
      0087C7 CD 83 81         [ 4]  992 	call	_uart_write
                                    993 ;	main.c: 271: uart_write(" <-\n");
      0087CA AE 80 4B         [ 2]  994 	ldw	x, #(___str_3+0)
      0087CD CD 83 81         [ 4]  995 	call	_uart_write
                                    996 ;	main.c: 272: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
      0087D0 96               [ 1]  997 	ldw	x, sp
      0087D1 5C               [ 1]  998 	incw	x
      0087D2 51               [ 1]  999 	exgw	x, y
      0087D3 C6 52 3A         [ 1] 1000 	ld	a, 0x523a
      0087D6 5F               [ 1] 1001 	clrw	x
      0087D7 90 89            [ 2] 1002 	pushw	y
      0087D9 97               [ 1] 1003 	ld	xl, a
      0087DA CD 84 8E         [ 4] 1004 	call	_convert_int_to_binary
                                   1005 ;	main.c: 273: uart_write("PSCR -> ");
      0087DD AE 80 C0         [ 2] 1006 	ldw	x, #(___str_17+0)
      0087E0 CD 83 81         [ 4] 1007 	call	_uart_write
                                   1008 ;	main.c: 274: uart_write(rx_binary_chars);
      0087E3 96               [ 1] 1009 	ldw	x, sp
      0087E4 5C               [ 1] 1010 	incw	x
      0087E5 CD 83 81         [ 4] 1011 	call	_uart_write
                                   1012 ;	main.c: 275: uart_write(" <-\n");
      0087E8 AE 80 4B         [ 2] 1013 	ldw	x, #(___str_3+0)
      0087EB CD 83 81         [ 4] 1014 	call	_uart_write
                                   1015 ;	main.c: 276: }
      0087EE 5B 09            [ 2] 1016 	addw	sp, #9
      0087F0 81               [ 4] 1017 	ret
                                   1018 ;	main.c: 278: void uart_init(void){
                                   1019 ;	-----------------------------------------
                                   1020 ;	 function uart_init
                                   1021 ;	-----------------------------------------
      0087F1                       1022 _uart_init:
                                   1023 ;	main.c: 279: CLK_CKDIVR = 0;
      0087F1 35 00 50 C6      [ 1] 1024 	mov	0x50c6+0, #0x00
                                   1025 ;	main.c: 282: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0087F5 72 16 52 35      [ 1] 1026 	bset	0x5235, #3
                                   1027 ;	main.c: 283: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      0087F9 72 14 52 35      [ 1] 1028 	bset	0x5235, #2
                                   1029 ;	main.c: 284: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0087FD C6 52 36         [ 1] 1030 	ld	a, 0x5236
      008800 A4 CF            [ 1] 1031 	and	a, #0xcf
      008802 C7 52 36         [ 1] 1032 	ld	0x5236, a
                                   1033 ;	main.c: 286: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008805 35 03 52 33      [ 1] 1034 	mov	0x5233+0, #0x03
      008809 35 68 52 32      [ 1] 1035 	mov	0x5232+0, #0x68
                                   1036 ;	main.c: 287: }
      00880D 81               [ 4] 1037 	ret
                                   1038 ;	main.c: 291: void i2c_init(void) {
                                   1039 ;	-----------------------------------------
                                   1040 ;	 function i2c_init
                                   1041 ;	-----------------------------------------
      00880E                       1042 _i2c_init:
                                   1043 ;	main.c: 297: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      00880E 72 11 52 10      [ 1] 1044 	bres	0x5210, #0
                                   1045 ;	main.c: 298: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008812 35 10 52 12      [ 1] 1046 	mov	0x5212+0, #0x10
                                   1047 ;	main.c: 299: I2C_CCRH = 0;                   // =0
      008816 35 00 52 1C      [ 1] 1048 	mov	0x521c+0, #0x00
                                   1049 ;	main.c: 300: I2C_CCRL = 80;                  // 100kHz for I2C
      00881A 35 50 52 1B      [ 1] 1050 	mov	0x521b+0, #0x50
                                   1051 ;	main.c: 301: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      00881E 72 1F 52 1C      [ 1] 1052 	bres	0x521c, #7
                                   1053 ;	main.c: 302: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      008822 72 1F 52 14      [ 1] 1054 	bres	0x5214, #7
                                   1055 ;	main.c: 303: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      008826 72 1C 52 14      [ 1] 1056 	bset	0x5214, #6
                                   1057 ;	main.c: 304: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      00882A 72 10 52 10      [ 1] 1058 	bset	0x5210, #0
                                   1059 ;	main.c: 305: }
      00882E 81               [ 4] 1060 	ret
                                   1061 ;	main.c: 314: void i2c_start(void) {
                                   1062 ;	-----------------------------------------
                                   1063 ;	 function i2c_start
                                   1064 ;	-----------------------------------------
      00882F                       1065 _i2c_start:
                                   1066 ;	main.c: 315: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      00882F 72 10 52 11      [ 1] 1067 	bset	0x5211, #0
                                   1068 ;	main.c: 316: while(!(I2C_SR1 & (1 << 0)));
      008833                       1069 00101$:
      008833 72 01 52 17 FB   [ 2] 1070 	btjf	0x5217, #0, 00101$
                                   1071 ;	main.c: 318: }
      008838 81               [ 4] 1072 	ret
                                   1073 ;	main.c: 320: void i2c_send_address(uint8_t address) {
                                   1074 ;	-----------------------------------------
                                   1075 ;	 function i2c_send_address
                                   1076 ;	-----------------------------------------
      008839                       1077 _i2c_send_address:
                                   1078 ;	main.c: 321: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      008839 48               [ 1] 1079 	sll	a
      00883A C7 52 16         [ 1] 1080 	ld	0x5216, a
                                   1081 ;	main.c: 322: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00883D                       1082 00102$:
      00883D 72 03 52 17 01   [ 2] 1083 	btjf	0x5217, #1, 00117$
      008842 81               [ 4] 1084 	ret
      008843                       1085 00117$:
      008843 72 05 52 18 F5   [ 2] 1086 	btjf	0x5218, #2, 00102$
                                   1087 ;	main.c: 323: }
      008848 81               [ 4] 1088 	ret
                                   1089 ;	main.c: 325: void i2c_stop(void) {
                                   1090 ;	-----------------------------------------
                                   1091 ;	 function i2c_stop
                                   1092 ;	-----------------------------------------
      008849                       1093 _i2c_stop:
                                   1094 ;	main.c: 326: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      008849 72 12 52 11      [ 1] 1095 	bset	0x5211, #1
                                   1096 ;	main.c: 328: }
      00884D 81               [ 4] 1097 	ret
                                   1098 ;	main.c: 329: void i2c_write(void){
                                   1099 ;	-----------------------------------------
                                   1100 ;	 function i2c_write
                                   1101 ;	-----------------------------------------
      00884E                       1102 _i2c_write:
      00884E 52 04            [ 2] 1103 	sub	sp, #4
                                   1104 ;	main.c: 330: I2C_DR = d_addr; // Отправка адреса устройства с битом на запись
      008850 55 01 04 52 16   [ 1] 1105 	mov	0x5216+0, _d_addr+0
                                   1106 ;	main.c: 331: uart_write("flag1\r");
      008855 AE 80 C9         [ 2] 1107 	ldw	x, #(___str_18+0)
      008858 CD 83 81         [ 4] 1108 	call	_uart_write
                                   1109 ;	main.c: 332: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
      00885B                       1110 00102$:
      00885B 72 02 52 17 0D   [ 2] 1111 	btjt	0x5217, #1, 00104$
      008860 72 04 52 18 08   [ 2] 1112 	btjt	0x5218, #2, 00104$
                                   1113 ;	main.c: 333: uart_write(".");
      008865 AE 80 D0         [ 2] 1114 	ldw	x, #(___str_19+0)
      008868 CD 83 81         [ 4] 1115 	call	_uart_write
      00886B 20 EE            [ 2] 1116 	jra	00102$
      00886D                       1117 00104$:
                                   1118 ;	main.c: 334: uart_write("flag2\r");
      00886D AE 80 D2         [ 2] 1119 	ldw	x, #(___str_20+0)
      008870 CD 83 81         [ 4] 1120 	call	_uart_write
                                   1121 ;	main.c: 335: for(int i = 0;i < d_size;i++)
      008873 5F               [ 1] 1122 	clrw	x
      008874 1F 03            [ 2] 1123 	ldw	(0x03, sp), x
      008876                       1124 00111$:
      008876 C6 01 06         [ 1] 1125 	ld	a, _d_size+0
      008879 6B 02            [ 1] 1126 	ld	(0x02, sp), a
      00887B 0F 01            [ 1] 1127 	clr	(0x01, sp)
      00887D 1E 03            [ 2] 1128 	ldw	x, (0x03, sp)
      00887F 13 01            [ 2] 1129 	cpw	x, (0x01, sp)
      008881 2E 2D            [ 1] 1130 	jrsge	00113$
                                   1131 ;	main.c: 337: uart_write("flag3\r");
      008883 AE 80 D9         [ 2] 1132 	ldw	x, #(___str_21+0)
      008886 CD 83 81         [ 4] 1133 	call	_uart_write
                                   1134 ;	main.c: 338: I2C_DR = data_buf[i];
      008889 1E 03            [ 2] 1135 	ldw	x, (0x03, sp)
      00888B D6 01 08         [ 1] 1136 	ld	a, (_data_buf+0, x)
      00888E C7 52 16         [ 1] 1137 	ld	0x5216, a
                                   1138 ;	main.c: 339: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
      008891                       1139 00106$:
      008891 72 02 52 17 0D   [ 2] 1140 	btjt	0x5217, #1, 00108$
      008896 72 04 52 18 08   [ 2] 1141 	btjt	0x5218, #2, 00108$
                                   1142 ;	main.c: 340: uart_write(".");
      00889B AE 80 D0         [ 2] 1143 	ldw	x, #(___str_19+0)
      00889E CD 83 81         [ 4] 1144 	call	_uart_write
      0088A1 20 EE            [ 2] 1145 	jra	00106$
      0088A3                       1146 00108$:
                                   1147 ;	main.c: 341: uart_write("flag4\r");
      0088A3 AE 80 E0         [ 2] 1148 	ldw	x, #(___str_22+0)
      0088A6 CD 83 81         [ 4] 1149 	call	_uart_write
                                   1150 ;	main.c: 335: for(int i = 0;i < d_size;i++)
      0088A9 1E 03            [ 2] 1151 	ldw	x, (0x03, sp)
      0088AB 5C               [ 1] 1152 	incw	x
      0088AC 1F 03            [ 2] 1153 	ldw	(0x03, sp), x
      0088AE 20 C6            [ 2] 1154 	jra	00111$
      0088B0                       1155 00113$:
                                   1156 ;	main.c: 343: }
      0088B0 5B 04            [ 2] 1157 	addw	sp, #4
      0088B2 81               [ 4] 1158 	ret
                                   1159 ;	main.c: 345: void i2c_read(void){
                                   1160 ;	-----------------------------------------
                                   1161 ;	 function i2c_read
                                   1162 ;	-----------------------------------------
      0088B3                       1163 _i2c_read:
      0088B3 52 04            [ 2] 1164 	sub	sp, #4
                                   1165 ;	main.c: 346: I2C_DR = (current_dev << 1) & (1 << 0);
      0088B5 C6 02 08         [ 1] 1166 	ld	a, _current_dev+0
      0088B8 48               [ 1] 1167 	sll	a
      0088B9 A4 01            [ 1] 1168 	and	a, #0x01
      0088BB C7 52 16         [ 1] 1169 	ld	0x5216, a
                                   1170 ;	main.c: 347: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
      0088BE                       1171 00102$:
      0088BE 72 02 52 17 0D   [ 2] 1172 	btjt	0x5217, #1, 00104$
      0088C3 72 04 52 18 08   [ 2] 1173 	btjt	0x5218, #2, 00104$
                                   1174 ;	main.c: 348: uart_write(".");
      0088C8 AE 80 D0         [ 2] 1175 	ldw	x, #(___str_19+0)
      0088CB CD 83 81         [ 4] 1176 	call	_uart_write
      0088CE 20 EE            [ 2] 1177 	jra	00102$
      0088D0                       1178 00104$:
                                   1179 ;	main.c: 349: uart_write("\r\n");
      0088D0 AE 80 E7         [ 2] 1180 	ldw	x, #(___str_23+0)
      0088D3 CD 83 81         [ 4] 1181 	call	_uart_write
                                   1182 ;	main.c: 350: I2C_DR = d_addr;
      0088D6 55 01 04 52 16   [ 1] 1183 	mov	0x5216+0, _d_addr+0
                                   1184 ;	main.c: 351: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
      0088DB                       1185 00106$:
      0088DB 72 02 52 17 0D   [ 2] 1186 	btjt	0x5217, #1, 00108$
      0088E0 72 04 52 18 08   [ 2] 1187 	btjt	0x5218, #2, 00108$
                                   1188 ;	main.c: 352: uart_write(".");
      0088E5 AE 80 D0         [ 2] 1189 	ldw	x, #(___str_19+0)
      0088E8 CD 83 81         [ 4] 1190 	call	_uart_write
      0088EB 20 EE            [ 2] 1191 	jra	00106$
      0088ED                       1192 00108$:
                                   1193 ;	main.c: 353: uart_write("\r\n");
      0088ED AE 80 E7         [ 2] 1194 	ldw	x, #(___str_23+0)
      0088F0 CD 83 81         [ 4] 1195 	call	_uart_write
                                   1196 ;	main.c: 354: i2c_stop();
      0088F3 CD 88 49         [ 4] 1197 	call	_i2c_stop
                                   1198 ;	main.c: 355: for(int i = 0;i < d_size;i++)
      0088F6 5F               [ 1] 1199 	clrw	x
      0088F7 1F 03            [ 2] 1200 	ldw	(0x03, sp), x
      0088F9                       1201 00115$:
      0088F9 C6 01 06         [ 1] 1202 	ld	a, _d_size+0
      0088FC 6B 02            [ 1] 1203 	ld	(0x02, sp), a
      0088FE 0F 01            [ 1] 1204 	clr	(0x01, sp)
      008900 1E 03            [ 2] 1205 	ldw	x, (0x03, sp)
      008902 13 01            [ 2] 1206 	cpw	x, (0x01, sp)
      008904 2E 27            [ 1] 1207 	jrsge	00117$
                                   1208 ;	main.c: 357: data_buf[i] = I2C_DR;
      008906 1E 03            [ 2] 1209 	ldw	x, (0x03, sp)
      008908 C6 52 16         [ 1] 1210 	ld	a, 0x5216
      00890B D7 01 08         [ 1] 1211 	ld	((_data_buf+0), x), a
                                   1212 ;	main.c: 358: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)))
      00890E                       1213 00110$:
      00890E 72 02 52 17 0D   [ 2] 1214 	btjt	0x5217, #1, 00112$
      008913 72 04 52 18 08   [ 2] 1215 	btjt	0x5218, #2, 00112$
                                   1216 ;	main.c: 359: uart_write(".");
      008918 AE 80 D0         [ 2] 1217 	ldw	x, #(___str_19+0)
      00891B CD 83 81         [ 4] 1218 	call	_uart_write
      00891E 20 EE            [ 2] 1219 	jra	00110$
      008920                       1220 00112$:
                                   1221 ;	main.c: 360: uart_write("\r\n");
      008920 AE 80 E7         [ 2] 1222 	ldw	x, #(___str_23+0)
      008923 CD 83 81         [ 4] 1223 	call	_uart_write
                                   1224 ;	main.c: 355: for(int i = 0;i < d_size;i++)
      008926 1E 03            [ 2] 1225 	ldw	x, (0x03, sp)
      008928 5C               [ 1] 1226 	incw	x
      008929 1F 03            [ 2] 1227 	ldw	(0x03, sp), x
      00892B 20 CC            [ 2] 1228 	jra	00115$
      00892D                       1229 00117$:
                                   1230 ;	main.c: 363: }
      00892D 5B 04            [ 2] 1231 	addw	sp, #4
      00892F 81               [ 4] 1232 	ret
                                   1233 ;	main.c: 364: void i2c_scan(void) {
                                   1234 ;	-----------------------------------------
                                   1235 ;	 function i2c_scan
                                   1236 ;	-----------------------------------------
      008930                       1237 _i2c_scan:
      008930 52 02            [ 2] 1238 	sub	sp, #2
                                   1239 ;	main.c: 365: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008932 C6 02 08         [ 1] 1240 	ld	a, _current_dev+0
      008935 6B 01            [ 1] 1241 	ld	(0x01, sp), a
      008937 6B 02            [ 1] 1242 	ld	(0x02, sp), a
      008939                       1243 00105$:
      008939 7B 02            [ 1] 1244 	ld	a, (0x02, sp)
      00893B A1 7F            [ 1] 1245 	cp	a, #0x7f
      00893D 24 26            [ 1] 1246 	jrnc	00107$
                                   1247 ;	main.c: 366: i2c_start();
      00893F CD 88 2F         [ 4] 1248 	call	_i2c_start
                                   1249 ;	main.c: 367: i2c_send_address(addr);
      008942 7B 02            [ 1] 1250 	ld	a, (0x02, sp)
      008944 CD 88 39         [ 4] 1251 	call	_i2c_send_address
                                   1252 ;	main.c: 368: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      008947 72 04 52 18 0A   [ 2] 1253 	btjt	0x5218, #2, 00102$
                                   1254 ;	main.c: 370: current_dev = addr;
      00894C 7B 01            [ 1] 1255 	ld	a, (0x01, sp)
      00894E C7 02 08         [ 1] 1256 	ld	_current_dev+0, a
                                   1257 ;	main.c: 371: i2c_stop();
      008951 5B 02            [ 2] 1258 	addw	sp, #2
                                   1259 ;	main.c: 372: break;
      008953 CC 88 49         [ 2] 1260 	jp	_i2c_stop
      008956                       1261 00102$:
                                   1262 ;	main.c: 374: i2c_stop();
      008956 CD 88 49         [ 4] 1263 	call	_i2c_stop
                                   1264 ;	main.c: 375: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      008959 72 15 52 18      [ 1] 1265 	bres	0x5218, #2
                                   1266 ;	main.c: 365: for (uint8_t addr = current_dev; addr < 127; addr++) {
      00895D 0C 02            [ 1] 1267 	inc	(0x02, sp)
      00895F 7B 02            [ 1] 1268 	ld	a, (0x02, sp)
      008961 6B 01            [ 1] 1269 	ld	(0x01, sp), a
      008963 20 D4            [ 2] 1270 	jra	00105$
      008965                       1271 00107$:
                                   1272 ;	main.c: 377: }
      008965 5B 02            [ 2] 1273 	addw	sp, #2
      008967 81               [ 4] 1274 	ret
                                   1275 ;	main.c: 387: void cm_SM(void)
                                   1276 ;	-----------------------------------------
                                   1277 ;	 function cm_SM
                                   1278 ;	-----------------------------------------
      008968                       1279 _cm_SM:
      008968 52 04            [ 2] 1280 	sub	sp, #4
                                   1281 ;	main.c: 389: char cur_dev[4]={0};
      00896A 0F 01            [ 1] 1282 	clr	(0x01, sp)
      00896C 0F 02            [ 1] 1283 	clr	(0x02, sp)
      00896E 0F 03            [ 1] 1284 	clr	(0x03, sp)
      008970 0F 04            [ 1] 1285 	clr	(0x04, sp)
                                   1286 ;	main.c: 390: convert_int_to_chars(current_dev, cur_dev);
      008972 96               [ 1] 1287 	ldw	x, sp
      008973 5C               [ 1] 1288 	incw	x
      008974 C6 02 08         [ 1] 1289 	ld	a, _current_dev+0
      008977 CD 83 E2         [ 4] 1290 	call	_convert_int_to_chars
                                   1291 ;	main.c: 391: uart_write("SM ");
      00897A AE 80 EA         [ 2] 1292 	ldw	x, #(___str_24+0)
      00897D CD 83 81         [ 4] 1293 	call	_uart_write
                                   1294 ;	main.c: 392: uart_write(cur_dev);
      008980 96               [ 1] 1295 	ldw	x, sp
      008981 5C               [ 1] 1296 	incw	x
      008982 CD 83 81         [ 4] 1297 	call	_uart_write
                                   1298 ;	main.c: 393: uart_write("\r\n");
      008985 AE 80 E7         [ 2] 1299 	ldw	x, #(___str_23+0)
      008988 CD 83 81         [ 4] 1300 	call	_uart_write
                                   1301 ;	main.c: 394: }
      00898B 5B 04            [ 2] 1302 	addw	sp, #4
      00898D 81               [ 4] 1303 	ret
                                   1304 ;	main.c: 395: void cm_SN(void)
                                   1305 ;	-----------------------------------------
                                   1306 ;	 function cm_SN
                                   1307 ;	-----------------------------------------
      00898E                       1308 _cm_SN:
                                   1309 ;	main.c: 397: i2c_scan();
      00898E CD 89 30         [ 4] 1310 	call	_i2c_scan
                                   1311 ;	main.c: 398: cm_SM();
                                   1312 ;	main.c: 399: }
      008991 CC 89 68         [ 2] 1313 	jp	_cm_SM
                                   1314 ;	main.c: 400: void cm_RM(void)
                                   1315 ;	-----------------------------------------
                                   1316 ;	 function cm_RM
                                   1317 ;	-----------------------------------------
      008994                       1318 _cm_RM:
                                   1319 ;	main.c: 402: current_dev = 0;
      008994 72 5F 02 08      [ 1] 1320 	clr	_current_dev+0
                                   1321 ;	main.c: 403: uart_write("RM\n");
      008998 AE 80 EE         [ 2] 1322 	ldw	x, #(___str_25+0)
                                   1323 ;	main.c: 404: }
      00899B CC 83 81         [ 2] 1324 	jp	_uart_write
                                   1325 ;	main.c: 406: void cm_DB(void)
                                   1326 ;	-----------------------------------------
                                   1327 ;	 function cm_DB
                                   1328 ;	-----------------------------------------
      00899E                       1329 _cm_DB:
                                   1330 ;	main.c: 408: status_check();
                                   1331 ;	main.c: 409: }
      00899E CC 85 D0         [ 2] 1332 	jp	_status_check
                                   1333 ;	main.c: 411: void cm_ST(void)
                                   1334 ;	-----------------------------------------
                                   1335 ;	 function cm_ST
                                   1336 ;	-----------------------------------------
      0089A1                       1337 _cm_ST:
                                   1338 ;	main.c: 413: get_addr_from_buff();
      0089A1 CD 84 C6         [ 4] 1339 	call	_get_addr_from_buff
                                   1340 ;	main.c: 414: current_dev = d_addr;
      0089A4 55 01 04 02 08   [ 1] 1341 	mov	_current_dev+0, _d_addr+0
                                   1342 ;	main.c: 415: uart_write("ST\n");
      0089A9 AE 80 F2         [ 2] 1343 	ldw	x, #(___str_26+0)
                                   1344 ;	main.c: 416: }
      0089AC CC 83 81         [ 2] 1345 	jp	_uart_write
                                   1346 ;	main.c: 417: void cm_SR(void)
                                   1347 ;	-----------------------------------------
                                   1348 ;	 function cm_SR
                                   1349 ;	-----------------------------------------
      0089AF                       1350 _cm_SR:
                                   1351 ;	main.c: 419: i2c_start();
      0089AF CD 88 2F         [ 4] 1352 	call	_i2c_start
                                   1353 ;	main.c: 420: i2c_send_address(current_dev);
      0089B2 C6 02 08         [ 1] 1354 	ld	a, _current_dev+0
      0089B5 CD 88 39         [ 4] 1355 	call	_i2c_send_address
                                   1356 ;	main.c: 421: i2c_read();
      0089B8 CD 88 B3         [ 4] 1357 	call	_i2c_read
                                   1358 ;	main.c: 422: i2c_stop();
                                   1359 ;	main.c: 423: }
      0089BB CC 88 49         [ 2] 1360 	jp	_i2c_stop
                                   1361 ;	main.c: 424: void cm_SW(void)
                                   1362 ;	-----------------------------------------
                                   1363 ;	 function cm_SW
                                   1364 ;	-----------------------------------------
      0089BE                       1365 _cm_SW:
      0089BE 52 04            [ 2] 1366 	sub	sp, #4
                                   1367 ;	main.c: 426: char ar[4]={0};
      0089C0 0F 01            [ 1] 1368 	clr	(0x01, sp)
      0089C2 0F 02            [ 1] 1369 	clr	(0x02, sp)
      0089C4 0F 03            [ 1] 1370 	clr	(0x03, sp)
      0089C6 0F 04            [ 1] 1371 	clr	(0x04, sp)
                                   1372 ;	main.c: 427: uart_write("f1");
      0089C8 AE 80 F6         [ 2] 1373 	ldw	x, #(___str_27+0)
      0089CB CD 83 81         [ 4] 1374 	call	_uart_write
                                   1375 ;	main.c: 428: i2c_start();
      0089CE CD 88 2F         [ 4] 1376 	call	_i2c_start
                                   1377 ;	main.c: 429: uart_write("f2");
      0089D1 AE 80 F9         [ 2] 1378 	ldw	x, #(___str_28+0)
      0089D4 CD 83 81         [ 4] 1379 	call	_uart_write
                                   1380 ;	main.c: 430: i2c_send_address(current_dev);
      0089D7 C6 02 08         [ 1] 1381 	ld	a, _current_dev+0
      0089DA CD 88 39         [ 4] 1382 	call	_i2c_send_address
                                   1383 ;	main.c: 431: uart_write("f3");
      0089DD AE 80 FC         [ 2] 1384 	ldw	x, #(___str_29+0)
      0089E0 CD 83 81         [ 4] 1385 	call	_uart_write
                                   1386 ;	main.c: 432: i2c_write();
      0089E3 CD 88 4E         [ 4] 1387 	call	_i2c_write
                                   1388 ;	main.c: 433: uart_write("f4");
      0089E6 AE 80 FF         [ 2] 1389 	ldw	x, #(___str_30+0)
      0089E9 CD 83 81         [ 4] 1390 	call	_uart_write
                                   1391 ;	main.c: 434: i2c_stop();
      0089EC CD 88 49         [ 4] 1392 	call	_i2c_stop
                                   1393 ;	main.c: 435: uart_write("f5");
      0089EF AE 81 02         [ 2] 1394 	ldw	x, #(___str_31+0)
      0089F2 CD 83 81         [ 4] 1395 	call	_uart_write
                                   1396 ;	main.c: 436: uart_write("SW ");
      0089F5 AE 81 05         [ 2] 1397 	ldw	x, #(___str_32+0)
      0089F8 CD 83 81         [ 4] 1398 	call	_uart_write
                                   1399 ;	main.c: 437: convert_int_to_chars(d_addr, ar);
      0089FB 96               [ 1] 1400 	ldw	x, sp
      0089FC 5C               [ 1] 1401 	incw	x
      0089FD C6 01 04         [ 1] 1402 	ld	a, _d_addr+0
      008A00 CD 83 E2         [ 4] 1403 	call	_convert_int_to_chars
                                   1404 ;	main.c: 438: uart_write(ar);
      008A03 96               [ 1] 1405 	ldw	x, sp
      008A04 5C               [ 1] 1406 	incw	x
      008A05 CD 83 81         [ 4] 1407 	call	_uart_write
                                   1408 ;	main.c: 439: uart_write(" ");
      008A08 AE 81 09         [ 2] 1409 	ldw	x, #(___str_33+0)
      008A0B CD 83 81         [ 4] 1410 	call	_uart_write
                                   1411 ;	main.c: 440: convert_int_to_chars(d_size, ar);
      008A0E 96               [ 1] 1412 	ldw	x, sp
      008A0F 5C               [ 1] 1413 	incw	x
      008A10 C6 01 06         [ 1] 1414 	ld	a, _d_size+0
      008A13 CD 83 E2         [ 4] 1415 	call	_convert_int_to_chars
                                   1416 ;	main.c: 441: uart_write(ar);
      008A16 96               [ 1] 1417 	ldw	x, sp
      008A17 5C               [ 1] 1418 	incw	x
      008A18 CD 83 81         [ 4] 1419 	call	_uart_write
                                   1420 ;	main.c: 442: uart_write("\r\n");
      008A1B AE 80 E7         [ 2] 1421 	ldw	x, #(___str_23+0)
      008A1E CD 83 81         [ 4] 1422 	call	_uart_write
                                   1423 ;	main.c: 443: }
      008A21 5B 04            [ 2] 1424 	addw	sp, #4
      008A23 81               [ 4] 1425 	ret
                                   1426 ;	main.c: 451: int data_handler(void)
                                   1427 ;	-----------------------------------------
                                   1428 ;	 function data_handler
                                   1429 ;	-----------------------------------------
      008A24                       1430 _data_handler:
                                   1431 ;	main.c: 453: p_size = 0;
      008A24 72 5F 01 05      [ 1] 1432 	clr	_p_size+0
                                   1433 ;	main.c: 454: p_bytes = 0;
      008A28 72 5F 01 07      [ 1] 1434 	clr	_p_bytes+0
                                   1435 ;	main.c: 455: d_addr = 0;
      008A2C 72 5F 01 04      [ 1] 1436 	clr	_d_addr+0
                                   1437 ;	main.c: 456: d_size = 0;
      008A30 72 5F 01 06      [ 1] 1438 	clr	_d_size+0
                                   1439 ;	main.c: 457: memset(data_buf, 0, sizeof(data_buf));
      008A34 4B 00            [ 1] 1440 	push	#0x00
      008A36 4B 01            [ 1] 1441 	push	#0x01
      008A38 5F               [ 1] 1442 	clrw	x
      008A39 89               [ 2] 1443 	pushw	x
      008A3A AE 01 08         [ 2] 1444 	ldw	x, #(_data_buf+0)
      008A3D CD 8B FA         [ 4] 1445 	call	_memset
                                   1446 ;	main.c: 458: if(memcmp(&buffer[0],"SM",2) == 0)
      008A40 4B 02            [ 1] 1447 	push	#0x02
      008A42 4B 00            [ 1] 1448 	push	#0x00
      008A44 4B 0B            [ 1] 1449 	push	#<(___str_34+0)
      008A46 4B 81            [ 1] 1450 	push	#((___str_34+0) >> 8)
      008A48 AE 00 01         [ 2] 1451 	ldw	x, #(_buffer+0)
      008A4B CD 8B 64         [ 4] 1452 	call	_memcmp
                                   1453 ;	main.c: 459: return 1;
      008A4E 5D               [ 2] 1454 	tnzw	x
      008A4F 26 02            [ 1] 1455 	jrne	00102$
      008A51 5C               [ 1] 1456 	incw	x
      008A52 81               [ 4] 1457 	ret
      008A53                       1458 00102$:
                                   1459 ;	main.c: 460: if(memcmp(&buffer[0],"SN",2) == 0)
      008A53 4B 02            [ 1] 1460 	push	#0x02
      008A55 4B 00            [ 1] 1461 	push	#0x00
      008A57 4B 0E            [ 1] 1462 	push	#<(___str_35+0)
      008A59 4B 81            [ 1] 1463 	push	#((___str_35+0) >> 8)
      008A5B AE 00 01         [ 2] 1464 	ldw	x, #(_buffer+0)
      008A5E CD 8B 64         [ 4] 1465 	call	_memcmp
      008A61 5D               [ 2] 1466 	tnzw	x
      008A62 26 04            [ 1] 1467 	jrne	00104$
                                   1468 ;	main.c: 461: return 2;
      008A64 AE 00 02         [ 2] 1469 	ldw	x, #0x0002
      008A67 81               [ 4] 1470 	ret
      008A68                       1471 00104$:
                                   1472 ;	main.c: 462: if(memcmp(&buffer[0],"ST",2) == 0)
      008A68 4B 02            [ 1] 1473 	push	#0x02
      008A6A 4B 00            [ 1] 1474 	push	#0x00
      008A6C 4B 11            [ 1] 1475 	push	#<(___str_36+0)
      008A6E 4B 81            [ 1] 1476 	push	#((___str_36+0) >> 8)
      008A70 AE 00 01         [ 2] 1477 	ldw	x, #(_buffer+0)
      008A73 CD 8B 64         [ 4] 1478 	call	_memcmp
      008A76 5D               [ 2] 1479 	tnzw	x
      008A77 26 04            [ 1] 1480 	jrne	00106$
                                   1481 ;	main.c: 463: return 5;
      008A79 AE 00 05         [ 2] 1482 	ldw	x, #0x0005
      008A7C 81               [ 4] 1483 	ret
      008A7D                       1484 00106$:
                                   1485 ;	main.c: 464: if(memcmp(&buffer[0],"RM",2) == 0)
      008A7D 4B 02            [ 1] 1486 	push	#0x02
      008A7F 4B 00            [ 1] 1487 	push	#0x00
      008A81 4B 14            [ 1] 1488 	push	#<(___str_37+0)
      008A83 4B 81            [ 1] 1489 	push	#((___str_37+0) >> 8)
      008A85 AE 00 01         [ 2] 1490 	ldw	x, #(_buffer+0)
      008A88 CD 8B 64         [ 4] 1491 	call	_memcmp
      008A8B 5D               [ 2] 1492 	tnzw	x
      008A8C 26 04            [ 1] 1493 	jrne	00108$
                                   1494 ;	main.c: 465: return 6;
      008A8E AE 00 06         [ 2] 1495 	ldw	x, #0x0006
      008A91 81               [ 4] 1496 	ret
      008A92                       1497 00108$:
                                   1498 ;	main.c: 466: if(memcmp(&buffer[0],"DB",2) == 0)
      008A92 4B 02            [ 1] 1499 	push	#0x02
      008A94 4B 00            [ 1] 1500 	push	#0x00
      008A96 4B 17            [ 1] 1501 	push	#<(___str_38+0)
      008A98 4B 81            [ 1] 1502 	push	#((___str_38+0) >> 8)
      008A9A AE 00 01         [ 2] 1503 	ldw	x, #(_buffer+0)
      008A9D CD 8B 64         [ 4] 1504 	call	_memcmp
      008AA0 5D               [ 2] 1505 	tnzw	x
      008AA1 26 04            [ 1] 1506 	jrne	00110$
                                   1507 ;	main.c: 467: return 7;
      008AA3 AE 00 07         [ 2] 1508 	ldw	x, #0x0007
      008AA6 81               [ 4] 1509 	ret
      008AA7                       1510 00110$:
                                   1511 ;	main.c: 469: get_addr_from_buff();
      008AA7 CD 84 C6         [ 4] 1512 	call	_get_addr_from_buff
                                   1513 ;	main.c: 470: get_size_from_buff();
      008AAA CD 85 07         [ 4] 1514 	call	_get_size_from_buff
                                   1515 ;	main.c: 472: if(memcmp(&buffer[0],"SR",2) == 0)
      008AAD 4B 02            [ 1] 1516 	push	#0x02
      008AAF 4B 00            [ 1] 1517 	push	#0x00
      008AB1 4B 1A            [ 1] 1518 	push	#<(___str_39+0)
      008AB3 4B 81            [ 1] 1519 	push	#((___str_39+0) >> 8)
      008AB5 AE 00 01         [ 2] 1520 	ldw	x, #(_buffer+0)
      008AB8 CD 8B 64         [ 4] 1521 	call	_memcmp
      008ABB 5D               [ 2] 1522 	tnzw	x
      008ABC 26 04            [ 1] 1523 	jrne	00112$
                                   1524 ;	main.c: 473: return 3;
      008ABE AE 00 03         [ 2] 1525 	ldw	x, #0x0003
      008AC1 81               [ 4] 1526 	ret
      008AC2                       1527 00112$:
                                   1528 ;	main.c: 475: char_buffer_to_int();
      008AC2 CD 85 4C         [ 4] 1529 	call	_char_buffer_to_int
                                   1530 ;	main.c: 477: if(memcmp(&buffer[0],"SW",2) == 0)
      008AC5 4B 02            [ 1] 1531 	push	#0x02
      008AC7 4B 00            [ 1] 1532 	push	#0x00
      008AC9 4B 1D            [ 1] 1533 	push	#<(___str_40+0)
      008ACB 4B 81            [ 1] 1534 	push	#((___str_40+0) >> 8)
      008ACD AE 00 01         [ 2] 1535 	ldw	x, #(_buffer+0)
      008AD0 CD 8B 64         [ 4] 1536 	call	_memcmp
      008AD3 5D               [ 2] 1537 	tnzw	x
      008AD4 26 04            [ 1] 1538 	jrne	00114$
                                   1539 ;	main.c: 478: return 4;
      008AD6 AE 00 04         [ 2] 1540 	ldw	x, #0x0004
      008AD9 81               [ 4] 1541 	ret
      008ADA                       1542 00114$:
                                   1543 ;	main.c: 479: return 0;
      008ADA 5F               [ 1] 1544 	clrw	x
                                   1545 ;	main.c: 481: }
      008ADB 81               [ 4] 1546 	ret
                                   1547 ;	main.c: 483: void command_switcher(void)
                                   1548 ;	-----------------------------------------
                                   1549 ;	 function command_switcher
                                   1550 ;	-----------------------------------------
      008ADC                       1551 _command_switcher:
      008ADC 52 06            [ 2] 1552 	sub	sp, #6
                                   1553 ;	main.c: 485: char ar[4]={0};
      008ADE 0F 01            [ 1] 1554 	clr	(0x01, sp)
      008AE0 0F 02            [ 1] 1555 	clr	(0x02, sp)
      008AE2 0F 03            [ 1] 1556 	clr	(0x03, sp)
      008AE4 0F 04            [ 1] 1557 	clr	(0x04, sp)
                                   1558 ;	main.c: 487: int af = data_handler();
      008AE6 CD 8A 24         [ 4] 1559 	call	_data_handler
      008AE9 1F 05            [ 2] 1560 	ldw	(0x05, sp), x
                                   1561 ;	main.c: 488: convert_int_to_chars(af, ar);
      008AEB 96               [ 1] 1562 	ldw	x, sp
      008AEC 5C               [ 1] 1563 	incw	x
      008AED 7B 06            [ 1] 1564 	ld	a, (0x06, sp)
      008AEF CD 83 E2         [ 4] 1565 	call	_convert_int_to_chars
                                   1566 ;	main.c: 489: uart_write("preswitch\n");
      008AF2 AE 81 20         [ 2] 1567 	ldw	x, #(___str_41+0)
      008AF5 CD 83 81         [ 4] 1568 	call	_uart_write
                                   1569 ;	main.c: 490: uart_write(ar);
      008AF8 96               [ 1] 1570 	ldw	x, sp
      008AF9 5C               [ 1] 1571 	incw	x
      008AFA CD 83 81         [ 4] 1572 	call	_uart_write
                                   1573 ;	main.c: 491: uart_write("\n");
      008AFD AE 81 2B         [ 2] 1574 	ldw	x, #(___str_42+0)
      008B00 CD 83 81         [ 4] 1575 	call	_uart_write
                                   1576 ;	main.c: 492: switch(af)
      008B03 0D 05            [ 1] 1577 	tnz	(0x05, sp)
      008B05 2B 45            [ 1] 1578 	jrmi	00109$
      008B07 1E 05            [ 2] 1579 	ldw	x, (0x05, sp)
      008B09 A3 00 07         [ 2] 1580 	cpw	x, #0x0007
      008B0C 2C 3E            [ 1] 1581 	jrsgt	00109$
      008B0E 1E 05            [ 2] 1582 	ldw	x, (0x05, sp)
      008B10 58               [ 2] 1583 	sllw	x
      008B11 DE 8B 15         [ 2] 1584 	ldw	x, (#00123$, x)
      008B14 FC               [ 2] 1585 	jp	(x)
      008B15                       1586 00123$:
      008B15 8B 4C                 1587 	.dw	#00109$
      008B17 8B 25                 1588 	.dw	#00101$
      008B19 8B 2A                 1589 	.dw	#00102$
      008B1B 8B 2F                 1590 	.dw	#00103$
      008B1D 8B 34                 1591 	.dw	#00104$
      008B1F 8B 3F                 1592 	.dw	#00105$
      008B21 8B 44                 1593 	.dw	#00106$
      008B23 8B 49                 1594 	.dw	#00107$
                                   1595 ;	main.c: 494: case 1:
      008B25                       1596 00101$:
                                   1597 ;	main.c: 495: cm_SM();
      008B25 CD 89 68         [ 4] 1598 	call	_cm_SM
                                   1599 ;	main.c: 496: break;
      008B28 20 22            [ 2] 1600 	jra	00109$
                                   1601 ;	main.c: 497: case 2:
      008B2A                       1602 00102$:
                                   1603 ;	main.c: 498: cm_SN();
      008B2A CD 89 8E         [ 4] 1604 	call	_cm_SN
                                   1605 ;	main.c: 499: break;
      008B2D 20 1D            [ 2] 1606 	jra	00109$
                                   1607 ;	main.c: 500: case 3:
      008B2F                       1608 00103$:
                                   1609 ;	main.c: 501: cm_SR();
      008B2F CD 89 AF         [ 4] 1610 	call	_cm_SR
                                   1611 ;	main.c: 502: break;
      008B32 20 18            [ 2] 1612 	jra	00109$
                                   1613 ;	main.c: 503: case 4:
      008B34                       1614 00104$:
                                   1615 ;	main.c: 504: uart_write("switch\n");
      008B34 AE 81 2D         [ 2] 1616 	ldw	x, #(___str_43+0)
      008B37 CD 83 81         [ 4] 1617 	call	_uart_write
                                   1618 ;	main.c: 505: cm_SW();
      008B3A CD 89 BE         [ 4] 1619 	call	_cm_SW
                                   1620 ;	main.c: 506: break;
      008B3D 20 0D            [ 2] 1621 	jra	00109$
                                   1622 ;	main.c: 507: case 5:
      008B3F                       1623 00105$:
                                   1624 ;	main.c: 508: cm_ST();
      008B3F CD 89 A1         [ 4] 1625 	call	_cm_ST
                                   1626 ;	main.c: 509: break;
      008B42 20 08            [ 2] 1627 	jra	00109$
                                   1628 ;	main.c: 510: case 6:
      008B44                       1629 00106$:
                                   1630 ;	main.c: 511: cm_RM();
      008B44 CD 89 94         [ 4] 1631 	call	_cm_RM
                                   1632 ;	main.c: 512: break;
      008B47 20 03            [ 2] 1633 	jra	00109$
                                   1634 ;	main.c: 513: case 7:
      008B49                       1635 00107$:
                                   1636 ;	main.c: 514: cm_DB();
      008B49 CD 89 9E         [ 4] 1637 	call	_cm_DB
                                   1638 ;	main.c: 516: }
      008B4C                       1639 00109$:
                                   1640 ;	main.c: 517: }
      008B4C 5B 06            [ 2] 1641 	addw	sp, #6
      008B4E 81               [ 4] 1642 	ret
                                   1643 ;	main.c: 520: void main(void)
                                   1644 ;	-----------------------------------------
                                   1645 ;	 function main
                                   1646 ;	-----------------------------------------
      008B4F                       1647 _main:
                                   1648 ;	main.c: 522: uart_init();
      008B4F CD 87 F1         [ 4] 1649 	call	_uart_init
                                   1650 ;	main.c: 523: i2c_init();
      008B52 CD 88 0E         [ 4] 1651 	call	_i2c_init
                                   1652 ;	main.c: 524: uart_write("SS\n");
      008B55 AE 81 35         [ 2] 1653 	ldw	x, #(___str_44+0)
      008B58 CD 83 81         [ 4] 1654 	call	_uart_write
                                   1655 ;	main.c: 525: while(1)
      008B5B                       1656 00102$:
                                   1657 ;	main.c: 527: uart_read();
      008B5B CD 83 AC         [ 4] 1658 	call	_uart_read
                                   1659 ;	main.c: 528: command_switcher();
      008B5E CD 8A DC         [ 4] 1660 	call	_command_switcher
      008B61 20 F8            [ 2] 1661 	jra	00102$
                                   1662 ;	main.c: 530: }
      008B63 81               [ 4] 1663 	ret
                                   1664 	.area CODE
                                   1665 	.area CONST
                                   1666 	.area CONST
      00802D                       1667 ___str_0:
      00802D 77 68 69 6C 65        1668 	.ascii "while"
      008032 00                    1669 	.db 0x00
                                   1670 	.area CODE
                                   1671 	.area CONST
      008033                       1672 ___str_1:
      008033 0A                    1673 	.db 0x0a
      008034 49 32 43 5F 52 45 47  1674 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      008040 0A                    1675 	.db 0x0a
      008041 00                    1676 	.db 0x00
                                   1677 	.area CODE
                                   1678 	.area CONST
      008042                       1679 ___str_2:
      008042 0A                    1680 	.db 0x0a
      008043 53 52 31 20 2D 3E 20  1681 	.ascii "SR1 -> "
      00804A 00                    1682 	.db 0x00
                                   1683 	.area CODE
                                   1684 	.area CONST
      00804B                       1685 ___str_3:
      00804B 20 3C 2D              1686 	.ascii " <-"
      00804E 0A                    1687 	.db 0x0a
      00804F 00                    1688 	.db 0x00
                                   1689 	.area CODE
                                   1690 	.area CONST
      008050                       1691 ___str_4:
      008050 53 52 32 20 2D 3E 20  1692 	.ascii "SR2 -> "
      008057 00                    1693 	.db 0x00
                                   1694 	.area CODE
                                   1695 	.area CONST
      008058                       1696 ___str_5:
      008058 53 52 33 20 2D 3E 20  1697 	.ascii "SR3 -> "
      00805F 00                    1698 	.db 0x00
                                   1699 	.area CODE
                                   1700 	.area CONST
      008060                       1701 ___str_6:
      008060 43 52 31 20 2D 3E 20  1702 	.ascii "CR1 -> "
      008067 00                    1703 	.db 0x00
                                   1704 	.area CODE
                                   1705 	.area CONST
      008068                       1706 ___str_7:
      008068 43 52 32 20 2D 3E 20  1707 	.ascii "CR2 -> "
      00806F 00                    1708 	.db 0x00
                                   1709 	.area CODE
                                   1710 	.area CONST
      008070                       1711 ___str_8:
      008070 44 52 20 2D 3E 20     1712 	.ascii "DR -> "
      008076 00                    1713 	.db 0x00
                                   1714 	.area CODE
                                   1715 	.area CONST
      008077                       1716 ___str_9:
      008077 55 41 52 54 5F 52 45  1717 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      008084 0A                    1718 	.db 0x0a
      008085 00                    1719 	.db 0x00
                                   1720 	.area CODE
                                   1721 	.area CONST
      008086                       1722 ___str_10:
      008086 0A                    1723 	.db 0x0a
      008087 53 52 20 2D 3E 20     1724 	.ascii "SR -> "
      00808D 00                    1725 	.db 0x00
                                   1726 	.area CODE
                                   1727 	.area CONST
      00808E                       1728 ___str_11:
      00808E 42 52 52 31 20 2D 3E  1729 	.ascii "BRR1 -> "
             20
      008096 00                    1730 	.db 0x00
                                   1731 	.area CODE
                                   1732 	.area CONST
      008097                       1733 ___str_12:
      008097 42 52 52 32 20 2D 3E  1734 	.ascii "BRR2 -> "
             20
      00809F 00                    1735 	.db 0x00
                                   1736 	.area CODE
                                   1737 	.area CONST
      0080A0                       1738 ___str_13:
      0080A0 43 52 33 20 2D 3E 20  1739 	.ascii "CR3 -> "
      0080A7 00                    1740 	.db 0x00
                                   1741 	.area CODE
                                   1742 	.area CONST
      0080A8                       1743 ___str_14:
      0080A8 43 52 34 20 2D 3E 20  1744 	.ascii "CR4 -> "
      0080AF 00                    1745 	.db 0x00
                                   1746 	.area CODE
                                   1747 	.area CONST
      0080B0                       1748 ___str_15:
      0080B0 43 52 35 20 2D 3E 20  1749 	.ascii "CR5 -> "
      0080B7 00                    1750 	.db 0x00
                                   1751 	.area CODE
                                   1752 	.area CONST
      0080B8                       1753 ___str_16:
      0080B8 47 54 52 20 2D 3E 20  1754 	.ascii "GTR -> "
      0080BF 00                    1755 	.db 0x00
                                   1756 	.area CODE
                                   1757 	.area CONST
      0080C0                       1758 ___str_17:
      0080C0 50 53 43 52 20 2D 3E  1759 	.ascii "PSCR -> "
             20
      0080C8 00                    1760 	.db 0x00
                                   1761 	.area CODE
                                   1762 	.area CONST
      0080C9                       1763 ___str_18:
      0080C9 66 6C 61 67 31        1764 	.ascii "flag1"
      0080CE 0D                    1765 	.db 0x0d
      0080CF 00                    1766 	.db 0x00
                                   1767 	.area CODE
                                   1768 	.area CONST
      0080D0                       1769 ___str_19:
      0080D0 2E                    1770 	.ascii "."
      0080D1 00                    1771 	.db 0x00
                                   1772 	.area CODE
                                   1773 	.area CONST
      0080D2                       1774 ___str_20:
      0080D2 66 6C 61 67 32        1775 	.ascii "flag2"
      0080D7 0D                    1776 	.db 0x0d
      0080D8 00                    1777 	.db 0x00
                                   1778 	.area CODE
                                   1779 	.area CONST
      0080D9                       1780 ___str_21:
      0080D9 66 6C 61 67 33        1781 	.ascii "flag3"
      0080DE 0D                    1782 	.db 0x0d
      0080DF 00                    1783 	.db 0x00
                                   1784 	.area CODE
                                   1785 	.area CONST
      0080E0                       1786 ___str_22:
      0080E0 66 6C 61 67 34        1787 	.ascii "flag4"
      0080E5 0D                    1788 	.db 0x0d
      0080E6 00                    1789 	.db 0x00
                                   1790 	.area CODE
                                   1791 	.area CONST
      0080E7                       1792 ___str_23:
      0080E7 0D                    1793 	.db 0x0d
      0080E8 0A                    1794 	.db 0x0a
      0080E9 00                    1795 	.db 0x00
                                   1796 	.area CODE
                                   1797 	.area CONST
      0080EA                       1798 ___str_24:
      0080EA 53 4D 20              1799 	.ascii "SM "
      0080ED 00                    1800 	.db 0x00
                                   1801 	.area CODE
                                   1802 	.area CONST
      0080EE                       1803 ___str_25:
      0080EE 52 4D                 1804 	.ascii "RM"
      0080F0 0A                    1805 	.db 0x0a
      0080F1 00                    1806 	.db 0x00
                                   1807 	.area CODE
                                   1808 	.area CONST
      0080F2                       1809 ___str_26:
      0080F2 53 54                 1810 	.ascii "ST"
      0080F4 0A                    1811 	.db 0x0a
      0080F5 00                    1812 	.db 0x00
                                   1813 	.area CODE
                                   1814 	.area CONST
      0080F6                       1815 ___str_27:
      0080F6 66 31                 1816 	.ascii "f1"
      0080F8 00                    1817 	.db 0x00
                                   1818 	.area CODE
                                   1819 	.area CONST
      0080F9                       1820 ___str_28:
      0080F9 66 32                 1821 	.ascii "f2"
      0080FB 00                    1822 	.db 0x00
                                   1823 	.area CODE
                                   1824 	.area CONST
      0080FC                       1825 ___str_29:
      0080FC 66 33                 1826 	.ascii "f3"
      0080FE 00                    1827 	.db 0x00
                                   1828 	.area CODE
                                   1829 	.area CONST
      0080FF                       1830 ___str_30:
      0080FF 66 34                 1831 	.ascii "f4"
      008101 00                    1832 	.db 0x00
                                   1833 	.area CODE
                                   1834 	.area CONST
      008102                       1835 ___str_31:
      008102 66 35                 1836 	.ascii "f5"
      008104 00                    1837 	.db 0x00
                                   1838 	.area CODE
                                   1839 	.area CONST
      008105                       1840 ___str_32:
      008105 53 57 20              1841 	.ascii "SW "
      008108 00                    1842 	.db 0x00
                                   1843 	.area CODE
                                   1844 	.area CONST
      008109                       1845 ___str_33:
      008109 20                    1846 	.ascii " "
      00810A 00                    1847 	.db 0x00
                                   1848 	.area CODE
                                   1849 	.area CONST
      00810B                       1850 ___str_34:
      00810B 53 4D                 1851 	.ascii "SM"
      00810D 00                    1852 	.db 0x00
                                   1853 	.area CODE
                                   1854 	.area CONST
      00810E                       1855 ___str_35:
      00810E 53 4E                 1856 	.ascii "SN"
      008110 00                    1857 	.db 0x00
                                   1858 	.area CODE
                                   1859 	.area CONST
      008111                       1860 ___str_36:
      008111 53 54                 1861 	.ascii "ST"
      008113 00                    1862 	.db 0x00
                                   1863 	.area CODE
                                   1864 	.area CONST
      008114                       1865 ___str_37:
      008114 52 4D                 1866 	.ascii "RM"
      008116 00                    1867 	.db 0x00
                                   1868 	.area CODE
                                   1869 	.area CONST
      008117                       1870 ___str_38:
      008117 44 42                 1871 	.ascii "DB"
      008119 00                    1872 	.db 0x00
                                   1873 	.area CODE
                                   1874 	.area CONST
      00811A                       1875 ___str_39:
      00811A 53 52                 1876 	.ascii "SR"
      00811C 00                    1877 	.db 0x00
                                   1878 	.area CODE
                                   1879 	.area CONST
      00811D                       1880 ___str_40:
      00811D 53 57                 1881 	.ascii "SW"
      00811F 00                    1882 	.db 0x00
                                   1883 	.area CODE
                                   1884 	.area CONST
      008120                       1885 ___str_41:
      008120 70 72 65 73 77 69 74  1886 	.ascii "preswitch"
             63 68
      008129 0A                    1887 	.db 0x0a
      00812A 00                    1888 	.db 0x00
                                   1889 	.area CODE
                                   1890 	.area CONST
      00812B                       1891 ___str_42:
      00812B 0A                    1892 	.db 0x0a
      00812C 00                    1893 	.db 0x00
                                   1894 	.area CODE
                                   1895 	.area CONST
      00812D                       1896 ___str_43:
      00812D 73 77 69 74 63 68     1897 	.ascii "switch"
      008133 0A                    1898 	.db 0x0a
      008134 00                    1899 	.db 0x00
                                   1900 	.area CODE
                                   1901 	.area CONST
      008135                       1902 ___str_44:
      008135 53 53                 1903 	.ascii "SS"
      008137 0A                    1904 	.db 0x0a
      008138 00                    1905 	.db 0x00
                                   1906 	.area CODE
                                   1907 	.area INITIALIZER
      008139                       1908 __xinit__buffer:
      008139 00                    1909 	.db #0x00	; 0
      00813A 00                    1910 	.db 0x00
      00813B 00                    1911 	.db 0x00
      00813C 00                    1912 	.db 0x00
      00813D 00                    1913 	.db 0x00
      00813E 00                    1914 	.db 0x00
      00813F 00                    1915 	.db 0x00
      008140 00                    1916 	.db 0x00
      008141 00                    1917 	.db 0x00
      008142 00                    1918 	.db 0x00
      008143 00                    1919 	.db 0x00
      008144 00                    1920 	.db 0x00
      008145 00                    1921 	.db 0x00
      008146 00                    1922 	.db 0x00
      008147 00                    1923 	.db 0x00
      008148 00                    1924 	.db 0x00
      008149 00                    1925 	.db 0x00
      00814A 00                    1926 	.db 0x00
      00814B 00                    1927 	.db 0x00
      00814C 00                    1928 	.db 0x00
      00814D 00                    1929 	.db 0x00
      00814E 00                    1930 	.db 0x00
      00814F 00                    1931 	.db 0x00
      008150 00                    1932 	.db 0x00
      008151 00                    1933 	.db 0x00
      008152 00                    1934 	.db 0x00
      008153 00                    1935 	.db 0x00
      008154 00                    1936 	.db 0x00
      008155 00                    1937 	.db 0x00
      008156 00                    1938 	.db 0x00
      008157 00                    1939 	.db 0x00
      008158 00                    1940 	.db 0x00
      008159 00                    1941 	.db 0x00
      00815A 00                    1942 	.db 0x00
      00815B 00                    1943 	.db 0x00
      00815C 00                    1944 	.db 0x00
      00815D 00                    1945 	.db 0x00
      00815E 00                    1946 	.db 0x00
      00815F 00                    1947 	.db 0x00
      008160 00                    1948 	.db 0x00
      008161 00                    1949 	.db 0x00
      008162 00                    1950 	.db 0x00
      008163 00                    1951 	.db 0x00
      008164 00                    1952 	.db 0x00
      008165 00                    1953 	.db 0x00
      008166 00                    1954 	.db 0x00
      008167 00                    1955 	.db 0x00
      008168 00                    1956 	.db 0x00
      008169 00                    1957 	.db 0x00
      00816A 00                    1958 	.db 0x00
      00816B 00                    1959 	.db 0x00
      00816C 00                    1960 	.db 0x00
      00816D 00                    1961 	.db 0x00
      00816E 00                    1962 	.db 0x00
      00816F 00                    1963 	.db 0x00
      008170 00                    1964 	.db 0x00
      008171 00                    1965 	.db 0x00
      008172 00                    1966 	.db 0x00
      008173 00                    1967 	.db 0x00
      008174 00                    1968 	.db 0x00
      008175 00                    1969 	.db 0x00
      008176 00                    1970 	.db 0x00
      008177 00                    1971 	.db 0x00
      008178 00                    1972 	.db 0x00
      008179 00                    1973 	.db 0x00
      00817A 00                    1974 	.db 0x00
      00817B 00                    1975 	.db 0x00
      00817C 00                    1976 	.db 0x00
      00817D 00                    1977 	.db 0x00
      00817E 00                    1978 	.db 0x00
      00817F 00                    1979 	.db 0x00
      008180 00                    1980 	.db 0x00
      008181 00                    1981 	.db 0x00
      008182 00                    1982 	.db 0x00
      008183 00                    1983 	.db 0x00
      008184 00                    1984 	.db 0x00
      008185 00                    1985 	.db 0x00
      008186 00                    1986 	.db 0x00
      008187 00                    1987 	.db 0x00
      008188 00                    1988 	.db 0x00
      008189 00                    1989 	.db 0x00
      00818A 00                    1990 	.db 0x00
      00818B 00                    1991 	.db 0x00
      00818C 00                    1992 	.db 0x00
      00818D 00                    1993 	.db 0x00
      00818E 00                    1994 	.db 0x00
      00818F 00                    1995 	.db 0x00
      008190 00                    1996 	.db 0x00
      008191 00                    1997 	.db 0x00
      008192 00                    1998 	.db 0x00
      008193 00                    1999 	.db 0x00
      008194 00                    2000 	.db 0x00
      008195 00                    2001 	.db 0x00
      008196 00                    2002 	.db 0x00
      008197 00                    2003 	.db 0x00
      008198 00                    2004 	.db 0x00
      008199 00                    2005 	.db 0x00
      00819A 00                    2006 	.db 0x00
      00819B 00                    2007 	.db 0x00
      00819C 00                    2008 	.db 0x00
      00819D 00                    2009 	.db 0x00
      00819E 00                    2010 	.db 0x00
      00819F 00                    2011 	.db 0x00
      0081A0 00                    2012 	.db 0x00
      0081A1 00                    2013 	.db 0x00
      0081A2 00                    2014 	.db 0x00
      0081A3 00                    2015 	.db 0x00
      0081A4 00                    2016 	.db 0x00
      0081A5 00                    2017 	.db 0x00
      0081A6 00                    2018 	.db 0x00
      0081A7 00                    2019 	.db 0x00
      0081A8 00                    2020 	.db 0x00
      0081A9 00                    2021 	.db 0x00
      0081AA 00                    2022 	.db 0x00
      0081AB 00                    2023 	.db 0x00
      0081AC 00                    2024 	.db 0x00
      0081AD 00                    2025 	.db 0x00
      0081AE 00                    2026 	.db 0x00
      0081AF 00                    2027 	.db 0x00
      0081B0 00                    2028 	.db 0x00
      0081B1 00                    2029 	.db 0x00
      0081B2 00                    2030 	.db 0x00
      0081B3 00                    2031 	.db 0x00
      0081B4 00                    2032 	.db 0x00
      0081B5 00                    2033 	.db 0x00
      0081B6 00                    2034 	.db 0x00
      0081B7 00                    2035 	.db 0x00
      0081B8 00                    2036 	.db 0x00
      0081B9 00                    2037 	.db 0x00
      0081BA 00                    2038 	.db 0x00
      0081BB 00                    2039 	.db 0x00
      0081BC 00                    2040 	.db 0x00
      0081BD 00                    2041 	.db 0x00
      0081BE 00                    2042 	.db 0x00
      0081BF 00                    2043 	.db 0x00
      0081C0 00                    2044 	.db 0x00
      0081C1 00                    2045 	.db 0x00
      0081C2 00                    2046 	.db 0x00
      0081C3 00                    2047 	.db 0x00
      0081C4 00                    2048 	.db 0x00
      0081C5 00                    2049 	.db 0x00
      0081C6 00                    2050 	.db 0x00
      0081C7 00                    2051 	.db 0x00
      0081C8 00                    2052 	.db 0x00
      0081C9 00                    2053 	.db 0x00
      0081CA 00                    2054 	.db 0x00
      0081CB 00                    2055 	.db 0x00
      0081CC 00                    2056 	.db 0x00
      0081CD 00                    2057 	.db 0x00
      0081CE 00                    2058 	.db 0x00
      0081CF 00                    2059 	.db 0x00
      0081D0 00                    2060 	.db 0x00
      0081D1 00                    2061 	.db 0x00
      0081D2 00                    2062 	.db 0x00
      0081D3 00                    2063 	.db 0x00
      0081D4 00                    2064 	.db 0x00
      0081D5 00                    2065 	.db 0x00
      0081D6 00                    2066 	.db 0x00
      0081D7 00                    2067 	.db 0x00
      0081D8 00                    2068 	.db 0x00
      0081D9 00                    2069 	.db 0x00
      0081DA 00                    2070 	.db 0x00
      0081DB 00                    2071 	.db 0x00
      0081DC 00                    2072 	.db 0x00
      0081DD 00                    2073 	.db 0x00
      0081DE 00                    2074 	.db 0x00
      0081DF 00                    2075 	.db 0x00
      0081E0 00                    2076 	.db 0x00
      0081E1 00                    2077 	.db 0x00
      0081E2 00                    2078 	.db 0x00
      0081E3 00                    2079 	.db 0x00
      0081E4 00                    2080 	.db 0x00
      0081E5 00                    2081 	.db 0x00
      0081E6 00                    2082 	.db 0x00
      0081E7 00                    2083 	.db 0x00
      0081E8 00                    2084 	.db 0x00
      0081E9 00                    2085 	.db 0x00
      0081EA 00                    2086 	.db 0x00
      0081EB 00                    2087 	.db 0x00
      0081EC 00                    2088 	.db 0x00
      0081ED 00                    2089 	.db 0x00
      0081EE 00                    2090 	.db 0x00
      0081EF 00                    2091 	.db 0x00
      0081F0 00                    2092 	.db 0x00
      0081F1 00                    2093 	.db 0x00
      0081F2 00                    2094 	.db 0x00
      0081F3 00                    2095 	.db 0x00
      0081F4 00                    2096 	.db 0x00
      0081F5 00                    2097 	.db 0x00
      0081F6 00                    2098 	.db 0x00
      0081F7 00                    2099 	.db 0x00
      0081F8 00                    2100 	.db 0x00
      0081F9 00                    2101 	.db 0x00
      0081FA 00                    2102 	.db 0x00
      0081FB 00                    2103 	.db 0x00
      0081FC 00                    2104 	.db 0x00
      0081FD 00                    2105 	.db 0x00
      0081FE 00                    2106 	.db 0x00
      0081FF 00                    2107 	.db 0x00
      008200 00                    2108 	.db 0x00
      008201 00                    2109 	.db 0x00
      008202 00                    2110 	.db 0x00
      008203 00                    2111 	.db 0x00
      008204 00                    2112 	.db 0x00
      008205 00                    2113 	.db 0x00
      008206 00                    2114 	.db 0x00
      008207 00                    2115 	.db 0x00
      008208 00                    2116 	.db 0x00
      008209 00                    2117 	.db 0x00
      00820A 00                    2118 	.db 0x00
      00820B 00                    2119 	.db 0x00
      00820C 00                    2120 	.db 0x00
      00820D 00                    2121 	.db 0x00
      00820E 00                    2122 	.db 0x00
      00820F 00                    2123 	.db 0x00
      008210 00                    2124 	.db 0x00
      008211 00                    2125 	.db 0x00
      008212 00                    2126 	.db 0x00
      008213 00                    2127 	.db 0x00
      008214 00                    2128 	.db 0x00
      008215 00                    2129 	.db 0x00
      008216 00                    2130 	.db 0x00
      008217 00                    2131 	.db 0x00
      008218 00                    2132 	.db 0x00
      008219 00                    2133 	.db 0x00
      00821A 00                    2134 	.db 0x00
      00821B 00                    2135 	.db 0x00
      00821C 00                    2136 	.db 0x00
      00821D 00                    2137 	.db 0x00
      00821E 00                    2138 	.db 0x00
      00821F 00                    2139 	.db 0x00
      008220 00                    2140 	.db 0x00
      008221 00                    2141 	.db 0x00
      008222 00                    2142 	.db 0x00
      008223 00                    2143 	.db 0x00
      008224 00                    2144 	.db 0x00
      008225 00                    2145 	.db 0x00
      008226 00                    2146 	.db 0x00
      008227 00                    2147 	.db 0x00
      008228 00                    2148 	.db 0x00
      008229 00                    2149 	.db 0x00
      00822A 00                    2150 	.db 0x00
      00822B 00                    2151 	.db 0x00
      00822C 00                    2152 	.db 0x00
      00822D 00                    2153 	.db 0x00
      00822E 00                    2154 	.db 0x00
      00822F 00                    2155 	.db 0x00
      008230 00                    2156 	.db 0x00
      008231 00                    2157 	.db 0x00
      008232 00                    2158 	.db 0x00
      008233 00                    2159 	.db 0x00
      008234 00                    2160 	.db 0x00
      008235 00                    2161 	.db 0x00
      008236 00                    2162 	.db 0x00
      008237 00                    2163 	.db 0x00
      008238 00                    2164 	.db 0x00
      008239                       2165 __xinit__a:
      008239 00                    2166 	.db #0x00	; 0
      00823A 00                    2167 	.db 0x00
      00823B 00                    2168 	.db 0x00
      00823C                       2169 __xinit__d_addr:
      00823C 00                    2170 	.db #0x00	; 0
      00823D                       2171 __xinit__p_size:
      00823D 00                    2172 	.db #0x00	; 0
      00823E                       2173 __xinit__d_size:
      00823E 00                    2174 	.db #0x00	; 0
      00823F                       2175 __xinit__p_bytes:
      00823F 00                    2176 	.db #0x00	; 0
      008240                       2177 __xinit__data_buf:
      008240 00                    2178 	.db #0x00	; 0
      008241 00                    2179 	.db 0x00
      008242 00                    2180 	.db 0x00
      008243 00                    2181 	.db 0x00
      008244 00                    2182 	.db 0x00
      008245 00                    2183 	.db 0x00
      008246 00                    2184 	.db 0x00
      008247 00                    2185 	.db 0x00
      008248 00                    2186 	.db 0x00
      008249 00                    2187 	.db 0x00
      00824A 00                    2188 	.db 0x00
      00824B 00                    2189 	.db 0x00
      00824C 00                    2190 	.db 0x00
      00824D 00                    2191 	.db 0x00
      00824E 00                    2192 	.db 0x00
      00824F 00                    2193 	.db 0x00
      008250 00                    2194 	.db 0x00
      008251 00                    2195 	.db 0x00
      008252 00                    2196 	.db 0x00
      008253 00                    2197 	.db 0x00
      008254 00                    2198 	.db 0x00
      008255 00                    2199 	.db 0x00
      008256 00                    2200 	.db 0x00
      008257 00                    2201 	.db 0x00
      008258 00                    2202 	.db 0x00
      008259 00                    2203 	.db 0x00
      00825A 00                    2204 	.db 0x00
      00825B 00                    2205 	.db 0x00
      00825C 00                    2206 	.db 0x00
      00825D 00                    2207 	.db 0x00
      00825E 00                    2208 	.db 0x00
      00825F 00                    2209 	.db 0x00
      008260 00                    2210 	.db 0x00
      008261 00                    2211 	.db 0x00
      008262 00                    2212 	.db 0x00
      008263 00                    2213 	.db 0x00
      008264 00                    2214 	.db 0x00
      008265 00                    2215 	.db 0x00
      008266 00                    2216 	.db 0x00
      008267 00                    2217 	.db 0x00
      008268 00                    2218 	.db 0x00
      008269 00                    2219 	.db 0x00
      00826A 00                    2220 	.db 0x00
      00826B 00                    2221 	.db 0x00
      00826C 00                    2222 	.db 0x00
      00826D 00                    2223 	.db 0x00
      00826E 00                    2224 	.db 0x00
      00826F 00                    2225 	.db 0x00
      008270 00                    2226 	.db 0x00
      008271 00                    2227 	.db 0x00
      008272 00                    2228 	.db 0x00
      008273 00                    2229 	.db 0x00
      008274 00                    2230 	.db 0x00
      008275 00                    2231 	.db 0x00
      008276 00                    2232 	.db 0x00
      008277 00                    2233 	.db 0x00
      008278 00                    2234 	.db 0x00
      008279 00                    2235 	.db 0x00
      00827A 00                    2236 	.db 0x00
      00827B 00                    2237 	.db 0x00
      00827C 00                    2238 	.db 0x00
      00827D 00                    2239 	.db 0x00
      00827E 00                    2240 	.db 0x00
      00827F 00                    2241 	.db 0x00
      008280 00                    2242 	.db 0x00
      008281 00                    2243 	.db 0x00
      008282 00                    2244 	.db 0x00
      008283 00                    2245 	.db 0x00
      008284 00                    2246 	.db 0x00
      008285 00                    2247 	.db 0x00
      008286 00                    2248 	.db 0x00
      008287 00                    2249 	.db 0x00
      008288 00                    2250 	.db 0x00
      008289 00                    2251 	.db 0x00
      00828A 00                    2252 	.db 0x00
      00828B 00                    2253 	.db 0x00
      00828C 00                    2254 	.db 0x00
      00828D 00                    2255 	.db 0x00
      00828E 00                    2256 	.db 0x00
      00828F 00                    2257 	.db 0x00
      008290 00                    2258 	.db 0x00
      008291 00                    2259 	.db 0x00
      008292 00                    2260 	.db 0x00
      008293 00                    2261 	.db 0x00
      008294 00                    2262 	.db 0x00
      008295 00                    2263 	.db 0x00
      008296 00                    2264 	.db 0x00
      008297 00                    2265 	.db 0x00
      008298 00                    2266 	.db 0x00
      008299 00                    2267 	.db 0x00
      00829A 00                    2268 	.db 0x00
      00829B 00                    2269 	.db 0x00
      00829C 00                    2270 	.db 0x00
      00829D 00                    2271 	.db 0x00
      00829E 00                    2272 	.db 0x00
      00829F 00                    2273 	.db 0x00
      0082A0 00                    2274 	.db 0x00
      0082A1 00                    2275 	.db 0x00
      0082A2 00                    2276 	.db 0x00
      0082A3 00                    2277 	.db 0x00
      0082A4 00                    2278 	.db 0x00
      0082A5 00                    2279 	.db 0x00
      0082A6 00                    2280 	.db 0x00
      0082A7 00                    2281 	.db 0x00
      0082A8 00                    2282 	.db 0x00
      0082A9 00                    2283 	.db 0x00
      0082AA 00                    2284 	.db 0x00
      0082AB 00                    2285 	.db 0x00
      0082AC 00                    2286 	.db 0x00
      0082AD 00                    2287 	.db 0x00
      0082AE 00                    2288 	.db 0x00
      0082AF 00                    2289 	.db 0x00
      0082B0 00                    2290 	.db 0x00
      0082B1 00                    2291 	.db 0x00
      0082B2 00                    2292 	.db 0x00
      0082B3 00                    2293 	.db 0x00
      0082B4 00                    2294 	.db 0x00
      0082B5 00                    2295 	.db 0x00
      0082B6 00                    2296 	.db 0x00
      0082B7 00                    2297 	.db 0x00
      0082B8 00                    2298 	.db 0x00
      0082B9 00                    2299 	.db 0x00
      0082BA 00                    2300 	.db 0x00
      0082BB 00                    2301 	.db 0x00
      0082BC 00                    2302 	.db 0x00
      0082BD 00                    2303 	.db 0x00
      0082BE 00                    2304 	.db 0x00
      0082BF 00                    2305 	.db 0x00
      0082C0 00                    2306 	.db 0x00
      0082C1 00                    2307 	.db 0x00
      0082C2 00                    2308 	.db 0x00
      0082C3 00                    2309 	.db 0x00
      0082C4 00                    2310 	.db 0x00
      0082C5 00                    2311 	.db 0x00
      0082C6 00                    2312 	.db 0x00
      0082C7 00                    2313 	.db 0x00
      0082C8 00                    2314 	.db 0x00
      0082C9 00                    2315 	.db 0x00
      0082CA 00                    2316 	.db 0x00
      0082CB 00                    2317 	.db 0x00
      0082CC 00                    2318 	.db 0x00
      0082CD 00                    2319 	.db 0x00
      0082CE 00                    2320 	.db 0x00
      0082CF 00                    2321 	.db 0x00
      0082D0 00                    2322 	.db 0x00
      0082D1 00                    2323 	.db 0x00
      0082D2 00                    2324 	.db 0x00
      0082D3 00                    2325 	.db 0x00
      0082D4 00                    2326 	.db 0x00
      0082D5 00                    2327 	.db 0x00
      0082D6 00                    2328 	.db 0x00
      0082D7 00                    2329 	.db 0x00
      0082D8 00                    2330 	.db 0x00
      0082D9 00                    2331 	.db 0x00
      0082DA 00                    2332 	.db 0x00
      0082DB 00                    2333 	.db 0x00
      0082DC 00                    2334 	.db 0x00
      0082DD 00                    2335 	.db 0x00
      0082DE 00                    2336 	.db 0x00
      0082DF 00                    2337 	.db 0x00
      0082E0 00                    2338 	.db 0x00
      0082E1 00                    2339 	.db 0x00
      0082E2 00                    2340 	.db 0x00
      0082E3 00                    2341 	.db 0x00
      0082E4 00                    2342 	.db 0x00
      0082E5 00                    2343 	.db 0x00
      0082E6 00                    2344 	.db 0x00
      0082E7 00                    2345 	.db 0x00
      0082E8 00                    2346 	.db 0x00
      0082E9 00                    2347 	.db 0x00
      0082EA 00                    2348 	.db 0x00
      0082EB 00                    2349 	.db 0x00
      0082EC 00                    2350 	.db 0x00
      0082ED 00                    2351 	.db 0x00
      0082EE 00                    2352 	.db 0x00
      0082EF 00                    2353 	.db 0x00
      0082F0 00                    2354 	.db 0x00
      0082F1 00                    2355 	.db 0x00
      0082F2 00                    2356 	.db 0x00
      0082F3 00                    2357 	.db 0x00
      0082F4 00                    2358 	.db 0x00
      0082F5 00                    2359 	.db 0x00
      0082F6 00                    2360 	.db 0x00
      0082F7 00                    2361 	.db 0x00
      0082F8 00                    2362 	.db 0x00
      0082F9 00                    2363 	.db 0x00
      0082FA 00                    2364 	.db 0x00
      0082FB 00                    2365 	.db 0x00
      0082FC 00                    2366 	.db 0x00
      0082FD 00                    2367 	.db 0x00
      0082FE 00                    2368 	.db 0x00
      0082FF 00                    2369 	.db 0x00
      008300 00                    2370 	.db 0x00
      008301 00                    2371 	.db 0x00
      008302 00                    2372 	.db 0x00
      008303 00                    2373 	.db 0x00
      008304 00                    2374 	.db 0x00
      008305 00                    2375 	.db 0x00
      008306 00                    2376 	.db 0x00
      008307 00                    2377 	.db 0x00
      008308 00                    2378 	.db 0x00
      008309 00                    2379 	.db 0x00
      00830A 00                    2380 	.db 0x00
      00830B 00                    2381 	.db 0x00
      00830C 00                    2382 	.db 0x00
      00830D 00                    2383 	.db 0x00
      00830E 00                    2384 	.db 0x00
      00830F 00                    2385 	.db 0x00
      008310 00                    2386 	.db 0x00
      008311 00                    2387 	.db 0x00
      008312 00                    2388 	.db 0x00
      008313 00                    2389 	.db 0x00
      008314 00                    2390 	.db 0x00
      008315 00                    2391 	.db 0x00
      008316 00                    2392 	.db 0x00
      008317 00                    2393 	.db 0x00
      008318 00                    2394 	.db 0x00
      008319 00                    2395 	.db 0x00
      00831A 00                    2396 	.db 0x00
      00831B 00                    2397 	.db 0x00
      00831C 00                    2398 	.db 0x00
      00831D 00                    2399 	.db 0x00
      00831E 00                    2400 	.db 0x00
      00831F 00                    2401 	.db 0x00
      008320 00                    2402 	.db 0x00
      008321 00                    2403 	.db 0x00
      008322 00                    2404 	.db 0x00
      008323 00                    2405 	.db 0x00
      008324 00                    2406 	.db 0x00
      008325 00                    2407 	.db 0x00
      008326 00                    2408 	.db 0x00
      008327 00                    2409 	.db 0x00
      008328 00                    2410 	.db 0x00
      008329 00                    2411 	.db 0x00
      00832A 00                    2412 	.db 0x00
      00832B 00                    2413 	.db 0x00
      00832C 00                    2414 	.db 0x00
      00832D 00                    2415 	.db 0x00
      00832E 00                    2416 	.db 0x00
      00832F 00                    2417 	.db 0x00
      008330 00                    2418 	.db 0x00
      008331 00                    2419 	.db 0x00
      008332 00                    2420 	.db 0x00
      008333 00                    2421 	.db 0x00
      008334 00                    2422 	.db 0x00
      008335 00                    2423 	.db 0x00
      008336 00                    2424 	.db 0x00
      008337 00                    2425 	.db 0x00
      008338 00                    2426 	.db 0x00
      008339 00                    2427 	.db 0x00
      00833A 00                    2428 	.db 0x00
      00833B 00                    2429 	.db 0x00
      00833C 00                    2430 	.db 0x00
      00833D 00                    2431 	.db 0x00
      00833E 00                    2432 	.db 0x00
      00833F 00                    2433 	.db 0x00
      008340                       2434 __xinit__current_dev:
      008340 00                    2435 	.db #0x00	; 0
                                   2436 	.area CABS (ABS)
