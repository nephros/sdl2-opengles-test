
PACKAGE := sdl3-opengles-test

SOURCES := $(wildcard main_*.cpp)
TARGETS := $(patsubst main_%.cpp,sdl3_%_test,$(SOURCES))
DESKTOPS := $(patsubst %,%.desktop,$(TARGETS))

DESTDIR ?=
PREFIX ?= /usr

BASEDATADIR := $(PREFIX)/share/
DATADIR_IMAGE := $(BASEDATADIR)/sdl3_image_test/
DATADIR_JOYSTICK := $(BASEDATADIR)/sdl3_joystick_test/
DATADIR_MIXER := $(BASEDATADIR)/sdl3_mixer_test/
DATADIR_TTF := $(BASEDATADIR)/sdl3_ttf_test/

CXXFLAGS ?= -g
CXXFLAGS += -DDATADIR_IMAGE=\"$(DATADIR_IMAGE)\"\
            -DDATADIR_JOYSTICK=\"$(DATADIR_JOYSTICK)\"\
            -DDATADIR_MIXER=\"$(DATADIR_MIXER)\"\
            -DDATADIR_TTF=\"$(DATADIR_TTF)\"

all: $(TARGETS)

#sdl2_opengles1_test: main_opengles1.cpp common.cpp
#	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv1_cm)

sdl3_opengles2_test: main_opengles2.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv2)

sdl3_image_test: main_image.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv1_cm sdl3-image)

sdl3_ttf_test: main_ttf.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv1_cm sdl3-ttf)

sdl3_joystick_test: main_joystick.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv1_cm sdl3-ttf)

sdl3_mixer_test: main_mixer.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv1_cm sdl3-mixer audioresource glib-2.0)

#sdl3_gles1_procaddr_test: main_gles1_procaddr.cpp common.cpp
#	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv1_cm egl) -ldl

sdl3_gles2_procaddr_test: main_gles2_procaddr.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3 glesv2 egl) -ldl

sdl3_renderer_test: main_renderer.cpp common.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell pkg-config --libs --cflags sdl3)

install: $(TARGETS) $(DESKTOPS)
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -d $(DESTDIR)$(PREFIX)/share/applications/
	install -d $(DESTDIR)$(DATADIR_IMAGE)
	install -d $(DESTDIR)$(DATADIR_JOYSTICK)
	install -d $(DESTDIR)$(DATADIR_MIXER)
	install -d $(DESTDIR)$(DATADIR_TTF)
	install -m755 $(TARGETS) $(DESTDIR)$(PREFIX)/bin/
	install -m644 $(DESKTOPS) $(DESTDIR)$(PREFIX)/share/applications/
	install -m644 images/* $(DESTDIR)$(DATADIR_IMAGE)
	install -m644 fonts/* $(DESTDIR)$(DATADIR_JOYSTICK)
	install -m644 sounds/* $(DESTDIR)$(DATADIR_MIXER)
	install -m644 fonts/* $(DESTDIR)$(DATADIR_TTF)

clean:
	rm -f $(TARGETS)

.PHONY: all install clean

