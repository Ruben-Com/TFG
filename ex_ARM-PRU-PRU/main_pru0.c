#include <stdint.h>
#include <stdio.h>
#include <pru_cfg.h>
#include <pru_intc.h>
#include <rsc_types.h>
#include <pru_virtqueue.h>
#include <pru_rpmsg.h>
 
#include "resource_table0.h"
#include "pru_defs.h"

#define HOST_ARM_TO_PRU0		HOST0_INT
#define HOST_PRU0_TO_PRU1		HOST1_INT

extern void start0_R(void);
extern void start0_L(void);
volatile register uint32_t __R31;
uint8_t payload[RPMSG_BUF_SIZE];

void main(void)
{
struct pru_rpmsg_transport transport;
	uint16_t src, dst, len;
	volatile uint8_t *status;

	/* allow OCP master port access by the PRU so the PRU can read external memories */
	CT_CFG.SYSCFG_bit.STANDBY_INIT = 0;

	/* clear the status of the PRU-ICSS system event that the ARM will use to 'kick' us */
	CT_INTC.SICR_bit.STS_CLR_IDX = SE_ARM_TO_PRU0;

	/* Make sure the Linux drivers are ready for RPMsg communication */
	status = &resourceTable.rpmsg_vdev.status;
	while (!(*status & VIRTIO_CONFIG_S_DRIVER_OK));

	/* Initialize pru_virtqueue corresponding to vring0 (PRU to ARM Host direction) */
	pru_virtqueue_init(&transport.virtqueue0, &resourceTable.rpmsg_vring0, SE_PRU0_TO_ARM, SE_ARM_TO_PRU0);

	/* Initialize pru_virtqueue corresponding to vring1 (ARM Host to PRU direction) */
	pru_virtqueue_init(&transport.virtqueue1, &resourceTable.rpmsg_vring1, SE_PRU0_TO_ARM, SE_ARM_TO_PRU0);

	/* Create the RPMsg channel between the PRU and ARM user space using the transport structure. */
	while (pru_rpmsg_channel(RPMSG_NS_CREATE, &transport, RPMSG_CHAN_NAME, PRU0_RPMSG_CHAN_DESC, PRU0_RPMSG_CHAN_PORT) != PRU_RPMSG_SUCCESS);
	while (1) {
		/* Check bit 30 of register R31 to see if the ARM has kicked us */
		if (check_host_int(HOST_ARM_TO_PRU0)) {
			/* Clear the event status */
			CT_INTC.SICR_bit.STS_CLR_IDX = SE_ARM_TO_PRU0;
			/* Receive all available messages, multiple messages can be sent per kick */
			while (pru_rpmsg_receive(&transport, &src, &dst, payload, &len) == PRU_RPMSG_SUCCESS) {
				if(payload[0]=='R'){
					start0_R();
					generate_sys_eve(SE_PRU0_TO_PRU1);
					pru_rpmsg_send(&transport, dst, src, "Right\n", sizeof("Right\n")/sizeof(char));
				} else if(payload[0]=='L'){
					start0_L();
					generate_sys_eve(SE_PRU0_TO_PRU1);
					pru_rpmsg_send(&transport, dst, src, "Left\n", sizeof("Left\n")/sizeof(char));
				} else{
					pru_rpmsg_send(&transport, dst, src, "Opcion invalida\n", sizeof("Opcion invalida\n")/sizeof(char));
				}
			}
		}
	}
}
