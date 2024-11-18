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
      008007 CD 83 7D         [ 4]   69 	call	___sdcc_external_startup
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
      008021 D6 80 7B         [ 1]   85 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 83 39         [ 2]   99 	jp	_main
                                    100 ;	return from main will return to caller
                                    101 ;--------------------------------------------------------
                                    102 ; code
                                    103 ;--------------------------------------------------------
                                    104 	.area CODE
                                    105 ;	libs/uart_lib.c: 3: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    106 ;	-----------------------------------------
                                    107 ;	 function uart_init
                                    108 ;	-----------------------------------------
      00807C                        109 _uart_init:
      00807C 52 02            [ 2]  110 	sub	sp, #2
      00807E 1F 01            [ 2]  111 	ldw	(0x01, sp), x
                                    112 ;	libs/uart_lib.c: 7: UART1_CR2 -> TEN = 1; // Transmitter enable
      008080 AE 52 35         [ 2]  113 	ldw	x, #0x5235
      008083 88               [ 1]  114 	push	a
      008084 F6               [ 1]  115 	ld	a, (x)
      008085 AA 08            [ 1]  116 	or	a, #0x08
      008087 F7               [ 1]  117 	ld	(x), a
      008088 84               [ 1]  118 	pop	a
                                    119 ;	libs/uart_lib.c: 8: UART1_CR2 -> REN = 1; // Receiver enable
      008089 AE 52 35         [ 2]  120 	ldw	x, #0x5235
      00808C 88               [ 1]  121 	push	a
      00808D F6               [ 1]  122 	ld	a, (x)
      00808E AA 04            [ 1]  123 	or	a, #0x04
      008090 F7               [ 1]  124 	ld	(x), a
      008091 84               [ 1]  125 	pop	a
                                    126 ;	libs/uart_lib.c: 9: switch(stopbit)
      008092 A1 02            [ 1]  127 	cp	a, #0x02
      008094 27 06            [ 1]  128 	jreq	00101$
      008096 A1 03            [ 1]  129 	cp	a, #0x03
      008098 27 0E            [ 1]  130 	jreq	00102$
      00809A 20 16            [ 2]  131 	jra	00103$
                                    132 ;	libs/uart_lib.c: 11: case 2:
      00809C                        133 00101$:
                                    134 ;	libs/uart_lib.c: 12: UART1_CR3 -> STOP = 2;
      00809C C6 52 36         [ 1]  135 	ld	a, 0x5236
      00809F A4 CF            [ 1]  136 	and	a, #0xcf
      0080A1 AA 20            [ 1]  137 	or	a, #0x20
      0080A3 C7 52 36         [ 1]  138 	ld	0x5236, a
                                    139 ;	libs/uart_lib.c: 13: break;
      0080A6 20 12            [ 2]  140 	jra	00104$
                                    141 ;	libs/uart_lib.c: 14: case 3:
      0080A8                        142 00102$:
                                    143 ;	libs/uart_lib.c: 15: UART1_CR3 -> STOP = 3;
      0080A8 C6 52 36         [ 1]  144 	ld	a, 0x5236
      0080AB AA 30            [ 1]  145 	or	a, #0x30
      0080AD C7 52 36         [ 1]  146 	ld	0x5236, a
                                    147 ;	libs/uart_lib.c: 16: break;
      0080B0 20 08            [ 2]  148 	jra	00104$
                                    149 ;	libs/uart_lib.c: 17: default:
      0080B2                        150 00103$:
                                    151 ;	libs/uart_lib.c: 18: UART1_CR3 -> STOP = 0;
      0080B2 C6 52 36         [ 1]  152 	ld	a, 0x5236
      0080B5 A4 CF            [ 1]  153 	and	a, #0xcf
      0080B7 C7 52 36         [ 1]  154 	ld	0x5236, a
                                    155 ;	libs/uart_lib.c: 20: }
      0080BA                        156 00104$:
                                    157 ;	libs/uart_lib.c: 21: switch(baudrate)
      0080BA 1E 01            [ 2]  158 	ldw	x, (0x01, sp)
      0080BC A3 08 00         [ 2]  159 	cpw	x, #0x0800
      0080BF 26 03            [ 1]  160 	jrne	00186$
      0080C1 CC 81 4D         [ 2]  161 	jp	00110$
      0080C4                        162 00186$:
      0080C4 1E 01            [ 2]  163 	ldw	x, (0x01, sp)
      0080C6 A3 09 60         [ 2]  164 	cpw	x, #0x0960
      0080C9 27 28            [ 1]  165 	jreq	00105$
      0080CB 1E 01            [ 2]  166 	ldw	x, (0x01, sp)
      0080CD A3 10 00         [ 2]  167 	cpw	x, #0x1000
      0080D0 26 03            [ 1]  168 	jrne	00192$
      0080D2 CC 81 5D         [ 2]  169 	jp	00111$
      0080D5                        170 00192$:
      0080D5 1E 01            [ 2]  171 	ldw	x, (0x01, sp)
      0080D7 A3 4B 00         [ 2]  172 	cpw	x, #0x4b00
      0080DA 27 31            [ 1]  173 	jreq	00106$
      0080DC 1E 01            [ 2]  174 	ldw	x, (0x01, sp)
      0080DE A3 84 00         [ 2]  175 	cpw	x, #0x8400
      0080E1 27 5A            [ 1]  176 	jreq	00109$
      0080E3 1E 01            [ 2]  177 	ldw	x, (0x01, sp)
      0080E5 A3 C2 00         [ 2]  178 	cpw	x, #0xc200
      0080E8 27 43            [ 1]  179 	jreq	00108$
      0080EA 1E 01            [ 2]  180 	ldw	x, (0x01, sp)
      0080EC A3 E1 00         [ 2]  181 	cpw	x, #0xe100
      0080EF 27 2C            [ 1]  182 	jreq	00107$
      0080F1 20 7A            [ 2]  183 	jra	00112$
                                    184 ;	libs/uart_lib.c: 23: case (unsigned int)2400:
      0080F3                        185 00105$:
                                    186 ;	libs/uart_lib.c: 24: UART1_BRR2 -> MSB = 0x01;
      0080F3 C6 52 33         [ 1]  187 	ld	a, 0x5233
      0080F6 A4 0F            [ 1]  188 	and	a, #0x0f
      0080F8 AA 10            [ 1]  189 	or	a, #0x10
      0080FA C7 52 33         [ 1]  190 	ld	0x5233, a
                                    191 ;	libs/uart_lib.c: 25: UART1_BRR1 -> DIV = 0xA0;
      0080FD 35 A0 52 32      [ 1]  192 	mov	0x5232+0, #0xa0
                                    193 ;	libs/uart_lib.c: 26: UART1_BRR2 -> LSB = 0x0B; 
      008101 C6 52 33         [ 1]  194 	ld	a, 0x5233
      008104 A4 F0            [ 1]  195 	and	a, #0xf0
      008106 AA 0B            [ 1]  196 	or	a, #0x0b
      008108 C7 52 33         [ 1]  197 	ld	0x5233, a
                                    198 ;	libs/uart_lib.c: 27: break;
      00810B 20 6E            [ 2]  199 	jra	00114$
                                    200 ;	libs/uart_lib.c: 28: case (unsigned int)19200:
      00810D                        201 00106$:
                                    202 ;	libs/uart_lib.c: 29: UART1_BRR1 -> DIV = 0x34;
      00810D 35 34 52 32      [ 1]  203 	mov	0x5232+0, #0x34
                                    204 ;	libs/uart_lib.c: 30: UART1_BRR2 -> LSB = 0x01;
      008111 C6 52 33         [ 1]  205 	ld	a, 0x5233
      008114 A4 F0            [ 1]  206 	and	a, #0xf0
      008116 AA 01            [ 1]  207 	or	a, #0x01
      008118 C7 52 33         [ 1]  208 	ld	0x5233, a
                                    209 ;	libs/uart_lib.c: 31: break;
      00811B 20 5E            [ 2]  210 	jra	00114$
                                    211 ;	libs/uart_lib.c: 32: case (unsigned int)57600:
      00811D                        212 00107$:
                                    213 ;	libs/uart_lib.c: 33: UART1_BRR1 -> DIV = 0x11;
      00811D 35 11 52 32      [ 1]  214 	mov	0x5232+0, #0x11
                                    215 ;	libs/uart_lib.c: 34: UART1_BRR2 -> LSB = 0x06;
      008121 C6 52 33         [ 1]  216 	ld	a, 0x5233
      008124 A4 F0            [ 1]  217 	and	a, #0xf0
      008126 AA 06            [ 1]  218 	or	a, #0x06
      008128 C7 52 33         [ 1]  219 	ld	0x5233, a
                                    220 ;	libs/uart_lib.c: 35: break;
      00812B 20 4E            [ 2]  221 	jra	00114$
                                    222 ;	libs/uart_lib.c: 36: case (unsigned int)115200:
      00812D                        223 00108$:
                                    224 ;	libs/uart_lib.c: 37: UART1_BRR1 -> DIV = 0x08;
      00812D 35 08 52 32      [ 1]  225 	mov	0x5232+0, #0x08
                                    226 ;	libs/uart_lib.c: 38: UART1_BRR2 -> LSB = 0x0B;
      008131 C6 52 33         [ 1]  227 	ld	a, 0x5233
      008134 A4 F0            [ 1]  228 	and	a, #0xf0
      008136 AA 0B            [ 1]  229 	or	a, #0x0b
      008138 C7 52 33         [ 1]  230 	ld	0x5233, a
                                    231 ;	libs/uart_lib.c: 39: break;
      00813B 20 3E            [ 2]  232 	jra	00114$
                                    233 ;	libs/uart_lib.c: 40: case (unsigned int)230400:
      00813D                        234 00109$:
                                    235 ;	libs/uart_lib.c: 41: UART1_BRR1 -> DIV = 0x04;
      00813D 35 04 52 32      [ 1]  236 	mov	0x5232+0, #0x04
                                    237 ;	libs/uart_lib.c: 42: UART1_BRR2 -> LSB = 0x05;
      008141 C6 52 33         [ 1]  238 	ld	a, 0x5233
      008144 A4 F0            [ 1]  239 	and	a, #0xf0
      008146 AA 05            [ 1]  240 	or	a, #0x05
      008148 C7 52 33         [ 1]  241 	ld	0x5233, a
                                    242 ;	libs/uart_lib.c: 43: break;
      00814B 20 2E            [ 2]  243 	jra	00114$
                                    244 ;	libs/uart_lib.c: 44: case (unsigned int)460800:
      00814D                        245 00110$:
                                    246 ;	libs/uart_lib.c: 45: UART1_BRR1 -> DIV = 0x02;
      00814D 35 02 52 32      [ 1]  247 	mov	0x5232+0, #0x02
                                    248 ;	libs/uart_lib.c: 46: UART1_BRR2 -> LSB = 0x03;
      008151 C6 52 33         [ 1]  249 	ld	a, 0x5233
      008154 A4 F0            [ 1]  250 	and	a, #0xf0
      008156 AA 03            [ 1]  251 	or	a, #0x03
      008158 C7 52 33         [ 1]  252 	ld	0x5233, a
                                    253 ;	libs/uart_lib.c: 47: break;
      00815B 20 1E            [ 2]  254 	jra	00114$
                                    255 ;	libs/uart_lib.c: 48: case (unsigned int)921600:
      00815D                        256 00111$:
                                    257 ;	libs/uart_lib.c: 49: UART1_BRR1 -> DIV = 0x01;
      00815D 35 01 52 32      [ 1]  258 	mov	0x5232+0, #0x01
                                    259 ;	libs/uart_lib.c: 50: UART1_BRR2 -> LSB = 0x01;
      008161 C6 52 33         [ 1]  260 	ld	a, 0x5233
      008164 A4 F0            [ 1]  261 	and	a, #0xf0
      008166 AA 01            [ 1]  262 	or	a, #0x01
      008168 C7 52 33         [ 1]  263 	ld	0x5233, a
                                    264 ;	libs/uart_lib.c: 51: break;
      00816B 20 0E            [ 2]  265 	jra	00114$
                                    266 ;	libs/uart_lib.c: 52: default:
      00816D                        267 00112$:
                                    268 ;	libs/uart_lib.c: 53: UART1_BRR1 -> DIV = 0x68;
      00816D 35 68 52 32      [ 1]  269 	mov	0x5232+0, #0x68
                                    270 ;	libs/uart_lib.c: 54: UART1_BRR2 -> LSB = 0x03;
      008171 C6 52 33         [ 1]  271 	ld	a, 0x5233
      008174 A4 F0            [ 1]  272 	and	a, #0xf0
      008176 AA 03            [ 1]  273 	or	a, #0x03
      008178 C7 52 33         [ 1]  274 	ld	0x5233, a
                                    275 ;	libs/uart_lib.c: 56: }
      00817B                        276 00114$:
                                    277 ;	libs/uart_lib.c: 57: }
      00817B 5B 02            [ 2]  278 	addw	sp, #2
      00817D 81               [ 4]  279 	ret
                                    280 ;	libs/uart_lib.c: 59: int uart_read_byte(uint8_t *data)
                                    281 ;	-----------------------------------------
                                    282 ;	 function uart_read_byte
                                    283 ;	-----------------------------------------
      00817E                        284 _uart_read_byte:
                                    285 ;	libs/uart_lib.c: 61: while(!(UART1_SR -> RXNE));
      00817E                        286 00101$:
      00817E 72 0B 52 30 FB   [ 2]  287 	btjf	0x5230, #5, 00101$
                                    288 ;	libs/uart_lib.c: 63: return 1;
      008183 5F               [ 1]  289 	clrw	x
      008184 5C               [ 1]  290 	incw	x
                                    291 ;	libs/uart_lib.c: 64: }
      008185 81               [ 4]  292 	ret
                                    293 ;	libs/uart_lib.c: 66: int uart_write_byte(uint8_t data)
                                    294 ;	-----------------------------------------
                                    295 ;	 function uart_write_byte
                                    296 ;	-----------------------------------------
      008186                        297 _uart_write_byte:
                                    298 ;	libs/uart_lib.c: 68: UART1_DR -> DR = data;
      008186 C7 52 31         [ 1]  299 	ld	0x5231, a
                                    300 ;	libs/uart_lib.c: 69: while(!(UART1_SR -> TXE));
      008189                        301 00101$:
      008189 72 0F 52 30 FB   [ 2]  302 	btjf	0x5230, #7, 00101$
                                    303 ;	libs/uart_lib.c: 70: return 1;
      00818E 5F               [ 1]  304 	clrw	x
      00818F 5C               [ 1]  305 	incw	x
                                    306 ;	libs/uart_lib.c: 71: }
      008190 81               [ 4]  307 	ret
                                    308 ;	libs/uart_lib.c: 73: int uart_write(uint8_t *data_buf)
                                    309 ;	-----------------------------------------
                                    310 ;	 function uart_write
                                    311 ;	-----------------------------------------
      008191                        312 _uart_write:
      008191 52 04            [ 2]  313 	sub	sp, #4
      008193 1F 01            [ 2]  314 	ldw	(0x01, sp), x
                                    315 ;	libs/uart_lib.c: 75: int count = 0;
      008195 5F               [ 1]  316 	clrw	x
      008196 1F 03            [ 2]  317 	ldw	(0x03, sp), x
                                    318 ;	libs/uart_lib.c: 76: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      008198 5F               [ 1]  319 	clrw	x
      008199                        320 00103$:
      008199 90 93            [ 1]  321 	ldw	y, x
      00819B 72 F9 01         [ 2]  322 	addw	y, (0x01, sp)
      00819E 90 F6            [ 1]  323 	ld	a, (y)
      0081A0 27 0E            [ 1]  324 	jreq	00101$
                                    325 ;	libs/uart_lib.c: 77: count += uart_write_byte(data_buf[i]);
      0081A2 89               [ 2]  326 	pushw	x
      0081A3 CD 81 86         [ 4]  327 	call	_uart_write_byte
      0081A6 51               [ 1]  328 	exgw	x, y
      0081A7 85               [ 2]  329 	popw	x
      0081A8 72 F9 03         [ 2]  330 	addw	y, (0x03, sp)
      0081AB 17 03            [ 2]  331 	ldw	(0x03, sp), y
                                    332 ;	libs/uart_lib.c: 76: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081AD 5C               [ 1]  333 	incw	x
      0081AE 20 E9            [ 2]  334 	jra	00103$
      0081B0                        335 00101$:
                                    336 ;	libs/uart_lib.c: 78: return count;
      0081B0 1E 03            [ 2]  337 	ldw	x, (0x03, sp)
                                    338 ;	libs/uart_lib.c: 79: }
      0081B2 5B 04            [ 2]  339 	addw	sp, #4
      0081B4 81               [ 4]  340 	ret
                                    341 ;	libs/uart_lib.c: 80: int uart_read(uint8_t *data_buf)
                                    342 ;	-----------------------------------------
                                    343 ;	 function uart_read
                                    344 ;	-----------------------------------------
      0081B5                        345 _uart_read:
      0081B5 52 04            [ 2]  346 	sub	sp, #4
      0081B7 1F 01            [ 2]  347 	ldw	(0x01, sp), x
                                    348 ;	libs/uart_lib.c: 82: int count = 0;
      0081B9 5F               [ 1]  349 	clrw	x
      0081BA 1F 03            [ 2]  350 	ldw	(0x03, sp), x
                                    351 ;	libs/uart_lib.c: 83: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081BC 5F               [ 1]  352 	clrw	x
      0081BD                        353 00103$:
      0081BD 90 93            [ 1]  354 	ldw	y, x
      0081BF 72 F9 01         [ 2]  355 	addw	y, (0x01, sp)
      0081C2 90 F6            [ 1]  356 	ld	a, (y)
      0081C4 27 13            [ 1]  357 	jreq	00101$
                                    358 ;	libs/uart_lib.c: 84: count += uart_read_byte((unsigned char *)data_buf[i]);
      0081C6 90 5F            [ 1]  359 	clrw	y
      0081C8 90 97            [ 1]  360 	ld	yl, a
      0081CA 89               [ 2]  361 	pushw	x
      0081CB 93               [ 1]  362 	ldw	x, y
      0081CC CD 81 7E         [ 4]  363 	call	_uart_read_byte
      0081CF 51               [ 1]  364 	exgw	x, y
      0081D0 85               [ 2]  365 	popw	x
      0081D1 72 F9 03         [ 2]  366 	addw	y, (0x03, sp)
      0081D4 17 03            [ 2]  367 	ldw	(0x03, sp), y
                                    368 ;	libs/uart_lib.c: 83: for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
      0081D6 5C               [ 1]  369 	incw	x
      0081D7 20 E4            [ 2]  370 	jra	00103$
      0081D9                        371 00101$:
                                    372 ;	libs/uart_lib.c: 85: return count;
      0081D9 1E 03            [ 2]  373 	ldw	x, (0x03, sp)
                                    374 ;	libs/uart_lib.c: 86: }
      0081DB 5B 04            [ 2]  375 	addw	sp, #4
      0081DD 81               [ 4]  376 	ret
                                    377 ;	libs/i2c_lib.c: 10: void delay(uint16_t ticks)
                                    378 ;	-----------------------------------------
                                    379 ;	 function delay
                                    380 ;	-----------------------------------------
      0081DE                        381 _delay:
                                    382 ;	libs/i2c_lib.c: 12: while(ticks > 0)
      0081DE                        383 00101$:
      0081DE 5D               [ 2]  384 	tnzw	x
      0081DF 26 01            [ 1]  385 	jrne	00120$
      0081E1 81               [ 4]  386 	ret
      0081E2                        387 00120$:
                                    388 ;	libs/i2c_lib.c: 14: ticks-=2;
      0081E2 5A               [ 2]  389 	decw	x
      0081E3 5A               [ 2]  390 	decw	x
                                    391 ;	libs/i2c_lib.c: 15: ticks+=1;
      0081E4 5C               [ 1]  392 	incw	x
      0081E5 20 F7            [ 2]  393 	jra	00101$
                                    394 ;	libs/i2c_lib.c: 17: }
      0081E7 81               [ 4]  395 	ret
                                    396 ;	libs/i2c_lib.c: 18: void trash_clean(void)
                                    397 ;	-----------------------------------------
                                    398 ;	 function trash_clean
                                    399 ;	-----------------------------------------
      0081E8                        400 _trash_clean:
                                    401 ;	libs/i2c_lib.c: 23: trash_reg = (unsigned char)I2C_SR3;
                                    402 ;	libs/i2c_lib.c: 24: }
      0081E8 81               [ 4]  403 	ret
                                    404 ;	libs/i2c_lib.c: 25: void i2c_init(void) {
                                    405 ;	-----------------------------------------
                                    406 ;	 function i2c_init
                                    407 ;	-----------------------------------------
      0081E9                        408 _i2c_init:
                                    409 ;	libs/i2c_lib.c: 28: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      0081E9 72 11 52 10      [ 1]  410 	bres	0x5210, #0
                                    411 ;	libs/i2c_lib.c: 29: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      0081ED C6 52 12         [ 1]  412 	ld	a, 0x5212
      0081F0 A4 C0            [ 1]  413 	and	a, #0xc0
      0081F2 AA 10            [ 1]  414 	or	a, #0x10
      0081F4 C7 52 12         [ 1]  415 	ld	0x5212, a
                                    416 ;	libs/i2c_lib.c: 30: I2C_CCRH -> CCR = 0;// =0
      0081F7 C6 52 1C         [ 1]  417 	ld	a, 0x521c
      0081FA A4 F0            [ 1]  418 	and	a, #0xf0
      0081FC C7 52 1C         [ 1]  419 	ld	0x521c, a
                                    420 ;	libs/i2c_lib.c: 31: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0081FF 35 50 52 1B      [ 1]  421 	mov	0x521b+0, #0x50
                                    422 ;	libs/i2c_lib.c: 32: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      008203 72 1F 52 1C      [ 1]  423 	bres	0x521c, #7
                                    424 ;	libs/i2c_lib.c: 33: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      008207 72 1F 52 14      [ 1]  425 	bres	0x5214, #7
                                    426 ;	libs/i2c_lib.c: 34: I2C_OARH -> ADDCONF = 1;// see reference manual
      00820B 72 10 52 14      [ 1]  427 	bset	0x5214, #0
                                    428 ;	libs/i2c_lib.c: 35: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      00820F 72 10 52 10      [ 1]  429 	bset	0x5210, #0
                                    430 ;	libs/i2c_lib.c: 36: }
      008213 81               [ 4]  431 	ret
                                    432 ;	libs/i2c_lib.c: 38: void i2c_start(void) {
                                    433 ;	-----------------------------------------
                                    434 ;	 function i2c_start
                                    435 ;	-----------------------------------------
      008214                        436 _i2c_start:
                                    437 ;	libs/i2c_lib.c: 39: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
      008214 72 10 52 11      [ 1]  438 	bset	0x5211, #0
                                    439 ;	libs/i2c_lib.c: 40: while(!(I2C_SR1 -> SB));// Ожидание отправки стартового сигнала
      008218                        440 00101$:
      008218 72 01 52 17 FB   [ 2]  441 	btjf	0x5217, #0, 00101$
                                    442 ;	libs/i2c_lib.c: 41: }
      00821D 81               [ 4]  443 	ret
                                    444 ;	libs/i2c_lib.c: 43: uint8_t i2c_send_byte(unsigned char data){
                                    445 ;	-----------------------------------------
                                    446 ;	 function i2c_send_byte
                                    447 ;	-----------------------------------------
      00821E                        448 _i2c_send_byte:
      00821E 88               [ 1]  449 	push	a
      00821F 6B 01            [ 1]  450 	ld	(0x01, sp), a
                                    451 ;	libs/i2c_lib.c: 44: uart_write("start send byte\n");
      008221 AE 80 2D         [ 2]  452 	ldw	x, #(___str_0+0)
      008224 CD 81 91         [ 4]  453 	call	_uart_write
                                    454 ;	libs/i2c_lib.c: 45: while (!(I2C_SR1 -> TXE));
      008227                        455 00101$:
      008227 72 0F 52 17 FB   [ 2]  456 	btjf	0x5217, #7, 00101$
                                    457 ;	libs/i2c_lib.c: 46: uart_write("while passed\n");
      00822C AE 80 3E         [ 2]  458 	ldw	x, #(___str_1+0)
      00822F CD 81 91         [ 4]  459 	call	_uart_write
                                    460 ;	libs/i2c_lib.c: 47: I2C_DR -> DR = data;
      008232 AE 52 16         [ 2]  461 	ldw	x, #0x5216
      008235 7B 01            [ 1]  462 	ld	a, (0x01, sp)
      008237 F7               [ 1]  463 	ld	(x), a
                                    464 ;	libs/i2c_lib.c: 49: uart_write("DR byte\n");
      008238 AE 80 4C         [ 2]  465 	ldw	x, #(___str_2+0)
      00823B CD 81 91         [ 4]  466 	call	_uart_write
                                    467 ;	libs/i2c_lib.c: 50: int result = I2C_SR2 -> AF;
      00823E C6 52 18         [ 1]  468 	ld	a, 0x5218
      008241 4E               [ 1]  469 	swap	a
      008242 44               [ 1]  470 	srl	a
      008243 44               [ 1]  471 	srl	a
      008244 44               [ 1]  472 	srl	a
      008245 A4 01            [ 1]  473 	and	a, #0x01
                                    474 ;	libs/i2c_lib.c: 51: return result;
                                    475 ;	libs/i2c_lib.c: 52: }
      008247 5B 01            [ 2]  476 	addw	sp, #1
      008249 81               [ 4]  477 	ret
                                    478 ;	libs/i2c_lib.c: 54: uint8_t i2c_read_byte(unsigned char *data){
                                    479 ;	-----------------------------------------
                                    480 ;	 function i2c_read_byte
                                    481 ;	-----------------------------------------
      00824A                        482 _i2c_read_byte:
                                    483 ;	libs/i2c_lib.c: 55: while (!(I2C_SR1 -> RXNE));
      00824A                        484 00101$:
      00824A 72 0D 52 17 FB   [ 2]  485 	btjf	0x5217, #6, 00101$
                                    486 ;	libs/i2c_lib.c: 57: return 0;
      00824F 4F               [ 1]  487 	clr	a
                                    488 ;	libs/i2c_lib.c: 59: }
      008250 81               [ 4]  489 	ret
                                    490 ;	libs/i2c_lib.c: 61: void i2c_stop(void) {
                                    491 ;	-----------------------------------------
                                    492 ;	 function i2c_stop
                                    493 ;	-----------------------------------------
      008251                        494 _i2c_stop:
                                    495 ;	libs/i2c_lib.c: 62: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
      008251 72 12 52 11      [ 1]  496 	bset	0x5211, #1
                                    497 ;	libs/i2c_lib.c: 63: }
      008255 81               [ 4]  498 	ret
                                    499 ;	libs/i2c_lib.c: 66: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    500 ;	-----------------------------------------
                                    501 ;	 function i2c_send_address
                                    502 ;	-----------------------------------------
      008256                        503 _i2c_send_address:
                                    504 ;	libs/i2c_lib.c: 68: i2c_start();
      008256 88               [ 1]  505 	push	a
      008257 CD 82 14         [ 4]  506 	call	_i2c_start
      00825A 84               [ 1]  507 	pop	a
                                    508 ;	libs/i2c_lib.c: 72: address = address << 1;
      00825B 48               [ 1]  509 	sll	a
                                    510 ;	libs/i2c_lib.c: 69: switch(rw_type)
      00825C 88               [ 1]  511 	push	a
      00825D 7B 04            [ 1]  512 	ld	a, (0x04, sp)
      00825F 4A               [ 1]  513 	dec	a
      008260 84               [ 1]  514 	pop	a
      008261 26 02            [ 1]  515 	jrne	00102$
                                    516 ;	libs/i2c_lib.c: 72: address = address << 1;
                                    517 ;	libs/i2c_lib.c: 73: address |= 0x01; // Отправка адреса устройства с битом на чтение
      008263 AA 01            [ 1]  518 	or	a, #0x01
                                    519 ;	libs/i2c_lib.c: 74: break;
                                    520 ;	libs/i2c_lib.c: 75: default:
                                    521 ;	libs/i2c_lib.c: 76: address = address << 1; // Отправка адреса устройства с битом на запись
                                    522 ;	libs/i2c_lib.c: 78: }
      008265                        523 00102$:
                                    524 ;	libs/i2c_lib.c: 79: I2C_DR -> DR = address;//Отправка адреса
      008265 C7 52 16         [ 1]  525 	ld	0x5216, a
                                    526 ;	libs/i2c_lib.c: 80: delay(250);
      008268 AE 00 FA         [ 2]  527 	ldw	x, #0x00fa
      00826B CD 81 DE         [ 4]  528 	call	_delay
                                    529 ;	libs/i2c_lib.c: 82: int result = I2C_SR1 -> ADDR;
      00826E C6 52 17         [ 1]  530 	ld	a, 0x5217
      008271 44               [ 1]  531 	srl	a
      008272 A4 01            [ 1]  532 	and	a, #0x01
                                    533 ;	libs/i2c_lib.c: 83: return result;
                                    534 ;	libs/i2c_lib.c: 84: }
      008274 85               [ 2]  535 	popw	x
      008275 5B 01            [ 2]  536 	addw	sp, #1
      008277 FC               [ 2]  537 	jp	(x)
                                    538 ;	libs/i2c_lib.c: 86: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    539 ;	-----------------------------------------
                                    540 ;	 function i2c_write
                                    541 ;	-----------------------------------------
      008278                        542 _i2c_write:
      008278 52 04            [ 2]  543 	sub	sp, #4
                                    544 ;	libs/i2c_lib.c: 88: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      00827A 4B 00            [ 1]  545 	push	#0x00
      00827C CD 82 56         [ 4]  546 	call	_i2c_send_address
      00827F 4D               [ 1]  547 	tnz	a
      008280 27 3C            [ 1]  548 	jreq	00105$
                                    549 ;	libs/i2c_lib.c: 90: uart_write("PIVO\n");
      008282 AE 80 55         [ 2]  550 	ldw	x, #(___str_3+0)
      008285 CD 81 91         [ 4]  551 	call	_uart_write
                                    552 ;	libs/i2c_lib.c: 91: for(int i = 0;i < size;i++)
      008288 5F               [ 1]  553 	clrw	x
      008289 1F 03            [ 2]  554 	ldw	(0x03, sp), x
      00828B                        555 00107$:
      00828B 7B 07            [ 1]  556 	ld	a, (0x07, sp)
      00828D 6B 02            [ 1]  557 	ld	(0x02, sp), a
      00828F 0F 01            [ 1]  558 	clr	(0x01, sp)
      008291 1E 03            [ 2]  559 	ldw	x, (0x03, sp)
      008293 13 01            [ 2]  560 	cpw	x, (0x01, sp)
      008295 2E 27            [ 1]  561 	jrsge	00105$
                                    562 ;	libs/i2c_lib.c: 93: uart_write("for\n");
      008297 AE 80 5B         [ 2]  563 	ldw	x, #(___str_4+0)
      00829A CD 81 91         [ 4]  564 	call	_uart_write
                                    565 ;	libs/i2c_lib.c: 94: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      00829D 1E 08            [ 2]  566 	ldw	x, (0x08, sp)
      00829F 72 FB 03         [ 2]  567 	addw	x, (0x03, sp)
      0082A2 F6               [ 1]  568 	ld	a, (x)
      0082A3 CD 82 1E         [ 4]  569 	call	_i2c_send_byte
      0082A6 4D               [ 1]  570 	tnz	a
      0082A7 27 08            [ 1]  571 	jreq	00102$
                                    572 ;	libs/i2c_lib.c: 96: uart_write("error send byte\n");
      0082A9 AE 80 60         [ 2]  573 	ldw	x, #(___str_5+0)
      0082AC CD 81 91         [ 4]  574 	call	_uart_write
                                    575 ;	libs/i2c_lib.c: 97: break;
      0082AF 20 0D            [ 2]  576 	jra	00105$
      0082B1                        577 00102$:
                                    578 ;	libs/i2c_lib.c: 99: uart_write("if passed\n");    
      0082B1 AE 80 71         [ 2]  579 	ldw	x, #(___str_6+0)
      0082B4 CD 81 91         [ 4]  580 	call	_uart_write
                                    581 ;	libs/i2c_lib.c: 91: for(int i = 0;i < size;i++)
      0082B7 1E 03            [ 2]  582 	ldw	x, (0x03, sp)
      0082B9 5C               [ 1]  583 	incw	x
      0082BA 1F 03            [ 2]  584 	ldw	(0x03, sp), x
      0082BC 20 CD            [ 2]  585 	jra	00107$
      0082BE                        586 00105$:
                                    587 ;	libs/i2c_lib.c: 102: i2c_stop();
      0082BE 1E 05            [ 2]  588 	ldw	x, (5, sp)
      0082C0 1F 08            [ 2]  589 	ldw	(8, sp), x
      0082C2 5B 07            [ 2]  590 	addw	sp, #7
                                    591 ;	libs/i2c_lib.c: 103: }
      0082C4 CC 82 51         [ 2]  592 	jp	_i2c_stop
                                    593 ;	libs/i2c_lib.c: 105: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
                                    594 ;	-----------------------------------------
                                    595 ;	 function i2c_read
                                    596 ;	-----------------------------------------
      0082C7                        597 _i2c_read:
      0082C7 52 02            [ 2]  598 	sub	sp, #2
                                    599 ;	libs/i2c_lib.c: 106: I2C_CR2 -> ACK = 1;
      0082C9 AE 52 11         [ 2]  600 	ldw	x, #0x5211
      0082CC 88               [ 1]  601 	push	a
      0082CD F6               [ 1]  602 	ld	a, (x)
      0082CE AA 04            [ 1]  603 	or	a, #0x04
      0082D0 F7               [ 1]  604 	ld	(x), a
      0082D1 84               [ 1]  605 	pop	a
                                    606 ;	libs/i2c_lib.c: 107: if(i2c_send_address(dev_addr,1))
      0082D2 4B 01            [ 1]  607 	push	#0x01
      0082D4 CD 82 56         [ 4]  608 	call	_i2c_send_address
      0082D7 4D               [ 1]  609 	tnz	a
      0082D8 27 1F            [ 1]  610 	jreq	00103$
                                    611 ;	libs/i2c_lib.c: 108: for(int i = 0;i < size;i++)
      0082DA 5F               [ 1]  612 	clrw	x
      0082DB                        613 00105$:
      0082DB 7B 05            [ 1]  614 	ld	a, (0x05, sp)
      0082DD 6B 02            [ 1]  615 	ld	(0x02, sp), a
      0082DF 0F 01            [ 1]  616 	clr	(0x01, sp)
      0082E1 13 01            [ 2]  617 	cpw	x, (0x01, sp)
      0082E3 2E 14            [ 1]  618 	jrsge	00103$
                                    619 ;	libs/i2c_lib.c: 110: i2c_read_byte((unsigned char *)data[i]);
      0082E5 90 93            [ 1]  620 	ldw	y, x
      0082E7 72 F9 06         [ 2]  621 	addw	y, (0x06, sp)
      0082EA 90 F6            [ 1]  622 	ld	a, (y)
      0082EC 90 5F            [ 1]  623 	clrw	y
      0082EE 90 97            [ 1]  624 	ld	yl, a
      0082F0 89               [ 2]  625 	pushw	x
      0082F1 93               [ 1]  626 	ldw	x, y
      0082F2 CD 82 4A         [ 4]  627 	call	_i2c_read_byte
      0082F5 85               [ 2]  628 	popw	x
                                    629 ;	libs/i2c_lib.c: 108: for(int i = 0;i < size;i++)
      0082F6 5C               [ 1]  630 	incw	x
      0082F7 20 E2            [ 2]  631 	jra	00105$
      0082F9                        632 00103$:
                                    633 ;	libs/i2c_lib.c: 112: I2C_CR2 -> ACK = 0;
      0082F9 C6 52 11         [ 1]  634 	ld	a, 0x5211
      0082FC A4 FB            [ 1]  635 	and	a, #0xfb
      0082FE C7 52 11         [ 1]  636 	ld	0x5211, a
                                    637 ;	libs/i2c_lib.c: 113: }
      008301 1E 03            [ 2]  638 	ldw	x, (3, sp)
      008303 5B 07            [ 2]  639 	addw	sp, #7
      008305 FC               [ 2]  640 	jp	(x)
                                    641 ;	libs/i2c_lib.c: 114: uint8_t i2c_scan(void) 
                                    642 ;	-----------------------------------------
                                    643 ;	 function i2c_scan
                                    644 ;	-----------------------------------------
      008306                        645 _i2c_scan:
      008306 52 02            [ 2]  646 	sub	sp, #2
                                    647 ;	libs/i2c_lib.c: 116: for (uint8_t addr = 1; addr < 127; addr++)
      008308 A6 01            [ 1]  648 	ld	a, #0x01
      00830A 6B 01            [ 1]  649 	ld	(0x01, sp), a
      00830C                        650 00105$:
      00830C A1 7F            [ 1]  651 	cp	a, #0x7f
      00830E 24 22            [ 1]  652 	jrnc	00103$
                                    653 ;	libs/i2c_lib.c: 118: if(i2c_send_address(addr, 0))
      008310 88               [ 1]  654 	push	a
      008311 4B 00            [ 1]  655 	push	#0x00
      008313 CD 82 56         [ 4]  656 	call	_i2c_send_address
      008316 6B 03            [ 1]  657 	ld	(0x03, sp), a
      008318 84               [ 1]  658 	pop	a
      008319 0D 02            [ 1]  659 	tnz	(0x02, sp)
      00831B 27 07            [ 1]  660 	jreq	00102$
                                    661 ;	libs/i2c_lib.c: 120: i2c_stop();
      00831D CD 82 51         [ 4]  662 	call	_i2c_stop
                                    663 ;	libs/i2c_lib.c: 121: return addr;
      008320 7B 01            [ 1]  664 	ld	a, (0x01, sp)
      008322 20 12            [ 2]  665 	jra	00107$
      008324                        666 00102$:
                                    667 ;	libs/i2c_lib.c: 123: I2C_SR2 -> AF = 0; //Очистка флага ошибки
      008324 AE 52 18         [ 2]  668 	ldw	x, #0x5218
      008327 88               [ 1]  669 	push	a
      008328 F6               [ 1]  670 	ld	a, (x)
      008329 A4 7F            [ 1]  671 	and	a, #0x7f
      00832B F7               [ 1]  672 	ld	(x), a
      00832C 84               [ 1]  673 	pop	a
                                    674 ;	libs/i2c_lib.c: 116: for (uint8_t addr = 1; addr < 127; addr++)
      00832D 4C               [ 1]  675 	inc	a
      00832E 6B 01            [ 1]  676 	ld	(0x01, sp), a
      008330 20 DA            [ 2]  677 	jra	00105$
      008332                        678 00103$:
                                    679 ;	libs/i2c_lib.c: 125: i2c_stop();
      008332 CD 82 51         [ 4]  680 	call	_i2c_stop
                                    681 ;	libs/i2c_lib.c: 126: return 0;
      008335 4F               [ 1]  682 	clr	a
      008336                        683 00107$:
                                    684 ;	libs/i2c_lib.c: 127: }
      008336 5B 02            [ 2]  685 	addw	sp, #2
      008338 81               [ 4]  686 	ret
                                    687 ;	main.c: 3: int main(void)
                                    688 ;	-----------------------------------------
                                    689 ;	 function main
                                    690 ;	-----------------------------------------
      008339                        691 _main:
      008339 52 02            [ 2]  692 	sub	sp, #2
                                    693 ;	main.c: 6: CLK_CKDIVR = 0;
      00833B 35 00 50 C6      [ 1]  694 	mov	0x50c6+0, #0x00
                                    695 ;	main.c: 7: uart_init(9600,0);
      00833F 4F               [ 1]  696 	clr	a
      008340 AE 25 80         [ 2]  697 	ldw	x, #0x2580
      008343 CD 80 7C         [ 4]  698 	call	_uart_init
                                    699 ;	main.c: 8: i2c_init();
      008346 CD 81 E9         [ 4]  700 	call	_i2c_init
                                    701 ;	main.c: 11: buf[0] = 0xA4;
      008349 A6 A4            [ 1]  702 	ld	a, #0xa4
      00834B 6B 01            [ 1]  703 	ld	(0x01, sp), a
                                    704 ;	main.c: 12: i2c_write(I2C_DISPLAY_ADDR,1,buf);
      00834D 96               [ 1]  705 	ldw	x, sp
      00834E 5C               [ 1]  706 	incw	x
      00834F 89               [ 2]  707 	pushw	x
      008350 4B 01            [ 1]  708 	push	#0x01
      008352 A6 3C            [ 1]  709 	ld	a, #0x3c
      008354 CD 82 78         [ 4]  710 	call	_i2c_write
                                    711 ;	main.c: 13: for(int i = 0;i < 256;i++)
      008357 5F               [ 1]  712 	clrw	x
      008358                        713 00103$:
      008358 A3 01 00         [ 2]  714 	cpw	x, #0x0100
      00835B 2E 1C            [ 1]  715 	jrsge	00101$
                                    716 ;	main.c: 15: buf[0] = i;
      00835D 9F               [ 1]  717 	ld	a, xl
      00835E 6B 01            [ 1]  718 	ld	(0x01, sp), a
                                    719 ;	main.c: 16: buf[1] = 1;
      008360 A6 01            [ 1]  720 	ld	a, #0x01
      008362 6B 02            [ 1]  721 	ld	(0x02, sp), a
                                    722 ;	main.c: 17: i2c_write(I2C_DISPLAY_ADDR,2,buf);
      008364 89               [ 2]  723 	pushw	x
      008365 90 96            [ 1]  724 	ldw	y, sp
      008367 72 A9 00 03      [ 2]  725 	addw	y, #3
      00836B 90 89            [ 2]  726 	pushw	y
      00836D 4B 02            [ 1]  727 	push	#0x02
      00836F A6 3C            [ 1]  728 	ld	a, #0x3c
      008371 CD 82 78         [ 4]  729 	call	_i2c_write
      008374 85               [ 2]  730 	popw	x
                                    731 ;	main.c: 18: i++;
      008375 5C               [ 1]  732 	incw	x
                                    733 ;	main.c: 13: for(int i = 0;i < 256;i++)
      008376 5C               [ 1]  734 	incw	x
      008377 20 DF            [ 2]  735 	jra	00103$
      008379                        736 00101$:
                                    737 ;	main.c: 20: return 0;
      008379 5F               [ 1]  738 	clrw	x
                                    739 ;	main.c: 21: }
      00837A 5B 02            [ 2]  740 	addw	sp, #2
      00837C 81               [ 4]  741 	ret
                                    742 	.area CODE
                                    743 	.area CONST
                                    744 	.area CONST
      00802D                        745 ___str_0:
      00802D 73 74 61 72 74 20 73   746 	.ascii "start send byte"
             65 6E 64 20 62 79 74
             65
      00803C 0A                     747 	.db 0x0a
      00803D 00                     748 	.db 0x00
                                    749 	.area CODE
                                    750 	.area CONST
      00803E                        751 ___str_1:
      00803E 77 68 69 6C 65 20 70   752 	.ascii "while passed"
             61 73 73 65 64
      00804A 0A                     753 	.db 0x0a
      00804B 00                     754 	.db 0x00
                                    755 	.area CODE
                                    756 	.area CONST
      00804C                        757 ___str_2:
      00804C 44 52 20 62 79 74 65   758 	.ascii "DR byte"
      008053 0A                     759 	.db 0x0a
      008054 00                     760 	.db 0x00
                                    761 	.area CODE
                                    762 	.area CONST
      008055                        763 ___str_3:
      008055 50 49 56 4F            764 	.ascii "PIVO"
      008059 0A                     765 	.db 0x0a
      00805A 00                     766 	.db 0x00
                                    767 	.area CODE
                                    768 	.area CONST
      00805B                        769 ___str_4:
      00805B 66 6F 72               770 	.ascii "for"
      00805E 0A                     771 	.db 0x0a
      00805F 00                     772 	.db 0x00
                                    773 	.area CODE
                                    774 	.area CONST
      008060                        775 ___str_5:
      008060 65 72 72 6F 72 20 73   776 	.ascii "error send byte"
             65 6E 64 20 62 79 74
             65
      00806F 0A                     777 	.db 0x0a
      008070 00                     778 	.db 0x00
                                    779 	.area CODE
                                    780 	.area CONST
      008071                        781 ___str_6:
      008071 69 66 20 70 61 73 73   782 	.ascii "if passed"
             65 64
      00807A 0A                     783 	.db 0x0a
      00807B 00                     784 	.db 0x00
                                    785 	.area CODE
                                    786 	.area INITIALIZER
                                    787 	.area CABS (ABS)
