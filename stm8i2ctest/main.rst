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
      008007 CD 8B A3         [ 4]  114 	call	___sdcc_external_startup
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
      008021 D6 80 B1         [ 1]  130 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 8A D6         [ 2]  144 	jp	_main
                                    145 ;	return from main will return to caller
                                    146 ;--------------------------------------------------------
                                    147 ; code
                                    148 ;--------------------------------------------------------
                                    149 	.area CODE
                                    150 ;	main.c: 27: void delay(unsigned long count) {
                                    151 ;	-----------------------------------------
                                    152 ;	 function delay
                                    153 ;	-----------------------------------------
      0083BA                        154 _delay:
      0083BA 52 08            [ 2]  155 	sub	sp, #8
                                    156 ;	main.c: 28: while (count--)
      0083BC 16 0D            [ 2]  157 	ldw	y, (0x0d, sp)
      0083BE 17 07            [ 2]  158 	ldw	(0x07, sp), y
      0083C0 1E 0B            [ 2]  159 	ldw	x, (0x0b, sp)
      0083C2                        160 00101$:
      0083C2 1F 01            [ 2]  161 	ldw	(0x01, sp), x
      0083C4 7B 07            [ 1]  162 	ld	a, (0x07, sp)
      0083C6 6B 03            [ 1]  163 	ld	(0x03, sp), a
      0083C8 7B 08            [ 1]  164 	ld	a, (0x08, sp)
      0083CA 16 07            [ 2]  165 	ldw	y, (0x07, sp)
      0083CC 72 A2 00 01      [ 2]  166 	subw	y, #0x0001
      0083D0 17 07            [ 2]  167 	ldw	(0x07, sp), y
      0083D2 24 01            [ 1]  168 	jrnc	00117$
      0083D4 5A               [ 2]  169 	decw	x
      0083D5                        170 00117$:
      0083D5 4D               [ 1]  171 	tnz	a
      0083D6 26 08            [ 1]  172 	jrne	00118$
      0083D8 16 02            [ 2]  173 	ldw	y, (0x02, sp)
      0083DA 26 04            [ 1]  174 	jrne	00118$
      0083DC 0D 01            [ 1]  175 	tnz	(0x01, sp)
      0083DE 27 03            [ 1]  176 	jreq	00104$
      0083E0                        177 00118$:
                                    178 ;	main.c: 29: nop();
      0083E0 9D               [ 1]  179 	nop
      0083E1 20 DF            [ 2]  180 	jra	00101$
      0083E3                        181 00104$:
                                    182 ;	main.c: 30: }
      0083E3 1E 09            [ 2]  183 	ldw	x, (9, sp)
      0083E5 5B 0E            [ 2]  184 	addw	sp, #14
      0083E7 FC               [ 2]  185 	jp	(x)
                                    186 ;	main.c: 38: void UART_TX(unsigned char value)
                                    187 ;	-----------------------------------------
                                    188 ;	 function UART_TX
                                    189 ;	-----------------------------------------
      0083E8                        190 _UART_TX:
                                    191 ;	main.c: 40: UART1_DR = value;
      0083E8 C7 52 31         [ 1]  192 	ld	0x5231, a
                                    193 ;	main.c: 41: while(!(UART1_SR & UART_SR_TXE));
      0083EB                        194 00101$:
      0083EB C6 52 30         [ 1]  195 	ld	a, 0x5230
      0083EE 2A FB            [ 1]  196 	jrpl	00101$
                                    197 ;	main.c: 42: }
      0083F0 81               [ 4]  198 	ret
                                    199 ;	main.c: 44: int uart_write(const char *str) {
                                    200 ;	-----------------------------------------
                                    201 ;	 function uart_write
                                    202 ;	-----------------------------------------
      0083F1                        203 _uart_write:
      0083F1 52 05            [ 2]  204 	sub	sp, #5
      0083F3 1F 03            [ 2]  205 	ldw	(0x03, sp), x
                                    206 ;	main.c: 46: for(i = 0; i < strlen(str); i++) {
      0083F5 0F 05            [ 1]  207 	clr	(0x05, sp)
      0083F7                        208 00103$:
      0083F7 1E 03            [ 2]  209 	ldw	x, (0x03, sp)
      0083F9 CD 8B A5         [ 4]  210 	call	_strlen
      0083FC 1F 01            [ 2]  211 	ldw	(0x01, sp), x
      0083FE 7B 05            [ 1]  212 	ld	a, (0x05, sp)
      008400 5F               [ 1]  213 	clrw	x
      008401 97               [ 1]  214 	ld	xl, a
      008402 13 01            [ 2]  215 	cpw	x, (0x01, sp)
      008404 24 0F            [ 1]  216 	jrnc	00101$
                                    217 ;	main.c: 48: UART_TX(str[i]);
      008406 5F               [ 1]  218 	clrw	x
      008407 7B 05            [ 1]  219 	ld	a, (0x05, sp)
      008409 97               [ 1]  220 	ld	xl, a
      00840A 72 FB 03         [ 2]  221 	addw	x, (0x03, sp)
      00840D F6               [ 1]  222 	ld	a, (x)
      00840E CD 83 E8         [ 4]  223 	call	_UART_TX
                                    224 ;	main.c: 46: for(i = 0; i < strlen(str); i++) {
      008411 0C 05            [ 1]  225 	inc	(0x05, sp)
      008413 20 E2            [ 2]  226 	jra	00103$
      008415                        227 00101$:
                                    228 ;	main.c: 51: return(i); // Bytes sent
      008415 7B 05            [ 1]  229 	ld	a, (0x05, sp)
      008417 5F               [ 1]  230 	clrw	x
      008418 97               [ 1]  231 	ld	xl, a
                                    232 ;	main.c: 52: }
      008419 5B 05            [ 2]  233 	addw	sp, #5
      00841B 81               [ 4]  234 	ret
                                    235 ;	main.c: 53: unsigned char UART_RX(void)
                                    236 ;	-----------------------------------------
                                    237 ;	 function UART_RX
                                    238 ;	-----------------------------------------
      00841C                        239 _UART_RX:
                                    240 ;	main.c: 56: while(!(UART1_SR & UART_SR_TXE));
      00841C                        241 00101$:
      00841C C6 52 30         [ 1]  242 	ld	a, 0x5230
      00841F 2A FB            [ 1]  243 	jrpl	00101$
                                    244 ;	main.c: 58: return UART1_DR;
      008421 C6 52 31         [ 1]  245 	ld	a, 0x5231
                                    246 ;	main.c: 59: }
      008424 81               [ 4]  247 	ret
                                    248 ;	main.c: 60: int uart_read(void)
                                    249 ;	-----------------------------------------
                                    250 ;	 function uart_read
                                    251 ;	-----------------------------------------
      008425                        252 _uart_read:
                                    253 ;	main.c: 63: memset(buffer, 0, sizeof(buffer));
      008425 4B 00            [ 1]  254 	push	#0x00
      008427 4B 01            [ 1]  255 	push	#0x01
      008429 5F               [ 1]  256 	clrw	x
      00842A 89               [ 2]  257 	pushw	x
      00842B AE 01 01         [ 2]  258 	ldw	x, #(_buffer+0)
      00842E CD 8B 81         [ 4]  259 	call	_memset
                                    260 ;	main.c: 66: while(i<256)
      008431 5F               [ 1]  261 	clrw	x
      008432                        262 00105$:
      008432 A3 01 00         [ 2]  263 	cpw	x, #0x0100
      008435 2E 22            [ 1]  264 	jrsge	00107$
                                    265 ;	main.c: 69: if(UART1_SR & UART_SR_RXNE)
      008437 C6 52 30         [ 1]  266 	ld	a, 0x5230
      00843A A5 20            [ 1]  267 	bcp	a, #0x20
      00843C 27 F4            [ 1]  268 	jreq	00105$
                                    269 ;	main.c: 72: buffer[i] = UART_RX();
      00843E 90 93            [ 1]  270 	ldw	y, x
      008440 72 A9 01 01      [ 2]  271 	addw	y, #(_buffer+0)
      008444 89               [ 2]  272 	pushw	x
      008445 90 89            [ 2]  273 	pushw	y
      008447 CD 84 1C         [ 4]  274 	call	_UART_RX
      00844A 90 85            [ 2]  275 	popw	y
      00844C 85               [ 2]  276 	popw	x
      00844D 90 F7            [ 1]  277 	ld	(y), a
                                    278 ;	main.c: 73: if(buffer[i] == '\r\n' )
      00844F A1 0D            [ 1]  279 	cp	a, #0x0d
      008451 26 03            [ 1]  280 	jrne	00102$
                                    281 ;	main.c: 75: return 1;
      008453 5F               [ 1]  282 	clrw	x
      008454 5C               [ 1]  283 	incw	x
      008455 81               [ 4]  284 	ret
                                    285 ;	main.c: 76: break;
      008456                        286 00102$:
                                    287 ;	main.c: 78: i++;
      008456 5C               [ 1]  288 	incw	x
      008457 20 D9            [ 2]  289 	jra	00105$
      008459                        290 00107$:
                                    291 ;	main.c: 82: return 0;
      008459 5F               [ 1]  292 	clrw	x
                                    293 ;	main.c: 83: }
      00845A 81               [ 4]  294 	ret
                                    295 ;	main.c: 92: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    296 ;	-----------------------------------------
                                    297 ;	 function convert_int_to_chars
                                    298 ;	-----------------------------------------
      00845B                        299 _convert_int_to_chars:
      00845B 52 0D            [ 2]  300 	sub	sp, #13
      00845D 6B 0D            [ 1]  301 	ld	(0x0d, sp), a
      00845F 1F 0B            [ 2]  302 	ldw	(0x0b, sp), x
                                    303 ;	main.c: 95: rx_int_chars[0] = num / 100 + '0';
      008461 7B 0D            [ 1]  304 	ld	a, (0x0d, sp)
      008463 6B 02            [ 1]  305 	ld	(0x02, sp), a
      008465 0F 01            [ 1]  306 	clr	(0x01, sp)
                                    307 ;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
      008467 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      008469 5C               [ 1]  309 	incw	x
      00846A 1F 03            [ 2]  310 	ldw	(0x03, sp), x
                                    311 ;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
      00846C 1E 0B            [ 2]  312 	ldw	x, (0x0b, sp)
      00846E 5C               [ 1]  313 	incw	x
      00846F 5C               [ 1]  314 	incw	x
      008470 1F 05            [ 2]  315 	ldw	(0x05, sp), x
                                    316 ;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
      008472 4B 0A            [ 1]  317 	push	#0x0a
      008474 4B 00            [ 1]  318 	push	#0x00
      008476 1E 03            [ 2]  319 	ldw	x, (0x03, sp)
                                    320 ;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
      008478 CD 8B CA         [ 4]  321 	call	__divsint
      00847B 1F 07            [ 2]  322 	ldw	(0x07, sp), x
      00847D 4B 0A            [ 1]  323 	push	#0x0a
      00847F 4B 00            [ 1]  324 	push	#0x00
      008481 1E 03            [ 2]  325 	ldw	x, (0x03, sp)
      008483 CD 8B B2         [ 4]  326 	call	__modsint
      008486 9F               [ 1]  327 	ld	a, xl
      008487 AB 30            [ 1]  328 	add	a, #0x30
      008489 6B 09            [ 1]  329 	ld	(0x09, sp), a
                                    330 ;	main.c: 93: if (num > 99) {
      00848B 7B 0D            [ 1]  331 	ld	a, (0x0d, sp)
      00848D A1 63            [ 1]  332 	cp	a, #0x63
      00848F 23 29            [ 2]  333 	jrule	00105$
                                    334 ;	main.c: 95: rx_int_chars[0] = num / 100 + '0';
      008491 4B 64            [ 1]  335 	push	#0x64
      008493 4B 00            [ 1]  336 	push	#0x00
      008495 1E 03            [ 2]  337 	ldw	x, (0x03, sp)
      008497 CD 8B CA         [ 4]  338 	call	__divsint
      00849A 9F               [ 1]  339 	ld	a, xl
      00849B AB 30            [ 1]  340 	add	a, #0x30
      00849D 1E 0B            [ 2]  341 	ldw	x, (0x0b, sp)
      00849F F7               [ 1]  342 	ld	(x), a
                                    343 ;	main.c: 96: rx_int_chars[1] = num / 10 % 10 + '0';
      0084A0 4B 0A            [ 1]  344 	push	#0x0a
      0084A2 4B 00            [ 1]  345 	push	#0x00
      0084A4 1E 09            [ 2]  346 	ldw	x, (0x09, sp)
      0084A6 CD 8B B2         [ 4]  347 	call	__modsint
      0084A9 9F               [ 1]  348 	ld	a, xl
      0084AA AB 30            [ 1]  349 	add	a, #0x30
      0084AC 1E 03            [ 2]  350 	ldw	x, (0x03, sp)
      0084AE F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 97: rx_int_chars[2] = num % 10 + '0';
      0084AF 1E 05            [ 2]  353 	ldw	x, (0x05, sp)
      0084B1 7B 09            [ 1]  354 	ld	a, (0x09, sp)
      0084B3 F7               [ 1]  355 	ld	(x), a
                                    356 ;	main.c: 98: rx_int_chars[3] ='\0';
      0084B4 1E 0B            [ 2]  357 	ldw	x, (0x0b, sp)
      0084B6 6F 03            [ 1]  358 	clr	(0x0003, x)
      0084B8 20 23            [ 2]  359 	jra	00107$
      0084BA                        360 00105$:
                                    361 ;	main.c: 100: } else if (num > 9) {
      0084BA 7B 0D            [ 1]  362 	ld	a, (0x0d, sp)
      0084BC A1 09            [ 1]  363 	cp	a, #0x09
      0084BE 23 13            [ 2]  364 	jrule	00102$
                                    365 ;	main.c: 102: rx_int_chars[0] = num / 10 + '0';
      0084C0 7B 08            [ 1]  366 	ld	a, (0x08, sp)
      0084C2 6B 0A            [ 1]  367 	ld	(0x0a, sp), a
      0084C4 AB 30            [ 1]  368 	add	a, #0x30
      0084C6 1E 0B            [ 2]  369 	ldw	x, (0x0b, sp)
      0084C8 F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 103: rx_int_chars[1] = num % 10 + '0';
      0084C9 1E 03            [ 2]  372 	ldw	x, (0x03, sp)
      0084CB 7B 09            [ 1]  373 	ld	a, (0x09, sp)
      0084CD F7               [ 1]  374 	ld	(x), a
                                    375 ;	main.c: 104: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      0084CE 1E 05            [ 2]  376 	ldw	x, (0x05, sp)
      0084D0 7F               [ 1]  377 	clr	(x)
      0084D1 20 0A            [ 2]  378 	jra	00107$
      0084D3                        379 00102$:
                                    380 ;	main.c: 107: rx_int_chars[0] = num + '0';
      0084D3 7B 0D            [ 1]  381 	ld	a, (0x0d, sp)
      0084D5 AB 30            [ 1]  382 	add	a, #0x30
      0084D7 1E 0B            [ 2]  383 	ldw	x, (0x0b, sp)
      0084D9 F7               [ 1]  384 	ld	(x), a
                                    385 ;	main.c: 108: rx_int_chars[1] ='\0';
      0084DA 1E 03            [ 2]  386 	ldw	x, (0x03, sp)
      0084DC 7F               [ 1]  387 	clr	(x)
      0084DD                        388 00107$:
                                    389 ;	main.c: 110: }
      0084DD 5B 0D            [ 2]  390 	addw	sp, #13
      0084DF 81               [ 4]  391 	ret
                                    392 ;	main.c: 112: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    393 ;	-----------------------------------------
                                    394 ;	 function convert_chars_to_int
                                    395 ;	-----------------------------------------
      0084E0                        396 _convert_chars_to_int:
      0084E0 52 03            [ 2]  397 	sub	sp, #3
      0084E2 1F 02            [ 2]  398 	ldw	(0x02, sp), x
                                    399 ;	main.c: 113: uint8_t result = 0;
      0084E4 4F               [ 1]  400 	clr	a
                                    401 ;	main.c: 115: for (int o = 0; o < i; o++) {
      0084E5 5F               [ 1]  402 	clrw	x
      0084E6                        403 00103$:
      0084E6 13 06            [ 2]  404 	cpw	x, (0x06, sp)
      0084E8 2E 18            [ 1]  405 	jrsge	00101$
                                    406 ;	main.c: 117: result = (result * 10) + (rx_chars_int[o] - '0');
      0084EA 90 97            [ 1]  407 	ld	yl, a
      0084EC A6 0A            [ 1]  408 	ld	a, #0x0a
      0084EE 90 42            [ 4]  409 	mul	y, a
      0084F0 61               [ 1]  410 	exg	a, yl
      0084F1 6B 01            [ 1]  411 	ld	(0x01, sp), a
      0084F3 61               [ 1]  412 	exg	a, yl
      0084F4 90 93            [ 1]  413 	ldw	y, x
      0084F6 72 F9 02         [ 2]  414 	addw	y, (0x02, sp)
      0084F9 90 F6            [ 1]  415 	ld	a, (y)
      0084FB A0 30            [ 1]  416 	sub	a, #0x30
      0084FD 1B 01            [ 1]  417 	add	a, (0x01, sp)
                                    418 ;	main.c: 115: for (int o = 0; o < i; o++) {
      0084FF 5C               [ 1]  419 	incw	x
      008500 20 E4            [ 2]  420 	jra	00103$
      008502                        421 00101$:
                                    422 ;	main.c: 120: return result;
                                    423 ;	main.c: 121: }
      008502 1E 04            [ 2]  424 	ldw	x, (4, sp)
      008504 5B 07            [ 2]  425 	addw	sp, #7
      008506 FC               [ 2]  426 	jp	(x)
                                    427 ;	main.c: 124: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    428 ;	-----------------------------------------
                                    429 ;	 function convert_int_to_binary
                                    430 ;	-----------------------------------------
      008507                        431 _convert_int_to_binary:
      008507 52 04            [ 2]  432 	sub	sp, #4
      008509 1F 01            [ 2]  433 	ldw	(0x01, sp), x
                                    434 ;	main.c: 126: for(int i = 7; i >= 0; i--) {
      00850B AE 00 07         [ 2]  435 	ldw	x, #0x0007
      00850E 1F 03            [ 2]  436 	ldw	(0x03, sp), x
      008510                        437 00103$:
      008510 0D 03            [ 1]  438 	tnz	(0x03, sp)
      008512 2B 22            [ 1]  439 	jrmi	00101$
                                    440 ;	main.c: 128: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008514 AE 00 07         [ 2]  441 	ldw	x, #0x0007
      008517 72 F0 03         [ 2]  442 	subw	x, (0x03, sp)
      00851A 72 FB 07         [ 2]  443 	addw	x, (0x07, sp)
      00851D 16 01            [ 2]  444 	ldw	y, (0x01, sp)
      00851F 7B 04            [ 1]  445 	ld	a, (0x04, sp)
      008521 27 05            [ 1]  446 	jreq	00120$
      008523                        447 00119$:
      008523 90 57            [ 2]  448 	sraw	y
      008525 4A               [ 1]  449 	dec	a
      008526 26 FB            [ 1]  450 	jrne	00119$
      008528                        451 00120$:
      008528 90 9F            [ 1]  452 	ld	a, yl
      00852A A4 01            [ 1]  453 	and	a, #0x01
      00852C AB 30            [ 1]  454 	add	a, #0x30
      00852E F7               [ 1]  455 	ld	(x), a
                                    456 ;	main.c: 126: for(int i = 7; i >= 0; i--) {
      00852F 1E 03            [ 2]  457 	ldw	x, (0x03, sp)
      008531 5A               [ 2]  458 	decw	x
      008532 1F 03            [ 2]  459 	ldw	(0x03, sp), x
      008534 20 DA            [ 2]  460 	jra	00103$
      008536                        461 00101$:
                                    462 ;	main.c: 130: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008536 1E 07            [ 2]  463 	ldw	x, (0x07, sp)
      008538 6F 08            [ 1]  464 	clr	(0x0008, x)
                                    465 ;	main.c: 131: }
      00853A 1E 05            [ 2]  466 	ldw	x, (5, sp)
      00853C 5B 08            [ 2]  467 	addw	sp, #8
      00853E FC               [ 2]  468 	jp	(x)
                                    469 ;	main.c: 140: void get_addr_from_buff(void)
                                    470 ;	-----------------------------------------
                                    471 ;	 function get_addr_from_buff
                                    472 ;	-----------------------------------------
      00853F                        473 _get_addr_from_buff:
      00853F 52 02            [ 2]  474 	sub	sp, #2
                                    475 ;	main.c: 144: while(1)
      008541 A6 03            [ 1]  476 	ld	a, #0x03
      008543 6B 01            [ 1]  477 	ld	(0x01, sp), a
      008545 0F 02            [ 1]  478 	clr	(0x02, sp)
      008547                        479 00105$:
                                    480 ;	main.c: 146: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008547 5F               [ 1]  481 	clrw	x
      008548 7B 01            [ 1]  482 	ld	a, (0x01, sp)
      00854A 97               [ 1]  483 	ld	xl, a
      00854B D6 01 01         [ 1]  484 	ld	a, (_buffer+0, x)
      00854E A1 20            [ 1]  485 	cp	a, #0x20
      008550 27 04            [ 1]  486 	jreq	00101$
      008552 A1 0D            [ 1]  487 	cp	a, #0x0d
      008554 26 08            [ 1]  488 	jrne	00102$
      008556                        489 00101$:
                                    490 ;	main.c: 148: p_size = i+1;
      008556 7B 01            [ 1]  491 	ld	a, (0x01, sp)
      008558 4C               [ 1]  492 	inc	a
      008559 C7 02 05         [ 1]  493 	ld	_p_size+0, a
                                    494 ;	main.c: 149: break;
      00855C 20 06            [ 2]  495 	jra	00106$
      00855E                        496 00102$:
                                    497 ;	main.c: 151: i++;
      00855E 0C 01            [ 1]  498 	inc	(0x01, sp)
                                    499 ;	main.c: 152: counter++;
      008560 0C 02            [ 1]  500 	inc	(0x02, sp)
      008562 20 E3            [ 2]  501 	jra	00105$
      008564                        502 00106$:
                                    503 ;	main.c: 154: memcpy(a, &buffer[3], counter);
      008564 5F               [ 1]  504 	clrw	x
      008565 7B 02            [ 1]  505 	ld	a, (0x02, sp)
      008567 97               [ 1]  506 	ld	xl, a
      008568 89               [ 2]  507 	pushw	x
      008569 4B 04            [ 1]  508 	push	#<(_buffer+3)
      00856B 4B 01            [ 1]  509 	push	#((_buffer+3) >> 8)
      00856D AE 02 01         [ 2]  510 	ldw	x, #(_a+0)
      008570 CD 8B 2E         [ 4]  511 	call	___memcpy
                                    512 ;	main.c: 155: d_addr = convert_chars_to_int(a, counter);
      008573 5F               [ 1]  513 	clrw	x
      008574 7B 02            [ 1]  514 	ld	a, (0x02, sp)
      008576 97               [ 1]  515 	ld	xl, a
      008577 89               [ 2]  516 	pushw	x
      008578 AE 02 01         [ 2]  517 	ldw	x, #(_a+0)
      00857B CD 84 E0         [ 4]  518 	call	_convert_chars_to_int
      00857E C7 02 04         [ 1]  519 	ld	_d_addr+0, a
                                    520 ;	main.c: 156: }
      008581 5B 02            [ 2]  521 	addw	sp, #2
      008583 81               [ 4]  522 	ret
                                    523 ;	main.c: 158: void get_size_from_buff(void)
                                    524 ;	-----------------------------------------
                                    525 ;	 function get_size_from_buff
                                    526 ;	-----------------------------------------
      008584                        527 _get_size_from_buff:
      008584 52 02            [ 2]  528 	sub	sp, #2
                                    529 ;	main.c: 160: memset(a, 0, sizeof(a));
      008586 4B 03            [ 1]  530 	push	#0x03
      008588 4B 00            [ 1]  531 	push	#0x00
      00858A 5F               [ 1]  532 	clrw	x
      00858B 89               [ 2]  533 	pushw	x
      00858C AE 02 01         [ 2]  534 	ldw	x, #(_a+0)
      00858F CD 8B 81         [ 4]  535 	call	_memset
                                    536 ;	main.c: 162: uint8_t i = p_size;
      008592 C6 02 05         [ 1]  537 	ld	a, _p_size+0
      008595 6B 01            [ 1]  538 	ld	(0x01, sp), a
                                    539 ;	main.c: 163: while(1)
      008597 0F 02            [ 1]  540 	clr	(0x02, sp)
      008599                        541 00105$:
                                    542 ;	main.c: 165: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008599 5F               [ 1]  543 	clrw	x
      00859A 7B 01            [ 1]  544 	ld	a, (0x01, sp)
      00859C 97               [ 1]  545 	ld	xl, a
      00859D D6 01 01         [ 1]  546 	ld	a, (_buffer+0, x)
      0085A0 A1 20            [ 1]  547 	cp	a, #0x20
      0085A2 27 04            [ 1]  548 	jreq	00101$
      0085A4 A1 0D            [ 1]  549 	cp	a, #0x0d
      0085A6 26 08            [ 1]  550 	jrne	00102$
      0085A8                        551 00101$:
                                    552 ;	main.c: 168: p_bytes = i+1;
      0085A8 7B 01            [ 1]  553 	ld	a, (0x01, sp)
      0085AA 4C               [ 1]  554 	inc	a
      0085AB C7 02 07         [ 1]  555 	ld	_p_bytes+0, a
                                    556 ;	main.c: 169: break;
      0085AE 20 06            [ 2]  557 	jra	00106$
      0085B0                        558 00102$:
                                    559 ;	main.c: 171: i++;
      0085B0 0C 01            [ 1]  560 	inc	(0x01, sp)
                                    561 ;	main.c: 172: counter++;
      0085B2 0C 02            [ 1]  562 	inc	(0x02, sp)
      0085B4 20 E3            [ 2]  563 	jra	00105$
      0085B6                        564 00106$:
                                    565 ;	main.c: 175: memcpy(a, &buffer[p_size], counter);
      0085B6 90 5F            [ 1]  566 	clrw	y
      0085B8 7B 02            [ 1]  567 	ld	a, (0x02, sp)
      0085BA 90 97            [ 1]  568 	ld	yl, a
      0085BC 5F               [ 1]  569 	clrw	x
      0085BD C6 02 05         [ 1]  570 	ld	a, _p_size+0
      0085C0 97               [ 1]  571 	ld	xl, a
      0085C1 1C 01 01         [ 2]  572 	addw	x, #(_buffer+0)
      0085C4 90 89            [ 2]  573 	pushw	y
      0085C6 89               [ 2]  574 	pushw	x
      0085C7 AE 02 01         [ 2]  575 	ldw	x, #(_a+0)
      0085CA CD 8B 2E         [ 4]  576 	call	___memcpy
                                    577 ;	main.c: 176: d_size = convert_chars_to_int(a, counter);
      0085CD 5F               [ 1]  578 	clrw	x
      0085CE 7B 02            [ 1]  579 	ld	a, (0x02, sp)
      0085D0 97               [ 1]  580 	ld	xl, a
      0085D1 89               [ 2]  581 	pushw	x
      0085D2 AE 02 01         [ 2]  582 	ldw	x, #(_a+0)
      0085D5 CD 84 E0         [ 4]  583 	call	_convert_chars_to_int
      0085D8 C7 02 06         [ 1]  584 	ld	_d_size+0, a
                                    585 ;	main.c: 177: }
      0085DB 5B 02            [ 2]  586 	addw	sp, #2
      0085DD 81               [ 4]  587 	ret
                                    588 ;	main.c: 178: void char_buffer_to_int(void)
                                    589 ;	-----------------------------------------
                                    590 ;	 function char_buffer_to_int
                                    591 ;	-----------------------------------------
      0085DE                        592 _char_buffer_to_int:
      0085DE 52 08            [ 2]  593 	sub	sp, #8
                                    594 ;	main.c: 180: memset(a, 0, sizeof(a));
      0085E0 4B 03            [ 1]  595 	push	#0x03
      0085E2 4B 00            [ 1]  596 	push	#0x00
      0085E4 5F               [ 1]  597 	clrw	x
      0085E5 89               [ 2]  598 	pushw	x
      0085E6 AE 02 01         [ 2]  599 	ldw	x, #(_a+0)
      0085E9 CD 8B 81         [ 4]  600 	call	_memset
                                    601 ;	main.c: 181: uint8_t counter = d_size;
      0085EC C6 02 06         [ 1]  602 	ld	a, _d_size+0
      0085EF 6B 01            [ 1]  603 	ld	(0x01, sp), a
                                    604 ;	main.c: 182: uint8_t i = p_bytes;
      0085F1 C6 02 07         [ 1]  605 	ld	a, _p_bytes+0
      0085F4 6B 03            [ 1]  606 	ld	(0x03, sp), a
                                    607 ;	main.c: 185: for(int o = 0; o < counter;o++)
      0085F6 0F 04            [ 1]  608 	clr	(0x04, sp)
      0085F8 5F               [ 1]  609 	clrw	x
      0085F9 1F 05            [ 2]  610 	ldw	(0x05, sp), x
      0085FB                        611 00112$:
      0085FB 7B 01            [ 1]  612 	ld	a, (0x01, sp)
      0085FD 6B 08            [ 1]  613 	ld	(0x08, sp), a
      0085FF 0F 07            [ 1]  614 	clr	(0x07, sp)
      008601 1E 05            [ 2]  615 	ldw	x, (0x05, sp)
      008603 13 07            [ 2]  616 	cpw	x, (0x07, sp)
      008605 2E 65            [ 1]  617 	jrsge	00114$
                                    618 ;	main.c: 187: uint8_t number_counter = 0;
      008607 0F 02            [ 1]  619 	clr	(0x02, sp)
                                    620 ;	main.c: 188: while(1)
      008609 7B 03            [ 1]  621 	ld	a, (0x03, sp)
      00860B 6B 07            [ 1]  622 	ld	(0x07, sp), a
      00860D 0F 08            [ 1]  623 	clr	(0x08, sp)
      00860F                        624 00108$:
                                    625 ;	main.c: 190: if(buffer[i] == ' ')
      00860F 5F               [ 1]  626 	clrw	x
      008610 7B 07            [ 1]  627 	ld	a, (0x07, sp)
      008612 97               [ 1]  628 	ld	xl, a
      008613 D6 01 01         [ 1]  629 	ld	a, (_buffer+0, x)
      008616 A1 20            [ 1]  630 	cp	a, #0x20
      008618 26 04            [ 1]  631 	jrne	00105$
                                    632 ;	main.c: 192: i++;
      00861A 0C 03            [ 1]  633 	inc	(0x03, sp)
                                    634 ;	main.c: 193: break;
      00861C 20 12            [ 2]  635 	jra	00109$
      00861E                        636 00105$:
                                    637 ;	main.c: 195: else if(buffer[i] == '\r\n')
      00861E A1 0D            [ 1]  638 	cp	a, #0x0d
      008620 27 0E            [ 1]  639 	jreq	00109$
                                    640 ;	main.c: 198: i++;
      008622 0C 07            [ 1]  641 	inc	(0x07, sp)
      008624 7B 07            [ 1]  642 	ld	a, (0x07, sp)
      008626 6B 03            [ 1]  643 	ld	(0x03, sp), a
                                    644 ;	main.c: 200: number_counter++;
      008628 0C 08            [ 1]  645 	inc	(0x08, sp)
      00862A 7B 08            [ 1]  646 	ld	a, (0x08, sp)
      00862C 6B 02            [ 1]  647 	ld	(0x02, sp), a
      00862E 20 DF            [ 2]  648 	jra	00108$
      008630                        649 00109$:
                                    650 ;	main.c: 202: memcpy(a, &buffer[i - number_counter], number_counter);
      008630 90 5F            [ 1]  651 	clrw	y
      008632 7B 02            [ 1]  652 	ld	a, (0x02, sp)
      008634 90 97            [ 1]  653 	ld	yl, a
      008636 5F               [ 1]  654 	clrw	x
      008637 7B 03            [ 1]  655 	ld	a, (0x03, sp)
      008639 97               [ 1]  656 	ld	xl, a
      00863A 7B 02            [ 1]  657 	ld	a, (0x02, sp)
      00863C 6B 08            [ 1]  658 	ld	(0x08, sp), a
      00863E 0F 07            [ 1]  659 	clr	(0x07, sp)
      008640 72 F0 07         [ 2]  660 	subw	x, (0x07, sp)
      008643 1C 01 01         [ 2]  661 	addw	x, #(_buffer+0)
      008646 90 89            [ 2]  662 	pushw	y
      008648 89               [ 2]  663 	pushw	x
      008649 AE 02 01         [ 2]  664 	ldw	x, #(_a+0)
      00864C CD 8B 2E         [ 4]  665 	call	___memcpy
                                    666 ;	main.c: 203: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      00864F 5F               [ 1]  667 	clrw	x
      008650 7B 04            [ 1]  668 	ld	a, (0x04, sp)
      008652 97               [ 1]  669 	ld	xl, a
      008653 1C 02 08         [ 2]  670 	addw	x, #(_data_buf+0)
      008656 89               [ 2]  671 	pushw	x
      008657 16 09            [ 2]  672 	ldw	y, (0x09, sp)
      008659 90 89            [ 2]  673 	pushw	y
      00865B AE 02 01         [ 2]  674 	ldw	x, #(_a+0)
      00865E CD 84 E0         [ 4]  675 	call	_convert_chars_to_int
      008661 85               [ 2]  676 	popw	x
      008662 F7               [ 1]  677 	ld	(x), a
                                    678 ;	main.c: 204: int_buf_i++;
      008663 0C 04            [ 1]  679 	inc	(0x04, sp)
                                    680 ;	main.c: 185: for(int o = 0; o < counter;o++)
      008665 1E 05            [ 2]  681 	ldw	x, (0x05, sp)
      008667 5C               [ 1]  682 	incw	x
      008668 1F 05            [ 2]  683 	ldw	(0x05, sp), x
      00866A 20 8F            [ 2]  684 	jra	00112$
      00866C                        685 00114$:
                                    686 ;	main.c: 206: }
      00866C 5B 08            [ 2]  687 	addw	sp, #8
      00866E 81               [ 4]  688 	ret
                                    689 ;	main.c: 214: void reg_check(void)
                                    690 ;	-----------------------------------------
                                    691 ;	 function reg_check
                                    692 ;	-----------------------------------------
      00866F                        693 _reg_check:
                                    694 ;	main.c: 216: status_registers[0] = I2C_SR1;
      00866F 55 52 17 00 01   [ 1]  695 	mov	_status_registers+0, 0x5217
                                    696 ;	main.c: 217: status_registers[1] = I2C_SR2;
      008674 55 52 18 00 02   [ 1]  697 	mov	_status_registers+1, 0x5218
                                    698 ;	main.c: 218: status_registers[2] = I2C_SR3;
      008679 55 52 19 00 03   [ 1]  699 	mov	_status_registers+2, 0x5219
                                    700 ;	main.c: 219: }
      00867E 81               [ 4]  701 	ret
                                    702 ;	main.c: 222: void status_check(void){
                                    703 ;	-----------------------------------------
                                    704 ;	 function status_check
                                    705 ;	-----------------------------------------
      00867F                        706 _status_check:
      00867F 52 09            [ 2]  707 	sub	sp, #9
                                    708 ;	main.c: 223: char rx_binary_chars[9]={0};
      008681 0F 01            [ 1]  709 	clr	(0x01, sp)
      008683 0F 02            [ 1]  710 	clr	(0x02, sp)
      008685 0F 03            [ 1]  711 	clr	(0x03, sp)
      008687 0F 04            [ 1]  712 	clr	(0x04, sp)
      008689 0F 05            [ 1]  713 	clr	(0x05, sp)
      00868B 0F 06            [ 1]  714 	clr	(0x06, sp)
      00868D 0F 07            [ 1]  715 	clr	(0x07, sp)
      00868F 0F 08            [ 1]  716 	clr	(0x08, sp)
      008691 0F 09            [ 1]  717 	clr	(0x09, sp)
                                    718 ;	main.c: 224: uart_write("\nI2C_REGS >.<\n");
      008693 AE 80 2D         [ 2]  719 	ldw	x, #(___str_0+0)
      008696 CD 83 F1         [ 4]  720 	call	_uart_write
                                    721 ;	main.c: 225: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      008699 96               [ 1]  722 	ldw	x, sp
      00869A 5C               [ 1]  723 	incw	x
      00869B 51               [ 1]  724 	exgw	x, y
      00869C C6 52 17         [ 1]  725 	ld	a, 0x5217
      00869F 5F               [ 1]  726 	clrw	x
      0086A0 90 89            [ 2]  727 	pushw	y
      0086A2 97               [ 1]  728 	ld	xl, a
      0086A3 CD 85 07         [ 4]  729 	call	_convert_int_to_binary
                                    730 ;	main.c: 226: uart_write("\nSR1 -> ");
      0086A6 AE 80 3C         [ 2]  731 	ldw	x, #(___str_1+0)
      0086A9 CD 83 F1         [ 4]  732 	call	_uart_write
                                    733 ;	main.c: 227: uart_write(rx_binary_chars);
      0086AC 96               [ 1]  734 	ldw	x, sp
      0086AD 5C               [ 1]  735 	incw	x
      0086AE CD 83 F1         [ 4]  736 	call	_uart_write
                                    737 ;	main.c: 228: uart_write(" <-\n");
      0086B1 AE 80 45         [ 2]  738 	ldw	x, #(___str_2+0)
      0086B4 CD 83 F1         [ 4]  739 	call	_uart_write
                                    740 ;	main.c: 229: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0086B7 96               [ 1]  741 	ldw	x, sp
      0086B8 5C               [ 1]  742 	incw	x
      0086B9 51               [ 1]  743 	exgw	x, y
      0086BA C6 52 18         [ 1]  744 	ld	a, 0x5218
      0086BD 5F               [ 1]  745 	clrw	x
      0086BE 90 89            [ 2]  746 	pushw	y
      0086C0 97               [ 1]  747 	ld	xl, a
      0086C1 CD 85 07         [ 4]  748 	call	_convert_int_to_binary
                                    749 ;	main.c: 230: uart_write("SR2 -> ");
      0086C4 AE 80 4A         [ 2]  750 	ldw	x, #(___str_3+0)
      0086C7 CD 83 F1         [ 4]  751 	call	_uart_write
                                    752 ;	main.c: 231: uart_write(rx_binary_chars);
      0086CA 96               [ 1]  753 	ldw	x, sp
      0086CB 5C               [ 1]  754 	incw	x
      0086CC CD 83 F1         [ 4]  755 	call	_uart_write
                                    756 ;	main.c: 232: uart_write(" <-\n");
      0086CF AE 80 45         [ 2]  757 	ldw	x, #(___str_2+0)
      0086D2 CD 83 F1         [ 4]  758 	call	_uart_write
                                    759 ;	main.c: 233: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0086D5 96               [ 1]  760 	ldw	x, sp
      0086D6 5C               [ 1]  761 	incw	x
      0086D7 51               [ 1]  762 	exgw	x, y
      0086D8 C6 52 19         [ 1]  763 	ld	a, 0x5219
      0086DB 5F               [ 1]  764 	clrw	x
      0086DC 90 89            [ 2]  765 	pushw	y
      0086DE 97               [ 1]  766 	ld	xl, a
      0086DF CD 85 07         [ 4]  767 	call	_convert_int_to_binary
                                    768 ;	main.c: 234: uart_write("SR3 -> ");
      0086E2 AE 80 52         [ 2]  769 	ldw	x, #(___str_4+0)
      0086E5 CD 83 F1         [ 4]  770 	call	_uart_write
                                    771 ;	main.c: 235: uart_write(rx_binary_chars);
      0086E8 96               [ 1]  772 	ldw	x, sp
      0086E9 5C               [ 1]  773 	incw	x
      0086EA CD 83 F1         [ 4]  774 	call	_uart_write
                                    775 ;	main.c: 236: uart_write(" <-\n");
      0086ED AE 80 45         [ 2]  776 	ldw	x, #(___str_2+0)
      0086F0 CD 83 F1         [ 4]  777 	call	_uart_write
                                    778 ;	main.c: 237: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      0086F3 96               [ 1]  779 	ldw	x, sp
      0086F4 5C               [ 1]  780 	incw	x
      0086F5 51               [ 1]  781 	exgw	x, y
      0086F6 C6 52 10         [ 1]  782 	ld	a, 0x5210
      0086F9 5F               [ 1]  783 	clrw	x
      0086FA 90 89            [ 2]  784 	pushw	y
      0086FC 97               [ 1]  785 	ld	xl, a
      0086FD CD 85 07         [ 4]  786 	call	_convert_int_to_binary
                                    787 ;	main.c: 238: uart_write("CR1 -> ");
      008700 AE 80 5A         [ 2]  788 	ldw	x, #(___str_5+0)
      008703 CD 83 F1         [ 4]  789 	call	_uart_write
                                    790 ;	main.c: 239: uart_write(rx_binary_chars);
      008706 96               [ 1]  791 	ldw	x, sp
      008707 5C               [ 1]  792 	incw	x
      008708 CD 83 F1         [ 4]  793 	call	_uart_write
                                    794 ;	main.c: 240: uart_write(" <-\n");
      00870B AE 80 45         [ 2]  795 	ldw	x, #(___str_2+0)
      00870E CD 83 F1         [ 4]  796 	call	_uart_write
                                    797 ;	main.c: 241: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008711 96               [ 1]  798 	ldw	x, sp
      008712 5C               [ 1]  799 	incw	x
      008713 51               [ 1]  800 	exgw	x, y
      008714 C6 52 11         [ 1]  801 	ld	a, 0x5211
      008717 5F               [ 1]  802 	clrw	x
      008718 90 89            [ 2]  803 	pushw	y
      00871A 97               [ 1]  804 	ld	xl, a
      00871B CD 85 07         [ 4]  805 	call	_convert_int_to_binary
                                    806 ;	main.c: 242: uart_write("CR2 -> ");
      00871E AE 80 62         [ 2]  807 	ldw	x, #(___str_6+0)
      008721 CD 83 F1         [ 4]  808 	call	_uart_write
                                    809 ;	main.c: 243: uart_write(rx_binary_chars);
      008724 96               [ 1]  810 	ldw	x, sp
      008725 5C               [ 1]  811 	incw	x
      008726 CD 83 F1         [ 4]  812 	call	_uart_write
                                    813 ;	main.c: 244: uart_write(" <-\n");
      008729 AE 80 45         [ 2]  814 	ldw	x, #(___str_2+0)
      00872C CD 83 F1         [ 4]  815 	call	_uart_write
                                    816 ;	main.c: 245: convert_int_to_binary(I2C_DR, rx_binary_chars);
      00872F 96               [ 1]  817 	ldw	x, sp
      008730 5C               [ 1]  818 	incw	x
      008731 51               [ 1]  819 	exgw	x, y
      008732 C6 52 16         [ 1]  820 	ld	a, 0x5216
      008735 5F               [ 1]  821 	clrw	x
      008736 90 89            [ 2]  822 	pushw	y
      008738 97               [ 1]  823 	ld	xl, a
      008739 CD 85 07         [ 4]  824 	call	_convert_int_to_binary
                                    825 ;	main.c: 246: uart_write("DR -> ");
      00873C AE 80 6A         [ 2]  826 	ldw	x, #(___str_7+0)
      00873F CD 83 F1         [ 4]  827 	call	_uart_write
                                    828 ;	main.c: 247: uart_write(rx_binary_chars);
      008742 96               [ 1]  829 	ldw	x, sp
      008743 5C               [ 1]  830 	incw	x
      008744 CD 83 F1         [ 4]  831 	call	_uart_write
                                    832 ;	main.c: 248: uart_write(" <-\n");
      008747 AE 80 45         [ 2]  833 	ldw	x, #(___str_2+0)
      00874A CD 83 F1         [ 4]  834 	call	_uart_write
                                    835 ;	main.c: 249: uart_write("UART_REGS >.<\n");
      00874D AE 80 71         [ 2]  836 	ldw	x, #(___str_8+0)
      008750 CD 83 F1         [ 4]  837 	call	_uart_write
                                    838 ;	main.c: 294: }
      008753 5B 09            [ 2]  839 	addw	sp, #9
      008755 81               [ 4]  840 	ret
                                    841 ;	main.c: 296: void uart_init(void){
                                    842 ;	-----------------------------------------
                                    843 ;	 function uart_init
                                    844 ;	-----------------------------------------
      008756                        845 _uart_init:
                                    846 ;	main.c: 297: CLK_CKDIVR = 0;
      008756 35 00 50 C6      [ 1]  847 	mov	0x50c6+0, #0x00
                                    848 ;	main.c: 300: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00875A 72 16 52 35      [ 1]  849 	bset	0x5235, #3
                                    850 ;	main.c: 301: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      00875E 72 14 52 35      [ 1]  851 	bset	0x5235, #2
                                    852 ;	main.c: 302: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008762 C6 52 36         [ 1]  853 	ld	a, 0x5236
      008765 A4 CF            [ 1]  854 	and	a, #0xcf
      008767 C7 52 36         [ 1]  855 	ld	0x5236, a
                                    856 ;	main.c: 304: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      00876A 35 03 52 33      [ 1]  857 	mov	0x5233+0, #0x03
      00876E 35 68 52 32      [ 1]  858 	mov	0x5232+0, #0x68
                                    859 ;	main.c: 305: }
      008772 81               [ 4]  860 	ret
                                    861 ;	main.c: 309: void i2c_init(void) {
                                    862 ;	-----------------------------------------
                                    863 ;	 function i2c_init
                                    864 ;	-----------------------------------------
      008773                        865 _i2c_init:
                                    866 ;	main.c: 315: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008773 72 11 52 10      [ 1]  867 	bres	0x5210, #0
                                    868 ;	main.c: 316: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008777 35 10 52 12      [ 1]  869 	mov	0x5212+0, #0x10
                                    870 ;	main.c: 317: I2C_CCRH = 0;                   // =0
      00877B 35 00 52 1C      [ 1]  871 	mov	0x521c+0, #0x00
                                    872 ;	main.c: 318: I2C_CCRL = 80;                  // 100kHz for I2C
      00877F 35 50 52 1B      [ 1]  873 	mov	0x521b+0, #0x50
                                    874 ;	main.c: 319: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      008783 72 1F 52 1C      [ 1]  875 	bres	0x521c, #7
                                    876 ;	main.c: 320: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      008787 72 1F 52 14      [ 1]  877 	bres	0x5214, #7
                                    878 ;	main.c: 321: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      00878B 72 1C 52 14      [ 1]  879 	bset	0x5214, #6
                                    880 ;	main.c: 322: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      00878F 72 10 52 10      [ 1]  881 	bset	0x5210, #0
                                    882 ;	main.c: 323: }
      008793 81               [ 4]  883 	ret
                                    884 ;	main.c: 332: void i2c_start(void) {
                                    885 ;	-----------------------------------------
                                    886 ;	 function i2c_start
                                    887 ;	-----------------------------------------
      008794                        888 _i2c_start:
                                    889 ;	main.c: 333: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      008794 72 10 52 11      [ 1]  890 	bset	0x5211, #0
                                    891 ;	main.c: 334: while(!(I2C_SR1 & (1 << 0)));
      008798                        892 00101$:
      008798 72 01 52 17 FB   [ 2]  893 	btjf	0x5217, #0, 00101$
                                    894 ;	main.c: 336: }
      00879D 81               [ 4]  895 	ret
                                    896 ;	main.c: 338: void i2c_send_address(uint8_t address) {
                                    897 ;	-----------------------------------------
                                    898 ;	 function i2c_send_address
                                    899 ;	-----------------------------------------
      00879E                        900 _i2c_send_address:
                                    901 ;	main.c: 339: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      00879E 48               [ 1]  902 	sll	a
      00879F C7 52 16         [ 1]  903 	ld	0x5216, a
                                    904 ;	main.c: 340: reg_check();
      0087A2 CD 86 6F         [ 4]  905 	call	_reg_check
                                    906 ;	main.c: 341: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0087A5                        907 00102$:
      0087A5 72 03 52 17 01   [ 2]  908 	btjf	0x5217, #1, 00117$
      0087AA 81               [ 4]  909 	ret
      0087AB                        910 00117$:
      0087AB 72 05 52 18 F5   [ 2]  911 	btjf	0x5218, #2, 00102$
                                    912 ;	main.c: 343: }
      0087B0 81               [ 4]  913 	ret
                                    914 ;	main.c: 345: void i2c_stop(void) {
                                    915 ;	-----------------------------------------
                                    916 ;	 function i2c_stop
                                    917 ;	-----------------------------------------
      0087B1                        918 _i2c_stop:
                                    919 ;	main.c: 346: I2C_CR2 = I2C_CR2 | (1 << 1);// Отправка стопового сигнала
      0087B1 72 12 52 11      [ 1]  920 	bset	0x5211, #1
                                    921 ;	main.c: 348: }
      0087B5 81               [ 4]  922 	ret
                                    923 ;	main.c: 349: void i2c_write(void){
                                    924 ;	-----------------------------------------
                                    925 ;	 function i2c_write
                                    926 ;	-----------------------------------------
      0087B6                        927 _i2c_write:
      0087B6 52 02            [ 2]  928 	sub	sp, #2
                                    929 ;	main.c: 350: I2C_DR = 0;
      0087B8 35 00 52 16      [ 1]  930 	mov	0x5216+0, #0x00
                                    931 ;	main.c: 351: reg_check();
      0087BC CD 86 6F         [ 4]  932 	call	_reg_check
                                    933 ;	main.c: 352: I2C_DR = d_addr;
      0087BF 55 02 04 52 16   [ 1]  934 	mov	0x5216+0, _d_addr+0
                                    935 ;	main.c: 353: reg_check();
      0087C4 CD 86 6F         [ 4]  936 	call	_reg_check
                                    937 ;	main.c: 354: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      0087C7                        938 00103$:
      0087C7 C6 52 17         [ 1]  939 	ld	a, 0x5217
      0087CA 2B 0A            [ 1]  940 	jrmi	00122$
      0087CC 72 05 52 18 05   [ 2]  941 	btjf	0x5218, #2, 00122$
      0087D1 72 05 52 17 F1   [ 2]  942 	btjf	0x5217, #2, 00103$
                                    943 ;	main.c: 355: for(int i = 0;i < d_size;i++)
      0087D6                        944 00122$:
      0087D6 5F               [ 1]  945 	clrw	x
      0087D7                        946 00112$:
      0087D7 C6 02 06         [ 1]  947 	ld	a, _d_size+0
      0087DA 6B 02            [ 1]  948 	ld	(0x02, sp), a
      0087DC 0F 01            [ 1]  949 	clr	(0x01, sp)
      0087DE 13 01            [ 2]  950 	cpw	x, (0x01, sp)
      0087E0 2E 1B            [ 1]  951 	jrsge	00114$
                                    952 ;	main.c: 357: I2C_DR = data_buf[i];
      0087E2 90 93            [ 1]  953 	ldw	y, x
      0087E4 90 D6 02 08      [ 1]  954 	ld	a, (_data_buf+0, y)
      0087E8 C7 52 16         [ 1]  955 	ld	0x5216, a
                                    956 ;	main.c: 358: reg_check();
      0087EB 89               [ 2]  957 	pushw	x
      0087EC CD 86 6F         [ 4]  958 	call	_reg_check
      0087EF 85               [ 2]  959 	popw	x
                                    960 ;	main.c: 359: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)));
      0087F0                        961 00107$:
      0087F0 C6 52 17         [ 1]  962 	ld	a, 0x5217
      0087F3 2B 05            [ 1]  963 	jrmi	00113$
      0087F5 72 04 52 18 F6   [ 2]  964 	btjt	0x5218, #2, 00107$
      0087FA                        965 00113$:
                                    966 ;	main.c: 355: for(int i = 0;i < d_size;i++)
      0087FA 5C               [ 1]  967 	incw	x
      0087FB 20 DA            [ 2]  968 	jra	00112$
      0087FD                        969 00114$:
                                    970 ;	main.c: 361: }
      0087FD 5B 02            [ 2]  971 	addw	sp, #2
      0087FF 81               [ 4]  972 	ret
                                    973 ;	main.c: 363: void i2c_read(void){
                                    974 ;	-----------------------------------------
                                    975 ;	 function i2c_read
                                    976 ;	-----------------------------------------
      008800                        977 _i2c_read:
      008800 52 04            [ 2]  978 	sub	sp, #4
                                    979 ;	main.c: 364: I2C_DR = d_addr;
      008802 55 02 04 52 16   [ 1]  980 	mov	0x5216+0, _d_addr+0
                                    981 ;	main.c: 365: status_check();
      008807 CD 86 7F         [ 4]  982 	call	_status_check
                                    983 ;	main.c: 366: while (!(I2C_SR1 & (1 << 7)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      00880A                        984 00102$:
      00880A C6 52 17         [ 1]  985 	ld	a, 0x5217
      00880D 2B 05            [ 1]  986 	jrmi	00104$
      00880F 72 05 52 17 F6   [ 2]  987 	btjf	0x5217, #2, 00102$
      008814                        988 00104$:
                                    989 ;	main.c: 367: i2c_stop();
      008814 CD 87 B1         [ 4]  990 	call	_i2c_stop
                                    991 ;	main.c: 368: i2c_start();
      008817 CD 87 94         [ 4]  992 	call	_i2c_start
                                    993 ;	main.c: 369: I2C_DR = (current_dev << 1) | (1 << 0);
      00881A C6 03 08         [ 1]  994 	ld	a, _current_dev+0
      00881D 48               [ 1]  995 	sll	a
      00881E AA 01            [ 1]  996 	or	a, #0x01
      008820 C7 52 16         [ 1]  997 	ld	0x5216, a
                                    998 ;	main.c: 370: status_check();
      008823 CD 86 7F         [ 4]  999 	call	_status_check
                                   1000 ;	main.c: 371: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR1 & (1 << 2)));
      008826                       1001 00106$:
      008826 72 02 52 17 05   [ 2] 1002 	btjt	0x5217, #1, 00108$
      00882B 72 05 52 17 F6   [ 2] 1003 	btjf	0x5217, #2, 00106$
      008830                       1004 00108$:
                                   1005 ;	main.c: 372: status_check();
      008830 CD 86 7F         [ 4] 1006 	call	_status_check
                                   1007 ;	main.c: 374: for(int i = 0;i < d_size;i++)
      008833 5F               [ 1] 1008 	clrw	x
      008834 1F 03            [ 2] 1009 	ldw	(0x03, sp), x
      008836                       1010 00114$:
      008836 C6 02 06         [ 1] 1011 	ld	a, _d_size+0
      008839 6B 02            [ 1] 1012 	ld	(0x02, sp), a
      00883B 0F 01            [ 1] 1013 	clr	(0x01, sp)
      00883D 1E 03            [ 2] 1014 	ldw	x, (0x03, sp)
      00883F 13 01            [ 2] 1015 	cpw	x, (0x01, sp)
      008841 2E 1D            [ 1] 1016 	jrsge	00116$
                                   1017 ;	main.c: 376: status_check();
      008843 CD 86 7F         [ 4] 1018 	call	_status_check
                                   1019 ;	main.c: 377: data_buf[i] = I2C_DR;
      008846 1E 03            [ 2] 1020 	ldw	x, (0x03, sp)
      008848 C6 52 16         [ 1] 1021 	ld	a, 0x5216
      00884B D7 02 08         [ 1] 1022 	ld	((_data_buf+0), x), a
                                   1023 ;	main.c: 378: status_check();
      00884E CD 86 7F         [ 4] 1024 	call	_status_check
                                   1025 ;	main.c: 379: while (!(I2C_SR1 & (1 << 6)));
      008851                       1026 00109$:
      008851 72 0D 52 17 FB   [ 2] 1027 	btjf	0x5217, #6, 00109$
                                   1028 ;	main.c: 380: status_check();
      008856 CD 86 7F         [ 4] 1029 	call	_status_check
                                   1030 ;	main.c: 374: for(int i = 0;i < d_size;i++)
      008859 1E 03            [ 2] 1031 	ldw	x, (0x03, sp)
      00885B 5C               [ 1] 1032 	incw	x
      00885C 1F 03            [ 2] 1033 	ldw	(0x03, sp), x
      00885E 20 D6            [ 2] 1034 	jra	00114$
      008860                       1035 00116$:
                                   1036 ;	main.c: 382: }
      008860 5B 04            [ 2] 1037 	addw	sp, #4
      008862 81               [ 4] 1038 	ret
                                   1039 ;	main.c: 383: void i2c_scan(void) {
                                   1040 ;	-----------------------------------------
                                   1041 ;	 function i2c_scan
                                   1042 ;	-----------------------------------------
      008863                       1043 _i2c_scan:
      008863 52 02            [ 2] 1044 	sub	sp, #2
                                   1045 ;	main.c: 384: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008865 C6 03 08         [ 1] 1046 	ld	a, _current_dev+0
      008868 6B 01            [ 1] 1047 	ld	(0x01, sp), a
      00886A 6B 02            [ 1] 1048 	ld	(0x02, sp), a
      00886C                       1049 00105$:
      00886C 7B 02            [ 1] 1050 	ld	a, (0x02, sp)
      00886E A1 7F            [ 1] 1051 	cp	a, #0x7f
      008870 24 26            [ 1] 1052 	jrnc	00107$
                                   1053 ;	main.c: 385: i2c_start();
      008872 CD 87 94         [ 4] 1054 	call	_i2c_start
                                   1055 ;	main.c: 386: i2c_send_address(addr);
      008875 7B 02            [ 1] 1056 	ld	a, (0x02, sp)
      008877 CD 87 9E         [ 4] 1057 	call	_i2c_send_address
                                   1058 ;	main.c: 387: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      00887A 72 04 52 18 0A   [ 2] 1059 	btjt	0x5218, #2, 00102$
                                   1060 ;	main.c: 389: current_dev = addr;
      00887F 7B 01            [ 1] 1061 	ld	a, (0x01, sp)
      008881 C7 03 08         [ 1] 1062 	ld	_current_dev+0, a
                                   1063 ;	main.c: 390: i2c_stop();
      008884 5B 02            [ 2] 1064 	addw	sp, #2
                                   1065 ;	main.c: 391: break;
      008886 CC 87 B1         [ 2] 1066 	jp	_i2c_stop
      008889                       1067 00102$:
                                   1068 ;	main.c: 393: i2c_stop();
      008889 CD 87 B1         [ 4] 1069 	call	_i2c_stop
                                   1070 ;	main.c: 394: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      00888C 72 15 52 18      [ 1] 1071 	bres	0x5218, #2
                                   1072 ;	main.c: 384: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008890 0C 02            [ 1] 1073 	inc	(0x02, sp)
      008892 7B 02            [ 1] 1074 	ld	a, (0x02, sp)
      008894 6B 01            [ 1] 1075 	ld	(0x01, sp), a
      008896 20 D4            [ 2] 1076 	jra	00105$
      008898                       1077 00107$:
                                   1078 ;	main.c: 396: }
      008898 5B 02            [ 2] 1079 	addw	sp, #2
      00889A 81               [ 4] 1080 	ret
                                   1081 ;	main.c: 406: void cm_SM(void)
                                   1082 ;	-----------------------------------------
                                   1083 ;	 function cm_SM
                                   1084 ;	-----------------------------------------
      00889B                       1085 _cm_SM:
      00889B 52 04            [ 2] 1086 	sub	sp, #4
                                   1087 ;	main.c: 408: char cur_dev[4]={0};
      00889D 0F 01            [ 1] 1088 	clr	(0x01, sp)
      00889F 0F 02            [ 1] 1089 	clr	(0x02, sp)
      0088A1 0F 03            [ 1] 1090 	clr	(0x03, sp)
      0088A3 0F 04            [ 1] 1091 	clr	(0x04, sp)
                                   1092 ;	main.c: 409: convert_int_to_chars(current_dev, cur_dev);
      0088A5 96               [ 1] 1093 	ldw	x, sp
      0088A6 5C               [ 1] 1094 	incw	x
      0088A7 C6 03 08         [ 1] 1095 	ld	a, _current_dev+0
      0088AA CD 84 5B         [ 4] 1096 	call	_convert_int_to_chars
                                   1097 ;	main.c: 410: uart_write("SM ");
      0088AD AE 80 80         [ 2] 1098 	ldw	x, #(___str_9+0)
      0088B0 CD 83 F1         [ 4] 1099 	call	_uart_write
                                   1100 ;	main.c: 411: uart_write(cur_dev);
      0088B3 96               [ 1] 1101 	ldw	x, sp
      0088B4 5C               [ 1] 1102 	incw	x
      0088B5 CD 83 F1         [ 4] 1103 	call	_uart_write
                                   1104 ;	main.c: 412: uart_write("\r\n");
      0088B8 AE 80 84         [ 2] 1105 	ldw	x, #(___str_10+0)
      0088BB CD 83 F1         [ 4] 1106 	call	_uart_write
                                   1107 ;	main.c: 413: }
      0088BE 5B 04            [ 2] 1108 	addw	sp, #4
      0088C0 81               [ 4] 1109 	ret
                                   1110 ;	main.c: 414: void cm_SN(void)
                                   1111 ;	-----------------------------------------
                                   1112 ;	 function cm_SN
                                   1113 ;	-----------------------------------------
      0088C1                       1114 _cm_SN:
                                   1115 ;	main.c: 416: i2c_scan();
      0088C1 CD 88 63         [ 4] 1116 	call	_i2c_scan
                                   1117 ;	main.c: 417: cm_SM();
                                   1118 ;	main.c: 418: }
      0088C4 CC 88 9B         [ 2] 1119 	jp	_cm_SM
                                   1120 ;	main.c: 419: void cm_RM(void)
                                   1121 ;	-----------------------------------------
                                   1122 ;	 function cm_RM
                                   1123 ;	-----------------------------------------
      0088C7                       1124 _cm_RM:
                                   1125 ;	main.c: 421: current_dev = 0;
      0088C7 72 5F 03 08      [ 1] 1126 	clr	_current_dev+0
                                   1127 ;	main.c: 422: uart_write("RM\n");
      0088CB AE 80 87         [ 2] 1128 	ldw	x, #(___str_11+0)
                                   1129 ;	main.c: 423: }
      0088CE CC 83 F1         [ 2] 1130 	jp	_uart_write
                                   1131 ;	main.c: 425: void cm_DB(void)
                                   1132 ;	-----------------------------------------
                                   1133 ;	 function cm_DB
                                   1134 ;	-----------------------------------------
      0088D1                       1135 _cm_DB:
                                   1136 ;	main.c: 427: status_check();
                                   1137 ;	main.c: 428: }
      0088D1 CC 86 7F         [ 2] 1138 	jp	_status_check
                                   1139 ;	main.c: 430: void cm_ST(void)
                                   1140 ;	-----------------------------------------
                                   1141 ;	 function cm_ST
                                   1142 ;	-----------------------------------------
      0088D4                       1143 _cm_ST:
                                   1144 ;	main.c: 432: get_addr_from_buff();
      0088D4 CD 85 3F         [ 4] 1145 	call	_get_addr_from_buff
                                   1146 ;	main.c: 433: current_dev = d_addr;
      0088D7 55 02 04 03 08   [ 1] 1147 	mov	_current_dev+0, _d_addr+0
                                   1148 ;	main.c: 434: uart_write("ST\n");
      0088DC AE 80 8B         [ 2] 1149 	ldw	x, #(___str_12+0)
                                   1150 ;	main.c: 435: }
      0088DF CC 83 F1         [ 2] 1151 	jp	_uart_write
                                   1152 ;	main.c: 436: void cm_SR(void)
                                   1153 ;	-----------------------------------------
                                   1154 ;	 function cm_SR
                                   1155 ;	-----------------------------------------
      0088E2                       1156 _cm_SR:
      0088E2 52 04            [ 2] 1157 	sub	sp, #4
                                   1158 ;	main.c: 438: i2c_start();
      0088E4 CD 87 94         [ 4] 1159 	call	_i2c_start
                                   1160 ;	main.c: 439: i2c_send_address(current_dev);
      0088E7 C6 03 08         [ 1] 1161 	ld	a, _current_dev+0
      0088EA CD 87 9E         [ 4] 1162 	call	_i2c_send_address
                                   1163 ;	main.c: 440: i2c_read();
      0088ED CD 88 00         [ 4] 1164 	call	_i2c_read
                                   1165 ;	main.c: 441: i2c_stop();
      0088F0 CD 87 B1         [ 4] 1166 	call	_i2c_stop
                                   1167 ;	main.c: 442: uart_write("SR ");
      0088F3 AE 80 8F         [ 2] 1168 	ldw	x, #(___str_13+0)
      0088F6 CD 83 F1         [ 4] 1169 	call	_uart_write
                                   1170 ;	main.c: 443: convert_int_to_chars(d_addr, a);
      0088F9 AE 02 01         [ 2] 1171 	ldw	x, #(_a+0)
      0088FC C6 02 04         [ 1] 1172 	ld	a, _d_addr+0
      0088FF CD 84 5B         [ 4] 1173 	call	_convert_int_to_chars
                                   1174 ;	main.c: 444: uart_write(a);
      008902 AE 02 01         [ 2] 1175 	ldw	x, #(_a+0)
      008905 CD 83 F1         [ 4] 1176 	call	_uart_write
                                   1177 ;	main.c: 445: uart_write(" ");
      008908 AE 80 93         [ 2] 1178 	ldw	x, #(___str_14+0)
      00890B CD 83 F1         [ 4] 1179 	call	_uart_write
                                   1180 ;	main.c: 446: convert_int_to_chars(d_size, a);
      00890E AE 02 01         [ 2] 1181 	ldw	x, #(_a+0)
      008911 C6 02 06         [ 1] 1182 	ld	a, _d_size+0
      008914 CD 84 5B         [ 4] 1183 	call	_convert_int_to_chars
                                   1184 ;	main.c: 447: uart_write(a);
      008917 AE 02 01         [ 2] 1185 	ldw	x, #(_a+0)
      00891A CD 83 F1         [ 4] 1186 	call	_uart_write
                                   1187 ;	main.c: 448: for(int i = 0;i < d_size;i++)
      00891D 5F               [ 1] 1188 	clrw	x
      00891E 1F 03            [ 2] 1189 	ldw	(0x03, sp), x
      008920                       1190 00103$:
      008920 C6 02 06         [ 1] 1191 	ld	a, _d_size+0
      008923 6B 02            [ 1] 1192 	ld	(0x02, sp), a
      008925 0F 01            [ 1] 1193 	clr	(0x01, sp)
      008927 1E 03            [ 2] 1194 	ldw	x, (0x03, sp)
      008929 13 01            [ 2] 1195 	cpw	x, (0x01, sp)
      00892B 2E 1E            [ 1] 1196 	jrsge	00101$
                                   1197 ;	main.c: 450: uart_write(" ");
      00892D AE 80 93         [ 2] 1198 	ldw	x, #(___str_14+0)
      008930 CD 83 F1         [ 4] 1199 	call	_uart_write
                                   1200 ;	main.c: 451: convert_int_to_chars(data_buf[i], a);
      008933 1E 03            [ 2] 1201 	ldw	x, (0x03, sp)
      008935 D6 02 08         [ 1] 1202 	ld	a, (_data_buf+0, x)
      008938 AE 02 01         [ 2] 1203 	ldw	x, #(_a+0)
      00893B CD 84 5B         [ 4] 1204 	call	_convert_int_to_chars
                                   1205 ;	main.c: 452: uart_write(a);
      00893E AE 02 01         [ 2] 1206 	ldw	x, #(_a+0)
      008941 CD 83 F1         [ 4] 1207 	call	_uart_write
                                   1208 ;	main.c: 448: for(int i = 0;i < d_size;i++)
      008944 1E 03            [ 2] 1209 	ldw	x, (0x03, sp)
      008946 5C               [ 1] 1210 	incw	x
      008947 1F 03            [ 2] 1211 	ldw	(0x03, sp), x
      008949 20 D5            [ 2] 1212 	jra	00103$
      00894B                       1213 00101$:
                                   1214 ;	main.c: 455: uart_write("\r\n");
      00894B AE 80 84         [ 2] 1215 	ldw	x, #(___str_10+0)
      00894E 5B 04            [ 2] 1216 	addw	sp, #4
                                   1217 ;	main.c: 456: }
      008950 CC 83 F1         [ 2] 1218 	jp	_uart_write
                                   1219 ;	main.c: 457: void cm_SW(void)
                                   1220 ;	-----------------------------------------
                                   1221 ;	 function cm_SW
                                   1222 ;	-----------------------------------------
      008953                       1223 _cm_SW:
      008953 52 04            [ 2] 1224 	sub	sp, #4
                                   1225 ;	main.c: 459: i2c_start();
      008955 CD 87 94         [ 4] 1226 	call	_i2c_start
                                   1227 ;	main.c: 460: i2c_send_address(current_dev);
      008958 C6 03 08         [ 1] 1228 	ld	a, _current_dev+0
      00895B CD 87 9E         [ 4] 1229 	call	_i2c_send_address
                                   1230 ;	main.c: 461: i2c_write();
      00895E CD 87 B6         [ 4] 1231 	call	_i2c_write
                                   1232 ;	main.c: 462: i2c_stop();
      008961 CD 87 B1         [ 4] 1233 	call	_i2c_stop
                                   1234 ;	main.c: 463: uart_write("SW ");
      008964 AE 80 95         [ 2] 1235 	ldw	x, #(___str_15+0)
      008967 CD 83 F1         [ 4] 1236 	call	_uart_write
                                   1237 ;	main.c: 464: convert_int_to_chars(d_addr, a);
      00896A AE 02 01         [ 2] 1238 	ldw	x, #(_a+0)
      00896D C6 02 04         [ 1] 1239 	ld	a, _d_addr+0
      008970 CD 84 5B         [ 4] 1240 	call	_convert_int_to_chars
                                   1241 ;	main.c: 465: uart_write(a);
      008973 AE 02 01         [ 2] 1242 	ldw	x, #(_a+0)
      008976 CD 83 F1         [ 4] 1243 	call	_uart_write
                                   1244 ;	main.c: 466: uart_write(" ");
      008979 AE 80 93         [ 2] 1245 	ldw	x, #(___str_14+0)
      00897C CD 83 F1         [ 4] 1246 	call	_uart_write
                                   1247 ;	main.c: 467: convert_int_to_chars(d_size, a);
      00897F AE 02 01         [ 2] 1248 	ldw	x, #(_a+0)
      008982 C6 02 06         [ 1] 1249 	ld	a, _d_size+0
      008985 CD 84 5B         [ 4] 1250 	call	_convert_int_to_chars
                                   1251 ;	main.c: 468: uart_write(a);
      008988 AE 02 01         [ 2] 1252 	ldw	x, #(_a+0)
      00898B CD 83 F1         [ 4] 1253 	call	_uart_write
                                   1254 ;	main.c: 469: for(int i = 0;i < d_size;i++)
      00898E 5F               [ 1] 1255 	clrw	x
      00898F 1F 03            [ 2] 1256 	ldw	(0x03, sp), x
      008991                       1257 00103$:
      008991 C6 02 06         [ 1] 1258 	ld	a, _d_size+0
      008994 6B 02            [ 1] 1259 	ld	(0x02, sp), a
      008996 0F 01            [ 1] 1260 	clr	(0x01, sp)
      008998 1E 03            [ 2] 1261 	ldw	x, (0x03, sp)
      00899A 13 01            [ 2] 1262 	cpw	x, (0x01, sp)
      00899C 2E 1E            [ 1] 1263 	jrsge	00101$
                                   1264 ;	main.c: 471: uart_write(" ");
      00899E AE 80 93         [ 2] 1265 	ldw	x, #(___str_14+0)
      0089A1 CD 83 F1         [ 4] 1266 	call	_uart_write
                                   1267 ;	main.c: 472: convert_int_to_chars(data_buf[i], a);
      0089A4 1E 03            [ 2] 1268 	ldw	x, (0x03, sp)
      0089A6 D6 02 08         [ 1] 1269 	ld	a, (_data_buf+0, x)
      0089A9 AE 02 01         [ 2] 1270 	ldw	x, #(_a+0)
      0089AC CD 84 5B         [ 4] 1271 	call	_convert_int_to_chars
                                   1272 ;	main.c: 473: uart_write(a);
      0089AF AE 02 01         [ 2] 1273 	ldw	x, #(_a+0)
      0089B2 CD 83 F1         [ 4] 1274 	call	_uart_write
                                   1275 ;	main.c: 469: for(int i = 0;i < d_size;i++)
      0089B5 1E 03            [ 2] 1276 	ldw	x, (0x03, sp)
      0089B7 5C               [ 1] 1277 	incw	x
      0089B8 1F 03            [ 2] 1278 	ldw	(0x03, sp), x
      0089BA 20 D5            [ 2] 1279 	jra	00103$
      0089BC                       1280 00101$:
                                   1281 ;	main.c: 476: uart_write("\r\n");
      0089BC AE 80 84         [ 2] 1282 	ldw	x, #(___str_10+0)
      0089BF 5B 04            [ 2] 1283 	addw	sp, #4
                                   1284 ;	main.c: 477: }
      0089C1 CC 83 F1         [ 2] 1285 	jp	_uart_write
                                   1286 ;	main.c: 485: int data_handler(void)
                                   1287 ;	-----------------------------------------
                                   1288 ;	 function data_handler
                                   1289 ;	-----------------------------------------
      0089C4                       1290 _data_handler:
                                   1291 ;	main.c: 487: p_size = 0;
      0089C4 72 5F 02 05      [ 1] 1292 	clr	_p_size+0
                                   1293 ;	main.c: 488: p_bytes = 0;
      0089C8 72 5F 02 07      [ 1] 1294 	clr	_p_bytes+0
                                   1295 ;	main.c: 489: d_addr = 0;
      0089CC 72 5F 02 04      [ 1] 1296 	clr	_d_addr+0
                                   1297 ;	main.c: 490: d_size = 0;
      0089D0 72 5F 02 06      [ 1] 1298 	clr	_d_size+0
                                   1299 ;	main.c: 491: memset(a, 0, sizeof(a));
      0089D4 4B 03            [ 1] 1300 	push	#0x03
      0089D6 4B 00            [ 1] 1301 	push	#0x00
      0089D8 5F               [ 1] 1302 	clrw	x
      0089D9 89               [ 2] 1303 	pushw	x
      0089DA AE 02 01         [ 2] 1304 	ldw	x, #(_a+0)
      0089DD CD 8B 81         [ 4] 1305 	call	_memset
                                   1306 ;	main.c: 492: memset(data_buf, 0, sizeof(data_buf));
      0089E0 4B 00            [ 1] 1307 	push	#0x00
      0089E2 4B 01            [ 1] 1308 	push	#0x01
      0089E4 5F               [ 1] 1309 	clrw	x
      0089E5 89               [ 2] 1310 	pushw	x
      0089E6 AE 02 08         [ 2] 1311 	ldw	x, #(_data_buf+0)
      0089E9 CD 8B 81         [ 4] 1312 	call	_memset
                                   1313 ;	main.c: 493: if(memcmp(&buffer[0],"SM",2) == 0)
      0089EC 4B 02            [ 1] 1314 	push	#0x02
      0089EE 4B 00            [ 1] 1315 	push	#0x00
      0089F0 4B 99            [ 1] 1316 	push	#<(___str_16+0)
      0089F2 4B 80            [ 1] 1317 	push	#((___str_16+0) >> 8)
      0089F4 AE 01 01         [ 2] 1318 	ldw	x, #(_buffer+0)
      0089F7 CD 8A EB         [ 4] 1319 	call	_memcmp
                                   1320 ;	main.c: 494: return 1;
      0089FA 5D               [ 2] 1321 	tnzw	x
      0089FB 26 02            [ 1] 1322 	jrne	00102$
      0089FD 5C               [ 1] 1323 	incw	x
      0089FE 81               [ 4] 1324 	ret
      0089FF                       1325 00102$:
                                   1326 ;	main.c: 495: if(memcmp(&buffer[0],"SN",2) == 0)
      0089FF 4B 02            [ 1] 1327 	push	#0x02
      008A01 4B 00            [ 1] 1328 	push	#0x00
      008A03 4B 9C            [ 1] 1329 	push	#<(___str_17+0)
      008A05 4B 80            [ 1] 1330 	push	#((___str_17+0) >> 8)
      008A07 AE 01 01         [ 2] 1331 	ldw	x, #(_buffer+0)
      008A0A CD 8A EB         [ 4] 1332 	call	_memcmp
      008A0D 5D               [ 2] 1333 	tnzw	x
      008A0E 26 04            [ 1] 1334 	jrne	00104$
                                   1335 ;	main.c: 496: return 2;
      008A10 AE 00 02         [ 2] 1336 	ldw	x, #0x0002
      008A13 81               [ 4] 1337 	ret
      008A14                       1338 00104$:
                                   1339 ;	main.c: 497: if(memcmp(&buffer[0],"ST",2) == 0)
      008A14 4B 02            [ 1] 1340 	push	#0x02
      008A16 4B 00            [ 1] 1341 	push	#0x00
      008A18 4B 9F            [ 1] 1342 	push	#<(___str_18+0)
      008A1A 4B 80            [ 1] 1343 	push	#((___str_18+0) >> 8)
      008A1C AE 01 01         [ 2] 1344 	ldw	x, #(_buffer+0)
      008A1F CD 8A EB         [ 4] 1345 	call	_memcmp
      008A22 5D               [ 2] 1346 	tnzw	x
      008A23 26 04            [ 1] 1347 	jrne	00106$
                                   1348 ;	main.c: 498: return 5;
      008A25 AE 00 05         [ 2] 1349 	ldw	x, #0x0005
      008A28 81               [ 4] 1350 	ret
      008A29                       1351 00106$:
                                   1352 ;	main.c: 499: if(memcmp(&buffer[0],"RM",2) == 0)
      008A29 4B 02            [ 1] 1353 	push	#0x02
      008A2B 4B 00            [ 1] 1354 	push	#0x00
      008A2D 4B A2            [ 1] 1355 	push	#<(___str_19+0)
      008A2F 4B 80            [ 1] 1356 	push	#((___str_19+0) >> 8)
      008A31 AE 01 01         [ 2] 1357 	ldw	x, #(_buffer+0)
      008A34 CD 8A EB         [ 4] 1358 	call	_memcmp
      008A37 5D               [ 2] 1359 	tnzw	x
      008A38 26 04            [ 1] 1360 	jrne	00108$
                                   1361 ;	main.c: 500: return 6;
      008A3A AE 00 06         [ 2] 1362 	ldw	x, #0x0006
      008A3D 81               [ 4] 1363 	ret
      008A3E                       1364 00108$:
                                   1365 ;	main.c: 501: if(memcmp(&buffer[0],"DB",2) == 0)
      008A3E 4B 02            [ 1] 1366 	push	#0x02
      008A40 4B 00            [ 1] 1367 	push	#0x00
      008A42 4B A5            [ 1] 1368 	push	#<(___str_20+0)
      008A44 4B 80            [ 1] 1369 	push	#((___str_20+0) >> 8)
      008A46 AE 01 01         [ 2] 1370 	ldw	x, #(_buffer+0)
      008A49 CD 8A EB         [ 4] 1371 	call	_memcmp
      008A4C 5D               [ 2] 1372 	tnzw	x
      008A4D 26 04            [ 1] 1373 	jrne	00110$
                                   1374 ;	main.c: 502: return 7;
      008A4F AE 00 07         [ 2] 1375 	ldw	x, #0x0007
      008A52 81               [ 4] 1376 	ret
      008A53                       1377 00110$:
                                   1378 ;	main.c: 504: get_addr_from_buff();
      008A53 CD 85 3F         [ 4] 1379 	call	_get_addr_from_buff
                                   1380 ;	main.c: 505: get_size_from_buff();
      008A56 CD 85 84         [ 4] 1381 	call	_get_size_from_buff
                                   1382 ;	main.c: 507: if(memcmp(&buffer[0],"SR",2) == 0)
      008A59 4B 02            [ 1] 1383 	push	#0x02
      008A5B 4B 00            [ 1] 1384 	push	#0x00
      008A5D 4B A8            [ 1] 1385 	push	#<(___str_21+0)
      008A5F 4B 80            [ 1] 1386 	push	#((___str_21+0) >> 8)
      008A61 AE 01 01         [ 2] 1387 	ldw	x, #(_buffer+0)
      008A64 CD 8A EB         [ 4] 1388 	call	_memcmp
      008A67 5D               [ 2] 1389 	tnzw	x
      008A68 26 04            [ 1] 1390 	jrne	00112$
                                   1391 ;	main.c: 508: return 3;
      008A6A AE 00 03         [ 2] 1392 	ldw	x, #0x0003
      008A6D 81               [ 4] 1393 	ret
      008A6E                       1394 00112$:
                                   1395 ;	main.c: 510: char_buffer_to_int();
      008A6E CD 85 DE         [ 4] 1396 	call	_char_buffer_to_int
                                   1397 ;	main.c: 512: if(memcmp(&buffer[0],"SW",2) == 0)
      008A71 4B 02            [ 1] 1398 	push	#0x02
      008A73 4B 00            [ 1] 1399 	push	#0x00
      008A75 4B AB            [ 1] 1400 	push	#<(___str_22+0)
      008A77 4B 80            [ 1] 1401 	push	#((___str_22+0) >> 8)
      008A79 AE 01 01         [ 2] 1402 	ldw	x, #(_buffer+0)
      008A7C CD 8A EB         [ 4] 1403 	call	_memcmp
      008A7F 5D               [ 2] 1404 	tnzw	x
      008A80 26 04            [ 1] 1405 	jrne	00114$
                                   1406 ;	main.c: 513: return 4;
      008A82 AE 00 04         [ 2] 1407 	ldw	x, #0x0004
      008A85 81               [ 4] 1408 	ret
      008A86                       1409 00114$:
                                   1410 ;	main.c: 514: return 0;
      008A86 5F               [ 1] 1411 	clrw	x
                                   1412 ;	main.c: 516: }
      008A87 81               [ 4] 1413 	ret
                                   1414 ;	main.c: 518: void command_switcher(void)
                                   1415 ;	-----------------------------------------
                                   1416 ;	 function command_switcher
                                   1417 ;	-----------------------------------------
      008A88                       1418 _command_switcher:
      008A88 52 04            [ 2] 1419 	sub	sp, #4
                                   1420 ;	main.c: 520: char ar[4]={0};
      008A8A 0F 01            [ 1] 1421 	clr	(0x01, sp)
      008A8C 0F 02            [ 1] 1422 	clr	(0x02, sp)
      008A8E 0F 03            [ 1] 1423 	clr	(0x03, sp)
      008A90 0F 04            [ 1] 1424 	clr	(0x04, sp)
                                   1425 ;	main.c: 522: switch(data_handler())
      008A92 CD 89 C4         [ 4] 1426 	call	_data_handler
      008A95 5D               [ 2] 1427 	tnzw	x
      008A96 2B 3B            [ 1] 1428 	jrmi	00109$
      008A98 A3 00 07         [ 2] 1429 	cpw	x, #0x0007
      008A9B 2C 36            [ 1] 1430 	jrsgt	00109$
      008A9D 58               [ 2] 1431 	sllw	x
      008A9E DE 8A A2         [ 2] 1432 	ldw	x, (#00123$, x)
      008AA1 FC               [ 2] 1433 	jp	(x)
      008AA2                       1434 00123$:
      008AA2 8A D3                 1435 	.dw	#00109$
      008AA4 8A B2                 1436 	.dw	#00101$
      008AA6 8A B7                 1437 	.dw	#00102$
      008AA8 8A BC                 1438 	.dw	#00103$
      008AAA 8A C1                 1439 	.dw	#00104$
      008AAC 8A C6                 1440 	.dw	#00105$
      008AAE 8A CB                 1441 	.dw	#00106$
      008AB0 8A D0                 1442 	.dw	#00107$
                                   1443 ;	main.c: 524: case 1:
      008AB2                       1444 00101$:
                                   1445 ;	main.c: 525: cm_SM();
      008AB2 CD 88 9B         [ 4] 1446 	call	_cm_SM
                                   1447 ;	main.c: 526: break;
      008AB5 20 1C            [ 2] 1448 	jra	00109$
                                   1449 ;	main.c: 527: case 2:
      008AB7                       1450 00102$:
                                   1451 ;	main.c: 528: cm_SN();
      008AB7 CD 88 C1         [ 4] 1452 	call	_cm_SN
                                   1453 ;	main.c: 529: break;
      008ABA 20 17            [ 2] 1454 	jra	00109$
                                   1455 ;	main.c: 530: case 3:
      008ABC                       1456 00103$:
                                   1457 ;	main.c: 531: cm_SR();
      008ABC CD 88 E2         [ 4] 1458 	call	_cm_SR
                                   1459 ;	main.c: 532: break;
      008ABF 20 12            [ 2] 1460 	jra	00109$
                                   1461 ;	main.c: 533: case 4:
      008AC1                       1462 00104$:
                                   1463 ;	main.c: 534: cm_SW();
      008AC1 CD 89 53         [ 4] 1464 	call	_cm_SW
                                   1465 ;	main.c: 535: break;
      008AC4 20 0D            [ 2] 1466 	jra	00109$
                                   1467 ;	main.c: 536: case 5:
      008AC6                       1468 00105$:
                                   1469 ;	main.c: 537: cm_ST();
      008AC6 CD 88 D4         [ 4] 1470 	call	_cm_ST
                                   1471 ;	main.c: 538: break;
      008AC9 20 08            [ 2] 1472 	jra	00109$
                                   1473 ;	main.c: 539: case 6:
      008ACB                       1474 00106$:
                                   1475 ;	main.c: 540: cm_RM();
      008ACB CD 88 C7         [ 4] 1476 	call	_cm_RM
                                   1477 ;	main.c: 541: break;
      008ACE 20 03            [ 2] 1478 	jra	00109$
                                   1479 ;	main.c: 542: case 7:
      008AD0                       1480 00107$:
                                   1481 ;	main.c: 543: cm_DB();
      008AD0 CD 88 D1         [ 4] 1482 	call	_cm_DB
                                   1483 ;	main.c: 545: }
      008AD3                       1484 00109$:
                                   1485 ;	main.c: 546: }
      008AD3 5B 04            [ 2] 1486 	addw	sp, #4
      008AD5 81               [ 4] 1487 	ret
                                   1488 ;	main.c: 549: void main(void)
                                   1489 ;	-----------------------------------------
                                   1490 ;	 function main
                                   1491 ;	-----------------------------------------
      008AD6                       1492 _main:
                                   1493 ;	main.c: 551: uart_init();
      008AD6 CD 87 56         [ 4] 1494 	call	_uart_init
                                   1495 ;	main.c: 552: i2c_init();
      008AD9 CD 87 73         [ 4] 1496 	call	_i2c_init
                                   1497 ;	main.c: 553: uart_write("SS\n");
      008ADC AE 80 AE         [ 2] 1498 	ldw	x, #(___str_23+0)
      008ADF CD 83 F1         [ 4] 1499 	call	_uart_write
                                   1500 ;	main.c: 554: while(1)
      008AE2                       1501 00102$:
                                   1502 ;	main.c: 556: uart_read();
      008AE2 CD 84 25         [ 4] 1503 	call	_uart_read
                                   1504 ;	main.c: 557: command_switcher();
      008AE5 CD 8A 88         [ 4] 1505 	call	_command_switcher
      008AE8 20 F8            [ 2] 1506 	jra	00102$
                                   1507 ;	main.c: 559: }
      008AEA 81               [ 4] 1508 	ret
                                   1509 	.area CODE
                                   1510 	.area CONST
                                   1511 	.area CONST
      00802D                       1512 ___str_0:
      00802D 0A                    1513 	.db 0x0a
      00802E 49 32 43 5F 52 45 47  1514 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                    1515 	.db 0x0a
      00803B 00                    1516 	.db 0x00
                                   1517 	.area CODE
                                   1518 	.area CONST
      00803C                       1519 ___str_1:
      00803C 0A                    1520 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20  1521 	.ascii "SR1 -> "
      008044 00                    1522 	.db 0x00
                                   1523 	.area CODE
                                   1524 	.area CONST
      008045                       1525 ___str_2:
      008045 20 3C 2D              1526 	.ascii " <-"
      008048 0A                    1527 	.db 0x0a
      008049 00                    1528 	.db 0x00
                                   1529 	.area CODE
                                   1530 	.area CONST
      00804A                       1531 ___str_3:
      00804A 53 52 32 20 2D 3E 20  1532 	.ascii "SR2 -> "
      008051 00                    1533 	.db 0x00
                                   1534 	.area CODE
                                   1535 	.area CONST
      008052                       1536 ___str_4:
      008052 53 52 33 20 2D 3E 20  1537 	.ascii "SR3 -> "
      008059 00                    1538 	.db 0x00
                                   1539 	.area CODE
                                   1540 	.area CONST
      00805A                       1541 ___str_5:
      00805A 43 52 31 20 2D 3E 20  1542 	.ascii "CR1 -> "
      008061 00                    1543 	.db 0x00
                                   1544 	.area CODE
                                   1545 	.area CONST
      008062                       1546 ___str_6:
      008062 43 52 32 20 2D 3E 20  1547 	.ascii "CR2 -> "
      008069 00                    1548 	.db 0x00
                                   1549 	.area CODE
                                   1550 	.area CONST
      00806A                       1551 ___str_7:
      00806A 44 52 20 2D 3E 20     1552 	.ascii "DR -> "
      008070 00                    1553 	.db 0x00
                                   1554 	.area CODE
                                   1555 	.area CONST
      008071                       1556 ___str_8:
      008071 55 41 52 54 5F 52 45  1557 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      00807E 0A                    1558 	.db 0x0a
      00807F 00                    1559 	.db 0x00
                                   1560 	.area CODE
                                   1561 	.area CONST
      008080                       1562 ___str_9:
      008080 53 4D 20              1563 	.ascii "SM "
      008083 00                    1564 	.db 0x00
                                   1565 	.area CODE
                                   1566 	.area CONST
      008084                       1567 ___str_10:
      008084 0D                    1568 	.db 0x0d
      008085 0A                    1569 	.db 0x0a
      008086 00                    1570 	.db 0x00
                                   1571 	.area CODE
                                   1572 	.area CONST
      008087                       1573 ___str_11:
      008087 52 4D                 1574 	.ascii "RM"
      008089 0A                    1575 	.db 0x0a
      00808A 00                    1576 	.db 0x00
                                   1577 	.area CODE
                                   1578 	.area CONST
      00808B                       1579 ___str_12:
      00808B 53 54                 1580 	.ascii "ST"
      00808D 0A                    1581 	.db 0x0a
      00808E 00                    1582 	.db 0x00
                                   1583 	.area CODE
                                   1584 	.area CONST
      00808F                       1585 ___str_13:
      00808F 53 52 20              1586 	.ascii "SR "
      008092 00                    1587 	.db 0x00
                                   1588 	.area CODE
                                   1589 	.area CONST
      008093                       1590 ___str_14:
      008093 20                    1591 	.ascii " "
      008094 00                    1592 	.db 0x00
                                   1593 	.area CODE
                                   1594 	.area CONST
      008095                       1595 ___str_15:
      008095 53 57 20              1596 	.ascii "SW "
      008098 00                    1597 	.db 0x00
                                   1598 	.area CODE
                                   1599 	.area CONST
      008099                       1600 ___str_16:
      008099 53 4D                 1601 	.ascii "SM"
      00809B 00                    1602 	.db 0x00
                                   1603 	.area CODE
                                   1604 	.area CONST
      00809C                       1605 ___str_17:
      00809C 53 4E                 1606 	.ascii "SN"
      00809E 00                    1607 	.db 0x00
                                   1608 	.area CODE
                                   1609 	.area CONST
      00809F                       1610 ___str_18:
      00809F 53 54                 1611 	.ascii "ST"
      0080A1 00                    1612 	.db 0x00
                                   1613 	.area CODE
                                   1614 	.area CONST
      0080A2                       1615 ___str_19:
      0080A2 52 4D                 1616 	.ascii "RM"
      0080A4 00                    1617 	.db 0x00
                                   1618 	.area CODE
                                   1619 	.area CONST
      0080A5                       1620 ___str_20:
      0080A5 44 42                 1621 	.ascii "DB"
      0080A7 00                    1622 	.db 0x00
                                   1623 	.area CODE
                                   1624 	.area CONST
      0080A8                       1625 ___str_21:
      0080A8 53 52                 1626 	.ascii "SR"
      0080AA 00                    1627 	.db 0x00
                                   1628 	.area CODE
                                   1629 	.area CONST
      0080AB                       1630 ___str_22:
      0080AB 53 57                 1631 	.ascii "SW"
      0080AD 00                    1632 	.db 0x00
                                   1633 	.area CODE
                                   1634 	.area CONST
      0080AE                       1635 ___str_23:
      0080AE 53 53                 1636 	.ascii "SS"
      0080B0 0A                    1637 	.db 0x0a
      0080B1 00                    1638 	.db 0x00
                                   1639 	.area CODE
                                   1640 	.area INITIALIZER
      0080B2                       1641 __xinit__status_registers:
      0080B2 00                    1642 	.db #0x00	; 0
      0080B3 00                    1643 	.db 0x00
      0080B4 00                    1644 	.db 0x00
      0080B5 00                    1645 	.db 0x00
      0080B6 00                    1646 	.db 0x00
      0080B7 00                    1647 	.db 0x00
      0080B8 00                    1648 	.db 0x00
      0080B9 00                    1649 	.db 0x00
      0080BA 00                    1650 	.db 0x00
      0080BB 00                    1651 	.db 0x00
      0080BC 00                    1652 	.db 0x00
      0080BD 00                    1653 	.db 0x00
      0080BE 00                    1654 	.db 0x00
      0080BF 00                    1655 	.db 0x00
      0080C0 00                    1656 	.db 0x00
      0080C1 00                    1657 	.db 0x00
      0080C2 00                    1658 	.db 0x00
      0080C3 00                    1659 	.db 0x00
      0080C4 00                    1660 	.db 0x00
      0080C5 00                    1661 	.db 0x00
      0080C6 00                    1662 	.db 0x00
      0080C7 00                    1663 	.db 0x00
      0080C8 00                    1664 	.db 0x00
      0080C9 00                    1665 	.db 0x00
      0080CA 00                    1666 	.db 0x00
      0080CB 00                    1667 	.db 0x00
      0080CC 00                    1668 	.db 0x00
      0080CD 00                    1669 	.db 0x00
      0080CE 00                    1670 	.db 0x00
      0080CF 00                    1671 	.db 0x00
      0080D0 00                    1672 	.db 0x00
      0080D1 00                    1673 	.db 0x00
      0080D2 00                    1674 	.db 0x00
      0080D3 00                    1675 	.db 0x00
      0080D4 00                    1676 	.db 0x00
      0080D5 00                    1677 	.db 0x00
      0080D6 00                    1678 	.db 0x00
      0080D7 00                    1679 	.db 0x00
      0080D8 00                    1680 	.db 0x00
      0080D9 00                    1681 	.db 0x00
      0080DA 00                    1682 	.db 0x00
      0080DB 00                    1683 	.db 0x00
      0080DC 00                    1684 	.db 0x00
      0080DD 00                    1685 	.db 0x00
      0080DE 00                    1686 	.db 0x00
      0080DF 00                    1687 	.db 0x00
      0080E0 00                    1688 	.db 0x00
      0080E1 00                    1689 	.db 0x00
      0080E2 00                    1690 	.db 0x00
      0080E3 00                    1691 	.db 0x00
      0080E4 00                    1692 	.db 0x00
      0080E5 00                    1693 	.db 0x00
      0080E6 00                    1694 	.db 0x00
      0080E7 00                    1695 	.db 0x00
      0080E8 00                    1696 	.db 0x00
      0080E9 00                    1697 	.db 0x00
      0080EA 00                    1698 	.db 0x00
      0080EB 00                    1699 	.db 0x00
      0080EC 00                    1700 	.db 0x00
      0080ED 00                    1701 	.db 0x00
      0080EE 00                    1702 	.db 0x00
      0080EF 00                    1703 	.db 0x00
      0080F0 00                    1704 	.db 0x00
      0080F1 00                    1705 	.db 0x00
      0080F2 00                    1706 	.db 0x00
      0080F3 00                    1707 	.db 0x00
      0080F4 00                    1708 	.db 0x00
      0080F5 00                    1709 	.db 0x00
      0080F6 00                    1710 	.db 0x00
      0080F7 00                    1711 	.db 0x00
      0080F8 00                    1712 	.db 0x00
      0080F9 00                    1713 	.db 0x00
      0080FA 00                    1714 	.db 0x00
      0080FB 00                    1715 	.db 0x00
      0080FC 00                    1716 	.db 0x00
      0080FD 00                    1717 	.db 0x00
      0080FE 00                    1718 	.db 0x00
      0080FF 00                    1719 	.db 0x00
      008100 00                    1720 	.db 0x00
      008101 00                    1721 	.db 0x00
      008102 00                    1722 	.db 0x00
      008103 00                    1723 	.db 0x00
      008104 00                    1724 	.db 0x00
      008105 00                    1725 	.db 0x00
      008106 00                    1726 	.db 0x00
      008107 00                    1727 	.db 0x00
      008108 00                    1728 	.db 0x00
      008109 00                    1729 	.db 0x00
      00810A 00                    1730 	.db 0x00
      00810B 00                    1731 	.db 0x00
      00810C 00                    1732 	.db 0x00
      00810D 00                    1733 	.db 0x00
      00810E 00                    1734 	.db 0x00
      00810F 00                    1735 	.db 0x00
      008110 00                    1736 	.db 0x00
      008111 00                    1737 	.db 0x00
      008112 00                    1738 	.db 0x00
      008113 00                    1739 	.db 0x00
      008114 00                    1740 	.db 0x00
      008115 00                    1741 	.db 0x00
      008116 00                    1742 	.db 0x00
      008117 00                    1743 	.db 0x00
      008118 00                    1744 	.db 0x00
      008119 00                    1745 	.db 0x00
      00811A 00                    1746 	.db 0x00
      00811B 00                    1747 	.db 0x00
      00811C 00                    1748 	.db 0x00
      00811D 00                    1749 	.db 0x00
      00811E 00                    1750 	.db 0x00
      00811F 00                    1751 	.db 0x00
      008120 00                    1752 	.db 0x00
      008121 00                    1753 	.db 0x00
      008122 00                    1754 	.db 0x00
      008123 00                    1755 	.db 0x00
      008124 00                    1756 	.db 0x00
      008125 00                    1757 	.db 0x00
      008126 00                    1758 	.db 0x00
      008127 00                    1759 	.db 0x00
      008128 00                    1760 	.db 0x00
      008129 00                    1761 	.db 0x00
      00812A 00                    1762 	.db 0x00
      00812B 00                    1763 	.db 0x00
      00812C 00                    1764 	.db 0x00
      00812D 00                    1765 	.db 0x00
      00812E 00                    1766 	.db 0x00
      00812F 00                    1767 	.db 0x00
      008130 00                    1768 	.db 0x00
      008131 00                    1769 	.db 0x00
      008132 00                    1770 	.db 0x00
      008133 00                    1771 	.db 0x00
      008134 00                    1772 	.db 0x00
      008135 00                    1773 	.db 0x00
      008136 00                    1774 	.db 0x00
      008137 00                    1775 	.db 0x00
      008138 00                    1776 	.db 0x00
      008139 00                    1777 	.db 0x00
      00813A 00                    1778 	.db 0x00
      00813B 00                    1779 	.db 0x00
      00813C 00                    1780 	.db 0x00
      00813D 00                    1781 	.db 0x00
      00813E 00                    1782 	.db 0x00
      00813F 00                    1783 	.db 0x00
      008140 00                    1784 	.db 0x00
      008141 00                    1785 	.db 0x00
      008142 00                    1786 	.db 0x00
      008143 00                    1787 	.db 0x00
      008144 00                    1788 	.db 0x00
      008145 00                    1789 	.db 0x00
      008146 00                    1790 	.db 0x00
      008147 00                    1791 	.db 0x00
      008148 00                    1792 	.db 0x00
      008149 00                    1793 	.db 0x00
      00814A 00                    1794 	.db 0x00
      00814B 00                    1795 	.db 0x00
      00814C 00                    1796 	.db 0x00
      00814D 00                    1797 	.db 0x00
      00814E 00                    1798 	.db 0x00
      00814F 00                    1799 	.db 0x00
      008150 00                    1800 	.db 0x00
      008151 00                    1801 	.db 0x00
      008152 00                    1802 	.db 0x00
      008153 00                    1803 	.db 0x00
      008154 00                    1804 	.db 0x00
      008155 00                    1805 	.db 0x00
      008156 00                    1806 	.db 0x00
      008157 00                    1807 	.db 0x00
      008158 00                    1808 	.db 0x00
      008159 00                    1809 	.db 0x00
      00815A 00                    1810 	.db 0x00
      00815B 00                    1811 	.db 0x00
      00815C 00                    1812 	.db 0x00
      00815D 00                    1813 	.db 0x00
      00815E 00                    1814 	.db 0x00
      00815F 00                    1815 	.db 0x00
      008160 00                    1816 	.db 0x00
      008161 00                    1817 	.db 0x00
      008162 00                    1818 	.db 0x00
      008163 00                    1819 	.db 0x00
      008164 00                    1820 	.db 0x00
      008165 00                    1821 	.db 0x00
      008166 00                    1822 	.db 0x00
      008167 00                    1823 	.db 0x00
      008168 00                    1824 	.db 0x00
      008169 00                    1825 	.db 0x00
      00816A 00                    1826 	.db 0x00
      00816B 00                    1827 	.db 0x00
      00816C 00                    1828 	.db 0x00
      00816D 00                    1829 	.db 0x00
      00816E 00                    1830 	.db 0x00
      00816F 00                    1831 	.db 0x00
      008170 00                    1832 	.db 0x00
      008171 00                    1833 	.db 0x00
      008172 00                    1834 	.db 0x00
      008173 00                    1835 	.db 0x00
      008174 00                    1836 	.db 0x00
      008175 00                    1837 	.db 0x00
      008176 00                    1838 	.db 0x00
      008177 00                    1839 	.db 0x00
      008178 00                    1840 	.db 0x00
      008179 00                    1841 	.db 0x00
      00817A 00                    1842 	.db 0x00
      00817B 00                    1843 	.db 0x00
      00817C 00                    1844 	.db 0x00
      00817D 00                    1845 	.db 0x00
      00817E 00                    1846 	.db 0x00
      00817F 00                    1847 	.db 0x00
      008180 00                    1848 	.db 0x00
      008181 00                    1849 	.db 0x00
      008182 00                    1850 	.db 0x00
      008183 00                    1851 	.db 0x00
      008184 00                    1852 	.db 0x00
      008185 00                    1853 	.db 0x00
      008186 00                    1854 	.db 0x00
      008187 00                    1855 	.db 0x00
      008188 00                    1856 	.db 0x00
      008189 00                    1857 	.db 0x00
      00818A 00                    1858 	.db 0x00
      00818B 00                    1859 	.db 0x00
      00818C 00                    1860 	.db 0x00
      00818D 00                    1861 	.db 0x00
      00818E 00                    1862 	.db 0x00
      00818F 00                    1863 	.db 0x00
      008190 00                    1864 	.db 0x00
      008191 00                    1865 	.db 0x00
      008192 00                    1866 	.db 0x00
      008193 00                    1867 	.db 0x00
      008194 00                    1868 	.db 0x00
      008195 00                    1869 	.db 0x00
      008196 00                    1870 	.db 0x00
      008197 00                    1871 	.db 0x00
      008198 00                    1872 	.db 0x00
      008199 00                    1873 	.db 0x00
      00819A 00                    1874 	.db 0x00
      00819B 00                    1875 	.db 0x00
      00819C 00                    1876 	.db 0x00
      00819D 00                    1877 	.db 0x00
      00819E 00                    1878 	.db 0x00
      00819F 00                    1879 	.db 0x00
      0081A0 00                    1880 	.db 0x00
      0081A1 00                    1881 	.db 0x00
      0081A2 00                    1882 	.db 0x00
      0081A3 00                    1883 	.db 0x00
      0081A4 00                    1884 	.db 0x00
      0081A5 00                    1885 	.db 0x00
      0081A6 00                    1886 	.db 0x00
      0081A7 00                    1887 	.db 0x00
      0081A8 00                    1888 	.db 0x00
      0081A9 00                    1889 	.db 0x00
      0081AA 00                    1890 	.db 0x00
      0081AB 00                    1891 	.db 0x00
      0081AC 00                    1892 	.db 0x00
      0081AD 00                    1893 	.db 0x00
      0081AE 00                    1894 	.db 0x00
      0081AF 00                    1895 	.db 0x00
      0081B0 00                    1896 	.db 0x00
      0081B1 00                    1897 	.db 0x00
      0081B2                       1898 __xinit__buffer:
      0081B2 00                    1899 	.db #0x00	; 0
      0081B3 00                    1900 	.db 0x00
      0081B4 00                    1901 	.db 0x00
      0081B5 00                    1902 	.db 0x00
      0081B6 00                    1903 	.db 0x00
      0081B7 00                    1904 	.db 0x00
      0081B8 00                    1905 	.db 0x00
      0081B9 00                    1906 	.db 0x00
      0081BA 00                    1907 	.db 0x00
      0081BB 00                    1908 	.db 0x00
      0081BC 00                    1909 	.db 0x00
      0081BD 00                    1910 	.db 0x00
      0081BE 00                    1911 	.db 0x00
      0081BF 00                    1912 	.db 0x00
      0081C0 00                    1913 	.db 0x00
      0081C1 00                    1914 	.db 0x00
      0081C2 00                    1915 	.db 0x00
      0081C3 00                    1916 	.db 0x00
      0081C4 00                    1917 	.db 0x00
      0081C5 00                    1918 	.db 0x00
      0081C6 00                    1919 	.db 0x00
      0081C7 00                    1920 	.db 0x00
      0081C8 00                    1921 	.db 0x00
      0081C9 00                    1922 	.db 0x00
      0081CA 00                    1923 	.db 0x00
      0081CB 00                    1924 	.db 0x00
      0081CC 00                    1925 	.db 0x00
      0081CD 00                    1926 	.db 0x00
      0081CE 00                    1927 	.db 0x00
      0081CF 00                    1928 	.db 0x00
      0081D0 00                    1929 	.db 0x00
      0081D1 00                    1930 	.db 0x00
      0081D2 00                    1931 	.db 0x00
      0081D3 00                    1932 	.db 0x00
      0081D4 00                    1933 	.db 0x00
      0081D5 00                    1934 	.db 0x00
      0081D6 00                    1935 	.db 0x00
      0081D7 00                    1936 	.db 0x00
      0081D8 00                    1937 	.db 0x00
      0081D9 00                    1938 	.db 0x00
      0081DA 00                    1939 	.db 0x00
      0081DB 00                    1940 	.db 0x00
      0081DC 00                    1941 	.db 0x00
      0081DD 00                    1942 	.db 0x00
      0081DE 00                    1943 	.db 0x00
      0081DF 00                    1944 	.db 0x00
      0081E0 00                    1945 	.db 0x00
      0081E1 00                    1946 	.db 0x00
      0081E2 00                    1947 	.db 0x00
      0081E3 00                    1948 	.db 0x00
      0081E4 00                    1949 	.db 0x00
      0081E5 00                    1950 	.db 0x00
      0081E6 00                    1951 	.db 0x00
      0081E7 00                    1952 	.db 0x00
      0081E8 00                    1953 	.db 0x00
      0081E9 00                    1954 	.db 0x00
      0081EA 00                    1955 	.db 0x00
      0081EB 00                    1956 	.db 0x00
      0081EC 00                    1957 	.db 0x00
      0081ED 00                    1958 	.db 0x00
      0081EE 00                    1959 	.db 0x00
      0081EF 00                    1960 	.db 0x00
      0081F0 00                    1961 	.db 0x00
      0081F1 00                    1962 	.db 0x00
      0081F2 00                    1963 	.db 0x00
      0081F3 00                    1964 	.db 0x00
      0081F4 00                    1965 	.db 0x00
      0081F5 00                    1966 	.db 0x00
      0081F6 00                    1967 	.db 0x00
      0081F7 00                    1968 	.db 0x00
      0081F8 00                    1969 	.db 0x00
      0081F9 00                    1970 	.db 0x00
      0081FA 00                    1971 	.db 0x00
      0081FB 00                    1972 	.db 0x00
      0081FC 00                    1973 	.db 0x00
      0081FD 00                    1974 	.db 0x00
      0081FE 00                    1975 	.db 0x00
      0081FF 00                    1976 	.db 0x00
      008200 00                    1977 	.db 0x00
      008201 00                    1978 	.db 0x00
      008202 00                    1979 	.db 0x00
      008203 00                    1980 	.db 0x00
      008204 00                    1981 	.db 0x00
      008205 00                    1982 	.db 0x00
      008206 00                    1983 	.db 0x00
      008207 00                    1984 	.db 0x00
      008208 00                    1985 	.db 0x00
      008209 00                    1986 	.db 0x00
      00820A 00                    1987 	.db 0x00
      00820B 00                    1988 	.db 0x00
      00820C 00                    1989 	.db 0x00
      00820D 00                    1990 	.db 0x00
      00820E 00                    1991 	.db 0x00
      00820F 00                    1992 	.db 0x00
      008210 00                    1993 	.db 0x00
      008211 00                    1994 	.db 0x00
      008212 00                    1995 	.db 0x00
      008213 00                    1996 	.db 0x00
      008214 00                    1997 	.db 0x00
      008215 00                    1998 	.db 0x00
      008216 00                    1999 	.db 0x00
      008217 00                    2000 	.db 0x00
      008218 00                    2001 	.db 0x00
      008219 00                    2002 	.db 0x00
      00821A 00                    2003 	.db 0x00
      00821B 00                    2004 	.db 0x00
      00821C 00                    2005 	.db 0x00
      00821D 00                    2006 	.db 0x00
      00821E 00                    2007 	.db 0x00
      00821F 00                    2008 	.db 0x00
      008220 00                    2009 	.db 0x00
      008221 00                    2010 	.db 0x00
      008222 00                    2011 	.db 0x00
      008223 00                    2012 	.db 0x00
      008224 00                    2013 	.db 0x00
      008225 00                    2014 	.db 0x00
      008226 00                    2015 	.db 0x00
      008227 00                    2016 	.db 0x00
      008228 00                    2017 	.db 0x00
      008229 00                    2018 	.db 0x00
      00822A 00                    2019 	.db 0x00
      00822B 00                    2020 	.db 0x00
      00822C 00                    2021 	.db 0x00
      00822D 00                    2022 	.db 0x00
      00822E 00                    2023 	.db 0x00
      00822F 00                    2024 	.db 0x00
      008230 00                    2025 	.db 0x00
      008231 00                    2026 	.db 0x00
      008232 00                    2027 	.db 0x00
      008233 00                    2028 	.db 0x00
      008234 00                    2029 	.db 0x00
      008235 00                    2030 	.db 0x00
      008236 00                    2031 	.db 0x00
      008237 00                    2032 	.db 0x00
      008238 00                    2033 	.db 0x00
      008239 00                    2034 	.db 0x00
      00823A 00                    2035 	.db 0x00
      00823B 00                    2036 	.db 0x00
      00823C 00                    2037 	.db 0x00
      00823D 00                    2038 	.db 0x00
      00823E 00                    2039 	.db 0x00
      00823F 00                    2040 	.db 0x00
      008240 00                    2041 	.db 0x00
      008241 00                    2042 	.db 0x00
      008242 00                    2043 	.db 0x00
      008243 00                    2044 	.db 0x00
      008244 00                    2045 	.db 0x00
      008245 00                    2046 	.db 0x00
      008246 00                    2047 	.db 0x00
      008247 00                    2048 	.db 0x00
      008248 00                    2049 	.db 0x00
      008249 00                    2050 	.db 0x00
      00824A 00                    2051 	.db 0x00
      00824B 00                    2052 	.db 0x00
      00824C 00                    2053 	.db 0x00
      00824D 00                    2054 	.db 0x00
      00824E 00                    2055 	.db 0x00
      00824F 00                    2056 	.db 0x00
      008250 00                    2057 	.db 0x00
      008251 00                    2058 	.db 0x00
      008252 00                    2059 	.db 0x00
      008253 00                    2060 	.db 0x00
      008254 00                    2061 	.db 0x00
      008255 00                    2062 	.db 0x00
      008256 00                    2063 	.db 0x00
      008257 00                    2064 	.db 0x00
      008258 00                    2065 	.db 0x00
      008259 00                    2066 	.db 0x00
      00825A 00                    2067 	.db 0x00
      00825B 00                    2068 	.db 0x00
      00825C 00                    2069 	.db 0x00
      00825D 00                    2070 	.db 0x00
      00825E 00                    2071 	.db 0x00
      00825F 00                    2072 	.db 0x00
      008260 00                    2073 	.db 0x00
      008261 00                    2074 	.db 0x00
      008262 00                    2075 	.db 0x00
      008263 00                    2076 	.db 0x00
      008264 00                    2077 	.db 0x00
      008265 00                    2078 	.db 0x00
      008266 00                    2079 	.db 0x00
      008267 00                    2080 	.db 0x00
      008268 00                    2081 	.db 0x00
      008269 00                    2082 	.db 0x00
      00826A 00                    2083 	.db 0x00
      00826B 00                    2084 	.db 0x00
      00826C 00                    2085 	.db 0x00
      00826D 00                    2086 	.db 0x00
      00826E 00                    2087 	.db 0x00
      00826F 00                    2088 	.db 0x00
      008270 00                    2089 	.db 0x00
      008271 00                    2090 	.db 0x00
      008272 00                    2091 	.db 0x00
      008273 00                    2092 	.db 0x00
      008274 00                    2093 	.db 0x00
      008275 00                    2094 	.db 0x00
      008276 00                    2095 	.db 0x00
      008277 00                    2096 	.db 0x00
      008278 00                    2097 	.db 0x00
      008279 00                    2098 	.db 0x00
      00827A 00                    2099 	.db 0x00
      00827B 00                    2100 	.db 0x00
      00827C 00                    2101 	.db 0x00
      00827D 00                    2102 	.db 0x00
      00827E 00                    2103 	.db 0x00
      00827F 00                    2104 	.db 0x00
      008280 00                    2105 	.db 0x00
      008281 00                    2106 	.db 0x00
      008282 00                    2107 	.db 0x00
      008283 00                    2108 	.db 0x00
      008284 00                    2109 	.db 0x00
      008285 00                    2110 	.db 0x00
      008286 00                    2111 	.db 0x00
      008287 00                    2112 	.db 0x00
      008288 00                    2113 	.db 0x00
      008289 00                    2114 	.db 0x00
      00828A 00                    2115 	.db 0x00
      00828B 00                    2116 	.db 0x00
      00828C 00                    2117 	.db 0x00
      00828D 00                    2118 	.db 0x00
      00828E 00                    2119 	.db 0x00
      00828F 00                    2120 	.db 0x00
      008290 00                    2121 	.db 0x00
      008291 00                    2122 	.db 0x00
      008292 00                    2123 	.db 0x00
      008293 00                    2124 	.db 0x00
      008294 00                    2125 	.db 0x00
      008295 00                    2126 	.db 0x00
      008296 00                    2127 	.db 0x00
      008297 00                    2128 	.db 0x00
      008298 00                    2129 	.db 0x00
      008299 00                    2130 	.db 0x00
      00829A 00                    2131 	.db 0x00
      00829B 00                    2132 	.db 0x00
      00829C 00                    2133 	.db 0x00
      00829D 00                    2134 	.db 0x00
      00829E 00                    2135 	.db 0x00
      00829F 00                    2136 	.db 0x00
      0082A0 00                    2137 	.db 0x00
      0082A1 00                    2138 	.db 0x00
      0082A2 00                    2139 	.db 0x00
      0082A3 00                    2140 	.db 0x00
      0082A4 00                    2141 	.db 0x00
      0082A5 00                    2142 	.db 0x00
      0082A6 00                    2143 	.db 0x00
      0082A7 00                    2144 	.db 0x00
      0082A8 00                    2145 	.db 0x00
      0082A9 00                    2146 	.db 0x00
      0082AA 00                    2147 	.db 0x00
      0082AB 00                    2148 	.db 0x00
      0082AC 00                    2149 	.db 0x00
      0082AD 00                    2150 	.db 0x00
      0082AE 00                    2151 	.db 0x00
      0082AF 00                    2152 	.db 0x00
      0082B0 00                    2153 	.db 0x00
      0082B1 00                    2154 	.db 0x00
      0082B2                       2155 __xinit__a:
      0082B2 00                    2156 	.db #0x00	; 0
      0082B3 00                    2157 	.db 0x00
      0082B4 00                    2158 	.db 0x00
      0082B5                       2159 __xinit__d_addr:
      0082B5 00                    2160 	.db #0x00	; 0
      0082B6                       2161 __xinit__p_size:
      0082B6 00                    2162 	.db #0x00	; 0
      0082B7                       2163 __xinit__d_size:
      0082B7 00                    2164 	.db #0x00	; 0
      0082B8                       2165 __xinit__p_bytes:
      0082B8 00                    2166 	.db #0x00	; 0
      0082B9                       2167 __xinit__data_buf:
      0082B9 00                    2168 	.db #0x00	; 0
      0082BA 00                    2169 	.db 0x00
      0082BB 00                    2170 	.db 0x00
      0082BC 00                    2171 	.db 0x00
      0082BD 00                    2172 	.db 0x00
      0082BE 00                    2173 	.db 0x00
      0082BF 00                    2174 	.db 0x00
      0082C0 00                    2175 	.db 0x00
      0082C1 00                    2176 	.db 0x00
      0082C2 00                    2177 	.db 0x00
      0082C3 00                    2178 	.db 0x00
      0082C4 00                    2179 	.db 0x00
      0082C5 00                    2180 	.db 0x00
      0082C6 00                    2181 	.db 0x00
      0082C7 00                    2182 	.db 0x00
      0082C8 00                    2183 	.db 0x00
      0082C9 00                    2184 	.db 0x00
      0082CA 00                    2185 	.db 0x00
      0082CB 00                    2186 	.db 0x00
      0082CC 00                    2187 	.db 0x00
      0082CD 00                    2188 	.db 0x00
      0082CE 00                    2189 	.db 0x00
      0082CF 00                    2190 	.db 0x00
      0082D0 00                    2191 	.db 0x00
      0082D1 00                    2192 	.db 0x00
      0082D2 00                    2193 	.db 0x00
      0082D3 00                    2194 	.db 0x00
      0082D4 00                    2195 	.db 0x00
      0082D5 00                    2196 	.db 0x00
      0082D6 00                    2197 	.db 0x00
      0082D7 00                    2198 	.db 0x00
      0082D8 00                    2199 	.db 0x00
      0082D9 00                    2200 	.db 0x00
      0082DA 00                    2201 	.db 0x00
      0082DB 00                    2202 	.db 0x00
      0082DC 00                    2203 	.db 0x00
      0082DD 00                    2204 	.db 0x00
      0082DE 00                    2205 	.db 0x00
      0082DF 00                    2206 	.db 0x00
      0082E0 00                    2207 	.db 0x00
      0082E1 00                    2208 	.db 0x00
      0082E2 00                    2209 	.db 0x00
      0082E3 00                    2210 	.db 0x00
      0082E4 00                    2211 	.db 0x00
      0082E5 00                    2212 	.db 0x00
      0082E6 00                    2213 	.db 0x00
      0082E7 00                    2214 	.db 0x00
      0082E8 00                    2215 	.db 0x00
      0082E9 00                    2216 	.db 0x00
      0082EA 00                    2217 	.db 0x00
      0082EB 00                    2218 	.db 0x00
      0082EC 00                    2219 	.db 0x00
      0082ED 00                    2220 	.db 0x00
      0082EE 00                    2221 	.db 0x00
      0082EF 00                    2222 	.db 0x00
      0082F0 00                    2223 	.db 0x00
      0082F1 00                    2224 	.db 0x00
      0082F2 00                    2225 	.db 0x00
      0082F3 00                    2226 	.db 0x00
      0082F4 00                    2227 	.db 0x00
      0082F5 00                    2228 	.db 0x00
      0082F6 00                    2229 	.db 0x00
      0082F7 00                    2230 	.db 0x00
      0082F8 00                    2231 	.db 0x00
      0082F9 00                    2232 	.db 0x00
      0082FA 00                    2233 	.db 0x00
      0082FB 00                    2234 	.db 0x00
      0082FC 00                    2235 	.db 0x00
      0082FD 00                    2236 	.db 0x00
      0082FE 00                    2237 	.db 0x00
      0082FF 00                    2238 	.db 0x00
      008300 00                    2239 	.db 0x00
      008301 00                    2240 	.db 0x00
      008302 00                    2241 	.db 0x00
      008303 00                    2242 	.db 0x00
      008304 00                    2243 	.db 0x00
      008305 00                    2244 	.db 0x00
      008306 00                    2245 	.db 0x00
      008307 00                    2246 	.db 0x00
      008308 00                    2247 	.db 0x00
      008309 00                    2248 	.db 0x00
      00830A 00                    2249 	.db 0x00
      00830B 00                    2250 	.db 0x00
      00830C 00                    2251 	.db 0x00
      00830D 00                    2252 	.db 0x00
      00830E 00                    2253 	.db 0x00
      00830F 00                    2254 	.db 0x00
      008310 00                    2255 	.db 0x00
      008311 00                    2256 	.db 0x00
      008312 00                    2257 	.db 0x00
      008313 00                    2258 	.db 0x00
      008314 00                    2259 	.db 0x00
      008315 00                    2260 	.db 0x00
      008316 00                    2261 	.db 0x00
      008317 00                    2262 	.db 0x00
      008318 00                    2263 	.db 0x00
      008319 00                    2264 	.db 0x00
      00831A 00                    2265 	.db 0x00
      00831B 00                    2266 	.db 0x00
      00831C 00                    2267 	.db 0x00
      00831D 00                    2268 	.db 0x00
      00831E 00                    2269 	.db 0x00
      00831F 00                    2270 	.db 0x00
      008320 00                    2271 	.db 0x00
      008321 00                    2272 	.db 0x00
      008322 00                    2273 	.db 0x00
      008323 00                    2274 	.db 0x00
      008324 00                    2275 	.db 0x00
      008325 00                    2276 	.db 0x00
      008326 00                    2277 	.db 0x00
      008327 00                    2278 	.db 0x00
      008328 00                    2279 	.db 0x00
      008329 00                    2280 	.db 0x00
      00832A 00                    2281 	.db 0x00
      00832B 00                    2282 	.db 0x00
      00832C 00                    2283 	.db 0x00
      00832D 00                    2284 	.db 0x00
      00832E 00                    2285 	.db 0x00
      00832F 00                    2286 	.db 0x00
      008330 00                    2287 	.db 0x00
      008331 00                    2288 	.db 0x00
      008332 00                    2289 	.db 0x00
      008333 00                    2290 	.db 0x00
      008334 00                    2291 	.db 0x00
      008335 00                    2292 	.db 0x00
      008336 00                    2293 	.db 0x00
      008337 00                    2294 	.db 0x00
      008338 00                    2295 	.db 0x00
      008339 00                    2296 	.db 0x00
      00833A 00                    2297 	.db 0x00
      00833B 00                    2298 	.db 0x00
      00833C 00                    2299 	.db 0x00
      00833D 00                    2300 	.db 0x00
      00833E 00                    2301 	.db 0x00
      00833F 00                    2302 	.db 0x00
      008340 00                    2303 	.db 0x00
      008341 00                    2304 	.db 0x00
      008342 00                    2305 	.db 0x00
      008343 00                    2306 	.db 0x00
      008344 00                    2307 	.db 0x00
      008345 00                    2308 	.db 0x00
      008346 00                    2309 	.db 0x00
      008347 00                    2310 	.db 0x00
      008348 00                    2311 	.db 0x00
      008349 00                    2312 	.db 0x00
      00834A 00                    2313 	.db 0x00
      00834B 00                    2314 	.db 0x00
      00834C 00                    2315 	.db 0x00
      00834D 00                    2316 	.db 0x00
      00834E 00                    2317 	.db 0x00
      00834F 00                    2318 	.db 0x00
      008350 00                    2319 	.db 0x00
      008351 00                    2320 	.db 0x00
      008352 00                    2321 	.db 0x00
      008353 00                    2322 	.db 0x00
      008354 00                    2323 	.db 0x00
      008355 00                    2324 	.db 0x00
      008356 00                    2325 	.db 0x00
      008357 00                    2326 	.db 0x00
      008358 00                    2327 	.db 0x00
      008359 00                    2328 	.db 0x00
      00835A 00                    2329 	.db 0x00
      00835B 00                    2330 	.db 0x00
      00835C 00                    2331 	.db 0x00
      00835D 00                    2332 	.db 0x00
      00835E 00                    2333 	.db 0x00
      00835F 00                    2334 	.db 0x00
      008360 00                    2335 	.db 0x00
      008361 00                    2336 	.db 0x00
      008362 00                    2337 	.db 0x00
      008363 00                    2338 	.db 0x00
      008364 00                    2339 	.db 0x00
      008365 00                    2340 	.db 0x00
      008366 00                    2341 	.db 0x00
      008367 00                    2342 	.db 0x00
      008368 00                    2343 	.db 0x00
      008369 00                    2344 	.db 0x00
      00836A 00                    2345 	.db 0x00
      00836B 00                    2346 	.db 0x00
      00836C 00                    2347 	.db 0x00
      00836D 00                    2348 	.db 0x00
      00836E 00                    2349 	.db 0x00
      00836F 00                    2350 	.db 0x00
      008370 00                    2351 	.db 0x00
      008371 00                    2352 	.db 0x00
      008372 00                    2353 	.db 0x00
      008373 00                    2354 	.db 0x00
      008374 00                    2355 	.db 0x00
      008375 00                    2356 	.db 0x00
      008376 00                    2357 	.db 0x00
      008377 00                    2358 	.db 0x00
      008378 00                    2359 	.db 0x00
      008379 00                    2360 	.db 0x00
      00837A 00                    2361 	.db 0x00
      00837B 00                    2362 	.db 0x00
      00837C 00                    2363 	.db 0x00
      00837D 00                    2364 	.db 0x00
      00837E 00                    2365 	.db 0x00
      00837F 00                    2366 	.db 0x00
      008380 00                    2367 	.db 0x00
      008381 00                    2368 	.db 0x00
      008382 00                    2369 	.db 0x00
      008383 00                    2370 	.db 0x00
      008384 00                    2371 	.db 0x00
      008385 00                    2372 	.db 0x00
      008386 00                    2373 	.db 0x00
      008387 00                    2374 	.db 0x00
      008388 00                    2375 	.db 0x00
      008389 00                    2376 	.db 0x00
      00838A 00                    2377 	.db 0x00
      00838B 00                    2378 	.db 0x00
      00838C 00                    2379 	.db 0x00
      00838D 00                    2380 	.db 0x00
      00838E 00                    2381 	.db 0x00
      00838F 00                    2382 	.db 0x00
      008390 00                    2383 	.db 0x00
      008391 00                    2384 	.db 0x00
      008392 00                    2385 	.db 0x00
      008393 00                    2386 	.db 0x00
      008394 00                    2387 	.db 0x00
      008395 00                    2388 	.db 0x00
      008396 00                    2389 	.db 0x00
      008397 00                    2390 	.db 0x00
      008398 00                    2391 	.db 0x00
      008399 00                    2392 	.db 0x00
      00839A 00                    2393 	.db 0x00
      00839B 00                    2394 	.db 0x00
      00839C 00                    2395 	.db 0x00
      00839D 00                    2396 	.db 0x00
      00839E 00                    2397 	.db 0x00
      00839F 00                    2398 	.db 0x00
      0083A0 00                    2399 	.db 0x00
      0083A1 00                    2400 	.db 0x00
      0083A2 00                    2401 	.db 0x00
      0083A3 00                    2402 	.db 0x00
      0083A4 00                    2403 	.db 0x00
      0083A5 00                    2404 	.db 0x00
      0083A6 00                    2405 	.db 0x00
      0083A7 00                    2406 	.db 0x00
      0083A8 00                    2407 	.db 0x00
      0083A9 00                    2408 	.db 0x00
      0083AA 00                    2409 	.db 0x00
      0083AB 00                    2410 	.db 0x00
      0083AC 00                    2411 	.db 0x00
      0083AD 00                    2412 	.db 0x00
      0083AE 00                    2413 	.db 0x00
      0083AF 00                    2414 	.db 0x00
      0083B0 00                    2415 	.db 0x00
      0083B1 00                    2416 	.db 0x00
      0083B2 00                    2417 	.db 0x00
      0083B3 00                    2418 	.db 0x00
      0083B4 00                    2419 	.db 0x00
      0083B5 00                    2420 	.db 0x00
      0083B6 00                    2421 	.db 0x00
      0083B7 00                    2422 	.db 0x00
      0083B8 00                    2423 	.db 0x00
      0083B9                       2424 __xinit__current_dev:
      0083B9 00                    2425 	.db #0x00	; 0
                                   2426 	.area CABS (ABS)
