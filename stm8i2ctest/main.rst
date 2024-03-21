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
                                     30 	.globl _reg_check
                                     31 	.globl _char_buffer_to_int
                                     32 	.globl _get_size_from_buff
                                     33 	.globl _get_addr_from_buff
                                     34 	.globl _convert_int_to_binary
                                     35 	.globl _convert_chars_to_int
                                     36 	.globl _convert_int_to_chars
                                     37 	.globl _uart_read
                                     38 	.globl _UART_RX
                                     39 	.globl _uart_write
                                     40 	.globl _UART_TX
                                     41 	.globl _delay
                                     42 	.globl ___memcpy
                                     43 	.globl _strlen
                                     44 	.globl _memset
                                     45 	.globl _memcmp
                                     46 	.globl _current_dev
                                     47 	.globl _data_buf
                                     48 	.globl _p_bytes
                                     49 	.globl _d_size
                                     50 	.globl _p_size
                                     51 	.globl _d_addr
                                     52 	.globl _a
                                     53 	.globl _buffer
                                     54 	.globl _status_registers
                                     55 ;--------------------------------------------------------
                                     56 ; ram data
                                     57 ;--------------------------------------------------------
                                     58 	.area DATA
                                     59 ;--------------------------------------------------------
                                     60 ; ram data
                                     61 ;--------------------------------------------------------
                                     62 	.area INITIALIZED
      000001                         63 _status_registers::
      000001                         64 	.ds 256
      000101                         65 _buffer::
      000101                         66 	.ds 256
      000201                         67 _a::
      000201                         68 	.ds 3
      000204                         69 _d_addr::
      000204                         70 	.ds 1
      000205                         71 _p_size::
      000205                         72 	.ds 1
      000206                         73 _d_size::
      000206                         74 	.ds 1
      000207                         75 _p_bytes::
      000207                         76 	.ds 1
      000208                         77 _data_buf::
      000208                         78 	.ds 256
      000308                         79 _current_dev::
      000308                         80 	.ds 1
                                     81 ;--------------------------------------------------------
                                     82 ; Stack segment in internal ram
                                     83 ;--------------------------------------------------------
                                     84 	.area SSEG
      000309                         85 __start__stack:
      000309                         86 	.ds	1
                                     87 
                                     88 ;--------------------------------------------------------
                                     89 ; absolute external ram data
                                     90 ;--------------------------------------------------------
                                     91 	.area DABS (ABS)
                                     92 
                                     93 ; default segment ordering for linker
                                     94 	.area HOME
                                     95 	.area GSINIT
                                     96 	.area GSFINAL
                                     97 	.area CONST
                                     98 	.area INITIALIZER
                                     99 	.area CODE
                                    100 
                                    101 ;--------------------------------------------------------
                                    102 ; interrupt vector
                                    103 ;--------------------------------------------------------
                                    104 	.area HOME
      008000                        105 __interrupt_vect:
      008000 82 00 80 07            106 	int s_GSINIT ; reset
                                    107 ;--------------------------------------------------------
                                    108 ; global & static initialisations
                                    109 ;--------------------------------------------------------
                                    110 	.area HOME
                                    111 	.area GSINIT
                                    112 	.area GSFINAL
                                    113 	.area GSINIT
      008007 CD 8C 1C         [ 4]  114 	call	___sdcc_external_startup
      00800A 4D               [ 1]  115 	tnz	a
      00800B 27 03            [ 1]  116 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]  117 	jp	__sdcc_program_startup
      008010                        118 __sdcc_init_data:
                                    119 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]  120 	ldw x, #l_DATA
      008013 27 07            [ 1]  121 	jreq	00002$
      008015                        122 00001$:
      008015 72 4F 00 00      [ 1]  123 	clr (s_DATA - 1, x)
      008019 5A               [ 2]  124 	decw x
      00801A 26 F9            [ 1]  125 	jrne	00001$
      00801C                        126 00002$:
      00801C AE 03 08         [ 2]  127 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]  128 	jreq	00004$
      008021                        129 00003$:
      008021 D6 80 A2         [ 1]  130 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]  131 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]  132 	decw	x
      008028 26 F7            [ 1]  133 	jrne	00003$
      00802A                        134 00004$:
                                    135 ; stm8_genXINIT() end
                                    136 	.area GSFINAL
      00802A CC 80 04         [ 2]  137 	jp	__sdcc_program_startup
                                    138 ;--------------------------------------------------------
                                    139 ; Home
                                    140 ;--------------------------------------------------------
                                    141 	.area HOME
                                    142 	.area HOME
      008004                        143 __sdcc_program_startup:
      008004 CC 8B 4F         [ 2]  144 	jp	_main
                                    145 ;	return from main will return to caller
                                    146 ;--------------------------------------------------------
                                    147 ; code
                                    148 ;--------------------------------------------------------
                                    149 	.area CODE
                                    150 ;	main.c: 27: void delay(unsigned long count) {
                                    151 ;	-----------------------------------------
                                    152 ;	 function delay
                                    153 ;	-----------------------------------------
      0083AB                        154 _delay:
      0083AB 52 08            [ 2]  155 	sub	sp, #8
                                    156 ;	main.c: 28: while (count--)
      0083AD 16 0D            [ 2]  157 	ldw	y, (0x0d, sp)
      0083AF 17 07            [ 2]  158 	ldw	(0x07, sp), y
      0083B1 1E 0B            [ 2]  159 	ldw	x, (0x0b, sp)
      0083B3                        160 00101$:
      0083B3 1F 01            [ 2]  161 	ldw	(0x01, sp), x
      0083B5 7B 07            [ 1]  162 	ld	a, (0x07, sp)
      0083B7 6B 03            [ 1]  163 	ld	(0x03, sp), a
      0083B9 7B 08            [ 1]  164 	ld	a, (0x08, sp)
      0083BB 16 07            [ 2]  165 	ldw	y, (0x07, sp)
      0083BD 72 A2 00 01      [ 2]  166 	subw	y, #0x0001
      0083C1 17 07            [ 2]  167 	ldw	(0x07, sp), y
      0083C3 24 01            [ 1]  168 	jrnc	00117$
      0083C5 5A               [ 2]  169 	decw	x
      0083C6                        170 00117$:
      0083C6 4D               [ 1]  171 	tnz	a
      0083C7 26 08            [ 1]  172 	jrne	00118$
      0083C9 16 02            [ 2]  173 	ldw	y, (0x02, sp)
      0083CB 26 04            [ 1]  174 	jrne	00118$
      0083CD 0D 01            [ 1]  175 	tnz	(0x01, sp)
      0083CF 27 03            [ 1]  176 	jreq	00104$
      0083D1                        177 00118$:
                                    178 ;	main.c: 29: nop();
      0083D1 9D               [ 1]  179 	nop
      0083D2 20 DF            [ 2]  180 	jra	00101$
      0083D4                        181 00104$:
                                    182 ;	main.c: 30: }
      0083D4 1E 09            [ 2]  183 	ldw	x, (9, sp)
      0083D6 5B 0E            [ 2]  184 	addw	sp, #14
      0083D8 FC               [ 2]  185 	jp	(x)
                                    186 ;	main.c: 38: void UART_TX(unsigned char value)
                                    187 ;	-----------------------------------------
                                    188 ;	 function UART_TX
                                    189 ;	-----------------------------------------
      0083D9                        190 _UART_TX:
                                    191 ;	main.c: 40: UART1_DR = value;
      0083D9 C7 52 31         [ 1]  192 	ld	0x5231, a
                                    193 ;	main.c: 41: while(!(UART1_SR & UART_SR_TXE));
      0083DC                        194 00101$:
      0083DC C6 52 30         [ 1]  195 	ld	a, 0x5230
      0083DF 2A FB            [ 1]  196 	jrpl	00101$
                                    197 ;	main.c: 42: }
      0083E1 81               [ 4]  198 	ret
                                    199 ;	main.c: 44: int uart_write(const char *str) {
                                    200 ;	-----------------------------------------
                                    201 ;	 function uart_write
                                    202 ;	-----------------------------------------
      0083E2                        203 _uart_write:
      0083E2 52 05            [ 2]  204 	sub	sp, #5
      0083E4 1F 03            [ 2]  205 	ldw	(0x03, sp), x
                                    206 ;	main.c: 46: for(i = 0; i < strlen(str); i++) {
      0083E6 0F 05            [ 1]  207 	clr	(0x05, sp)
      0083E8                        208 00103$:
      0083E8 1E 03            [ 2]  209 	ldw	x, (0x03, sp)
      0083EA CD 8C 1E         [ 4]  210 	call	_strlen
      0083ED 1F 01            [ 2]  211 	ldw	(0x01, sp), x
      0083EF 7B 05            [ 1]  212 	ld	a, (0x05, sp)
      0083F1 5F               [ 1]  213 	clrw	x
      0083F2 97               [ 1]  214 	ld	xl, a
      0083F3 13 01            [ 2]  215 	cpw	x, (0x01, sp)
      0083F5 24 0F            [ 1]  216 	jrnc	00101$
                                    217 ;	main.c: 48: UART_TX(str[i]);
      0083F7 5F               [ 1]  218 	clrw	x
      0083F8 7B 05            [ 1]  219 	ld	a, (0x05, sp)
      0083FA 97               [ 1]  220 	ld	xl, a
      0083FB 72 FB 03         [ 2]  221 	addw	x, (0x03, sp)
      0083FE F6               [ 1]  222 	ld	a, (x)
      0083FF CD 83 D9         [ 4]  223 	call	_UART_TX
                                    224 ;	main.c: 46: for(i = 0; i < strlen(str); i++) {
      008402 0C 05            [ 1]  225 	inc	(0x05, sp)
      008404 20 E2            [ 2]  226 	jra	00103$
      008406                        227 00101$:
                                    228 ;	main.c: 51: return(i); // Bytes sent
      008406 7B 05            [ 1]  229 	ld	a, (0x05, sp)
      008408 5F               [ 1]  230 	clrw	x
      008409 97               [ 1]  231 	ld	xl, a
                                    232 ;	main.c: 52: }
      00840A 5B 05            [ 2]  233 	addw	sp, #5
      00840C 81               [ 4]  234 	ret
                                    235 ;	main.c: 53: unsigned char UART_RX(void)
                                    236 ;	-----------------------------------------
                                    237 ;	 function UART_RX
                                    238 ;	-----------------------------------------
      00840D                        239 _UART_RX:
                                    240 ;	main.c: 56: while(!(UART1_SR & UART_SR_TXE));
      00840D                        241 00101$:
      00840D C6 52 30         [ 1]  242 	ld	a, 0x5230
      008410 2A FB            [ 1]  243 	jrpl	00101$
                                    244 ;	main.c: 58: return UART1_DR;
      008412 C6 52 31         [ 1]  245 	ld	a, 0x5231
                                    246 ;	main.c: 59: }
      008415 81               [ 4]  247 	ret
                                    248 ;	main.c: 60: int uart_read(void)
                                    249 ;	-----------------------------------------
                                    250 ;	 function uart_read
                                    251 ;	-----------------------------------------
      008416                        252 _uart_read:
                                    253 ;	main.c: 63: memset(buffer, 0, sizeof(buffer));
      008416 4B 00            [ 1]  254 	push	#0x00
      008418 4B 01            [ 1]  255 	push	#0x01
      00841A 5F               [ 1]  256 	clrw	x
      00841B 89               [ 2]  257 	pushw	x
      00841C AE 01 01         [ 2]  258 	ldw	x, #(_buffer+0)
      00841F CD 8B FA         [ 4]  259 	call	_memset
                                    260 ;	main.c: 66: while(i<256)
      008422 5F               [ 1]  261 	clrw	x
      008423                        262 00105$:
      008423 A3 01 00         [ 2]  263 	cpw	x, #0x0100
      008426 2E 22            [ 1]  264 	jrsge	00107$
                                    265 ;	main.c: 69: if(UART1_SR & UART_SR_RXNE)
      008428 C6 52 30         [ 1]  266 	ld	a, 0x5230
      00842B A5 20            [ 1]  267 	bcp	a, #0x20
      00842D 27 F4            [ 1]  268 	jreq	00105$
                                    269 ;	main.c: 72: buffer[i] = UART_RX();
      00842F 90 93            [ 1]  270 	ldw	y, x
      008431 72 A9 01 01      [ 2]  271 	addw	y, #(_buffer+0)
      008435 89               [ 2]  272 	pushw	x
      008436 90 89            [ 2]  273 	pushw	y
      008438 CD 84 0D         [ 4]  274 	call	_UART_RX
      00843B 90 85            [ 2]  275 	popw	y
      00843D 85               [ 2]  276 	popw	x
      00843E 90 F7            [ 1]  277 	ld	(y), a
                                    278 ;	main.c: 73: if(buffer[i] == '\r\n' )
      008440 A1 0D            [ 1]  279 	cp	a, #0x0d
      008442 26 03            [ 1]  280 	jrne	00102$
                                    281 ;	main.c: 75: return 1;
      008444 5F               [ 1]  282 	clrw	x
      008445 5C               [ 1]  283 	incw	x
      008446 81               [ 4]  284 	ret
                                    285 ;	main.c: 76: break;
      008447                        286 00102$:
                                    287 ;	main.c: 78: i++;
      008447 5C               [ 1]  288 	incw	x
      008448 20 D9            [ 2]  289 	jra	00105$
      00844A                        290 00107$:
                                    291 ;	main.c: 82: return 0;
      00844A 5F               [ 1]  292 	clrw	x
                                    293 ;	main.c: 83: }
      00844B 81               [ 4]  294 	ret
                                    295 ;	main.c: 92: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    296 ;	-----------------------------------------
                                    297 ;	 function convert_int_to_chars
                                    298 ;	-----------------------------------------
      00844C                        299 _convert_int_to_chars:
      00844C 52 0D            [ 2]  300 	sub	sp, #13
      00844E 6B 0D            [ 1]  301 	ld	(0x0d, sp), a
      008450 1F 0B            [ 2]  302 	ldw	(0x0b, sp), x
                                    303 ;	main.c: 95: rx_int_chars[0] = num / 100 + '0';
      008452 7B 0D            [ 1]  304 	ld	a, (0x0d, sp)
      008454 6B 02            [ 1]  305 	ld	(0x02, sp), a
      008456 0F 01            [ 1]  306 	clr	(0x01, sp)
                                    307 ;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
      008458 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      00845A 5C               [ 1]  309 	incw	x
      00845B 1F 03            [ 2]  310 	ldw	(0x03, sp), x
                                    311 ;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
      00845D 1E 0B            [ 2]  312 	ldw	x, (0x0b, sp)
      00845F 5C               [ 1]  313 	incw	x
      008460 5C               [ 1]  314 	incw	x
      008461 1F 05            [ 2]  315 	ldw	(0x05, sp), x
                                    316 ;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
      008463 4B 0A            [ 1]  317 	push	#0x0a
      008465 4B 00            [ 1]  318 	push	#0x00
      008467 1E 03            [ 2]  319 	ldw	x, (0x03, sp)
                                    320 ;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
      008469 CD 8C 43         [ 4]  321 	call	__divsint
      00846C 1F 07            [ 2]  322 	ldw	(0x07, sp), x
      00846E 4B 0A            [ 1]  323 	push	#0x0a
      008470 4B 00            [ 1]  324 	push	#0x00
      008472 1E 03            [ 2]  325 	ldw	x, (0x03, sp)
      008474 CD 8C 2B         [ 4]  326 	call	__modsint
      008477 9F               [ 1]  327 	ld	a, xl
      008478 AB 30            [ 1]  328 	add	a, #0x30
      00847A 6B 09            [ 1]  329 	ld	(0x09, sp), a
                                    330 ;	main.c: 93: if (num > 99) {
      00847C 7B 0D            [ 1]  331 	ld	a, (0x0d, sp)
      00847E A1 63            [ 1]  332 	cp	a, #0x63
      008480 23 29            [ 2]  333 	jrule	00105$
                                    334 ;	main.c: 95: rx_int_chars[0] = num / 100 + '0';
      008482 4B 64            [ 1]  335 	push	#0x64
      008484 4B 00            [ 1]  336 	push	#0x00
      008486 1E 03            [ 2]  337 	ldw	x, (0x03, sp)
      008488 CD 8C 43         [ 4]  338 	call	__divsint
      00848B 9F               [ 1]  339 	ld	a, xl
      00848C AB 30            [ 1]  340 	add	a, #0x30
      00848E 1E 0B            [ 2]  341 	ldw	x, (0x0b, sp)
      008490 F7               [ 1]  342 	ld	(x), a
                                    343 ;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
      008491 4B 0A            [ 1]  344 	push	#0x0a
      008493 4B 00            [ 1]  345 	push	#0x00
      008495 1E 09            [ 2]  346 	ldw	x, (0x09, sp)
      008497 CD 8C 2B         [ 4]  347 	call	__modsint
      00849A 9F               [ 1]  348 	ld	a, xl
      00849B AB 30            [ 1]  349 	add	a, #0x30
      00849D 1E 03            [ 2]  350 	ldw	x, (0x03, sp)
      00849F F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
      0084A0 1E 05            [ 2]  353 	ldw	x, (0x05, sp)
      0084A2 7B 09            [ 1]  354 	ld	a, (0x09, sp)
      0084A4 F7               [ 1]  355 	ld	(x), a
                                    356 ;	main.c: 98: rx_int_chars[3] ='\0';
      0084A5 1E 0B            [ 2]  357 	ldw	x, (0x0b, sp)
      0084A7 6F 03            [ 1]  358 	clr	(0x0003, x)
      0084A9 20 23            [ 2]  359 	jra	00107$
      0084AB                        360 00105$:
                                    361 ;	main.c: 100: } else if (num > 9) {
      0084AB 7B 0D            [ 1]  362 	ld	a, (0x0d, sp)
      0084AD A1 09            [ 1]  363 	cp	a, #0x09
      0084AF 23 13            [ 2]  364 	jrule	00102$
                                    365 ;	main.c: 102: rx_int_chars[0] = num / 10 + '0';
      0084B1 7B 08            [ 1]  366 	ld	a, (0x08, sp)
      0084B3 6B 0A            [ 1]  367 	ld	(0x0a, sp), a
      0084B5 AB 30            [ 1]  368 	add	a, #0x30
      0084B7 1E 0B            [ 2]  369 	ldw	x, (0x0b, sp)
      0084B9 F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 103: rx_int_chars[1] = num % 10 + '0';
      0084BA 1E 03            [ 2]  372 	ldw	x, (0x03, sp)
      0084BC 7B 09            [ 1]  373 	ld	a, (0x09, sp)
      0084BE F7               [ 1]  374 	ld	(x), a
                                    375 ;	main.c: 104: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      0084BF 1E 05            [ 2]  376 	ldw	x, (0x05, sp)
      0084C1 7F               [ 1]  377 	clr	(x)
      0084C2 20 0A            [ 2]  378 	jra	00107$
      0084C4                        379 00102$:
                                    380 ;	main.c: 107: rx_int_chars[0] = num + '0';
      0084C4 7B 0D            [ 1]  381 	ld	a, (0x0d, sp)
      0084C6 AB 30            [ 1]  382 	add	a, #0x30
      0084C8 1E 0B            [ 2]  383 	ldw	x, (0x0b, sp)
      0084CA F7               [ 1]  384 	ld	(x), a
                                    385 ;	main.c: 108: rx_int_chars[1] ='\0';
      0084CB 1E 03            [ 2]  386 	ldw	x, (0x03, sp)
      0084CD 7F               [ 1]  387 	clr	(x)
      0084CE                        388 00107$:
                                    389 ;	main.c: 110: }
      0084CE 5B 0D            [ 2]  390 	addw	sp, #13
      0084D0 81               [ 4]  391 	ret
                                    392 ;	main.c: 112: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    393 ;	-----------------------------------------
                                    394 ;	 function convert_chars_to_int
                                    395 ;	-----------------------------------------
      0084D1                        396 _convert_chars_to_int:
      0084D1 52 03            [ 2]  397 	sub	sp, #3
      0084D3 1F 02            [ 2]  398 	ldw	(0x02, sp), x
                                    399 ;	main.c: 113: uint8_t result = 0;
      0084D5 4F               [ 1]  400 	clr	a
                                    401 ;	main.c: 115: for (int o = 0; o < i; o++) {
      0084D6 5F               [ 1]  402 	clrw	x
      0084D7                        403 00103$:
      0084D7 13 06            [ 2]  404 	cpw	x, (0x06, sp)
      0084D9 2E 18            [ 1]  405 	jrsge	00101$
                                    406 ;	main.c: 117: result = (result * 10) + (rx_chars_int[o] - '0');
      0084DB 90 97            [ 1]  407 	ld	yl, a
      0084DD A6 0A            [ 1]  408 	ld	a, #0x0a
      0084DF 90 42            [ 4]  409 	mul	y, a
      0084E1 61               [ 1]  410 	exg	a, yl
      0084E2 6B 01            [ 1]  411 	ld	(0x01, sp), a
      0084E4 61               [ 1]  412 	exg	a, yl
      0084E5 90 93            [ 1]  413 	ldw	y, x
      0084E7 72 F9 02         [ 2]  414 	addw	y, (0x02, sp)
      0084EA 90 F6            [ 1]  415 	ld	a, (y)
      0084EC A0 30            [ 1]  416 	sub	a, #0x30
      0084EE 1B 01            [ 1]  417 	add	a, (0x01, sp)
                                    418 ;	main.c: 115: for (int o = 0; o < i; o++) {
      0084F0 5C               [ 1]  419 	incw	x
      0084F1 20 E4            [ 2]  420 	jra	00103$
      0084F3                        421 00101$:
                                    422 ;	main.c: 120: return result;
                                    423 ;	main.c: 121: }
      0084F3 1E 04            [ 2]  424 	ldw	x, (4, sp)
      0084F5 5B 07            [ 2]  425 	addw	sp, #7
      0084F7 FC               [ 2]  426 	jp	(x)
                                    427 ;	main.c: 124: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    428 ;	-----------------------------------------
                                    429 ;	 function convert_int_to_binary
                                    430 ;	-----------------------------------------
      0084F8                        431 _convert_int_to_binary:
      0084F8 52 04            [ 2]  432 	sub	sp, #4
      0084FA 1F 01            [ 2]  433 	ldw	(0x01, sp), x
                                    434 ;	main.c: 126: for(int i = 7; i >= 0; i--) {
      0084FC AE 00 07         [ 2]  435 	ldw	x, #0x0007
      0084FF 1F 03            [ 2]  436 	ldw	(0x03, sp), x
      008501                        437 00103$:
      008501 0D 03            [ 1]  438 	tnz	(0x03, sp)
      008503 2B 22            [ 1]  439 	jrmi	00101$
                                    440 ;	main.c: 128: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008505 AE 00 07         [ 2]  441 	ldw	x, #0x0007
      008508 72 F0 03         [ 2]  442 	subw	x, (0x03, sp)
      00850B 72 FB 07         [ 2]  443 	addw	x, (0x07, sp)
      00850E 16 01            [ 2]  444 	ldw	y, (0x01, sp)
      008510 7B 04            [ 1]  445 	ld	a, (0x04, sp)
      008512 27 05            [ 1]  446 	jreq	00120$
      008514                        447 00119$:
      008514 90 57            [ 2]  448 	sraw	y
      008516 4A               [ 1]  449 	dec	a
      008517 26 FB            [ 1]  450 	jrne	00119$
      008519                        451 00120$:
      008519 90 9F            [ 1]  452 	ld	a, yl
      00851B A4 01            [ 1]  453 	and	a, #0x01
      00851D AB 30            [ 1]  454 	add	a, #0x30
      00851F F7               [ 1]  455 	ld	(x), a
                                    456 ;	main.c: 126: for(int i = 7; i >= 0; i--) {
      008520 1E 03            [ 2]  457 	ldw	x, (0x03, sp)
      008522 5A               [ 2]  458 	decw	x
      008523 1F 03            [ 2]  459 	ldw	(0x03, sp), x
      008525 20 DA            [ 2]  460 	jra	00103$
      008527                        461 00101$:
                                    462 ;	main.c: 130: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008527 1E 07            [ 2]  463 	ldw	x, (0x07, sp)
      008529 6F 08            [ 1]  464 	clr	(0x0008, x)
                                    465 ;	main.c: 131: }
      00852B 1E 05            [ 2]  466 	ldw	x, (5, sp)
      00852D 5B 08            [ 2]  467 	addw	sp, #8
      00852F FC               [ 2]  468 	jp	(x)
                                    469 ;	main.c: 140: void get_addr_from_buff(void)
                                    470 ;	-----------------------------------------
                                    471 ;	 function get_addr_from_buff
                                    472 ;	-----------------------------------------
      008530                        473 _get_addr_from_buff:
      008530 52 02            [ 2]  474 	sub	sp, #2
                                    475 ;	main.c: 144: while(1)
      008532 A6 03            [ 1]  476 	ld	a, #0x03
      008534 6B 01            [ 1]  477 	ld	(0x01, sp), a
      008536 0F 02            [ 1]  478 	clr	(0x02, sp)
      008538                        479 00105$:
                                    480 ;	main.c: 146: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008538 5F               [ 1]  481 	clrw	x
      008539 7B 01            [ 1]  482 	ld	a, (0x01, sp)
      00853B 97               [ 1]  483 	ld	xl, a
      00853C D6 01 01         [ 1]  484 	ld	a, (_buffer+0, x)
      00853F A1 20            [ 1]  485 	cp	a, #0x20
      008541 27 04            [ 1]  486 	jreq	00101$
      008543 A1 0D            [ 1]  487 	cp	a, #0x0d
      008545 26 08            [ 1]  488 	jrne	00102$
      008547                        489 00101$:
                                    490 ;	main.c: 148: p_size = i+1;
      008547 7B 01            [ 1]  491 	ld	a, (0x01, sp)
      008549 4C               [ 1]  492 	inc	a
      00854A C7 02 05         [ 1]  493 	ld	_p_size+0, a
                                    494 ;	main.c: 149: break;
      00854D 20 06            [ 2]  495 	jra	00106$
      00854F                        496 00102$:
                                    497 ;	main.c: 151: i++;
      00854F 0C 01            [ 1]  498 	inc	(0x01, sp)
                                    499 ;	main.c: 152: counter++;
      008551 0C 02            [ 1]  500 	inc	(0x02, sp)
      008553 20 E3            [ 2]  501 	jra	00105$
      008555                        502 00106$:
                                    503 ;	main.c: 154: memcpy(a, &buffer[3], counter);
      008555 5F               [ 1]  504 	clrw	x
      008556 7B 02            [ 1]  505 	ld	a, (0x02, sp)
      008558 97               [ 1]  506 	ld	xl, a
      008559 89               [ 2]  507 	pushw	x
      00855A 4B 04            [ 1]  508 	push	#<(_buffer+3)
      00855C 4B 01            [ 1]  509 	push	#((_buffer+3) >> 8)
      00855E AE 02 01         [ 2]  510 	ldw	x, #(_a+0)
      008561 CD 8B A7         [ 4]  511 	call	___memcpy
                                    512 ;	main.c: 155: d_addr = convert_chars_to_int(a, counter);
      008564 5F               [ 1]  513 	clrw	x
      008565 7B 02            [ 1]  514 	ld	a, (0x02, sp)
      008567 97               [ 1]  515 	ld	xl, a
      008568 89               [ 2]  516 	pushw	x
      008569 AE 02 01         [ 2]  517 	ldw	x, #(_a+0)
      00856C CD 84 D1         [ 4]  518 	call	_convert_chars_to_int
      00856F C7 02 04         [ 1]  519 	ld	_d_addr+0, a
                                    520 ;	main.c: 156: }
      008572 5B 02            [ 2]  521 	addw	sp, #2
      008574 81               [ 4]  522 	ret
                                    523 ;	main.c: 158: void get_size_from_buff(void)
                                    524 ;	-----------------------------------------
                                    525 ;	 function get_size_from_buff
                                    526 ;	-----------------------------------------
      008575                        527 _get_size_from_buff:
      008575 52 02            [ 2]  528 	sub	sp, #2
                                    529 ;	main.c: 160: memset(a, 0, sizeof(a));
      008577 4B 03            [ 1]  530 	push	#0x03
      008579 4B 00            [ 1]  531 	push	#0x00
      00857B 5F               [ 1]  532 	clrw	x
      00857C 89               [ 2]  533 	pushw	x
      00857D AE 02 01         [ 2]  534 	ldw	x, #(_a+0)
      008580 CD 8B FA         [ 4]  535 	call	_memset
                                    536 ;	main.c: 162: uint8_t i = p_size;
      008583 C6 02 05         [ 1]  537 	ld	a, _p_size+0
      008586 6B 01            [ 1]  538 	ld	(0x01, sp), a
                                    539 ;	main.c: 163: while(1)
      008588 0F 02            [ 1]  540 	clr	(0x02, sp)
      00858A                        541 00105$:
                                    542 ;	main.c: 165: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      00858A 5F               [ 1]  543 	clrw	x
      00858B 7B 01            [ 1]  544 	ld	a, (0x01, sp)
      00858D 97               [ 1]  545 	ld	xl, a
      00858E D6 01 01         [ 1]  546 	ld	a, (_buffer+0, x)
      008591 A1 20            [ 1]  547 	cp	a, #0x20
      008593 27 04            [ 1]  548 	jreq	00101$
      008595 A1 0D            [ 1]  549 	cp	a, #0x0d
      008597 26 08            [ 1]  550 	jrne	00102$
      008599                        551 00101$:
                                    552 ;	main.c: 168: p_bytes = i+1;
      008599 7B 01            [ 1]  553 	ld	a, (0x01, sp)
      00859B 4C               [ 1]  554 	inc	a
      00859C C7 02 07         [ 1]  555 	ld	_p_bytes+0, a
                                    556 ;	main.c: 169: break;
      00859F 20 06            [ 2]  557 	jra	00106$
      0085A1                        558 00102$:
                                    559 ;	main.c: 171: i++;
      0085A1 0C 01            [ 1]  560 	inc	(0x01, sp)
                                    561 ;	main.c: 172: counter++;
      0085A3 0C 02            [ 1]  562 	inc	(0x02, sp)
      0085A5 20 E3            [ 2]  563 	jra	00105$
      0085A7                        564 00106$:
                                    565 ;	main.c: 175: memcpy(a, &buffer[p_size], counter);
      0085A7 90 5F            [ 1]  566 	clrw	y
      0085A9 7B 02            [ 1]  567 	ld	a, (0x02, sp)
      0085AB 90 97            [ 1]  568 	ld	yl, a
      0085AD 5F               [ 1]  569 	clrw	x
      0085AE C6 02 05         [ 1]  570 	ld	a, _p_size+0
      0085B1 97               [ 1]  571 	ld	xl, a
      0085B2 1C 01 01         [ 2]  572 	addw	x, #(_buffer+0)
      0085B5 90 89            [ 2]  573 	pushw	y
      0085B7 89               [ 2]  574 	pushw	x
      0085B8 AE 02 01         [ 2]  575 	ldw	x, #(_a+0)
      0085BB CD 8B A7         [ 4]  576 	call	___memcpy
                                    577 ;	main.c: 176: d_size = convert_chars_to_int(a, counter);
      0085BE 5F               [ 1]  578 	clrw	x
      0085BF 7B 02            [ 1]  579 	ld	a, (0x02, sp)
      0085C1 97               [ 1]  580 	ld	xl, a
      0085C2 89               [ 2]  581 	pushw	x
      0085C3 AE 02 01         [ 2]  582 	ldw	x, #(_a+0)
      0085C6 CD 84 D1         [ 4]  583 	call	_convert_chars_to_int
      0085C9 C7 02 06         [ 1]  584 	ld	_d_size+0, a
                                    585 ;	main.c: 177: }
      0085CC 5B 02            [ 2]  586 	addw	sp, #2
      0085CE 81               [ 4]  587 	ret
                                    588 ;	main.c: 178: void char_buffer_to_int(void)
                                    589 ;	-----------------------------------------
                                    590 ;	 function char_buffer_to_int
                                    591 ;	-----------------------------------------
      0085CF                        592 _char_buffer_to_int:
      0085CF 52 08            [ 2]  593 	sub	sp, #8
                                    594 ;	main.c: 180: memset(a, 0, sizeof(a));
      0085D1 4B 03            [ 1]  595 	push	#0x03
      0085D3 4B 00            [ 1]  596 	push	#0x00
      0085D5 5F               [ 1]  597 	clrw	x
      0085D6 89               [ 2]  598 	pushw	x
      0085D7 AE 02 01         [ 2]  599 	ldw	x, #(_a+0)
      0085DA CD 8B FA         [ 4]  600 	call	_memset
                                    601 ;	main.c: 181: uint8_t counter = d_size;
      0085DD C6 02 06         [ 1]  602 	ld	a, _d_size+0
      0085E0 6B 01            [ 1]  603 	ld	(0x01, sp), a
                                    604 ;	main.c: 182: uint8_t i = p_bytes;
      0085E2 C6 02 07         [ 1]  605 	ld	a, _p_bytes+0
      0085E5 6B 03            [ 1]  606 	ld	(0x03, sp), a
                                    607 ;	main.c: 185: for(int o = 0; o < counter;o++)
      0085E7 0F 04            [ 1]  608 	clr	(0x04, sp)
      0085E9 5F               [ 1]  609 	clrw	x
      0085EA 1F 05            [ 2]  610 	ldw	(0x05, sp), x
      0085EC                        611 00112$:
      0085EC 7B 01            [ 1]  612 	ld	a, (0x01, sp)
      0085EE 6B 08            [ 1]  613 	ld	(0x08, sp), a
      0085F0 0F 07            [ 1]  614 	clr	(0x07, sp)
      0085F2 1E 05            [ 2]  615 	ldw	x, (0x05, sp)
      0085F4 13 07            [ 2]  616 	cpw	x, (0x07, sp)
      0085F6 2E 65            [ 1]  617 	jrsge	00114$
                                    618 ;	main.c: 187: uint8_t number_counter = 0;
      0085F8 0F 02            [ 1]  619 	clr	(0x02, sp)
                                    620 ;	main.c: 188: while(1)
      0085FA 7B 03            [ 1]  621 	ld	a, (0x03, sp)
      0085FC 6B 07            [ 1]  622 	ld	(0x07, sp), a
      0085FE 0F 08            [ 1]  623 	clr	(0x08, sp)
      008600                        624 00108$:
                                    625 ;	main.c: 190: if(buffer[i] == ' ')
      008600 5F               [ 1]  626 	clrw	x
      008601 7B 07            [ 1]  627 	ld	a, (0x07, sp)
      008603 97               [ 1]  628 	ld	xl, a
      008604 D6 01 01         [ 1]  629 	ld	a, (_buffer+0, x)
      008607 A1 20            [ 1]  630 	cp	a, #0x20
      008609 26 04            [ 1]  631 	jrne	00105$
                                    632 ;	main.c: 192: i++;
      00860B 0C 03            [ 1]  633 	inc	(0x03, sp)
                                    634 ;	main.c: 193: break;
      00860D 20 12            [ 2]  635 	jra	00109$
      00860F                        636 00105$:
                                    637 ;	main.c: 195: else if(buffer[i] == '\r\n')
      00860F A1 0D            [ 1]  638 	cp	a, #0x0d
      008611 27 0E            [ 1]  639 	jreq	00109$
                                    640 ;	main.c: 198: i++;
      008613 0C 07            [ 1]  641 	inc	(0x07, sp)
      008615 7B 07            [ 1]  642 	ld	a, (0x07, sp)
      008617 6B 03            [ 1]  643 	ld	(0x03, sp), a
                                    644 ;	main.c: 200: number_counter++;
      008619 0C 08            [ 1]  645 	inc	(0x08, sp)
      00861B 7B 08            [ 1]  646 	ld	a, (0x08, sp)
      00861D 6B 02            [ 1]  647 	ld	(0x02, sp), a
      00861F 20 DF            [ 2]  648 	jra	00108$
      008621                        649 00109$:
                                    650 ;	main.c: 202: memcpy(a, &buffer[i - number_counter], number_counter);
      008621 90 5F            [ 1]  651 	clrw	y
      008623 7B 02            [ 1]  652 	ld	a, (0x02, sp)
      008625 90 97            [ 1]  653 	ld	yl, a
      008627 5F               [ 1]  654 	clrw	x
      008628 7B 03            [ 1]  655 	ld	a, (0x03, sp)
      00862A 97               [ 1]  656 	ld	xl, a
      00862B 7B 02            [ 1]  657 	ld	a, (0x02, sp)
      00862D 6B 08            [ 1]  658 	ld	(0x08, sp), a
      00862F 0F 07            [ 1]  659 	clr	(0x07, sp)
      008631 72 F0 07         [ 2]  660 	subw	x, (0x07, sp)
      008634 1C 01 01         [ 2]  661 	addw	x, #(_buffer+0)
      008637 90 89            [ 2]  662 	pushw	y
      008639 89               [ 2]  663 	pushw	x
      00863A AE 02 01         [ 2]  664 	ldw	x, #(_a+0)
      00863D CD 8B A7         [ 4]  665 	call	___memcpy
                                    666 ;	main.c: 203: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      008640 5F               [ 1]  667 	clrw	x
      008641 7B 04            [ 1]  668 	ld	a, (0x04, sp)
      008643 97               [ 1]  669 	ld	xl, a
      008644 1C 02 08         [ 2]  670 	addw	x, #(_data_buf+0)
      008647 89               [ 2]  671 	pushw	x
      008648 16 09            [ 2]  672 	ldw	y, (0x09, sp)
      00864A 90 89            [ 2]  673 	pushw	y
      00864C AE 02 01         [ 2]  674 	ldw	x, #(_a+0)
      00864F CD 84 D1         [ 4]  675 	call	_convert_chars_to_int
      008652 85               [ 2]  676 	popw	x
      008653 F7               [ 1]  677 	ld	(x), a
                                    678 ;	main.c: 204: int_buf_i++;
      008654 0C 04            [ 1]  679 	inc	(0x04, sp)
                                    680 ;	main.c: 185: for(int o = 0; o < counter;o++)
      008656 1E 05            [ 2]  681 	ldw	x, (0x05, sp)
      008658 5C               [ 1]  682 	incw	x
      008659 1F 05            [ 2]  683 	ldw	(0x05, sp), x
      00865B 20 8F            [ 2]  684 	jra	00112$
      00865D                        685 00114$:
                                    686 ;	main.c: 206: }
      00865D 5B 08            [ 2]  687 	addw	sp, #8
      00865F 81               [ 4]  688 	ret
                                    689 ;	main.c: 214: void reg_check(void)
                                    690 ;	-----------------------------------------
                                    691 ;	 function reg_check
                                    692 ;	-----------------------------------------
      008660                        693 _reg_check:
      008660 52 09            [ 2]  694 	sub	sp, #9
                                    695 ;	main.c: 216: char rx_binary_chars[9]={0};
      008662 0F 01            [ 1]  696 	clr	(0x01, sp)
      008664 0F 02            [ 1]  697 	clr	(0x02, sp)
      008666 0F 03            [ 1]  698 	clr	(0x03, sp)
      008668 0F 04            [ 1]  699 	clr	(0x04, sp)
      00866A 0F 05            [ 1]  700 	clr	(0x05, sp)
      00866C 0F 06            [ 1]  701 	clr	(0x06, sp)
      00866E 0F 07            [ 1]  702 	clr	(0x07, sp)
      008670 0F 08            [ 1]  703 	clr	(0x08, sp)
      008672 0F 09            [ 1]  704 	clr	(0x09, sp)
                                    705 ;	main.c: 217: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      008674 96               [ 1]  706 	ldw	x, sp
      008675 5C               [ 1]  707 	incw	x
      008676 51               [ 1]  708 	exgw	x, y
      008677 C6 52 17         [ 1]  709 	ld	a, 0x5217
      00867A 5F               [ 1]  710 	clrw	x
      00867B 90 89            [ 2]  711 	pushw	y
      00867D 97               [ 1]  712 	ld	xl, a
      00867E CD 84 F8         [ 4]  713 	call	_convert_int_to_binary
                                    714 ;	main.c: 218: status_registers[0] = I2C_SR1;
      008681 55 52 17 00 01   [ 1]  715 	mov	_status_registers+0, 0x5217
                                    716 ;	main.c: 219: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008686 96               [ 1]  717 	ldw	x, sp
      008687 5C               [ 1]  718 	incw	x
      008688 51               [ 1]  719 	exgw	x, y
      008689 C6 52 18         [ 1]  720 	ld	a, 0x5218
      00868C 5F               [ 1]  721 	clrw	x
      00868D 90 89            [ 2]  722 	pushw	y
      00868F 97               [ 1]  723 	ld	xl, a
      008690 CD 84 F8         [ 4]  724 	call	_convert_int_to_binary
                                    725 ;	main.c: 220: status_registers[1] = I2C_SR2;
      008693 55 52 18 00 02   [ 1]  726 	mov	_status_registers+1, 0x5218
                                    727 ;	main.c: 221: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008698 96               [ 1]  728 	ldw	x, sp
      008699 5C               [ 1]  729 	incw	x
      00869A 51               [ 1]  730 	exgw	x, y
      00869B C6 52 19         [ 1]  731 	ld	a, 0x5219
      00869E 5F               [ 1]  732 	clrw	x
      00869F 90 89            [ 2]  733 	pushw	y
      0086A1 97               [ 1]  734 	ld	xl, a
      0086A2 CD 84 F8         [ 4]  735 	call	_convert_int_to_binary
                                    736 ;	main.c: 222: status_registers[2] = I2C_SR3;
      0086A5 55 52 19 00 03   [ 1]  737 	mov	_status_registers+2, 0x5219
                                    738 ;	main.c: 223: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      0086AA 96               [ 1]  739 	ldw	x, sp
      0086AB 5C               [ 1]  740 	incw	x
      0086AC 51               [ 1]  741 	exgw	x, y
      0086AD C6 52 10         [ 1]  742 	ld	a, 0x5210
      0086B0 5F               [ 1]  743 	clrw	x
      0086B1 90 89            [ 2]  744 	pushw	y
      0086B3 97               [ 1]  745 	ld	xl, a
      0086B4 CD 84 F8         [ 4]  746 	call	_convert_int_to_binary
                                    747 ;	main.c: 224: status_registers[3] = I2C_CR1;
      0086B7 55 52 10 00 04   [ 1]  748 	mov	_status_registers+3, 0x5210
                                    749 ;	main.c: 225: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      0086BC 96               [ 1]  750 	ldw	x, sp
      0086BD 5C               [ 1]  751 	incw	x
      0086BE 51               [ 1]  752 	exgw	x, y
      0086BF C6 52 11         [ 1]  753 	ld	a, 0x5211
      0086C2 5F               [ 1]  754 	clrw	x
      0086C3 90 89            [ 2]  755 	pushw	y
      0086C5 97               [ 1]  756 	ld	xl, a
      0086C6 CD 84 F8         [ 4]  757 	call	_convert_int_to_binary
                                    758 ;	main.c: 226: status_registers[4] = I2C_CR2;
      0086C9 55 52 11 00 05   [ 1]  759 	mov	_status_registers+4, 0x5211
                                    760 ;	main.c: 227: convert_int_to_binary(I2C_DR, rx_binary_chars);
      0086CE 96               [ 1]  761 	ldw	x, sp
      0086CF 5C               [ 1]  762 	incw	x
      0086D0 51               [ 1]  763 	exgw	x, y
      0086D1 C6 52 16         [ 1]  764 	ld	a, 0x5216
      0086D4 5F               [ 1]  765 	clrw	x
      0086D5 90 89            [ 2]  766 	pushw	y
      0086D7 97               [ 1]  767 	ld	xl, a
      0086D8 CD 84 F8         [ 4]  768 	call	_convert_int_to_binary
                                    769 ;	main.c: 228: status_registers[5] = I2C_DR;
      0086DB 55 52 16 00 06   [ 1]  770 	mov	_status_registers+5, 0x5216
                                    771 ;	main.c: 229: }
      0086E0 5B 09            [ 2]  772 	addw	sp, #9
      0086E2 81               [ 4]  773 	ret
                                    774 ;	main.c: 232: void status_check(void){
                                    775 ;	-----------------------------------------
                                    776 ;	 function status_check
                                    777 ;	-----------------------------------------
      0086E3                        778 _status_check:
      0086E3 52 09            [ 2]  779 	sub	sp, #9
                                    780 ;	main.c: 233: char rx_binary_chars[9]={0};
      0086E5 0F 01            [ 1]  781 	clr	(0x01, sp)
      0086E7 0F 02            [ 1]  782 	clr	(0x02, sp)
      0086E9 0F 03            [ 1]  783 	clr	(0x03, sp)
      0086EB 0F 04            [ 1]  784 	clr	(0x04, sp)
      0086ED 0F 05            [ 1]  785 	clr	(0x05, sp)
      0086EF 0F 06            [ 1]  786 	clr	(0x06, sp)
      0086F1 0F 07            [ 1]  787 	clr	(0x07, sp)
      0086F3 0F 08            [ 1]  788 	clr	(0x08, sp)
      0086F5 0F 09            [ 1]  789 	clr	(0x09, sp)
                                    790 ;	main.c: 234: uart_write("\nI2C_REGS >.<\n");
      0086F7 AE 80 2D         [ 2]  791 	ldw	x, #(___str_0+0)
      0086FA CD 83 E2         [ 4]  792 	call	_uart_write
                                    793 ;	main.c: 235: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0086FD 96               [ 1]  794 	ldw	x, sp
      0086FE 5C               [ 1]  795 	incw	x
      0086FF 51               [ 1]  796 	exgw	x, y
      008700 C6 52 17         [ 1]  797 	ld	a, 0x5217
      008703 5F               [ 1]  798 	clrw	x
      008704 90 89            [ 2]  799 	pushw	y
      008706 97               [ 1]  800 	ld	xl, a
      008707 CD 84 F8         [ 4]  801 	call	_convert_int_to_binary
                                    802 ;	main.c: 236: uart_write("\nSR1 -> ");
      00870A AE 80 3C         [ 2]  803 	ldw	x, #(___str_1+0)
      00870D CD 83 E2         [ 4]  804 	call	_uart_write
                                    805 ;	main.c: 237: uart_write(rx_binary_chars);
      008710 96               [ 1]  806 	ldw	x, sp
      008711 5C               [ 1]  807 	incw	x
      008712 CD 83 E2         [ 4]  808 	call	_uart_write
                                    809 ;	main.c: 238: uart_write(" <-\n");
      008715 AE 80 45         [ 2]  810 	ldw	x, #(___str_2+0)
      008718 CD 83 E2         [ 4]  811 	call	_uart_write
                                    812 ;	main.c: 239: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      00871B 96               [ 1]  813 	ldw	x, sp
      00871C 5C               [ 1]  814 	incw	x
      00871D 51               [ 1]  815 	exgw	x, y
      00871E C6 52 18         [ 1]  816 	ld	a, 0x5218
      008721 5F               [ 1]  817 	clrw	x
      008722 90 89            [ 2]  818 	pushw	y
      008724 97               [ 1]  819 	ld	xl, a
      008725 CD 84 F8         [ 4]  820 	call	_convert_int_to_binary
                                    821 ;	main.c: 240: uart_write("SR2 -> ");
      008728 AE 80 4A         [ 2]  822 	ldw	x, #(___str_3+0)
      00872B CD 83 E2         [ 4]  823 	call	_uart_write
                                    824 ;	main.c: 241: uart_write(rx_binary_chars);
      00872E 96               [ 1]  825 	ldw	x, sp
      00872F 5C               [ 1]  826 	incw	x
      008730 CD 83 E2         [ 4]  827 	call	_uart_write
                                    828 ;	main.c: 242: uart_write(" <-\n");
      008733 AE 80 45         [ 2]  829 	ldw	x, #(___str_2+0)
      008736 CD 83 E2         [ 4]  830 	call	_uart_write
                                    831 ;	main.c: 243: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008739 96               [ 1]  832 	ldw	x, sp
      00873A 5C               [ 1]  833 	incw	x
      00873B 51               [ 1]  834 	exgw	x, y
      00873C C6 52 19         [ 1]  835 	ld	a, 0x5219
      00873F 5F               [ 1]  836 	clrw	x
      008740 90 89            [ 2]  837 	pushw	y
      008742 97               [ 1]  838 	ld	xl, a
      008743 CD 84 F8         [ 4]  839 	call	_convert_int_to_binary
                                    840 ;	main.c: 244: uart_write("SR3 -> ");
      008746 AE 80 52         [ 2]  841 	ldw	x, #(___str_4+0)
      008749 CD 83 E2         [ 4]  842 	call	_uart_write
                                    843 ;	main.c: 245: uart_write(rx_binary_chars);
      00874C 96               [ 1]  844 	ldw	x, sp
      00874D 5C               [ 1]  845 	incw	x
      00874E CD 83 E2         [ 4]  846 	call	_uart_write
                                    847 ;	main.c: 246: uart_write(" <-\n");
      008751 AE 80 45         [ 2]  848 	ldw	x, #(___str_2+0)
      008754 CD 83 E2         [ 4]  849 	call	_uart_write
                                    850 ;	main.c: 247: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      008757 96               [ 1]  851 	ldw	x, sp
      008758 5C               [ 1]  852 	incw	x
      008759 51               [ 1]  853 	exgw	x, y
      00875A C6 52 10         [ 1]  854 	ld	a, 0x5210
      00875D 5F               [ 1]  855 	clrw	x
      00875E 90 89            [ 2]  856 	pushw	y
      008760 97               [ 1]  857 	ld	xl, a
      008761 CD 84 F8         [ 4]  858 	call	_convert_int_to_binary
                                    859 ;	main.c: 248: uart_write("CR1 -> ");
      008764 AE 80 5A         [ 2]  860 	ldw	x, #(___str_5+0)
      008767 CD 83 E2         [ 4]  861 	call	_uart_write
                                    862 ;	main.c: 249: uart_write(rx_binary_chars);
      00876A 96               [ 1]  863 	ldw	x, sp
      00876B 5C               [ 1]  864 	incw	x
      00876C CD 83 E2         [ 4]  865 	call	_uart_write
                                    866 ;	main.c: 250: uart_write(" <-\n");
      00876F AE 80 45         [ 2]  867 	ldw	x, #(___str_2+0)
      008772 CD 83 E2         [ 4]  868 	call	_uart_write
                                    869 ;	main.c: 251: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008775 96               [ 1]  870 	ldw	x, sp
      008776 5C               [ 1]  871 	incw	x
      008777 51               [ 1]  872 	exgw	x, y
      008778 C6 52 11         [ 1]  873 	ld	a, 0x5211
      00877B 5F               [ 1]  874 	clrw	x
      00877C 90 89            [ 2]  875 	pushw	y
      00877E 97               [ 1]  876 	ld	xl, a
      00877F CD 84 F8         [ 4]  877 	call	_convert_int_to_binary
                                    878 ;	main.c: 252: uart_write("CR2 -> ");
      008782 AE 80 62         [ 2]  879 	ldw	x, #(___str_6+0)
      008785 CD 83 E2         [ 4]  880 	call	_uart_write
                                    881 ;	main.c: 253: uart_write(rx_binary_chars);
      008788 96               [ 1]  882 	ldw	x, sp
      008789 5C               [ 1]  883 	incw	x
      00878A CD 83 E2         [ 4]  884 	call	_uart_write
                                    885 ;	main.c: 254: uart_write(" <-\n");
      00878D AE 80 45         [ 2]  886 	ldw	x, #(___str_2+0)
      008790 CD 83 E2         [ 4]  887 	call	_uart_write
                                    888 ;	main.c: 255: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008793 96               [ 1]  889 	ldw	x, sp
      008794 5C               [ 1]  890 	incw	x
      008795 51               [ 1]  891 	exgw	x, y
      008796 C6 52 16         [ 1]  892 	ld	a, 0x5216
      008799 5F               [ 1]  893 	clrw	x
      00879A 90 89            [ 2]  894 	pushw	y
      00879C 97               [ 1]  895 	ld	xl, a
      00879D CD 84 F8         [ 4]  896 	call	_convert_int_to_binary
                                    897 ;	main.c: 256: uart_write("DR -> ");
      0087A0 AE 80 6A         [ 2]  898 	ldw	x, #(___str_7+0)
      0087A3 CD 83 E2         [ 4]  899 	call	_uart_write
                                    900 ;	main.c: 257: uart_write(rx_binary_chars);
      0087A6 96               [ 1]  901 	ldw	x, sp
      0087A7 5C               [ 1]  902 	incw	x
      0087A8 CD 83 E2         [ 4]  903 	call	_uart_write
                                    904 ;	main.c: 258: uart_write(" <-\n");
      0087AB AE 80 45         [ 2]  905 	ldw	x, #(___str_2+0)
      0087AE CD 83 E2         [ 4]  906 	call	_uart_write
                                    907 ;	main.c: 304: }
      0087B1 5B 09            [ 2]  908 	addw	sp, #9
      0087B3 81               [ 4]  909 	ret
                                    910 ;	main.c: 306: void uart_init(void){
                                    911 ;	-----------------------------------------
                                    912 ;	 function uart_init
                                    913 ;	-----------------------------------------
      0087B4                        914 _uart_init:
                                    915 ;	main.c: 307: CLK_CKDIVR = 0;
      0087B4 35 00 50 C6      [ 1]  916 	mov	0x50c6+0, #0x00
                                    917 ;	main.c: 310: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0087B8 72 16 52 35      [ 1]  918 	bset	0x5235, #3
                                    919 ;	main.c: 311: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      0087BC 72 14 52 35      [ 1]  920 	bset	0x5235, #2
                                    921 ;	main.c: 312: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0087C0 C6 52 36         [ 1]  922 	ld	a, 0x5236
      0087C3 A4 CF            [ 1]  923 	and	a, #0xcf
      0087C5 C7 52 36         [ 1]  924 	ld	0x5236, a
                                    925 ;	main.c: 314: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0087C8 35 03 52 33      [ 1]  926 	mov	0x5233+0, #0x03
      0087CC 35 68 52 32      [ 1]  927 	mov	0x5232+0, #0x68
                                    928 ;	main.c: 315: }
      0087D0 81               [ 4]  929 	ret
                                    930 ;	main.c: 319: void i2c_init(void) {
                                    931 ;	-----------------------------------------
                                    932 ;	 function i2c_init
                                    933 ;	-----------------------------------------
      0087D1                        934 _i2c_init:
                                    935 ;	main.c: 325: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      0087D1 72 11 52 10      [ 1]  936 	bres	0x5210, #0
                                    937 ;	main.c: 326: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      0087D5 35 10 52 12      [ 1]  938 	mov	0x5212+0, #0x10
                                    939 ;	main.c: 327: I2C_CCRH = 0;                   // =0
      0087D9 35 00 52 1C      [ 1]  940 	mov	0x521c+0, #0x00
                                    941 ;	main.c: 328: I2C_CCRL = 80;                  // 100kHz for I2C
      0087DD 35 50 52 1B      [ 1]  942 	mov	0x521b+0, #0x50
                                    943 ;	main.c: 329: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0087E1 72 1F 52 1C      [ 1]  944 	bres	0x521c, #7
                                    945 ;	main.c: 330: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0087E5 72 1F 52 14      [ 1]  946 	bres	0x5214, #7
                                    947 ;	main.c: 331: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0087E9 72 1C 52 14      [ 1]  948 	bset	0x5214, #6
                                    949 ;	main.c: 332: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0087ED 72 10 52 10      [ 1]  950 	bset	0x5210, #0
                                    951 ;	main.c: 333: }
      0087F1 81               [ 4]  952 	ret
                                    953 ;	main.c: 342: void i2c_start(void) {
                                    954 ;	-----------------------------------------
                                    955 ;	 function i2c_start
                                    956 ;	-----------------------------------------
      0087F2                        957 _i2c_start:
                                    958 ;	main.c: 343: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0087F2 72 10 52 11      [ 1]  959 	bset	0x5211, #0
                                    960 ;	main.c: 344: while(!(I2C_SR1 & (1 << 0)));
      0087F6                        961 00101$:
      0087F6 72 01 52 17 FB   [ 2]  962 	btjf	0x5217, #0, 00101$
                                    963 ;	main.c: 346: }
      0087FB 81               [ 4]  964 	ret
                                    965 ;	main.c: 348: void i2c_send_address(uint8_t address) {
                                    966 ;	-----------------------------------------
                                    967 ;	 function i2c_send_address
                                    968 ;	-----------------------------------------
      0087FC                        969 _i2c_send_address:
                                    970 ;	main.c: 349: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0087FC 48               [ 1]  971 	sll	a
      0087FD C7 52 16         [ 1]  972 	ld	0x5216, a
                                    973 ;	main.c: 350: reg_check();
      008800 CD 86 60         [ 4]  974 	call	_reg_check
                                    975 ;	main.c: 351: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008803                        976 00102$:
      008803 72 03 52 17 01   [ 2]  977 	btjf	0x5217, #1, 00117$
      008808 81               [ 4]  978 	ret
      008809                        979 00117$:
      008809 72 05 52 18 F5   [ 2]  980 	btjf	0x5218, #2, 00102$
                                    981 ;	main.c: 353: }
      00880E 81               [ 4]  982 	ret
                                    983 ;	main.c: 355: void i2c_stop(void) {
                                    984 ;	-----------------------------------------
                                    985 ;	 function i2c_stop
                                    986 ;	-----------------------------------------
      00880F                        987 _i2c_stop:
                                    988 ;	main.c: 356: I2C_CR2 = I2C_CR2 | (1 << 1);// Отправка стопового сигнала
      00880F 72 12 52 11      [ 1]  989 	bset	0x5211, #1
                                    990 ;	main.c: 358: }
      008813 81               [ 4]  991 	ret
                                    992 ;	main.c: 359: void i2c_write(void){
                                    993 ;	-----------------------------------------
                                    994 ;	 function i2c_write
                                    995 ;	-----------------------------------------
      008814                        996 _i2c_write:
      008814 52 02            [ 2]  997 	sub	sp, #2
                                    998 ;	main.c: 360: I2C_DR = 0;
      008816 35 00 52 16      [ 1]  999 	mov	0x5216+0, #0x00
                                   1000 ;	main.c: 361: reg_check();
      00881A CD 86 60         [ 4] 1001 	call	_reg_check
                                   1002 ;	main.c: 362: I2C_DR = d_addr;
      00881D 55 02 04 52 16   [ 1] 1003 	mov	0x5216+0, _d_addr+0
                                   1004 ;	main.c: 363: reg_check();
      008822 CD 86 60         [ 4] 1005 	call	_reg_check
                                   1006 ;	main.c: 364: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      008825                       1007 00103$:
      008825 C6 52 17         [ 1] 1008 	ld	a, 0x5217
      008828 2B 0A            [ 1] 1009 	jrmi	00124$
      00882A 72 05 52 18 05   [ 2] 1010 	btjf	0x5218, #2, 00124$
      00882F 72 05 52 17 F1   [ 2] 1011 	btjf	0x5217, #2, 00103$
                                   1012 ;	main.c: 365: for(int i = 0;i < d_size;i++)
      008834                       1013 00124$:
      008834 5F               [ 1] 1014 	clrw	x
      008835                       1015 00113$:
      008835 C6 02 06         [ 1] 1016 	ld	a, _d_size+0
      008838 6B 02            [ 1] 1017 	ld	(0x02, sp), a
      00883A 0F 01            [ 1] 1018 	clr	(0x01, sp)
      00883C 13 01            [ 2] 1019 	cpw	x, (0x01, sp)
      00883E 2E 25            [ 1] 1020 	jrsge	00115$
                                   1021 ;	main.c: 367: I2C_DR = data_buf[i];
      008840 90 93            [ 1] 1022 	ldw	y, x
      008842 90 D6 02 08      [ 1] 1023 	ld	a, (_data_buf+0, y)
      008846 C7 52 16         [ 1] 1024 	ld	0x5216, a
                                   1025 ;	main.c: 368: reg_check();
      008849 89               [ 2] 1026 	pushw	x
      00884A CD 86 60         [ 4] 1027 	call	_reg_check
      00884D 85               [ 2] 1028 	popw	x
                                   1029 ;	main.c: 369: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2)));
      00884E                       1030 00108$:
      00884E C6 52 17         [ 1] 1031 	ld	a, 0x5217
      008851 2B 0A            [ 1] 1032 	jrmi	00110$
      008853 72 05 52 18 05   [ 2] 1033 	btjf	0x5218, #2, 00110$
      008858 72 05 52 17 F1   [ 2] 1034 	btjf	0x5217, #2, 00108$
      00885D                       1035 00110$:
                                   1036 ;	main.c: 370: reg_check();
      00885D 89               [ 2] 1037 	pushw	x
      00885E CD 86 60         [ 4] 1038 	call	_reg_check
      008861 85               [ 2] 1039 	popw	x
                                   1040 ;	main.c: 365: for(int i = 0;i < d_size;i++)
      008862 5C               [ 1] 1041 	incw	x
      008863 20 D0            [ 2] 1042 	jra	00113$
      008865                       1043 00115$:
                                   1044 ;	main.c: 372: }
      008865 5B 02            [ 2] 1045 	addw	sp, #2
      008867 81               [ 4] 1046 	ret
                                   1047 ;	main.c: 374: void i2c_read(void){
                                   1048 ;	-----------------------------------------
                                   1049 ;	 function i2c_read
                                   1050 ;	-----------------------------------------
      008868                       1051 _i2c_read:
      008868 52 02            [ 2] 1052 	sub	sp, #2
                                   1053 ;	main.c: 375: I2C_CR2 = I2C_CR2 | (1 << 2);
      00886A 72 14 52 11      [ 1] 1054 	bset	0x5211, #2
                                   1055 ;	main.c: 376: I2C_DR = 0;
      00886E 35 00 52 16      [ 1] 1056 	mov	0x5216+0, #0x00
                                   1057 ;	main.c: 377: reg_check();
      008872 CD 86 60         [ 4] 1058 	call	_reg_check
                                   1059 ;	main.c: 378: I2C_DR = d_addr;
      008875 55 02 04 52 16   [ 1] 1060 	mov	0x5216+0, _d_addr+0
                                   1061 ;	main.c: 379: reg_check();
      00887A CD 86 60         [ 4] 1062 	call	_reg_check
                                   1063 ;	main.c: 380: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      00887D                       1064 00103$:
      00887D C6 52 17         [ 1] 1065 	ld	a, 0x5217
      008880 2B 0A            [ 1] 1066 	jrmi	00105$
      008882 72 05 52 18 05   [ 2] 1067 	btjf	0x5218, #2, 00105$
      008887 72 05 52 17 F1   [ 2] 1068 	btjf	0x5217, #2, 00103$
      00888C                       1069 00105$:
                                   1070 ;	main.c: 383: i2c_start();
      00888C CD 87 F2         [ 4] 1071 	call	_i2c_start
                                   1072 ;	main.c: 384: I2C_DR = (current_dev << 1) | (1 << 0);
      00888F C6 03 08         [ 1] 1073 	ld	a, _current_dev+0
      008892 48               [ 1] 1074 	sll	a
      008893 AA 01            [ 1] 1075 	or	a, #0x01
      008895 C7 52 16         [ 1] 1076 	ld	0x5216, a
                                   1077 ;	main.c: 385: reg_check();
      008898 CD 86 60         [ 4] 1078 	call	_reg_check
                                   1079 ;	main.c: 386: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR1 & (1 << 2)) && !(I2C_SR1 & (1 << 6)));
      00889B                       1080 00108$:
      00889B 72 02 52 17 0A   [ 2] 1081 	btjt	0x5217, #1, 00110$
      0088A0 72 04 52 17 05   [ 2] 1082 	btjt	0x5217, #2, 00110$
      0088A5 72 0D 52 17 F1   [ 2] 1083 	btjf	0x5217, #6, 00108$
      0088AA                       1084 00110$:
                                   1085 ;	main.c: 387: reg_check();
      0088AA CD 86 60         [ 4] 1086 	call	_reg_check
                                   1087 ;	main.c: 388: for(int i = 0;i < d_size;i++)
      0088AD 5F               [ 1] 1088 	clrw	x
      0088AE                       1089 00116$:
      0088AE C6 02 06         [ 1] 1090 	ld	a, _d_size+0
      0088B1 6B 02            [ 1] 1091 	ld	(0x02, sp), a
      0088B3 0F 01            [ 1] 1092 	clr	(0x01, sp)
      0088B5 13 01            [ 2] 1093 	cpw	x, (0x01, sp)
      0088B7 2E 13            [ 1] 1094 	jrsge	00114$
                                   1095 ;	main.c: 390: data_buf[i] = I2C_DR;
      0088B9 90 93            [ 1] 1096 	ldw	y, x
      0088BB 72 A9 02 08      [ 2] 1097 	addw	y, #(_data_buf+0)
      0088BF C6 52 16         [ 1] 1098 	ld	a, 0x5216
      0088C2 90 F7            [ 1] 1099 	ld	(y), a
                                   1100 ;	main.c: 391: while (!(I2C_SR1 & (1 << 6)));
      0088C4                       1101 00111$:
      0088C4 72 0D 52 17 FB   [ 2] 1102 	btjf	0x5217, #6, 00111$
                                   1103 ;	main.c: 388: for(int i = 0;i < d_size;i++)
      0088C9 5C               [ 1] 1104 	incw	x
      0088CA 20 E2            [ 2] 1105 	jra	00116$
      0088CC                       1106 00114$:
                                   1107 ;	main.c: 393: reg_check();
      0088CC CD 86 60         [ 4] 1108 	call	_reg_check
                                   1109 ;	main.c: 394: I2C_CR2 = I2C_CR2 & ~(1 << 2);
      0088CF C6 52 11         [ 1] 1110 	ld	a, 0x5211
      0088D2 A4 FB            [ 1] 1111 	and	a, #0xfb
      0088D4 C7 52 11         [ 1] 1112 	ld	0x5211, a
                                   1113 ;	main.c: 395: reg_check();
      0088D7 5B 02            [ 2] 1114 	addw	sp, #2
                                   1115 ;	main.c: 396: }
      0088D9 CC 86 60         [ 2] 1116 	jp	_reg_check
                                   1117 ;	main.c: 397: void i2c_scan(void) {
                                   1118 ;	-----------------------------------------
                                   1119 ;	 function i2c_scan
                                   1120 ;	-----------------------------------------
      0088DC                       1121 _i2c_scan:
      0088DC 52 02            [ 2] 1122 	sub	sp, #2
                                   1123 ;	main.c: 398: for (uint8_t addr = current_dev; addr < 127; addr++) {
      0088DE C6 03 08         [ 1] 1124 	ld	a, _current_dev+0
      0088E1 6B 01            [ 1] 1125 	ld	(0x01, sp), a
      0088E3 6B 02            [ 1] 1126 	ld	(0x02, sp), a
      0088E5                       1127 00105$:
      0088E5 7B 02            [ 1] 1128 	ld	a, (0x02, sp)
      0088E7 A1 7F            [ 1] 1129 	cp	a, #0x7f
      0088E9 24 26            [ 1] 1130 	jrnc	00107$
                                   1131 ;	main.c: 399: i2c_start();
      0088EB CD 87 F2         [ 4] 1132 	call	_i2c_start
                                   1133 ;	main.c: 400: i2c_send_address(addr);
      0088EE 7B 02            [ 1] 1134 	ld	a, (0x02, sp)
      0088F0 CD 87 FC         [ 4] 1135 	call	_i2c_send_address
                                   1136 ;	main.c: 401: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0088F3 72 04 52 18 0A   [ 2] 1137 	btjt	0x5218, #2, 00102$
                                   1138 ;	main.c: 403: current_dev = addr;
      0088F8 7B 01            [ 1] 1139 	ld	a, (0x01, sp)
      0088FA C7 03 08         [ 1] 1140 	ld	_current_dev+0, a
                                   1141 ;	main.c: 404: i2c_stop();
      0088FD 5B 02            [ 2] 1142 	addw	sp, #2
                                   1143 ;	main.c: 405: break;
      0088FF CC 88 0F         [ 2] 1144 	jp	_i2c_stop
      008902                       1145 00102$:
                                   1146 ;	main.c: 407: i2c_stop();
      008902 CD 88 0F         [ 4] 1147 	call	_i2c_stop
                                   1148 ;	main.c: 408: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      008905 72 15 52 18      [ 1] 1149 	bres	0x5218, #2
                                   1150 ;	main.c: 398: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008909 0C 02            [ 1] 1151 	inc	(0x02, sp)
      00890B 7B 02            [ 1] 1152 	ld	a, (0x02, sp)
      00890D 6B 01            [ 1] 1153 	ld	(0x01, sp), a
      00890F 20 D4            [ 2] 1154 	jra	00105$
      008911                       1155 00107$:
                                   1156 ;	main.c: 410: }
      008911 5B 02            [ 2] 1157 	addw	sp, #2
      008913 81               [ 4] 1158 	ret
                                   1159 ;	main.c: 420: void cm_SM(void)
                                   1160 ;	-----------------------------------------
                                   1161 ;	 function cm_SM
                                   1162 ;	-----------------------------------------
      008914                       1163 _cm_SM:
      008914 52 04            [ 2] 1164 	sub	sp, #4
                                   1165 ;	main.c: 422: char cur_dev[4]={0};
      008916 0F 01            [ 1] 1166 	clr	(0x01, sp)
      008918 0F 02            [ 1] 1167 	clr	(0x02, sp)
      00891A 0F 03            [ 1] 1168 	clr	(0x03, sp)
      00891C 0F 04            [ 1] 1169 	clr	(0x04, sp)
                                   1170 ;	main.c: 423: convert_int_to_chars(current_dev, cur_dev);
      00891E 96               [ 1] 1171 	ldw	x, sp
      00891F 5C               [ 1] 1172 	incw	x
      008920 C6 03 08         [ 1] 1173 	ld	a, _current_dev+0
      008923 CD 84 4C         [ 4] 1174 	call	_convert_int_to_chars
                                   1175 ;	main.c: 424: uart_write("SM ");
      008926 AE 80 71         [ 2] 1176 	ldw	x, #(___str_8+0)
      008929 CD 83 E2         [ 4] 1177 	call	_uart_write
                                   1178 ;	main.c: 425: uart_write(cur_dev);
      00892C 96               [ 1] 1179 	ldw	x, sp
      00892D 5C               [ 1] 1180 	incw	x
      00892E CD 83 E2         [ 4] 1181 	call	_uart_write
                                   1182 ;	main.c: 426: uart_write("\r\n");
      008931 AE 80 75         [ 2] 1183 	ldw	x, #(___str_9+0)
      008934 CD 83 E2         [ 4] 1184 	call	_uart_write
                                   1185 ;	main.c: 427: }
      008937 5B 04            [ 2] 1186 	addw	sp, #4
      008939 81               [ 4] 1187 	ret
                                   1188 ;	main.c: 428: void cm_SN(void)
                                   1189 ;	-----------------------------------------
                                   1190 ;	 function cm_SN
                                   1191 ;	-----------------------------------------
      00893A                       1192 _cm_SN:
                                   1193 ;	main.c: 430: i2c_scan();
      00893A CD 88 DC         [ 4] 1194 	call	_i2c_scan
                                   1195 ;	main.c: 431: cm_SM();
                                   1196 ;	main.c: 432: }
      00893D CC 89 14         [ 2] 1197 	jp	_cm_SM
                                   1198 ;	main.c: 433: void cm_RM(void)
                                   1199 ;	-----------------------------------------
                                   1200 ;	 function cm_RM
                                   1201 ;	-----------------------------------------
      008940                       1202 _cm_RM:
                                   1203 ;	main.c: 435: current_dev = 0;
      008940 72 5F 03 08      [ 1] 1204 	clr	_current_dev+0
                                   1205 ;	main.c: 436: uart_write("RM\n");
      008944 AE 80 78         [ 2] 1206 	ldw	x, #(___str_10+0)
                                   1207 ;	main.c: 437: }
      008947 CC 83 E2         [ 2] 1208 	jp	_uart_write
                                   1209 ;	main.c: 439: void cm_DB(void)
                                   1210 ;	-----------------------------------------
                                   1211 ;	 function cm_DB
                                   1212 ;	-----------------------------------------
      00894A                       1213 _cm_DB:
                                   1214 ;	main.c: 441: status_check();
                                   1215 ;	main.c: 442: }
      00894A CC 86 E3         [ 2] 1216 	jp	_status_check
                                   1217 ;	main.c: 444: void cm_ST(void)
                                   1218 ;	-----------------------------------------
                                   1219 ;	 function cm_ST
                                   1220 ;	-----------------------------------------
      00894D                       1221 _cm_ST:
                                   1222 ;	main.c: 446: get_addr_from_buff();
      00894D CD 85 30         [ 4] 1223 	call	_get_addr_from_buff
                                   1224 ;	main.c: 447: current_dev = d_addr;
      008950 55 02 04 03 08   [ 1] 1225 	mov	_current_dev+0, _d_addr+0
                                   1226 ;	main.c: 448: uart_write("ST\n");
      008955 AE 80 7C         [ 2] 1227 	ldw	x, #(___str_11+0)
                                   1228 ;	main.c: 449: }
      008958 CC 83 E2         [ 2] 1229 	jp	_uart_write
                                   1230 ;	main.c: 450: void cm_SR(void)
                                   1231 ;	-----------------------------------------
                                   1232 ;	 function cm_SR
                                   1233 ;	-----------------------------------------
      00895B                       1234 _cm_SR:
      00895B 52 04            [ 2] 1235 	sub	sp, #4
                                   1236 ;	main.c: 452: i2c_start();
      00895D CD 87 F2         [ 4] 1237 	call	_i2c_start
                                   1238 ;	main.c: 453: i2c_send_address(current_dev);
      008960 C6 03 08         [ 1] 1239 	ld	a, _current_dev+0
      008963 CD 87 FC         [ 4] 1240 	call	_i2c_send_address
                                   1241 ;	main.c: 454: i2c_read();
      008966 CD 88 68         [ 4] 1242 	call	_i2c_read
                                   1243 ;	main.c: 455: i2c_stop();
      008969 CD 88 0F         [ 4] 1244 	call	_i2c_stop
                                   1245 ;	main.c: 456: uart_write("SR ");
      00896C AE 80 80         [ 2] 1246 	ldw	x, #(___str_12+0)
      00896F CD 83 E2         [ 4] 1247 	call	_uart_write
                                   1248 ;	main.c: 457: convert_int_to_chars(d_addr, a);
      008972 AE 02 01         [ 2] 1249 	ldw	x, #(_a+0)
      008975 C6 02 04         [ 1] 1250 	ld	a, _d_addr+0
      008978 CD 84 4C         [ 4] 1251 	call	_convert_int_to_chars
                                   1252 ;	main.c: 458: uart_write(a);
      00897B AE 02 01         [ 2] 1253 	ldw	x, #(_a+0)
      00897E CD 83 E2         [ 4] 1254 	call	_uart_write
                                   1255 ;	main.c: 459: uart_write(" ");
      008981 AE 80 84         [ 2] 1256 	ldw	x, #(___str_13+0)
      008984 CD 83 E2         [ 4] 1257 	call	_uart_write
                                   1258 ;	main.c: 460: convert_int_to_chars(d_size, a);
      008987 AE 02 01         [ 2] 1259 	ldw	x, #(_a+0)
      00898A C6 02 06         [ 1] 1260 	ld	a, _d_size+0
      00898D CD 84 4C         [ 4] 1261 	call	_convert_int_to_chars
                                   1262 ;	main.c: 461: uart_write(a);
      008990 AE 02 01         [ 2] 1263 	ldw	x, #(_a+0)
      008993 CD 83 E2         [ 4] 1264 	call	_uart_write
                                   1265 ;	main.c: 462: for(int i = 0;i < d_size;i++)
      008996 5F               [ 1] 1266 	clrw	x
      008997 1F 03            [ 2] 1267 	ldw	(0x03, sp), x
      008999                       1268 00103$:
      008999 C6 02 06         [ 1] 1269 	ld	a, _d_size+0
      00899C 6B 02            [ 1] 1270 	ld	(0x02, sp), a
      00899E 0F 01            [ 1] 1271 	clr	(0x01, sp)
      0089A0 1E 03            [ 2] 1272 	ldw	x, (0x03, sp)
      0089A2 13 01            [ 2] 1273 	cpw	x, (0x01, sp)
      0089A4 2E 1E            [ 1] 1274 	jrsge	00101$
                                   1275 ;	main.c: 464: uart_write(" ");
      0089A6 AE 80 84         [ 2] 1276 	ldw	x, #(___str_13+0)
      0089A9 CD 83 E2         [ 4] 1277 	call	_uart_write
                                   1278 ;	main.c: 465: convert_int_to_chars(data_buf[i], a);
      0089AC 1E 03            [ 2] 1279 	ldw	x, (0x03, sp)
      0089AE D6 02 08         [ 1] 1280 	ld	a, (_data_buf+0, x)
      0089B1 AE 02 01         [ 2] 1281 	ldw	x, #(_a+0)
      0089B4 CD 84 4C         [ 4] 1282 	call	_convert_int_to_chars
                                   1283 ;	main.c: 466: uart_write(a);
      0089B7 AE 02 01         [ 2] 1284 	ldw	x, #(_a+0)
      0089BA CD 83 E2         [ 4] 1285 	call	_uart_write
                                   1286 ;	main.c: 462: for(int i = 0;i < d_size;i++)
      0089BD 1E 03            [ 2] 1287 	ldw	x, (0x03, sp)
      0089BF 5C               [ 1] 1288 	incw	x
      0089C0 1F 03            [ 2] 1289 	ldw	(0x03, sp), x
      0089C2 20 D5            [ 2] 1290 	jra	00103$
      0089C4                       1291 00101$:
                                   1292 ;	main.c: 469: uart_write("\r\n");
      0089C4 AE 80 75         [ 2] 1293 	ldw	x, #(___str_9+0)
      0089C7 5B 04            [ 2] 1294 	addw	sp, #4
                                   1295 ;	main.c: 470: }
      0089C9 CC 83 E2         [ 2] 1296 	jp	_uart_write
                                   1297 ;	main.c: 471: void cm_SW(void)
                                   1298 ;	-----------------------------------------
                                   1299 ;	 function cm_SW
                                   1300 ;	-----------------------------------------
      0089CC                       1301 _cm_SW:
      0089CC 52 04            [ 2] 1302 	sub	sp, #4
                                   1303 ;	main.c: 473: i2c_start();
      0089CE CD 87 F2         [ 4] 1304 	call	_i2c_start
                                   1305 ;	main.c: 474: i2c_send_address(current_dev);
      0089D1 C6 03 08         [ 1] 1306 	ld	a, _current_dev+0
      0089D4 CD 87 FC         [ 4] 1307 	call	_i2c_send_address
                                   1308 ;	main.c: 475: i2c_write();
      0089D7 CD 88 14         [ 4] 1309 	call	_i2c_write
                                   1310 ;	main.c: 476: i2c_stop();
      0089DA CD 88 0F         [ 4] 1311 	call	_i2c_stop
                                   1312 ;	main.c: 477: uart_write("SW ");
      0089DD AE 80 86         [ 2] 1313 	ldw	x, #(___str_14+0)
      0089E0 CD 83 E2         [ 4] 1314 	call	_uart_write
                                   1315 ;	main.c: 478: convert_int_to_chars(d_addr, a);
      0089E3 AE 02 01         [ 2] 1316 	ldw	x, #(_a+0)
      0089E6 C6 02 04         [ 1] 1317 	ld	a, _d_addr+0
      0089E9 CD 84 4C         [ 4] 1318 	call	_convert_int_to_chars
                                   1319 ;	main.c: 479: uart_write(a);
      0089EC AE 02 01         [ 2] 1320 	ldw	x, #(_a+0)
      0089EF CD 83 E2         [ 4] 1321 	call	_uart_write
                                   1322 ;	main.c: 480: uart_write(" ");
      0089F2 AE 80 84         [ 2] 1323 	ldw	x, #(___str_13+0)
      0089F5 CD 83 E2         [ 4] 1324 	call	_uart_write
                                   1325 ;	main.c: 481: convert_int_to_chars(d_size, a);
      0089F8 AE 02 01         [ 2] 1326 	ldw	x, #(_a+0)
      0089FB C6 02 06         [ 1] 1327 	ld	a, _d_size+0
      0089FE CD 84 4C         [ 4] 1328 	call	_convert_int_to_chars
                                   1329 ;	main.c: 482: uart_write(a);
      008A01 AE 02 01         [ 2] 1330 	ldw	x, #(_a+0)
      008A04 CD 83 E2         [ 4] 1331 	call	_uart_write
                                   1332 ;	main.c: 483: for(int i = 0;i < d_size;i++)
      008A07 5F               [ 1] 1333 	clrw	x
      008A08 1F 03            [ 2] 1334 	ldw	(0x03, sp), x
      008A0A                       1335 00103$:
      008A0A C6 02 06         [ 1] 1336 	ld	a, _d_size+0
      008A0D 6B 02            [ 1] 1337 	ld	(0x02, sp), a
      008A0F 0F 01            [ 1] 1338 	clr	(0x01, sp)
      008A11 1E 03            [ 2] 1339 	ldw	x, (0x03, sp)
      008A13 13 01            [ 2] 1340 	cpw	x, (0x01, sp)
      008A15 2E 1E            [ 1] 1341 	jrsge	00101$
                                   1342 ;	main.c: 485: uart_write(" ");
      008A17 AE 80 84         [ 2] 1343 	ldw	x, #(___str_13+0)
      008A1A CD 83 E2         [ 4] 1344 	call	_uart_write
                                   1345 ;	main.c: 486: convert_int_to_chars(data_buf[i], a);
      008A1D 1E 03            [ 2] 1346 	ldw	x, (0x03, sp)
      008A1F D6 02 08         [ 1] 1347 	ld	a, (_data_buf+0, x)
      008A22 AE 02 01         [ 2] 1348 	ldw	x, #(_a+0)
      008A25 CD 84 4C         [ 4] 1349 	call	_convert_int_to_chars
                                   1350 ;	main.c: 487: uart_write(a);
      008A28 AE 02 01         [ 2] 1351 	ldw	x, #(_a+0)
      008A2B CD 83 E2         [ 4] 1352 	call	_uart_write
                                   1353 ;	main.c: 483: for(int i = 0;i < d_size;i++)
      008A2E 1E 03            [ 2] 1354 	ldw	x, (0x03, sp)
      008A30 5C               [ 1] 1355 	incw	x
      008A31 1F 03            [ 2] 1356 	ldw	(0x03, sp), x
      008A33 20 D5            [ 2] 1357 	jra	00103$
      008A35                       1358 00101$:
                                   1359 ;	main.c: 490: uart_write("\r\n");
      008A35 AE 80 75         [ 2] 1360 	ldw	x, #(___str_9+0)
      008A38 5B 04            [ 2] 1361 	addw	sp, #4
                                   1362 ;	main.c: 491: }
      008A3A CC 83 E2         [ 2] 1363 	jp	_uart_write
                                   1364 ;	main.c: 499: int data_handler(void)
                                   1365 ;	-----------------------------------------
                                   1366 ;	 function data_handler
                                   1367 ;	-----------------------------------------
      008A3D                       1368 _data_handler:
                                   1369 ;	main.c: 501: p_size = 0;
      008A3D 72 5F 02 05      [ 1] 1370 	clr	_p_size+0
                                   1371 ;	main.c: 502: p_bytes = 0;
      008A41 72 5F 02 07      [ 1] 1372 	clr	_p_bytes+0
                                   1373 ;	main.c: 503: d_addr = 0;
      008A45 72 5F 02 04      [ 1] 1374 	clr	_d_addr+0
                                   1375 ;	main.c: 504: d_size = 0;
      008A49 72 5F 02 06      [ 1] 1376 	clr	_d_size+0
                                   1377 ;	main.c: 505: memset(a, 0, sizeof(a));
      008A4D 4B 03            [ 1] 1378 	push	#0x03
      008A4F 4B 00            [ 1] 1379 	push	#0x00
      008A51 5F               [ 1] 1380 	clrw	x
      008A52 89               [ 2] 1381 	pushw	x
      008A53 AE 02 01         [ 2] 1382 	ldw	x, #(_a+0)
      008A56 CD 8B FA         [ 4] 1383 	call	_memset
                                   1384 ;	main.c: 506: memset(data_buf, 0, sizeof(data_buf));
      008A59 4B 00            [ 1] 1385 	push	#0x00
      008A5B 4B 01            [ 1] 1386 	push	#0x01
      008A5D 5F               [ 1] 1387 	clrw	x
      008A5E 89               [ 2] 1388 	pushw	x
      008A5F AE 02 08         [ 2] 1389 	ldw	x, #(_data_buf+0)
      008A62 CD 8B FA         [ 4] 1390 	call	_memset
                                   1391 ;	main.c: 507: if(memcmp(&buffer[0],"SM",2) == 0)
      008A65 4B 02            [ 1] 1392 	push	#0x02
      008A67 4B 00            [ 1] 1393 	push	#0x00
      008A69 4B 8A            [ 1] 1394 	push	#<(___str_15+0)
      008A6B 4B 80            [ 1] 1395 	push	#((___str_15+0) >> 8)
      008A6D AE 01 01         [ 2] 1396 	ldw	x, #(_buffer+0)
      008A70 CD 8B 64         [ 4] 1397 	call	_memcmp
                                   1398 ;	main.c: 508: return 1;
      008A73 5D               [ 2] 1399 	tnzw	x
      008A74 26 02            [ 1] 1400 	jrne	00102$
      008A76 5C               [ 1] 1401 	incw	x
      008A77 81               [ 4] 1402 	ret
      008A78                       1403 00102$:
                                   1404 ;	main.c: 509: if(memcmp(&buffer[0],"SN",2) == 0)
      008A78 4B 02            [ 1] 1405 	push	#0x02
      008A7A 4B 00            [ 1] 1406 	push	#0x00
      008A7C 4B 8D            [ 1] 1407 	push	#<(___str_16+0)
      008A7E 4B 80            [ 1] 1408 	push	#((___str_16+0) >> 8)
      008A80 AE 01 01         [ 2] 1409 	ldw	x, #(_buffer+0)
      008A83 CD 8B 64         [ 4] 1410 	call	_memcmp
      008A86 5D               [ 2] 1411 	tnzw	x
      008A87 26 04            [ 1] 1412 	jrne	00104$
                                   1413 ;	main.c: 510: return 2;
      008A89 AE 00 02         [ 2] 1414 	ldw	x, #0x0002
      008A8C 81               [ 4] 1415 	ret
      008A8D                       1416 00104$:
                                   1417 ;	main.c: 511: if(memcmp(&buffer[0],"ST",2) == 0)
      008A8D 4B 02            [ 1] 1418 	push	#0x02
      008A8F 4B 00            [ 1] 1419 	push	#0x00
      008A91 4B 90            [ 1] 1420 	push	#<(___str_17+0)
      008A93 4B 80            [ 1] 1421 	push	#((___str_17+0) >> 8)
      008A95 AE 01 01         [ 2] 1422 	ldw	x, #(_buffer+0)
      008A98 CD 8B 64         [ 4] 1423 	call	_memcmp
      008A9B 5D               [ 2] 1424 	tnzw	x
      008A9C 26 04            [ 1] 1425 	jrne	00106$
                                   1426 ;	main.c: 512: return 5;
      008A9E AE 00 05         [ 2] 1427 	ldw	x, #0x0005
      008AA1 81               [ 4] 1428 	ret
      008AA2                       1429 00106$:
                                   1430 ;	main.c: 513: if(memcmp(&buffer[0],"RM",2) == 0)
      008AA2 4B 02            [ 1] 1431 	push	#0x02
      008AA4 4B 00            [ 1] 1432 	push	#0x00
      008AA6 4B 93            [ 1] 1433 	push	#<(___str_18+0)
      008AA8 4B 80            [ 1] 1434 	push	#((___str_18+0) >> 8)
      008AAA AE 01 01         [ 2] 1435 	ldw	x, #(_buffer+0)
      008AAD CD 8B 64         [ 4] 1436 	call	_memcmp
      008AB0 5D               [ 2] 1437 	tnzw	x
      008AB1 26 04            [ 1] 1438 	jrne	00108$
                                   1439 ;	main.c: 514: return 6;
      008AB3 AE 00 06         [ 2] 1440 	ldw	x, #0x0006
      008AB6 81               [ 4] 1441 	ret
      008AB7                       1442 00108$:
                                   1443 ;	main.c: 515: if(memcmp(&buffer[0],"DB",2) == 0)
      008AB7 4B 02            [ 1] 1444 	push	#0x02
      008AB9 4B 00            [ 1] 1445 	push	#0x00
      008ABB 4B 96            [ 1] 1446 	push	#<(___str_19+0)
      008ABD 4B 80            [ 1] 1447 	push	#((___str_19+0) >> 8)
      008ABF AE 01 01         [ 2] 1448 	ldw	x, #(_buffer+0)
      008AC2 CD 8B 64         [ 4] 1449 	call	_memcmp
      008AC5 5D               [ 2] 1450 	tnzw	x
      008AC6 26 04            [ 1] 1451 	jrne	00110$
                                   1452 ;	main.c: 516: return 7;
      008AC8 AE 00 07         [ 2] 1453 	ldw	x, #0x0007
      008ACB 81               [ 4] 1454 	ret
      008ACC                       1455 00110$:
                                   1456 ;	main.c: 518: get_addr_from_buff();
      008ACC CD 85 30         [ 4] 1457 	call	_get_addr_from_buff
                                   1458 ;	main.c: 519: get_size_from_buff();
      008ACF CD 85 75         [ 4] 1459 	call	_get_size_from_buff
                                   1460 ;	main.c: 521: if(memcmp(&buffer[0],"SR",2) == 0)
      008AD2 4B 02            [ 1] 1461 	push	#0x02
      008AD4 4B 00            [ 1] 1462 	push	#0x00
      008AD6 4B 99            [ 1] 1463 	push	#<(___str_20+0)
      008AD8 4B 80            [ 1] 1464 	push	#((___str_20+0) >> 8)
      008ADA AE 01 01         [ 2] 1465 	ldw	x, #(_buffer+0)
      008ADD CD 8B 64         [ 4] 1466 	call	_memcmp
      008AE0 5D               [ 2] 1467 	tnzw	x
      008AE1 26 04            [ 1] 1468 	jrne	00112$
                                   1469 ;	main.c: 522: return 3;
      008AE3 AE 00 03         [ 2] 1470 	ldw	x, #0x0003
      008AE6 81               [ 4] 1471 	ret
      008AE7                       1472 00112$:
                                   1473 ;	main.c: 524: char_buffer_to_int();
      008AE7 CD 85 CF         [ 4] 1474 	call	_char_buffer_to_int
                                   1475 ;	main.c: 526: if(memcmp(&buffer[0],"SW",2) == 0)
      008AEA 4B 02            [ 1] 1476 	push	#0x02
      008AEC 4B 00            [ 1] 1477 	push	#0x00
      008AEE 4B 9C            [ 1] 1478 	push	#<(___str_21+0)
      008AF0 4B 80            [ 1] 1479 	push	#((___str_21+0) >> 8)
      008AF2 AE 01 01         [ 2] 1480 	ldw	x, #(_buffer+0)
      008AF5 CD 8B 64         [ 4] 1481 	call	_memcmp
      008AF8 5D               [ 2] 1482 	tnzw	x
      008AF9 26 04            [ 1] 1483 	jrne	00114$
                                   1484 ;	main.c: 527: return 4;
      008AFB AE 00 04         [ 2] 1485 	ldw	x, #0x0004
      008AFE 81               [ 4] 1486 	ret
      008AFF                       1487 00114$:
                                   1488 ;	main.c: 528: return 0;
      008AFF 5F               [ 1] 1489 	clrw	x
                                   1490 ;	main.c: 530: }
      008B00 81               [ 4] 1491 	ret
                                   1492 ;	main.c: 532: void command_switcher(void)
                                   1493 ;	-----------------------------------------
                                   1494 ;	 function command_switcher
                                   1495 ;	-----------------------------------------
      008B01                       1496 _command_switcher:
      008B01 52 04            [ 2] 1497 	sub	sp, #4
                                   1498 ;	main.c: 534: char ar[4]={0};
      008B03 0F 01            [ 1] 1499 	clr	(0x01, sp)
      008B05 0F 02            [ 1] 1500 	clr	(0x02, sp)
      008B07 0F 03            [ 1] 1501 	clr	(0x03, sp)
      008B09 0F 04            [ 1] 1502 	clr	(0x04, sp)
                                   1503 ;	main.c: 536: switch(data_handler())
      008B0B CD 8A 3D         [ 4] 1504 	call	_data_handler
      008B0E 5D               [ 2] 1505 	tnzw	x
      008B0F 2B 3B            [ 1] 1506 	jrmi	00109$
      008B11 A3 00 07         [ 2] 1507 	cpw	x, #0x0007
      008B14 2C 36            [ 1] 1508 	jrsgt	00109$
      008B16 58               [ 2] 1509 	sllw	x
      008B17 DE 8B 1B         [ 2] 1510 	ldw	x, (#00123$, x)
      008B1A FC               [ 2] 1511 	jp	(x)
      008B1B                       1512 00123$:
      008B1B 8B 4C                 1513 	.dw	#00109$
      008B1D 8B 2B                 1514 	.dw	#00101$
      008B1F 8B 30                 1515 	.dw	#00102$
      008B21 8B 35                 1516 	.dw	#00103$
      008B23 8B 3A                 1517 	.dw	#00104$
      008B25 8B 3F                 1518 	.dw	#00105$
      008B27 8B 44                 1519 	.dw	#00106$
      008B29 8B 49                 1520 	.dw	#00107$
                                   1521 ;	main.c: 538: case 1:
      008B2B                       1522 00101$:
                                   1523 ;	main.c: 539: cm_SM();
      008B2B CD 89 14         [ 4] 1524 	call	_cm_SM
                                   1525 ;	main.c: 540: break;
      008B2E 20 1C            [ 2] 1526 	jra	00109$
                                   1527 ;	main.c: 541: case 2:
      008B30                       1528 00102$:
                                   1529 ;	main.c: 542: cm_SN();
      008B30 CD 89 3A         [ 4] 1530 	call	_cm_SN
                                   1531 ;	main.c: 543: break;
      008B33 20 17            [ 2] 1532 	jra	00109$
                                   1533 ;	main.c: 544: case 3:
      008B35                       1534 00103$:
                                   1535 ;	main.c: 545: cm_SR();
      008B35 CD 89 5B         [ 4] 1536 	call	_cm_SR
                                   1537 ;	main.c: 546: break;
      008B38 20 12            [ 2] 1538 	jra	00109$
                                   1539 ;	main.c: 547: case 4:
      008B3A                       1540 00104$:
                                   1541 ;	main.c: 548: cm_SW();
      008B3A CD 89 CC         [ 4] 1542 	call	_cm_SW
                                   1543 ;	main.c: 549: break;
      008B3D 20 0D            [ 2] 1544 	jra	00109$
                                   1545 ;	main.c: 550: case 5:
      008B3F                       1546 00105$:
                                   1547 ;	main.c: 551: cm_ST();
      008B3F CD 89 4D         [ 4] 1548 	call	_cm_ST
                                   1549 ;	main.c: 552: break;
      008B42 20 08            [ 2] 1550 	jra	00109$
                                   1551 ;	main.c: 553: case 6:
      008B44                       1552 00106$:
                                   1553 ;	main.c: 554: cm_RM();
      008B44 CD 89 40         [ 4] 1554 	call	_cm_RM
                                   1555 ;	main.c: 555: break;
      008B47 20 03            [ 2] 1556 	jra	00109$
                                   1557 ;	main.c: 556: case 7:
      008B49                       1558 00107$:
                                   1559 ;	main.c: 557: cm_DB();
      008B49 CD 89 4A         [ 4] 1560 	call	_cm_DB
                                   1561 ;	main.c: 559: }
      008B4C                       1562 00109$:
                                   1563 ;	main.c: 560: }
      008B4C 5B 04            [ 2] 1564 	addw	sp, #4
      008B4E 81               [ 4] 1565 	ret
                                   1566 ;	main.c: 563: void main(void)
                                   1567 ;	-----------------------------------------
                                   1568 ;	 function main
                                   1569 ;	-----------------------------------------
      008B4F                       1570 _main:
                                   1571 ;	main.c: 565: uart_init();
      008B4F CD 87 B4         [ 4] 1572 	call	_uart_init
                                   1573 ;	main.c: 566: i2c_init();
      008B52 CD 87 D1         [ 4] 1574 	call	_i2c_init
                                   1575 ;	main.c: 567: uart_write("SS\n");
      008B55 AE 80 9F         [ 2] 1576 	ldw	x, #(___str_22+0)
      008B58 CD 83 E2         [ 4] 1577 	call	_uart_write
                                   1578 ;	main.c: 568: while(1)
      008B5B                       1579 00102$:
                                   1580 ;	main.c: 570: uart_read();
      008B5B CD 84 16         [ 4] 1581 	call	_uart_read
                                   1582 ;	main.c: 571: command_switcher();
      008B5E CD 8B 01         [ 4] 1583 	call	_command_switcher
      008B61 20 F8            [ 2] 1584 	jra	00102$
                                   1585 ;	main.c: 573: }
      008B63 81               [ 4] 1586 	ret
                                   1587 	.area CODE
                                   1588 	.area CONST
                                   1589 	.area CONST
      00802D                       1590 ___str_0:
      00802D 0A                    1591 	.db 0x0a
      00802E 49 32 43 5F 52 45 47  1592 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                    1593 	.db 0x0a
      00803B 00                    1594 	.db 0x00
                                   1595 	.area CODE
                                   1596 	.area CONST
      00803C                       1597 ___str_1:
      00803C 0A                    1598 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20  1599 	.ascii "SR1 -> "
      008044 00                    1600 	.db 0x00
                                   1601 	.area CODE
                                   1602 	.area CONST
      008045                       1603 ___str_2:
      008045 20 3C 2D              1604 	.ascii " <-"
      008048 0A                    1605 	.db 0x0a
      008049 00                    1606 	.db 0x00
                                   1607 	.area CODE
                                   1608 	.area CONST
      00804A                       1609 ___str_3:
      00804A 53 52 32 20 2D 3E 20  1610 	.ascii "SR2 -> "
      008051 00                    1611 	.db 0x00
                                   1612 	.area CODE
                                   1613 	.area CONST
      008052                       1614 ___str_4:
      008052 53 52 33 20 2D 3E 20  1615 	.ascii "SR3 -> "
      008059 00                    1616 	.db 0x00
                                   1617 	.area CODE
                                   1618 	.area CONST
      00805A                       1619 ___str_5:
      00805A 43 52 31 20 2D 3E 20  1620 	.ascii "CR1 -> "
      008061 00                    1621 	.db 0x00
                                   1622 	.area CODE
                                   1623 	.area CONST
      008062                       1624 ___str_6:
      008062 43 52 32 20 2D 3E 20  1625 	.ascii "CR2 -> "
      008069 00                    1626 	.db 0x00
                                   1627 	.area CODE
                                   1628 	.area CONST
      00806A                       1629 ___str_7:
      00806A 44 52 20 2D 3E 20     1630 	.ascii "DR -> "
      008070 00                    1631 	.db 0x00
                                   1632 	.area CODE
                                   1633 	.area CONST
      008071                       1634 ___str_8:
      008071 53 4D 20              1635 	.ascii "SM "
      008074 00                    1636 	.db 0x00
                                   1637 	.area CODE
                                   1638 	.area CONST
      008075                       1639 ___str_9:
      008075 0D                    1640 	.db 0x0d
      008076 0A                    1641 	.db 0x0a
      008077 00                    1642 	.db 0x00
                                   1643 	.area CODE
                                   1644 	.area CONST
      008078                       1645 ___str_10:
      008078 52 4D                 1646 	.ascii "RM"
      00807A 0A                    1647 	.db 0x0a
      00807B 00                    1648 	.db 0x00
                                   1649 	.area CODE
                                   1650 	.area CONST
      00807C                       1651 ___str_11:
      00807C 53 54                 1652 	.ascii "ST"
      00807E 0A                    1653 	.db 0x0a
      00807F 00                    1654 	.db 0x00
                                   1655 	.area CODE
                                   1656 	.area CONST
      008080                       1657 ___str_12:
      008080 53 52 20              1658 	.ascii "SR "
      008083 00                    1659 	.db 0x00
                                   1660 	.area CODE
                                   1661 	.area CONST
      008084                       1662 ___str_13:
      008084 20                    1663 	.ascii " "
      008085 00                    1664 	.db 0x00
                                   1665 	.area CODE
                                   1666 	.area CONST
      008086                       1667 ___str_14:
      008086 53 57 20              1668 	.ascii "SW "
      008089 00                    1669 	.db 0x00
                                   1670 	.area CODE
                                   1671 	.area CONST
      00808A                       1672 ___str_15:
      00808A 53 4D                 1673 	.ascii "SM"
      00808C 00                    1674 	.db 0x00
                                   1675 	.area CODE
                                   1676 	.area CONST
      00808D                       1677 ___str_16:
      00808D 53 4E                 1678 	.ascii "SN"
      00808F 00                    1679 	.db 0x00
                                   1680 	.area CODE
                                   1681 	.area CONST
      008090                       1682 ___str_17:
      008090 53 54                 1683 	.ascii "ST"
      008092 00                    1684 	.db 0x00
                                   1685 	.area CODE
                                   1686 	.area CONST
      008093                       1687 ___str_18:
      008093 52 4D                 1688 	.ascii "RM"
      008095 00                    1689 	.db 0x00
                                   1690 	.area CODE
                                   1691 	.area CONST
      008096                       1692 ___str_19:
      008096 44 42                 1693 	.ascii "DB"
      008098 00                    1694 	.db 0x00
                                   1695 	.area CODE
                                   1696 	.area CONST
      008099                       1697 ___str_20:
      008099 53 52                 1698 	.ascii "SR"
      00809B 00                    1699 	.db 0x00
                                   1700 	.area CODE
                                   1701 	.area CONST
      00809C                       1702 ___str_21:
      00809C 53 57                 1703 	.ascii "SW"
      00809E 00                    1704 	.db 0x00
                                   1705 	.area CODE
                                   1706 	.area CONST
      00809F                       1707 ___str_22:
      00809F 53 53                 1708 	.ascii "SS"
      0080A1 0A                    1709 	.db 0x0a
      0080A2 00                    1710 	.db 0x00
                                   1711 	.area CODE
                                   1712 	.area INITIALIZER
      0080A3                       1713 __xinit__status_registers:
      0080A3 00                    1714 	.db #0x00	; 0
      0080A4 00                    1715 	.db 0x00
      0080A5 00                    1716 	.db 0x00
      0080A6 00                    1717 	.db 0x00
      0080A7 00                    1718 	.db 0x00
      0080A8 00                    1719 	.db 0x00
      0080A9 00                    1720 	.db 0x00
      0080AA 00                    1721 	.db 0x00
      0080AB 00                    1722 	.db 0x00
      0080AC 00                    1723 	.db 0x00
      0080AD 00                    1724 	.db 0x00
      0080AE 00                    1725 	.db 0x00
      0080AF 00                    1726 	.db 0x00
      0080B0 00                    1727 	.db 0x00
      0080B1 00                    1728 	.db 0x00
      0080B2 00                    1729 	.db 0x00
      0080B3 00                    1730 	.db 0x00
      0080B4 00                    1731 	.db 0x00
      0080B5 00                    1732 	.db 0x00
      0080B6 00                    1733 	.db 0x00
      0080B7 00                    1734 	.db 0x00
      0080B8 00                    1735 	.db 0x00
      0080B9 00                    1736 	.db 0x00
      0080BA 00                    1737 	.db 0x00
      0080BB 00                    1738 	.db 0x00
      0080BC 00                    1739 	.db 0x00
      0080BD 00                    1740 	.db 0x00
      0080BE 00                    1741 	.db 0x00
      0080BF 00                    1742 	.db 0x00
      0080C0 00                    1743 	.db 0x00
      0080C1 00                    1744 	.db 0x00
      0080C2 00                    1745 	.db 0x00
      0080C3 00                    1746 	.db 0x00
      0080C4 00                    1747 	.db 0x00
      0080C5 00                    1748 	.db 0x00
      0080C6 00                    1749 	.db 0x00
      0080C7 00                    1750 	.db 0x00
      0080C8 00                    1751 	.db 0x00
      0080C9 00                    1752 	.db 0x00
      0080CA 00                    1753 	.db 0x00
      0080CB 00                    1754 	.db 0x00
      0080CC 00                    1755 	.db 0x00
      0080CD 00                    1756 	.db 0x00
      0080CE 00                    1757 	.db 0x00
      0080CF 00                    1758 	.db 0x00
      0080D0 00                    1759 	.db 0x00
      0080D1 00                    1760 	.db 0x00
      0080D2 00                    1761 	.db 0x00
      0080D3 00                    1762 	.db 0x00
      0080D4 00                    1763 	.db 0x00
      0080D5 00                    1764 	.db 0x00
      0080D6 00                    1765 	.db 0x00
      0080D7 00                    1766 	.db 0x00
      0080D8 00                    1767 	.db 0x00
      0080D9 00                    1768 	.db 0x00
      0080DA 00                    1769 	.db 0x00
      0080DB 00                    1770 	.db 0x00
      0080DC 00                    1771 	.db 0x00
      0080DD 00                    1772 	.db 0x00
      0080DE 00                    1773 	.db 0x00
      0080DF 00                    1774 	.db 0x00
      0080E0 00                    1775 	.db 0x00
      0080E1 00                    1776 	.db 0x00
      0080E2 00                    1777 	.db 0x00
      0080E3 00                    1778 	.db 0x00
      0080E4 00                    1779 	.db 0x00
      0080E5 00                    1780 	.db 0x00
      0080E6 00                    1781 	.db 0x00
      0080E7 00                    1782 	.db 0x00
      0080E8 00                    1783 	.db 0x00
      0080E9 00                    1784 	.db 0x00
      0080EA 00                    1785 	.db 0x00
      0080EB 00                    1786 	.db 0x00
      0080EC 00                    1787 	.db 0x00
      0080ED 00                    1788 	.db 0x00
      0080EE 00                    1789 	.db 0x00
      0080EF 00                    1790 	.db 0x00
      0080F0 00                    1791 	.db 0x00
      0080F1 00                    1792 	.db 0x00
      0080F2 00                    1793 	.db 0x00
      0080F3 00                    1794 	.db 0x00
      0080F4 00                    1795 	.db 0x00
      0080F5 00                    1796 	.db 0x00
      0080F6 00                    1797 	.db 0x00
      0080F7 00                    1798 	.db 0x00
      0080F8 00                    1799 	.db 0x00
      0080F9 00                    1800 	.db 0x00
      0080FA 00                    1801 	.db 0x00
      0080FB 00                    1802 	.db 0x00
      0080FC 00                    1803 	.db 0x00
      0080FD 00                    1804 	.db 0x00
      0080FE 00                    1805 	.db 0x00
      0080FF 00                    1806 	.db 0x00
      008100 00                    1807 	.db 0x00
      008101 00                    1808 	.db 0x00
      008102 00                    1809 	.db 0x00
      008103 00                    1810 	.db 0x00
      008104 00                    1811 	.db 0x00
      008105 00                    1812 	.db 0x00
      008106 00                    1813 	.db 0x00
      008107 00                    1814 	.db 0x00
      008108 00                    1815 	.db 0x00
      008109 00                    1816 	.db 0x00
      00810A 00                    1817 	.db 0x00
      00810B 00                    1818 	.db 0x00
      00810C 00                    1819 	.db 0x00
      00810D 00                    1820 	.db 0x00
      00810E 00                    1821 	.db 0x00
      00810F 00                    1822 	.db 0x00
      008110 00                    1823 	.db 0x00
      008111 00                    1824 	.db 0x00
      008112 00                    1825 	.db 0x00
      008113 00                    1826 	.db 0x00
      008114 00                    1827 	.db 0x00
      008115 00                    1828 	.db 0x00
      008116 00                    1829 	.db 0x00
      008117 00                    1830 	.db 0x00
      008118 00                    1831 	.db 0x00
      008119 00                    1832 	.db 0x00
      00811A 00                    1833 	.db 0x00
      00811B 00                    1834 	.db 0x00
      00811C 00                    1835 	.db 0x00
      00811D 00                    1836 	.db 0x00
      00811E 00                    1837 	.db 0x00
      00811F 00                    1838 	.db 0x00
      008120 00                    1839 	.db 0x00
      008121 00                    1840 	.db 0x00
      008122 00                    1841 	.db 0x00
      008123 00                    1842 	.db 0x00
      008124 00                    1843 	.db 0x00
      008125 00                    1844 	.db 0x00
      008126 00                    1845 	.db 0x00
      008127 00                    1846 	.db 0x00
      008128 00                    1847 	.db 0x00
      008129 00                    1848 	.db 0x00
      00812A 00                    1849 	.db 0x00
      00812B 00                    1850 	.db 0x00
      00812C 00                    1851 	.db 0x00
      00812D 00                    1852 	.db 0x00
      00812E 00                    1853 	.db 0x00
      00812F 00                    1854 	.db 0x00
      008130 00                    1855 	.db 0x00
      008131 00                    1856 	.db 0x00
      008132 00                    1857 	.db 0x00
      008133 00                    1858 	.db 0x00
      008134 00                    1859 	.db 0x00
      008135 00                    1860 	.db 0x00
      008136 00                    1861 	.db 0x00
      008137 00                    1862 	.db 0x00
      008138 00                    1863 	.db 0x00
      008139 00                    1864 	.db 0x00
      00813A 00                    1865 	.db 0x00
      00813B 00                    1866 	.db 0x00
      00813C 00                    1867 	.db 0x00
      00813D 00                    1868 	.db 0x00
      00813E 00                    1869 	.db 0x00
      00813F 00                    1870 	.db 0x00
      008140 00                    1871 	.db 0x00
      008141 00                    1872 	.db 0x00
      008142 00                    1873 	.db 0x00
      008143 00                    1874 	.db 0x00
      008144 00                    1875 	.db 0x00
      008145 00                    1876 	.db 0x00
      008146 00                    1877 	.db 0x00
      008147 00                    1878 	.db 0x00
      008148 00                    1879 	.db 0x00
      008149 00                    1880 	.db 0x00
      00814A 00                    1881 	.db 0x00
      00814B 00                    1882 	.db 0x00
      00814C 00                    1883 	.db 0x00
      00814D 00                    1884 	.db 0x00
      00814E 00                    1885 	.db 0x00
      00814F 00                    1886 	.db 0x00
      008150 00                    1887 	.db 0x00
      008151 00                    1888 	.db 0x00
      008152 00                    1889 	.db 0x00
      008153 00                    1890 	.db 0x00
      008154 00                    1891 	.db 0x00
      008155 00                    1892 	.db 0x00
      008156 00                    1893 	.db 0x00
      008157 00                    1894 	.db 0x00
      008158 00                    1895 	.db 0x00
      008159 00                    1896 	.db 0x00
      00815A 00                    1897 	.db 0x00
      00815B 00                    1898 	.db 0x00
      00815C 00                    1899 	.db 0x00
      00815D 00                    1900 	.db 0x00
      00815E 00                    1901 	.db 0x00
      00815F 00                    1902 	.db 0x00
      008160 00                    1903 	.db 0x00
      008161 00                    1904 	.db 0x00
      008162 00                    1905 	.db 0x00
      008163 00                    1906 	.db 0x00
      008164 00                    1907 	.db 0x00
      008165 00                    1908 	.db 0x00
      008166 00                    1909 	.db 0x00
      008167 00                    1910 	.db 0x00
      008168 00                    1911 	.db 0x00
      008169 00                    1912 	.db 0x00
      00816A 00                    1913 	.db 0x00
      00816B 00                    1914 	.db 0x00
      00816C 00                    1915 	.db 0x00
      00816D 00                    1916 	.db 0x00
      00816E 00                    1917 	.db 0x00
      00816F 00                    1918 	.db 0x00
      008170 00                    1919 	.db 0x00
      008171 00                    1920 	.db 0x00
      008172 00                    1921 	.db 0x00
      008173 00                    1922 	.db 0x00
      008174 00                    1923 	.db 0x00
      008175 00                    1924 	.db 0x00
      008176 00                    1925 	.db 0x00
      008177 00                    1926 	.db 0x00
      008178 00                    1927 	.db 0x00
      008179 00                    1928 	.db 0x00
      00817A 00                    1929 	.db 0x00
      00817B 00                    1930 	.db 0x00
      00817C 00                    1931 	.db 0x00
      00817D 00                    1932 	.db 0x00
      00817E 00                    1933 	.db 0x00
      00817F 00                    1934 	.db 0x00
      008180 00                    1935 	.db 0x00
      008181 00                    1936 	.db 0x00
      008182 00                    1937 	.db 0x00
      008183 00                    1938 	.db 0x00
      008184 00                    1939 	.db 0x00
      008185 00                    1940 	.db 0x00
      008186 00                    1941 	.db 0x00
      008187 00                    1942 	.db 0x00
      008188 00                    1943 	.db 0x00
      008189 00                    1944 	.db 0x00
      00818A 00                    1945 	.db 0x00
      00818B 00                    1946 	.db 0x00
      00818C 00                    1947 	.db 0x00
      00818D 00                    1948 	.db 0x00
      00818E 00                    1949 	.db 0x00
      00818F 00                    1950 	.db 0x00
      008190 00                    1951 	.db 0x00
      008191 00                    1952 	.db 0x00
      008192 00                    1953 	.db 0x00
      008193 00                    1954 	.db 0x00
      008194 00                    1955 	.db 0x00
      008195 00                    1956 	.db 0x00
      008196 00                    1957 	.db 0x00
      008197 00                    1958 	.db 0x00
      008198 00                    1959 	.db 0x00
      008199 00                    1960 	.db 0x00
      00819A 00                    1961 	.db 0x00
      00819B 00                    1962 	.db 0x00
      00819C 00                    1963 	.db 0x00
      00819D 00                    1964 	.db 0x00
      00819E 00                    1965 	.db 0x00
      00819F 00                    1966 	.db 0x00
      0081A0 00                    1967 	.db 0x00
      0081A1 00                    1968 	.db 0x00
      0081A2 00                    1969 	.db 0x00
      0081A3                       1970 __xinit__buffer:
      0081A3 00                    1971 	.db #0x00	; 0
      0081A4 00                    1972 	.db 0x00
      0081A5 00                    1973 	.db 0x00
      0081A6 00                    1974 	.db 0x00
      0081A7 00                    1975 	.db 0x00
      0081A8 00                    1976 	.db 0x00
      0081A9 00                    1977 	.db 0x00
      0081AA 00                    1978 	.db 0x00
      0081AB 00                    1979 	.db 0x00
      0081AC 00                    1980 	.db 0x00
      0081AD 00                    1981 	.db 0x00
      0081AE 00                    1982 	.db 0x00
      0081AF 00                    1983 	.db 0x00
      0081B0 00                    1984 	.db 0x00
      0081B1 00                    1985 	.db 0x00
      0081B2 00                    1986 	.db 0x00
      0081B3 00                    1987 	.db 0x00
      0081B4 00                    1988 	.db 0x00
      0081B5 00                    1989 	.db 0x00
      0081B6 00                    1990 	.db 0x00
      0081B7 00                    1991 	.db 0x00
      0081B8 00                    1992 	.db 0x00
      0081B9 00                    1993 	.db 0x00
      0081BA 00                    1994 	.db 0x00
      0081BB 00                    1995 	.db 0x00
      0081BC 00                    1996 	.db 0x00
      0081BD 00                    1997 	.db 0x00
      0081BE 00                    1998 	.db 0x00
      0081BF 00                    1999 	.db 0x00
      0081C0 00                    2000 	.db 0x00
      0081C1 00                    2001 	.db 0x00
      0081C2 00                    2002 	.db 0x00
      0081C3 00                    2003 	.db 0x00
      0081C4 00                    2004 	.db 0x00
      0081C5 00                    2005 	.db 0x00
      0081C6 00                    2006 	.db 0x00
      0081C7 00                    2007 	.db 0x00
      0081C8 00                    2008 	.db 0x00
      0081C9 00                    2009 	.db 0x00
      0081CA 00                    2010 	.db 0x00
      0081CB 00                    2011 	.db 0x00
      0081CC 00                    2012 	.db 0x00
      0081CD 00                    2013 	.db 0x00
      0081CE 00                    2014 	.db 0x00
      0081CF 00                    2015 	.db 0x00
      0081D0 00                    2016 	.db 0x00
      0081D1 00                    2017 	.db 0x00
      0081D2 00                    2018 	.db 0x00
      0081D3 00                    2019 	.db 0x00
      0081D4 00                    2020 	.db 0x00
      0081D5 00                    2021 	.db 0x00
      0081D6 00                    2022 	.db 0x00
      0081D7 00                    2023 	.db 0x00
      0081D8 00                    2024 	.db 0x00
      0081D9 00                    2025 	.db 0x00
      0081DA 00                    2026 	.db 0x00
      0081DB 00                    2027 	.db 0x00
      0081DC 00                    2028 	.db 0x00
      0081DD 00                    2029 	.db 0x00
      0081DE 00                    2030 	.db 0x00
      0081DF 00                    2031 	.db 0x00
      0081E0 00                    2032 	.db 0x00
      0081E1 00                    2033 	.db 0x00
      0081E2 00                    2034 	.db 0x00
      0081E3 00                    2035 	.db 0x00
      0081E4 00                    2036 	.db 0x00
      0081E5 00                    2037 	.db 0x00
      0081E6 00                    2038 	.db 0x00
      0081E7 00                    2039 	.db 0x00
      0081E8 00                    2040 	.db 0x00
      0081E9 00                    2041 	.db 0x00
      0081EA 00                    2042 	.db 0x00
      0081EB 00                    2043 	.db 0x00
      0081EC 00                    2044 	.db 0x00
      0081ED 00                    2045 	.db 0x00
      0081EE 00                    2046 	.db 0x00
      0081EF 00                    2047 	.db 0x00
      0081F0 00                    2048 	.db 0x00
      0081F1 00                    2049 	.db 0x00
      0081F2 00                    2050 	.db 0x00
      0081F3 00                    2051 	.db 0x00
      0081F4 00                    2052 	.db 0x00
      0081F5 00                    2053 	.db 0x00
      0081F6 00                    2054 	.db 0x00
      0081F7 00                    2055 	.db 0x00
      0081F8 00                    2056 	.db 0x00
      0081F9 00                    2057 	.db 0x00
      0081FA 00                    2058 	.db 0x00
      0081FB 00                    2059 	.db 0x00
      0081FC 00                    2060 	.db 0x00
      0081FD 00                    2061 	.db 0x00
      0081FE 00                    2062 	.db 0x00
      0081FF 00                    2063 	.db 0x00
      008200 00                    2064 	.db 0x00
      008201 00                    2065 	.db 0x00
      008202 00                    2066 	.db 0x00
      008203 00                    2067 	.db 0x00
      008204 00                    2068 	.db 0x00
      008205 00                    2069 	.db 0x00
      008206 00                    2070 	.db 0x00
      008207 00                    2071 	.db 0x00
      008208 00                    2072 	.db 0x00
      008209 00                    2073 	.db 0x00
      00820A 00                    2074 	.db 0x00
      00820B 00                    2075 	.db 0x00
      00820C 00                    2076 	.db 0x00
      00820D 00                    2077 	.db 0x00
      00820E 00                    2078 	.db 0x00
      00820F 00                    2079 	.db 0x00
      008210 00                    2080 	.db 0x00
      008211 00                    2081 	.db 0x00
      008212 00                    2082 	.db 0x00
      008213 00                    2083 	.db 0x00
      008214 00                    2084 	.db 0x00
      008215 00                    2085 	.db 0x00
      008216 00                    2086 	.db 0x00
      008217 00                    2087 	.db 0x00
      008218 00                    2088 	.db 0x00
      008219 00                    2089 	.db 0x00
      00821A 00                    2090 	.db 0x00
      00821B 00                    2091 	.db 0x00
      00821C 00                    2092 	.db 0x00
      00821D 00                    2093 	.db 0x00
      00821E 00                    2094 	.db 0x00
      00821F 00                    2095 	.db 0x00
      008220 00                    2096 	.db 0x00
      008221 00                    2097 	.db 0x00
      008222 00                    2098 	.db 0x00
      008223 00                    2099 	.db 0x00
      008224 00                    2100 	.db 0x00
      008225 00                    2101 	.db 0x00
      008226 00                    2102 	.db 0x00
      008227 00                    2103 	.db 0x00
      008228 00                    2104 	.db 0x00
      008229 00                    2105 	.db 0x00
      00822A 00                    2106 	.db 0x00
      00822B 00                    2107 	.db 0x00
      00822C 00                    2108 	.db 0x00
      00822D 00                    2109 	.db 0x00
      00822E 00                    2110 	.db 0x00
      00822F 00                    2111 	.db 0x00
      008230 00                    2112 	.db 0x00
      008231 00                    2113 	.db 0x00
      008232 00                    2114 	.db 0x00
      008233 00                    2115 	.db 0x00
      008234 00                    2116 	.db 0x00
      008235 00                    2117 	.db 0x00
      008236 00                    2118 	.db 0x00
      008237 00                    2119 	.db 0x00
      008238 00                    2120 	.db 0x00
      008239 00                    2121 	.db 0x00
      00823A 00                    2122 	.db 0x00
      00823B 00                    2123 	.db 0x00
      00823C 00                    2124 	.db 0x00
      00823D 00                    2125 	.db 0x00
      00823E 00                    2126 	.db 0x00
      00823F 00                    2127 	.db 0x00
      008240 00                    2128 	.db 0x00
      008241 00                    2129 	.db 0x00
      008242 00                    2130 	.db 0x00
      008243 00                    2131 	.db 0x00
      008244 00                    2132 	.db 0x00
      008245 00                    2133 	.db 0x00
      008246 00                    2134 	.db 0x00
      008247 00                    2135 	.db 0x00
      008248 00                    2136 	.db 0x00
      008249 00                    2137 	.db 0x00
      00824A 00                    2138 	.db 0x00
      00824B 00                    2139 	.db 0x00
      00824C 00                    2140 	.db 0x00
      00824D 00                    2141 	.db 0x00
      00824E 00                    2142 	.db 0x00
      00824F 00                    2143 	.db 0x00
      008250 00                    2144 	.db 0x00
      008251 00                    2145 	.db 0x00
      008252 00                    2146 	.db 0x00
      008253 00                    2147 	.db 0x00
      008254 00                    2148 	.db 0x00
      008255 00                    2149 	.db 0x00
      008256 00                    2150 	.db 0x00
      008257 00                    2151 	.db 0x00
      008258 00                    2152 	.db 0x00
      008259 00                    2153 	.db 0x00
      00825A 00                    2154 	.db 0x00
      00825B 00                    2155 	.db 0x00
      00825C 00                    2156 	.db 0x00
      00825D 00                    2157 	.db 0x00
      00825E 00                    2158 	.db 0x00
      00825F 00                    2159 	.db 0x00
      008260 00                    2160 	.db 0x00
      008261 00                    2161 	.db 0x00
      008262 00                    2162 	.db 0x00
      008263 00                    2163 	.db 0x00
      008264 00                    2164 	.db 0x00
      008265 00                    2165 	.db 0x00
      008266 00                    2166 	.db 0x00
      008267 00                    2167 	.db 0x00
      008268 00                    2168 	.db 0x00
      008269 00                    2169 	.db 0x00
      00826A 00                    2170 	.db 0x00
      00826B 00                    2171 	.db 0x00
      00826C 00                    2172 	.db 0x00
      00826D 00                    2173 	.db 0x00
      00826E 00                    2174 	.db 0x00
      00826F 00                    2175 	.db 0x00
      008270 00                    2176 	.db 0x00
      008271 00                    2177 	.db 0x00
      008272 00                    2178 	.db 0x00
      008273 00                    2179 	.db 0x00
      008274 00                    2180 	.db 0x00
      008275 00                    2181 	.db 0x00
      008276 00                    2182 	.db 0x00
      008277 00                    2183 	.db 0x00
      008278 00                    2184 	.db 0x00
      008279 00                    2185 	.db 0x00
      00827A 00                    2186 	.db 0x00
      00827B 00                    2187 	.db 0x00
      00827C 00                    2188 	.db 0x00
      00827D 00                    2189 	.db 0x00
      00827E 00                    2190 	.db 0x00
      00827F 00                    2191 	.db 0x00
      008280 00                    2192 	.db 0x00
      008281 00                    2193 	.db 0x00
      008282 00                    2194 	.db 0x00
      008283 00                    2195 	.db 0x00
      008284 00                    2196 	.db 0x00
      008285 00                    2197 	.db 0x00
      008286 00                    2198 	.db 0x00
      008287 00                    2199 	.db 0x00
      008288 00                    2200 	.db 0x00
      008289 00                    2201 	.db 0x00
      00828A 00                    2202 	.db 0x00
      00828B 00                    2203 	.db 0x00
      00828C 00                    2204 	.db 0x00
      00828D 00                    2205 	.db 0x00
      00828E 00                    2206 	.db 0x00
      00828F 00                    2207 	.db 0x00
      008290 00                    2208 	.db 0x00
      008291 00                    2209 	.db 0x00
      008292 00                    2210 	.db 0x00
      008293 00                    2211 	.db 0x00
      008294 00                    2212 	.db 0x00
      008295 00                    2213 	.db 0x00
      008296 00                    2214 	.db 0x00
      008297 00                    2215 	.db 0x00
      008298 00                    2216 	.db 0x00
      008299 00                    2217 	.db 0x00
      00829A 00                    2218 	.db 0x00
      00829B 00                    2219 	.db 0x00
      00829C 00                    2220 	.db 0x00
      00829D 00                    2221 	.db 0x00
      00829E 00                    2222 	.db 0x00
      00829F 00                    2223 	.db 0x00
      0082A0 00                    2224 	.db 0x00
      0082A1 00                    2225 	.db 0x00
      0082A2 00                    2226 	.db 0x00
      0082A3                       2227 __xinit__a:
      0082A3 00                    2228 	.db #0x00	; 0
      0082A4 00                    2229 	.db 0x00
      0082A5 00                    2230 	.db 0x00
      0082A6                       2231 __xinit__d_addr:
      0082A6 00                    2232 	.db #0x00	; 0
      0082A7                       2233 __xinit__p_size:
      0082A7 00                    2234 	.db #0x00	; 0
      0082A8                       2235 __xinit__d_size:
      0082A8 00                    2236 	.db #0x00	; 0
      0082A9                       2237 __xinit__p_bytes:
      0082A9 00                    2238 	.db #0x00	; 0
      0082AA                       2239 __xinit__data_buf:
      0082AA 00                    2240 	.db #0x00	; 0
      0082AB 00                    2241 	.db 0x00
      0082AC 00                    2242 	.db 0x00
      0082AD 00                    2243 	.db 0x00
      0082AE 00                    2244 	.db 0x00
      0082AF 00                    2245 	.db 0x00
      0082B0 00                    2246 	.db 0x00
      0082B1 00                    2247 	.db 0x00
      0082B2 00                    2248 	.db 0x00
      0082B3 00                    2249 	.db 0x00
      0082B4 00                    2250 	.db 0x00
      0082B5 00                    2251 	.db 0x00
      0082B6 00                    2252 	.db 0x00
      0082B7 00                    2253 	.db 0x00
      0082B8 00                    2254 	.db 0x00
      0082B9 00                    2255 	.db 0x00
      0082BA 00                    2256 	.db 0x00
      0082BB 00                    2257 	.db 0x00
      0082BC 00                    2258 	.db 0x00
      0082BD 00                    2259 	.db 0x00
      0082BE 00                    2260 	.db 0x00
      0082BF 00                    2261 	.db 0x00
      0082C0 00                    2262 	.db 0x00
      0082C1 00                    2263 	.db 0x00
      0082C2 00                    2264 	.db 0x00
      0082C3 00                    2265 	.db 0x00
      0082C4 00                    2266 	.db 0x00
      0082C5 00                    2267 	.db 0x00
      0082C6 00                    2268 	.db 0x00
      0082C7 00                    2269 	.db 0x00
      0082C8 00                    2270 	.db 0x00
      0082C9 00                    2271 	.db 0x00
      0082CA 00                    2272 	.db 0x00
      0082CB 00                    2273 	.db 0x00
      0082CC 00                    2274 	.db 0x00
      0082CD 00                    2275 	.db 0x00
      0082CE 00                    2276 	.db 0x00
      0082CF 00                    2277 	.db 0x00
      0082D0 00                    2278 	.db 0x00
      0082D1 00                    2279 	.db 0x00
      0082D2 00                    2280 	.db 0x00
      0082D3 00                    2281 	.db 0x00
      0082D4 00                    2282 	.db 0x00
      0082D5 00                    2283 	.db 0x00
      0082D6 00                    2284 	.db 0x00
      0082D7 00                    2285 	.db 0x00
      0082D8 00                    2286 	.db 0x00
      0082D9 00                    2287 	.db 0x00
      0082DA 00                    2288 	.db 0x00
      0082DB 00                    2289 	.db 0x00
      0082DC 00                    2290 	.db 0x00
      0082DD 00                    2291 	.db 0x00
      0082DE 00                    2292 	.db 0x00
      0082DF 00                    2293 	.db 0x00
      0082E0 00                    2294 	.db 0x00
      0082E1 00                    2295 	.db 0x00
      0082E2 00                    2296 	.db 0x00
      0082E3 00                    2297 	.db 0x00
      0082E4 00                    2298 	.db 0x00
      0082E5 00                    2299 	.db 0x00
      0082E6 00                    2300 	.db 0x00
      0082E7 00                    2301 	.db 0x00
      0082E8 00                    2302 	.db 0x00
      0082E9 00                    2303 	.db 0x00
      0082EA 00                    2304 	.db 0x00
      0082EB 00                    2305 	.db 0x00
      0082EC 00                    2306 	.db 0x00
      0082ED 00                    2307 	.db 0x00
      0082EE 00                    2308 	.db 0x00
      0082EF 00                    2309 	.db 0x00
      0082F0 00                    2310 	.db 0x00
      0082F1 00                    2311 	.db 0x00
      0082F2 00                    2312 	.db 0x00
      0082F3 00                    2313 	.db 0x00
      0082F4 00                    2314 	.db 0x00
      0082F5 00                    2315 	.db 0x00
      0082F6 00                    2316 	.db 0x00
      0082F7 00                    2317 	.db 0x00
      0082F8 00                    2318 	.db 0x00
      0082F9 00                    2319 	.db 0x00
      0082FA 00                    2320 	.db 0x00
      0082FB 00                    2321 	.db 0x00
      0082FC 00                    2322 	.db 0x00
      0082FD 00                    2323 	.db 0x00
      0082FE 00                    2324 	.db 0x00
      0082FF 00                    2325 	.db 0x00
      008300 00                    2326 	.db 0x00
      008301 00                    2327 	.db 0x00
      008302 00                    2328 	.db 0x00
      008303 00                    2329 	.db 0x00
      008304 00                    2330 	.db 0x00
      008305 00                    2331 	.db 0x00
      008306 00                    2332 	.db 0x00
      008307 00                    2333 	.db 0x00
      008308 00                    2334 	.db 0x00
      008309 00                    2335 	.db 0x00
      00830A 00                    2336 	.db 0x00
      00830B 00                    2337 	.db 0x00
      00830C 00                    2338 	.db 0x00
      00830D 00                    2339 	.db 0x00
      00830E 00                    2340 	.db 0x00
      00830F 00                    2341 	.db 0x00
      008310 00                    2342 	.db 0x00
      008311 00                    2343 	.db 0x00
      008312 00                    2344 	.db 0x00
      008313 00                    2345 	.db 0x00
      008314 00                    2346 	.db 0x00
      008315 00                    2347 	.db 0x00
      008316 00                    2348 	.db 0x00
      008317 00                    2349 	.db 0x00
      008318 00                    2350 	.db 0x00
      008319 00                    2351 	.db 0x00
      00831A 00                    2352 	.db 0x00
      00831B 00                    2353 	.db 0x00
      00831C 00                    2354 	.db 0x00
      00831D 00                    2355 	.db 0x00
      00831E 00                    2356 	.db 0x00
      00831F 00                    2357 	.db 0x00
      008320 00                    2358 	.db 0x00
      008321 00                    2359 	.db 0x00
      008322 00                    2360 	.db 0x00
      008323 00                    2361 	.db 0x00
      008324 00                    2362 	.db 0x00
      008325 00                    2363 	.db 0x00
      008326 00                    2364 	.db 0x00
      008327 00                    2365 	.db 0x00
      008328 00                    2366 	.db 0x00
      008329 00                    2367 	.db 0x00
      00832A 00                    2368 	.db 0x00
      00832B 00                    2369 	.db 0x00
      00832C 00                    2370 	.db 0x00
      00832D 00                    2371 	.db 0x00
      00832E 00                    2372 	.db 0x00
      00832F 00                    2373 	.db 0x00
      008330 00                    2374 	.db 0x00
      008331 00                    2375 	.db 0x00
      008332 00                    2376 	.db 0x00
      008333 00                    2377 	.db 0x00
      008334 00                    2378 	.db 0x00
      008335 00                    2379 	.db 0x00
      008336 00                    2380 	.db 0x00
      008337 00                    2381 	.db 0x00
      008338 00                    2382 	.db 0x00
      008339 00                    2383 	.db 0x00
      00833A 00                    2384 	.db 0x00
      00833B 00                    2385 	.db 0x00
      00833C 00                    2386 	.db 0x00
      00833D 00                    2387 	.db 0x00
      00833E 00                    2388 	.db 0x00
      00833F 00                    2389 	.db 0x00
      008340 00                    2390 	.db 0x00
      008341 00                    2391 	.db 0x00
      008342 00                    2392 	.db 0x00
      008343 00                    2393 	.db 0x00
      008344 00                    2394 	.db 0x00
      008345 00                    2395 	.db 0x00
      008346 00                    2396 	.db 0x00
      008347 00                    2397 	.db 0x00
      008348 00                    2398 	.db 0x00
      008349 00                    2399 	.db 0x00
      00834A 00                    2400 	.db 0x00
      00834B 00                    2401 	.db 0x00
      00834C 00                    2402 	.db 0x00
      00834D 00                    2403 	.db 0x00
      00834E 00                    2404 	.db 0x00
      00834F 00                    2405 	.db 0x00
      008350 00                    2406 	.db 0x00
      008351 00                    2407 	.db 0x00
      008352 00                    2408 	.db 0x00
      008353 00                    2409 	.db 0x00
      008354 00                    2410 	.db 0x00
      008355 00                    2411 	.db 0x00
      008356 00                    2412 	.db 0x00
      008357 00                    2413 	.db 0x00
      008358 00                    2414 	.db 0x00
      008359 00                    2415 	.db 0x00
      00835A 00                    2416 	.db 0x00
      00835B 00                    2417 	.db 0x00
      00835C 00                    2418 	.db 0x00
      00835D 00                    2419 	.db 0x00
      00835E 00                    2420 	.db 0x00
      00835F 00                    2421 	.db 0x00
      008360 00                    2422 	.db 0x00
      008361 00                    2423 	.db 0x00
      008362 00                    2424 	.db 0x00
      008363 00                    2425 	.db 0x00
      008364 00                    2426 	.db 0x00
      008365 00                    2427 	.db 0x00
      008366 00                    2428 	.db 0x00
      008367 00                    2429 	.db 0x00
      008368 00                    2430 	.db 0x00
      008369 00                    2431 	.db 0x00
      00836A 00                    2432 	.db 0x00
      00836B 00                    2433 	.db 0x00
      00836C 00                    2434 	.db 0x00
      00836D 00                    2435 	.db 0x00
      00836E 00                    2436 	.db 0x00
      00836F 00                    2437 	.db 0x00
      008370 00                    2438 	.db 0x00
      008371 00                    2439 	.db 0x00
      008372 00                    2440 	.db 0x00
      008373 00                    2441 	.db 0x00
      008374 00                    2442 	.db 0x00
      008375 00                    2443 	.db 0x00
      008376 00                    2444 	.db 0x00
      008377 00                    2445 	.db 0x00
      008378 00                    2446 	.db 0x00
      008379 00                    2447 	.db 0x00
      00837A 00                    2448 	.db 0x00
      00837B 00                    2449 	.db 0x00
      00837C 00                    2450 	.db 0x00
      00837D 00                    2451 	.db 0x00
      00837E 00                    2452 	.db 0x00
      00837F 00                    2453 	.db 0x00
      008380 00                    2454 	.db 0x00
      008381 00                    2455 	.db 0x00
      008382 00                    2456 	.db 0x00
      008383 00                    2457 	.db 0x00
      008384 00                    2458 	.db 0x00
      008385 00                    2459 	.db 0x00
      008386 00                    2460 	.db 0x00
      008387 00                    2461 	.db 0x00
      008388 00                    2462 	.db 0x00
      008389 00                    2463 	.db 0x00
      00838A 00                    2464 	.db 0x00
      00838B 00                    2465 	.db 0x00
      00838C 00                    2466 	.db 0x00
      00838D 00                    2467 	.db 0x00
      00838E 00                    2468 	.db 0x00
      00838F 00                    2469 	.db 0x00
      008390 00                    2470 	.db 0x00
      008391 00                    2471 	.db 0x00
      008392 00                    2472 	.db 0x00
      008393 00                    2473 	.db 0x00
      008394 00                    2474 	.db 0x00
      008395 00                    2475 	.db 0x00
      008396 00                    2476 	.db 0x00
      008397 00                    2477 	.db 0x00
      008398 00                    2478 	.db 0x00
      008399 00                    2479 	.db 0x00
      00839A 00                    2480 	.db 0x00
      00839B 00                    2481 	.db 0x00
      00839C 00                    2482 	.db 0x00
      00839D 00                    2483 	.db 0x00
      00839E 00                    2484 	.db 0x00
      00839F 00                    2485 	.db 0x00
      0083A0 00                    2486 	.db 0x00
      0083A1 00                    2487 	.db 0x00
      0083A2 00                    2488 	.db 0x00
      0083A3 00                    2489 	.db 0x00
      0083A4 00                    2490 	.db 0x00
      0083A5 00                    2491 	.db 0x00
      0083A6 00                    2492 	.db 0x00
      0083A7 00                    2493 	.db 0x00
      0083A8 00                    2494 	.db 0x00
      0083A9 00                    2495 	.db 0x00
      0083AA                       2496 __xinit__current_dev:
      0083AA 00                    2497 	.db #0x00	; 0
                                   2498 	.area CABS (ABS)
