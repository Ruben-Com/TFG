PRU_CGT=/usr/share/ti/cgt-pru
LINKER_COMMAND_FILE=./AM335x_PRU.cmd
LIBS=--library=./lib/rpmsg_lib.lib
INCLUDE=--include_path=./include
STACK_SIZE=0x100
HEAP_SIZE=0x100


CFLAGS=-v3 -O2 --display_error_number --endian=little --hardware_mac=on --obj_directory=$(GEN_DIR) --pp_directory=$(GEN_DIR) -ppd -ppa
LFLAGS=--reread_libs --warn_sections --stack_size=$(STACK_SIZE) --heap_size=$(HEAP_SIZE)


GEN_DIR=gen

PRU1_FW=$(GEN_DIR)/main_pru1_fw.out
PRU0_FW=$(GEN_DIR)/main_pru0_fw.out

TARGETS		=$(PRU1_FW) $(PRU0_FW)

# add the required files while linkin the FW code
# required linking files for PRU1
# LINK_PRU1_FW = (GEN_DIR)/pru1-inline-asm.object (GEN_DIR)/code2_pru1.object
LINK_PRU1_FW=

# required linking files for PRU1
# LINK_PRU0_FW = (GEN_DIR)/pru0-inline-asm.object (GEN_DIR)/code2_pru1.object
LINK_PRU0_FW=


all: $(TARGETS) firmware
	@echo '-	Generated firmwares are : $^'


$(PRU1_FW): $(GEN_DIR)/main_pru1.object $(LINK_PRU1_FW)
	@echo 'LD	$^'
	@$(PRU_CGT)/bin/lnkpru -i$(PRU_CGT)/lib -i$(PRU_CGT)/include $(LFLAGS) -o $@ $^  $(LINKER_COMMAND_FILE) --library=libc.a $(LIBS) $^


$(PRU0_FW): $(GEN_DIR)/main_pru0.object $(LINK_PRU0_FW)
	@echo 'LD	$^' 
	@$(PRU_CGT)/bin/lnkpru -i$(PRU_CGT)/lib -i$(PRU_CGT)/include $(LFLAGS) -o $@ $^  $(LINKER_COMMAND_FILE) --library=libc.a $(LIBS) $^


$(GEN_DIR)/main_pru0.object: main_pru0.c 
	@mkdir -p $(GEN_DIR)
	@echo 'CC	$<'
	@$(PRU_CGT)/bin/clpru --include_path=$(PRU_CGT)/include $(INCLUDE) $(CFLAGS) -fe $@ $<


$(GEN_DIR)/main_pru1.object: main_pru1.c
	@mkdir -p $(GEN_DIR)
	@echo 'CC	$<'
	@$(PRU_CGT)/bin/clpru --include_path=$(PRU_CGT)/include $(INCLUDE) $(CFLAGS) -fe $@ $<


firmware:
	@echo '-	copying firmware to /lib/firmware/'
	@cp $(PRU0_FW) /lib/firmware/main_pru0
	@cp $(PRU1_FW) /lib/firmware/main_pru1
	@echo '-	echoing firmware to /sys/class/remoteproc/remoteprocN/'
	@echo 'main_pru0' > /sys/class/remoteproc/remoteproc1/firmware
	@echo 'main_pru1' > /sys/class/remoteproc/remoteproc2/firmware

start_prus:
	@echo 'Starting PRUs'
	@echo start > /sys/class/remoteproc/remoteproc1/state
	@echo start > /sys/class/remoteproc/remoteproc2/state
	
stop_prus:
	@echo 'Stopping PRUs'
	@echo stop > /sys/class/remoteproc/remoteproc1/state
	@echo stop > /sys/class/remoteproc/remoteproc2/state

clean:
	@echo 'CLEAN	.'
	@rm -rf $(GEN_DIR)
