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
      000001                         62 	.ds 255
      000100                         63 _a::
      000100                         64 	.ds 3
      000103                         65 _d_addr::
      000103                         66 	.ds 1
      000104                         67 _p_size::
      000104                         68 	.ds 1
      000105                         69 _d_size::
      000105                         70 	.ds 1
      000106                         71 _p_bytes::
      000106                         72 	.ds 1
      000107                         73 _data_buf::
      000107                         74 	.ds 255
      000206                         75 _current_dev::
      000206                         76 	.ds 1
                                     77 ;--------------------------------------------------------
                                     78 ; Stack segment in internal ram
                                     79 ;--------------------------------------------------------
                                     80 	.area SSEG
      000207                         81 __start__stack:
      000207                         82 	.ds	1
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
      008007 CD 8C 03         [ 4]  110 	call	___sdcc_external_startup
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
      00801C AE 02 06         [ 2]  123 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]  124 	jreq	00004$
      008021                        125 00003$:
      008021 D6 81 1F         [ 1]  126 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 8B 36         [ 2]  140 	jp	_main
                                    141 ;	return from main will return to caller
                                    142 ;--------------------------------------------------------
                                    143 ; code
                                    144 ;--------------------------------------------------------
                                    145 	.area CODE
                                    146 ;	main.c: 26: void delay(unsigned long count) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function delay
                                    149 ;	-----------------------------------------
      008326                        150 _delay:
      008326 52 08            [ 2]  151 	sub	sp, #8
                                    152 ;	main.c: 27: while (count--)
      008328 16 0D            [ 2]  153 	ldw	y, (0x0d, sp)
      00832A 17 07            [ 2]  154 	ldw	(0x07, sp), y
      00832C 1E 0B            [ 2]  155 	ldw	x, (0x0b, sp)
      00832E                        156 00101$:
      00832E 1F 01            [ 2]  157 	ldw	(0x01, sp), x
      008330 7B 07            [ 1]  158 	ld	a, (0x07, sp)
      008332 6B 03            [ 1]  159 	ld	(0x03, sp), a
      008334 7B 08            [ 1]  160 	ld	a, (0x08, sp)
      008336 16 07            [ 2]  161 	ldw	y, (0x07, sp)
      008338 72 A2 00 01      [ 2]  162 	subw	y, #0x0001
      00833C 17 07            [ 2]  163 	ldw	(0x07, sp), y
      00833E 24 01            [ 1]  164 	jrnc	00117$
      008340 5A               [ 2]  165 	decw	x
      008341                        166 00117$:
      008341 4D               [ 1]  167 	tnz	a
      008342 26 08            [ 1]  168 	jrne	00118$
      008344 16 02            [ 2]  169 	ldw	y, (0x02, sp)
      008346 26 04            [ 1]  170 	jrne	00118$
      008348 0D 01            [ 1]  171 	tnz	(0x01, sp)
      00834A 27 03            [ 1]  172 	jreq	00104$
      00834C                        173 00118$:
                                    174 ;	main.c: 28: nop();
      00834C 9D               [ 1]  175 	nop
      00834D 20 DF            [ 2]  176 	jra	00101$
      00834F                        177 00104$:
                                    178 ;	main.c: 29: }
      00834F 1E 09            [ 2]  179 	ldw	x, (9, sp)
      008351 5B 0E            [ 2]  180 	addw	sp, #14
      008353 FC               [ 2]  181 	jp	(x)
                                    182 ;	main.c: 37: void UART_TX(unsigned char value)
                                    183 ;	-----------------------------------------
                                    184 ;	 function UART_TX
                                    185 ;	-----------------------------------------
      008354                        186 _UART_TX:
                                    187 ;	main.c: 39: UART1_DR = value;
      008354 C7 52 31         [ 1]  188 	ld	0x5231, a
                                    189 ;	main.c: 40: while(!(UART1_SR & UART_SR_TXE));
      008357                        190 00101$:
      008357 C6 52 30         [ 1]  191 	ld	a, 0x5230
      00835A 2A FB            [ 1]  192 	jrpl	00101$
                                    193 ;	main.c: 41: }
      00835C 81               [ 4]  194 	ret
                                    195 ;	main.c: 42: unsigned char UART_RX(void)
                                    196 ;	-----------------------------------------
                                    197 ;	 function UART_RX
                                    198 ;	-----------------------------------------
      00835D                        199 _UART_RX:
                                    200 ;	main.c: 44: while(!(UART1_SR & UART_SR_TXE));
      00835D                        201 00101$:
      00835D C6 52 30         [ 1]  202 	ld	a, 0x5230
      008360 2A FB            [ 1]  203 	jrpl	00101$
                                    204 ;	main.c: 45: return UART1_DR;
      008362 C6 52 31         [ 1]  205 	ld	a, 0x5231
                                    206 ;	main.c: 46: }
      008365 81               [ 4]  207 	ret
                                    208 ;	main.c: 47: int uart_write(const char *str) {
                                    209 ;	-----------------------------------------
                                    210 ;	 function uart_write
                                    211 ;	-----------------------------------------
      008366                        212 _uart_write:
      008366 52 05            [ 2]  213 	sub	sp, #5
      008368 1F 03            [ 2]  214 	ldw	(0x03, sp), x
                                    215 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      00836A 0F 05            [ 1]  216 	clr	(0x05, sp)
      00836C                        217 00103$:
      00836C 1E 03            [ 2]  218 	ldw	x, (0x03, sp)
      00836E CD 8C 05         [ 4]  219 	call	_strlen
      008371 1F 01            [ 2]  220 	ldw	(0x01, sp), x
      008373 7B 05            [ 1]  221 	ld	a, (0x05, sp)
      008375 5F               [ 1]  222 	clrw	x
      008376 97               [ 1]  223 	ld	xl, a
      008377 13 01            [ 2]  224 	cpw	x, (0x01, sp)
      008379 24 0F            [ 1]  225 	jrnc	00101$
                                    226 ;	main.c: 51: UART_TX(str[i]);
      00837B 5F               [ 1]  227 	clrw	x
      00837C 7B 05            [ 1]  228 	ld	a, (0x05, sp)
      00837E 97               [ 1]  229 	ld	xl, a
      00837F 72 FB 03         [ 2]  230 	addw	x, (0x03, sp)
      008382 F6               [ 1]  231 	ld	a, (x)
      008383 CD 83 54         [ 4]  232 	call	_UART_TX
                                    233 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      008386 0C 05            [ 1]  234 	inc	(0x05, sp)
      008388 20 E2            [ 2]  235 	jra	00103$
      00838A                        236 00101$:
                                    237 ;	main.c: 53: return(i); // Bytes sent
      00838A 7B 05            [ 1]  238 	ld	a, (0x05, sp)
      00838C 5F               [ 1]  239 	clrw	x
      00838D 97               [ 1]  240 	ld	xl, a
                                    241 ;	main.c: 54: }
      00838E 5B 05            [ 2]  242 	addw	sp, #5
      008390 81               [ 4]  243 	ret
                                    244 ;	main.c: 55: int uart_read(void)
                                    245 ;	-----------------------------------------
                                    246 ;	 function uart_read
                                    247 ;	-----------------------------------------
      008391                        248 _uart_read:
                                    249 ;	main.c: 57: memset(buffer, 0, sizeof(buffer));
      008391 4B FF            [ 1]  250 	push	#0xff
      008393 4B 00            [ 1]  251 	push	#0x00
      008395 5F               [ 1]  252 	clrw	x
      008396 89               [ 2]  253 	pushw	x
      008397 AE 00 01         [ 2]  254 	ldw	x, #(_buffer+0)
      00839A CD 8B E1         [ 4]  255 	call	_memset
                                    256 ;	main.c: 59: while(i<256)
      00839D 5F               [ 1]  257 	clrw	x
      00839E                        258 00105$:
      00839E A3 01 00         [ 2]  259 	cpw	x, #0x0100
      0083A1 2E 22            [ 1]  260 	jrsge	00107$
                                    261 ;	main.c: 61: if(UART1_SR & UART_SR_RXNE)
      0083A3 C6 52 30         [ 1]  262 	ld	a, 0x5230
      0083A6 A5 20            [ 1]  263 	bcp	a, #0x20
      0083A8 27 F4            [ 1]  264 	jreq	00105$
                                    265 ;	main.c: 63: buffer[i] = UART_RX();
      0083AA 90 93            [ 1]  266 	ldw	y, x
      0083AC 72 A9 00 01      [ 2]  267 	addw	y, #(_buffer+0)
      0083B0 89               [ 2]  268 	pushw	x
      0083B1 90 89            [ 2]  269 	pushw	y
      0083B3 CD 83 5D         [ 4]  270 	call	_UART_RX
      0083B6 90 85            [ 2]  271 	popw	y
      0083B8 85               [ 2]  272 	popw	x
      0083B9 90 F7            [ 1]  273 	ld	(y), a
                                    274 ;	main.c: 64: if(buffer[i] == '\r\n' )
      0083BB A1 0D            [ 1]  275 	cp	a, #0x0d
      0083BD 26 03            [ 1]  276 	jrne	00102$
                                    277 ;	main.c: 66: return 1;
      0083BF 5F               [ 1]  278 	clrw	x
      0083C0 5C               [ 1]  279 	incw	x
      0083C1 81               [ 4]  280 	ret
                                    281 ;	main.c: 67: break;
      0083C2                        282 00102$:
                                    283 ;	main.c: 69: i++;
      0083C2 5C               [ 1]  284 	incw	x
      0083C3 20 D9            [ 2]  285 	jra	00105$
      0083C5                        286 00107$:
                                    287 ;	main.c: 72: return 0;
      0083C5 5F               [ 1]  288 	clrw	x
                                    289 ;	main.c: 73: }
      0083C6 81               [ 4]  290 	ret
                                    291 ;	main.c: 82: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    292 ;	-----------------------------------------
                                    293 ;	 function convert_int_to_chars
                                    294 ;	-----------------------------------------
      0083C7                        295 _convert_int_to_chars:
      0083C7 52 0D            [ 2]  296 	sub	sp, #13
      0083C9 6B 0D            [ 1]  297 	ld	(0x0d, sp), a
      0083CB 1F 0B            [ 2]  298 	ldw	(0x0b, sp), x
                                    299 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      0083CD 7B 0D            [ 1]  300 	ld	a, (0x0d, sp)
      0083CF 6B 02            [ 1]  301 	ld	(0x02, sp), a
      0083D1 0F 01            [ 1]  302 	clr	(0x01, sp)
                                    303 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083D3 1E 0B            [ 2]  304 	ldw	x, (0x0b, sp)
      0083D5 5C               [ 1]  305 	incw	x
      0083D6 1F 03            [ 2]  306 	ldw	(0x03, sp), x
                                    307 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083D8 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      0083DA 5C               [ 1]  309 	incw	x
      0083DB 5C               [ 1]  310 	incw	x
      0083DC 1F 05            [ 2]  311 	ldw	(0x05, sp), x
                                    312 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083DE 4B 0A            [ 1]  313 	push	#0x0a
      0083E0 4B 00            [ 1]  314 	push	#0x00
      0083E2 1E 03            [ 2]  315 	ldw	x, (0x03, sp)
                                    316 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083E4 CD 8C 2A         [ 4]  317 	call	__divsint
      0083E7 1F 07            [ 2]  318 	ldw	(0x07, sp), x
      0083E9 4B 0A            [ 1]  319 	push	#0x0a
      0083EB 4B 00            [ 1]  320 	push	#0x00
      0083ED 1E 03            [ 2]  321 	ldw	x, (0x03, sp)
      0083EF CD 8C 12         [ 4]  322 	call	__modsint
      0083F2 9F               [ 1]  323 	ld	a, xl
      0083F3 AB 30            [ 1]  324 	add	a, #0x30
      0083F5 6B 09            [ 1]  325 	ld	(0x09, sp), a
                                    326 ;	main.c: 83: if (num > 99) {
      0083F7 7B 0D            [ 1]  327 	ld	a, (0x0d, sp)
      0083F9 A1 63            [ 1]  328 	cp	a, #0x63
      0083FB 23 29            [ 2]  329 	jrule	00105$
                                    330 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      0083FD 4B 64            [ 1]  331 	push	#0x64
      0083FF 4B 00            [ 1]  332 	push	#0x00
      008401 1E 03            [ 2]  333 	ldw	x, (0x03, sp)
      008403 CD 8C 2A         [ 4]  334 	call	__divsint
      008406 9F               [ 1]  335 	ld	a, xl
      008407 AB 30            [ 1]  336 	add	a, #0x30
      008409 1E 0B            [ 2]  337 	ldw	x, (0x0b, sp)
      00840B F7               [ 1]  338 	ld	(x), a
                                    339 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      00840C 4B 0A            [ 1]  340 	push	#0x0a
      00840E 4B 00            [ 1]  341 	push	#0x00
      008410 1E 09            [ 2]  342 	ldw	x, (0x09, sp)
      008412 CD 8C 12         [ 4]  343 	call	__modsint
      008415 9F               [ 1]  344 	ld	a, xl
      008416 AB 30            [ 1]  345 	add	a, #0x30
      008418 1E 03            [ 2]  346 	ldw	x, (0x03, sp)
      00841A F7               [ 1]  347 	ld	(x), a
                                    348 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      00841B 1E 05            [ 2]  349 	ldw	x, (0x05, sp)
      00841D 7B 09            [ 1]  350 	ld	a, (0x09, sp)
      00841F F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 88: rx_int_chars[3] ='\0';
      008420 1E 0B            [ 2]  353 	ldw	x, (0x0b, sp)
      008422 6F 03            [ 1]  354 	clr	(0x0003, x)
      008424 20 23            [ 2]  355 	jra	00107$
      008426                        356 00105$:
                                    357 ;	main.c: 90: } else if (num > 9) {
      008426 7B 0D            [ 1]  358 	ld	a, (0x0d, sp)
      008428 A1 09            [ 1]  359 	cp	a, #0x09
      00842A 23 13            [ 2]  360 	jrule	00102$
                                    361 ;	main.c: 92: rx_int_chars[0] = num / 10 + '0';
      00842C 7B 08            [ 1]  362 	ld	a, (0x08, sp)
      00842E 6B 0A            [ 1]  363 	ld	(0x0a, sp), a
      008430 AB 30            [ 1]  364 	add	a, #0x30
      008432 1E 0B            [ 2]  365 	ldw	x, (0x0b, sp)
      008434 F7               [ 1]  366 	ld	(x), a
                                    367 ;	main.c: 93: rx_int_chars[1] = num % 10 + '0';
      008435 1E 03            [ 2]  368 	ldw	x, (0x03, sp)
      008437 7B 09            [ 1]  369 	ld	a, (0x09, sp)
      008439 F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 94: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      00843A 1E 05            [ 2]  372 	ldw	x, (0x05, sp)
      00843C 7F               [ 1]  373 	clr	(x)
      00843D 20 0A            [ 2]  374 	jra	00107$
      00843F                        375 00102$:
                                    376 ;	main.c: 97: rx_int_chars[0] = num + '0';
      00843F 7B 0D            [ 1]  377 	ld	a, (0x0d, sp)
      008441 AB 30            [ 1]  378 	add	a, #0x30
      008443 1E 0B            [ 2]  379 	ldw	x, (0x0b, sp)
      008445 F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 98: rx_int_chars[1] ='\0';
      008446 1E 03            [ 2]  382 	ldw	x, (0x03, sp)
      008448 7F               [ 1]  383 	clr	(x)
      008449                        384 00107$:
                                    385 ;	main.c: 100: }
      008449 5B 0D            [ 2]  386 	addw	sp, #13
      00844B 81               [ 4]  387 	ret
                                    388 ;	main.c: 102: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    389 ;	-----------------------------------------
                                    390 ;	 function convert_chars_to_int
                                    391 ;	-----------------------------------------
      00844C                        392 _convert_chars_to_int:
      00844C 52 09            [ 2]  393 	sub	sp, #9
      00844E 1F 06            [ 2]  394 	ldw	(0x06, sp), x
                                    395 ;	main.c: 103: uint8_t result = 0;
      008450 0F 05            [ 1]  396 	clr	(0x05, sp)
                                    397 ;	main.c: 104: uart_write("\nchar -> ");
      008452 AE 80 2D         [ 2]  398 	ldw	x, #(___str_0+0)
      008455 CD 83 66         [ 4]  399 	call	_uart_write
                                    400 ;	main.c: 105: uart_write(rx_chars_int);
      008458 1E 06            [ 2]  401 	ldw	x, (0x06, sp)
      00845A CD 83 66         [ 4]  402 	call	_uart_write
                                    403 ;	main.c: 106: uart_write(" <-\n");
      00845D AE 80 37         [ 2]  404 	ldw	x, #(___str_1+0)
      008460 CD 83 66         [ 4]  405 	call	_uart_write
                                    406 ;	main.c: 107: for (int o = 0; o < i; o++) {
      008463 5F               [ 1]  407 	clrw	x
      008464 1F 08            [ 2]  408 	ldw	(0x08, sp), x
      008466                        409 00103$:
      008466 1E 08            [ 2]  410 	ldw	x, (0x08, sp)
      008468 13 0C            [ 2]  411 	cpw	x, (0x0c, sp)
      00846A 2E 3C            [ 1]  412 	jrsge	00101$
                                    413 ;	main.c: 109: result = (result * 10) + (rx_chars_int[o] - '0');
      00846C 7B 05            [ 1]  414 	ld	a, (0x05, sp)
      00846E 97               [ 1]  415 	ld	xl, a
      00846F A6 0A            [ 1]  416 	ld	a, #0x0a
      008471 42               [ 4]  417 	mul	x, a
      008472 16 06            [ 2]  418 	ldw	y, (0x06, sp)
      008474 72 F9 08         [ 2]  419 	addw	y, (0x08, sp)
      008477 90 F6            [ 1]  420 	ld	a, (y)
      008479 A0 30            [ 1]  421 	sub	a, #0x30
      00847B 89               [ 2]  422 	pushw	x
      00847C 1B 02            [ 1]  423 	add	a, (2, sp)
      00847E 85               [ 2]  424 	popw	x
      00847F 6B 05            [ 1]  425 	ld	(0x05, sp), a
                                    426 ;	main.c: 110: char rx_binary_chars[4]={0};
      008481 0F 01            [ 1]  427 	clr	(0x01, sp)
      008483 0F 02            [ 1]  428 	clr	(0x02, sp)
      008485 0F 03            [ 1]  429 	clr	(0x03, sp)
      008487 0F 04            [ 1]  430 	clr	(0x04, sp)
                                    431 ;	main.c: 111: convert_int_to_chars(result, rx_binary_chars);
      008489 96               [ 1]  432 	ldw	x, sp
      00848A 5C               [ 1]  433 	incw	x
      00848B 7B 05            [ 1]  434 	ld	a, (0x05, sp)
      00848D CD 83 C7         [ 4]  435 	call	_convert_int_to_chars
                                    436 ;	main.c: 112: uart_write("\nresult -> ");
      008490 AE 80 3C         [ 2]  437 	ldw	x, #(___str_2+0)
      008493 CD 83 66         [ 4]  438 	call	_uart_write
                                    439 ;	main.c: 113: uart_write(rx_binary_chars);
      008496 96               [ 1]  440 	ldw	x, sp
      008497 5C               [ 1]  441 	incw	x
      008498 CD 83 66         [ 4]  442 	call	_uart_write
                                    443 ;	main.c: 114: uart_write(" <-\n");
      00849B AE 80 37         [ 2]  444 	ldw	x, #(___str_1+0)
      00849E CD 83 66         [ 4]  445 	call	_uart_write
                                    446 ;	main.c: 107: for (int o = 0; o < i; o++) {
      0084A1 1E 08            [ 2]  447 	ldw	x, (0x08, sp)
      0084A3 5C               [ 1]  448 	incw	x
      0084A4 1F 08            [ 2]  449 	ldw	(0x08, sp), x
      0084A6 20 BE            [ 2]  450 	jra	00103$
      0084A8                        451 00101$:
                                    452 ;	main.c: 117: return result;
      0084A8 7B 05            [ 1]  453 	ld	a, (0x05, sp)
                                    454 ;	main.c: 118: }
      0084AA 1E 0A            [ 2]  455 	ldw	x, (10, sp)
      0084AC 5B 0D            [ 2]  456 	addw	sp, #13
      0084AE FC               [ 2]  457 	jp	(x)
                                    458 ;	main.c: 121: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    459 ;	-----------------------------------------
                                    460 ;	 function convert_int_to_binary
                                    461 ;	-----------------------------------------
      0084AF                        462 _convert_int_to_binary:
      0084AF 52 04            [ 2]  463 	sub	sp, #4
      0084B1 1F 01            [ 2]  464 	ldw	(0x01, sp), x
                                    465 ;	main.c: 123: for(int i = 7; i >= 0; i--) {
      0084B3 AE 00 07         [ 2]  466 	ldw	x, #0x0007
      0084B6 1F 03            [ 2]  467 	ldw	(0x03, sp), x
      0084B8                        468 00103$:
      0084B8 0D 03            [ 1]  469 	tnz	(0x03, sp)
      0084BA 2B 22            [ 1]  470 	jrmi	00101$
                                    471 ;	main.c: 125: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      0084BC AE 00 07         [ 2]  472 	ldw	x, #0x0007
      0084BF 72 F0 03         [ 2]  473 	subw	x, (0x03, sp)
      0084C2 72 FB 07         [ 2]  474 	addw	x, (0x07, sp)
      0084C5 16 01            [ 2]  475 	ldw	y, (0x01, sp)
      0084C7 7B 04            [ 1]  476 	ld	a, (0x04, sp)
      0084C9 27 05            [ 1]  477 	jreq	00120$
      0084CB                        478 00119$:
      0084CB 90 57            [ 2]  479 	sraw	y
      0084CD 4A               [ 1]  480 	dec	a
      0084CE 26 FB            [ 1]  481 	jrne	00119$
      0084D0                        482 00120$:
      0084D0 90 9F            [ 1]  483 	ld	a, yl
      0084D2 A4 01            [ 1]  484 	and	a, #0x01
      0084D4 AB 30            [ 1]  485 	add	a, #0x30
      0084D6 F7               [ 1]  486 	ld	(x), a
                                    487 ;	main.c: 123: for(int i = 7; i >= 0; i--) {
      0084D7 1E 03            [ 2]  488 	ldw	x, (0x03, sp)
      0084D9 5A               [ 2]  489 	decw	x
      0084DA 1F 03            [ 2]  490 	ldw	(0x03, sp), x
      0084DC 20 DA            [ 2]  491 	jra	00103$
      0084DE                        492 00101$:
                                    493 ;	main.c: 127: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      0084DE 1E 07            [ 2]  494 	ldw	x, (0x07, sp)
      0084E0 6F 08            [ 1]  495 	clr	(0x0008, x)
                                    496 ;	main.c: 128: }
      0084E2 1E 05            [ 2]  497 	ldw	x, (5, sp)
      0084E4 5B 08            [ 2]  498 	addw	sp, #8
      0084E6 FC               [ 2]  499 	jp	(x)
                                    500 ;	main.c: 137: void get_addr_from_buff(void)
                                    501 ;	-----------------------------------------
                                    502 ;	 function get_addr_from_buff
                                    503 ;	-----------------------------------------
      0084E7                        504 _get_addr_from_buff:
      0084E7 52 02            [ 2]  505 	sub	sp, #2
                                    506 ;	main.c: 141: while(1)
      0084E9 A6 03            [ 1]  507 	ld	a, #0x03
      0084EB 6B 01            [ 1]  508 	ld	(0x01, sp), a
      0084ED 0F 02            [ 1]  509 	clr	(0x02, sp)
      0084EF                        510 00105$:
                                    511 ;	main.c: 143: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      0084EF 5F               [ 1]  512 	clrw	x
      0084F0 7B 01            [ 1]  513 	ld	a, (0x01, sp)
      0084F2 97               [ 1]  514 	ld	xl, a
      0084F3 D6 00 01         [ 1]  515 	ld	a, (_buffer+0, x)
      0084F6 A1 20            [ 1]  516 	cp	a, #0x20
      0084F8 27 04            [ 1]  517 	jreq	00101$
      0084FA A1 0D            [ 1]  518 	cp	a, #0x0d
      0084FC 26 08            [ 1]  519 	jrne	00102$
      0084FE                        520 00101$:
                                    521 ;	main.c: 145: p_size = i+1;
      0084FE 7B 01            [ 1]  522 	ld	a, (0x01, sp)
      008500 4C               [ 1]  523 	inc	a
      008501 C7 01 04         [ 1]  524 	ld	_p_size+0, a
                                    525 ;	main.c: 146: break;
      008504 20 06            [ 2]  526 	jra	00106$
      008506                        527 00102$:
                                    528 ;	main.c: 148: i++;
      008506 0C 01            [ 1]  529 	inc	(0x01, sp)
                                    530 ;	main.c: 149: counter++;
      008508 0C 02            [ 1]  531 	inc	(0x02, sp)
      00850A 20 E3            [ 2]  532 	jra	00105$
      00850C                        533 00106$:
                                    534 ;	main.c: 151: memcpy(a, &buffer[3], counter);
      00850C 5F               [ 1]  535 	clrw	x
      00850D 7B 02            [ 1]  536 	ld	a, (0x02, sp)
      00850F 97               [ 1]  537 	ld	xl, a
      008510 89               [ 2]  538 	pushw	x
      008511 4B 04            [ 1]  539 	push	#<(_buffer+3)
      008513 4B 00            [ 1]  540 	push	#((_buffer+3) >> 8)
      008515 AE 01 00         [ 2]  541 	ldw	x, #(_a+0)
      008518 CD 8B 8E         [ 4]  542 	call	___memcpy
                                    543 ;	main.c: 152: d_addr = convert_chars_to_int(a, counter);
      00851B 5F               [ 1]  544 	clrw	x
      00851C 7B 02            [ 1]  545 	ld	a, (0x02, sp)
      00851E 97               [ 1]  546 	ld	xl, a
      00851F 89               [ 2]  547 	pushw	x
      008520 AE 01 00         [ 2]  548 	ldw	x, #(_a+0)
      008523 CD 84 4C         [ 4]  549 	call	_convert_chars_to_int
      008526 C7 01 03         [ 1]  550 	ld	_d_addr+0, a
                                    551 ;	main.c: 153: }
      008529 5B 02            [ 2]  552 	addw	sp, #2
      00852B 81               [ 4]  553 	ret
                                    554 ;	main.c: 155: void get_size_from_buff(void)
                                    555 ;	-----------------------------------------
                                    556 ;	 function get_size_from_buff
                                    557 ;	-----------------------------------------
      00852C                        558 _get_size_from_buff:
      00852C 52 02            [ 2]  559 	sub	sp, #2
                                    560 ;	main.c: 157: memset(a, 0, sizeof(a));
      00852E 4B 03            [ 1]  561 	push	#0x03
      008530 4B 00            [ 1]  562 	push	#0x00
      008532 5F               [ 1]  563 	clrw	x
      008533 89               [ 2]  564 	pushw	x
      008534 AE 01 00         [ 2]  565 	ldw	x, #(_a+0)
      008537 CD 8B E1         [ 4]  566 	call	_memset
                                    567 ;	main.c: 159: uint8_t i = p_size;
      00853A C6 01 04         [ 1]  568 	ld	a, _p_size+0
      00853D 6B 01            [ 1]  569 	ld	(0x01, sp), a
                                    570 ;	main.c: 160: while(1)
      00853F 0F 02            [ 1]  571 	clr	(0x02, sp)
      008541                        572 00105$:
                                    573 ;	main.c: 162: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008541 5F               [ 1]  574 	clrw	x
      008542 7B 01            [ 1]  575 	ld	a, (0x01, sp)
      008544 97               [ 1]  576 	ld	xl, a
      008545 D6 00 01         [ 1]  577 	ld	a, (_buffer+0, x)
      008548 A1 20            [ 1]  578 	cp	a, #0x20
      00854A 27 04            [ 1]  579 	jreq	00101$
      00854C A1 0D            [ 1]  580 	cp	a, #0x0d
      00854E 26 08            [ 1]  581 	jrne	00102$
      008550                        582 00101$:
                                    583 ;	main.c: 165: p_bytes = i+1;
      008550 7B 01            [ 1]  584 	ld	a, (0x01, sp)
      008552 4C               [ 1]  585 	inc	a
      008553 C7 01 06         [ 1]  586 	ld	_p_bytes+0, a
                                    587 ;	main.c: 166: break;
      008556 20 06            [ 2]  588 	jra	00106$
      008558                        589 00102$:
                                    590 ;	main.c: 168: i++;
      008558 0C 01            [ 1]  591 	inc	(0x01, sp)
                                    592 ;	main.c: 169: counter++;
      00855A 0C 02            [ 1]  593 	inc	(0x02, sp)
      00855C 20 E3            [ 2]  594 	jra	00105$
      00855E                        595 00106$:
                                    596 ;	main.c: 172: memcpy(a, &buffer[p_size], counter);
      00855E 90 5F            [ 1]  597 	clrw	y
      008560 7B 02            [ 1]  598 	ld	a, (0x02, sp)
      008562 90 97            [ 1]  599 	ld	yl, a
      008564 5F               [ 1]  600 	clrw	x
      008565 C6 01 04         [ 1]  601 	ld	a, _p_size+0
      008568 97               [ 1]  602 	ld	xl, a
      008569 1C 00 01         [ 2]  603 	addw	x, #(_buffer+0)
      00856C 90 89            [ 2]  604 	pushw	y
      00856E 89               [ 2]  605 	pushw	x
      00856F AE 01 00         [ 2]  606 	ldw	x, #(_a+0)
      008572 CD 8B 8E         [ 4]  607 	call	___memcpy
                                    608 ;	main.c: 173: d_size = convert_chars_to_int(a, counter);
      008575 5F               [ 1]  609 	clrw	x
      008576 7B 02            [ 1]  610 	ld	a, (0x02, sp)
      008578 97               [ 1]  611 	ld	xl, a
      008579 89               [ 2]  612 	pushw	x
      00857A AE 01 00         [ 2]  613 	ldw	x, #(_a+0)
      00857D CD 84 4C         [ 4]  614 	call	_convert_chars_to_int
      008580 C7 01 05         [ 1]  615 	ld	_d_size+0, a
                                    616 ;	main.c: 174: }
      008583 5B 02            [ 2]  617 	addw	sp, #2
      008585 81               [ 4]  618 	ret
                                    619 ;	main.c: 175: void char_buffer_to_int(void)
                                    620 ;	-----------------------------------------
                                    621 ;	 function char_buffer_to_int
                                    622 ;	-----------------------------------------
      008586                        623 _char_buffer_to_int:
      008586 52 0C            [ 2]  624 	sub	sp, #12
                                    625 ;	main.c: 177: memset(a, 0, sizeof(a));
      008588 4B 03            [ 1]  626 	push	#0x03
      00858A 4B 00            [ 1]  627 	push	#0x00
      00858C 5F               [ 1]  628 	clrw	x
      00858D 89               [ 2]  629 	pushw	x
      00858E AE 01 00         [ 2]  630 	ldw	x, #(_a+0)
      008591 CD 8B E1         [ 4]  631 	call	_memset
                                    632 ;	main.c: 178: uint8_t counter = d_size;
      008594 C6 01 05         [ 1]  633 	ld	a, _d_size+0
      008597 6B 05            [ 1]  634 	ld	(0x05, sp), a
                                    635 ;	main.c: 179: uint8_t i = p_bytes;
      008599 C6 01 06         [ 1]  636 	ld	a, _p_bytes+0
      00859C 6B 06            [ 1]  637 	ld	(0x06, sp), a
                                    638 ;	main.c: 182: for(int o = 0; o < counter;o++)
      00859E 0F 08            [ 1]  639 	clr	(0x08, sp)
      0085A0 5F               [ 1]  640 	clrw	x
      0085A1 1F 09            [ 2]  641 	ldw	(0x09, sp), x
      0085A3                        642 00112$:
      0085A3 7B 05            [ 1]  643 	ld	a, (0x05, sp)
      0085A5 6B 0C            [ 1]  644 	ld	(0x0c, sp), a
      0085A7 0F 0B            [ 1]  645 	clr	(0x0b, sp)
      0085A9 1E 09            [ 2]  646 	ldw	x, (0x09, sp)
      0085AB 13 0B            [ 2]  647 	cpw	x, (0x0b, sp)
      0085AD 2F 03            [ 1]  648 	jrslt	00142$
      0085AF CC 86 58         [ 2]  649 	jp	00114$
      0085B2                        650 00142$:
                                    651 ;	main.c: 184: uint8_t number_counter = 0;
      0085B2 0F 07            [ 1]  652 	clr	(0x07, sp)
                                    653 ;	main.c: 185: while(1)
      0085B4 7B 06            [ 1]  654 	ld	a, (0x06, sp)
      0085B6 6B 0B            [ 1]  655 	ld	(0x0b, sp), a
      0085B8 0F 0C            [ 1]  656 	clr	(0x0c, sp)
      0085BA                        657 00108$:
                                    658 ;	main.c: 187: char rx_binary_chars1[4]={0};
      0085BA 0F 01            [ 1]  659 	clr	(0x01, sp)
      0085BC 0F 02            [ 1]  660 	clr	(0x02, sp)
      0085BE 0F 03            [ 1]  661 	clr	(0x03, sp)
      0085C0 0F 04            [ 1]  662 	clr	(0x04, sp)
                                    663 ;	main.c: 188: convert_int_to_chars(i, rx_binary_chars1);
      0085C2 96               [ 1]  664 	ldw	x, sp
      0085C3 5C               [ 1]  665 	incw	x
      0085C4 7B 0B            [ 1]  666 	ld	a, (0x0b, sp)
      0085C6 CD 83 C7         [ 4]  667 	call	_convert_int_to_chars
                                    668 ;	main.c: 189: uart_write("\ni while-> -> ");
      0085C9 AE 80 48         [ 2]  669 	ldw	x, #(___str_3+0)
      0085CC CD 83 66         [ 4]  670 	call	_uart_write
                                    671 ;	main.c: 190: uart_write(rx_binary_chars1);
      0085CF 96               [ 1]  672 	ldw	x, sp
      0085D0 5C               [ 1]  673 	incw	x
      0085D1 CD 83 66         [ 4]  674 	call	_uart_write
                                    675 ;	main.c: 191: uart_write(" <-\n");
      0085D4 AE 80 37         [ 2]  676 	ldw	x, #(___str_1+0)
      0085D7 CD 83 66         [ 4]  677 	call	_uart_write
                                    678 ;	main.c: 192: if(buffer[i] == ' ')
      0085DA 5F               [ 1]  679 	clrw	x
      0085DB 7B 0B            [ 1]  680 	ld	a, (0x0b, sp)
      0085DD 97               [ 1]  681 	ld	xl, a
      0085DE D6 00 01         [ 1]  682 	ld	a, (_buffer+0, x)
      0085E1 A1 20            [ 1]  683 	cp	a, #0x20
      0085E3 26 04            [ 1]  684 	jrne	00105$
                                    685 ;	main.c: 194: i = i+1;
      0085E5 0C 06            [ 1]  686 	inc	(0x06, sp)
                                    687 ;	main.c: 195: break;
      0085E7 20 12            [ 2]  688 	jra	00109$
      0085E9                        689 00105$:
                                    690 ;	main.c: 197: else if(buffer[i] == '\r\n')
      0085E9 A1 0D            [ 1]  691 	cp	a, #0x0d
      0085EB 27 0E            [ 1]  692 	jreq	00109$
                                    693 ;	main.c: 200: i++;
      0085ED 0C 0B            [ 1]  694 	inc	(0x0b, sp)
      0085EF 7B 0B            [ 1]  695 	ld	a, (0x0b, sp)
      0085F1 6B 06            [ 1]  696 	ld	(0x06, sp), a
                                    697 ;	main.c: 202: number_counter++;
      0085F3 0C 0C            [ 1]  698 	inc	(0x0c, sp)
      0085F5 7B 0C            [ 1]  699 	ld	a, (0x0c, sp)
      0085F7 6B 07            [ 1]  700 	ld	(0x07, sp), a
      0085F9 20 BF            [ 2]  701 	jra	00108$
      0085FB                        702 00109$:
                                    703 ;	main.c: 204: memcpy(a, &buffer[i - number_counter], number_counter);
      0085FB 90 5F            [ 1]  704 	clrw	y
      0085FD 7B 07            [ 1]  705 	ld	a, (0x07, sp)
      0085FF 90 97            [ 1]  706 	ld	yl, a
      008601 5F               [ 1]  707 	clrw	x
      008602 7B 06            [ 1]  708 	ld	a, (0x06, sp)
      008604 97               [ 1]  709 	ld	xl, a
      008605 7B 07            [ 1]  710 	ld	a, (0x07, sp)
      008607 6B 0C            [ 1]  711 	ld	(0x0c, sp), a
      008609 0F 0B            [ 1]  712 	clr	(0x0b, sp)
      00860B 72 F0 0B         [ 2]  713 	subw	x, (0x0b, sp)
      00860E 1C 00 01         [ 2]  714 	addw	x, #(_buffer+0)
      008611 90 89            [ 2]  715 	pushw	y
      008613 89               [ 2]  716 	pushw	x
      008614 AE 01 00         [ 2]  717 	ldw	x, #(_a+0)
      008617 CD 8B 8E         [ 4]  718 	call	___memcpy
                                    719 ;	main.c: 205: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      00861A 5F               [ 1]  720 	clrw	x
      00861B 7B 08            [ 1]  721 	ld	a, (0x08, sp)
      00861D 97               [ 1]  722 	ld	xl, a
      00861E 1C 01 07         [ 2]  723 	addw	x, #(_data_buf+0)
      008621 89               [ 2]  724 	pushw	x
      008622 16 0D            [ 2]  725 	ldw	y, (0x0d, sp)
      008624 90 89            [ 2]  726 	pushw	y
      008626 AE 01 00         [ 2]  727 	ldw	x, #(_a+0)
      008629 CD 84 4C         [ 4]  728 	call	_convert_chars_to_int
      00862C 85               [ 2]  729 	popw	x
      00862D F7               [ 1]  730 	ld	(x), a
                                    731 ;	main.c: 207: char rx_binary_chars[4]={0};
      00862E 0F 01            [ 1]  732 	clr	(0x01, sp)
      008630 0F 02            [ 1]  733 	clr	(0x02, sp)
      008632 0F 03            [ 1]  734 	clr	(0x03, sp)
      008634 0F 04            [ 1]  735 	clr	(0x04, sp)
                                    736 ;	main.c: 208: convert_int_to_chars(i, rx_binary_chars);
      008636 96               [ 1]  737 	ldw	x, sp
      008637 5C               [ 1]  738 	incw	x
      008638 7B 06            [ 1]  739 	ld	a, (0x06, sp)
      00863A CD 83 C7         [ 4]  740 	call	_convert_int_to_chars
                                    741 ;	main.c: 209: uart_write("\ni -> -> ");
      00863D AE 80 57         [ 2]  742 	ldw	x, #(___str_4+0)
      008640 CD 83 66         [ 4]  743 	call	_uart_write
                                    744 ;	main.c: 210: uart_write(rx_binary_chars);
      008643 96               [ 1]  745 	ldw	x, sp
      008644 5C               [ 1]  746 	incw	x
      008645 CD 83 66         [ 4]  747 	call	_uart_write
                                    748 ;	main.c: 211: uart_write(" <-\n");
      008648 AE 80 37         [ 2]  749 	ldw	x, #(___str_1+0)
      00864B CD 83 66         [ 4]  750 	call	_uart_write
                                    751 ;	main.c: 212: int_buf_i++;
      00864E 0C 08            [ 1]  752 	inc	(0x08, sp)
                                    753 ;	main.c: 182: for(int o = 0; o < counter;o++)
      008650 1E 09            [ 2]  754 	ldw	x, (0x09, sp)
      008652 5C               [ 1]  755 	incw	x
      008653 1F 09            [ 2]  756 	ldw	(0x09, sp), x
      008655 CC 85 A3         [ 2]  757 	jp	00112$
      008658                        758 00114$:
                                    759 ;	main.c: 214: }
      008658 5B 0C            [ 2]  760 	addw	sp, #12
      00865A 81               [ 4]  761 	ret
                                    762 ;	main.c: 222: void status_check(void){
                                    763 ;	-----------------------------------------
                                    764 ;	 function status_check
                                    765 ;	-----------------------------------------
      00865B                        766 _status_check:
      00865B 52 09            [ 2]  767 	sub	sp, #9
                                    768 ;	main.c: 223: char rx_binary_chars[9]={0};
      00865D 0F 01            [ 1]  769 	clr	(0x01, sp)
      00865F 0F 02            [ 1]  770 	clr	(0x02, sp)
      008661 0F 03            [ 1]  771 	clr	(0x03, sp)
      008663 0F 04            [ 1]  772 	clr	(0x04, sp)
      008665 0F 05            [ 1]  773 	clr	(0x05, sp)
      008667 0F 06            [ 1]  774 	clr	(0x06, sp)
      008669 0F 07            [ 1]  775 	clr	(0x07, sp)
      00866B 0F 08            [ 1]  776 	clr	(0x08, sp)
      00866D 0F 09            [ 1]  777 	clr	(0x09, sp)
                                    778 ;	main.c: 224: uart_write("\nI2C_REGS >.<\n");
      00866F AE 80 61         [ 2]  779 	ldw	x, #(___str_5+0)
      008672 CD 83 66         [ 4]  780 	call	_uart_write
                                    781 ;	main.c: 225: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      008675 96               [ 1]  782 	ldw	x, sp
      008676 5C               [ 1]  783 	incw	x
      008677 51               [ 1]  784 	exgw	x, y
      008678 C6 52 17         [ 1]  785 	ld	a, 0x5217
      00867B 5F               [ 1]  786 	clrw	x
      00867C 90 89            [ 2]  787 	pushw	y
      00867E 97               [ 1]  788 	ld	xl, a
      00867F CD 84 AF         [ 4]  789 	call	_convert_int_to_binary
                                    790 ;	main.c: 226: uart_write("\nSR1 -> ");
      008682 AE 80 70         [ 2]  791 	ldw	x, #(___str_6+0)
      008685 CD 83 66         [ 4]  792 	call	_uart_write
                                    793 ;	main.c: 227: uart_write(rx_binary_chars);
      008688 96               [ 1]  794 	ldw	x, sp
      008689 5C               [ 1]  795 	incw	x
      00868A CD 83 66         [ 4]  796 	call	_uart_write
                                    797 ;	main.c: 228: uart_write(" <-\n");
      00868D AE 80 37         [ 2]  798 	ldw	x, #(___str_1+0)
      008690 CD 83 66         [ 4]  799 	call	_uart_write
                                    800 ;	main.c: 229: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008693 96               [ 1]  801 	ldw	x, sp
      008694 5C               [ 1]  802 	incw	x
      008695 51               [ 1]  803 	exgw	x, y
      008696 C6 52 18         [ 1]  804 	ld	a, 0x5218
      008699 5F               [ 1]  805 	clrw	x
      00869A 90 89            [ 2]  806 	pushw	y
      00869C 97               [ 1]  807 	ld	xl, a
      00869D CD 84 AF         [ 4]  808 	call	_convert_int_to_binary
                                    809 ;	main.c: 230: uart_write("SR2 -> ");
      0086A0 AE 80 79         [ 2]  810 	ldw	x, #(___str_7+0)
      0086A3 CD 83 66         [ 4]  811 	call	_uart_write
                                    812 ;	main.c: 231: uart_write(rx_binary_chars);
      0086A6 96               [ 1]  813 	ldw	x, sp
      0086A7 5C               [ 1]  814 	incw	x
      0086A8 CD 83 66         [ 4]  815 	call	_uart_write
                                    816 ;	main.c: 232: uart_write(" <-\n");
      0086AB AE 80 37         [ 2]  817 	ldw	x, #(___str_1+0)
      0086AE CD 83 66         [ 4]  818 	call	_uart_write
                                    819 ;	main.c: 233: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0086B1 96               [ 1]  820 	ldw	x, sp
      0086B2 5C               [ 1]  821 	incw	x
      0086B3 51               [ 1]  822 	exgw	x, y
      0086B4 C6 52 19         [ 1]  823 	ld	a, 0x5219
      0086B7 5F               [ 1]  824 	clrw	x
      0086B8 90 89            [ 2]  825 	pushw	y
      0086BA 97               [ 1]  826 	ld	xl, a
      0086BB CD 84 AF         [ 4]  827 	call	_convert_int_to_binary
                                    828 ;	main.c: 234: uart_write("SR3 -> ");
      0086BE AE 80 81         [ 2]  829 	ldw	x, #(___str_8+0)
      0086C1 CD 83 66         [ 4]  830 	call	_uart_write
                                    831 ;	main.c: 235: uart_write(rx_binary_chars);
      0086C4 96               [ 1]  832 	ldw	x, sp
      0086C5 5C               [ 1]  833 	incw	x
      0086C6 CD 83 66         [ 4]  834 	call	_uart_write
                                    835 ;	main.c: 236: uart_write(" <-\n");
      0086C9 AE 80 37         [ 2]  836 	ldw	x, #(___str_1+0)
      0086CC CD 83 66         [ 4]  837 	call	_uart_write
                                    838 ;	main.c: 237: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      0086CF 96               [ 1]  839 	ldw	x, sp
      0086D0 5C               [ 1]  840 	incw	x
      0086D1 51               [ 1]  841 	exgw	x, y
      0086D2 C6 52 10         [ 1]  842 	ld	a, 0x5210
      0086D5 5F               [ 1]  843 	clrw	x
      0086D6 90 89            [ 2]  844 	pushw	y
      0086D8 97               [ 1]  845 	ld	xl, a
      0086D9 CD 84 AF         [ 4]  846 	call	_convert_int_to_binary
                                    847 ;	main.c: 238: uart_write("CR1 -> ");
      0086DC AE 80 89         [ 2]  848 	ldw	x, #(___str_9+0)
      0086DF CD 83 66         [ 4]  849 	call	_uart_write
                                    850 ;	main.c: 239: uart_write(rx_binary_chars);
      0086E2 96               [ 1]  851 	ldw	x, sp
      0086E3 5C               [ 1]  852 	incw	x
      0086E4 CD 83 66         [ 4]  853 	call	_uart_write
                                    854 ;	main.c: 240: uart_write(" <-\n");
      0086E7 AE 80 37         [ 2]  855 	ldw	x, #(___str_1+0)
      0086EA CD 83 66         [ 4]  856 	call	_uart_write
                                    857 ;	main.c: 241: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      0086ED 96               [ 1]  858 	ldw	x, sp
      0086EE 5C               [ 1]  859 	incw	x
      0086EF 51               [ 1]  860 	exgw	x, y
      0086F0 C6 52 11         [ 1]  861 	ld	a, 0x5211
      0086F3 5F               [ 1]  862 	clrw	x
      0086F4 90 89            [ 2]  863 	pushw	y
      0086F6 97               [ 1]  864 	ld	xl, a
      0086F7 CD 84 AF         [ 4]  865 	call	_convert_int_to_binary
                                    866 ;	main.c: 242: uart_write("CR2 -> ");
      0086FA AE 80 91         [ 2]  867 	ldw	x, #(___str_10+0)
      0086FD CD 83 66         [ 4]  868 	call	_uart_write
                                    869 ;	main.c: 243: uart_write(rx_binary_chars);
      008700 96               [ 1]  870 	ldw	x, sp
      008701 5C               [ 1]  871 	incw	x
      008702 CD 83 66         [ 4]  872 	call	_uart_write
                                    873 ;	main.c: 244: uart_write(" <-\n");
      008705 AE 80 37         [ 2]  874 	ldw	x, #(___str_1+0)
      008708 CD 83 66         [ 4]  875 	call	_uart_write
                                    876 ;	main.c: 245: convert_int_to_binary(I2C_DR, rx_binary_chars);
      00870B 96               [ 1]  877 	ldw	x, sp
      00870C 5C               [ 1]  878 	incw	x
      00870D 51               [ 1]  879 	exgw	x, y
      00870E C6 52 16         [ 1]  880 	ld	a, 0x5216
      008711 5F               [ 1]  881 	clrw	x
      008712 90 89            [ 2]  882 	pushw	y
      008714 97               [ 1]  883 	ld	xl, a
      008715 CD 84 AF         [ 4]  884 	call	_convert_int_to_binary
                                    885 ;	main.c: 246: uart_write("DR -> ");
      008718 AE 80 99         [ 2]  886 	ldw	x, #(___str_11+0)
      00871B CD 83 66         [ 4]  887 	call	_uart_write
                                    888 ;	main.c: 247: uart_write(rx_binary_chars);
      00871E 96               [ 1]  889 	ldw	x, sp
      00871F 5C               [ 1]  890 	incw	x
      008720 CD 83 66         [ 4]  891 	call	_uart_write
                                    892 ;	main.c: 248: uart_write(" <-\n");
      008723 AE 80 37         [ 2]  893 	ldw	x, #(___str_1+0)
      008726 CD 83 66         [ 4]  894 	call	_uart_write
                                    895 ;	main.c: 249: uart_write("UART_REGS >.<\n");
      008729 AE 80 A0         [ 2]  896 	ldw	x, #(___str_12+0)
      00872C CD 83 66         [ 4]  897 	call	_uart_write
                                    898 ;	main.c: 250: convert_int_to_binary(UART1_SR, rx_binary_chars);
      00872F 96               [ 1]  899 	ldw	x, sp
      008730 5C               [ 1]  900 	incw	x
      008731 51               [ 1]  901 	exgw	x, y
      008732 C6 52 30         [ 1]  902 	ld	a, 0x5230
      008735 5F               [ 1]  903 	clrw	x
      008736 90 89            [ 2]  904 	pushw	y
      008738 97               [ 1]  905 	ld	xl, a
      008739 CD 84 AF         [ 4]  906 	call	_convert_int_to_binary
                                    907 ;	main.c: 251: uart_write("\nSR -> ");
      00873C AE 80 AF         [ 2]  908 	ldw	x, #(___str_13+0)
      00873F CD 83 66         [ 4]  909 	call	_uart_write
                                    910 ;	main.c: 252: uart_write(rx_binary_chars);
      008742 96               [ 1]  911 	ldw	x, sp
      008743 5C               [ 1]  912 	incw	x
      008744 CD 83 66         [ 4]  913 	call	_uart_write
                                    914 ;	main.c: 253: uart_write(" <-\n");
      008747 AE 80 37         [ 2]  915 	ldw	x, #(___str_1+0)
      00874A CD 83 66         [ 4]  916 	call	_uart_write
                                    917 ;	main.c: 254: convert_int_to_binary(UART1_DR, rx_binary_chars);
      00874D 96               [ 1]  918 	ldw	x, sp
      00874E 5C               [ 1]  919 	incw	x
      00874F 51               [ 1]  920 	exgw	x, y
      008750 C6 52 31         [ 1]  921 	ld	a, 0x5231
      008753 5F               [ 1]  922 	clrw	x
      008754 90 89            [ 2]  923 	pushw	y
      008756 97               [ 1]  924 	ld	xl, a
      008757 CD 84 AF         [ 4]  925 	call	_convert_int_to_binary
                                    926 ;	main.c: 255: uart_write("DR -> ");
      00875A AE 80 99         [ 2]  927 	ldw	x, #(___str_11+0)
      00875D CD 83 66         [ 4]  928 	call	_uart_write
                                    929 ;	main.c: 256: uart_write(rx_binary_chars);
      008760 96               [ 1]  930 	ldw	x, sp
      008761 5C               [ 1]  931 	incw	x
      008762 CD 83 66         [ 4]  932 	call	_uart_write
                                    933 ;	main.c: 257: uart_write(" <-\n");
      008765 AE 80 37         [ 2]  934 	ldw	x, #(___str_1+0)
      008768 CD 83 66         [ 4]  935 	call	_uart_write
                                    936 ;	main.c: 258: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
      00876B 96               [ 1]  937 	ldw	x, sp
      00876C 5C               [ 1]  938 	incw	x
      00876D 51               [ 1]  939 	exgw	x, y
      00876E C6 52 32         [ 1]  940 	ld	a, 0x5232
      008771 5F               [ 1]  941 	clrw	x
      008772 90 89            [ 2]  942 	pushw	y
      008774 97               [ 1]  943 	ld	xl, a
      008775 CD 84 AF         [ 4]  944 	call	_convert_int_to_binary
                                    945 ;	main.c: 259: uart_write("BRR1 -> ");
      008778 AE 80 B7         [ 2]  946 	ldw	x, #(___str_14+0)
      00877B CD 83 66         [ 4]  947 	call	_uart_write
                                    948 ;	main.c: 260: uart_write(rx_binary_chars);
      00877E 96               [ 1]  949 	ldw	x, sp
      00877F 5C               [ 1]  950 	incw	x
      008780 CD 83 66         [ 4]  951 	call	_uart_write
                                    952 ;	main.c: 261: uart_write(" <-\n");
      008783 AE 80 37         [ 2]  953 	ldw	x, #(___str_1+0)
      008786 CD 83 66         [ 4]  954 	call	_uart_write
                                    955 ;	main.c: 262: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
      008789 96               [ 1]  956 	ldw	x, sp
      00878A 5C               [ 1]  957 	incw	x
      00878B 51               [ 1]  958 	exgw	x, y
      00878C C6 52 33         [ 1]  959 	ld	a, 0x5233
      00878F 5F               [ 1]  960 	clrw	x
      008790 90 89            [ 2]  961 	pushw	y
      008792 97               [ 1]  962 	ld	xl, a
      008793 CD 84 AF         [ 4]  963 	call	_convert_int_to_binary
                                    964 ;	main.c: 263: uart_write("BRR2 -> ");
      008796 AE 80 C0         [ 2]  965 	ldw	x, #(___str_15+0)
      008799 CD 83 66         [ 4]  966 	call	_uart_write
                                    967 ;	main.c: 264: uart_write(rx_binary_chars);
      00879C 96               [ 1]  968 	ldw	x, sp
      00879D 5C               [ 1]  969 	incw	x
      00879E CD 83 66         [ 4]  970 	call	_uart_write
                                    971 ;	main.c: 265: uart_write(" <-\n");
      0087A1 AE 80 37         [ 2]  972 	ldw	x, #(___str_1+0)
      0087A4 CD 83 66         [ 4]  973 	call	_uart_write
                                    974 ;	main.c: 266: convert_int_to_binary(UART1_CR1, rx_binary_chars);
      0087A7 96               [ 1]  975 	ldw	x, sp
      0087A8 5C               [ 1]  976 	incw	x
      0087A9 51               [ 1]  977 	exgw	x, y
      0087AA C6 52 34         [ 1]  978 	ld	a, 0x5234
      0087AD 5F               [ 1]  979 	clrw	x
      0087AE 90 89            [ 2]  980 	pushw	y
      0087B0 97               [ 1]  981 	ld	xl, a
      0087B1 CD 84 AF         [ 4]  982 	call	_convert_int_to_binary
                                    983 ;	main.c: 267: uart_write("CR1 -> ");
      0087B4 AE 80 89         [ 2]  984 	ldw	x, #(___str_9+0)
      0087B7 CD 83 66         [ 4]  985 	call	_uart_write
                                    986 ;	main.c: 268: uart_write(rx_binary_chars);
      0087BA 96               [ 1]  987 	ldw	x, sp
      0087BB 5C               [ 1]  988 	incw	x
      0087BC CD 83 66         [ 4]  989 	call	_uart_write
                                    990 ;	main.c: 269: uart_write(" <-\n");
      0087BF AE 80 37         [ 2]  991 	ldw	x, #(___str_1+0)
      0087C2 CD 83 66         [ 4]  992 	call	_uart_write
                                    993 ;	main.c: 270: convert_int_to_binary(UART1_CR2, rx_binary_chars);
      0087C5 96               [ 1]  994 	ldw	x, sp
      0087C6 5C               [ 1]  995 	incw	x
      0087C7 51               [ 1]  996 	exgw	x, y
      0087C8 C6 52 35         [ 1]  997 	ld	a, 0x5235
      0087CB 5F               [ 1]  998 	clrw	x
      0087CC 90 89            [ 2]  999 	pushw	y
      0087CE 97               [ 1] 1000 	ld	xl, a
      0087CF CD 84 AF         [ 4] 1001 	call	_convert_int_to_binary
                                   1002 ;	main.c: 271: uart_write("CR2 -> ");
      0087D2 AE 80 91         [ 2] 1003 	ldw	x, #(___str_10+0)
      0087D5 CD 83 66         [ 4] 1004 	call	_uart_write
                                   1005 ;	main.c: 272: uart_write(rx_binary_chars);
      0087D8 96               [ 1] 1006 	ldw	x, sp
      0087D9 5C               [ 1] 1007 	incw	x
      0087DA CD 83 66         [ 4] 1008 	call	_uart_write
                                   1009 ;	main.c: 273: uart_write(" <-\n");
      0087DD AE 80 37         [ 2] 1010 	ldw	x, #(___str_1+0)
      0087E0 CD 83 66         [ 4] 1011 	call	_uart_write
                                   1012 ;	main.c: 274: convert_int_to_binary(UART1_CR3, rx_binary_chars);
      0087E3 96               [ 1] 1013 	ldw	x, sp
      0087E4 5C               [ 1] 1014 	incw	x
      0087E5 51               [ 1] 1015 	exgw	x, y
      0087E6 C6 52 36         [ 1] 1016 	ld	a, 0x5236
      0087E9 5F               [ 1] 1017 	clrw	x
      0087EA 90 89            [ 2] 1018 	pushw	y
      0087EC 97               [ 1] 1019 	ld	xl, a
      0087ED CD 84 AF         [ 4] 1020 	call	_convert_int_to_binary
                                   1021 ;	main.c: 275: uart_write("CR3 -> ");
      0087F0 AE 80 C9         [ 2] 1022 	ldw	x, #(___str_16+0)
      0087F3 CD 83 66         [ 4] 1023 	call	_uart_write
                                   1024 ;	main.c: 276: uart_write(rx_binary_chars);
      0087F6 96               [ 1] 1025 	ldw	x, sp
      0087F7 5C               [ 1] 1026 	incw	x
      0087F8 CD 83 66         [ 4] 1027 	call	_uart_write
                                   1028 ;	main.c: 277: uart_write(" <-\n");
      0087FB AE 80 37         [ 2] 1029 	ldw	x, #(___str_1+0)
      0087FE CD 83 66         [ 4] 1030 	call	_uart_write
                                   1031 ;	main.c: 278: convert_int_to_binary(UART1_CR4, rx_binary_chars);
      008801 96               [ 1] 1032 	ldw	x, sp
      008802 5C               [ 1] 1033 	incw	x
      008803 51               [ 1] 1034 	exgw	x, y
      008804 C6 52 37         [ 1] 1035 	ld	a, 0x5237
      008807 5F               [ 1] 1036 	clrw	x
      008808 90 89            [ 2] 1037 	pushw	y
      00880A 97               [ 1] 1038 	ld	xl, a
      00880B CD 84 AF         [ 4] 1039 	call	_convert_int_to_binary
                                   1040 ;	main.c: 279: uart_write("CR4 -> ");
      00880E AE 80 D1         [ 2] 1041 	ldw	x, #(___str_17+0)
      008811 CD 83 66         [ 4] 1042 	call	_uart_write
                                   1043 ;	main.c: 280: uart_write(rx_binary_chars);
      008814 96               [ 1] 1044 	ldw	x, sp
      008815 5C               [ 1] 1045 	incw	x
      008816 CD 83 66         [ 4] 1046 	call	_uart_write
                                   1047 ;	main.c: 281: uart_write(" <-\n");
      008819 AE 80 37         [ 2] 1048 	ldw	x, #(___str_1+0)
      00881C CD 83 66         [ 4] 1049 	call	_uart_write
                                   1050 ;	main.c: 282: convert_int_to_binary(UART1_CR5, rx_binary_chars);
      00881F 96               [ 1] 1051 	ldw	x, sp
      008820 5C               [ 1] 1052 	incw	x
      008821 51               [ 1] 1053 	exgw	x, y
      008822 C6 52 38         [ 1] 1054 	ld	a, 0x5238
      008825 5F               [ 1] 1055 	clrw	x
      008826 90 89            [ 2] 1056 	pushw	y
      008828 97               [ 1] 1057 	ld	xl, a
      008829 CD 84 AF         [ 4] 1058 	call	_convert_int_to_binary
                                   1059 ;	main.c: 283: uart_write("CR5 -> ");
      00882C AE 80 D9         [ 2] 1060 	ldw	x, #(___str_18+0)
      00882F CD 83 66         [ 4] 1061 	call	_uart_write
                                   1062 ;	main.c: 284: uart_write(rx_binary_chars);
      008832 96               [ 1] 1063 	ldw	x, sp
      008833 5C               [ 1] 1064 	incw	x
      008834 CD 83 66         [ 4] 1065 	call	_uart_write
                                   1066 ;	main.c: 285: uart_write(" <-\n");
      008837 AE 80 37         [ 2] 1067 	ldw	x, #(___str_1+0)
      00883A CD 83 66         [ 4] 1068 	call	_uart_write
                                   1069 ;	main.c: 286: convert_int_to_binary(UART1_GTR, rx_binary_chars);
      00883D 96               [ 1] 1070 	ldw	x, sp
      00883E 5C               [ 1] 1071 	incw	x
      00883F 51               [ 1] 1072 	exgw	x, y
      008840 C6 52 39         [ 1] 1073 	ld	a, 0x5239
      008843 5F               [ 1] 1074 	clrw	x
      008844 90 89            [ 2] 1075 	pushw	y
      008846 97               [ 1] 1076 	ld	xl, a
      008847 CD 84 AF         [ 4] 1077 	call	_convert_int_to_binary
                                   1078 ;	main.c: 287: uart_write("GTR -> ");
      00884A AE 80 E1         [ 2] 1079 	ldw	x, #(___str_19+0)
      00884D CD 83 66         [ 4] 1080 	call	_uart_write
                                   1081 ;	main.c: 288: uart_write(rx_binary_chars);
      008850 96               [ 1] 1082 	ldw	x, sp
      008851 5C               [ 1] 1083 	incw	x
      008852 CD 83 66         [ 4] 1084 	call	_uart_write
                                   1085 ;	main.c: 289: uart_write(" <-\n");
      008855 AE 80 37         [ 2] 1086 	ldw	x, #(___str_1+0)
      008858 CD 83 66         [ 4] 1087 	call	_uart_write
                                   1088 ;	main.c: 290: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
      00885B 96               [ 1] 1089 	ldw	x, sp
      00885C 5C               [ 1] 1090 	incw	x
      00885D 51               [ 1] 1091 	exgw	x, y
      00885E C6 52 3A         [ 1] 1092 	ld	a, 0x523a
      008861 5F               [ 1] 1093 	clrw	x
      008862 90 89            [ 2] 1094 	pushw	y
      008864 97               [ 1] 1095 	ld	xl, a
      008865 CD 84 AF         [ 4] 1096 	call	_convert_int_to_binary
                                   1097 ;	main.c: 291: uart_write("PSCR -> ");
      008868 AE 80 E9         [ 2] 1098 	ldw	x, #(___str_20+0)
      00886B CD 83 66         [ 4] 1099 	call	_uart_write
                                   1100 ;	main.c: 292: uart_write(rx_binary_chars);
      00886E 96               [ 1] 1101 	ldw	x, sp
      00886F 5C               [ 1] 1102 	incw	x
      008870 CD 83 66         [ 4] 1103 	call	_uart_write
                                   1104 ;	main.c: 293: uart_write(" <-\n");
      008873 AE 80 37         [ 2] 1105 	ldw	x, #(___str_1+0)
      008876 CD 83 66         [ 4] 1106 	call	_uart_write
                                   1107 ;	main.c: 294: }
      008879 5B 09            [ 2] 1108 	addw	sp, #9
      00887B 81               [ 4] 1109 	ret
                                   1110 ;	main.c: 296: void uart_init(void){
                                   1111 ;	-----------------------------------------
                                   1112 ;	 function uart_init
                                   1113 ;	-----------------------------------------
      00887C                       1114 _uart_init:
                                   1115 ;	main.c: 297: CLK_CKDIVR = 0;
      00887C 35 00 50 C6      [ 1] 1116 	mov	0x50c6+0, #0x00
                                   1117 ;	main.c: 300: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008880 72 16 52 35      [ 1] 1118 	bset	0x5235, #3
                                   1119 ;	main.c: 301: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      008884 72 14 52 35      [ 1] 1120 	bset	0x5235, #2
                                   1121 ;	main.c: 302: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008888 C6 52 36         [ 1] 1122 	ld	a, 0x5236
      00888B A4 CF            [ 1] 1123 	and	a, #0xcf
      00888D C7 52 36         [ 1] 1124 	ld	0x5236, a
                                   1125 ;	main.c: 304: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008890 35 03 52 33      [ 1] 1126 	mov	0x5233+0, #0x03
      008894 35 68 52 32      [ 1] 1127 	mov	0x5232+0, #0x68
                                   1128 ;	main.c: 305: }
      008898 81               [ 4] 1129 	ret
                                   1130 ;	main.c: 309: void i2c_init(void) {
                                   1131 ;	-----------------------------------------
                                   1132 ;	 function i2c_init
                                   1133 ;	-----------------------------------------
      008899                       1134 _i2c_init:
                                   1135 ;	main.c: 315: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008899 72 11 52 10      [ 1] 1136 	bres	0x5210, #0
                                   1137 ;	main.c: 316: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      00889D 35 10 52 12      [ 1] 1138 	mov	0x5212+0, #0x10
                                   1139 ;	main.c: 317: I2C_CCRH = 0;                   // =0
      0088A1 35 00 52 1C      [ 1] 1140 	mov	0x521c+0, #0x00
                                   1141 ;	main.c: 318: I2C_CCRL = 80;                  // 100kHz for I2C
      0088A5 35 50 52 1B      [ 1] 1142 	mov	0x521b+0, #0x50
                                   1143 ;	main.c: 319: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0088A9 72 1F 52 1C      [ 1] 1144 	bres	0x521c, #7
                                   1145 ;	main.c: 320: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0088AD 72 1F 52 14      [ 1] 1146 	bres	0x5214, #7
                                   1147 ;	main.c: 321: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0088B1 72 1C 52 14      [ 1] 1148 	bset	0x5214, #6
                                   1149 ;	main.c: 322: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0088B5 72 10 52 10      [ 1] 1150 	bset	0x5210, #0
                                   1151 ;	main.c: 323: }
      0088B9 81               [ 4] 1152 	ret
                                   1153 ;	main.c: 332: void i2c_start(void) {
                                   1154 ;	-----------------------------------------
                                   1155 ;	 function i2c_start
                                   1156 ;	-----------------------------------------
      0088BA                       1157 _i2c_start:
                                   1158 ;	main.c: 333: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0088BA 72 10 52 11      [ 1] 1159 	bset	0x5211, #0
                                   1160 ;	main.c: 334: while(!(I2C_SR1 & (1 << 0)));
      0088BE                       1161 00101$:
      0088BE 72 01 52 17 FB   [ 2] 1162 	btjf	0x5217, #0, 00101$
                                   1163 ;	main.c: 336: }
      0088C3 81               [ 4] 1164 	ret
                                   1165 ;	main.c: 338: void i2c_send_address(uint8_t address) {
                                   1166 ;	-----------------------------------------
                                   1167 ;	 function i2c_send_address
                                   1168 ;	-----------------------------------------
      0088C4                       1169 _i2c_send_address:
                                   1170 ;	main.c: 339: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0088C4 48               [ 1] 1171 	sll	a
      0088C5 C7 52 16         [ 1] 1172 	ld	0x5216, a
                                   1173 ;	main.c: 340: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0088C8                       1174 00102$:
      0088C8 72 03 52 17 01   [ 2] 1175 	btjf	0x5217, #1, 00117$
      0088CD 81               [ 4] 1176 	ret
      0088CE                       1177 00117$:
      0088CE 72 05 52 18 F5   [ 2] 1178 	btjf	0x5218, #2, 00102$
                                   1179 ;	main.c: 341: }
      0088D3 81               [ 4] 1180 	ret
                                   1181 ;	main.c: 343: void i2c_stop(void) {
                                   1182 ;	-----------------------------------------
                                   1183 ;	 function i2c_stop
                                   1184 ;	-----------------------------------------
      0088D4                       1185 _i2c_stop:
                                   1186 ;	main.c: 344: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      0088D4 72 12 52 11      [ 1] 1187 	bset	0x5211, #1
                                   1188 ;	main.c: 346: }
      0088D8 81               [ 4] 1189 	ret
                                   1190 ;	main.c: 347: void i2c_write(void){
                                   1191 ;	-----------------------------------------
                                   1192 ;	 function i2c_write
                                   1193 ;	-----------------------------------------
      0088D9                       1194 _i2c_write:
      0088D9 52 02            [ 2] 1195 	sub	sp, #2
                                   1196 ;	main.c: 348: I2C_DR = d_addr; // Отправка адреса регистра
      0088DB 55 01 03 52 16   [ 1] 1197 	mov	0x5216+0, _d_addr+0
                                   1198 ;	main.c: 349: for(int i = 0;i < d_size;i++)
      0088E0 5F               [ 1] 1199 	clrw	x
      0088E1                       1200 00107$:
      0088E1 C6 01 05         [ 1] 1201 	ld	a, _d_size+0
      0088E4 6B 02            [ 1] 1202 	ld	(0x02, sp), a
      0088E6 0F 01            [ 1] 1203 	clr	(0x01, sp)
      0088E8 13 01            [ 2] 1204 	cpw	x, (0x01, sp)
      0088EA 2E 16            [ 1] 1205 	jrsge	00109$
                                   1206 ;	main.c: 351: I2C_DR = data_buf[i];
      0088EC 90 93            [ 1] 1207 	ldw	y, x
      0088EE 90 D6 01 07      [ 1] 1208 	ld	a, (_data_buf+0, y)
      0088F2 C7 52 16         [ 1] 1209 	ld	0x5216, a
                                   1210 ;	main.c: 352: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0088F5                       1211 00102$:
      0088F5 72 02 52 17 05   [ 2] 1212 	btjt	0x5217, #1, 00108$
      0088FA 72 05 52 18 F6   [ 2] 1213 	btjf	0x5218, #2, 00102$
      0088FF                       1214 00108$:
                                   1215 ;	main.c: 349: for(int i = 0;i < d_size;i++)
      0088FF 5C               [ 1] 1216 	incw	x
      008900 20 DF            [ 2] 1217 	jra	00107$
      008902                       1218 00109$:
                                   1219 ;	main.c: 354: }
      008902 5B 02            [ 2] 1220 	addw	sp, #2
      008904 81               [ 4] 1221 	ret
                                   1222 ;	main.c: 356: void i2c_read(void){
                                   1223 ;	-----------------------------------------
                                   1224 ;	 function i2c_read
                                   1225 ;	-----------------------------------------
      008905                       1226 _i2c_read:
      008905 52 02            [ 2] 1227 	sub	sp, #2
                                   1228 ;	main.c: 357: I2C_DR = (current_dev << 1) & (1 << 0);
      008907 C6 02 06         [ 1] 1229 	ld	a, _current_dev+0
      00890A 48               [ 1] 1230 	sll	a
      00890B A4 01            [ 1] 1231 	and	a, #0x01
      00890D C7 52 16         [ 1] 1232 	ld	0x5216, a
                                   1233 ;	main.c: 358: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008910                       1234 00102$:
      008910 72 02 52 17 05   [ 2] 1235 	btjt	0x5217, #1, 00104$
      008915 72 05 52 18 F6   [ 2] 1236 	btjf	0x5218, #2, 00102$
      00891A                       1237 00104$:
                                   1238 ;	main.c: 360: I2C_DR = d_addr;
      00891A 55 01 03 52 16   [ 1] 1239 	mov	0x5216+0, _d_addr+0
                                   1240 ;	main.c: 361: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00891F                       1241 00106$:
      00891F 72 02 52 17 05   [ 2] 1242 	btjt	0x5217, #1, 00108$
      008924 72 05 52 18 F6   [ 2] 1243 	btjf	0x5218, #2, 00106$
      008929                       1244 00108$:
                                   1245 ;	main.c: 362: i2c_stop();
      008929 CD 88 D4         [ 4] 1246 	call	_i2c_stop
                                   1247 ;	main.c: 363: for(int i = 0;i < d_size;i++)
      00892C 5F               [ 1] 1248 	clrw	x
      00892D                       1249 00115$:
      00892D C6 01 05         [ 1] 1250 	ld	a, _d_size+0
      008930 6B 02            [ 1] 1251 	ld	(0x02, sp), a
      008932 0F 01            [ 1] 1252 	clr	(0x01, sp)
      008934 13 01            [ 2] 1253 	cpw	x, (0x01, sp)
      008936 2E 13            [ 1] 1254 	jrsge	00117$
                                   1255 ;	main.c: 365: data_buf[i] = I2C_DR;
      008938 C6 52 16         [ 1] 1256 	ld	a, 0x5216
      00893B D7 01 07         [ 1] 1257 	ld	((_data_buf+0), x), a
                                   1258 ;	main.c: 366: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00893E                       1259 00110$:
      00893E 72 02 52 17 05   [ 2] 1260 	btjt	0x5217, #1, 00116$
      008943 72 05 52 18 F6   [ 2] 1261 	btjf	0x5218, #2, 00110$
      008948                       1262 00116$:
                                   1263 ;	main.c: 363: for(int i = 0;i < d_size;i++)
      008948 5C               [ 1] 1264 	incw	x
      008949 20 E2            [ 2] 1265 	jra	00115$
      00894B                       1266 00117$:
                                   1267 ;	main.c: 369: }
      00894B 5B 02            [ 2] 1268 	addw	sp, #2
      00894D 81               [ 4] 1269 	ret
                                   1270 ;	main.c: 370: void i2c_scan(void) {
                                   1271 ;	-----------------------------------------
                                   1272 ;	 function i2c_scan
                                   1273 ;	-----------------------------------------
      00894E                       1274 _i2c_scan:
      00894E 52 02            [ 2] 1275 	sub	sp, #2
                                   1276 ;	main.c: 371: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008950 C6 02 06         [ 1] 1277 	ld	a, _current_dev+0
      008953 6B 01            [ 1] 1278 	ld	(0x01, sp), a
      008955 6B 02            [ 1] 1279 	ld	(0x02, sp), a
      008957                       1280 00105$:
      008957 7B 02            [ 1] 1281 	ld	a, (0x02, sp)
      008959 A1 7F            [ 1] 1282 	cp	a, #0x7f
      00895B 24 26            [ 1] 1283 	jrnc	00107$
                                   1284 ;	main.c: 372: i2c_start();
      00895D CD 88 BA         [ 4] 1285 	call	_i2c_start
                                   1286 ;	main.c: 373: i2c_send_address(addr);
      008960 7B 02            [ 1] 1287 	ld	a, (0x02, sp)
      008962 CD 88 C4         [ 4] 1288 	call	_i2c_send_address
                                   1289 ;	main.c: 374: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      008965 72 04 52 18 0A   [ 2] 1290 	btjt	0x5218, #2, 00102$
                                   1291 ;	main.c: 376: current_dev = addr;
      00896A 7B 01            [ 1] 1292 	ld	a, (0x01, sp)
      00896C C7 02 06         [ 1] 1293 	ld	_current_dev+0, a
                                   1294 ;	main.c: 377: i2c_stop();
      00896F 5B 02            [ 2] 1295 	addw	sp, #2
                                   1296 ;	main.c: 378: break;
      008971 CC 88 D4         [ 2] 1297 	jp	_i2c_stop
      008974                       1298 00102$:
                                   1299 ;	main.c: 380: i2c_stop();
      008974 CD 88 D4         [ 4] 1300 	call	_i2c_stop
                                   1301 ;	main.c: 381: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      008977 72 15 52 18      [ 1] 1302 	bres	0x5218, #2
                                   1303 ;	main.c: 371: for (uint8_t addr = current_dev; addr < 127; addr++) {
      00897B 0C 02            [ 1] 1304 	inc	(0x02, sp)
      00897D 7B 02            [ 1] 1305 	ld	a, (0x02, sp)
      00897F 6B 01            [ 1] 1306 	ld	(0x01, sp), a
      008981 20 D4            [ 2] 1307 	jra	00105$
      008983                       1308 00107$:
                                   1309 ;	main.c: 383: }
      008983 5B 02            [ 2] 1310 	addw	sp, #2
      008985 81               [ 4] 1311 	ret
                                   1312 ;	main.c: 393: void cm_SM(void)
                                   1313 ;	-----------------------------------------
                                   1314 ;	 function cm_SM
                                   1315 ;	-----------------------------------------
      008986                       1316 _cm_SM:
      008986 52 04            [ 2] 1317 	sub	sp, #4
                                   1318 ;	main.c: 395: char cur_dev[4]={0};
      008988 0F 01            [ 1] 1319 	clr	(0x01, sp)
      00898A 0F 02            [ 1] 1320 	clr	(0x02, sp)
      00898C 0F 03            [ 1] 1321 	clr	(0x03, sp)
      00898E 0F 04            [ 1] 1322 	clr	(0x04, sp)
                                   1323 ;	main.c: 396: convert_int_to_chars(current_dev, cur_dev);
      008990 96               [ 1] 1324 	ldw	x, sp
      008991 5C               [ 1] 1325 	incw	x
      008992 C6 02 06         [ 1] 1326 	ld	a, _current_dev+0
      008995 CD 83 C7         [ 4] 1327 	call	_convert_int_to_chars
                                   1328 ;	main.c: 397: uart_write("SM ");
      008998 AE 80 F2         [ 2] 1329 	ldw	x, #(___str_21+0)
      00899B CD 83 66         [ 4] 1330 	call	_uart_write
                                   1331 ;	main.c: 398: uart_write(cur_dev);
      00899E 96               [ 1] 1332 	ldw	x, sp
      00899F 5C               [ 1] 1333 	incw	x
      0089A0 CD 83 66         [ 4] 1334 	call	_uart_write
                                   1335 ;	main.c: 399: uart_write("\r\n");
      0089A3 AE 80 F6         [ 2] 1336 	ldw	x, #(___str_22+0)
      0089A6 CD 83 66         [ 4] 1337 	call	_uart_write
                                   1338 ;	main.c: 400: }
      0089A9 5B 04            [ 2] 1339 	addw	sp, #4
      0089AB 81               [ 4] 1340 	ret
                                   1341 ;	main.c: 401: void cm_SN(void)
                                   1342 ;	-----------------------------------------
                                   1343 ;	 function cm_SN
                                   1344 ;	-----------------------------------------
      0089AC                       1345 _cm_SN:
                                   1346 ;	main.c: 403: i2c_scan();
      0089AC CD 89 4E         [ 4] 1347 	call	_i2c_scan
                                   1348 ;	main.c: 404: cm_SM();
                                   1349 ;	main.c: 405: }
      0089AF CC 89 86         [ 2] 1350 	jp	_cm_SM
                                   1351 ;	main.c: 406: void cm_RM(void)
                                   1352 ;	-----------------------------------------
                                   1353 ;	 function cm_RM
                                   1354 ;	-----------------------------------------
      0089B2                       1355 _cm_RM:
                                   1356 ;	main.c: 408: current_dev = 0;
      0089B2 72 5F 02 06      [ 1] 1357 	clr	_current_dev+0
                                   1358 ;	main.c: 409: uart_write("RM\n");
      0089B6 AE 80 F9         [ 2] 1359 	ldw	x, #(___str_23+0)
                                   1360 ;	main.c: 410: }
      0089B9 CC 83 66         [ 2] 1361 	jp	_uart_write
                                   1362 ;	main.c: 412: void cm_DB(void)
                                   1363 ;	-----------------------------------------
                                   1364 ;	 function cm_DB
                                   1365 ;	-----------------------------------------
      0089BC                       1366 _cm_DB:
                                   1367 ;	main.c: 414: status_check();
                                   1368 ;	main.c: 415: }
      0089BC CC 86 5B         [ 2] 1369 	jp	_status_check
                                   1370 ;	main.c: 417: void cm_ST(void)
                                   1371 ;	-----------------------------------------
                                   1372 ;	 function cm_ST
                                   1373 ;	-----------------------------------------
      0089BF                       1374 _cm_ST:
                                   1375 ;	main.c: 419: get_addr_from_buff();
      0089BF CD 84 E7         [ 4] 1376 	call	_get_addr_from_buff
                                   1377 ;	main.c: 420: current_dev = d_addr;
      0089C2 55 01 03 02 06   [ 1] 1378 	mov	_current_dev+0, _d_addr+0
                                   1379 ;	main.c: 421: uart_write("ST\n");
      0089C7 AE 80 FD         [ 2] 1380 	ldw	x, #(___str_24+0)
                                   1381 ;	main.c: 422: }
      0089CA CC 83 66         [ 2] 1382 	jp	_uart_write
                                   1383 ;	main.c: 423: void cm_SR(void)
                                   1384 ;	-----------------------------------------
                                   1385 ;	 function cm_SR
                                   1386 ;	-----------------------------------------
      0089CD                       1387 _cm_SR:
                                   1388 ;	main.c: 425: i2c_start();
      0089CD CD 88 BA         [ 4] 1389 	call	_i2c_start
                                   1390 ;	main.c: 426: i2c_send_address(current_dev);
      0089D0 C6 02 06         [ 1] 1391 	ld	a, _current_dev+0
      0089D3 CD 88 C4         [ 4] 1392 	call	_i2c_send_address
                                   1393 ;	main.c: 427: i2c_read();
      0089D6 CD 89 05         [ 4] 1394 	call	_i2c_read
                                   1395 ;	main.c: 428: i2c_stop();
                                   1396 ;	main.c: 429: }
      0089D9 CC 88 D4         [ 2] 1397 	jp	_i2c_stop
                                   1398 ;	main.c: 430: void cm_SW(void)
                                   1399 ;	-----------------------------------------
                                   1400 ;	 function cm_SW
                                   1401 ;	-----------------------------------------
      0089DC                       1402 _cm_SW:
      0089DC 52 04            [ 2] 1403 	sub	sp, #4
                                   1404 ;	main.c: 432: char ar[4]={0};
      0089DE 0F 01            [ 1] 1405 	clr	(0x01, sp)
      0089E0 0F 02            [ 1] 1406 	clr	(0x02, sp)
      0089E2 0F 03            [ 1] 1407 	clr	(0x03, sp)
      0089E4 0F 04            [ 1] 1408 	clr	(0x04, sp)
                                   1409 ;	main.c: 433: i2c_start();
      0089E6 CD 88 BA         [ 4] 1410 	call	_i2c_start
                                   1411 ;	main.c: 434: i2c_send_address(current_dev);
      0089E9 C6 02 06         [ 1] 1412 	ld	a, _current_dev+0
      0089EC CD 88 C4         [ 4] 1413 	call	_i2c_send_address
                                   1414 ;	main.c: 435: i2c_write();
      0089EF CD 88 D9         [ 4] 1415 	call	_i2c_write
                                   1416 ;	main.c: 436: i2c_stop();
      0089F2 CD 88 D4         [ 4] 1417 	call	_i2c_stop
                                   1418 ;	main.c: 437: uart_write("SW ");
      0089F5 AE 81 01         [ 2] 1419 	ldw	x, #(___str_25+0)
      0089F8 CD 83 66         [ 4] 1420 	call	_uart_write
                                   1421 ;	main.c: 438: convert_int_to_chars(d_addr, ar);
      0089FB 96               [ 1] 1422 	ldw	x, sp
      0089FC 5C               [ 1] 1423 	incw	x
      0089FD C6 01 03         [ 1] 1424 	ld	a, _d_addr+0
      008A00 CD 83 C7         [ 4] 1425 	call	_convert_int_to_chars
                                   1426 ;	main.c: 439: uart_write(ar);
      008A03 96               [ 1] 1427 	ldw	x, sp
      008A04 5C               [ 1] 1428 	incw	x
      008A05 CD 83 66         [ 4] 1429 	call	_uart_write
                                   1430 ;	main.c: 440: uart_write(" ");
      008A08 AE 81 05         [ 2] 1431 	ldw	x, #(___str_26+0)
      008A0B CD 83 66         [ 4] 1432 	call	_uart_write
                                   1433 ;	main.c: 441: convert_int_to_chars(d_size, ar);
      008A0E 96               [ 1] 1434 	ldw	x, sp
      008A0F 5C               [ 1] 1435 	incw	x
      008A10 C6 01 05         [ 1] 1436 	ld	a, _d_size+0
      008A13 CD 83 C7         [ 4] 1437 	call	_convert_int_to_chars
                                   1438 ;	main.c: 442: uart_write(ar);
      008A16 96               [ 1] 1439 	ldw	x, sp
      008A17 5C               [ 1] 1440 	incw	x
      008A18 CD 83 66         [ 4] 1441 	call	_uart_write
                                   1442 ;	main.c: 443: uart_write("\r\n");
      008A1B AE 80 F6         [ 2] 1443 	ldw	x, #(___str_22+0)
      008A1E CD 83 66         [ 4] 1444 	call	_uart_write
                                   1445 ;	main.c: 444: }
      008A21 5B 04            [ 2] 1446 	addw	sp, #4
      008A23 81               [ 4] 1447 	ret
                                   1448 ;	main.c: 452: int data_handler(void)
                                   1449 ;	-----------------------------------------
                                   1450 ;	 function data_handler
                                   1451 ;	-----------------------------------------
      008A24                       1452 _data_handler:
                                   1453 ;	main.c: 454: p_size = 0;
      008A24 72 5F 01 04      [ 1] 1454 	clr	_p_size+0
                                   1455 ;	main.c: 455: p_bytes = 0;
      008A28 72 5F 01 06      [ 1] 1456 	clr	_p_bytes+0
                                   1457 ;	main.c: 456: d_addr = 0;
      008A2C 72 5F 01 03      [ 1] 1458 	clr	_d_addr+0
                                   1459 ;	main.c: 457: d_size = 0;
      008A30 72 5F 01 05      [ 1] 1460 	clr	_d_size+0
                                   1461 ;	main.c: 458: memset(a, 0, sizeof(a));
      008A34 4B 03            [ 1] 1462 	push	#0x03
      008A36 4B 00            [ 1] 1463 	push	#0x00
      008A38 5F               [ 1] 1464 	clrw	x
      008A39 89               [ 2] 1465 	pushw	x
      008A3A AE 01 00         [ 2] 1466 	ldw	x, #(_a+0)
      008A3D CD 8B E1         [ 4] 1467 	call	_memset
                                   1468 ;	main.c: 459: memset(data_buf, 0, sizeof(data_buf));
      008A40 4B FF            [ 1] 1469 	push	#0xff
      008A42 4B 00            [ 1] 1470 	push	#0x00
      008A44 5F               [ 1] 1471 	clrw	x
      008A45 89               [ 2] 1472 	pushw	x
      008A46 AE 01 07         [ 2] 1473 	ldw	x, #(_data_buf+0)
      008A49 CD 8B E1         [ 4] 1474 	call	_memset
                                   1475 ;	main.c: 460: if(memcmp(&buffer[0],"SM",2) == 0)
      008A4C 4B 02            [ 1] 1476 	push	#0x02
      008A4E 4B 00            [ 1] 1477 	push	#0x00
      008A50 4B 07            [ 1] 1478 	push	#<(___str_27+0)
      008A52 4B 81            [ 1] 1479 	push	#((___str_27+0) >> 8)
      008A54 AE 00 01         [ 2] 1480 	ldw	x, #(_buffer+0)
      008A57 CD 8B 4B         [ 4] 1481 	call	_memcmp
                                   1482 ;	main.c: 461: return 1;
      008A5A 5D               [ 2] 1483 	tnzw	x
      008A5B 26 02            [ 1] 1484 	jrne	00102$
      008A5D 5C               [ 1] 1485 	incw	x
      008A5E 81               [ 4] 1486 	ret
      008A5F                       1487 00102$:
                                   1488 ;	main.c: 462: if(memcmp(&buffer[0],"SN",2) == 0)
      008A5F 4B 02            [ 1] 1489 	push	#0x02
      008A61 4B 00            [ 1] 1490 	push	#0x00
      008A63 4B 0A            [ 1] 1491 	push	#<(___str_28+0)
      008A65 4B 81            [ 1] 1492 	push	#((___str_28+0) >> 8)
      008A67 AE 00 01         [ 2] 1493 	ldw	x, #(_buffer+0)
      008A6A CD 8B 4B         [ 4] 1494 	call	_memcmp
      008A6D 5D               [ 2] 1495 	tnzw	x
      008A6E 26 04            [ 1] 1496 	jrne	00104$
                                   1497 ;	main.c: 463: return 2;
      008A70 AE 00 02         [ 2] 1498 	ldw	x, #0x0002
      008A73 81               [ 4] 1499 	ret
      008A74                       1500 00104$:
                                   1501 ;	main.c: 464: if(memcmp(&buffer[0],"ST",2) == 0)
      008A74 4B 02            [ 1] 1502 	push	#0x02
      008A76 4B 00            [ 1] 1503 	push	#0x00
      008A78 4B 0D            [ 1] 1504 	push	#<(___str_29+0)
      008A7A 4B 81            [ 1] 1505 	push	#((___str_29+0) >> 8)
      008A7C AE 00 01         [ 2] 1506 	ldw	x, #(_buffer+0)
      008A7F CD 8B 4B         [ 4] 1507 	call	_memcmp
      008A82 5D               [ 2] 1508 	tnzw	x
      008A83 26 04            [ 1] 1509 	jrne	00106$
                                   1510 ;	main.c: 465: return 5;
      008A85 AE 00 05         [ 2] 1511 	ldw	x, #0x0005
      008A88 81               [ 4] 1512 	ret
      008A89                       1513 00106$:
                                   1514 ;	main.c: 466: if(memcmp(&buffer[0],"RM",2) == 0)
      008A89 4B 02            [ 1] 1515 	push	#0x02
      008A8B 4B 00            [ 1] 1516 	push	#0x00
      008A8D 4B 10            [ 1] 1517 	push	#<(___str_30+0)
      008A8F 4B 81            [ 1] 1518 	push	#((___str_30+0) >> 8)
      008A91 AE 00 01         [ 2] 1519 	ldw	x, #(_buffer+0)
      008A94 CD 8B 4B         [ 4] 1520 	call	_memcmp
      008A97 5D               [ 2] 1521 	tnzw	x
      008A98 26 04            [ 1] 1522 	jrne	00108$
                                   1523 ;	main.c: 467: return 6;
      008A9A AE 00 06         [ 2] 1524 	ldw	x, #0x0006
      008A9D 81               [ 4] 1525 	ret
      008A9E                       1526 00108$:
                                   1527 ;	main.c: 468: if(memcmp(&buffer[0],"DB",2) == 0)
      008A9E 4B 02            [ 1] 1528 	push	#0x02
      008AA0 4B 00            [ 1] 1529 	push	#0x00
      008AA2 4B 13            [ 1] 1530 	push	#<(___str_31+0)
      008AA4 4B 81            [ 1] 1531 	push	#((___str_31+0) >> 8)
      008AA6 AE 00 01         [ 2] 1532 	ldw	x, #(_buffer+0)
      008AA9 CD 8B 4B         [ 4] 1533 	call	_memcmp
      008AAC 5D               [ 2] 1534 	tnzw	x
      008AAD 26 04            [ 1] 1535 	jrne	00110$
                                   1536 ;	main.c: 469: return 7;
      008AAF AE 00 07         [ 2] 1537 	ldw	x, #0x0007
      008AB2 81               [ 4] 1538 	ret
      008AB3                       1539 00110$:
                                   1540 ;	main.c: 471: get_addr_from_buff();
      008AB3 CD 84 E7         [ 4] 1541 	call	_get_addr_from_buff
                                   1542 ;	main.c: 472: get_size_from_buff();
      008AB6 CD 85 2C         [ 4] 1543 	call	_get_size_from_buff
                                   1544 ;	main.c: 474: if(memcmp(&buffer[0],"SR",2) == 0)
      008AB9 4B 02            [ 1] 1545 	push	#0x02
      008ABB 4B 00            [ 1] 1546 	push	#0x00
      008ABD 4B 16            [ 1] 1547 	push	#<(___str_32+0)
      008ABF 4B 81            [ 1] 1548 	push	#((___str_32+0) >> 8)
      008AC1 AE 00 01         [ 2] 1549 	ldw	x, #(_buffer+0)
      008AC4 CD 8B 4B         [ 4] 1550 	call	_memcmp
      008AC7 5D               [ 2] 1551 	tnzw	x
      008AC8 26 04            [ 1] 1552 	jrne	00112$
                                   1553 ;	main.c: 475: return 3;
      008ACA AE 00 03         [ 2] 1554 	ldw	x, #0x0003
      008ACD 81               [ 4] 1555 	ret
      008ACE                       1556 00112$:
                                   1557 ;	main.c: 477: char_buffer_to_int();
      008ACE CD 85 86         [ 4] 1558 	call	_char_buffer_to_int
                                   1559 ;	main.c: 479: if(memcmp(&buffer[0],"SW",2) == 0)
      008AD1 4B 02            [ 1] 1560 	push	#0x02
      008AD3 4B 00            [ 1] 1561 	push	#0x00
      008AD5 4B 19            [ 1] 1562 	push	#<(___str_33+0)
      008AD7 4B 81            [ 1] 1563 	push	#((___str_33+0) >> 8)
      008AD9 AE 00 01         [ 2] 1564 	ldw	x, #(_buffer+0)
      008ADC CD 8B 4B         [ 4] 1565 	call	_memcmp
      008ADF 5D               [ 2] 1566 	tnzw	x
      008AE0 26 04            [ 1] 1567 	jrne	00114$
                                   1568 ;	main.c: 480: return 4;
      008AE2 AE 00 04         [ 2] 1569 	ldw	x, #0x0004
      008AE5 81               [ 4] 1570 	ret
      008AE6                       1571 00114$:
                                   1572 ;	main.c: 481: return 0;
      008AE6 5F               [ 1] 1573 	clrw	x
                                   1574 ;	main.c: 483: }
      008AE7 81               [ 4] 1575 	ret
                                   1576 ;	main.c: 485: void command_switcher(void)
                                   1577 ;	-----------------------------------------
                                   1578 ;	 function command_switcher
                                   1579 ;	-----------------------------------------
      008AE8                       1580 _command_switcher:
      008AE8 52 04            [ 2] 1581 	sub	sp, #4
                                   1582 ;	main.c: 487: char ar[4]={0};
      008AEA 0F 01            [ 1] 1583 	clr	(0x01, sp)
      008AEC 0F 02            [ 1] 1584 	clr	(0x02, sp)
      008AEE 0F 03            [ 1] 1585 	clr	(0x03, sp)
      008AF0 0F 04            [ 1] 1586 	clr	(0x04, sp)
                                   1587 ;	main.c: 489: switch(data_handler())
      008AF2 CD 8A 24         [ 4] 1588 	call	_data_handler
      008AF5 5D               [ 2] 1589 	tnzw	x
      008AF6 2B 3B            [ 1] 1590 	jrmi	00109$
      008AF8 A3 00 07         [ 2] 1591 	cpw	x, #0x0007
      008AFB 2C 36            [ 1] 1592 	jrsgt	00109$
      008AFD 58               [ 2] 1593 	sllw	x
      008AFE DE 8B 02         [ 2] 1594 	ldw	x, (#00123$, x)
      008B01 FC               [ 2] 1595 	jp	(x)
      008B02                       1596 00123$:
      008B02 8B 33                 1597 	.dw	#00109$
      008B04 8B 12                 1598 	.dw	#00101$
      008B06 8B 17                 1599 	.dw	#00102$
      008B08 8B 1C                 1600 	.dw	#00103$
      008B0A 8B 21                 1601 	.dw	#00104$
      008B0C 8B 26                 1602 	.dw	#00105$
      008B0E 8B 2B                 1603 	.dw	#00106$
      008B10 8B 30                 1604 	.dw	#00107$
                                   1605 ;	main.c: 491: case 1:
      008B12                       1606 00101$:
                                   1607 ;	main.c: 492: cm_SM();
      008B12 CD 89 86         [ 4] 1608 	call	_cm_SM
                                   1609 ;	main.c: 493: break;
      008B15 20 1C            [ 2] 1610 	jra	00109$
                                   1611 ;	main.c: 494: case 2:
      008B17                       1612 00102$:
                                   1613 ;	main.c: 495: cm_SN();
      008B17 CD 89 AC         [ 4] 1614 	call	_cm_SN
                                   1615 ;	main.c: 496: break;
      008B1A 20 17            [ 2] 1616 	jra	00109$
                                   1617 ;	main.c: 497: case 3:
      008B1C                       1618 00103$:
                                   1619 ;	main.c: 498: cm_SR();
      008B1C CD 89 CD         [ 4] 1620 	call	_cm_SR
                                   1621 ;	main.c: 499: break;
      008B1F 20 12            [ 2] 1622 	jra	00109$
                                   1623 ;	main.c: 500: case 4:
      008B21                       1624 00104$:
                                   1625 ;	main.c: 501: cm_SW();
      008B21 CD 89 DC         [ 4] 1626 	call	_cm_SW
                                   1627 ;	main.c: 502: break;
      008B24 20 0D            [ 2] 1628 	jra	00109$
                                   1629 ;	main.c: 503: case 5:
      008B26                       1630 00105$:
                                   1631 ;	main.c: 504: cm_ST();
      008B26 CD 89 BF         [ 4] 1632 	call	_cm_ST
                                   1633 ;	main.c: 505: break;
      008B29 20 08            [ 2] 1634 	jra	00109$
                                   1635 ;	main.c: 506: case 6:
      008B2B                       1636 00106$:
                                   1637 ;	main.c: 507: cm_RM();
      008B2B CD 89 B2         [ 4] 1638 	call	_cm_RM
                                   1639 ;	main.c: 508: break;
      008B2E 20 03            [ 2] 1640 	jra	00109$
                                   1641 ;	main.c: 509: case 7:
      008B30                       1642 00107$:
                                   1643 ;	main.c: 510: cm_DB();
      008B30 CD 89 BC         [ 4] 1644 	call	_cm_DB
                                   1645 ;	main.c: 512: }
      008B33                       1646 00109$:
                                   1647 ;	main.c: 513: }
      008B33 5B 04            [ 2] 1648 	addw	sp, #4
      008B35 81               [ 4] 1649 	ret
                                   1650 ;	main.c: 516: void main(void)
                                   1651 ;	-----------------------------------------
                                   1652 ;	 function main
                                   1653 ;	-----------------------------------------
      008B36                       1654 _main:
                                   1655 ;	main.c: 518: uart_init();
      008B36 CD 88 7C         [ 4] 1656 	call	_uart_init
                                   1657 ;	main.c: 519: i2c_init();
      008B39 CD 88 99         [ 4] 1658 	call	_i2c_init
                                   1659 ;	main.c: 520: uart_write("SS\n");
      008B3C AE 81 1C         [ 2] 1660 	ldw	x, #(___str_34+0)
      008B3F CD 83 66         [ 4] 1661 	call	_uart_write
                                   1662 ;	main.c: 521: while(1)
      008B42                       1663 00102$:
                                   1664 ;	main.c: 523: uart_read();
      008B42 CD 83 91         [ 4] 1665 	call	_uart_read
                                   1666 ;	main.c: 524: command_switcher();
      008B45 CD 8A E8         [ 4] 1667 	call	_command_switcher
      008B48 20 F8            [ 2] 1668 	jra	00102$
                                   1669 ;	main.c: 526: }
      008B4A 81               [ 4] 1670 	ret
                                   1671 	.area CODE
                                   1672 	.area CONST
                                   1673 	.area CONST
      00802D                       1674 ___str_0:
      00802D 0A                    1675 	.db 0x0a
      00802E 63 68 61 72 20 2D 3E  1676 	.ascii "char -> "
             20
      008036 00                    1677 	.db 0x00
                                   1678 	.area CODE
                                   1679 	.area CONST
      008037                       1680 ___str_1:
      008037 20 3C 2D              1681 	.ascii " <-"
      00803A 0A                    1682 	.db 0x0a
      00803B 00                    1683 	.db 0x00
                                   1684 	.area CODE
                                   1685 	.area CONST
      00803C                       1686 ___str_2:
      00803C 0A                    1687 	.db 0x0a
      00803D 72 65 73 75 6C 74 20  1688 	.ascii "result -> "
             2D 3E 20
      008047 00                    1689 	.db 0x00
                                   1690 	.area CODE
                                   1691 	.area CONST
      008048                       1692 ___str_3:
      008048 0A                    1693 	.db 0x0a
      008049 69 20 77 68 69 6C 65  1694 	.ascii "i while-> -> "
             2D 3E 20 2D 3E 20
      008056 00                    1695 	.db 0x00
                                   1696 	.area CODE
                                   1697 	.area CONST
      008057                       1698 ___str_4:
      008057 0A                    1699 	.db 0x0a
      008058 69 20 2D 3E 20 2D 3E  1700 	.ascii "i -> -> "
             20
      008060 00                    1701 	.db 0x00
                                   1702 	.area CODE
                                   1703 	.area CONST
      008061                       1704 ___str_5:
      008061 0A                    1705 	.db 0x0a
      008062 49 32 43 5F 52 45 47  1706 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00806E 0A                    1707 	.db 0x0a
      00806F 00                    1708 	.db 0x00
                                   1709 	.area CODE
                                   1710 	.area CONST
      008070                       1711 ___str_6:
      008070 0A                    1712 	.db 0x0a
      008071 53 52 31 20 2D 3E 20  1713 	.ascii "SR1 -> "
      008078 00                    1714 	.db 0x00
                                   1715 	.area CODE
                                   1716 	.area CONST
      008079                       1717 ___str_7:
      008079 53 52 32 20 2D 3E 20  1718 	.ascii "SR2 -> "
      008080 00                    1719 	.db 0x00
                                   1720 	.area CODE
                                   1721 	.area CONST
      008081                       1722 ___str_8:
      008081 53 52 33 20 2D 3E 20  1723 	.ascii "SR3 -> "
      008088 00                    1724 	.db 0x00
                                   1725 	.area CODE
                                   1726 	.area CONST
      008089                       1727 ___str_9:
      008089 43 52 31 20 2D 3E 20  1728 	.ascii "CR1 -> "
      008090 00                    1729 	.db 0x00
                                   1730 	.area CODE
                                   1731 	.area CONST
      008091                       1732 ___str_10:
      008091 43 52 32 20 2D 3E 20  1733 	.ascii "CR2 -> "
      008098 00                    1734 	.db 0x00
                                   1735 	.area CODE
                                   1736 	.area CONST
      008099                       1737 ___str_11:
      008099 44 52 20 2D 3E 20     1738 	.ascii "DR -> "
      00809F 00                    1739 	.db 0x00
                                   1740 	.area CODE
                                   1741 	.area CONST
      0080A0                       1742 ___str_12:
      0080A0 55 41 52 54 5F 52 45  1743 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      0080AD 0A                    1744 	.db 0x0a
      0080AE 00                    1745 	.db 0x00
                                   1746 	.area CODE
                                   1747 	.area CONST
      0080AF                       1748 ___str_13:
      0080AF 0A                    1749 	.db 0x0a
      0080B0 53 52 20 2D 3E 20     1750 	.ascii "SR -> "
      0080B6 00                    1751 	.db 0x00
                                   1752 	.area CODE
                                   1753 	.area CONST
      0080B7                       1754 ___str_14:
      0080B7 42 52 52 31 20 2D 3E  1755 	.ascii "BRR1 -> "
             20
      0080BF 00                    1756 	.db 0x00
                                   1757 	.area CODE
                                   1758 	.area CONST
      0080C0                       1759 ___str_15:
      0080C0 42 52 52 32 20 2D 3E  1760 	.ascii "BRR2 -> "
             20
      0080C8 00                    1761 	.db 0x00
                                   1762 	.area CODE
                                   1763 	.area CONST
      0080C9                       1764 ___str_16:
      0080C9 43 52 33 20 2D 3E 20  1765 	.ascii "CR3 -> "
      0080D0 00                    1766 	.db 0x00
                                   1767 	.area CODE
                                   1768 	.area CONST
      0080D1                       1769 ___str_17:
      0080D1 43 52 34 20 2D 3E 20  1770 	.ascii "CR4 -> "
      0080D8 00                    1771 	.db 0x00
                                   1772 	.area CODE
                                   1773 	.area CONST
      0080D9                       1774 ___str_18:
      0080D9 43 52 35 20 2D 3E 20  1775 	.ascii "CR5 -> "
      0080E0 00                    1776 	.db 0x00
                                   1777 	.area CODE
                                   1778 	.area CONST
      0080E1                       1779 ___str_19:
      0080E1 47 54 52 20 2D 3E 20  1780 	.ascii "GTR -> "
      0080E8 00                    1781 	.db 0x00
                                   1782 	.area CODE
                                   1783 	.area CONST
      0080E9                       1784 ___str_20:
      0080E9 50 53 43 52 20 2D 3E  1785 	.ascii "PSCR -> "
             20
      0080F1 00                    1786 	.db 0x00
                                   1787 	.area CODE
                                   1788 	.area CONST
      0080F2                       1789 ___str_21:
      0080F2 53 4D 20              1790 	.ascii "SM "
      0080F5 00                    1791 	.db 0x00
                                   1792 	.area CODE
                                   1793 	.area CONST
      0080F6                       1794 ___str_22:
      0080F6 0D                    1795 	.db 0x0d
      0080F7 0A                    1796 	.db 0x0a
      0080F8 00                    1797 	.db 0x00
                                   1798 	.area CODE
                                   1799 	.area CONST
      0080F9                       1800 ___str_23:
      0080F9 52 4D                 1801 	.ascii "RM"
      0080FB 0A                    1802 	.db 0x0a
      0080FC 00                    1803 	.db 0x00
                                   1804 	.area CODE
                                   1805 	.area CONST
      0080FD                       1806 ___str_24:
      0080FD 53 54                 1807 	.ascii "ST"
      0080FF 0A                    1808 	.db 0x0a
      008100 00                    1809 	.db 0x00
                                   1810 	.area CODE
                                   1811 	.area CONST
      008101                       1812 ___str_25:
      008101 53 57 20              1813 	.ascii "SW "
      008104 00                    1814 	.db 0x00
                                   1815 	.area CODE
                                   1816 	.area CONST
      008105                       1817 ___str_26:
      008105 20                    1818 	.ascii " "
      008106 00                    1819 	.db 0x00
                                   1820 	.area CODE
                                   1821 	.area CONST
      008107                       1822 ___str_27:
      008107 53 4D                 1823 	.ascii "SM"
      008109 00                    1824 	.db 0x00
                                   1825 	.area CODE
                                   1826 	.area CONST
      00810A                       1827 ___str_28:
      00810A 53 4E                 1828 	.ascii "SN"
      00810C 00                    1829 	.db 0x00
                                   1830 	.area CODE
                                   1831 	.area CONST
      00810D                       1832 ___str_29:
      00810D 53 54                 1833 	.ascii "ST"
      00810F 00                    1834 	.db 0x00
                                   1835 	.area CODE
                                   1836 	.area CONST
      008110                       1837 ___str_30:
      008110 52 4D                 1838 	.ascii "RM"
      008112 00                    1839 	.db 0x00
                                   1840 	.area CODE
                                   1841 	.area CONST
      008113                       1842 ___str_31:
      008113 44 42                 1843 	.ascii "DB"
      008115 00                    1844 	.db 0x00
                                   1845 	.area CODE
                                   1846 	.area CONST
      008116                       1847 ___str_32:
      008116 53 52                 1848 	.ascii "SR"
      008118 00                    1849 	.db 0x00
                                   1850 	.area CODE
                                   1851 	.area CONST
      008119                       1852 ___str_33:
      008119 53 57                 1853 	.ascii "SW"
      00811B 00                    1854 	.db 0x00
                                   1855 	.area CODE
                                   1856 	.area CONST
      00811C                       1857 ___str_34:
      00811C 53 53                 1858 	.ascii "SS"
      00811E 0A                    1859 	.db 0x0a
      00811F 00                    1860 	.db 0x00
                                   1861 	.area CODE
                                   1862 	.area INITIALIZER
      008120                       1863 __xinit__buffer:
      008120 00                    1864 	.db #0x00	; 0
      008121 00                    1865 	.db 0x00
      008122 00                    1866 	.db 0x00
      008123 00                    1867 	.db 0x00
      008124 00                    1868 	.db 0x00
      008125 00                    1869 	.db 0x00
      008126 00                    1870 	.db 0x00
      008127 00                    1871 	.db 0x00
      008128 00                    1872 	.db 0x00
      008129 00                    1873 	.db 0x00
      00812A 00                    1874 	.db 0x00
      00812B 00                    1875 	.db 0x00
      00812C 00                    1876 	.db 0x00
      00812D 00                    1877 	.db 0x00
      00812E 00                    1878 	.db 0x00
      00812F 00                    1879 	.db 0x00
      008130 00                    1880 	.db 0x00
      008131 00                    1881 	.db 0x00
      008132 00                    1882 	.db 0x00
      008133 00                    1883 	.db 0x00
      008134 00                    1884 	.db 0x00
      008135 00                    1885 	.db 0x00
      008136 00                    1886 	.db 0x00
      008137 00                    1887 	.db 0x00
      008138 00                    1888 	.db 0x00
      008139 00                    1889 	.db 0x00
      00813A 00                    1890 	.db 0x00
      00813B 00                    1891 	.db 0x00
      00813C 00                    1892 	.db 0x00
      00813D 00                    1893 	.db 0x00
      00813E 00                    1894 	.db 0x00
      00813F 00                    1895 	.db 0x00
      008140 00                    1896 	.db 0x00
      008141 00                    1897 	.db 0x00
      008142 00                    1898 	.db 0x00
      008143 00                    1899 	.db 0x00
      008144 00                    1900 	.db 0x00
      008145 00                    1901 	.db 0x00
      008146 00                    1902 	.db 0x00
      008147 00                    1903 	.db 0x00
      008148 00                    1904 	.db 0x00
      008149 00                    1905 	.db 0x00
      00814A 00                    1906 	.db 0x00
      00814B 00                    1907 	.db 0x00
      00814C 00                    1908 	.db 0x00
      00814D 00                    1909 	.db 0x00
      00814E 00                    1910 	.db 0x00
      00814F 00                    1911 	.db 0x00
      008150 00                    1912 	.db 0x00
      008151 00                    1913 	.db 0x00
      008152 00                    1914 	.db 0x00
      008153 00                    1915 	.db 0x00
      008154 00                    1916 	.db 0x00
      008155 00                    1917 	.db 0x00
      008156 00                    1918 	.db 0x00
      008157 00                    1919 	.db 0x00
      008158 00                    1920 	.db 0x00
      008159 00                    1921 	.db 0x00
      00815A 00                    1922 	.db 0x00
      00815B 00                    1923 	.db 0x00
      00815C 00                    1924 	.db 0x00
      00815D 00                    1925 	.db 0x00
      00815E 00                    1926 	.db 0x00
      00815F 00                    1927 	.db 0x00
      008160 00                    1928 	.db 0x00
      008161 00                    1929 	.db 0x00
      008162 00                    1930 	.db 0x00
      008163 00                    1931 	.db 0x00
      008164 00                    1932 	.db 0x00
      008165 00                    1933 	.db 0x00
      008166 00                    1934 	.db 0x00
      008167 00                    1935 	.db 0x00
      008168 00                    1936 	.db 0x00
      008169 00                    1937 	.db 0x00
      00816A 00                    1938 	.db 0x00
      00816B 00                    1939 	.db 0x00
      00816C 00                    1940 	.db 0x00
      00816D 00                    1941 	.db 0x00
      00816E 00                    1942 	.db 0x00
      00816F 00                    1943 	.db 0x00
      008170 00                    1944 	.db 0x00
      008171 00                    1945 	.db 0x00
      008172 00                    1946 	.db 0x00
      008173 00                    1947 	.db 0x00
      008174 00                    1948 	.db 0x00
      008175 00                    1949 	.db 0x00
      008176 00                    1950 	.db 0x00
      008177 00                    1951 	.db 0x00
      008178 00                    1952 	.db 0x00
      008179 00                    1953 	.db 0x00
      00817A 00                    1954 	.db 0x00
      00817B 00                    1955 	.db 0x00
      00817C 00                    1956 	.db 0x00
      00817D 00                    1957 	.db 0x00
      00817E 00                    1958 	.db 0x00
      00817F 00                    1959 	.db 0x00
      008180 00                    1960 	.db 0x00
      008181 00                    1961 	.db 0x00
      008182 00                    1962 	.db 0x00
      008183 00                    1963 	.db 0x00
      008184 00                    1964 	.db 0x00
      008185 00                    1965 	.db 0x00
      008186 00                    1966 	.db 0x00
      008187 00                    1967 	.db 0x00
      008188 00                    1968 	.db 0x00
      008189 00                    1969 	.db 0x00
      00818A 00                    1970 	.db 0x00
      00818B 00                    1971 	.db 0x00
      00818C 00                    1972 	.db 0x00
      00818D 00                    1973 	.db 0x00
      00818E 00                    1974 	.db 0x00
      00818F 00                    1975 	.db 0x00
      008190 00                    1976 	.db 0x00
      008191 00                    1977 	.db 0x00
      008192 00                    1978 	.db 0x00
      008193 00                    1979 	.db 0x00
      008194 00                    1980 	.db 0x00
      008195 00                    1981 	.db 0x00
      008196 00                    1982 	.db 0x00
      008197 00                    1983 	.db 0x00
      008198 00                    1984 	.db 0x00
      008199 00                    1985 	.db 0x00
      00819A 00                    1986 	.db 0x00
      00819B 00                    1987 	.db 0x00
      00819C 00                    1988 	.db 0x00
      00819D 00                    1989 	.db 0x00
      00819E 00                    1990 	.db 0x00
      00819F 00                    1991 	.db 0x00
      0081A0 00                    1992 	.db 0x00
      0081A1 00                    1993 	.db 0x00
      0081A2 00                    1994 	.db 0x00
      0081A3 00                    1995 	.db 0x00
      0081A4 00                    1996 	.db 0x00
      0081A5 00                    1997 	.db 0x00
      0081A6 00                    1998 	.db 0x00
      0081A7 00                    1999 	.db 0x00
      0081A8 00                    2000 	.db 0x00
      0081A9 00                    2001 	.db 0x00
      0081AA 00                    2002 	.db 0x00
      0081AB 00                    2003 	.db 0x00
      0081AC 00                    2004 	.db 0x00
      0081AD 00                    2005 	.db 0x00
      0081AE 00                    2006 	.db 0x00
      0081AF 00                    2007 	.db 0x00
      0081B0 00                    2008 	.db 0x00
      0081B1 00                    2009 	.db 0x00
      0081B2 00                    2010 	.db 0x00
      0081B3 00                    2011 	.db 0x00
      0081B4 00                    2012 	.db 0x00
      0081B5 00                    2013 	.db 0x00
      0081B6 00                    2014 	.db 0x00
      0081B7 00                    2015 	.db 0x00
      0081B8 00                    2016 	.db 0x00
      0081B9 00                    2017 	.db 0x00
      0081BA 00                    2018 	.db 0x00
      0081BB 00                    2019 	.db 0x00
      0081BC 00                    2020 	.db 0x00
      0081BD 00                    2021 	.db 0x00
      0081BE 00                    2022 	.db 0x00
      0081BF 00                    2023 	.db 0x00
      0081C0 00                    2024 	.db 0x00
      0081C1 00                    2025 	.db 0x00
      0081C2 00                    2026 	.db 0x00
      0081C3 00                    2027 	.db 0x00
      0081C4 00                    2028 	.db 0x00
      0081C5 00                    2029 	.db 0x00
      0081C6 00                    2030 	.db 0x00
      0081C7 00                    2031 	.db 0x00
      0081C8 00                    2032 	.db 0x00
      0081C9 00                    2033 	.db 0x00
      0081CA 00                    2034 	.db 0x00
      0081CB 00                    2035 	.db 0x00
      0081CC 00                    2036 	.db 0x00
      0081CD 00                    2037 	.db 0x00
      0081CE 00                    2038 	.db 0x00
      0081CF 00                    2039 	.db 0x00
      0081D0 00                    2040 	.db 0x00
      0081D1 00                    2041 	.db 0x00
      0081D2 00                    2042 	.db 0x00
      0081D3 00                    2043 	.db 0x00
      0081D4 00                    2044 	.db 0x00
      0081D5 00                    2045 	.db 0x00
      0081D6 00                    2046 	.db 0x00
      0081D7 00                    2047 	.db 0x00
      0081D8 00                    2048 	.db 0x00
      0081D9 00                    2049 	.db 0x00
      0081DA 00                    2050 	.db 0x00
      0081DB 00                    2051 	.db 0x00
      0081DC 00                    2052 	.db 0x00
      0081DD 00                    2053 	.db 0x00
      0081DE 00                    2054 	.db 0x00
      0081DF 00                    2055 	.db 0x00
      0081E0 00                    2056 	.db 0x00
      0081E1 00                    2057 	.db 0x00
      0081E2 00                    2058 	.db 0x00
      0081E3 00                    2059 	.db 0x00
      0081E4 00                    2060 	.db 0x00
      0081E5 00                    2061 	.db 0x00
      0081E6 00                    2062 	.db 0x00
      0081E7 00                    2063 	.db 0x00
      0081E8 00                    2064 	.db 0x00
      0081E9 00                    2065 	.db 0x00
      0081EA 00                    2066 	.db 0x00
      0081EB 00                    2067 	.db 0x00
      0081EC 00                    2068 	.db 0x00
      0081ED 00                    2069 	.db 0x00
      0081EE 00                    2070 	.db 0x00
      0081EF 00                    2071 	.db 0x00
      0081F0 00                    2072 	.db 0x00
      0081F1 00                    2073 	.db 0x00
      0081F2 00                    2074 	.db 0x00
      0081F3 00                    2075 	.db 0x00
      0081F4 00                    2076 	.db 0x00
      0081F5 00                    2077 	.db 0x00
      0081F6 00                    2078 	.db 0x00
      0081F7 00                    2079 	.db 0x00
      0081F8 00                    2080 	.db 0x00
      0081F9 00                    2081 	.db 0x00
      0081FA 00                    2082 	.db 0x00
      0081FB 00                    2083 	.db 0x00
      0081FC 00                    2084 	.db 0x00
      0081FD 00                    2085 	.db 0x00
      0081FE 00                    2086 	.db 0x00
      0081FF 00                    2087 	.db 0x00
      008200 00                    2088 	.db 0x00
      008201 00                    2089 	.db 0x00
      008202 00                    2090 	.db 0x00
      008203 00                    2091 	.db 0x00
      008204 00                    2092 	.db 0x00
      008205 00                    2093 	.db 0x00
      008206 00                    2094 	.db 0x00
      008207 00                    2095 	.db 0x00
      008208 00                    2096 	.db 0x00
      008209 00                    2097 	.db 0x00
      00820A 00                    2098 	.db 0x00
      00820B 00                    2099 	.db 0x00
      00820C 00                    2100 	.db 0x00
      00820D 00                    2101 	.db 0x00
      00820E 00                    2102 	.db 0x00
      00820F 00                    2103 	.db 0x00
      008210 00                    2104 	.db 0x00
      008211 00                    2105 	.db 0x00
      008212 00                    2106 	.db 0x00
      008213 00                    2107 	.db 0x00
      008214 00                    2108 	.db 0x00
      008215 00                    2109 	.db 0x00
      008216 00                    2110 	.db 0x00
      008217 00                    2111 	.db 0x00
      008218 00                    2112 	.db 0x00
      008219 00                    2113 	.db 0x00
      00821A 00                    2114 	.db 0x00
      00821B 00                    2115 	.db 0x00
      00821C 00                    2116 	.db 0x00
      00821D 00                    2117 	.db 0x00
      00821E 00                    2118 	.db 0x00
      00821F                       2119 __xinit__a:
      00821F 00                    2120 	.db #0x00	; 0
      008220 00                    2121 	.db 0x00
      008221 00                    2122 	.db 0x00
      008222                       2123 __xinit__d_addr:
      008222 00                    2124 	.db #0x00	; 0
      008223                       2125 __xinit__p_size:
      008223 00                    2126 	.db #0x00	; 0
      008224                       2127 __xinit__d_size:
      008224 00                    2128 	.db #0x00	; 0
      008225                       2129 __xinit__p_bytes:
      008225 00                    2130 	.db #0x00	; 0
      008226                       2131 __xinit__data_buf:
      008226 00                    2132 	.db #0x00	; 0
      008227 00                    2133 	.db 0x00
      008228 00                    2134 	.db 0x00
      008229 00                    2135 	.db 0x00
      00822A 00                    2136 	.db 0x00
      00822B 00                    2137 	.db 0x00
      00822C 00                    2138 	.db 0x00
      00822D 00                    2139 	.db 0x00
      00822E 00                    2140 	.db 0x00
      00822F 00                    2141 	.db 0x00
      008230 00                    2142 	.db 0x00
      008231 00                    2143 	.db 0x00
      008232 00                    2144 	.db 0x00
      008233 00                    2145 	.db 0x00
      008234 00                    2146 	.db 0x00
      008235 00                    2147 	.db 0x00
      008236 00                    2148 	.db 0x00
      008237 00                    2149 	.db 0x00
      008238 00                    2150 	.db 0x00
      008239 00                    2151 	.db 0x00
      00823A 00                    2152 	.db 0x00
      00823B 00                    2153 	.db 0x00
      00823C 00                    2154 	.db 0x00
      00823D 00                    2155 	.db 0x00
      00823E 00                    2156 	.db 0x00
      00823F 00                    2157 	.db 0x00
      008240 00                    2158 	.db 0x00
      008241 00                    2159 	.db 0x00
      008242 00                    2160 	.db 0x00
      008243 00                    2161 	.db 0x00
      008244 00                    2162 	.db 0x00
      008245 00                    2163 	.db 0x00
      008246 00                    2164 	.db 0x00
      008247 00                    2165 	.db 0x00
      008248 00                    2166 	.db 0x00
      008249 00                    2167 	.db 0x00
      00824A 00                    2168 	.db 0x00
      00824B 00                    2169 	.db 0x00
      00824C 00                    2170 	.db 0x00
      00824D 00                    2171 	.db 0x00
      00824E 00                    2172 	.db 0x00
      00824F 00                    2173 	.db 0x00
      008250 00                    2174 	.db 0x00
      008251 00                    2175 	.db 0x00
      008252 00                    2176 	.db 0x00
      008253 00                    2177 	.db 0x00
      008254 00                    2178 	.db 0x00
      008255 00                    2179 	.db 0x00
      008256 00                    2180 	.db 0x00
      008257 00                    2181 	.db 0x00
      008258 00                    2182 	.db 0x00
      008259 00                    2183 	.db 0x00
      00825A 00                    2184 	.db 0x00
      00825B 00                    2185 	.db 0x00
      00825C 00                    2186 	.db 0x00
      00825D 00                    2187 	.db 0x00
      00825E 00                    2188 	.db 0x00
      00825F 00                    2189 	.db 0x00
      008260 00                    2190 	.db 0x00
      008261 00                    2191 	.db 0x00
      008262 00                    2192 	.db 0x00
      008263 00                    2193 	.db 0x00
      008264 00                    2194 	.db 0x00
      008265 00                    2195 	.db 0x00
      008266 00                    2196 	.db 0x00
      008267 00                    2197 	.db 0x00
      008268 00                    2198 	.db 0x00
      008269 00                    2199 	.db 0x00
      00826A 00                    2200 	.db 0x00
      00826B 00                    2201 	.db 0x00
      00826C 00                    2202 	.db 0x00
      00826D 00                    2203 	.db 0x00
      00826E 00                    2204 	.db 0x00
      00826F 00                    2205 	.db 0x00
      008270 00                    2206 	.db 0x00
      008271 00                    2207 	.db 0x00
      008272 00                    2208 	.db 0x00
      008273 00                    2209 	.db 0x00
      008274 00                    2210 	.db 0x00
      008275 00                    2211 	.db 0x00
      008276 00                    2212 	.db 0x00
      008277 00                    2213 	.db 0x00
      008278 00                    2214 	.db 0x00
      008279 00                    2215 	.db 0x00
      00827A 00                    2216 	.db 0x00
      00827B 00                    2217 	.db 0x00
      00827C 00                    2218 	.db 0x00
      00827D 00                    2219 	.db 0x00
      00827E 00                    2220 	.db 0x00
      00827F 00                    2221 	.db 0x00
      008280 00                    2222 	.db 0x00
      008281 00                    2223 	.db 0x00
      008282 00                    2224 	.db 0x00
      008283 00                    2225 	.db 0x00
      008284 00                    2226 	.db 0x00
      008285 00                    2227 	.db 0x00
      008286 00                    2228 	.db 0x00
      008287 00                    2229 	.db 0x00
      008288 00                    2230 	.db 0x00
      008289 00                    2231 	.db 0x00
      00828A 00                    2232 	.db 0x00
      00828B 00                    2233 	.db 0x00
      00828C 00                    2234 	.db 0x00
      00828D 00                    2235 	.db 0x00
      00828E 00                    2236 	.db 0x00
      00828F 00                    2237 	.db 0x00
      008290 00                    2238 	.db 0x00
      008291 00                    2239 	.db 0x00
      008292 00                    2240 	.db 0x00
      008293 00                    2241 	.db 0x00
      008294 00                    2242 	.db 0x00
      008295 00                    2243 	.db 0x00
      008296 00                    2244 	.db 0x00
      008297 00                    2245 	.db 0x00
      008298 00                    2246 	.db 0x00
      008299 00                    2247 	.db 0x00
      00829A 00                    2248 	.db 0x00
      00829B 00                    2249 	.db 0x00
      00829C 00                    2250 	.db 0x00
      00829D 00                    2251 	.db 0x00
      00829E 00                    2252 	.db 0x00
      00829F 00                    2253 	.db 0x00
      0082A0 00                    2254 	.db 0x00
      0082A1 00                    2255 	.db 0x00
      0082A2 00                    2256 	.db 0x00
      0082A3 00                    2257 	.db 0x00
      0082A4 00                    2258 	.db 0x00
      0082A5 00                    2259 	.db 0x00
      0082A6 00                    2260 	.db 0x00
      0082A7 00                    2261 	.db 0x00
      0082A8 00                    2262 	.db 0x00
      0082A9 00                    2263 	.db 0x00
      0082AA 00                    2264 	.db 0x00
      0082AB 00                    2265 	.db 0x00
      0082AC 00                    2266 	.db 0x00
      0082AD 00                    2267 	.db 0x00
      0082AE 00                    2268 	.db 0x00
      0082AF 00                    2269 	.db 0x00
      0082B0 00                    2270 	.db 0x00
      0082B1 00                    2271 	.db 0x00
      0082B2 00                    2272 	.db 0x00
      0082B3 00                    2273 	.db 0x00
      0082B4 00                    2274 	.db 0x00
      0082B5 00                    2275 	.db 0x00
      0082B6 00                    2276 	.db 0x00
      0082B7 00                    2277 	.db 0x00
      0082B8 00                    2278 	.db 0x00
      0082B9 00                    2279 	.db 0x00
      0082BA 00                    2280 	.db 0x00
      0082BB 00                    2281 	.db 0x00
      0082BC 00                    2282 	.db 0x00
      0082BD 00                    2283 	.db 0x00
      0082BE 00                    2284 	.db 0x00
      0082BF 00                    2285 	.db 0x00
      0082C0 00                    2286 	.db 0x00
      0082C1 00                    2287 	.db 0x00
      0082C2 00                    2288 	.db 0x00
      0082C3 00                    2289 	.db 0x00
      0082C4 00                    2290 	.db 0x00
      0082C5 00                    2291 	.db 0x00
      0082C6 00                    2292 	.db 0x00
      0082C7 00                    2293 	.db 0x00
      0082C8 00                    2294 	.db 0x00
      0082C9 00                    2295 	.db 0x00
      0082CA 00                    2296 	.db 0x00
      0082CB 00                    2297 	.db 0x00
      0082CC 00                    2298 	.db 0x00
      0082CD 00                    2299 	.db 0x00
      0082CE 00                    2300 	.db 0x00
      0082CF 00                    2301 	.db 0x00
      0082D0 00                    2302 	.db 0x00
      0082D1 00                    2303 	.db 0x00
      0082D2 00                    2304 	.db 0x00
      0082D3 00                    2305 	.db 0x00
      0082D4 00                    2306 	.db 0x00
      0082D5 00                    2307 	.db 0x00
      0082D6 00                    2308 	.db 0x00
      0082D7 00                    2309 	.db 0x00
      0082D8 00                    2310 	.db 0x00
      0082D9 00                    2311 	.db 0x00
      0082DA 00                    2312 	.db 0x00
      0082DB 00                    2313 	.db 0x00
      0082DC 00                    2314 	.db 0x00
      0082DD 00                    2315 	.db 0x00
      0082DE 00                    2316 	.db 0x00
      0082DF 00                    2317 	.db 0x00
      0082E0 00                    2318 	.db 0x00
      0082E1 00                    2319 	.db 0x00
      0082E2 00                    2320 	.db 0x00
      0082E3 00                    2321 	.db 0x00
      0082E4 00                    2322 	.db 0x00
      0082E5 00                    2323 	.db 0x00
      0082E6 00                    2324 	.db 0x00
      0082E7 00                    2325 	.db 0x00
      0082E8 00                    2326 	.db 0x00
      0082E9 00                    2327 	.db 0x00
      0082EA 00                    2328 	.db 0x00
      0082EB 00                    2329 	.db 0x00
      0082EC 00                    2330 	.db 0x00
      0082ED 00                    2331 	.db 0x00
      0082EE 00                    2332 	.db 0x00
      0082EF 00                    2333 	.db 0x00
      0082F0 00                    2334 	.db 0x00
      0082F1 00                    2335 	.db 0x00
      0082F2 00                    2336 	.db 0x00
      0082F3 00                    2337 	.db 0x00
      0082F4 00                    2338 	.db 0x00
      0082F5 00                    2339 	.db 0x00
      0082F6 00                    2340 	.db 0x00
      0082F7 00                    2341 	.db 0x00
      0082F8 00                    2342 	.db 0x00
      0082F9 00                    2343 	.db 0x00
      0082FA 00                    2344 	.db 0x00
      0082FB 00                    2345 	.db 0x00
      0082FC 00                    2346 	.db 0x00
      0082FD 00                    2347 	.db 0x00
      0082FE 00                    2348 	.db 0x00
      0082FF 00                    2349 	.db 0x00
      008300 00                    2350 	.db 0x00
      008301 00                    2351 	.db 0x00
      008302 00                    2352 	.db 0x00
      008303 00                    2353 	.db 0x00
      008304 00                    2354 	.db 0x00
      008305 00                    2355 	.db 0x00
      008306 00                    2356 	.db 0x00
      008307 00                    2357 	.db 0x00
      008308 00                    2358 	.db 0x00
      008309 00                    2359 	.db 0x00
      00830A 00                    2360 	.db 0x00
      00830B 00                    2361 	.db 0x00
      00830C 00                    2362 	.db 0x00
      00830D 00                    2363 	.db 0x00
      00830E 00                    2364 	.db 0x00
      00830F 00                    2365 	.db 0x00
      008310 00                    2366 	.db 0x00
      008311 00                    2367 	.db 0x00
      008312 00                    2368 	.db 0x00
      008313 00                    2369 	.db 0x00
      008314 00                    2370 	.db 0x00
      008315 00                    2371 	.db 0x00
      008316 00                    2372 	.db 0x00
      008317 00                    2373 	.db 0x00
      008318 00                    2374 	.db 0x00
      008319 00                    2375 	.db 0x00
      00831A 00                    2376 	.db 0x00
      00831B 00                    2377 	.db 0x00
      00831C 00                    2378 	.db 0x00
      00831D 00                    2379 	.db 0x00
      00831E 00                    2380 	.db 0x00
      00831F 00                    2381 	.db 0x00
      008320 00                    2382 	.db 0x00
      008321 00                    2383 	.db 0x00
      008322 00                    2384 	.db 0x00
      008323 00                    2385 	.db 0x00
      008324 00                    2386 	.db 0x00
      008325                       2387 __xinit__current_dev:
      008325 77                    2388 	.db #0x77	; 119	'w'
                                   2389 	.area CABS (ABS)
