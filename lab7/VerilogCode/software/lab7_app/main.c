typedef unsigned int uint32_t;
typedef struct
{
	uint32_t volatile data;
	uint32_t volatile direction;
	uint32_t volatile interruptmask;
	uint32_t volatile edgecapture;
	uint32_t volatile outset;
	uint32_t volatile outclear;
}NIOS_PIO;




int main()
{
	unsigned int accumulate = 0;
	uint32_t pressed = 0x0000;
	uint32_t unpressed = 0x0001;
	NIOS_PIO* LED_PIO= (NIOS_PIO*)0x90; //make a pointer to access the LED PIO block
	NIOS_PIO* ACCUM = (NIOS_PIO*)0x70; //pointer to accumulate key
	NIOS_PIO* ARESET = (NIOS_PIO*) 0x60;
	NIOS_PIO* SW = (NIOS_PIO*) 0x80;

	LED_PIO->data = 0; //clear all LEDs
	while (1) //infinite loop
	{
		if(ARESET->data == pressed)
		{
			accumulate = 0;
		}

		if(ACCUM->data == pressed)
		{
			//accumulate += SW->data;
			accumulate += SW->data;
			if(accumulate > 255)
			{
				accumulate -= 256;
			}
			while(1)
			{
				if(ACCUM->data == unpressed) break;
			}
		}
		LED_PIO->data =  accumulate;

		/*for (i = 0; i < 100000; i++); //software delay
		LED_PIO->data |= 0x1; //set LSB
		for (i = 0; i < 100000; i++); //software delay
		LED_PIO->data &= ~0x1; //clear LSB */
	}
	return 1; //never gets here
}
