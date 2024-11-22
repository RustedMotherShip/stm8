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
                                     12 	.globl _i2c_scan
                                     13 	.globl _i2c_read
                                     14 	.globl _i2c_write
                                     15 	.globl _i2c_send_address
                                     16 	.globl _i2c_stop
                                     17 	.globl _i2c_read_byte
                                     18 	.globl _i2c_send_byte
                                     19 	.globl _i2c_start
                                     20 	.globl _i2c_init
                                     21 	.globl _trash_clean
                                     22 	.globl _delay
                                     23 	.globl _uart_read
                                     24 	.globl _uart_write
                                     25 	.globl _uart_write_byte
                                     26 	.globl _uart_read_byte
                                     27 	.globl _uart_init
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DATA
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area INITIALIZED
                                     36 ;--------------------------------------------------------
                                     37 ; Stack segment in internal ram
                                     38 ;--------------------------------------------------------
                                     39 	.area SSEG
      000001                         40 __start__stack:
      000001                         41 	.ds	1
                                     42 
                                     43 ;--------------------------------------------------------
                                     44 ; absolute external ram data
                                     45 ;--------------------------------------------------------
                                     46 	.area DABS (ABS)
                                     47 
                                     48 ; default segment ordering for linker
                                     49 	.area HOME
                                     50 	.area GSINIT
                                     51 	.area GSFINAL
                                     52 	.area CONST
                                     53 	.area INITIALIZER
                                     54 	.area CODE
                                     55 
                                     56 ;--------------------------------------------------------
                                     57 ; interrupt vector
                                     58 ;--------------------------------------------------------
                                     59 	.area HOME
      008000                         60 __interrupt_vect:
      008000 82 00 80 07             61 	int s_GSINIT ; reset
                                     62 ;--------------------------------------------------------
                                     63 ; global & static initialisations
                                     64 ;--------------------------------------------------------
                                     65 	.area HOME
                                     66 	.area GSINIT
                                     67 	.area GSFINAL
                                     68 	.area GSINIT
      008007 CD 83 A9         [ 4]   69 	call	___sdcc_external_startup
      00800A 4D               [ 1]   70 	tnz	a
      00800B 27 03            [ 1]   71 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   72 	jp	__sdcc_program_startup
      008010                         73 __sdcc_init_data:
                                     74 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   75 	ldw x, #l_DATA
      008013 27 07            [ 1]   76 	jreq	00002$
      008015                         77 00001$:
      008015 72 4F 00 00      [ 1]   78 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   79 	decw x
      00801A 26 F9            [ 1]   80 	jrne	00001$
      00801C                         81 00002$:
      00801C AE 00 00         [ 2]   82 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   83 	jreq	00004$
      008021                         84 00003$:
      008021 D6 80 94         [ 1]   85 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   86 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   87 	decw	x
      008028 26 F7            [ 1]   88 	jrne	00003$
      00802A                         89 00004$:
                                     90 ; stm8_genXINIT() end
                                     91 	.area GSFINAL
      00802A CC 80 04         [ 2]   92 	jp	__sdcc_program_startup
                                     93 ;--------------------------------------------------------
                                     94 ; Home
                                     95 ;--------------------------------------------------------
                                     96 	.area HOME
                                     97 	.area HOME
      008004                         98 __sdcc_program_startup:
      008004 CC 83 6C         [ 2]   99 	jp	_main
                                    100 ;	return from main will return to caller
                                    101 ;--------------------------------------------------------
                                    102 ; code
                                    103 ;--------------------------------------------------------
                                    104 	.area CODE
                                    105 ;	libs/uart_lib.c: 3: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    106 ;	-----------------------------------------
                                    107 ;	 function uart_init
                                    108 ;	-----------------------------------------
      008095                        109 _uart_init:
      008095 52 02            [ 2]  110 	sub	sp, #2
      008097 1F 01            [ 2]  111 	ldw	(0x01, sp), x
                                    112 ;	libs/uart_lib.c: 7: UART1_CR2 -> TEN = 1; // Transmitter enable
      008099 AE 52 35         [ 2]  113 	ldw	x, #0x5235
      00809C 88               [ 1]  114 	push	a
      00809D F6               [ 1]  115 	ld	a, (x)
      00809E AA 08            [ 1]  116 	or	a, #0x08
      0080A0 F7               [ 1]  117 	ld	(x), a
      0080A1 84               [ 1]  118 	pop	a
                                    119 ;	libs/uart_lib.c: 8: UART1_CR2 -> REN = 1; // Receiver enable
      0080A2 AE 52 35         [ 2]  120 	ldw	x, #0x5235
      0080A5 88               [ 1]  121 	push	a
      0080A6 F6               [ 1]  122 	ld	a, (x)
      0080A7 AA 04            [ 1]  123 	or	a, #0x04
      0080A9 F7               [ 1]  124 	ld	(x), a
      0080AA 84               [ 1]  125 	pop	a
                                    126 ;	libs/uart_lib.c: 9: switch(stopbit)
      0080AB A1 02            [ 1]  127 	cp	a, #0x02
      0080AD 27 06            [ 1]  128 	jreq	00101$
      0080AF A1 03            [ 1]  129 	cp	a, #0x03
      0080B1 27 0E            [ 1]  130 	jreq	00102$
      0080B3 20 16            [ 2]  131 	jra	00103$
                                    132 ;	libs/uart_lib.c: 11: case 2:
      0080B5                        133 00101$:
                                    134 ;	libs/uart_lib.c: 12: UART1_CR3 -> STOP = 2;
      0080B5 C6 52 36         [ 1]  135 	ld	a, 0x5236
      0080B8 A4 CF            [ 1]  136 	and	a, #0xcf
      0080BA AA 20            [ 1]  137 	or	a, #0x20
      0080BC C7 52 36         [ 1]  138 	ld	0x5236, a
                                    139 ;	libs/uart_lib.c: 13: break;
      0080BF 20 12            [ 2]  140 	jra	00104$
                                    141 ;	libs/uart_lib.c: 14: case 3:
      0080C1                        142 00102$:
                                    143 ;	libs/uart_lib.c: 15: UART1_CR3 -> STOP = 3;
      0080C1 C6 52 36         [ 1]  144 	ld	a, 0x5236
      0080C4 AA 30            [ 1]  145 	or	a, #0x30
      0080C6 C7 52 36         [ 1]  146 	ld	0x5236, a
                                    147 ;	libs/uart_lib.c: 16: break;
      0080C9 20 08            [ 2]  148 	jra	00104$
                                    149 ;	libs/uart_lib.c: 17: default:
      0080CB                        150 00103$:
                                    151 ;	libs/uart_lib.c: 18: UART1_CR3 -> STOP = 0;
      0080CB C6 52 36         [ 1]  152 	ld	a, 0x5236
      0080CE A4 CF            [ 1]  153 	and	a, #0xcf
      0080D0 C7 52 36         [ 1]  154 	ld	0x5236, a
                                    155 ;	libs/uart_lib.c: 20: }
      0080D3                        156 00104$:
                                    157 ;	libs/uart_lib.c: 21: switch(baudrate)
      0080D3 1E 01            [ 2]  158 	ldw	x, (0x01, sp)
      0080D5 A3 08 00         [ 2]  159 	cpw	x, #0x0800
      0080D8 26 03            [ 1]  160 	jrne	00186$
      0080DA CC 81 66         [ 2]  161 	jp	00110$
      0080DD                        162 00186$:
      0080DD 1E 01            [ 2]  163 	ldw	x, (0x01, sp)
      0080DF A3 09 60         [ 2]  164 	cpw	x, #0x0960
      0080E2 27 28            [ 1]  165 	jreq	00105$
      0080E4 1E 01            [ 2]  166 	ldw	x, (0x01, sp)
      0080E6 A3 10 00         [ 2]  167 	cpw	x, #0x1000
      0080E9 26 03            [ 1]  168 	jrne	00192$
      0080EB CC 81 76         [ 2]  169 	jp	00111$
      0080EE                        170 00192$:
      0080EE 1E 01            [ 2]  171 	ldw	x, (0x01, sp)
      0080F0 A3 4B 00         [ 2]  172 	cpw	x, #0x4b00
      0080F3 27 31            [ 1]  173 	jreq	00106$
      0080F5 1E 01            [ 2]  174 	ldw	x, (0x01, sp)
      0080F7 A3 84 00         [ 2]  175 	cpw	x, #0x8400
      0080FA 27 5A            [ 1]  176 	jreq	00109$
      0080FC 1E 01            [ 2]  177 	ldw	x, (0x01, sp)
      0080FE A3 C2 00         [ 2]  178 	cpw	x, #0xc200
      008101 27 43            [ 1]  179 	jreq	00108$
      008103 1E 01            [ 2]  180 	ldw	x, (0x01, sp)
      008105 A3 E1 00         [ 2]  181 	cpw	x, #0xe100
      008108 27 2C            [ 1]  182 	jreq	00107$
      00810A 20 7A            [ 2]  183 	jra	00112$
                                    184 ;	libs/uart_lib.c: 23: case (unsigned int)2400:
      00810C                        185 00105$:
                                    186 ;	libs/uart_lib.c: 24: UART1_BRR2 -> MSB = 0x01;
      00810C C6 52 33         [ 1]  187 	ld	a, 0x5233
      00810F A4 0F            [ 1]  188 	and	a, #0x0f
      008111 AA 10            [ 1]  189 	or	a, #0x10
      008113 C7 52 33         [ 1]  190 	ld	0x5233, a
                                    191 ;	libs/uart_lib.c: 25: UART1_BRR1 -> DIV = 0xA0;
      008116 35 A0 52 32      [ 1]  192 	mov	0x5232+0, #0xa0
                                    193 ;	libs/uart_lib.c: 26: UART1_BRR2 -> LSB = 0x0B; 
      00811A C6 52 33         [ 1]  194 	ld	a, 0x5233
      00811D A4 F0            [ 1]  195 	and	a, #0xf0
      00811F AA 0B            [ 1]  196 	or	a, #0x0b
      008121 C7 52 33         [ 1]  197 	ld	0x5233, a
                                    198 ;	libs/uart_lib.c: 27: break;
      008124 20 6E            [ 2]  199 	jra	00114$
                                    200 ;	libs/uart_lib.c: 28: case (unsigned int)19200:
      008126                        201 00106$:
                                    202 ;	libs/uart_lib.c: 29: UART1_BRR1 -> DIV = 0x34;
      008126 35 34 52 32      [ 1]  203 	mov	0x5232+0, #0x34
                                    204 ;	libs/uart_lib.c: 30: UART1_BRR2 -> LSB = 0x01;
      00812A C6 52 33         [ 1]  205 	ld	a, 0x5233
      00812D A4 F0            [ 1]  206 	and	a, #0xf0
      00812F AA 01            [ 1]  207 	or	a, #0x01
      008131 C7 52 33         [ 1]  208 	ld	0x5233, a
                                    209 ;	libs/uart_lib.c: 31: break;
      008134 20 5E            [ 2]  210 	jra	00114$
                                    211 ;	libs/uart_lib.c: 32: case (unsigned int)57600:
      008136                        212 00107$:
                                    213 ;	libs/uart_lib.c: 33: UART1_BRR1 -> DIV = 0x11;
      008136 35 11 52 32      [ 1]  214 	mov	0x5232+0, #0x11
                                    215 ;	libs/uart_lib.c: 34: UART1_BRR2 -> LSB = 0x06;
      00813A C6 52 33         [ 1]  216 	ld	a, 0x5233
      00813D A4 F0            [ 1]  217 	and	a, #0xf0
      00813F AA 06            [ 1]  218 	or	a, #0x06
      008141 C7 52 33         [ 1]  219 	ld	0x5233, a
                                    220 ;	libs/uart_lib.c: 35: break;
      008144 20 4E            [ 2]  221 	jra	00114$
                                    222 ;	libs/uart_lib.c: 36: case (unsigned int)115200:
      008146                        223 00108$:
                                    224 ;	libs/uart_lib.c: 37: UART1_BRR1 -> DIV = 0x08;
      008146 35 08 52 32      [ 1]  225 	mov	0x5232+0, #0x08
                                    226 ;	libs/uart_lib.c: 38: UART1_BRR2 -> LSB = 0x0B;
      00814A C6 52 33         [ 1]  227 	ld	a, 0x5233
      00814D A4 F0            [ 1]  228 	and	a, #0xf0
      00814F AA 0B            [ 1]  229 	or	a, #0x0b
      008151 C7 52 33         [ 1]  230 	ld	0x5233, a
                                    231 ;	libs/uart_lib.c: 39: break;
      008154 20 3E            [ 2]  232 	jra	00114$
                                    233 ;	libs/uart_lib.c: 40: case (unsigned int)230400:
      008156                        234 00109$:
                                    235 ;	libs/uart_lib.c: 41: UART1_BRR1 -> DIV = 0x04;
      008156 35 04 52 32      [ 1]  236 	mov	0x5232+0, #0x04
                                    237 ;	libs/uart_lib.c: 42: UART1_BRR2 -> LSB = 0x05;
      00815A C6 52 33         [ 1]  238 	ld	a, 0x5233
      00815D A4 F0            [ 1]  239 	and	a, #0xf0
      00815F AA 05            [ 1]  240 	or	a, #0x05
      008161 C7 52 33         [ 1]  241 	ld	0x5233, a
                                    242 ;	libs/uart_lib.c: 43: break;
      008164 20 2E            [ 2]  243 	jra	00114$
                                    244 ;	libs/uart_lib.c: 44: case (unsigned int)460800:
      008166                        245 00110$:
                                    246 ;	libs/uart_lib.c: 45: UART1_BRR1 -> DIV = 0x02;
      008166 35 02 52 32      [ 1]  247 	mov	0x5232+0, #0x02
                                    248 ;	libs/uart_lib.c: 46: UART1_BRR2 -> LSB = 0x03;
      00816A C6 52 33         [ 1]  249 	ld	a, 0x5233
      00816D A4 F0            [ 1]  250 	and	a, #0xf0
      00816F AA 03            [ 1]  251 	or	a, #0x03
      008171 C7 52 33         [ 1]  252 	ld	0x5233, a
                                    253 ;	libs/uart_lib.c: 47: break;
      008174 20 1E            [ 2]  254 	jra	00114$
                                    255 ;	libs/uart_lib.c: 48: case (unsigned int)921600:
      008176                        256 00111$:
                                    257 ;	libs/uart_lib.c: 49: UART1_BRR1 -> DIV = 0x01;
      008176 35 01 52 32      [ 1]  258 	mov	0x5232+0, #0x01
                                    259 ;	libs/uart_lib.c: 50: UART1_BRR2 -> LSB = 0x01;
      00817A C6 52 33         [ 1]  260 	ld	a, 0x5233
      00817D A4 F0            [ 1]  261 	and	a, #0xf0
      00817F AA 01            [ 1]  262 	or	a, #0x01
      008181 C7 52 33         [ 1]  263 	ld	0x5233, a
                                    264 ;	libs/uart_lib.c: 51: break;
      008184 20 0E            [ 2]  265 	jra	00114$
                                    266 ;	libs/uart_lib.c: 52: default:
      008186                        267 00112$:
                                    268 ;	libs/uart_lib.c: 53: UART1_BRR1 -> DIV = 0x68;
      008186 35 68 52 32      [ 1]  269 	mov	0x5232+0, #0x68
                                    270 ;	libs/uart_lib.c: 54: UART1_BRR2 -> LSB = 0x03;
      00818A C6 52 33         [ 1]  271 	ld	a, 0x5233
      00818D A4 F0            [ 1]  272 	and	a, #0xf0
      00818F AA 03            [ 1]  273 	or	a, #0x03
      008191 C7 52 33         [ 1]  274 	ld	0x5233, a
                                    275 ;	libs/uart_lib.c: 56: }
      008194                        276 00114$:
                                    277 ;	libs/uart_lib.c: 57: }
      008194 5B 02            [ 2]  278 	addw	sp, #2
      008196 81               [ 4]  279 	ret
                                    280 ;	libs/uart_lib.c: 59: int uart_read_byte(uint8_t *data)
                                    281 ;	-----------------------------------------
                                    282 ;	 function uart_read_byte
                                    283 ;	-----------------------------------------
      008197                        284 _uart_read_byte:
                                    285 ;	libs/uart_lib.c: 61: while(!(UART1_SR -> RXNE));
      008197                        286 00101$:
      008197 72 0B 52 30 FB   [ 2]  287 	btjf	0x5230, #5, 00101$
                                    288 ;	libs/uart_lib.c: 63: return 1;
      00819C 5F               [ 1]  289 	clrw	x
      00819D 5C               [ 1]  290 	incw	x
                                    291 ;	libs/uart_lib.c: 64: }
      00819E 81               [ 4]  292 	ret
                                    293 ;	libs/uart_lib.c: 66: int uart_write_byte(uint8_t data)
                                    294 ;	-----------------------------------------
                                    295 ;	 function uart_write_byte
                                    296 ;	-----------------------------------------
      00819F                        297 _uart_write_byte:
                                    298 ;	libs/uart_lib.c: 68: UART1_DR -> DR = data;
      00819F C7 52 31         [ 1]  299 	ld	0x5231, a
                                    300 ;	libs/uart_lib.c: 69: while(!(UART1_SR -> TXE));
      0081A2                        301 00101$:
      0081A2 72 0F 52 30 FB   [ 2]  302 	btjf	0x5230, #7, 00101$
                                    303 ;	libs/uart_lib.c: 70: return 1;
      0081A7 5F               [ 1]  304 	clrw	x
      0081A8 5C               [ 1]  305 	incw	x
                                    306 ;	libs/uart_lib.c: 71: }
      0081A9 81               [ 4]  307 	ret
                                    308 ;	libs/uart_lib.c: 73: int uart_write(uint8_t *data_buf)
                                    309 ;	-----------------------------------------
                                    310 ;	 function uart_write
                                    311 ;	-----------------------------------------
      0081AA                        312 _uart_write:
      0081AA 52 04            [ 2]  313 	sub	sp, #4
      0081AC 1F 01            [ 2]  314 	ldw	(0x01, sp), x
                                    315 ;	libs/uart_lib.c: 75: int count = 0;
      0081AE 5F               [ 1]  316 	clrw	x
      0081AF 1F 03            [ 2]  317 	ldw	(0x03, sp), x
                                    318 ;	libs/uart_lib.c: 76: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081B1 5F               [ 1]  319 	clrw	x
      0081B2                        320 00103$:
      0081B2 90 93            [ 1]  321 	ldw	y, x
      0081B4 72 F9 01         [ 2]  322 	addw	y, (0x01, sp)
      0081B7 90 F6            [ 1]  323 	ld	a, (y)
      0081B9 27 0E            [ 1]  324 	jreq	00101$
                                    325 ;	libs/uart_lib.c: 77: count += uart_write_byte(data_buf[i]);
      0081BB 89               [ 2]  326 	pushw	x
      0081BC CD 81 9F         [ 4]  327 	call	_uart_write_byte
      0081BF 51               [ 1]  328 	exgw	x, y
      0081C0 85               [ 2]  329 	popw	x
      0081C1 72 F9 03         [ 2]  330 	addw	y, (0x03, sp)
      0081C4 17 03            [ 2]  331 	ldw	(0x03, sp), y
                                    332 ;	libs/uart_lib.c: 76: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081C6 5C               [ 1]  333 	incw	x
      0081C7 20 E9            [ 2]  334 	jra	00103$
      0081C9                        335 00101$:
                                    336 ;	libs/uart_lib.c: 78: return count;
      0081C9 1E 03            [ 2]  337 	ldw	x, (0x03, sp)
                                    338 ;	libs/uart_lib.c: 79: }
      0081CB 5B 04            [ 2]  339 	addw	sp, #4
      0081CD 81               [ 4]  340 	ret
                                    341 ;	libs/uart_lib.c: 80: int uart_read(uint8_t *data_buf)
                                    342 ;	-----------------------------------------
                                    343 ;	 function uart_read
                                    344 ;	-----------------------------------------
      0081CE                        345 _uart_read:
      0081CE 52 04            [ 2]  346 	sub	sp, #4
      0081D0 1F 01            [ 2]  347 	ldw	(0x01, sp), x
                                    348 ;	libs/uart_lib.c: 82: int count = 0;
      0081D2 5F               [ 1]  349 	clrw	x
      0081D3 1F 03            [ 2]  350 	ldw	(0x03, sp), x
                                    351 ;	libs/uart_lib.c: 83: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081D5 5F               [ 1]  352 	clrw	x
      0081D6                        353 00103$:
      0081D6 90 93            [ 1]  354 	ldw	y, x
      0081D8 72 F9 01         [ 2]  355 	addw	y, (0x01, sp)
      0081DB 90 F6            [ 1]  356 	ld	a, (y)
      0081DD 27 13            [ 1]  357 	jreq	00101$
                                    358 ;	libs/uart_lib.c: 84: count += uart_read_byte((unsigned char *)data_buf[i]);
      0081DF 90 5F            [ 1]  359 	clrw	y
      0081E1 90 97            [ 1]  360 	ld	yl, a
      0081E3 89               [ 2]  361 	pushw	x
      0081E4 93               [ 1]  362 	ldw	x, y
      0081E5 CD 81 97         [ 4]  363 	call	_uart_read_byte
      0081E8 51               [ 1]  364 	exgw	x, y
      0081E9 85               [ 2]  365 	popw	x
      0081EA 72 F9 03         [ 2]  366 	addw	y, (0x03, sp)
      0081ED 17 03            [ 2]  367 	ldw	(0x03, sp), y
                                    368 ;	libs/uart_lib.c: 83: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081EF 5C               [ 1]  369 	incw	x
      0081F0 20 E4            [ 2]  370 	jra	00103$
      0081F2                        371 00101$:
                                    372 ;	libs/uart_lib.c: 85: return count;
      0081F2 1E 03            [ 2]  373 	ldw	x, (0x03, sp)
                                    374 ;	libs/uart_lib.c: 86: }
      0081F4 5B 04            [ 2]  375 	addw	sp, #4
      0081F6 81               [ 4]  376 	ret
                                    377 ;	libs/i2c_lib.c: 10: void delay(uint16_t ticks)
                                    378 ;	-----------------------------------------
                                    379 ;	 function delay
                                    380 ;	-----------------------------------------
      0081F7                        381 _delay:
                                    382 ;	libs/i2c_lib.c: 12: while(ticks > 0)
      0081F7                        383 00101$:
      0081F7 5D               [ 2]  384 	tnzw	x
      0081F8 26 01            [ 1]  385 	jrne	00120$
      0081FA 81               [ 4]  386 	ret
      0081FB                        387 00120$:
                                    388 ;	libs/i2c_lib.c: 14: ticks-=2;
      0081FB 5A               [ 2]  389 	decw	x
      0081FC 5A               [ 2]  390 	decw	x
                                    391 ;	libs/i2c_lib.c: 15: ticks+=1;
      0081FD 5C               [ 1]  392 	incw	x
      0081FE 20 F7            [ 2]  393 	jra	00101$
                                    394 ;	libs/i2c_lib.c: 17: }
      008200 81               [ 4]  395 	ret
                                    396 ;	libs/i2c_lib.c: 18: void trash_clean(void)
                                    397 ;	-----------------------------------------
                                    398 ;	 function trash_clean
                                    399 ;	-----------------------------------------
      008201                        400 _trash_clean:
                                    401 ;	libs/i2c_lib.c: 24: }
      008201 81               [ 4]  402 	ret
                                    403 ;	libs/i2c_lib.c: 25: void i2c_init(void) {
                                    404 ;	-----------------------------------------
                                    405 ;	 function i2c_init
                                    406 ;	-----------------------------------------
      008202                        407 _i2c_init:
                                    408 ;	libs/i2c_lib.c: 28: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      008202 72 11 52 10      [ 1]  409 	bres	0x5210, #0
                                    410 ;	libs/i2c_lib.c: 29: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      008206 C6 52 12         [ 1]  411 	ld	a, 0x5212
      008209 A4 C0            [ 1]  412 	and	a, #0xc0
      00820B AA 10            [ 1]  413 	or	a, #0x10
      00820D C7 52 12         [ 1]  414 	ld	0x5212, a
                                    415 ;	libs/i2c_lib.c: 30: I2C_CCRH -> CCR = 0;// =0
      008210 C6 52 1C         [ 1]  416 	ld	a, 0x521c
      008213 A4 F0            [ 1]  417 	and	a, #0xf0
      008215 C7 52 1C         [ 1]  418 	ld	0x521c, a
                                    419 ;	libs/i2c_lib.c: 31: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008218 35 50 52 1B      [ 1]  420 	mov	0x521b+0, #0x50
                                    421 ;	libs/i2c_lib.c: 32: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      00821C 72 1F 52 1C      [ 1]  422 	bres	0x521c, #7
                                    423 ;	libs/i2c_lib.c: 33: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      008220 72 1F 52 14      [ 1]  424 	bres	0x5214, #7
                                    425 ;	libs/i2c_lib.c: 34: I2C_OARH -> ADDCONF = 1;// see reference manual
      008224 72 10 52 14      [ 1]  426 	bset	0x5214, #0
                                    427 ;	libs/i2c_lib.c: 35: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      008228 72 10 52 10      [ 1]  428 	bset	0x5210, #0
                                    429 ;	libs/i2c_lib.c: 36: }
      00822C 81               [ 4]  430 	ret
                                    431 ;	libs/i2c_lib.c: 38: void i2c_start(void) {
                                    432 ;	-----------------------------------------
                                    433 ;	 function i2c_start
                                    434 ;	-----------------------------------------
      00822D                        435 _i2c_start:
                                    436 ;	libs/i2c_lib.c: 39: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
      00822D 72 10 52 11      [ 1]  437 	bset	0x5211, #0
                                    438 ;	libs/i2c_lib.c: 40: while(!(I2C_SR1 -> SB));// Ожидание отправки стартового сигнала
      008231                        439 00101$:
      008231 72 01 52 17 FB   [ 2]  440 	btjf	0x5217, #0, 00101$
                                    441 ;	libs/i2c_lib.c: 41: }
      008236 81               [ 4]  442 	ret
                                    443 ;	libs/i2c_lib.c: 43: uint8_t i2c_send_byte(unsigned char data){
                                    444 ;	-----------------------------------------
                                    445 ;	 function i2c_send_byte
                                    446 ;	-----------------------------------------
      008237                        447 _i2c_send_byte:
                                    448 ;	libs/i2c_lib.c: 44: uart_write("start send byte\n");
      008237 88               [ 1]  449 	push	a
      008238 AE 80 2D         [ 2]  450 	ldw	x, #(___str_0+0)
      00823B CD 81 AA         [ 4]  451 	call	_uart_write
      00823E 84               [ 1]  452 	pop	a
                                    453 ;	libs/i2c_lib.c: 45: I2C_DR -> DR = data;
      00823F C7 52 16         [ 1]  454 	ld	0x5216, a
                                    455 ;	libs/i2c_lib.c: 48: while (!(I2C_SR1 ->TXE) && (I2C_SR2 -> AF) && !(I2C_SR1 -> BTF));
      008242                        456 00103$:
      008242 72 0E 52 17 0A   [ 2]  457 	btjt	0x5217, #7, 00105$
      008247 72 0F 52 18 05   [ 2]  458 	btjf	0x5218, #7, 00105$
      00824C 72 05 52 17 F1   [ 2]  459 	btjf	0x5217, #2, 00103$
      008251                        460 00105$:
                                    461 ;	libs/i2c_lib.c: 49: uart_write("DR byte\n");
      008251 AE 80 3E         [ 2]  462 	ldw	x, #(___str_1+0)
      008254 CD 81 AA         [ 4]  463 	call	_uart_write
                                    464 ;	libs/i2c_lib.c: 50: int result = I2C_SR2 -> AF;
      008257 C6 52 18         [ 1]  465 	ld	a, 0x5218
      00825A 4E               [ 1]  466 	swap	a
      00825B 44               [ 1]  467 	srl	a
      00825C 44               [ 1]  468 	srl	a
      00825D 44               [ 1]  469 	srl	a
      00825E A4 01            [ 1]  470 	and	a, #0x01
                                    471 ;	libs/i2c_lib.c: 51: return result;
                                    472 ;	libs/i2c_lib.c: 52: }
      008260 81               [ 4]  473 	ret
                                    474 ;	libs/i2c_lib.c: 54: uint8_t i2c_read_byte(unsigned char *data){
                                    475 ;	-----------------------------------------
                                    476 ;	 function i2c_read_byte
                                    477 ;	-----------------------------------------
      008261                        478 _i2c_read_byte:
                                    479 ;	libs/i2c_lib.c: 55: while (!(I2C_SR1 -> RXNE));
      008261                        480 00101$:
      008261 72 0D 52 17 FB   [ 2]  481 	btjf	0x5217, #6, 00101$
                                    482 ;	libs/i2c_lib.c: 57: return 0;
      008266 4F               [ 1]  483 	clr	a
                                    484 ;	libs/i2c_lib.c: 59: }
      008267 81               [ 4]  485 	ret
                                    486 ;	libs/i2c_lib.c: 61: void i2c_stop(void) {
                                    487 ;	-----------------------------------------
                                    488 ;	 function i2c_stop
                                    489 ;	-----------------------------------------
      008268                        490 _i2c_stop:
                                    491 ;	libs/i2c_lib.c: 62: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
      008268 72 12 52 11      [ 1]  492 	bset	0x5211, #1
                                    493 ;	libs/i2c_lib.c: 63: }
      00826C 81               [ 4]  494 	ret
                                    495 ;	libs/i2c_lib.c: 66: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    496 ;	-----------------------------------------
                                    497 ;	 function i2c_send_address
                                    498 ;	-----------------------------------------
      00826D                        499 _i2c_send_address:
      00826D 88               [ 1]  500 	push	a
                                    501 ;	libs/i2c_lib.c: 68: i2c_start();
      00826E 88               [ 1]  502 	push	a
      00826F CD 82 2D         [ 4]  503 	call	_i2c_start
      008272 84               [ 1]  504 	pop	a
                                    505 ;	libs/i2c_lib.c: 72: address = address << 1;
      008273 48               [ 1]  506 	sll	a
                                    507 ;	libs/i2c_lib.c: 69: switch(rw_type)
      008274 88               [ 1]  508 	push	a
      008275 7B 05            [ 1]  509 	ld	a, (0x05, sp)
      008277 4A               [ 1]  510 	dec	a
      008278 84               [ 1]  511 	pop	a
      008279 26 02            [ 1]  512 	jrne	00102$
                                    513 ;	libs/i2c_lib.c: 72: address = address << 1;
                                    514 ;	libs/i2c_lib.c: 73: address |= 0x01; // Отправка адреса устройства с битом на чтение
      00827B AA 01            [ 1]  515 	or	a, #0x01
                                    516 ;	libs/i2c_lib.c: 74: break;
                                    517 ;	libs/i2c_lib.c: 75: default:
                                    518 ;	libs/i2c_lib.c: 76: address = address << 1; // Отправка адреса устройства с битом на запись
                                    519 ;	libs/i2c_lib.c: 78: }
      00827D                        520 00102$:
                                    521 ;	libs/i2c_lib.c: 79: I2C_DR -> DR = address;
      00827D C7 52 16         [ 1]  522 	ld	0x5216, a
                                    523 ;	libs/i2c_lib.c: 80: int result = I2C_SR1 -> ADDR;//Отправка адреса
      008280 C6 52 17         [ 1]  524 	ld	a, 0x5217
      008283 44               [ 1]  525 	srl	a
      008284 A4 01            [ 1]  526 	and	a, #0x01
      008286 6B 01            [ 1]  527 	ld	(0x01, sp), a
                                    528 ;	libs/i2c_lib.c: 83: uart_write("WHILE start\n");
      008288 AE 80 47         [ 2]  529 	ldw	x, #(___str_2+0)
      00828B CD 81 AA         [ 4]  530 	call	_uart_write
                                    531 ;	libs/i2c_lib.c: 84: while (!(I2C_SR1 -> ADDR) && (I2C_SR2 -> AF));
      00828E                        532 00105$:
      00828E 72 02 52 17 05   [ 2]  533 	btjt	0x5217, #1, 00107$
      008293 72 0E 52 18 F6   [ 2]  534 	btjt	0x5218, #7, 00105$
      008298                        535 00107$:
                                    536 ;	libs/i2c_lib.c: 85: uart_write("WHILE passed\n");  
      008298 AE 80 54         [ 2]  537 	ldw	x, #(___str_3+0)
      00829B CD 81 AA         [ 4]  538 	call	_uart_write
                                    539 ;	libs/i2c_lib.c: 91: return result;
      00829E 7B 01            [ 1]  540 	ld	a, (0x01, sp)
                                    541 ;	libs/i2c_lib.c: 92: }
      0082A0 5B 01            [ 2]  542 	addw	sp, #1
      0082A2 85               [ 2]  543 	popw	x
      0082A3 5B 01            [ 2]  544 	addw	sp, #1
      0082A5 FC               [ 2]  545 	jp	(x)
                                    546 ;	libs/i2c_lib.c: 94: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    547 ;	-----------------------------------------
                                    548 ;	 function i2c_write
                                    549 ;	-----------------------------------------
      0082A6                        550 _i2c_write:
      0082A6 52 04            [ 2]  551 	sub	sp, #4
                                    552 ;	libs/i2c_lib.c: 96: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      0082A8 4B 00            [ 1]  553 	push	#0x00
      0082AA CD 82 6D         [ 4]  554 	call	_i2c_send_address
      0082AD 4D               [ 1]  555 	tnz	a
      0082AE 27 3C            [ 1]  556 	jreq	00105$
                                    557 ;	libs/i2c_lib.c: 98: uart_write("PIVO\n");
      0082B0 AE 80 62         [ 2]  558 	ldw	x, #(___str_4+0)
      0082B3 CD 81 AA         [ 4]  559 	call	_uart_write
                                    560 ;	libs/i2c_lib.c: 99: for(int i = 0;i < size;i++)
      0082B6 5F               [ 1]  561 	clrw	x
      0082B7 1F 03            [ 2]  562 	ldw	(0x03, sp), x
      0082B9                        563 00107$:
      0082B9 7B 07            [ 1]  564 	ld	a, (0x07, sp)
      0082BB 6B 02            [ 1]  565 	ld	(0x02, sp), a
      0082BD 0F 01            [ 1]  566 	clr	(0x01, sp)
      0082BF 1E 03            [ 2]  567 	ldw	x, (0x03, sp)
      0082C1 13 01            [ 2]  568 	cpw	x, (0x01, sp)
      0082C3 2E 27            [ 1]  569 	jrsge	00105$
                                    570 ;	libs/i2c_lib.c: 101: uart_write("for\n");
      0082C5 AE 80 68         [ 2]  571 	ldw	x, #(___str_5+0)
      0082C8 CD 81 AA         [ 4]  572 	call	_uart_write
                                    573 ;	libs/i2c_lib.c: 102: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      0082CB 1E 08            [ 2]  574 	ldw	x, (0x08, sp)
      0082CD 72 FB 03         [ 2]  575 	addw	x, (0x03, sp)
      0082D0 F6               [ 1]  576 	ld	a, (x)
      0082D1 CD 82 37         [ 4]  577 	call	_i2c_send_byte
      0082D4 4D               [ 1]  578 	tnz	a
      0082D5 27 08            [ 1]  579 	jreq	00102$
                                    580 ;	libs/i2c_lib.c: 104: uart_write("error send byte\n");
      0082D7 AE 80 6D         [ 2]  581 	ldw	x, #(___str_6+0)
      0082DA CD 81 AA         [ 4]  582 	call	_uart_write
                                    583 ;	libs/i2c_lib.c: 105: break;
      0082DD 20 0D            [ 2]  584 	jra	00105$
      0082DF                        585 00102$:
                                    586 ;	libs/i2c_lib.c: 109: uart_write("if passed\n");    
      0082DF AE 80 7E         [ 2]  587 	ldw	x, #(___str_7+0)
      0082E2 CD 81 AA         [ 4]  588 	call	_uart_write
                                    589 ;	libs/i2c_lib.c: 99: for(int i = 0;i < size;i++)
      0082E5 1E 03            [ 2]  590 	ldw	x, (0x03, sp)
      0082E7 5C               [ 1]  591 	incw	x
      0082E8 1F 03            [ 2]  592 	ldw	(0x03, sp), x
      0082EA 20 CD            [ 2]  593 	jra	00107$
      0082EC                        594 00105$:
                                    595 ;	libs/i2c_lib.c: 112: i2c_stop();
      0082EC 1E 05            [ 2]  596 	ldw	x, (5, sp)
      0082EE 1F 08            [ 2]  597 	ldw	(8, sp), x
      0082F0 5B 07            [ 2]  598 	addw	sp, #7
                                    599 ;	libs/i2c_lib.c: 113: }
      0082F2 CC 82 68         [ 2]  600 	jp	_i2c_stop
                                    601 ;	libs/i2c_lib.c: 115: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
                                    602 ;	-----------------------------------------
                                    603 ;	 function i2c_read
                                    604 ;	-----------------------------------------
      0082F5                        605 _i2c_read:
      0082F5 52 02            [ 2]  606 	sub	sp, #2
                                    607 ;	libs/i2c_lib.c: 116: I2C_CR2 -> ACK = 1;
      0082F7 AE 52 11         [ 2]  608 	ldw	x, #0x5211
      0082FA 88               [ 1]  609 	push	a
      0082FB F6               [ 1]  610 	ld	a, (x)
      0082FC AA 04            [ 1]  611 	or	a, #0x04
      0082FE F7               [ 1]  612 	ld	(x), a
      0082FF 84               [ 1]  613 	pop	a
                                    614 ;	libs/i2c_lib.c: 117: if(i2c_send_address(dev_addr,1))
      008300 4B 01            [ 1]  615 	push	#0x01
      008302 CD 82 6D         [ 4]  616 	call	_i2c_send_address
      008305 4D               [ 1]  617 	tnz	a
      008306 27 1F            [ 1]  618 	jreq	00103$
                                    619 ;	libs/i2c_lib.c: 118: for(int i = 0;i < size;i++)
      008308 5F               [ 1]  620 	clrw	x
      008309                        621 00105$:
      008309 7B 05            [ 1]  622 	ld	a, (0x05, sp)
      00830B 6B 02            [ 1]  623 	ld	(0x02, sp), a
      00830D 0F 01            [ 1]  624 	clr	(0x01, sp)
      00830F 13 01            [ 2]  625 	cpw	x, (0x01, sp)
      008311 2E 14            [ 1]  626 	jrsge	00103$
                                    627 ;	libs/i2c_lib.c: 120: i2c_read_byte((unsigned char *)data[i]);
      008313 90 93            [ 1]  628 	ldw	y, x
      008315 72 F9 06         [ 2]  629 	addw	y, (0x06, sp)
      008318 90 F6            [ 1]  630 	ld	a, (y)
      00831A 90 5F            [ 1]  631 	clrw	y
      00831C 90 97            [ 1]  632 	ld	yl, a
      00831E 89               [ 2]  633 	pushw	x
      00831F 93               [ 1]  634 	ldw	x, y
      008320 CD 82 61         [ 4]  635 	call	_i2c_read_byte
      008323 85               [ 2]  636 	popw	x
                                    637 ;	libs/i2c_lib.c: 118: for(int i = 0;i < size;i++)
      008324 5C               [ 1]  638 	incw	x
      008325 20 E2            [ 2]  639 	jra	00105$
      008327                        640 00103$:
                                    641 ;	libs/i2c_lib.c: 122: I2C_CR2 -> ACK = 0;
      008327 C6 52 11         [ 1]  642 	ld	a, 0x5211
      00832A A4 FB            [ 1]  643 	and	a, #0xfb
      00832C C7 52 11         [ 1]  644 	ld	0x5211, a
                                    645 ;	libs/i2c_lib.c: 123: }
      00832F 1E 03            [ 2]  646 	ldw	x, (3, sp)
      008331 5B 07            [ 2]  647 	addw	sp, #7
      008333 FC               [ 2]  648 	jp	(x)
                                    649 ;	libs/i2c_lib.c: 124: uint8_t i2c_scan(void) 
                                    650 ;	-----------------------------------------
                                    651 ;	 function i2c_scan
                                    652 ;	-----------------------------------------
      008334                        653 _i2c_scan:
      008334 52 02            [ 2]  654 	sub	sp, #2
                                    655 ;	libs/i2c_lib.c: 126: for (uint8_t addr = 1; addr < 127; addr++)
      008336 A6 01            [ 1]  656 	ld	a, #0x01
      008338 6B 01            [ 1]  657 	ld	(0x01, sp), a
      00833A 6B 02            [ 1]  658 	ld	(0x02, sp), a
      00833C                        659 00105$:
      00833C 7B 02            [ 1]  660 	ld	a, (0x02, sp)
      00833E A1 7F            [ 1]  661 	cp	a, #0x7f
      008340 24 23            [ 1]  662 	jrnc	00103$
                                    663 ;	libs/i2c_lib.c: 128: if(i2c_send_address(addr, 0))
      008342 4B 00            [ 1]  664 	push	#0x00
      008344 7B 03            [ 1]  665 	ld	a, (0x03, sp)
      008346 CD 82 6D         [ 4]  666 	call	_i2c_send_address
      008349 4D               [ 1]  667 	tnz	a
      00834A 27 07            [ 1]  668 	jreq	00102$
                                    669 ;	libs/i2c_lib.c: 130: i2c_stop();
      00834C CD 82 68         [ 4]  670 	call	_i2c_stop
                                    671 ;	libs/i2c_lib.c: 131: return addr;
      00834F 7B 01            [ 1]  672 	ld	a, (0x01, sp)
      008351 20 16            [ 2]  673 	jra	00107$
      008353                        674 00102$:
                                    675 ;	libs/i2c_lib.c: 133: I2C_SR2 -> AF = 0;
      008353 72 1F 52 18      [ 1]  676 	bres	0x5218, #7
                                    677 ;	libs/i2c_lib.c: 134: uart_write("error addr\n"); //Очистка флага ошибки
      008357 AE 80 89         [ 2]  678 	ldw	x, #(___str_8+0)
      00835A CD 81 AA         [ 4]  679 	call	_uart_write
                                    680 ;	libs/i2c_lib.c: 126: for (uint8_t addr = 1; addr < 127; addr++)
      00835D 0C 02            [ 1]  681 	inc	(0x02, sp)
      00835F 7B 02            [ 1]  682 	ld	a, (0x02, sp)
      008361 6B 01            [ 1]  683 	ld	(0x01, sp), a
      008363 20 D7            [ 2]  684 	jra	00105$
      008365                        685 00103$:
                                    686 ;	libs/i2c_lib.c: 136: i2c_stop();
      008365 CD 82 68         [ 4]  687 	call	_i2c_stop
                                    688 ;	libs/i2c_lib.c: 137: return 0;
      008368 4F               [ 1]  689 	clr	a
      008369                        690 00107$:
                                    691 ;	libs/i2c_lib.c: 138: }
      008369 5B 02            [ 2]  692 	addw	sp, #2
      00836B 81               [ 4]  693 	ret
                                    694 ;	main.c: 3: int main(void)
                                    695 ;	-----------------------------------------
                                    696 ;	 function main
                                    697 ;	-----------------------------------------
      00836C                        698 _main:
      00836C 88               [ 1]  699 	push	a
                                    700 ;	main.c: 6: CLK_CKDIVR = 0;
      00836D 35 00 50 C6      [ 1]  701 	mov	0x50c6+0, #0x00
                                    702 ;	main.c: 7: uart_init(9600,0);
      008371 4F               [ 1]  703 	clr	a
      008372 AE 25 80         [ 2]  704 	ldw	x, #0x2580
      008375 CD 80 95         [ 4]  705 	call	_uart_init
                                    706 ;	main.c: 8: i2c_init();
      008378 CD 82 02         [ 4]  707 	call	_i2c_init
                                    708 ;	main.c: 9: i2c_scan();
      00837B CD 83 34         [ 4]  709 	call	_i2c_scan
                                    710 ;	main.c: 11: buf[0] = 0xA4;
      00837E A6 A4            [ 1]  711 	ld	a, #0xa4
      008380 6B 01            [ 1]  712 	ld	(0x01, sp), a
                                    713 ;	main.c: 12: i2c_write(I2C_DISPLAY_ADDR,1,buf);
      008382 96               [ 1]  714 	ldw	x, sp
      008383 5C               [ 1]  715 	incw	x
      008384 89               [ 2]  716 	pushw	x
      008385 4B 01            [ 1]  717 	push	#0x01
      008387 A6 3C            [ 1]  718 	ld	a, #0x3c
      008389 CD 82 A6         [ 4]  719 	call	_i2c_write
                                    720 ;	main.c: 13: for(int i = 0;i < 256;i++)
      00838C 5F               [ 1]  721 	clrw	x
      00838D                        722 00103$:
      00838D A3 01 00         [ 2]  723 	cpw	x, #0x0100
      008390 2E 14            [ 1]  724 	jrsge	00101$
                                    725 ;	main.c: 15: i2c_write(I2C_DISPLAY_ADDR,1,buf);
      008392 89               [ 2]  726 	pushw	x
      008393 90 96            [ 1]  727 	ldw	y, sp
      008395 72 A9 00 03      [ 2]  728 	addw	y, #3
      008399 90 89            [ 2]  729 	pushw	y
      00839B 4B 01            [ 1]  730 	push	#0x01
      00839D A6 3C            [ 1]  731 	ld	a, #0x3c
      00839F CD 82 A6         [ 4]  732 	call	_i2c_write
      0083A2 85               [ 2]  733 	popw	x
                                    734 ;	main.c: 13: for(int i = 0;i < 256;i++)
      0083A3 5C               [ 1]  735 	incw	x
      0083A4 20 E7            [ 2]  736 	jra	00103$
      0083A6                        737 00101$:
                                    738 ;	main.c: 17: return 0;
      0083A6 5F               [ 1]  739 	clrw	x
                                    740 ;	main.c: 18: }
      0083A7 84               [ 1]  741 	pop	a
      0083A8 81               [ 4]  742 	ret
                                    743 	.area CODE
                                    744 	.area CONST
                                    745 	.area CONST
      00802D                        746 ___str_0:
      00802D 73 74 61 72 74 20 73   747 	.ascii "start send byte"
             65 6E 64 20 62 79 74
             65
      00803C 0A                     748 	.db 0x0a
      00803D 00                     749 	.db 0x00
                                    750 	.area CODE
                                    751 	.area CONST
      00803E                        752 ___str_1:
      00803E 44 52 20 62 79 74 65   753 	.ascii "DR byte"
      008045 0A                     754 	.db 0x0a
      008046 00                     755 	.db 0x00
                                    756 	.area CODE
                                    757 	.area CONST
      008047                        758 ___str_2:
      008047 57 48 49 4C 45 20 73   759 	.ascii "WHILE start"
             74 61 72 74
      008052 0A                     760 	.db 0x0a
      008053 00                     761 	.db 0x00
                                    762 	.area CODE
                                    763 	.area CONST
      008054                        764 ___str_3:
      008054 57 48 49 4C 45 20 70   765 	.ascii "WHILE passed"
             61 73 73 65 64
      008060 0A                     766 	.db 0x0a
      008061 00                     767 	.db 0x00
                                    768 	.area CODE
                                    769 	.area CONST
      008062                        770 ___str_4:
      008062 50 49 56 4F            771 	.ascii "PIVO"
      008066 0A                     772 	.db 0x0a
      008067 00                     773 	.db 0x00
                                    774 	.area CODE
                                    775 	.area CONST
      008068                        776 ___str_5:
      008068 66 6F 72               777 	.ascii "for"
      00806B 0A                     778 	.db 0x0a
      00806C 00                     779 	.db 0x00
                                    780 	.area CODE
                                    781 	.area CONST
      00806D                        782 ___str_6:
      00806D 65 72 72 6F 72 20 73   783 	.ascii "error send byte"
             65 6E 64 20 62 79 74
             65
      00807C 0A                     784 	.db 0x0a
      00807D 00                     785 	.db 0x00
                                    786 	.area CODE
                                    787 	.area CONST
      00807E                        788 ___str_7:
      00807E 69 66 20 70 61 73 73   789 	.ascii "if passed"
             65 64
      008087 0A                     790 	.db 0x0a
      008088 00                     791 	.db 0x00
                                    792 	.area CODE
                                    793 	.area CONST
      008089                        794 ___str_8:
      008089 65 72 72 6F 72 20 61   795 	.ascii "error addr"
             64 64 72
      008093 0A                     796 	.db 0x0a
      008094 00                     797 	.db 0x00
                                    798 	.area CODE
                                    799 	.area INITIALIZER
                                    800 	.area CABS (ABS)
