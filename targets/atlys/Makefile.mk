# atlys targets

ifneq ($(PLATFORM),atlys)
	$(error "Platform should be atlys when using this file!?")
endif

# Settings
DEFAULT_TARGET = video
TARGET ?= $(DEFAULT_TARGET)

# Image
image-flash-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --flash-gateware=$(IMAGE_FILE)
	$(PLATFORM)-mode-switch --verbose --reset-gateware

# Gateware
gateware-load-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --load-gateware $(GATEWARE_FILEBASE).bit

gateware-flash-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --flash-gateware=$(GATEWARE_FILEBASE).bin
	$(PLATFORM)-mode-switch --verbose --reset-gateware

# Firmware
firmware-load-$(PLATFORM):
	flterm --port=$$($(PLATFORM)-mode-switch --get-serial-device) --kernel=$(FIRMWARE_FILEBASE).bin

firmware-flash-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --flash-softcpu-firmware=$(FIRMWARE_FILEBASE).fbi
	$(PLATFORM)-mode-switch --verbose --reset-gateware

firmware-connect-$(PLATFORM):
	flterm --port=$$($(PLATFORM)-mode-switch --get-serial-dev)

firmware-clear-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --clear-softcpu-firmware


# Bios
bios-flash-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --flash-softcpu-bios=$(BIOS_FILE)
	$(PLATFORM)-mode-switch --verbose --reset-gateware

# Extra commands
help-$(PLATFORM):
	@true

reset-$(PLATFORM):
	$(PLATFORM)-mode-switch --verbose --mode=jtag
