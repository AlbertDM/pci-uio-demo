# Makefile for PCIe NIC UIO Driver

# Define the kernel version
KERNEL_DIR = /lib/modules/$(shell uname -r)/build

# Name of the kernel module
MODULE_NAME = pci_uio_demo

# Source files
SRC = src/pci_uio_demo.c

# Object files
OBJ = $(SRC:.c=.o)

# Compiler options
ccflags-y := -I$(src) -Wall

# Targets
obj-m += $(MODULE_NAME).o

all: module

module: $(MODULE_NAME).ko

$(MODULE_NAME).ko: $(OBJ)
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) clean
	rm -f $(MODULE_NAME).ko
	rm -f $(OBJ)

install:
	insmod $(MODULE_NAME).ko

uninstall:
	rmmod $(MODULE_NAME)

.PHONY: all module clean install uninstall

