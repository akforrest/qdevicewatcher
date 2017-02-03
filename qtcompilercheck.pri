###################################################################################
# This is a common file which, if changed, needs replicating into the following
# projects:
#   qtvlc
#   Lynx
#   Lynx-updater
#   QDeviceWatcher
#   quazip
#
#   Version 1 - 2016-09-06 - PH - Specify a common build path
#
###################################################################################

COMPILER_VERSION=unknown

android {
    COMPILER_VERSION=gcc4.9
}
else {
    linux {
        COMPILER_VERSION=gcc5.3.1
    }
}

osx|ios {
    COMPILER_VERSION=clang
}

windows {
    *-g++* {

        COMPILER_VERSION=unknownGCC

        greaterThan(QT_MAJOR_VERSION, 5) {
            COMPILER_VERSION=mingw5.3.0
        }
        else {
            greaterThan(QT_MINOR_VERSION, 6) {
                COMPILER_VERSION=mingw5.3.0
            }
            else {
                COMPILER_VERSION=mingw4.9.2
            }
        }
    }
    *-msvc* {
        COMPILER_VERSION=unknownMSVC

        isEmpty(MSVC_VER) {
            message("Finding MSVC_VER")
            MSVC_VER = $$(VisualStudioVersion)
        }

        message(MSVC_VER: $${MSVC_VER});

        equals(MSVC_VER, 14.0){
            COMPILER_VERSION=msvc2015
        }
        equals(MSVC_VER, 12.0){
            COMPILER_VERSION=msvc2013
        }

        contains(QMAKE_TARGET.arch, x86_64){
            COMPILER_VERSION=$${COMPILER_VERSION}_64
        }
        else {
            COMPILER_VERSION=$${COMPILER_VERSION}_32
        }
    }
}

CONFIG(release, debug|release) {
    DRMODE = r
}
CONFIG(debug, debug|release) {
    DRMODE = d
}

CURRENT_BUILD_OS = $$(OS)
contains(CURRENT_BUILD_OS, Windows_NT){
    message("Windows build machine")
    BUILD_LIBRARIES_ROOT = C:/Buildbot/lib
}else{
    CURRENT_HOME = $$(HOME)
    message(Current Home: $$CURRENT_HOME)
    contains (CURRENT_HOME, /home/administrator) {
        message("Linux build machine")
        CURRENT_BUILD_OS = linux
        BUILD_LIBRARIES_ROOT = /home/$$(USER)/dev/sahara/lib
    } else {
        message("OSX Build machine")
        CURRENT_BUILD_OS = OSX
        BUILD_LIBRARIES_ROOT = /Users/$$(USER)/dev/sahara/lib
    }
}

android {
    TARGET_OS = a
}
else {

    win32 {
        TARGET_OS = win

        win32-msvc* {
            TARGET_OS = winmsvc
        }
    }
    else {
        macx {
            TARGET_OS = mac
        }
        else {
            linux {
                TARGET_OS = linux
            }
            else {
                ios {
                    TARGET_OS = ios
                } else {
                    TARGET_OS = unknown
                }
            }
        }
    }
}

BUILD_PATH = _g/$${DRMODE}-$${QT_VERSION}-$${COMPILER_VERSION}-$${TARGET_OS}

MOC_DIR = $$PWD/$${BUILD_PATH}/_m
OBJECTS_DIR = $$PWD/$${BUILD_PATH}/_o
DESTDIR = $$PWD/$${BUILD_PATH}/bin
UI_DIR = $$PWD/$${BUILD_PATH}/_u
UI_SOURCES_DIR = $$PWD/$${BUILD_PATH}/_u
RCC_DIR = $$PWD/$${BUILD_PATH}/_r

message("QMAKESPEC:" $${QMAKESPEC})
message(Compiler version: $${COMPILER_VERSION})
message(Qt version: $${QT_VERSION})
message(Dependency root: $${BUILD_LIBRARIES_ROOT})
