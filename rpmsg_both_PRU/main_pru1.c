#include <stdint.h>
#include <pru_cfg.h>
#include "resource_table_pru1.h"


volatile register uint32_t __R30;
volatile register uint32_t __R31;

void main(void)
{

	while (1) {
		generate_sys_eve(SE_PRU1_TO_PRU0);			
		__delay_cycles(1000000000);
	}
}

