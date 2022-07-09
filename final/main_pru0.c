/* Source Modified by Rubén Comerón Galán < Batuecas12 - rubencg2000@hotmail.es >
 * Based on the examples distributed by TI
 *
 * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
 *
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *	* Redistributions of source code must retain the above copyright
 *	  notice, this list of conditions and the following disclaimer.
 *
 *	* Redistributions in binary form must reproduce the above copyright
 *	  notice, this list of conditions and the following disclaimer in the
 *	  documentation and/or other materials provided with the
 *	  distribution.
 *
 *	* Neither the name of Texas Instruments Incorporated nor the names of
 *	  its contributors may be used to endorse or promote products derived
 *	  from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#include <stdint.h>
#include <stdlib.h>
#include <string.h>
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

extern void start0_F(uint16_t);
extern void start0_P(uint16_t);
extern void start0_S(uint16_t);
extern void start0_D(uint16_t);
extern void start0_T(uint16_t);
extern void start0_W(uint16_t);
extern void start0_R(void);
extern void start0_I(void);
extern void start0_H(void);
volatile register uint32_t __R31;
uint8_t payload[RPMSG_BUF_SIZE];

void main(void)
{
struct pru_rpmsg_transport transport;
	uint16_t src, dst, len, param;
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
				if(payload[0]=='F'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_valor_fijo\n", sizeof("Mostrando_valor_fijo\n"));
					param = atoi(&payload[1]);
					start0_F(param);
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_valor_fijo\n", sizeof("Mostrando_valor_fijo\n"));
				} else if(payload[0]=='P'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_un_pulso\n", sizeof("Mostrando_un_pulso\n"));
					param = atoi(&payload[1]);
					start0_P(param);
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_un_pulso\n", sizeof("Mostrando_un_pulso\n"));
				} else if(payload[0]=='S'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_senal_senoidal\n", sizeof("Mostrando_senal_senoidal\n"));
					param = atoi(&payload[1]);
					start0_S(param);
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_senal_senoidal\n", sizeof("Mostrando_senal_senoidal\n"));
				} else if(payload[0]=='D'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_diente_de_sierra\n", sizeof("Mostrando_diente_de_sierra\n"));
					param = atoi(&payload[1]);
					start0_D(param);
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_diente_de_sierra\n", sizeof("Mostrando_diente_de_sierra\n"));
				} else if(payload[0]=='T'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_senal_triangular\n", sizeof("Mostrando_senal_triangular\n"));
					param = atoi(&payload[1]);
					start0_T(param);
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_senal_triangular\n", sizeof("Mostrando_senal_triangular\n"));
				} else if(payload[0]=='W'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_senal_pwm\n", sizeof("Mostrando_senal_pwm\n"));
					param = atoi(&payload[1]);
					start0_W(param);
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_senal_pwm\n", sizeof("Mostrando_senal_pwm\n"));
				} else if(payload[0]=='R'){
					start0_I();				//interrumpir antes de cambiar la senal
					generate_sys_eve(SE_PRU0_TO_PRU1);	//interrumpir antes de cambiar la senal
					pru_rpmsg_send(&transport, dst, src, "Mostrando_un_pulso_de_radiacion\n", sizeof("Mostrando_un_pulso_de_radiacion\n"));
					start0_R();
					generate_sys_eve(SE_PRU0_TO_PRU1);
					//pru_rpmsg_send(&transport, dst, src, "Mostrando_un_pulso\n", sizeof("Mostrando_un_pulso\n"));
				} else if(payload[0]=='I'){
					start0_I();
					generate_sys_eve(SE_PRU0_TO_PRU1);
					pru_rpmsg_send(&transport, dst, src, "Interrumpiendo_senal\n", sizeof("Interrumpiendo_senal\n"));
				} else if(payload[0]=='H'){
					start0_H();
					generate_sys_eve(SE_PRU0_TO_PRU1);
					pru_rpmsg_send(&transport, dst, src, "Apagando_PRUs\n", sizeof("Apagando_PRUs\n"));
					__halt();
				} else{
					pru_rpmsg_send(&transport, dst, src, "Opcion_no_valida\n", sizeof("Opcion_no_valida\n"));
				}
			}
		}
	}
}
