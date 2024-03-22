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
      008007 CD 8C 26         [ 4]  114 	call	___sdcc_external_startup
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
      008004 CC 8B 59         [ 2]  144 	jp	_main
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
      0083EA CD 8C 28         [ 4]  210 	call	_strlen
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
      00841F CD 8C 04         [ 4]  259 	call	_memset
                                    260 ;	main.c: 66: while(i<256)
      008422 5F               [ 1]  261 	clrw	x
      008423                        262 00109$:
      008423 A3 01 00         [ 2]  263 	cpw	x, #0x0100
      008426 2E 2C            [ 1]  264 	jrsge	00111$
                                    265 ;	main.c: 69: if(UART1_SR & UART_SR_RXNE)
      008428 C6 52 30         [ 1]  266 	ld	a, 0x5230
      00842B A5 20            [ 1]  267 	bcp	a, #0x20
      00842D 27 F4            [ 1]  268 	jreq	00109$
                                    269 ;	main.c: 72: buffer[i] = UART_RX();
      00842F 90 93            [ 1]  270 	ldw	y, x
      008431 72 A9 01 01      [ 2]  271 	addw	y, #(_buffer+0)
      008435 89               [ 2]  272 	pushw	x
      008436 90 89            [ 2]  273 	pushw	y
      008438 CD 84 0D         [ 4]  274 	call	_UART_RX
      00843B 90 85            [ 2]  275 	popw	y
      00843D 85               [ 2]  276 	popw	x
      00843E 90 F7            [ 1]  277 	ld	(y), a
                                    278 ;	main.c: 73: if(buffer[i] == '\r')
      008440 A1 0D            [ 1]  279 	cp	a, #0x0d
      008442 26 03            [ 1]  280 	jrne	00102$
                                    281 ;	main.c: 75: return 1;
      008444 5F               [ 1]  282 	clrw	x
      008445 5C               [ 1]  283 	incw	x
      008446 81               [ 4]  284 	ret
                                    285 ;	main.c: 76: break;
      008447                        286 00102$:
                                    287 ;	main.c: 78: if(buffer[i] < 32 || buffer[i] > 126);
      008447 90 F6            [ 1]  288 	ld	a, (y)
      008449 A1 20            [ 1]  289 	cp	a, #0x20
      00844B 25 D6            [ 1]  290 	jrc	00109$
      00844D A1 7E            [ 1]  291 	cp	a, #0x7e
      00844F 22 D2            [ 1]  292 	jrugt	00109$
                                    293 ;	main.c: 80: i++;
      008451 5C               [ 1]  294 	incw	x
      008452 20 CF            [ 2]  295 	jra	00109$
      008454                        296 00111$:
                                    297 ;	main.c: 84: return 0;
      008454 5F               [ 1]  298 	clrw	x
                                    299 ;	main.c: 85: }
      008455 81               [ 4]  300 	ret
                                    301 ;	main.c: 94: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    302 ;	-----------------------------------------
                                    303 ;	 function convert_int_to_chars
                                    304 ;	-----------------------------------------
      008456                        305 _convert_int_to_chars:
      008456 52 0D            [ 2]  306 	sub	sp, #13
      008458 6B 0D            [ 1]  307 	ld	(0x0d, sp), a
      00845A 1F 0B            [ 2]  308 	ldw	(0x0b, sp), x
                                    309 ;	main.c: 97: rx_int_chars[0] = num / 100 + '0';
      00845C 7B 0D            [ 1]  310 	ld	a, (0x0d, sp)
      00845E 6B 02            [ 1]  311 	ld	(0x02, sp), a
      008460 0F 01            [ 1]  312 	clr	(0x01, sp)
                                    313 ;	main.c: 98: rx_int_chars[1] = num / 10 % 10 + '0';
      008462 1E 0B            [ 2]  314 	ldw	x, (0x0b, sp)
      008464 5C               [ 1]  315 	incw	x
      008465 1F 03            [ 2]  316 	ldw	(0x03, sp), x
                                    317 ;	main.c: 99: rx_int_chars[2] = num % 10 + '0';
      008467 1E 0B            [ 2]  318 	ldw	x, (0x0b, sp)
      008469 5C               [ 1]  319 	incw	x
      00846A 5C               [ 1]  320 	incw	x
      00846B 1F 05            [ 2]  321 	ldw	(0x05, sp), x
                                    322 ;	main.c: 98: rx_int_chars[1] = num / 10 % 10 + '0';
      00846D 4B 0A            [ 1]  323 	push	#0x0a
      00846F 4B 00            [ 1]  324 	push	#0x00
      008471 1E 03            [ 2]  325 	ldw	x, (0x03, sp)
                                    326 ;	main.c: 99: rx_int_chars[2] = num % 10 + '0';
      008473 CD 8C 4D         [ 4]  327 	call	__divsint
      008476 1F 07            [ 2]  328 	ldw	(0x07, sp), x
      008478 4B 0A            [ 1]  329 	push	#0x0a
      00847A 4B 00            [ 1]  330 	push	#0x00
      00847C 1E 03            [ 2]  331 	ldw	x, (0x03, sp)
      00847E CD 8C 35         [ 4]  332 	call	__modsint
      008481 9F               [ 1]  333 	ld	a, xl
      008482 AB 30            [ 1]  334 	add	a, #0x30
      008484 6B 09            [ 1]  335 	ld	(0x09, sp), a
                                    336 ;	main.c: 95: if (num > 99) {
      008486 7B 0D            [ 1]  337 	ld	a, (0x0d, sp)
      008488 A1 63            [ 1]  338 	cp	a, #0x63
      00848A 23 29            [ 2]  339 	jrule	00105$
                                    340 ;	main.c: 97: rx_int_chars[0] = num / 100 + '0';
      00848C 4B 64            [ 1]  341 	push	#0x64
      00848E 4B 00            [ 1]  342 	push	#0x00
      008490 1E 03            [ 2]  343 	ldw	x, (0x03, sp)
      008492 CD 8C 4D         [ 4]  344 	call	__divsint
      008495 9F               [ 1]  345 	ld	a, xl
      008496 AB 30            [ 1]  346 	add	a, #0x30
      008498 1E 0B            [ 2]  347 	ldw	x, (0x0b, sp)
      00849A F7               [ 1]  348 	ld	(x), a
                                    349 ;	main.c: 98: rx_int_chars[1] = num / 10 % 10 + '0';
      00849B 4B 0A            [ 1]  350 	push	#0x0a
      00849D 4B 00            [ 1]  351 	push	#0x00
      00849F 1E 09            [ 2]  352 	ldw	x, (0x09, sp)
      0084A1 CD 8C 35         [ 4]  353 	call	__modsint
      0084A4 9F               [ 1]  354 	ld	a, xl
      0084A5 AB 30            [ 1]  355 	add	a, #0x30
      0084A7 1E 03            [ 2]  356 	ldw	x, (0x03, sp)
      0084A9 F7               [ 1]  357 	ld	(x), a
                                    358 ;	main.c: 99: rx_int_chars[2] = num % 10 + '0';
      0084AA 1E 05            [ 2]  359 	ldw	x, (0x05, sp)
      0084AC 7B 09            [ 1]  360 	ld	a, (0x09, sp)
      0084AE F7               [ 1]  361 	ld	(x), a
                                    362 ;	main.c: 100: rx_int_chars[3] ='\0';
      0084AF 1E 0B            [ 2]  363 	ldw	x, (0x0b, sp)
      0084B1 6F 03            [ 1]  364 	clr	(0x0003, x)
      0084B3 20 23            [ 2]  365 	jra	00107$
      0084B5                        366 00105$:
                                    367 ;	main.c: 102: } else if (num > 9) {
      0084B5 7B 0D            [ 1]  368 	ld	a, (0x0d, sp)
      0084B7 A1 09            [ 1]  369 	cp	a, #0x09
      0084B9 23 13            [ 2]  370 	jrule	00102$
                                    371 ;	main.c: 104: rx_int_chars[0] = num / 10 + '0';
      0084BB 7B 08            [ 1]  372 	ld	a, (0x08, sp)
      0084BD 6B 0A            [ 1]  373 	ld	(0x0a, sp), a
      0084BF AB 30            [ 1]  374 	add	a, #0x30
      0084C1 1E 0B            [ 2]  375 	ldw	x, (0x0b, sp)
      0084C3 F7               [ 1]  376 	ld	(x), a
                                    377 ;	main.c: 105: rx_int_chars[1] = num % 10 + '0';
      0084C4 1E 03            [ 2]  378 	ldw	x, (0x03, sp)
      0084C6 7B 09            [ 1]  379 	ld	a, (0x09, sp)
      0084C8 F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 106: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      0084C9 1E 05            [ 2]  382 	ldw	x, (0x05, sp)
      0084CB 7F               [ 1]  383 	clr	(x)
      0084CC 20 0A            [ 2]  384 	jra	00107$
      0084CE                        385 00102$:
                                    386 ;	main.c: 109: rx_int_chars[0] = num + '0';
      0084CE 7B 0D            [ 1]  387 	ld	a, (0x0d, sp)
      0084D0 AB 30            [ 1]  388 	add	a, #0x30
      0084D2 1E 0B            [ 2]  389 	ldw	x, (0x0b, sp)
      0084D4 F7               [ 1]  390 	ld	(x), a
                                    391 ;	main.c: 110: rx_int_chars[1] ='\0';
      0084D5 1E 03            [ 2]  392 	ldw	x, (0x03, sp)
      0084D7 7F               [ 1]  393 	clr	(x)
      0084D8                        394 00107$:
                                    395 ;	main.c: 112: }
      0084D8 5B 0D            [ 2]  396 	addw	sp, #13
      0084DA 81               [ 4]  397 	ret
                                    398 ;	main.c: 114: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    399 ;	-----------------------------------------
                                    400 ;	 function convert_chars_to_int
                                    401 ;	-----------------------------------------
      0084DB                        402 _convert_chars_to_int:
      0084DB 52 03            [ 2]  403 	sub	sp, #3
      0084DD 1F 02            [ 2]  404 	ldw	(0x02, sp), x
                                    405 ;	main.c: 115: uint8_t result = 0;
      0084DF 4F               [ 1]  406 	clr	a
                                    407 ;	main.c: 117: for (int o = 0; o < i; o++) {
      0084E0 5F               [ 1]  408 	clrw	x
      0084E1                        409 00103$:
      0084E1 13 06            [ 2]  410 	cpw	x, (0x06, sp)
      0084E3 2E 18            [ 1]  411 	jrsge	00101$
                                    412 ;	main.c: 119: result = (result * 10) + (rx_chars_int[o] - '0');
      0084E5 90 97            [ 1]  413 	ld	yl, a
      0084E7 A6 0A            [ 1]  414 	ld	a, #0x0a
      0084E9 90 42            [ 4]  415 	mul	y, a
      0084EB 61               [ 1]  416 	exg	a, yl
      0084EC 6B 01            [ 1]  417 	ld	(0x01, sp), a
      0084EE 61               [ 1]  418 	exg	a, yl
      0084EF 90 93            [ 1]  419 	ldw	y, x
      0084F1 72 F9 02         [ 2]  420 	addw	y, (0x02, sp)
      0084F4 90 F6            [ 1]  421 	ld	a, (y)
      0084F6 A0 30            [ 1]  422 	sub	a, #0x30
      0084F8 1B 01            [ 1]  423 	add	a, (0x01, sp)
                                    424 ;	main.c: 117: for (int o = 0; o < i; o++) {
      0084FA 5C               [ 1]  425 	incw	x
      0084FB 20 E4            [ 2]  426 	jra	00103$
      0084FD                        427 00101$:
                                    428 ;	main.c: 122: return result;
                                    429 ;	main.c: 123: }
      0084FD 1E 04            [ 2]  430 	ldw	x, (4, sp)
      0084FF 5B 07            [ 2]  431 	addw	sp, #7
      008501 FC               [ 2]  432 	jp	(x)
                                    433 ;	main.c: 126: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    434 ;	-----------------------------------------
                                    435 ;	 function convert_int_to_binary
                                    436 ;	-----------------------------------------
      008502                        437 _convert_int_to_binary:
      008502 52 04            [ 2]  438 	sub	sp, #4
      008504 1F 01            [ 2]  439 	ldw	(0x01, sp), x
                                    440 ;	main.c: 128: for(int i = 7; i >= 0; i--) {
      008506 AE 00 07         [ 2]  441 	ldw	x, #0x0007
      008509 1F 03            [ 2]  442 	ldw	(0x03, sp), x
      00850B                        443 00103$:
      00850B 0D 03            [ 1]  444 	tnz	(0x03, sp)
      00850D 2B 22            [ 1]  445 	jrmi	00101$
                                    446 ;	main.c: 130: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      00850F AE 00 07         [ 2]  447 	ldw	x, #0x0007
      008512 72 F0 03         [ 2]  448 	subw	x, (0x03, sp)
      008515 72 FB 07         [ 2]  449 	addw	x, (0x07, sp)
      008518 16 01            [ 2]  450 	ldw	y, (0x01, sp)
      00851A 7B 04            [ 1]  451 	ld	a, (0x04, sp)
      00851C 27 05            [ 1]  452 	jreq	00120$
      00851E                        453 00119$:
      00851E 90 57            [ 2]  454 	sraw	y
      008520 4A               [ 1]  455 	dec	a
      008521 26 FB            [ 1]  456 	jrne	00119$
      008523                        457 00120$:
      008523 90 9F            [ 1]  458 	ld	a, yl
      008525 A4 01            [ 1]  459 	and	a, #0x01
      008527 AB 30            [ 1]  460 	add	a, #0x30
      008529 F7               [ 1]  461 	ld	(x), a
                                    462 ;	main.c: 128: for(int i = 7; i >= 0; i--) {
      00852A 1E 03            [ 2]  463 	ldw	x, (0x03, sp)
      00852C 5A               [ 2]  464 	decw	x
      00852D 1F 03            [ 2]  465 	ldw	(0x03, sp), x
      00852F 20 DA            [ 2]  466 	jra	00103$
      008531                        467 00101$:
                                    468 ;	main.c: 132: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008531 1E 07            [ 2]  469 	ldw	x, (0x07, sp)
      008533 6F 08            [ 1]  470 	clr	(0x0008, x)
                                    471 ;	main.c: 133: }
      008535 1E 05            [ 2]  472 	ldw	x, (5, sp)
      008537 5B 08            [ 2]  473 	addw	sp, #8
      008539 FC               [ 2]  474 	jp	(x)
                                    475 ;	main.c: 142: void get_addr_from_buff(void)
                                    476 ;	-----------------------------------------
                                    477 ;	 function get_addr_from_buff
                                    478 ;	-----------------------------------------
      00853A                        479 _get_addr_from_buff:
      00853A 52 02            [ 2]  480 	sub	sp, #2
                                    481 ;	main.c: 146: while(1)
      00853C A6 03            [ 1]  482 	ld	a, #0x03
      00853E 6B 01            [ 1]  483 	ld	(0x01, sp), a
      008540 0F 02            [ 1]  484 	clr	(0x02, sp)
      008542                        485 00105$:
                                    486 ;	main.c: 148: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008542 5F               [ 1]  487 	clrw	x
      008543 7B 01            [ 1]  488 	ld	a, (0x01, sp)
      008545 97               [ 1]  489 	ld	xl, a
      008546 D6 01 01         [ 1]  490 	ld	a, (_buffer+0, x)
      008549 A1 20            [ 1]  491 	cp	a, #0x20
      00854B 27 04            [ 1]  492 	jreq	00101$
      00854D A1 0D            [ 1]  493 	cp	a, #0x0d
      00854F 26 08            [ 1]  494 	jrne	00102$
      008551                        495 00101$:
                                    496 ;	main.c: 150: p_size = i+1;
      008551 7B 01            [ 1]  497 	ld	a, (0x01, sp)
      008553 4C               [ 1]  498 	inc	a
      008554 C7 02 05         [ 1]  499 	ld	_p_size+0, a
                                    500 ;	main.c: 151: break;
      008557 20 06            [ 2]  501 	jra	00106$
      008559                        502 00102$:
                                    503 ;	main.c: 153: i++;
      008559 0C 01            [ 1]  504 	inc	(0x01, sp)
                                    505 ;	main.c: 154: counter++;
      00855B 0C 02            [ 1]  506 	inc	(0x02, sp)
      00855D 20 E3            [ 2]  507 	jra	00105$
      00855F                        508 00106$:
                                    509 ;	main.c: 156: memcpy(a, &buffer[3], counter);
      00855F 5F               [ 1]  510 	clrw	x
      008560 7B 02            [ 1]  511 	ld	a, (0x02, sp)
      008562 97               [ 1]  512 	ld	xl, a
      008563 89               [ 2]  513 	pushw	x
      008564 4B 04            [ 1]  514 	push	#<(_buffer+3)
      008566 4B 01            [ 1]  515 	push	#((_buffer+3) >> 8)
      008568 AE 02 01         [ 2]  516 	ldw	x, #(_a+0)
      00856B CD 8B B1         [ 4]  517 	call	___memcpy
                                    518 ;	main.c: 157: d_addr = convert_chars_to_int(a, counter);
      00856E 5F               [ 1]  519 	clrw	x
      00856F 7B 02            [ 1]  520 	ld	a, (0x02, sp)
      008571 97               [ 1]  521 	ld	xl, a
      008572 89               [ 2]  522 	pushw	x
      008573 AE 02 01         [ 2]  523 	ldw	x, #(_a+0)
      008576 CD 84 DB         [ 4]  524 	call	_convert_chars_to_int
      008579 C7 02 04         [ 1]  525 	ld	_d_addr+0, a
                                    526 ;	main.c: 158: }
      00857C 5B 02            [ 2]  527 	addw	sp, #2
      00857E 81               [ 4]  528 	ret
                                    529 ;	main.c: 160: void get_size_from_buff(void)
                                    530 ;	-----------------------------------------
                                    531 ;	 function get_size_from_buff
                                    532 ;	-----------------------------------------
      00857F                        533 _get_size_from_buff:
      00857F 52 02            [ 2]  534 	sub	sp, #2
                                    535 ;	main.c: 162: memset(a, 0, sizeof(a));
      008581 4B 03            [ 1]  536 	push	#0x03
      008583 4B 00            [ 1]  537 	push	#0x00
      008585 5F               [ 1]  538 	clrw	x
      008586 89               [ 2]  539 	pushw	x
      008587 AE 02 01         [ 2]  540 	ldw	x, #(_a+0)
      00858A CD 8C 04         [ 4]  541 	call	_memset
                                    542 ;	main.c: 164: uint8_t i = p_size;
      00858D C6 02 05         [ 1]  543 	ld	a, _p_size+0
      008590 6B 01            [ 1]  544 	ld	(0x01, sp), a
                                    545 ;	main.c: 165: while(1)
      008592 0F 02            [ 1]  546 	clr	(0x02, sp)
      008594                        547 00105$:
                                    548 ;	main.c: 167: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008594 5F               [ 1]  549 	clrw	x
      008595 7B 01            [ 1]  550 	ld	a, (0x01, sp)
      008597 97               [ 1]  551 	ld	xl, a
      008598 D6 01 01         [ 1]  552 	ld	a, (_buffer+0, x)
      00859B A1 20            [ 1]  553 	cp	a, #0x20
      00859D 27 04            [ 1]  554 	jreq	00101$
      00859F A1 0D            [ 1]  555 	cp	a, #0x0d
      0085A1 26 08            [ 1]  556 	jrne	00102$
      0085A3                        557 00101$:
                                    558 ;	main.c: 170: p_bytes = i+1;
      0085A3 7B 01            [ 1]  559 	ld	a, (0x01, sp)
      0085A5 4C               [ 1]  560 	inc	a
      0085A6 C7 02 07         [ 1]  561 	ld	_p_bytes+0, a
                                    562 ;	main.c: 171: break;
      0085A9 20 06            [ 2]  563 	jra	00106$
      0085AB                        564 00102$:
                                    565 ;	main.c: 173: i++;
      0085AB 0C 01            [ 1]  566 	inc	(0x01, sp)
                                    567 ;	main.c: 174: counter++;
      0085AD 0C 02            [ 1]  568 	inc	(0x02, sp)
      0085AF 20 E3            [ 2]  569 	jra	00105$
      0085B1                        570 00106$:
                                    571 ;	main.c: 177: memcpy(a, &buffer[p_size], counter);
      0085B1 90 5F            [ 1]  572 	clrw	y
      0085B3 7B 02            [ 1]  573 	ld	a, (0x02, sp)
      0085B5 90 97            [ 1]  574 	ld	yl, a
      0085B7 5F               [ 1]  575 	clrw	x
      0085B8 C6 02 05         [ 1]  576 	ld	a, _p_size+0
      0085BB 97               [ 1]  577 	ld	xl, a
      0085BC 1C 01 01         [ 2]  578 	addw	x, #(_buffer+0)
      0085BF 90 89            [ 2]  579 	pushw	y
      0085C1 89               [ 2]  580 	pushw	x
      0085C2 AE 02 01         [ 2]  581 	ldw	x, #(_a+0)
      0085C5 CD 8B B1         [ 4]  582 	call	___memcpy
                                    583 ;	main.c: 178: d_size = convert_chars_to_int(a, counter);
      0085C8 5F               [ 1]  584 	clrw	x
      0085C9 7B 02            [ 1]  585 	ld	a, (0x02, sp)
      0085CB 97               [ 1]  586 	ld	xl, a
      0085CC 89               [ 2]  587 	pushw	x
      0085CD AE 02 01         [ 2]  588 	ldw	x, #(_a+0)
      0085D0 CD 84 DB         [ 4]  589 	call	_convert_chars_to_int
      0085D3 C7 02 06         [ 1]  590 	ld	_d_size+0, a
                                    591 ;	main.c: 179: }
      0085D6 5B 02            [ 2]  592 	addw	sp, #2
      0085D8 81               [ 4]  593 	ret
                                    594 ;	main.c: 180: void char_buffer_to_int(void)
                                    595 ;	-----------------------------------------
                                    596 ;	 function char_buffer_to_int
                                    597 ;	-----------------------------------------
      0085D9                        598 _char_buffer_to_int:
      0085D9 52 08            [ 2]  599 	sub	sp, #8
                                    600 ;	main.c: 182: memset(a, 0, sizeof(a));
      0085DB 4B 03            [ 1]  601 	push	#0x03
      0085DD 4B 00            [ 1]  602 	push	#0x00
      0085DF 5F               [ 1]  603 	clrw	x
      0085E0 89               [ 2]  604 	pushw	x
      0085E1 AE 02 01         [ 2]  605 	ldw	x, #(_a+0)
      0085E4 CD 8C 04         [ 4]  606 	call	_memset
                                    607 ;	main.c: 183: uint8_t counter = d_size;
      0085E7 C6 02 06         [ 1]  608 	ld	a, _d_size+0
      0085EA 6B 01            [ 1]  609 	ld	(0x01, sp), a
                                    610 ;	main.c: 184: uint8_t i = p_bytes;
      0085EC C6 02 07         [ 1]  611 	ld	a, _p_bytes+0
      0085EF 6B 03            [ 1]  612 	ld	(0x03, sp), a
                                    613 ;	main.c: 187: for(int o = 0; o < counter;o++)
      0085F1 0F 04            [ 1]  614 	clr	(0x04, sp)
      0085F3 5F               [ 1]  615 	clrw	x
      0085F4 1F 05            [ 2]  616 	ldw	(0x05, sp), x
      0085F6                        617 00112$:
      0085F6 7B 01            [ 1]  618 	ld	a, (0x01, sp)
      0085F8 6B 08            [ 1]  619 	ld	(0x08, sp), a
      0085FA 0F 07            [ 1]  620 	clr	(0x07, sp)
      0085FC 1E 05            [ 2]  621 	ldw	x, (0x05, sp)
      0085FE 13 07            [ 2]  622 	cpw	x, (0x07, sp)
      008600 2E 65            [ 1]  623 	jrsge	00114$
                                    624 ;	main.c: 189: uint8_t number_counter = 0;
      008602 0F 02            [ 1]  625 	clr	(0x02, sp)
                                    626 ;	main.c: 190: while(1)
      008604 7B 03            [ 1]  627 	ld	a, (0x03, sp)
      008606 6B 07            [ 1]  628 	ld	(0x07, sp), a
      008608 0F 08            [ 1]  629 	clr	(0x08, sp)
      00860A                        630 00108$:
                                    631 ;	main.c: 192: if(buffer[i] == ' ')
      00860A 5F               [ 1]  632 	clrw	x
      00860B 7B 07            [ 1]  633 	ld	a, (0x07, sp)
      00860D 97               [ 1]  634 	ld	xl, a
      00860E D6 01 01         [ 1]  635 	ld	a, (_buffer+0, x)
      008611 A1 20            [ 1]  636 	cp	a, #0x20
      008613 26 04            [ 1]  637 	jrne	00105$
                                    638 ;	main.c: 194: i++;
      008615 0C 03            [ 1]  639 	inc	(0x03, sp)
                                    640 ;	main.c: 195: break;
      008617 20 12            [ 2]  641 	jra	00109$
      008619                        642 00105$:
                                    643 ;	main.c: 197: else if(buffer[i] == '\r\n')
      008619 A1 0D            [ 1]  644 	cp	a, #0x0d
      00861B 27 0E            [ 1]  645 	jreq	00109$
                                    646 ;	main.c: 200: i++;
      00861D 0C 07            [ 1]  647 	inc	(0x07, sp)
      00861F 7B 07            [ 1]  648 	ld	a, (0x07, sp)
      008621 6B 03            [ 1]  649 	ld	(0x03, sp), a
                                    650 ;	main.c: 202: number_counter++;
      008623 0C 08            [ 1]  651 	inc	(0x08, sp)
      008625 7B 08            [ 1]  652 	ld	a, (0x08, sp)
      008627 6B 02            [ 1]  653 	ld	(0x02, sp), a
      008629 20 DF            [ 2]  654 	jra	00108$
      00862B                        655 00109$:
                                    656 ;	main.c: 204: memcpy(a, &buffer[i - number_counter], number_counter);
      00862B 90 5F            [ 1]  657 	clrw	y
      00862D 7B 02            [ 1]  658 	ld	a, (0x02, sp)
      00862F 90 97            [ 1]  659 	ld	yl, a
      008631 5F               [ 1]  660 	clrw	x
      008632 7B 03            [ 1]  661 	ld	a, (0x03, sp)
      008634 97               [ 1]  662 	ld	xl, a
      008635 7B 02            [ 1]  663 	ld	a, (0x02, sp)
      008637 6B 08            [ 1]  664 	ld	(0x08, sp), a
      008639 0F 07            [ 1]  665 	clr	(0x07, sp)
      00863B 72 F0 07         [ 2]  666 	subw	x, (0x07, sp)
      00863E 1C 01 01         [ 2]  667 	addw	x, #(_buffer+0)
      008641 90 89            [ 2]  668 	pushw	y
      008643 89               [ 2]  669 	pushw	x
      008644 AE 02 01         [ 2]  670 	ldw	x, #(_a+0)
      008647 CD 8B B1         [ 4]  671 	call	___memcpy
                                    672 ;	main.c: 205: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      00864A 5F               [ 1]  673 	clrw	x
      00864B 7B 04            [ 1]  674 	ld	a, (0x04, sp)
      00864D 97               [ 1]  675 	ld	xl, a
      00864E 1C 02 08         [ 2]  676 	addw	x, #(_data_buf+0)
      008651 89               [ 2]  677 	pushw	x
      008652 16 09            [ 2]  678 	ldw	y, (0x09, sp)
      008654 90 89            [ 2]  679 	pushw	y
      008656 AE 02 01         [ 2]  680 	ldw	x, #(_a+0)
      008659 CD 84 DB         [ 4]  681 	call	_convert_chars_to_int
      00865C 85               [ 2]  682 	popw	x
      00865D F7               [ 1]  683 	ld	(x), a
                                    684 ;	main.c: 206: int_buf_i++;
      00865E 0C 04            [ 1]  685 	inc	(0x04, sp)
                                    686 ;	main.c: 187: for(int o = 0; o < counter;o++)
      008660 1E 05            [ 2]  687 	ldw	x, (0x05, sp)
      008662 5C               [ 1]  688 	incw	x
      008663 1F 05            [ 2]  689 	ldw	(0x05, sp), x
      008665 20 8F            [ 2]  690 	jra	00112$
      008667                        691 00114$:
                                    692 ;	main.c: 208: }
      008667 5B 08            [ 2]  693 	addw	sp, #8
      008669 81               [ 4]  694 	ret
                                    695 ;	main.c: 216: void reg_check(void)
                                    696 ;	-----------------------------------------
                                    697 ;	 function reg_check
                                    698 ;	-----------------------------------------
      00866A                        699 _reg_check:
      00866A 52 09            [ 2]  700 	sub	sp, #9
                                    701 ;	main.c: 218: char rx_binary_chars[9]={0};
      00866C 0F 01            [ 1]  702 	clr	(0x01, sp)
      00866E 0F 02            [ 1]  703 	clr	(0x02, sp)
      008670 0F 03            [ 1]  704 	clr	(0x03, sp)
      008672 0F 04            [ 1]  705 	clr	(0x04, sp)
      008674 0F 05            [ 1]  706 	clr	(0x05, sp)
      008676 0F 06            [ 1]  707 	clr	(0x06, sp)
      008678 0F 07            [ 1]  708 	clr	(0x07, sp)
      00867A 0F 08            [ 1]  709 	clr	(0x08, sp)
      00867C 0F 09            [ 1]  710 	clr	(0x09, sp)
                                    711 ;	main.c: 219: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      00867E 96               [ 1]  712 	ldw	x, sp
      00867F 5C               [ 1]  713 	incw	x
      008680 51               [ 1]  714 	exgw	x, y
      008681 C6 52 17         [ 1]  715 	ld	a, 0x5217
      008684 5F               [ 1]  716 	clrw	x
      008685 90 89            [ 2]  717 	pushw	y
      008687 97               [ 1]  718 	ld	xl, a
      008688 CD 85 02         [ 4]  719 	call	_convert_int_to_binary
                                    720 ;	main.c: 220: status_registers[0] = I2C_SR1;
      00868B 55 52 17 00 01   [ 1]  721 	mov	_status_registers+0, 0x5217
                                    722 ;	main.c: 221: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008690 96               [ 1]  723 	ldw	x, sp
      008691 5C               [ 1]  724 	incw	x
      008692 51               [ 1]  725 	exgw	x, y
      008693 C6 52 18         [ 1]  726 	ld	a, 0x5218
      008696 5F               [ 1]  727 	clrw	x
      008697 90 89            [ 2]  728 	pushw	y
      008699 97               [ 1]  729 	ld	xl, a
      00869A CD 85 02         [ 4]  730 	call	_convert_int_to_binary
                                    731 ;	main.c: 222: status_registers[1] = I2C_SR2;
      00869D 55 52 18 00 02   [ 1]  732 	mov	_status_registers+1, 0x5218
                                    733 ;	main.c: 223: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0086A2 96               [ 1]  734 	ldw	x, sp
      0086A3 5C               [ 1]  735 	incw	x
      0086A4 51               [ 1]  736 	exgw	x, y
      0086A5 C6 52 19         [ 1]  737 	ld	a, 0x5219
      0086A8 5F               [ 1]  738 	clrw	x
      0086A9 90 89            [ 2]  739 	pushw	y
      0086AB 97               [ 1]  740 	ld	xl, a
      0086AC CD 85 02         [ 4]  741 	call	_convert_int_to_binary
                                    742 ;	main.c: 224: status_registers[2] = I2C_SR3;
      0086AF 55 52 19 00 03   [ 1]  743 	mov	_status_registers+2, 0x5219
                                    744 ;	main.c: 225: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      0086B4 96               [ 1]  745 	ldw	x, sp
      0086B5 5C               [ 1]  746 	incw	x
      0086B6 51               [ 1]  747 	exgw	x, y
      0086B7 C6 52 10         [ 1]  748 	ld	a, 0x5210
      0086BA 5F               [ 1]  749 	clrw	x
      0086BB 90 89            [ 2]  750 	pushw	y
      0086BD 97               [ 1]  751 	ld	xl, a
      0086BE CD 85 02         [ 4]  752 	call	_convert_int_to_binary
                                    753 ;	main.c: 226: status_registers[3] = I2C_CR1;
      0086C1 55 52 10 00 04   [ 1]  754 	mov	_status_registers+3, 0x5210
                                    755 ;	main.c: 227: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      0086C6 96               [ 1]  756 	ldw	x, sp
      0086C7 5C               [ 1]  757 	incw	x
      0086C8 51               [ 1]  758 	exgw	x, y
      0086C9 C6 52 11         [ 1]  759 	ld	a, 0x5211
      0086CC 5F               [ 1]  760 	clrw	x
      0086CD 90 89            [ 2]  761 	pushw	y
      0086CF 97               [ 1]  762 	ld	xl, a
      0086D0 CD 85 02         [ 4]  763 	call	_convert_int_to_binary
                                    764 ;	main.c: 228: status_registers[4] = I2C_CR2;
      0086D3 55 52 11 00 05   [ 1]  765 	mov	_status_registers+4, 0x5211
                                    766 ;	main.c: 229: convert_int_to_binary(I2C_DR, rx_binary_chars);
      0086D8 96               [ 1]  767 	ldw	x, sp
      0086D9 5C               [ 1]  768 	incw	x
      0086DA 51               [ 1]  769 	exgw	x, y
      0086DB C6 52 16         [ 1]  770 	ld	a, 0x5216
      0086DE 5F               [ 1]  771 	clrw	x
      0086DF 90 89            [ 2]  772 	pushw	y
      0086E1 97               [ 1]  773 	ld	xl, a
      0086E2 CD 85 02         [ 4]  774 	call	_convert_int_to_binary
                                    775 ;	main.c: 230: status_registers[5] = I2C_DR;
      0086E5 55 52 16 00 06   [ 1]  776 	mov	_status_registers+5, 0x5216
                                    777 ;	main.c: 231: }
      0086EA 5B 09            [ 2]  778 	addw	sp, #9
      0086EC 81               [ 4]  779 	ret
                                    780 ;	main.c: 234: void status_check(void){
                                    781 ;	-----------------------------------------
                                    782 ;	 function status_check
                                    783 ;	-----------------------------------------
      0086ED                        784 _status_check:
      0086ED 52 09            [ 2]  785 	sub	sp, #9
                                    786 ;	main.c: 235: char rx_binary_chars[9]={0};
      0086EF 0F 01            [ 1]  787 	clr	(0x01, sp)
      0086F1 0F 02            [ 1]  788 	clr	(0x02, sp)
      0086F3 0F 03            [ 1]  789 	clr	(0x03, sp)
      0086F5 0F 04            [ 1]  790 	clr	(0x04, sp)
      0086F7 0F 05            [ 1]  791 	clr	(0x05, sp)
      0086F9 0F 06            [ 1]  792 	clr	(0x06, sp)
      0086FB 0F 07            [ 1]  793 	clr	(0x07, sp)
      0086FD 0F 08            [ 1]  794 	clr	(0x08, sp)
      0086FF 0F 09            [ 1]  795 	clr	(0x09, sp)
                                    796 ;	main.c: 236: uart_write("\nI2C_REGS >.<\n");
      008701 AE 80 2D         [ 2]  797 	ldw	x, #(___str_0+0)
      008704 CD 83 E2         [ 4]  798 	call	_uart_write
                                    799 ;	main.c: 237: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      008707 96               [ 1]  800 	ldw	x, sp
      008708 5C               [ 1]  801 	incw	x
      008709 51               [ 1]  802 	exgw	x, y
      00870A C6 52 17         [ 1]  803 	ld	a, 0x5217
      00870D 5F               [ 1]  804 	clrw	x
      00870E 90 89            [ 2]  805 	pushw	y
      008710 97               [ 1]  806 	ld	xl, a
      008711 CD 85 02         [ 4]  807 	call	_convert_int_to_binary
                                    808 ;	main.c: 238: uart_write("\nSR1 -> ");
      008714 AE 80 3C         [ 2]  809 	ldw	x, #(___str_1+0)
      008717 CD 83 E2         [ 4]  810 	call	_uart_write
                                    811 ;	main.c: 239: uart_write(rx_binary_chars);
      00871A 96               [ 1]  812 	ldw	x, sp
      00871B 5C               [ 1]  813 	incw	x
      00871C CD 83 E2         [ 4]  814 	call	_uart_write
                                    815 ;	main.c: 240: uart_write(" <-\n");
      00871F AE 80 45         [ 2]  816 	ldw	x, #(___str_2+0)
      008722 CD 83 E2         [ 4]  817 	call	_uart_write
                                    818 ;	main.c: 241: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008725 96               [ 1]  819 	ldw	x, sp
      008726 5C               [ 1]  820 	incw	x
      008727 51               [ 1]  821 	exgw	x, y
      008728 C6 52 18         [ 1]  822 	ld	a, 0x5218
      00872B 5F               [ 1]  823 	clrw	x
      00872C 90 89            [ 2]  824 	pushw	y
      00872E 97               [ 1]  825 	ld	xl, a
      00872F CD 85 02         [ 4]  826 	call	_convert_int_to_binary
                                    827 ;	main.c: 242: uart_write("SR2 -> ");
      008732 AE 80 4A         [ 2]  828 	ldw	x, #(___str_3+0)
      008735 CD 83 E2         [ 4]  829 	call	_uart_write
                                    830 ;	main.c: 243: uart_write(rx_binary_chars);
      008738 96               [ 1]  831 	ldw	x, sp
      008739 5C               [ 1]  832 	incw	x
      00873A CD 83 E2         [ 4]  833 	call	_uart_write
                                    834 ;	main.c: 244: uart_write(" <-\n");
      00873D AE 80 45         [ 2]  835 	ldw	x, #(___str_2+0)
      008740 CD 83 E2         [ 4]  836 	call	_uart_write
                                    837 ;	main.c: 245: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008743 96               [ 1]  838 	ldw	x, sp
      008744 5C               [ 1]  839 	incw	x
      008745 51               [ 1]  840 	exgw	x, y
      008746 C6 52 19         [ 1]  841 	ld	a, 0x5219
      008749 5F               [ 1]  842 	clrw	x
      00874A 90 89            [ 2]  843 	pushw	y
      00874C 97               [ 1]  844 	ld	xl, a
      00874D CD 85 02         [ 4]  845 	call	_convert_int_to_binary
                                    846 ;	main.c: 246: uart_write("SR3 -> ");
      008750 AE 80 52         [ 2]  847 	ldw	x, #(___str_4+0)
      008753 CD 83 E2         [ 4]  848 	call	_uart_write
                                    849 ;	main.c: 247: uart_write(rx_binary_chars);
      008756 96               [ 1]  850 	ldw	x, sp
      008757 5C               [ 1]  851 	incw	x
      008758 CD 83 E2         [ 4]  852 	call	_uart_write
                                    853 ;	main.c: 248: uart_write(" <-\n");
      00875B AE 80 45         [ 2]  854 	ldw	x, #(___str_2+0)
      00875E CD 83 E2         [ 4]  855 	call	_uart_write
                                    856 ;	main.c: 249: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      008761 96               [ 1]  857 	ldw	x, sp
      008762 5C               [ 1]  858 	incw	x
      008763 51               [ 1]  859 	exgw	x, y
      008764 C6 52 10         [ 1]  860 	ld	a, 0x5210
      008767 5F               [ 1]  861 	clrw	x
      008768 90 89            [ 2]  862 	pushw	y
      00876A 97               [ 1]  863 	ld	xl, a
      00876B CD 85 02         [ 4]  864 	call	_convert_int_to_binary
                                    865 ;	main.c: 250: uart_write("CR1 -> ");
      00876E AE 80 5A         [ 2]  866 	ldw	x, #(___str_5+0)
      008771 CD 83 E2         [ 4]  867 	call	_uart_write
                                    868 ;	main.c: 251: uart_write(rx_binary_chars);
      008774 96               [ 1]  869 	ldw	x, sp
      008775 5C               [ 1]  870 	incw	x
      008776 CD 83 E2         [ 4]  871 	call	_uart_write
                                    872 ;	main.c: 252: uart_write(" <-\n");
      008779 AE 80 45         [ 2]  873 	ldw	x, #(___str_2+0)
      00877C CD 83 E2         [ 4]  874 	call	_uart_write
                                    875 ;	main.c: 253: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      00877F 96               [ 1]  876 	ldw	x, sp
      008780 5C               [ 1]  877 	incw	x
      008781 51               [ 1]  878 	exgw	x, y
      008782 C6 52 11         [ 1]  879 	ld	a, 0x5211
      008785 5F               [ 1]  880 	clrw	x
      008786 90 89            [ 2]  881 	pushw	y
      008788 97               [ 1]  882 	ld	xl, a
      008789 CD 85 02         [ 4]  883 	call	_convert_int_to_binary
                                    884 ;	main.c: 254: uart_write("CR2 -> ");
      00878C AE 80 62         [ 2]  885 	ldw	x, #(___str_6+0)
      00878F CD 83 E2         [ 4]  886 	call	_uart_write
                                    887 ;	main.c: 255: uart_write(rx_binary_chars);
      008792 96               [ 1]  888 	ldw	x, sp
      008793 5C               [ 1]  889 	incw	x
      008794 CD 83 E2         [ 4]  890 	call	_uart_write
                                    891 ;	main.c: 256: uart_write(" <-\n");
      008797 AE 80 45         [ 2]  892 	ldw	x, #(___str_2+0)
      00879A CD 83 E2         [ 4]  893 	call	_uart_write
                                    894 ;	main.c: 257: convert_int_to_binary(I2C_DR, rx_binary_chars);
      00879D 96               [ 1]  895 	ldw	x, sp
      00879E 5C               [ 1]  896 	incw	x
      00879F 51               [ 1]  897 	exgw	x, y
      0087A0 C6 52 16         [ 1]  898 	ld	a, 0x5216
      0087A3 5F               [ 1]  899 	clrw	x
      0087A4 90 89            [ 2]  900 	pushw	y
      0087A6 97               [ 1]  901 	ld	xl, a
      0087A7 CD 85 02         [ 4]  902 	call	_convert_int_to_binary
                                    903 ;	main.c: 258: uart_write("DR -> ");
      0087AA AE 80 6A         [ 2]  904 	ldw	x, #(___str_7+0)
      0087AD CD 83 E2         [ 4]  905 	call	_uart_write
                                    906 ;	main.c: 259: uart_write(rx_binary_chars);
      0087B0 96               [ 1]  907 	ldw	x, sp
      0087B1 5C               [ 1]  908 	incw	x
      0087B2 CD 83 E2         [ 4]  909 	call	_uart_write
                                    910 ;	main.c: 260: uart_write(" <-\n");
      0087B5 AE 80 45         [ 2]  911 	ldw	x, #(___str_2+0)
      0087B8 CD 83 E2         [ 4]  912 	call	_uart_write
                                    913 ;	main.c: 306: }
      0087BB 5B 09            [ 2]  914 	addw	sp, #9
      0087BD 81               [ 4]  915 	ret
                                    916 ;	main.c: 308: void uart_init(void){
                                    917 ;	-----------------------------------------
                                    918 ;	 function uart_init
                                    919 ;	-----------------------------------------
      0087BE                        920 _uart_init:
                                    921 ;	main.c: 309: CLK_CKDIVR = 0;
      0087BE 35 00 50 C6      [ 1]  922 	mov	0x50c6+0, #0x00
                                    923 ;	main.c: 312: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0087C2 72 16 52 35      [ 1]  924 	bset	0x5235, #3
                                    925 ;	main.c: 313: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      0087C6 72 14 52 35      [ 1]  926 	bset	0x5235, #2
                                    927 ;	main.c: 314: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0087CA C6 52 36         [ 1]  928 	ld	a, 0x5236
      0087CD A4 CF            [ 1]  929 	and	a, #0xcf
      0087CF C7 52 36         [ 1]  930 	ld	0x5236, a
                                    931 ;	main.c: 316: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0087D2 35 03 52 33      [ 1]  932 	mov	0x5233+0, #0x03
      0087D6 35 68 52 32      [ 1]  933 	mov	0x5232+0, #0x68
                                    934 ;	main.c: 317: }
      0087DA 81               [ 4]  935 	ret
                                    936 ;	main.c: 321: void i2c_init(void) {
                                    937 ;	-----------------------------------------
                                    938 ;	 function i2c_init
                                    939 ;	-----------------------------------------
      0087DB                        940 _i2c_init:
                                    941 ;	main.c: 327: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      0087DB 72 11 52 10      [ 1]  942 	bres	0x5210, #0
                                    943 ;	main.c: 328: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      0087DF 35 10 52 12      [ 1]  944 	mov	0x5212+0, #0x10
                                    945 ;	main.c: 329: I2C_CCRH = 0;                   // =0
      0087E3 35 00 52 1C      [ 1]  946 	mov	0x521c+0, #0x00
                                    947 ;	main.c: 330: I2C_CCRL = 80;                  // 100kHz for I2C
      0087E7 35 50 52 1B      [ 1]  948 	mov	0x521b+0, #0x50
                                    949 ;	main.c: 331: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0087EB 72 1F 52 1C      [ 1]  950 	bres	0x521c, #7
                                    951 ;	main.c: 332: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0087EF 72 1F 52 14      [ 1]  952 	bres	0x5214, #7
                                    953 ;	main.c: 333: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0087F3 72 1C 52 14      [ 1]  954 	bset	0x5214, #6
                                    955 ;	main.c: 334: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0087F7 72 10 52 10      [ 1]  956 	bset	0x5210, #0
                                    957 ;	main.c: 335: }
      0087FB 81               [ 4]  958 	ret
                                    959 ;	main.c: 344: void i2c_start(void) {
                                    960 ;	-----------------------------------------
                                    961 ;	 function i2c_start
                                    962 ;	-----------------------------------------
      0087FC                        963 _i2c_start:
                                    964 ;	main.c: 345: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0087FC 72 10 52 11      [ 1]  965 	bset	0x5211, #0
                                    966 ;	main.c: 346: while(!(I2C_SR1 & (1 << 0)));
      008800                        967 00101$:
      008800 72 01 52 17 FB   [ 2]  968 	btjf	0x5217, #0, 00101$
                                    969 ;	main.c: 348: }
      008805 81               [ 4]  970 	ret
                                    971 ;	main.c: 350: void i2c_send_address(uint8_t address) {
                                    972 ;	-----------------------------------------
                                    973 ;	 function i2c_send_address
                                    974 ;	-----------------------------------------
      008806                        975 _i2c_send_address:
                                    976 ;	main.c: 351: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      008806 48               [ 1]  977 	sll	a
      008807 C7 52 16         [ 1]  978 	ld	0x5216, a
                                    979 ;	main.c: 352: reg_check();
      00880A CD 86 6A         [ 4]  980 	call	_reg_check
                                    981 ;	main.c: 353: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00880D                        982 00102$:
      00880D 72 03 52 17 01   [ 2]  983 	btjf	0x5217, #1, 00117$
      008812 81               [ 4]  984 	ret
      008813                        985 00117$:
      008813 72 05 52 18 F5   [ 2]  986 	btjf	0x5218, #2, 00102$
                                    987 ;	main.c: 355: }
      008818 81               [ 4]  988 	ret
                                    989 ;	main.c: 357: void i2c_stop(void) {
                                    990 ;	-----------------------------------------
                                    991 ;	 function i2c_stop
                                    992 ;	-----------------------------------------
      008819                        993 _i2c_stop:
                                    994 ;	main.c: 358: I2C_CR2 = I2C_CR2 | (1 << 1);// Отправка стопового сигнала
      008819 72 12 52 11      [ 1]  995 	bset	0x5211, #1
                                    996 ;	main.c: 360: }
      00881D 81               [ 4]  997 	ret
                                    998 ;	main.c: 361: void i2c_write(void){
                                    999 ;	-----------------------------------------
                                   1000 ;	 function i2c_write
                                   1001 ;	-----------------------------------------
      00881E                       1002 _i2c_write:
      00881E 52 02            [ 2] 1003 	sub	sp, #2
                                   1004 ;	main.c: 362: I2C_DR = 0;
      008820 35 00 52 16      [ 1] 1005 	mov	0x5216+0, #0x00
                                   1006 ;	main.c: 363: reg_check();
      008824 CD 86 6A         [ 4] 1007 	call	_reg_check
                                   1008 ;	main.c: 364: I2C_DR = d_addr;
      008827 55 02 04 52 16   [ 1] 1009 	mov	0x5216+0, _d_addr+0
                                   1010 ;	main.c: 365: reg_check();
      00882C CD 86 6A         [ 4] 1011 	call	_reg_check
                                   1012 ;	main.c: 366: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      00882F                       1013 00103$:
      00882F C6 52 17         [ 1] 1014 	ld	a, 0x5217
      008832 2B 0A            [ 1] 1015 	jrmi	00124$
      008834 72 05 52 18 05   [ 2] 1016 	btjf	0x5218, #2, 00124$
      008839 72 05 52 17 F1   [ 2] 1017 	btjf	0x5217, #2, 00103$
                                   1018 ;	main.c: 367: for(int i = 0;i < d_size;i++)
      00883E                       1019 00124$:
      00883E 5F               [ 1] 1020 	clrw	x
      00883F                       1021 00113$:
      00883F C6 02 06         [ 1] 1022 	ld	a, _d_size+0
      008842 6B 02            [ 1] 1023 	ld	(0x02, sp), a
      008844 0F 01            [ 1] 1024 	clr	(0x01, sp)
      008846 13 01            [ 2] 1025 	cpw	x, (0x01, sp)
      008848 2E 25            [ 1] 1026 	jrsge	00115$
                                   1027 ;	main.c: 369: I2C_DR = data_buf[i];
      00884A 90 93            [ 1] 1028 	ldw	y, x
      00884C 90 D6 02 08      [ 1] 1029 	ld	a, (_data_buf+0, y)
      008850 C7 52 16         [ 1] 1030 	ld	0x5216, a
                                   1031 ;	main.c: 370: reg_check();
      008853 89               [ 2] 1032 	pushw	x
      008854 CD 86 6A         [ 4] 1033 	call	_reg_check
      008857 85               [ 2] 1034 	popw	x
                                   1035 ;	main.c: 371: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2)));
      008858                       1036 00108$:
      008858 C6 52 17         [ 1] 1037 	ld	a, 0x5217
      00885B 2B 0A            [ 1] 1038 	jrmi	00110$
      00885D 72 05 52 18 05   [ 2] 1039 	btjf	0x5218, #2, 00110$
      008862 72 05 52 17 F1   [ 2] 1040 	btjf	0x5217, #2, 00108$
      008867                       1041 00110$:
                                   1042 ;	main.c: 372: reg_check();
      008867 89               [ 2] 1043 	pushw	x
      008868 CD 86 6A         [ 4] 1044 	call	_reg_check
      00886B 85               [ 2] 1045 	popw	x
                                   1046 ;	main.c: 367: for(int i = 0;i < d_size;i++)
      00886C 5C               [ 1] 1047 	incw	x
      00886D 20 D0            [ 2] 1048 	jra	00113$
      00886F                       1049 00115$:
                                   1050 ;	main.c: 374: }
      00886F 5B 02            [ 2] 1051 	addw	sp, #2
      008871 81               [ 4] 1052 	ret
                                   1053 ;	main.c: 376: void i2c_read(void){
                                   1054 ;	-----------------------------------------
                                   1055 ;	 function i2c_read
                                   1056 ;	-----------------------------------------
      008872                       1057 _i2c_read:
      008872 52 02            [ 2] 1058 	sub	sp, #2
                                   1059 ;	main.c: 377: I2C_CR2 = I2C_CR2 | (1 << 2);
      008874 72 14 52 11      [ 1] 1060 	bset	0x5211, #2
                                   1061 ;	main.c: 378: I2C_DR = 0;
      008878 35 00 52 16      [ 1] 1062 	mov	0x5216+0, #0x00
                                   1063 ;	main.c: 379: reg_check();
      00887C CD 86 6A         [ 4] 1064 	call	_reg_check
                                   1065 ;	main.c: 380: I2C_DR = d_addr;
      00887F 55 02 04 52 16   [ 1] 1066 	mov	0x5216+0, _d_addr+0
                                   1067 ;	main.c: 381: reg_check();
      008884 CD 86 6A         [ 4] 1068 	call	_reg_check
                                   1069 ;	main.c: 382: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      008887                       1070 00103$:
      008887 C6 52 17         [ 1] 1071 	ld	a, 0x5217
      00888A 2B 0A            [ 1] 1072 	jrmi	00105$
      00888C 72 05 52 18 05   [ 2] 1073 	btjf	0x5218, #2, 00105$
      008891 72 05 52 17 F1   [ 2] 1074 	btjf	0x5217, #2, 00103$
      008896                       1075 00105$:
                                   1076 ;	main.c: 385: i2c_start();
      008896 CD 87 FC         [ 4] 1077 	call	_i2c_start
                                   1078 ;	main.c: 386: I2C_DR = (current_dev << 1) | (1 << 0);
      008899 C6 03 08         [ 1] 1079 	ld	a, _current_dev+0
      00889C 48               [ 1] 1080 	sll	a
      00889D AA 01            [ 1] 1081 	or	a, #0x01
      00889F C7 52 16         [ 1] 1082 	ld	0x5216, a
                                   1083 ;	main.c: 387: reg_check();
      0088A2 CD 86 6A         [ 4] 1084 	call	_reg_check
                                   1085 ;	main.c: 388: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR1 & (1 << 2)) && !(I2C_SR1 & (1 << 6)));
      0088A5                       1086 00108$:
      0088A5 72 02 52 17 0A   [ 2] 1087 	btjt	0x5217, #1, 00110$
      0088AA 72 04 52 17 05   [ 2] 1088 	btjt	0x5217, #2, 00110$
      0088AF 72 0D 52 17 F1   [ 2] 1089 	btjf	0x5217, #6, 00108$
      0088B4                       1090 00110$:
                                   1091 ;	main.c: 389: reg_check();
      0088B4 CD 86 6A         [ 4] 1092 	call	_reg_check
                                   1093 ;	main.c: 390: for(int i = 0;i < d_size;i++)
      0088B7 5F               [ 1] 1094 	clrw	x
      0088B8                       1095 00116$:
      0088B8 C6 02 06         [ 1] 1096 	ld	a, _d_size+0
      0088BB 6B 02            [ 1] 1097 	ld	(0x02, sp), a
      0088BD 0F 01            [ 1] 1098 	clr	(0x01, sp)
      0088BF 13 01            [ 2] 1099 	cpw	x, (0x01, sp)
      0088C1 2E 13            [ 1] 1100 	jrsge	00114$
                                   1101 ;	main.c: 392: data_buf[i] = I2C_DR;
      0088C3 90 93            [ 1] 1102 	ldw	y, x
      0088C5 72 A9 02 08      [ 2] 1103 	addw	y, #(_data_buf+0)
      0088C9 C6 52 16         [ 1] 1104 	ld	a, 0x5216
      0088CC 90 F7            [ 1] 1105 	ld	(y), a
                                   1106 ;	main.c: 393: while (!(I2C_SR1 & (1 << 6)));
      0088CE                       1107 00111$:
      0088CE 72 0D 52 17 FB   [ 2] 1108 	btjf	0x5217, #6, 00111$
                                   1109 ;	main.c: 390: for(int i = 0;i < d_size;i++)
      0088D3 5C               [ 1] 1110 	incw	x
      0088D4 20 E2            [ 2] 1111 	jra	00116$
      0088D6                       1112 00114$:
                                   1113 ;	main.c: 395: reg_check();
      0088D6 CD 86 6A         [ 4] 1114 	call	_reg_check
                                   1115 ;	main.c: 396: I2C_CR2 = I2C_CR2 & ~(1 << 2);
      0088D9 C6 52 11         [ 1] 1116 	ld	a, 0x5211
      0088DC A4 FB            [ 1] 1117 	and	a, #0xfb
      0088DE C7 52 11         [ 1] 1118 	ld	0x5211, a
                                   1119 ;	main.c: 397: reg_check();
      0088E1 5B 02            [ 2] 1120 	addw	sp, #2
                                   1121 ;	main.c: 398: }
      0088E3 CC 86 6A         [ 2] 1122 	jp	_reg_check
                                   1123 ;	main.c: 399: void i2c_scan(void) {
                                   1124 ;	-----------------------------------------
                                   1125 ;	 function i2c_scan
                                   1126 ;	-----------------------------------------
      0088E6                       1127 _i2c_scan:
      0088E6 52 02            [ 2] 1128 	sub	sp, #2
                                   1129 ;	main.c: 400: for (uint8_t addr = current_dev; addr < 127; addr++) {
      0088E8 C6 03 08         [ 1] 1130 	ld	a, _current_dev+0
      0088EB 6B 01            [ 1] 1131 	ld	(0x01, sp), a
      0088ED 6B 02            [ 1] 1132 	ld	(0x02, sp), a
      0088EF                       1133 00105$:
      0088EF 7B 02            [ 1] 1134 	ld	a, (0x02, sp)
      0088F1 A1 7F            [ 1] 1135 	cp	a, #0x7f
      0088F3 24 26            [ 1] 1136 	jrnc	00107$
                                   1137 ;	main.c: 401: i2c_start();
      0088F5 CD 87 FC         [ 4] 1138 	call	_i2c_start
                                   1139 ;	main.c: 402: i2c_send_address(addr);
      0088F8 7B 02            [ 1] 1140 	ld	a, (0x02, sp)
      0088FA CD 88 06         [ 4] 1141 	call	_i2c_send_address
                                   1142 ;	main.c: 403: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0088FD 72 04 52 18 0A   [ 2] 1143 	btjt	0x5218, #2, 00102$
                                   1144 ;	main.c: 405: current_dev = addr;
      008902 7B 01            [ 1] 1145 	ld	a, (0x01, sp)
      008904 C7 03 08         [ 1] 1146 	ld	_current_dev+0, a
                                   1147 ;	main.c: 406: i2c_stop();
      008907 5B 02            [ 2] 1148 	addw	sp, #2
                                   1149 ;	main.c: 407: break;
      008909 CC 88 19         [ 2] 1150 	jp	_i2c_stop
      00890C                       1151 00102$:
                                   1152 ;	main.c: 409: i2c_stop();
      00890C CD 88 19         [ 4] 1153 	call	_i2c_stop
                                   1154 ;	main.c: 410: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      00890F 72 15 52 18      [ 1] 1155 	bres	0x5218, #2
                                   1156 ;	main.c: 400: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008913 0C 02            [ 1] 1157 	inc	(0x02, sp)
      008915 7B 02            [ 1] 1158 	ld	a, (0x02, sp)
      008917 6B 01            [ 1] 1159 	ld	(0x01, sp), a
      008919 20 D4            [ 2] 1160 	jra	00105$
      00891B                       1161 00107$:
                                   1162 ;	main.c: 412: }
      00891B 5B 02            [ 2] 1163 	addw	sp, #2
      00891D 81               [ 4] 1164 	ret
                                   1165 ;	main.c: 422: void cm_SM(void)
                                   1166 ;	-----------------------------------------
                                   1167 ;	 function cm_SM
                                   1168 ;	-----------------------------------------
      00891E                       1169 _cm_SM:
      00891E 52 04            [ 2] 1170 	sub	sp, #4
                                   1171 ;	main.c: 424: char cur_dev[4]={0};
      008920 0F 01            [ 1] 1172 	clr	(0x01, sp)
      008922 0F 02            [ 1] 1173 	clr	(0x02, sp)
      008924 0F 03            [ 1] 1174 	clr	(0x03, sp)
      008926 0F 04            [ 1] 1175 	clr	(0x04, sp)
                                   1176 ;	main.c: 425: convert_int_to_chars(current_dev, cur_dev);
      008928 96               [ 1] 1177 	ldw	x, sp
      008929 5C               [ 1] 1178 	incw	x
      00892A C6 03 08         [ 1] 1179 	ld	a, _current_dev+0
      00892D CD 84 56         [ 4] 1180 	call	_convert_int_to_chars
                                   1181 ;	main.c: 426: uart_write("SM ");
      008930 AE 80 71         [ 2] 1182 	ldw	x, #(___str_8+0)
      008933 CD 83 E2         [ 4] 1183 	call	_uart_write
                                   1184 ;	main.c: 427: uart_write(cur_dev);
      008936 96               [ 1] 1185 	ldw	x, sp
      008937 5C               [ 1] 1186 	incw	x
      008938 CD 83 E2         [ 4] 1187 	call	_uart_write
                                   1188 ;	main.c: 428: uart_write("\r\n");
      00893B AE 80 75         [ 2] 1189 	ldw	x, #(___str_9+0)
      00893E CD 83 E2         [ 4] 1190 	call	_uart_write
                                   1191 ;	main.c: 429: }
      008941 5B 04            [ 2] 1192 	addw	sp, #4
      008943 81               [ 4] 1193 	ret
                                   1194 ;	main.c: 430: void cm_SN(void)
                                   1195 ;	-----------------------------------------
                                   1196 ;	 function cm_SN
                                   1197 ;	-----------------------------------------
      008944                       1198 _cm_SN:
                                   1199 ;	main.c: 432: i2c_scan();
      008944 CD 88 E6         [ 4] 1200 	call	_i2c_scan
                                   1201 ;	main.c: 433: cm_SM();
                                   1202 ;	main.c: 434: }
      008947 CC 89 1E         [ 2] 1203 	jp	_cm_SM
                                   1204 ;	main.c: 435: void cm_RM(void)
                                   1205 ;	-----------------------------------------
                                   1206 ;	 function cm_RM
                                   1207 ;	-----------------------------------------
      00894A                       1208 _cm_RM:
                                   1209 ;	main.c: 437: current_dev = 0;
      00894A 72 5F 03 08      [ 1] 1210 	clr	_current_dev+0
                                   1211 ;	main.c: 438: uart_write("RM\n");
      00894E AE 80 78         [ 2] 1212 	ldw	x, #(___str_10+0)
                                   1213 ;	main.c: 439: }
      008951 CC 83 E2         [ 2] 1214 	jp	_uart_write
                                   1215 ;	main.c: 441: void cm_DB(void)
                                   1216 ;	-----------------------------------------
                                   1217 ;	 function cm_DB
                                   1218 ;	-----------------------------------------
      008954                       1219 _cm_DB:
                                   1220 ;	main.c: 443: status_check();
                                   1221 ;	main.c: 444: }
      008954 CC 86 ED         [ 2] 1222 	jp	_status_check
                                   1223 ;	main.c: 446: void cm_ST(void)
                                   1224 ;	-----------------------------------------
                                   1225 ;	 function cm_ST
                                   1226 ;	-----------------------------------------
      008957                       1227 _cm_ST:
                                   1228 ;	main.c: 448: get_addr_from_buff();
      008957 CD 85 3A         [ 4] 1229 	call	_get_addr_from_buff
                                   1230 ;	main.c: 449: current_dev = d_addr;
      00895A 55 02 04 03 08   [ 1] 1231 	mov	_current_dev+0, _d_addr+0
                                   1232 ;	main.c: 450: uart_write("ST\n");
      00895F AE 80 7C         [ 2] 1233 	ldw	x, #(___str_11+0)
                                   1234 ;	main.c: 451: }
      008962 CC 83 E2         [ 2] 1235 	jp	_uart_write
                                   1236 ;	main.c: 452: void cm_SR(void)
                                   1237 ;	-----------------------------------------
                                   1238 ;	 function cm_SR
                                   1239 ;	-----------------------------------------
      008965                       1240 _cm_SR:
      008965 52 04            [ 2] 1241 	sub	sp, #4
                                   1242 ;	main.c: 454: i2c_start();
      008967 CD 87 FC         [ 4] 1243 	call	_i2c_start
                                   1244 ;	main.c: 455: i2c_send_address(current_dev);
      00896A C6 03 08         [ 1] 1245 	ld	a, _current_dev+0
      00896D CD 88 06         [ 4] 1246 	call	_i2c_send_address
                                   1247 ;	main.c: 456: i2c_read();
      008970 CD 88 72         [ 4] 1248 	call	_i2c_read
                                   1249 ;	main.c: 457: i2c_stop();
      008973 CD 88 19         [ 4] 1250 	call	_i2c_stop
                                   1251 ;	main.c: 458: uart_write("SR ");
      008976 AE 80 80         [ 2] 1252 	ldw	x, #(___str_12+0)
      008979 CD 83 E2         [ 4] 1253 	call	_uart_write
                                   1254 ;	main.c: 459: convert_int_to_chars(d_addr, a);
      00897C AE 02 01         [ 2] 1255 	ldw	x, #(_a+0)
      00897F C6 02 04         [ 1] 1256 	ld	a, _d_addr+0
      008982 CD 84 56         [ 4] 1257 	call	_convert_int_to_chars
                                   1258 ;	main.c: 460: uart_write(a);
      008985 AE 02 01         [ 2] 1259 	ldw	x, #(_a+0)
      008988 CD 83 E2         [ 4] 1260 	call	_uart_write
                                   1261 ;	main.c: 461: uart_write(" ");
      00898B AE 80 84         [ 2] 1262 	ldw	x, #(___str_13+0)
      00898E CD 83 E2         [ 4] 1263 	call	_uart_write
                                   1264 ;	main.c: 462: convert_int_to_chars(d_size, a);
      008991 AE 02 01         [ 2] 1265 	ldw	x, #(_a+0)
      008994 C6 02 06         [ 1] 1266 	ld	a, _d_size+0
      008997 CD 84 56         [ 4] 1267 	call	_convert_int_to_chars
                                   1268 ;	main.c: 463: uart_write(a);
      00899A AE 02 01         [ 2] 1269 	ldw	x, #(_a+0)
      00899D CD 83 E2         [ 4] 1270 	call	_uart_write
                                   1271 ;	main.c: 464: for(int i = 0;i < d_size;i++)
      0089A0 5F               [ 1] 1272 	clrw	x
      0089A1 1F 03            [ 2] 1273 	ldw	(0x03, sp), x
      0089A3                       1274 00103$:
      0089A3 C6 02 06         [ 1] 1275 	ld	a, _d_size+0
      0089A6 6B 02            [ 1] 1276 	ld	(0x02, sp), a
      0089A8 0F 01            [ 1] 1277 	clr	(0x01, sp)
      0089AA 1E 03            [ 2] 1278 	ldw	x, (0x03, sp)
      0089AC 13 01            [ 2] 1279 	cpw	x, (0x01, sp)
      0089AE 2E 1E            [ 1] 1280 	jrsge	00101$
                                   1281 ;	main.c: 466: uart_write(" ");
      0089B0 AE 80 84         [ 2] 1282 	ldw	x, #(___str_13+0)
      0089B3 CD 83 E2         [ 4] 1283 	call	_uart_write
                                   1284 ;	main.c: 467: convert_int_to_chars(data_buf[i], a);
      0089B6 1E 03            [ 2] 1285 	ldw	x, (0x03, sp)
      0089B8 D6 02 08         [ 1] 1286 	ld	a, (_data_buf+0, x)
      0089BB AE 02 01         [ 2] 1287 	ldw	x, #(_a+0)
      0089BE CD 84 56         [ 4] 1288 	call	_convert_int_to_chars
                                   1289 ;	main.c: 468: uart_write(a);
      0089C1 AE 02 01         [ 2] 1290 	ldw	x, #(_a+0)
      0089C4 CD 83 E2         [ 4] 1291 	call	_uart_write
                                   1292 ;	main.c: 464: for(int i = 0;i < d_size;i++)
      0089C7 1E 03            [ 2] 1293 	ldw	x, (0x03, sp)
      0089C9 5C               [ 1] 1294 	incw	x
      0089CA 1F 03            [ 2] 1295 	ldw	(0x03, sp), x
      0089CC 20 D5            [ 2] 1296 	jra	00103$
      0089CE                       1297 00101$:
                                   1298 ;	main.c: 471: uart_write("\r\n");
      0089CE AE 80 75         [ 2] 1299 	ldw	x, #(___str_9+0)
      0089D1 5B 04            [ 2] 1300 	addw	sp, #4
                                   1301 ;	main.c: 472: }
      0089D3 CC 83 E2         [ 2] 1302 	jp	_uart_write
                                   1303 ;	main.c: 473: void cm_SW(void)
                                   1304 ;	-----------------------------------------
                                   1305 ;	 function cm_SW
                                   1306 ;	-----------------------------------------
      0089D6                       1307 _cm_SW:
      0089D6 52 04            [ 2] 1308 	sub	sp, #4
                                   1309 ;	main.c: 475: i2c_start();
      0089D8 CD 87 FC         [ 4] 1310 	call	_i2c_start
                                   1311 ;	main.c: 476: i2c_send_address(current_dev);
      0089DB C6 03 08         [ 1] 1312 	ld	a, _current_dev+0
      0089DE CD 88 06         [ 4] 1313 	call	_i2c_send_address
                                   1314 ;	main.c: 477: i2c_write();
      0089E1 CD 88 1E         [ 4] 1315 	call	_i2c_write
                                   1316 ;	main.c: 478: i2c_stop();
      0089E4 CD 88 19         [ 4] 1317 	call	_i2c_stop
                                   1318 ;	main.c: 479: uart_write("SW ");
      0089E7 AE 80 86         [ 2] 1319 	ldw	x, #(___str_14+0)
      0089EA CD 83 E2         [ 4] 1320 	call	_uart_write
                                   1321 ;	main.c: 480: convert_int_to_chars(d_addr, a);
      0089ED AE 02 01         [ 2] 1322 	ldw	x, #(_a+0)
      0089F0 C6 02 04         [ 1] 1323 	ld	a, _d_addr+0
      0089F3 CD 84 56         [ 4] 1324 	call	_convert_int_to_chars
                                   1325 ;	main.c: 481: uart_write(a);
      0089F6 AE 02 01         [ 2] 1326 	ldw	x, #(_a+0)
      0089F9 CD 83 E2         [ 4] 1327 	call	_uart_write
                                   1328 ;	main.c: 482: uart_write(" ");
      0089FC AE 80 84         [ 2] 1329 	ldw	x, #(___str_13+0)
      0089FF CD 83 E2         [ 4] 1330 	call	_uart_write
                                   1331 ;	main.c: 483: convert_int_to_chars(d_size, a);
      008A02 AE 02 01         [ 2] 1332 	ldw	x, #(_a+0)
      008A05 C6 02 06         [ 1] 1333 	ld	a, _d_size+0
      008A08 CD 84 56         [ 4] 1334 	call	_convert_int_to_chars
                                   1335 ;	main.c: 484: uart_write(a);
      008A0B AE 02 01         [ 2] 1336 	ldw	x, #(_a+0)
      008A0E CD 83 E2         [ 4] 1337 	call	_uart_write
                                   1338 ;	main.c: 485: for(int i = 0;i < d_size;i++)
      008A11 5F               [ 1] 1339 	clrw	x
      008A12 1F 03            [ 2] 1340 	ldw	(0x03, sp), x
      008A14                       1341 00103$:
      008A14 C6 02 06         [ 1] 1342 	ld	a, _d_size+0
      008A17 6B 02            [ 1] 1343 	ld	(0x02, sp), a
      008A19 0F 01            [ 1] 1344 	clr	(0x01, sp)
      008A1B 1E 03            [ 2] 1345 	ldw	x, (0x03, sp)
      008A1D 13 01            [ 2] 1346 	cpw	x, (0x01, sp)
      008A1F 2E 1E            [ 1] 1347 	jrsge	00101$
                                   1348 ;	main.c: 487: uart_write(" ");
      008A21 AE 80 84         [ 2] 1349 	ldw	x, #(___str_13+0)
      008A24 CD 83 E2         [ 4] 1350 	call	_uart_write
                                   1351 ;	main.c: 488: convert_int_to_chars(data_buf[i], a);
      008A27 1E 03            [ 2] 1352 	ldw	x, (0x03, sp)
      008A29 D6 02 08         [ 1] 1353 	ld	a, (_data_buf+0, x)
      008A2C AE 02 01         [ 2] 1354 	ldw	x, #(_a+0)
      008A2F CD 84 56         [ 4] 1355 	call	_convert_int_to_chars
                                   1356 ;	main.c: 489: uart_write(a);
      008A32 AE 02 01         [ 2] 1357 	ldw	x, #(_a+0)
      008A35 CD 83 E2         [ 4] 1358 	call	_uart_write
                                   1359 ;	main.c: 485: for(int i = 0;i < d_size;i++)
      008A38 1E 03            [ 2] 1360 	ldw	x, (0x03, sp)
      008A3A 5C               [ 1] 1361 	incw	x
      008A3B 1F 03            [ 2] 1362 	ldw	(0x03, sp), x
      008A3D 20 D5            [ 2] 1363 	jra	00103$
      008A3F                       1364 00101$:
                                   1365 ;	main.c: 492: uart_write("\r\n");
      008A3F AE 80 75         [ 2] 1366 	ldw	x, #(___str_9+0)
      008A42 5B 04            [ 2] 1367 	addw	sp, #4
                                   1368 ;	main.c: 493: }
      008A44 CC 83 E2         [ 2] 1369 	jp	_uart_write
                                   1370 ;	main.c: 501: int data_handler(void)
                                   1371 ;	-----------------------------------------
                                   1372 ;	 function data_handler
                                   1373 ;	-----------------------------------------
      008A47                       1374 _data_handler:
                                   1375 ;	main.c: 503: p_size = 0;
      008A47 72 5F 02 05      [ 1] 1376 	clr	_p_size+0
                                   1377 ;	main.c: 504: p_bytes = 0;
      008A4B 72 5F 02 07      [ 1] 1378 	clr	_p_bytes+0
                                   1379 ;	main.c: 505: d_addr = 0;
      008A4F 72 5F 02 04      [ 1] 1380 	clr	_d_addr+0
                                   1381 ;	main.c: 506: d_size = 0;
      008A53 72 5F 02 06      [ 1] 1382 	clr	_d_size+0
                                   1383 ;	main.c: 507: memset(a, 0, sizeof(a));
      008A57 4B 03            [ 1] 1384 	push	#0x03
      008A59 4B 00            [ 1] 1385 	push	#0x00
      008A5B 5F               [ 1] 1386 	clrw	x
      008A5C 89               [ 2] 1387 	pushw	x
      008A5D AE 02 01         [ 2] 1388 	ldw	x, #(_a+0)
      008A60 CD 8C 04         [ 4] 1389 	call	_memset
                                   1390 ;	main.c: 508: memset(data_buf, 0, sizeof(data_buf));
      008A63 4B 00            [ 1] 1391 	push	#0x00
      008A65 4B 01            [ 1] 1392 	push	#0x01
      008A67 5F               [ 1] 1393 	clrw	x
      008A68 89               [ 2] 1394 	pushw	x
      008A69 AE 02 08         [ 2] 1395 	ldw	x, #(_data_buf+0)
      008A6C CD 8C 04         [ 4] 1396 	call	_memset
                                   1397 ;	main.c: 509: if(memcmp(&buffer[0],"SM",2) == 0)
      008A6F 4B 02            [ 1] 1398 	push	#0x02
      008A71 4B 00            [ 1] 1399 	push	#0x00
      008A73 4B 8A            [ 1] 1400 	push	#<(___str_15+0)
      008A75 4B 80            [ 1] 1401 	push	#((___str_15+0) >> 8)
      008A77 AE 01 01         [ 2] 1402 	ldw	x, #(_buffer+0)
      008A7A CD 8B 6E         [ 4] 1403 	call	_memcmp
                                   1404 ;	main.c: 510: return 1;
      008A7D 5D               [ 2] 1405 	tnzw	x
      008A7E 26 02            [ 1] 1406 	jrne	00102$
      008A80 5C               [ 1] 1407 	incw	x
      008A81 81               [ 4] 1408 	ret
      008A82                       1409 00102$:
                                   1410 ;	main.c: 511: if(memcmp(&buffer[0],"SN",2) == 0)
      008A82 4B 02            [ 1] 1411 	push	#0x02
      008A84 4B 00            [ 1] 1412 	push	#0x00
      008A86 4B 8D            [ 1] 1413 	push	#<(___str_16+0)
      008A88 4B 80            [ 1] 1414 	push	#((___str_16+0) >> 8)
      008A8A AE 01 01         [ 2] 1415 	ldw	x, #(_buffer+0)
      008A8D CD 8B 6E         [ 4] 1416 	call	_memcmp
      008A90 5D               [ 2] 1417 	tnzw	x
      008A91 26 04            [ 1] 1418 	jrne	00104$
                                   1419 ;	main.c: 512: return 2;
      008A93 AE 00 02         [ 2] 1420 	ldw	x, #0x0002
      008A96 81               [ 4] 1421 	ret
      008A97                       1422 00104$:
                                   1423 ;	main.c: 513: if(memcmp(&buffer[0],"ST",2) == 0)
      008A97 4B 02            [ 1] 1424 	push	#0x02
      008A99 4B 00            [ 1] 1425 	push	#0x00
      008A9B 4B 90            [ 1] 1426 	push	#<(___str_17+0)
      008A9D 4B 80            [ 1] 1427 	push	#((___str_17+0) >> 8)
      008A9F AE 01 01         [ 2] 1428 	ldw	x, #(_buffer+0)
      008AA2 CD 8B 6E         [ 4] 1429 	call	_memcmp
      008AA5 5D               [ 2] 1430 	tnzw	x
      008AA6 26 04            [ 1] 1431 	jrne	00106$
                                   1432 ;	main.c: 514: return 5;
      008AA8 AE 00 05         [ 2] 1433 	ldw	x, #0x0005
      008AAB 81               [ 4] 1434 	ret
      008AAC                       1435 00106$:
                                   1436 ;	main.c: 515: if(memcmp(&buffer[0],"RM",2) == 0)
      008AAC 4B 02            [ 1] 1437 	push	#0x02
      008AAE 4B 00            [ 1] 1438 	push	#0x00
      008AB0 4B 93            [ 1] 1439 	push	#<(___str_18+0)
      008AB2 4B 80            [ 1] 1440 	push	#((___str_18+0) >> 8)
      008AB4 AE 01 01         [ 2] 1441 	ldw	x, #(_buffer+0)
      008AB7 CD 8B 6E         [ 4] 1442 	call	_memcmp
      008ABA 5D               [ 2] 1443 	tnzw	x
      008ABB 26 04            [ 1] 1444 	jrne	00108$
                                   1445 ;	main.c: 516: return 6;
      008ABD AE 00 06         [ 2] 1446 	ldw	x, #0x0006
      008AC0 81               [ 4] 1447 	ret
      008AC1                       1448 00108$:
                                   1449 ;	main.c: 517: if(memcmp(&buffer[0],"DB",2) == 0)
      008AC1 4B 02            [ 1] 1450 	push	#0x02
      008AC3 4B 00            [ 1] 1451 	push	#0x00
      008AC5 4B 96            [ 1] 1452 	push	#<(___str_19+0)
      008AC7 4B 80            [ 1] 1453 	push	#((___str_19+0) >> 8)
      008AC9 AE 01 01         [ 2] 1454 	ldw	x, #(_buffer+0)
      008ACC CD 8B 6E         [ 4] 1455 	call	_memcmp
      008ACF 5D               [ 2] 1456 	tnzw	x
      008AD0 26 04            [ 1] 1457 	jrne	00110$
                                   1458 ;	main.c: 518: return 7;
      008AD2 AE 00 07         [ 2] 1459 	ldw	x, #0x0007
      008AD5 81               [ 4] 1460 	ret
      008AD6                       1461 00110$:
                                   1462 ;	main.c: 520: get_addr_from_buff();
      008AD6 CD 85 3A         [ 4] 1463 	call	_get_addr_from_buff
                                   1464 ;	main.c: 521: get_size_from_buff();
      008AD9 CD 85 7F         [ 4] 1465 	call	_get_size_from_buff
                                   1466 ;	main.c: 523: if(memcmp(&buffer[0],"SR",2) == 0)
      008ADC 4B 02            [ 1] 1467 	push	#0x02
      008ADE 4B 00            [ 1] 1468 	push	#0x00
      008AE0 4B 99            [ 1] 1469 	push	#<(___str_20+0)
      008AE2 4B 80            [ 1] 1470 	push	#((___str_20+0) >> 8)
      008AE4 AE 01 01         [ 2] 1471 	ldw	x, #(_buffer+0)
      008AE7 CD 8B 6E         [ 4] 1472 	call	_memcmp
      008AEA 5D               [ 2] 1473 	tnzw	x
      008AEB 26 04            [ 1] 1474 	jrne	00112$
                                   1475 ;	main.c: 524: return 3;
      008AED AE 00 03         [ 2] 1476 	ldw	x, #0x0003
      008AF0 81               [ 4] 1477 	ret
      008AF1                       1478 00112$:
                                   1479 ;	main.c: 526: char_buffer_to_int();
      008AF1 CD 85 D9         [ 4] 1480 	call	_char_buffer_to_int
                                   1481 ;	main.c: 528: if(memcmp(&buffer[0],"SW",2) == 0)
      008AF4 4B 02            [ 1] 1482 	push	#0x02
      008AF6 4B 00            [ 1] 1483 	push	#0x00
      008AF8 4B 9C            [ 1] 1484 	push	#<(___str_21+0)
      008AFA 4B 80            [ 1] 1485 	push	#((___str_21+0) >> 8)
      008AFC AE 01 01         [ 2] 1486 	ldw	x, #(_buffer+0)
      008AFF CD 8B 6E         [ 4] 1487 	call	_memcmp
      008B02 5D               [ 2] 1488 	tnzw	x
      008B03 26 04            [ 1] 1489 	jrne	00114$
                                   1490 ;	main.c: 529: return 4;
      008B05 AE 00 04         [ 2] 1491 	ldw	x, #0x0004
      008B08 81               [ 4] 1492 	ret
      008B09                       1493 00114$:
                                   1494 ;	main.c: 530: return 0;
      008B09 5F               [ 1] 1495 	clrw	x
                                   1496 ;	main.c: 532: }
      008B0A 81               [ 4] 1497 	ret
                                   1498 ;	main.c: 534: void command_switcher(void)
                                   1499 ;	-----------------------------------------
                                   1500 ;	 function command_switcher
                                   1501 ;	-----------------------------------------
      008B0B                       1502 _command_switcher:
      008B0B 52 04            [ 2] 1503 	sub	sp, #4
                                   1504 ;	main.c: 536: char ar[4]={0};
      008B0D 0F 01            [ 1] 1505 	clr	(0x01, sp)
      008B0F 0F 02            [ 1] 1506 	clr	(0x02, sp)
      008B11 0F 03            [ 1] 1507 	clr	(0x03, sp)
      008B13 0F 04            [ 1] 1508 	clr	(0x04, sp)
                                   1509 ;	main.c: 538: switch(data_handler())
      008B15 CD 8A 47         [ 4] 1510 	call	_data_handler
      008B18 5D               [ 2] 1511 	tnzw	x
      008B19 2B 3B            [ 1] 1512 	jrmi	00109$
      008B1B A3 00 07         [ 2] 1513 	cpw	x, #0x0007
      008B1E 2C 36            [ 1] 1514 	jrsgt	00109$
      008B20 58               [ 2] 1515 	sllw	x
      008B21 DE 8B 25         [ 2] 1516 	ldw	x, (#00123$, x)
      008B24 FC               [ 2] 1517 	jp	(x)
      008B25                       1518 00123$:
      008B25 8B 56                 1519 	.dw	#00109$
      008B27 8B 35                 1520 	.dw	#00101$
      008B29 8B 3A                 1521 	.dw	#00102$
      008B2B 8B 3F                 1522 	.dw	#00103$
      008B2D 8B 44                 1523 	.dw	#00104$
      008B2F 8B 49                 1524 	.dw	#00105$
      008B31 8B 4E                 1525 	.dw	#00106$
      008B33 8B 53                 1526 	.dw	#00107$
                                   1527 ;	main.c: 540: case 1:
      008B35                       1528 00101$:
                                   1529 ;	main.c: 541: cm_SM();
      008B35 CD 89 1E         [ 4] 1530 	call	_cm_SM
                                   1531 ;	main.c: 542: break;
      008B38 20 1C            [ 2] 1532 	jra	00109$
                                   1533 ;	main.c: 543: case 2:
      008B3A                       1534 00102$:
                                   1535 ;	main.c: 544: cm_SN();
      008B3A CD 89 44         [ 4] 1536 	call	_cm_SN
                                   1537 ;	main.c: 545: break;
      008B3D 20 17            [ 2] 1538 	jra	00109$
                                   1539 ;	main.c: 546: case 3:
      008B3F                       1540 00103$:
                                   1541 ;	main.c: 547: cm_SR();
      008B3F CD 89 65         [ 4] 1542 	call	_cm_SR
                                   1543 ;	main.c: 548: break;
      008B42 20 12            [ 2] 1544 	jra	00109$
                                   1545 ;	main.c: 549: case 4:
      008B44                       1546 00104$:
                                   1547 ;	main.c: 550: cm_SW();
      008B44 CD 89 D6         [ 4] 1548 	call	_cm_SW
                                   1549 ;	main.c: 551: break;
      008B47 20 0D            [ 2] 1550 	jra	00109$
                                   1551 ;	main.c: 552: case 5:
      008B49                       1552 00105$:
                                   1553 ;	main.c: 553: cm_ST();
      008B49 CD 89 57         [ 4] 1554 	call	_cm_ST
                                   1555 ;	main.c: 554: break;
      008B4C 20 08            [ 2] 1556 	jra	00109$
                                   1557 ;	main.c: 555: case 6:
      008B4E                       1558 00106$:
                                   1559 ;	main.c: 556: cm_RM();
      008B4E CD 89 4A         [ 4] 1560 	call	_cm_RM
                                   1561 ;	main.c: 557: break;
      008B51 20 03            [ 2] 1562 	jra	00109$
                                   1563 ;	main.c: 558: case 7:
      008B53                       1564 00107$:
                                   1565 ;	main.c: 559: cm_DB();
      008B53 CD 89 54         [ 4] 1566 	call	_cm_DB
                                   1567 ;	main.c: 561: }
      008B56                       1568 00109$:
                                   1569 ;	main.c: 562: }
      008B56 5B 04            [ 2] 1570 	addw	sp, #4
      008B58 81               [ 4] 1571 	ret
                                   1572 ;	main.c: 565: void main(void)
                                   1573 ;	-----------------------------------------
                                   1574 ;	 function main
                                   1575 ;	-----------------------------------------
      008B59                       1576 _main:
                                   1577 ;	main.c: 567: uart_init();
      008B59 CD 87 BE         [ 4] 1578 	call	_uart_init
                                   1579 ;	main.c: 568: i2c_init();
      008B5C CD 87 DB         [ 4] 1580 	call	_i2c_init
                                   1581 ;	main.c: 569: uart_write("SS\n");
      008B5F AE 80 9F         [ 2] 1582 	ldw	x, #(___str_22+0)
      008B62 CD 83 E2         [ 4] 1583 	call	_uart_write
                                   1584 ;	main.c: 570: while(1)
      008B65                       1585 00102$:
                                   1586 ;	main.c: 572: uart_read();
      008B65 CD 84 16         [ 4] 1587 	call	_uart_read
                                   1588 ;	main.c: 573: command_switcher();
      008B68 CD 8B 0B         [ 4] 1589 	call	_command_switcher
      008B6B 20 F8            [ 2] 1590 	jra	00102$
                                   1591 ;	main.c: 575: }
      008B6D 81               [ 4] 1592 	ret
                                   1593 	.area CODE
                                   1594 	.area CONST
                                   1595 	.area CONST
      00802D                       1596 ___str_0:
      00802D 0A                    1597 	.db 0x0a
      00802E 49 32 43 5F 52 45 47  1598 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                    1599 	.db 0x0a
      00803B 00                    1600 	.db 0x00
                                   1601 	.area CODE
                                   1602 	.area CONST
      00803C                       1603 ___str_1:
      00803C 0A                    1604 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20  1605 	.ascii "SR1 -> "
      008044 00                    1606 	.db 0x00
                                   1607 	.area CODE
                                   1608 	.area CONST
      008045                       1609 ___str_2:
      008045 20 3C 2D              1610 	.ascii " <-"
      008048 0A                    1611 	.db 0x0a
      008049 00                    1612 	.db 0x00
                                   1613 	.area CODE
                                   1614 	.area CONST
      00804A                       1615 ___str_3:
      00804A 53 52 32 20 2D 3E 20  1616 	.ascii "SR2 -> "
      008051 00                    1617 	.db 0x00
                                   1618 	.area CODE
                                   1619 	.area CONST
      008052                       1620 ___str_4:
      008052 53 52 33 20 2D 3E 20  1621 	.ascii "SR3 -> "
      008059 00                    1622 	.db 0x00
                                   1623 	.area CODE
                                   1624 	.area CONST
      00805A                       1625 ___str_5:
      00805A 43 52 31 20 2D 3E 20  1626 	.ascii "CR1 -> "
      008061 00                    1627 	.db 0x00
                                   1628 	.area CODE
                                   1629 	.area CONST
      008062                       1630 ___str_6:
      008062 43 52 32 20 2D 3E 20  1631 	.ascii "CR2 -> "
      008069 00                    1632 	.db 0x00
                                   1633 	.area CODE
                                   1634 	.area CONST
      00806A                       1635 ___str_7:
      00806A 44 52 20 2D 3E 20     1636 	.ascii "DR -> "
      008070 00                    1637 	.db 0x00
                                   1638 	.area CODE
                                   1639 	.area CONST
      008071                       1640 ___str_8:
      008071 53 4D 20              1641 	.ascii "SM "
      008074 00                    1642 	.db 0x00
                                   1643 	.area CODE
                                   1644 	.area CONST
      008075                       1645 ___str_9:
      008075 0D                    1646 	.db 0x0d
      008076 0A                    1647 	.db 0x0a
      008077 00                    1648 	.db 0x00
                                   1649 	.area CODE
                                   1650 	.area CONST
      008078                       1651 ___str_10:
      008078 52 4D                 1652 	.ascii "RM"
      00807A 0A                    1653 	.db 0x0a
      00807B 00                    1654 	.db 0x00
                                   1655 	.area CODE
                                   1656 	.area CONST
      00807C                       1657 ___str_11:
      00807C 53 54                 1658 	.ascii "ST"
      00807E 0A                    1659 	.db 0x0a
      00807F 00                    1660 	.db 0x00
                                   1661 	.area CODE
                                   1662 	.area CONST
      008080                       1663 ___str_12:
      008080 53 52 20              1664 	.ascii "SR "
      008083 00                    1665 	.db 0x00
                                   1666 	.area CODE
                                   1667 	.area CONST
      008084                       1668 ___str_13:
      008084 20                    1669 	.ascii " "
      008085 00                    1670 	.db 0x00
                                   1671 	.area CODE
                                   1672 	.area CONST
      008086                       1673 ___str_14:
      008086 53 57 20              1674 	.ascii "SW "
      008089 00                    1675 	.db 0x00
                                   1676 	.area CODE
                                   1677 	.area CONST
      00808A                       1678 ___str_15:
      00808A 53 4D                 1679 	.ascii "SM"
      00808C 00                    1680 	.db 0x00
                                   1681 	.area CODE
                                   1682 	.area CONST
      00808D                       1683 ___str_16:
      00808D 53 4E                 1684 	.ascii "SN"
      00808F 00                    1685 	.db 0x00
                                   1686 	.area CODE
                                   1687 	.area CONST
      008090                       1688 ___str_17:
      008090 53 54                 1689 	.ascii "ST"
      008092 00                    1690 	.db 0x00
                                   1691 	.area CODE
                                   1692 	.area CONST
      008093                       1693 ___str_18:
      008093 52 4D                 1694 	.ascii "RM"
      008095 00                    1695 	.db 0x00
                                   1696 	.area CODE
                                   1697 	.area CONST
      008096                       1698 ___str_19:
      008096 44 42                 1699 	.ascii "DB"
      008098 00                    1700 	.db 0x00
                                   1701 	.area CODE
                                   1702 	.area CONST
      008099                       1703 ___str_20:
      008099 53 52                 1704 	.ascii "SR"
      00809B 00                    1705 	.db 0x00
                                   1706 	.area CODE
                                   1707 	.area CONST
      00809C                       1708 ___str_21:
      00809C 53 57                 1709 	.ascii "SW"
      00809E 00                    1710 	.db 0x00
                                   1711 	.area CODE
                                   1712 	.area CONST
      00809F                       1713 ___str_22:
      00809F 53 53                 1714 	.ascii "SS"
      0080A1 0A                    1715 	.db 0x0a
      0080A2 00                    1716 	.db 0x00
                                   1717 	.area CODE
                                   1718 	.area INITIALIZER
      0080A3                       1719 __xinit__status_registers:
      0080A3 00                    1720 	.db #0x00	; 0
      0080A4 00                    1721 	.db 0x00
      0080A5 00                    1722 	.db 0x00
      0080A6 00                    1723 	.db 0x00
      0080A7 00                    1724 	.db 0x00
      0080A8 00                    1725 	.db 0x00
      0080A9 00                    1726 	.db 0x00
      0080AA 00                    1727 	.db 0x00
      0080AB 00                    1728 	.db 0x00
      0080AC 00                    1729 	.db 0x00
      0080AD 00                    1730 	.db 0x00
      0080AE 00                    1731 	.db 0x00
      0080AF 00                    1732 	.db 0x00
      0080B0 00                    1733 	.db 0x00
      0080B1 00                    1734 	.db 0x00
      0080B2 00                    1735 	.db 0x00
      0080B3 00                    1736 	.db 0x00
      0080B4 00                    1737 	.db 0x00
      0080B5 00                    1738 	.db 0x00
      0080B6 00                    1739 	.db 0x00
      0080B7 00                    1740 	.db 0x00
      0080B8 00                    1741 	.db 0x00
      0080B9 00                    1742 	.db 0x00
      0080BA 00                    1743 	.db 0x00
      0080BB 00                    1744 	.db 0x00
      0080BC 00                    1745 	.db 0x00
      0080BD 00                    1746 	.db 0x00
      0080BE 00                    1747 	.db 0x00
      0080BF 00                    1748 	.db 0x00
      0080C0 00                    1749 	.db 0x00
      0080C1 00                    1750 	.db 0x00
      0080C2 00                    1751 	.db 0x00
      0080C3 00                    1752 	.db 0x00
      0080C4 00                    1753 	.db 0x00
      0080C5 00                    1754 	.db 0x00
      0080C6 00                    1755 	.db 0x00
      0080C7 00                    1756 	.db 0x00
      0080C8 00                    1757 	.db 0x00
      0080C9 00                    1758 	.db 0x00
      0080CA 00                    1759 	.db 0x00
      0080CB 00                    1760 	.db 0x00
      0080CC 00                    1761 	.db 0x00
      0080CD 00                    1762 	.db 0x00
      0080CE 00                    1763 	.db 0x00
      0080CF 00                    1764 	.db 0x00
      0080D0 00                    1765 	.db 0x00
      0080D1 00                    1766 	.db 0x00
      0080D2 00                    1767 	.db 0x00
      0080D3 00                    1768 	.db 0x00
      0080D4 00                    1769 	.db 0x00
      0080D5 00                    1770 	.db 0x00
      0080D6 00                    1771 	.db 0x00
      0080D7 00                    1772 	.db 0x00
      0080D8 00                    1773 	.db 0x00
      0080D9 00                    1774 	.db 0x00
      0080DA 00                    1775 	.db 0x00
      0080DB 00                    1776 	.db 0x00
      0080DC 00                    1777 	.db 0x00
      0080DD 00                    1778 	.db 0x00
      0080DE 00                    1779 	.db 0x00
      0080DF 00                    1780 	.db 0x00
      0080E0 00                    1781 	.db 0x00
      0080E1 00                    1782 	.db 0x00
      0080E2 00                    1783 	.db 0x00
      0080E3 00                    1784 	.db 0x00
      0080E4 00                    1785 	.db 0x00
      0080E5 00                    1786 	.db 0x00
      0080E6 00                    1787 	.db 0x00
      0080E7 00                    1788 	.db 0x00
      0080E8 00                    1789 	.db 0x00
      0080E9 00                    1790 	.db 0x00
      0080EA 00                    1791 	.db 0x00
      0080EB 00                    1792 	.db 0x00
      0080EC 00                    1793 	.db 0x00
      0080ED 00                    1794 	.db 0x00
      0080EE 00                    1795 	.db 0x00
      0080EF 00                    1796 	.db 0x00
      0080F0 00                    1797 	.db 0x00
      0080F1 00                    1798 	.db 0x00
      0080F2 00                    1799 	.db 0x00
      0080F3 00                    1800 	.db 0x00
      0080F4 00                    1801 	.db 0x00
      0080F5 00                    1802 	.db 0x00
      0080F6 00                    1803 	.db 0x00
      0080F7 00                    1804 	.db 0x00
      0080F8 00                    1805 	.db 0x00
      0080F9 00                    1806 	.db 0x00
      0080FA 00                    1807 	.db 0x00
      0080FB 00                    1808 	.db 0x00
      0080FC 00                    1809 	.db 0x00
      0080FD 00                    1810 	.db 0x00
      0080FE 00                    1811 	.db 0x00
      0080FF 00                    1812 	.db 0x00
      008100 00                    1813 	.db 0x00
      008101 00                    1814 	.db 0x00
      008102 00                    1815 	.db 0x00
      008103 00                    1816 	.db 0x00
      008104 00                    1817 	.db 0x00
      008105 00                    1818 	.db 0x00
      008106 00                    1819 	.db 0x00
      008107 00                    1820 	.db 0x00
      008108 00                    1821 	.db 0x00
      008109 00                    1822 	.db 0x00
      00810A 00                    1823 	.db 0x00
      00810B 00                    1824 	.db 0x00
      00810C 00                    1825 	.db 0x00
      00810D 00                    1826 	.db 0x00
      00810E 00                    1827 	.db 0x00
      00810F 00                    1828 	.db 0x00
      008110 00                    1829 	.db 0x00
      008111 00                    1830 	.db 0x00
      008112 00                    1831 	.db 0x00
      008113 00                    1832 	.db 0x00
      008114 00                    1833 	.db 0x00
      008115 00                    1834 	.db 0x00
      008116 00                    1835 	.db 0x00
      008117 00                    1836 	.db 0x00
      008118 00                    1837 	.db 0x00
      008119 00                    1838 	.db 0x00
      00811A 00                    1839 	.db 0x00
      00811B 00                    1840 	.db 0x00
      00811C 00                    1841 	.db 0x00
      00811D 00                    1842 	.db 0x00
      00811E 00                    1843 	.db 0x00
      00811F 00                    1844 	.db 0x00
      008120 00                    1845 	.db 0x00
      008121 00                    1846 	.db 0x00
      008122 00                    1847 	.db 0x00
      008123 00                    1848 	.db 0x00
      008124 00                    1849 	.db 0x00
      008125 00                    1850 	.db 0x00
      008126 00                    1851 	.db 0x00
      008127 00                    1852 	.db 0x00
      008128 00                    1853 	.db 0x00
      008129 00                    1854 	.db 0x00
      00812A 00                    1855 	.db 0x00
      00812B 00                    1856 	.db 0x00
      00812C 00                    1857 	.db 0x00
      00812D 00                    1858 	.db 0x00
      00812E 00                    1859 	.db 0x00
      00812F 00                    1860 	.db 0x00
      008130 00                    1861 	.db 0x00
      008131 00                    1862 	.db 0x00
      008132 00                    1863 	.db 0x00
      008133 00                    1864 	.db 0x00
      008134 00                    1865 	.db 0x00
      008135 00                    1866 	.db 0x00
      008136 00                    1867 	.db 0x00
      008137 00                    1868 	.db 0x00
      008138 00                    1869 	.db 0x00
      008139 00                    1870 	.db 0x00
      00813A 00                    1871 	.db 0x00
      00813B 00                    1872 	.db 0x00
      00813C 00                    1873 	.db 0x00
      00813D 00                    1874 	.db 0x00
      00813E 00                    1875 	.db 0x00
      00813F 00                    1876 	.db 0x00
      008140 00                    1877 	.db 0x00
      008141 00                    1878 	.db 0x00
      008142 00                    1879 	.db 0x00
      008143 00                    1880 	.db 0x00
      008144 00                    1881 	.db 0x00
      008145 00                    1882 	.db 0x00
      008146 00                    1883 	.db 0x00
      008147 00                    1884 	.db 0x00
      008148 00                    1885 	.db 0x00
      008149 00                    1886 	.db 0x00
      00814A 00                    1887 	.db 0x00
      00814B 00                    1888 	.db 0x00
      00814C 00                    1889 	.db 0x00
      00814D 00                    1890 	.db 0x00
      00814E 00                    1891 	.db 0x00
      00814F 00                    1892 	.db 0x00
      008150 00                    1893 	.db 0x00
      008151 00                    1894 	.db 0x00
      008152 00                    1895 	.db 0x00
      008153 00                    1896 	.db 0x00
      008154 00                    1897 	.db 0x00
      008155 00                    1898 	.db 0x00
      008156 00                    1899 	.db 0x00
      008157 00                    1900 	.db 0x00
      008158 00                    1901 	.db 0x00
      008159 00                    1902 	.db 0x00
      00815A 00                    1903 	.db 0x00
      00815B 00                    1904 	.db 0x00
      00815C 00                    1905 	.db 0x00
      00815D 00                    1906 	.db 0x00
      00815E 00                    1907 	.db 0x00
      00815F 00                    1908 	.db 0x00
      008160 00                    1909 	.db 0x00
      008161 00                    1910 	.db 0x00
      008162 00                    1911 	.db 0x00
      008163 00                    1912 	.db 0x00
      008164 00                    1913 	.db 0x00
      008165 00                    1914 	.db 0x00
      008166 00                    1915 	.db 0x00
      008167 00                    1916 	.db 0x00
      008168 00                    1917 	.db 0x00
      008169 00                    1918 	.db 0x00
      00816A 00                    1919 	.db 0x00
      00816B 00                    1920 	.db 0x00
      00816C 00                    1921 	.db 0x00
      00816D 00                    1922 	.db 0x00
      00816E 00                    1923 	.db 0x00
      00816F 00                    1924 	.db 0x00
      008170 00                    1925 	.db 0x00
      008171 00                    1926 	.db 0x00
      008172 00                    1927 	.db 0x00
      008173 00                    1928 	.db 0x00
      008174 00                    1929 	.db 0x00
      008175 00                    1930 	.db 0x00
      008176 00                    1931 	.db 0x00
      008177 00                    1932 	.db 0x00
      008178 00                    1933 	.db 0x00
      008179 00                    1934 	.db 0x00
      00817A 00                    1935 	.db 0x00
      00817B 00                    1936 	.db 0x00
      00817C 00                    1937 	.db 0x00
      00817D 00                    1938 	.db 0x00
      00817E 00                    1939 	.db 0x00
      00817F 00                    1940 	.db 0x00
      008180 00                    1941 	.db 0x00
      008181 00                    1942 	.db 0x00
      008182 00                    1943 	.db 0x00
      008183 00                    1944 	.db 0x00
      008184 00                    1945 	.db 0x00
      008185 00                    1946 	.db 0x00
      008186 00                    1947 	.db 0x00
      008187 00                    1948 	.db 0x00
      008188 00                    1949 	.db 0x00
      008189 00                    1950 	.db 0x00
      00818A 00                    1951 	.db 0x00
      00818B 00                    1952 	.db 0x00
      00818C 00                    1953 	.db 0x00
      00818D 00                    1954 	.db 0x00
      00818E 00                    1955 	.db 0x00
      00818F 00                    1956 	.db 0x00
      008190 00                    1957 	.db 0x00
      008191 00                    1958 	.db 0x00
      008192 00                    1959 	.db 0x00
      008193 00                    1960 	.db 0x00
      008194 00                    1961 	.db 0x00
      008195 00                    1962 	.db 0x00
      008196 00                    1963 	.db 0x00
      008197 00                    1964 	.db 0x00
      008198 00                    1965 	.db 0x00
      008199 00                    1966 	.db 0x00
      00819A 00                    1967 	.db 0x00
      00819B 00                    1968 	.db 0x00
      00819C 00                    1969 	.db 0x00
      00819D 00                    1970 	.db 0x00
      00819E 00                    1971 	.db 0x00
      00819F 00                    1972 	.db 0x00
      0081A0 00                    1973 	.db 0x00
      0081A1 00                    1974 	.db 0x00
      0081A2 00                    1975 	.db 0x00
      0081A3                       1976 __xinit__buffer:
      0081A3 00                    1977 	.db #0x00	; 0
      0081A4 00                    1978 	.db 0x00
      0081A5 00                    1979 	.db 0x00
      0081A6 00                    1980 	.db 0x00
      0081A7 00                    1981 	.db 0x00
      0081A8 00                    1982 	.db 0x00
      0081A9 00                    1983 	.db 0x00
      0081AA 00                    1984 	.db 0x00
      0081AB 00                    1985 	.db 0x00
      0081AC 00                    1986 	.db 0x00
      0081AD 00                    1987 	.db 0x00
      0081AE 00                    1988 	.db 0x00
      0081AF 00                    1989 	.db 0x00
      0081B0 00                    1990 	.db 0x00
      0081B1 00                    1991 	.db 0x00
      0081B2 00                    1992 	.db 0x00
      0081B3 00                    1993 	.db 0x00
      0081B4 00                    1994 	.db 0x00
      0081B5 00                    1995 	.db 0x00
      0081B6 00                    1996 	.db 0x00
      0081B7 00                    1997 	.db 0x00
      0081B8 00                    1998 	.db 0x00
      0081B9 00                    1999 	.db 0x00
      0081BA 00                    2000 	.db 0x00
      0081BB 00                    2001 	.db 0x00
      0081BC 00                    2002 	.db 0x00
      0081BD 00                    2003 	.db 0x00
      0081BE 00                    2004 	.db 0x00
      0081BF 00                    2005 	.db 0x00
      0081C0 00                    2006 	.db 0x00
      0081C1 00                    2007 	.db 0x00
      0081C2 00                    2008 	.db 0x00
      0081C3 00                    2009 	.db 0x00
      0081C4 00                    2010 	.db 0x00
      0081C5 00                    2011 	.db 0x00
      0081C6 00                    2012 	.db 0x00
      0081C7 00                    2013 	.db 0x00
      0081C8 00                    2014 	.db 0x00
      0081C9 00                    2015 	.db 0x00
      0081CA 00                    2016 	.db 0x00
      0081CB 00                    2017 	.db 0x00
      0081CC 00                    2018 	.db 0x00
      0081CD 00                    2019 	.db 0x00
      0081CE 00                    2020 	.db 0x00
      0081CF 00                    2021 	.db 0x00
      0081D0 00                    2022 	.db 0x00
      0081D1 00                    2023 	.db 0x00
      0081D2 00                    2024 	.db 0x00
      0081D3 00                    2025 	.db 0x00
      0081D4 00                    2026 	.db 0x00
      0081D5 00                    2027 	.db 0x00
      0081D6 00                    2028 	.db 0x00
      0081D7 00                    2029 	.db 0x00
      0081D8 00                    2030 	.db 0x00
      0081D9 00                    2031 	.db 0x00
      0081DA 00                    2032 	.db 0x00
      0081DB 00                    2033 	.db 0x00
      0081DC 00                    2034 	.db 0x00
      0081DD 00                    2035 	.db 0x00
      0081DE 00                    2036 	.db 0x00
      0081DF 00                    2037 	.db 0x00
      0081E0 00                    2038 	.db 0x00
      0081E1 00                    2039 	.db 0x00
      0081E2 00                    2040 	.db 0x00
      0081E3 00                    2041 	.db 0x00
      0081E4 00                    2042 	.db 0x00
      0081E5 00                    2043 	.db 0x00
      0081E6 00                    2044 	.db 0x00
      0081E7 00                    2045 	.db 0x00
      0081E8 00                    2046 	.db 0x00
      0081E9 00                    2047 	.db 0x00
      0081EA 00                    2048 	.db 0x00
      0081EB 00                    2049 	.db 0x00
      0081EC 00                    2050 	.db 0x00
      0081ED 00                    2051 	.db 0x00
      0081EE 00                    2052 	.db 0x00
      0081EF 00                    2053 	.db 0x00
      0081F0 00                    2054 	.db 0x00
      0081F1 00                    2055 	.db 0x00
      0081F2 00                    2056 	.db 0x00
      0081F3 00                    2057 	.db 0x00
      0081F4 00                    2058 	.db 0x00
      0081F5 00                    2059 	.db 0x00
      0081F6 00                    2060 	.db 0x00
      0081F7 00                    2061 	.db 0x00
      0081F8 00                    2062 	.db 0x00
      0081F9 00                    2063 	.db 0x00
      0081FA 00                    2064 	.db 0x00
      0081FB 00                    2065 	.db 0x00
      0081FC 00                    2066 	.db 0x00
      0081FD 00                    2067 	.db 0x00
      0081FE 00                    2068 	.db 0x00
      0081FF 00                    2069 	.db 0x00
      008200 00                    2070 	.db 0x00
      008201 00                    2071 	.db 0x00
      008202 00                    2072 	.db 0x00
      008203 00                    2073 	.db 0x00
      008204 00                    2074 	.db 0x00
      008205 00                    2075 	.db 0x00
      008206 00                    2076 	.db 0x00
      008207 00                    2077 	.db 0x00
      008208 00                    2078 	.db 0x00
      008209 00                    2079 	.db 0x00
      00820A 00                    2080 	.db 0x00
      00820B 00                    2081 	.db 0x00
      00820C 00                    2082 	.db 0x00
      00820D 00                    2083 	.db 0x00
      00820E 00                    2084 	.db 0x00
      00820F 00                    2085 	.db 0x00
      008210 00                    2086 	.db 0x00
      008211 00                    2087 	.db 0x00
      008212 00                    2088 	.db 0x00
      008213 00                    2089 	.db 0x00
      008214 00                    2090 	.db 0x00
      008215 00                    2091 	.db 0x00
      008216 00                    2092 	.db 0x00
      008217 00                    2093 	.db 0x00
      008218 00                    2094 	.db 0x00
      008219 00                    2095 	.db 0x00
      00821A 00                    2096 	.db 0x00
      00821B 00                    2097 	.db 0x00
      00821C 00                    2098 	.db 0x00
      00821D 00                    2099 	.db 0x00
      00821E 00                    2100 	.db 0x00
      00821F 00                    2101 	.db 0x00
      008220 00                    2102 	.db 0x00
      008221 00                    2103 	.db 0x00
      008222 00                    2104 	.db 0x00
      008223 00                    2105 	.db 0x00
      008224 00                    2106 	.db 0x00
      008225 00                    2107 	.db 0x00
      008226 00                    2108 	.db 0x00
      008227 00                    2109 	.db 0x00
      008228 00                    2110 	.db 0x00
      008229 00                    2111 	.db 0x00
      00822A 00                    2112 	.db 0x00
      00822B 00                    2113 	.db 0x00
      00822C 00                    2114 	.db 0x00
      00822D 00                    2115 	.db 0x00
      00822E 00                    2116 	.db 0x00
      00822F 00                    2117 	.db 0x00
      008230 00                    2118 	.db 0x00
      008231 00                    2119 	.db 0x00
      008232 00                    2120 	.db 0x00
      008233 00                    2121 	.db 0x00
      008234 00                    2122 	.db 0x00
      008235 00                    2123 	.db 0x00
      008236 00                    2124 	.db 0x00
      008237 00                    2125 	.db 0x00
      008238 00                    2126 	.db 0x00
      008239 00                    2127 	.db 0x00
      00823A 00                    2128 	.db 0x00
      00823B 00                    2129 	.db 0x00
      00823C 00                    2130 	.db 0x00
      00823D 00                    2131 	.db 0x00
      00823E 00                    2132 	.db 0x00
      00823F 00                    2133 	.db 0x00
      008240 00                    2134 	.db 0x00
      008241 00                    2135 	.db 0x00
      008242 00                    2136 	.db 0x00
      008243 00                    2137 	.db 0x00
      008244 00                    2138 	.db 0x00
      008245 00                    2139 	.db 0x00
      008246 00                    2140 	.db 0x00
      008247 00                    2141 	.db 0x00
      008248 00                    2142 	.db 0x00
      008249 00                    2143 	.db 0x00
      00824A 00                    2144 	.db 0x00
      00824B 00                    2145 	.db 0x00
      00824C 00                    2146 	.db 0x00
      00824D 00                    2147 	.db 0x00
      00824E 00                    2148 	.db 0x00
      00824F 00                    2149 	.db 0x00
      008250 00                    2150 	.db 0x00
      008251 00                    2151 	.db 0x00
      008252 00                    2152 	.db 0x00
      008253 00                    2153 	.db 0x00
      008254 00                    2154 	.db 0x00
      008255 00                    2155 	.db 0x00
      008256 00                    2156 	.db 0x00
      008257 00                    2157 	.db 0x00
      008258 00                    2158 	.db 0x00
      008259 00                    2159 	.db 0x00
      00825A 00                    2160 	.db 0x00
      00825B 00                    2161 	.db 0x00
      00825C 00                    2162 	.db 0x00
      00825D 00                    2163 	.db 0x00
      00825E 00                    2164 	.db 0x00
      00825F 00                    2165 	.db 0x00
      008260 00                    2166 	.db 0x00
      008261 00                    2167 	.db 0x00
      008262 00                    2168 	.db 0x00
      008263 00                    2169 	.db 0x00
      008264 00                    2170 	.db 0x00
      008265 00                    2171 	.db 0x00
      008266 00                    2172 	.db 0x00
      008267 00                    2173 	.db 0x00
      008268 00                    2174 	.db 0x00
      008269 00                    2175 	.db 0x00
      00826A 00                    2176 	.db 0x00
      00826B 00                    2177 	.db 0x00
      00826C 00                    2178 	.db 0x00
      00826D 00                    2179 	.db 0x00
      00826E 00                    2180 	.db 0x00
      00826F 00                    2181 	.db 0x00
      008270 00                    2182 	.db 0x00
      008271 00                    2183 	.db 0x00
      008272 00                    2184 	.db 0x00
      008273 00                    2185 	.db 0x00
      008274 00                    2186 	.db 0x00
      008275 00                    2187 	.db 0x00
      008276 00                    2188 	.db 0x00
      008277 00                    2189 	.db 0x00
      008278 00                    2190 	.db 0x00
      008279 00                    2191 	.db 0x00
      00827A 00                    2192 	.db 0x00
      00827B 00                    2193 	.db 0x00
      00827C 00                    2194 	.db 0x00
      00827D 00                    2195 	.db 0x00
      00827E 00                    2196 	.db 0x00
      00827F 00                    2197 	.db 0x00
      008280 00                    2198 	.db 0x00
      008281 00                    2199 	.db 0x00
      008282 00                    2200 	.db 0x00
      008283 00                    2201 	.db 0x00
      008284 00                    2202 	.db 0x00
      008285 00                    2203 	.db 0x00
      008286 00                    2204 	.db 0x00
      008287 00                    2205 	.db 0x00
      008288 00                    2206 	.db 0x00
      008289 00                    2207 	.db 0x00
      00828A 00                    2208 	.db 0x00
      00828B 00                    2209 	.db 0x00
      00828C 00                    2210 	.db 0x00
      00828D 00                    2211 	.db 0x00
      00828E 00                    2212 	.db 0x00
      00828F 00                    2213 	.db 0x00
      008290 00                    2214 	.db 0x00
      008291 00                    2215 	.db 0x00
      008292 00                    2216 	.db 0x00
      008293 00                    2217 	.db 0x00
      008294 00                    2218 	.db 0x00
      008295 00                    2219 	.db 0x00
      008296 00                    2220 	.db 0x00
      008297 00                    2221 	.db 0x00
      008298 00                    2222 	.db 0x00
      008299 00                    2223 	.db 0x00
      00829A 00                    2224 	.db 0x00
      00829B 00                    2225 	.db 0x00
      00829C 00                    2226 	.db 0x00
      00829D 00                    2227 	.db 0x00
      00829E 00                    2228 	.db 0x00
      00829F 00                    2229 	.db 0x00
      0082A0 00                    2230 	.db 0x00
      0082A1 00                    2231 	.db 0x00
      0082A2 00                    2232 	.db 0x00
      0082A3                       2233 __xinit__a:
      0082A3 00                    2234 	.db #0x00	; 0
      0082A4 00                    2235 	.db 0x00
      0082A5 00                    2236 	.db 0x00
      0082A6                       2237 __xinit__d_addr:
      0082A6 00                    2238 	.db #0x00	; 0
      0082A7                       2239 __xinit__p_size:
      0082A7 00                    2240 	.db #0x00	; 0
      0082A8                       2241 __xinit__d_size:
      0082A8 00                    2242 	.db #0x00	; 0
      0082A9                       2243 __xinit__p_bytes:
      0082A9 00                    2244 	.db #0x00	; 0
      0082AA                       2245 __xinit__data_buf:
      0082AA 00                    2246 	.db #0x00	; 0
      0082AB 00                    2247 	.db 0x00
      0082AC 00                    2248 	.db 0x00
      0082AD 00                    2249 	.db 0x00
      0082AE 00                    2250 	.db 0x00
      0082AF 00                    2251 	.db 0x00
      0082B0 00                    2252 	.db 0x00
      0082B1 00                    2253 	.db 0x00
      0082B2 00                    2254 	.db 0x00
      0082B3 00                    2255 	.db 0x00
      0082B4 00                    2256 	.db 0x00
      0082B5 00                    2257 	.db 0x00
      0082B6 00                    2258 	.db 0x00
      0082B7 00                    2259 	.db 0x00
      0082B8 00                    2260 	.db 0x00
      0082B9 00                    2261 	.db 0x00
      0082BA 00                    2262 	.db 0x00
      0082BB 00                    2263 	.db 0x00
      0082BC 00                    2264 	.db 0x00
      0082BD 00                    2265 	.db 0x00
      0082BE 00                    2266 	.db 0x00
      0082BF 00                    2267 	.db 0x00
      0082C0 00                    2268 	.db 0x00
      0082C1 00                    2269 	.db 0x00
      0082C2 00                    2270 	.db 0x00
      0082C3 00                    2271 	.db 0x00
      0082C4 00                    2272 	.db 0x00
      0082C5 00                    2273 	.db 0x00
      0082C6 00                    2274 	.db 0x00
      0082C7 00                    2275 	.db 0x00
      0082C8 00                    2276 	.db 0x00
      0082C9 00                    2277 	.db 0x00
      0082CA 00                    2278 	.db 0x00
      0082CB 00                    2279 	.db 0x00
      0082CC 00                    2280 	.db 0x00
      0082CD 00                    2281 	.db 0x00
      0082CE 00                    2282 	.db 0x00
      0082CF 00                    2283 	.db 0x00
      0082D0 00                    2284 	.db 0x00
      0082D1 00                    2285 	.db 0x00
      0082D2 00                    2286 	.db 0x00
      0082D3 00                    2287 	.db 0x00
      0082D4 00                    2288 	.db 0x00
      0082D5 00                    2289 	.db 0x00
      0082D6 00                    2290 	.db 0x00
      0082D7 00                    2291 	.db 0x00
      0082D8 00                    2292 	.db 0x00
      0082D9 00                    2293 	.db 0x00
      0082DA 00                    2294 	.db 0x00
      0082DB 00                    2295 	.db 0x00
      0082DC 00                    2296 	.db 0x00
      0082DD 00                    2297 	.db 0x00
      0082DE 00                    2298 	.db 0x00
      0082DF 00                    2299 	.db 0x00
      0082E0 00                    2300 	.db 0x00
      0082E1 00                    2301 	.db 0x00
      0082E2 00                    2302 	.db 0x00
      0082E3 00                    2303 	.db 0x00
      0082E4 00                    2304 	.db 0x00
      0082E5 00                    2305 	.db 0x00
      0082E6 00                    2306 	.db 0x00
      0082E7 00                    2307 	.db 0x00
      0082E8 00                    2308 	.db 0x00
      0082E9 00                    2309 	.db 0x00
      0082EA 00                    2310 	.db 0x00
      0082EB 00                    2311 	.db 0x00
      0082EC 00                    2312 	.db 0x00
      0082ED 00                    2313 	.db 0x00
      0082EE 00                    2314 	.db 0x00
      0082EF 00                    2315 	.db 0x00
      0082F0 00                    2316 	.db 0x00
      0082F1 00                    2317 	.db 0x00
      0082F2 00                    2318 	.db 0x00
      0082F3 00                    2319 	.db 0x00
      0082F4 00                    2320 	.db 0x00
      0082F5 00                    2321 	.db 0x00
      0082F6 00                    2322 	.db 0x00
      0082F7 00                    2323 	.db 0x00
      0082F8 00                    2324 	.db 0x00
      0082F9 00                    2325 	.db 0x00
      0082FA 00                    2326 	.db 0x00
      0082FB 00                    2327 	.db 0x00
      0082FC 00                    2328 	.db 0x00
      0082FD 00                    2329 	.db 0x00
      0082FE 00                    2330 	.db 0x00
      0082FF 00                    2331 	.db 0x00
      008300 00                    2332 	.db 0x00
      008301 00                    2333 	.db 0x00
      008302 00                    2334 	.db 0x00
      008303 00                    2335 	.db 0x00
      008304 00                    2336 	.db 0x00
      008305 00                    2337 	.db 0x00
      008306 00                    2338 	.db 0x00
      008307 00                    2339 	.db 0x00
      008308 00                    2340 	.db 0x00
      008309 00                    2341 	.db 0x00
      00830A 00                    2342 	.db 0x00
      00830B 00                    2343 	.db 0x00
      00830C 00                    2344 	.db 0x00
      00830D 00                    2345 	.db 0x00
      00830E 00                    2346 	.db 0x00
      00830F 00                    2347 	.db 0x00
      008310 00                    2348 	.db 0x00
      008311 00                    2349 	.db 0x00
      008312 00                    2350 	.db 0x00
      008313 00                    2351 	.db 0x00
      008314 00                    2352 	.db 0x00
      008315 00                    2353 	.db 0x00
      008316 00                    2354 	.db 0x00
      008317 00                    2355 	.db 0x00
      008318 00                    2356 	.db 0x00
      008319 00                    2357 	.db 0x00
      00831A 00                    2358 	.db 0x00
      00831B 00                    2359 	.db 0x00
      00831C 00                    2360 	.db 0x00
      00831D 00                    2361 	.db 0x00
      00831E 00                    2362 	.db 0x00
      00831F 00                    2363 	.db 0x00
      008320 00                    2364 	.db 0x00
      008321 00                    2365 	.db 0x00
      008322 00                    2366 	.db 0x00
      008323 00                    2367 	.db 0x00
      008324 00                    2368 	.db 0x00
      008325 00                    2369 	.db 0x00
      008326 00                    2370 	.db 0x00
      008327 00                    2371 	.db 0x00
      008328 00                    2372 	.db 0x00
      008329 00                    2373 	.db 0x00
      00832A 00                    2374 	.db 0x00
      00832B 00                    2375 	.db 0x00
      00832C 00                    2376 	.db 0x00
      00832D 00                    2377 	.db 0x00
      00832E 00                    2378 	.db 0x00
      00832F 00                    2379 	.db 0x00
      008330 00                    2380 	.db 0x00
      008331 00                    2381 	.db 0x00
      008332 00                    2382 	.db 0x00
      008333 00                    2383 	.db 0x00
      008334 00                    2384 	.db 0x00
      008335 00                    2385 	.db 0x00
      008336 00                    2386 	.db 0x00
      008337 00                    2387 	.db 0x00
      008338 00                    2388 	.db 0x00
      008339 00                    2389 	.db 0x00
      00833A 00                    2390 	.db 0x00
      00833B 00                    2391 	.db 0x00
      00833C 00                    2392 	.db 0x00
      00833D 00                    2393 	.db 0x00
      00833E 00                    2394 	.db 0x00
      00833F 00                    2395 	.db 0x00
      008340 00                    2396 	.db 0x00
      008341 00                    2397 	.db 0x00
      008342 00                    2398 	.db 0x00
      008343 00                    2399 	.db 0x00
      008344 00                    2400 	.db 0x00
      008345 00                    2401 	.db 0x00
      008346 00                    2402 	.db 0x00
      008347 00                    2403 	.db 0x00
      008348 00                    2404 	.db 0x00
      008349 00                    2405 	.db 0x00
      00834A 00                    2406 	.db 0x00
      00834B 00                    2407 	.db 0x00
      00834C 00                    2408 	.db 0x00
      00834D 00                    2409 	.db 0x00
      00834E 00                    2410 	.db 0x00
      00834F 00                    2411 	.db 0x00
      008350 00                    2412 	.db 0x00
      008351 00                    2413 	.db 0x00
      008352 00                    2414 	.db 0x00
      008353 00                    2415 	.db 0x00
      008354 00                    2416 	.db 0x00
      008355 00                    2417 	.db 0x00
      008356 00                    2418 	.db 0x00
      008357 00                    2419 	.db 0x00
      008358 00                    2420 	.db 0x00
      008359 00                    2421 	.db 0x00
      00835A 00                    2422 	.db 0x00
      00835B 00                    2423 	.db 0x00
      00835C 00                    2424 	.db 0x00
      00835D 00                    2425 	.db 0x00
      00835E 00                    2426 	.db 0x00
      00835F 00                    2427 	.db 0x00
      008360 00                    2428 	.db 0x00
      008361 00                    2429 	.db 0x00
      008362 00                    2430 	.db 0x00
      008363 00                    2431 	.db 0x00
      008364 00                    2432 	.db 0x00
      008365 00                    2433 	.db 0x00
      008366 00                    2434 	.db 0x00
      008367 00                    2435 	.db 0x00
      008368 00                    2436 	.db 0x00
      008369 00                    2437 	.db 0x00
      00836A 00                    2438 	.db 0x00
      00836B 00                    2439 	.db 0x00
      00836C 00                    2440 	.db 0x00
      00836D 00                    2441 	.db 0x00
      00836E 00                    2442 	.db 0x00
      00836F 00                    2443 	.db 0x00
      008370 00                    2444 	.db 0x00
      008371 00                    2445 	.db 0x00
      008372 00                    2446 	.db 0x00
      008373 00                    2447 	.db 0x00
      008374 00                    2448 	.db 0x00
      008375 00                    2449 	.db 0x00
      008376 00                    2450 	.db 0x00
      008377 00                    2451 	.db 0x00
      008378 00                    2452 	.db 0x00
      008379 00                    2453 	.db 0x00
      00837A 00                    2454 	.db 0x00
      00837B 00                    2455 	.db 0x00
      00837C 00                    2456 	.db 0x00
      00837D 00                    2457 	.db 0x00
      00837E 00                    2458 	.db 0x00
      00837F 00                    2459 	.db 0x00
      008380 00                    2460 	.db 0x00
      008381 00                    2461 	.db 0x00
      008382 00                    2462 	.db 0x00
      008383 00                    2463 	.db 0x00
      008384 00                    2464 	.db 0x00
      008385 00                    2465 	.db 0x00
      008386 00                    2466 	.db 0x00
      008387 00                    2467 	.db 0x00
      008388 00                    2468 	.db 0x00
      008389 00                    2469 	.db 0x00
      00838A 00                    2470 	.db 0x00
      00838B 00                    2471 	.db 0x00
      00838C 00                    2472 	.db 0x00
      00838D 00                    2473 	.db 0x00
      00838E 00                    2474 	.db 0x00
      00838F 00                    2475 	.db 0x00
      008390 00                    2476 	.db 0x00
      008391 00                    2477 	.db 0x00
      008392 00                    2478 	.db 0x00
      008393 00                    2479 	.db 0x00
      008394 00                    2480 	.db 0x00
      008395 00                    2481 	.db 0x00
      008396 00                    2482 	.db 0x00
      008397 00                    2483 	.db 0x00
      008398 00                    2484 	.db 0x00
      008399 00                    2485 	.db 0x00
      00839A 00                    2486 	.db 0x00
      00839B 00                    2487 	.db 0x00
      00839C 00                    2488 	.db 0x00
      00839D 00                    2489 	.db 0x00
      00839E 00                    2490 	.db 0x00
      00839F 00                    2491 	.db 0x00
      0083A0 00                    2492 	.db 0x00
      0083A1 00                    2493 	.db 0x00
      0083A2 00                    2494 	.db 0x00
      0083A3 00                    2495 	.db 0x00
      0083A4 00                    2496 	.db 0x00
      0083A5 00                    2497 	.db 0x00
      0083A6 00                    2498 	.db 0x00
      0083A7 00                    2499 	.db 0x00
      0083A8 00                    2500 	.db 0x00
      0083A9 00                    2501 	.db 0x00
      0083AA                       2502 __xinit__current_dev:
      0083AA 00                    2503 	.db #0x00	; 0
                                   2504 	.area CABS (ABS)
