#!make

# 	Read .PHONY targets from an ?.phony file.
define read_phony_targets
$(shell cat $(dir $(lastword $(MAKEFILE_LIST)))$(1))
endef

# 	Recursively searches through a directory and its subdirectories for files matching a specified pattern, returning a list of all matching files.
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))


