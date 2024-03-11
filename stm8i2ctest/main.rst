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
      008007 CD 89 94         [ 4]  110 	call	___sdcc_external_startup
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
      008021 D6 80 79         [ 1]  126 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 88 C7         [ 2]  140 	jp	_main
                                    141 ;	return from main will return to caller
                                    142 ;--------------------------------------------------------
                                    143 ; code
                                    144 ;--------------------------------------------------------
                                    145 	.area CODE
                                    146 ;	main.c: 26: void delay(unsigned long count) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function delay
                                    149 ;	-----------------------------------------
      008280                        150 _delay:
      008280 52 08            [ 2]  151 	sub	sp, #8
                                    152 ;	main.c: 27: while (count--)
      008282 16 0D            [ 2]  153 	ldw	y, (0x0d, sp)
      008284 17 07            [ 2]  154 	ldw	(0x07, sp), y
      008286 1E 0B            [ 2]  155 	ldw	x, (0x0b, sp)
      008288                        156 00101$:
      008288 1F 01            [ 2]  157 	ldw	(0x01, sp), x
      00828A 7B 07            [ 1]  158 	ld	a, (0x07, sp)
      00828C 6B 03            [ 1]  159 	ld	(0x03, sp), a
      00828E 7B 08            [ 1]  160 	ld	a, (0x08, sp)
      008290 16 07            [ 2]  161 	ldw	y, (0x07, sp)
      008292 72 A2 00 01      [ 2]  162 	subw	y, #0x0001
      008296 17 07            [ 2]  163 	ldw	(0x07, sp), y
      008298 24 01            [ 1]  164 	jrnc	00117$
      00829A 5A               [ 2]  165 	decw	x
      00829B                        166 00117$:
      00829B 4D               [ 1]  167 	tnz	a
      00829C 26 08            [ 1]  168 	jrne	00118$
      00829E 16 02            [ 2]  169 	ldw	y, (0x02, sp)
      0082A0 26 04            [ 1]  170 	jrne	00118$
      0082A2 0D 01            [ 1]  171 	tnz	(0x01, sp)
      0082A4 27 03            [ 1]  172 	jreq	00104$
      0082A6                        173 00118$:
                                    174 ;	main.c: 28: nop();
      0082A6 9D               [ 1]  175 	nop
      0082A7 20 DF            [ 2]  176 	jra	00101$
      0082A9                        177 00104$:
                                    178 ;	main.c: 29: }
      0082A9 1E 09            [ 2]  179 	ldw	x, (9, sp)
      0082AB 5B 0E            [ 2]  180 	addw	sp, #14
      0082AD FC               [ 2]  181 	jp	(x)
                                    182 ;	main.c: 37: void UART_TX(unsigned char value)
                                    183 ;	-----------------------------------------
                                    184 ;	 function UART_TX
                                    185 ;	-----------------------------------------
      0082AE                        186 _UART_TX:
                                    187 ;	main.c: 39: UART1_DR = value;
      0082AE C7 52 31         [ 1]  188 	ld	0x5231, a
                                    189 ;	main.c: 40: while(!(UART1_SR & UART_SR_TXE));
      0082B1                        190 00101$:
      0082B1 C6 52 30         [ 1]  191 	ld	a, 0x5230
      0082B4 2A FB            [ 1]  192 	jrpl	00101$
                                    193 ;	main.c: 41: }
      0082B6 81               [ 4]  194 	ret
                                    195 ;	main.c: 42: unsigned char UART_RX(void)
                                    196 ;	-----------------------------------------
                                    197 ;	 function UART_RX
                                    198 ;	-----------------------------------------
      0082B7                        199 _UART_RX:
                                    200 ;	main.c: 44: while(!(UART1_SR & UART_SR_TXE));
      0082B7                        201 00101$:
      0082B7 C6 52 30         [ 1]  202 	ld	a, 0x5230
      0082BA 2A FB            [ 1]  203 	jrpl	00101$
                                    204 ;	main.c: 45: return UART1_DR;
      0082BC C6 52 31         [ 1]  205 	ld	a, 0x5231
                                    206 ;	main.c: 46: }
      0082BF 81               [ 4]  207 	ret
                                    208 ;	main.c: 47: int uart_write(const char *str) {
                                    209 ;	-----------------------------------------
                                    210 ;	 function uart_write
                                    211 ;	-----------------------------------------
      0082C0                        212 _uart_write:
      0082C0 52 05            [ 2]  213 	sub	sp, #5
      0082C2 1F 03            [ 2]  214 	ldw	(0x03, sp), x
                                    215 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      0082C4 0F 05            [ 1]  216 	clr	(0x05, sp)
      0082C6                        217 00103$:
      0082C6 1E 03            [ 2]  218 	ldw	x, (0x03, sp)
      0082C8 CD 89 96         [ 4]  219 	call	_strlen
      0082CB 1F 01            [ 2]  220 	ldw	(0x01, sp), x
      0082CD 7B 05            [ 1]  221 	ld	a, (0x05, sp)
      0082CF 5F               [ 1]  222 	clrw	x
      0082D0 97               [ 1]  223 	ld	xl, a
      0082D1 13 01            [ 2]  224 	cpw	x, (0x01, sp)
      0082D3 24 0F            [ 1]  225 	jrnc	00101$
                                    226 ;	main.c: 51: UART_TX(str[i]);
      0082D5 5F               [ 1]  227 	clrw	x
      0082D6 7B 05            [ 1]  228 	ld	a, (0x05, sp)
      0082D8 97               [ 1]  229 	ld	xl, a
      0082D9 72 FB 03         [ 2]  230 	addw	x, (0x03, sp)
      0082DC F6               [ 1]  231 	ld	a, (x)
      0082DD CD 82 AE         [ 4]  232 	call	_UART_TX
                                    233 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      0082E0 0C 05            [ 1]  234 	inc	(0x05, sp)
      0082E2 20 E2            [ 2]  235 	jra	00103$
      0082E4                        236 00101$:
                                    237 ;	main.c: 53: return(i); // Bytes sent
      0082E4 7B 05            [ 1]  238 	ld	a, (0x05, sp)
      0082E6 5F               [ 1]  239 	clrw	x
      0082E7 97               [ 1]  240 	ld	xl, a
                                    241 ;	main.c: 54: }
      0082E8 5B 05            [ 2]  242 	addw	sp, #5
      0082EA 81               [ 4]  243 	ret
                                    244 ;	main.c: 55: int uart_read(void)
                                    245 ;	-----------------------------------------
                                    246 ;	 function uart_read
                                    247 ;	-----------------------------------------
      0082EB                        248 _uart_read:
                                    249 ;	main.c: 57: memset(buffer, 0, sizeof(buffer));
      0082EB 4B FF            [ 1]  250 	push	#0xff
      0082ED 4B 00            [ 1]  251 	push	#0x00
      0082EF 5F               [ 1]  252 	clrw	x
      0082F0 89               [ 2]  253 	pushw	x
      0082F1 AE 00 01         [ 2]  254 	ldw	x, #(_buffer+0)
      0082F4 CD 89 72         [ 4]  255 	call	_memset
                                    256 ;	main.c: 59: while(i<256)
      0082F7 5F               [ 1]  257 	clrw	x
      0082F8                        258 00105$:
      0082F8 A3 01 00         [ 2]  259 	cpw	x, #0x0100
      0082FB 2E 22            [ 1]  260 	jrsge	00107$
                                    261 ;	main.c: 61: if(UART1_SR & UART_SR_RXNE)
      0082FD C6 52 30         [ 1]  262 	ld	a, 0x5230
      008300 A5 20            [ 1]  263 	bcp	a, #0x20
      008302 27 F4            [ 1]  264 	jreq	00105$
                                    265 ;	main.c: 63: buffer[i] = UART_RX();
      008304 90 93            [ 1]  266 	ldw	y, x
      008306 72 A9 00 01      [ 2]  267 	addw	y, #(_buffer+0)
      00830A 89               [ 2]  268 	pushw	x
      00830B 90 89            [ 2]  269 	pushw	y
      00830D CD 82 B7         [ 4]  270 	call	_UART_RX
      008310 90 85            [ 2]  271 	popw	y
      008312 85               [ 2]  272 	popw	x
      008313 90 F7            [ 1]  273 	ld	(y), a
                                    274 ;	main.c: 64: if(buffer[i] == '\r\n' )
      008315 A1 0D            [ 1]  275 	cp	a, #0x0d
      008317 26 03            [ 1]  276 	jrne	00102$
                                    277 ;	main.c: 66: return 1;
      008319 5F               [ 1]  278 	clrw	x
      00831A 5C               [ 1]  279 	incw	x
      00831B 81               [ 4]  280 	ret
                                    281 ;	main.c: 67: break;
      00831C                        282 00102$:
                                    283 ;	main.c: 69: i++;
      00831C 5C               [ 1]  284 	incw	x
      00831D 20 D9            [ 2]  285 	jra	00105$
      00831F                        286 00107$:
                                    287 ;	main.c: 72: return 0;
      00831F 5F               [ 1]  288 	clrw	x
                                    289 ;	main.c: 73: }
      008320 81               [ 4]  290 	ret
                                    291 ;	main.c: 82: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    292 ;	-----------------------------------------
                                    293 ;	 function convert_int_to_chars
                                    294 ;	-----------------------------------------
      008321                        295 _convert_int_to_chars:
      008321 52 0D            [ 2]  296 	sub	sp, #13
      008323 6B 0D            [ 1]  297 	ld	(0x0d, sp), a
      008325 1F 0B            [ 2]  298 	ldw	(0x0b, sp), x
                                    299 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      008327 7B 0D            [ 1]  300 	ld	a, (0x0d, sp)
      008329 6B 02            [ 1]  301 	ld	(0x02, sp), a
      00832B 0F 01            [ 1]  302 	clr	(0x01, sp)
                                    303 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      00832D 1E 0B            [ 2]  304 	ldw	x, (0x0b, sp)
      00832F 5C               [ 1]  305 	incw	x
      008330 1F 03            [ 2]  306 	ldw	(0x03, sp), x
                                    307 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      008332 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      008334 5C               [ 1]  309 	incw	x
      008335 5C               [ 1]  310 	incw	x
      008336 1F 05            [ 2]  311 	ldw	(0x05, sp), x
                                    312 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      008338 4B 0A            [ 1]  313 	push	#0x0a
      00833A 4B 00            [ 1]  314 	push	#0x00
      00833C 1E 03            [ 2]  315 	ldw	x, (0x03, sp)
                                    316 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      00833E CD 89 BB         [ 4]  317 	call	__divsint
      008341 1F 07            [ 2]  318 	ldw	(0x07, sp), x
      008343 4B 0A            [ 1]  319 	push	#0x0a
      008345 4B 00            [ 1]  320 	push	#0x00
      008347 1E 03            [ 2]  321 	ldw	x, (0x03, sp)
      008349 CD 89 A3         [ 4]  322 	call	__modsint
      00834C 9F               [ 1]  323 	ld	a, xl
      00834D AB 30            [ 1]  324 	add	a, #0x30
      00834F 6B 09            [ 1]  325 	ld	(0x09, sp), a
                                    326 ;	main.c: 83: if (num > 99) {
      008351 7B 0D            [ 1]  327 	ld	a, (0x0d, sp)
      008353 A1 63            [ 1]  328 	cp	a, #0x63
      008355 23 29            [ 2]  329 	jrule	00105$
                                    330 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      008357 4B 64            [ 1]  331 	push	#0x64
      008359 4B 00            [ 1]  332 	push	#0x00
      00835B 1E 03            [ 2]  333 	ldw	x, (0x03, sp)
      00835D CD 89 BB         [ 4]  334 	call	__divsint
      008360 9F               [ 1]  335 	ld	a, xl
      008361 AB 30            [ 1]  336 	add	a, #0x30
      008363 1E 0B            [ 2]  337 	ldw	x, (0x0b, sp)
      008365 F7               [ 1]  338 	ld	(x), a
                                    339 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      008366 4B 0A            [ 1]  340 	push	#0x0a
      008368 4B 00            [ 1]  341 	push	#0x00
      00836A 1E 09            [ 2]  342 	ldw	x, (0x09, sp)
      00836C CD 89 A3         [ 4]  343 	call	__modsint
      00836F 9F               [ 1]  344 	ld	a, xl
      008370 AB 30            [ 1]  345 	add	a, #0x30
      008372 1E 03            [ 2]  346 	ldw	x, (0x03, sp)
      008374 F7               [ 1]  347 	ld	(x), a
                                    348 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      008375 1E 05            [ 2]  349 	ldw	x, (0x05, sp)
      008377 7B 09            [ 1]  350 	ld	a, (0x09, sp)
      008379 F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 88: rx_int_chars[3] ='\0';
      00837A 1E 0B            [ 2]  353 	ldw	x, (0x0b, sp)
      00837C 6F 03            [ 1]  354 	clr	(0x0003, x)
      00837E 20 23            [ 2]  355 	jra	00107$
      008380                        356 00105$:
                                    357 ;	main.c: 90: } else if (num > 9) {
      008380 7B 0D            [ 1]  358 	ld	a, (0x0d, sp)
      008382 A1 09            [ 1]  359 	cp	a, #0x09
      008384 23 13            [ 2]  360 	jrule	00102$
                                    361 ;	main.c: 92: rx_int_chars[0] = num / 10 + '0';
      008386 7B 08            [ 1]  362 	ld	a, (0x08, sp)
      008388 6B 0A            [ 1]  363 	ld	(0x0a, sp), a
      00838A AB 30            [ 1]  364 	add	a, #0x30
      00838C 1E 0B            [ 2]  365 	ldw	x, (0x0b, sp)
      00838E F7               [ 1]  366 	ld	(x), a
                                    367 ;	main.c: 93: rx_int_chars[1] = num % 10 + '0';
      00838F 1E 03            [ 2]  368 	ldw	x, (0x03, sp)
      008391 7B 09            [ 1]  369 	ld	a, (0x09, sp)
      008393 F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 94: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      008394 1E 05            [ 2]  372 	ldw	x, (0x05, sp)
      008396 7F               [ 1]  373 	clr	(x)
      008397 20 0A            [ 2]  374 	jra	00107$
      008399                        375 00102$:
                                    376 ;	main.c: 97: rx_int_chars[0] = num + '0';
      008399 7B 0D            [ 1]  377 	ld	a, (0x0d, sp)
      00839B AB 30            [ 1]  378 	add	a, #0x30
      00839D 1E 0B            [ 2]  379 	ldw	x, (0x0b, sp)
      00839F F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 98: rx_int_chars[1] ='\0';
      0083A0 1E 03            [ 2]  382 	ldw	x, (0x03, sp)
      0083A2 7F               [ 1]  383 	clr	(x)
      0083A3                        384 00107$:
                                    385 ;	main.c: 100: }
      0083A3 5B 0D            [ 2]  386 	addw	sp, #13
      0083A5 81               [ 4]  387 	ret
                                    388 ;	main.c: 102: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    389 ;	-----------------------------------------
                                    390 ;	 function convert_chars_to_int
                                    391 ;	-----------------------------------------
      0083A6                        392 _convert_chars_to_int:
      0083A6 52 03            [ 2]  393 	sub	sp, #3
      0083A8 1F 02            [ 2]  394 	ldw	(0x02, sp), x
                                    395 ;	main.c: 103: uint8_t result = 0;
      0083AA 4F               [ 1]  396 	clr	a
                                    397 ;	main.c: 105: for (int o = 0; o < i; o++) {
      0083AB 5F               [ 1]  398 	clrw	x
      0083AC                        399 00103$:
      0083AC 13 06            [ 2]  400 	cpw	x, (0x06, sp)
      0083AE 2E 18            [ 1]  401 	jrsge	00101$
                                    402 ;	main.c: 107: result = (result * 10) + (rx_chars_int[o] - '0');
      0083B0 90 97            [ 1]  403 	ld	yl, a
      0083B2 A6 0A            [ 1]  404 	ld	a, #0x0a
      0083B4 90 42            [ 4]  405 	mul	y, a
      0083B6 61               [ 1]  406 	exg	a, yl
      0083B7 6B 01            [ 1]  407 	ld	(0x01, sp), a
      0083B9 61               [ 1]  408 	exg	a, yl
      0083BA 90 93            [ 1]  409 	ldw	y, x
      0083BC 72 F9 02         [ 2]  410 	addw	y, (0x02, sp)
      0083BF 90 F6            [ 1]  411 	ld	a, (y)
      0083C1 A0 30            [ 1]  412 	sub	a, #0x30
      0083C3 1B 01            [ 1]  413 	add	a, (0x01, sp)
                                    414 ;	main.c: 105: for (int o = 0; o < i; o++) {
      0083C5 5C               [ 1]  415 	incw	x
      0083C6 20 E4            [ 2]  416 	jra	00103$
      0083C8                        417 00101$:
                                    418 ;	main.c: 110: return result;
                                    419 ;	main.c: 111: }
      0083C8 1E 04            [ 2]  420 	ldw	x, (4, sp)
      0083CA 5B 07            [ 2]  421 	addw	sp, #7
      0083CC FC               [ 2]  422 	jp	(x)
                                    423 ;	main.c: 114: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    424 ;	-----------------------------------------
                                    425 ;	 function convert_int_to_binary
                                    426 ;	-----------------------------------------
      0083CD                        427 _convert_int_to_binary:
      0083CD 52 04            [ 2]  428 	sub	sp, #4
      0083CF 1F 01            [ 2]  429 	ldw	(0x01, sp), x
                                    430 ;	main.c: 116: for(int i = 7; i >= 0; i--) {
      0083D1 AE 00 07         [ 2]  431 	ldw	x, #0x0007
      0083D4 1F 03            [ 2]  432 	ldw	(0x03, sp), x
      0083D6                        433 00103$:
      0083D6 0D 03            [ 1]  434 	tnz	(0x03, sp)
      0083D8 2B 22            [ 1]  435 	jrmi	00101$
                                    436 ;	main.c: 118: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      0083DA AE 00 07         [ 2]  437 	ldw	x, #0x0007
      0083DD 72 F0 03         [ 2]  438 	subw	x, (0x03, sp)
      0083E0 72 FB 07         [ 2]  439 	addw	x, (0x07, sp)
      0083E3 16 01            [ 2]  440 	ldw	y, (0x01, sp)
      0083E5 7B 04            [ 1]  441 	ld	a, (0x04, sp)
      0083E7 27 05            [ 1]  442 	jreq	00120$
      0083E9                        443 00119$:
      0083E9 90 57            [ 2]  444 	sraw	y
      0083EB 4A               [ 1]  445 	dec	a
      0083EC 26 FB            [ 1]  446 	jrne	00119$
      0083EE                        447 00120$:
      0083EE 90 9F            [ 1]  448 	ld	a, yl
      0083F0 A4 01            [ 1]  449 	and	a, #0x01
      0083F2 AB 30            [ 1]  450 	add	a, #0x30
      0083F4 F7               [ 1]  451 	ld	(x), a
                                    452 ;	main.c: 116: for(int i = 7; i >= 0; i--) {
      0083F5 1E 03            [ 2]  453 	ldw	x, (0x03, sp)
      0083F7 5A               [ 2]  454 	decw	x
      0083F8 1F 03            [ 2]  455 	ldw	(0x03, sp), x
      0083FA 20 DA            [ 2]  456 	jra	00103$
      0083FC                        457 00101$:
                                    458 ;	main.c: 120: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      0083FC 1E 07            [ 2]  459 	ldw	x, (0x07, sp)
      0083FE 6F 08            [ 1]  460 	clr	(0x0008, x)
                                    461 ;	main.c: 121: }
      008400 1E 05            [ 2]  462 	ldw	x, (5, sp)
      008402 5B 08            [ 2]  463 	addw	sp, #8
      008404 FC               [ 2]  464 	jp	(x)
                                    465 ;	main.c: 130: void get_addr_from_buff(void)
                                    466 ;	-----------------------------------------
                                    467 ;	 function get_addr_from_buff
                                    468 ;	-----------------------------------------
      008405                        469 _get_addr_from_buff:
      008405 52 02            [ 2]  470 	sub	sp, #2
                                    471 ;	main.c: 134: while(1)
      008407 A6 03            [ 1]  472 	ld	a, #0x03
      008409 6B 01            [ 1]  473 	ld	(0x01, sp), a
      00840B 0F 02            [ 1]  474 	clr	(0x02, sp)
      00840D                        475 00105$:
                                    476 ;	main.c: 136: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      00840D 5F               [ 1]  477 	clrw	x
      00840E 7B 01            [ 1]  478 	ld	a, (0x01, sp)
      008410 97               [ 1]  479 	ld	xl, a
      008411 D6 00 01         [ 1]  480 	ld	a, (_buffer+0, x)
      008414 A1 20            [ 1]  481 	cp	a, #0x20
      008416 27 04            [ 1]  482 	jreq	00101$
      008418 A1 0D            [ 1]  483 	cp	a, #0x0d
      00841A 26 08            [ 1]  484 	jrne	00102$
      00841C                        485 00101$:
                                    486 ;	main.c: 138: p_size = i+1;
      00841C 7B 01            [ 1]  487 	ld	a, (0x01, sp)
      00841E 4C               [ 1]  488 	inc	a
      00841F C7 01 04         [ 1]  489 	ld	_p_size+0, a
                                    490 ;	main.c: 139: break;
      008422 20 06            [ 2]  491 	jra	00106$
      008424                        492 00102$:
                                    493 ;	main.c: 141: i++;
      008424 0C 01            [ 1]  494 	inc	(0x01, sp)
                                    495 ;	main.c: 142: counter++;
      008426 0C 02            [ 1]  496 	inc	(0x02, sp)
      008428 20 E3            [ 2]  497 	jra	00105$
      00842A                        498 00106$:
                                    499 ;	main.c: 144: memcpy(a, &buffer[3], counter);
      00842A 5F               [ 1]  500 	clrw	x
      00842B 7B 02            [ 1]  501 	ld	a, (0x02, sp)
      00842D 97               [ 1]  502 	ld	xl, a
      00842E 89               [ 2]  503 	pushw	x
      00842F 4B 04            [ 1]  504 	push	#<(_buffer+3)
      008431 4B 00            [ 1]  505 	push	#((_buffer+3) >> 8)
      008433 AE 01 00         [ 2]  506 	ldw	x, #(_a+0)
      008436 CD 89 1F         [ 4]  507 	call	___memcpy
                                    508 ;	main.c: 145: d_addr = convert_chars_to_int(a, counter);
      008439 5F               [ 1]  509 	clrw	x
      00843A 7B 02            [ 1]  510 	ld	a, (0x02, sp)
      00843C 97               [ 1]  511 	ld	xl, a
      00843D 89               [ 2]  512 	pushw	x
      00843E AE 01 00         [ 2]  513 	ldw	x, #(_a+0)
      008441 CD 83 A6         [ 4]  514 	call	_convert_chars_to_int
      008444 C7 01 03         [ 1]  515 	ld	_d_addr+0, a
                                    516 ;	main.c: 146: }
      008447 5B 02            [ 2]  517 	addw	sp, #2
      008449 81               [ 4]  518 	ret
                                    519 ;	main.c: 148: void get_size_from_buff(void)
                                    520 ;	-----------------------------------------
                                    521 ;	 function get_size_from_buff
                                    522 ;	-----------------------------------------
      00844A                        523 _get_size_from_buff:
      00844A 52 02            [ 2]  524 	sub	sp, #2
                                    525 ;	main.c: 150: memset(a, 0, sizeof(a));
      00844C 4B 03            [ 1]  526 	push	#0x03
      00844E 4B 00            [ 1]  527 	push	#0x00
      008450 5F               [ 1]  528 	clrw	x
      008451 89               [ 2]  529 	pushw	x
      008452 AE 01 00         [ 2]  530 	ldw	x, #(_a+0)
      008455 CD 89 72         [ 4]  531 	call	_memset
                                    532 ;	main.c: 152: uint8_t i = p_size;
      008458 C6 01 04         [ 1]  533 	ld	a, _p_size+0
      00845B 6B 01            [ 1]  534 	ld	(0x01, sp), a
                                    535 ;	main.c: 153: while(1)
      00845D 0F 02            [ 1]  536 	clr	(0x02, sp)
      00845F                        537 00105$:
                                    538 ;	main.c: 155: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      00845F 5F               [ 1]  539 	clrw	x
      008460 7B 01            [ 1]  540 	ld	a, (0x01, sp)
      008462 97               [ 1]  541 	ld	xl, a
      008463 D6 00 01         [ 1]  542 	ld	a, (_buffer+0, x)
      008466 A1 20            [ 1]  543 	cp	a, #0x20
      008468 27 04            [ 1]  544 	jreq	00101$
      00846A A1 0D            [ 1]  545 	cp	a, #0x0d
      00846C 26 08            [ 1]  546 	jrne	00102$
      00846E                        547 00101$:
                                    548 ;	main.c: 158: p_bytes = i+1;
      00846E 7B 01            [ 1]  549 	ld	a, (0x01, sp)
      008470 4C               [ 1]  550 	inc	a
      008471 C7 01 06         [ 1]  551 	ld	_p_bytes+0, a
                                    552 ;	main.c: 159: break;
      008474 20 06            [ 2]  553 	jra	00106$
      008476                        554 00102$:
                                    555 ;	main.c: 161: i++;
      008476 0C 01            [ 1]  556 	inc	(0x01, sp)
                                    557 ;	main.c: 162: counter++;
      008478 0C 02            [ 1]  558 	inc	(0x02, sp)
      00847A 20 E3            [ 2]  559 	jra	00105$
      00847C                        560 00106$:
                                    561 ;	main.c: 165: memcpy(a, &buffer[p_size], counter);
      00847C 90 5F            [ 1]  562 	clrw	y
      00847E 7B 02            [ 1]  563 	ld	a, (0x02, sp)
      008480 90 97            [ 1]  564 	ld	yl, a
      008482 5F               [ 1]  565 	clrw	x
      008483 C6 01 04         [ 1]  566 	ld	a, _p_size+0
      008486 97               [ 1]  567 	ld	xl, a
      008487 1C 00 01         [ 2]  568 	addw	x, #(_buffer+0)
      00848A 90 89            [ 2]  569 	pushw	y
      00848C 89               [ 2]  570 	pushw	x
      00848D AE 01 00         [ 2]  571 	ldw	x, #(_a+0)
      008490 CD 89 1F         [ 4]  572 	call	___memcpy
                                    573 ;	main.c: 166: d_size = convert_chars_to_int(a, counter);
      008493 5F               [ 1]  574 	clrw	x
      008494 7B 02            [ 1]  575 	ld	a, (0x02, sp)
      008496 97               [ 1]  576 	ld	xl, a
      008497 89               [ 2]  577 	pushw	x
      008498 AE 01 00         [ 2]  578 	ldw	x, #(_a+0)
      00849B CD 83 A6         [ 4]  579 	call	_convert_chars_to_int
      00849E C7 01 05         [ 1]  580 	ld	_d_size+0, a
                                    581 ;	main.c: 167: }
      0084A1 5B 02            [ 2]  582 	addw	sp, #2
      0084A3 81               [ 4]  583 	ret
                                    584 ;	main.c: 168: void char_buffer_to_int(void)
                                    585 ;	-----------------------------------------
                                    586 ;	 function char_buffer_to_int
                                    587 ;	-----------------------------------------
      0084A4                        588 _char_buffer_to_int:
      0084A4 52 08            [ 2]  589 	sub	sp, #8
                                    590 ;	main.c: 170: memset(a, 0, sizeof(a));
      0084A6 4B 03            [ 1]  591 	push	#0x03
      0084A8 4B 00            [ 1]  592 	push	#0x00
      0084AA 5F               [ 1]  593 	clrw	x
      0084AB 89               [ 2]  594 	pushw	x
      0084AC AE 01 00         [ 2]  595 	ldw	x, #(_a+0)
      0084AF CD 89 72         [ 4]  596 	call	_memset
                                    597 ;	main.c: 171: uint8_t counter = d_size;
      0084B2 C6 01 05         [ 1]  598 	ld	a, _d_size+0
      0084B5 6B 01            [ 1]  599 	ld	(0x01, sp), a
                                    600 ;	main.c: 172: uint8_t i = p_bytes;
      0084B7 C6 01 06         [ 1]  601 	ld	a, _p_bytes+0
      0084BA 6B 03            [ 1]  602 	ld	(0x03, sp), a
                                    603 ;	main.c: 175: for(int o = 0; o < counter;o++)
      0084BC 0F 04            [ 1]  604 	clr	(0x04, sp)
      0084BE 5F               [ 1]  605 	clrw	x
      0084BF 1F 05            [ 2]  606 	ldw	(0x05, sp), x
      0084C1                        607 00112$:
      0084C1 7B 01            [ 1]  608 	ld	a, (0x01, sp)
      0084C3 6B 08            [ 1]  609 	ld	(0x08, sp), a
      0084C5 0F 07            [ 1]  610 	clr	(0x07, sp)
      0084C7 1E 05            [ 2]  611 	ldw	x, (0x05, sp)
      0084C9 13 07            [ 2]  612 	cpw	x, (0x07, sp)
      0084CB 2E 65            [ 1]  613 	jrsge	00114$
                                    614 ;	main.c: 177: uint8_t number_counter = 0;
      0084CD 0F 02            [ 1]  615 	clr	(0x02, sp)
                                    616 ;	main.c: 178: while(1)
      0084CF 7B 03            [ 1]  617 	ld	a, (0x03, sp)
      0084D1 6B 07            [ 1]  618 	ld	(0x07, sp), a
      0084D3 0F 08            [ 1]  619 	clr	(0x08, sp)
      0084D5                        620 00108$:
                                    621 ;	main.c: 180: if(buffer[i] == ' ')
      0084D5 5F               [ 1]  622 	clrw	x
      0084D6 7B 07            [ 1]  623 	ld	a, (0x07, sp)
      0084D8 97               [ 1]  624 	ld	xl, a
      0084D9 D6 00 01         [ 1]  625 	ld	a, (_buffer+0, x)
      0084DC A1 20            [ 1]  626 	cp	a, #0x20
      0084DE 26 04            [ 1]  627 	jrne	00105$
                                    628 ;	main.c: 182: i++;
      0084E0 0C 03            [ 1]  629 	inc	(0x03, sp)
                                    630 ;	main.c: 183: break;
      0084E2 20 12            [ 2]  631 	jra	00109$
      0084E4                        632 00105$:
                                    633 ;	main.c: 185: else if(buffer[i] == '\r\n')
      0084E4 A1 0D            [ 1]  634 	cp	a, #0x0d
      0084E6 27 0E            [ 1]  635 	jreq	00109$
                                    636 ;	main.c: 188: i++;
      0084E8 0C 07            [ 1]  637 	inc	(0x07, sp)
      0084EA 7B 07            [ 1]  638 	ld	a, (0x07, sp)
      0084EC 6B 03            [ 1]  639 	ld	(0x03, sp), a
                                    640 ;	main.c: 190: number_counter++;
      0084EE 0C 08            [ 1]  641 	inc	(0x08, sp)
      0084F0 7B 08            [ 1]  642 	ld	a, (0x08, sp)
      0084F2 6B 02            [ 1]  643 	ld	(0x02, sp), a
      0084F4 20 DF            [ 2]  644 	jra	00108$
      0084F6                        645 00109$:
                                    646 ;	main.c: 192: memcpy(a, &buffer[i - number_counter], number_counter);
      0084F6 90 5F            [ 1]  647 	clrw	y
      0084F8 7B 02            [ 1]  648 	ld	a, (0x02, sp)
      0084FA 90 97            [ 1]  649 	ld	yl, a
      0084FC 5F               [ 1]  650 	clrw	x
      0084FD 7B 03            [ 1]  651 	ld	a, (0x03, sp)
      0084FF 97               [ 1]  652 	ld	xl, a
      008500 7B 02            [ 1]  653 	ld	a, (0x02, sp)
      008502 6B 08            [ 1]  654 	ld	(0x08, sp), a
      008504 0F 07            [ 1]  655 	clr	(0x07, sp)
      008506 72 F0 07         [ 2]  656 	subw	x, (0x07, sp)
      008509 1C 00 01         [ 2]  657 	addw	x, #(_buffer+0)
      00850C 90 89            [ 2]  658 	pushw	y
      00850E 89               [ 2]  659 	pushw	x
      00850F AE 01 00         [ 2]  660 	ldw	x, #(_a+0)
      008512 CD 89 1F         [ 4]  661 	call	___memcpy
                                    662 ;	main.c: 193: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      008515 5F               [ 1]  663 	clrw	x
      008516 7B 04            [ 1]  664 	ld	a, (0x04, sp)
      008518 97               [ 1]  665 	ld	xl, a
      008519 1C 01 07         [ 2]  666 	addw	x, #(_data_buf+0)
      00851C 89               [ 2]  667 	pushw	x
      00851D 16 09            [ 2]  668 	ldw	y, (0x09, sp)
      00851F 90 89            [ 2]  669 	pushw	y
      008521 AE 01 00         [ 2]  670 	ldw	x, #(_a+0)
      008524 CD 83 A6         [ 4]  671 	call	_convert_chars_to_int
      008527 85               [ 2]  672 	popw	x
      008528 F7               [ 1]  673 	ld	(x), a
                                    674 ;	main.c: 194: int_buf_i++;
      008529 0C 04            [ 1]  675 	inc	(0x04, sp)
                                    676 ;	main.c: 175: for(int o = 0; o < counter;o++)
      00852B 1E 05            [ 2]  677 	ldw	x, (0x05, sp)
      00852D 5C               [ 1]  678 	incw	x
      00852E 1F 05            [ 2]  679 	ldw	(0x05, sp), x
      008530 20 8F            [ 2]  680 	jra	00112$
      008532                        681 00114$:
                                    682 ;	main.c: 196: }
      008532 5B 08            [ 2]  683 	addw	sp, #8
      008534 81               [ 4]  684 	ret
                                    685 ;	main.c: 204: void status_check(void){
                                    686 ;	-----------------------------------------
                                    687 ;	 function status_check
                                    688 ;	-----------------------------------------
      008535                        689 _status_check:
      008535 52 09            [ 2]  690 	sub	sp, #9
                                    691 ;	main.c: 205: char rx_binary_chars[9]={0};
      008537 0F 01            [ 1]  692 	clr	(0x01, sp)
      008539 0F 02            [ 1]  693 	clr	(0x02, sp)
      00853B 0F 03            [ 1]  694 	clr	(0x03, sp)
      00853D 0F 04            [ 1]  695 	clr	(0x04, sp)
      00853F 0F 05            [ 1]  696 	clr	(0x05, sp)
      008541 0F 06            [ 1]  697 	clr	(0x06, sp)
      008543 0F 07            [ 1]  698 	clr	(0x07, sp)
      008545 0F 08            [ 1]  699 	clr	(0x08, sp)
      008547 0F 09            [ 1]  700 	clr	(0x09, sp)
                                    701 ;	main.c: 206: uart_write("\nI2C_REGS >.<\n");
      008549 AE 80 2D         [ 2]  702 	ldw	x, #(___str_0+0)
      00854C CD 82 C0         [ 4]  703 	call	_uart_write
                                    704 ;	main.c: 227: convert_int_to_binary(I2C_DR, rx_binary_chars);
      00854F 96               [ 1]  705 	ldw	x, sp
      008550 5C               [ 1]  706 	incw	x
      008551 51               [ 1]  707 	exgw	x, y
      008552 C6 52 16         [ 1]  708 	ld	a, 0x5216
      008555 5F               [ 1]  709 	clrw	x
      008556 90 89            [ 2]  710 	pushw	y
      008558 97               [ 1]  711 	ld	xl, a
      008559 CD 83 CD         [ 4]  712 	call	_convert_int_to_binary
                                    713 ;	main.c: 228: uart_write("DR -> ");
      00855C AE 80 3C         [ 2]  714 	ldw	x, #(___str_1+0)
      00855F CD 82 C0         [ 4]  715 	call	_uart_write
                                    716 ;	main.c: 229: uart_write(rx_binary_chars);
      008562 96               [ 1]  717 	ldw	x, sp
      008563 5C               [ 1]  718 	incw	x
      008564 CD 82 C0         [ 4]  719 	call	_uart_write
                                    720 ;	main.c: 230: uart_write(" <-\n");
      008567 AE 80 43         [ 2]  721 	ldw	x, #(___str_2+0)
      00856A CD 82 C0         [ 4]  722 	call	_uart_write
                                    723 ;	main.c: 276: }
      00856D 5B 09            [ 2]  724 	addw	sp, #9
      00856F 81               [ 4]  725 	ret
                                    726 ;	main.c: 278: void uart_init(void){
                                    727 ;	-----------------------------------------
                                    728 ;	 function uart_init
                                    729 ;	-----------------------------------------
      008570                        730 _uart_init:
                                    731 ;	main.c: 279: CLK_CKDIVR = 0;
      008570 35 00 50 C6      [ 1]  732 	mov	0x50c6+0, #0x00
                                    733 ;	main.c: 282: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008574 72 16 52 35      [ 1]  734 	bset	0x5235, #3
                                    735 ;	main.c: 283: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      008578 72 14 52 35      [ 1]  736 	bset	0x5235, #2
                                    737 ;	main.c: 284: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      00857C C6 52 36         [ 1]  738 	ld	a, 0x5236
      00857F A4 CF            [ 1]  739 	and	a, #0xcf
      008581 C7 52 36         [ 1]  740 	ld	0x5236, a
                                    741 ;	main.c: 286: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008584 35 03 52 33      [ 1]  742 	mov	0x5233+0, #0x03
      008588 35 68 52 32      [ 1]  743 	mov	0x5232+0, #0x68
                                    744 ;	main.c: 287: }
      00858C 81               [ 4]  745 	ret
                                    746 ;	main.c: 291: void i2c_init(void) {
                                    747 ;	-----------------------------------------
                                    748 ;	 function i2c_init
                                    749 ;	-----------------------------------------
      00858D                        750 _i2c_init:
                                    751 ;	main.c: 297: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      00858D 72 11 52 10      [ 1]  752 	bres	0x5210, #0
                                    753 ;	main.c: 298: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008591 35 10 52 12      [ 1]  754 	mov	0x5212+0, #0x10
                                    755 ;	main.c: 299: I2C_CCRH = 0;                   // =0
      008595 35 00 52 1C      [ 1]  756 	mov	0x521c+0, #0x00
                                    757 ;	main.c: 300: I2C_CCRL = 80;                  // 100kHz for I2C
      008599 35 50 52 1B      [ 1]  758 	mov	0x521b+0, #0x50
                                    759 ;	main.c: 301: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      00859D 72 1F 52 1C      [ 1]  760 	bres	0x521c, #7
                                    761 ;	main.c: 302: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0085A1 72 1F 52 14      [ 1]  762 	bres	0x5214, #7
                                    763 ;	main.c: 303: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0085A5 72 1C 52 14      [ 1]  764 	bset	0x5214, #6
                                    765 ;	main.c: 304: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0085A9 72 10 52 10      [ 1]  766 	bset	0x5210, #0
                                    767 ;	main.c: 305: }
      0085AD 81               [ 4]  768 	ret
                                    769 ;	main.c: 314: void i2c_start(void) {
                                    770 ;	-----------------------------------------
                                    771 ;	 function i2c_start
                                    772 ;	-----------------------------------------
      0085AE                        773 _i2c_start:
                                    774 ;	main.c: 315: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0085AE 72 10 52 11      [ 1]  775 	bset	0x5211, #0
                                    776 ;	main.c: 316: while(!(I2C_SR1 & (1 << 0)));
      0085B2                        777 00101$:
      0085B2 72 01 52 17 FB   [ 2]  778 	btjf	0x5217, #0, 00101$
                                    779 ;	main.c: 318: }
      0085B7 81               [ 4]  780 	ret
                                    781 ;	main.c: 320: void i2c_send_address(uint8_t address) {
                                    782 ;	-----------------------------------------
                                    783 ;	 function i2c_send_address
                                    784 ;	-----------------------------------------
      0085B8                        785 _i2c_send_address:
                                    786 ;	main.c: 321: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0085B8 48               [ 1]  787 	sll	a
      0085B9 C7 52 16         [ 1]  788 	ld	0x5216, a
                                    789 ;	main.c: 322: status_check();
      0085BC CD 85 35         [ 4]  790 	call	_status_check
                                    791 ;	main.c: 323: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0085BF                        792 00102$:
      0085BF 72 03 52 17 01   [ 2]  793 	btjf	0x5217, #1, 00117$
      0085C4 81               [ 4]  794 	ret
      0085C5                        795 00117$:
      0085C5 72 05 52 18 F5   [ 2]  796 	btjf	0x5218, #2, 00102$
                                    797 ;	main.c: 324: }
      0085CA 81               [ 4]  798 	ret
                                    799 ;	main.c: 326: void i2c_stop(void) {
                                    800 ;	-----------------------------------------
                                    801 ;	 function i2c_stop
                                    802 ;	-----------------------------------------
      0085CB                        803 _i2c_stop:
                                    804 ;	main.c: 327: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      0085CB 72 12 52 11      [ 1]  805 	bset	0x5211, #1
                                    806 ;	main.c: 329: }
      0085CF 81               [ 4]  807 	ret
                                    808 ;	main.c: 330: void i2c_write(void){
                                    809 ;	-----------------------------------------
                                    810 ;	 function i2c_write
                                    811 ;	-----------------------------------------
      0085D0                        812 _i2c_write:
      0085D0 52 02            [ 2]  813 	sub	sp, #2
                                    814 ;	main.c: 331: I2C_DR = d_addr;
      0085D2 55 01 03 52 16   [ 1]  815 	mov	0x5216+0, _d_addr+0
                                    816 ;	main.c: 332: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2))); // Отправка адреса регистра
      0085D7                        817 00102$:
      0085D7 72 02 52 17 05   [ 2]  818 	btjt	0x5217, #1, 00120$
      0085DC 72 05 52 18 F6   [ 2]  819 	btjf	0x5218, #2, 00102$
                                    820 ;	main.c: 333: for(int i = 0;i < d_size;i++)
      0085E1                        821 00120$:
      0085E1 5F               [ 1]  822 	clrw	x
      0085E2                        823 00111$:
      0085E2 C6 01 05         [ 1]  824 	ld	a, _d_size+0
      0085E5 6B 02            [ 1]  825 	ld	(0x02, sp), a
      0085E7 0F 01            [ 1]  826 	clr	(0x01, sp)
      0085E9 13 01            [ 2]  827 	cpw	x, (0x01, sp)
      0085EB 2E 1B            [ 1]  828 	jrsge	00113$
                                    829 ;	main.c: 335: I2C_DR = data_buf[i];
      0085ED 90 93            [ 1]  830 	ldw	y, x
      0085EF 90 D6 01 07      [ 1]  831 	ld	a, (_data_buf+0, y)
      0085F3 C7 52 16         [ 1]  832 	ld	0x5216, a
                                    833 ;	main.c: 336: status_check();
      0085F6 89               [ 2]  834 	pushw	x
      0085F7 CD 85 35         [ 4]  835 	call	_status_check
      0085FA 85               [ 2]  836 	popw	x
                                    837 ;	main.c: 337: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0085FB                        838 00106$:
      0085FB 72 02 52 17 05   [ 2]  839 	btjt	0x5217, #1, 00112$
      008600 72 05 52 18 F6   [ 2]  840 	btjf	0x5218, #2, 00106$
      008605                        841 00112$:
                                    842 ;	main.c: 333: for(int i = 0;i < d_size;i++)
      008605 5C               [ 1]  843 	incw	x
      008606 20 DA            [ 2]  844 	jra	00111$
      008608                        845 00113$:
                                    846 ;	main.c: 339: }
      008608 5B 02            [ 2]  847 	addw	sp, #2
      00860A 81               [ 4]  848 	ret
                                    849 ;	main.c: 341: void i2c_read(void){
                                    850 ;	-----------------------------------------
                                    851 ;	 function i2c_read
                                    852 ;	-----------------------------------------
      00860B                        853 _i2c_read:
      00860B 52 02            [ 2]  854 	sub	sp, #2
                                    855 ;	main.c: 342: I2C_DR = (current_dev << 1) & (1 << 0);
      00860D C6 02 06         [ 1]  856 	ld	a, _current_dev+0
      008610 48               [ 1]  857 	sll	a
      008611 A4 01            [ 1]  858 	and	a, #0x01
      008613 C7 52 16         [ 1]  859 	ld	0x5216, a
                                    860 ;	main.c: 343: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008616                        861 00102$:
      008616 72 02 52 17 05   [ 2]  862 	btjt	0x5217, #1, 00104$
      00861B 72 05 52 18 F6   [ 2]  863 	btjf	0x5218, #2, 00102$
      008620                        864 00104$:
                                    865 ;	main.c: 345: I2C_DR = d_addr;
      008620 55 01 03 52 16   [ 1]  866 	mov	0x5216+0, _d_addr+0
                                    867 ;	main.c: 346: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008625                        868 00106$:
      008625 72 02 52 17 05   [ 2]  869 	btjt	0x5217, #1, 00108$
      00862A 72 05 52 18 F6   [ 2]  870 	btjf	0x5218, #2, 00106$
      00862F                        871 00108$:
                                    872 ;	main.c: 347: i2c_stop();
      00862F CD 85 CB         [ 4]  873 	call	_i2c_stop
                                    874 ;	main.c: 348: for(int i = 0;i < d_size;i++)
      008632 5F               [ 1]  875 	clrw	x
      008633                        876 00115$:
      008633 C6 01 05         [ 1]  877 	ld	a, _d_size+0
      008636 6B 02            [ 1]  878 	ld	(0x02, sp), a
      008638 0F 01            [ 1]  879 	clr	(0x01, sp)
      00863A 13 01            [ 2]  880 	cpw	x, (0x01, sp)
      00863C 2E 13            [ 1]  881 	jrsge	00117$
                                    882 ;	main.c: 350: data_buf[i] = I2C_DR;
      00863E C6 52 16         [ 1]  883 	ld	a, 0x5216
      008641 D7 01 07         [ 1]  884 	ld	((_data_buf+0), x), a
                                    885 ;	main.c: 351: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008644                        886 00110$:
      008644 72 02 52 17 05   [ 2]  887 	btjt	0x5217, #1, 00116$
      008649 72 05 52 18 F6   [ 2]  888 	btjf	0x5218, #2, 00110$
      00864E                        889 00116$:
                                    890 ;	main.c: 348: for(int i = 0;i < d_size;i++)
      00864E 5C               [ 1]  891 	incw	x
      00864F 20 E2            [ 2]  892 	jra	00115$
      008651                        893 00117$:
                                    894 ;	main.c: 354: }
      008651 5B 02            [ 2]  895 	addw	sp, #2
      008653 81               [ 4]  896 	ret
                                    897 ;	main.c: 355: void i2c_scan(void) {
                                    898 ;	-----------------------------------------
                                    899 ;	 function i2c_scan
                                    900 ;	-----------------------------------------
      008654                        901 _i2c_scan:
      008654 52 02            [ 2]  902 	sub	sp, #2
                                    903 ;	main.c: 356: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008656 C6 02 06         [ 1]  904 	ld	a, _current_dev+0
      008659 6B 01            [ 1]  905 	ld	(0x01, sp), a
      00865B 6B 02            [ 1]  906 	ld	(0x02, sp), a
      00865D                        907 00105$:
      00865D 7B 02            [ 1]  908 	ld	a, (0x02, sp)
      00865F A1 7F            [ 1]  909 	cp	a, #0x7f
      008661 24 26            [ 1]  910 	jrnc	00107$
                                    911 ;	main.c: 357: i2c_start();
      008663 CD 85 AE         [ 4]  912 	call	_i2c_start
                                    913 ;	main.c: 358: i2c_send_address(addr);
      008666 7B 02            [ 1]  914 	ld	a, (0x02, sp)
      008668 CD 85 B8         [ 4]  915 	call	_i2c_send_address
                                    916 ;	main.c: 359: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      00866B 72 04 52 18 0A   [ 2]  917 	btjt	0x5218, #2, 00102$
                                    918 ;	main.c: 361: current_dev = addr;
      008670 7B 01            [ 1]  919 	ld	a, (0x01, sp)
      008672 C7 02 06         [ 1]  920 	ld	_current_dev+0, a
                                    921 ;	main.c: 362: i2c_stop();
      008675 5B 02            [ 2]  922 	addw	sp, #2
                                    923 ;	main.c: 363: break;
      008677 CC 85 CB         [ 2]  924 	jp	_i2c_stop
      00867A                        925 00102$:
                                    926 ;	main.c: 365: i2c_stop();
      00867A CD 85 CB         [ 4]  927 	call	_i2c_stop
                                    928 ;	main.c: 366: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      00867D 72 15 52 18      [ 1]  929 	bres	0x5218, #2
                                    930 ;	main.c: 356: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008681 0C 02            [ 1]  931 	inc	(0x02, sp)
      008683 7B 02            [ 1]  932 	ld	a, (0x02, sp)
      008685 6B 01            [ 1]  933 	ld	(0x01, sp), a
      008687 20 D4            [ 2]  934 	jra	00105$
      008689                        935 00107$:
                                    936 ;	main.c: 368: }
      008689 5B 02            [ 2]  937 	addw	sp, #2
      00868B 81               [ 4]  938 	ret
                                    939 ;	main.c: 378: void cm_SM(void)
                                    940 ;	-----------------------------------------
                                    941 ;	 function cm_SM
                                    942 ;	-----------------------------------------
      00868C                        943 _cm_SM:
      00868C 52 04            [ 2]  944 	sub	sp, #4
                                    945 ;	main.c: 380: char cur_dev[4]={0};
      00868E 0F 01            [ 1]  946 	clr	(0x01, sp)
      008690 0F 02            [ 1]  947 	clr	(0x02, sp)
      008692 0F 03            [ 1]  948 	clr	(0x03, sp)
      008694 0F 04            [ 1]  949 	clr	(0x04, sp)
                                    950 ;	main.c: 381: convert_int_to_chars(current_dev, cur_dev);
      008696 96               [ 1]  951 	ldw	x, sp
      008697 5C               [ 1]  952 	incw	x
      008698 C6 02 06         [ 1]  953 	ld	a, _current_dev+0
      00869B CD 83 21         [ 4]  954 	call	_convert_int_to_chars
                                    955 ;	main.c: 382: uart_write("SM ");
      00869E AE 80 48         [ 2]  956 	ldw	x, #(___str_3+0)
      0086A1 CD 82 C0         [ 4]  957 	call	_uart_write
                                    958 ;	main.c: 383: uart_write(cur_dev);
      0086A4 96               [ 1]  959 	ldw	x, sp
      0086A5 5C               [ 1]  960 	incw	x
      0086A6 CD 82 C0         [ 4]  961 	call	_uart_write
                                    962 ;	main.c: 384: uart_write("\r\n");
      0086A9 AE 80 4C         [ 2]  963 	ldw	x, #(___str_4+0)
      0086AC CD 82 C0         [ 4]  964 	call	_uart_write
                                    965 ;	main.c: 385: }
      0086AF 5B 04            [ 2]  966 	addw	sp, #4
      0086B1 81               [ 4]  967 	ret
                                    968 ;	main.c: 386: void cm_SN(void)
                                    969 ;	-----------------------------------------
                                    970 ;	 function cm_SN
                                    971 ;	-----------------------------------------
      0086B2                        972 _cm_SN:
                                    973 ;	main.c: 388: i2c_scan();
      0086B2 CD 86 54         [ 4]  974 	call	_i2c_scan
                                    975 ;	main.c: 389: cm_SM();
                                    976 ;	main.c: 390: }
      0086B5 CC 86 8C         [ 2]  977 	jp	_cm_SM
                                    978 ;	main.c: 391: void cm_RM(void)
                                    979 ;	-----------------------------------------
                                    980 ;	 function cm_RM
                                    981 ;	-----------------------------------------
      0086B8                        982 _cm_RM:
                                    983 ;	main.c: 393: current_dev = 0;
      0086B8 72 5F 02 06      [ 1]  984 	clr	_current_dev+0
                                    985 ;	main.c: 394: uart_write("RM\n");
      0086BC AE 80 4F         [ 2]  986 	ldw	x, #(___str_5+0)
                                    987 ;	main.c: 395: }
      0086BF CC 82 C0         [ 2]  988 	jp	_uart_write
                                    989 ;	main.c: 397: void cm_DB(void)
                                    990 ;	-----------------------------------------
                                    991 ;	 function cm_DB
                                    992 ;	-----------------------------------------
      0086C2                        993 _cm_DB:
                                    994 ;	main.c: 399: status_check();
                                    995 ;	main.c: 400: }
      0086C2 CC 85 35         [ 2]  996 	jp	_status_check
                                    997 ;	main.c: 402: void cm_ST(void)
                                    998 ;	-----------------------------------------
                                    999 ;	 function cm_ST
                                   1000 ;	-----------------------------------------
      0086C5                       1001 _cm_ST:
                                   1002 ;	main.c: 404: get_addr_from_buff();
      0086C5 CD 84 05         [ 4] 1003 	call	_get_addr_from_buff
                                   1004 ;	main.c: 405: current_dev = d_addr;
      0086C8 55 01 03 02 06   [ 1] 1005 	mov	_current_dev+0, _d_addr+0
                                   1006 ;	main.c: 406: uart_write("ST\n");
      0086CD AE 80 53         [ 2] 1007 	ldw	x, #(___str_6+0)
                                   1008 ;	main.c: 407: }
      0086D0 CC 82 C0         [ 2] 1009 	jp	_uart_write
                                   1010 ;	main.c: 408: void cm_SR(void)
                                   1011 ;	-----------------------------------------
                                   1012 ;	 function cm_SR
                                   1013 ;	-----------------------------------------
      0086D3                       1014 _cm_SR:
      0086D3 52 04            [ 2] 1015 	sub	sp, #4
                                   1016 ;	main.c: 410: i2c_start();
      0086D5 CD 85 AE         [ 4] 1017 	call	_i2c_start
                                   1018 ;	main.c: 411: i2c_send_address(current_dev);
      0086D8 C6 02 06         [ 1] 1019 	ld	a, _current_dev+0
      0086DB CD 85 B8         [ 4] 1020 	call	_i2c_send_address
                                   1021 ;	main.c: 412: i2c_read();
      0086DE CD 86 0B         [ 4] 1022 	call	_i2c_read
                                   1023 ;	main.c: 413: i2c_stop();
      0086E1 CD 85 CB         [ 4] 1024 	call	_i2c_stop
                                   1025 ;	main.c: 414: uart_write("SR ");
      0086E4 AE 80 57         [ 2] 1026 	ldw	x, #(___str_7+0)
      0086E7 CD 82 C0         [ 4] 1027 	call	_uart_write
                                   1028 ;	main.c: 415: convert_int_to_chars(d_addr, a);
      0086EA AE 01 00         [ 2] 1029 	ldw	x, #(_a+0)
      0086ED C6 01 03         [ 1] 1030 	ld	a, _d_addr+0
      0086F0 CD 83 21         [ 4] 1031 	call	_convert_int_to_chars
                                   1032 ;	main.c: 416: uart_write(a);
      0086F3 AE 01 00         [ 2] 1033 	ldw	x, #(_a+0)
      0086F6 CD 82 C0         [ 4] 1034 	call	_uart_write
                                   1035 ;	main.c: 417: uart_write(" ");
      0086F9 AE 80 5B         [ 2] 1036 	ldw	x, #(___str_8+0)
      0086FC CD 82 C0         [ 4] 1037 	call	_uart_write
                                   1038 ;	main.c: 418: convert_int_to_chars(d_size, a);
      0086FF AE 01 00         [ 2] 1039 	ldw	x, #(_a+0)
      008702 C6 01 05         [ 1] 1040 	ld	a, _d_size+0
      008705 CD 83 21         [ 4] 1041 	call	_convert_int_to_chars
                                   1042 ;	main.c: 419: uart_write(a);
      008708 AE 01 00         [ 2] 1043 	ldw	x, #(_a+0)
      00870B CD 82 C0         [ 4] 1044 	call	_uart_write
                                   1045 ;	main.c: 420: for(int i = 0;i < d_size;i++)
      00870E 5F               [ 1] 1046 	clrw	x
      00870F 1F 03            [ 2] 1047 	ldw	(0x03, sp), x
      008711                       1048 00103$:
      008711 C6 01 05         [ 1] 1049 	ld	a, _d_size+0
      008714 6B 02            [ 1] 1050 	ld	(0x02, sp), a
      008716 0F 01            [ 1] 1051 	clr	(0x01, sp)
      008718 1E 03            [ 2] 1052 	ldw	x, (0x03, sp)
      00871A 13 01            [ 2] 1053 	cpw	x, (0x01, sp)
      00871C 2E 1E            [ 1] 1054 	jrsge	00101$
                                   1055 ;	main.c: 422: uart_write(" ");
      00871E AE 80 5B         [ 2] 1056 	ldw	x, #(___str_8+0)
      008721 CD 82 C0         [ 4] 1057 	call	_uart_write
                                   1058 ;	main.c: 423: convert_int_to_chars(data_buf[i], a);
      008724 1E 03            [ 2] 1059 	ldw	x, (0x03, sp)
      008726 D6 01 07         [ 1] 1060 	ld	a, (_data_buf+0, x)
      008729 AE 01 00         [ 2] 1061 	ldw	x, #(_a+0)
      00872C CD 83 21         [ 4] 1062 	call	_convert_int_to_chars
                                   1063 ;	main.c: 424: uart_write(a);
      00872F AE 01 00         [ 2] 1064 	ldw	x, #(_a+0)
      008732 CD 82 C0         [ 4] 1065 	call	_uart_write
                                   1066 ;	main.c: 420: for(int i = 0;i < d_size;i++)
      008735 1E 03            [ 2] 1067 	ldw	x, (0x03, sp)
      008737 5C               [ 1] 1068 	incw	x
      008738 1F 03            [ 2] 1069 	ldw	(0x03, sp), x
      00873A 20 D5            [ 2] 1070 	jra	00103$
      00873C                       1071 00101$:
                                   1072 ;	main.c: 427: uart_write("\r\n");
      00873C AE 80 4C         [ 2] 1073 	ldw	x, #(___str_4+0)
      00873F 5B 04            [ 2] 1074 	addw	sp, #4
                                   1075 ;	main.c: 428: }
      008741 CC 82 C0         [ 2] 1076 	jp	_uart_write
                                   1077 ;	main.c: 429: void cm_SW(void)
                                   1078 ;	-----------------------------------------
                                   1079 ;	 function cm_SW
                                   1080 ;	-----------------------------------------
      008744                       1081 _cm_SW:
      008744 52 04            [ 2] 1082 	sub	sp, #4
                                   1083 ;	main.c: 431: i2c_start();
      008746 CD 85 AE         [ 4] 1084 	call	_i2c_start
                                   1085 ;	main.c: 432: i2c_send_address(current_dev);
      008749 C6 02 06         [ 1] 1086 	ld	a, _current_dev+0
      00874C CD 85 B8         [ 4] 1087 	call	_i2c_send_address
                                   1088 ;	main.c: 433: i2c_write();
      00874F CD 85 D0         [ 4] 1089 	call	_i2c_write
                                   1090 ;	main.c: 434: i2c_stop();
      008752 CD 85 CB         [ 4] 1091 	call	_i2c_stop
                                   1092 ;	main.c: 435: uart_write("SW ");
      008755 AE 80 5D         [ 2] 1093 	ldw	x, #(___str_9+0)
      008758 CD 82 C0         [ 4] 1094 	call	_uart_write
                                   1095 ;	main.c: 436: convert_int_to_chars(d_addr, a);
      00875B AE 01 00         [ 2] 1096 	ldw	x, #(_a+0)
      00875E C6 01 03         [ 1] 1097 	ld	a, _d_addr+0
      008761 CD 83 21         [ 4] 1098 	call	_convert_int_to_chars
                                   1099 ;	main.c: 437: uart_write(a);
      008764 AE 01 00         [ 2] 1100 	ldw	x, #(_a+0)
      008767 CD 82 C0         [ 4] 1101 	call	_uart_write
                                   1102 ;	main.c: 438: uart_write(" ");
      00876A AE 80 5B         [ 2] 1103 	ldw	x, #(___str_8+0)
      00876D CD 82 C0         [ 4] 1104 	call	_uart_write
                                   1105 ;	main.c: 439: convert_int_to_chars(d_size, a);
      008770 AE 01 00         [ 2] 1106 	ldw	x, #(_a+0)
      008773 C6 01 05         [ 1] 1107 	ld	a, _d_size+0
      008776 CD 83 21         [ 4] 1108 	call	_convert_int_to_chars
                                   1109 ;	main.c: 440: uart_write(a);
      008779 AE 01 00         [ 2] 1110 	ldw	x, #(_a+0)
      00877C CD 82 C0         [ 4] 1111 	call	_uart_write
                                   1112 ;	main.c: 441: for(int i = 0;i < d_size;i++)
      00877F 5F               [ 1] 1113 	clrw	x
      008780 1F 03            [ 2] 1114 	ldw	(0x03, sp), x
      008782                       1115 00103$:
      008782 C6 01 05         [ 1] 1116 	ld	a, _d_size+0
      008785 6B 02            [ 1] 1117 	ld	(0x02, sp), a
      008787 0F 01            [ 1] 1118 	clr	(0x01, sp)
      008789 1E 03            [ 2] 1119 	ldw	x, (0x03, sp)
      00878B 13 01            [ 2] 1120 	cpw	x, (0x01, sp)
      00878D 2E 1E            [ 1] 1121 	jrsge	00101$
                                   1122 ;	main.c: 443: uart_write(" ");
      00878F AE 80 5B         [ 2] 1123 	ldw	x, #(___str_8+0)
      008792 CD 82 C0         [ 4] 1124 	call	_uart_write
                                   1125 ;	main.c: 444: convert_int_to_chars(data_buf[i], a);
      008795 1E 03            [ 2] 1126 	ldw	x, (0x03, sp)
      008797 D6 01 07         [ 1] 1127 	ld	a, (_data_buf+0, x)
      00879A AE 01 00         [ 2] 1128 	ldw	x, #(_a+0)
      00879D CD 83 21         [ 4] 1129 	call	_convert_int_to_chars
                                   1130 ;	main.c: 445: uart_write(a);
      0087A0 AE 01 00         [ 2] 1131 	ldw	x, #(_a+0)
      0087A3 CD 82 C0         [ 4] 1132 	call	_uart_write
                                   1133 ;	main.c: 441: for(int i = 0;i < d_size;i++)
      0087A6 1E 03            [ 2] 1134 	ldw	x, (0x03, sp)
      0087A8 5C               [ 1] 1135 	incw	x
      0087A9 1F 03            [ 2] 1136 	ldw	(0x03, sp), x
      0087AB 20 D5            [ 2] 1137 	jra	00103$
      0087AD                       1138 00101$:
                                   1139 ;	main.c: 448: uart_write("\r\n");
      0087AD AE 80 4C         [ 2] 1140 	ldw	x, #(___str_4+0)
      0087B0 5B 04            [ 2] 1141 	addw	sp, #4
                                   1142 ;	main.c: 449: }
      0087B2 CC 82 C0         [ 2] 1143 	jp	_uart_write
                                   1144 ;	main.c: 457: int data_handler(void)
                                   1145 ;	-----------------------------------------
                                   1146 ;	 function data_handler
                                   1147 ;	-----------------------------------------
      0087B5                       1148 _data_handler:
                                   1149 ;	main.c: 459: p_size = 0;
      0087B5 72 5F 01 04      [ 1] 1150 	clr	_p_size+0
                                   1151 ;	main.c: 460: p_bytes = 0;
      0087B9 72 5F 01 06      [ 1] 1152 	clr	_p_bytes+0
                                   1153 ;	main.c: 461: d_addr = 0;
      0087BD 72 5F 01 03      [ 1] 1154 	clr	_d_addr+0
                                   1155 ;	main.c: 462: d_size = 0;
      0087C1 72 5F 01 05      [ 1] 1156 	clr	_d_size+0
                                   1157 ;	main.c: 463: memset(a, 0, sizeof(a));
      0087C5 4B 03            [ 1] 1158 	push	#0x03
      0087C7 4B 00            [ 1] 1159 	push	#0x00
      0087C9 5F               [ 1] 1160 	clrw	x
      0087CA 89               [ 2] 1161 	pushw	x
      0087CB AE 01 00         [ 2] 1162 	ldw	x, #(_a+0)
      0087CE CD 89 72         [ 4] 1163 	call	_memset
                                   1164 ;	main.c: 464: memset(data_buf, 0, sizeof(data_buf));
      0087D1 4B FF            [ 1] 1165 	push	#0xff
      0087D3 4B 00            [ 1] 1166 	push	#0x00
      0087D5 5F               [ 1] 1167 	clrw	x
      0087D6 89               [ 2] 1168 	pushw	x
      0087D7 AE 01 07         [ 2] 1169 	ldw	x, #(_data_buf+0)
      0087DA CD 89 72         [ 4] 1170 	call	_memset
                                   1171 ;	main.c: 465: if(memcmp(&buffer[0],"SM",2) == 0)
      0087DD 4B 02            [ 1] 1172 	push	#0x02
      0087DF 4B 00            [ 1] 1173 	push	#0x00
      0087E1 4B 61            [ 1] 1174 	push	#<(___str_10+0)
      0087E3 4B 80            [ 1] 1175 	push	#((___str_10+0) >> 8)
      0087E5 AE 00 01         [ 2] 1176 	ldw	x, #(_buffer+0)
      0087E8 CD 88 DC         [ 4] 1177 	call	_memcmp
                                   1178 ;	main.c: 466: return 1;
      0087EB 5D               [ 2] 1179 	tnzw	x
      0087EC 26 02            [ 1] 1180 	jrne	00102$
      0087EE 5C               [ 1] 1181 	incw	x
      0087EF 81               [ 4] 1182 	ret
      0087F0                       1183 00102$:
                                   1184 ;	main.c: 467: if(memcmp(&buffer[0],"SN",2) == 0)
      0087F0 4B 02            [ 1] 1185 	push	#0x02
      0087F2 4B 00            [ 1] 1186 	push	#0x00
      0087F4 4B 64            [ 1] 1187 	push	#<(___str_11+0)
      0087F6 4B 80            [ 1] 1188 	push	#((___str_11+0) >> 8)
      0087F8 AE 00 01         [ 2] 1189 	ldw	x, #(_buffer+0)
      0087FB CD 88 DC         [ 4] 1190 	call	_memcmp
      0087FE 5D               [ 2] 1191 	tnzw	x
      0087FF 26 04            [ 1] 1192 	jrne	00104$
                                   1193 ;	main.c: 468: return 2;
      008801 AE 00 02         [ 2] 1194 	ldw	x, #0x0002
      008804 81               [ 4] 1195 	ret
      008805                       1196 00104$:
                                   1197 ;	main.c: 469: if(memcmp(&buffer[0],"ST",2) == 0)
      008805 4B 02            [ 1] 1198 	push	#0x02
      008807 4B 00            [ 1] 1199 	push	#0x00
      008809 4B 67            [ 1] 1200 	push	#<(___str_12+0)
      00880B 4B 80            [ 1] 1201 	push	#((___str_12+0) >> 8)
      00880D AE 00 01         [ 2] 1202 	ldw	x, #(_buffer+0)
      008810 CD 88 DC         [ 4] 1203 	call	_memcmp
      008813 5D               [ 2] 1204 	tnzw	x
      008814 26 04            [ 1] 1205 	jrne	00106$
                                   1206 ;	main.c: 470: return 5;
      008816 AE 00 05         [ 2] 1207 	ldw	x, #0x0005
      008819 81               [ 4] 1208 	ret
      00881A                       1209 00106$:
                                   1210 ;	main.c: 471: if(memcmp(&buffer[0],"RM",2) == 0)
      00881A 4B 02            [ 1] 1211 	push	#0x02
      00881C 4B 00            [ 1] 1212 	push	#0x00
      00881E 4B 6A            [ 1] 1213 	push	#<(___str_13+0)
      008820 4B 80            [ 1] 1214 	push	#((___str_13+0) >> 8)
      008822 AE 00 01         [ 2] 1215 	ldw	x, #(_buffer+0)
      008825 CD 88 DC         [ 4] 1216 	call	_memcmp
      008828 5D               [ 2] 1217 	tnzw	x
      008829 26 04            [ 1] 1218 	jrne	00108$
                                   1219 ;	main.c: 472: return 6;
      00882B AE 00 06         [ 2] 1220 	ldw	x, #0x0006
      00882E 81               [ 4] 1221 	ret
      00882F                       1222 00108$:
                                   1223 ;	main.c: 473: if(memcmp(&buffer[0],"DB",2) == 0)
      00882F 4B 02            [ 1] 1224 	push	#0x02
      008831 4B 00            [ 1] 1225 	push	#0x00
      008833 4B 6D            [ 1] 1226 	push	#<(___str_14+0)
      008835 4B 80            [ 1] 1227 	push	#((___str_14+0) >> 8)
      008837 AE 00 01         [ 2] 1228 	ldw	x, #(_buffer+0)
      00883A CD 88 DC         [ 4] 1229 	call	_memcmp
      00883D 5D               [ 2] 1230 	tnzw	x
      00883E 26 04            [ 1] 1231 	jrne	00110$
                                   1232 ;	main.c: 474: return 7;
      008840 AE 00 07         [ 2] 1233 	ldw	x, #0x0007
      008843 81               [ 4] 1234 	ret
      008844                       1235 00110$:
                                   1236 ;	main.c: 476: get_addr_from_buff();
      008844 CD 84 05         [ 4] 1237 	call	_get_addr_from_buff
                                   1238 ;	main.c: 477: get_size_from_buff();
      008847 CD 84 4A         [ 4] 1239 	call	_get_size_from_buff
                                   1240 ;	main.c: 479: if(memcmp(&buffer[0],"SR",2) == 0)
      00884A 4B 02            [ 1] 1241 	push	#0x02
      00884C 4B 00            [ 1] 1242 	push	#0x00
      00884E 4B 70            [ 1] 1243 	push	#<(___str_15+0)
      008850 4B 80            [ 1] 1244 	push	#((___str_15+0) >> 8)
      008852 AE 00 01         [ 2] 1245 	ldw	x, #(_buffer+0)
      008855 CD 88 DC         [ 4] 1246 	call	_memcmp
      008858 5D               [ 2] 1247 	tnzw	x
      008859 26 04            [ 1] 1248 	jrne	00112$
                                   1249 ;	main.c: 480: return 3;
      00885B AE 00 03         [ 2] 1250 	ldw	x, #0x0003
      00885E 81               [ 4] 1251 	ret
      00885F                       1252 00112$:
                                   1253 ;	main.c: 482: char_buffer_to_int();
      00885F CD 84 A4         [ 4] 1254 	call	_char_buffer_to_int
                                   1255 ;	main.c: 484: if(memcmp(&buffer[0],"SW",2) == 0)
      008862 4B 02            [ 1] 1256 	push	#0x02
      008864 4B 00            [ 1] 1257 	push	#0x00
      008866 4B 73            [ 1] 1258 	push	#<(___str_16+0)
      008868 4B 80            [ 1] 1259 	push	#((___str_16+0) >> 8)
      00886A AE 00 01         [ 2] 1260 	ldw	x, #(_buffer+0)
      00886D CD 88 DC         [ 4] 1261 	call	_memcmp
      008870 5D               [ 2] 1262 	tnzw	x
      008871 26 04            [ 1] 1263 	jrne	00114$
                                   1264 ;	main.c: 485: return 4;
      008873 AE 00 04         [ 2] 1265 	ldw	x, #0x0004
      008876 81               [ 4] 1266 	ret
      008877                       1267 00114$:
                                   1268 ;	main.c: 486: return 0;
      008877 5F               [ 1] 1269 	clrw	x
                                   1270 ;	main.c: 488: }
      008878 81               [ 4] 1271 	ret
                                   1272 ;	main.c: 490: void command_switcher(void)
                                   1273 ;	-----------------------------------------
                                   1274 ;	 function command_switcher
                                   1275 ;	-----------------------------------------
      008879                       1276 _command_switcher:
      008879 52 04            [ 2] 1277 	sub	sp, #4
                                   1278 ;	main.c: 492: char ar[4]={0};
      00887B 0F 01            [ 1] 1279 	clr	(0x01, sp)
      00887D 0F 02            [ 1] 1280 	clr	(0x02, sp)
      00887F 0F 03            [ 1] 1281 	clr	(0x03, sp)
      008881 0F 04            [ 1] 1282 	clr	(0x04, sp)
                                   1283 ;	main.c: 494: switch(data_handler())
      008883 CD 87 B5         [ 4] 1284 	call	_data_handler
      008886 5D               [ 2] 1285 	tnzw	x
      008887 2B 3B            [ 1] 1286 	jrmi	00109$
      008889 A3 00 07         [ 2] 1287 	cpw	x, #0x0007
      00888C 2C 36            [ 1] 1288 	jrsgt	00109$
      00888E 58               [ 2] 1289 	sllw	x
      00888F DE 88 93         [ 2] 1290 	ldw	x, (#00123$, x)
      008892 FC               [ 2] 1291 	jp	(x)
      008893                       1292 00123$:
      008893 88 C4                 1293 	.dw	#00109$
      008895 88 A3                 1294 	.dw	#00101$
      008897 88 A8                 1295 	.dw	#00102$
      008899 88 AD                 1296 	.dw	#00103$
      00889B 88 B2                 1297 	.dw	#00104$
      00889D 88 B7                 1298 	.dw	#00105$
      00889F 88 BC                 1299 	.dw	#00106$
      0088A1 88 C1                 1300 	.dw	#00107$
                                   1301 ;	main.c: 496: case 1:
      0088A3                       1302 00101$:
                                   1303 ;	main.c: 497: cm_SM();
      0088A3 CD 86 8C         [ 4] 1304 	call	_cm_SM
                                   1305 ;	main.c: 498: break;
      0088A6 20 1C            [ 2] 1306 	jra	00109$
                                   1307 ;	main.c: 499: case 2:
      0088A8                       1308 00102$:
                                   1309 ;	main.c: 500: cm_SN();
      0088A8 CD 86 B2         [ 4] 1310 	call	_cm_SN
                                   1311 ;	main.c: 501: break;
      0088AB 20 17            [ 2] 1312 	jra	00109$
                                   1313 ;	main.c: 502: case 3:
      0088AD                       1314 00103$:
                                   1315 ;	main.c: 503: cm_SR();
      0088AD CD 86 D3         [ 4] 1316 	call	_cm_SR
                                   1317 ;	main.c: 504: break;
      0088B0 20 12            [ 2] 1318 	jra	00109$
                                   1319 ;	main.c: 505: case 4:
      0088B2                       1320 00104$:
                                   1321 ;	main.c: 506: cm_SW();
      0088B2 CD 87 44         [ 4] 1322 	call	_cm_SW
                                   1323 ;	main.c: 507: break;
      0088B5 20 0D            [ 2] 1324 	jra	00109$
                                   1325 ;	main.c: 508: case 5:
      0088B7                       1326 00105$:
                                   1327 ;	main.c: 509: cm_ST();
      0088B7 CD 86 C5         [ 4] 1328 	call	_cm_ST
                                   1329 ;	main.c: 510: break;
      0088BA 20 08            [ 2] 1330 	jra	00109$
                                   1331 ;	main.c: 511: case 6:
      0088BC                       1332 00106$:
                                   1333 ;	main.c: 512: cm_RM();
      0088BC CD 86 B8         [ 4] 1334 	call	_cm_RM
                                   1335 ;	main.c: 513: break;
      0088BF 20 03            [ 2] 1336 	jra	00109$
                                   1337 ;	main.c: 514: case 7:
      0088C1                       1338 00107$:
                                   1339 ;	main.c: 515: cm_DB();
      0088C1 CD 86 C2         [ 4] 1340 	call	_cm_DB
                                   1341 ;	main.c: 517: }
      0088C4                       1342 00109$:
                                   1343 ;	main.c: 518: }
      0088C4 5B 04            [ 2] 1344 	addw	sp, #4
      0088C6 81               [ 4] 1345 	ret
                                   1346 ;	main.c: 521: void main(void)
                                   1347 ;	-----------------------------------------
                                   1348 ;	 function main
                                   1349 ;	-----------------------------------------
      0088C7                       1350 _main:
                                   1351 ;	main.c: 523: uart_init();
      0088C7 CD 85 70         [ 4] 1352 	call	_uart_init
                                   1353 ;	main.c: 524: i2c_init();
      0088CA CD 85 8D         [ 4] 1354 	call	_i2c_init
                                   1355 ;	main.c: 525: uart_write("SS\n");
      0088CD AE 80 76         [ 2] 1356 	ldw	x, #(___str_17+0)
      0088D0 CD 82 C0         [ 4] 1357 	call	_uart_write
                                   1358 ;	main.c: 526: while(1)
      0088D3                       1359 00102$:
                                   1360 ;	main.c: 528: uart_read();
      0088D3 CD 82 EB         [ 4] 1361 	call	_uart_read
                                   1362 ;	main.c: 529: command_switcher();
      0088D6 CD 88 79         [ 4] 1363 	call	_command_switcher
      0088D9 20 F8            [ 2] 1364 	jra	00102$
                                   1365 ;	main.c: 531: }
      0088DB 81               [ 4] 1366 	ret
                                   1367 	.area CODE
                                   1368 	.area CONST
                                   1369 	.area CONST
      00802D                       1370 ___str_0:
      00802D 0A                    1371 	.db 0x0a
      00802E 49 32 43 5F 52 45 47  1372 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                    1373 	.db 0x0a
      00803B 00                    1374 	.db 0x00
                                   1375 	.area CODE
                                   1376 	.area CONST
      00803C                       1377 ___str_1:
      00803C 44 52 20 2D 3E 20     1378 	.ascii "DR -> "
      008042 00                    1379 	.db 0x00
                                   1380 	.area CODE
                                   1381 	.area CONST
      008043                       1382 ___str_2:
      008043 20 3C 2D              1383 	.ascii " <-"
      008046 0A                    1384 	.db 0x0a
      008047 00                    1385 	.db 0x00
                                   1386 	.area CODE
                                   1387 	.area CONST
      008048                       1388 ___str_3:
      008048 53 4D 20              1389 	.ascii "SM "
      00804B 00                    1390 	.db 0x00
                                   1391 	.area CODE
                                   1392 	.area CONST
      00804C                       1393 ___str_4:
      00804C 0D                    1394 	.db 0x0d
      00804D 0A                    1395 	.db 0x0a
      00804E 00                    1396 	.db 0x00
                                   1397 	.area CODE
                                   1398 	.area CONST
      00804F                       1399 ___str_5:
      00804F 52 4D                 1400 	.ascii "RM"
      008051 0A                    1401 	.db 0x0a
      008052 00                    1402 	.db 0x00
                                   1403 	.area CODE
                                   1404 	.area CONST
      008053                       1405 ___str_6:
      008053 53 54                 1406 	.ascii "ST"
      008055 0A                    1407 	.db 0x0a
      008056 00                    1408 	.db 0x00
                                   1409 	.area CODE
                                   1410 	.area CONST
      008057                       1411 ___str_7:
      008057 53 52 20              1412 	.ascii "SR "
      00805A 00                    1413 	.db 0x00
                                   1414 	.area CODE
                                   1415 	.area CONST
      00805B                       1416 ___str_8:
      00805B 20                    1417 	.ascii " "
      00805C 00                    1418 	.db 0x00
                                   1419 	.area CODE
                                   1420 	.area CONST
      00805D                       1421 ___str_9:
      00805D 53 57 20              1422 	.ascii "SW "
      008060 00                    1423 	.db 0x00
                                   1424 	.area CODE
                                   1425 	.area CONST
      008061                       1426 ___str_10:
      008061 53 4D                 1427 	.ascii "SM"
      008063 00                    1428 	.db 0x00
                                   1429 	.area CODE
                                   1430 	.area CONST
      008064                       1431 ___str_11:
      008064 53 4E                 1432 	.ascii "SN"
      008066 00                    1433 	.db 0x00
                                   1434 	.area CODE
                                   1435 	.area CONST
      008067                       1436 ___str_12:
      008067 53 54                 1437 	.ascii "ST"
      008069 00                    1438 	.db 0x00
                                   1439 	.area CODE
                                   1440 	.area CONST
      00806A                       1441 ___str_13:
      00806A 52 4D                 1442 	.ascii "RM"
      00806C 00                    1443 	.db 0x00
                                   1444 	.area CODE
                                   1445 	.area CONST
      00806D                       1446 ___str_14:
      00806D 44 42                 1447 	.ascii "DB"
      00806F 00                    1448 	.db 0x00
                                   1449 	.area CODE
                                   1450 	.area CONST
      008070                       1451 ___str_15:
      008070 53 52                 1452 	.ascii "SR"
      008072 00                    1453 	.db 0x00
                                   1454 	.area CODE
                                   1455 	.area CONST
      008073                       1456 ___str_16:
      008073 53 57                 1457 	.ascii "SW"
      008075 00                    1458 	.db 0x00
                                   1459 	.area CODE
                                   1460 	.area CONST
      008076                       1461 ___str_17:
      008076 53 53                 1462 	.ascii "SS"
      008078 0A                    1463 	.db 0x0a
      008079 00                    1464 	.db 0x00
                                   1465 	.area CODE
                                   1466 	.area INITIALIZER
      00807A                       1467 __xinit__buffer:
      00807A 00                    1468 	.db #0x00	; 0
      00807B 00                    1469 	.db 0x00
      00807C 00                    1470 	.db 0x00
      00807D 00                    1471 	.db 0x00
      00807E 00                    1472 	.db 0x00
      00807F 00                    1473 	.db 0x00
      008080 00                    1474 	.db 0x00
      008081 00                    1475 	.db 0x00
      008082 00                    1476 	.db 0x00
      008083 00                    1477 	.db 0x00
      008084 00                    1478 	.db 0x00
      008085 00                    1479 	.db 0x00
      008086 00                    1480 	.db 0x00
      008087 00                    1481 	.db 0x00
      008088 00                    1482 	.db 0x00
      008089 00                    1483 	.db 0x00
      00808A 00                    1484 	.db 0x00
      00808B 00                    1485 	.db 0x00
      00808C 00                    1486 	.db 0x00
      00808D 00                    1487 	.db 0x00
      00808E 00                    1488 	.db 0x00
      00808F 00                    1489 	.db 0x00
      008090 00                    1490 	.db 0x00
      008091 00                    1491 	.db 0x00
      008092 00                    1492 	.db 0x00
      008093 00                    1493 	.db 0x00
      008094 00                    1494 	.db 0x00
      008095 00                    1495 	.db 0x00
      008096 00                    1496 	.db 0x00
      008097 00                    1497 	.db 0x00
      008098 00                    1498 	.db 0x00
      008099 00                    1499 	.db 0x00
      00809A 00                    1500 	.db 0x00
      00809B 00                    1501 	.db 0x00
      00809C 00                    1502 	.db 0x00
      00809D 00                    1503 	.db 0x00
      00809E 00                    1504 	.db 0x00
      00809F 00                    1505 	.db 0x00
      0080A0 00                    1506 	.db 0x00
      0080A1 00                    1507 	.db 0x00
      0080A2 00                    1508 	.db 0x00
      0080A3 00                    1509 	.db 0x00
      0080A4 00                    1510 	.db 0x00
      0080A5 00                    1511 	.db 0x00
      0080A6 00                    1512 	.db 0x00
      0080A7 00                    1513 	.db 0x00
      0080A8 00                    1514 	.db 0x00
      0080A9 00                    1515 	.db 0x00
      0080AA 00                    1516 	.db 0x00
      0080AB 00                    1517 	.db 0x00
      0080AC 00                    1518 	.db 0x00
      0080AD 00                    1519 	.db 0x00
      0080AE 00                    1520 	.db 0x00
      0080AF 00                    1521 	.db 0x00
      0080B0 00                    1522 	.db 0x00
      0080B1 00                    1523 	.db 0x00
      0080B2 00                    1524 	.db 0x00
      0080B3 00                    1525 	.db 0x00
      0080B4 00                    1526 	.db 0x00
      0080B5 00                    1527 	.db 0x00
      0080B6 00                    1528 	.db 0x00
      0080B7 00                    1529 	.db 0x00
      0080B8 00                    1530 	.db 0x00
      0080B9 00                    1531 	.db 0x00
      0080BA 00                    1532 	.db 0x00
      0080BB 00                    1533 	.db 0x00
      0080BC 00                    1534 	.db 0x00
      0080BD 00                    1535 	.db 0x00
      0080BE 00                    1536 	.db 0x00
      0080BF 00                    1537 	.db 0x00
      0080C0 00                    1538 	.db 0x00
      0080C1 00                    1539 	.db 0x00
      0080C2 00                    1540 	.db 0x00
      0080C3 00                    1541 	.db 0x00
      0080C4 00                    1542 	.db 0x00
      0080C5 00                    1543 	.db 0x00
      0080C6 00                    1544 	.db 0x00
      0080C7 00                    1545 	.db 0x00
      0080C8 00                    1546 	.db 0x00
      0080C9 00                    1547 	.db 0x00
      0080CA 00                    1548 	.db 0x00
      0080CB 00                    1549 	.db 0x00
      0080CC 00                    1550 	.db 0x00
      0080CD 00                    1551 	.db 0x00
      0080CE 00                    1552 	.db 0x00
      0080CF 00                    1553 	.db 0x00
      0080D0 00                    1554 	.db 0x00
      0080D1 00                    1555 	.db 0x00
      0080D2 00                    1556 	.db 0x00
      0080D3 00                    1557 	.db 0x00
      0080D4 00                    1558 	.db 0x00
      0080D5 00                    1559 	.db 0x00
      0080D6 00                    1560 	.db 0x00
      0080D7 00                    1561 	.db 0x00
      0080D8 00                    1562 	.db 0x00
      0080D9 00                    1563 	.db 0x00
      0080DA 00                    1564 	.db 0x00
      0080DB 00                    1565 	.db 0x00
      0080DC 00                    1566 	.db 0x00
      0080DD 00                    1567 	.db 0x00
      0080DE 00                    1568 	.db 0x00
      0080DF 00                    1569 	.db 0x00
      0080E0 00                    1570 	.db 0x00
      0080E1 00                    1571 	.db 0x00
      0080E2 00                    1572 	.db 0x00
      0080E3 00                    1573 	.db 0x00
      0080E4 00                    1574 	.db 0x00
      0080E5 00                    1575 	.db 0x00
      0080E6 00                    1576 	.db 0x00
      0080E7 00                    1577 	.db 0x00
      0080E8 00                    1578 	.db 0x00
      0080E9 00                    1579 	.db 0x00
      0080EA 00                    1580 	.db 0x00
      0080EB 00                    1581 	.db 0x00
      0080EC 00                    1582 	.db 0x00
      0080ED 00                    1583 	.db 0x00
      0080EE 00                    1584 	.db 0x00
      0080EF 00                    1585 	.db 0x00
      0080F0 00                    1586 	.db 0x00
      0080F1 00                    1587 	.db 0x00
      0080F2 00                    1588 	.db 0x00
      0080F3 00                    1589 	.db 0x00
      0080F4 00                    1590 	.db 0x00
      0080F5 00                    1591 	.db 0x00
      0080F6 00                    1592 	.db 0x00
      0080F7 00                    1593 	.db 0x00
      0080F8 00                    1594 	.db 0x00
      0080F9 00                    1595 	.db 0x00
      0080FA 00                    1596 	.db 0x00
      0080FB 00                    1597 	.db 0x00
      0080FC 00                    1598 	.db 0x00
      0080FD 00                    1599 	.db 0x00
      0080FE 00                    1600 	.db 0x00
      0080FF 00                    1601 	.db 0x00
      008100 00                    1602 	.db 0x00
      008101 00                    1603 	.db 0x00
      008102 00                    1604 	.db 0x00
      008103 00                    1605 	.db 0x00
      008104 00                    1606 	.db 0x00
      008105 00                    1607 	.db 0x00
      008106 00                    1608 	.db 0x00
      008107 00                    1609 	.db 0x00
      008108 00                    1610 	.db 0x00
      008109 00                    1611 	.db 0x00
      00810A 00                    1612 	.db 0x00
      00810B 00                    1613 	.db 0x00
      00810C 00                    1614 	.db 0x00
      00810D 00                    1615 	.db 0x00
      00810E 00                    1616 	.db 0x00
      00810F 00                    1617 	.db 0x00
      008110 00                    1618 	.db 0x00
      008111 00                    1619 	.db 0x00
      008112 00                    1620 	.db 0x00
      008113 00                    1621 	.db 0x00
      008114 00                    1622 	.db 0x00
      008115 00                    1623 	.db 0x00
      008116 00                    1624 	.db 0x00
      008117 00                    1625 	.db 0x00
      008118 00                    1626 	.db 0x00
      008119 00                    1627 	.db 0x00
      00811A 00                    1628 	.db 0x00
      00811B 00                    1629 	.db 0x00
      00811C 00                    1630 	.db 0x00
      00811D 00                    1631 	.db 0x00
      00811E 00                    1632 	.db 0x00
      00811F 00                    1633 	.db 0x00
      008120 00                    1634 	.db 0x00
      008121 00                    1635 	.db 0x00
      008122 00                    1636 	.db 0x00
      008123 00                    1637 	.db 0x00
      008124 00                    1638 	.db 0x00
      008125 00                    1639 	.db 0x00
      008126 00                    1640 	.db 0x00
      008127 00                    1641 	.db 0x00
      008128 00                    1642 	.db 0x00
      008129 00                    1643 	.db 0x00
      00812A 00                    1644 	.db 0x00
      00812B 00                    1645 	.db 0x00
      00812C 00                    1646 	.db 0x00
      00812D 00                    1647 	.db 0x00
      00812E 00                    1648 	.db 0x00
      00812F 00                    1649 	.db 0x00
      008130 00                    1650 	.db 0x00
      008131 00                    1651 	.db 0x00
      008132 00                    1652 	.db 0x00
      008133 00                    1653 	.db 0x00
      008134 00                    1654 	.db 0x00
      008135 00                    1655 	.db 0x00
      008136 00                    1656 	.db 0x00
      008137 00                    1657 	.db 0x00
      008138 00                    1658 	.db 0x00
      008139 00                    1659 	.db 0x00
      00813A 00                    1660 	.db 0x00
      00813B 00                    1661 	.db 0x00
      00813C 00                    1662 	.db 0x00
      00813D 00                    1663 	.db 0x00
      00813E 00                    1664 	.db 0x00
      00813F 00                    1665 	.db 0x00
      008140 00                    1666 	.db 0x00
      008141 00                    1667 	.db 0x00
      008142 00                    1668 	.db 0x00
      008143 00                    1669 	.db 0x00
      008144 00                    1670 	.db 0x00
      008145 00                    1671 	.db 0x00
      008146 00                    1672 	.db 0x00
      008147 00                    1673 	.db 0x00
      008148 00                    1674 	.db 0x00
      008149 00                    1675 	.db 0x00
      00814A 00                    1676 	.db 0x00
      00814B 00                    1677 	.db 0x00
      00814C 00                    1678 	.db 0x00
      00814D 00                    1679 	.db 0x00
      00814E 00                    1680 	.db 0x00
      00814F 00                    1681 	.db 0x00
      008150 00                    1682 	.db 0x00
      008151 00                    1683 	.db 0x00
      008152 00                    1684 	.db 0x00
      008153 00                    1685 	.db 0x00
      008154 00                    1686 	.db 0x00
      008155 00                    1687 	.db 0x00
      008156 00                    1688 	.db 0x00
      008157 00                    1689 	.db 0x00
      008158 00                    1690 	.db 0x00
      008159 00                    1691 	.db 0x00
      00815A 00                    1692 	.db 0x00
      00815B 00                    1693 	.db 0x00
      00815C 00                    1694 	.db 0x00
      00815D 00                    1695 	.db 0x00
      00815E 00                    1696 	.db 0x00
      00815F 00                    1697 	.db 0x00
      008160 00                    1698 	.db 0x00
      008161 00                    1699 	.db 0x00
      008162 00                    1700 	.db 0x00
      008163 00                    1701 	.db 0x00
      008164 00                    1702 	.db 0x00
      008165 00                    1703 	.db 0x00
      008166 00                    1704 	.db 0x00
      008167 00                    1705 	.db 0x00
      008168 00                    1706 	.db 0x00
      008169 00                    1707 	.db 0x00
      00816A 00                    1708 	.db 0x00
      00816B 00                    1709 	.db 0x00
      00816C 00                    1710 	.db 0x00
      00816D 00                    1711 	.db 0x00
      00816E 00                    1712 	.db 0x00
      00816F 00                    1713 	.db 0x00
      008170 00                    1714 	.db 0x00
      008171 00                    1715 	.db 0x00
      008172 00                    1716 	.db 0x00
      008173 00                    1717 	.db 0x00
      008174 00                    1718 	.db 0x00
      008175 00                    1719 	.db 0x00
      008176 00                    1720 	.db 0x00
      008177 00                    1721 	.db 0x00
      008178 00                    1722 	.db 0x00
      008179                       1723 __xinit__a:
      008179 00                    1724 	.db #0x00	; 0
      00817A 00                    1725 	.db 0x00
      00817B 00                    1726 	.db 0x00
      00817C                       1727 __xinit__d_addr:
      00817C 00                    1728 	.db #0x00	; 0
      00817D                       1729 __xinit__p_size:
      00817D 00                    1730 	.db #0x00	; 0
      00817E                       1731 __xinit__d_size:
      00817E 00                    1732 	.db #0x00	; 0
      00817F                       1733 __xinit__p_bytes:
      00817F 00                    1734 	.db #0x00	; 0
      008180                       1735 __xinit__data_buf:
      008180 00                    1736 	.db #0x00	; 0
      008181 00                    1737 	.db 0x00
      008182 00                    1738 	.db 0x00
      008183 00                    1739 	.db 0x00
      008184 00                    1740 	.db 0x00
      008185 00                    1741 	.db 0x00
      008186 00                    1742 	.db 0x00
      008187 00                    1743 	.db 0x00
      008188 00                    1744 	.db 0x00
      008189 00                    1745 	.db 0x00
      00818A 00                    1746 	.db 0x00
      00818B 00                    1747 	.db 0x00
      00818C 00                    1748 	.db 0x00
      00818D 00                    1749 	.db 0x00
      00818E 00                    1750 	.db 0x00
      00818F 00                    1751 	.db 0x00
      008190 00                    1752 	.db 0x00
      008191 00                    1753 	.db 0x00
      008192 00                    1754 	.db 0x00
      008193 00                    1755 	.db 0x00
      008194 00                    1756 	.db 0x00
      008195 00                    1757 	.db 0x00
      008196 00                    1758 	.db 0x00
      008197 00                    1759 	.db 0x00
      008198 00                    1760 	.db 0x00
      008199 00                    1761 	.db 0x00
      00819A 00                    1762 	.db 0x00
      00819B 00                    1763 	.db 0x00
      00819C 00                    1764 	.db 0x00
      00819D 00                    1765 	.db 0x00
      00819E 00                    1766 	.db 0x00
      00819F 00                    1767 	.db 0x00
      0081A0 00                    1768 	.db 0x00
      0081A1 00                    1769 	.db 0x00
      0081A2 00                    1770 	.db 0x00
      0081A3 00                    1771 	.db 0x00
      0081A4 00                    1772 	.db 0x00
      0081A5 00                    1773 	.db 0x00
      0081A6 00                    1774 	.db 0x00
      0081A7 00                    1775 	.db 0x00
      0081A8 00                    1776 	.db 0x00
      0081A9 00                    1777 	.db 0x00
      0081AA 00                    1778 	.db 0x00
      0081AB 00                    1779 	.db 0x00
      0081AC 00                    1780 	.db 0x00
      0081AD 00                    1781 	.db 0x00
      0081AE 00                    1782 	.db 0x00
      0081AF 00                    1783 	.db 0x00
      0081B0 00                    1784 	.db 0x00
      0081B1 00                    1785 	.db 0x00
      0081B2 00                    1786 	.db 0x00
      0081B3 00                    1787 	.db 0x00
      0081B4 00                    1788 	.db 0x00
      0081B5 00                    1789 	.db 0x00
      0081B6 00                    1790 	.db 0x00
      0081B7 00                    1791 	.db 0x00
      0081B8 00                    1792 	.db 0x00
      0081B9 00                    1793 	.db 0x00
      0081BA 00                    1794 	.db 0x00
      0081BB 00                    1795 	.db 0x00
      0081BC 00                    1796 	.db 0x00
      0081BD 00                    1797 	.db 0x00
      0081BE 00                    1798 	.db 0x00
      0081BF 00                    1799 	.db 0x00
      0081C0 00                    1800 	.db 0x00
      0081C1 00                    1801 	.db 0x00
      0081C2 00                    1802 	.db 0x00
      0081C3 00                    1803 	.db 0x00
      0081C4 00                    1804 	.db 0x00
      0081C5 00                    1805 	.db 0x00
      0081C6 00                    1806 	.db 0x00
      0081C7 00                    1807 	.db 0x00
      0081C8 00                    1808 	.db 0x00
      0081C9 00                    1809 	.db 0x00
      0081CA 00                    1810 	.db 0x00
      0081CB 00                    1811 	.db 0x00
      0081CC 00                    1812 	.db 0x00
      0081CD 00                    1813 	.db 0x00
      0081CE 00                    1814 	.db 0x00
      0081CF 00                    1815 	.db 0x00
      0081D0 00                    1816 	.db 0x00
      0081D1 00                    1817 	.db 0x00
      0081D2 00                    1818 	.db 0x00
      0081D3 00                    1819 	.db 0x00
      0081D4 00                    1820 	.db 0x00
      0081D5 00                    1821 	.db 0x00
      0081D6 00                    1822 	.db 0x00
      0081D7 00                    1823 	.db 0x00
      0081D8 00                    1824 	.db 0x00
      0081D9 00                    1825 	.db 0x00
      0081DA 00                    1826 	.db 0x00
      0081DB 00                    1827 	.db 0x00
      0081DC 00                    1828 	.db 0x00
      0081DD 00                    1829 	.db 0x00
      0081DE 00                    1830 	.db 0x00
      0081DF 00                    1831 	.db 0x00
      0081E0 00                    1832 	.db 0x00
      0081E1 00                    1833 	.db 0x00
      0081E2 00                    1834 	.db 0x00
      0081E3 00                    1835 	.db 0x00
      0081E4 00                    1836 	.db 0x00
      0081E5 00                    1837 	.db 0x00
      0081E6 00                    1838 	.db 0x00
      0081E7 00                    1839 	.db 0x00
      0081E8 00                    1840 	.db 0x00
      0081E9 00                    1841 	.db 0x00
      0081EA 00                    1842 	.db 0x00
      0081EB 00                    1843 	.db 0x00
      0081EC 00                    1844 	.db 0x00
      0081ED 00                    1845 	.db 0x00
      0081EE 00                    1846 	.db 0x00
      0081EF 00                    1847 	.db 0x00
      0081F0 00                    1848 	.db 0x00
      0081F1 00                    1849 	.db 0x00
      0081F2 00                    1850 	.db 0x00
      0081F3 00                    1851 	.db 0x00
      0081F4 00                    1852 	.db 0x00
      0081F5 00                    1853 	.db 0x00
      0081F6 00                    1854 	.db 0x00
      0081F7 00                    1855 	.db 0x00
      0081F8 00                    1856 	.db 0x00
      0081F9 00                    1857 	.db 0x00
      0081FA 00                    1858 	.db 0x00
      0081FB 00                    1859 	.db 0x00
      0081FC 00                    1860 	.db 0x00
      0081FD 00                    1861 	.db 0x00
      0081FE 00                    1862 	.db 0x00
      0081FF 00                    1863 	.db 0x00
      008200 00                    1864 	.db 0x00
      008201 00                    1865 	.db 0x00
      008202 00                    1866 	.db 0x00
      008203 00                    1867 	.db 0x00
      008204 00                    1868 	.db 0x00
      008205 00                    1869 	.db 0x00
      008206 00                    1870 	.db 0x00
      008207 00                    1871 	.db 0x00
      008208 00                    1872 	.db 0x00
      008209 00                    1873 	.db 0x00
      00820A 00                    1874 	.db 0x00
      00820B 00                    1875 	.db 0x00
      00820C 00                    1876 	.db 0x00
      00820D 00                    1877 	.db 0x00
      00820E 00                    1878 	.db 0x00
      00820F 00                    1879 	.db 0x00
      008210 00                    1880 	.db 0x00
      008211 00                    1881 	.db 0x00
      008212 00                    1882 	.db 0x00
      008213 00                    1883 	.db 0x00
      008214 00                    1884 	.db 0x00
      008215 00                    1885 	.db 0x00
      008216 00                    1886 	.db 0x00
      008217 00                    1887 	.db 0x00
      008218 00                    1888 	.db 0x00
      008219 00                    1889 	.db 0x00
      00821A 00                    1890 	.db 0x00
      00821B 00                    1891 	.db 0x00
      00821C 00                    1892 	.db 0x00
      00821D 00                    1893 	.db 0x00
      00821E 00                    1894 	.db 0x00
      00821F 00                    1895 	.db 0x00
      008220 00                    1896 	.db 0x00
      008221 00                    1897 	.db 0x00
      008222 00                    1898 	.db 0x00
      008223 00                    1899 	.db 0x00
      008224 00                    1900 	.db 0x00
      008225 00                    1901 	.db 0x00
      008226 00                    1902 	.db 0x00
      008227 00                    1903 	.db 0x00
      008228 00                    1904 	.db 0x00
      008229 00                    1905 	.db 0x00
      00822A 00                    1906 	.db 0x00
      00822B 00                    1907 	.db 0x00
      00822C 00                    1908 	.db 0x00
      00822D 00                    1909 	.db 0x00
      00822E 00                    1910 	.db 0x00
      00822F 00                    1911 	.db 0x00
      008230 00                    1912 	.db 0x00
      008231 00                    1913 	.db 0x00
      008232 00                    1914 	.db 0x00
      008233 00                    1915 	.db 0x00
      008234 00                    1916 	.db 0x00
      008235 00                    1917 	.db 0x00
      008236 00                    1918 	.db 0x00
      008237 00                    1919 	.db 0x00
      008238 00                    1920 	.db 0x00
      008239 00                    1921 	.db 0x00
      00823A 00                    1922 	.db 0x00
      00823B 00                    1923 	.db 0x00
      00823C 00                    1924 	.db 0x00
      00823D 00                    1925 	.db 0x00
      00823E 00                    1926 	.db 0x00
      00823F 00                    1927 	.db 0x00
      008240 00                    1928 	.db 0x00
      008241 00                    1929 	.db 0x00
      008242 00                    1930 	.db 0x00
      008243 00                    1931 	.db 0x00
      008244 00                    1932 	.db 0x00
      008245 00                    1933 	.db 0x00
      008246 00                    1934 	.db 0x00
      008247 00                    1935 	.db 0x00
      008248 00                    1936 	.db 0x00
      008249 00                    1937 	.db 0x00
      00824A 00                    1938 	.db 0x00
      00824B 00                    1939 	.db 0x00
      00824C 00                    1940 	.db 0x00
      00824D 00                    1941 	.db 0x00
      00824E 00                    1942 	.db 0x00
      00824F 00                    1943 	.db 0x00
      008250 00                    1944 	.db 0x00
      008251 00                    1945 	.db 0x00
      008252 00                    1946 	.db 0x00
      008253 00                    1947 	.db 0x00
      008254 00                    1948 	.db 0x00
      008255 00                    1949 	.db 0x00
      008256 00                    1950 	.db 0x00
      008257 00                    1951 	.db 0x00
      008258 00                    1952 	.db 0x00
      008259 00                    1953 	.db 0x00
      00825A 00                    1954 	.db 0x00
      00825B 00                    1955 	.db 0x00
      00825C 00                    1956 	.db 0x00
      00825D 00                    1957 	.db 0x00
      00825E 00                    1958 	.db 0x00
      00825F 00                    1959 	.db 0x00
      008260 00                    1960 	.db 0x00
      008261 00                    1961 	.db 0x00
      008262 00                    1962 	.db 0x00
      008263 00                    1963 	.db 0x00
      008264 00                    1964 	.db 0x00
      008265 00                    1965 	.db 0x00
      008266 00                    1966 	.db 0x00
      008267 00                    1967 	.db 0x00
      008268 00                    1968 	.db 0x00
      008269 00                    1969 	.db 0x00
      00826A 00                    1970 	.db 0x00
      00826B 00                    1971 	.db 0x00
      00826C 00                    1972 	.db 0x00
      00826D 00                    1973 	.db 0x00
      00826E 00                    1974 	.db 0x00
      00826F 00                    1975 	.db 0x00
      008270 00                    1976 	.db 0x00
      008271 00                    1977 	.db 0x00
      008272 00                    1978 	.db 0x00
      008273 00                    1979 	.db 0x00
      008274 00                    1980 	.db 0x00
      008275 00                    1981 	.db 0x00
      008276 00                    1982 	.db 0x00
      008277 00                    1983 	.db 0x00
      008278 00                    1984 	.db 0x00
      008279 00                    1985 	.db 0x00
      00827A 00                    1986 	.db 0x00
      00827B 00                    1987 	.db 0x00
      00827C 00                    1988 	.db 0x00
      00827D 00                    1989 	.db 0x00
      00827E 00                    1990 	.db 0x00
      00827F                       1991 __xinit__current_dev:
      00827F 77                    1992 	.db #0x77	; 119	'w'
                                   1993 	.area CABS (ABS)
