PROJ1=main_pru0
PROJ2=main_pru1
ASM1=pru0
ASM2=pru1
PRU_CGT=/usr/share/ti/cgt-pru
GEN_DIR=gen
STACK_SIZE=0x100
HEAP_SIZE=0x100
CFLAGS=--keep_asm -v3 -O2 --display_error_number --endian=little --hardware_mac=on --obj_directory=$(GEN_DIR) --pp_directory=$(GEN_DIR) -ppd -ppa
LFLAGS=--reread_libs --warn_sections --stack_size=$(STACK_SIZE) --heap_size=$(HEAP_SIZE)
LIBS=--library=libc.a --library=./lib/rpmsg_lib.lib
INCLUDE=--include_path=$(PRU_CGT)/include --include_path=./include
LINKER_COMMAND_FILE_1=./AM335x_PRU_intc.cmd
LINKER_COMMAND_FILE_2=./AM335x_PRU.cmd

all: clean conector create compile link configure load_firm

conector: conector.c
	@gcc conector.c -o conector

create:
	@echo 'Creating $(GEN_DIR) directory'
	@mkdir $(GEN_DIR)

compile:
	@echo 'Compiling project $(PROJ1) and $(PROJ2)'
	@clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(PROJ1).object $(PROJ1).c
	@clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(ASM1).object pru0.asm
	@clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(PROJ2).object $(PROJ2).c
	@clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(ASM2).object pru1.asm

link:
	@echo 'Linking project $(PROJ1) and $(PROJ2)'
	@lnkpru -i$(PRU_CGT)/lib -i$(PRU_CGT)/lib -i$(PRU_CGT)/include -o $(GEN_DIR)/$(PROJ1).out $(GEN_DIR)/$(PROJ1).object $(GEN_DIR)/$(ASM1).object $(LINKER_COMMAND_FILE_1) $(LIBS)
	@lnkpru -i$(PRU_CGT)/lib -i$(PRU_CGT)/lib -i$(PRU_CGT)/include -o $(GEN_DIR)/$(PROJ2).out $(GEN_DIR)/$(PROJ2).object $(GEN_DIR)/$(ASM2).object $(LINKER_COMMAND_FILE_1) $(LIBS)

configure:
	@echo 'Configuring P9_28-31 and P8_39-46 as pruout'
	@config-pin P8_46 pruout
	@config-pin P8_45 pruout
	@config-pin P8_44 pruout
	@config-pin P8_43 pruout
	@config-pin P8_42 pruout
	@config-pin P8_41 pruout
	@config-pin P8_40 pruout
	@config-pin P8_39 pruout
	@config-pin P8_30 pruout
	@config-pin P8_29 pruout
	@config-pin P8_28 pruout
	@config-pin P8_27 pruout
	@config-pin P8_21 pruout
	@config-pin P8_20 pruout

load_firm:
	@echo 'Loading firmware into PRU0 and PRU1'
	@cp gen/$(PROJ1).out /lib/firmware/$(PROJ1)
	@cp gen/$(PROJ2).out /lib/firmware/$(PROJ2)
	@echo $(PROJ1) > /sys/class/remoteproc/remoteproc1/firmware
	@echo $(PROJ2) > /sys/class/remoteproc/remoteproc2/firmware

start:
	@echo 'Starting PRUs'
	@echo start > /sys/class/remoteproc/remoteproc1/state
	@echo start > /sys/class/remoteproc/remoteproc2/state
	
stop:
	@echo 'Stopping PRUs'
	@echo stop > /sys/class/remoteproc/remoteproc1/state
	@echo stop > /sys/class/remoteproc/remoteproc2/state
	
clean:
	@echo 'Removing $(GEN_DIR) directory'
	@rm -rf $(GEN_DIR) $(PROJ1).asm $(PROJ2).asm
