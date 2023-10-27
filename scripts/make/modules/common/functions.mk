#!make

# Define the function to read phony targets
define read_phony_targets
$(shell cat $(dir $(lastword $(MAKEFILE_LIST)))$(1))
endef
