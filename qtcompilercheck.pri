

COMPILER_VERSION=unknown

android {
    COMPILER_VERSION=gcc4.9
}
else {
    linux {
        COMPILER_VERSION=gcc5.3.1
    }
}

osx {
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
        MSVC_VER = $$(VisualStudioVersion)

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

message($${QMAKESPEC})
message(qt compiler checks: $${COMPILER_VERSION})
