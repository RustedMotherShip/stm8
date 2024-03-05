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
                                     12 	.globl _status_check
                                     13 	.globl _uart_write_line
                                     14 	.globl _convert_int_to_binary
                                     15 	.globl _convert_int_to_chars
                                     16 	.globl _delay
                                     17 	.globl _strlen
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; Stack segment in internal ram
                                     28 ;--------------------------------------------------------
                                     29 	.area SSEG
      000001                         30 __start__stack:
      000001                         31 	.ds	1
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; absolute external ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DABS (ABS)
                                     37 
                                     38 ; default segment ordering for linker
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area CONST
                                     43 	.area INITIALIZER
                                     44 	.area CODE
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; interrupt vector
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
      008000                         50 __interrupt_vect:
      008000 82 00 80 07             51 	int s_GSINIT ; reset
                                     52 ;--------------------------------------------------------
                                     53 ; global & static initialisations
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area GSINIT
      008007 CD 82 E6         [ 4]   59 	call	___sdcc_external_startup
      00800A 4D               [ 1]   60 	tnz	a
      00800B 27 03            [ 1]   61 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   62 	jp	__sdcc_program_startup
      008010                         63 __sdcc_init_data:
                                     64 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   65 	ldw x, #l_DATA
      008013 27 07            [ 1]   66 	jreq	00002$
      008015                         67 00001$:
      008015 72 4F 00 00      [ 1]   68 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   69 	decw x
      00801A 26 F9            [ 1]   70 	jrne	00001$
      00801C                         71 00002$:
      00801C AE 00 00         [ 2]   72 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   73 	jreq	00004$
      008021                         74 00003$:
      008021 D6 80 A1         [ 1]   75 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   76 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   77 	decw	x
      008028 26 F7            [ 1]   78 	jrne	00003$
      00802A                         79 00004$:
                                     80 ; stm8_genXINIT() end
                                     81 	.area GSFINAL
      00802A CC 80 04         [ 2]   82 	jp	__sdcc_program_startup
                                     83 ;--------------------------------------------------------
                                     84 ; Home
                                     85 ;--------------------------------------------------------
                                     86 	.area HOME
                                     87 	.area HOME
      008004                         88 __sdcc_program_startup:
      008004 CC 82 2E         [ 2]   89 	jp	_main
                                     90 ;	return from main will return to caller
                                     91 ;--------------------------------------------------------
                                     92 ; code
                                     93 ;--------------------------------------------------------
                                     94 	.area CODE
                                     95 ;	main.c: 7: void delay(unsigned long count) {
                                     96 ;	-----------------------------------------
                                     97 ;	 function delay
                                     98 ;	-----------------------------------------
      0080A2                         99 _delay:
      0080A2 52 08            [ 2]  100 	sub	sp, #8
                                    101 ;	main.c: 8: while (count--)
      0080A4 16 0D            [ 2]  102 	ldw	y, (0x0d, sp)
      0080A6 17 07            [ 2]  103 	ldw	(0x07, sp), y
      0080A8 1E 0B            [ 2]  104 	ldw	x, (0x0b, sp)
      0080AA                        105 00101$:
      0080AA 1F 01            [ 2]  106 	ldw	(0x01, sp), x
      0080AC 7B 07            [ 1]  107 	ld	a, (0x07, sp)
      0080AE 6B 03            [ 1]  108 	ld	(0x03, sp), a
      0080B0 7B 08            [ 1]  109 	ld	a, (0x08, sp)
      0080B2 16 07            [ 2]  110 	ldw	y, (0x07, sp)
      0080B4 72 A2 00 01      [ 2]  111 	subw	y, #0x0001
      0080B8 17 07            [ 2]  112 	ldw	(0x07, sp), y
      0080BA 24 01            [ 1]  113 	jrnc	00117$
      0080BC 5A               [ 2]  114 	decw	x
      0080BD                        115 00117$:
      0080BD 4D               [ 1]  116 	tnz	a
      0080BE 26 08            [ 1]  117 	jrne	00118$
      0080C0 16 02            [ 2]  118 	ldw	y, (0x02, sp)
      0080C2 26 04            [ 1]  119 	jrne	00118$
      0080C4 0D 01            [ 1]  120 	tnz	(0x01, sp)
      0080C6 27 03            [ 1]  121 	jreq	00104$
      0080C8                        122 00118$:
                                    123 ;	main.c: 9: nop();
      0080C8 9D               [ 1]  124 	nop
      0080C9 20 DF            [ 2]  125 	jra	00101$
      0080CB                        126 00104$:
                                    127 ;	main.c: 10: }
      0080CB 1E 09            [ 2]  128 	ldw	x, (9, sp)
      0080CD 5B 0E            [ 2]  129 	addw	sp, #14
      0080CF FC               [ 2]  130 	jp	(x)
                                    131 ;	main.c: 12: void convert_int_to_chars(int num, char* rx_int_chars) {
                                    132 ;	-----------------------------------------
                                    133 ;	 function convert_int_to_chars
                                    134 ;	-----------------------------------------
      0080D0                        135 _convert_int_to_chars:
      0080D0 52 0B            [ 2]  136 	sub	sp, #11
      0080D2 1F 0A            [ 2]  137 	ldw	(0x0a, sp), x
                                    138 ;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
      0080D4 16 0E            [ 2]  139 	ldw	y, (0x0e, sp)
      0080D6 17 01            [ 2]  140 	ldw	(0x01, sp), y
                                    141 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      0080D8 4B 0A            [ 1]  142 	push	#0x0a
      0080DA 4B 00            [ 1]  143 	push	#0x00
      0080DC 1E 0C            [ 2]  144 	ldw	x, (0x0c, sp)
                                    145 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      0080DE CD 83 0D         [ 4]  146 	call	__divsint
      0080E1 1F 03            [ 2]  147 	ldw	(0x03, sp), x
      0080E3 4B 0A            [ 1]  148 	push	#0x0a
      0080E5 4B 00            [ 1]  149 	push	#0x00
      0080E7 1E 0C            [ 2]  150 	ldw	x, (0x0c, sp)
                                    151 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      0080E9 CD 82 F5         [ 4]  152 	call	__modsint
      0080EC 90 93            [ 1]  153 	ldw	y, x
      0080EE 9F               [ 1]  154 	ld	a, xl
      0080EF 1E 01            [ 2]  155 	ldw	x, (0x01, sp)
      0080F1 5C               [ 1]  156 	incw	x
      0080F2 1F 05            [ 2]  157 	ldw	(0x05, sp), x
                                    158 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      0080F4 1E 01            [ 2]  159 	ldw	x, (0x01, sp)
      0080F6 5C               [ 1]  160 	incw	x
      0080F7 5C               [ 1]  161 	incw	x
      0080F8 1F 07            [ 2]  162 	ldw	(0x07, sp), x
      0080FA AB 30            [ 1]  163 	add	a, #0x30
      0080FC 6B 09            [ 1]  164 	ld	(0x09, sp), a
                                    165 ;	main.c: 13: if (num > 99) {
      0080FE 1E 0A            [ 2]  166 	ldw	x, (0x0a, sp)
      008100 A3 00 63         [ 2]  167 	cpw	x, #0x0063
      008103 2D 29            [ 1]  168 	jrsle	00105$
                                    169 ;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
      008105 4B 64            [ 1]  170 	push	#0x64
      008107 4B 00            [ 1]  171 	push	#0x00
      008109 1E 0C            [ 2]  172 	ldw	x, (0x0c, sp)
      00810B CD 83 0D         [ 4]  173 	call	__divsint
      00810E 9F               [ 1]  174 	ld	a, xl
      00810F AB 30            [ 1]  175 	add	a, #0x30
      008111 1E 01            [ 2]  176 	ldw	x, (0x01, sp)
      008113 F7               [ 1]  177 	ld	(x), a
                                    178 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      008114 4B 0A            [ 1]  179 	push	#0x0a
      008116 4B 00            [ 1]  180 	push	#0x00
      008118 1E 05            [ 2]  181 	ldw	x, (0x05, sp)
      00811A CD 82 F5         [ 4]  182 	call	__modsint
      00811D 9F               [ 1]  183 	ld	a, xl
      00811E AB 30            [ 1]  184 	add	a, #0x30
      008120 1E 05            [ 2]  185 	ldw	x, (0x05, sp)
      008122 F7               [ 1]  186 	ld	(x), a
                                    187 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      008123 1E 07            [ 2]  188 	ldw	x, (0x07, sp)
      008125 7B 09            [ 1]  189 	ld	a, (0x09, sp)
      008127 F7               [ 1]  190 	ld	(x), a
                                    191 ;	main.c: 18: rx_int_chars[3] ='\0';
      008128 1E 01            [ 2]  192 	ldw	x, (0x01, sp)
      00812A 6F 03            [ 1]  193 	clr	(0x0003, x)
      00812C 20 22            [ 2]  194 	jra	00107$
      00812E                        195 00105$:
                                    196 ;	main.c: 20: } else if (num > 9) {
      00812E 1E 0A            [ 2]  197 	ldw	x, (0x0a, sp)
      008130 A3 00 09         [ 2]  198 	cpw	x, #0x0009
      008133 2D 11            [ 1]  199 	jrsle	00102$
                                    200 ;	main.c: 22: rx_int_chars[0] = num / 10 + '0';
      008135 7B 04            [ 1]  201 	ld	a, (0x04, sp)
      008137 AB 30            [ 1]  202 	add	a, #0x30
      008139 1E 01            [ 2]  203 	ldw	x, (0x01, sp)
      00813B F7               [ 1]  204 	ld	(x), a
                                    205 ;	main.c: 23: rx_int_chars[1] = num % 10 + '0';
      00813C 1E 05            [ 2]  206 	ldw	x, (0x05, sp)
      00813E 7B 09            [ 1]  207 	ld	a, (0x09, sp)
      008140 F7               [ 1]  208 	ld	(x), a
                                    209 ;	main.c: 24: rx_int_chars[2] ='\0';
      008141 1E 07            [ 2]  210 	ldw	x, (0x07, sp)
      008143 7F               [ 1]  211 	clr	(x)
      008144 20 0A            [ 2]  212 	jra	00107$
      008146                        213 00102$:
                                    214 ;	main.c: 29: rx_int_chars[0] = num + '0';
      008146 7B 0B            [ 1]  215 	ld	a, (0x0b, sp)
      008148 AB 30            [ 1]  216 	add	a, #0x30
      00814A 1E 01            [ 2]  217 	ldw	x, (0x01, sp)
      00814C F7               [ 1]  218 	ld	(x), a
                                    219 ;	main.c: 30: rx_int_chars[1] ='\0';
      00814D 1E 05            [ 2]  220 	ldw	x, (0x05, sp)
      00814F 7F               [ 1]  221 	clr	(x)
      008150                        222 00107$:
                                    223 ;	main.c: 32: }
      008150 1E 0C            [ 2]  224 	ldw	x, (12, sp)
      008152 5B 0F            [ 2]  225 	addw	sp, #15
      008154 FC               [ 2]  226 	jp	(x)
                                    227 ;	main.c: 34: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    228 ;	-----------------------------------------
                                    229 ;	 function convert_int_to_binary
                                    230 ;	-----------------------------------------
      008155                        231 _convert_int_to_binary:
      008155 52 04            [ 2]  232 	sub	sp, #4
      008157 1F 01            [ 2]  233 	ldw	(0x01, sp), x
                                    234 ;	main.c: 36: for(int i = 7; i >= 0; i--) {
      008159 AE 00 07         [ 2]  235 	ldw	x, #0x0007
      00815C 1F 03            [ 2]  236 	ldw	(0x03, sp), x
      00815E                        237 00103$:
      00815E 0D 03            [ 1]  238 	tnz	(0x03, sp)
      008160 2B 22            [ 1]  239 	jrmi	00101$
                                    240 ;	main.c: 38: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008162 AE 00 07         [ 2]  241 	ldw	x, #0x0007
      008165 72 F0 03         [ 2]  242 	subw	x, (0x03, sp)
      008168 72 FB 07         [ 2]  243 	addw	x, (0x07, sp)
      00816B 16 01            [ 2]  244 	ldw	y, (0x01, sp)
      00816D 7B 04            [ 1]  245 	ld	a, (0x04, sp)
      00816F 27 05            [ 1]  246 	jreq	00120$
      008171                        247 00119$:
      008171 90 57            [ 2]  248 	sraw	y
      008173 4A               [ 1]  249 	dec	a
      008174 26 FB            [ 1]  250 	jrne	00119$
      008176                        251 00120$:
      008176 90 9F            [ 1]  252 	ld	a, yl
      008178 A4 01            [ 1]  253 	and	a, #0x01
      00817A AB 30            [ 1]  254 	add	a, #0x30
      00817C F7               [ 1]  255 	ld	(x), a
                                    256 ;	main.c: 36: for(int i = 7; i >= 0; i--) {
      00817D 1E 03            [ 2]  257 	ldw	x, (0x03, sp)
      00817F 5A               [ 2]  258 	decw	x
      008180 1F 03            [ 2]  259 	ldw	(0x03, sp), x
      008182 20 DA            [ 2]  260 	jra	00103$
      008184                        261 00101$:
                                    262 ;	main.c: 40: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008184 1E 07            [ 2]  263 	ldw	x, (0x07, sp)
      008186 6F 08            [ 1]  264 	clr	(0x0008, x)
                                    265 ;	main.c: 41: }
      008188 1E 05            [ 2]  266 	ldw	x, (5, sp)
      00818A 5B 08            [ 2]  267 	addw	sp, #8
      00818C FC               [ 2]  268 	jp	(x)
                                    269 ;	main.c: 46: int uart_write_line(const char *str) {
                                    270 ;	-----------------------------------------
                                    271 ;	 function uart_write_line
                                    272 ;	-----------------------------------------
      00818D                        273 _uart_write_line:
      00818D 52 05            [ 2]  274 	sub	sp, #5
      00818F 1F 03            [ 2]  275 	ldw	(0x03, sp), x
                                    276 ;	main.c: 48: for(i = 0; i < strlen(str); i++) {
      008191 0F 05            [ 1]  277 	clr	(0x05, sp)
      008193                        278 00106$:
      008193 1E 03            [ 2]  279 	ldw	x, (0x03, sp)
      008195 CD 82 E8         [ 4]  280 	call	_strlen
      008198 1F 01            [ 2]  281 	ldw	(0x01, sp), x
      00819A 5F               [ 1]  282 	clrw	x
      00819B 7B 05            [ 1]  283 	ld	a, (0x05, sp)
      00819D 97               [ 1]  284 	ld	xl, a
      00819E 13 01            [ 2]  285 	cpw	x, (0x01, sp)
      0081A0 24 14            [ 1]  286 	jrnc	00104$
                                    287 ;	main.c: 49: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0081A2                        288 00101$:
      0081A2 C6 52 30         [ 1]  289 	ld	a, 0x5230
      0081A5 2A FB            [ 1]  290 	jrpl	00101$
                                    291 ;	main.c: 50: UART1_DR = str[i];
      0081A7 5F               [ 1]  292 	clrw	x
      0081A8 7B 05            [ 1]  293 	ld	a, (0x05, sp)
      0081AA 97               [ 1]  294 	ld	xl, a
      0081AB 72 FB 03         [ 2]  295 	addw	x, (0x03, sp)
      0081AE F6               [ 1]  296 	ld	a, (x)
      0081AF C7 52 31         [ 1]  297 	ld	0x5231, a
                                    298 ;	main.c: 48: for(i = 0; i < strlen(str); i++) {
      0081B2 0C 05            [ 1]  299 	inc	(0x05, sp)
      0081B4 20 DD            [ 2]  300 	jra	00106$
      0081B6                        301 00104$:
                                    302 ;	main.c: 52: return(i); // Bytes sent
      0081B6 7B 05            [ 1]  303 	ld	a, (0x05, sp)
      0081B8 5F               [ 1]  304 	clrw	x
      0081B9 97               [ 1]  305 	ld	xl, a
                                    306 ;	main.c: 53: }
      0081BA 5B 05            [ 2]  307 	addw	sp, #5
      0081BC 81               [ 4]  308 	ret
                                    309 ;	main.c: 55: void status_check(void){
                                    310 ;	-----------------------------------------
                                    311 ;	 function status_check
                                    312 ;	-----------------------------------------
      0081BD                        313 _status_check:
      0081BD 52 09            [ 2]  314 	sub	sp, #9
                                    315 ;	main.c: 56: char rx_binary_chars[9]={0};
      0081BF 0F 01            [ 1]  316 	clr	(0x01, sp)
      0081C1 0F 02            [ 1]  317 	clr	(0x02, sp)
      0081C3 0F 03            [ 1]  318 	clr	(0x03, sp)
      0081C5 0F 04            [ 1]  319 	clr	(0x04, sp)
      0081C7 0F 05            [ 1]  320 	clr	(0x05, sp)
      0081C9 0F 06            [ 1]  321 	clr	(0x06, sp)
      0081CB 0F 07            [ 1]  322 	clr	(0x07, sp)
      0081CD 0F 08            [ 1]  323 	clr	(0x08, sp)
      0081CF 0F 09            [ 1]  324 	clr	(0x09, sp)
                                    325 ;	main.c: 57: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0081D1 96               [ 1]  326 	ldw	x, sp
      0081D2 5C               [ 1]  327 	incw	x
      0081D3 51               [ 1]  328 	exgw	x, y
      0081D4 C6 52 17         [ 1]  329 	ld	a, 0x5217
      0081D7 5F               [ 1]  330 	clrw	x
      0081D8 90 89            [ 2]  331 	pushw	y
      0081DA 97               [ 1]  332 	ld	xl, a
      0081DB CD 81 55         [ 4]  333 	call	_convert_int_to_binary
                                    334 ;	main.c: 58: uart_write_line("SR1 -> ");
      0081DE AE 80 2D         [ 2]  335 	ldw	x, #(___str_0+0)
      0081E1 CD 81 8D         [ 4]  336 	call	_uart_write_line
                                    337 ;	main.c: 59: uart_write_line(rx_binary_chars);
      0081E4 96               [ 1]  338 	ldw	x, sp
      0081E5 5C               [ 1]  339 	incw	x
      0081E6 CD 81 8D         [ 4]  340 	call	_uart_write_line
                                    341 ;	main.c: 60: uart_write_line(" <-\n");
      0081E9 AE 80 35         [ 2]  342 	ldw	x, #(___str_1+0)
      0081EC CD 81 8D         [ 4]  343 	call	_uart_write_line
                                    344 ;	main.c: 61: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0081EF 96               [ 1]  345 	ldw	x, sp
      0081F0 5C               [ 1]  346 	incw	x
      0081F1 51               [ 1]  347 	exgw	x, y
      0081F2 C6 52 18         [ 1]  348 	ld	a, 0x5218
      0081F5 5F               [ 1]  349 	clrw	x
      0081F6 90 89            [ 2]  350 	pushw	y
      0081F8 97               [ 1]  351 	ld	xl, a
      0081F9 CD 81 55         [ 4]  352 	call	_convert_int_to_binary
                                    353 ;	main.c: 62: uart_write_line("SR2 -> ");
      0081FC AE 80 3A         [ 2]  354 	ldw	x, #(___str_2+0)
      0081FF CD 81 8D         [ 4]  355 	call	_uart_write_line
                                    356 ;	main.c: 63: uart_write_line(rx_binary_chars);
      008202 96               [ 1]  357 	ldw	x, sp
      008203 5C               [ 1]  358 	incw	x
      008204 CD 81 8D         [ 4]  359 	call	_uart_write_line
                                    360 ;	main.c: 64: uart_write_line(" <-\n");
      008207 AE 80 35         [ 2]  361 	ldw	x, #(___str_1+0)
      00820A CD 81 8D         [ 4]  362 	call	_uart_write_line
                                    363 ;	main.c: 65: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      00820D 96               [ 1]  364 	ldw	x, sp
      00820E 5C               [ 1]  365 	incw	x
      00820F 51               [ 1]  366 	exgw	x, y
      008210 C6 52 19         [ 1]  367 	ld	a, 0x5219
      008213 5F               [ 1]  368 	clrw	x
      008214 90 89            [ 2]  369 	pushw	y
      008216 97               [ 1]  370 	ld	xl, a
      008217 CD 81 55         [ 4]  371 	call	_convert_int_to_binary
                                    372 ;	main.c: 66: uart_write_line("SR3 -> ");
      00821A AE 80 42         [ 2]  373 	ldw	x, #(___str_3+0)
      00821D CD 81 8D         [ 4]  374 	call	_uart_write_line
                                    375 ;	main.c: 67: uart_write_line(rx_binary_chars);
      008220 96               [ 1]  376 	ldw	x, sp
      008221 5C               [ 1]  377 	incw	x
      008222 CD 81 8D         [ 4]  378 	call	_uart_write_line
                                    379 ;	main.c: 68: uart_write_line(" <-\n");
      008225 AE 80 35         [ 2]  380 	ldw	x, #(___str_1+0)
      008228 CD 81 8D         [ 4]  381 	call	_uart_write_line
                                    382 ;	main.c: 69: }
      00822B 5B 09            [ 2]  383 	addw	sp, #9
      00822D 81               [ 4]  384 	ret
                                    385 ;	main.c: 71: int main(void)
                                    386 ;	-----------------------------------------
                                    387 ;	 function main
                                    388 ;	-----------------------------------------
      00822E                        389 _main:
      00822E 52 05            [ 2]  390 	sub	sp, #5
                                    391 ;	main.c: 74: CLK_CKDIVR = 0;
      008230 35 00 50 C6      [ 1]  392 	mov	0x50c6+0, #0x00
                                    393 ;	main.c: 77: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008234 72 16 52 35      [ 1]  394 	bset	0x5235, #3
                                    395 ;	main.c: 79: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008238 C6 52 36         [ 1]  396 	ld	a, 0x5236
      00823B A4 CF            [ 1]  397 	and	a, #0xcf
      00823D C7 52 36         [ 1]  398 	ld	0x5236, a
                                    399 ;	main.c: 81: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008240 35 03 52 33      [ 1]  400 	mov	0x5233+0, #0x03
      008244 35 68 52 32      [ 1]  401 	mov	0x5232+0, #0x68
                                    402 ;	main.c: 85: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008248 72 11 52 10      [ 1]  403 	bres	0x5210, #0
                                    404 ;	main.c: 86: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      00824C 35 10 52 12      [ 1]  405 	mov	0x5212+0, #0x10
                                    406 ;	main.c: 87: I2C_CCRH = 0;                   // =0
      008250 35 00 52 1C      [ 1]  407 	mov	0x521c+0, #0x00
                                    408 ;	main.c: 88: I2C_CCRL = 80;                  // 100kHz for I2C
      008254 35 50 52 1B      [ 1]  409 	mov	0x521b+0, #0x50
                                    410 ;	main.c: 89: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      008258 72 1F 52 1C      [ 1]  411 	bres	0x521c, #7
                                    412 ;	main.c: 90: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      00825C 72 1F 52 14      [ 1]  413 	bres	0x5214, #7
                                    414 ;	main.c: 91: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      008260 72 1C 52 14      [ 1]  415 	bset	0x5214, #6
                                    416 ;	main.c: 92: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      008264 72 10 52 10      [ 1]  417 	bset	0x5210, #0
                                    418 ;	main.c: 98: uart_write_line("Start Scanning\n");
      008268 AE 80 4A         [ 2]  419 	ldw	x, #(___str_4+0)
      00826B CD 81 8D         [ 4]  420 	call	_uart_write_line
                                    421 ;	main.c: 100: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
      00826E 0F 05            [ 1]  422 	clr	(0x05, sp)
      008270                        423 00106$:
      008270 7B 05            [ 1]  424 	ld	a, (0x05, sp)
      008272 A1 FF            [ 1]  425 	cp	a, #0xff
      008274 24 6C            [ 1]  426 	jrnc	00104$
                                    427 ;	main.c: 103: uart_write_line("_______Start______\n");
      008276 AE 80 5A         [ 2]  428 	ldw	x, #(___str_5+0)
      008279 CD 81 8D         [ 4]  429 	call	_uart_write_line
                                    430 ;	main.c: 104: uart_write_line("Dev ->  ");
      00827C AE 80 6E         [ 2]  431 	ldw	x, #(___str_6+0)
      00827F CD 81 8D         [ 4]  432 	call	_uart_write_line
                                    433 ;	main.c: 105: char rx_int_chars[4]={0};
      008282 0F 01            [ 1]  434 	clr	(0x01, sp)
      008284 0F 02            [ 1]  435 	clr	(0x02, sp)
      008286 0F 03            [ 1]  436 	clr	(0x03, sp)
      008288 0F 04            [ 1]  437 	clr	(0x04, sp)
                                    438 ;	main.c: 107: convert_int_to_chars(addr, rx_int_chars);
      00828A 96               [ 1]  439 	ldw	x, sp
      00828B 5C               [ 1]  440 	incw	x
      00828C 51               [ 1]  441 	exgw	x, y
      00828D 7B 05            [ 1]  442 	ld	a, (0x05, sp)
      00828F 5F               [ 1]  443 	clrw	x
      008290 90 89            [ 2]  444 	pushw	y
      008292 97               [ 1]  445 	ld	xl, a
      008293 CD 80 D0         [ 4]  446 	call	_convert_int_to_chars
                                    447 ;	main.c: 108: uart_write_line(rx_int_chars);
      008296 96               [ 1]  448 	ldw	x, sp
      008297 5C               [ 1]  449 	incw	x
      008298 CD 81 8D         [ 4]  450 	call	_uart_write_line
                                    451 ;	main.c: 109: uart_write_line("  <- Dev\n");
      00829B AE 80 77         [ 2]  452 	ldw	x, #(___str_7+0)
      00829E CD 81 8D         [ 4]  453 	call	_uart_write_line
                                    454 ;	main.c: 110: status_check();
      0082A1 CD 81 BD         [ 4]  455 	call	_status_check
                                    456 ;	main.c: 113: I2C_CR2 = I2C_CR2 | (1 << 2); // Set ACK bit
      0082A4 72 14 52 11      [ 1]  457 	bset	0x5211, #2
                                    458 ;	main.c: 114: I2C_CR2 = I2C_CR2 | (1 << 0); // START
      0082A8 72 10 52 11      [ 1]  459 	bset	0x5211, #0
                                    460 ;	main.c: 115: uart_write_line("flag\n");
      0082AC AE 80 81         [ 2]  461 	ldw	x, #(___str_8+0)
      0082AF CD 81 8D         [ 4]  462 	call	_uart_write_line
                                    463 ;	main.c: 116: while (!(I2C_SR1 & (1 << 0)));
      0082B2                        464 00101$:
      0082B2 72 01 52 17 FB   [ 2]  465 	btjf	0x5217, #0, 00101$
                                    466 ;	main.c: 117: uart_write_line("flag1\n");
      0082B7 AE 80 87         [ 2]  467 	ldw	x, #(___str_9+0)
      0082BA CD 81 8D         [ 4]  468 	call	_uart_write_line
                                    469 ;	main.c: 118: I2C_SR1 = I2C_SR1 | 0x00;
      0082BD 55 52 17 52 17   [ 1]  470 	mov	0x5217, 0x5217
                                    471 ;	main.c: 119: I2C_DR = I2C_DR | addr;
      0082C2 C6 52 16         [ 1]  472 	ld	a, 0x5216
      0082C5 1A 05            [ 1]  473 	or	a, (0x05, sp)
      0082C7 C7 52 16         [ 1]  474 	ld	0x5216, a
                                    475 ;	main.c: 120: status_check();
      0082CA CD 81 BD         [ 4]  476 	call	_status_check
                                    477 ;	main.c: 126: I2C_SR1 = 0x00;
      0082CD 35 00 52 17      [ 1]  478 	mov	0x5217+0, #0x00
                                    479 ;	main.c: 127: I2C_SR3 = 0x00;
      0082D1 35 00 52 19      [ 1]  480 	mov	0x5219+0, #0x00
                                    481 ;	main.c: 128: status_check();
      0082D5 CD 81 BD         [ 4]  482 	call	_status_check
                                    483 ;	main.c: 131: uart_write_line("_______Stop_______\n");
      0082D8 AE 80 8E         [ 2]  484 	ldw	x, #(___str_10+0)
      0082DB CD 81 8D         [ 4]  485 	call	_uart_write_line
                                    486 ;	main.c: 100: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
      0082DE 0C 05            [ 1]  487 	inc	(0x05, sp)
      0082E0 20 8E            [ 2]  488 	jra	00106$
      0082E2                        489 00104$:
                                    490 ;	main.c: 137: return 0;
      0082E2 5F               [ 1]  491 	clrw	x
                                    492 ;	main.c: 138: }
      0082E3 5B 05            [ 2]  493 	addw	sp, #5
      0082E5 81               [ 4]  494 	ret
                                    495 	.area CODE
                                    496 	.area CONST
                                    497 	.area CONST
      00802D                        498 ___str_0:
      00802D 53 52 31 20 2D 3E 20   499 	.ascii "SR1 -> "
      008034 00                     500 	.db 0x00
                                    501 	.area CODE
                                    502 	.area CONST
      008035                        503 ___str_1:
      008035 20 3C 2D               504 	.ascii " <-"
      008038 0A                     505 	.db 0x0a
      008039 00                     506 	.db 0x00
                                    507 	.area CODE
                                    508 	.area CONST
      00803A                        509 ___str_2:
      00803A 53 52 32 20 2D 3E 20   510 	.ascii "SR2 -> "
      008041 00                     511 	.db 0x00
                                    512 	.area CODE
                                    513 	.area CONST
      008042                        514 ___str_3:
      008042 53 52 33 20 2D 3E 20   515 	.ascii "SR3 -> "
      008049 00                     516 	.db 0x00
                                    517 	.area CODE
                                    518 	.area CONST
      00804A                        519 ___str_4:
      00804A 53 74 61 72 74 20 53   520 	.ascii "Start Scanning"
             63 61 6E 6E 69 6E 67
      008058 0A                     521 	.db 0x0a
      008059 00                     522 	.db 0x00
                                    523 	.area CODE
                                    524 	.area CONST
      00805A                        525 ___str_5:
      00805A 5F 5F 5F 5F 5F 5F 5F   526 	.ascii "_______Start______"
             53 74 61 72 74 5F 5F
             5F 5F 5F 5F
      00806C 0A                     527 	.db 0x0a
      00806D 00                     528 	.db 0x00
                                    529 	.area CODE
                                    530 	.area CONST
      00806E                        531 ___str_6:
      00806E 44 65 76 20 2D 3E 20   532 	.ascii "Dev ->  "
             20
      008076 00                     533 	.db 0x00
                                    534 	.area CODE
                                    535 	.area CONST
      008077                        536 ___str_7:
      008077 20 20 3C 2D 20 44 65   537 	.ascii "  <- Dev"
             76
      00807F 0A                     538 	.db 0x0a
      008080 00                     539 	.db 0x00
                                    540 	.area CODE
                                    541 	.area CONST
      008081                        542 ___str_8:
      008081 66 6C 61 67            543 	.ascii "flag"
      008085 0A                     544 	.db 0x0a
      008086 00                     545 	.db 0x00
                                    546 	.area CODE
                                    547 	.area CONST
      008087                        548 ___str_9:
      008087 66 6C 61 67 31         549 	.ascii "flag1"
      00808C 0A                     550 	.db 0x0a
      00808D 00                     551 	.db 0x00
                                    552 	.area CODE
                                    553 	.area CONST
      00808E                        554 ___str_10:
      00808E 5F 5F 5F 5F 5F 5F 5F   555 	.ascii "_______Stop_______"
             53 74 6F 70 5F 5F 5F
             5F 5F 5F 5F
      0080A0 0A                     556 	.db 0x0a
      0080A1 00                     557 	.db 0x00
                                    558 	.area CODE
                                    559 	.area INITIALIZER
                                    560 	.area CABS (ABS)
