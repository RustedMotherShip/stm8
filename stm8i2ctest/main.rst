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
      008007 CD 8B E0         [ 4]  114 	call	___sdcc_external_startup
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
      008004 CC 8A F2         [ 2]  144 	jp	_main
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
      0083C3 24 01            [ 1]  168 	jrnc	00121$
      0083C5 5A               [ 2]  169 	decw	x
      0083C6                        170 00121$:
      0083C6 4D               [ 1]  171 	tnz	a
      0083C7 26 08            [ 1]  172 	jrne	00122$
      0083C9 16 02            [ 2]  173 	ldw	y, (0x02, sp)
      0083CB 26 04            [ 1]  174 	jrne	00122$
      0083CD 0D 01            [ 1]  175 	tnz	(0x01, sp)
      0083CF 27 03            [ 1]  176 	jreq	00104$
      0083D1                        177 00122$:
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
      0083EA CD 8B E2         [ 4]  210 	call	_strlen
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
      00841F CD 8B BE         [ 4]  259 	call	_memset
                                    260 ;	main.c: 66: while(i<256)
      008422 90 5F            [ 1]  261 	clrw	y
      008424                        262 00109$:
      008424 90 A3 01 00      [ 2]  263 	cpw	y, #0x0100
      008428 2E 29            [ 1]  264 	jrsge	00111$
                                    265 ;	main.c: 69: if(UART1_SR & UART_SR_RXNE)
      00842A C6 52 30         [ 1]  266 	ld	a, 0x5230
      00842D A5 20            [ 1]  267 	bcp	a, #0x20
      00842F 27 F3            [ 1]  268 	jreq	00109$
                                    269 ;	main.c: 72: buffer[i] = UART_RX();
      008431 93               [ 1]  270 	ldw	x, y
      008432 1C 01 01         [ 2]  271 	addw	x, #(_buffer+0)
      008435 89               [ 2]  272 	pushw	x
      008436 90 89            [ 2]  273 	pushw	y
      008438 CD 84 0D         [ 4]  274 	call	_UART_RX
      00843B 90 85            [ 2]  275 	popw	y
      00843D 85               [ 2]  276 	popw	x
      00843E F7               [ 1]  277 	ld	(x), a
                                    278 ;	main.c: 73: if(buffer[i] == '\r')
      00843F A1 0D            [ 1]  279 	cp	a, #0x0d
      008441 26 03            [ 1]  280 	jrne	00102$
                                    281 ;	main.c: 75: return 1;
      008443 5F               [ 1]  282 	clrw	x
      008444 5C               [ 1]  283 	incw	x
      008445 81               [ 4]  284 	ret
                                    285 ;	main.c: 76: break;
      008446                        286 00102$:
                                    287 ;	main.c: 78: if(buffer[i] < 32 || buffer[i] > 126);
      008446 F6               [ 1]  288 	ld	a, (x)
      008447 A1 20            [ 1]  289 	cp	a, #0x20
      008449 25 D9            [ 1]  290 	jrc	00109$
      00844B A1 7E            [ 1]  291 	cp	a, #0x7e
      00844D 22 D5            [ 1]  292 	jrugt	00109$
                                    293 ;	main.c: 80: i++;
      00844F 90 5C            [ 1]  294 	incw	y
      008451 20 D1            [ 2]  295 	jra	00109$
      008453                        296 00111$:
                                    297 ;	main.c: 84: return 0;
      008453 5F               [ 1]  298 	clrw	x
                                    299 ;	main.c: 85: }
      008454 81               [ 4]  300 	ret
                                    301 ;	main.c: 94: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    302 ;	-----------------------------------------
                                    303 ;	 function convert_int_to_chars
                                    304 ;	-----------------------------------------
      008455                        305 _convert_int_to_chars:
      008455 52 0D            [ 2]  306 	sub	sp, #13
      008457 6B 0D            [ 1]  307 	ld	(0x0d, sp), a
      008459 1F 0B            [ 2]  308 	ldw	(0x0b, sp), x
                                    309 ;	main.c: 97: rx_int_chars[0] = num / 100 + '0';
      00845B 7B 0D            [ 1]  310 	ld	a, (0x0d, sp)
      00845D 6B 02            [ 1]  311 	ld	(0x02, sp), a
      00845F 0F 01            [ 1]  312 	clr	(0x01, sp)
                                    313 ;	main.c: 98: rx_int_chars[1] = num / 10 % 10 + '0';
      008461 1E 0B            [ 2]  314 	ldw	x, (0x0b, sp)
      008463 5C               [ 1]  315 	incw	x
      008464 1F 03            [ 2]  316 	ldw	(0x03, sp), x
                                    317 ;	main.c: 99: rx_int_chars[2] = num % 10 + '0';
      008466 1E 0B            [ 2]  318 	ldw	x, (0x0b, sp)
      008468 5C               [ 1]  319 	incw	x
      008469 5C               [ 1]  320 	incw	x
      00846A 1F 05            [ 2]  321 	ldw	(0x05, sp), x
                                    322 ;	main.c: 98: rx_int_chars[1] = num / 10 % 10 + '0';
      00846C 4B 0A            [ 1]  323 	push	#0x0a
      00846E 4B 00            [ 1]  324 	push	#0x00
      008470 1E 03            [ 2]  325 	ldw	x, (0x03, sp)
                                    326 ;	main.c: 99: rx_int_chars[2] = num % 10 + '0';
      008472 CD 8C 08         [ 4]  327 	call	__divsint
      008475 1F 07            [ 2]  328 	ldw	(0x07, sp), x
      008477 4B 0A            [ 1]  329 	push	#0x0a
      008479 4B 00            [ 1]  330 	push	#0x00
      00847B 1E 03            [ 2]  331 	ldw	x, (0x03, sp)
      00847D CD 8B F0         [ 4]  332 	call	__modsint
      008480 9F               [ 1]  333 	ld	a, xl
      008481 AB 30            [ 1]  334 	add	a, #0x30
      008483 6B 09            [ 1]  335 	ld	(0x09, sp), a
                                    336 ;	main.c: 95: if (num > 99) {
      008485 7B 0D            [ 1]  337 	ld	a, (0x0d, sp)
      008487 A1 63            [ 1]  338 	cp	a, #0x63
      008489 23 29            [ 2]  339 	jrule	00105$
                                    340 ;	main.c: 97: rx_int_chars[0] = num / 100 + '0';
      00848B 4B 64            [ 1]  341 	push	#0x64
      00848D 4B 00            [ 1]  342 	push	#0x00
      00848F 1E 03            [ 2]  343 	ldw	x, (0x03, sp)
      008491 CD 8C 08         [ 4]  344 	call	__divsint
      008494 9F               [ 1]  345 	ld	a, xl
      008495 AB 30            [ 1]  346 	add	a, #0x30
      008497 1E 0B            [ 2]  347 	ldw	x, (0x0b, sp)
      008499 F7               [ 1]  348 	ld	(x), a
                                    349 ;	main.c: 98: rx_int_chars[1] = num / 10 % 10 + '0';
      00849A 4B 0A            [ 1]  350 	push	#0x0a
      00849C 4B 00            [ 1]  351 	push	#0x00
      00849E 1E 09            [ 2]  352 	ldw	x, (0x09, sp)
      0084A0 CD 8B F0         [ 4]  353 	call	__modsint
      0084A3 9F               [ 1]  354 	ld	a, xl
      0084A4 AB 30            [ 1]  355 	add	a, #0x30
      0084A6 1E 03            [ 2]  356 	ldw	x, (0x03, sp)
      0084A8 F7               [ 1]  357 	ld	(x), a
                                    358 ;	main.c: 99: rx_int_chars[2] = num % 10 + '0';
      0084A9 1E 05            [ 2]  359 	ldw	x, (0x05, sp)
      0084AB 7B 09            [ 1]  360 	ld	a, (0x09, sp)
      0084AD F7               [ 1]  361 	ld	(x), a
                                    362 ;	main.c: 100: rx_int_chars[3] ='\0';
      0084AE 1E 0B            [ 2]  363 	ldw	x, (0x0b, sp)
      0084B0 6F 03            [ 1]  364 	clr	(0x0003, x)
      0084B2 20 23            [ 2]  365 	jra	00107$
      0084B4                        366 00105$:
                                    367 ;	main.c: 102: } else if (num > 9) {
      0084B4 7B 0D            [ 1]  368 	ld	a, (0x0d, sp)
      0084B6 A1 09            [ 1]  369 	cp	a, #0x09
      0084B8 23 13            [ 2]  370 	jrule	00102$
                                    371 ;	main.c: 104: rx_int_chars[0] = num / 10 + '0';
      0084BA 7B 08            [ 1]  372 	ld	a, (0x08, sp)
      0084BC 6B 0A            [ 1]  373 	ld	(0x0a, sp), a
      0084BE AB 30            [ 1]  374 	add	a, #0x30
      0084C0 1E 0B            [ 2]  375 	ldw	x, (0x0b, sp)
      0084C2 F7               [ 1]  376 	ld	(x), a
                                    377 ;	main.c: 105: rx_int_chars[1] = num % 10 + '0';
      0084C3 1E 03            [ 2]  378 	ldw	x, (0x03, sp)
      0084C5 7B 09            [ 1]  379 	ld	a, (0x09, sp)
      0084C7 F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 106: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      0084C8 1E 05            [ 2]  382 	ldw	x, (0x05, sp)
      0084CA 7F               [ 1]  383 	clr	(x)
      0084CB 20 0A            [ 2]  384 	jra	00107$
      0084CD                        385 00102$:
                                    386 ;	main.c: 109: rx_int_chars[0] = num + '0';
      0084CD 7B 0D            [ 1]  387 	ld	a, (0x0d, sp)
      0084CF AB 30            [ 1]  388 	add	a, #0x30
      0084D1 1E 0B            [ 2]  389 	ldw	x, (0x0b, sp)
      0084D3 F7               [ 1]  390 	ld	(x), a
                                    391 ;	main.c: 110: rx_int_chars[1] ='\0';
      0084D4 1E 03            [ 2]  392 	ldw	x, (0x03, sp)
      0084D6 7F               [ 1]  393 	clr	(x)
      0084D7                        394 00107$:
                                    395 ;	main.c: 112: }
      0084D7 5B 0D            [ 2]  396 	addw	sp, #13
      0084D9 81               [ 4]  397 	ret
                                    398 ;	main.c: 114: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    399 ;	-----------------------------------------
                                    400 ;	 function convert_chars_to_int
                                    401 ;	-----------------------------------------
      0084DA                        402 _convert_chars_to_int:
      0084DA 52 03            [ 2]  403 	sub	sp, #3
      0084DC 1F 02            [ 2]  404 	ldw	(0x02, sp), x
                                    405 ;	main.c: 115: uint8_t result = 0;
      0084DE 4F               [ 1]  406 	clr	a
                                    407 ;	main.c: 117: for (int o = 0; o < i; o++) {
      0084DF 5F               [ 1]  408 	clrw	x
      0084E0                        409 00103$:
      0084E0 13 06            [ 2]  410 	cpw	x, (0x06, sp)
      0084E2 2E 18            [ 1]  411 	jrsge	00101$
                                    412 ;	main.c: 119: result = (result * 10) + (rx_chars_int[o] - '0');
      0084E4 90 97            [ 1]  413 	ld	yl, a
      0084E6 A6 0A            [ 1]  414 	ld	a, #0x0a
      0084E8 90 42            [ 4]  415 	mul	y, a
      0084EA 61               [ 1]  416 	exg	a, yl
      0084EB 6B 01            [ 1]  417 	ld	(0x01, sp), a
      0084ED 61               [ 1]  418 	exg	a, yl
      0084EE 90 93            [ 1]  419 	ldw	y, x
      0084F0 72 F9 02         [ 2]  420 	addw	y, (0x02, sp)
      0084F3 90 F6            [ 1]  421 	ld	a, (y)
      0084F5 A0 30            [ 1]  422 	sub	a, #0x30
      0084F7 1B 01            [ 1]  423 	add	a, (0x01, sp)
                                    424 ;	main.c: 117: for (int o = 0; o < i; o++) {
      0084F9 5C               [ 1]  425 	incw	x
      0084FA 20 E4            [ 2]  426 	jra	00103$
      0084FC                        427 00101$:
                                    428 ;	main.c: 122: return result;
                                    429 ;	main.c: 123: }
      0084FC 1E 04            [ 2]  430 	ldw	x, (4, sp)
      0084FE 5B 07            [ 2]  431 	addw	sp, #7
      008500 FC               [ 2]  432 	jp	(x)
                                    433 ;	main.c: 126: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    434 ;	-----------------------------------------
                                    435 ;	 function convert_int_to_binary
                                    436 ;	-----------------------------------------
      008501                        437 _convert_int_to_binary:
      008501 52 04            [ 2]  438 	sub	sp, #4
      008503 1F 01            [ 2]  439 	ldw	(0x01, sp), x
                                    440 ;	main.c: 128: for(int i = 7; i >= 0; i--) {
      008505 AE 00 07         [ 2]  441 	ldw	x, #0x0007
      008508 1F 03            [ 2]  442 	ldw	(0x03, sp), x
      00850A                        443 00103$:
      00850A 0D 03            [ 1]  444 	tnz	(0x03, sp)
      00850C 2B 22            [ 1]  445 	jrmi	00101$
                                    446 ;	main.c: 130: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      00850E AE 00 07         [ 2]  447 	ldw	x, #0x0007
      008511 72 F0 03         [ 2]  448 	subw	x, (0x03, sp)
      008514 72 FB 07         [ 2]  449 	addw	x, (0x07, sp)
      008517 16 01            [ 2]  450 	ldw	y, (0x01, sp)
      008519 7B 04            [ 1]  451 	ld	a, (0x04, sp)
      00851B 27 05            [ 1]  452 	jreq	00124$
      00851D                        453 00123$:
      00851D 90 57            [ 2]  454 	sraw	y
      00851F 4A               [ 1]  455 	dec	a
      008520 26 FB            [ 1]  456 	jrne	00123$
      008522                        457 00124$:
      008522 90 9F            [ 1]  458 	ld	a, yl
      008524 A4 01            [ 1]  459 	and	a, #0x01
      008526 AB 30            [ 1]  460 	add	a, #0x30
      008528 F7               [ 1]  461 	ld	(x), a
                                    462 ;	main.c: 128: for(int i = 7; i >= 0; i--) {
      008529 1E 03            [ 2]  463 	ldw	x, (0x03, sp)
      00852B 5A               [ 2]  464 	decw	x
      00852C 1F 03            [ 2]  465 	ldw	(0x03, sp), x
      00852E 20 DA            [ 2]  466 	jra	00103$
      008530                        467 00101$:
                                    468 ;	main.c: 132: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008530 1E 07            [ 2]  469 	ldw	x, (0x07, sp)
      008532 6F 08            [ 1]  470 	clr	(0x0008, x)
                                    471 ;	main.c: 133: }
      008534 1E 05            [ 2]  472 	ldw	x, (5, sp)
      008536 5B 08            [ 2]  473 	addw	sp, #8
      008538 FC               [ 2]  474 	jp	(x)
                                    475 ;	main.c: 142: void get_addr_from_buff(void)
                                    476 ;	-----------------------------------------
                                    477 ;	 function get_addr_from_buff
                                    478 ;	-----------------------------------------
      008539                        479 _get_addr_from_buff:
      008539 52 02            [ 2]  480 	sub	sp, #2
                                    481 ;	main.c: 146: while(1)
      00853B A6 03            [ 1]  482 	ld	a, #0x03
      00853D 6B 01            [ 1]  483 	ld	(0x01, sp), a
      00853F 0F 02            [ 1]  484 	clr	(0x02, sp)
      008541                        485 00105$:
                                    486 ;	main.c: 148: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008541 5F               [ 1]  487 	clrw	x
      008542 7B 01            [ 1]  488 	ld	a, (0x01, sp)
      008544 97               [ 1]  489 	ld	xl, a
      008545 D6 01 01         [ 1]  490 	ld	a, (_buffer+0, x)
      008548 A1 20            [ 1]  491 	cp	a, #0x20
      00854A 27 04            [ 1]  492 	jreq	00101$
      00854C A1 0D            [ 1]  493 	cp	a, #0x0d
      00854E 26 08            [ 1]  494 	jrne	00102$
      008550                        495 00101$:
                                    496 ;	main.c: 150: p_size = i+1;
      008550 7B 01            [ 1]  497 	ld	a, (0x01, sp)
      008552 4C               [ 1]  498 	inc	a
      008553 C7 02 05         [ 1]  499 	ld	_p_size+0, a
                                    500 ;	main.c: 151: break;
      008556 20 06            [ 2]  501 	jra	00106$
      008558                        502 00102$:
                                    503 ;	main.c: 153: i++;
      008558 0C 01            [ 1]  504 	inc	(0x01, sp)
                                    505 ;	main.c: 154: counter++;
      00855A 0C 02            [ 1]  506 	inc	(0x02, sp)
      00855C 20 E3            [ 2]  507 	jra	00105$
      00855E                        508 00106$:
                                    509 ;	main.c: 156: memcpy(a, &buffer[3], counter);
      00855E 5F               [ 1]  510 	clrw	x
      00855F 7B 02            [ 1]  511 	ld	a, (0x02, sp)
      008561 97               [ 1]  512 	ld	xl, a
      008562 89               [ 2]  513 	pushw	x
      008563 4B 04            [ 1]  514 	push	#<(_buffer+3)
      008565 4B 01            [ 1]  515 	push	#((_buffer+3) >> 8)
      008567 AE 02 01         [ 2]  516 	ldw	x, #(_a+0)
      00856A CD 8B 6B         [ 4]  517 	call	___memcpy
                                    518 ;	main.c: 157: d_addr = convert_chars_to_int(a, counter);
      00856D 5F               [ 1]  519 	clrw	x
      00856E 7B 02            [ 1]  520 	ld	a, (0x02, sp)
      008570 97               [ 1]  521 	ld	xl, a
      008571 89               [ 2]  522 	pushw	x
      008572 AE 02 01         [ 2]  523 	ldw	x, #(_a+0)
      008575 CD 84 DA         [ 4]  524 	call	_convert_chars_to_int
      008578 C7 02 04         [ 1]  525 	ld	_d_addr+0, a
                                    526 ;	main.c: 158: }
      00857B 5B 02            [ 2]  527 	addw	sp, #2
      00857D 81               [ 4]  528 	ret
                                    529 ;	main.c: 160: void get_size_from_buff(void)
                                    530 ;	-----------------------------------------
                                    531 ;	 function get_size_from_buff
                                    532 ;	-----------------------------------------
      00857E                        533 _get_size_from_buff:
      00857E 52 02            [ 2]  534 	sub	sp, #2
                                    535 ;	main.c: 162: memset(a, 0, sizeof(a));
      008580 4B 03            [ 1]  536 	push	#0x03
      008582 4B 00            [ 1]  537 	push	#0x00
      008584 5F               [ 1]  538 	clrw	x
      008585 89               [ 2]  539 	pushw	x
      008586 AE 02 01         [ 2]  540 	ldw	x, #(_a+0)
      008589 CD 8B BE         [ 4]  541 	call	_memset
                                    542 ;	main.c: 164: uint8_t i = p_size;
      00858C C6 02 05         [ 1]  543 	ld	a, _p_size+0
      00858F 6B 01            [ 1]  544 	ld	(0x01, sp), a
                                    545 ;	main.c: 165: while(1)
      008591 0F 02            [ 1]  546 	clr	(0x02, sp)
      008593                        547 00105$:
                                    548 ;	main.c: 167: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008593 5F               [ 1]  549 	clrw	x
      008594 7B 01            [ 1]  550 	ld	a, (0x01, sp)
      008596 97               [ 1]  551 	ld	xl, a
      008597 D6 01 01         [ 1]  552 	ld	a, (_buffer+0, x)
      00859A A1 20            [ 1]  553 	cp	a, #0x20
      00859C 27 04            [ 1]  554 	jreq	00101$
      00859E A1 0D            [ 1]  555 	cp	a, #0x0d
      0085A0 26 08            [ 1]  556 	jrne	00102$
      0085A2                        557 00101$:
                                    558 ;	main.c: 170: p_bytes = i+1;
      0085A2 7B 01            [ 1]  559 	ld	a, (0x01, sp)
      0085A4 4C               [ 1]  560 	inc	a
      0085A5 C7 02 07         [ 1]  561 	ld	_p_bytes+0, a
                                    562 ;	main.c: 171: break;
      0085A8 20 06            [ 2]  563 	jra	00106$
      0085AA                        564 00102$:
                                    565 ;	main.c: 173: i++;
      0085AA 0C 01            [ 1]  566 	inc	(0x01, sp)
                                    567 ;	main.c: 174: counter++;
      0085AC 0C 02            [ 1]  568 	inc	(0x02, sp)
      0085AE 20 E3            [ 2]  569 	jra	00105$
      0085B0                        570 00106$:
                                    571 ;	main.c: 177: memcpy(a, &buffer[p_size], counter);
      0085B0 90 5F            [ 1]  572 	clrw	y
      0085B2 7B 02            [ 1]  573 	ld	a, (0x02, sp)
      0085B4 90 97            [ 1]  574 	ld	yl, a
      0085B6 5F               [ 1]  575 	clrw	x
      0085B7 C6 02 05         [ 1]  576 	ld	a, _p_size+0
      0085BA 97               [ 1]  577 	ld	xl, a
      0085BB 1C 01 01         [ 2]  578 	addw	x, #(_buffer+0)
      0085BE 90 89            [ 2]  579 	pushw	y
      0085C0 89               [ 2]  580 	pushw	x
      0085C1 AE 02 01         [ 2]  581 	ldw	x, #(_a+0)
      0085C4 CD 8B 6B         [ 4]  582 	call	___memcpy
                                    583 ;	main.c: 178: d_size = convert_chars_to_int(a, counter);
      0085C7 5F               [ 1]  584 	clrw	x
      0085C8 7B 02            [ 1]  585 	ld	a, (0x02, sp)
      0085CA 97               [ 1]  586 	ld	xl, a
      0085CB 89               [ 2]  587 	pushw	x
      0085CC AE 02 01         [ 2]  588 	ldw	x, #(_a+0)
      0085CF CD 84 DA         [ 4]  589 	call	_convert_chars_to_int
      0085D2 C7 02 06         [ 1]  590 	ld	_d_size+0, a
                                    591 ;	main.c: 179: }
      0085D5 5B 02            [ 2]  592 	addw	sp, #2
      0085D7 81               [ 4]  593 	ret
                                    594 ;	main.c: 180: void char_buffer_to_int(void)
                                    595 ;	-----------------------------------------
                                    596 ;	 function char_buffer_to_int
                                    597 ;	-----------------------------------------
      0085D8                        598 _char_buffer_to_int:
      0085D8 52 08            [ 2]  599 	sub	sp, #8
                                    600 ;	main.c: 182: memset(a, 0, sizeof(a));
      0085DA 4B 03            [ 1]  601 	push	#0x03
      0085DC 4B 00            [ 1]  602 	push	#0x00
      0085DE 5F               [ 1]  603 	clrw	x
      0085DF 89               [ 2]  604 	pushw	x
      0085E0 AE 02 01         [ 2]  605 	ldw	x, #(_a+0)
      0085E3 CD 8B BE         [ 4]  606 	call	_memset
                                    607 ;	main.c: 183: uint8_t counter = d_size;
      0085E6 C6 02 06         [ 1]  608 	ld	a, _d_size+0
      0085E9 6B 01            [ 1]  609 	ld	(0x01, sp), a
                                    610 ;	main.c: 184: uint8_t i = p_bytes;
      0085EB C6 02 07         [ 1]  611 	ld	a, _p_bytes+0
      0085EE 6B 03            [ 1]  612 	ld	(0x03, sp), a
                                    613 ;	main.c: 187: for(int o = 0; o < counter;o++)
      0085F0 0F 04            [ 1]  614 	clr	(0x04, sp)
      0085F2 5F               [ 1]  615 	clrw	x
      0085F3 1F 05            [ 2]  616 	ldw	(0x05, sp), x
      0085F5                        617 00112$:
      0085F5 7B 01            [ 1]  618 	ld	a, (0x01, sp)
      0085F7 6B 08            [ 1]  619 	ld	(0x08, sp), a
      0085F9 0F 07            [ 1]  620 	clr	(0x07, sp)
      0085FB 1E 05            [ 2]  621 	ldw	x, (0x05, sp)
      0085FD 13 07            [ 2]  622 	cpw	x, (0x07, sp)
      0085FF 2E 65            [ 1]  623 	jrsge	00114$
                                    624 ;	main.c: 189: uint8_t number_counter = 0;
      008601 0F 02            [ 1]  625 	clr	(0x02, sp)
                                    626 ;	main.c: 190: while(1)
      008603 7B 03            [ 1]  627 	ld	a, (0x03, sp)
      008605 6B 07            [ 1]  628 	ld	(0x07, sp), a
      008607 0F 08            [ 1]  629 	clr	(0x08, sp)
      008609                        630 00108$:
                                    631 ;	main.c: 192: if(buffer[i] == ' ')
      008609 5F               [ 1]  632 	clrw	x
      00860A 7B 07            [ 1]  633 	ld	a, (0x07, sp)
      00860C 97               [ 1]  634 	ld	xl, a
      00860D D6 01 01         [ 1]  635 	ld	a, (_buffer+0, x)
      008610 A1 20            [ 1]  636 	cp	a, #0x20
      008612 26 04            [ 1]  637 	jrne	00105$
                                    638 ;	main.c: 194: i++;
      008614 0C 03            [ 1]  639 	inc	(0x03, sp)
                                    640 ;	main.c: 195: break;
      008616 20 12            [ 2]  641 	jra	00109$
      008618                        642 00105$:
                                    643 ;	main.c: 197: else if(buffer[i] == '\r\n')
      008618 A1 0D            [ 1]  644 	cp	a, #0x0d
      00861A 27 0E            [ 1]  645 	jreq	00109$
                                    646 ;	main.c: 200: i++;
      00861C 0C 07            [ 1]  647 	inc	(0x07, sp)
      00861E 7B 07            [ 1]  648 	ld	a, (0x07, sp)
      008620 6B 03            [ 1]  649 	ld	(0x03, sp), a
                                    650 ;	main.c: 202: number_counter++;
      008622 0C 08            [ 1]  651 	inc	(0x08, sp)
      008624 7B 08            [ 1]  652 	ld	a, (0x08, sp)
      008626 6B 02            [ 1]  653 	ld	(0x02, sp), a
      008628 20 DF            [ 2]  654 	jra	00108$
      00862A                        655 00109$:
                                    656 ;	main.c: 204: memcpy(a, &buffer[i - number_counter], number_counter);
      00862A 90 5F            [ 1]  657 	clrw	y
      00862C 7B 02            [ 1]  658 	ld	a, (0x02, sp)
      00862E 90 97            [ 1]  659 	ld	yl, a
      008630 5F               [ 1]  660 	clrw	x
      008631 7B 03            [ 1]  661 	ld	a, (0x03, sp)
      008633 97               [ 1]  662 	ld	xl, a
      008634 7B 02            [ 1]  663 	ld	a, (0x02, sp)
      008636 6B 08            [ 1]  664 	ld	(0x08, sp), a
      008638 0F 07            [ 1]  665 	clr	(0x07, sp)
      00863A 72 F0 07         [ 2]  666 	subw	x, (0x07, sp)
      00863D 1C 01 01         [ 2]  667 	addw	x, #(_buffer+0)
      008640 90 89            [ 2]  668 	pushw	y
      008642 89               [ 2]  669 	pushw	x
      008643 AE 02 01         [ 2]  670 	ldw	x, #(_a+0)
      008646 CD 8B 6B         [ 4]  671 	call	___memcpy
                                    672 ;	main.c: 205: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      008649 5F               [ 1]  673 	clrw	x
      00864A 7B 04            [ 1]  674 	ld	a, (0x04, sp)
      00864C 97               [ 1]  675 	ld	xl, a
      00864D 1C 02 08         [ 2]  676 	addw	x, #(_data_buf+0)
      008650 89               [ 2]  677 	pushw	x
      008651 16 09            [ 2]  678 	ldw	y, (0x09, sp)
      008653 90 89            [ 2]  679 	pushw	y
      008655 AE 02 01         [ 2]  680 	ldw	x, #(_a+0)
      008658 CD 84 DA         [ 4]  681 	call	_convert_chars_to_int
      00865B 85               [ 2]  682 	popw	x
      00865C F7               [ 1]  683 	ld	(x), a
                                    684 ;	main.c: 206: int_buf_i++;
      00865D 0C 04            [ 1]  685 	inc	(0x04, sp)
                                    686 ;	main.c: 187: for(int o = 0; o < counter;o++)
      00865F 1E 05            [ 2]  687 	ldw	x, (0x05, sp)
      008661 5C               [ 1]  688 	incw	x
      008662 1F 05            [ 2]  689 	ldw	(0x05, sp), x
      008664 20 8F            [ 2]  690 	jra	00112$
      008666                        691 00114$:
                                    692 ;	main.c: 208: }
      008666 5B 08            [ 2]  693 	addw	sp, #8
      008668 81               [ 4]  694 	ret
                                    695 ;	main.c: 216: void reg_check(void)
                                    696 ;	-----------------------------------------
                                    697 ;	 function reg_check
                                    698 ;	-----------------------------------------
      008669                        699 _reg_check:
      008669 52 09            [ 2]  700 	sub	sp, #9
                                    701 ;	main.c: 218: char rx_binary_chars[9]={0};
      00866B 0F 01            [ 1]  702 	clr	(0x01, sp)
      00866D 0F 02            [ 1]  703 	clr	(0x02, sp)
      00866F 0F 03            [ 1]  704 	clr	(0x03, sp)
      008671 0F 04            [ 1]  705 	clr	(0x04, sp)
      008673 0F 05            [ 1]  706 	clr	(0x05, sp)
      008675 0F 06            [ 1]  707 	clr	(0x06, sp)
      008677 0F 07            [ 1]  708 	clr	(0x07, sp)
      008679 0F 08            [ 1]  709 	clr	(0x08, sp)
      00867B 0F 09            [ 1]  710 	clr	(0x09, sp)
                                    711 ;	main.c: 223: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      00867D 96               [ 1]  712 	ldw	x, sp
      00867E 5C               [ 1]  713 	incw	x
      00867F 51               [ 1]  714 	exgw	x, y
      008680 C6 52 19         [ 1]  715 	ld	a, 0x5219
      008683 5F               [ 1]  716 	clrw	x
      008684 90 89            [ 2]  717 	pushw	y
      008686 97               [ 1]  718 	ld	xl, a
      008687 CD 85 01         [ 4]  719 	call	_convert_int_to_binary
                                    720 ;	main.c: 224: status_registers[2] = I2C_SR3;
      00868A 55 52 19 00 03   [ 1]  721 	mov	_status_registers+2, 0x5219
                                    722 ;	main.c: 229: convert_int_to_binary(I2C_DR, rx_binary_chars);
      00868F 96               [ 1]  723 	ldw	x, sp
      008690 5C               [ 1]  724 	incw	x
      008691 51               [ 1]  725 	exgw	x, y
      008692 C6 52 16         [ 1]  726 	ld	a, 0x5216
      008695 5F               [ 1]  727 	clrw	x
      008696 90 89            [ 2]  728 	pushw	y
      008698 97               [ 1]  729 	ld	xl, a
      008699 CD 85 01         [ 4]  730 	call	_convert_int_to_binary
                                    731 ;	main.c: 230: status_registers[5] = I2C_DR;
      00869C 55 52 16 00 06   [ 1]  732 	mov	_status_registers+5, 0x5216
                                    733 ;	main.c: 231: }
      0086A1 5B 09            [ 2]  734 	addw	sp, #9
      0086A3 81               [ 4]  735 	ret
                                    736 ;	main.c: 234: void status_check(void){
                                    737 ;	-----------------------------------------
                                    738 ;	 function status_check
                                    739 ;	-----------------------------------------
      0086A4                        740 _status_check:
      0086A4 52 09            [ 2]  741 	sub	sp, #9
                                    742 ;	main.c: 235: char rx_binary_chars[9]={0};
      0086A6 0F 01            [ 1]  743 	clr	(0x01, sp)
      0086A8 0F 02            [ 1]  744 	clr	(0x02, sp)
      0086AA 0F 03            [ 1]  745 	clr	(0x03, sp)
      0086AC 0F 04            [ 1]  746 	clr	(0x04, sp)
      0086AE 0F 05            [ 1]  747 	clr	(0x05, sp)
      0086B0 0F 06            [ 1]  748 	clr	(0x06, sp)
      0086B2 0F 07            [ 1]  749 	clr	(0x07, sp)
      0086B4 0F 08            [ 1]  750 	clr	(0x08, sp)
      0086B6 0F 09            [ 1]  751 	clr	(0x09, sp)
                                    752 ;	main.c: 236: uart_write("\nI2C_REGS >.<\n");
      0086B8 AE 80 2D         [ 2]  753 	ldw	x, #(___str_0+0)
      0086BB CD 83 E2         [ 4]  754 	call	_uart_write
                                    755 ;	main.c: 237: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0086BE 96               [ 1]  756 	ldw	x, sp
      0086BF 5C               [ 1]  757 	incw	x
      0086C0 51               [ 1]  758 	exgw	x, y
      0086C1 C6 52 17         [ 1]  759 	ld	a, 0x5217
      0086C4 5F               [ 1]  760 	clrw	x
      0086C5 90 89            [ 2]  761 	pushw	y
      0086C7 97               [ 1]  762 	ld	xl, a
      0086C8 CD 85 01         [ 4]  763 	call	_convert_int_to_binary
                                    764 ;	main.c: 238: uart_write("\nSR1 -> ");
      0086CB AE 80 3C         [ 2]  765 	ldw	x, #(___str_1+0)
      0086CE CD 83 E2         [ 4]  766 	call	_uart_write
                                    767 ;	main.c: 239: uart_write(rx_binary_chars);
      0086D1 96               [ 1]  768 	ldw	x, sp
      0086D2 5C               [ 1]  769 	incw	x
      0086D3 CD 83 E2         [ 4]  770 	call	_uart_write
                                    771 ;	main.c: 240: uart_write(" <-\n");
      0086D6 AE 80 45         [ 2]  772 	ldw	x, #(___str_2+0)
      0086D9 CD 83 E2         [ 4]  773 	call	_uart_write
                                    774 ;	main.c: 241: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0086DC 96               [ 1]  775 	ldw	x, sp
      0086DD 5C               [ 1]  776 	incw	x
      0086DE 51               [ 1]  777 	exgw	x, y
      0086DF C6 52 18         [ 1]  778 	ld	a, 0x5218
      0086E2 5F               [ 1]  779 	clrw	x
      0086E3 90 89            [ 2]  780 	pushw	y
      0086E5 97               [ 1]  781 	ld	xl, a
      0086E6 CD 85 01         [ 4]  782 	call	_convert_int_to_binary
                                    783 ;	main.c: 242: uart_write("SR2 -> ");
      0086E9 AE 80 4A         [ 2]  784 	ldw	x, #(___str_3+0)
      0086EC CD 83 E2         [ 4]  785 	call	_uart_write
                                    786 ;	main.c: 243: uart_write(rx_binary_chars);
      0086EF 96               [ 1]  787 	ldw	x, sp
      0086F0 5C               [ 1]  788 	incw	x
      0086F1 CD 83 E2         [ 4]  789 	call	_uart_write
                                    790 ;	main.c: 244: uart_write(" <-\n");
      0086F4 AE 80 45         [ 2]  791 	ldw	x, #(___str_2+0)
      0086F7 CD 83 E2         [ 4]  792 	call	_uart_write
                                    793 ;	main.c: 245: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0086FA 96               [ 1]  794 	ldw	x, sp
      0086FB 5C               [ 1]  795 	incw	x
      0086FC 51               [ 1]  796 	exgw	x, y
      0086FD C6 52 19         [ 1]  797 	ld	a, 0x5219
      008700 5F               [ 1]  798 	clrw	x
      008701 90 89            [ 2]  799 	pushw	y
      008703 97               [ 1]  800 	ld	xl, a
      008704 CD 85 01         [ 4]  801 	call	_convert_int_to_binary
                                    802 ;	main.c: 246: uart_write("SR3 -> ");
      008707 AE 80 52         [ 2]  803 	ldw	x, #(___str_4+0)
      00870A CD 83 E2         [ 4]  804 	call	_uart_write
                                    805 ;	main.c: 247: uart_write(rx_binary_chars);
      00870D 96               [ 1]  806 	ldw	x, sp
      00870E 5C               [ 1]  807 	incw	x
      00870F CD 83 E2         [ 4]  808 	call	_uart_write
                                    809 ;	main.c: 248: uart_write(" <-\n");
      008712 AE 80 45         [ 2]  810 	ldw	x, #(___str_2+0)
      008715 CD 83 E2         [ 4]  811 	call	_uart_write
                                    812 ;	main.c: 249: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      008718 96               [ 1]  813 	ldw	x, sp
      008719 5C               [ 1]  814 	incw	x
      00871A 51               [ 1]  815 	exgw	x, y
      00871B C6 52 10         [ 1]  816 	ld	a, 0x5210
      00871E 5F               [ 1]  817 	clrw	x
      00871F 90 89            [ 2]  818 	pushw	y
      008721 97               [ 1]  819 	ld	xl, a
      008722 CD 85 01         [ 4]  820 	call	_convert_int_to_binary
                                    821 ;	main.c: 250: uart_write("CR1 -> ");
      008725 AE 80 5A         [ 2]  822 	ldw	x, #(___str_5+0)
      008728 CD 83 E2         [ 4]  823 	call	_uart_write
                                    824 ;	main.c: 251: uart_write(rx_binary_chars);
      00872B 96               [ 1]  825 	ldw	x, sp
      00872C 5C               [ 1]  826 	incw	x
      00872D CD 83 E2         [ 4]  827 	call	_uart_write
                                    828 ;	main.c: 252: uart_write(" <-\n");
      008730 AE 80 45         [ 2]  829 	ldw	x, #(___str_2+0)
      008733 CD 83 E2         [ 4]  830 	call	_uart_write
                                    831 ;	main.c: 253: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008736 96               [ 1]  832 	ldw	x, sp
      008737 5C               [ 1]  833 	incw	x
      008738 51               [ 1]  834 	exgw	x, y
      008739 C6 52 11         [ 1]  835 	ld	a, 0x5211
      00873C 5F               [ 1]  836 	clrw	x
      00873D 90 89            [ 2]  837 	pushw	y
      00873F 97               [ 1]  838 	ld	xl, a
      008740 CD 85 01         [ 4]  839 	call	_convert_int_to_binary
                                    840 ;	main.c: 254: uart_write("CR2 -> ");
      008743 AE 80 62         [ 2]  841 	ldw	x, #(___str_6+0)
      008746 CD 83 E2         [ 4]  842 	call	_uart_write
                                    843 ;	main.c: 255: uart_write(rx_binary_chars);
      008749 96               [ 1]  844 	ldw	x, sp
      00874A 5C               [ 1]  845 	incw	x
      00874B CD 83 E2         [ 4]  846 	call	_uart_write
                                    847 ;	main.c: 256: uart_write(" <-\n");
      00874E AE 80 45         [ 2]  848 	ldw	x, #(___str_2+0)
      008751 CD 83 E2         [ 4]  849 	call	_uart_write
                                    850 ;	main.c: 257: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008754 96               [ 1]  851 	ldw	x, sp
      008755 5C               [ 1]  852 	incw	x
      008756 51               [ 1]  853 	exgw	x, y
      008757 C6 52 16         [ 1]  854 	ld	a, 0x5216
      00875A 5F               [ 1]  855 	clrw	x
      00875B 90 89            [ 2]  856 	pushw	y
      00875D 97               [ 1]  857 	ld	xl, a
      00875E CD 85 01         [ 4]  858 	call	_convert_int_to_binary
                                    859 ;	main.c: 258: uart_write("DR -> ");
      008761 AE 80 6A         [ 2]  860 	ldw	x, #(___str_7+0)
      008764 CD 83 E2         [ 4]  861 	call	_uart_write
                                    862 ;	main.c: 259: uart_write(rx_binary_chars);
      008767 96               [ 1]  863 	ldw	x, sp
      008768 5C               [ 1]  864 	incw	x
      008769 CD 83 E2         [ 4]  865 	call	_uart_write
                                    866 ;	main.c: 260: uart_write(" <-\n");
      00876C AE 80 45         [ 2]  867 	ldw	x, #(___str_2+0)
      00876F CD 83 E2         [ 4]  868 	call	_uart_write
                                    869 ;	main.c: 306: }
      008772 5B 09            [ 2]  870 	addw	sp, #9
      008774 81               [ 4]  871 	ret
                                    872 ;	main.c: 308: void uart_init(void){
                                    873 ;	-----------------------------------------
                                    874 ;	 function uart_init
                                    875 ;	-----------------------------------------
      008775                        876 _uart_init:
                                    877 ;	main.c: 309: CLK_CKDIVR = 0;
      008775 35 00 50 C6      [ 1]  878 	mov	0x50c6+0, #0x00
                                    879 ;	main.c: 312: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008779 72 16 52 35      [ 1]  880 	bset	0x5235, #3
                                    881 ;	main.c: 313: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      00877D 72 14 52 35      [ 1]  882 	bset	0x5235, #2
                                    883 ;	main.c: 314: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008781 C6 52 36         [ 1]  884 	ld	a, 0x5236
      008784 A4 CF            [ 1]  885 	and	a, #0xcf
      008786 C7 52 36         [ 1]  886 	ld	0x5236, a
                                    887 ;	main.c: 316: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008789 35 03 52 33      [ 1]  888 	mov	0x5233+0, #0x03
      00878D 35 68 52 32      [ 1]  889 	mov	0x5232+0, #0x68
                                    890 ;	main.c: 317: }
      008791 81               [ 4]  891 	ret
                                    892 ;	main.c: 321: void i2c_init(void) {
                                    893 ;	-----------------------------------------
                                    894 ;	 function i2c_init
                                    895 ;	-----------------------------------------
      008792                        896 _i2c_init:
                                    897 ;	main.c: 327: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008792 72 11 52 10      [ 1]  898 	bres	0x5210, #0
                                    899 ;	main.c: 328: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008796 35 10 52 12      [ 1]  900 	mov	0x5212+0, #0x10
                                    901 ;	main.c: 329: I2C_CCRH = 0;                   // =0
      00879A 35 00 52 1C      [ 1]  902 	mov	0x521c+0, #0x00
                                    903 ;	main.c: 330: I2C_CCRL = 80;                  // 100kHz for I2C
      00879E 35 50 52 1B      [ 1]  904 	mov	0x521b+0, #0x50
                                    905 ;	main.c: 331: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0087A2 72 1F 52 1C      [ 1]  906 	bres	0x521c, #7
                                    907 ;	main.c: 332: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0087A6 72 1F 52 14      [ 1]  908 	bres	0x5214, #7
                                    909 ;	main.c: 333: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0087AA 72 1C 52 14      [ 1]  910 	bset	0x5214, #6
                                    911 ;	main.c: 334: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0087AE 72 10 52 10      [ 1]  912 	bset	0x5210, #0
                                    913 ;	main.c: 335: }
      0087B2 81               [ 4]  914 	ret
                                    915 ;	main.c: 344: void i2c_start(void) {
                                    916 ;	-----------------------------------------
                                    917 ;	 function i2c_start
                                    918 ;	-----------------------------------------
      0087B3                        919 _i2c_start:
                                    920 ;	main.c: 345: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0087B3 72 10 52 11      [ 1]  921 	bset	0x5211, #0
                                    922 ;	main.c: 346: while(!(I2C_SR1 & (1 << 0)));
      0087B7                        923 00101$:
      0087B7 72 01 52 17 FB   [ 2]  924 	btjf	0x5217, #0, 00101$
                                    925 ;	main.c: 348: }
      0087BC 81               [ 4]  926 	ret
                                    927 ;	main.c: 350: void i2c_send_address(uint8_t address) {
                                    928 ;	-----------------------------------------
                                    929 ;	 function i2c_send_address
                                    930 ;	-----------------------------------------
      0087BD                        931 _i2c_send_address:
                                    932 ;	main.c: 351: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0087BD 48               [ 1]  933 	sll	a
      0087BE C7 52 16         [ 1]  934 	ld	0x5216, a
                                    935 ;	main.c: 352: reg_check();
      0087C1 CD 86 69         [ 4]  936 	call	_reg_check
                                    937 ;	main.c: 353: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0087C4                        938 00102$:
      0087C4 72 03 52 17 01   [ 2]  939 	btjf	0x5217, #1, 00121$
      0087C9 81               [ 4]  940 	ret
      0087CA                        941 00121$:
      0087CA 72 05 52 18 F5   [ 2]  942 	btjf	0x5218, #2, 00102$
                                    943 ;	main.c: 355: }
      0087CF 81               [ 4]  944 	ret
                                    945 ;	main.c: 357: void i2c_stop(void) {
                                    946 ;	-----------------------------------------
                                    947 ;	 function i2c_stop
                                    948 ;	-----------------------------------------
      0087D0                        949 _i2c_stop:
                                    950 ;	main.c: 358: I2C_CR2 = I2C_CR2 | (1 << 1);// Отправка стопового сигнала
      0087D0 72 12 52 11      [ 1]  951 	bset	0x5211, #1
                                    952 ;	main.c: 360: }
      0087D4 81               [ 4]  953 	ret
                                    954 ;	main.c: 361: void i2c_write(void){
                                    955 ;	-----------------------------------------
                                    956 ;	 function i2c_write
                                    957 ;	-----------------------------------------
      0087D5                        958 _i2c_write:
      0087D5 52 02            [ 2]  959 	sub	sp, #2
                                    960 ;	main.c: 368: for(int i = 0;i < d_size;i++)
      0087D7 5F               [ 1]  961 	clrw	x
      0087D8                        962 00108$:
      0087D8 C6 02 06         [ 1]  963 	ld	a, _d_size+0
      0087DB 6B 02            [ 1]  964 	ld	(0x02, sp), a
      0087DD 0F 01            [ 1]  965 	clr	(0x01, sp)
      0087DF 13 01            [ 2]  966 	cpw	x, (0x01, sp)
      0087E1 2E 25            [ 1]  967 	jrsge	00110$
                                    968 ;	main.c: 370: I2C_DR = data_buf[i];
      0087E3 90 93            [ 1]  969 	ldw	y, x
      0087E5 90 D6 02 08      [ 1]  970 	ld	a, (_data_buf+0, y)
      0087E9 C7 52 16         [ 1]  971 	ld	0x5216, a
                                    972 ;	main.c: 371: reg_check();
      0087EC 89               [ 2]  973 	pushw	x
      0087ED CD 86 69         [ 4]  974 	call	_reg_check
      0087F0 85               [ 2]  975 	popw	x
                                    976 ;	main.c: 372: while (!(I2C_SR1 & (1 << 7)) && I2C_SR2 & (1 << 2) && !(I2C_SR1 & (1 << 2)));
      0087F1                        977 00103$:
      0087F1 C6 52 17         [ 1]  978 	ld	a, 0x5217
      0087F4 2B 0A            [ 1]  979 	jrmi	00105$
      0087F6 72 05 52 18 05   [ 2]  980 	btjf	0x5218, #2, 00105$
      0087FB 72 05 52 17 F1   [ 2]  981 	btjf	0x5217, #2, 00103$
      008800                        982 00105$:
                                    983 ;	main.c: 373: reg_check();
      008800 89               [ 2]  984 	pushw	x
      008801 CD 86 69         [ 4]  985 	call	_reg_check
      008804 85               [ 2]  986 	popw	x
                                    987 ;	main.c: 368: for(int i = 0;i < d_size;i++)
      008805 5C               [ 1]  988 	incw	x
      008806 20 D0            [ 2]  989 	jra	00108$
      008808                        990 00110$:
                                    991 ;	main.c: 375: }
      008808 5B 02            [ 2]  992 	addw	sp, #2
      00880A 81               [ 4]  993 	ret
                                    994 ;	main.c: 377: void i2c_read(void){
                                    995 ;	-----------------------------------------
                                    996 ;	 function i2c_read
                                    997 ;	-----------------------------------------
      00880B                        998 _i2c_read:
      00880B 52 02            [ 2]  999 	sub	sp, #2
                                   1000 ;	main.c: 378: I2C_CR2 = I2C_CR2 | (1 << 2);
      00880D 72 14 52 11      [ 1] 1001 	bset	0x5211, #2
                                   1002 ;	main.c: 379: I2C_DR = 0;
      008811 35 00 52 16      [ 1] 1003 	mov	0x5216+0, #0x00
                                   1004 ;	main.c: 380: reg_check();
      008815 CD 86 69         [ 4] 1005 	call	_reg_check
                                   1006 ;	main.c: 381: I2C_DR = d_addr;
      008818 55 02 04 52 16   [ 1] 1007 	mov	0x5216+0, _d_addr+0
                                   1008 ;	main.c: 382: reg_check();
      00881D CD 86 69         [ 4] 1009 	call	_reg_check
                                   1010 ;	main.c: 383: while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
      008820                       1011 00103$:
      008820 C6 52 17         [ 1] 1012 	ld	a, 0x5217
      008823 2B 0A            [ 1] 1013 	jrmi	00105$
      008825 72 05 52 18 05   [ 2] 1014 	btjf	0x5218, #2, 00105$
      00882A 72 05 52 17 F1   [ 2] 1015 	btjf	0x5217, #2, 00103$
      00882F                       1016 00105$:
                                   1017 ;	main.c: 386: i2c_start();
      00882F CD 87 B3         [ 4] 1018 	call	_i2c_start
                                   1019 ;	main.c: 387: I2C_DR = (current_dev << 1) | (1 << 0);
      008832 C6 03 08         [ 1] 1020 	ld	a, _current_dev+0
      008835 48               [ 1] 1021 	sll	a
      008836 AA 01            [ 1] 1022 	or	a, #0x01
      008838 C7 52 16         [ 1] 1023 	ld	0x5216, a
                                   1024 ;	main.c: 388: reg_check();
      00883B CD 86 69         [ 4] 1025 	call	_reg_check
                                   1026 ;	main.c: 389: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR1 & (1 << 2)) && !(I2C_SR1 & (1 << 6)));
      00883E                       1027 00108$:
      00883E 72 02 52 17 0A   [ 2] 1028 	btjt	0x5217, #1, 00110$
      008843 72 04 52 17 05   [ 2] 1029 	btjt	0x5217, #2, 00110$
      008848 72 0D 52 17 F1   [ 2] 1030 	btjf	0x5217, #6, 00108$
      00884D                       1031 00110$:
                                   1032 ;	main.c: 390: reg_check();
      00884D CD 86 69         [ 4] 1033 	call	_reg_check
                                   1034 ;	main.c: 391: for(int i = 0;i < d_size;i++)
      008850 5F               [ 1] 1035 	clrw	x
      008851                       1036 00116$:
      008851 C6 02 06         [ 1] 1037 	ld	a, _d_size+0
      008854 6B 02            [ 1] 1038 	ld	(0x02, sp), a
      008856 0F 01            [ 1] 1039 	clr	(0x01, sp)
      008858 13 01            [ 2] 1040 	cpw	x, (0x01, sp)
      00885A 2E 13            [ 1] 1041 	jrsge	00114$
                                   1042 ;	main.c: 393: data_buf[i] = I2C_DR;
      00885C 90 93            [ 1] 1043 	ldw	y, x
      00885E 72 A9 02 08      [ 2] 1044 	addw	y, #(_data_buf+0)
      008862 C6 52 16         [ 1] 1045 	ld	a, 0x5216
      008865 90 F7            [ 1] 1046 	ld	(y), a
                                   1047 ;	main.c: 394: while (!(I2C_SR1 & (1 << 6)));
      008867                       1048 00111$:
      008867 72 0D 52 17 FB   [ 2] 1049 	btjf	0x5217, #6, 00111$
                                   1050 ;	main.c: 391: for(int i = 0;i < d_size;i++)
      00886C 5C               [ 1] 1051 	incw	x
      00886D 20 E2            [ 2] 1052 	jra	00116$
      00886F                       1053 00114$:
                                   1054 ;	main.c: 396: reg_check();
      00886F CD 86 69         [ 4] 1055 	call	_reg_check
                                   1056 ;	main.c: 397: I2C_CR2 = I2C_CR2 & ~(1 << 2);
      008872 C6 52 11         [ 1] 1057 	ld	a, 0x5211
      008875 A4 FB            [ 1] 1058 	and	a, #0xfb
      008877 C7 52 11         [ 1] 1059 	ld	0x5211, a
                                   1060 ;	main.c: 398: reg_check();
      00887A 5B 02            [ 2] 1061 	addw	sp, #2
                                   1062 ;	main.c: 399: }
      00887C CC 86 69         [ 2] 1063 	jp	_reg_check
                                   1064 ;	main.c: 400: void i2c_scan(void) {
                                   1065 ;	-----------------------------------------
                                   1066 ;	 function i2c_scan
                                   1067 ;	-----------------------------------------
      00887F                       1068 _i2c_scan:
      00887F 52 02            [ 2] 1069 	sub	sp, #2
                                   1070 ;	main.c: 401: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008881 C6 03 08         [ 1] 1071 	ld	a, _current_dev+0
      008884 6B 01            [ 1] 1072 	ld	(0x01, sp), a
      008886 6B 02            [ 1] 1073 	ld	(0x02, sp), a
      008888                       1074 00105$:
      008888 7B 02            [ 1] 1075 	ld	a, (0x02, sp)
      00888A A1 7F            [ 1] 1076 	cp	a, #0x7f
      00888C 24 26            [ 1] 1077 	jrnc	00107$
                                   1078 ;	main.c: 402: i2c_start();
      00888E CD 87 B3         [ 4] 1079 	call	_i2c_start
                                   1080 ;	main.c: 403: i2c_send_address(addr);
      008891 7B 02            [ 1] 1081 	ld	a, (0x02, sp)
      008893 CD 87 BD         [ 4] 1082 	call	_i2c_send_address
                                   1083 ;	main.c: 404: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      008896 72 04 52 18 0A   [ 2] 1084 	btjt	0x5218, #2, 00102$
                                   1085 ;	main.c: 406: current_dev = addr;
      00889B 7B 01            [ 1] 1086 	ld	a, (0x01, sp)
      00889D C7 03 08         [ 1] 1087 	ld	_current_dev+0, a
                                   1088 ;	main.c: 407: i2c_stop();
      0088A0 5B 02            [ 2] 1089 	addw	sp, #2
                                   1090 ;	main.c: 408: break;
      0088A2 CC 87 D0         [ 2] 1091 	jp	_i2c_stop
      0088A5                       1092 00102$:
                                   1093 ;	main.c: 410: i2c_stop();
      0088A5 CD 87 D0         [ 4] 1094 	call	_i2c_stop
                                   1095 ;	main.c: 411: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      0088A8 72 15 52 18      [ 1] 1096 	bres	0x5218, #2
                                   1097 ;	main.c: 401: for (uint8_t addr = current_dev; addr < 127; addr++) {
      0088AC 0C 02            [ 1] 1098 	inc	(0x02, sp)
      0088AE 7B 02            [ 1] 1099 	ld	a, (0x02, sp)
      0088B0 6B 01            [ 1] 1100 	ld	(0x01, sp), a
      0088B2 20 D4            [ 2] 1101 	jra	00105$
      0088B4                       1102 00107$:
                                   1103 ;	main.c: 413: }
      0088B4 5B 02            [ 2] 1104 	addw	sp, #2
      0088B6 81               [ 4] 1105 	ret
                                   1106 ;	main.c: 423: void cm_SM(void)
                                   1107 ;	-----------------------------------------
                                   1108 ;	 function cm_SM
                                   1109 ;	-----------------------------------------
      0088B7                       1110 _cm_SM:
      0088B7 52 04            [ 2] 1111 	sub	sp, #4
                                   1112 ;	main.c: 425: char cur_dev[4]={0};
      0088B9 0F 01            [ 1] 1113 	clr	(0x01, sp)
      0088BB 0F 02            [ 1] 1114 	clr	(0x02, sp)
      0088BD 0F 03            [ 1] 1115 	clr	(0x03, sp)
      0088BF 0F 04            [ 1] 1116 	clr	(0x04, sp)
                                   1117 ;	main.c: 426: convert_int_to_chars(current_dev, cur_dev);
      0088C1 96               [ 1] 1118 	ldw	x, sp
      0088C2 5C               [ 1] 1119 	incw	x
      0088C3 C6 03 08         [ 1] 1120 	ld	a, _current_dev+0
      0088C6 CD 84 55         [ 4] 1121 	call	_convert_int_to_chars
                                   1122 ;	main.c: 427: uart_write("SM ");
      0088C9 AE 80 71         [ 2] 1123 	ldw	x, #(___str_8+0)
      0088CC CD 83 E2         [ 4] 1124 	call	_uart_write
                                   1125 ;	main.c: 428: uart_write(cur_dev);
      0088CF 96               [ 1] 1126 	ldw	x, sp
      0088D0 5C               [ 1] 1127 	incw	x
      0088D1 CD 83 E2         [ 4] 1128 	call	_uart_write
                                   1129 ;	main.c: 429: uart_write("\r\n");
      0088D4 AE 80 75         [ 2] 1130 	ldw	x, #(___str_9+0)
      0088D7 CD 83 E2         [ 4] 1131 	call	_uart_write
                                   1132 ;	main.c: 430: }
      0088DA 5B 04            [ 2] 1133 	addw	sp, #4
      0088DC 81               [ 4] 1134 	ret
                                   1135 ;	main.c: 431: void cm_SN(void)
                                   1136 ;	-----------------------------------------
                                   1137 ;	 function cm_SN
                                   1138 ;	-----------------------------------------
      0088DD                       1139 _cm_SN:
                                   1140 ;	main.c: 433: i2c_scan();
      0088DD CD 88 7F         [ 4] 1141 	call	_i2c_scan
                                   1142 ;	main.c: 434: cm_SM();
                                   1143 ;	main.c: 435: }
      0088E0 CC 88 B7         [ 2] 1144 	jp	_cm_SM
                                   1145 ;	main.c: 436: void cm_RM(void)
                                   1146 ;	-----------------------------------------
                                   1147 ;	 function cm_RM
                                   1148 ;	-----------------------------------------
      0088E3                       1149 _cm_RM:
                                   1150 ;	main.c: 438: current_dev = 0;
      0088E3 72 5F 03 08      [ 1] 1151 	clr	_current_dev+0
                                   1152 ;	main.c: 439: uart_write("RM\n");
      0088E7 AE 80 78         [ 2] 1153 	ldw	x, #(___str_10+0)
                                   1154 ;	main.c: 440: }
      0088EA CC 83 E2         [ 2] 1155 	jp	_uart_write
                                   1156 ;	main.c: 442: void cm_DB(void)
                                   1157 ;	-----------------------------------------
                                   1158 ;	 function cm_DB
                                   1159 ;	-----------------------------------------
      0088ED                       1160 _cm_DB:
                                   1161 ;	main.c: 444: status_check();
                                   1162 ;	main.c: 445: }
      0088ED CC 86 A4         [ 2] 1163 	jp	_status_check
                                   1164 ;	main.c: 447: void cm_ST(void)
                                   1165 ;	-----------------------------------------
                                   1166 ;	 function cm_ST
                                   1167 ;	-----------------------------------------
      0088F0                       1168 _cm_ST:
                                   1169 ;	main.c: 449: get_addr_from_buff();
      0088F0 CD 85 39         [ 4] 1170 	call	_get_addr_from_buff
                                   1171 ;	main.c: 450: current_dev = d_addr;
      0088F3 55 02 04 03 08   [ 1] 1172 	mov	_current_dev+0, _d_addr+0
                                   1173 ;	main.c: 451: uart_write("ST\n");
      0088F8 AE 80 7C         [ 2] 1174 	ldw	x, #(___str_11+0)
                                   1175 ;	main.c: 452: }
      0088FB CC 83 E2         [ 2] 1176 	jp	_uart_write
                                   1177 ;	main.c: 453: void cm_SR(void)
                                   1178 ;	-----------------------------------------
                                   1179 ;	 function cm_SR
                                   1180 ;	-----------------------------------------
      0088FE                       1181 _cm_SR:
      0088FE 52 04            [ 2] 1182 	sub	sp, #4
                                   1183 ;	main.c: 455: i2c_start();
      008900 CD 87 B3         [ 4] 1184 	call	_i2c_start
                                   1185 ;	main.c: 456: i2c_send_address(current_dev);
      008903 C6 03 08         [ 1] 1186 	ld	a, _current_dev+0
      008906 CD 87 BD         [ 4] 1187 	call	_i2c_send_address
                                   1188 ;	main.c: 457: i2c_read();
      008909 CD 88 0B         [ 4] 1189 	call	_i2c_read
                                   1190 ;	main.c: 458: i2c_stop();
      00890C CD 87 D0         [ 4] 1191 	call	_i2c_stop
                                   1192 ;	main.c: 459: uart_write("SR ");
      00890F AE 80 80         [ 2] 1193 	ldw	x, #(___str_12+0)
      008912 CD 83 E2         [ 4] 1194 	call	_uart_write
                                   1195 ;	main.c: 460: convert_int_to_chars(d_addr, a);
      008915 AE 02 01         [ 2] 1196 	ldw	x, #(_a+0)
      008918 C6 02 04         [ 1] 1197 	ld	a, _d_addr+0
      00891B CD 84 55         [ 4] 1198 	call	_convert_int_to_chars
                                   1199 ;	main.c: 461: uart_write(a);
      00891E AE 02 01         [ 2] 1200 	ldw	x, #(_a+0)
      008921 CD 83 E2         [ 4] 1201 	call	_uart_write
                                   1202 ;	main.c: 462: uart_write(" ");
      008924 AE 80 84         [ 2] 1203 	ldw	x, #(___str_13+0)
      008927 CD 83 E2         [ 4] 1204 	call	_uart_write
                                   1205 ;	main.c: 463: convert_int_to_chars(d_size, a);
      00892A AE 02 01         [ 2] 1206 	ldw	x, #(_a+0)
      00892D C6 02 06         [ 1] 1207 	ld	a, _d_size+0
      008930 CD 84 55         [ 4] 1208 	call	_convert_int_to_chars
                                   1209 ;	main.c: 464: uart_write(a);
      008933 AE 02 01         [ 2] 1210 	ldw	x, #(_a+0)
      008936 CD 83 E2         [ 4] 1211 	call	_uart_write
                                   1212 ;	main.c: 465: for(int i = 0;i < d_size;i++)
      008939 5F               [ 1] 1213 	clrw	x
      00893A 1F 03            [ 2] 1214 	ldw	(0x03, sp), x
      00893C                       1215 00103$:
      00893C C6 02 06         [ 1] 1216 	ld	a, _d_size+0
      00893F 6B 02            [ 1] 1217 	ld	(0x02, sp), a
      008941 0F 01            [ 1] 1218 	clr	(0x01, sp)
      008943 1E 03            [ 2] 1219 	ldw	x, (0x03, sp)
      008945 13 01            [ 2] 1220 	cpw	x, (0x01, sp)
      008947 2E 1E            [ 1] 1221 	jrsge	00101$
                                   1222 ;	main.c: 467: uart_write(" ");
      008949 AE 80 84         [ 2] 1223 	ldw	x, #(___str_13+0)
      00894C CD 83 E2         [ 4] 1224 	call	_uart_write
                                   1225 ;	main.c: 468: convert_int_to_chars(data_buf[i], a);
      00894F 1E 03            [ 2] 1226 	ldw	x, (0x03, sp)
      008951 D6 02 08         [ 1] 1227 	ld	a, (_data_buf+0, x)
      008954 AE 02 01         [ 2] 1228 	ldw	x, #(_a+0)
      008957 CD 84 55         [ 4] 1229 	call	_convert_int_to_chars
                                   1230 ;	main.c: 469: uart_write(a);
      00895A AE 02 01         [ 2] 1231 	ldw	x, #(_a+0)
      00895D CD 83 E2         [ 4] 1232 	call	_uart_write
                                   1233 ;	main.c: 465: for(int i = 0;i < d_size;i++)
      008960 1E 03            [ 2] 1234 	ldw	x, (0x03, sp)
      008962 5C               [ 1] 1235 	incw	x
      008963 1F 03            [ 2] 1236 	ldw	(0x03, sp), x
      008965 20 D5            [ 2] 1237 	jra	00103$
      008967                       1238 00101$:
                                   1239 ;	main.c: 472: uart_write("\r\n");
      008967 AE 80 75         [ 2] 1240 	ldw	x, #(___str_9+0)
      00896A 5B 04            [ 2] 1241 	addw	sp, #4
                                   1242 ;	main.c: 473: }
      00896C CC 83 E2         [ 2] 1243 	jp	_uart_write
                                   1244 ;	main.c: 474: void cm_SW(void)
                                   1245 ;	-----------------------------------------
                                   1246 ;	 function cm_SW
                                   1247 ;	-----------------------------------------
      00896F                       1248 _cm_SW:
      00896F 52 04            [ 2] 1249 	sub	sp, #4
                                   1250 ;	main.c: 476: i2c_start();
      008971 CD 87 B3         [ 4] 1251 	call	_i2c_start
                                   1252 ;	main.c: 477: i2c_send_address(current_dev);
      008974 C6 03 08         [ 1] 1253 	ld	a, _current_dev+0
      008977 CD 87 BD         [ 4] 1254 	call	_i2c_send_address
                                   1255 ;	main.c: 478: i2c_write();
      00897A CD 87 D5         [ 4] 1256 	call	_i2c_write
                                   1257 ;	main.c: 479: i2c_stop();
      00897D CD 87 D0         [ 4] 1258 	call	_i2c_stop
                                   1259 ;	main.c: 480: uart_write("SW ");
      008980 AE 80 86         [ 2] 1260 	ldw	x, #(___str_14+0)
      008983 CD 83 E2         [ 4] 1261 	call	_uart_write
                                   1262 ;	main.c: 481: convert_int_to_chars(d_addr, a);
      008986 AE 02 01         [ 2] 1263 	ldw	x, #(_a+0)
      008989 C6 02 04         [ 1] 1264 	ld	a, _d_addr+0
      00898C CD 84 55         [ 4] 1265 	call	_convert_int_to_chars
                                   1266 ;	main.c: 482: uart_write(a);
      00898F AE 02 01         [ 2] 1267 	ldw	x, #(_a+0)
      008992 CD 83 E2         [ 4] 1268 	call	_uart_write
                                   1269 ;	main.c: 483: uart_write(" ");
      008995 AE 80 84         [ 2] 1270 	ldw	x, #(___str_13+0)
      008998 CD 83 E2         [ 4] 1271 	call	_uart_write
                                   1272 ;	main.c: 484: convert_int_to_chars(d_size, a);
      00899B AE 02 01         [ 2] 1273 	ldw	x, #(_a+0)
      00899E C6 02 06         [ 1] 1274 	ld	a, _d_size+0
      0089A1 CD 84 55         [ 4] 1275 	call	_convert_int_to_chars
                                   1276 ;	main.c: 485: uart_write(a);
      0089A4 AE 02 01         [ 2] 1277 	ldw	x, #(_a+0)
      0089A7 CD 83 E2         [ 4] 1278 	call	_uart_write
                                   1279 ;	main.c: 486: for(int i = 0;i < d_size;i++)
      0089AA 5F               [ 1] 1280 	clrw	x
      0089AB 1F 03            [ 2] 1281 	ldw	(0x03, sp), x
      0089AD                       1282 00103$:
      0089AD C6 02 06         [ 1] 1283 	ld	a, _d_size+0
      0089B0 6B 02            [ 1] 1284 	ld	(0x02, sp), a
      0089B2 0F 01            [ 1] 1285 	clr	(0x01, sp)
      0089B4 1E 03            [ 2] 1286 	ldw	x, (0x03, sp)
      0089B6 13 01            [ 2] 1287 	cpw	x, (0x01, sp)
      0089B8 2E 1E            [ 1] 1288 	jrsge	00101$
                                   1289 ;	main.c: 488: uart_write(" ");
      0089BA AE 80 84         [ 2] 1290 	ldw	x, #(___str_13+0)
      0089BD CD 83 E2         [ 4] 1291 	call	_uart_write
                                   1292 ;	main.c: 489: convert_int_to_chars(data_buf[i], a);
      0089C0 1E 03            [ 2] 1293 	ldw	x, (0x03, sp)
      0089C2 D6 02 08         [ 1] 1294 	ld	a, (_data_buf+0, x)
      0089C5 AE 02 01         [ 2] 1295 	ldw	x, #(_a+0)
      0089C8 CD 84 55         [ 4] 1296 	call	_convert_int_to_chars
                                   1297 ;	main.c: 490: uart_write(a);
      0089CB AE 02 01         [ 2] 1298 	ldw	x, #(_a+0)
      0089CE CD 83 E2         [ 4] 1299 	call	_uart_write
                                   1300 ;	main.c: 486: for(int i = 0;i < d_size;i++)
      0089D1 1E 03            [ 2] 1301 	ldw	x, (0x03, sp)
      0089D3 5C               [ 1] 1302 	incw	x
      0089D4 1F 03            [ 2] 1303 	ldw	(0x03, sp), x
      0089D6 20 D5            [ 2] 1304 	jra	00103$
      0089D8                       1305 00101$:
                                   1306 ;	main.c: 493: uart_write("\r\n");
      0089D8 AE 80 75         [ 2] 1307 	ldw	x, #(___str_9+0)
      0089DB 5B 04            [ 2] 1308 	addw	sp, #4
                                   1309 ;	main.c: 494: }
      0089DD CC 83 E2         [ 2] 1310 	jp	_uart_write
                                   1311 ;	main.c: 502: int data_handler(void)
                                   1312 ;	-----------------------------------------
                                   1313 ;	 function data_handler
                                   1314 ;	-----------------------------------------
      0089E0                       1315 _data_handler:
                                   1316 ;	main.c: 504: p_size = 0;
      0089E0 72 5F 02 05      [ 1] 1317 	clr	_p_size+0
                                   1318 ;	main.c: 505: p_bytes = 0;
      0089E4 72 5F 02 07      [ 1] 1319 	clr	_p_bytes+0
                                   1320 ;	main.c: 506: d_addr = 0;
      0089E8 72 5F 02 04      [ 1] 1321 	clr	_d_addr+0
                                   1322 ;	main.c: 507: d_size = 0;
      0089EC 72 5F 02 06      [ 1] 1323 	clr	_d_size+0
                                   1324 ;	main.c: 508: memset(a, 0, sizeof(a));
      0089F0 4B 03            [ 1] 1325 	push	#0x03
      0089F2 4B 00            [ 1] 1326 	push	#0x00
      0089F4 5F               [ 1] 1327 	clrw	x
      0089F5 89               [ 2] 1328 	pushw	x
      0089F6 AE 02 01         [ 2] 1329 	ldw	x, #(_a+0)
      0089F9 CD 8B BE         [ 4] 1330 	call	_memset
                                   1331 ;	main.c: 509: memset(data_buf, 0, sizeof(data_buf));
      0089FC 4B 00            [ 1] 1332 	push	#0x00
      0089FE 4B 01            [ 1] 1333 	push	#0x01
      008A00 5F               [ 1] 1334 	clrw	x
      008A01 89               [ 2] 1335 	pushw	x
      008A02 AE 02 08         [ 2] 1336 	ldw	x, #(_data_buf+0)
      008A05 CD 8B BE         [ 4] 1337 	call	_memset
                                   1338 ;	main.c: 510: if(memcmp(&buffer[0],"SM",2) == 0)
      008A08 4B 02            [ 1] 1339 	push	#0x02
      008A0A 4B 00            [ 1] 1340 	push	#0x00
      008A0C 4B 8A            [ 1] 1341 	push	#<(___str_15+0)
      008A0E 4B 80            [ 1] 1342 	push	#((___str_15+0) >> 8)
      008A10 AE 01 01         [ 2] 1343 	ldw	x, #(_buffer+0)
      008A13 CD 8B 28         [ 4] 1344 	call	_memcmp
                                   1345 ;	main.c: 511: return 1;
      008A16 5D               [ 2] 1346 	tnzw	x
      008A17 26 02            [ 1] 1347 	jrne	00102$
      008A19 5C               [ 1] 1348 	incw	x
      008A1A 81               [ 4] 1349 	ret
      008A1B                       1350 00102$:
                                   1351 ;	main.c: 512: if(memcmp(&buffer[0],"SN",2) == 0)
      008A1B 4B 02            [ 1] 1352 	push	#0x02
      008A1D 4B 00            [ 1] 1353 	push	#0x00
      008A1F 4B 8D            [ 1] 1354 	push	#<(___str_16+0)
      008A21 4B 80            [ 1] 1355 	push	#((___str_16+0) >> 8)
      008A23 AE 01 01         [ 2] 1356 	ldw	x, #(_buffer+0)
      008A26 CD 8B 28         [ 4] 1357 	call	_memcmp
      008A29 5D               [ 2] 1358 	tnzw	x
      008A2A 26 04            [ 1] 1359 	jrne	00104$
                                   1360 ;	main.c: 513: return 2;
      008A2C AE 00 02         [ 2] 1361 	ldw	x, #0x0002
      008A2F 81               [ 4] 1362 	ret
      008A30                       1363 00104$:
                                   1364 ;	main.c: 514: if(memcmp(&buffer[0],"ST",2) == 0)
      008A30 4B 02            [ 1] 1365 	push	#0x02
      008A32 4B 00            [ 1] 1366 	push	#0x00
      008A34 4B 90            [ 1] 1367 	push	#<(___str_17+0)
      008A36 4B 80            [ 1] 1368 	push	#((___str_17+0) >> 8)
      008A38 AE 01 01         [ 2] 1369 	ldw	x, #(_buffer+0)
      008A3B CD 8B 28         [ 4] 1370 	call	_memcmp
      008A3E 5D               [ 2] 1371 	tnzw	x
      008A3F 26 04            [ 1] 1372 	jrne	00106$
                                   1373 ;	main.c: 515: return 5;
      008A41 AE 00 05         [ 2] 1374 	ldw	x, #0x0005
      008A44 81               [ 4] 1375 	ret
      008A45                       1376 00106$:
                                   1377 ;	main.c: 516: if(memcmp(&buffer[0],"RM",2) == 0)
      008A45 4B 02            [ 1] 1378 	push	#0x02
      008A47 4B 00            [ 1] 1379 	push	#0x00
      008A49 4B 93            [ 1] 1380 	push	#<(___str_18+0)
      008A4B 4B 80            [ 1] 1381 	push	#((___str_18+0) >> 8)
      008A4D AE 01 01         [ 2] 1382 	ldw	x, #(_buffer+0)
      008A50 CD 8B 28         [ 4] 1383 	call	_memcmp
      008A53 5D               [ 2] 1384 	tnzw	x
      008A54 26 04            [ 1] 1385 	jrne	00108$
                                   1386 ;	main.c: 517: return 6;
      008A56 AE 00 06         [ 2] 1387 	ldw	x, #0x0006
      008A59 81               [ 4] 1388 	ret
      008A5A                       1389 00108$:
                                   1390 ;	main.c: 518: if(memcmp(&buffer[0],"DB",2) == 0)
      008A5A 4B 02            [ 1] 1391 	push	#0x02
      008A5C 4B 00            [ 1] 1392 	push	#0x00
      008A5E 4B 96            [ 1] 1393 	push	#<(___str_19+0)
      008A60 4B 80            [ 1] 1394 	push	#((___str_19+0) >> 8)
      008A62 AE 01 01         [ 2] 1395 	ldw	x, #(_buffer+0)
      008A65 CD 8B 28         [ 4] 1396 	call	_memcmp
      008A68 5D               [ 2] 1397 	tnzw	x
      008A69 26 04            [ 1] 1398 	jrne	00110$
                                   1399 ;	main.c: 519: return 7;
      008A6B AE 00 07         [ 2] 1400 	ldw	x, #0x0007
      008A6E 81               [ 4] 1401 	ret
      008A6F                       1402 00110$:
                                   1403 ;	main.c: 521: get_addr_from_buff();
      008A6F CD 85 39         [ 4] 1404 	call	_get_addr_from_buff
                                   1405 ;	main.c: 522: get_size_from_buff();
      008A72 CD 85 7E         [ 4] 1406 	call	_get_size_from_buff
                                   1407 ;	main.c: 524: if(memcmp(&buffer[0],"SR",2) == 0)
      008A75 4B 02            [ 1] 1408 	push	#0x02
      008A77 4B 00            [ 1] 1409 	push	#0x00
      008A79 4B 99            [ 1] 1410 	push	#<(___str_20+0)
      008A7B 4B 80            [ 1] 1411 	push	#((___str_20+0) >> 8)
      008A7D AE 01 01         [ 2] 1412 	ldw	x, #(_buffer+0)
      008A80 CD 8B 28         [ 4] 1413 	call	_memcmp
      008A83 5D               [ 2] 1414 	tnzw	x
      008A84 26 04            [ 1] 1415 	jrne	00112$
                                   1416 ;	main.c: 525: return 3;
      008A86 AE 00 03         [ 2] 1417 	ldw	x, #0x0003
      008A89 81               [ 4] 1418 	ret
      008A8A                       1419 00112$:
                                   1420 ;	main.c: 527: char_buffer_to_int();
      008A8A CD 85 D8         [ 4] 1421 	call	_char_buffer_to_int
                                   1422 ;	main.c: 529: if(memcmp(&buffer[0],"SW",2) == 0)
      008A8D 4B 02            [ 1] 1423 	push	#0x02
      008A8F 4B 00            [ 1] 1424 	push	#0x00
      008A91 4B 9C            [ 1] 1425 	push	#<(___str_21+0)
      008A93 4B 80            [ 1] 1426 	push	#((___str_21+0) >> 8)
      008A95 AE 01 01         [ 2] 1427 	ldw	x, #(_buffer+0)
      008A98 CD 8B 28         [ 4] 1428 	call	_memcmp
      008A9B 5D               [ 2] 1429 	tnzw	x
      008A9C 26 04            [ 1] 1430 	jrne	00114$
                                   1431 ;	main.c: 530: return 4;
      008A9E AE 00 04         [ 2] 1432 	ldw	x, #0x0004
      008AA1 81               [ 4] 1433 	ret
      008AA2                       1434 00114$:
                                   1435 ;	main.c: 531: return 0;
      008AA2 5F               [ 1] 1436 	clrw	x
                                   1437 ;	main.c: 533: }
      008AA3 81               [ 4] 1438 	ret
                                   1439 ;	main.c: 535: void command_switcher(void)
                                   1440 ;	-----------------------------------------
                                   1441 ;	 function command_switcher
                                   1442 ;	-----------------------------------------
      008AA4                       1443 _command_switcher:
      008AA4 52 04            [ 2] 1444 	sub	sp, #4
                                   1445 ;	main.c: 537: char ar[4]={0};
      008AA6 0F 01            [ 1] 1446 	clr	(0x01, sp)
      008AA8 0F 02            [ 1] 1447 	clr	(0x02, sp)
      008AAA 0F 03            [ 1] 1448 	clr	(0x03, sp)
      008AAC 0F 04            [ 1] 1449 	clr	(0x04, sp)
                                   1450 ;	main.c: 539: switch(data_handler())
      008AAE CD 89 E0         [ 4] 1451 	call	_data_handler
      008AB1 5D               [ 2] 1452 	tnzw	x
      008AB2 2B 3B            [ 1] 1453 	jrmi	00109$
      008AB4 A3 00 07         [ 2] 1454 	cpw	x, #0x0007
      008AB7 2C 36            [ 1] 1455 	jrsgt	00109$
      008AB9 58               [ 2] 1456 	sllw	x
      008ABA DE 8A BE         [ 2] 1457 	ldw	x, (#00127$, x)
      008ABD FC               [ 2] 1458 	jp	(x)
      008ABE                       1459 00127$:
      008ABE 8A EF                 1460 	.dw	#00109$
      008AC0 8A CE                 1461 	.dw	#00101$
      008AC2 8A D3                 1462 	.dw	#00102$
      008AC4 8A D8                 1463 	.dw	#00103$
      008AC6 8A DD                 1464 	.dw	#00104$
      008AC8 8A E2                 1465 	.dw	#00105$
      008ACA 8A E7                 1466 	.dw	#00106$
      008ACC 8A EC                 1467 	.dw	#00107$
                                   1468 ;	main.c: 541: case 1:
      008ACE                       1469 00101$:
                                   1470 ;	main.c: 542: cm_SM();
      008ACE CD 88 B7         [ 4] 1471 	call	_cm_SM
                                   1472 ;	main.c: 543: break;
      008AD1 20 1C            [ 2] 1473 	jra	00109$
                                   1474 ;	main.c: 544: case 2:
      008AD3                       1475 00102$:
                                   1476 ;	main.c: 545: cm_SN();
      008AD3 CD 88 DD         [ 4] 1477 	call	_cm_SN
                                   1478 ;	main.c: 546: break;
      008AD6 20 17            [ 2] 1479 	jra	00109$
                                   1480 ;	main.c: 547: case 3:
      008AD8                       1481 00103$:
                                   1482 ;	main.c: 548: cm_SR();
      008AD8 CD 88 FE         [ 4] 1483 	call	_cm_SR
                                   1484 ;	main.c: 549: break;
      008ADB 20 12            [ 2] 1485 	jra	00109$
                                   1486 ;	main.c: 550: case 4:
      008ADD                       1487 00104$:
                                   1488 ;	main.c: 551: cm_SW();
      008ADD CD 89 6F         [ 4] 1489 	call	_cm_SW
                                   1490 ;	main.c: 552: break;
      008AE0 20 0D            [ 2] 1491 	jra	00109$
                                   1492 ;	main.c: 553: case 5:
      008AE2                       1493 00105$:
                                   1494 ;	main.c: 554: cm_ST();
      008AE2 CD 88 F0         [ 4] 1495 	call	_cm_ST
                                   1496 ;	main.c: 555: break;
      008AE5 20 08            [ 2] 1497 	jra	00109$
                                   1498 ;	main.c: 556: case 6:
      008AE7                       1499 00106$:
                                   1500 ;	main.c: 557: cm_RM();
      008AE7 CD 88 E3         [ 4] 1501 	call	_cm_RM
                                   1502 ;	main.c: 558: break;
      008AEA 20 03            [ 2] 1503 	jra	00109$
                                   1504 ;	main.c: 559: case 7:
      008AEC                       1505 00107$:
                                   1506 ;	main.c: 560: cm_DB();
      008AEC CD 88 ED         [ 4] 1507 	call	_cm_DB
                                   1508 ;	main.c: 562: }
      008AEF                       1509 00109$:
                                   1510 ;	main.c: 563: }
      008AEF 5B 04            [ 2] 1511 	addw	sp, #4
      008AF1 81               [ 4] 1512 	ret
                                   1513 ;	main.c: 566: void main(void)
                                   1514 ;	-----------------------------------------
                                   1515 ;	 function main
                                   1516 ;	-----------------------------------------
      008AF2                       1517 _main:
                                   1518 ;	main.c: 568: uart_init();
      008AF2 CD 87 75         [ 4] 1519 	call	_uart_init
                                   1520 ;	main.c: 569: i2c_init();
      008AF5 CD 87 92         [ 4] 1521 	call	_i2c_init
                                   1522 ;	main.c: 570: uart_write("SS\n");
      008AF8 AE 80 9F         [ 2] 1523 	ldw	x, #(___str_22+0)
      008AFB CD 83 E2         [ 4] 1524 	call	_uart_write
                                   1525 ;	main.c: 571: current_dev = 0x3C;
      008AFE 35 3C 03 08      [ 1] 1526 	mov	_current_dev+0, #0x3c
                                   1527 ;	main.c: 572: d_addr = 0x55;
      008B02 35 55 02 04      [ 1] 1528 	mov	_d_addr+0, #0x55
                                   1529 ;	main.c: 573: d_size = 3;
      008B06 35 03 02 06      [ 1] 1530 	mov	_d_size+0, #0x03
                                   1531 ;	main.c: 574: data_buf[0] = 1;
      008B0A 35 01 02 08      [ 1] 1532 	mov	_data_buf+0, #0x01
                                   1533 ;	main.c: 575: data_buf[1] = 2;
      008B0E 35 02 02 09      [ 1] 1534 	mov	_data_buf+1, #0x02
                                   1535 ;	main.c: 576: data_buf[2] = 3;
      008B12 35 03 02 0A      [ 1] 1536 	mov	_data_buf+2, #0x03
                                   1537 ;	main.c: 577: cm_SW();
      008B16 CD 89 6F         [ 4] 1538 	call	_cm_SW
                                   1539 ;	main.c: 578: cm_SW();
      008B19 CD 89 6F         [ 4] 1540 	call	_cm_SW
                                   1541 ;	main.c: 579: cm_SW();
      008B1C CD 89 6F         [ 4] 1542 	call	_cm_SW
                                   1543 ;	main.c: 581: while(1)
      008B1F                       1544 00102$:
                                   1545 ;	main.c: 583: uart_read();
      008B1F CD 84 16         [ 4] 1546 	call	_uart_read
                                   1547 ;	main.c: 584: command_switcher();
      008B22 CD 8A A4         [ 4] 1548 	call	_command_switcher
      008B25 20 F8            [ 2] 1549 	jra	00102$
                                   1550 ;	main.c: 586: }
      008B27 81               [ 4] 1551 	ret
                                   1552 	.area CODE
                                   1553 	.area CONST
                                   1554 	.area CONST
      00802D                       1555 ___str_0:
      00802D 0A                    1556 	.db 0x0a
      00802E 49 32 43 5F 52 45 47  1557 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                    1558 	.db 0x0a
      00803B 00                    1559 	.db 0x00
                                   1560 	.area CODE
                                   1561 	.area CONST
      00803C                       1562 ___str_1:
      00803C 0A                    1563 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20  1564 	.ascii "SR1 -> "
      008044 00                    1565 	.db 0x00
                                   1566 	.area CODE
                                   1567 	.area CONST
      008045                       1568 ___str_2:
      008045 20 3C 2D              1569 	.ascii " <-"
      008048 0A                    1570 	.db 0x0a
      008049 00                    1571 	.db 0x00
                                   1572 	.area CODE
                                   1573 	.area CONST
      00804A                       1574 ___str_3:
      00804A 53 52 32 20 2D 3E 20  1575 	.ascii "SR2 -> "
      008051 00                    1576 	.db 0x00
                                   1577 	.area CODE
                                   1578 	.area CONST
      008052                       1579 ___str_4:
      008052 53 52 33 20 2D 3E 20  1580 	.ascii "SR3 -> "
      008059 00                    1581 	.db 0x00
                                   1582 	.area CODE
                                   1583 	.area CONST
      00805A                       1584 ___str_5:
      00805A 43 52 31 20 2D 3E 20  1585 	.ascii "CR1 -> "
      008061 00                    1586 	.db 0x00
                                   1587 	.area CODE
                                   1588 	.area CONST
      008062                       1589 ___str_6:
      008062 43 52 32 20 2D 3E 20  1590 	.ascii "CR2 -> "
      008069 00                    1591 	.db 0x00
                                   1592 	.area CODE
                                   1593 	.area CONST
      00806A                       1594 ___str_7:
      00806A 44 52 20 2D 3E 20     1595 	.ascii "DR -> "
      008070 00                    1596 	.db 0x00
                                   1597 	.area CODE
                                   1598 	.area CONST
      008071                       1599 ___str_8:
      008071 53 4D 20              1600 	.ascii "SM "
      008074 00                    1601 	.db 0x00
                                   1602 	.area CODE
                                   1603 	.area CONST
      008075                       1604 ___str_9:
      008075 0D                    1605 	.db 0x0d
      008076 0A                    1606 	.db 0x0a
      008077 00                    1607 	.db 0x00
                                   1608 	.area CODE
                                   1609 	.area CONST
      008078                       1610 ___str_10:
      008078 52 4D                 1611 	.ascii "RM"
      00807A 0A                    1612 	.db 0x0a
      00807B 00                    1613 	.db 0x00
                                   1614 	.area CODE
                                   1615 	.area CONST
      00807C                       1616 ___str_11:
      00807C 53 54                 1617 	.ascii "ST"
      00807E 0A                    1618 	.db 0x0a
      00807F 00                    1619 	.db 0x00
                                   1620 	.area CODE
                                   1621 	.area CONST
      008080                       1622 ___str_12:
      008080 53 52 20              1623 	.ascii "SR "
      008083 00                    1624 	.db 0x00
                                   1625 	.area CODE
                                   1626 	.area CONST
      008084                       1627 ___str_13:
      008084 20                    1628 	.ascii " "
      008085 00                    1629 	.db 0x00
                                   1630 	.area CODE
                                   1631 	.area CONST
      008086                       1632 ___str_14:
      008086 53 57 20              1633 	.ascii "SW "
      008089 00                    1634 	.db 0x00
                                   1635 	.area CODE
                                   1636 	.area CONST
      00808A                       1637 ___str_15:
      00808A 53 4D                 1638 	.ascii "SM"
      00808C 00                    1639 	.db 0x00
                                   1640 	.area CODE
                                   1641 	.area CONST
      00808D                       1642 ___str_16:
      00808D 53 4E                 1643 	.ascii "SN"
      00808F 00                    1644 	.db 0x00
                                   1645 	.area CODE
                                   1646 	.area CONST
      008090                       1647 ___str_17:
      008090 53 54                 1648 	.ascii "ST"
      008092 00                    1649 	.db 0x00
                                   1650 	.area CODE
                                   1651 	.area CONST
      008093                       1652 ___str_18:
      008093 52 4D                 1653 	.ascii "RM"
      008095 00                    1654 	.db 0x00
                                   1655 	.area CODE
                                   1656 	.area CONST
      008096                       1657 ___str_19:
      008096 44 42                 1658 	.ascii "DB"
      008098 00                    1659 	.db 0x00
                                   1660 	.area CODE
                                   1661 	.area CONST
      008099                       1662 ___str_20:
      008099 53 52                 1663 	.ascii "SR"
      00809B 00                    1664 	.db 0x00
                                   1665 	.area CODE
                                   1666 	.area CONST
      00809C                       1667 ___str_21:
      00809C 53 57                 1668 	.ascii "SW"
      00809E 00                    1669 	.db 0x00
                                   1670 	.area CODE
                                   1671 	.area CONST
      00809F                       1672 ___str_22:
      00809F 53 53                 1673 	.ascii "SS"
      0080A1 0A                    1674 	.db 0x0a
      0080A2 00                    1675 	.db 0x00
                                   1676 	.area CODE
                                   1677 	.area INITIALIZER
      0080A3                       1678 __xinit__status_registers:
      0080A3 00                    1679 	.db #0x00	; 0
      0080A4 00                    1680 	.db 0x00
      0080A5 00                    1681 	.db 0x00
      0080A6 00                    1682 	.db 0x00
      0080A7 00                    1683 	.db 0x00
      0080A8 00                    1684 	.db 0x00
      0080A9 00                    1685 	.db 0x00
      0080AA 00                    1686 	.db 0x00
      0080AB 00                    1687 	.db 0x00
      0080AC 00                    1688 	.db 0x00
      0080AD 00                    1689 	.db 0x00
      0080AE 00                    1690 	.db 0x00
      0080AF 00                    1691 	.db 0x00
      0080B0 00                    1692 	.db 0x00
      0080B1 00                    1693 	.db 0x00
      0080B2 00                    1694 	.db 0x00
      0080B3 00                    1695 	.db 0x00
      0080B4 00                    1696 	.db 0x00
      0080B5 00                    1697 	.db 0x00
      0080B6 00                    1698 	.db 0x00
      0080B7 00                    1699 	.db 0x00
      0080B8 00                    1700 	.db 0x00
      0080B9 00                    1701 	.db 0x00
      0080BA 00                    1702 	.db 0x00
      0080BB 00                    1703 	.db 0x00
      0080BC 00                    1704 	.db 0x00
      0080BD 00                    1705 	.db 0x00
      0080BE 00                    1706 	.db 0x00
      0080BF 00                    1707 	.db 0x00
      0080C0 00                    1708 	.db 0x00
      0080C1 00                    1709 	.db 0x00
      0080C2 00                    1710 	.db 0x00
      0080C3 00                    1711 	.db 0x00
      0080C4 00                    1712 	.db 0x00
      0080C5 00                    1713 	.db 0x00
      0080C6 00                    1714 	.db 0x00
      0080C7 00                    1715 	.db 0x00
      0080C8 00                    1716 	.db 0x00
      0080C9 00                    1717 	.db 0x00
      0080CA 00                    1718 	.db 0x00
      0080CB 00                    1719 	.db 0x00
      0080CC 00                    1720 	.db 0x00
      0080CD 00                    1721 	.db 0x00
      0080CE 00                    1722 	.db 0x00
      0080CF 00                    1723 	.db 0x00
      0080D0 00                    1724 	.db 0x00
      0080D1 00                    1725 	.db 0x00
      0080D2 00                    1726 	.db 0x00
      0080D3 00                    1727 	.db 0x00
      0080D4 00                    1728 	.db 0x00
      0080D5 00                    1729 	.db 0x00
      0080D6 00                    1730 	.db 0x00
      0080D7 00                    1731 	.db 0x00
      0080D8 00                    1732 	.db 0x00
      0080D9 00                    1733 	.db 0x00
      0080DA 00                    1734 	.db 0x00
      0080DB 00                    1735 	.db 0x00
      0080DC 00                    1736 	.db 0x00
      0080DD 00                    1737 	.db 0x00
      0080DE 00                    1738 	.db 0x00
      0080DF 00                    1739 	.db 0x00
      0080E0 00                    1740 	.db 0x00
      0080E1 00                    1741 	.db 0x00
      0080E2 00                    1742 	.db 0x00
      0080E3 00                    1743 	.db 0x00
      0080E4 00                    1744 	.db 0x00
      0080E5 00                    1745 	.db 0x00
      0080E6 00                    1746 	.db 0x00
      0080E7 00                    1747 	.db 0x00
      0080E8 00                    1748 	.db 0x00
      0080E9 00                    1749 	.db 0x00
      0080EA 00                    1750 	.db 0x00
      0080EB 00                    1751 	.db 0x00
      0080EC 00                    1752 	.db 0x00
      0080ED 00                    1753 	.db 0x00
      0080EE 00                    1754 	.db 0x00
      0080EF 00                    1755 	.db 0x00
      0080F0 00                    1756 	.db 0x00
      0080F1 00                    1757 	.db 0x00
      0080F2 00                    1758 	.db 0x00
      0080F3 00                    1759 	.db 0x00
      0080F4 00                    1760 	.db 0x00
      0080F5 00                    1761 	.db 0x00
      0080F6 00                    1762 	.db 0x00
      0080F7 00                    1763 	.db 0x00
      0080F8 00                    1764 	.db 0x00
      0080F9 00                    1765 	.db 0x00
      0080FA 00                    1766 	.db 0x00
      0080FB 00                    1767 	.db 0x00
      0080FC 00                    1768 	.db 0x00
      0080FD 00                    1769 	.db 0x00
      0080FE 00                    1770 	.db 0x00
      0080FF 00                    1771 	.db 0x00
      008100 00                    1772 	.db 0x00
      008101 00                    1773 	.db 0x00
      008102 00                    1774 	.db 0x00
      008103 00                    1775 	.db 0x00
      008104 00                    1776 	.db 0x00
      008105 00                    1777 	.db 0x00
      008106 00                    1778 	.db 0x00
      008107 00                    1779 	.db 0x00
      008108 00                    1780 	.db 0x00
      008109 00                    1781 	.db 0x00
      00810A 00                    1782 	.db 0x00
      00810B 00                    1783 	.db 0x00
      00810C 00                    1784 	.db 0x00
      00810D 00                    1785 	.db 0x00
      00810E 00                    1786 	.db 0x00
      00810F 00                    1787 	.db 0x00
      008110 00                    1788 	.db 0x00
      008111 00                    1789 	.db 0x00
      008112 00                    1790 	.db 0x00
      008113 00                    1791 	.db 0x00
      008114 00                    1792 	.db 0x00
      008115 00                    1793 	.db 0x00
      008116 00                    1794 	.db 0x00
      008117 00                    1795 	.db 0x00
      008118 00                    1796 	.db 0x00
      008119 00                    1797 	.db 0x00
      00811A 00                    1798 	.db 0x00
      00811B 00                    1799 	.db 0x00
      00811C 00                    1800 	.db 0x00
      00811D 00                    1801 	.db 0x00
      00811E 00                    1802 	.db 0x00
      00811F 00                    1803 	.db 0x00
      008120 00                    1804 	.db 0x00
      008121 00                    1805 	.db 0x00
      008122 00                    1806 	.db 0x00
      008123 00                    1807 	.db 0x00
      008124 00                    1808 	.db 0x00
      008125 00                    1809 	.db 0x00
      008126 00                    1810 	.db 0x00
      008127 00                    1811 	.db 0x00
      008128 00                    1812 	.db 0x00
      008129 00                    1813 	.db 0x00
      00812A 00                    1814 	.db 0x00
      00812B 00                    1815 	.db 0x00
      00812C 00                    1816 	.db 0x00
      00812D 00                    1817 	.db 0x00
      00812E 00                    1818 	.db 0x00
      00812F 00                    1819 	.db 0x00
      008130 00                    1820 	.db 0x00
      008131 00                    1821 	.db 0x00
      008132 00                    1822 	.db 0x00
      008133 00                    1823 	.db 0x00
      008134 00                    1824 	.db 0x00
      008135 00                    1825 	.db 0x00
      008136 00                    1826 	.db 0x00
      008137 00                    1827 	.db 0x00
      008138 00                    1828 	.db 0x00
      008139 00                    1829 	.db 0x00
      00813A 00                    1830 	.db 0x00
      00813B 00                    1831 	.db 0x00
      00813C 00                    1832 	.db 0x00
      00813D 00                    1833 	.db 0x00
      00813E 00                    1834 	.db 0x00
      00813F 00                    1835 	.db 0x00
      008140 00                    1836 	.db 0x00
      008141 00                    1837 	.db 0x00
      008142 00                    1838 	.db 0x00
      008143 00                    1839 	.db 0x00
      008144 00                    1840 	.db 0x00
      008145 00                    1841 	.db 0x00
      008146 00                    1842 	.db 0x00
      008147 00                    1843 	.db 0x00
      008148 00                    1844 	.db 0x00
      008149 00                    1845 	.db 0x00
      00814A 00                    1846 	.db 0x00
      00814B 00                    1847 	.db 0x00
      00814C 00                    1848 	.db 0x00
      00814D 00                    1849 	.db 0x00
      00814E 00                    1850 	.db 0x00
      00814F 00                    1851 	.db 0x00
      008150 00                    1852 	.db 0x00
      008151 00                    1853 	.db 0x00
      008152 00                    1854 	.db 0x00
      008153 00                    1855 	.db 0x00
      008154 00                    1856 	.db 0x00
      008155 00                    1857 	.db 0x00
      008156 00                    1858 	.db 0x00
      008157 00                    1859 	.db 0x00
      008158 00                    1860 	.db 0x00
      008159 00                    1861 	.db 0x00
      00815A 00                    1862 	.db 0x00
      00815B 00                    1863 	.db 0x00
      00815C 00                    1864 	.db 0x00
      00815D 00                    1865 	.db 0x00
      00815E 00                    1866 	.db 0x00
      00815F 00                    1867 	.db 0x00
      008160 00                    1868 	.db 0x00
      008161 00                    1869 	.db 0x00
      008162 00                    1870 	.db 0x00
      008163 00                    1871 	.db 0x00
      008164 00                    1872 	.db 0x00
      008165 00                    1873 	.db 0x00
      008166 00                    1874 	.db 0x00
      008167 00                    1875 	.db 0x00
      008168 00                    1876 	.db 0x00
      008169 00                    1877 	.db 0x00
      00816A 00                    1878 	.db 0x00
      00816B 00                    1879 	.db 0x00
      00816C 00                    1880 	.db 0x00
      00816D 00                    1881 	.db 0x00
      00816E 00                    1882 	.db 0x00
      00816F 00                    1883 	.db 0x00
      008170 00                    1884 	.db 0x00
      008171 00                    1885 	.db 0x00
      008172 00                    1886 	.db 0x00
      008173 00                    1887 	.db 0x00
      008174 00                    1888 	.db 0x00
      008175 00                    1889 	.db 0x00
      008176 00                    1890 	.db 0x00
      008177 00                    1891 	.db 0x00
      008178 00                    1892 	.db 0x00
      008179 00                    1893 	.db 0x00
      00817A 00                    1894 	.db 0x00
      00817B 00                    1895 	.db 0x00
      00817C 00                    1896 	.db 0x00
      00817D 00                    1897 	.db 0x00
      00817E 00                    1898 	.db 0x00
      00817F 00                    1899 	.db 0x00
      008180 00                    1900 	.db 0x00
      008181 00                    1901 	.db 0x00
      008182 00                    1902 	.db 0x00
      008183 00                    1903 	.db 0x00
      008184 00                    1904 	.db 0x00
      008185 00                    1905 	.db 0x00
      008186 00                    1906 	.db 0x00
      008187 00                    1907 	.db 0x00
      008188 00                    1908 	.db 0x00
      008189 00                    1909 	.db 0x00
      00818A 00                    1910 	.db 0x00
      00818B 00                    1911 	.db 0x00
      00818C 00                    1912 	.db 0x00
      00818D 00                    1913 	.db 0x00
      00818E 00                    1914 	.db 0x00
      00818F 00                    1915 	.db 0x00
      008190 00                    1916 	.db 0x00
      008191 00                    1917 	.db 0x00
      008192 00                    1918 	.db 0x00
      008193 00                    1919 	.db 0x00
      008194 00                    1920 	.db 0x00
      008195 00                    1921 	.db 0x00
      008196 00                    1922 	.db 0x00
      008197 00                    1923 	.db 0x00
      008198 00                    1924 	.db 0x00
      008199 00                    1925 	.db 0x00
      00819A 00                    1926 	.db 0x00
      00819B 00                    1927 	.db 0x00
      00819C 00                    1928 	.db 0x00
      00819D 00                    1929 	.db 0x00
      00819E 00                    1930 	.db 0x00
      00819F 00                    1931 	.db 0x00
      0081A0 00                    1932 	.db 0x00
      0081A1 00                    1933 	.db 0x00
      0081A2 00                    1934 	.db 0x00
      0081A3                       1935 __xinit__buffer:
      0081A3 00                    1936 	.db #0x00	; 0
      0081A4 00                    1937 	.db 0x00
      0081A5 00                    1938 	.db 0x00
      0081A6 00                    1939 	.db 0x00
      0081A7 00                    1940 	.db 0x00
      0081A8 00                    1941 	.db 0x00
      0081A9 00                    1942 	.db 0x00
      0081AA 00                    1943 	.db 0x00
      0081AB 00                    1944 	.db 0x00
      0081AC 00                    1945 	.db 0x00
      0081AD 00                    1946 	.db 0x00
      0081AE 00                    1947 	.db 0x00
      0081AF 00                    1948 	.db 0x00
      0081B0 00                    1949 	.db 0x00
      0081B1 00                    1950 	.db 0x00
      0081B2 00                    1951 	.db 0x00
      0081B3 00                    1952 	.db 0x00
      0081B4 00                    1953 	.db 0x00
      0081B5 00                    1954 	.db 0x00
      0081B6 00                    1955 	.db 0x00
      0081B7 00                    1956 	.db 0x00
      0081B8 00                    1957 	.db 0x00
      0081B9 00                    1958 	.db 0x00
      0081BA 00                    1959 	.db 0x00
      0081BB 00                    1960 	.db 0x00
      0081BC 00                    1961 	.db 0x00
      0081BD 00                    1962 	.db 0x00
      0081BE 00                    1963 	.db 0x00
      0081BF 00                    1964 	.db 0x00
      0081C0 00                    1965 	.db 0x00
      0081C1 00                    1966 	.db 0x00
      0081C2 00                    1967 	.db 0x00
      0081C3 00                    1968 	.db 0x00
      0081C4 00                    1969 	.db 0x00
      0081C5 00                    1970 	.db 0x00
      0081C6 00                    1971 	.db 0x00
      0081C7 00                    1972 	.db 0x00
      0081C8 00                    1973 	.db 0x00
      0081C9 00                    1974 	.db 0x00
      0081CA 00                    1975 	.db 0x00
      0081CB 00                    1976 	.db 0x00
      0081CC 00                    1977 	.db 0x00
      0081CD 00                    1978 	.db 0x00
      0081CE 00                    1979 	.db 0x00
      0081CF 00                    1980 	.db 0x00
      0081D0 00                    1981 	.db 0x00
      0081D1 00                    1982 	.db 0x00
      0081D2 00                    1983 	.db 0x00
      0081D3 00                    1984 	.db 0x00
      0081D4 00                    1985 	.db 0x00
      0081D5 00                    1986 	.db 0x00
      0081D6 00                    1987 	.db 0x00
      0081D7 00                    1988 	.db 0x00
      0081D8 00                    1989 	.db 0x00
      0081D9 00                    1990 	.db 0x00
      0081DA 00                    1991 	.db 0x00
      0081DB 00                    1992 	.db 0x00
      0081DC 00                    1993 	.db 0x00
      0081DD 00                    1994 	.db 0x00
      0081DE 00                    1995 	.db 0x00
      0081DF 00                    1996 	.db 0x00
      0081E0 00                    1997 	.db 0x00
      0081E1 00                    1998 	.db 0x00
      0081E2 00                    1999 	.db 0x00
      0081E3 00                    2000 	.db 0x00
      0081E4 00                    2001 	.db 0x00
      0081E5 00                    2002 	.db 0x00
      0081E6 00                    2003 	.db 0x00
      0081E7 00                    2004 	.db 0x00
      0081E8 00                    2005 	.db 0x00
      0081E9 00                    2006 	.db 0x00
      0081EA 00                    2007 	.db 0x00
      0081EB 00                    2008 	.db 0x00
      0081EC 00                    2009 	.db 0x00
      0081ED 00                    2010 	.db 0x00
      0081EE 00                    2011 	.db 0x00
      0081EF 00                    2012 	.db 0x00
      0081F0 00                    2013 	.db 0x00
      0081F1 00                    2014 	.db 0x00
      0081F2 00                    2015 	.db 0x00
      0081F3 00                    2016 	.db 0x00
      0081F4 00                    2017 	.db 0x00
      0081F5 00                    2018 	.db 0x00
      0081F6 00                    2019 	.db 0x00
      0081F7 00                    2020 	.db 0x00
      0081F8 00                    2021 	.db 0x00
      0081F9 00                    2022 	.db 0x00
      0081FA 00                    2023 	.db 0x00
      0081FB 00                    2024 	.db 0x00
      0081FC 00                    2025 	.db 0x00
      0081FD 00                    2026 	.db 0x00
      0081FE 00                    2027 	.db 0x00
      0081FF 00                    2028 	.db 0x00
      008200 00                    2029 	.db 0x00
      008201 00                    2030 	.db 0x00
      008202 00                    2031 	.db 0x00
      008203 00                    2032 	.db 0x00
      008204 00                    2033 	.db 0x00
      008205 00                    2034 	.db 0x00
      008206 00                    2035 	.db 0x00
      008207 00                    2036 	.db 0x00
      008208 00                    2037 	.db 0x00
      008209 00                    2038 	.db 0x00
      00820A 00                    2039 	.db 0x00
      00820B 00                    2040 	.db 0x00
      00820C 00                    2041 	.db 0x00
      00820D 00                    2042 	.db 0x00
      00820E 00                    2043 	.db 0x00
      00820F 00                    2044 	.db 0x00
      008210 00                    2045 	.db 0x00
      008211 00                    2046 	.db 0x00
      008212 00                    2047 	.db 0x00
      008213 00                    2048 	.db 0x00
      008214 00                    2049 	.db 0x00
      008215 00                    2050 	.db 0x00
      008216 00                    2051 	.db 0x00
      008217 00                    2052 	.db 0x00
      008218 00                    2053 	.db 0x00
      008219 00                    2054 	.db 0x00
      00821A 00                    2055 	.db 0x00
      00821B 00                    2056 	.db 0x00
      00821C 00                    2057 	.db 0x00
      00821D 00                    2058 	.db 0x00
      00821E 00                    2059 	.db 0x00
      00821F 00                    2060 	.db 0x00
      008220 00                    2061 	.db 0x00
      008221 00                    2062 	.db 0x00
      008222 00                    2063 	.db 0x00
      008223 00                    2064 	.db 0x00
      008224 00                    2065 	.db 0x00
      008225 00                    2066 	.db 0x00
      008226 00                    2067 	.db 0x00
      008227 00                    2068 	.db 0x00
      008228 00                    2069 	.db 0x00
      008229 00                    2070 	.db 0x00
      00822A 00                    2071 	.db 0x00
      00822B 00                    2072 	.db 0x00
      00822C 00                    2073 	.db 0x00
      00822D 00                    2074 	.db 0x00
      00822E 00                    2075 	.db 0x00
      00822F 00                    2076 	.db 0x00
      008230 00                    2077 	.db 0x00
      008231 00                    2078 	.db 0x00
      008232 00                    2079 	.db 0x00
      008233 00                    2080 	.db 0x00
      008234 00                    2081 	.db 0x00
      008235 00                    2082 	.db 0x00
      008236 00                    2083 	.db 0x00
      008237 00                    2084 	.db 0x00
      008238 00                    2085 	.db 0x00
      008239 00                    2086 	.db 0x00
      00823A 00                    2087 	.db 0x00
      00823B 00                    2088 	.db 0x00
      00823C 00                    2089 	.db 0x00
      00823D 00                    2090 	.db 0x00
      00823E 00                    2091 	.db 0x00
      00823F 00                    2092 	.db 0x00
      008240 00                    2093 	.db 0x00
      008241 00                    2094 	.db 0x00
      008242 00                    2095 	.db 0x00
      008243 00                    2096 	.db 0x00
      008244 00                    2097 	.db 0x00
      008245 00                    2098 	.db 0x00
      008246 00                    2099 	.db 0x00
      008247 00                    2100 	.db 0x00
      008248 00                    2101 	.db 0x00
      008249 00                    2102 	.db 0x00
      00824A 00                    2103 	.db 0x00
      00824B 00                    2104 	.db 0x00
      00824C 00                    2105 	.db 0x00
      00824D 00                    2106 	.db 0x00
      00824E 00                    2107 	.db 0x00
      00824F 00                    2108 	.db 0x00
      008250 00                    2109 	.db 0x00
      008251 00                    2110 	.db 0x00
      008252 00                    2111 	.db 0x00
      008253 00                    2112 	.db 0x00
      008254 00                    2113 	.db 0x00
      008255 00                    2114 	.db 0x00
      008256 00                    2115 	.db 0x00
      008257 00                    2116 	.db 0x00
      008258 00                    2117 	.db 0x00
      008259 00                    2118 	.db 0x00
      00825A 00                    2119 	.db 0x00
      00825B 00                    2120 	.db 0x00
      00825C 00                    2121 	.db 0x00
      00825D 00                    2122 	.db 0x00
      00825E 00                    2123 	.db 0x00
      00825F 00                    2124 	.db 0x00
      008260 00                    2125 	.db 0x00
      008261 00                    2126 	.db 0x00
      008262 00                    2127 	.db 0x00
      008263 00                    2128 	.db 0x00
      008264 00                    2129 	.db 0x00
      008265 00                    2130 	.db 0x00
      008266 00                    2131 	.db 0x00
      008267 00                    2132 	.db 0x00
      008268 00                    2133 	.db 0x00
      008269 00                    2134 	.db 0x00
      00826A 00                    2135 	.db 0x00
      00826B 00                    2136 	.db 0x00
      00826C 00                    2137 	.db 0x00
      00826D 00                    2138 	.db 0x00
      00826E 00                    2139 	.db 0x00
      00826F 00                    2140 	.db 0x00
      008270 00                    2141 	.db 0x00
      008271 00                    2142 	.db 0x00
      008272 00                    2143 	.db 0x00
      008273 00                    2144 	.db 0x00
      008274 00                    2145 	.db 0x00
      008275 00                    2146 	.db 0x00
      008276 00                    2147 	.db 0x00
      008277 00                    2148 	.db 0x00
      008278 00                    2149 	.db 0x00
      008279 00                    2150 	.db 0x00
      00827A 00                    2151 	.db 0x00
      00827B 00                    2152 	.db 0x00
      00827C 00                    2153 	.db 0x00
      00827D 00                    2154 	.db 0x00
      00827E 00                    2155 	.db 0x00
      00827F 00                    2156 	.db 0x00
      008280 00                    2157 	.db 0x00
      008281 00                    2158 	.db 0x00
      008282 00                    2159 	.db 0x00
      008283 00                    2160 	.db 0x00
      008284 00                    2161 	.db 0x00
      008285 00                    2162 	.db 0x00
      008286 00                    2163 	.db 0x00
      008287 00                    2164 	.db 0x00
      008288 00                    2165 	.db 0x00
      008289 00                    2166 	.db 0x00
      00828A 00                    2167 	.db 0x00
      00828B 00                    2168 	.db 0x00
      00828C 00                    2169 	.db 0x00
      00828D 00                    2170 	.db 0x00
      00828E 00                    2171 	.db 0x00
      00828F 00                    2172 	.db 0x00
      008290 00                    2173 	.db 0x00
      008291 00                    2174 	.db 0x00
      008292 00                    2175 	.db 0x00
      008293 00                    2176 	.db 0x00
      008294 00                    2177 	.db 0x00
      008295 00                    2178 	.db 0x00
      008296 00                    2179 	.db 0x00
      008297 00                    2180 	.db 0x00
      008298 00                    2181 	.db 0x00
      008299 00                    2182 	.db 0x00
      00829A 00                    2183 	.db 0x00
      00829B 00                    2184 	.db 0x00
      00829C 00                    2185 	.db 0x00
      00829D 00                    2186 	.db 0x00
      00829E 00                    2187 	.db 0x00
      00829F 00                    2188 	.db 0x00
      0082A0 00                    2189 	.db 0x00
      0082A1 00                    2190 	.db 0x00
      0082A2 00                    2191 	.db 0x00
      0082A3                       2192 __xinit__a:
      0082A3 00                    2193 	.db #0x00	; 0
      0082A4 00                    2194 	.db 0x00
      0082A5 00                    2195 	.db 0x00
      0082A6                       2196 __xinit__d_addr:
      0082A6 00                    2197 	.db #0x00	; 0
      0082A7                       2198 __xinit__p_size:
      0082A7 00                    2199 	.db #0x00	; 0
      0082A8                       2200 __xinit__d_size:
      0082A8 00                    2201 	.db #0x00	; 0
      0082A9                       2202 __xinit__p_bytes:
      0082A9 00                    2203 	.db #0x00	; 0
      0082AA                       2204 __xinit__data_buf:
      0082AA 00                    2205 	.db #0x00	; 0
      0082AB 00                    2206 	.db 0x00
      0082AC 00                    2207 	.db 0x00
      0082AD 00                    2208 	.db 0x00
      0082AE 00                    2209 	.db 0x00
      0082AF 00                    2210 	.db 0x00
      0082B0 00                    2211 	.db 0x00
      0082B1 00                    2212 	.db 0x00
      0082B2 00                    2213 	.db 0x00
      0082B3 00                    2214 	.db 0x00
      0082B4 00                    2215 	.db 0x00
      0082B5 00                    2216 	.db 0x00
      0082B6 00                    2217 	.db 0x00
      0082B7 00                    2218 	.db 0x00
      0082B8 00                    2219 	.db 0x00
      0082B9 00                    2220 	.db 0x00
      0082BA 00                    2221 	.db 0x00
      0082BB 00                    2222 	.db 0x00
      0082BC 00                    2223 	.db 0x00
      0082BD 00                    2224 	.db 0x00
      0082BE 00                    2225 	.db 0x00
      0082BF 00                    2226 	.db 0x00
      0082C0 00                    2227 	.db 0x00
      0082C1 00                    2228 	.db 0x00
      0082C2 00                    2229 	.db 0x00
      0082C3 00                    2230 	.db 0x00
      0082C4 00                    2231 	.db 0x00
      0082C5 00                    2232 	.db 0x00
      0082C6 00                    2233 	.db 0x00
      0082C7 00                    2234 	.db 0x00
      0082C8 00                    2235 	.db 0x00
      0082C9 00                    2236 	.db 0x00
      0082CA 00                    2237 	.db 0x00
      0082CB 00                    2238 	.db 0x00
      0082CC 00                    2239 	.db 0x00
      0082CD 00                    2240 	.db 0x00
      0082CE 00                    2241 	.db 0x00
      0082CF 00                    2242 	.db 0x00
      0082D0 00                    2243 	.db 0x00
      0082D1 00                    2244 	.db 0x00
      0082D2 00                    2245 	.db 0x00
      0082D3 00                    2246 	.db 0x00
      0082D4 00                    2247 	.db 0x00
      0082D5 00                    2248 	.db 0x00
      0082D6 00                    2249 	.db 0x00
      0082D7 00                    2250 	.db 0x00
      0082D8 00                    2251 	.db 0x00
      0082D9 00                    2252 	.db 0x00
      0082DA 00                    2253 	.db 0x00
      0082DB 00                    2254 	.db 0x00
      0082DC 00                    2255 	.db 0x00
      0082DD 00                    2256 	.db 0x00
      0082DE 00                    2257 	.db 0x00
      0082DF 00                    2258 	.db 0x00
      0082E0 00                    2259 	.db 0x00
      0082E1 00                    2260 	.db 0x00
      0082E2 00                    2261 	.db 0x00
      0082E3 00                    2262 	.db 0x00
      0082E4 00                    2263 	.db 0x00
      0082E5 00                    2264 	.db 0x00
      0082E6 00                    2265 	.db 0x00
      0082E7 00                    2266 	.db 0x00
      0082E8 00                    2267 	.db 0x00
      0082E9 00                    2268 	.db 0x00
      0082EA 00                    2269 	.db 0x00
      0082EB 00                    2270 	.db 0x00
      0082EC 00                    2271 	.db 0x00
      0082ED 00                    2272 	.db 0x00
      0082EE 00                    2273 	.db 0x00
      0082EF 00                    2274 	.db 0x00
      0082F0 00                    2275 	.db 0x00
      0082F1 00                    2276 	.db 0x00
      0082F2 00                    2277 	.db 0x00
      0082F3 00                    2278 	.db 0x00
      0082F4 00                    2279 	.db 0x00
      0082F5 00                    2280 	.db 0x00
      0082F6 00                    2281 	.db 0x00
      0082F7 00                    2282 	.db 0x00
      0082F8 00                    2283 	.db 0x00
      0082F9 00                    2284 	.db 0x00
      0082FA 00                    2285 	.db 0x00
      0082FB 00                    2286 	.db 0x00
      0082FC 00                    2287 	.db 0x00
      0082FD 00                    2288 	.db 0x00
      0082FE 00                    2289 	.db 0x00
      0082FF 00                    2290 	.db 0x00
      008300 00                    2291 	.db 0x00
      008301 00                    2292 	.db 0x00
      008302 00                    2293 	.db 0x00
      008303 00                    2294 	.db 0x00
      008304 00                    2295 	.db 0x00
      008305 00                    2296 	.db 0x00
      008306 00                    2297 	.db 0x00
      008307 00                    2298 	.db 0x00
      008308 00                    2299 	.db 0x00
      008309 00                    2300 	.db 0x00
      00830A 00                    2301 	.db 0x00
      00830B 00                    2302 	.db 0x00
      00830C 00                    2303 	.db 0x00
      00830D 00                    2304 	.db 0x00
      00830E 00                    2305 	.db 0x00
      00830F 00                    2306 	.db 0x00
      008310 00                    2307 	.db 0x00
      008311 00                    2308 	.db 0x00
      008312 00                    2309 	.db 0x00
      008313 00                    2310 	.db 0x00
      008314 00                    2311 	.db 0x00
      008315 00                    2312 	.db 0x00
      008316 00                    2313 	.db 0x00
      008317 00                    2314 	.db 0x00
      008318 00                    2315 	.db 0x00
      008319 00                    2316 	.db 0x00
      00831A 00                    2317 	.db 0x00
      00831B 00                    2318 	.db 0x00
      00831C 00                    2319 	.db 0x00
      00831D 00                    2320 	.db 0x00
      00831E 00                    2321 	.db 0x00
      00831F 00                    2322 	.db 0x00
      008320 00                    2323 	.db 0x00
      008321 00                    2324 	.db 0x00
      008322 00                    2325 	.db 0x00
      008323 00                    2326 	.db 0x00
      008324 00                    2327 	.db 0x00
      008325 00                    2328 	.db 0x00
      008326 00                    2329 	.db 0x00
      008327 00                    2330 	.db 0x00
      008328 00                    2331 	.db 0x00
      008329 00                    2332 	.db 0x00
      00832A 00                    2333 	.db 0x00
      00832B 00                    2334 	.db 0x00
      00832C 00                    2335 	.db 0x00
      00832D 00                    2336 	.db 0x00
      00832E 00                    2337 	.db 0x00
      00832F 00                    2338 	.db 0x00
      008330 00                    2339 	.db 0x00
      008331 00                    2340 	.db 0x00
      008332 00                    2341 	.db 0x00
      008333 00                    2342 	.db 0x00
      008334 00                    2343 	.db 0x00
      008335 00                    2344 	.db 0x00
      008336 00                    2345 	.db 0x00
      008337 00                    2346 	.db 0x00
      008338 00                    2347 	.db 0x00
      008339 00                    2348 	.db 0x00
      00833A 00                    2349 	.db 0x00
      00833B 00                    2350 	.db 0x00
      00833C 00                    2351 	.db 0x00
      00833D 00                    2352 	.db 0x00
      00833E 00                    2353 	.db 0x00
      00833F 00                    2354 	.db 0x00
      008340 00                    2355 	.db 0x00
      008341 00                    2356 	.db 0x00
      008342 00                    2357 	.db 0x00
      008343 00                    2358 	.db 0x00
      008344 00                    2359 	.db 0x00
      008345 00                    2360 	.db 0x00
      008346 00                    2361 	.db 0x00
      008347 00                    2362 	.db 0x00
      008348 00                    2363 	.db 0x00
      008349 00                    2364 	.db 0x00
      00834A 00                    2365 	.db 0x00
      00834B 00                    2366 	.db 0x00
      00834C 00                    2367 	.db 0x00
      00834D 00                    2368 	.db 0x00
      00834E 00                    2369 	.db 0x00
      00834F 00                    2370 	.db 0x00
      008350 00                    2371 	.db 0x00
      008351 00                    2372 	.db 0x00
      008352 00                    2373 	.db 0x00
      008353 00                    2374 	.db 0x00
      008354 00                    2375 	.db 0x00
      008355 00                    2376 	.db 0x00
      008356 00                    2377 	.db 0x00
      008357 00                    2378 	.db 0x00
      008358 00                    2379 	.db 0x00
      008359 00                    2380 	.db 0x00
      00835A 00                    2381 	.db 0x00
      00835B 00                    2382 	.db 0x00
      00835C 00                    2383 	.db 0x00
      00835D 00                    2384 	.db 0x00
      00835E 00                    2385 	.db 0x00
      00835F 00                    2386 	.db 0x00
      008360 00                    2387 	.db 0x00
      008361 00                    2388 	.db 0x00
      008362 00                    2389 	.db 0x00
      008363 00                    2390 	.db 0x00
      008364 00                    2391 	.db 0x00
      008365 00                    2392 	.db 0x00
      008366 00                    2393 	.db 0x00
      008367 00                    2394 	.db 0x00
      008368 00                    2395 	.db 0x00
      008369 00                    2396 	.db 0x00
      00836A 00                    2397 	.db 0x00
      00836B 00                    2398 	.db 0x00
      00836C 00                    2399 	.db 0x00
      00836D 00                    2400 	.db 0x00
      00836E 00                    2401 	.db 0x00
      00836F 00                    2402 	.db 0x00
      008370 00                    2403 	.db 0x00
      008371 00                    2404 	.db 0x00
      008372 00                    2405 	.db 0x00
      008373 00                    2406 	.db 0x00
      008374 00                    2407 	.db 0x00
      008375 00                    2408 	.db 0x00
      008376 00                    2409 	.db 0x00
      008377 00                    2410 	.db 0x00
      008378 00                    2411 	.db 0x00
      008379 00                    2412 	.db 0x00
      00837A 00                    2413 	.db 0x00
      00837B 00                    2414 	.db 0x00
      00837C 00                    2415 	.db 0x00
      00837D 00                    2416 	.db 0x00
      00837E 00                    2417 	.db 0x00
      00837F 00                    2418 	.db 0x00
      008380 00                    2419 	.db 0x00
      008381 00                    2420 	.db 0x00
      008382 00                    2421 	.db 0x00
      008383 00                    2422 	.db 0x00
      008384 00                    2423 	.db 0x00
      008385 00                    2424 	.db 0x00
      008386 00                    2425 	.db 0x00
      008387 00                    2426 	.db 0x00
      008388 00                    2427 	.db 0x00
      008389 00                    2428 	.db 0x00
      00838A 00                    2429 	.db 0x00
      00838B 00                    2430 	.db 0x00
      00838C 00                    2431 	.db 0x00
      00838D 00                    2432 	.db 0x00
      00838E 00                    2433 	.db 0x00
      00838F 00                    2434 	.db 0x00
      008390 00                    2435 	.db 0x00
      008391 00                    2436 	.db 0x00
      008392 00                    2437 	.db 0x00
      008393 00                    2438 	.db 0x00
      008394 00                    2439 	.db 0x00
      008395 00                    2440 	.db 0x00
      008396 00                    2441 	.db 0x00
      008397 00                    2442 	.db 0x00
      008398 00                    2443 	.db 0x00
      008399 00                    2444 	.db 0x00
      00839A 00                    2445 	.db 0x00
      00839B 00                    2446 	.db 0x00
      00839C 00                    2447 	.db 0x00
      00839D 00                    2448 	.db 0x00
      00839E 00                    2449 	.db 0x00
      00839F 00                    2450 	.db 0x00
      0083A0 00                    2451 	.db 0x00
      0083A1 00                    2452 	.db 0x00
      0083A2 00                    2453 	.db 0x00
      0083A3 00                    2454 	.db 0x00
      0083A4 00                    2455 	.db 0x00
      0083A5 00                    2456 	.db 0x00
      0083A6 00                    2457 	.db 0x00
      0083A7 00                    2458 	.db 0x00
      0083A8 00                    2459 	.db 0x00
      0083A9 00                    2460 	.db 0x00
      0083AA                       2461 __xinit__current_dev:
      0083AA 00                    2462 	.db #0x00	; 0
                                   2463 	.area CABS (ABS)
