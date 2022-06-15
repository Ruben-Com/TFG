main_pru1.c is the C program that loads the assembly code in pru1-asm-blinky.asm.
pru1-asm-blinky.asm is an loop in assembly code that alternates between high level and low level in register 30 bits.

For compiling, linking, configuring pins and loading the firmware (only possible with PRUs stopped) execute:
sudo make

For starting the PRUs execute:
sudo make start_prus

For stopping the PRUs execute:
sudo make stop_prus

For removing the compilation results and directory (gen) execute:
sudo make clean

For creating the directory for compilation files (gen) execute:
sudo make create

For compiling execute:
sudo make compile

For linking execute:
sudo make link

For configuring from P9_28 to P9_31 and P8_39 to P8_46 execute:
sudo make configure

For loading the firmware execute:
sudo make load_firm