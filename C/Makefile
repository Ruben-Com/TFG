PROJ=PRU_gpioToggle
PRU_CGT=/usr/share/ti/cgt-pru
GEN_DIR=gen
STACK_SIZE=0x100
HEAP_SIZE=0x100
CFLAGS=--keep_asm -v3 -O2 --display_error_number --endian=little --hardware_mac=on --obj_directory=$(GEN_DIR) --pp_directory=$(GEN_DIR) -ppd -ppa
LFLAGS=--reread_libs --warn_sections --stack_size=$(STACK_SIZE) --heap_size=$(HEAP_SIZE)
LIBS=--library=libc.a --library=./lib/rpmsg_lib.lib
INCLUDE=--include_path=$(PRU_CGT)/include --include_path=./include
LINKER_COMMAND_FILE=./AM335x_PRU.cmd

all: clean create compile link configure load_firm

create:
	@echo 'Creating $(GEN_DIR) directory'
	@mkdir $(GEN_DIR)

compile:
	@echo 'Compiling project $(PROJ)'
	@$(PRU_CGT)/bin/clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(PROJ).object $(PROJ).c

link:
	@echo 'Linking project $(PROJ)'
	@$(PRU_CGT)/bin/clpru $(CFLAGS) -z -i$(PRU_CGT)/lib -i$(PRU_CGT)/include -o $(GEN_DIR)/$(PROJ).out $(GEN_DIR)/$(PROJ).object -m$(GEN_DIR)/$(PROJ).map $(LINKER_COMMAND_FILE) $(LIBS)

configure:
	@echo 'Configuring P9_28-31 and P8_39-46 as pruout'
	@config-pin P9_31 pruout
	@config-pin P9_30 pruout
	@config-pin P9_29 pruout
	@config-pin P9_28 pruout
	@config-pin P8_46 pruout
	@config-pin P8_45 pruout
	@config-pin P8_44 pruout
	@config-pin P8_43 pruout
	@config-pin P8_42 pruout
	@config-pin P8_41 pruout
	@config-pin P8_40 pruout
	@config-pin P8_39 pruout

load_firm:
	@echo 'Loading firmware into PRU0 and PRU1'
	@cp gen/$(PROJ).out /lib/firmware/$(PROJ)
	@echo $(PROJ) > /sys/class/remoteproc/remoteproc1/firmware
	@echo $(PROJ) > /sys/class/remoteproc/remoteproc2/firmware

start_prus:
	@echo 'Starting PRUs'
	@echo start > /sys/class/remoteproc/remoteproc1/state
	@echo start > /sys/class/remoteproc/remoteproc2/state

stop_prus:
	@echo 'Stopping PRUs'
	@echo stop > /sys/class/remoteproc/remoteproc1/state
	@echo stop > /sys/class/remoteproc/remoteproc2/state

clean:
	@echo 'Removing $(GEN_DIR) directory'
	@rm -rf $(GEN_DIR) $(PROJ).asm
