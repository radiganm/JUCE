#!/usr/bin/make
## makefile (for Juce static library)
## Mac Radigan

.PHONY: clean clobber init
.DEFAULT_GOAL := all

all: build

VPATH = ./modules

CCC = g++
FC = gfortran
CYC = cython
CMM = cython

BINDIR    = ./bin
SRCDIR    = ./modules
LIBDIR    = ./lib
TESTDIR   = ./tests
SCRIPTDIR = ./scripts
FMODDIR   = ./mod
MODDIR    = ./$(SRCDIR)/modules
APPDIR    = ./$(SRCDIR)/apps
TESTSDIR  = ./$(SRCDIR)/tests
SUBDIR    = ./submodules

TARGET = juce

LIBS = \
  $(LIBDIR)/lib$(TARGET).a  \
  $(LIBDIR)/lib$(TARGET).so

ARCH = -m64
ININC =                                                                                \
  -I$(SRCDIR)                                                                          \

EXINC =
INC = -I./include
JUCE_DEFINES =                           \
  -DJUCE_GLOBAL_MODULE_SETTINGS_INCLUDED \
  -DJucePlugin_Build_VST                 \
  -DJucePlugin_Build_VST3                \
  -DJucePlugin_Build_AU                  \
  -DJucePlugin_Build_AUv3                \
  -DJucePlugin_Build_RTAS                \
  -DJucePlugin_Build_AAX                 \
  -DJucePlugin_Build_Standalone          \
  -DJucePlugin_Build_LV2

CFLAGS = -fPIC -O2 $(ARCH) -g3 $(INC) $(ININC) $(EXINC) 
C11FLAGS = -fPIC -O2 $(ARCH) -g3 -std=c++11 $(INC) $(ININC) $(EXINC) $(JUCE_DEFINES)
CMMFLAGS = -fPIC -O2 $(ARCH) -g3 -x objective-c++ -std=c++11 $(INC) $(ININC) $(EXINC) $(JUCE_DEFINES)
FFLAGS = -J$(FMODDIR) -cpp -fPIC -O2 $(ARCH) -g3 $(INC) $(ININC) $(JUCE_DEFINES)
LIBPATH = \
  -L/lib/x86_64-linux-gnu \
  -L/usr/lib/x86_64-linux-gnu
EXLIBS = \
  -lm \
  -ldl \
  -pthread
INLIBS = 
LDFLAGS = -O2 $(ARCH) -g $(LIBPATH) $(INLIBS) $(EXLIBS) $(LIBDIR)/lib$(TARGET).a

init:
	@-mkdir -p $(LIBDIR)

%.oMM: %.mm
	$(CMM) $(CMMFLAGS) -c -o $@ $^

%.oC11: %.cpp
	$(CCC) $(C11FLAGS) -c -o $@ $^

%.oF90: %.f90
	$(FC) $(FFLAGS) -c -o $@ $^

## *EOF*
