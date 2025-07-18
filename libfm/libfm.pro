include(../share/qtfm.pri)

greaterThan(QT_MAJOR_VERSION, 4) {
    QT += widgets concurrent
}

TARGET = QtFM
VERSION = $${QTFM_MAJOR}.$${QTFM_MINOR}.$${QTFM_PATCH}
TEMPLATE = lib

SOURCES += \
    applicationdialog.cpp \
    customactionsmanager.cpp \
    desktopfile.cpp \
    fileutils.cpp \
    mimeutils.cpp \
    properties.cpp \
    processdialog.cpp \
    progressdlg.cpp \
    icondlg.cpp \
    mymodel.cpp \
    mymodelitem.cpp \
    propertiesdlg.cpp \
    common.cpp \
    completer.cpp \
    sortmodel.cpp \
    iconview.cpp \
    iconlist.cpp \
    fm.cpp \
    bookmarkmodel.cpp

HEADERS += \
    applicationdialog.h \
    customactionsmanager.h \
    desktopfile.h \
    fileutils.h \
    mimeutils.h \
    properties.h \
    common.h \
    processdialog.h \
    progressdlg.h \
    icondlg.h \
    mymodel.h \
    mymodelitem.h \
    propertiesdlg.h \
    iconview.h \
    iconlist.h \
    completer.h \
    sortmodel.h \
    fm.h \
    bookmarkmodel.h

# qtcopydialog
#INCLUDEPATH += qtcopydialog
#SOURCES += qtcopydialog/qtcopydialog.cpp \
#           qtcopydialog/qtfilecopier.cpp
#HEADERS += qtcopydialog/qtcopydialog.h \
#           qtcopydialog/qtfilecopier.h
#FORMS   += qtcopydialog/qtcopydialog.ui \
#           qtcopydialog/qtoverwritedialog.ui \
#           qtcopydialog/qtotherdialog.ui

unix:!macx {
    DESTDIR = ../lib$${LIBSUFFIX}
    OBJECTS_DIR = $${DESTDIR}/.obj_libfm
    MOC_DIR = $${DESTDIR}/.moc_libfm
    RCC_DIR = $${DESTDIR}/.qrc_libfm

    !CONFIG(no_dbus) {
        SOURCES += \
                disks.cpp \
                udisks2.cpp
        HEADERS += \
                disks.h \
                udisks2.h \
                service.h
        QT += dbus
    }
    CONFIG(with_includes): CONFIG += create_prl no_install_prl create_pc

    target.path = $${LIBDIR}
    docs.path = $${DOCDIR}/$${QTFM_TARGET}-$${VERSION}
    docs.files += \
                ../LICENSE \
                ../README.md \
                ../AUTHORS \
                ../ChangeLog

    CONFIG(with_includes) {
        target_inc.path = $${PREFIX}/include/lib$${TARGET}
        target_inc.files = $${HEADERS}
        QMAKE_PKGCONFIG_NAME = lib$${TARGET}
        QMAKE_PKGCONFIG_DESCRIPTION = $${TARGET} library
        QMAKE_PKGCONFIG_LIBDIR = $$target.path
        QMAKE_PKGCONFIG_INCDIR = $$target_inc.path
        QMAKE_PKGCONFIG_DESTDIR = pkgconfig
    }

    INSTALLS += docs
    !CONFIG(staticlib): INSTALLS += target
    CONFIG(with_includes): INSTALLS += target_inc
}

CONFIG(with_magick): include(../share/imagemagick.pri)
CONFIG(with_ffmpeg): include(../share/ffmpeg.pri)
