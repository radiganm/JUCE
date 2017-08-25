#!/usr/bin/make
## makefile (for Juce library)
## Mac Radigan

.PHONY: clean clobber submodules libraries applications tests experimental
.DEFAULT_GOAL := all

BLDDIR=./build

all: libraries

libraries:
	$(MAKE) -f $(BLDDIR)/$@.mk

clean:
	$(MAKE) -f $(BLDDIR)/libraries.mk    $@

clobber:
	$(MAKE) -f $(BLDDIR)/libraries.mk    $@

## *EOF*
