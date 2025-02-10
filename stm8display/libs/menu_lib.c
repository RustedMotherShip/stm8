#include "menu_lib.h"

void menu_border(void)
{
	ssd1306_buffer_write(0,0,ttf_eng_corner_left_up);
	for(int x = 1;x<15;x++)
		ssd1306_buffer_write(x*8,0,ttf_eng_line_up);
	ssd1306_buffer_write(120,0,ttf_eng_corner_right_up);
	//Верхняя полоса
	ssd1306_buffer_write(0,8,ttf_eng_line_left);
	ssd1306_buffer_write(0,16,ttf_eng_line_left);
	//Левая полоса
	ssd1306_buffer_write(120,8,ttf_eng_line_right);
	ssd1306_buffer_write(120,16,ttf_eng_line_right);
	//Правая полоса
	ssd1306_buffer_write(0,24,ttf_eng_corner_left_down);
	for(int x = 1;x<15;x++)
		ssd1306_buffer_write(x*8,24,ttf_eng_line_down);
	ssd1306_buffer_write(120,24,ttf_eng_corner_right_down);
	//Нижняя полоса
}

void menu_border_splash(uint8_t number_of_letters)
{
	ssd1306_buffer_write(6,8,ttf_eng_corner_left_up);
	ssd1306_buffer_write(6,16,ttf_eng_corner_left_down);
	for(int x = 1;x<number_of_letters+1;x++)
		ssd1306_buffer_write(6+x*8,8,ttf_eng_line_up);
	ssd1306_buffer_write(6+number_of_letters*8,8,ttf_eng_corner_right_up);
	ssd1306_buffer_write(12+number_of_letters*8,0,ttf_eng_line_left);
	//Верхняя полоса

	ssd1306_buffer_write(6,16,ttf_eng_corner_left_down);
	for(int x = 1;x<number_of_letters+1;x++)
		ssd1306_buffer_write(6+x*8,16,ttf_eng_line_down);
	ssd1306_buffer_write(6+number_of_letters*8,16,ttf_eng_corner_right_down);
	ssd1306_buffer_write(12+number_of_letters*8,24,ttf_eng_line_left);
	//Нижняя полоса

	
}
void menu_set_item_menu(uint8_t item)
{

	switch(item)
	{
		case red:

		break;
		case green:

		break;
		case blue:

		break;
		case first:

		break;
		case second:

		break;
		case sens:

		break;
		case vers:

		break;
	}

}
void menu_switch_paragraph(uint8_t paragraph)
{
	
}
void menu_set_paragraph(uint8_t paragraph)
{
	switch(paragraph)
	{
		case menu:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_splash(4);

			ssd1306_buffer_write(10,12,ttf_eng_m);
	    	ssd1306_buffer_write(18,12,ttf_eng_e);
	    	ssd1306_buffer_write(26,12,ttf_eng_n);
	    	ssd1306_buffer_write(34,12,ttf_eng_u);

	    	ssd1306_buffer_write(48,4,ttf_eng_c);
	    	ssd1306_buffer_write(56,4,ttf_eng_o);
	    	ssd1306_buffer_write(64,4,ttf_eng_l);
	    	ssd1306_buffer_write(72,4,ttf_eng_o);
	    	ssd1306_buffer_write(80,4,ttf_eng_r);
	    	ssd1306_buffer_write(114,4,ttf_eng_line_left);

	    	ssd1306_buffer_write(48,12,ttf_eng_s);
	    	ssd1306_buffer_write(56,12,ttf_eng_e);
	    	ssd1306_buffer_write(64,12,ttf_eng_g);
	    	ssd1306_buffer_write(72,12,ttf_eng_m);
	    	ssd1306_buffer_write(80,12,ttf_eng_e);
	    	ssd1306_buffer_write(88,12,ttf_eng_n);
	    	ssd1306_buffer_write(96,12,ttf_eng_t);
	    	ssd1306_buffer_write(114,12,ttf_eng_void);

	    	ssd1306_buffer_write(48,20,ttf_eng_s);
	    	ssd1306_buffer_write(56,20,ttf_eng_e);
	    	ssd1306_buffer_write(64,20,ttf_eng_t);
	    	ssd1306_buffer_write(72,20,ttf_eng_t);
	    	ssd1306_buffer_write(80,20,ttf_eng_i);
	    	ssd1306_buffer_write(88,20,ttf_eng_n);
	    	ssd1306_buffer_write(96,20,ttf_eng_g);
	    	ssd1306_buffer_write(104,20,ttf_eng_s);
	    	ssd1306_buffer_write(114,20,ttf_eng_void);

	    	ssd1306_send_buffer();
		break;
		case color:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_splash(5);

			ssd1306_buffer_write(10,12,ttf_eng_c);
	    	ssd1306_buffer_write(18,12,ttf_eng_o);
	    	ssd1306_buffer_write(26,12,ttf_eng_l);
	    	ssd1306_buffer_write(34,12,ttf_eng_o);
	    	ssd1306_buffer_write(42,12,ttf_eng_r);

	    	ssd1306_send_buffer();
		break;
		case segment:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_splash(7);

			ssd1306_buffer_write(10,12,ttf_eng_s);
	    	ssd1306_buffer_write(18,12,ttf_eng_e);
	    	ssd1306_buffer_write(26,12,ttf_eng_g);
	    	ssd1306_buffer_write(34,12,ttf_eng_m);
	    	ssd1306_buffer_write(42,12,ttf_eng_e);
	    	ssd1306_buffer_write(50,12,ttf_eng_n);
	    	ssd1306_buffer_write(58,12,ttf_eng_t);

	    	ssd1306_send_buffer();


		break;
		case settings:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_splash(8);

			ssd1306_buffer_write(10,12,ttf_eng_s);
	    	ssd1306_buffer_write(18,12,ttf_eng_e);
	    	ssd1306_buffer_write(26,12,ttf_eng_t);
	    	ssd1306_buffer_write(34,12,ttf_eng_t);
	    	ssd1306_buffer_write(42,12,ttf_eng_i);
	    	ssd1306_buffer_write(50,12,ttf_eng_n);
	    	ssd1306_buffer_write(58,12,ttf_eng_g);
	    	ssd1306_buffer_write(66,12,ttf_eng_s);

	    	ssd1306_send_buffer();
		break;
	}
}