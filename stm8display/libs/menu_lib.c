#include "menu_lib.h"

void menu_border(void)
{
	//Верхняя полоса
	ssd1306_buffer_write(0,0,ttf_corner_left_up);
	for(int x = 1;x<15;x++)
		ssd1306_buffer_write(x*8,0,ttf_line_up);
	ssd1306_buffer_write(120,0,ttf_corner_right_up);
	//Левая полоса
	ssd1306_buffer_write(0,8,ttf_line_left);
	ssd1306_buffer_write(0,16,ttf_line_left);
	//Правая полоса
	ssd1306_buffer_write(120,8,ttf_line_right);
	ssd1306_buffer_write(120,16,ttf_line_right);
	//Нижняя полоса
	ssd1306_buffer_write(0,24,ttf_corner_left_down);
	for(int x = 1;x<15;x++)
		ssd1306_buffer_write(x*8,24,ttf_line_down);
	ssd1306_buffer_write(120,24,ttf_corner_right_down);
}

void menu_border_paragraph(uint8_t number_of_letters)
{
	//Верхняя полоса
	ssd1306_buffer_write(6,8,ttf_corner_left_up);
	ssd1306_buffer_write(6,16,ttf_corner_left_down);
	for(int x = 1;x<number_of_letters+1;x++)
		ssd1306_buffer_write(6+x*8,8,ttf_line_up);
	ssd1306_buffer_write(6+number_of_letters*8,8,ttf_corner_right_up);
	ssd1306_buffer_write(12+number_of_letters*8,0,ttf_line_left);
	
	//Нижняя полоса
	ssd1306_buffer_write(6,16,ttf_corner_left_down);
	for(int x = 1;x<number_of_letters+1;x++)
		ssd1306_buffer_write(6+x*8,16,ttf_line_down);
	ssd1306_buffer_write(6+number_of_letters*8,16,ttf_corner_right_down);
	ssd1306_buffer_write(12+number_of_letters*8,24,ttf_line_left);
	
}

void menu_border_item(uint8_t number_of_letters)
{
	//Боковая полоса
	ssd1306_buffer_write(12+number_of_letters*8,7,ttf_corner_left_down);
	for(int x = 1;x<14-number_of_letters;x++)
		ssd1306_buffer_write(12+number_of_letters*8+x*8,7,ttf_line_down);
	ssd1306_buffer_write(120,7,ttf_corner_right_down);

	//Нижняя полоса
	ssd1306_buffer_write(97,15,ttf_line_left);
	ssd1306_buffer_write(97,17,ttf_corner_left_down);
	ssd1306_buffer_write(104,17,ttf_line_down);
	ssd1306_buffer_write(112,17,ttf_line_down);
	ssd1306_buffer_write(120,17,ttf_line_down);

	
}

void menu_set_params_value(uint8_t number)
{
	uint8_t index = 0;
	static uint8_t *numbers[] = {&ttf_num_0[0],&ttf_num_1[0],&ttf_num_2[0],&ttf_num_3[0],&ttf_num_4[0],&ttf_num_5[0],&ttf_num_6[0],&ttf_num_7[0],&ttf_num_8[0],&ttf_num_9[0]};
	do {
        ssd1306_buffer_write(117-8*index,15,numbers[number % 10]); // Получаем последнюю цифру
        number /= 10; // Убираем последнюю цифру
        index++;
    } while (number > 0);
}
void menu_set_item_menu(uint8_t item)
{

	switch(item)
	{
		case red:
			menu_border_item(color);
			
			ssd1306_buffer_write(15+color*8,4,ttf_eng_r);
			ssd1306_buffer_write(15+color*8+8,4,ttf_eng_e);
			ssd1306_buffer_write(15+color*8+16,4,ttf_eng_d);

			menu_set_params_value(params_value.current_red);

		break;
		case green:
			menu_border_item(color);
			
			ssd1306_buffer_write(15+color*8,4,ttf_eng_g);
			ssd1306_buffer_write(15+color*8+8,4,ttf_eng_r);
			ssd1306_buffer_write(15+color*8+16,4,ttf_eng_e);
			ssd1306_buffer_write(15+color*8+24,4,ttf_eng_e);
			ssd1306_buffer_write(15+color*8+32,4,ttf_eng_n);

			menu_set_params_value(params_value.current_green);


		break;
		case blue:
			menu_border_item(color);
			
			ssd1306_buffer_write(15+color*8,4,ttf_eng_b);
			ssd1306_buffer_write(15+color*8+8,4,ttf_eng_l);
			ssd1306_buffer_write(15+color*8+16,4,ttf_eng_u);
			ssd1306_buffer_write(15+color*8+24,4,ttf_eng_e);

			menu_set_params_value(params_value.current_blue);
		break;
		case first:
			menu_border_item(segment);
			
			ssd1306_buffer_write(15+segment*8,4,ttf_eng_f);
			ssd1306_buffer_write(15+segment*8+8,4,ttf_eng_i);
			ssd1306_buffer_write(15+segment*8+16,4,ttf_eng_r);
			ssd1306_buffer_write(15+segment*8+24,4,ttf_eng_s);
			ssd1306_buffer_write(15+segment*8+32,4,ttf_eng_t);

			menu_set_params_value(params_value.current_first);
		break;
		case second:
			menu_border_item(segment);
			
			ssd1306_buffer_write(15+segment*8,4,ttf_eng_s);
			ssd1306_buffer_write(15+segment*8+8,4,ttf_eng_e);
			ssd1306_buffer_write(15+segment*8+16,4,ttf_eng_c);
			ssd1306_buffer_write(15+segment*8+24,4,ttf_eng_o);
			ssd1306_buffer_write(15+segment*8+32,4,ttf_eng_n);
			ssd1306_buffer_write(15+segment*8+40,4,ttf_eng_d);

			menu_set_params_value(params_value.current_second);
		break;
		case sens:
			menu_border_item(settings);
			
			ssd1306_buffer_write(15+settings*8,4,ttf_eng_s);
			ssd1306_buffer_write(15+settings*8+8,4,ttf_eng_e);
			ssd1306_buffer_write(15+settings*8+16,4,ttf_eng_n);
			ssd1306_buffer_write(15+settings*8+24,4,ttf_eng_s);

			menu_set_params_value(params_value.current_sens);
		break;
		case vers:
			menu_border_item(settings);
			
			ssd1306_buffer_write(15+settings*8,4,ttf_eng_v);
			ssd1306_buffer_write(15+settings*8+8,4,ttf_eng_e);
			ssd1306_buffer_write(15+settings*8+16,4,ttf_eng_r);
			ssd1306_buffer_write(15+settings*8+24,4,ttf_eng_s);

			menu_set_params_value(params_value.current_vers);
		break;
	}

}
// void menu_switch_paragraph(uint8_t paragraph)
// {
	
