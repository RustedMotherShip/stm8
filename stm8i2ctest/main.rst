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
      008007 CD 8A 8A         [ 4]  110 	call	___sdcc_external_startup
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
      008021 D6 80 B1         [ 1]  126 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 89 BD         [ 2]  140 	jp	_main
                                    141 ;	return from main will return to caller
                                    142 ;--------------------------------------------------------
                                    143 ; code
                                    144 ;--------------------------------------------------------
                                    145 	.area CODE
                                    146 ;	main.c: 26: void delay(unsigned long count) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function delay
                                    149 ;	-----------------------------------------
      0082B8                        150 _delay:
      0082B8 52 08            [ 2]  151 	sub	sp, #8
                                    152 ;	main.c: 27: while (count--)
      0082BA 16 0D            [ 2]  153 	ldw	y, (0x0d, sp)
      0082BC 17 07            [ 2]  154 	ldw	(0x07, sp), y
      0082BE 1E 0B            [ 2]  155 	ldw	x, (0x0b, sp)
      0082C0                        156 00101$:
      0082C0 1F 01            [ 2]  157 	ldw	(0x01, sp), x
      0082C2 7B 07            [ 1]  158 	ld	a, (0x07, sp)
      0082C4 6B 03            [ 1]  159 	ld	(0x03, sp), a
      0082C6 7B 08            [ 1]  160 	ld	a, (0x08, sp)
      0082C8 16 07            [ 2]  161 	ldw	y, (0x07, sp)
      0082CA 72 A2 00 01      [ 2]  162 	subw	y, #0x0001
      0082CE 17 07            [ 2]  163 	ldw	(0x07, sp), y
      0082D0 24 01            [ 1]  164 	jrnc	00117$
      0082D2 5A               [ 2]  165 	decw	x
      0082D3                        166 00117$:
      0082D3 4D               [ 1]  167 	tnz	a
      0082D4 26 08            [ 1]  168 	jrne	00118$
      0082D6 16 02            [ 2]  169 	ldw	y, (0x02, sp)
      0082D8 26 04            [ 1]  170 	jrne	00118$
      0082DA 0D 01            [ 1]  171 	tnz	(0x01, sp)
      0082DC 27 03            [ 1]  172 	jreq	00104$
      0082DE                        173 00118$:
                                    174 ;	main.c: 28: nop();
      0082DE 9D               [ 1]  175 	nop
      0082DF 20 DF            [ 2]  176 	jra	00101$
      0082E1                        177 00104$:
                                    178 ;	main.c: 29: }
      0082E1 1E 09            [ 2]  179 	ldw	x, (9, sp)
      0082E3 5B 0E            [ 2]  180 	addw	sp, #14
      0082E5 FC               [ 2]  181 	jp	(x)
                                    182 ;	main.c: 37: void UART_TX(unsigned char value)
                                    183 ;	-----------------------------------------
                                    184 ;	 function UART_TX
                                    185 ;	-----------------------------------------
      0082E6                        186 _UART_TX:
                                    187 ;	main.c: 39: UART1_DR = value;
      0082E6 C7 52 31         [ 1]  188 	ld	0x5231, a
                                    189 ;	main.c: 40: while(!(UART1_SR & UART_SR_TXE));
      0082E9                        190 00101$:
      0082E9 C6 52 30         [ 1]  191 	ld	a, 0x5230
      0082EC 2A FB            [ 1]  192 	jrpl	00101$
                                    193 ;	main.c: 41: }
      0082EE 81               [ 4]  194 	ret
                                    195 ;	main.c: 42: unsigned char UART_RX(void)
                                    196 ;	-----------------------------------------
                                    197 ;	 function UART_RX
                                    198 ;	-----------------------------------------
      0082EF                        199 _UART_RX:
                                    200 ;	main.c: 44: while(!(UART1_SR & UART_SR_TXE));
      0082EF                        201 00101$:
      0082EF C6 52 30         [ 1]  202 	ld	a, 0x5230
      0082F2 2A FB            [ 1]  203 	jrpl	00101$
                                    204 ;	main.c: 45: return UART1_DR;
      0082F4 C6 52 31         [ 1]  205 	ld	a, 0x5231
                                    206 ;	main.c: 46: }
      0082F7 81               [ 4]  207 	ret
                                    208 ;	main.c: 47: int uart_write(const char *str) {
                                    209 ;	-----------------------------------------
                                    210 ;	 function uart_write
                                    211 ;	-----------------------------------------
      0082F8                        212 _uart_write:
      0082F8 52 05            [ 2]  213 	sub	sp, #5
      0082FA 1F 03            [ 2]  214 	ldw	(0x03, sp), x
                                    215 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      0082FC 0F 05            [ 1]  216 	clr	(0x05, sp)
      0082FE                        217 00103$:
      0082FE 1E 03            [ 2]  218 	ldw	x, (0x03, sp)
      008300 CD 8A 8C         [ 4]  219 	call	_strlen
      008303 1F 01            [ 2]  220 	ldw	(0x01, sp), x
      008305 7B 05            [ 1]  221 	ld	a, (0x05, sp)
      008307 5F               [ 1]  222 	clrw	x
      008308 97               [ 1]  223 	ld	xl, a
      008309 13 01            [ 2]  224 	cpw	x, (0x01, sp)
      00830B 24 0F            [ 1]  225 	jrnc	00101$
                                    226 ;	main.c: 51: UART_TX(str[i]);
      00830D 5F               [ 1]  227 	clrw	x
      00830E 7B 05            [ 1]  228 	ld	a, (0x05, sp)
      008310 97               [ 1]  229 	ld	xl, a
      008311 72 FB 03         [ 2]  230 	addw	x, (0x03, sp)
      008314 F6               [ 1]  231 	ld	a, (x)
      008315 CD 82 E6         [ 4]  232 	call	_UART_TX
                                    233 ;	main.c: 49: for(i = 0; i < strlen(str); i++) {
      008318 0C 05            [ 1]  234 	inc	(0x05, sp)
      00831A 20 E2            [ 2]  235 	jra	00103$
      00831C                        236 00101$:
                                    237 ;	main.c: 53: return(i); // Bytes sent
      00831C 7B 05            [ 1]  238 	ld	a, (0x05, sp)
      00831E 5F               [ 1]  239 	clrw	x
      00831F 97               [ 1]  240 	ld	xl, a
                                    241 ;	main.c: 54: }
      008320 5B 05            [ 2]  242 	addw	sp, #5
      008322 81               [ 4]  243 	ret
                                    244 ;	main.c: 55: int uart_read(void)
                                    245 ;	-----------------------------------------
                                    246 ;	 function uart_read
                                    247 ;	-----------------------------------------
      008323                        248 _uart_read:
                                    249 ;	main.c: 57: memset(buffer, 0, sizeof(buffer));
      008323 4B FF            [ 1]  250 	push	#0xff
      008325 4B 00            [ 1]  251 	push	#0x00
      008327 5F               [ 1]  252 	clrw	x
      008328 89               [ 2]  253 	pushw	x
      008329 AE 00 01         [ 2]  254 	ldw	x, #(_buffer+0)
      00832C CD 8A 68         [ 4]  255 	call	_memset
                                    256 ;	main.c: 59: while(i<256)
      00832F 5F               [ 1]  257 	clrw	x
      008330                        258 00105$:
      008330 A3 01 00         [ 2]  259 	cpw	x, #0x0100
      008333 2E 22            [ 1]  260 	jrsge	00107$
                                    261 ;	main.c: 61: if(UART1_SR & UART_SR_RXNE)
      008335 C6 52 30         [ 1]  262 	ld	a, 0x5230
      008338 A5 20            [ 1]  263 	bcp	a, #0x20
      00833A 27 F4            [ 1]  264 	jreq	00105$
                                    265 ;	main.c: 63: buffer[i] = UART_RX();
      00833C 90 93            [ 1]  266 	ldw	y, x
      00833E 72 A9 00 01      [ 2]  267 	addw	y, #(_buffer+0)
      008342 89               [ 2]  268 	pushw	x
      008343 90 89            [ 2]  269 	pushw	y
      008345 CD 82 EF         [ 4]  270 	call	_UART_RX
      008348 90 85            [ 2]  271 	popw	y
      00834A 85               [ 2]  272 	popw	x
      00834B 90 F7            [ 1]  273 	ld	(y), a
                                    274 ;	main.c: 64: if(buffer[i] == '\r\n' )
      00834D A1 0D            [ 1]  275 	cp	a, #0x0d
      00834F 26 03            [ 1]  276 	jrne	00102$
                                    277 ;	main.c: 66: return 1;
      008351 5F               [ 1]  278 	clrw	x
      008352 5C               [ 1]  279 	incw	x
      008353 81               [ 4]  280 	ret
                                    281 ;	main.c: 67: break;
      008354                        282 00102$:
                                    283 ;	main.c: 69: i++;
      008354 5C               [ 1]  284 	incw	x
      008355 20 D9            [ 2]  285 	jra	00105$
      008357                        286 00107$:
                                    287 ;	main.c: 72: return 0;
      008357 5F               [ 1]  288 	clrw	x
                                    289 ;	main.c: 73: }
      008358 81               [ 4]  290 	ret
                                    291 ;	main.c: 82: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    292 ;	-----------------------------------------
                                    293 ;	 function convert_int_to_chars
                                    294 ;	-----------------------------------------
      008359                        295 _convert_int_to_chars:
      008359 52 0D            [ 2]  296 	sub	sp, #13
      00835B 6B 0D            [ 1]  297 	ld	(0x0d, sp), a
      00835D 1F 0B            [ 2]  298 	ldw	(0x0b, sp), x
                                    299 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      00835F 7B 0D            [ 1]  300 	ld	a, (0x0d, sp)
      008361 6B 02            [ 1]  301 	ld	(0x02, sp), a
      008363 0F 01            [ 1]  302 	clr	(0x01, sp)
                                    303 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      008365 1E 0B            [ 2]  304 	ldw	x, (0x0b, sp)
      008367 5C               [ 1]  305 	incw	x
      008368 1F 03            [ 2]  306 	ldw	(0x03, sp), x
                                    307 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      00836A 1E 0B            [ 2]  308 	ldw	x, (0x0b, sp)
      00836C 5C               [ 1]  309 	incw	x
      00836D 5C               [ 1]  310 	incw	x
      00836E 1F 05            [ 2]  311 	ldw	(0x05, sp), x
                                    312 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      008370 4B 0A            [ 1]  313 	push	#0x0a
      008372 4B 00            [ 1]  314 	push	#0x00
      008374 1E 03            [ 2]  315 	ldw	x, (0x03, sp)
                                    316 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      008376 CD 8A B1         [ 4]  317 	call	__divsint
      008379 1F 07            [ 2]  318 	ldw	(0x07, sp), x
      00837B 4B 0A            [ 1]  319 	push	#0x0a
      00837D 4B 00            [ 1]  320 	push	#0x00
      00837F 1E 03            [ 2]  321 	ldw	x, (0x03, sp)
      008381 CD 8A 99         [ 4]  322 	call	__modsint
      008384 9F               [ 1]  323 	ld	a, xl
      008385 AB 30            [ 1]  324 	add	a, #0x30
      008387 6B 09            [ 1]  325 	ld	(0x09, sp), a
                                    326 ;	main.c: 83: if (num > 99) {
      008389 7B 0D            [ 1]  327 	ld	a, (0x0d, sp)
      00838B A1 63            [ 1]  328 	cp	a, #0x63
      00838D 23 29            [ 2]  329 	jrule	00105$
                                    330 ;	main.c: 85: rx_int_chars[0] = num / 100 + '0';
      00838F 4B 64            [ 1]  331 	push	#0x64
      008391 4B 00            [ 1]  332 	push	#0x00
      008393 1E 03            [ 2]  333 	ldw	x, (0x03, sp)
      008395 CD 8A B1         [ 4]  334 	call	__divsint
      008398 9F               [ 1]  335 	ld	a, xl
      008399 AB 30            [ 1]  336 	add	a, #0x30
      00839B 1E 0B            [ 2]  337 	ldw	x, (0x0b, sp)
      00839D F7               [ 1]  338 	ld	(x), a
                                    339 ;	main.c: 86: rx_int_chars[1] = num / 10 % 10 + '0';
      00839E 4B 0A            [ 1]  340 	push	#0x0a
      0083A0 4B 00            [ 1]  341 	push	#0x00
      0083A2 1E 09            [ 2]  342 	ldw	x, (0x09, sp)
      0083A4 CD 8A 99         [ 4]  343 	call	__modsint
      0083A7 9F               [ 1]  344 	ld	a, xl
      0083A8 AB 30            [ 1]  345 	add	a, #0x30
      0083AA 1E 03            [ 2]  346 	ldw	x, (0x03, sp)
      0083AC F7               [ 1]  347 	ld	(x), a
                                    348 ;	main.c: 87: rx_int_chars[2] = num % 10 + '0';
      0083AD 1E 05            [ 2]  349 	ldw	x, (0x05, sp)
      0083AF 7B 09            [ 1]  350 	ld	a, (0x09, sp)
      0083B1 F7               [ 1]  351 	ld	(x), a
                                    352 ;	main.c: 88: rx_int_chars[3] ='\0';
      0083B2 1E 0B            [ 2]  353 	ldw	x, (0x0b, sp)
      0083B4 6F 03            [ 1]  354 	clr	(0x0003, x)
      0083B6 20 23            [ 2]  355 	jra	00107$
      0083B8                        356 00105$:
                                    357 ;	main.c: 90: } else if (num > 9) {
      0083B8 7B 0D            [ 1]  358 	ld	a, (0x0d, sp)
      0083BA A1 09            [ 1]  359 	cp	a, #0x09
      0083BC 23 13            [ 2]  360 	jrule	00102$
                                    361 ;	main.c: 92: rx_int_chars[0] = num / 10 + '0';
      0083BE 7B 08            [ 1]  362 	ld	a, (0x08, sp)
      0083C0 6B 0A            [ 1]  363 	ld	(0x0a, sp), a
      0083C2 AB 30            [ 1]  364 	add	a, #0x30
      0083C4 1E 0B            [ 2]  365 	ldw	x, (0x0b, sp)
      0083C6 F7               [ 1]  366 	ld	(x), a
                                    367 ;	main.c: 93: rx_int_chars[1] = num % 10 + '0';
      0083C7 1E 03            [ 2]  368 	ldw	x, (0x03, sp)
      0083C9 7B 09            [ 1]  369 	ld	a, (0x09, sp)
      0083CB F7               [ 1]  370 	ld	(x), a
                                    371 ;	main.c: 94: rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
      0083CC 1E 05            [ 2]  372 	ldw	x, (0x05, sp)
      0083CE 7F               [ 1]  373 	clr	(x)
      0083CF 20 0A            [ 2]  374 	jra	00107$
      0083D1                        375 00102$:
                                    376 ;	main.c: 97: rx_int_chars[0] = num + '0';
      0083D1 7B 0D            [ 1]  377 	ld	a, (0x0d, sp)
      0083D3 AB 30            [ 1]  378 	add	a, #0x30
      0083D5 1E 0B            [ 2]  379 	ldw	x, (0x0b, sp)
      0083D7 F7               [ 1]  380 	ld	(x), a
                                    381 ;	main.c: 98: rx_int_chars[1] ='\0';
      0083D8 1E 03            [ 2]  382 	ldw	x, (0x03, sp)
      0083DA 7F               [ 1]  383 	clr	(x)
      0083DB                        384 00107$:
                                    385 ;	main.c: 100: }
      0083DB 5B 0D            [ 2]  386 	addw	sp, #13
      0083DD 81               [ 4]  387 	ret
                                    388 ;	main.c: 102: uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
                                    389 ;	-----------------------------------------
                                    390 ;	 function convert_chars_to_int
                                    391 ;	-----------------------------------------
      0083DE                        392 _convert_chars_to_int:
      0083DE 52 03            [ 2]  393 	sub	sp, #3
      0083E0 1F 02            [ 2]  394 	ldw	(0x02, sp), x
                                    395 ;	main.c: 103: uint8_t result = 0;
      0083E2 4F               [ 1]  396 	clr	a
                                    397 ;	main.c: 105: for (int o = 0; o < i; o++) {
      0083E3 5F               [ 1]  398 	clrw	x
      0083E4                        399 00103$:
      0083E4 13 06            [ 2]  400 	cpw	x, (0x06, sp)
      0083E6 2E 18            [ 1]  401 	jrsge	00101$
                                    402 ;	main.c: 107: result = (result * 10) + (rx_chars_int[o] - '0');
      0083E8 90 97            [ 1]  403 	ld	yl, a
      0083EA A6 0A            [ 1]  404 	ld	a, #0x0a
      0083EC 90 42            [ 4]  405 	mul	y, a
      0083EE 61               [ 1]  406 	exg	a, yl
      0083EF 6B 01            [ 1]  407 	ld	(0x01, sp), a
      0083F1 61               [ 1]  408 	exg	a, yl
      0083F2 90 93            [ 1]  409 	ldw	y, x
      0083F4 72 F9 02         [ 2]  410 	addw	y, (0x02, sp)
      0083F7 90 F6            [ 1]  411 	ld	a, (y)
      0083F9 A0 30            [ 1]  412 	sub	a, #0x30
      0083FB 1B 01            [ 1]  413 	add	a, (0x01, sp)
                                    414 ;	main.c: 105: for (int o = 0; o < i; o++) {
      0083FD 5C               [ 1]  415 	incw	x
      0083FE 20 E4            [ 2]  416 	jra	00103$
      008400                        417 00101$:
                                    418 ;	main.c: 110: return result;
                                    419 ;	main.c: 111: }
      008400 1E 04            [ 2]  420 	ldw	x, (4, sp)
      008402 5B 07            [ 2]  421 	addw	sp, #7
      008404 FC               [ 2]  422 	jp	(x)
                                    423 ;	main.c: 114: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    424 ;	-----------------------------------------
                                    425 ;	 function convert_int_to_binary
                                    426 ;	-----------------------------------------
      008405                        427 _convert_int_to_binary:
      008405 52 04            [ 2]  428 	sub	sp, #4
      008407 1F 01            [ 2]  429 	ldw	(0x01, sp), x
                                    430 ;	main.c: 116: for(int i = 7; i >= 0; i--) {
      008409 AE 00 07         [ 2]  431 	ldw	x, #0x0007
      00840C 1F 03            [ 2]  432 	ldw	(0x03, sp), x
      00840E                        433 00103$:
      00840E 0D 03            [ 1]  434 	tnz	(0x03, sp)
      008410 2B 22            [ 1]  435 	jrmi	00101$
                                    436 ;	main.c: 118: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008412 AE 00 07         [ 2]  437 	ldw	x, #0x0007
      008415 72 F0 03         [ 2]  438 	subw	x, (0x03, sp)
      008418 72 FB 07         [ 2]  439 	addw	x, (0x07, sp)
      00841B 16 01            [ 2]  440 	ldw	y, (0x01, sp)
      00841D 7B 04            [ 1]  441 	ld	a, (0x04, sp)
      00841F 27 05            [ 1]  442 	jreq	00120$
      008421                        443 00119$:
      008421 90 57            [ 2]  444 	sraw	y
      008423 4A               [ 1]  445 	dec	a
      008424 26 FB            [ 1]  446 	jrne	00119$
      008426                        447 00120$:
      008426 90 9F            [ 1]  448 	ld	a, yl
      008428 A4 01            [ 1]  449 	and	a, #0x01
      00842A AB 30            [ 1]  450 	add	a, #0x30
      00842C F7               [ 1]  451 	ld	(x), a
                                    452 ;	main.c: 116: for(int i = 7; i >= 0; i--) {
      00842D 1E 03            [ 2]  453 	ldw	x, (0x03, sp)
      00842F 5A               [ 2]  454 	decw	x
      008430 1F 03            [ 2]  455 	ldw	(0x03, sp), x
      008432 20 DA            [ 2]  456 	jra	00103$
      008434                        457 00101$:
                                    458 ;	main.c: 120: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008434 1E 07            [ 2]  459 	ldw	x, (0x07, sp)
      008436 6F 08            [ 1]  460 	clr	(0x0008, x)
                                    461 ;	main.c: 121: }
      008438 1E 05            [ 2]  462 	ldw	x, (5, sp)
      00843A 5B 08            [ 2]  463 	addw	sp, #8
      00843C FC               [ 2]  464 	jp	(x)
                                    465 ;	main.c: 130: void get_addr_from_buff(void)
                                    466 ;	-----------------------------------------
                                    467 ;	 function get_addr_from_buff
                                    468 ;	-----------------------------------------
      00843D                        469 _get_addr_from_buff:
      00843D 52 02            [ 2]  470 	sub	sp, #2
                                    471 ;	main.c: 134: while(1)
      00843F A6 03            [ 1]  472 	ld	a, #0x03
      008441 6B 01            [ 1]  473 	ld	(0x01, sp), a
      008443 0F 02            [ 1]  474 	clr	(0x02, sp)
      008445                        475 00105$:
                                    476 ;	main.c: 136: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008445 5F               [ 1]  477 	clrw	x
      008446 7B 01            [ 1]  478 	ld	a, (0x01, sp)
      008448 97               [ 1]  479 	ld	xl, a
      008449 D6 00 01         [ 1]  480 	ld	a, (_buffer+0, x)
      00844C A1 20            [ 1]  481 	cp	a, #0x20
      00844E 27 04            [ 1]  482 	jreq	00101$
      008450 A1 0D            [ 1]  483 	cp	a, #0x0d
      008452 26 08            [ 1]  484 	jrne	00102$
      008454                        485 00101$:
                                    486 ;	main.c: 138: p_size = i+1;
      008454 7B 01            [ 1]  487 	ld	a, (0x01, sp)
      008456 4C               [ 1]  488 	inc	a
      008457 C7 01 04         [ 1]  489 	ld	_p_size+0, a
                                    490 ;	main.c: 139: break;
      00845A 20 06            [ 2]  491 	jra	00106$
      00845C                        492 00102$:
                                    493 ;	main.c: 141: i++;
      00845C 0C 01            [ 1]  494 	inc	(0x01, sp)
                                    495 ;	main.c: 142: counter++;
      00845E 0C 02            [ 1]  496 	inc	(0x02, sp)
      008460 20 E3            [ 2]  497 	jra	00105$
      008462                        498 00106$:
                                    499 ;	main.c: 144: memcpy(a, &buffer[3], counter);
      008462 5F               [ 1]  500 	clrw	x
      008463 7B 02            [ 1]  501 	ld	a, (0x02, sp)
      008465 97               [ 1]  502 	ld	xl, a
      008466 89               [ 2]  503 	pushw	x
      008467 4B 04            [ 1]  504 	push	#<(_buffer+3)
      008469 4B 00            [ 1]  505 	push	#((_buffer+3) >> 8)
      00846B AE 01 00         [ 2]  506 	ldw	x, #(_a+0)
      00846E CD 8A 15         [ 4]  507 	call	___memcpy
                                    508 ;	main.c: 145: d_addr = convert_chars_to_int(a, counter);
      008471 5F               [ 1]  509 	clrw	x
      008472 7B 02            [ 1]  510 	ld	a, (0x02, sp)
      008474 97               [ 1]  511 	ld	xl, a
      008475 89               [ 2]  512 	pushw	x
      008476 AE 01 00         [ 2]  513 	ldw	x, #(_a+0)
      008479 CD 83 DE         [ 4]  514 	call	_convert_chars_to_int
      00847C C7 01 03         [ 1]  515 	ld	_d_addr+0, a
                                    516 ;	main.c: 146: }
      00847F 5B 02            [ 2]  517 	addw	sp, #2
      008481 81               [ 4]  518 	ret
                                    519 ;	main.c: 148: void get_size_from_buff(void)
                                    520 ;	-----------------------------------------
                                    521 ;	 function get_size_from_buff
                                    522 ;	-----------------------------------------
      008482                        523 _get_size_from_buff:
      008482 52 02            [ 2]  524 	sub	sp, #2
                                    525 ;	main.c: 150: memset(a, 0, sizeof(a));
      008484 4B 03            [ 1]  526 	push	#0x03
      008486 4B 00            [ 1]  527 	push	#0x00
      008488 5F               [ 1]  528 	clrw	x
      008489 89               [ 2]  529 	pushw	x
      00848A AE 01 00         [ 2]  530 	ldw	x, #(_a+0)
      00848D CD 8A 68         [ 4]  531 	call	_memset
                                    532 ;	main.c: 152: uint8_t i = p_size;
      008490 C6 01 04         [ 1]  533 	ld	a, _p_size+0
      008493 6B 01            [ 1]  534 	ld	(0x01, sp), a
                                    535 ;	main.c: 153: while(1)
      008495 0F 02            [ 1]  536 	clr	(0x02, sp)
      008497                        537 00105$:
                                    538 ;	main.c: 155: if(buffer[i] == ' ' || buffer[i] == '\r\n')
      008497 5F               [ 1]  539 	clrw	x
      008498 7B 01            [ 1]  540 	ld	a, (0x01, sp)
      00849A 97               [ 1]  541 	ld	xl, a
      00849B D6 00 01         [ 1]  542 	ld	a, (_buffer+0, x)
      00849E A1 20            [ 1]  543 	cp	a, #0x20
      0084A0 27 04            [ 1]  544 	jreq	00101$
      0084A2 A1 0D            [ 1]  545 	cp	a, #0x0d
      0084A4 26 08            [ 1]  546 	jrne	00102$
      0084A6                        547 00101$:
                                    548 ;	main.c: 158: p_bytes = i+1;
      0084A6 7B 01            [ 1]  549 	ld	a, (0x01, sp)
      0084A8 4C               [ 1]  550 	inc	a
      0084A9 C7 01 06         [ 1]  551 	ld	_p_bytes+0, a
                                    552 ;	main.c: 159: break;
      0084AC 20 06            [ 2]  553 	jra	00106$
      0084AE                        554 00102$:
                                    555 ;	main.c: 161: i++;
      0084AE 0C 01            [ 1]  556 	inc	(0x01, sp)
                                    557 ;	main.c: 162: counter++;
      0084B0 0C 02            [ 1]  558 	inc	(0x02, sp)
      0084B2 20 E3            [ 2]  559 	jra	00105$
      0084B4                        560 00106$:
                                    561 ;	main.c: 165: memcpy(a, &buffer[p_size], counter);
      0084B4 90 5F            [ 1]  562 	clrw	y
      0084B6 7B 02            [ 1]  563 	ld	a, (0x02, sp)
      0084B8 90 97            [ 1]  564 	ld	yl, a
      0084BA 5F               [ 1]  565 	clrw	x
      0084BB C6 01 04         [ 1]  566 	ld	a, _p_size+0
      0084BE 97               [ 1]  567 	ld	xl, a
      0084BF 1C 00 01         [ 2]  568 	addw	x, #(_buffer+0)
      0084C2 90 89            [ 2]  569 	pushw	y
      0084C4 89               [ 2]  570 	pushw	x
      0084C5 AE 01 00         [ 2]  571 	ldw	x, #(_a+0)
      0084C8 CD 8A 15         [ 4]  572 	call	___memcpy
                                    573 ;	main.c: 166: d_size = convert_chars_to_int(a, counter);
      0084CB 5F               [ 1]  574 	clrw	x
      0084CC 7B 02            [ 1]  575 	ld	a, (0x02, sp)
      0084CE 97               [ 1]  576 	ld	xl, a
      0084CF 89               [ 2]  577 	pushw	x
      0084D0 AE 01 00         [ 2]  578 	ldw	x, #(_a+0)
      0084D3 CD 83 DE         [ 4]  579 	call	_convert_chars_to_int
      0084D6 C7 01 05         [ 1]  580 	ld	_d_size+0, a
                                    581 ;	main.c: 167: }
      0084D9 5B 02            [ 2]  582 	addw	sp, #2
      0084DB 81               [ 4]  583 	ret
                                    584 ;	main.c: 168: void char_buffer_to_int(void)
                                    585 ;	-----------------------------------------
                                    586 ;	 function char_buffer_to_int
                                    587 ;	-----------------------------------------
      0084DC                        588 _char_buffer_to_int:
      0084DC 52 08            [ 2]  589 	sub	sp, #8
                                    590 ;	main.c: 170: memset(a, 0, sizeof(a));
      0084DE 4B 03            [ 1]  591 	push	#0x03
      0084E0 4B 00            [ 1]  592 	push	#0x00
      0084E2 5F               [ 1]  593 	clrw	x
      0084E3 89               [ 2]  594 	pushw	x
      0084E4 AE 01 00         [ 2]  595 	ldw	x, #(_a+0)
      0084E7 CD 8A 68         [ 4]  596 	call	_memset
                                    597 ;	main.c: 171: uint8_t counter = d_size;
      0084EA C6 01 05         [ 1]  598 	ld	a, _d_size+0
      0084ED 6B 01            [ 1]  599 	ld	(0x01, sp), a
                                    600 ;	main.c: 172: uint8_t i = p_bytes;
      0084EF C6 01 06         [ 1]  601 	ld	a, _p_bytes+0
      0084F2 6B 03            [ 1]  602 	ld	(0x03, sp), a
                                    603 ;	main.c: 175: for(int o = 0; o < counter;o++)
      0084F4 0F 04            [ 1]  604 	clr	(0x04, sp)
      0084F6 5F               [ 1]  605 	clrw	x
      0084F7 1F 05            [ 2]  606 	ldw	(0x05, sp), x
      0084F9                        607 00112$:
      0084F9 7B 01            [ 1]  608 	ld	a, (0x01, sp)
      0084FB 6B 08            [ 1]  609 	ld	(0x08, sp), a
      0084FD 0F 07            [ 1]  610 	clr	(0x07, sp)
      0084FF 1E 05            [ 2]  611 	ldw	x, (0x05, sp)
      008501 13 07            [ 2]  612 	cpw	x, (0x07, sp)
      008503 2E 65            [ 1]  613 	jrsge	00114$
                                    614 ;	main.c: 177: uint8_t number_counter = 0;
      008505 0F 02            [ 1]  615 	clr	(0x02, sp)
                                    616 ;	main.c: 178: while(1)
      008507 7B 03            [ 1]  617 	ld	a, (0x03, sp)
      008509 6B 07            [ 1]  618 	ld	(0x07, sp), a
      00850B 0F 08            [ 1]  619 	clr	(0x08, sp)
      00850D                        620 00108$:
                                    621 ;	main.c: 180: if(buffer[i] == ' ')
      00850D 5F               [ 1]  622 	clrw	x
      00850E 7B 07            [ 1]  623 	ld	a, (0x07, sp)
      008510 97               [ 1]  624 	ld	xl, a
      008511 D6 00 01         [ 1]  625 	ld	a, (_buffer+0, x)
      008514 A1 20            [ 1]  626 	cp	a, #0x20
      008516 26 04            [ 1]  627 	jrne	00105$
                                    628 ;	main.c: 182: i++;
      008518 0C 03            [ 1]  629 	inc	(0x03, sp)
                                    630 ;	main.c: 183: break;
      00851A 20 12            [ 2]  631 	jra	00109$
      00851C                        632 00105$:
                                    633 ;	main.c: 185: else if(buffer[i] == '\r\n')
      00851C A1 0D            [ 1]  634 	cp	a, #0x0d
      00851E 27 0E            [ 1]  635 	jreq	00109$
                                    636 ;	main.c: 188: i++;
      008520 0C 07            [ 1]  637 	inc	(0x07, sp)
      008522 7B 07            [ 1]  638 	ld	a, (0x07, sp)
      008524 6B 03            [ 1]  639 	ld	(0x03, sp), a
                                    640 ;	main.c: 190: number_counter++;
      008526 0C 08            [ 1]  641 	inc	(0x08, sp)
      008528 7B 08            [ 1]  642 	ld	a, (0x08, sp)
      00852A 6B 02            [ 1]  643 	ld	(0x02, sp), a
      00852C 20 DF            [ 2]  644 	jra	00108$
      00852E                        645 00109$:
                                    646 ;	main.c: 192: memcpy(a, &buffer[i - number_counter], number_counter);
      00852E 90 5F            [ 1]  647 	clrw	y
      008530 7B 02            [ 1]  648 	ld	a, (0x02, sp)
      008532 90 97            [ 1]  649 	ld	yl, a
      008534 5F               [ 1]  650 	clrw	x
      008535 7B 03            [ 1]  651 	ld	a, (0x03, sp)
      008537 97               [ 1]  652 	ld	xl, a
      008538 7B 02            [ 1]  653 	ld	a, (0x02, sp)
      00853A 6B 08            [ 1]  654 	ld	(0x08, sp), a
      00853C 0F 07            [ 1]  655 	clr	(0x07, sp)
      00853E 72 F0 07         [ 2]  656 	subw	x, (0x07, sp)
      008541 1C 00 01         [ 2]  657 	addw	x, #(_buffer+0)
      008544 90 89            [ 2]  658 	pushw	y
      008546 89               [ 2]  659 	pushw	x
      008547 AE 01 00         [ 2]  660 	ldw	x, #(_a+0)
      00854A CD 8A 15         [ 4]  661 	call	___memcpy
                                    662 ;	main.c: 193: data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
      00854D 5F               [ 1]  663 	clrw	x
      00854E 7B 04            [ 1]  664 	ld	a, (0x04, sp)
      008550 97               [ 1]  665 	ld	xl, a
      008551 1C 01 07         [ 2]  666 	addw	x, #(_data_buf+0)
      008554 89               [ 2]  667 	pushw	x
      008555 16 09            [ 2]  668 	ldw	y, (0x09, sp)
      008557 90 89            [ 2]  669 	pushw	y
      008559 AE 01 00         [ 2]  670 	ldw	x, #(_a+0)
      00855C CD 83 DE         [ 4]  671 	call	_convert_chars_to_int
      00855F 85               [ 2]  672 	popw	x
      008560 F7               [ 1]  673 	ld	(x), a
                                    674 ;	main.c: 194: int_buf_i++;
      008561 0C 04            [ 1]  675 	inc	(0x04, sp)
                                    676 ;	main.c: 175: for(int o = 0; o < counter;o++)
      008563 1E 05            [ 2]  677 	ldw	x, (0x05, sp)
      008565 5C               [ 1]  678 	incw	x
      008566 1F 05            [ 2]  679 	ldw	(0x05, sp), x
      008568 20 8F            [ 2]  680 	jra	00112$
      00856A                        681 00114$:
                                    682 ;	main.c: 196: }
      00856A 5B 08            [ 2]  683 	addw	sp, #8
      00856C 81               [ 4]  684 	ret
                                    685 ;	main.c: 204: void status_check(void){
                                    686 ;	-----------------------------------------
                                    687 ;	 function status_check
                                    688 ;	-----------------------------------------
      00856D                        689 _status_check:
      00856D 52 09            [ 2]  690 	sub	sp, #9
                                    691 ;	main.c: 205: char rx_binary_chars[9]={0};
      00856F 0F 01            [ 1]  692 	clr	(0x01, sp)
      008571 0F 02            [ 1]  693 	clr	(0x02, sp)
      008573 0F 03            [ 1]  694 	clr	(0x03, sp)
      008575 0F 04            [ 1]  695 	clr	(0x04, sp)
      008577 0F 05            [ 1]  696 	clr	(0x05, sp)
      008579 0F 06            [ 1]  697 	clr	(0x06, sp)
      00857B 0F 07            [ 1]  698 	clr	(0x07, sp)
      00857D 0F 08            [ 1]  699 	clr	(0x08, sp)
      00857F 0F 09            [ 1]  700 	clr	(0x09, sp)
                                    701 ;	main.c: 206: uart_write("\nI2C_REGS >.<\n");
      008581 AE 80 2D         [ 2]  702 	ldw	x, #(___str_0+0)
      008584 CD 82 F8         [ 4]  703 	call	_uart_write
                                    704 ;	main.c: 207: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      008587 96               [ 1]  705 	ldw	x, sp
      008588 5C               [ 1]  706 	incw	x
      008589 51               [ 1]  707 	exgw	x, y
      00858A C6 52 17         [ 1]  708 	ld	a, 0x5217
      00858D 5F               [ 1]  709 	clrw	x
      00858E 90 89            [ 2]  710 	pushw	y
      008590 97               [ 1]  711 	ld	xl, a
      008591 CD 84 05         [ 4]  712 	call	_convert_int_to_binary
                                    713 ;	main.c: 208: uart_write("\nSR1 -> ");
      008594 AE 80 3C         [ 2]  714 	ldw	x, #(___str_1+0)
      008597 CD 82 F8         [ 4]  715 	call	_uart_write
                                    716 ;	main.c: 209: uart_write(rx_binary_chars);
      00859A 96               [ 1]  717 	ldw	x, sp
      00859B 5C               [ 1]  718 	incw	x
      00859C CD 82 F8         [ 4]  719 	call	_uart_write
                                    720 ;	main.c: 210: uart_write(" <-\n");
      00859F AE 80 45         [ 2]  721 	ldw	x, #(___str_2+0)
      0085A2 CD 82 F8         [ 4]  722 	call	_uart_write
                                    723 ;	main.c: 211: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0085A5 96               [ 1]  724 	ldw	x, sp
      0085A6 5C               [ 1]  725 	incw	x
      0085A7 51               [ 1]  726 	exgw	x, y
      0085A8 C6 52 18         [ 1]  727 	ld	a, 0x5218
      0085AB 5F               [ 1]  728 	clrw	x
      0085AC 90 89            [ 2]  729 	pushw	y
      0085AE 97               [ 1]  730 	ld	xl, a
      0085AF CD 84 05         [ 4]  731 	call	_convert_int_to_binary
                                    732 ;	main.c: 212: uart_write("SR2 -> ");
      0085B2 AE 80 4A         [ 2]  733 	ldw	x, #(___str_3+0)
      0085B5 CD 82 F8         [ 4]  734 	call	_uart_write
                                    735 ;	main.c: 213: uart_write(rx_binary_chars);
      0085B8 96               [ 1]  736 	ldw	x, sp
      0085B9 5C               [ 1]  737 	incw	x
      0085BA CD 82 F8         [ 4]  738 	call	_uart_write
                                    739 ;	main.c: 214: uart_write(" <-\n");
      0085BD AE 80 45         [ 2]  740 	ldw	x, #(___str_2+0)
      0085C0 CD 82 F8         [ 4]  741 	call	_uart_write
                                    742 ;	main.c: 215: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0085C3 96               [ 1]  743 	ldw	x, sp
      0085C4 5C               [ 1]  744 	incw	x
      0085C5 51               [ 1]  745 	exgw	x, y
      0085C6 C6 52 19         [ 1]  746 	ld	a, 0x5219
      0085C9 5F               [ 1]  747 	clrw	x
      0085CA 90 89            [ 2]  748 	pushw	y
      0085CC 97               [ 1]  749 	ld	xl, a
      0085CD CD 84 05         [ 4]  750 	call	_convert_int_to_binary
                                    751 ;	main.c: 216: uart_write("SR3 -> ");
      0085D0 AE 80 52         [ 2]  752 	ldw	x, #(___str_4+0)
      0085D3 CD 82 F8         [ 4]  753 	call	_uart_write
                                    754 ;	main.c: 217: uart_write(rx_binary_chars);
      0085D6 96               [ 1]  755 	ldw	x, sp
      0085D7 5C               [ 1]  756 	incw	x
      0085D8 CD 82 F8         [ 4]  757 	call	_uart_write
                                    758 ;	main.c: 218: uart_write(" <-\n");
      0085DB AE 80 45         [ 2]  759 	ldw	x, #(___str_2+0)
      0085DE CD 82 F8         [ 4]  760 	call	_uart_write
                                    761 ;	main.c: 219: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      0085E1 96               [ 1]  762 	ldw	x, sp
      0085E2 5C               [ 1]  763 	incw	x
      0085E3 51               [ 1]  764 	exgw	x, y
      0085E4 C6 52 10         [ 1]  765 	ld	a, 0x5210
      0085E7 5F               [ 1]  766 	clrw	x
      0085E8 90 89            [ 2]  767 	pushw	y
      0085EA 97               [ 1]  768 	ld	xl, a
      0085EB CD 84 05         [ 4]  769 	call	_convert_int_to_binary
                                    770 ;	main.c: 220: uart_write("CR1 -> ");
      0085EE AE 80 5A         [ 2]  771 	ldw	x, #(___str_5+0)
      0085F1 CD 82 F8         [ 4]  772 	call	_uart_write
                                    773 ;	main.c: 221: uart_write(rx_binary_chars);
      0085F4 96               [ 1]  774 	ldw	x, sp
      0085F5 5C               [ 1]  775 	incw	x
      0085F6 CD 82 F8         [ 4]  776 	call	_uart_write
                                    777 ;	main.c: 222: uart_write(" <-\n");
      0085F9 AE 80 45         [ 2]  778 	ldw	x, #(___str_2+0)
      0085FC CD 82 F8         [ 4]  779 	call	_uart_write
                                    780 ;	main.c: 223: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      0085FF 96               [ 1]  781 	ldw	x, sp
      008600 5C               [ 1]  782 	incw	x
      008601 51               [ 1]  783 	exgw	x, y
      008602 C6 52 11         [ 1]  784 	ld	a, 0x5211
      008605 5F               [ 1]  785 	clrw	x
      008606 90 89            [ 2]  786 	pushw	y
      008608 97               [ 1]  787 	ld	xl, a
      008609 CD 84 05         [ 4]  788 	call	_convert_int_to_binary
                                    789 ;	main.c: 224: uart_write("CR2 -> ");
      00860C AE 80 62         [ 2]  790 	ldw	x, #(___str_6+0)
      00860F CD 82 F8         [ 4]  791 	call	_uart_write
                                    792 ;	main.c: 225: uart_write(rx_binary_chars);
      008612 96               [ 1]  793 	ldw	x, sp
      008613 5C               [ 1]  794 	incw	x
      008614 CD 82 F8         [ 4]  795 	call	_uart_write
                                    796 ;	main.c: 226: uart_write(" <-\n");
      008617 AE 80 45         [ 2]  797 	ldw	x, #(___str_2+0)
      00861A CD 82 F8         [ 4]  798 	call	_uart_write
                                    799 ;	main.c: 227: convert_int_to_binary(I2C_DR, rx_binary_chars);
      00861D 96               [ 1]  800 	ldw	x, sp
      00861E 5C               [ 1]  801 	incw	x
      00861F 51               [ 1]  802 	exgw	x, y
      008620 C6 52 16         [ 1]  803 	ld	a, 0x5216
      008623 5F               [ 1]  804 	clrw	x
      008624 90 89            [ 2]  805 	pushw	y
      008626 97               [ 1]  806 	ld	xl, a
      008627 CD 84 05         [ 4]  807 	call	_convert_int_to_binary
                                    808 ;	main.c: 228: uart_write("DR -> ");
      00862A AE 80 6A         [ 2]  809 	ldw	x, #(___str_7+0)
      00862D CD 82 F8         [ 4]  810 	call	_uart_write
                                    811 ;	main.c: 229: uart_write(rx_binary_chars);
      008630 96               [ 1]  812 	ldw	x, sp
      008631 5C               [ 1]  813 	incw	x
      008632 CD 82 F8         [ 4]  814 	call	_uart_write
                                    815 ;	main.c: 230: uart_write(" <-\n");
      008635 AE 80 45         [ 2]  816 	ldw	x, #(___str_2+0)
      008638 CD 82 F8         [ 4]  817 	call	_uart_write
                                    818 ;	main.c: 231: uart_write("UART_REGS >.<\n");
      00863B AE 80 71         [ 2]  819 	ldw	x, #(___str_8+0)
      00863E CD 82 F8         [ 4]  820 	call	_uart_write
                                    821 ;	main.c: 276: }
      008641 5B 09            [ 2]  822 	addw	sp, #9
      008643 81               [ 4]  823 	ret
                                    824 ;	main.c: 278: void uart_init(void){
                                    825 ;	-----------------------------------------
                                    826 ;	 function uart_init
                                    827 ;	-----------------------------------------
      008644                        828 _uart_init:
                                    829 ;	main.c: 279: CLK_CKDIVR = 0;
      008644 35 00 50 C6      [ 1]  830 	mov	0x50c6+0, #0x00
                                    831 ;	main.c: 282: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008648 72 16 52 35      [ 1]  832 	bset	0x5235, #3
                                    833 ;	main.c: 283: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      00864C 72 14 52 35      [ 1]  834 	bset	0x5235, #2
                                    835 ;	main.c: 284: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008650 C6 52 36         [ 1]  836 	ld	a, 0x5236
      008653 A4 CF            [ 1]  837 	and	a, #0xcf
      008655 C7 52 36         [ 1]  838 	ld	0x5236, a
                                    839 ;	main.c: 286: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008658 35 03 52 33      [ 1]  840 	mov	0x5233+0, #0x03
      00865C 35 68 52 32      [ 1]  841 	mov	0x5232+0, #0x68
                                    842 ;	main.c: 287: }
      008660 81               [ 4]  843 	ret
                                    844 ;	main.c: 291: void i2c_init(void) {
                                    845 ;	-----------------------------------------
                                    846 ;	 function i2c_init
                                    847 ;	-----------------------------------------
      008661                        848 _i2c_init:
                                    849 ;	main.c: 297: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008661 72 11 52 10      [ 1]  850 	bres	0x5210, #0
                                    851 ;	main.c: 298: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008665 35 10 52 12      [ 1]  852 	mov	0x5212+0, #0x10
                                    853 ;	main.c: 299: I2C_CCRH = 0;                   // =0
      008669 35 00 52 1C      [ 1]  854 	mov	0x521c+0, #0x00
                                    855 ;	main.c: 300: I2C_CCRL = 80;                  // 100kHz for I2C
      00866D 35 50 52 1B      [ 1]  856 	mov	0x521b+0, #0x50
                                    857 ;	main.c: 301: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      008671 72 1F 52 1C      [ 1]  858 	bres	0x521c, #7
                                    859 ;	main.c: 302: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      008675 72 1F 52 14      [ 1]  860 	bres	0x5214, #7
                                    861 ;	main.c: 303: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      008679 72 1C 52 14      [ 1]  862 	bset	0x5214, #6
                                    863 ;	main.c: 304: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      00867D 72 10 52 10      [ 1]  864 	bset	0x5210, #0
                                    865 ;	main.c: 305: }
      008681 81               [ 4]  866 	ret
                                    867 ;	main.c: 314: void i2c_start(void) {
                                    868 ;	-----------------------------------------
                                    869 ;	 function i2c_start
                                    870 ;	-----------------------------------------
      008682                        871 _i2c_start:
                                    872 ;	main.c: 315: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      008682 72 10 52 11      [ 1]  873 	bset	0x5211, #0
                                    874 ;	main.c: 316: while(!(I2C_SR1 & (1 << 0)));
      008686                        875 00101$:
      008686 72 01 52 17 FB   [ 2]  876 	btjf	0x5217, #0, 00101$
                                    877 ;	main.c: 318: }
      00868B 81               [ 4]  878 	ret
                                    879 ;	main.c: 320: void i2c_send_address(uint8_t address) {
                                    880 ;	-----------------------------------------
                                    881 ;	 function i2c_send_address
                                    882 ;	-----------------------------------------
      00868C                        883 _i2c_send_address:
                                    884 ;	main.c: 321: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      00868C 48               [ 1]  885 	sll	a
      00868D C7 52 16         [ 1]  886 	ld	0x5216, a
                                    887 ;	main.c: 323: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008690                        888 00102$:
      008690 72 03 52 17 01   [ 2]  889 	btjf	0x5217, #1, 00117$
      008695 81               [ 4]  890 	ret
      008696                        891 00117$:
      008696 72 05 52 18 F5   [ 2]  892 	btjf	0x5218, #2, 00102$
                                    893 ;	main.c: 324: }
      00869B 81               [ 4]  894 	ret
                                    895 ;	main.c: 326: void i2c_stop(void) {
                                    896 ;	-----------------------------------------
                                    897 ;	 function i2c_stop
                                    898 ;	-----------------------------------------
      00869C                        899 _i2c_stop:
                                    900 ;	main.c: 327: I2C_CR2 = I2C_CR2 | (1 << 1);// Отправка стопового сигнала
      00869C 72 12 52 11      [ 1]  901 	bset	0x5211, #1
                                    902 ;	main.c: 329: }
      0086A0 81               [ 4]  903 	ret
                                    904 ;	main.c: 330: void i2c_write(void){
                                    905 ;	-----------------------------------------
                                    906 ;	 function i2c_write
                                    907 ;	-----------------------------------------
      0086A1                        908 _i2c_write:
      0086A1 52 02            [ 2]  909 	sub	sp, #2
                                    910 ;	main.c: 331: I2C_DR = d_addr;
      0086A3 55 01 03 52 16   [ 1]  911 	mov	0x5216+0, _d_addr+0
                                    912 ;	main.c: 332: status_check();
      0086A8 CD 85 6D         [ 4]  913 	call	_status_check
                                    914 ;	main.c: 333: while (!(I2C_SR1 & (1 << 7)) && !(I2C_SR2 & (1 << 2))); // Отправка адреса регистра
      0086AB                        915 00102$:
      0086AB C6 52 17         [ 1]  916 	ld	a, 0x5217
      0086AE 2B 05            [ 1]  917 	jrmi	00104$
      0086B0 72 05 52 18 F6   [ 2]  918 	btjf	0x5218, #2, 00102$
      0086B5                        919 00104$:
                                    920 ;	main.c: 334: status_check();
      0086B5 CD 85 6D         [ 4]  921 	call	_status_check
                                    922 ;	main.c: 335: for(int i = 0;i < d_size;i++)
      0086B8 5F               [ 1]  923 	clrw	x
      0086B9                        924 00111$:
      0086B9 C6 01 05         [ 1]  925 	ld	a, _d_size+0
      0086BC 6B 02            [ 1]  926 	ld	(0x02, sp), a
      0086BE 0F 01            [ 1]  927 	clr	(0x01, sp)
      0086C0 13 01            [ 2]  928 	cpw	x, (0x01, sp)
      0086C2 2E 20            [ 1]  929 	jrsge	00113$
                                    930 ;	main.c: 337: I2C_DR = data_buf[i];
      0086C4 90 93            [ 1]  931 	ldw	y, x
      0086C6 90 D6 01 07      [ 1]  932 	ld	a, (_data_buf+0, y)
      0086CA C7 52 16         [ 1]  933 	ld	0x5216, a
                                    934 ;	main.c: 338: status_check();
      0086CD 89               [ 2]  935 	pushw	x
      0086CE CD 85 6D         [ 4]  936 	call	_status_check
      0086D1 85               [ 2]  937 	popw	x
                                    938 ;	main.c: 339: while (!(I2C_SR1 & (1 << 7)) && !(I2C_SR2 & (1 << 2)));
      0086D2                        939 00106$:
      0086D2 C6 52 17         [ 1]  940 	ld	a, 0x5217
      0086D5 2B 05            [ 1]  941 	jrmi	00108$
      0086D7 72 05 52 18 F6   [ 2]  942 	btjf	0x5218, #2, 00106$
      0086DC                        943 00108$:
                                    944 ;	main.c: 340: status_check();
      0086DC 89               [ 2]  945 	pushw	x
      0086DD CD 85 6D         [ 4]  946 	call	_status_check
      0086E0 85               [ 2]  947 	popw	x
                                    948 ;	main.c: 335: for(int i = 0;i < d_size;i++)
      0086E1 5C               [ 1]  949 	incw	x
      0086E2 20 D5            [ 2]  950 	jra	00111$
      0086E4                        951 00113$:
                                    952 ;	main.c: 342: }
      0086E4 5B 02            [ 2]  953 	addw	sp, #2
      0086E6 81               [ 4]  954 	ret
                                    955 ;	main.c: 344: void i2c_read(void){
                                    956 ;	-----------------------------------------
                                    957 ;	 function i2c_read
                                    958 ;	-----------------------------------------
      0086E7                        959 _i2c_read:
      0086E7 52 04            [ 2]  960 	sub	sp, #4
                                    961 ;	main.c: 345: I2C_DR = d_addr;
      0086E9 55 01 03 52 16   [ 1]  962 	mov	0x5216+0, _d_addr+0
                                    963 ;	main.c: 346: status_check();
      0086EE CD 85 6D         [ 4]  964 	call	_status_check
                                    965 ;	main.c: 347: while (!(I2C_SR1 & (1 << 7)) && !(I2C_SR2 & (1 << 2))); // Отправка адреса регистра
      0086F1                        966 00102$:
      0086F1 C6 52 17         [ 1]  967 	ld	a, 0x5217
      0086F4 2B 05            [ 1]  968 	jrmi	00104$
      0086F6 72 05 52 18 F6   [ 2]  969 	btjf	0x5218, #2, 00102$
      0086FB                        970 00104$:
                                    971 ;	main.c: 348: i2c_stop();
      0086FB CD 86 9C         [ 4]  972 	call	_i2c_stop
                                    973 ;	main.c: 349: i2c_start();
      0086FE CD 86 82         [ 4]  974 	call	_i2c_start
                                    975 ;	main.c: 350: I2C_DR = (current_dev << 1) | (1 << 0);
      008701 C6 02 06         [ 1]  976 	ld	a, _current_dev+0
      008704 48               [ 1]  977 	sll	a
      008705 AA 01            [ 1]  978 	or	a, #0x01
      008707 C7 52 16         [ 1]  979 	ld	0x5216, a
                                    980 ;	main.c: 351: status_check();
      00870A CD 85 6D         [ 4]  981 	call	_status_check
                                    982 ;	main.c: 352: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      00870D                        983 00106$:
      00870D 72 02 52 17 05   [ 2]  984 	btjt	0x5217, #1, 00108$
      008712 72 05 52 18 F6   [ 2]  985 	btjf	0x5218, #2, 00106$
      008717                        986 00108$:
                                    987 ;	main.c: 353: status_check();
      008717 CD 85 6D         [ 4]  988 	call	_status_check
                                    989 ;	main.c: 355: for(int i = 0;i < d_size;i++)
      00871A 5F               [ 1]  990 	clrw	x
      00871B 1F 03            [ 2]  991 	ldw	(0x03, sp), x
      00871D                        992 00114$:
      00871D C6 01 05         [ 1]  993 	ld	a, _d_size+0
      008720 6B 02            [ 1]  994 	ld	(0x02, sp), a
      008722 0F 01            [ 1]  995 	clr	(0x01, sp)
      008724 1E 03            [ 2]  996 	ldw	x, (0x03, sp)
      008726 13 01            [ 2]  997 	cpw	x, (0x01, sp)
      008728 2E 1D            [ 1]  998 	jrsge	00116$
                                    999 ;	main.c: 357: status_check();
      00872A CD 85 6D         [ 4] 1000 	call	_status_check
                                   1001 ;	main.c: 358: data_buf[i] = I2C_DR;
      00872D 1E 03            [ 2] 1002 	ldw	x, (0x03, sp)
      00872F C6 52 16         [ 1] 1003 	ld	a, 0x5216
      008732 D7 01 07         [ 1] 1004 	ld	((_data_buf+0), x), a
                                   1005 ;	main.c: 359: status_check();
      008735 CD 85 6D         [ 4] 1006 	call	_status_check
                                   1007 ;	main.c: 360: while (!(I2C_SR1 & (1 << 6)));
      008738                       1008 00109$:
      008738 72 0D 52 17 FB   [ 2] 1009 	btjf	0x5217, #6, 00109$
                                   1010 ;	main.c: 361: status_check();
      00873D CD 85 6D         [ 4] 1011 	call	_status_check
                                   1012 ;	main.c: 355: for(int i = 0;i < d_size;i++)
      008740 1E 03            [ 2] 1013 	ldw	x, (0x03, sp)
      008742 5C               [ 1] 1014 	incw	x
      008743 1F 03            [ 2] 1015 	ldw	(0x03, sp), x
      008745 20 D6            [ 2] 1016 	jra	00114$
      008747                       1017 00116$:
                                   1018 ;	main.c: 363: }
      008747 5B 04            [ 2] 1019 	addw	sp, #4
      008749 81               [ 4] 1020 	ret
                                   1021 ;	main.c: 364: void i2c_scan(void) {
                                   1022 ;	-----------------------------------------
                                   1023 ;	 function i2c_scan
                                   1024 ;	-----------------------------------------
      00874A                       1025 _i2c_scan:
      00874A 52 02            [ 2] 1026 	sub	sp, #2
                                   1027 ;	main.c: 365: for (uint8_t addr = current_dev; addr < 127; addr++) {
      00874C C6 02 06         [ 1] 1028 	ld	a, _current_dev+0
      00874F 6B 01            [ 1] 1029 	ld	(0x01, sp), a
      008751 6B 02            [ 1] 1030 	ld	(0x02, sp), a
      008753                       1031 00105$:
      008753 7B 02            [ 1] 1032 	ld	a, (0x02, sp)
      008755 A1 7F            [ 1] 1033 	cp	a, #0x7f
      008757 24 26            [ 1] 1034 	jrnc	00107$
                                   1035 ;	main.c: 366: i2c_start();
      008759 CD 86 82         [ 4] 1036 	call	_i2c_start
                                   1037 ;	main.c: 367: i2c_send_address(addr);
      00875C 7B 02            [ 1] 1038 	ld	a, (0x02, sp)
      00875E CD 86 8C         [ 4] 1039 	call	_i2c_send_address
                                   1040 ;	main.c: 368: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      008761 72 04 52 18 0A   [ 2] 1041 	btjt	0x5218, #2, 00102$
                                   1042 ;	main.c: 370: current_dev = addr;
      008766 7B 01            [ 1] 1043 	ld	a, (0x01, sp)
      008768 C7 02 06         [ 1] 1044 	ld	_current_dev+0, a
                                   1045 ;	main.c: 371: i2c_stop();
      00876B 5B 02            [ 2] 1046 	addw	sp, #2
                                   1047 ;	main.c: 372: break;
      00876D CC 86 9C         [ 2] 1048 	jp	_i2c_stop
      008770                       1049 00102$:
                                   1050 ;	main.c: 374: i2c_stop();
      008770 CD 86 9C         [ 4] 1051 	call	_i2c_stop
                                   1052 ;	main.c: 375: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      008773 72 15 52 18      [ 1] 1053 	bres	0x5218, #2
                                   1054 ;	main.c: 365: for (uint8_t addr = current_dev; addr < 127; addr++) {
      008777 0C 02            [ 1] 1055 	inc	(0x02, sp)
      008779 7B 02            [ 1] 1056 	ld	a, (0x02, sp)
      00877B 6B 01            [ 1] 1057 	ld	(0x01, sp), a
      00877D 20 D4            [ 2] 1058 	jra	00105$
      00877F                       1059 00107$:
                                   1060 ;	main.c: 377: }
      00877F 5B 02            [ 2] 1061 	addw	sp, #2
      008781 81               [ 4] 1062 	ret
                                   1063 ;	main.c: 387: void cm_SM(void)
                                   1064 ;	-----------------------------------------
                                   1065 ;	 function cm_SM
                                   1066 ;	-----------------------------------------
      008782                       1067 _cm_SM:
      008782 52 04            [ 2] 1068 	sub	sp, #4
                                   1069 ;	main.c: 389: char cur_dev[4]={0};
      008784 0F 01            [ 1] 1070 	clr	(0x01, sp)
      008786 0F 02            [ 1] 1071 	clr	(0x02, sp)
      008788 0F 03            [ 1] 1072 	clr	(0x03, sp)
      00878A 0F 04            [ 1] 1073 	clr	(0x04, sp)
                                   1074 ;	main.c: 390: convert_int_to_chars(current_dev, cur_dev);
      00878C 96               [ 1] 1075 	ldw	x, sp
      00878D 5C               [ 1] 1076 	incw	x
      00878E C6 02 06         [ 1] 1077 	ld	a, _current_dev+0
      008791 CD 83 59         [ 4] 1078 	call	_convert_int_to_chars
                                   1079 ;	main.c: 391: uart_write("SM ");
      008794 AE 80 80         [ 2] 1080 	ldw	x, #(___str_9+0)
      008797 CD 82 F8         [ 4] 1081 	call	_uart_write
                                   1082 ;	main.c: 392: uart_write(cur_dev);
      00879A 96               [ 1] 1083 	ldw	x, sp
      00879B 5C               [ 1] 1084 	incw	x
      00879C CD 82 F8         [ 4] 1085 	call	_uart_write
                                   1086 ;	main.c: 393: uart_write("\r\n");
      00879F AE 80 84         [ 2] 1087 	ldw	x, #(___str_10+0)
      0087A2 CD 82 F8         [ 4] 1088 	call	_uart_write
                                   1089 ;	main.c: 394: }
      0087A5 5B 04            [ 2] 1090 	addw	sp, #4
      0087A7 81               [ 4] 1091 	ret
                                   1092 ;	main.c: 395: void cm_SN(void)
                                   1093 ;	-----------------------------------------
                                   1094 ;	 function cm_SN
                                   1095 ;	-----------------------------------------
      0087A8                       1096 _cm_SN:
                                   1097 ;	main.c: 397: i2c_scan();
      0087A8 CD 87 4A         [ 4] 1098 	call	_i2c_scan
                                   1099 ;	main.c: 398: cm_SM();
                                   1100 ;	main.c: 399: }
      0087AB CC 87 82         [ 2] 1101 	jp	_cm_SM
                                   1102 ;	main.c: 400: void cm_RM(void)
                                   1103 ;	-----------------------------------------
                                   1104 ;	 function cm_RM
                                   1105 ;	-----------------------------------------
      0087AE                       1106 _cm_RM:
                                   1107 ;	main.c: 402: current_dev = 0;
      0087AE 72 5F 02 06      [ 1] 1108 	clr	_current_dev+0
                                   1109 ;	main.c: 403: uart_write("RM\n");
      0087B2 AE 80 87         [ 2] 1110 	ldw	x, #(___str_11+0)
                                   1111 ;	main.c: 404: }
      0087B5 CC 82 F8         [ 2] 1112 	jp	_uart_write
                                   1113 ;	main.c: 406: void cm_DB(void)
                                   1114 ;	-----------------------------------------
                                   1115 ;	 function cm_DB
                                   1116 ;	-----------------------------------------
      0087B8                       1117 _cm_DB:
                                   1118 ;	main.c: 408: status_check();
                                   1119 ;	main.c: 409: }
      0087B8 CC 85 6D         [ 2] 1120 	jp	_status_check
                                   1121 ;	main.c: 411: void cm_ST(void)
                                   1122 ;	-----------------------------------------
                                   1123 ;	 function cm_ST
                                   1124 ;	-----------------------------------------
      0087BB                       1125 _cm_ST:
                                   1126 ;	main.c: 413: get_addr_from_buff();
      0087BB CD 84 3D         [ 4] 1127 	call	_get_addr_from_buff
                                   1128 ;	main.c: 414: current_dev = d_addr;
      0087BE 55 01 03 02 06   [ 1] 1129 	mov	_current_dev+0, _d_addr+0
                                   1130 ;	main.c: 415: uart_write("ST\n");
      0087C3 AE 80 8B         [ 2] 1131 	ldw	x, #(___str_12+0)
                                   1132 ;	main.c: 416: }
      0087C6 CC 82 F8         [ 2] 1133 	jp	_uart_write
                                   1134 ;	main.c: 417: void cm_SR(void)
                                   1135 ;	-----------------------------------------
                                   1136 ;	 function cm_SR
                                   1137 ;	-----------------------------------------
      0087C9                       1138 _cm_SR:
      0087C9 52 04            [ 2] 1139 	sub	sp, #4
                                   1140 ;	main.c: 419: i2c_start();
      0087CB CD 86 82         [ 4] 1141 	call	_i2c_start
                                   1142 ;	main.c: 420: i2c_send_address(current_dev);
      0087CE C6 02 06         [ 1] 1143 	ld	a, _current_dev+0
      0087D1 CD 86 8C         [ 4] 1144 	call	_i2c_send_address
                                   1145 ;	main.c: 421: i2c_read();
      0087D4 CD 86 E7         [ 4] 1146 	call	_i2c_read
                                   1147 ;	main.c: 422: i2c_stop();
      0087D7 CD 86 9C         [ 4] 1148 	call	_i2c_stop
                                   1149 ;	main.c: 423: uart_write("SR ");
      0087DA AE 80 8F         [ 2] 1150 	ldw	x, #(___str_13+0)
      0087DD CD 82 F8         [ 4] 1151 	call	_uart_write
                                   1152 ;	main.c: 424: convert_int_to_chars(d_addr, a);
      0087E0 AE 01 00         [ 2] 1153 	ldw	x, #(_a+0)
      0087E3 C6 01 03         [ 1] 1154 	ld	a, _d_addr+0
      0087E6 CD 83 59         [ 4] 1155 	call	_convert_int_to_chars
                                   1156 ;	main.c: 425: uart_write(a);
      0087E9 AE 01 00         [ 2] 1157 	ldw	x, #(_a+0)
      0087EC CD 82 F8         [ 4] 1158 	call	_uart_write
                                   1159 ;	main.c: 426: uart_write(" ");
      0087EF AE 80 93         [ 2] 1160 	ldw	x, #(___str_14+0)
      0087F2 CD 82 F8         [ 4] 1161 	call	_uart_write
                                   1162 ;	main.c: 427: convert_int_to_chars(d_size, a);
      0087F5 AE 01 00         [ 2] 1163 	ldw	x, #(_a+0)
      0087F8 C6 01 05         [ 1] 1164 	ld	a, _d_size+0
      0087FB CD 83 59         [ 4] 1165 	call	_convert_int_to_chars
                                   1166 ;	main.c: 428: uart_write(a);
      0087FE AE 01 00         [ 2] 1167 	ldw	x, #(_a+0)
      008801 CD 82 F8         [ 4] 1168 	call	_uart_write
                                   1169 ;	main.c: 429: for(int i = 0;i < d_size;i++)
      008804 5F               [ 1] 1170 	clrw	x
      008805 1F 03            [ 2] 1171 	ldw	(0x03, sp), x
      008807                       1172 00103$:
      008807 C6 01 05         [ 1] 1173 	ld	a, _d_size+0
      00880A 6B 02            [ 1] 1174 	ld	(0x02, sp), a
      00880C 0F 01            [ 1] 1175 	clr	(0x01, sp)
      00880E 1E 03            [ 2] 1176 	ldw	x, (0x03, sp)
      008810 13 01            [ 2] 1177 	cpw	x, (0x01, sp)
      008812 2E 1E            [ 1] 1178 	jrsge	00101$
                                   1179 ;	main.c: 431: uart_write(" ");
      008814 AE 80 93         [ 2] 1180 	ldw	x, #(___str_14+0)
      008817 CD 82 F8         [ 4] 1181 	call	_uart_write
                                   1182 ;	main.c: 432: convert_int_to_chars(data_buf[i], a);
      00881A 1E 03            [ 2] 1183 	ldw	x, (0x03, sp)
      00881C D6 01 07         [ 1] 1184 	ld	a, (_data_buf+0, x)
      00881F AE 01 00         [ 2] 1185 	ldw	x, #(_a+0)
      008822 CD 83 59         [ 4] 1186 	call	_convert_int_to_chars
                                   1187 ;	main.c: 433: uart_write(a);
      008825 AE 01 00         [ 2] 1188 	ldw	x, #(_a+0)
      008828 CD 82 F8         [ 4] 1189 	call	_uart_write
                                   1190 ;	main.c: 429: for(int i = 0;i < d_size;i++)
      00882B 1E 03            [ 2] 1191 	ldw	x, (0x03, sp)
      00882D 5C               [ 1] 1192 	incw	x
      00882E 1F 03            [ 2] 1193 	ldw	(0x03, sp), x
      008830 20 D5            [ 2] 1194 	jra	00103$
      008832                       1195 00101$:
                                   1196 ;	main.c: 436: uart_write("\r\n");
      008832 AE 80 84         [ 2] 1197 	ldw	x, #(___str_10+0)
      008835 5B 04            [ 2] 1198 	addw	sp, #4
                                   1199 ;	main.c: 437: }
      008837 CC 82 F8         [ 2] 1200 	jp	_uart_write
                                   1201 ;	main.c: 438: void cm_SW(void)
                                   1202 ;	-----------------------------------------
                                   1203 ;	 function cm_SW
                                   1204 ;	-----------------------------------------
      00883A                       1205 _cm_SW:
      00883A 52 04            [ 2] 1206 	sub	sp, #4
                                   1207 ;	main.c: 440: i2c_start();
      00883C CD 86 82         [ 4] 1208 	call	_i2c_start
                                   1209 ;	main.c: 441: i2c_send_address(current_dev);
      00883F C6 02 06         [ 1] 1210 	ld	a, _current_dev+0
      008842 CD 86 8C         [ 4] 1211 	call	_i2c_send_address
                                   1212 ;	main.c: 442: i2c_write();
      008845 CD 86 A1         [ 4] 1213 	call	_i2c_write
                                   1214 ;	main.c: 443: i2c_stop();
      008848 CD 86 9C         [ 4] 1215 	call	_i2c_stop
                                   1216 ;	main.c: 444: uart_write("SW ");
      00884B AE 80 95         [ 2] 1217 	ldw	x, #(___str_15+0)
      00884E CD 82 F8         [ 4] 1218 	call	_uart_write
                                   1219 ;	main.c: 445: convert_int_to_chars(d_addr, a);
      008851 AE 01 00         [ 2] 1220 	ldw	x, #(_a+0)
      008854 C6 01 03         [ 1] 1221 	ld	a, _d_addr+0
      008857 CD 83 59         [ 4] 1222 	call	_convert_int_to_chars
                                   1223 ;	main.c: 446: uart_write(a);
      00885A AE 01 00         [ 2] 1224 	ldw	x, #(_a+0)
      00885D CD 82 F8         [ 4] 1225 	call	_uart_write
                                   1226 ;	main.c: 447: uart_write(" ");
      008860 AE 80 93         [ 2] 1227 	ldw	x, #(___str_14+0)
      008863 CD 82 F8         [ 4] 1228 	call	_uart_write
                                   1229 ;	main.c: 448: convert_int_to_chars(d_size, a);
      008866 AE 01 00         [ 2] 1230 	ldw	x, #(_a+0)
      008869 C6 01 05         [ 1] 1231 	ld	a, _d_size+0
      00886C CD 83 59         [ 4] 1232 	call	_convert_int_to_chars
                                   1233 ;	main.c: 449: uart_write(a);
      00886F AE 01 00         [ 2] 1234 	ldw	x, #(_a+0)
      008872 CD 82 F8         [ 4] 1235 	call	_uart_write
                                   1236 ;	main.c: 450: for(int i = 0;i < d_size;i++)
      008875 5F               [ 1] 1237 	clrw	x
      008876 1F 03            [ 2] 1238 	ldw	(0x03, sp), x
      008878                       1239 00103$:
      008878 C6 01 05         [ 1] 1240 	ld	a, _d_size+0
      00887B 6B 02            [ 1] 1241 	ld	(0x02, sp), a
      00887D 0F 01            [ 1] 1242 	clr	(0x01, sp)
      00887F 1E 03            [ 2] 1243 	ldw	x, (0x03, sp)
      008881 13 01            [ 2] 1244 	cpw	x, (0x01, sp)
      008883 2E 1E            [ 1] 1245 	jrsge	00101$
                                   1246 ;	main.c: 452: uart_write(" ");
      008885 AE 80 93         [ 2] 1247 	ldw	x, #(___str_14+0)
      008888 CD 82 F8         [ 4] 1248 	call	_uart_write
                                   1249 ;	main.c: 453: convert_int_to_chars(data_buf[i], a);
      00888B 1E 03            [ 2] 1250 	ldw	x, (0x03, sp)
      00888D D6 01 07         [ 1] 1251 	ld	a, (_data_buf+0, x)
      008890 AE 01 00         [ 2] 1252 	ldw	x, #(_a+0)
      008893 CD 83 59         [ 4] 1253 	call	_convert_int_to_chars
                                   1254 ;	main.c: 454: uart_write(a);
      008896 AE 01 00         [ 2] 1255 	ldw	x, #(_a+0)
      008899 CD 82 F8         [ 4] 1256 	call	_uart_write
                                   1257 ;	main.c: 450: for(int i = 0;i < d_size;i++)
      00889C 1E 03            [ 2] 1258 	ldw	x, (0x03, sp)
      00889E 5C               [ 1] 1259 	incw	x
      00889F 1F 03            [ 2] 1260 	ldw	(0x03, sp), x
      0088A1 20 D5            [ 2] 1261 	jra	00103$
      0088A3                       1262 00101$:
                                   1263 ;	main.c: 457: uart_write("\r\n");
      0088A3 AE 80 84         [ 2] 1264 	ldw	x, #(___str_10+0)
      0088A6 5B 04            [ 2] 1265 	addw	sp, #4
                                   1266 ;	main.c: 458: }
      0088A8 CC 82 F8         [ 2] 1267 	jp	_uart_write
                                   1268 ;	main.c: 466: int data_handler(void)
                                   1269 ;	-----------------------------------------
                                   1270 ;	 function data_handler
                                   1271 ;	-----------------------------------------
      0088AB                       1272 _data_handler:
                                   1273 ;	main.c: 468: p_size = 0;
      0088AB 72 5F 01 04      [ 1] 1274 	clr	_p_size+0
                                   1275 ;	main.c: 469: p_bytes = 0;
      0088AF 72 5F 01 06      [ 1] 1276 	clr	_p_bytes+0
                                   1277 ;	main.c: 470: d_addr = 0;
      0088B3 72 5F 01 03      [ 1] 1278 	clr	_d_addr+0
                                   1279 ;	main.c: 471: d_size = 0;
      0088B7 72 5F 01 05      [ 1] 1280 	clr	_d_size+0
                                   1281 ;	main.c: 472: memset(a, 0, sizeof(a));
      0088BB 4B 03            [ 1] 1282 	push	#0x03
      0088BD 4B 00            [ 1] 1283 	push	#0x00
      0088BF 5F               [ 1] 1284 	clrw	x
      0088C0 89               [ 2] 1285 	pushw	x
      0088C1 AE 01 00         [ 2] 1286 	ldw	x, #(_a+0)
      0088C4 CD 8A 68         [ 4] 1287 	call	_memset
                                   1288 ;	main.c: 473: memset(data_buf, 0, sizeof(data_buf));
      0088C7 4B FF            [ 1] 1289 	push	#0xff
      0088C9 4B 00            [ 1] 1290 	push	#0x00
      0088CB 5F               [ 1] 1291 	clrw	x
      0088CC 89               [ 2] 1292 	pushw	x
      0088CD AE 01 07         [ 2] 1293 	ldw	x, #(_data_buf+0)
      0088D0 CD 8A 68         [ 4] 1294 	call	_memset
                                   1295 ;	main.c: 474: if(memcmp(&buffer[0],"SM",2) == 0)
      0088D3 4B 02            [ 1] 1296 	push	#0x02
      0088D5 4B 00            [ 1] 1297 	push	#0x00
      0088D7 4B 99            [ 1] 1298 	push	#<(___str_16+0)
      0088D9 4B 80            [ 1] 1299 	push	#((___str_16+0) >> 8)
      0088DB AE 00 01         [ 2] 1300 	ldw	x, #(_buffer+0)
      0088DE CD 89 D2         [ 4] 1301 	call	_memcmp
                                   1302 ;	main.c: 475: return 1;
      0088E1 5D               [ 2] 1303 	tnzw	x
      0088E2 26 02            [ 1] 1304 	jrne	00102$
      0088E4 5C               [ 1] 1305 	incw	x
      0088E5 81               [ 4] 1306 	ret
      0088E6                       1307 00102$:
                                   1308 ;	main.c: 476: if(memcmp(&buffer[0],"SN",2) == 0)
      0088E6 4B 02            [ 1] 1309 	push	#0x02
      0088E8 4B 00            [ 1] 1310 	push	#0x00
      0088EA 4B 9C            [ 1] 1311 	push	#<(___str_17+0)
      0088EC 4B 80            [ 1] 1312 	push	#((___str_17+0) >> 8)
      0088EE AE 00 01         [ 2] 1313 	ldw	x, #(_buffer+0)
      0088F1 CD 89 D2         [ 4] 1314 	call	_memcmp
      0088F4 5D               [ 2] 1315 	tnzw	x
      0088F5 26 04            [ 1] 1316 	jrne	00104$
                                   1317 ;	main.c: 477: return 2;
      0088F7 AE 00 02         [ 2] 1318 	ldw	x, #0x0002
      0088FA 81               [ 4] 1319 	ret
      0088FB                       1320 00104$:
                                   1321 ;	main.c: 478: if(memcmp(&buffer[0],"ST",2) == 0)
      0088FB 4B 02            [ 1] 1322 	push	#0x02
      0088FD 4B 00            [ 1] 1323 	push	#0x00
      0088FF 4B 9F            [ 1] 1324 	push	#<(___str_18+0)
      008901 4B 80            [ 1] 1325 	push	#((___str_18+0) >> 8)
      008903 AE 00 01         [ 2] 1326 	ldw	x, #(_buffer+0)
      008906 CD 89 D2         [ 4] 1327 	call	_memcmp
      008909 5D               [ 2] 1328 	tnzw	x
      00890A 26 04            [ 1] 1329 	jrne	00106$
                                   1330 ;	main.c: 479: return 5;
      00890C AE 00 05         [ 2] 1331 	ldw	x, #0x0005
      00890F 81               [ 4] 1332 	ret
      008910                       1333 00106$:
                                   1334 ;	main.c: 480: if(memcmp(&buffer[0],"RM",2) == 0)
      008910 4B 02            [ 1] 1335 	push	#0x02
      008912 4B 00            [ 1] 1336 	push	#0x00
      008914 4B A2            [ 1] 1337 	push	#<(___str_19+0)
      008916 4B 80            [ 1] 1338 	push	#((___str_19+0) >> 8)
      008918 AE 00 01         [ 2] 1339 	ldw	x, #(_buffer+0)
      00891B CD 89 D2         [ 4] 1340 	call	_memcmp
      00891E 5D               [ 2] 1341 	tnzw	x
      00891F 26 04            [ 1] 1342 	jrne	00108$
                                   1343 ;	main.c: 481: return 6;
      008921 AE 00 06         [ 2] 1344 	ldw	x, #0x0006
      008924 81               [ 4] 1345 	ret
      008925                       1346 00108$:
                                   1347 ;	main.c: 482: if(memcmp(&buffer[0],"DB",2) == 0)
      008925 4B 02            [ 1] 1348 	push	#0x02
      008927 4B 00            [ 1] 1349 	push	#0x00
      008929 4B A5            [ 1] 1350 	push	#<(___str_20+0)
      00892B 4B 80            [ 1] 1351 	push	#((___str_20+0) >> 8)
      00892D AE 00 01         [ 2] 1352 	ldw	x, #(_buffer+0)
      008930 CD 89 D2         [ 4] 1353 	call	_memcmp
      008933 5D               [ 2] 1354 	tnzw	x
      008934 26 04            [ 1] 1355 	jrne	00110$
                                   1356 ;	main.c: 483: return 7;
      008936 AE 00 07         [ 2] 1357 	ldw	x, #0x0007
      008939 81               [ 4] 1358 	ret
      00893A                       1359 00110$:
                                   1360 ;	main.c: 485: get_addr_from_buff();
      00893A CD 84 3D         [ 4] 1361 	call	_get_addr_from_buff
                                   1362 ;	main.c: 486: get_size_from_buff();
      00893D CD 84 82         [ 4] 1363 	call	_get_size_from_buff
                                   1364 ;	main.c: 488: if(memcmp(&buffer[0],"SR",2) == 0)
      008940 4B 02            [ 1] 1365 	push	#0x02
      008942 4B 00            [ 1] 1366 	push	#0x00
      008944 4B A8            [ 1] 1367 	push	#<(___str_21+0)
      008946 4B 80            [ 1] 1368 	push	#((___str_21+0) >> 8)
      008948 AE 00 01         [ 2] 1369 	ldw	x, #(_buffer+0)
      00894B CD 89 D2         [ 4] 1370 	call	_memcmp
      00894E 5D               [ 2] 1371 	tnzw	x
      00894F 26 04            [ 1] 1372 	jrne	00112$
                                   1373 ;	main.c: 489: return 3;
      008951 AE 00 03         [ 2] 1374 	ldw	x, #0x0003
      008954 81               [ 4] 1375 	ret
      008955                       1376 00112$:
                                   1377 ;	main.c: 491: char_buffer_to_int();
      008955 CD 84 DC         [ 4] 1378 	call	_char_buffer_to_int
                                   1379 ;	main.c: 493: if(memcmp(&buffer[0],"SW",2) == 0)
      008958 4B 02            [ 1] 1380 	push	#0x02
      00895A 4B 00            [ 1] 1381 	push	#0x00
      00895C 4B AB            [ 1] 1382 	push	#<(___str_22+0)
      00895E 4B 80            [ 1] 1383 	push	#((___str_22+0) >> 8)
      008960 AE 00 01         [ 2] 1384 	ldw	x, #(_buffer+0)
      008963 CD 89 D2         [ 4] 1385 	call	_memcmp
      008966 5D               [ 2] 1386 	tnzw	x
      008967 26 04            [ 1] 1387 	jrne	00114$
                                   1388 ;	main.c: 494: return 4;
      008969 AE 00 04         [ 2] 1389 	ldw	x, #0x0004
      00896C 81               [ 4] 1390 	ret
      00896D                       1391 00114$:
                                   1392 ;	main.c: 495: return 0;
      00896D 5F               [ 1] 1393 	clrw	x
                                   1394 ;	main.c: 497: }
      00896E 81               [ 4] 1395 	ret
                                   1396 ;	main.c: 499: void command_switcher(void)
                                   1397 ;	-----------------------------------------
                                   1398 ;	 function command_switcher
                                   1399 ;	-----------------------------------------
      00896F                       1400 _command_switcher:
      00896F 52 04            [ 2] 1401 	sub	sp, #4
                                   1402 ;	main.c: 501: char ar[4]={0};
      008971 0F 01            [ 1] 1403 	clr	(0x01, sp)
      008973 0F 02            [ 1] 1404 	clr	(0x02, sp)
      008975 0F 03            [ 1] 1405 	clr	(0x03, sp)
      008977 0F 04            [ 1] 1406 	clr	(0x04, sp)
                                   1407 ;	main.c: 503: switch(data_handler())
      008979 CD 88 AB         [ 4] 1408 	call	_data_handler
      00897C 5D               [ 2] 1409 	tnzw	x
      00897D 2B 3B            [ 1] 1410 	jrmi	00109$
      00897F A3 00 07         [ 2] 1411 	cpw	x, #0x0007
      008982 2C 36            [ 1] 1412 	jrsgt	00109$
      008984 58               [ 2] 1413 	sllw	x
      008985 DE 89 89         [ 2] 1414 	ldw	x, (#00123$, x)
      008988 FC               [ 2] 1415 	jp	(x)
      008989                       1416 00123$:
      008989 89 BA                 1417 	.dw	#00109$
      00898B 89 99                 1418 	.dw	#00101$
      00898D 89 9E                 1419 	.dw	#00102$
      00898F 89 A3                 1420 	.dw	#00103$
      008991 89 A8                 1421 	.dw	#00104$
      008993 89 AD                 1422 	.dw	#00105$
      008995 89 B2                 1423 	.dw	#00106$
      008997 89 B7                 1424 	.dw	#00107$
                                   1425 ;	main.c: 505: case 1:
      008999                       1426 00101$:
                                   1427 ;	main.c: 506: cm_SM();
      008999 CD 87 82         [ 4] 1428 	call	_cm_SM
                                   1429 ;	main.c: 507: break;
      00899C 20 1C            [ 2] 1430 	jra	00109$
                                   1431 ;	main.c: 508: case 2:
      00899E                       1432 00102$:
                                   1433 ;	main.c: 509: cm_SN();
      00899E CD 87 A8         [ 4] 1434 	call	_cm_SN
                                   1435 ;	main.c: 510: break;
      0089A1 20 17            [ 2] 1436 	jra	00109$
                                   1437 ;	main.c: 511: case 3:
      0089A3                       1438 00103$:
                                   1439 ;	main.c: 512: cm_SR();
      0089A3 CD 87 C9         [ 4] 1440 	call	_cm_SR
                                   1441 ;	main.c: 513: break;
      0089A6 20 12            [ 2] 1442 	jra	00109$
                                   1443 ;	main.c: 514: case 4:
      0089A8                       1444 00104$:
                                   1445 ;	main.c: 515: cm_SW();
      0089A8 CD 88 3A         [ 4] 1446 	call	_cm_SW
                                   1447 ;	main.c: 516: break;
      0089AB 20 0D            [ 2] 1448 	jra	00109$
                                   1449 ;	main.c: 517: case 5:
      0089AD                       1450 00105$:
                                   1451 ;	main.c: 518: cm_ST();
      0089AD CD 87 BB         [ 4] 1452 	call	_cm_ST
                                   1453 ;	main.c: 519: break;
      0089B0 20 08            [ 2] 1454 	jra	00109$
                                   1455 ;	main.c: 520: case 6:
      0089B2                       1456 00106$:
                                   1457 ;	main.c: 521: cm_RM();
      0089B2 CD 87 AE         [ 4] 1458 	call	_cm_RM
                                   1459 ;	main.c: 522: break;
      0089B5 20 03            [ 2] 1460 	jra	00109$
                                   1461 ;	main.c: 523: case 7:
      0089B7                       1462 00107$:
                                   1463 ;	main.c: 524: cm_DB();
      0089B7 CD 87 B8         [ 4] 1464 	call	_cm_DB
                                   1465 ;	main.c: 526: }
      0089BA                       1466 00109$:
                                   1467 ;	main.c: 527: }
      0089BA 5B 04            [ 2] 1468 	addw	sp, #4
      0089BC 81               [ 4] 1469 	ret
                                   1470 ;	main.c: 530: void main(void)
                                   1471 ;	-----------------------------------------
                                   1472 ;	 function main
                                   1473 ;	-----------------------------------------
      0089BD                       1474 _main:
                                   1475 ;	main.c: 532: uart_init();
      0089BD CD 86 44         [ 4] 1476 	call	_uart_init
                                   1477 ;	main.c: 533: i2c_init();
      0089C0 CD 86 61         [ 4] 1478 	call	_i2c_init
                                   1479 ;	main.c: 534: uart_write("SS\n");
      0089C3 AE 80 AE         [ 2] 1480 	ldw	x, #(___str_23+0)
      0089C6 CD 82 F8         [ 4] 1481 	call	_uart_write
                                   1482 ;	main.c: 535: while(1)
      0089C9                       1483 00102$:
                                   1484 ;	main.c: 537: uart_read();
      0089C9 CD 83 23         [ 4] 1485 	call	_uart_read
                                   1486 ;	main.c: 538: command_switcher();
      0089CC CD 89 6F         [ 4] 1487 	call	_command_switcher
      0089CF 20 F8            [ 2] 1488 	jra	00102$
                                   1489 ;	main.c: 540: }
      0089D1 81               [ 4] 1490 	ret
                                   1491 	.area CODE
                                   1492 	.area CONST
                                   1493 	.area CONST
      00802D                       1494 ___str_0:
      00802D 0A                    1495 	.db 0x0a
      00802E 49 32 43 5F 52 45 47  1496 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                    1497 	.db 0x0a
      00803B 00                    1498 	.db 0x00
                                   1499 	.area CODE
                                   1500 	.area CONST
      00803C                       1501 ___str_1:
      00803C 0A                    1502 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20  1503 	.ascii "SR1 -> "
      008044 00                    1504 	.db 0x00
                                   1505 	.area CODE
                                   1506 	.area CONST
      008045                       1507 ___str_2:
      008045 20 3C 2D              1508 	.ascii " <-"
      008048 0A                    1509 	.db 0x0a
      008049 00                    1510 	.db 0x00
                                   1511 	.area CODE
                                   1512 	.area CONST
      00804A                       1513 ___str_3:
      00804A 53 52 32 20 2D 3E 20  1514 	.ascii "SR2 -> "
      008051 00                    1515 	.db 0x00
                                   1516 	.area CODE
                                   1517 	.area CONST
      008052                       1518 ___str_4:
      008052 53 52 33 20 2D 3E 20  1519 	.ascii "SR3 -> "
      008059 00                    1520 	.db 0x00
                                   1521 	.area CODE
                                   1522 	.area CONST
      00805A                       1523 ___str_5:
      00805A 43 52 31 20 2D 3E 20  1524 	.ascii "CR1 -> "
      008061 00                    1525 	.db 0x00
                                   1526 	.area CODE
                                   1527 	.area CONST
      008062                       1528 ___str_6:
      008062 43 52 32 20 2D 3E 20  1529 	.ascii "CR2 -> "
      008069 00                    1530 	.db 0x00
                                   1531 	.area CODE
                                   1532 	.area CONST
      00806A                       1533 ___str_7:
      00806A 44 52 20 2D 3E 20     1534 	.ascii "DR -> "
      008070 00                    1535 	.db 0x00
                                   1536 	.area CODE
                                   1537 	.area CONST
      008071                       1538 ___str_8:
      008071 55 41 52 54 5F 52 45  1539 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      00807E 0A                    1540 	.db 0x0a
      00807F 00                    1541 	.db 0x00
                                   1542 	.area CODE
                                   1543 	.area CONST
      008080                       1544 ___str_9:
      008080 53 4D 20              1545 	.ascii "SM "
      008083 00                    1546 	.db 0x00
                                   1547 	.area CODE
                                   1548 	.area CONST
      008084                       1549 ___str_10:
      008084 0D                    1550 	.db 0x0d
      008085 0A                    1551 	.db 0x0a
      008086 00                    1552 	.db 0x00
                                   1553 	.area CODE
                                   1554 	.area CONST
      008087                       1555 ___str_11:
      008087 52 4D                 1556 	.ascii "RM"
      008089 0A                    1557 	.db 0x0a
      00808A 00                    1558 	.db 0x00
                                   1559 	.area CODE
                                   1560 	.area CONST
      00808B                       1561 ___str_12:
      00808B 53 54                 1562 	.ascii "ST"
      00808D 0A                    1563 	.db 0x0a
      00808E 00                    1564 	.db 0x00
                                   1565 	.area CODE
                                   1566 	.area CONST
      00808F                       1567 ___str_13:
      00808F 53 52 20              1568 	.ascii "SR "
      008092 00                    1569 	.db 0x00
                                   1570 	.area CODE
                                   1571 	.area CONST
      008093                       1572 ___str_14:
      008093 20                    1573 	.ascii " "
      008094 00                    1574 	.db 0x00
                                   1575 	.area CODE
                                   1576 	.area CONST
      008095                       1577 ___str_15:
      008095 53 57 20              1578 	.ascii "SW "
      008098 00                    1579 	.db 0x00
                                   1580 	.area CODE
                                   1581 	.area CONST
      008099                       1582 ___str_16:
      008099 53 4D                 1583 	.ascii "SM"
      00809B 00                    1584 	.db 0x00
                                   1585 	.area CODE
                                   1586 	.area CONST
      00809C                       1587 ___str_17:
      00809C 53 4E                 1588 	.ascii "SN"
      00809E 00                    1589 	.db 0x00
                                   1590 	.area CODE
                                   1591 	.area CONST
      00809F                       1592 ___str_18:
      00809F 53 54                 1593 	.ascii "ST"
      0080A1 00                    1594 	.db 0x00
                                   1595 	.area CODE
                                   1596 	.area CONST
      0080A2                       1597 ___str_19:
      0080A2 52 4D                 1598 	.ascii "RM"
      0080A4 00                    1599 	.db 0x00
                                   1600 	.area CODE
                                   1601 	.area CONST
      0080A5                       1602 ___str_20:
      0080A5 44 42                 1603 	.ascii "DB"
      0080A7 00                    1604 	.db 0x00
                                   1605 	.area CODE
                                   1606 	.area CONST
      0080A8                       1607 ___str_21:
      0080A8 53 52                 1608 	.ascii "SR"
      0080AA 00                    1609 	.db 0x00
                                   1610 	.area CODE
                                   1611 	.area CONST
      0080AB                       1612 ___str_22:
      0080AB 53 57                 1613 	.ascii "SW"
      0080AD 00                    1614 	.db 0x00
                                   1615 	.area CODE
                                   1616 	.area CONST
      0080AE                       1617 ___str_23:
      0080AE 53 53                 1618 	.ascii "SS"
      0080B0 0A                    1619 	.db 0x0a
      0080B1 00                    1620 	.db 0x00
                                   1621 	.area CODE
                                   1622 	.area INITIALIZER
      0080B2                       1623 __xinit__buffer:
      0080B2 00                    1624 	.db #0x00	; 0
      0080B3 00                    1625 	.db 0x00
      0080B4 00                    1626 	.db 0x00
      0080B5 00                    1627 	.db 0x00
      0080B6 00                    1628 	.db 0x00
      0080B7 00                    1629 	.db 0x00
      0080B8 00                    1630 	.db 0x00
      0080B9 00                    1631 	.db 0x00
      0080BA 00                    1632 	.db 0x00
      0080BB 00                    1633 	.db 0x00
      0080BC 00                    1634 	.db 0x00
      0080BD 00                    1635 	.db 0x00
      0080BE 00                    1636 	.db 0x00
      0080BF 00                    1637 	.db 0x00
      0080C0 00                    1638 	.db 0x00
      0080C1 00                    1639 	.db 0x00
      0080C2 00                    1640 	.db 0x00
      0080C3 00                    1641 	.db 0x00
      0080C4 00                    1642 	.db 0x00
      0080C5 00                    1643 	.db 0x00
      0080C6 00                    1644 	.db 0x00
      0080C7 00                    1645 	.db 0x00
      0080C8 00                    1646 	.db 0x00
      0080C9 00                    1647 	.db 0x00
      0080CA 00                    1648 	.db 0x00
      0080CB 00                    1649 	.db 0x00
      0080CC 00                    1650 	.db 0x00
      0080CD 00                    1651 	.db 0x00
      0080CE 00                    1652 	.db 0x00
      0080CF 00                    1653 	.db 0x00
      0080D0 00                    1654 	.db 0x00
      0080D1 00                    1655 	.db 0x00
      0080D2 00                    1656 	.db 0x00
      0080D3 00                    1657 	.db 0x00
      0080D4 00                    1658 	.db 0x00
      0080D5 00                    1659 	.db 0x00
      0080D6 00                    1660 	.db 0x00
      0080D7 00                    1661 	.db 0x00
      0080D8 00                    1662 	.db 0x00
      0080D9 00                    1663 	.db 0x00
      0080DA 00                    1664 	.db 0x00
      0080DB 00                    1665 	.db 0x00
      0080DC 00                    1666 	.db 0x00
      0080DD 00                    1667 	.db 0x00
      0080DE 00                    1668 	.db 0x00
      0080DF 00                    1669 	.db 0x00
      0080E0 00                    1670 	.db 0x00
      0080E1 00                    1671 	.db 0x00
      0080E2 00                    1672 	.db 0x00
      0080E3 00                    1673 	.db 0x00
      0080E4 00                    1674 	.db 0x00
      0080E5 00                    1675 	.db 0x00
      0080E6 00                    1676 	.db 0x00
      0080E7 00                    1677 	.db 0x00
      0080E8 00                    1678 	.db 0x00
      0080E9 00                    1679 	.db 0x00
      0080EA 00                    1680 	.db 0x00
      0080EB 00                    1681 	.db 0x00
      0080EC 00                    1682 	.db 0x00
      0080ED 00                    1683 	.db 0x00
      0080EE 00                    1684 	.db 0x00
      0080EF 00                    1685 	.db 0x00
      0080F0 00                    1686 	.db 0x00
      0080F1 00                    1687 	.db 0x00
      0080F2 00                    1688 	.db 0x00
      0080F3 00                    1689 	.db 0x00
      0080F4 00                    1690 	.db 0x00
      0080F5 00                    1691 	.db 0x00
      0080F6 00                    1692 	.db 0x00
      0080F7 00                    1693 	.db 0x00
      0080F8 00                    1694 	.db 0x00
      0080F9 00                    1695 	.db 0x00
      0080FA 00                    1696 	.db 0x00
      0080FB 00                    1697 	.db 0x00
      0080FC 00                    1698 	.db 0x00
      0080FD 00                    1699 	.db 0x00
      0080FE 00                    1700 	.db 0x00
      0080FF 00                    1701 	.db 0x00
      008100 00                    1702 	.db 0x00
      008101 00                    1703 	.db 0x00
      008102 00                    1704 	.db 0x00
      008103 00                    1705 	.db 0x00
      008104 00                    1706 	.db 0x00
      008105 00                    1707 	.db 0x00
      008106 00                    1708 	.db 0x00
      008107 00                    1709 	.db 0x00
      008108 00                    1710 	.db 0x00
      008109 00                    1711 	.db 0x00
      00810A 00                    1712 	.db 0x00
      00810B 00                    1713 	.db 0x00
      00810C 00                    1714 	.db 0x00
      00810D 00                    1715 	.db 0x00
      00810E 00                    1716 	.db 0x00
      00810F 00                    1717 	.db 0x00
      008110 00                    1718 	.db 0x00
      008111 00                    1719 	.db 0x00
      008112 00                    1720 	.db 0x00
      008113 00                    1721 	.db 0x00
      008114 00                    1722 	.db 0x00
      008115 00                    1723 	.db 0x00
      008116 00                    1724 	.db 0x00
      008117 00                    1725 	.db 0x00
      008118 00                    1726 	.db 0x00
      008119 00                    1727 	.db 0x00
      00811A 00                    1728 	.db 0x00
      00811B 00                    1729 	.db 0x00
      00811C 00                    1730 	.db 0x00
      00811D 00                    1731 	.db 0x00
      00811E 00                    1732 	.db 0x00
      00811F 00                    1733 	.db 0x00
      008120 00                    1734 	.db 0x00
      008121 00                    1735 	.db 0x00
      008122 00                    1736 	.db 0x00
      008123 00                    1737 	.db 0x00
      008124 00                    1738 	.db 0x00
      008125 00                    1739 	.db 0x00
      008126 00                    1740 	.db 0x00
      008127 00                    1741 	.db 0x00
      008128 00                    1742 	.db 0x00
      008129 00                    1743 	.db 0x00
      00812A 00                    1744 	.db 0x00
      00812B 00                    1745 	.db 0x00
      00812C 00                    1746 	.db 0x00
      00812D 00                    1747 	.db 0x00
      00812E 00                    1748 	.db 0x00
      00812F 00                    1749 	.db 0x00
      008130 00                    1750 	.db 0x00
      008131 00                    1751 	.db 0x00
      008132 00                    1752 	.db 0x00
      008133 00                    1753 	.db 0x00
      008134 00                    1754 	.db 0x00
      008135 00                    1755 	.db 0x00
      008136 00                    1756 	.db 0x00
      008137 00                    1757 	.db 0x00
      008138 00                    1758 	.db 0x00
      008139 00                    1759 	.db 0x00
      00813A 00                    1760 	.db 0x00
      00813B 00                    1761 	.db 0x00
      00813C 00                    1762 	.db 0x00
      00813D 00                    1763 	.db 0x00
      00813E 00                    1764 	.db 0x00
      00813F 00                    1765 	.db 0x00
      008140 00                    1766 	.db 0x00
      008141 00                    1767 	.db 0x00
      008142 00                    1768 	.db 0x00
      008143 00                    1769 	.db 0x00
      008144 00                    1770 	.db 0x00
      008145 00                    1771 	.db 0x00
      008146 00                    1772 	.db 0x00
      008147 00                    1773 	.db 0x00
      008148 00                    1774 	.db 0x00
      008149 00                    1775 	.db 0x00
      00814A 00                    1776 	.db 0x00
      00814B 00                    1777 	.db 0x00
      00814C 00                    1778 	.db 0x00
      00814D 00                    1779 	.db 0x00
      00814E 00                    1780 	.db 0x00
      00814F 00                    1781 	.db 0x00
      008150 00                    1782 	.db 0x00
      008151 00                    1783 	.db 0x00
      008152 00                    1784 	.db 0x00
      008153 00                    1785 	.db 0x00
      008154 00                    1786 	.db 0x00
      008155 00                    1787 	.db 0x00
      008156 00                    1788 	.db 0x00
      008157 00                    1789 	.db 0x00
      008158 00                    1790 	.db 0x00
      008159 00                    1791 	.db 0x00
      00815A 00                    1792 	.db 0x00
      00815B 00                    1793 	.db 0x00
      00815C 00                    1794 	.db 0x00
      00815D 00                    1795 	.db 0x00
      00815E 00                    1796 	.db 0x00
      00815F 00                    1797 	.db 0x00
      008160 00                    1798 	.db 0x00
      008161 00                    1799 	.db 0x00
      008162 00                    1800 	.db 0x00
      008163 00                    1801 	.db 0x00
      008164 00                    1802 	.db 0x00
      008165 00                    1803 	.db 0x00
      008166 00                    1804 	.db 0x00
      008167 00                    1805 	.db 0x00
      008168 00                    1806 	.db 0x00
      008169 00                    1807 	.db 0x00
      00816A 00                    1808 	.db 0x00
      00816B 00                    1809 	.db 0x00
      00816C 00                    1810 	.db 0x00
      00816D 00                    1811 	.db 0x00
      00816E 00                    1812 	.db 0x00
      00816F 00                    1813 	.db 0x00
      008170 00                    1814 	.db 0x00
      008171 00                    1815 	.db 0x00
      008172 00                    1816 	.db 0x00
      008173 00                    1817 	.db 0x00
      008174 00                    1818 	.db 0x00
      008175 00                    1819 	.db 0x00
      008176 00                    1820 	.db 0x00
      008177 00                    1821 	.db 0x00
      008178 00                    1822 	.db 0x00
      008179 00                    1823 	.db 0x00
      00817A 00                    1824 	.db 0x00
      00817B 00                    1825 	.db 0x00
      00817C 00                    1826 	.db 0x00
      00817D 00                    1827 	.db 0x00
      00817E 00                    1828 	.db 0x00
      00817F 00                    1829 	.db 0x00
      008180 00                    1830 	.db 0x00
      008181 00                    1831 	.db 0x00
      008182 00                    1832 	.db 0x00
      008183 00                    1833 	.db 0x00
      008184 00                    1834 	.db 0x00
      008185 00                    1835 	.db 0x00
      008186 00                    1836 	.db 0x00
      008187 00                    1837 	.db 0x00
      008188 00                    1838 	.db 0x00
      008189 00                    1839 	.db 0x00
      00818A 00                    1840 	.db 0x00
      00818B 00                    1841 	.db 0x00
      00818C 00                    1842 	.db 0x00
      00818D 00                    1843 	.db 0x00
      00818E 00                    1844 	.db 0x00
      00818F 00                    1845 	.db 0x00
      008190 00                    1846 	.db 0x00
      008191 00                    1847 	.db 0x00
      008192 00                    1848 	.db 0x00
      008193 00                    1849 	.db 0x00
      008194 00                    1850 	.db 0x00
      008195 00                    1851 	.db 0x00
      008196 00                    1852 	.db 0x00
      008197 00                    1853 	.db 0x00
      008198 00                    1854 	.db 0x00
      008199 00                    1855 	.db 0x00
      00819A 00                    1856 	.db 0x00
      00819B 00                    1857 	.db 0x00
      00819C 00                    1858 	.db 0x00
      00819D 00                    1859 	.db 0x00
      00819E 00                    1860 	.db 0x00
      00819F 00                    1861 	.db 0x00
      0081A0 00                    1862 	.db 0x00
      0081A1 00                    1863 	.db 0x00
      0081A2 00                    1864 	.db 0x00
      0081A3 00                    1865 	.db 0x00
      0081A4 00                    1866 	.db 0x00
      0081A5 00                    1867 	.db 0x00
      0081A6 00                    1868 	.db 0x00
      0081A7 00                    1869 	.db 0x00
      0081A8 00                    1870 	.db 0x00
      0081A9 00                    1871 	.db 0x00
      0081AA 00                    1872 	.db 0x00
      0081AB 00                    1873 	.db 0x00
      0081AC 00                    1874 	.db 0x00
      0081AD 00                    1875 	.db 0x00
      0081AE 00                    1876 	.db 0x00
      0081AF 00                    1877 	.db 0x00
      0081B0 00                    1878 	.db 0x00
      0081B1                       1879 __xinit__a:
      0081B1 00                    1880 	.db #0x00	; 0
      0081B2 00                    1881 	.db 0x00
      0081B3 00                    1882 	.db 0x00
      0081B4                       1883 __xinit__d_addr:
      0081B4 00                    1884 	.db #0x00	; 0
      0081B5                       1885 __xinit__p_size:
      0081B5 00                    1886 	.db #0x00	; 0
      0081B6                       1887 __xinit__d_size:
      0081B6 00                    1888 	.db #0x00	; 0
      0081B7                       1889 __xinit__p_bytes:
      0081B7 00                    1890 	.db #0x00	; 0
      0081B8                       1891 __xinit__data_buf:
      0081B8 00                    1892 	.db #0x00	; 0
      0081B9 00                    1893 	.db 0x00
      0081BA 00                    1894 	.db 0x00
      0081BB 00                    1895 	.db 0x00
      0081BC 00                    1896 	.db 0x00
      0081BD 00                    1897 	.db 0x00
      0081BE 00                    1898 	.db 0x00
      0081BF 00                    1899 	.db 0x00
      0081C0 00                    1900 	.db 0x00
      0081C1 00                    1901 	.db 0x00
      0081C2 00                    1902 	.db 0x00
      0081C3 00                    1903 	.db 0x00
      0081C4 00                    1904 	.db 0x00
      0081C5 00                    1905 	.db 0x00
      0081C6 00                    1906 	.db 0x00
      0081C7 00                    1907 	.db 0x00
      0081C8 00                    1908 	.db 0x00
      0081C9 00                    1909 	.db 0x00
      0081CA 00                    1910 	.db 0x00
      0081CB 00                    1911 	.db 0x00
      0081CC 00                    1912 	.db 0x00
      0081CD 00                    1913 	.db 0x00
      0081CE 00                    1914 	.db 0x00
      0081CF 00                    1915 	.db 0x00
      0081D0 00                    1916 	.db 0x00
      0081D1 00                    1917 	.db 0x00
      0081D2 00                    1918 	.db 0x00
      0081D3 00                    1919 	.db 0x00
      0081D4 00                    1920 	.db 0x00
      0081D5 00                    1921 	.db 0x00
      0081D6 00                    1922 	.db 0x00
      0081D7 00                    1923 	.db 0x00
      0081D8 00                    1924 	.db 0x00
      0081D9 00                    1925 	.db 0x00
      0081DA 00                    1926 	.db 0x00
      0081DB 00                    1927 	.db 0x00
      0081DC 00                    1928 	.db 0x00
      0081DD 00                    1929 	.db 0x00
      0081DE 00                    1930 	.db 0x00
      0081DF 00                    1931 	.db 0x00
      0081E0 00                    1932 	.db 0x00
      0081E1 00                    1933 	.db 0x00
      0081E2 00                    1934 	.db 0x00
      0081E3 00                    1935 	.db 0x00
      0081E4 00                    1936 	.db 0x00
      0081E5 00                    1937 	.db 0x00
      0081E6 00                    1938 	.db 0x00
      0081E7 00                    1939 	.db 0x00
      0081E8 00                    1940 	.db 0x00
      0081E9 00                    1941 	.db 0x00
      0081EA 00                    1942 	.db 0x00
      0081EB 00                    1943 	.db 0x00
      0081EC 00                    1944 	.db 0x00
      0081ED 00                    1945 	.db 0x00
      0081EE 00                    1946 	.db 0x00
      0081EF 00                    1947 	.db 0x00
      0081F0 00                    1948 	.db 0x00
      0081F1 00                    1949 	.db 0x00
      0081F2 00                    1950 	.db 0x00
      0081F3 00                    1951 	.db 0x00
      0081F4 00                    1952 	.db 0x00
      0081F5 00                    1953 	.db 0x00
      0081F6 00                    1954 	.db 0x00
      0081F7 00                    1955 	.db 0x00
      0081F8 00                    1956 	.db 0x00
      0081F9 00                    1957 	.db 0x00
      0081FA 00                    1958 	.db 0x00
      0081FB 00                    1959 	.db 0x00
      0081FC 00                    1960 	.db 0x00
      0081FD 00                    1961 	.db 0x00
      0081FE 00                    1962 	.db 0x00
      0081FF 00                    1963 	.db 0x00
      008200 00                    1964 	.db 0x00
      008201 00                    1965 	.db 0x00
      008202 00                    1966 	.db 0x00
      008203 00                    1967 	.db 0x00
      008204 00                    1968 	.db 0x00
      008205 00                    1969 	.db 0x00
      008206 00                    1970 	.db 0x00
      008207 00                    1971 	.db 0x00
      008208 00                    1972 	.db 0x00
      008209 00                    1973 	.db 0x00
      00820A 00                    1974 	.db 0x00
      00820B 00                    1975 	.db 0x00
      00820C 00                    1976 	.db 0x00
      00820D 00                    1977 	.db 0x00
      00820E 00                    1978 	.db 0x00
      00820F 00                    1979 	.db 0x00
      008210 00                    1980 	.db 0x00
      008211 00                    1981 	.db 0x00
      008212 00                    1982 	.db 0x00
      008213 00                    1983 	.db 0x00
      008214 00                    1984 	.db 0x00
      008215 00                    1985 	.db 0x00
      008216 00                    1986 	.db 0x00
      008217 00                    1987 	.db 0x00
      008218 00                    1988 	.db 0x00
      008219 00                    1989 	.db 0x00
      00821A 00                    1990 	.db 0x00
      00821B 00                    1991 	.db 0x00
      00821C 00                    1992 	.db 0x00
      00821D 00                    1993 	.db 0x00
      00821E 00                    1994 	.db 0x00
      00821F 00                    1995 	.db 0x00
      008220 00                    1996 	.db 0x00
      008221 00                    1997 	.db 0x00
      008222 00                    1998 	.db 0x00
      008223 00                    1999 	.db 0x00
      008224 00                    2000 	.db 0x00
      008225 00                    2001 	.db 0x00
      008226 00                    2002 	.db 0x00
      008227 00                    2003 	.db 0x00
      008228 00                    2004 	.db 0x00
      008229 00                    2005 	.db 0x00
      00822A 00                    2006 	.db 0x00
      00822B 00                    2007 	.db 0x00
      00822C 00                    2008 	.db 0x00
      00822D 00                    2009 	.db 0x00
      00822E 00                    2010 	.db 0x00
      00822F 00                    2011 	.db 0x00
      008230 00                    2012 	.db 0x00
      008231 00                    2013 	.db 0x00
      008232 00                    2014 	.db 0x00
      008233 00                    2015 	.db 0x00
      008234 00                    2016 	.db 0x00
      008235 00                    2017 	.db 0x00
      008236 00                    2018 	.db 0x00
      008237 00                    2019 	.db 0x00
      008238 00                    2020 	.db 0x00
      008239 00                    2021 	.db 0x00
      00823A 00                    2022 	.db 0x00
      00823B 00                    2023 	.db 0x00
      00823C 00                    2024 	.db 0x00
      00823D 00                    2025 	.db 0x00
      00823E 00                    2026 	.db 0x00
      00823F 00                    2027 	.db 0x00
      008240 00                    2028 	.db 0x00
      008241 00                    2029 	.db 0x00
      008242 00                    2030 	.db 0x00
      008243 00                    2031 	.db 0x00
      008244 00                    2032 	.db 0x00
      008245 00                    2033 	.db 0x00
      008246 00                    2034 	.db 0x00
      008247 00                    2035 	.db 0x00
      008248 00                    2036 	.db 0x00
      008249 00                    2037 	.db 0x00
      00824A 00                    2038 	.db 0x00
      00824B 00                    2039 	.db 0x00
      00824C 00                    2040 	.db 0x00
      00824D 00                    2041 	.db 0x00
      00824E 00                    2042 	.db 0x00
      00824F 00                    2043 	.db 0x00
      008250 00                    2044 	.db 0x00
      008251 00                    2045 	.db 0x00
      008252 00                    2046 	.db 0x00
      008253 00                    2047 	.db 0x00
      008254 00                    2048 	.db 0x00
      008255 00                    2049 	.db 0x00
      008256 00                    2050 	.db 0x00
      008257 00                    2051 	.db 0x00
      008258 00                    2052 	.db 0x00
      008259 00                    2053 	.db 0x00
      00825A 00                    2054 	.db 0x00
      00825B 00                    2055 	.db 0x00
      00825C 00                    2056 	.db 0x00
      00825D 00                    2057 	.db 0x00
      00825E 00                    2058 	.db 0x00
      00825F 00                    2059 	.db 0x00
      008260 00                    2060 	.db 0x00
      008261 00                    2061 	.db 0x00
      008262 00                    2062 	.db 0x00
      008263 00                    2063 	.db 0x00
      008264 00                    2064 	.db 0x00
      008265 00                    2065 	.db 0x00
      008266 00                    2066 	.db 0x00
      008267 00                    2067 	.db 0x00
      008268 00                    2068 	.db 0x00
      008269 00                    2069 	.db 0x00
      00826A 00                    2070 	.db 0x00
      00826B 00                    2071 	.db 0x00
      00826C 00                    2072 	.db 0x00
      00826D 00                    2073 	.db 0x00
      00826E 00                    2074 	.db 0x00
      00826F 00                    2075 	.db 0x00
      008270 00                    2076 	.db 0x00
      008271 00                    2077 	.db 0x00
      008272 00                    2078 	.db 0x00
      008273 00                    2079 	.db 0x00
      008274 00                    2080 	.db 0x00
      008275 00                    2081 	.db 0x00
      008276 00                    2082 	.db 0x00
      008277 00                    2083 	.db 0x00
      008278 00                    2084 	.db 0x00
      008279 00                    2085 	.db 0x00
      00827A 00                    2086 	.db 0x00
      00827B 00                    2087 	.db 0x00
      00827C 00                    2088 	.db 0x00
      00827D 00                    2089 	.db 0x00
      00827E 00                    2090 	.db 0x00
      00827F 00                    2091 	.db 0x00
      008280 00                    2092 	.db 0x00
      008281 00                    2093 	.db 0x00
      008282 00                    2094 	.db 0x00
      008283 00                    2095 	.db 0x00
      008284 00                    2096 	.db 0x00
      008285 00                    2097 	.db 0x00
      008286 00                    2098 	.db 0x00
      008287 00                    2099 	.db 0x00
      008288 00                    2100 	.db 0x00
      008289 00                    2101 	.db 0x00
      00828A 00                    2102 	.db 0x00
      00828B 00                    2103 	.db 0x00
      00828C 00                    2104 	.db 0x00
      00828D 00                    2105 	.db 0x00
      00828E 00                    2106 	.db 0x00
      00828F 00                    2107 	.db 0x00
      008290 00                    2108 	.db 0x00
      008291 00                    2109 	.db 0x00
      008292 00                    2110 	.db 0x00
      008293 00                    2111 	.db 0x00
      008294 00                    2112 	.db 0x00
      008295 00                    2113 	.db 0x00
      008296 00                    2114 	.db 0x00
      008297 00                    2115 	.db 0x00
      008298 00                    2116 	.db 0x00
      008299 00                    2117 	.db 0x00
      00829A 00                    2118 	.db 0x00
      00829B 00                    2119 	.db 0x00
      00829C 00                    2120 	.db 0x00
      00829D 00                    2121 	.db 0x00
      00829E 00                    2122 	.db 0x00
      00829F 00                    2123 	.db 0x00
      0082A0 00                    2124 	.db 0x00
      0082A1 00                    2125 	.db 0x00
      0082A2 00                    2126 	.db 0x00
      0082A3 00                    2127 	.db 0x00
      0082A4 00                    2128 	.db 0x00
      0082A5 00                    2129 	.db 0x00
      0082A6 00                    2130 	.db 0x00
      0082A7 00                    2131 	.db 0x00
      0082A8 00                    2132 	.db 0x00
      0082A9 00                    2133 	.db 0x00
      0082AA 00                    2134 	.db 0x00
      0082AB 00                    2135 	.db 0x00
      0082AC 00                    2136 	.db 0x00
      0082AD 00                    2137 	.db 0x00
      0082AE 00                    2138 	.db 0x00
      0082AF 00                    2139 	.db 0x00
      0082B0 00                    2140 	.db 0x00
      0082B1 00                    2141 	.db 0x00
      0082B2 00                    2142 	.db 0x00
      0082B3 00                    2143 	.db 0x00
      0082B4 00                    2144 	.db 0x00
      0082B5 00                    2145 	.db 0x00
      0082B6 00                    2146 	.db 0x00
      0082B7                       2147 __xinit__current_dev:
      0082B7 00                    2148 	.db #0x00	; 0
                                   2149 	.area CABS (ABS)
