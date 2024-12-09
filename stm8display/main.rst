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
                                     14 	.globl _i2c_read
                                     15 	.globl _i2c_write
                                     16 	.globl _i2c_send_address
                                     17 	.globl _i2c_read_byte
                                     18 	.globl _i2c_send_byte
                                     19 	.globl _i2c_stop
                                     20 	.globl _i2c_start
                                     21 	.globl _i2c_init
                                     22 	.globl _i2c_irq
                                     23 	.globl _uart_read
                                     24 	.globl _uart_write_byte
                                     25 	.globl _uart_read_byte
                                     26 	.globl _uart_init
                                     27 	.globl _uart_reciever_irq
                                     28 	.globl _uart_transmission_irq
                                     29 	.globl _memset
                                     30 	.globl _I2C_IRQ
                                     31 	.globl _buf_size
                                     32 	.globl _buf_pos
                                     33 	.globl _rx_buf_pointer
                                     34 	.globl _tx_buf_pointer
                                     35 	.globl _uart_write
                                     36 ;--------------------------------------------------------
                                     37 ; ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DATA
      000001                         40 _tx_buf_pointer::
      000001                         41 	.ds 2
      000003                         42 _rx_buf_pointer::
      000003                         43 	.ds 2
      000005                         44 _buf_pos::
      000005                         45 	.ds 1
      000006                         46 _buf_size::
      000006                         47 	.ds 1
                                     48 ;--------------------------------------------------------
                                     49 ; ram data
                                     50 ;--------------------------------------------------------
                                     51 	.area INITIALIZED
      000007                         52 _I2C_IRQ::
      000007                         53 	.ds 1
                                     54 ;--------------------------------------------------------
                                     55 ; Stack segment in internal ram
                                     56 ;--------------------------------------------------------
                                     57 	.area SSEG
      000008                         58 __start__stack:
      000008                         59 	.ds	1
                                     60 
                                     61 ;--------------------------------------------------------
                                     62 ; absolute external ram data
                                     63 ;--------------------------------------------------------
                                     64 	.area DABS (ABS)
                                     65 
                                     66 ; default segment ordering for linker
                                     67 	.area HOME
                                     68 	.area GSINIT
                                     69 	.area GSFINAL
                                     70 	.area CONST
                                     71 	.area INITIALIZER
                                     72 	.area CODE
                                     73 
                                     74 ;--------------------------------------------------------
                                     75 ; interrupt vector
                                     76 ;--------------------------------------------------------
                                     77 	.area HOME
      008000                         78 __interrupt_vect:
      008000 82 00 80 5B             79 	int s_GSINIT ; reset
      008004 82 00 00 00             80 	int 0x000000 ; trap
      008008 82 00 00 00             81 	int 0x000000 ; int0
      00800C 82 00 00 00             82 	int 0x000000 ; int1
      008010 82 00 00 00             83 	int 0x000000 ; int2
      008014 82 00 00 00             84 	int 0x000000 ; int3
      008018 82 00 00 00             85 	int 0x000000 ; int4
      00801C 82 00 00 00             86 	int 0x000000 ; int5
      008020 82 00 00 00             87 	int 0x000000 ; int6
      008024 82 00 00 00             88 	int 0x000000 ; int7
      008028 82 00 00 00             89 	int 0x000000 ; int8
      00802C 82 00 00 00             90 	int 0x000000 ; int9
      008030 82 00 00 00             91 	int 0x000000 ; int10
      008034 82 00 00 00             92 	int 0x000000 ; int11
      008038 82 00 00 00             93 	int 0x000000 ; int12
      00803C 82 00 00 00             94 	int 0x000000 ; int13
      008040 82 00 00 00             95 	int 0x000000 ; int14
      008044 82 00 00 00             96 	int 0x000000 ; int15
      008048 82 00 00 00             97 	int 0x000000 ; int16
      00804C 82 00 80 B7             98 	int _uart_transmission_irq ; int17
      008050 82 00 80 F3             99 	int _uart_reciever_irq ; int18
      008054 82 00 82 9B            100 	int _i2c_irq ; int19
                                    101 ;--------------------------------------------------------
                                    102 ; global & static initialisations
                                    103 ;--------------------------------------------------------
                                    104 	.area HOME
                                    105 	.area GSINIT
                                    106 	.area GSFINAL
                                    107 	.area GSINIT
      00805B CD 84 A1         [ 4]  108 	call	___sdcc_external_startup
      00805E 4D               [ 1]  109 	tnz	a
      00805F 27 03            [ 1]  110 	jreq	__sdcc_init_data
      008061 CC 80 58         [ 2]  111 	jp	__sdcc_program_startup
      008064                        112 __sdcc_init_data:
                                    113 ; stm8_genXINIT() start
      008064 AE 00 06         [ 2]  114 	ldw x, #l_DATA
      008067 27 07            [ 1]  115 	jreq	00002$
      008069                        116 00001$:
      008069 72 4F 00 00      [ 1]  117 	clr (s_DATA - 1, x)
      00806D 5A               [ 2]  118 	decw x
      00806E 26 F9            [ 1]  119 	jrne	00001$
      008070                        120 00002$:
      008070 AE 00 01         [ 2]  121 	ldw	x, #l_INITIALIZER
      008073 27 09            [ 1]  122 	jreq	00004$
      008075                        123 00003$:
      008075 D6 80 B5         [ 1]  124 	ld	a, (s_INITIALIZER - 1, x)
      008078 D7 00 06         [ 1]  125 	ld	(s_INITIALIZED - 1, x), a
      00807B 5A               [ 2]  126 	decw	x
      00807C 26 F7            [ 1]  127 	jrne	00003$
      00807E                        128 00004$:
                                    129 ; stm8_genXINIT() end
                                    130 	.area GSFINAL
      00807E CC 80 58         [ 2]  131 	jp	__sdcc_program_startup
                                    132 ;--------------------------------------------------------
                                    133 ; Home
                                    134 ;--------------------------------------------------------
                                    135 	.area HOME
                                    136 	.area HOME
      008058                        137 __sdcc_program_startup:
      008058 CC 84 64         [ 2]  138 	jp	_main
                                    139 ;	return from main will return to caller
                                    140 ;--------------------------------------------------------
                                    141 ; code
                                    142 ;--------------------------------------------------------
                                    143 	.area CODE
                                    144 ;	libs/uart_lib.c: 3: void uart_transmission_irq(void) __interrupt(UART1_T_vector)
                                    145 ;	-----------------------------------------
                                    146 ;	 function uart_transmission_irq
                                    147 ;	-----------------------------------------
      0080B7                        148 _uart_transmission_irq:
                                    149 ;	libs/uart_lib.c: 5: if(UART1_SR -> TXE) 
      0080B7 AE 52 30         [ 2]  150 	ldw	x, #0x5230
      0080BA F6               [ 1]  151 	ld	a, (x)
      0080BB 4E               [ 1]  152 	swap	a
      0080BC 44               [ 1]  153 	srl	a
      0080BD 44               [ 1]  154 	srl	a
      0080BE 44               [ 1]  155 	srl	a
      0080BF A5 01            [ 1]  156 	bcp	a, #0x01
      0080C1 27 2F            [ 1]  157 	jreq	00107$
                                    158 ;	libs/uart_lib.c: 7: if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      0080C3 C6 00 02         [ 1]  159 	ld	a, _tx_buf_pointer+1
      0080C6 CB 00 05         [ 1]  160 	add	a, _buf_pos+0
      0080C9 97               [ 1]  161 	ld	xl, a
      0080CA C6 00 01         [ 1]  162 	ld	a, _tx_buf_pointer+0
      0080CD A9 00            [ 1]  163 	adc	a, #0x00
      0080CF 95               [ 1]  164 	ld	xh, a
      0080D0 F6               [ 1]  165 	ld	a, (x)
      0080D1 27 1B            [ 1]  166 	jreq	00102$
      0080D3 C6 00 05         [ 1]  167 	ld	a, _buf_pos+0
      0080D6 C1 00 06         [ 1]  168 	cp	a, _buf_size+0
      0080D9 24 13            [ 1]  169 	jrnc	00102$
                                    170 ;	libs/uart_lib.c: 8: UART1_DR -> DR = tx_buf_pointer[buf_pos++];
      0080DB C6 00 05         [ 1]  171 	ld	a, _buf_pos+0
      0080DE 72 5C 00 05      [ 1]  172 	inc	_buf_pos+0
      0080E2 5F               [ 1]  173 	clrw	x
      0080E3 97               [ 1]  174 	ld	xl, a
      0080E4 72 BB 00 01      [ 2]  175 	addw	x, _tx_buf_pointer+0
      0080E8 F6               [ 1]  176 	ld	a, (x)
      0080E9 C7 52 31         [ 1]  177 	ld	0x5231, a
      0080EC 20 04            [ 2]  178 	jra	00107$
      0080EE                        179 00102$:
                                    180 ;	libs/uart_lib.c: 10: UART1_CR2 -> TIEN = 0;
      0080EE 72 1F 52 35      [ 1]  181 	bres	0x5235, #7
      0080F2                        182 00107$:
                                    183 ;	libs/uart_lib.c: 14: }
      0080F2 80               [11]  184 	iret
                                    185 ;	libs/uart_lib.c: 15: void uart_reciever_irq(void) __interrupt(UART1_R_vector)
                                    186 ;	-----------------------------------------
                                    187 ;	 function uart_reciever_irq
                                    188 ;	-----------------------------------------
      0080F3                        189 _uart_reciever_irq:
      0080F3 88               [ 1]  190 	push	a
                                    191 ;	libs/uart_lib.c: 19: if(UART1_SR -> RXNE)
      0080F4 C6 52 30         [ 1]  192 	ld	a, 0x5230
      0080F7 4E               [ 1]  193 	swap	a
      0080F8 44               [ 1]  194 	srl	a
      0080F9 A5 01            [ 1]  195 	bcp	a, #0x01
      0080FB 27 27            [ 1]  196 	jreq	00107$
                                    197 ;	libs/uart_lib.c: 21: trash_reg = UART1_DR -> DR;
      0080FD C6 52 31         [ 1]  198 	ld	a, 0x5231
                                    199 ;	libs/uart_lib.c: 22: if(trash_reg != '\n' && buf_size>buf_pos)
      008100 6B 01            [ 1]  200 	ld	(0x01, sp), a
      008102 A1 0A            [ 1]  201 	cp	a, #0x0a
      008104 27 1A            [ 1]  202 	jreq	00102$
      008106 C6 00 05         [ 1]  203 	ld	a, _buf_pos+0
      008109 C1 00 06         [ 1]  204 	cp	a, _buf_size+0
      00810C 24 12            [ 1]  205 	jrnc	00102$
                                    206 ;	libs/uart_lib.c: 23: rx_buf_pointer[buf_pos++] = trash_reg;
      00810E C6 00 05         [ 1]  207 	ld	a, _buf_pos+0
      008111 72 5C 00 05      [ 1]  208 	inc	_buf_pos+0
      008115 5F               [ 1]  209 	clrw	x
      008116 97               [ 1]  210 	ld	xl, a
      008117 72 BB 00 03      [ 2]  211 	addw	x, _rx_buf_pointer+0
      00811B 7B 01            [ 1]  212 	ld	a, (0x01, sp)
      00811D F7               [ 1]  213 	ld	(x), a
      00811E 20 04            [ 2]  214 	jra	00107$
      008120                        215 00102$:
                                    216 ;	libs/uart_lib.c: 25: UART1_CR2 -> RIEN = 0;
      008120 72 1B 52 35      [ 1]  217 	bres	0x5235, #5
      008124                        218 00107$:
                                    219 ;	libs/uart_lib.c: 29: }
      008124 84               [ 1]  220 	pop	a
      008125 80               [11]  221 	iret
                                    222 ;	libs/uart_lib.c: 30: void uart_init(unsigned int baudrate,uint8_t stopbit)
                                    223 ;	-----------------------------------------
                                    224 ;	 function uart_init
                                    225 ;	-----------------------------------------
      008126                        226 _uart_init:
      008126 52 02            [ 2]  227 	sub	sp, #2
      008128 1F 01            [ 2]  228 	ldw	(0x01, sp), x
                                    229 ;	libs/uart_lib.c: 34: UART1_CR2 -> TEN = 1; // Transmitter enable
      00812A AE 52 35         [ 2]  230 	ldw	x, #0x5235
      00812D 88               [ 1]  231 	push	a
      00812E F6               [ 1]  232 	ld	a, (x)
      00812F AA 08            [ 1]  233 	or	a, #0x08
      008131 F7               [ 1]  234 	ld	(x), a
      008132 84               [ 1]  235 	pop	a
                                    236 ;	libs/uart_lib.c: 35: UART1_CR2 -> REN = 1; // Receiver enable
      008133 AE 52 35         [ 2]  237 	ldw	x, #0x5235
      008136 88               [ 1]  238 	push	a
      008137 F6               [ 1]  239 	ld	a, (x)
      008138 AA 04            [ 1]  240 	or	a, #0x04
      00813A F7               [ 1]  241 	ld	(x), a
      00813B 84               [ 1]  242 	pop	a
                                    243 ;	libs/uart_lib.c: 36: switch(stopbit)
      00813C A1 02            [ 1]  244 	cp	a, #0x02
      00813E 27 06            [ 1]  245 	jreq	00101$
      008140 A1 03            [ 1]  246 	cp	a, #0x03
      008142 27 0E            [ 1]  247 	jreq	00102$
      008144 20 16            [ 2]  248 	jra	00103$
                                    249 ;	libs/uart_lib.c: 38: case 2:
      008146                        250 00101$:
                                    251 ;	libs/uart_lib.c: 39: UART1_CR3 -> STOP = 2;
      008146 C6 52 36         [ 1]  252 	ld	a, 0x5236
      008149 A4 CF            [ 1]  253 	and	a, #0xcf
      00814B AA 20            [ 1]  254 	or	a, #0x20
      00814D C7 52 36         [ 1]  255 	ld	0x5236, a
                                    256 ;	libs/uart_lib.c: 40: break;
      008150 20 12            [ 2]  257 	jra	00104$
                                    258 ;	libs/uart_lib.c: 41: case 3:
      008152                        259 00102$:
                                    260 ;	libs/uart_lib.c: 42: UART1_CR3 -> STOP = 3;
      008152 C6 52 36         [ 1]  261 	ld	a, 0x5236
      008155 AA 30            [ 1]  262 	or	a, #0x30
      008157 C7 52 36         [ 1]  263 	ld	0x5236, a
                                    264 ;	libs/uart_lib.c: 43: break;
      00815A 20 08            [ 2]  265 	jra	00104$
                                    266 ;	libs/uart_lib.c: 44: default:
      00815C                        267 00103$:
                                    268 ;	libs/uart_lib.c: 45: UART1_CR3 -> STOP = 0;
      00815C C6 52 36         [ 1]  269 	ld	a, 0x5236
      00815F A4 CF            [ 1]  270 	and	a, #0xcf
      008161 C7 52 36         [ 1]  271 	ld	0x5236, a
                                    272 ;	libs/uart_lib.c: 47: }
      008164                        273 00104$:
                                    274 ;	libs/uart_lib.c: 48: switch(baudrate)
      008164 1E 01            [ 2]  275 	ldw	x, (0x01, sp)
      008166 A3 08 00         [ 2]  276 	cpw	x, #0x0800
      008169 26 03            [ 1]  277 	jrne	00186$
      00816B CC 81 F7         [ 2]  278 	jp	00110$
      00816E                        279 00186$:
      00816E 1E 01            [ 2]  280 	ldw	x, (0x01, sp)
      008170 A3 09 60         [ 2]  281 	cpw	x, #0x0960
      008173 27 28            [ 1]  282 	jreq	00105$
      008175 1E 01            [ 2]  283 	ldw	x, (0x01, sp)
      008177 A3 10 00         [ 2]  284 	cpw	x, #0x1000
      00817A 26 03            [ 1]  285 	jrne	00192$
      00817C CC 82 07         [ 2]  286 	jp	00111$
      00817F                        287 00192$:
      00817F 1E 01            [ 2]  288 	ldw	x, (0x01, sp)
      008181 A3 4B 00         [ 2]  289 	cpw	x, #0x4b00
      008184 27 31            [ 1]  290 	jreq	00106$
      008186 1E 01            [ 2]  291 	ldw	x, (0x01, sp)
      008188 A3 84 00         [ 2]  292 	cpw	x, #0x8400
      00818B 27 5A            [ 1]  293 	jreq	00109$
      00818D 1E 01            [ 2]  294 	ldw	x, (0x01, sp)
      00818F A3 C2 00         [ 2]  295 	cpw	x, #0xc200
      008192 27 43            [ 1]  296 	jreq	00108$
      008194 1E 01            [ 2]  297 	ldw	x, (0x01, sp)
      008196 A3 E1 00         [ 2]  298 	cpw	x, #0xe100
      008199 27 2C            [ 1]  299 	jreq	00107$
      00819B 20 7A            [ 2]  300 	jra	00112$
                                    301 ;	libs/uart_lib.c: 50: case (unsigned int)2400:
      00819D                        302 00105$:
                                    303 ;	libs/uart_lib.c: 51: UART1_BRR2 -> MSB = 0x01;
      00819D C6 52 33         [ 1]  304 	ld	a, 0x5233
      0081A0 A4 0F            [ 1]  305 	and	a, #0x0f
      0081A2 AA 10            [ 1]  306 	or	a, #0x10
      0081A4 C7 52 33         [ 1]  307 	ld	0x5233, a
                                    308 ;	libs/uart_lib.c: 52: UART1_BRR1 -> DIV = 0xA0;
      0081A7 35 A0 52 32      [ 1]  309 	mov	0x5232+0, #0xa0
                                    310 ;	libs/uart_lib.c: 53: UART1_BRR2 -> LSB = 0x0B; 
      0081AB C6 52 33         [ 1]  311 	ld	a, 0x5233
      0081AE A4 F0            [ 1]  312 	and	a, #0xf0
      0081B0 AA 0B            [ 1]  313 	or	a, #0x0b
      0081B2 C7 52 33         [ 1]  314 	ld	0x5233, a
                                    315 ;	libs/uart_lib.c: 54: break;
      0081B5 20 6E            [ 2]  316 	jra	00114$
                                    317 ;	libs/uart_lib.c: 55: case (unsigned int)19200:
      0081B7                        318 00106$:
                                    319 ;	libs/uart_lib.c: 56: UART1_BRR1 -> DIV = 0x34;
      0081B7 35 34 52 32      [ 1]  320 	mov	0x5232+0, #0x34
                                    321 ;	libs/uart_lib.c: 57: UART1_BRR2 -> LSB = 0x01;
      0081BB C6 52 33         [ 1]  322 	ld	a, 0x5233
      0081BE A4 F0            [ 1]  323 	and	a, #0xf0
      0081C0 AA 01            [ 1]  324 	or	a, #0x01
      0081C2 C7 52 33         [ 1]  325 	ld	0x5233, a
                                    326 ;	libs/uart_lib.c: 58: break;
      0081C5 20 5E            [ 2]  327 	jra	00114$
                                    328 ;	libs/uart_lib.c: 59: case (unsigned int)57600:
      0081C7                        329 00107$:
                                    330 ;	libs/uart_lib.c: 60: UART1_BRR1 -> DIV = 0x11;
      0081C7 35 11 52 32      [ 1]  331 	mov	0x5232+0, #0x11
                                    332 ;	libs/uart_lib.c: 61: UART1_BRR2 -> LSB = 0x06;
      0081CB C6 52 33         [ 1]  333 	ld	a, 0x5233
      0081CE A4 F0            [ 1]  334 	and	a, #0xf0
      0081D0 AA 06            [ 1]  335 	or	a, #0x06
      0081D2 C7 52 33         [ 1]  336 	ld	0x5233, a
                                    337 ;	libs/uart_lib.c: 62: break;
      0081D5 20 4E            [ 2]  338 	jra	00114$
                                    339 ;	libs/uart_lib.c: 63: case (unsigned int)115200:
      0081D7                        340 00108$:
                                    341 ;	libs/uart_lib.c: 64: UART1_BRR1 -> DIV = 0x08;
      0081D7 35 08 52 32      [ 1]  342 	mov	0x5232+0, #0x08
                                    343 ;	libs/uart_lib.c: 65: UART1_BRR2 -> LSB = 0x0B;
      0081DB C6 52 33         [ 1]  344 	ld	a, 0x5233
      0081DE A4 F0            [ 1]  345 	and	a, #0xf0
      0081E0 AA 0B            [ 1]  346 	or	a, #0x0b
      0081E2 C7 52 33         [ 1]  347 	ld	0x5233, a
                                    348 ;	libs/uart_lib.c: 66: break;
      0081E5 20 3E            [ 2]  349 	jra	00114$
                                    350 ;	libs/uart_lib.c: 67: case (unsigned int)230400:
      0081E7                        351 00109$:
                                    352 ;	libs/uart_lib.c: 68: UART1_BRR1 -> DIV = 0x04;
      0081E7 35 04 52 32      [ 1]  353 	mov	0x5232+0, #0x04
                                    354 ;	libs/uart_lib.c: 69: UART1_BRR2 -> LSB = 0x05;
      0081EB C6 52 33         [ 1]  355 	ld	a, 0x5233
      0081EE A4 F0            [ 1]  356 	and	a, #0xf0
      0081F0 AA 05            [ 1]  357 	or	a, #0x05
      0081F2 C7 52 33         [ 1]  358 	ld	0x5233, a
                                    359 ;	libs/uart_lib.c: 70: break;
      0081F5 20 2E            [ 2]  360 	jra	00114$
                                    361 ;	libs/uart_lib.c: 71: case (unsigned int)460800:
      0081F7                        362 00110$:
                                    363 ;	libs/uart_lib.c: 72: UART1_BRR1 -> DIV = 0x02;
      0081F7 35 02 52 32      [ 1]  364 	mov	0x5232+0, #0x02
                                    365 ;	libs/uart_lib.c: 73: UART1_BRR2 -> LSB = 0x03;
      0081FB C6 52 33         [ 1]  366 	ld	a, 0x5233
      0081FE A4 F0            [ 1]  367 	and	a, #0xf0
      008200 AA 03            [ 1]  368 	or	a, #0x03
      008202 C7 52 33         [ 1]  369 	ld	0x5233, a
                                    370 ;	libs/uart_lib.c: 74: break;
      008205 20 1E            [ 2]  371 	jra	00114$
                                    372 ;	libs/uart_lib.c: 75: case (unsigned int)921600:
      008207                        373 00111$:
                                    374 ;	libs/uart_lib.c: 76: UART1_BRR1 -> DIV = 0x01;
      008207 35 01 52 32      [ 1]  375 	mov	0x5232+0, #0x01
                                    376 ;	libs/uart_lib.c: 77: UART1_BRR2 -> LSB = 0x01;
      00820B C6 52 33         [ 1]  377 	ld	a, 0x5233
      00820E A4 F0            [ 1]  378 	and	a, #0xf0
      008210 AA 01            [ 1]  379 	or	a, #0x01
      008212 C7 52 33         [ 1]  380 	ld	0x5233, a
                                    381 ;	libs/uart_lib.c: 78: break;
      008215 20 0E            [ 2]  382 	jra	00114$
                                    383 ;	libs/uart_lib.c: 79: default:
      008217                        384 00112$:
                                    385 ;	libs/uart_lib.c: 80: UART1_BRR1 -> DIV = 0x68;
      008217 35 68 52 32      [ 1]  386 	mov	0x5232+0, #0x68
                                    387 ;	libs/uart_lib.c: 81: UART1_BRR2 -> LSB = 0x03;
      00821B C6 52 33         [ 1]  388 	ld	a, 0x5233
      00821E A4 F0            [ 1]  389 	and	a, #0xf0
      008220 AA 03            [ 1]  390 	or	a, #0x03
      008222 C7 52 33         [ 1]  391 	ld	0x5233, a
                                    392 ;	libs/uart_lib.c: 83: }
      008225                        393 00114$:
                                    394 ;	libs/uart_lib.c: 84: }
      008225 5B 02            [ 2]  395 	addw	sp, #2
      008227 81               [ 4]  396 	ret
                                    397 ;	libs/uart_lib.c: 86: int uart_read_byte(uint8_t *data)
                                    398 ;	-----------------------------------------
                                    399 ;	 function uart_read_byte
                                    400 ;	-----------------------------------------
      008228                        401 _uart_read_byte:
                                    402 ;	libs/uart_lib.c: 88: while(!(UART1_SR -> RXNE));
      008228                        403 00101$:
      008228 72 0B 52 30 FB   [ 2]  404 	btjf	0x5230, #5, 00101$
                                    405 ;	libs/uart_lib.c: 90: return 1;
      00822D 5F               [ 1]  406 	clrw	x
      00822E 5C               [ 1]  407 	incw	x
                                    408 ;	libs/uart_lib.c: 91: }
      00822F 81               [ 4]  409 	ret
                                    410 ;	libs/uart_lib.c: 93: int uart_write_byte(uint8_t data)
                                    411 ;	-----------------------------------------
                                    412 ;	 function uart_write_byte
                                    413 ;	-----------------------------------------
      008230                        414 _uart_write_byte:
                                    415 ;	libs/uart_lib.c: 95: UART1_DR -> DR = data;
      008230 C7 52 31         [ 1]  416 	ld	0x5231, a
                                    417 ;	libs/uart_lib.c: 96: while(!(UART1_SR -> TXE));
      008233                        418 00101$:
      008233 72 0F 52 30 FB   [ 2]  419 	btjf	0x5230, #7, 00101$
                                    420 ;	libs/uart_lib.c: 97: return 1;
      008238 5F               [ 1]  421 	clrw	x
      008239 5C               [ 1]  422 	incw	x
                                    423 ;	libs/uart_lib.c: 98: }
      00823A 81               [ 4]  424 	ret
                                    425 ;	libs/uart_lib.c: 100: void uart_write(uint8_t *data_buf)
                                    426 ;	-----------------------------------------
                                    427 ;	 function uart_write
                                    428 ;	-----------------------------------------
      00823B                        429 _uart_write:
      00823B 52 02            [ 2]  430 	sub	sp, #2
                                    431 ;	libs/uart_lib.c: 102: tx_buf_pointer = data_buf;
      00823D 1F 01            [ 2]  432 	ldw	(0x01, sp), x
      00823F CF 00 01         [ 2]  433 	ldw	_tx_buf_pointer+0, x
                                    434 ;	libs/uart_lib.c: 103: buf_pos = 0;
      008242 72 5F 00 05      [ 1]  435 	clr	_buf_pos+0
                                    436 ;	libs/uart_lib.c: 104: buf_size = 0;
      008246 72 5F 00 06      [ 1]  437 	clr	_buf_size+0
                                    438 ;	libs/uart_lib.c: 105: while (data_buf[buf_size++] != '\0');
      00824A                        439 00101$:
      00824A C6 00 06         [ 1]  440 	ld	a, _buf_size+0
      00824D 72 5C 00 06      [ 1]  441 	inc	_buf_size+0
      008251 5F               [ 1]  442 	clrw	x
      008252 97               [ 1]  443 	ld	xl, a
      008253 72 FB 01         [ 2]  444 	addw	x, (0x01, sp)
      008256 F6               [ 1]  445 	ld	a, (x)
      008257 26 F1            [ 1]  446 	jrne	00101$
                                    447 ;	libs/uart_lib.c: 106: UART1_CR2 -> TIEN = 1;
      008259 72 1E 52 35      [ 1]  448 	bset	0x5235, #7
                                    449 ;	libs/uart_lib.c: 107: while(UART1_CR2 -> TIEN);
      00825D                        450 00104$:
      00825D 72 0E 52 35 FB   [ 2]  451 	btjt	0x5235, #7, 00104$
                                    452 ;	libs/uart_lib.c: 108: }
      008262 5B 02            [ 2]  453 	addw	sp, #2
      008264 81               [ 4]  454 	ret
                                    455 ;	libs/uart_lib.c: 109: void uart_read(uint8_t *data_buf,int size)
                                    456 ;	-----------------------------------------
                                    457 ;	 function uart_read
                                    458 ;	-----------------------------------------
      008265                        459 _uart_read:
                                    460 ;	libs/uart_lib.c: 111: rx_buf_pointer = data_buf;
      008265 CF 00 03         [ 2]  461 	ldw	_rx_buf_pointer+0, x
                                    462 ;	libs/uart_lib.c: 112: uart_write("rx_buf_pointer\n");
      008268 AE 80 81         [ 2]  463 	ldw	x, #(___str_0+0)
      00826B CD 82 3B         [ 4]  464 	call	_uart_write
                                    465 ;	libs/uart_lib.c: 113: buf_pos = 0;
      00826E 72 5F 00 05      [ 1]  466 	clr	_buf_pos+0
                                    467 ;	libs/uart_lib.c: 114: uart_write("buf_pos\n");
      008272 AE 80 91         [ 2]  468 	ldw	x, #(___str_1+0)
      008275 CD 82 3B         [ 4]  469 	call	_uart_write
                                    470 ;	libs/uart_lib.c: 115: buf_size = size;
      008278 7B 04            [ 1]  471 	ld	a, (0x04, sp)
      00827A C7 00 06         [ 1]  472 	ld	_buf_size+0, a
                                    473 ;	libs/uart_lib.c: 116: uart_write("buf_size\n");
      00827D AE 80 9A         [ 2]  474 	ldw	x, #(___str_2+0)
      008280 CD 82 3B         [ 4]  475 	call	_uart_write
                                    476 ;	libs/uart_lib.c: 117: UART1_CR2 -> RIEN = 1;
      008283 72 1A 52 35      [ 1]  477 	bset	0x5235, #5
                                    478 ;	libs/uart_lib.c: 118: uart_write("RIEN\n");
      008287 AE 80 A4         [ 2]  479 	ldw	x, #(___str_3+0)
      00828A CD 82 3B         [ 4]  480 	call	_uart_write
                                    481 ;	libs/uart_lib.c: 119: while(UART1_CR2 -> RIEN);
      00828D                        482 00101$:
      00828D C6 52 35         [ 1]  483 	ld	a, 0x5235
      008290 4E               [ 1]  484 	swap	a
      008291 44               [ 1]  485 	srl	a
      008292 A4 01            [ 1]  486 	and	a, #0x01
      008294 26 F7            [ 1]  487 	jrne	00101$
                                    488 ;	libs/uart_lib.c: 120: }
      008296 1E 01            [ 2]  489 	ldw	x, (1, sp)
      008298 5B 04            [ 2]  490 	addw	sp, #4
      00829A FC               [ 2]  491 	jp	(x)
                                    492 ;	libs/i2c_lib.c: 3: void i2c_irq(void) __interrupt(I2C_vector)
                                    493 ;	-----------------------------------------
                                    494 ;	 function i2c_irq
                                    495 ;	-----------------------------------------
      00829B                        496 _i2c_irq:
      00829B 4F               [ 1]  497 	clr	a
      00829C 62               [ 2]  498 	div	x, a
                                    499 ;	libs/i2c_lib.c: 5: disableInterrupts();
      00829D 9B               [ 1]  500 	sim
                                    501 ;	libs/i2c_lib.c: 6: memset(&I2C_IRQ, 0, sizeof(I2C_IRQ));
      00829E 4B 01            [ 1]  502 	push	#0x01
      0082A0 4B 00            [ 1]  503 	push	#0x00
      0082A2 5F               [ 1]  504 	clrw	x
      0082A3 89               [ 2]  505 	pushw	x
      0082A4 AE 00 07         [ 2]  506 	ldw	x, #(_I2C_IRQ+0)
      0082A7 CD 84 7F         [ 4]  507 	call	_memset
                                    508 ;	libs/i2c_lib.c: 7: if(I2C_SR1 -> SB) 
      0082AA 72 01 52 17 08   [ 2]  509 	btjf	0x5217, #0, 00102$
                                    510 ;	libs/i2c_lib.c: 9: I2C_IRQ.SB = 1;
      0082AF 72 10 00 07      [ 1]  511 	bset	_I2C_IRQ+0, #0
                                    512 ;	libs/i2c_lib.c: 10: I2C_ITR -> ITEVTEN = 0;
      0082B3 72 13 52 1A      [ 1]  513 	bres	0x521a, #1
      0082B7                        514 00102$:
                                    515 ;	libs/i2c_lib.c: 12: if(I2C_SR1 -> ADDR) 
      0082B7 72 03 52 17 08   [ 2]  516 	btjf	0x5217, #1, 00104$
                                    517 ;	libs/i2c_lib.c: 14: I2C_IRQ.ADDR = 1;
      0082BC 72 12 00 07      [ 1]  518 	bset	_I2C_IRQ+0, #1
                                    519 ;	libs/i2c_lib.c: 15: I2C_ITR -> ITEVTEN = 0;
      0082C0 72 13 52 1A      [ 1]  520 	bres	0x521a, #1
      0082C4                        521 00104$:
                                    522 ;	libs/i2c_lib.c: 17: if(I2C_SR1 -> BTF) 
      0082C4 72 05 52 17 08   [ 2]  523 	btjf	0x5217, #2, 00106$
                                    524 ;	libs/i2c_lib.c: 19: I2C_IRQ.BTF = 1;
      0082C9 72 14 00 07      [ 1]  525 	bset	_I2C_IRQ+0, #2
                                    526 ;	libs/i2c_lib.c: 20: I2C_ITR -> ITEVTEN = 0;
      0082CD 72 13 52 1A      [ 1]  527 	bres	0x521a, #1
      0082D1                        528 00106$:
                                    529 ;	libs/i2c_lib.c: 22: if(I2C_SR1 -> TXE) 
      0082D1 72 0F 52 17 08   [ 2]  530 	btjf	0x5217, #7, 00108$
                                    531 ;	libs/i2c_lib.c: 24: I2C_IRQ.TXE = 1;
      0082D6 72 18 00 07      [ 1]  532 	bset	_I2C_IRQ+0, #4
                                    533 ;	libs/i2c_lib.c: 25: I2C_ITR -> ITBUFEN = 0;
      0082DA 72 15 52 1A      [ 1]  534 	bres	0x521a, #2
      0082DE                        535 00108$:
                                    536 ;	libs/i2c_lib.c: 27: if(I2C_SR1 -> RXNE) 
      0082DE 72 0D 52 17 08   [ 2]  537 	btjf	0x5217, #6, 00110$
                                    538 ;	libs/i2c_lib.c: 29: I2C_IRQ.RXNE = 1;
      0082E3 72 16 00 07      [ 1]  539 	bset	_I2C_IRQ+0, #3
                                    540 ;	libs/i2c_lib.c: 30: I2C_ITR -> ITBUFEN = 0;
      0082E7 72 15 52 1A      [ 1]  541 	bres	0x521a, #2
      0082EB                        542 00110$:
                                    543 ;	libs/i2c_lib.c: 32: if(I2C_SR2 -> AF) 
      0082EB AE 52 18         [ 2]  544 	ldw	x, #0x5218
      0082EE F6               [ 1]  545 	ld	a, (x)
      0082EF 44               [ 1]  546 	srl	a
      0082F0 44               [ 1]  547 	srl	a
      0082F1 A4 01            [ 1]  548 	and	a, #0x01
      0082F3 27 0B            [ 1]  549 	jreq	00112$
                                    550 ;	libs/i2c_lib.c: 34: I2C_IRQ.AF = 1;
      0082F5 72 1A 00 07      [ 1]  551 	bset	_I2C_IRQ+0, #5
                                    552 ;	libs/i2c_lib.c: 35: I2C_ITR -> ITERREN = 0;
      0082F9 AE 52 1A         [ 2]  553 	ldw	x, #0x521a
      0082FC F6               [ 1]  554 	ld	a, (x)
      0082FD A4 FE            [ 1]  555 	and	a, #0xfe
      0082FF F7               [ 1]  556 	ld	(x), a
      008300                        557 00112$:
                                    558 ;	libs/i2c_lib.c: 37: enableInterrupts(); 
      008300 9A               [ 1]  559 	rim
                                    560 ;	libs/i2c_lib.c: 39: }
      008301 80               [11]  561 	iret
                                    562 ;	libs/i2c_lib.c: 41: void i2c_init(void)
                                    563 ;	-----------------------------------------
                                    564 ;	 function i2c_init
                                    565 ;	-----------------------------------------
      008302                        566 _i2c_init:
                                    567 ;	libs/i2c_lib.c: 45: I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
      008302 72 11 52 10      [ 1]  568 	bres	0x5210, #0
                                    569 ;	libs/i2c_lib.c: 46: I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
      008306 C6 52 12         [ 1]  570 	ld	a, 0x5212
      008309 A4 C0            [ 1]  571 	and	a, #0xc0
      00830B AA 10            [ 1]  572 	or	a, #0x10
      00830D C7 52 12         [ 1]  573 	ld	0x5212, a
                                    574 ;	libs/i2c_lib.c: 47: I2C_CCRH -> CCR = 0;// =0
      008310 C6 52 1C         [ 1]  575 	ld	a, 0x521c
      008313 A4 F0            [ 1]  576 	and	a, #0xf0
      008315 C7 52 1C         [ 1]  577 	ld	0x521c, a
                                    578 ;	libs/i2c_lib.c: 48: I2C_CCRL -> CCR = 80;// 100kHz for I2C
      008318 35 50 52 1B      [ 1]  579 	mov	0x521b+0, #0x50
                                    580 ;	libs/i2c_lib.c: 49: I2C_CCRH -> FS = 0;// set standart mode(100кHz)
      00831C 72 1F 52 1C      [ 1]  581 	bres	0x521c, #7
                                    582 ;	libs/i2c_lib.c: 50: I2C_OARH -> ADDMODE = 0;// 7-bit address mode
      008320 72 1F 52 14      [ 1]  583 	bres	0x5214, #7
                                    584 ;	libs/i2c_lib.c: 51: I2C_OARH -> ADDCONF = 1;// see reference manual
      008324 72 10 52 14      [ 1]  585 	bset	0x5214, #0
                                    586 ;	libs/i2c_lib.c: 52: I2C_CR1 -> PE = 1;// PE=1, enable I2C
      008328 72 10 52 10      [ 1]  587 	bset	0x5210, #0
                                    588 ;	libs/i2c_lib.c: 53: }
      00832C 81               [ 4]  589 	ret
                                    590 ;	libs/i2c_lib.c: 55: void i2c_start(void)
                                    591 ;	-----------------------------------------
                                    592 ;	 function i2c_start
                                    593 ;	-----------------------------------------
      00832D                        594 _i2c_start:
                                    595 ;	libs/i2c_lib.c: 57: I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
      00832D 72 12 52 1A      [ 1]  596 	bset	0x521a, #1
                                    597 ;	libs/i2c_lib.c: 58: I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
      008331 72 10 52 11      [ 1]  598 	bset	0x5211, #0
                                    599 ;	libs/i2c_lib.c: 59: while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
      008335                        600 00101$:
      008335 C6 52 1A         [ 1]  601 	ld	a, 0x521a
      008338 A5 02            [ 1]  602 	bcp	a, #2
      00833A 26 F9            [ 1]  603 	jrne	00101$
                                    604 ;	libs/i2c_lib.c: 61: }
      00833C 81               [ 4]  605 	ret
                                    606 ;	libs/i2c_lib.c: 63: void i2c_stop(void)
                                    607 ;	-----------------------------------------
                                    608 ;	 function i2c_stop
                                    609 ;	-----------------------------------------
      00833D                        610 _i2c_stop:
                                    611 ;	libs/i2c_lib.c: 65: I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
      00833D 72 12 52 11      [ 1]  612 	bset	0x5211, #1
                                    613 ;	libs/i2c_lib.c: 66: }
      008341 81               [ 4]  614 	ret
                                    615 ;	libs/i2c_lib.c: 68: uint8_t i2c_send_byte(unsigned char data)
                                    616 ;	-----------------------------------------
                                    617 ;	 function i2c_send_byte
                                    618 ;	-----------------------------------------
      008342                        619 _i2c_send_byte:
      008342 88               [ 1]  620 	push	a
      008343 6B 01            [ 1]  621 	ld	(0x01, sp), a
                                    622 ;	libs/i2c_lib.c: 70: I2C_ITR -> ITBUFEN = 1;
      008345 72 14 52 1A      [ 1]  623 	bset	0x521a, #2
                                    624 ;	libs/i2c_lib.c: 71: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      008349 72 12 52 1A      [ 1]  625 	bset	0x521a, #1
                                    626 ;	libs/i2c_lib.c: 72: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      00834D 72 10 52 1A      [ 1]  627 	bset	0x521a, #0
                                    628 ;	libs/i2c_lib.c: 73: I2C_DR -> DR = data; //Отправка данных
      008351 AE 52 16         [ 2]  629 	ldw	x, #0x5216
      008354 7B 01            [ 1]  630 	ld	a, (0x01, sp)
      008356 F7               [ 1]  631 	ld	(x), a
                                    632 ;	libs/i2c_lib.c: 74: while(I2C_ITR -> ITBUFEN || I2C_ITR -> ITERREN);
      008357                        633 00102$:
      008357 C6 52 1A         [ 1]  634 	ld	a, 0x521a
      00835A 44               [ 1]  635 	srl	a
      00835B A5 02            [ 1]  636 	bcp	a, #2
      00835D 26 F8            [ 1]  637 	jrne	00102$
      00835F C6 52 1A         [ 1]  638 	ld	a, 0x521a
      008362 A5 01            [ 1]  639 	bcp	a, #0x01
      008364 26 F1            [ 1]  640 	jrne	00102$
                                    641 ;	libs/i2c_lib.c: 75: return I2C_IRQ.AF;
      008366 C6 00 07         [ 1]  642 	ld	a, _I2C_IRQ+0
      008369 4E               [ 1]  643 	swap	a
      00836A 44               [ 1]  644 	srl	a
      00836B A4 01            [ 1]  645 	and	a, #0x01
                                    646 ;	libs/i2c_lib.c: 76: }
      00836D 5B 01            [ 2]  647 	addw	sp, #1
      00836F 81               [ 4]  648 	ret
                                    649 ;	libs/i2c_lib.c: 78: uint8_t i2c_read_byte(unsigned char *data){
                                    650 ;	-----------------------------------------
                                    651 ;	 function i2c_read_byte
                                    652 ;	-----------------------------------------
      008370                        653 _i2c_read_byte:
                                    654 ;	libs/i2c_lib.c: 79: while (!(I2C_SR1 -> RXNE));
      008370                        655 00101$:
      008370 72 0D 52 17 FB   [ 2]  656 	btjf	0x5217, #6, 00101$
                                    657 ;	libs/i2c_lib.c: 81: return 0;
      008375 4F               [ 1]  658 	clr	a
                                    659 ;	libs/i2c_lib.c: 83: }
      008376 81               [ 4]  660 	ret
                                    661 ;	libs/i2c_lib.c: 88: uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
                                    662 ;	-----------------------------------------
                                    663 ;	 function i2c_send_address
                                    664 ;	-----------------------------------------
      008377                        665 _i2c_send_address:
      008377 90 97            [ 1]  666 	ld	yl, a
                                    667 ;	libs/i2c_lib.c: 90: I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
      008379 72 12 52 1A      [ 1]  668 	bset	0x521a, #1
                                    669 ;	libs/i2c_lib.c: 91: I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
      00837D 72 10 52 1A      [ 1]  670 	bset	0x521a, #0
                                    671 ;	libs/i2c_lib.c: 95: address = address << 1;
      008381 93               [ 1]  672 	ldw	x, y
      008382 58               [ 2]  673 	sllw	x
                                    674 ;	libs/i2c_lib.c: 92: switch(rw_type)
      008383 7B 03            [ 1]  675 	ld	a, (0x03, sp)
      008385 4A               [ 1]  676 	dec	a
      008386 26 04            [ 1]  677 	jrne	00102$
                                    678 ;	libs/i2c_lib.c: 95: address = address << 1;
      008388 9F               [ 1]  679 	ld	a, xl
                                    680 ;	libs/i2c_lib.c: 96: address |= 0x01; // Отправка адреса устройства с битом на чтение
      008389 AA 01            [ 1]  681 	or	a, #0x01
                                    682 ;	libs/i2c_lib.c: 97: break;
                                    683 ;	libs/i2c_lib.c: 98: default:
                                    684 ;	libs/i2c_lib.c: 99: address = address << 1; // Отправка адреса устройства с битом на запись
                                    685 ;	libs/i2c_lib.c: 101: }
      00838B 21                     686 	.byte 0x21
      00838C                        687 00102$:
      00838C 9F               [ 1]  688 	ld	a, xl
      00838D                        689 00103$:
                                    690 ;	libs/i2c_lib.c: 102: i2c_start();
      00838D 88               [ 1]  691 	push	a
      00838E CD 83 2D         [ 4]  692 	call	_i2c_start
      008391 84               [ 1]  693 	pop	a
                                    694 ;	libs/i2c_lib.c: 103: I2C_DR -> DR = address;
      008392 C7 52 16         [ 1]  695 	ld	0x5216, a
                                    696 ;	libs/i2c_lib.c: 104: while(I2C_ITR -> ITEVTEN || I2C_ITR -> ITERREN);
      008395                        697 00105$:
      008395 C6 52 1A         [ 1]  698 	ld	a, 0x521a
      008398 A5 02            [ 1]  699 	bcp	a, #2
      00839A 26 F9            [ 1]  700 	jrne	00105$
      00839C C6 52 1A         [ 1]  701 	ld	a, 0x521a
      00839F A5 01            [ 1]  702 	bcp	a, #0x01
      0083A1 26 F2            [ 1]  703 	jrne	00105$
                                    704 ;	libs/i2c_lib.c: 105: return I2C_IRQ.ADDR;
      0083A3 C6 00 07         [ 1]  705 	ld	a, _I2C_IRQ+0
      0083A6 44               [ 1]  706 	srl	a
      0083A7 A4 01            [ 1]  707 	and	a, #0x01
                                    708 ;	libs/i2c_lib.c: 106: }
      0083A9 85               [ 2]  709 	popw	x
      0083AA 5B 01            [ 2]  710 	addw	sp, #1
      0083AC FC               [ 2]  711 	jp	(x)
                                    712 ;	libs/i2c_lib.c: 108: void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
                                    713 ;	-----------------------------------------
                                    714 ;	 function i2c_write
                                    715 ;	-----------------------------------------
      0083AD                        716 _i2c_write:
      0083AD 52 02            [ 2]  717 	sub	sp, #2
                                    718 ;	libs/i2c_lib.c: 110: if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
      0083AF 4B 00            [ 1]  719 	push	#0x00
      0083B1 CD 83 77         [ 4]  720 	call	_i2c_send_address
      0083B4 4D               [ 1]  721 	tnz	a
      0083B5 27 1D            [ 1]  722 	jreq	00105$
                                    723 ;	libs/i2c_lib.c: 112: for(int i = 0;i < size;i++)
      0083B7 5F               [ 1]  724 	clrw	x
      0083B8                        725 00107$:
      0083B8 7B 05            [ 1]  726 	ld	a, (0x05, sp)
      0083BA 6B 02            [ 1]  727 	ld	(0x02, sp), a
      0083BC 0F 01            [ 1]  728 	clr	(0x01, sp)
      0083BE 13 01            [ 2]  729 	cpw	x, (0x01, sp)
      0083C0 2E 12            [ 1]  730 	jrsge	00105$
                                    731 ;	libs/i2c_lib.c: 114: if(i2c_send_byte(data[i]))//Проверка на АСК бит
      0083C2 90 93            [ 1]  732 	ldw	y, x
      0083C4 72 F9 06         [ 2]  733 	addw	y, (0x06, sp)
      0083C7 90 F6            [ 1]  734 	ld	a, (y)
      0083C9 89               [ 2]  735 	pushw	x
      0083CA CD 83 42         [ 4]  736 	call	_i2c_send_byte
      0083CD 85               [ 2]  737 	popw	x
      0083CE 4D               [ 1]  738 	tnz	a
      0083CF 26 03            [ 1]  739 	jrne	00105$
                                    740 ;	libs/i2c_lib.c: 112: for(int i = 0;i < size;i++)
      0083D1 5C               [ 1]  741 	incw	x
      0083D2 20 E4            [ 2]  742 	jra	00107$
      0083D4                        743 00105$:
                                    744 ;	libs/i2c_lib.c: 120: i2c_stop();
      0083D4 1E 03            [ 2]  745 	ldw	x, (3, sp)
      0083D6 1F 06            [ 2]  746 	ldw	(6, sp), x
      0083D8 5B 05            [ 2]  747 	addw	sp, #5
                                    748 ;	libs/i2c_lib.c: 121: }
      0083DA CC 83 3D         [ 2]  749 	jp	_i2c_stop
                                    750 ;	libs/i2c_lib.c: 123: void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
                                    751 ;	-----------------------------------------
                                    752 ;	 function i2c_read
                                    753 ;	-----------------------------------------
      0083DD                        754 _i2c_read:
      0083DD 52 02            [ 2]  755 	sub	sp, #2
                                    756 ;	libs/i2c_lib.c: 124: I2C_CR2 -> ACK = 1;
      0083DF AE 52 11         [ 2]  757 	ldw	x, #0x5211
      0083E2 88               [ 1]  758 	push	a
      0083E3 F6               [ 1]  759 	ld	a, (x)
      0083E4 AA 04            [ 1]  760 	or	a, #0x04
      0083E6 F7               [ 1]  761 	ld	(x), a
      0083E7 84               [ 1]  762 	pop	a
                                    763 ;	libs/i2c_lib.c: 125: if(i2c_send_address(dev_addr,1))
      0083E8 4B 01            [ 1]  764 	push	#0x01
      0083EA CD 83 77         [ 4]  765 	call	_i2c_send_address
      0083ED 4D               [ 1]  766 	tnz	a
      0083EE 27 1F            [ 1]  767 	jreq	00103$
                                    768 ;	libs/i2c_lib.c: 126: for(int i = 0;i < size;i++)
      0083F0 5F               [ 1]  769 	clrw	x
      0083F1                        770 00105$:
      0083F1 7B 05            [ 1]  771 	ld	a, (0x05, sp)
      0083F3 6B 02            [ 1]  772 	ld	(0x02, sp), a
      0083F5 0F 01            [ 1]  773 	clr	(0x01, sp)
      0083F7 13 01            [ 2]  774 	cpw	x, (0x01, sp)
      0083F9 2E 14            [ 1]  775 	jrsge	00103$
                                    776 ;	libs/i2c_lib.c: 128: i2c_read_byte((unsigned char *)data[i]);
      0083FB 90 93            [ 1]  777 	ldw	y, x
      0083FD 72 F9 06         [ 2]  778 	addw	y, (0x06, sp)
      008400 90 F6            [ 1]  779 	ld	a, (y)
      008402 90 5F            [ 1]  780 	clrw	y
      008404 90 97            [ 1]  781 	ld	yl, a
      008406 89               [ 2]  782 	pushw	x
      008407 93               [ 1]  783 	ldw	x, y
      008408 CD 83 70         [ 4]  784 	call	_i2c_read_byte
      00840B 85               [ 2]  785 	popw	x
                                    786 ;	libs/i2c_lib.c: 126: for(int i = 0;i < size;i++)
      00840C 5C               [ 1]  787 	incw	x
      00840D 20 E2            [ 2]  788 	jra	00105$
      00840F                        789 00103$:
                                    790 ;	libs/i2c_lib.c: 130: I2C_CR2 -> ACK = 0;
      00840F C6 52 11         [ 1]  791 	ld	a, 0x5211
      008412 A4 FB            [ 1]  792 	and	a, #0xfb
      008414 C7 52 11         [ 1]  793 	ld	0x5211, a
                                    794 ;	libs/i2c_lib.c: 131: }
      008417 1E 03            [ 2]  795 	ldw	x, (3, sp)
      008419 5B 07            [ 2]  796 	addw	sp, #7
      00841B FC               [ 2]  797 	jp	(x)
                                    798 ;	libs/i2c_lib.c: 132: uint8_t i2c_scan(void) 
                                    799 ;	-----------------------------------------
                                    800 ;	 function i2c_scan
                                    801 ;	-----------------------------------------
      00841C                        802 _i2c_scan:
      00841C 52 02            [ 2]  803 	sub	sp, #2
                                    804 ;	libs/i2c_lib.c: 134: for (uint8_t addr = 1; addr < 127; addr++)
      00841E A6 01            [ 1]  805 	ld	a, #0x01
      008420 6B 01            [ 1]  806 	ld	(0x01, sp), a
      008422 6B 02            [ 1]  807 	ld	(0x02, sp), a
      008424                        808 00105$:
      008424 7B 02            [ 1]  809 	ld	a, (0x02, sp)
      008426 A1 7F            [ 1]  810 	cp	a, #0x7f
      008428 24 23            [ 1]  811 	jrnc	00103$
                                    812 ;	libs/i2c_lib.c: 136: if(i2c_send_address(addr, 0))
      00842A 4B 00            [ 1]  813 	push	#0x00
      00842C 7B 03            [ 1]  814 	ld	a, (0x03, sp)
      00842E CD 83 77         [ 4]  815 	call	_i2c_send_address
      008431 4D               [ 1]  816 	tnz	a
      008432 27 07            [ 1]  817 	jreq	00102$
                                    818 ;	libs/i2c_lib.c: 138: i2c_stop();
      008434 CD 83 3D         [ 4]  819 	call	_i2c_stop
                                    820 ;	libs/i2c_lib.c: 139: return addr;
      008437 7B 01            [ 1]  821 	ld	a, (0x01, sp)
      008439 20 16            [ 2]  822 	jra	00107$
      00843B                        823 00102$:
                                    824 ;	libs/i2c_lib.c: 141: I2C_SR2 -> AF = 0;
      00843B 72 15 52 18      [ 1]  825 	bres	0x5218, #2
                                    826 ;	libs/i2c_lib.c: 142: uart_write("error addr\n"); //Очистка флага ошибки
      00843F AE 80 AA         [ 2]  827 	ldw	x, #(___str_4+0)
      008442 CD 82 3B         [ 4]  828 	call	_uart_write
                                    829 ;	libs/i2c_lib.c: 134: for (uint8_t addr = 1; addr < 127; addr++)
      008445 0C 02            [ 1]  830 	inc	(0x02, sp)
      008447 7B 02            [ 1]  831 	ld	a, (0x02, sp)
      008449 6B 01            [ 1]  832 	ld	(0x01, sp), a
      00844B 20 D7            [ 2]  833 	jra	00105$
      00844D                        834 00103$:
                                    835 ;	libs/i2c_lib.c: 144: i2c_stop();
      00844D CD 83 3D         [ 4]  836 	call	_i2c_stop
                                    837 ;	libs/i2c_lib.c: 145: return 0;
      008450 4F               [ 1]  838 	clr	a
      008451                        839 00107$:
                                    840 ;	libs/i2c_lib.c: 146: }
      008451 5B 02            [ 2]  841 	addw	sp, #2
      008453 81               [ 4]  842 	ret
                                    843 ;	main.c: 2: void setup(void)
                                    844 ;	-----------------------------------------
                                    845 ;	 function setup
                                    846 ;	-----------------------------------------
      008454                        847 _setup:
                                    848 ;	main.c: 5: CLK_CKDIVR = 0;
      008454 35 00 50 C6      [ 1]  849 	mov	0x50c6+0, #0x00
                                    850 ;	main.c: 7: uart_init(9600,0);
      008458 4F               [ 1]  851 	clr	a
      008459 AE 25 80         [ 2]  852 	ldw	x, #0x2580
      00845C CD 81 26         [ 4]  853 	call	_uart_init
                                    854 ;	main.c: 8: i2c_init();
      00845F CD 83 02         [ 4]  855 	call	_i2c_init
                                    856 ;	main.c: 10: enableInterrupts();
      008462 9A               [ 1]  857 	rim
                                    858 ;	main.c: 11: }
      008463 81               [ 4]  859 	ret
                                    860 ;	main.c: 12: int main(void)
                                    861 ;	-----------------------------------------
                                    862 ;	 function main
                                    863 ;	-----------------------------------------
      008464                        864 _main:
      008464 52 02            [ 2]  865 	sub	sp, #2
                                    866 ;	main.c: 14: setup();
      008466 CD 84 54         [ 4]  867 	call	_setup
                                    868 ;	main.c: 20: buf[0] = 0xA4;
      008469 96               [ 1]  869 	ldw	x, sp
      00846A 5C               [ 1]  870 	incw	x
      00846B A6 A4            [ 1]  871 	ld	a, #0xa4
      00846D F7               [ 1]  872 	ld	(x), a
                                    873 ;	main.c: 21: buf[1] = 0xA5;
      00846E A6 A5            [ 1]  874 	ld	a, #0xa5
      008470 6B 02            [ 1]  875 	ld	(0x02, sp), a
                                    876 ;	main.c: 22: i2c_write(I2C_DISPLAY_ADDR,2,buf);
      008472 89               [ 2]  877 	pushw	x
      008473 4B 02            [ 1]  878 	push	#0x02
      008475 A6 3C            [ 1]  879 	ld	a, #0x3c
      008477 CD 83 AD         [ 4]  880 	call	_i2c_write
                                    881 ;	main.c: 23: while(1);
      00847A                        882 00102$:
      00847A 20 FE            [ 2]  883 	jra	00102$
                                    884 ;	main.c: 34: }
      00847C 5B 02            [ 2]  885 	addw	sp, #2
      00847E 81               [ 4]  886 	ret
                                    887 	.area CODE
                                    888 	.area CONST
                                    889 	.area CONST
      008081                        890 ___str_0:
      008081 72 78 5F 62 75 66 5F   891 	.ascii "rx_buf_pointer"
             70 6F 69 6E 74 65 72
      00808F 0A                     892 	.db 0x0a
      008090 00                     893 	.db 0x00
                                    894 	.area CODE
                                    895 	.area CONST
      008091                        896 ___str_1:
      008091 62 75 66 5F 70 6F 73   897 	.ascii "buf_pos"
      008098 0A                     898 	.db 0x0a
      008099 00                     899 	.db 0x00
                                    900 	.area CODE
                                    901 	.area CONST
      00809A                        902 ___str_2:
      00809A 62 75 66 5F 73 69 7A   903 	.ascii "buf_size"
             65
      0080A2 0A                     904 	.db 0x0a
      0080A3 00                     905 	.db 0x00
                                    906 	.area CODE
                                    907 	.area CONST
      0080A4                        908 ___str_3:
      0080A4 52 49 45 4E            909 	.ascii "RIEN"
      0080A8 0A                     910 	.db 0x0a
      0080A9 00                     911 	.db 0x00
                                    912 	.area CODE
                                    913 	.area CONST
      0080AA                        914 ___str_4:
      0080AA 65 72 72 6F 72 20 61   915 	.ascii "error addr"
             64 64 72
      0080B4 0A                     916 	.db 0x0a
      0080B5 00                     917 	.db 0x00
                                    918 	.area CODE
                                    919 	.area INITIALIZER
      0080B6                        920 __xinit__I2C_IRQ:
      0080B6 00                     921 	.db 0x00
                                    922 	.area CABS (ABS)