// }
void menu_set_paragraph(uint8_t paragraph)
{
	switch(paragraph)
	{
		case menu:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_paragraph(menu);

			ssd1306_buffer_write(10,12,ttf_eng_m);
	    	ssd1306_buffer_write(18,12,ttf_eng_e);
	    	ssd1306_buffer_write(26,12,ttf_eng_n);
	    	ssd1306_buffer_write(34,12,ttf_eng_u);

	    	ssd1306_buffer_write(48,4,ttf_eng_c);
	    	ssd1306_buffer_write(56,4,ttf_eng_o);
	    	ssd1306_buffer_write(64,4,ttf_eng_l);
	    	ssd1306_buffer_write(72,4,ttf_eng_o);
	    	ssd1306_buffer_write(80,4,ttf_eng_r);
	    	ssd1306_buffer_write(114,4,ttf_line_left);

	    	ssd1306_buffer_write(48,12,ttf_eng_s);
	    	ssd1306_buffer_write(56,12,ttf_eng_e);
	    	ssd1306_buffer_write(64,12,ttf_eng_g);
	    	ssd1306_buffer_write(72,12,ttf_eng_m);
	    	ssd1306_buffer_write(80,12,ttf_eng_e);
	    	ssd1306_buffer_write(88,12,ttf_eng_n);
	    	ssd1306_buffer_write(96,12,ttf_eng_t);
	    	ssd1306_buffer_write(114,12,ttf_void);

	    	ssd1306_buffer_write(48,20,ttf_eng_s);
	    	ssd1306_buffer_write(56,20,ttf_eng_e);
	    	ssd1306_buffer_write(64,20,ttf_eng_t);
	    	ssd1306_buffer_write(72,20,ttf_eng_t);
	    	ssd1306_buffer_write(80,20,ttf_eng_i);
	    	ssd1306_buffer_write(88,20,ttf_eng_n);
	    	ssd1306_buffer_write(96,20,ttf_eng_g);
	    	ssd1306_buffer_write(104,20,ttf_eng_s);
	    	ssd1306_buffer_write(114,20,ttf_void);

	    	ssd1306_send_buffer();
		break;
		case color:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_paragraph(color);

			ssd1306_buffer_write(10,12,ttf_eng_c);
	    	ssd1306_buffer_write(18,12,ttf_eng_o);
	    	ssd1306_buffer_write(26,12,ttf_eng_l);
	    	ssd1306_buffer_write(34,12,ttf_eng_o);
	    	ssd1306_buffer_write(42,12,ttf_eng_r);

	    	menu_set_item_menu(red);

	    	ssd1306_send_buffer();
		break;
		case segment:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_paragraph(segment);

			ssd1306_buffer_write(10,12,ttf_eng_s);
	    	ssd1306_buffer_write(18,12,ttf_eng_e);
	    	ssd1306_buffer_write(26,12,ttf_eng_g);
	    	ssd1306_buffer_write(34,12,ttf_eng_m);
	    	ssd1306_buffer_write(42,12,ttf_eng_e);
	    	ssd1306_buffer_write(50,12,ttf_eng_n);
	    	ssd1306_buffer_write(58,12,ttf_eng_t);

	    	menu_set_item_menu(first);

	    	ssd1306_send_buffer();


		break;
		case settings:
			ssd1306_buffer_clean();
			menu_border();
			menu_border_paragraph(settings);

			ssd1306_buffer_write(10,12,ttf_eng_s);
	    	ssd1306_buffer_write(18,12,ttf_eng_e);
	    	ssd1306_buffer_write(26,12,ttf_eng_t);
	    	ssd1306_buffer_write(34,12,ttf_eng_t);
	    	ssd1306_buffer_write(42,12,ttf_eng_i);
	    	ssd1306_buffer_write(50,12,ttf_eng_n);
	    	ssd1306_buffer_write(58,12,ttf_eng_g);
	    	ssd1306_buffer_write(66,12,ttf_eng_s);

	    	menu_set_item_menu(sens);

	    	ssd1306_send_buffer();
		break;
	}
}