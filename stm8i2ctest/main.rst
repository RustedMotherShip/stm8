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
      008007 CD 8B 41         [ 4]  110 	call	___sdcc_external_startup
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
      008021 D6 80 FE         [ 1]  126 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 8A 74         [ 2]  140 	jp	_main
                                    141 ;	return from main will return to caller
                                    142 ;--------------------------------------------------------
                                    143 ; code
                                    144 ;--------------------------------------------------------
                                    145 	.area CODE
                                    146 ;	main.c: 26: void delay(unsigned long count) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function delay
                                    149 ;	-----------------------------------------
      008307                        150 _delay:
      008307 52 08            [ 2]  151 	sub	sp, #8
                                    152 ;	main.c: 27: while (count--)
      008309 16 0D            [ 2]  153 	ldw	y, (0x0d, sp)
      00830B 17 07            [ 2]  154 	ldw	(0x07, sp), y
      00830D 1E 0B            [ 2]  155 	ldw	x, (0x0b, sp)
      00830F                        156 00101$:
      00830F 1F 01            [ 2]  157 	ldw	(0x01, sp), x
      008311 7B 07            [ 1]  158 	ld	a, (0x07, sp)
      008313 6B 03            [ 1]  159 	ld	(0x03, sp), a
      008315 7B 08            [ 1]  160 	ld	a, (0x08, sp)
      008317 16 07            [ 2]  161 	ldw	y, (0x07, sp)
      008319 72 A2 00 01      [ 2]  162 	subw	y, #0x0001
      00831D 17 07            [ 2]  163 	ldw	(0x07, sp), y
      00831F 24 01            [ 1]  164 	jrnc	00117$
      008321 5A               [ 2]  165 	decw	x
      008322                        166 00117$:
      008322 4D               [ 1]  167 	tnz	a
      008323 26 08            [ 1]  168 	jrne	00118$
      008325 16 02            [ 2]  169 	ldw	y, (0x02, sp)
      008327 26 04            [ 1]  170 	jrne	00118$
      008329 0D 01            [ 1]  171 	tnz	(0x01, sp)
      00832B 27 03            [ 1]  172 	jreq	00104$
      00832D                        173 00118$:
                                    174 ;	main.c: 28: nop();
      00832D 9D               [ 1]  175 	nop
      00832E 20 DF            [ 2]  176 	jra	00101$
      008330                        177 00104$:
                                    178 ;	main.c: 29: }
      008330 1E 09            [ 2]  179 	ldw	x, (9, sp)
      008332 5B 0E            [ 2]  180 	addw	sp, #14
      008334 FC               [ 2]  181 	jp	(x)
                                    182 ;	main.c: 37: void UART_TX(unsigned char value)
                                    183 ;	-----------------------------------------
                                    184 ;	 function UART_TX
                                    185 ;	-----------------------------------------
      008335                        186 _UART_TX:
                                    187 ;	main.c: 39: UART1_DR = value;
      008335 C7 52 31         [ 1]  188 	ld	0x5231, a
                                    189 ;	main.c: 40: while(!(UART1_SR & UART_SR_TXE));
      008338                        190 00101$:
      008338 C6 52 30         [ 1]  191 	ld	a, 0x5230
      00833B 2A FB            [ 1]  192 	jrpl	00101$
                                    193 ;	main.c: 41: }
      00833D 81               [ 4]  194 	ret
                                    195 ;	main.c: 42: unsigned char UART_RX(void)
                                    196 ;	-----------------------------------------
                                    197 ;	 function UART_RX
                                    198 ;	-----------------------------------------
      00833E                        199 _UART_RX:
                                    200 ;	main.c: 44: while(!(UART1_SR & UART_SR_TXE));
      00833E                        201 00101$:
      00833E C6 52 30         [ 1]  202 	ld	a, 0x5230
      008341 2A FB            [ 1]  203 	jrpl	00101$
                                    204 ;	main.c: 45: return UART1_DR;
      008343 C6 52 31         [ 1]  205 	ld	a, 0x5231
                                    206 ;	main.c: 46: }
      008346 81               [ 4]  207 	ret
                                    208 ;	main.c: 47: int uart_write(const char *str) {
                                    209 ;	-----------------------------------------
                                    210 ;	 function uart_write
                                    211 ;	-----------------------------------------
      008347                        212 _uart_write:
      008347 52 05            [ 2]  213 	sub	sp, #5
      008349 1F 03            [ 2]  214 	ldw	(0x03, sp), x
                                    215 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      00834B 0F 05            [ 1]  216 	clr	(0x05, sp)
      00834D                        217 00103$:
      00834D 1E 03            [ 2]  218 	ldw	x, (0x03, sp)
      00834F CD 8B 43         [ 4]  219 	call	_strlen
      008352 1F 01            [ 2]  220 	ldw	(0x01, sp), x
      008354 7B 05            [ 1]  221 	ld	a, (0x05, sp)
      008356 5F               [ 1]  222 	clrw	x
      008357 97               [ 1]  223 	ld	xl, a
      008358 13 01            [ 2]  224 	cpw	x, (0x01, sp)
      00835A 24 0F            [ 1]  225 	jrnc	00101$
                                    226 ;	main.c: 51: UART_TX(str[i]);
      00835C 5F               [ 1]  227 	clrw	x
      00835D 7B 05            [ 1]  228 	ld	a, (0x05, sp)
      00835F 97               [ 1]  229 	ld	xl, a
      008360 72 FB 03         [ 2]  230 	addw	x, (0x03, sp)
      008363 F6               [ 1]  231 	ld	a, (x)
      008364 CD 83 35         [ 4]  232 	call	_UART_TX
                                    233 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      008367 0C 05            [ 1]  234 	inc	(0x05, sp)
      008369 20 E2            [ 2]  235 	jra	00103$
      00836B                        236 00101$:
                                    237 ;	main.c: 53: return(i); // Bytes sent
      00836B 7B 05            [ 1]  238 	ld	a, (0x05, sp)
      00836D 5F               [ 1]  239 	clrw	x
      00836E 97               [ 1]  240 	ld	xl, a
                                    241 ;	main.c: 54: }
      00836F 5B 05            [ 2]  242 	addw	sp, #5
      008371 81               [ 4]  243 	ret
                                    244 ;	main.c: 55: int uart_read(void)
                                    245 ;	-----------------------------------------
                                    246 ;	 function uart_read
                                    247 ;	-----------------------------------------
      008372                        248 _uart_read:
                                    249 ;	main.c: 57: memset(buffer, 0, sizeof(buffer));
      008372 4B 00            [ 1]  250 	push	#0x00
      008374 4B 01            [ 1]  251 	push	#0x01
      008376 5F               [ 1]  252 	clrw	x
      008377 89               [ 2]  253 	pushw	x
      008378 AE 00 01         [ 2]  254 	ldw	x, #(_buffer+0)
      00837B CD 8B 1F         [ 4]  255 	call	_memset
                                    256 ;	main.c: 59: while(i<256)
      00837E 5F               [ 1]  257 	clrw	x
      00837F                        258 00105$:
      00837F A3 01 00         [ 2]  259 	cpw	x, #0x0100
      008382 2E 22            [ 1]  260 	jrsge	00107$
                                    261 ;	main.c: 61: if(UART1_SR & UART_SR_RXNE)
      008384 C6 52 30         [ 1]  262 	ld	a, 0x5230
      008387 A5 20            [ 1]  263 	bcp	a, #0x20
      008389 27 F4            [ 1]  264 	jreq	00105$
                                    265 ;	main.c: 63: buffer[i] = UART_RX();
      00838B 90 93            [ 1]  266 	ldw	y, x
      00838D 72 A9 00 01      [ 2]  267 	addw	y, #(_buffer+0)
      008391 89               [ 2]  268 	pushw	x
      008392 90 89            [ 2]  269 	pushw	y
      008394 CD 83 3E         [ 4]  270 	call	_UART_RX
      008397 90 85            [ 2]  271 	popw	y
      008399 85               [ 2]  272 	popw	x
      00839A 90 F7            [ 1]  273 	ld	(y), a
                                    274 ;	main.c: 64: if(buffer[i] == '\r\n' )
      00839C A1 0D            [ 1]  275 	cp	a, #0x0d
      00839E 26 03            [ 1]  276 	jrne	00102$
                                    277 ;	main.c: 66: return 1;
      0083A0 5F               [ 1]  278 	clrw	x
      0083A1 5C               [ 1]  279 	incw	x
      0083A2 81               [ 4]  280 	ret
                                    281 ;	main.c: 67: break;
      0083A3                        282 00102$:
                                    283 ;	main.c: 69: i++;
      0083A3 5C               [ 1]  284 	incw	x
      0083A4 20 D9            [ 2]  285 	jra	00105$
      0083A6                        286 00107$:
                                    287 ;	main.c: 72: return 0;
      0083A6 5F               [ 1]  288 	clrw	x
                                    289 ;	main.c: 73: }
      0083A7 81               [ 4]  290 	ret
                                    291 ;	main.c: 82: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    292 ;	-----------------------------------------
                                    293 ;	 function convert_int_to_chars
                                    294 ;	-----------------------------------------
      0083A8                        295 _convert_int_to_chars:
      0083A8 52 0D            [ 2]  296 	sub	sp, #13
      0083AA 6B 0D            [ 1]  297 	ld	(0x0d, sp), a
      0083AC 1F 0B            [ 2]  298 	ldw	(0x0b, sp), x
                                    299 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      0083AE 7B 0D            [ 1]  300 	ld	a, (0x0d, sp)
      0083B0 6B 02            [ 1]  301 	ld	(0x02, sp), a
      0083B2 0F 01            [ 1]  302 	clr	(0x01, sp)
                                    303 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083B4 1E 0B            [ 2]  304 	ldw	x, (0x0b, sp)
      0083B6 5C               [ 1]  305 	incw	x
      0083B7 1F 03            [ 2]  306 	ldw	(0x03, sp), x
                                    307 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083B9 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      0083BB 5C               [ 1]  309 	incw	x
      0083BC 5C               [ 1]  310 	incw	x
      0083BD 1F 05            [ 2]  311 	ldw	(0x05, sp), x
                                    312 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083BF 4B 0A            [ 1]  313 	push	#0x0a
      0083C1 4B 00            [ 1]  314 	push	#0x00
      0083C3 1E 03            [ 2]  315 	ldw	x, (0x03, sp)
                                    316 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083C5 CD 8B 68         [ 4]  317 	call	__divsint
      0083C8 1F 07            [ 2]  318 	ldw	(0x07, sp), x
      0083CA 4B 0A            [ 1]  319 	push	#0x0a
      0083CC 4B 00            [ 1]  320 	push	#0x00
      0083CE 1E 03            [ 2]  321 	ldw	x, (0x03, sp)
      0083D0 CD 8B 50         [ 4]  322 	call	__modsint
      0083D3 9F               [ 1]  323 	ld	a, xl
      0083D4 AB 30            [ 1]  324 	add	a, #0x30
      0083D6 6B 09            [ 1]  325 	ld	(0x09, sp), a
                                    326 ;	main.c: 83: if (num > 99) {
      0083D8 7B 0D            [ 1]  327 	ld	a, (0x0d, sp)
      0083DA A1 63            [ 1]  328 	cp	a, #0x63
      0083DC 23 29            [ 2]  329 	jrule	00105$
                                    330 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      0083DE 4B 64            [ 1]  331 	push	#0x64
      0083E0 4B 00            [ 1]  332 	push	#0x00
      0083E2 1E 03            [ 2]  333 	ldw	x, (0x03, sp)
      0083E4 CD 8B 68         [ 4]  334 	call	__divsint
      0083E7 9F               [ 1]  335 	ld	a, xl
      0083E8 AB 30            [ 1]  336 	add	a, #0x30
      0083EA 1E 0B            [ 2]  337 	ldw	x, (0x0b, sp)
      0083EC F7               [ 1]  338 	ld	(x), a
                                    339 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      0083ED 4B 0A            [ 1]  340 	push	#0x0a
      0083EF 4B 00            [ 1]  341 	push	#0x00
      0083F1 1E 09            [ 2]  342 	ldw	x, (0x09, sp)
      0083F3 CD 8B 50         [ 4]  343 	call	__modsint
      0083F6 9F               [ 1]  344 	ld	a, xl
      0083F7 AB 30            [ 1]  345 	add	a, #0x30
      0083F9 1E 03            [ 2]  346 	ldw	x, (0x03, sp)
      0083FB F7               [ 1]  347 	ld	(x), a
                                    348 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083FC 1E 05            [ 2]  349 	ldw	x, (0x05, sp)
      0083FE 7B 09            [ 1]  350 	ld	a, (0x09, sp)
      008400 F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 88: rx_int_chars[3] ='\0';
      008401 1E 0B            [ 2]  353 	ldw	x, (0x0b, sp)
      008403 6F 03            [ 1]  354 	clr	(0x0003, x)
      008405 20 23            [ 2]  355 	jra	00107$
      008407                        356 00105$:
                                    357 ;	main.c: 90: } else if (num > 9) {
      008407 7B 0D            [ 1]  358 	ld	a, (0x0d, sp)
      008409 A1 09            [ 1]  359 	cp	a, #0x09
      00840B 23 13            [ 2]  360 	jrule	00102$
                                    361 ;	main.c: 92: rx_int_chars[0] = num / 10 + '0';
      00840D 7B 08            [ 1]  362 	ld	a, (0x08, sp)
      00840F 6B 0A            [ 1]  363 	ld	(0x0a, sp), a
      008411 AB 30            [ 1]  364 	add	a, #0x30
      008413 1E 0B            [ 2]  365 	ldw	x, (0x0b, sp)
      008415 F7               [ 1]  366 	ld	(x), a
                                    367 ;	main.c: 93: rx_int_chars[1] = num % 10 + '0';
      008416 1E 03            [ 2]  368 	ldw	x, (0x03, sp)
      008418 7B 09            [ 1]  369 	ld	a, (0x09, sp)
      00841A F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 94: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      00841B 1E 05            [ 2]  372 	ldw	x, (0x05, sp)
      00841D 7F               [ 1]  373 	clr	(x)
      00841E 20 0A            [ 2]  374 	jra	00107$
      008420                        375 00102$:
                                    376 ;	main.c: 97: rx_int_chars[0] = num + '0';
      008420 7B 0D            [ 1]  377 	ld	a, (0x0d, sp)
      008422 AB 30            [ 1]  378 	add	a, #0x30
      008424 1E 0B            [ 2]  379 	ldw	x, (0x0b, sp)
      008426 F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 98: rx_int_chars[1] ='\0';
      008427 1E 03            [ 2]  382 	ldw	x, (0x03, sp)
      008429 7F               [ 1]  383 	clr	(x)
      00842A                        384 00107$:
                                    385 ;	main.c: 100: }
      00842A 5B 0D            [ 2]  386 	addw	sp, #13
      00842C 81               [ 4]  387 	ret
                                    388 ;	main.c: 102: uint8_t convert_chars_to_int(char* rx_chars_int) {
                                    389 ;	-----------------------------------------
                                    390 ;	 function convert_chars_to_int
                                    391 ;	-----------------------------------------
      00842D                        392 _convert_chars_to_int:
      00842D 52 03            [ 2]  393 	sub	sp, #3
      00842F 1F 02            [ 2]  394 	ldw	(0x02, sp), x
                                    395 ;	main.c: 103: uint8_t result = 0;
      008431 4F               [ 1]  396 	clr	a
                                    397 ;	main.c: 105: for (int i = 0; i < 3; i++) {
      008432 5F               [ 1]  398 	clrw	x
      008433                        399 00103$:
      008433 A3 00 03         [ 2]  400 	cpw	x, #0x0003
      008436 2E 18            [ 1]  401 	jrsge	00101$
                                    402 ;	main.c: 106: result = (result * 10) + (rx_chars_int[i] - '0');
      008438 90 97            [ 1]  403 	ld	yl, a
      00843A A6 0A            [ 1]  404 	ld	a, #0x0a
      00843C 90 42            [ 4]  405 	mul	y, a
      00843E 61               [ 1]  406 	exg	a, yl
      00843F 6B 01            [ 1]  407 	ld	(0x01, sp), a
      008441 61               [ 1]  408 	exg	a, yl
      008442 90 93            [ 1]  409 	ldw	y, x
      008444 72 F9 02         [ 2]  410 	addw	y, (0x02, sp)
      008447 90 F6            [ 1]  411 	ld	a, (y)
      008449 A0 30            [ 1]  412 	sub	a, #0x30
      00844B 1B 01            [ 1]  413 	add	a, (0x01, sp)
                                    414 ;	main.c: 105: for (int i = 0; i < 3; i++) {
      00844D 5C               [ 1]  415 	incw	x
      00844E 20 E3            [ 2]  416 	jra	00103$
      008450                        417 00101$:
                                    418 ;	main.c: 109: return result;
                                    419 ;	main.c: 110: }
      008450 5B 03            [ 2]  420 	addw	sp, #3
      008452 81               [ 4]  421 	ret
                                    422 ;	main.c: 113: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    423 ;	-----------------------------------------
                                    424 ;	 function convert_int_to_binary
                                    425 ;	-----------------------------------------
      008453                        426 _convert_int_to_binary:
      008453 52 04            [ 2]  427 	sub	sp, #4
      008455 1F 01            [ 2]  428 	ldw	(0x01, sp), x
                                    429 ;	main.c: 115: for(int i = 7; i >= 0; i--) {
      008457 AE 00 07         [ 2]  430 	ldw	x, #0x0007
      00845A 1F 03            [ 2]  431 	ldw	(0x03, sp), x
      00845C                        432 00103$:
      00845C 0D 03            [ 1]  433 	tnz	(0x03, sp)
      00845E 2B 22            [ 1]  434 	jrmi	00101$
                                    435 ;	main.c: 117: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008460 AE 00 07         [ 2]  436 	ldw	x, #0x0007
      008463 72 F0 03         [ 2]  437 	subw	x, (0x03, sp)
      008466 72 FB 07         [ 2]  438 	addw	x, (0x07, sp)
      008469 16 01            [ 2]  439 	ldw	y, (0x01, sp)
      00846B 7B 04            [ 1]  440 	ld	a, (0x04, sp)
      00846D 27 05            [ 1]  441 	jreq	00120$
      00846F                        442 00119$:
      00846F 90 57            [ 2]  443 	sraw	y
      008471 4A               [ 1]  444 	dec	a
      008472 26 FB            [ 1]  445 	jrne	00119$
      008474                        446 00120$:
      008474 90 9F            [ 1]  447 	ld	a, yl
      008476 A4 01            [ 1]  448 	and	a, #0x01
      008478 AB 30            [ 1]  449 	add	a, #0x30
      00847A F7               [ 1]  450 	ld	(x), a
                                    451 ;	main.c: 115: for(int i = 7; i >= 0; i--) {
      00847B 1E 03            [ 2]  452 	ldw	x, (0x03, sp)
      00847D 5A               [ 2]  453 	decw	x
      00847E 1F 03            [ 2]  454 	ldw	(0x03, sp), x
      008480 20 DA            [ 2]  455 	jra	00103$
      008482                        456 00101$:
                                    457 ;	main.c: 119: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008482 1E 07            [ 2]  458 	ldw	x, (0x07, sp)
      008484 6F 08            [ 1]  459 	clr	(0x0008, x)
                                    460 ;	main.c: 120: }
      008486 1E 05            [ 2]  461 	ldw	x, (5, sp)
      008488 5B 08            [ 2]  462 	addw	sp, #8
      00848A FC               [ 2]  463 	jp	(x)
                                    464 ;	main.c: 129: void get_addr_from_buff(void)
                                    465 ;	-----------------------------------------
                                    466 ;	 function get_addr_from_buff
                                    467 ;	-----------------------------------------
      00848B                        468 _get_addr_from_buff:
      00848B 52 02            [ 2]  469 	sub	sp, #2
                                    470 ;	main.c: 133: while(1)
      00848D A6 04            [ 1]  471 	ld	a, #0x04
      00848F 6B 01            [ 1]  472 	ld	(0x01, sp), a
      008491 0F 02            [ 1]  473 	clr	(0x02, sp)
      008493                        474 00105$:
                                    475 ;	main.c: 135: if(buffer[i] == 32 || buffer[i] == 10)
      008493 5F               [ 1]  476 	clrw	x
      008494 7B 01            [ 1]  477 	ld	a, (0x01, sp)
      008496 97               [ 1]  478 	ld	xl, a
      008497 D6 00 01         [ 1]  479 	ld	a, (_buffer+0, x)
      00849A A1 20            [ 1]  480 	cp	a, #0x20
      00849C 27 04            [ 1]  481 	jreq	00101$
      00849E A1 0A            [ 1]  482 	cp	a, #0x0a
      0084A0 26 08            [ 1]  483 	jrne	00102$
      0084A2                        484 00101$:
                                    485 ;	main.c: 137: p_size = i+1;
      0084A2 7B 01            [ 1]  486 	ld	a, (0x01, sp)
      0084A4 4C               [ 1]  487 	inc	a
      0084A5 C7 01 05         [ 1]  488 	ld	_p_size+0, a
                                    489 ;	main.c: 138: break;
      0084A8 20 06            [ 2]  490 	jra	00106$
      0084AA                        491 00102$:
                                    492 ;	main.c: 140: i++;
      0084AA 0C 01            [ 1]  493 	inc	(0x01, sp)
                                    494 ;	main.c: 141: counter++;
      0084AC 0C 02            [ 1]  495 	inc	(0x02, sp)
      0084AE 20 E3            [ 2]  496 	jra	00105$
      0084B0                        497 00106$:
                                    498 ;	main.c: 143: memcpy(a, &buffer[3], counter);
      0084B0 5F               [ 1]  499 	clrw	x
      0084B1 7B 02            [ 1]  500 	ld	a, (0x02, sp)
      0084B3 97               [ 1]  501 	ld	xl, a
      0084B4 89               [ 2]  502 	pushw	x
      0084B5 4B 04            [ 1]  503 	push	#<(_buffer+3)
      0084B7 4B 00            [ 1]  504 	push	#((_buffer+3) >> 8)
      0084B9 AE 01 01         [ 2]  505 	ldw	x, #(_a+0)
      0084BC CD 8A CC         [ 4]  506 	call	___memcpy
                                    507 ;	main.c: 144: d_addr = convert_chars_to_int(a);
      0084BF AE 01 01         [ 2]  508 	ldw	x, #(_a+0)
      0084C2 CD 84 2D         [ 4]  509 	call	_convert_chars_to_int
      0084C5 C7 01 04         [ 1]  510 	ld	_d_addr+0, a
                                    511 ;	main.c: 145: }
      0084C8 5B 02            [ 2]  512 	addw	sp, #2
      0084CA 81               [ 4]  513 	ret
                                    514 ;	main.c: 147: void get_size_from_buff(void)
                                    515 ;	-----------------------------------------
                                    516 ;	 function get_size_from_buff
                                    517 ;	-----------------------------------------
      0084CB                        518 _get_size_from_buff:
      0084CB 88               [ 1]  519 	push	a
                                    520 ;	main.c: 150: uint8_t i = p_size;
      0084CC C6 01 05         [ 1]  521 	ld	a, _p_size+0
      0084CF 6B 01            [ 1]  522 	ld	(0x01, sp), a
                                    523 ;	main.c: 151: while(1)
      0084D1 90 5F            [ 1]  524 	clrw	y
      0084D3                        525 00105$:
                                    526 ;	main.c: 153: if(buffer[i] == 32 || buffer[i] == 10)
      0084D3 5F               [ 1]  527 	clrw	x
      0084D4 7B 01            [ 1]  528 	ld	a, (0x01, sp)
      0084D6 97               [ 1]  529 	ld	xl, a
      0084D7 D6 00 01         [ 1]  530 	ld	a, (_buffer+0, x)
      0084DA A1 20            [ 1]  531 	cp	a, #0x20
      0084DC 27 04            [ 1]  532 	jreq	00101$
      0084DE A1 0A            [ 1]  533 	cp	a, #0x0a
      0084E0 26 08            [ 1]  534 	jrne	00102$
      0084E2                        535 00101$:
                                    536 ;	main.c: 155: p_bytes = i+1;
      0084E2 7B 01            [ 1]  537 	ld	a, (0x01, sp)
      0084E4 4C               [ 1]  538 	inc	a
      0084E5 C7 01 07         [ 1]  539 	ld	_p_bytes+0, a
                                    540 ;	main.c: 156: break;
      0084E8 20 06            [ 2]  541 	jra	00106$
      0084EA                        542 00102$:
                                    543 ;	main.c: 158: i++;
      0084EA 0C 01            [ 1]  544 	inc	(0x01, sp)
                                    545 ;	main.c: 159: counter++;
      0084EC 90 5C            [ 1]  546 	incw	y
      0084EE 20 E3            [ 2]  547 	jra	00105$
      0084F0                        548 00106$:
                                    549 ;	main.c: 161: memcpy(a, &buffer[p_size], counter);
      0084F0 4F               [ 1]  550 	clr	a
      0084F1 90 95            [ 1]  551 	ld	yh, a
      0084F3 5F               [ 1]  552 	clrw	x
      0084F4 C6 01 05         [ 1]  553 	ld	a, _p_size+0
      0084F7 97               [ 1]  554 	ld	xl, a
      0084F8 1C 00 01         [ 2]  555 	addw	x, #(_buffer+0)
      0084FB 90 89            [ 2]  556 	pushw	y
      0084FD 89               [ 2]  557 	pushw	x
      0084FE AE 01 01         [ 2]  558 	ldw	x, #(_a+0)
      008501 CD 8A CC         [ 4]  559 	call	___memcpy
                                    560 ;	main.c: 162: d_size = convert_chars_to_int(a);
      008504 AE 01 01         [ 2]  561 	ldw	x, #(_a+0)
      008507 CD 84 2D         [ 4]  562 	call	_convert_chars_to_int
      00850A C7 01 06         [ 1]  563 	ld	_d_size+0, a
                                    564 ;	main.c: 163: }
      00850D 84               [ 1]  565 	pop	a
      00850E 81               [ 4]  566 	ret
                                    567 ;	main.c: 164: void char_buffer_to_int(void)
                                    568 ;	-----------------------------------------
                                    569 ;	 function char_buffer_to_int
                                    570 ;	-----------------------------------------
      00850F                        571 _char_buffer_to_int:
      00850F 52 06            [ 2]  572 	sub	sp, #6
                                    573 ;	main.c: 166: uint8_t counter = d_size;
      008511 C6 01 06         [ 1]  574 	ld	a, _d_size+0
      008514 6B 03            [ 1]  575 	ld	(0x03, sp), a
                                    576 ;	main.c: 167: uint8_t i = p_bytes;
      008516 C6 01 07         [ 1]  577 	ld	a, _p_bytes+0
      008519 6B 06            [ 1]  578 	ld	(0x06, sp), a
                                    579 ;	main.c: 168: uint8_t buf_i = 0;
      00851B 0F 05            [ 1]  580 	clr	(0x05, sp)
                                    581 ;	main.c: 169: while(counter > 0) // 
      00851D 0F 04            [ 1]  582 	clr	(0x04, sp)
      00851F                        583 00113$:
      00851F 0D 03            [ 1]  584 	tnz	(0x03, sp)
      008521 27 73            [ 1]  585 	jreq	00116$
                                    586 ;	main.c: 171: if(buffer[i] == ' ')
      008523 5F               [ 1]  587 	clrw	x
      008524 7B 06            [ 1]  588 	ld	a, (0x06, sp)
      008526 97               [ 1]  589 	ld	xl, a
      008527 D6 00 01         [ 1]  590 	ld	a, (_buffer+0, x)
      00852A A1 20            [ 1]  591 	cp	a, #0x20
      00852C 26 44            [ 1]  592 	jrne	00111$
                                    593 ;	main.c: 174: while(1)
      00852E 0F 05            [ 1]  594 	clr	(0x05, sp)
      008530                        595 00105$:
                                    596 ;	main.c: 176: i++;
      008530 0C 06            [ 1]  597 	inc	(0x06, sp)
                                    598 ;	main.c: 177: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008532 5F               [ 1]  599 	clrw	x
      008533 7B 06            [ 1]  600 	ld	a, (0x06, sp)
      008535 97               [ 1]  601 	ld	xl, a
      008536 1C 00 01         [ 2]  602 	addw	x, #(_buffer+0)
      008539 1F 01            [ 2]  603 	ldw	(0x01, sp), x
      00853B F6               [ 1]  604 	ld	a, (x)
      00853C A1 20            [ 1]  605 	cp	a, #0x20
      00853E 27 08            [ 1]  606 	jreq	00125$
      008540 A1 0D            [ 1]  607 	cp	a, #0x0d
      008542 27 04            [ 1]  608 	jreq	00125$
                                    609 ;	main.c: 179: buf_counter++;
      008544 0C 05            [ 1]  610 	inc	(0x05, sp)
      008546 20 E8            [ 2]  611 	jra	00105$
      008548                        612 00125$:
                                    613 ;	main.c: 181: memcpy(a, &buffer[i], buf_counter);
      008548 7B 05            [ 1]  614 	ld	a, (0x05, sp)
      00854A 5F               [ 1]  615 	clrw	x
      00854B 16 01            [ 2]  616 	ldw	y, (0x01, sp)
      00854D 88               [ 1]  617 	push	a
      00854E 9E               [ 1]  618 	ld	a, xh
      00854F 88               [ 1]  619 	push	a
      008550 90 89            [ 2]  620 	pushw	y
      008552 AE 01 01         [ 2]  621 	ldw	x, #(_a+0)
      008555 CD 8A CC         [ 4]  622 	call	___memcpy
                                    623 ;	main.c: 185: data_buf[buf_i] = convert_chars_to_int(a);
      008558 5F               [ 1]  624 	clrw	x
      008559 7B 04            [ 1]  625 	ld	a, (0x04, sp)
      00855B 97               [ 1]  626 	ld	xl, a
      00855C 1C 01 08         [ 2]  627 	addw	x, #(_data_buf+0)
      00855F 89               [ 2]  628 	pushw	x
      008560 AE 01 01         [ 2]  629 	ldw	x, #(_a+0)
      008563 CD 84 2D         [ 4]  630 	call	_convert_chars_to_int
      008566 85               [ 2]  631 	popw	x
      008567 F7               [ 1]  632 	ld	(x), a
                                    633 ;	main.c: 186: counter--;
      008568 0A 03            [ 1]  634 	dec	(0x03, sp)
                                    635 ;	main.c: 187: buf_i++;
      00856A 0C 04            [ 1]  636 	inc	(0x04, sp)
      00856C 7B 04            [ 1]  637 	ld	a, (0x04, sp)
      00856E 6B 05            [ 1]  638 	ld	(0x05, sp), a
      008570 20 AD            [ 2]  639 	jra	00113$
      008572                        640 00111$:
                                    641 ;	main.c: 189: else if(buffer[i] == '\r\n')
      008572 A1 0D            [ 1]  642 	cp	a, #0x0d
      008574 26 1C            [ 1]  643 	jrne	00108$
                                    644 ;	main.c: 191: convert_int_to_chars(buf_i, a);
      008576 AE 01 01         [ 2]  645 	ldw	x, #(_a+0)
      008579 7B 05            [ 1]  646 	ld	a, (0x05, sp)
      00857B CD 83 A8         [ 4]  647 	call	_convert_int_to_chars
                                    648 ;	main.c: 192: uart_write("buf count -> ");
      00857E AE 80 2D         [ 2]  649 	ldw	x, #(___str_0+0)
      008581 CD 83 47         [ 4]  650 	call	_uart_write
                                    651 ;	main.c: 193: uart_write(a);
      008584 AE 01 01         [ 2]  652 	ldw	x, #(_a+0)
      008587 CD 83 47         [ 4]  653 	call	_uart_write
                                    654 ;	main.c: 194: uart_write(" <-\n");
      00858A AE 80 3B         [ 2]  655 	ldw	x, #(___str_1+0)
      00858D 5B 06            [ 2]  656 	addw	sp, #6
                                    657 ;	main.c: 195: break;
      00858F CC 83 47         [ 2]  658 	jp	_uart_write
      008592                        659 00108$:
                                    660 ;	main.c: 198: i++;
      008592 0C 06            [ 1]  661 	inc	(0x06, sp)
      008594 20 89            [ 2]  662 	jra	00113$
      008596                        663 00116$:
                                    664 ;	main.c: 202: }
      008596 5B 06            [ 2]  665 	addw	sp, #6
      008598 81               [ 4]  666 	ret
                                    667 ;	main.c: 210: void status_check(void){
                                    668 ;	-----------------------------------------
                                    669 ;	 function status_check
                                    670 ;	-----------------------------------------
      008599                        671 _status_check:
      008599 52 09            [ 2]  672 	sub	sp, #9
                                    673 ;	main.c: 211: char rx_binary_chars[9]={0};
      00859B 0F 01            [ 1]  674 	clr	(0x01, sp)
      00859D 0F 02            [ 1]  675 	clr	(0x02, sp)
      00859F 0F 03            [ 1]  676 	clr	(0x03, sp)
      0085A1 0F 04            [ 1]  677 	clr	(0x04, sp)
      0085A3 0F 05            [ 1]  678 	clr	(0x05, sp)
      0085A5 0F 06            [ 1]  679 	clr	(0x06, sp)
      0085A7 0F 07            [ 1]  680 	clr	(0x07, sp)
      0085A9 0F 08            [ 1]  681 	clr	(0x08, sp)
      0085AB 0F 09            [ 1]  682 	clr	(0x09, sp)
                                    683 ;	main.c: 212: uart_write("\nI2C_REGS >.<\n");
      0085AD AE 80 40         [ 2]  684 	ldw	x, #(___str_2+0)
      0085B0 CD 83 47         [ 4]  685 	call	_uart_write
                                    686 ;	main.c: 213: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0085B3 96               [ 1]  687 	ldw	x, sp
      0085B4 5C               [ 1]  688 	incw	x
      0085B5 51               [ 1]  689 	exgw	x, y
      0085B6 C6 52 17         [ 1]  690 	ld	a, 0x5217
      0085B9 5F               [ 1]  691 	clrw	x
      0085BA 90 89            [ 2]  692 	pushw	y
      0085BC 97               [ 1]  693 	ld	xl, a
      0085BD CD 84 53         [ 4]  694 	call	_convert_int_to_binary
                                    695 ;	main.c: 214: uart_write("\nSR1 -> ");
      0085C0 AE 80 4F         [ 2]  696 	ldw	x, #(___str_3+0)
      0085C3 CD 83 47         [ 4]  697 	call	_uart_write
                                    698 ;	main.c: 215: uart_write(rx_binary_chars);
      0085C6 96               [ 1]  699 	ldw	x, sp
      0085C7 5C               [ 1]  700 	incw	x
      0085C8 CD 83 47         [ 4]  701 	call	_uart_write
                                    702 ;	main.c: 216: uart_write(" <-\n");
      0085CB AE 80 3B         [ 2]  703 	ldw	x, #(___str_1+0)
      0085CE CD 83 47         [ 4]  704 	call	_uart_write
                                    705 ;	main.c: 217: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0085D1 96               [ 1]  706 	ldw	x, sp
      0085D2 5C               [ 1]  707 	incw	x
      0085D3 51               [ 1]  708 	exgw	x, y
      0085D4 C6 52 18         [ 1]  709 	ld	a, 0x5218
      0085D7 5F               [ 1]  710 	clrw	x
      0085D8 90 89            [ 2]  711 	pushw	y
      0085DA 97               [ 1]  712 	ld	xl, a
      0085DB CD 84 53         [ 4]  713 	call	_convert_int_to_binary
                                    714 ;	main.c: 218: uart_write("SR2 -> ");
      0085DE AE 80 58         [ 2]  715 	ldw	x, #(___str_4+0)
      0085E1 CD 83 47         [ 4]  716 	call	_uart_write
                                    717 ;	main.c: 219: uart_write(rx_binary_chars);
      0085E4 96               [ 1]  718 	ldw	x, sp
      0085E5 5C               [ 1]  719 	incw	x
      0085E6 CD 83 47         [ 4]  720 	call	_uart_write
                                    721 ;	main.c: 220: uart_write(" <-\n");
      0085E9 AE 80 3B         [ 2]  722 	ldw	x, #(___str_1+0)
      0085EC CD 83 47         [ 4]  723 	call	_uart_write
                                    724 ;	main.c: 221: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0085EF 96               [ 1]  725 	ldw	x, sp
      0085F0 5C               [ 1]  726 	incw	x
      0085F1 51               [ 1]  727 	exgw	x, y
      0085F2 C6 52 19         [ 1]  728 	ld	a, 0x5219
      0085F5 5F               [ 1]  729 	clrw	x
      0085F6 90 89            [ 2]  730 	pushw	y
      0085F8 97               [ 1]  731 	ld	xl, a
      0085F9 CD 84 53         [ 4]  732 	call	_convert_int_to_binary
                                    733 ;	main.c: 222: uart_write("SR3 -> ");
      0085FC AE 80 60         [ 2]  734 	ldw	x, #(___str_5+0)
      0085FF CD 83 47         [ 4]  735 	call	_uart_write
                                    736 ;	main.c: 223: uart_write(rx_binary_chars);
      008602 96               [ 1]  737 	ldw	x, sp
      008603 5C               [ 1]  738 	incw	x
      008604 CD 83 47         [ 4]  739 	call	_uart_write
                                    740 ;	main.c: 224: uart_write(" <-\n");
      008607 AE 80 3B         [ 2]  741 	ldw	x, #(___str_1+0)
      00860A CD 83 47         [ 4]  742 	call	_uart_write
                                    743 ;	main.c: 225: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      00860D 96               [ 1]  744 	ldw	x, sp
      00860E 5C               [ 1]  745 	incw	x
      00860F 51               [ 1]  746 	exgw	x, y
      008610 C6 52 10         [ 1]  747 	ld	a, 0x5210
      008613 5F               [ 1]  748 	clrw	x
      008614 90 89            [ 2]  749 	pushw	y
      008616 97               [ 1]  750 	ld	xl, a
      008617 CD 84 53         [ 4]  751 	call	_convert_int_to_binary
                                    752 ;	main.c: 226: uart_write("CR1 -> ");
      00861A AE 80 68         [ 2]  753 	ldw	x, #(___str_6+0)
      00861D CD 83 47         [ 4]  754 	call	_uart_write
                                    755 ;	main.c: 227: uart_write(rx_binary_chars);
      008620 96               [ 1]  756 	ldw	x, sp
      008621 5C               [ 1]  757 	incw	x
      008622 CD 83 47         [ 4]  758 	call	_uart_write
                                    759 ;	main.c: 228: uart_write(" <-\n");
      008625 AE 80 3B         [ 2]  760 	ldw	x, #(___str_1+0)
      008628 CD 83 47         [ 4]  761 	call	_uart_write
                                    762 ;	main.c: 229: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      00862B 96               [ 1]  763 	ldw	x, sp
      00862C 5C               [ 1]  764 	incw	x
      00862D 51               [ 1]  765 	exgw	x, y
      00862E C6 52 11         [ 1]  766 	ld	a, 0x5211
      008631 5F               [ 1]  767 	clrw	x
      008632 90 89            [ 2]  768 	pushw	y
      008634 97               [ 1]  769 	ld	xl, a
      008635 CD 84 53         [ 4]  770 	call	_convert_int_to_binary
                                    771 ;	main.c: 230: uart_write("CR2 -> ");
      008638 AE 80 70         [ 2]  772 	ldw	x, #(___str_7+0)
      00863B CD 83 47         [ 4]  773 	call	_uart_write
                                    774 ;	main.c: 231: uart_write(rx_binary_chars);
      00863E 96               [ 1]  775 	ldw	x, sp
      00863F 5C               [ 1]  776 	incw	x
      008640 CD 83 47         [ 4]  777 	call	_uart_write
                                    778 ;	main.c: 232: uart_write(" <-\n");
      008643 AE 80 3B         [ 2]  779 	ldw	x, #(___str_1+0)
      008646 CD 83 47         [ 4]  780 	call	_uart_write
                                    781 ;	main.c: 233: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008649 96               [ 1]  782 	ldw	x, sp
      00864A 5C               [ 1]  783 	incw	x
      00864B 51               [ 1]  784 	exgw	x, y
      00864C C6 52 16         [ 1]  785 	ld	a, 0x5216
      00864F 5F               [ 1]  786 	clrw	x
      008650 90 89            [ 2]  787 	pushw	y
      008652 97               [ 1]  788 	ld	xl, a
      008653 CD 84 53         [ 4]  789 	call	_convert_int_to_binary
                                    790 ;	main.c: 234: uart_write("DR -> ");
      008656 AE 80 78         [ 2]  791 	ldw	x, #(___str_8+0)
      008659 CD 83 47         [ 4]  792 	call	_uart_write
                                    793 ;	main.c: 235: uart_write(rx_binary_chars);
      00865C 96               [ 1]  794 	ldw	x, sp
      00865D 5C               [ 1]  795 	incw	x
      00865E CD 83 47         [ 4]  796 	call	_uart_write
                                    797 ;	main.c: 236: uart_write(" <-\n");
      008661 AE 80 3B         [ 2]  798 	ldw	x, #(___str_1+0)
      008664 CD 83 47         [ 4]  799 	call	_uart_write
                                    800 ;	main.c: 237: uart_write("UART_REGS >.<\n");
      008667 AE 80 7F         [ 2]  801 	ldw	x, #(___str_9+0)
      00866A CD 83 47         [ 4]  802 	call	_uart_write
                                    803 ;	main.c: 238: convert_int_to_binary(UART1_SR, rx_binary_chars);
      00866D 96               [ 1]  804 	ldw	x, sp
      00866E 5C               [ 1]  805 	incw	x
      00866F 51               [ 1]  806 	exgw	x, y
      008670 C6 52 30         [ 1]  807 	ld	a, 0x5230
      008673 5F               [ 1]  808 	clrw	x
      008674 90 89            [ 2]  809 	pushw	y
      008676 97               [ 1]  810 	ld	xl, a
      008677 CD 84 53         [ 4]  811 	call	_convert_int_to_binary
                                    812 ;	main.c: 239: uart_write("\nSR -> ");
      00867A AE 80 8E         [ 2]  813 	ldw	x, #(___str_10+0)
      00867D CD 83 47         [ 4]  814 	call	_uart_write
                                    815 ;	main.c: 240: uart_write(rx_binary_chars);
      008680 96               [ 1]  816 	ldw	x, sp
      008681 5C               [ 1]  817 	incw	x
      008682 CD 83 47         [ 4]  818 	call	_uart_write
                                    819 ;	main.c: 241: uart_write(" <-\n");
      008685 AE 80 3B         [ 2]  820 	ldw	x, #(___str_1+0)
      008688 CD 83 47         [ 4]  821 	call	_uart_write
                                    822 ;	main.c: 242: convert_int_to_binary(UART1_DR, rx_binary_chars);
      00868B 96               [ 1]  823 	ldw	x, sp
      00868C 5C               [ 1]  824 	incw	x
      00868D 51               [ 1]  825 	exgw	x, y
      00868E C6 52 31         [ 1]  826 	ld	a, 0x5231
      008691 5F               [ 1]  827 	clrw	x
      008692 90 89            [ 2]  828 	pushw	y
      008694 97               [ 1]  829 	ld	xl, a
      008695 CD 84 53         [ 4]  830 	call	_convert_int_to_binary
                                    831 ;	main.c: 243: uart_write("DR -> ");
      008698 AE 80 78         [ 2]  832 	ldw	x, #(___str_8+0)
      00869B CD 83 47         [ 4]  833 	call	_uart_write
                                    834 ;	main.c: 244: uart_write(rx_binary_chars);
      00869E 96               [ 1]  835 	ldw	x, sp
      00869F 5C               [ 1]  836 	incw	x
      0086A0 CD 83 47         [ 4]  837 	call	_uart_write
                                    838 ;	main.c: 245: uart_write(" <-\n");
      0086A3 AE 80 3B         [ 2]  839 	ldw	x, #(___str_1+0)
      0086A6 CD 83 47         [ 4]  840 	call	_uart_write
                                    841 ;	main.c: 246: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
      0086A9 96               [ 1]  842 	ldw	x, sp
      0086AA 5C               [ 1]  843 	incw	x
      0086AB 51               [ 1]  844 	exgw	x, y
      0086AC C6 52 32         [ 1]  845 	ld	a, 0x5232
      0086AF 5F               [ 1]  846 	clrw	x
      0086B0 90 89            [ 2]  847 	pushw	y
      0086B2 97               [ 1]  848 	ld	xl, a
      0086B3 CD 84 53         [ 4]  849 	call	_convert_int_to_binary
                                    850 ;	main.c: 247: uart_write("BRR1 -> ");
      0086B6 AE 80 96         [ 2]  851 	ldw	x, #(___str_11+0)
      0086B9 CD 83 47         [ 4]  852 	call	_uart_write
                                    853 ;	main.c: 248: uart_write(rx_binary_chars);
      0086BC 96               [ 1]  854 	ldw	x, sp
      0086BD 5C               [ 1]  855 	incw	x
      0086BE CD 83 47         [ 4]  856 	call	_uart_write
                                    857 ;	main.c: 249: uart_write(" <-\n");
      0086C1 AE 80 3B         [ 2]  858 	ldw	x, #(___str_1+0)
      0086C4 CD 83 47         [ 4]  859 	call	_uart_write
                                    860 ;	main.c: 250: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
      0086C7 96               [ 1]  861 	ldw	x, sp
      0086C8 5C               [ 1]  862 	incw	x
      0086C9 51               [ 1]  863 	exgw	x, y
      0086CA C6 52 33         [ 1]  864 	ld	a, 0x5233
      0086CD 5F               [ 1]  865 	clrw	x
      0086CE 90 89            [ 2]  866 	pushw	y
      0086D0 97               [ 1]  867 	ld	xl, a
      0086D1 CD 84 53         [ 4]  868 	call	_convert_int_to_binary
                                    869 ;	main.c: 251: uart_write("BRR2 -> ");
      0086D4 AE 80 9F         [ 2]  870 	ldw	x, #(___str_12+0)
      0086D7 CD 83 47         [ 4]  871 	call	_uart_write
                                    872 ;	main.c: 252: uart_write(rx_binary_chars);
      0086DA 96               [ 1]  873 	ldw	x, sp
      0086DB 5C               [ 1]  874 	incw	x
      0086DC CD 83 47         [ 4]  875 	call	_uart_write
                                    876 ;	main.c: 253: uart_write(" <-\n");
      0086DF AE 80 3B         [ 2]  877 	ldw	x, #(___str_1+0)
      0086E2 CD 83 47         [ 4]  878 	call	_uart_write
                                    879 ;	main.c: 254: convert_int_to_binary(UART1_CR1, rx_binary_chars);
      0086E5 96               [ 1]  880 	ldw	x, sp
      0086E6 5C               [ 1]  881 	incw	x
      0086E7 51               [ 1]  882 	exgw	x, y
      0086E8 C6 52 34         [ 1]  883 	ld	a, 0x5234
      0086EB 5F               [ 1]  884 	clrw	x
      0086EC 90 89            [ 2]  885 	pushw	y
      0086EE 97               [ 1]  886 	ld	xl, a
      0086EF CD 84 53         [ 4]  887 	call	_convert_int_to_binary
                                    888 ;	main.c: 255: uart_write("CR1 -> ");
      0086F2 AE 80 68         [ 2]  889 	ldw	x, #(___str_6+0)
      0086F5 CD 83 47         [ 4]  890 	call	_uart_write
                                    891 ;	main.c: 256: uart_write(rx_binary_chars);
      0086F8 96               [ 1]  892 	ldw	x, sp
      0086F9 5C               [ 1]  893 	incw	x
      0086FA CD 83 47         [ 4]  894 	call	_uart_write
                                    895 ;	main.c: 257: uart_write(" <-\n");
      0086FD AE 80 3B         [ 2]  896 	ldw	x, #(___str_1+0)
      008700 CD 83 47         [ 4]  897 	call	_uart_write
                                    898 ;	main.c: 258: convert_int_to_binary(UART1_CR2, rx_binary_chars);
      008703 96               [ 1]  899 	ldw	x, sp
      008704 5C               [ 1]  900 	incw	x
      008705 51               [ 1]  901 	exgw	x, y
      008706 C6 52 35         [ 1]  902 	ld	a, 0x5235
      008709 5F               [ 1]  903 	clrw	x
      00870A 90 89            [ 2]  904 	pushw	y
      00870C 97               [ 1]  905 	ld	xl, a
      00870D CD 84 53         [ 4]  906 	call	_convert_int_to_binary
                                    907 ;	main.c: 259: uart_write("CR2 -> ");
      008710 AE 80 70         [ 2]  908 	ldw	x, #(___str_7+0)
      008713 CD 83 47         [ 4]  909 	call	_uart_write
                                    910 ;	main.c: 260: uart_write(rx_binary_chars);
      008716 96               [ 1]  911 	ldw	x, sp
      008717 5C               [ 1]  912 	incw	x
      008718 CD 83 47         [ 4]  913 	call	_uart_write
                                    914 ;	main.c: 261: uart_write(" <-\n");
      00871B AE 80 3B         [ 2]  915 	ldw	x, #(___str_1+0)
      00871E CD 83 47         [ 4]  916 	call	_uart_write
                                    917 ;	main.c: 262: convert_int_to_binary(UART1_CR3, rx_binary_chars);
      008721 96               [ 1]  918 	ldw	x, sp
      008722 5C               [ 1]  919 	incw	x
      008723 51               [ 1]  920 	exgw	x, y
      008724 C6 52 36         [ 1]  921 	ld	a, 0x5236
      008727 5F               [ 1]  922 	clrw	x
      008728 90 89            [ 2]  923 	pushw	y
      00872A 97               [ 1]  924 	ld	xl, a
      00872B CD 84 53         [ 4]  925 	call	_convert_int_to_binary
                                    926 ;	main.c: 263: uart_write("CR3 -> ");
      00872E AE 80 A8         [ 2]  927 	ldw	x, #(___str_13+0)
      008731 CD 83 47         [ 4]  928 	call	_uart_write
                                    929 ;	main.c: 264: uart_write(rx_binary_chars);
      008734 96               [ 1]  930 	ldw	x, sp
      008735 5C               [ 1]  931 	incw	x
      008736 CD 83 47         [ 4]  932 	call	_uart_write
                                    933 ;	main.c: 265: uart_write(" <-\n");
      008739 AE 80 3B         [ 2]  934 	ldw	x, #(___str_1+0)
      00873C CD 83 47         [ 4]  935 	call	_uart_write
                                    936 ;	main.c: 266: convert_int_to_binary(UART1_CR4, rx_binary_chars);
      00873F 96               [ 1]  937 	ldw	x, sp
      008740 5C               [ 1]  938 	incw	x
      008741 51               [ 1]  939 	exgw	x, y
      008742 C6 52 37         [ 1]  940 	ld	a, 0x5237
      008745 5F               [ 1]  941 	clrw	x
      008746 90 89            [ 2]  942 	pushw	y
      008748 97               [ 1]  943 	ld	xl, a
      008749 CD 84 53         [ 4]  944 	call	_convert_int_to_binary
                                    945 ;	main.c: 267: uart_write("CR4 -> ");
      00874C AE 80 B0         [ 2]  946 	ldw	x, #(___str_14+0)
      00874F CD 83 47         [ 4]  947 	call	_uart_write
                                    948 ;	main.c: 268: uart_write(rx_binary_chars);
      008752 96               [ 1]  949 	ldw	x, sp
      008753 5C               [ 1]  950 	incw	x
      008754 CD 83 47         [ 4]  951 	call	_uart_write
                                    952 ;	main.c: 269: uart_write(" <-\n");
      008757 AE 80 3B         [ 2]  953 	ldw	x, #(___str_1+0)
      00875A CD 83 47         [ 4]  954 	call	_uart_write
                                    955 ;	main.c: 270: convert_int_to_binary(UART1_CR5, rx_binary_chars);
      00875D 96               [ 1]  956 	ldw	x, sp
      00875E 5C               [ 1]  957 	incw	x
      00875F 51               [ 1]  958 	exgw	x, y
      008760 C6 52 38         [ 1]  959 	ld	a, 0x5238
      008763 5F               [ 1]  960 	clrw	x
      008764 90 89            [ 2]  961 	pushw	y
      008766 97               [ 1]  962 	ld	xl, a
      008767 CD 84 53         [ 4]  963 	call	_convert_int_to_binary
                                    964 ;	main.c: 271: uart_write("CR5 -> ");
      00876A AE 80 B8         [ 2]  965 	ldw	x, #(___str_15+0)
      00876D CD 83 47         [ 4]  966 	call	_uart_write
                                    967 ;	main.c: 272: uart_write(rx_binary_chars);
      008770 96               [ 1]  968 	ldw	x, sp
      008771 5C               [ 1]  969 	incw	x
      008772 CD 83 47         [ 4]  970 	call	_uart_write
                                    971 ;	main.c: 273: uart_write(" <-\n");
      008775 AE 80 3B         [ 2]  972 	ldw	x, #(___str_1+0)
      008778 CD 83 47         [ 4]  973 	call	_uart_write
                                    974 ;	main.c: 274: convert_int_to_binary(UART1_GTR, rx_binary_chars);
      00877B 96               [ 1]  975 	ldw	x, sp
      00877C 5C               [ 1]  976 	incw	x
      00877D 51               [ 1]  977 	exgw	x, y
      00877E C6 52 39         [ 1]  978 	ld	a, 0x5239
      008781 5F               [ 1]  979 	clrw	x
      008782 90 89            [ 2]  980 	pushw	y
      008784 97               [ 1]  981 	ld	xl, a
      008785 CD 84 53         [ 4]  982 	call	_convert_int_to_binary
                                    983 ;	main.c: 275: uart_write("GTR -> ");
      008788 AE 80 C0         [ 2]  984 	ldw	x, #(___str_16+0)
      00878B CD 83 47         [ 4]  985 	call	_uart_write
                                    986 ;	main.c: 276: uart_write(rx_binary_chars);
      00878E 96               [ 1]  987 	ldw	x, sp
      00878F 5C               [ 1]  988 	incw	x
      008790 CD 83 47         [ 4]  989 	call	_uart_write
                                    990 ;	main.c: 277: uart_write(" <-\n");
      008793 AE 80 3B         [ 2]  991 	ldw	x, #(___str_1+0)
      008796 CD 83 47         [ 4]  992 	call	_uart_write
                                    993 ;	main.c: 278: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
      008799 96               [ 1]  994 	ldw	x, sp
      00879A 5C               [ 1]  995 	incw	x
      00879B 51               [ 1]  996 	exgw	x, y
      00879C C6 52 3A         [ 1]  997 	ld	a, 0x523a
      00879F 5F               [ 1]  998 	clrw	x
      0087A0 90 89            [ 2]  999 	pushw	y
      0087A2 97               [ 1] 1000 	ld	xl, a
      0087A3 CD 84 53         [ 4] 1001 	call	_convert_int_to_binary
                                   1002 ;	main.c: 279: uart_write("PSCR -> ");
      0087A6 AE 80 C8         [ 2] 1003 	ldw	x, #(___str_17+0)
      0087A9 CD 83 47         [ 4] 1004 	call	_uart_write
                                   1005 ;	main.c: 280: uart_write(rx_binary_chars);
      0087AC 96               [ 1] 1006 	ldw	x, sp
      0087AD 5C               [ 1] 1007 	incw	x
      0087AE CD 83 47         [ 4] 1008 	call	_uart_write
                                   1009 ;	main.c: 281: uart_write(" <-\n");
      0087B1 AE 80 3B         [ 2] 1010 	ldw	x, #(___str_1+0)
      0087B4 CD 83 47         [ 4] 1011 	call	_uart_write
                                   1012 ;	main.c: 282: }
      0087B7 5B 09            [ 2] 1013 	addw	sp, #9
      0087B9 81               [ 4] 1014 	ret
                                   1015 ;	main.c: 284: void uart_init(void){
                                   1016 ;	-----------------------------------------
                                   1017 ;	 function uart_init
                                   1018 ;	-----------------------------------------
      0087BA                       1019 _uart_init:
                                   1020 ;	main.c: 285: CLK_CKDIVR = 0;
      0087BA 35 00 50 C6      [ 1] 1021 	mov	0x50c6+0, #0x00
                                   1022 ;	main.c: 288: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0087BE 72 16 52 35      [ 1] 1023 	bset	0x5235, #3
                                   1024 ;	main.c: 289: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      0087C2 72 14 52 35      [ 1] 1025 	bset	0x5235, #2
                                   1026 ;	main.c: 290: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0087C6 C6 52 36         [ 1] 1027 	ld	a, 0x5236
      0087C9 A4 CF            [ 1] 1028 	and	a, #0xcf
      0087CB C7 52 36         [ 1] 1029 	ld	0x5236, a
                                   1030 ;	main.c: 292: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0087CE 35 03 52 33      [ 1] 1031 	mov	0x5233+0, #0x03
      0087D2 35 68 52 32      [ 1] 1032 	mov	0x5232+0, #0x68
                                   1033 ;	main.c: 293: }
      0087D6 81               [ 4] 1034 	ret
                                   1035 ;	main.c: 297: void i2c_init(void) {
                                   1036 ;	-----------------------------------------
                                   1037 ;	 function i2c_init
                                   1038 ;	-----------------------------------------
      0087D7                       1039 _i2c_init:
                                   1040 ;	main.c: 303: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      0087D7 72 11 52 10      [ 1] 1041 	bres	0x5210, #0
                                   1042 ;	main.c: 304: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      0087DB 35 10 52 12      [ 1] 1043 	mov	0x5212+0, #0x10
                                   1044 ;	main.c: 305: I2C_CCRH = 0;                   // =0
      0087DF 35 00 52 1C      [ 1] 1045 	mov	0x521c+0, #0x00
                                   1046 ;	main.c: 306: I2C_CCRL = 80;                  // 100kHz for I2C
      0087E3 35 50 52 1B      [ 1] 1047 	mov	0x521b+0, #0x50
                                   1048 ;	main.c: 307: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0087E7 72 1F 52 1C      [ 1] 1049 	bres	0x521c, #7
                                   1050 ;	main.c: 308: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0087EB 72 1F 52 14      [ 1] 1051 	bres	0x5214, #7
                                   1052 ;	main.c: 309: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0087EF 72 1C 52 14      [ 1] 1053 	bset	0x5214, #6
                                   1054 ;	main.c: 310: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0087F3 72 10 52 10      [ 1] 1055 	bset	0x5210, #0
                                   1056 ;	main.c: 311: }
      0087F7 81               [ 4] 1057 	ret
                                   1058 ;	main.c: 320: void i2c_start(void) {
                                   1059 ;	-----------------------------------------
                                   1060 ;	 function i2c_start
                                   1061 ;	-----------------------------------------
      0087F8                       1062 _i2c_start:
                                   1063 ;	main.c: 321: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0087F8 72 10 52 11      [ 1] 1064 	bset	0x5211, #0
                                   1065 ;	main.c: 322: while(!(I2C_SR1 & (1 << 0)));
      0087FC                       1066 00101$:
      0087FC 72 01 52 17 FB   [ 2] 1067 	btjf	0x5217, #0, 00101$
                                   1068 ;	main.c: 324: }
      008801 81               [ 4] 1069 	ret
                                   1070 ;	main.c: 326: void i2c_send_address(uint8_t address) {
                                   1071 ;	-----------------------------------------
                                   1072 ;	 function i2c_send_address
                                   1073 ;	-----------------------------------------
      008802                       1074 _i2c_send_address:
                                   1075 ;	main.c: 327: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      008802 48               [ 1] 1076 	sll	a
      008803 C7 52 16         [ 1] 1077 	ld	0x5216, a
                                   1078 ;	main.c: 328: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008806                       1079 00102$:
      008806 72 03 52 17 01   [ 2] 1080 	btjf	0x5217, #1, 00117$
      00880B 81               [ 4] 1081 	ret
      00880C                       1082 00117$:
      00880C 72 05 52 18 F5   [ 2] 1083 	btjf	0x5218, #2, 00102$
                                   1084 ;	main.c: 329: }
      008811 81               [ 4] 1085 	ret
                                   1086 ;	main.c: 331: void i2c_stop(void) {
                                   1087 ;	-----------------------------------------
                                   1088 ;	 function i2c_stop
                                   1089 ;	-----------------------------------------
      008812                       1090 _i2c_stop:
                                   1091 ;	main.c: 332: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      008812 72 12 52 11      [ 1] 1092 	bset	0x5211, #1
                                   1093 ;	main.c: 334: }
      008816 81               [ 4] 1094 	ret
                                   1095 ;	main.c: 335: void i2c_write(void){
                                   1096 ;	-----------------------------------------
                                   1097 ;	 function i2c_write
                                   1098 ;	-----------------------------------------
      008817                       1099 _i2c_write:
      008817 52 02            [ 2] 1100 	sub	sp, #2
                                   1101 ;	main.c: 336: I2C_DR = d_addr; // Отправка адреса регистра
      008819 55 01 04 52 16   [ 1] 1102 	mov	0x5216+0, _d_addr+0
                                   1103 ;	main.c: 337: for(int i = 0;i < d_size;i++)
      00881E 5F               [ 1] 1104 	clrw	x
      00881F                       1105 00107$:
      00881F C6 01 06         [ 1] 1106 	ld	a, _d_size+0
      008822 6B 02            [ 1] 1107 	ld	(0x02, sp), a
      008824 0F 01            [ 1] 1108 	clr	(0x01, sp)
      008826 13 01            [ 2] 1109 	cpw	x, (0x01, sp)
      008828 2E 16            [ 1] 1110 	jrsge	00109$
                                   1111 ;	main.c: 339: I2C_DR = data_buf[i];
      00882A 90 93            [ 1] 1112 	ldw	y, x
      00882C 90 D6 01 08      [ 1] 1113 	ld	a, (_data_buf+0, y)
      008830 C7 52 16         [ 1] 1114 	ld	0x5216, a
                                   1115 ;	main.c: 340: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008833                       1116 00102$:
      008833 72 02 52 17 05   [ 2] 1117 	btjt	0x5217, #1, 00108$
      008838 72 05 52 18 F6   [ 2] 1118 	btjf	0x5218, #2, 00102$
      00883D                       1119 00108$:
                                   1120 ;	main.c: 337: for(int i = 0;i < d_size;i++)
      00883D 5C               [ 1] 1121 	incw	x
      00883E 20 DF            [ 2] 1122 	jra	00107$
      008840                       1123 00109$:
                                   1124 ;	main.c: 342: }
      008840 5B 02            [ 2] 1125 	addw	sp, #2
      008842 81               [ 4] 1126 	ret
                                   1127 ;	main.c: 344: void i2c_read(void){
                                   1128 ;	-----------------------------------------
                                   1129 ;	 function i2c_read
                                   1130 ;	-----------------------------------------
      008843                       1131 _i2c_read:
      008843 52 02            [ 2] 1132 	sub	sp, #2
                                   1133 ;	main.c: 345: I2C_DR = (current_dev << 1) & (1 << 0);
      008845 C6 02 08         [ 1] 1134 	ld	a, _current_dev+0
      008848 48               [ 1] 1135 	sll	a
      008849 A4 01            [ 1] 1136 	and	a, #0x01
      00884B C7 52 16         [ 1] 1137 	ld	0x5216, a
                                   1138 ;	main.c: 346: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00884E                       1139 00102$:
      00884E 72 02 52 17 05   [ 2] 1140 	btjt	0x5217, #1, 00104$
      008853 72 05 52 18 F6   [ 2] 1141 	btjf	0x5218, #2, 00102$
      008858                       1142 00104$:
                                   1143 ;	main.c: 348: I2C_DR = d_addr;
      008858 55 01 04 52 16   [ 1] 1144 	mov	0x5216+0, _d_addr+0
                                   1145 ;	main.c: 349: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00885D                       1146 00106$:
      00885D 72 02 52 17 05   [ 2] 1147 	btjt	0x5217, #1, 00108$
      008862 72 05 52 18 F6   [ 2] 1148 	btjf	0x5218, #2, 00106$
      008867                       1149 00108$:
                                   1150 ;	main.c: 350: i2c_stop();
      008867 CD 88 12         [ 4] 1151 	call	_i2c_stop
                                   1152 ;	main.c: 351: for(int i = 0;i < d_size;i++)
      00886A 5F               [ 1] 1153 	clrw	x
      00886B                       1154 00115$:
      00886B C6 01 06         [ 1] 1155 	ld	a, _d_size+0
      00886E 6B 02            [ 1] 1156 	ld	(0x02, sp), a
      008870 0F 01            [ 1] 1157 	clr	(0x01, sp)
      008872 13 01            [ 2] 1158 	cpw	x, (0x01, sp)
      008874 2E 13            [ 1] 1159 	jrsge	00117$
                                   1160 ;	main.c: 353: data_buf[i] = I2C_DR;
      008876 C6 52 16         [ 1] 1161 	ld	a, 0x5216
      008879 D7 01 08         [ 1] 1162 	ld	((_data_buf+0), x), a
                                   1163 ;	main.c: 354: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00887C                       1164 00110$:
      00887C 72 02 52 17 05   [ 2] 1165 	btjt	0x5217, #1, 00116$
      008881 72 05 52 18 F6   [ 2] 1166 	btjf	0x5218, #2, 00110$
      008886                       1167 00116$:
                                   1168 ;	main.c: 351: for(int i = 0;i < d_size;i++)
      008886 5C               [ 1] 1169 	incw	x
      008887 20 E2            [ 2] 1170 	jra	00115$
      008889                       1171 00117$:
                                   1172 ;	main.c: 357: }
      008889 5B 02            [ 2] 1173 	addw	sp, #2
      00888B 81               [ 4] 1174 	ret
                                   1175 ;	main.c: 358: void i2c_scan(void) {
                                   1176 ;	-----------------------------------------
                                   1177 ;	 function i2c_scan
                                   1178 ;	-----------------------------------------
      00888C                       1179 _i2c_scan:
      00888C 52 02            [ 2] 1180 	sub	sp, #2
                                   1181 ;	main.c: 359: for (uint8_t addr = current_dev; addr < 127; addr++) {
      00888E C6 02 08         [ 1] 1182 	ld	a, _current_dev+0
      008891 6B 01            [ 1] 1183 	ld	(0x01, sp), a
      008893 6B 02            [ 1] 1184 	ld	(0x02, sp), a
      008895                       1185 00105$:
      008895 7B 02            [ 1] 1186 	ld	a, (0x02, sp)
      008897 A1 7F            [ 1] 1187 	cp	a, #0x7f
      008899 24 26            [ 1] 1188 	jrnc	00107$
                                   1189 ;	main.c: 360: i2c_start();
      00889B CD 87 F8         [ 4] 1190 	call	_i2c_start
                                   1191 ;	main.c: 361: i2c_send_address(addr);
      00889E 7B 02            [ 1] 1192 	ld	a, (0x02, sp)
      0088A0 CD 88 02         [ 4] 1193 	call	_i2c_send_address
                                   1194 ;	main.c: 362: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0088A3 72 04 52 18 0A   [ 2] 1195 	btjt	0x5218, #2, 00102$
                                   1196 ;	main.c: 364: current_dev = addr;
      0088A8 7B 01            [ 1] 1197 	ld	a, (0x01, sp)
      0088AA C7 02 08         [ 1] 1198 	ld	_current_dev+0, a
                                   1199 ;	main.c: 365: i2c_stop();
      0088AD 5B 02            [ 2] 1200 	addw	sp, #2
                                   1201 ;	main.c: 366: break;
      0088AF CC 88 12         [ 2] 1202 	jp	_i2c_stop
      0088B2                       1203 00102$:
                                   1204 ;	main.c: 368: i2c_stop();
      0088B2 CD 88 12         [ 4] 1205 	call	_i2c_stop
                                   1206 ;	main.c: 369: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      0088B5 72 15 52 18      [ 1] 1207 	bres	0x5218, #2
                                   1208 ;	main.c: 359: for (uint8_t addr = current_dev; addr < 127; addr++) {
      0088B9 0C 02            [ 1] 1209 	inc	(0x02, sp)
      0088BB 7B 02            [ 1] 1210 	ld	a, (0x02, sp)
      0088BD 6B 01            [ 1] 1211 	ld	(0x01, sp), a
      0088BF 20 D4            [ 2] 1212 	jra	00105$
      0088C1                       1213 00107$:
                                   1214 ;	main.c: 371: }
      0088C1 5B 02            [ 2] 1215 	addw	sp, #2
      0088C3 81               [ 4] 1216 	ret
                                   1217 ;	main.c: 381: void cm_SM(void)
                                   1218 ;	-----------------------------------------
                                   1219 ;	 function cm_SM
                                   1220 ;	-----------------------------------------
      0088C4                       1221 _cm_SM:
      0088C4 52 04            [ 2] 1222 	sub	sp, #4
                                   1223 ;	main.c: 383: char cur_dev[4]={0};
      0088C6 0F 01            [ 1] 1224 	clr	(0x01, sp)
      0088C8 0F 02            [ 1] 1225 	clr	(0x02, sp)
      0088CA 0F 03            [ 1] 1226 	clr	(0x03, sp)
      0088CC 0F 04            [ 1] 1227 	clr	(0x04, sp)
                                   1228 ;	main.c: 384: convert_int_to_chars(current_dev, cur_dev);
      0088CE 96               [ 1] 1229 	ldw	x, sp
      0088CF 5C               [ 1] 1230 	incw	x
      0088D0 C6 02 08         [ 1] 1231 	ld	a, _current_dev+0
      0088D3 CD 83 A8         [ 4] 1232 	call	_convert_int_to_chars
                                   1233 ;	main.c: 385: uart_write("SM ");
      0088D6 AE 80 D1         [ 2] 1234 	ldw	x, #(___str_18+0)
      0088D9 CD 83 47         [ 4] 1235 	call	_uart_write
                                   1236 ;	main.c: 386: uart_write(cur_dev);
      0088DC 96               [ 1] 1237 	ldw	x, sp
      0088DD 5C               [ 1] 1238 	incw	x
      0088DE CD 83 47         [ 4] 1239 	call	_uart_write
                                   1240 ;	main.c: 387: uart_write("\r\n");
      0088E1 AE 80 D5         [ 2] 1241 	ldw	x, #(___str_19+0)
      0088E4 CD 83 47         [ 4] 1242 	call	_uart_write
                                   1243 ;	main.c: 388: }
      0088E7 5B 04            [ 2] 1244 	addw	sp, #4
      0088E9 81               [ 4] 1245 	ret
                                   1246 ;	main.c: 389: void cm_SN(void)
                                   1247 ;	-----------------------------------------
                                   1248 ;	 function cm_SN
                                   1249 ;	-----------------------------------------
      0088EA                       1250 _cm_SN:
                                   1251 ;	main.c: 391: i2c_scan();
      0088EA CD 88 8C         [ 4] 1252 	call	_i2c_scan
                                   1253 ;	main.c: 392: cm_SM();
                                   1254 ;	main.c: 393: }
      0088ED CC 88 C4         [ 2] 1255 	jp	_cm_SM
                                   1256 ;	main.c: 394: void cm_RM(void)
                                   1257 ;	-----------------------------------------
                                   1258 ;	 function cm_RM
                                   1259 ;	-----------------------------------------
      0088F0                       1260 _cm_RM:
                                   1261 ;	main.c: 396: current_dev = 0;
      0088F0 72 5F 02 08      [ 1] 1262 	clr	_current_dev+0
                                   1263 ;	main.c: 397: uart_write("RM\n");
      0088F4 AE 80 D8         [ 2] 1264 	ldw	x, #(___str_20+0)
                                   1265 ;	main.c: 398: }
      0088F7 CC 83 47         [ 2] 1266 	jp	_uart_write
                                   1267 ;	main.c: 400: void cm_DB(void)
                                   1268 ;	-----------------------------------------
                                   1269 ;	 function cm_DB
                                   1270 ;	-----------------------------------------
      0088FA                       1271 _cm_DB:
                                   1272 ;	main.c: 402: status_check();
                                   1273 ;	main.c: 403: }
      0088FA CC 85 99         [ 2] 1274 	jp	_status_check
                                   1275 ;	main.c: 405: void cm_ST(void)
                                   1276 ;	-----------------------------------------
                                   1277 ;	 function cm_ST
                                   1278 ;	-----------------------------------------
      0088FD                       1279 _cm_ST:
                                   1280 ;	main.c: 407: get_addr_from_buff();
      0088FD CD 84 8B         [ 4] 1281 	call	_get_addr_from_buff
                                   1282 ;	main.c: 408: current_dev = d_addr;
      008900 55 01 04 02 08   [ 1] 1283 	mov	_current_dev+0, _d_addr+0
                                   1284 ;	main.c: 409: uart_write("ST\n");
      008905 AE 80 DC         [ 2] 1285 	ldw	x, #(___str_21+0)
                                   1286 ;	main.c: 410: }
      008908 CC 83 47         [ 2] 1287 	jp	_uart_write
                                   1288 ;	main.c: 411: void cm_SR(void)
                                   1289 ;	-----------------------------------------
                                   1290 ;	 function cm_SR
                                   1291 ;	-----------------------------------------
      00890B                       1292 _cm_SR:
                                   1293 ;	main.c: 413: i2c_start();
      00890B CD 87 F8         [ 4] 1294 	call	_i2c_start
                                   1295 ;	main.c: 414: i2c_send_address(current_dev);
      00890E C6 02 08         [ 1] 1296 	ld	a, _current_dev+0
      008911 CD 88 02         [ 4] 1297 	call	_i2c_send_address
                                   1298 ;	main.c: 415: i2c_read();
      008914 CD 88 43         [ 4] 1299 	call	_i2c_read
                                   1300 ;	main.c: 416: i2c_stop();
                                   1301 ;	main.c: 417: }
      008917 CC 88 12         [ 2] 1302 	jp	_i2c_stop
                                   1303 ;	main.c: 418: void cm_SW(void)
                                   1304 ;	-----------------------------------------
                                   1305 ;	 function cm_SW
                                   1306 ;	-----------------------------------------
      00891A                       1307 _cm_SW:
      00891A 52 04            [ 2] 1308 	sub	sp, #4
                                   1309 ;	main.c: 420: char ar[4]={0};
      00891C 0F 01            [ 1] 1310 	clr	(0x01, sp)
      00891E 0F 02            [ 1] 1311 	clr	(0x02, sp)
      008920 0F 03            [ 1] 1312 	clr	(0x03, sp)
      008922 0F 04            [ 1] 1313 	clr	(0x04, sp)
                                   1314 ;	main.c: 421: i2c_start();
      008924 CD 87 F8         [ 4] 1315 	call	_i2c_start
                                   1316 ;	main.c: 422: i2c_send_address(current_dev);
      008927 C6 02 08         [ 1] 1317 	ld	a, _current_dev+0
      00892A CD 88 02         [ 4] 1318 	call	_i2c_send_address
                                   1319 ;	main.c: 423: i2c_write();
      00892D CD 88 17         [ 4] 1320 	call	_i2c_write
                                   1321 ;	main.c: 424: i2c_stop();
      008930 CD 88 12         [ 4] 1322 	call	_i2c_stop
                                   1323 ;	main.c: 425: uart_write("SW ");
      008933 AE 80 E0         [ 2] 1324 	ldw	x, #(___str_22+0)
      008936 CD 83 47         [ 4] 1325 	call	_uart_write
                                   1326 ;	main.c: 426: convert_int_to_chars(d_addr, ar);
      008939 96               [ 1] 1327 	ldw	x, sp
      00893A 5C               [ 1] 1328 	incw	x
      00893B C6 01 04         [ 1] 1329 	ld	a, _d_addr+0
      00893E CD 83 A8         [ 4] 1330 	call	_convert_int_to_chars
                                   1331 ;	main.c: 427: uart_write(ar);
      008941 96               [ 1] 1332 	ldw	x, sp
      008942 5C               [ 1] 1333 	incw	x
      008943 CD 83 47         [ 4] 1334 	call	_uart_write
                                   1335 ;	main.c: 428: uart_write(" ");
      008946 AE 80 E4         [ 2] 1336 	ldw	x, #(___str_23+0)
      008949 CD 83 47         [ 4] 1337 	call	_uart_write
                                   1338 ;	main.c: 429: convert_int_to_chars(d_size, ar);
      00894C 96               [ 1] 1339 	ldw	x, sp
      00894D 5C               [ 1] 1340 	incw	x
      00894E C6 01 06         [ 1] 1341 	ld	a, _d_size+0
      008951 CD 83 A8         [ 4] 1342 	call	_convert_int_to_chars
                                   1343 ;	main.c: 430: uart_write(ar);
      008954 96               [ 1] 1344 	ldw	x, sp
      008955 5C               [ 1] 1345 	incw	x
      008956 CD 83 47         [ 4] 1346 	call	_uart_write
                                   1347 ;	main.c: 431: uart_write("\r\n");
      008959 AE 80 D5         [ 2] 1348 	ldw	x, #(___str_19+0)
      00895C CD 83 47         [ 4] 1349 	call	_uart_write
                                   1350 ;	main.c: 432: }
      00895F 5B 04            [ 2] 1351 	addw	sp, #4
      008961 81               [ 4] 1352 	ret
                                   1353 ;	main.c: 440: int data_handler(void)
                                   1354 ;	-----------------------------------------
                                   1355 ;	 function data_handler
                                   1356 ;	-----------------------------------------
      008962                       1357 _data_handler:
                                   1358 ;	main.c: 442: p_size = 0;
      008962 72 5F 01 05      [ 1] 1359 	clr	_p_size+0
                                   1360 ;	main.c: 443: p_bytes = 0;
      008966 72 5F 01 07      [ 1] 1361 	clr	_p_bytes+0
                                   1362 ;	main.c: 444: d_addr = 0;
      00896A 72 5F 01 04      [ 1] 1363 	clr	_d_addr+0
                                   1364 ;	main.c: 445: d_size = 0;
      00896E 72 5F 01 06      [ 1] 1365 	clr	_d_size+0
                                   1366 ;	main.c: 446: memset(a, 0, sizeof(a));
      008972 4B 03            [ 1] 1367 	push	#0x03
      008974 4B 00            [ 1] 1368 	push	#0x00
      008976 5F               [ 1] 1369 	clrw	x
      008977 89               [ 2] 1370 	pushw	x
      008978 AE 01 01         [ 2] 1371 	ldw	x, #(_a+0)
      00897B CD 8B 1F         [ 4] 1372 	call	_memset
                                   1373 ;	main.c: 447: memset(data_buf, 0, sizeof(data_buf));
      00897E 4B 00            [ 1] 1374 	push	#0x00
      008980 4B 01            [ 1] 1375 	push	#0x01
      008982 5F               [ 1] 1376 	clrw	x
      008983 89               [ 2] 1377 	pushw	x
      008984 AE 01 08         [ 2] 1378 	ldw	x, #(_data_buf+0)
      008987 CD 8B 1F         [ 4] 1379 	call	_memset
                                   1380 ;	main.c: 448: if(memcmp(&buffer[0],"SM",2) == 0)
      00898A 4B 02            [ 1] 1381 	push	#0x02
      00898C 4B 00            [ 1] 1382 	push	#0x00
      00898E 4B E6            [ 1] 1383 	push	#<(___str_24+0)
      008990 4B 80            [ 1] 1384 	push	#((___str_24+0) >> 8)
      008992 AE 00 01         [ 2] 1385 	ldw	x, #(_buffer+0)
      008995 CD 8A 89         [ 4] 1386 	call	_memcmp
                                   1387 ;	main.c: 449: return 1;
      008998 5D               [ 2] 1388 	tnzw	x
      008999 26 02            [ 1] 1389 	jrne	00102$
      00899B 5C               [ 1] 1390 	incw	x
      00899C 81               [ 4] 1391 	ret
      00899D                       1392 00102$:
                                   1393 ;	main.c: 450: if(memcmp(&buffer[0],"SN",2) == 0)
      00899D 4B 02            [ 1] 1394 	push	#0x02
      00899F 4B 00            [ 1] 1395 	push	#0x00
      0089A1 4B E9            [ 1] 1396 	push	#<(___str_25+0)
      0089A3 4B 80            [ 1] 1397 	push	#((___str_25+0) >> 8)
      0089A5 AE 00 01         [ 2] 1398 	ldw	x, #(_buffer+0)
      0089A8 CD 8A 89         [ 4] 1399 	call	_memcmp
      0089AB 5D               [ 2] 1400 	tnzw	x
      0089AC 26 04            [ 1] 1401 	jrne	00104$
                                   1402 ;	main.c: 451: return 2;
      0089AE AE 00 02         [ 2] 1403 	ldw	x, #0x0002
      0089B1 81               [ 4] 1404 	ret
      0089B2                       1405 00104$:
                                   1406 ;	main.c: 452: if(memcmp(&buffer[0],"ST",2) == 0)
      0089B2 4B 02            [ 1] 1407 	push	#0x02
      0089B4 4B 00            [ 1] 1408 	push	#0x00
      0089B6 4B EC            [ 1] 1409 	push	#<(___str_26+0)
      0089B8 4B 80            [ 1] 1410 	push	#((___str_26+0) >> 8)
      0089BA AE 00 01         [ 2] 1411 	ldw	x, #(_buffer+0)
      0089BD CD 8A 89         [ 4] 1412 	call	_memcmp
      0089C0 5D               [ 2] 1413 	tnzw	x
      0089C1 26 04            [ 1] 1414 	jrne	00106$
                                   1415 ;	main.c: 453: return 5;
      0089C3 AE 00 05         [ 2] 1416 	ldw	x, #0x0005
      0089C6 81               [ 4] 1417 	ret
      0089C7                       1418 00106$:
                                   1419 ;	main.c: 454: if(memcmp(&buffer[0],"RM",2) == 0)
      0089C7 4B 02            [ 1] 1420 	push	#0x02
      0089C9 4B 00            [ 1] 1421 	push	#0x00
      0089CB 4B EF            [ 1] 1422 	push	#<(___str_27+0)
      0089CD 4B 80            [ 1] 1423 	push	#((___str_27+0) >> 8)
      0089CF AE 00 01         [ 2] 1424 	ldw	x, #(_buffer+0)
      0089D2 CD 8A 89         [ 4] 1425 	call	_memcmp
      0089D5 5D               [ 2] 1426 	tnzw	x
      0089D6 26 04            [ 1] 1427 	jrne	00108$
                                   1428 ;	main.c: 455: return 6;
      0089D8 AE 00 06         [ 2] 1429 	ldw	x, #0x0006
      0089DB 81               [ 4] 1430 	ret
      0089DC                       1431 00108$:
                                   1432 ;	main.c: 456: if(memcmp(&buffer[0],"DB",2) == 0)
      0089DC 4B 02            [ 1] 1433 	push	#0x02
      0089DE 4B 00            [ 1] 1434 	push	#0x00
      0089E0 4B F2            [ 1] 1435 	push	#<(___str_28+0)
      0089E2 4B 80            [ 1] 1436 	push	#((___str_28+0) >> 8)
      0089E4 AE 00 01         [ 2] 1437 	ldw	x, #(_buffer+0)
      0089E7 CD 8A 89         [ 4] 1438 	call	_memcmp
      0089EA 5D               [ 2] 1439 	tnzw	x
      0089EB 26 04            [ 1] 1440 	jrne	00110$
                                   1441 ;	main.c: 457: return 7;
      0089ED AE 00 07         [ 2] 1442 	ldw	x, #0x0007
      0089F0 81               [ 4] 1443 	ret
      0089F1                       1444 00110$:
                                   1445 ;	main.c: 459: get_addr_from_buff();
      0089F1 CD 84 8B         [ 4] 1446 	call	_get_addr_from_buff
                                   1447 ;	main.c: 460: get_size_from_buff();
      0089F4 CD 84 CB         [ 4] 1448 	call	_get_size_from_buff
                                   1449 ;	main.c: 462: if(memcmp(&buffer[0],"SR",2) == 0)
      0089F7 4B 02            [ 1] 1450 	push	#0x02
      0089F9 4B 00            [ 1] 1451 	push	#0x00
      0089FB 4B F5            [ 1] 1452 	push	#<(___str_29+0)
      0089FD 4B 80            [ 1] 1453 	push	#((___str_29+0) >> 8)
      0089FF AE 00 01         [ 2] 1454 	ldw	x, #(_buffer+0)
      008A02 CD 8A 89         [ 4] 1455 	call	_memcmp
      008A05 5D               [ 2] 1456 	tnzw	x
      008A06 26 04            [ 1] 1457 	jrne	00112$
                                   1458 ;	main.c: 463: return 3;
      008A08 AE 00 03         [ 2] 1459 	ldw	x, #0x0003
      008A0B 81               [ 4] 1460 	ret
      008A0C                       1461 00112$:
                                   1462 ;	main.c: 465: char_buffer_to_int();
      008A0C CD 85 0F         [ 4] 1463 	call	_char_buffer_to_int
                                   1464 ;	main.c: 467: if(memcmp(&buffer[0],"SW",2) == 0)
      008A0F 4B 02            [ 1] 1465 	push	#0x02
      008A11 4B 00            [ 1] 1466 	push	#0x00
      008A13 4B F8            [ 1] 1467 	push	#<(___str_30+0)
      008A15 4B 80            [ 1] 1468 	push	#((___str_30+0) >> 8)
      008A17 AE 00 01         [ 2] 1469 	ldw	x, #(_buffer+0)
      008A1A CD 8A 89         [ 4] 1470 	call	_memcmp
      008A1D 5D               [ 2] 1471 	tnzw	x
      008A1E 26 04            [ 1] 1472 	jrne	00114$
                                   1473 ;	main.c: 468: return 4;
      008A20 AE 00 04         [ 2] 1474 	ldw	x, #0x0004
      008A23 81               [ 4] 1475 	ret
      008A24                       1476 00114$:
                                   1477 ;	main.c: 469: return 0;
      008A24 5F               [ 1] 1478 	clrw	x
                                   1479 ;	main.c: 471: }
      008A25 81               [ 4] 1480 	ret
                                   1481 ;	main.c: 473: void command_switcher(void)
                                   1482 ;	-----------------------------------------
                                   1483 ;	 function command_switcher
                                   1484 ;	-----------------------------------------
      008A26                       1485 _command_switcher:
      008A26 52 04            [ 2] 1486 	sub	sp, #4
                                   1487 ;	main.c: 475: char ar[4]={0};
      008A28 0F 01            [ 1] 1488 	clr	(0x01, sp)
      008A2A 0F 02            [ 1] 1489 	clr	(0x02, sp)
      008A2C 0F 03            [ 1] 1490 	clr	(0x03, sp)
      008A2E 0F 04            [ 1] 1491 	clr	(0x04, sp)
                                   1492 ;	main.c: 477: switch(data_handler())
      008A30 CD 89 62         [ 4] 1493 	call	_data_handler
      008A33 5D               [ 2] 1494 	tnzw	x
      008A34 2B 3B            [ 1] 1495 	jrmi	00109$
      008A36 A3 00 07         [ 2] 1496 	cpw	x, #0x0007
      008A39 2C 36            [ 1] 1497 	jrsgt	00109$
      008A3B 58               [ 2] 1498 	sllw	x
      008A3C DE 8A 40         [ 2] 1499 	ldw	x, (#00123$, x)
      008A3F FC               [ 2] 1500 	jp	(x)
      008A40                       1501 00123$:
      008A40 8A 71                 1502 	.dw	#00109$
      008A42 8A 50                 1503 	.dw	#00101$
      008A44 8A 55                 1504 	.dw	#00102$
      008A46 8A 5A                 1505 	.dw	#00103$
      008A48 8A 5F                 1506 	.dw	#00104$
      008A4A 8A 64                 1507 	.dw	#00105$
      008A4C 8A 69                 1508 	.dw	#00106$
      008A4E 8A 6E                 1509 	.dw	#00107$
                                   1510 ;	main.c: 479: case 1:
      008A50                       1511 00101$:
                                   1512 ;	main.c: 480: cm_SM();
      008A50 CD 88 C4         [ 4] 1513 	call	_cm_SM
                                   1514 ;	main.c: 481: break;
      008A53 20 1C            [ 2] 1515 	jra	00109$
                                   1516 ;	main.c: 482: case 2:
      008A55                       1517 00102$:
                                   1518 ;	main.c: 483: cm_SN();
      008A55 CD 88 EA         [ 4] 1519 	call	_cm_SN
                                   1520 ;	main.c: 484: break;
      008A58 20 17            [ 2] 1521 	jra	00109$
                                   1522 ;	main.c: 485: case 3:
      008A5A                       1523 00103$:
                                   1524 ;	main.c: 486: cm_SR();
      008A5A CD 89 0B         [ 4] 1525 	call	_cm_SR
                                   1526 ;	main.c: 487: break;
      008A5D 20 12            [ 2] 1527 	jra	00109$
                                   1528 ;	main.c: 488: case 4:
      008A5F                       1529 00104$:
                                   1530 ;	main.c: 489: cm_SW();
      008A5F CD 89 1A         [ 4] 1531 	call	_cm_SW
                                   1532 ;	main.c: 490: break;
      008A62 20 0D            [ 2] 1533 	jra	00109$
                                   1534 ;	main.c: 491: case 5:
      008A64                       1535 00105$:
                                   1536 ;	main.c: 492: cm_ST();
      008A64 CD 88 FD         [ 4] 1537 	call	_cm_ST
                                   1538 ;	main.c: 493: break;
      008A67 20 08            [ 2] 1539 	jra	00109$
                                   1540 ;	main.c: 494: case 6:
      008A69                       1541 00106$:
                                   1542 ;	main.c: 495: cm_RM();
      008A69 CD 88 F0         [ 4] 1543 	call	_cm_RM
                                   1544 ;	main.c: 496: break;
      008A6C 20 03            [ 2] 1545 	jra	00109$
                                   1546 ;	main.c: 497: case 7:
      008A6E                       1547 00107$:
                                   1548 ;	main.c: 498: cm_DB();
      008A6E CD 88 FA         [ 4] 1549 	call	_cm_DB
                                   1550 ;	main.c: 500: }
      008A71                       1551 00109$:
                                   1552 ;	main.c: 501: }
      008A71 5B 04            [ 2] 1553 	addw	sp, #4
      008A73 81               [ 4] 1554 	ret
                                   1555 ;	main.c: 504: void main(void)
                                   1556 ;	-----------------------------------------
                                   1557 ;	 function main
                                   1558 ;	-----------------------------------------
      008A74                       1559 _main:
                                   1560 ;	main.c: 506: uart_init();
      008A74 CD 87 BA         [ 4] 1561 	call	_uart_init
                                   1562 ;	main.c: 507: i2c_init();
      008A77 CD 87 D7         [ 4] 1563 	call	_i2c_init
                                   1564 ;	main.c: 508: uart_write("SS\n");
      008A7A AE 80 FB         [ 2] 1565 	ldw	x, #(___str_31+0)
      008A7D CD 83 47         [ 4] 1566 	call	_uart_write
                                   1567 ;	main.c: 509: while(1)
      008A80                       1568 00102$:
                                   1569 ;	main.c: 511: uart_read();
      008A80 CD 83 72         [ 4] 1570 	call	_uart_read
                                   1571 ;	main.c: 512: command_switcher();
      008A83 CD 8A 26         [ 4] 1572 	call	_command_switcher
      008A86 20 F8            [ 2] 1573 	jra	00102$
                                   1574 ;	main.c: 514: }
      008A88 81               [ 4] 1575 	ret
                                   1576 	.area CODE
                                   1577 	.area CONST
                                   1578 	.area CONST
      00802D                       1579 ___str_0:
      00802D 62 75 66 20 63 6F 75  1580 	.ascii "buf count -> "
             6E 74 20 2D 3E 20
      00803A 00                    1581 	.db 0x00
                                   1582 	.area CODE
                                   1583 	.area CONST
      00803B                       1584 ___str_1:
      00803B 20 3C 2D              1585 	.ascii " <-"
      00803E 0A                    1586 	.db 0x0a
      00803F 00                    1587 	.db 0x00
                                   1588 	.area CODE
                                   1589 	.area CONST
      008040                       1590 ___str_2:
      008040 0A                    1591 	.db 0x0a
      008041 49 32 43 5F 52 45 47  1592 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00804D 0A                    1593 	.db 0x0a
      00804E 00                    1594 	.db 0x00
                                   1595 	.area CODE
                                   1596 	.area CONST
      00804F                       1597 ___str_3:
      00804F 0A                    1598 	.db 0x0a
      008050 53 52 31 20 2D 3E 20  1599 	.ascii "SR1 -> "
      008057 00                    1600 	.db 0x00
                                   1601 	.area CODE
                                   1602 	.area CONST
      008058                       1603 ___str_4:
      008058 53 52 32 20 2D 3E 20  1604 	.ascii "SR2 -> "
      00805F 00                    1605 	.db 0x00
                                   1606 	.area CODE
                                   1607 	.area CONST
      008060                       1608 ___str_5:
      008060 53 52 33 20 2D 3E 20  1609 	.ascii "SR3 -> "
      008067 00                    1610 	.db 0x00
                                   1611 	.area CODE
                                   1612 	.area CONST
      008068                       1613 ___str_6:
      008068 43 52 31 20 2D 3E 20  1614 	.ascii "CR1 -> "
      00806F 00                    1615 	.db 0x00
                                   1616 	.area CODE
                                   1617 	.area CONST
      008070                       1618 ___str_7:
      008070 43 52 32 20 2D 3E 20  1619 	.ascii "CR2 -> "
      008077 00                    1620 	.db 0x00
                                   1621 	.area CODE
                                   1622 	.area CONST
      008078                       1623 ___str_8:
      008078 44 52 20 2D 3E 20     1624 	.ascii "DR -> "
      00807E 00                    1625 	.db 0x00
                                   1626 	.area CODE
                                   1627 	.area CONST
      00807F                       1628 ___str_9:
      00807F 55 41 52 54 5F 52 45  1629 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      00808C 0A                    1630 	.db 0x0a
      00808D 00                    1631 	.db 0x00
                                   1632 	.area CODE
                                   1633 	.area CONST
      00808E                       1634 ___str_10:
      00808E 0A                    1635 	.db 0x0a
      00808F 53 52 20 2D 3E 20     1636 	.ascii "SR -> "
      008095 00                    1637 	.db 0x00
                                   1638 	.area CODE
                                   1639 	.area CONST
      008096                       1640 ___str_11:
      008096 42 52 52 31 20 2D 3E  1641 	.ascii "BRR1 -> "
             20
      00809E 00                    1642 	.db 0x00
                                   1643 	.area CODE
                                   1644 	.area CONST
      00809F                       1645 ___str_12:
      00809F 42 52 52 32 20 2D 3E  1646 	.ascii "BRR2 -> "
             20
      0080A7 00                    1647 	.db 0x00
                                   1648 	.area CODE
                                   1649 	.area CONST
      0080A8                       1650 ___str_13:
      0080A8 43 52 33 20 2D 3E 20  1651 	.ascii "CR3 -> "
      0080AF 00                    1652 	.db 0x00
                                   1653 	.area CODE
                                   1654 	.area CONST
      0080B0                       1655 ___str_14:
      0080B0 43 52 34 20 2D 3E 20  1656 	.ascii "CR4 -> "
      0080B7 00                    1657 	.db 0x00
                                   1658 	.area CODE
                                   1659 	.area CONST
      0080B8                       1660 ___str_15:
      0080B8 43 52 35 20 2D 3E 20  1661 	.ascii "CR5 -> "
      0080BF 00                    1662 	.db 0x00
                                   1663 	.area CODE
                                   1664 	.area CONST
      0080C0                       1665 ___str_16:
      0080C0 47 54 52 20 2D 3E 20  1666 	.ascii "GTR -> "
      0080C7 00                    1667 	.db 0x00
                                   1668 	.area CODE
                                   1669 	.area CONST
      0080C8                       1670 ___str_17:
      0080C8 50 53 43 52 20 2D 3E  1671 	.ascii "PSCR -> "
             20
      0080D0 00                    1672 	.db 0x00
                                   1673 	.area CODE
                                   1674 	.area CONST
      0080D1                       1675 ___str_18:
      0080D1 53 4D 20              1676 	.ascii "SM "
      0080D4 00                    1677 	.db 0x00
                                   1678 	.area CODE
                                   1679 	.area CONST
      0080D5                       1680 ___str_19:
      0080D5 0D                    1681 	.db 0x0d
      0080D6 0A                    1682 	.db 0x0a
      0080D7 00                    1683 	.db 0x00
                                   1684 	.area CODE
                                   1685 	.area CONST
      0080D8                       1686 ___str_20:
      0080D8 52 4D                 1687 	.ascii "RM"
      0080DA 0A                    1688 	.db 0x0a
      0080DB 00                    1689 	.db 0x00
                                   1690 	.area CODE
                                   1691 	.area CONST
      0080DC                       1692 ___str_21:
      0080DC 53 54                 1693 	.ascii "ST"
      0080DE 0A                    1694 	.db 0x0a
      0080DF 00                    1695 	.db 0x00
                                   1696 	.area CODE
                                   1697 	.area CONST
      0080E0                       1698 ___str_22:
      0080E0 53 57 20              1699 	.ascii "SW "
      0080E3 00                    1700 	.db 0x00
                                   1701 	.area CODE
                                   1702 	.area CONST
      0080E4                       1703 ___str_23:
      0080E4 20                    1704 	.ascii " "
      0080E5 00                    1705 	.db 0x00
                                   1706 	.area CODE
                                   1707 	.area CONST
      0080E6                       1708 ___str_24:
      0080E6 53 4D                 1709 	.ascii "SM"
      0080E8 00                    1710 	.db 0x00
                                   1711 	.area CODE
                                   1712 	.area CONST
      0080E9                       1713 ___str_25:
      0080E9 53 4E                 1714 	.ascii "SN"
      0080EB 00                    1715 	.db 0x00
                                   1716 	.area CODE
                                   1717 	.area CONST
      0080EC                       1718 ___str_26:
      0080EC 53 54                 1719 	.ascii "ST"
      0080EE 00                    1720 	.db 0x00
                                   1721 	.area CODE
                                   1722 	.area CONST
      0080EF                       1723 ___str_27:
      0080EF 52 4D                 1724 	.ascii "RM"
      0080F1 00                    1725 	.db 0x00
                                   1726 	.area CODE
                                   1727 	.area CONST
      0080F2                       1728 ___str_28:
      0080F2 44 42                 1729 	.ascii "DB"
      0080F4 00                    1730 	.db 0x00
                                   1731 	.area CODE
                                   1732 	.area CONST
      0080F5                       1733 ___str_29:
      0080F5 53 52                 1734 	.ascii "SR"
      0080F7 00                    1735 	.db 0x00
                                   1736 	.area CODE
                                   1737 	.area CONST
      0080F8                       1738 ___str_30:
      0080F8 53 57                 1739 	.ascii "SW"
      0080FA 00                    1740 	.db 0x00
                                   1741 	.area CODE
                                   1742 	.area CONST
      0080FB                       1743 ___str_31:
      0080FB 53 53                 1744 	.ascii "SS"
      0080FD 0A                    1745 	.db 0x0a
      0080FE 00                    1746 	.db 0x00
                                   1747 	.area CODE
                                   1748 	.area INITIALIZER
      0080FF                       1749 __xinit__buffer:
      0080FF 00                    1750 	.db #0x00	; 0
      008100 00                    1751 	.db 0x00
      008101 00                    1752 	.db 0x00
      008102 00                    1753 	.db 0x00
      008103 00                    1754 	.db 0x00
      008104 00                    1755 	.db 0x00
      008105 00                    1756 	.db 0x00
      008106 00                    1757 	.db 0x00
      008107 00                    1758 	.db 0x00
      008108 00                    1759 	.db 0x00
      008109 00                    1760 	.db 0x00
      00810A 00                    1761 	.db 0x00
      00810B 00                    1762 	.db 0x00
      00810C 00                    1763 	.db 0x00
      00810D 00                    1764 	.db 0x00
      00810E 00                    1765 	.db 0x00
      00810F 00                    1766 	.db 0x00
      008110 00                    1767 	.db 0x00
      008111 00                    1768 	.db 0x00
      008112 00                    1769 	.db 0x00
      008113 00                    1770 	.db 0x00
      008114 00                    1771 	.db 0x00
      008115 00                    1772 	.db 0x00
      008116 00                    1773 	.db 0x00
      008117 00                    1774 	.db 0x00
      008118 00                    1775 	.db 0x00
      008119 00                    1776 	.db 0x00
      00811A 00                    1777 	.db 0x00
      00811B 00                    1778 	.db 0x00
      00811C 00                    1779 	.db 0x00
      00811D 00                    1780 	.db 0x00
      00811E 00                    1781 	.db 0x00
      00811F 00                    1782 	.db 0x00
      008120 00                    1783 	.db 0x00
      008121 00                    1784 	.db 0x00
      008122 00                    1785 	.db 0x00
      008123 00                    1786 	.db 0x00
      008124 00                    1787 	.db 0x00
      008125 00                    1788 	.db 0x00
      008126 00                    1789 	.db 0x00
      008127 00                    1790 	.db 0x00
      008128 00                    1791 	.db 0x00
      008129 00                    1792 	.db 0x00
      00812A 00                    1793 	.db 0x00
      00812B 00                    1794 	.db 0x00
      00812C 00                    1795 	.db 0x00
      00812D 00                    1796 	.db 0x00
      00812E 00                    1797 	.db 0x00
      00812F 00                    1798 	.db 0x00
      008130 00                    1799 	.db 0x00
      008131 00                    1800 	.db 0x00
      008132 00                    1801 	.db 0x00
      008133 00                    1802 	.db 0x00
      008134 00                    1803 	.db 0x00
      008135 00                    1804 	.db 0x00
      008136 00                    1805 	.db 0x00
      008137 00                    1806 	.db 0x00
      008138 00                    1807 	.db 0x00
      008139 00                    1808 	.db 0x00
      00813A 00                    1809 	.db 0x00
      00813B 00                    1810 	.db 0x00
      00813C 00                    1811 	.db 0x00
      00813D 00                    1812 	.db 0x00
      00813E 00                    1813 	.db 0x00
      00813F 00                    1814 	.db 0x00
      008140 00                    1815 	.db 0x00
      008141 00                    1816 	.db 0x00
      008142 00                    1817 	.db 0x00
      008143 00                    1818 	.db 0x00
      008144 00                    1819 	.db 0x00
      008145 00                    1820 	.db 0x00
      008146 00                    1821 	.db 0x00
      008147 00                    1822 	.db 0x00
      008148 00                    1823 	.db 0x00
      008149 00                    1824 	.db 0x00
      00814A 00                    1825 	.db 0x00
      00814B 00                    1826 	.db 0x00
      00814C 00                    1827 	.db 0x00
      00814D 00                    1828 	.db 0x00
      00814E 00                    1829 	.db 0x00
      00814F 00                    1830 	.db 0x00
      008150 00                    1831 	.db 0x00
      008151 00                    1832 	.db 0x00
      008152 00                    1833 	.db 0x00
      008153 00                    1834 	.db 0x00
      008154 00                    1835 	.db 0x00
      008155 00                    1836 	.db 0x00
      008156 00                    1837 	.db 0x00
      008157 00                    1838 	.db 0x00
      008158 00                    1839 	.db 0x00
      008159 00                    1840 	.db 0x00
      00815A 00                    1841 	.db 0x00
      00815B 00                    1842 	.db 0x00
      00815C 00                    1843 	.db 0x00
      00815D 00                    1844 	.db 0x00
      00815E 00                    1845 	.db 0x00
      00815F 00                    1846 	.db 0x00
      008160 00                    1847 	.db 0x00
      008161 00                    1848 	.db 0x00
      008162 00                    1849 	.db 0x00
      008163 00                    1850 	.db 0x00
      008164 00                    1851 	.db 0x00
      008165 00                    1852 	.db 0x00
      008166 00                    1853 	.db 0x00
      008167 00                    1854 	.db 0x00
      008168 00                    1855 	.db 0x00
      008169 00                    1856 	.db 0x00
      00816A 00                    1857 	.db 0x00
      00816B 00                    1858 	.db 0x00
      00816C 00                    1859 	.db 0x00
      00816D 00                    1860 	.db 0x00
      00816E 00                    1861 	.db 0x00
      00816F 00                    1862 	.db 0x00
      008170 00                    1863 	.db 0x00
      008171 00                    1864 	.db 0x00
      008172 00                    1865 	.db 0x00
      008173 00                    1866 	.db 0x00
      008174 00                    1867 	.db 0x00
      008175 00                    1868 	.db 0x00
      008176 00                    1869 	.db 0x00
      008177 00                    1870 	.db 0x00
      008178 00                    1871 	.db 0x00
      008179 00                    1872 	.db 0x00
      00817A 00                    1873 	.db 0x00
      00817B 00                    1874 	.db 0x00
      00817C 00                    1875 	.db 0x00
      00817D 00                    1876 	.db 0x00
      00817E 00                    1877 	.db 0x00
      00817F 00                    1878 	.db 0x00
      008180 00                    1879 	.db 0x00
      008181 00                    1880 	.db 0x00
      008182 00                    1881 	.db 0x00
      008183 00                    1882 	.db 0x00
      008184 00                    1883 	.db 0x00
      008185 00                    1884 	.db 0x00
      008186 00                    1885 	.db 0x00
      008187 00                    1886 	.db 0x00
      008188 00                    1887 	.db 0x00
      008189 00                    1888 	.db 0x00
      00818A 00                    1889 	.db 0x00
      00818B 00                    1890 	.db 0x00
      00818C 00                    1891 	.db 0x00
      00818D 00                    1892 	.db 0x00
      00818E 00                    1893 	.db 0x00
      00818F 00                    1894 	.db 0x00
      008190 00                    1895 	.db 0x00
      008191 00                    1896 	.db 0x00
      008192 00                    1897 	.db 0x00
      008193 00                    1898 	.db 0x00
      008194 00                    1899 	.db 0x00
      008195 00                    1900 	.db 0x00
      008196 00                    1901 	.db 0x00
      008197 00                    1902 	.db 0x00
      008198 00                    1903 	.db 0x00
      008199 00                    1904 	.db 0x00
      00819A 00                    1905 	.db 0x00
      00819B 00                    1906 	.db 0x00
      00819C 00                    1907 	.db 0x00
      00819D 00                    1908 	.db 0x00
      00819E 00                    1909 	.db 0x00
      00819F 00                    1910 	.db 0x00
      0081A0 00                    1911 	.db 0x00
      0081A1 00                    1912 	.db 0x00
      0081A2 00                    1913 	.db 0x00
      0081A3 00                    1914 	.db 0x00
      0081A4 00                    1915 	.db 0x00
      0081A5 00                    1916 	.db 0x00
      0081A6 00                    1917 	.db 0x00
      0081A7 00                    1918 	.db 0x00
      0081A8 00                    1919 	.db 0x00
      0081A9 00                    1920 	.db 0x00
      0081AA 00                    1921 	.db 0x00
      0081AB 00                    1922 	.db 0x00
      0081AC 00                    1923 	.db 0x00
      0081AD 00                    1924 	.db 0x00
      0081AE 00                    1925 	.db 0x00
      0081AF 00                    1926 	.db 0x00
      0081B0 00                    1927 	.db 0x00
      0081B1 00                    1928 	.db 0x00
      0081B2 00                    1929 	.db 0x00
      0081B3 00                    1930 	.db 0x00
      0081B4 00                    1931 	.db 0x00
      0081B5 00                    1932 	.db 0x00
      0081B6 00                    1933 	.db 0x00
      0081B7 00                    1934 	.db 0x00
      0081B8 00                    1935 	.db 0x00
      0081B9 00                    1936 	.db 0x00
      0081BA 00                    1937 	.db 0x00
      0081BB 00                    1938 	.db 0x00
      0081BC 00                    1939 	.db 0x00
      0081BD 00                    1940 	.db 0x00
      0081BE 00                    1941 	.db 0x00
      0081BF 00                    1942 	.db 0x00
      0081C0 00                    1943 	.db 0x00
      0081C1 00                    1944 	.db 0x00
      0081C2 00                    1945 	.db 0x00
      0081C3 00                    1946 	.db 0x00
      0081C4 00                    1947 	.db 0x00
      0081C5 00                    1948 	.db 0x00
      0081C6 00                    1949 	.db 0x00
      0081C7 00                    1950 	.db 0x00
      0081C8 00                    1951 	.db 0x00
      0081C9 00                    1952 	.db 0x00
      0081CA 00                    1953 	.db 0x00
      0081CB 00                    1954 	.db 0x00
      0081CC 00                    1955 	.db 0x00
      0081CD 00                    1956 	.db 0x00
      0081CE 00                    1957 	.db 0x00
      0081CF 00                    1958 	.db 0x00
      0081D0 00                    1959 	.db 0x00
      0081D1 00                    1960 	.db 0x00
      0081D2 00                    1961 	.db 0x00
      0081D3 00                    1962 	.db 0x00
      0081D4 00                    1963 	.db 0x00
      0081D5 00                    1964 	.db 0x00
      0081D6 00                    1965 	.db 0x00
      0081D7 00                    1966 	.db 0x00
      0081D8 00                    1967 	.db 0x00
      0081D9 00                    1968 	.db 0x00
      0081DA 00                    1969 	.db 0x00
      0081DB 00                    1970 	.db 0x00
      0081DC 00                    1971 	.db 0x00
      0081DD 00                    1972 	.db 0x00
      0081DE 00                    1973 	.db 0x00
      0081DF 00                    1974 	.db 0x00
      0081E0 00                    1975 	.db 0x00
      0081E1 00                    1976 	.db 0x00
      0081E2 00                    1977 	.db 0x00
      0081E3 00                    1978 	.db 0x00
      0081E4 00                    1979 	.db 0x00
      0081E5 00                    1980 	.db 0x00
      0081E6 00                    1981 	.db 0x00
      0081E7 00                    1982 	.db 0x00
      0081E8 00                    1983 	.db 0x00
      0081E9 00                    1984 	.db 0x00
      0081EA 00                    1985 	.db 0x00
      0081EB 00                    1986 	.db 0x00
      0081EC 00                    1987 	.db 0x00
      0081ED 00                    1988 	.db 0x00
      0081EE 00                    1989 	.db 0x00
      0081EF 00                    1990 	.db 0x00
      0081F0 00                    1991 	.db 0x00
      0081F1 00                    1992 	.db 0x00
      0081F2 00                    1993 	.db 0x00
      0081F3 00                    1994 	.db 0x00
      0081F4 00                    1995 	.db 0x00
      0081F5 00                    1996 	.db 0x00
      0081F6 00                    1997 	.db 0x00
      0081F7 00                    1998 	.db 0x00
      0081F8 00                    1999 	.db 0x00
      0081F9 00                    2000 	.db 0x00
      0081FA 00                    2001 	.db 0x00
      0081FB 00                    2002 	.db 0x00
      0081FC 00                    2003 	.db 0x00
      0081FD 00                    2004 	.db 0x00
      0081FE 00                    2005 	.db 0x00
      0081FF                       2006 __xinit__a:
      0081FF 00                    2007 	.db #0x00	; 0
      008200 00                    2008 	.db 0x00
      008201 00                    2009 	.db 0x00
      008202                       2010 __xinit__d_addr:
      008202 00                    2011 	.db #0x00	; 0
      008203                       2012 __xinit__p_size:
      008203 00                    2013 	.db #0x00	; 0
      008204                       2014 __xinit__d_size:
      008204 00                    2015 	.db #0x00	; 0
      008205                       2016 __xinit__p_bytes:
      008205 00                    2017 	.db #0x00	; 0
      008206                       2018 __xinit__data_buf:
      008206 00                    2019 	.db #0x00	; 0
      008207 00                    2020 	.db 0x00
      008208 00                    2021 	.db 0x00
      008209 00                    2022 	.db 0x00
      00820A 00                    2023 	.db 0x00
      00820B 00                    2024 	.db 0x00
      00820C 00                    2025 	.db 0x00
      00820D 00                    2026 	.db 0x00
      00820E 00                    2027 	.db 0x00
      00820F 00                    2028 	.db 0x00
      008210 00                    2029 	.db 0x00
      008211 00                    2030 	.db 0x00
      008212 00                    2031 	.db 0x00
      008213 00                    2032 	.db 0x00
      008214 00                    2033 	.db 0x00
      008215 00                    2034 	.db 0x00
      008216 00                    2035 	.db 0x00
      008217 00                    2036 	.db 0x00
      008218 00                    2037 	.db 0x00
      008219 00                    2038 	.db 0x00
      00821A 00                    2039 	.db 0x00
      00821B 00                    2040 	.db 0x00
      00821C 00                    2041 	.db 0x00
      00821D 00                    2042 	.db 0x00
      00821E 00                    2043 	.db 0x00
      00821F 00                    2044 	.db 0x00
      008220 00                    2045 	.db 0x00
      008221 00                    2046 	.db 0x00
      008222 00                    2047 	.db 0x00
      008223 00                    2048 	.db 0x00
      008224 00                    2049 	.db 0x00
      008225 00                    2050 	.db 0x00
      008226 00                    2051 	.db 0x00
      008227 00                    2052 	.db 0x00
      008228 00                    2053 	.db 0x00
      008229 00                    2054 	.db 0x00
      00822A 00                    2055 	.db 0x00
      00822B 00                    2056 	.db 0x00
      00822C 00                    2057 	.db 0x00
      00822D 00                    2058 	.db 0x00
      00822E 00                    2059 	.db 0x00
      00822F 00                    2060 	.db 0x00
      008230 00                    2061 	.db 0x00
      008231 00                    2062 	.db 0x00
      008232 00                    2063 	.db 0x00
      008233 00                    2064 	.db 0x00
      008234 00                    2065 	.db 0x00
      008235 00                    2066 	.db 0x00
      008236 00                    2067 	.db 0x00
      008237 00                    2068 	.db 0x00
      008238 00                    2069 	.db 0x00
      008239 00                    2070 	.db 0x00
      00823A 00                    2071 	.db 0x00
      00823B 00                    2072 	.db 0x00
      00823C 00                    2073 	.db 0x00
      00823D 00                    2074 	.db 0x00
      00823E 00                    2075 	.db 0x00
      00823F 00                    2076 	.db 0x00
      008240 00                    2077 	.db 0x00
      008241 00                    2078 	.db 0x00
      008242 00                    2079 	.db 0x00
      008243 00                    2080 	.db 0x00
      008244 00                    2081 	.db 0x00
      008245 00                    2082 	.db 0x00
      008246 00                    2083 	.db 0x00
      008247 00                    2084 	.db 0x00
      008248 00                    2085 	.db 0x00
      008249 00                    2086 	.db 0x00
      00824A 00                    2087 	.db 0x00
      00824B 00                    2088 	.db 0x00
      00824C 00                    2089 	.db 0x00
      00824D 00                    2090 	.db 0x00
      00824E 00                    2091 	.db 0x00
      00824F 00                    2092 	.db 0x00
      008250 00                    2093 	.db 0x00
      008251 00                    2094 	.db 0x00
      008252 00                    2095 	.db 0x00
      008253 00                    2096 	.db 0x00
      008254 00                    2097 	.db 0x00
      008255 00                    2098 	.db 0x00
      008256 00                    2099 	.db 0x00
      008257 00                    2100 	.db 0x00
      008258 00                    2101 	.db 0x00
      008259 00                    2102 	.db 0x00
      00825A 00                    2103 	.db 0x00
      00825B 00                    2104 	.db 0x00
      00825C 00                    2105 	.db 0x00
      00825D 00                    2106 	.db 0x00
      00825E 00                    2107 	.db 0x00
      00825F 00                    2108 	.db 0x00
      008260 00                    2109 	.db 0x00
      008261 00                    2110 	.db 0x00
      008262 00                    2111 	.db 0x00
      008263 00                    2112 	.db 0x00
      008264 00                    2113 	.db 0x00
      008265 00                    2114 	.db 0x00
      008266 00                    2115 	.db 0x00
      008267 00                    2116 	.db 0x00
      008268 00                    2117 	.db 0x00
      008269 00                    2118 	.db 0x00
      00826A 00                    2119 	.db 0x00
      00826B 00                    2120 	.db 0x00
      00826C 00                    2121 	.db 0x00
      00826D 00                    2122 	.db 0x00
      00826E 00                    2123 	.db 0x00
      00826F 00                    2124 	.db 0x00
      008270 00                    2125 	.db 0x00
      008271 00                    2126 	.db 0x00
      008272 00                    2127 	.db 0x00
      008273 00                    2128 	.db 0x00
      008274 00                    2129 	.db 0x00
      008275 00                    2130 	.db 0x00
      008276 00                    2131 	.db 0x00
      008277 00                    2132 	.db 0x00
      008278 00                    2133 	.db 0x00
      008279 00                    2134 	.db 0x00
      00827A 00                    2135 	.db 0x00
      00827B 00                    2136 	.db 0x00
      00827C 00                    2137 	.db 0x00
      00827D 00                    2138 	.db 0x00
      00827E 00                    2139 	.db 0x00
      00827F 00                    2140 	.db 0x00
      008280 00                    2141 	.db 0x00
      008281 00                    2142 	.db 0x00
      008282 00                    2143 	.db 0x00
      008283 00                    2144 	.db 0x00
      008284 00                    2145 	.db 0x00
      008285 00                    2146 	.db 0x00
      008286 00                    2147 	.db 0x00
      008287 00                    2148 	.db 0x00
      008288 00                    2149 	.db 0x00
      008289 00                    2150 	.db 0x00
      00828A 00                    2151 	.db 0x00
      00828B 00                    2152 	.db 0x00
      00828C 00                    2153 	.db 0x00
      00828D 00                    2154 	.db 0x00
      00828E 00                    2155 	.db 0x00
      00828F 00                    2156 	.db 0x00
      008290 00                    2157 	.db 0x00
      008291 00                    2158 	.db 0x00
      008292 00                    2159 	.db 0x00
      008293 00                    2160 	.db 0x00
      008294 00                    2161 	.db 0x00
      008295 00                    2162 	.db 0x00
      008296 00                    2163 	.db 0x00
      008297 00                    2164 	.db 0x00
      008298 00                    2165 	.db 0x00
      008299 00                    2166 	.db 0x00
      00829A 00                    2167 	.db 0x00
      00829B 00                    2168 	.db 0x00
      00829C 00                    2169 	.db 0x00
      00829D 00                    2170 	.db 0x00
      00829E 00                    2171 	.db 0x00
      00829F 00                    2172 	.db 0x00
      0082A0 00                    2173 	.db 0x00
      0082A1 00                    2174 	.db 0x00
      0082A2 00                    2175 	.db 0x00
      0082A3 00                    2176 	.db 0x00
      0082A4 00                    2177 	.db 0x00
      0082A5 00                    2178 	.db 0x00
      0082A6 00                    2179 	.db 0x00
      0082A7 00                    2180 	.db 0x00
      0082A8 00                    2181 	.db 0x00
      0082A9 00                    2182 	.db 0x00
      0082AA 00                    2183 	.db 0x00
      0082AB 00                    2184 	.db 0x00
      0082AC 00                    2185 	.db 0x00
      0082AD 00                    2186 	.db 0x00
      0082AE 00                    2187 	.db 0x00
      0082AF 00                    2188 	.db 0x00
      0082B0 00                    2189 	.db 0x00
      0082B1 00                    2190 	.db 0x00
      0082B2 00                    2191 	.db 0x00
      0082B3 00                    2192 	.db 0x00
      0082B4 00                    2193 	.db 0x00
      0082B5 00                    2194 	.db 0x00
      0082B6 00                    2195 	.db 0x00
      0082B7 00                    2196 	.db 0x00
      0082B8 00                    2197 	.db 0x00
      0082B9 00                    2198 	.db 0x00
      0082BA 00                    2199 	.db 0x00
      0082BB 00                    2200 	.db 0x00
      0082BC 00                    2201 	.db 0x00
      0082BD 00                    2202 	.db 0x00
      0082BE 00                    2203 	.db 0x00
      0082BF 00                    2204 	.db 0x00
      0082C0 00                    2205 	.db 0x00
      0082C1 00                    2206 	.db 0x00
      0082C2 00                    2207 	.db 0x00
      0082C3 00                    2208 	.db 0x00
      0082C4 00                    2209 	.db 0x00
      0082C5 00                    2210 	.db 0x00
      0082C6 00                    2211 	.db 0x00
      0082C7 00                    2212 	.db 0x00
      0082C8 00                    2213 	.db 0x00
      0082C9 00                    2214 	.db 0x00
      0082CA 00                    2215 	.db 0x00
      0082CB 00                    2216 	.db 0x00
      0082CC 00                    2217 	.db 0x00
      0082CD 00                    2218 	.db 0x00
      0082CE 00                    2219 	.db 0x00
      0082CF 00                    2220 	.db 0x00
      0082D0 00                    2221 	.db 0x00
      0082D1 00                    2222 	.db 0x00
      0082D2 00                    2223 	.db 0x00
      0082D3 00                    2224 	.db 0x00
      0082D4 00                    2225 	.db 0x00
      0082D5 00                    2226 	.db 0x00
      0082D6 00                    2227 	.db 0x00
      0082D7 00                    2228 	.db 0x00
      0082D8 00                    2229 	.db 0x00
      0082D9 00                    2230 	.db 0x00
      0082DA 00                    2231 	.db 0x00
      0082DB 00                    2232 	.db 0x00
      0082DC 00                    2233 	.db 0x00
      0082DD 00                    2234 	.db 0x00
      0082DE 00                    2235 	.db 0x00
      0082DF 00                    2236 	.db 0x00
      0082E0 00                    2237 	.db 0x00
      0082E1 00                    2238 	.db 0x00
      0082E2 00                    2239 	.db 0x00
      0082E3 00                    2240 	.db 0x00
      0082E4 00                    2241 	.db 0x00
      0082E5 00                    2242 	.db 0x00
      0082E6 00                    2243 	.db 0x00
      0082E7 00                    2244 	.db 0x00
      0082E8 00                    2245 	.db 0x00
      0082E9 00                    2246 	.db 0x00
      0082EA 00                    2247 	.db 0x00
      0082EB 00                    2248 	.db 0x00
      0082EC 00                    2249 	.db 0x00
      0082ED 00                    2250 	.db 0x00
      0082EE 00                    2251 	.db 0x00
      0082EF 00                    2252 	.db 0x00
      0082F0 00                    2253 	.db 0x00
      0082F1 00                    2254 	.db 0x00
      0082F2 00                    2255 	.db 0x00
      0082F3 00                    2256 	.db 0x00
      0082F4 00                    2257 	.db 0x00
      0082F5 00                    2258 	.db 0x00
      0082F6 00                    2259 	.db 0x00
      0082F7 00                    2260 	.db 0x00
      0082F8 00                    2261 	.db 0x00
      0082F9 00                    2262 	.db 0x00
      0082FA 00                    2263 	.db 0x00
      0082FB 00                    2264 	.db 0x00
      0082FC 00                    2265 	.db 0x00
      0082FD 00                    2266 	.db 0x00
      0082FE 00                    2267 	.db 0x00
      0082FF 00                    2268 	.db 0x00
      008300 00                    2269 	.db 0x00
      008301 00                    2270 	.db 0x00
      008302 00                    2271 	.db 0x00
      008303 00                    2272 	.db 0x00
      008304 00                    2273 	.db 0x00
      008305 00                    2274 	.db 0x00
      008306                       2275 __xinit__current_dev:
      008306 00                    2276 	.db #0x00	; 0
                                   2277 	.area CABS (ABS)
