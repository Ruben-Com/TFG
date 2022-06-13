#include <stdint.h>
#include <stdio.h>
#include <pru_cfg.h>
#include <pru_intc.h>
#include <rsc_types.h>
#include <pru_virtqueue.h>
#include <pru_rpmsg.h>
 
#include "resource_table1.h"
#include "pru_defs.h"

#define HOST_ARM_TO_PRU0		HOST0_INT
#define HOST_PRU0_TO_PRU1		HOST1_INT

extern void start1(void);
volatile register uint32_t __R31;
uint8_t payload[RPMSG_BUF_SIZE];


void main(void)
{
	while (1) {
		if (check_host_int(HOST_PRU0_TO_PRU1)){
			CT_INTC.SICR_bit.STS_CLR_IDX = SE_PRU0_TO_PRU1;
			start1();
		}
	}
}
