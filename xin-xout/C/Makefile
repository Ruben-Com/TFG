PROJ1=PRU0_Direct_Connect
PROJ2=PRU1_Direct_Connect
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

all: clean create compile link configure

create:
	echo 'Creating $(GEN_DIR) directory'
	mkdir $(GEN_DIR)
	echo ''

compile:
	echo 'Compiling project $(PROJ1) and $(PROJ2)'
	$(PRU_CGT)/bin/clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(PROJ1).object $(PROJ1).c
	$(PRU_CGT)/bin/clpru $(INCLUDE) $(CFLAGS) -fe $(GEN_DIR)/$(PROJ2).object $(PROJ2).c
	echo ''

link:
	echo 'Linking project $(PROJ1) and $(PROJ2)'
	$(PRU_CGT)/bin/clpru $(CFLAGS) -z -i$(PRU_CGT)/lib -i$(PRU_CGT)/include -o $(GEN_DIR)/$(PROJ1).out $(GEN_DIR)/$(PROJ1).object -m$(GEN_DIR)/$(PROJ1).map $(LINKER_COMMAND_FILE_1) $(LIBS)
	$(PRU_CGT)/bin/clpru $(CFLAGS) -z -i$(PRU_CGT)/lib -i$(PRU_CGT)/include -o $(GEN_DIR)/$(PROJ2).out $(GEN_DIR)/$(PROJ2).object -m$(GEN_DIR)/$(PROJ2).map $(LINKER_COMMAND_FILE_2) $(LIBS)
	echo ''

configure:
	echo 'Configuring P9_28-31 and P8_43-46 as pruout'
	config-pin P9_31 pruout
	config-pin P9_30 pruout
	config-pin P9_29 pruout
	config-pin P9_28 pruout
	config-pin P8_46 pruout
	config-pin P8_45 pruout
	config-pin P8_44 pruout
	config-pin P8_43 pruout
	echo ''

load_firm:
	echo 'Loading firmware into PRU0 and PRU1'
	cp gen/$(PROJ1).out /lib/firmware/$(PROJ1)
	cp gen/$(PROJ2).out /lib/firmware/$(PROJ2)
	echo $(PROJ1) > /sys/class/remoteproc/remoteproc1/firmware
	echo $(PROJ2) > /sys/class/remoteproc/remoteproc2/firmware
	echo ''

prus_start:
	echo 'Starting PRUs'
	echo start > /sys/class/remoteproc/remoteproc1/state
	echo start > /sys/class/remoteproc/remoteproc2/state
	echo ''
	
prus_stop:
	echo 'Stopping PRUs'
	echo stop > /sys/class/remoteproc/remoteproc1/state
	echo stop > /sys/class/remoteproc/remoteproc2/state
	echo ''
	
todo: prus_stop clean all load_firm prus_start
casi_todo: clean all load_firm prus_start

clean:
	echo 'Removing $(GEN_DIR) directory'
	rm -rf $(GEN_DIR) $(PROJ1).asm $(PROJ2).asm
	echo ''
