#!usr/bin/make
## makefile (for Juce static library)
## Mac Radigan

.PHONY: clean clobber init
.DEFAULT_GOAL := all

include ./build/rules.mk

all: init build

build: $(LIBS)

C11SRC = \
  $(SRCDIR)/juce_opengl/juce_opengl.cpp                                                                          \
  $(SRCDIR)/juce_osc/juce_osc.cpp                                                                                \
  $(SRCDIR)/juce_audio_formats/juce_audio_formats.cpp                                                            \
  $(SRCDIR)/juce_data_structures/juce_data_structures.cpp                                                        \
  $(SRCDIR)/juce_gui_basics/juce_gui_basics.cpp                                                                  \
  $(SRCDIR)/juce_core/juce_core.cpp                                                                              \
  $(SRCDIR)/juce_gui_extra/juce_gui_extra.cpp                                                                    \
  $(SRCDIR)/juce_box2d/juce_box2d.cpp                                                                            \
  $(SRCDIR)/juce_graphics/juce_graphics.cpp                                                                      \
  $(SRCDIR)/juce_audio_basics/juce_audio_basics.cpp                                                              \
  $(SRCDIR)/juce_audio_processors/juce_audio_processors.cpp                                                      \
  $(SRCDIR)/juce_tracktion_marketplace/juce_tracktion_marketplace.cpp                                            \
  $(SRCDIR)/juce_video/juce_video.cpp                                                                            \
  $(SRCDIR)/juce_cryptography/juce_cryptography.cpp                                                              \
  $(SRCDIR)/juce_audio_utils/juce_audio_utils.cpp                                                                \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_RTAS_4.cpp                                         \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_VST3.cpp                                           \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_RTAS_1.cpp                                         \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_VST2.cpp                                           \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_Standalone.cpp                                     \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_RTAS_2.cpp                                         \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_RTAS_3.cpp                                         \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_RTAS_utils.cpp                                     \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_utils.cpp                                          \
  $(SRCDIR)/juce_audio_plugin_client/juce_audio_plugin_client_AAX.cpp                                            \
  $(SRCDIR)/juce_events/juce_events.cpp                                                                          \
  $(SRCDIR)/juce_audio_devices/juce_audio_devices.cpp                                                             
C11OBJ = $(C11SRC:.cpp=.oC11)

CMMSRC =  
CMMOBJ = $(CMMSRC:.cpp=.oCMM)

FSRC =
FOBJ = $(FSRC:.f90=.oF90)

$(LIBDIR)/lib$(TARGET).so: $(C11OBJ) $(CMMOBJ) $(FOBJ)
	$(CCC) $(C11FLAGS) -shared -o $@ $^ $(LDFLAGS)

$(LIBDIR)/lib$(TARGET).a: $(C11OBJ) $(CMMOBJ) $(FOBJ)
	ar rvs $@ $^

clean:
	-rm -f $(C11OBJ)
	-rm -f $(CMMOBJ)
	-rm -f $(FOBJ)

clobber: clean
	-rm -f $(LIBS)

## *EOF*
