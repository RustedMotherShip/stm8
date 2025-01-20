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
                                     12 	.globl _gg
                                     13 	.globl _setup
                                     14 	.globl _uart_write_byte
                                     15 	.globl _uart_init
                                     16 	.globl _I2C_IRQ
                                     17 	.globl _buf_size
                                     18 	.globl _buf_pos
                                     19 	.globl _rx_buf_pointer
                                     20 	.globl _tx_buf_pointer
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
      000001                         25 _tx_buf_pointer::
      000001                         26 	.ds 2
      000003                         27 _rx_buf_pointer::
      000003                         28 	.ds 2
      000005                         29 _buf_pos::
      000005                         30 	.ds 1
      000006                         31 _buf_size::
      000006                         32 	.ds 1
                                     33 ;--------------------------------------------------------
                                     34 ; ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area INITIALIZED
      000007                         37 _I2C_IRQ::
      000007                         38 	.ds 1
                                     39 ;--------------------------------------------------------
                                     40 ; Stack segment in internal ram
                                     41 ;--------------------------------------------------------
                                     42 	.area SSEG
      000008                         43 __start__stack:
      000008                         44 	.ds	1
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; absolute external ram data
                                     48 ;--------------------------------------------------------
                                     49 	.area DABS (ABS)
                                     50 
                                     51 ; default segment ordering for linker
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area CONST
                                     56 	.area INITIALIZER
                                     57 	.area CODE
                                     58 
                                     59 ;--------------------------------------------------------
                                     60 ; interrupt vector
                                     61 ;--------------------------------------------------------
                                     62 	.area HOME
      008000                         63 __interrupt_vect:
      008000 82 00 80 57             64 	int s_GSINIT ; reset
      008004 82 00 00 00             65 	int 0x000000 ; trap
      008008 82 00 00 00             66 	int 0x000000 ; int0
      00800C 82 00 00 00             67 	int 0x000000 ; int1
      008010 82 00 00 00             68 	int 0x000000 ; int2
      008014 82 00 00 00             69 	int 0x000000 ; int3
      008018 82 00 00 00             70 	int 0x000000 ; int4
      00801C 82 00 00 00             71 	int 0x000000 ; int5
      008020 82 00 00 00             72 	int 0x000000 ; int6
      008024 82 00 00 00             73 	int 0x000000 ; int7
      008028 82 00 00 00             74 	int 0x000000 ; int8
      00802C 82 00 00 00             75 	int 0x000000 ; int9
      008030 82 00 00 00             76 	int 0x000000 ; int10
      008034 82 00 00 00             77 	int 0x000000 ; int11
      008038 82 00 00 00             78 	int 0x000000 ; int12
      00803C 82 00 00 00             79 	int 0x000000 ; int13
      008040 82 00 00 00             80 	int 0x000000 ; int14
      008044 82 00 00 00             81 	int 0x000000 ; int15
      008048 82 00 00 00             82 	int 0x000000 ; int16
      00804C 82 00 00 00             83 	int _uart_transmission_irq ; int17
      008050 82 00 00 00             84 	int _uart_reciever_irq ; int18
                                     85 ;--------------------------------------------------------
                                     86 ; global & static initialisations
                                     87 ;--------------------------------------------------------
                                     88 	.area HOME
                                     89 	.area GSINIT
                                     90 	.area GSFINAL
                                     91 	.area GSINIT
      008057 CD 80 99         [ 4]   92 	call	___sdcc_external_startup
      00805A 4D               [ 1]   93 	tnz	a
      00805B 27 03            [ 1]   94 	jreq	__sdcc_init_data
      00805D CC 80 54         [ 2]   95 	jp	__sdcc_program_startup
      008060                         96 __sdcc_init_data:
                                     97 ; stm8_genXINIT() start
      008060 AE 00 06         [ 2]   98 	ldw x, #l_DATA
      008063 27 07            [ 1]   99 	jreq	00002$
      008065                        100 00001$:
      008065 72 4F 00 00      [ 1]  101 	clr (s_DATA - 1, x)
      008069 5A               [ 2]  102 	decw x
      00806A 26 F9            [ 1]  103 	jrne	00001$
      00806C                        104 00002$:
      00806C AE 00 01         [ 2]  105 	ldw	x, #l_INITIALIZER
      00806F 27 09            [ 1]  106 	jreq	00004$
      008071                        107 00003$:
      008071 D6 80 7C         [ 1]  108 	ld	a, (s_INITIALIZER - 1, x)
      008074 D7 00 06         [ 1]  109 	ld	(s_INITIALIZED - 1, x), a
      008077 5A               [ 2]  110 	decw	x
      008078 26 F7            [ 1]  111 	jrne	00003$
      00807A                        112 00004$:
                                    113 ; stm8_genXINIT() end
                                    114 	.area GSFINAL
      00807A CC 80 54         [ 2]  115 	jp	__sdcc_program_startup
                                    116 ;--------------------------------------------------------
                                    117 ; Home
                                    118 ;--------------------------------------------------------
                                    119 	.area HOME
                                    120 	.area HOME
      008054                        121 __sdcc_program_startup:
      008054 CC 80 90         [ 2]  122 	jp	_main
                                    123 ;	return from main will return to caller
                                    124 ;--------------------------------------------------------
                                    125 ; code
                                    126 ;--------------------------------------------------------
                                    127 	.area CODE
                                    128 ;	main.c: 4: void setup(void)
                                    129 ;	-----------------------------------------
                                    130 ;	 function setup
                                    131 ;	-----------------------------------------
      00807E                        132 _setup:
                                    133 ;	main.c: 7: CLK_CKDIVR = 0;
      00807E 35 00 50 C6      [ 1]  134 	mov	0x50c6+0, #0x00
                                    135 ;	main.c: 9: uart_init(9600,0);
      008082 4F               [ 1]  136 	clr	a
      008083 AE 25 80         [ 2]  137 	ldw	x, #0x2580
      008086 CD 00 00         [ 4]  138 	call	_uart_init
                                    139 ;	main.c: 12: enableInterrupts();
      008089 9A               [ 1]  140 	rim
                                    141 ;	main.c: 13: }
      00808A 81               [ 4]  142 	ret
                                    143 ;	main.c: 35: void gg(void)
                                    144 ;	-----------------------------------------
                                    145 ;	 function gg
                                    146 ;	-----------------------------------------
      00808B                        147 _gg:
                                    148 ;	main.c: 40: uart_write_byte(0xAA);
      00808B A6 AA            [ 1]  149 	ld	a, #0xaa
                                    150 ;	main.c: 41: }
      00808D CC 00 00         [ 2]  151 	jp	_uart_write_byte
                                    152 ;	main.c: 43: int main(void)
                                    153 ;	-----------------------------------------
                                    154 ;	 function main
                                    155 ;	-----------------------------------------
      008090                        156 _main:
                                    157 ;	main.c: 45: setup();
      008090 CD 80 7E         [ 4]  158 	call	_setup
                                    159 ;	main.c: 46: gg();
      008093 CD 80 8B         [ 4]  160 	call	_gg
                                    161 ;	main.c: 47: while(1);
      008096                        162 00102$:
      008096 20 FE            [ 2]  163 	jra	00102$
                                    164 ;	main.c: 48: }
      008098 81               [ 4]  165 	ret
                                    166 	.area CODE
                                    167 	.area CONST
                                    168 	.area INITIALIZER
      00807D                        169 __xinit__I2C_IRQ:
      00807D 00                     170 	.db #0x00	; 0
                                    171 	.area CABS (ABS)
