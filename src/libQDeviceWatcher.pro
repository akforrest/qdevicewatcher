TEMPLATE = lib
QT -= gui
CONFIG *= qdevicewatcher-buildlib

message()
message("----------------- QDeviceWatcher -----------------")

include(../qtcompilercheck.pri)

!include(libQDeviceWatcher.pri): error(could not find ibQDeviceWatcher.pri)
staticlib|isEqual(STATICLINK, 1): DEFINES += BUILD_QDEVICEWATCHER_STATIC


unix:!macx {
    SOURCES += qdevicewatcher_linux.cpp
}
else {
    macx {
        QMAKE_CXXFLAGS += -mmacosx-version-min=10.7 -std=c++11 -stdlib=libc++
        QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.11
        SOURCES += qdevicewatcher_mac.cpp
        LIBS += -framework DiskArbitration -framework Foundation
    }
}

win32 {
  wince*: SOURCES += qdevicewatcher_wince.cpp
  else:  SOURCES += qdevicewatcher_win32.cpp
  LIBS *= -luser32
}

SOURCES += qdevicewatcher.cpp


HEADERS += \
	qdevicewatcher_p.h \
	qdevicewatcher.h


