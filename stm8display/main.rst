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
                                     12 	.globl _setup
                                     13 	.globl _i2c_scan
                                     14 	.globl _i2c_write
                                     15 	.globl _i2c_send_byte
                                     16 	.globl _i2c_read
                                     17 	.globl _i2c_read_byte
                                     18 	.globl _i2c_send_address
                                     19 	.globl _i2c_stop
                                     20 	.globl _i2c_start
                                     21 	.globl _i2c_init
                                     22 	.globl _uart_read
                                     23 	.globl _uart_write_byte
                                     24 	.globl _uart_read_byte
                                     25 	.globl _uart_init
                                     26 	.globl _uart_reciever_irq
                                     27 	.globl _uart_transmission_irq
                                     28 	.globl _I2C_IRQ
                                     29 	.globl _buf_size
                                     30 	.globl _buf_pos
                                     31 	.globl _rx_buf_pointer
                                     32 	.globl _tx_buf_pointer
                                     33 	.globl _uart_write
                                     34 ;--------------------------------------------------------
                                     35 ; ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DATA
      000001                         38 _tx_buf_pointer::
      000001                         39 	.ds 2
      000003                         40 _rx_buf_pointer::
      000003                         41 	.ds 2
      000005                         42 _buf_pos::
      000005                         43 	.ds 1
      000006                         44 _buf_size::
      000006                         45 	.ds 1
                                     46 ;--------------------------------------------------------
                                     47 ; ram data
                                     48 ;--------------------------------------------------------
                                     49 	.area INITIALIZED
      000007                         50 _I2C_IRQ::
      000007                         51 	.ds 1
                                     52 ;--------------------------------------------------------
                                     53 ; Stack segment in internal ram
                                     54 ;--------------------------------------------------------
                                     55 	.area SSEG
      000008                         56 __start__stack:
      000008                         57 	.ds	1
                                     58 
                                     59 ;--------------------------------------------------------
                                     60 ; absolute external ram data
                                     61 ;--------------------------------------------------------
                                     62 	.area DABS (ABS)
                                     63 
                                     64 ; default segment ordering for linker
                                     65 	.area HOME
                                     66 	.area GSINIT
                                     67 	.area GSFINAL
                                     68 	.area CONST
                                     69 	.area INITIALIZER
                                     70 	.area CODE
                                     71 
                                     72 ;--------------------------------------------------------
                                     73 ; interrupt vector
                                     74 ;--------------------------------------------------------
                                     75 	.area HOME
      008000                         76 __interrupt_vect:
      008000 82 00 80 57             77 	int s_GSINIT ; reset
      008004 82 00 00 00             78 	int 0x000000 ; trap
      008008 82 00 00 00             79 	int 0x000000 ; int0
      00800C 82 00 00 00             80 	int 0x000000 ; int1
      008010 82 00 00 00             81 	int 0x000000 ; int2
      008014 82 00 00 00             82 	int 0x000000 ; int3
      008018 82 00 00 00             83 	int 0x000000 ; int4
      00801C 82 00 00 00             84 	int 0x000000 ; int5
      008020 82 00 00 00             85 	int 0x000000 ; int6
      008024 82 00 00 00             86 	int 0x000000 ; int7
      008028 82 00 00 00             87 	int 0x000000 ; int8
      00802C 82 00 00 00             88 	int 0x000000 ; int9
      008030 82 00 00 00             89 	int 0x000000 ; int10
      008034 82 00 00 00             90 	int 0x000000 ; int11
      008038 82 00 00 00             91 	int 0x000000 ; int12
      00803C 82 00 00 00             92 	int 0x000000 ; int13
      008040 82 00 00 00             93 	int 0x000000 ; int14
      008044 82 00 00 00             94 	int 0x000000 ; int15
      008048 82 00 00 00             95 	int 0x000000 ; int16
      00804C 82 00 80 A7             96 	int _uart_transmission_irq ; int17
      008050 82 00 80 E3             97 	int _uart_reciever_irq ; int18
                                     98 ;--------------------------------------------------------
                                     99 ; global & static initialisations
                                    100 ;--------------------------------------------------------
                                    101 	.area HOME
                                    102 	.area GSINIT
                                    103 	.area GSFINAL
                                    104 	.area GSINIT
      008057 CD 85 1B         [ 4]  105 	call	___sdcc_external_startup
      00805A 4D               [ 1]  106 	tnz	a
      00805B 27 03            [ 1]  107 	jreq	__sdcc_init_data
      00805D CC 80 54         [ 2]  108 	jp	__sdcc_program_startup
      008060                        109 __sdcc_init_data:
                                    110 ; stm8_genXINIT() start
      008060 AE 00 06         [ 2]  111 	ldw x, #l_DATA
      008063 27 07            [ 1]  112 	jreq	00002$
      008065                        113 00001$:
      008065 72 4F 00 00      [ 1]  114 	clr (s_DATA - 1, x)
      008069 5A               [ 2]  115 	decw x
      00806A 26 F9            [ 1]  116 	jrne	00001$
      00806C                        117 00002$:
      00806C AE 00 01         [ 2]  118 	ldw	x, #l_INITIALIZER
      00806F 27 09            [ 1]  119 	jreq	00004$
      008071                        120 00003$:
      008071 D6 80 A5         [ 1]  121 	ld	a, (s_INITIALIZER - 1, x)
      008074 D7 00 06         [ 1]  122 	ld	(s_INITIALIZED - 1, x), a
      008077 5A               [ 2]  123 	decw	x
      008078 26 F7            [ 1]  124 	jrne	00003$
      00807A                        125 00004$:
                                    126 ; stm8_genXINIT() end
                                    127 	.area GSFINAL
      00807A CC 80 54         [ 2]  128 	jp	__sdcc_program_startup
                                    129 ;--------------------------------------------------------
                                    130 ; Home
                                    131 ;--------------------------------------------------------
                                    132 	.area HOME
                                    133 	.area HOME
      008054                        134 __sdcc_program_startup:
      008054 CC 83 E3         [ 2]  135 	jp	_main
                                    136 ;	return from main will return to caller
                                    137 ;--------------------------------------------------------
                                    138 ; code
                                    139 ;--------------------------------------------------------
                                    140 	.area CODE
                                    141 ;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    142 ;	-----------------------------------------
                                    143 ;	 function uart_transmission_irq
                                    144 ;	-----------------------------------------
      0080A7                        145 _uart_transmission_irq:
                                    146 ;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0080A7 AE 52 30         [ 2]  147 	ldw	x, #0x5230
      0080AA F6               [ 1]  148 	ld	a, (x)
      0080AB 4E               [ 1]  149 	swap	a
      0080AC 44               [ 1]  150 	srl	a
      0080AD 44               [ 1]  151 	srl	a
      0080AE 44               [ 1]  152 	srl	a
      0080AF A5 01            [ 1]  153 	bcp	a, #0x01
      0080B1 27 2F            [ 1]  154 	jreq	00107$
                                    155 ;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0080B3 C6 00 02         [ 1]  156 	ld	a, _tx_buf_pointer+1
      0080B6 CB 00 05         [ 1]  157 	add	a, _buf_pos+0
      0080B9 97               [ 1]  158 	ld	xl, a
      0080BA C6 00 01         [ 1]  159 	ld	a, _tx_buf_pointer+0
      0080BD A9 00            [ 1]  160 	adc	a, #0x00
      0080BF 95               [ 1]  161 	ld	xh, a
      0080C0 F6               [ 1]  162 	ld	a, (x)
      0080C1 27 1B            [ 1]  163 	jreq	00102$
      0080C3 C6 00 05         [ 1]  164 	ld	a, _buf_pos+0
      0080C6 C1 00 06         [ 1]  165 	cp	a, _buf_size+0
      0080C9 24 13            [ 1]  166 	jrnc	00102$
                                    167 ;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0080CB C6 00 05         [ 1]  168 	ld	a, _buf_pos+0
      0080CE 72 5C 00 05      [ 1]  169 	inc	_buf_pos+0
      0080D2 5F               [ 1]  170 	clrw	x
      0080D3 97               [ 1]  171 	ld	xl, a
      0080D4 72 BB 00 01      [ 2]  172 	addw	x, _tx_buf_pointer+0
      0080D8 F6               [ 1]  173 	ld	a, (x)
      0080D9 C7 52 31         [ 1]  174 	ld	0x5231, a
      0080DC 20 04            [ 2]  175 	jra	00107$
      0080DE                        176 00102$:
                                    177 ;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0080DE 72 1F 52 35      [ 1]  178 	bres	0x5235, #7
      0080E2                        179 00107$:
                                    180 ;	libs/uart_lib.c: 14: }
      0080E2 80               [11]  181 	iret
                                    182 ;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    183 ;	-----------------------------------------
                                    184 ;	 function uart_reciever_irq
                                    185 ;	-----------------------------------------
      0080E3                        186 _uart_reciever_irq:
      0080E3 88               [ 1]  187 	push	a
                                    188 ;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
      0080E4 C6 52 30         [ 1]  189 	ld	a, 0x5230
      0080E7 4E               [ 1]  190 	swap	a
      0080E8 44               [ 1]  191 	srl	a
      0080E9 A5 01            [ 1]  192 	bcp	a, #0x01
      0080EB 27 27            [ 1]  193 	jreq	00107$
                                    194 ;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
      0080ED C6 52 31         [ 1]  195 	ld	a, 0x5231
                                    196 ;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
      0080F0 6B 01            [ 1]  197 	ld	(0x01, sp), a
      0080F2 A1 0A            [ 1]  198 	cp	a, #0x0a
      0080F4 27 1A            [ 1]  199 	jreq	00102$
      0080F6 C6 00 05         [ 1]  200 	ld	a, _buf_pos+0
      0080F9 C1 00 06         [ 1]  201 	cp	a, _buf_size+0
      0080FC 24 12            [ 1]  202 	jrnc	00102$
                                    203 ;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
      0080FE C6 00 05         [ 1]  204 	ld	a, _buf_pos+0
      008101 72 5C 00 05      [ 1]  205 	inc	_buf_pos+0
      008105 5F               [ 1]  206 	clrw	x
      008106 97               [ 1]  207 	ld	xl, a
      008107 72 BB 00 03      [ 2]  208 	addw	x, _rx_buf_pointer+0
      00810B 7B 01            [ 1]  209 	ld	a, (0x01, sp)
      00810D F7               [ 1]  210 	ld	(x), a
      00810E 20 04            [ 2]  211 	jra	00107$
      008110                        212 00102$:
                                    213 ;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
      008110 72 1B 52 35      [ 1]  214 	bres	0x5235, #5
      008114                        215 00107$:
                                    216 ;	libs/uart_lib.c: 29: }
      008114 84               [ 1]  217 	pop	a
      008115 80               [11]  218 	iret
                                    219 ;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    220 ;	-----------------------------------------
                                    221 ;	 function uart_init
                                    222 ;	-----------------------------------------
      008116                        223 _uart_init:
      008116 52 02            [ 2]  224 	sub	sp, #2
      008118 1F 01            [ 2]  225 	ldw	(0x01, sp), x
                                    226 ;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
      00811A AE 52 35         [ 2]  227 	ldw	x, #0x5235
      00811D 88               [ 1]  228 	push	a
      00811E F6               [ 1]  229 	ld	a, (x)
      00811F AA 08            [ 1]  230 	or	a, #0x08
      008121 F7               [ 1]  231 	ld	(x), a
      008122 84               [ 1]  232 	pop	a
                                    233 ;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
      008123 AE 52 35         [ 2]  234 	ldw	x, #0x5235
      008126 88               [ 1]  235 	push	a
      008127 F6               [ 1]  236 	ld	a, (x)
      008128 AA 04            [ 1]  237 	or	a, #0x04
      00812A F7               [ 1]  238 	ld	(x), a
      00812B 84               [ 1]  239 	pop	a
                                    240 ;	libs/uart_lib.c: 36: switch(stopbit)
      00812C A1 02            [ 1]  241 	cp	a, #0x02
      00812E 27 06            [ 1]  242 	jreq	00101$
      008130 A1 03            [ 1]  243 	cp	a, #0x03
      008132 27 0E            [ 1]  244 	jreq	00102$
      008134 20 16            [ 2]  245 	jra	00103$
                                    246 ;	libs/uart_lib.c: 38: case 2:
      008136                        247 00101$:
                                    248 ;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
      008136 C6 52 36         [ 1]  249 	ld	a, 0x5236
      008139 A4 CF            [ 1]  250 	and	a, #0xcf
      00813B AA 20            [ 1]  251 	or	a, #0x20
      00813D C7 52 36         [ 1]  252 	ld	0x5236, a
                                    253 ;	libs/uart_lib.c: 40: break;
      008140 20 12            [ 2]  254 	jra	00104$
                                    255 ;	libs/uart_lib.c: 41: case 3:
      008142                        256 00102$:
                                    257 ;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
      008142 C6 52 36         [ 1]  258 	ld	a, 0x5236
      008145 AA 30            [ 1]  259 	or	a, #0x30
      008147 C7 52 36         [ 1]  260 	ld	0x5236, a
                                    261 ;	libs/uart_lib.c: 43: break;
      00814A 20 08            [ 2]  262 	jra	00104$
                                    263 ;	libs/uart_lib.c: 44: default:
      00814C                        264 00103$:
                                    265 ;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
      00814C C6 52 36         [ 1]  266 	ld	a, 0x5236
      00814F A4 CF            [ 1]  267 	and	a, #0xcf
      008151 C7 52 36         [ 1]  268 	ld	0x5236, a
                                    269 ;	libs/uart_lib.c: 47: }
      008154                        270 00104$:
                                    271 ;	libs/uart_lib.c: 48: switch(baudrate)
      008154 1E 01            [ 2]  272 	ldw	x, (0x01, sp)
      008156 A3 08 00         [ 2]  273 	cpw	x, #0x0800
      008159 26 03            [ 1]  274 	jrne	00186$
      00815B CC 81 E7         [ 2]  275 	jp	00110$
      00815E                        276 00186$:
      00815E 1E 01            [ 2]  277 	ldw	x, (0x01, sp)
      008160 A3 09 60         [ 2]  278 	cpw	x, #0x0960
      008163 27 28            [ 1]  279 	jreq	00105$
      008165 1E 01            [ 2]  280 	ldw	x, (0x01, sp)
      008167 A3 10 00         [ 2]  281 	cpw	x, #0x1000
      00816A 26 03            [ 1]  282 	jrne	00192$
      00816C CC 81 F7         [ 2]  283 	jp	00111$
      00816F                        284 00192$:
      00816F 1E 01            [ 2]  285 	ldw	x, (0x01, sp)
      008171 A3 4B 00         [ 2]  286 	cpw	x, #0x4b00
      008174 27 31            [ 1]  287 	jreq	00106$
      008176 1E 01            [ 2]  288 	ldw	x, (0x01, sp)
      008178 A3 84 00         [ 2]  289 	cpw	x, #0x8400
      00817B 27 5A            [ 1]  290 	jreq	00109$
      00817D 1E 01            [ 2]  291 	ldw	x, (0x01, sp)
      00817F A3 C2 00         [ 2]  292 	cpw	x, #0xc200
      008182 27 43            [ 1]  293 	jreq	00108$
      008184 1E 01            [ 2]  294 	ldw	x, (0x01, sp)
      008186 A3 E1 00         [ 2]  295 	cpw	x, #0xe100
      008189 27 2C            [ 1]  296 	jreq	00107$
      00818B 20 7A            [ 2]  297 	jra	00112$
                                    298 ;	libs/uart_lib.c: 50: case (unsigned int)2400:
      00818D                        299 00105$:
                                    300 ;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
      00818D C6 52 33         [ 1]  301 	ld	a, 0x5233
      008190 A4 0F            [ 1]  302 	and	a, #0x0f
      008192 AA 10            [ 1]  303 	or	a, #0x10
      008194 C7 52 33         [ 1]  304 	ld	0x5233, a
                                    305 ;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
      008197 35 A0 52 32      [ 1]  306 	mov	0x5232+0, #0xa0
                                    307 ;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
      00819B C6 52 33         [ 1]  308 	ld	a, 0x5233
      00819E A4 F0            [ 1]  309 	and	a, #0xf0
      0081A0 AA 0B            [ 1]  310 	or	a, #0x0b
      0081A2 C7 52 33         [ 1]  311 	ld	0x5233, a
                                    312 ;	libs/uart_lib.c: 54: break;
      0081A5 20 6E            [ 2]  313 	jra	00114$
                                    314 ;	libs/uart_lib.c: 55: case (unsigned int)19200:
      0081A7                        315 00106$:
                                    316 ;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
      0081A7 35 34 52 32      [ 1]  317 	mov	0x5232+0, #0x34
                                    318 ;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
      0081AB C6 52 33         [ 1]  319 	ld	a, 0x5233
      0081AE A4 F0            [ 1]  320 	and	a, #0xf0
      0081B0 AA 01            [ 1]  321 	or	a, #0x01
      0081B2 C7 52 33         [ 1]  322 	ld	0x5233, a
                                    323 ;	libs/uart_lib.c: 58: break;
      0081B5 20 5E            [ 2]  324 	jra	00114$
                                    325 ;	libs/uart_lib.c: 59: case (unsigned int)57600:
      0081B7                        326 00107$:
                                    327 ;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
      0081B7 35 11 52 32      [ 1]  328 	mov	0x5232+0, #0x11
                                    329 ;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
      0081BB C6 52 33         [ 1]  330 	ld	a, 0x5233
      0081BE A4 F0            [ 1]  331 	and	a, #0xf0
      0081C0 AA 06            [ 1]  332 	or	a, #0x06
      0081C2 C7 52 33         [ 1]  333 	ld	0x5233, a
                                    334 ;	libs/uart_lib.c: 62: break;
      0081C5 20 4E            [ 2]  335 	jra	00114$
                                    336 ;	libs/uart_lib.c: 63: case (unsigned int)115200:
      0081C7                        337 00108$:
                                    338 ;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
      0081C7 35 08 52 32      [ 1]  339 	mov	0x5232+0, #0x08
                                    340 ;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
      0081CB C6 52 33         [ 1]  341 	ld	a, 0x5233
      0081CE A4 F0            [ 1]  342 	and	a, #0xf0
      0081D0 AA 0B            [ 1]  343 	or	a, #0x0b
      0081D2 C7 52 33         [ 1]  344 	ld	0x5233, a
                                    345 ;	libs/uart_lib.c: 66: break;
      0081D5 20 3E            [ 2]  346 	jra	00114$
                                    347 ;	libs/uart_lib.c: 67: case (unsigned int)230400:
      0081D7                        348 00109$:
                                    349 ;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
      0081D7 35 04 52 32      [ 1]  350 	mov	0x5232+0, #0x04
                                    351 ;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
      0081DB C6 52 33         [ 1]  352 	ld	a, 0x5233
      0081DE A4 F0            [ 1]  353 	and	a, #0xf0
      0081E0 AA 05            [ 1]  354 	or	a, #0x05
      0081E2 C7 52 33         [ 1]  355 	ld	0x5233, a
                                    356 ;	libs/uart_lib.c: 70: break;
      0081E5 20 2E            [ 2]  357 	jra	00114$
                                    358 ;	libs/uart_lib.c: 71: case (unsigned int)460800:
      0081E7                        359 00110$:
                                    360 ;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
      0081E7 35 02 52 32      [ 1]  361 	mov	0x5232+0, #0x02
                                    362 ;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
      0081EB C6 52 33         [ 1]  363 	ld	a, 0x5233
      0081EE A4 F0            [ 1]  364 	and	a, #0xf0
      0081F0 AA 03            [ 1]  365 	or	a, #0x03
      0081F2 C7 52 33         [ 1]  366 	ld	0x5233, a
                                    367 ;	libs/uart_lib.c: 74: break;
      0081F5 20 1E            [ 2]  368 	jra	00114$
                                    369 ;	libs/uart_lib.c: 75: case (unsigned int)921600:
      0081F7                        370 00111$:
                                    371 ;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
      0081F7 35 01 52 32      [ 1]  372 	mov	0x5232+0, #0x01
                                    373 ;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      0081FB C6 52 33         [ 1]  374 	ld	a, 0x5233
      0081FE A4 F0            [ 1]  375 	and	a, #0xf0
      008200 AA 01            [ 1]  376 	or	a, #0x01
      008202 C7 52 33         [ 1]  377 	ld	0x5233, a
                                    378 ;	libs/uart_lib.c: 78: break;
      008205 20 0E            [ 2]  379 	jra	00114$
                                    380 ;	libs/uart_lib.c: 79: default:
      008207                        381 00112$:
                                    382 ;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
      008207 35 68 52 32      [ 1]  383 	mov	0x5232+0, #0x68
                                    384 ;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
      00820B C6 52 33         [ 1]  385 	ld	a, 0x5233
      00820E A4 F0            [ 1]  386 	and	a, #0xf0
      008210 AA 03            [ 1]  387 	or	a, #0x03
      008212 C7 52 33         [ 1]  388 	ld	0x5233, a
                                    389 ;	libs/uart_lib.c: 83: }
      008215                        390 00114$:
                                    391 ;	libs/uart_lib.c: 84: }
      008215 5B 02            [ 2]  392 	addw	sp, #2
      008217 81               [ 4]  393 	ret
                                    394 ;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
                                    395 ;	-----------------------------------------
                                    396 ;	 function uart_read_byte
                                    397 ;	-----------------------------------------
      008218                        398 _uart_read_byte:
                                    399 ;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
      008218                        400 00101$:
      008218 72 0B 52 30 FB   [ 2]  401 	btjf	0x5230, #5, 00101$
                                    402 ;	libs/uart_lib.c: 90: return 1;
      00821D 5F               [ 1]  403 	clrw	x
      00821E 5C               [ 1]  404 	incw	x
                                    405 ;	libs/uart_lib.c: 91: }
      00821F 81               [ 4]  406 	ret
                                    407 ;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
                                    408 ;	-----------------------------------------
                                    409 ;	 function uart_write_byte
                                    410 ;	-----------------------------------------
      008220                        411 _uart_write_byte:
                                    412 ;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
      008220 C7 52 31         [ 1]  413 	ld	0x5231, a
                                    414 ;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
      008223                        415 00101$:
      008223 72 0F 52 30 FB   [ 2]  416 	btjf	0x5230, #7, 00101$
                                    417 ;	libs/uart_lib.c: 97: return 1;
      008228 5F               [ 1]  418 	clrw	x
      008229 5C               [ 1]  419 	incw	x
                                    420 ;	libs/uart_lib.c: 98: }
      00822A 81               [ 4]  421 	ret
                                    422 ;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
                                    423 ;	-----------------------------------------
                                    424 ;	 function uart_write
                                    425 ;	-----------------------------------------
      00822B                        426 _uart_write:
      00822B 52 02            [ 2]  427 	sub	sp, #2
                                    428 ;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
      00822D 1F 01            [ 2]  429 	ldw	(0x01, sp), x
      00822F CF 00 01         [ 2]  430 	ldw	_tx_buf_pointer+0, x
                                    431 ;	libs/uart_lib.c: 103: buf_pos = 0;
      008232 72 5F 00 05      [ 1]  432 	clr	_buf_pos+0
                                    433 ;	libs/uart_lib.c: 104: buf_size = 0;
      008236 72 5F 00 06      [ 1]  434 	clr	_buf_size+0
                                    435 ;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
      00823A                        436 00101$:
      00823A C6 00 06         [ 1]  437 	ld	a, _buf_size+0
      00823D 72 5C 00 06      [ 1]  438 	inc	_buf_size+0
      008241 5F               [ 1]  439 	clrw	x
      008242 97               [ 1]  440 	ld	xl, a
      008243 72 FB 01         [ 2]  441 	addw	x, (0x01, sp)
      008246 F6               [ 1]  442 	ld	a, (x)
      008247 26 F1            [ 1]  443 	jrne	00101$
                                    444 ;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
      008249 72 1E 52 35      [ 1]  445 	bset	0x5235, #7
                                    446 ;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
      00824D                        447 00104$:
      00824D 72 0E 52 35 FB   [ 2]  448 	btjt	0x5235, #7, 00104$
                                    449 ;	libs/uart_lib.c: 108: }
      008252 5B 02            [ 2]  450 	addw	sp, #2
      008254 81               [ 4]  451 	ret
                                    452 ;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
                                    453 ;	-----------------------------------------
                                    454 ;	 function uart_read
                                    455 ;	-----------------------------------------
      008255                        456 _uart_read:
                                    457 ;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
      008255 CF 00 03         [ 2]  458 	ldw	_rx_buf_pointer+0, x
                                    459 ;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
      008258 AE 80 7D         [ 2]  460 	ldw	x, #(___str_0+0)
      00825B CD 82 2B         [ 4]  461 	call	_uart_write
                                    462 ;	libs/uart_lib.c: 113: buf_pos = 0;
      00825E 72 5F 00 05      [ 1]  463 	clr	_buf_pos+0
                                    464 ;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
      008262 AE 80 8D         [ 2]  465 	ldw	x, #(___str_1+0)
      008265 CD 82 2B         [ 4]  466 	call	_uart_write
                                    467 ;	libs/uart_lib.c: 115: buf_size = size;
      008268 7B 04            [ 1]  468 	ld	a, (0x04, sp)
      00826A C7 00 06         [ 1]  469 	ld	_buf_size+0, a
                                    470 ;	libs/uart_lib.c: 116: uart_write("buf_size\n");
      00826D AE 80 96         [ 2]  471 	ldw	x, #(___str_2+0)
      008270 CD 82 2B         [ 4]  472 	call	_uart_write
                                    473 ;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
      008273 72 1A 52 35      [ 1]  474 	bset	0x5235, #5
                                    475 ;	libs/uart_lib.c: 118: uart_write("RIEN\n");
      008277 AE 80 A0         [ 2]  476 	ldw	x, #(___str_3+0)
      00827A CD 82 2B         [ 4]  477 	call	_uart_write
                                    478 ;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
      00827D                        479 00101$:
      00827D C6 52 35         [ 1]  480 	ld	a, 0x5235
      008280 4E               [ 1]  481 	swap	a
      008281 44               [ 1]  482 	srl	a
      008282 A4 01            [ 1]  483 	and	a, #0x01
      008284 26 F7            [ 1]  484 	jrne	00101$
                                    485 ;	libs/uart_lib.c: 120: }
      008286 1E 01            [ 2]  486 	ldw	x, (1, sp)
      008288 5B 04            [ 2]  487 	addw	sp, #4
      00828A FC               [ 2]  488 	jp	(x)
                                    489 ;	libs/i2c_lib.c: 3: void i2c_init(void)
                                    490 ;	-----------------------------------------
                                    491 ;	 function i2c_init
                                    492 ;	-----------------------------------------
      00828B                        493 _i2c_init:
                                    494 ;	libs/i2c_lib.c: 7: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      00828B 72 11 52 10      [ 1]  495 	bres	0x5210, #0
                                    496 ;	libs/i2c_lib.c: 8: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      00828F C6 52 12         [ 1]  497 	ld	a, 0x5212
      008292 A4 C0            [ 1]  498 	and	a, #0xc0
      008294 AA 10            [ 1]  499 	or	a, #0x10
      008296 C7 52 12         [ 1]  500 	ld	0x5212, a
                                    501 ;	libs/i2c_lib.c: 9: I2C_CCRH -> CCR = 0;// =0
      008299 C6 52 1C         [ 1]  502 	ld	a, 0x521c
      00829C A4 F0            [ 1]  503 	and	a, #0xf0
      00829E C7 52 1C         [ 1]  504 	ld	0x521c, a
                                    505 ;	libs/i2c_lib.c: 10: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      0082A1 35 50 52 1B      [ 1]  506 	mov	0x521b+0, #0x50
                                    507 ;	libs/i2c_lib.c: 11: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      0082A5 72 1F 52 1C      [ 1]  508 	bres	0x521c, #7
                                    509 ;	libs/i2c_lib.c: 12: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      0082A9 72 1F 52 14      [ 1]  510 	bres	0x5214, #7
                                    511 ;	libs/i2c_lib.c: 13: I2C_OARH -> ADDCONF = 1;// see reference manual
      0082AD 72 10 52 14      [ 1]  512 	bset	0x5214, #0
                                    513 ;	libs/i2c_lib.c: 14: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      0082B1 72 10 52 10      [ 1]  514 	bset	0x5210, #0
                                    515 ;	libs/i2c_lib.c: 15: }
      0082B5 81               [ 4]  516 	ret
                                    517 ;	libs/i2c_lib.c: 17: void i2c_start(void)
                                    518 ;	-----------------------------------------
                                    519 ;	 function i2c_start
                                    520 ;	-----------------------------------------
      0082B6                        521 _i2c_start:
                                    522 ;	libs/i2c_lib.c: 19: I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
      0082B6 72 10 52 11      [ 1]  523 	bset	0x5211, #0
                                    524 ;	libs/i2c_lib.c: 20: while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
      0082BA                        525 00101$:
      0082BA 72 01 52 17 FB   [ 2]  526 	btjf	0x5217, #0, 00101$
                                    527 ;	libs/i2c_lib.c: 21: }
      0082BF 81               [ 4]  528 	ret
                                    529 ;	libs/i2c_lib.c: 23: void i2c_stop(void)
                                    530 ;	-----------------------------------------
                                    531 ;	 function i2c_stop
                                    532 ;	-----------------------------------------
      0082C0                        533 _i2c_stop:
                                    534 ;	libs/i2c_lib.c: 25: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
      0082C0 72 12 52 11      [ 1]  535 	bset	0x5211, #1
                                    536 ;	libs/i2c_lib.c: 26: }
      0082C4 81               [ 4]  537 	ret
                                    538 ;	libs/i2c_lib.c: 28: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    539 ;	-----------------------------------------
                                    540 ;	 function i2c_send_address
                                    541 ;	-----------------------------------------
      0082C5                        542 _i2c_send_address:
                                    543 ;	libs/i2c_lib.c: 33: address = address << 1;
      0082C5 48               [ 1]  544 	sll	a
                                    545 ;	libs/i2c_lib.c: 30: switch(rw_type)
      0082C6 88               [ 1]  546 	push	a
      0082C7 7B 04            [ 1]  547 	ld	a, (0x04, sp)
      0082C9 4A               [ 1]  548 	dec	a
      0082CA 84               [ 1]  549 	pop	a
      0082CB 26 02            [ 1]  550 	jrne	00102$
                                    551 ;	libs/i2c_lib.c: 33: address = address << 1;
                                    552 ;	libs/i2c_lib.c: 34: address |= 0x01; // Отправка адреса устройства с битом на чтение
      0082CD AA 01            [ 1]  553 	or	a, #0x01
                                    554 ;	libs/i2c_lib.c: 35: break;
                                    555 ;	libs/i2c_lib.c: 36: default:
                                    556 ;	libs/i2c_lib.c: 37: address = address << 1; // Отправка адреса устройства с битом на запись
                                    557 ;	libs/i2c_lib.c: 39: }
      0082CF                        558 00102$:
                                    559 ;	libs/i2c_lib.c: 40: i2c_start();
      0082CF 88               [ 1]  560 	push	a
      0082D0 CD 82 B6         [ 4]  561 	call	_i2c_start
      0082D3 84               [ 1]  562 	pop	a
                                    563 ;	libs/i2c_lib.c: 41: I2C_DR -> DR = address;
      0082D4 C7 52 16         [ 1]  564 	ld	0x5216, a
                                    565 ;	libs/i2c_lib.c: 42: while(!I2C_SR1 -> ADDR)
      0082D7                        566 00106$:
      0082D7 AE 52 17         [ 2]  567 	ldw	x, #0x5217
      0082DA F6               [ 1]  568 	ld	a, (x)
      0082DB 44               [ 1]  569 	srl	a
      0082DC A4 01            [ 1]  570 	and	a, #0x01
      0082DE 26 08            [ 1]  571 	jrne	00108$
                                    572 ;	libs/i2c_lib.c: 43: if(I2C_SR2 -> AF)
      0082E0 72 05 52 18 F2   [ 2]  573 	btjf	0x5218, #2, 00106$
                                    574 ;	libs/i2c_lib.c: 44: return 0;
      0082E5 4F               [ 1]  575 	clr	a
      0082E6 20 08            [ 2]  576 	jra	00109$
      0082E8                        577 00108$:
                                    578 ;	libs/i2c_lib.c: 45: clr_sr1();
      0082E8 C6 52 17         [ 1]  579 	ld	a,0x5217
                                    580 ;	libs/i2c_lib.c: 46: clr_sr3();
      0082EB C6 52 19         [ 1]  581 	ld	a,0x5219
                                    582 ;	libs/i2c_lib.c: 47: return 1;
      0082EE A6 01            [ 1]  583 	ld	a, #0x01
      0082F0                        584 00109$:
                                    585 ;	libs/i2c_lib.c: 48: }
      0082F0 85               [ 2]  586 	popw	x
      0082F1 5B 01            [ 2]  587 	addw	sp, #1
      0082F3 FC               [ 2]  588 	jp	(x)
                                    589 ;	libs/i2c_lib.c: 50: uint8_t i2c_read_byte(void){
                                    590 ;	-----------------------------------------
                                    591 ;	 function i2c_read_byte
                                    592 ;	-----------------------------------------
      0082F4                        593 _i2c_read_byte:
                                    594 ;	libs/i2c_lib.c: 51: while(!I2C_SR1 -> RXNE);
      0082F4                        595 00101$:
      0082F4 72 0D 52 17 FB   [ 2]  596 	btjf	0x5217, #6, 00101$
                                    597 ;	libs/i2c_lib.c: 52: return I2C_DR -> DR;
      0082F9 C6 52 16         [ 1]  598 	ld	a, 0x5216
                                    599 ;	libs/i2c_lib.c: 53: }
      0082FC 81               [ 4]  600 	ret
                                    601 ;	libs/i2c_lib.c: 55: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
                                    602 ;	-----------------------------------------
                                    603 ;	 function i2c_read
                                    604 ;	-----------------------------------------
      0082FD                        605 _i2c_read:
      0082FD 52 04            [ 2]  606 	sub	sp, #4
                                    607 ;	libs/i2c_lib.c: 57: if(i2c_send_address(dev_addr, 1))//проверка на ACK
      0082FF 4B 01            [ 1]  608 	push	#0x01
      008301 CD 82 C5         [ 4]  609 	call	_i2c_send_address
      008304 4D               [ 1]  610 	tnz	a
      008305 27 41            [ 1]  611 	jreq	00103$
                                    612 ;	libs/i2c_lib.c: 59: I2C_CR2 -> ACK = 1;//включение ответа на посылки 
      008307 72 14 52 11      [ 1]  613 	bset	0x5211, #2
                                    614 ;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      00830B 5F               [ 1]  615 	clrw	x
      00830C 1F 03            [ 2]  616 	ldw	(0x03, sp), x
      00830E                        617 00105$:
      00830E 5F               [ 1]  618 	clrw	x
      00830F 7B 07            [ 1]  619 	ld	a, (0x07, sp)
      008311 97               [ 1]  620 	ld	xl, a
      008312 5A               [ 2]  621 	decw	x
      008313 1F 01            [ 2]  622 	ldw	(0x01, sp), x
      008315 1E 03            [ 2]  623 	ldw	x, (0x03, sp)
      008317 13 01            [ 2]  624 	cpw	x, (0x01, sp)
      008319 2E 12            [ 1]  625 	jrsge	00101$
                                    626 ;	libs/i2c_lib.c: 62: data[i] = i2c_read_byte();//функция записи байта в элемент массива
      00831B 1E 08            [ 2]  627 	ldw	x, (0x08, sp)
      00831D 72 FB 03         [ 2]  628 	addw	x, (0x03, sp)
      008320 89               [ 2]  629 	pushw	x
      008321 CD 82 F4         [ 4]  630 	call	_i2c_read_byte
      008324 85               [ 2]  631 	popw	x
      008325 F7               [ 1]  632 	ld	(x), a
                                    633 ;	libs/i2c_lib.c: 60: for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
      008326 1E 03            [ 2]  634 	ldw	x, (0x03, sp)
      008328 5C               [ 1]  635 	incw	x
      008329 1F 03            [ 2]  636 	ldw	(0x03, sp), x
      00832B 20 E1            [ 2]  637 	jra	00105$
      00832D                        638 00101$:
                                    639 ;	libs/i2c_lib.c: 64: I2C_CR2 -> ACK = 0;//выключение ответа на посылки
      00832D 72 15 52 11      [ 1]  640 	bres	0x5211, #2
                                    641 ;	libs/i2c_lib.c: 65: uart_write_byte(0x00);
      008331 4F               [ 1]  642 	clr	a
      008332 CD 82 20         [ 4]  643 	call	_uart_write_byte
                                    644 ;	libs/i2c_lib.c: 66: data[size-1] = i2c_read_byte();
      008335 1E 08            [ 2]  645 	ldw	x, (0x08, sp)
      008337 72 FB 01         [ 2]  646 	addw	x, (0x01, sp)
      00833A 89               [ 2]  647 	pushw	x
      00833B CD 82 F4         [ 4]  648 	call	_i2c_read_byte
      00833E 85               [ 2]  649 	popw	x
      00833F F7               [ 1]  650 	ld	(x), a
                                    651 ;	libs/i2c_lib.c: 67: uart_write_byte(0x01);
      008340 A6 01            [ 1]  652 	ld	a, #0x01
      008342 CD 82 20         [ 4]  653 	call	_uart_write_byte
                                    654 ;	libs/i2c_lib.c: 68: i2c_stop();
      008345 CD 82 C0         [ 4]  655 	call	_i2c_stop
      008348                        656 00103$:
                                    657 ;	libs/i2c_lib.c: 70: uart_write_byte(0x02);
      008348 A6 02            [ 1]  658 	ld	a, #0x02
      00834A CD 82 20         [ 4]  659 	call	_uart_write_byte
                                    660 ;	libs/i2c_lib.c: 71: i2c_stop();
      00834D CD 82 C0         [ 4]  661 	call	_i2c_stop
                                    662 ;	libs/i2c_lib.c: 72: i2c_stop();
      008350 CD 82 C0         [ 4]  663 	call	_i2c_stop
                                    664 ;	libs/i2c_lib.c: 73: uart_write_byte(0x03); 
      008353 A6 03            [ 1]  665 	ld	a, #0x03
      008355 1E 05            [ 2]  666 	ldw	x, (5, sp)
      008357 1F 08            [ 2]  667 	ldw	(8, sp), x
      008359 5B 07            [ 2]  668 	addw	sp, #7
                                    669 ;	libs/i2c_lib.c: 74: }
      00835B CC 82 20         [ 2]  670 	jp	_uart_write_byte
                                    671 ;	libs/i2c_lib.c: 76: uint8_t i2c_send_byte(uint8_t data)
                                    672 ;	-----------------------------------------
                                    673 ;	 function i2c_send_byte
                                    674 ;	-----------------------------------------
      00835E                        675 _i2c_send_byte:
                                    676 ;	libs/i2c_lib.c: 78: I2C_DR -> DR = data; //Отправка данных
      00835E C7 52 16         [ 1]  677 	ld	0x5216, a
                                    678 ;	libs/i2c_lib.c: 79: while(!I2C_SR1 -> TXE)
      008361                        679 00103$:
      008361 72 0E 52 17 07   [ 2]  680 	btjt	0x5217, #7, 00105$
                                    681 ;	libs/i2c_lib.c: 80: if(I2C_SR2 -> AF)
      008366 72 05 52 18 F6   [ 2]  682 	btjf	0x5218, #2, 00103$
                                    683 ;	libs/i2c_lib.c: 81: return 0;
      00836B 4F               [ 1]  684 	clr	a
      00836C 81               [ 4]  685 	ret
      00836D                        686 00105$:
                                    687 ;	libs/i2c_lib.c: 82: return 1;//флаг ответа
      00836D A6 01            [ 1]  688 	ld	a, #0x01
                                    689 ;	libs/i2c_lib.c: 83: }
      00836F 81               [ 4]  690 	ret
                                    691 ;	libs/i2c_lib.c: 85: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    692 ;	-----------------------------------------
                                    693 ;	 function i2c_write
                                    694 ;	-----------------------------------------
      008370                        695 _i2c_write:
      008370 52 02            [ 2]  696 	sub	sp, #2
                                    697 ;	libs/i2c_lib.c: 87: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      008372 4B 00            [ 1]  698 	push	#0x00
      008374 CD 82 C5         [ 4]  699 	call	_i2c_send_address
      008377 4D               [ 1]  700 	tnz	a
      008378 27 1D            [ 1]  701 	jreq	00105$
                                    702 ;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      00837A 5F               [ 1]  703 	clrw	x
      00837B                        704 00107$:
      00837B 7B 05            [ 1]  705 	ld	a, (0x05, sp)
      00837D 6B 02            [ 1]  706 	ld	(0x02, sp), a
      00837F 0F 01            [ 1]  707 	clr	(0x01, sp)
      008381 13 01            [ 2]  708 	cpw	x, (0x01, sp)
      008383 2E 12            [ 1]  709 	jrsge	00105$
                                    710 ;	libs/i2c_lib.c: 90: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      008385 90 93            [ 1]  711 	ldw	y, x
      008387 72 F9 06         [ 2]  712 	addw	y, (0x06, sp)
      00838A 90 F6            [ 1]  713 	ld	a, (y)
      00838C 89               [ 2]  714 	pushw	x
      00838D CD 83 5E         [ 4]  715 	call	_i2c_send_byte
      008390 85               [ 2]  716 	popw	x
      008391 4D               [ 1]  717 	tnz	a
      008392 26 03            [ 1]  718 	jrne	00105$
                                    719 ;	libs/i2c_lib.c: 88: for(int i = 0;i < size;i++)
      008394 5C               [ 1]  720 	incw	x
      008395 20 E4            [ 2]  721 	jra	00107$
      008397                        722 00105$:
                                    723 ;	libs/i2c_lib.c: 95: i2c_stop();
      008397 1E 03            [ 2]  724 	ldw	x, (3, sp)
      008399 1F 06            [ 2]  725 	ldw	(6, sp), x
      00839B 5B 05            [ 2]  726 	addw	sp, #5
                                    727 ;	libs/i2c_lib.c: 96: }
      00839D CC 82 C0         [ 2]  728 	jp	_i2c_stop
                                    729 ;	libs/i2c_lib.c: 98: uint8_t i2c_scan(void) 
                                    730 ;	-----------------------------------------
                                    731 ;	 function i2c_scan
                                    732 ;	-----------------------------------------
      0083A0                        733 _i2c_scan:
      0083A0 52 02            [ 2]  734 	sub	sp, #2
                                    735 ;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0083A2 A6 01            [ 1]  736 	ld	a, #0x01
      0083A4 6B 01            [ 1]  737 	ld	(0x01, sp), a
      0083A6                        738 00105$:
      0083A6 A1 7F            [ 1]  739 	cp	a, #0x7f
      0083A8 24 22            [ 1]  740 	jrnc	00103$
                                    741 ;	libs/i2c_lib.c: 102: if(i2c_send_address(addr, 0))//отправка адреса на проверку 
      0083AA 88               [ 1]  742 	push	a
      0083AB 4B 00            [ 1]  743 	push	#0x00
      0083AD CD 82 C5         [ 4]  744 	call	_i2c_send_address
      0083B0 6B 03            [ 1]  745 	ld	(0x03, sp), a
      0083B2 84               [ 1]  746 	pop	a
      0083B3 0D 02            [ 1]  747 	tnz	(0x02, sp)
      0083B5 27 07            [ 1]  748 	jreq	00102$
                                    749 ;	libs/i2c_lib.c: 104: i2c_stop();//адрес совпал 
      0083B7 CD 82 C0         [ 4]  750 	call	_i2c_stop
                                    751 ;	libs/i2c_lib.c: 105: return addr;// выход из цикла
      0083BA 7B 01            [ 1]  752 	ld	a, (0x01, sp)
      0083BC 20 12            [ 2]  753 	jra	00107$
      0083BE                        754 00102$:
                                    755 ;	libs/i2c_lib.c: 107: I2C_SR2 -> AF = 0;//очистка флага ошибки
      0083BE AE 52 18         [ 2]  756 	ldw	x, #0x5218
      0083C1 88               [ 1]  757 	push	a
      0083C2 F6               [ 1]  758 	ld	a, (x)
      0083C3 A4 FB            [ 1]  759 	and	a, #0xfb
      0083C5 F7               [ 1]  760 	ld	(x), a
      0083C6 84               [ 1]  761 	pop	a
                                    762 ;	libs/i2c_lib.c: 100: for (uint8_t addr = 1; addr < 127; addr++)
      0083C7 4C               [ 1]  763 	inc	a
      0083C8 6B 01            [ 1]  764 	ld	(0x01, sp), a
      0083CA 20 DA            [ 2]  765 	jra	00105$
      0083CC                        766 00103$:
                                    767 ;	libs/i2c_lib.c: 109: i2c_stop();//совпадений нет выход из функции
      0083CC CD 82 C0         [ 4]  768 	call	_i2c_stop
                                    769 ;	libs/i2c_lib.c: 110: return 0;
      0083CF 4F               [ 1]  770 	clr	a
      0083D0                        771 00107$:
                                    772 ;	libs/i2c_lib.c: 111: }
      0083D0 5B 02            [ 2]  773 	addw	sp, #2
      0083D2 81               [ 4]  774 	ret
                                    775 ;	main.c: 2: void setup(void)
                                    776 ;	-----------------------------------------
                                    777 ;	 function setup
                                    778 ;	-----------------------------------------
      0083D3                        779 _setup:
                                    780 ;	main.c: 5: CLK_CKDIVR = 0;
      0083D3 35 00 50 C6      [ 1]  781 	mov	0x50c6+0, #0x00
                                    782 ;	main.c: 7: uart_init(9600,0);
      0083D7 4F               [ 1]  783 	clr	a
      0083D8 AE 25 80         [ 2]  784 	ldw	x, #0x2580
      0083DB CD 81 16         [ 4]  785 	call	_uart_init
                                    786 ;	main.c: 8: i2c_init();
      0083DE CD 82 8B         [ 4]  787 	call	_i2c_init
                                    788 ;	main.c: 10: enableInterrupts();
      0083E1 9A               [ 1]  789 	rim
                                    790 ;	main.c: 11: }
      0083E2 81               [ 4]  791 	ret
                                    792 ;	main.c: 12: int main(void)
                                    793 ;	-----------------------------------------
                                    794 ;	 function main
                                    795 ;	-----------------------------------------
      0083E3                        796 _main:
      0083E3 52 84            [ 2]  797 	sub	sp, #132
                                    798 ;	main.c: 14: setup();
      0083E5 CD 83 D3         [ 4]  799 	call	_setup
                                    800 ;	main.c: 15: uint8_t buf[5] = {0};
      0083E8 96               [ 1]  801 	ldw	x, sp
      0083E9 5C               [ 1]  802 	incw	x
      0083EA 7F               [ 1]  803 	clr	(x)
      0083EB 0F 02            [ 1]  804 	clr	(0x02, sp)
      0083ED 0F 03            [ 1]  805 	clr	(0x03, sp)
      0083EF 0F 04            [ 1]  806 	clr	(0x04, sp)
      0083F1 0F 05            [ 1]  807 	clr	(0x05, sp)
                                    808 ;	main.c: 16: uint8_t buf1[127] = {0};
      0083F3 0F 06            [ 1]  809 	clr	(0x06, sp)
      0083F5 0F 07            [ 1]  810 	clr	(0x07, sp)
      0083F7 0F 08            [ 1]  811 	clr	(0x08, sp)
      0083F9 0F 09            [ 1]  812 	clr	(0x09, sp)
      0083FB 0F 0A            [ 1]  813 	clr	(0x0a, sp)
      0083FD 0F 0B            [ 1]  814 	clr	(0x0b, sp)
      0083FF 0F 0C            [ 1]  815 	clr	(0x0c, sp)
      008401 0F 0D            [ 1]  816 	clr	(0x0d, sp)
      008403 0F 0E            [ 1]  817 	clr	(0x0e, sp)
      008405 0F 0F            [ 1]  818 	clr	(0x0f, sp)
      008407 0F 10            [ 1]  819 	clr	(0x10, sp)
      008409 0F 11            [ 1]  820 	clr	(0x11, sp)
      00840B 0F 12            [ 1]  821 	clr	(0x12, sp)
      00840D 0F 13            [ 1]  822 	clr	(0x13, sp)
      00840F 0F 14            [ 1]  823 	clr	(0x14, sp)
      008411 0F 15            [ 1]  824 	clr	(0x15, sp)
      008413 0F 16            [ 1]  825 	clr	(0x16, sp)
      008415 0F 17            [ 1]  826 	clr	(0x17, sp)
      008417 0F 18            [ 1]  827 	clr	(0x18, sp)
      008419 0F 19            [ 1]  828 	clr	(0x19, sp)
      00841B 0F 1A            [ 1]  829 	clr	(0x1a, sp)
      00841D 0F 1B            [ 1]  830 	clr	(0x1b, sp)
      00841F 0F 1C            [ 1]  831 	clr	(0x1c, sp)
      008421 0F 1D            [ 1]  832 	clr	(0x1d, sp)
      008423 0F 1E            [ 1]  833 	clr	(0x1e, sp)
      008425 0F 1F            [ 1]  834 	clr	(0x1f, sp)
      008427 0F 20            [ 1]  835 	clr	(0x20, sp)
      008429 0F 21            [ 1]  836 	clr	(0x21, sp)
      00842B 0F 22            [ 1]  837 	clr	(0x22, sp)
      00842D 0F 23            [ 1]  838 	clr	(0x23, sp)
      00842F 0F 24            [ 1]  839 	clr	(0x24, sp)
      008431 0F 25            [ 1]  840 	clr	(0x25, sp)
      008433 0F 26            [ 1]  841 	clr	(0x26, sp)
      008435 0F 27            [ 1]  842 	clr	(0x27, sp)
      008437 0F 28            [ 1]  843 	clr	(0x28, sp)
      008439 0F 29            [ 1]  844 	clr	(0x29, sp)
      00843B 0F 2A            [ 1]  845 	clr	(0x2a, sp)
      00843D 0F 2B            [ 1]  846 	clr	(0x2b, sp)
      00843F 0F 2C            [ 1]  847 	clr	(0x2c, sp)
      008441 0F 2D            [ 1]  848 	clr	(0x2d, sp)
      008443 0F 2E            [ 1]  849 	clr	(0x2e, sp)
      008445 0F 2F            [ 1]  850 	clr	(0x2f, sp)
      008447 0F 30            [ 1]  851 	clr	(0x30, sp)
      008449 0F 31            [ 1]  852 	clr	(0x31, sp)
      00844B 0F 32            [ 1]  853 	clr	(0x32, sp)
      00844D 0F 33            [ 1]  854 	clr	(0x33, sp)
      00844F 0F 34            [ 1]  855 	clr	(0x34, sp)
      008451 0F 35            [ 1]  856 	clr	(0x35, sp)
      008453 0F 36            [ 1]  857 	clr	(0x36, sp)
      008455 0F 37            [ 1]  858 	clr	(0x37, sp)
      008457 0F 38            [ 1]  859 	clr	(0x38, sp)
      008459 0F 39            [ 1]  860 	clr	(0x39, sp)
      00845B 0F 3A            [ 1]  861 	clr	(0x3a, sp)
      00845D 0F 3B            [ 1]  862 	clr	(0x3b, sp)
      00845F 0F 3C            [ 1]  863 	clr	(0x3c, sp)
      008461 0F 3D            [ 1]  864 	clr	(0x3d, sp)
      008463 0F 3E            [ 1]  865 	clr	(0x3e, sp)
      008465 0F 3F            [ 1]  866 	clr	(0x3f, sp)
      008467 0F 40            [ 1]  867 	clr	(0x40, sp)
      008469 0F 41            [ 1]  868 	clr	(0x41, sp)
      00846B 0F 42            [ 1]  869 	clr	(0x42, sp)
      00846D 0F 43            [ 1]  870 	clr	(0x43, sp)
      00846F 0F 44            [ 1]  871 	clr	(0x44, sp)
      008471 0F 45            [ 1]  872 	clr	(0x45, sp)
      008473 0F 46            [ 1]  873 	clr	(0x46, sp)
      008475 0F 47            [ 1]  874 	clr	(0x47, sp)
      008477 0F 48            [ 1]  875 	clr	(0x48, sp)
      008479 0F 49            [ 1]  876 	clr	(0x49, sp)
      00847B 0F 4A            [ 1]  877 	clr	(0x4a, sp)
      00847D 0F 4B            [ 1]  878 	clr	(0x4b, sp)
      00847F 0F 4C            [ 1]  879 	clr	(0x4c, sp)
      008481 0F 4D            [ 1]  880 	clr	(0x4d, sp)
      008483 0F 4E            [ 1]  881 	clr	(0x4e, sp)
      008485 0F 4F            [ 1]  882 	clr	(0x4f, sp)
      008487 0F 50            [ 1]  883 	clr	(0x50, sp)
      008489 0F 51            [ 1]  884 	clr	(0x51, sp)
      00848B 0F 52            [ 1]  885 	clr	(0x52, sp)
      00848D 0F 53            [ 1]  886 	clr	(0x53, sp)
      00848F 0F 54            [ 1]  887 	clr	(0x54, sp)
      008491 0F 55            [ 1]  888 	clr	(0x55, sp)
      008493 0F 56            [ 1]  889 	clr	(0x56, sp)
      008495 0F 57            [ 1]  890 	clr	(0x57, sp)
      008497 0F 58            [ 1]  891 	clr	(0x58, sp)
      008499 0F 59            [ 1]  892 	clr	(0x59, sp)
      00849B 0F 5A            [ 1]  893 	clr	(0x5a, sp)
      00849D 0F 5B            [ 1]  894 	clr	(0x5b, sp)
      00849F 0F 5C            [ 1]  895 	clr	(0x5c, sp)
      0084A1 0F 5D            [ 1]  896 	clr	(0x5d, sp)
      0084A3 0F 5E            [ 1]  897 	clr	(0x5e, sp)
      0084A5 0F 5F            [ 1]  898 	clr	(0x5f, sp)
      0084A7 0F 60            [ 1]  899 	clr	(0x60, sp)
      0084A9 0F 61            [ 1]  900 	clr	(0x61, sp)
      0084AB 0F 62            [ 1]  901 	clr	(0x62, sp)
      0084AD 0F 63            [ 1]  902 	clr	(0x63, sp)
      0084AF 0F 64            [ 1]  903 	clr	(0x64, sp)
      0084B1 0F 65            [ 1]  904 	clr	(0x65, sp)
      0084B3 0F 66            [ 1]  905 	clr	(0x66, sp)
      0084B5 0F 67            [ 1]  906 	clr	(0x67, sp)
      0084B7 0F 68            [ 1]  907 	clr	(0x68, sp)
      0084B9 0F 69            [ 1]  908 	clr	(0x69, sp)
      0084BB 0F 6A            [ 1]  909 	clr	(0x6a, sp)
      0084BD 0F 6B            [ 1]  910 	clr	(0x6b, sp)
      0084BF 0F 6C            [ 1]  911 	clr	(0x6c, sp)
      0084C1 0F 6D            [ 1]  912 	clr	(0x6d, sp)
      0084C3 0F 6E            [ 1]  913 	clr	(0x6e, sp)
      0084C5 0F 6F            [ 1]  914 	clr	(0x6f, sp)
      0084C7 0F 70            [ 1]  915 	clr	(0x70, sp)
      0084C9 0F 71            [ 1]  916 	clr	(0x71, sp)
      0084CB 0F 72            [ 1]  917 	clr	(0x72, sp)
      0084CD 0F 73            [ 1]  918 	clr	(0x73, sp)
      0084CF 0F 74            [ 1]  919 	clr	(0x74, sp)
      0084D1 0F 75            [ 1]  920 	clr	(0x75, sp)
      0084D3 0F 76            [ 1]  921 	clr	(0x76, sp)
      0084D5 0F 77            [ 1]  922 	clr	(0x77, sp)
      0084D7 0F 78            [ 1]  923 	clr	(0x78, sp)
      0084D9 0F 79            [ 1]  924 	clr	(0x79, sp)
      0084DB 0F 7A            [ 1]  925 	clr	(0x7a, sp)
      0084DD 0F 7B            [ 1]  926 	clr	(0x7b, sp)
      0084DF 0F 7C            [ 1]  927 	clr	(0x7c, sp)
      0084E1 0F 7D            [ 1]  928 	clr	(0x7d, sp)
      0084E3 0F 7E            [ 1]  929 	clr	(0x7e, sp)
      0084E5 0F 7F            [ 1]  930 	clr	(0x7f, sp)
      0084E7 0F 80            [ 1]  931 	clr	(0x80, sp)
      0084E9 0F 81            [ 1]  932 	clr	(0x81, sp)
      0084EB 0F 82            [ 1]  933 	clr	(0x82, sp)
      0084ED 0F 83            [ 1]  934 	clr	(0x83, sp)
      0084EF 0F 84            [ 1]  935 	clr	(0x84, sp)
                                    936 ;	main.c: 18: buf[0] = 0xAF;
      0084F1 A6 AF            [ 1]  937 	ld	a, #0xaf
      0084F3 F7               [ 1]  938 	ld	(x), a
                                    939 ;	main.c: 19: buf[1] = 0x00;
      0084F4 0F 02            [ 1]  940 	clr	(0x02, sp)
                                    941 ;	main.c: 20: buf[2] = 0xA6;
      0084F6 A6 A6            [ 1]  942 	ld	a, #0xa6
      0084F8 6B 03            [ 1]  943 	ld	(0x03, sp), a
                                    944 ;	main.c: 21: buf[3] = 0xA7;
      0084FA A6 A7            [ 1]  945 	ld	a, #0xa7
      0084FC 6B 04            [ 1]  946 	ld	(0x04, sp), a
                                    947 ;	main.c: 22: buf[4] = 0xA8;
      0084FE A6 A8            [ 1]  948 	ld	a, #0xa8
      008500 6B 05            [ 1]  949 	ld	(0x05, sp), a
                                    950 ;	main.c: 23: i2c_write(I2C_DISPLAY_ADDR,2,buf);
      008502 89               [ 2]  951 	pushw	x
      008503 4B 02            [ 1]  952 	push	#0x02
      008505 A6 3C            [ 1]  953 	ld	a, #0x3c
      008507 CD 83 70         [ 4]  954 	call	_i2c_write
                                    955 ;	main.c: 30: i2c_read(I2C_DISPLAY_ADDR,12,buf1);
      00850A 96               [ 1]  956 	ldw	x, sp
      00850B 1C 00 06         [ 2]  957 	addw	x, #6
      00850E 89               [ 2]  958 	pushw	x
      00850F 4B 0C            [ 1]  959 	push	#0x0c
      008511 A6 3C            [ 1]  960 	ld	a, #0x3c
      008513 CD 82 FD         [ 4]  961 	call	_i2c_read
                                    962 ;	main.c: 31: while(1);
      008516                        963 00102$:
      008516 20 FE            [ 2]  964 	jra	00102$
                                    965 ;	main.c: 32: }
      008518 5B 84            [ 2]  966 	addw	sp, #132
      00851A 81               [ 4]  967 	ret
                                    968 	.area CODE
                                    969 	.area CONST
                                    970 	.area CONST
      00807D                        971 ___str_0:
      00807D 72 78 5F 62 75 66 5F   972 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808B 0A                     973 	.db 0x0a
      00808C 00                     974 	.db 0x00
                                    975 	.area CODE
                                    976 	.area CONST
      00808D                        977 ___str_1:
      00808D 62 75 66 5F 70 6F 73   978 	.ascii "buf_pos"
      008094 0A                     979 	.db 0x0a
      008095 00                     980 	.db 0x00
                                    981 	.area CODE
                                    982 	.area CONST
      008096                        983 ___str_2:
      008096 62 75 66 5F 73 69 7A   984 	.ascii "buf_size"
             65
      00809E 0A                     985 	.db 0x0a
      00809F 00                     986 	.db 0x00
                                    987 	.area CODE
                                    988 	.area CONST
      0080A0                        989 ___str_3:
      0080A0 52 49 45 4E            990 	.ascii "RIEN"
      0080A4 0A                     991 	.db 0x0a
      0080A5 00                     992 	.db 0x00
                                    993 	.area CODE
                                    994 	.area INITIALIZER
      0080A6                        995 __xinit__I2C_IRQ:
      0080A6 00                     996 	.db #0x00	; 0
                                    997 	.area CABS (ABS)
