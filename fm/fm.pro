include(../share/qtfm.pri)

greaterThan(QT_MAJOR_VERSION, 4) {
    QT += widgets concurrent
}

TARGET = qtfm
TARGET_NAME = "QtFM"
VERSION = $${QTFM_MAJOR}.$${QTFM_MINOR}.$${QTFM_PATCH}
TEMPLATE = app

INCLUDEPATH += src ../libfm

DEFINES += APP=\"\\\"$${TARGET}\\\"\"
DEFINES += APP_NAME=\"\\\"$${TARGET_NAME}\\\"\"
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

HEADERS += \
    src/mainwindow.h \
    src/tabbar.h \
    src/settingsdialog.h

SOURCES += \
    src/main.cpp \
    src/mainwindow.cpp \
    src/bookmarks.cpp \
    src/tabbar.cpp \
    src/settingsdialog.cpp \
    src/actiondefs.cpp \
    src/actiontriggers.cpp

RESOURCES += ../share/$${TARGET}.qrc

macx {
    LIBS += -L../libfm -lQtFM -F$${PREFIX}/libexec/qt4/Library/Frameworks
    DEFINES += NO_DBUS NO_UDISKS
    RESOURCES += bundle/adwaita.qrc
    ICON = ../share/images/QtFM.icns
    QMAKE_INFO_PLIST = ../share/Info.plist
}

unix:!macx {
    DESTDIR = ../bin
    OBJECTS_DIR = $${DESTDIR}/.obj_fm
    MOC_DIR = $${DESTDIR}/.moc_fm
    RCC_DIR = $${DESTDIR}/.qrc_fm
    LIBS += -L../lib$${LIBSUFFIX} -lQtFM

    target.path = $${PREFIX}/bin
    desktop.files += $${TARGET}.desktop
    desktop.path += $${PREFIX}/share/applications
    man.files += qtfm.1
    man.path += $${MANDIR}/man1
    INSTALLS += target desktop man

    hicolor.files = ../share/hicolor
    hicolor.path = $${PREFIX}/share/icons
    INSTALLS += hicolor

    CONFIG(no_dbus) {
        DEFINES += NO_DBUS
        DEFINES += NO_UDISKS
    }
    !CONFIG(no_dbus) : QT += dbus
    !CONFIG(staticlib): QMAKE_RPATHDIR += $ORIGIN/../lib$${LIBSUFFIX}
}

CONFIG(with_magick): include(../share/imagemagick.pri)
CONFIG(with_ffmpeg): include(../share/ffmpeg.pri)
