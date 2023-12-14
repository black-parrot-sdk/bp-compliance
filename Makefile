
TOP                ?= $(shell git rev-parse --show-toplevel)
BP_SDK_DIR         ?= $(TOP)/..
BP_SDK_INSTALL_DIR ?= $(BP_SDK_DIR)/install
BP_SDK_BIN_DIR     ?= $(BP_SDK_INSTALL_DIR)/bin
PATH               := $(BP_SDK_BIN_DIR):$(PATH)
COMPLIANCE_DIR     ?= $(BP_SDK_DIR)/compliance

RISCOF ?= riscof
FIND ?= find
WORKDIR ?= riscof_work/
ELFDIR ?= riscof
MKDIR ?= mkdir

all:
	$(MKDIR) -p $(ELFDIR)
	$(RISCOF) --verbose info run \
		--suite $(COMPLIANCE_DIR)/riscv-arch-test/riscv-test-suite/rv64i_m \
		--env $(COMPLIANCE_DIR)/env/ \
		--work-dir $(WORKDIR)
	$(FIND) $(WORKDIR) -mindepth 3 -maxdepth 3 -type d \
		-exec sh -c 'cp $$1/dut/main.elf $(ELFDIR)/$$(basename "$$1").riscv' sh {} \;

clean:
	rm -rf $(WORKDIR)
	rm -rf $(ELFDIR)

