ARG DISTRO_VERSION=38

FROM fedora:${DISTRO_VERSION} as single
MAINTAINER Matthias Kuhn <matthias@opengis.ch>

RUN dnf -y --refresh install \
    bison \
    ccache \
    clang \
    clazy \
    curl \
    exiv2-devel \
    expat-devel \
    fcgi-devel \
    flex \
    git \
    gdal-devel \
    geos-devel \
    gpsbabel \
    grass \
    grass-devel \
    gsl-devel \
    libpq-devel \
    libspatialite-devel \
    libxml2-devel \
    libzip-devel \
    libzstd-devel \
    netcdf-devel \
    ninja-build \
    ocl-icd-devel \
    PDAL \
    PDAL-libs \
    PDAL-devel \
    proj-devel \
    protobuf-devel \
    protobuf-lite-devel \
    python3-devel \
    python3-termcolor \
    qca-qt6-devel \
    qt6-qt3d-devel \
    qt6-qtbase-devel \
    qt6-qtbase-private-devel \
    qt6-qtdeclarative-devel \
    qt6-qttools-static \
    qt6-qtserialport-devel \
    qt6-qtsvg-devel \
    qt6-qtpositioning-devel \
    qt6-qtdeclarative-devel \
    qt6-qt5compat-devel \
    qt6-qtmultimedia-devel \
    qtkeychain-qt6-devel \
    qwt-qt6-devel \
    qscintilla-qt6-devel \
    spatialindex-devel \
    sqlite-devel \
    unzip \
    unixODBC-devel \
    xorg-x11-server-Xvfb \
    util-linux \
    wget \
    openssl-devel \
    libsecret-devel \
    make \
    automake \
    gcc \
    gcc-c++ \
    kernel-devel \
    ninja-build \
    patch \
    dos2unix

# Workaround https://bugreports.qt.io/browse/QTBUG-113227 for now, roll back to qt 6.4
RUN dnf -y downgrade qt6-qtbase-6.4.3-1.fc38 qt6-qt3d-6.4.3-1.fc38 qt6-qtdeclarative.6.4.3-1.fc38 qt6-qtserialport.6.4.3-1.fc38 qt6-qtsvg.6.4.3-1.fc38 qt6-qtpositioning.6.4.3-1.fc38  qt6-qtdeclarative.6.4.3-1.fc38 qt6-qt5compat-6.4.3-1.fc38  qt6-qtmultimedia.6.4.3-1.fc38 --allowerasing

# Oracle : client side
RUN curl https://download.oracle.com/otn_software/linux/instantclient/199000/instantclient-basic-linux.x64-19.9.0.0.0dbru.zip > instantclient-basic-linux.x64-19.9.0.0.0dbru.zip
RUN curl https://download.oracle.com/otn_software/linux/instantclient/199000/instantclient-sdk-linux.x64-19.9.0.0.0dbru.zip > instantclient-sdk-linux.x64-19.9.0.0.0dbru.zip
RUN curl https://download.oracle.com/otn_software/linux/instantclient/199000/instantclient-sqlplus-linux.x64-19.9.0.0.0dbru.zip > instantclient-sqlplus-linux.x64-19.9.0.0.0dbru.zip

RUN unzip instantclient-basic-linux.x64-19.9.0.0.0dbru.zip
RUN unzip instantclient-sdk-linux.x64-19.9.0.0.0dbru.zip
RUN unzip instantclient-sqlplus-linux.x64-19.9.0.0.0dbru.zip

ENV PATH="/instantclient_19_9:${PATH}"
ENV LD_LIBRARY_PATH="/instantclient_19_9:${LD_LIBRARY_PATH}"
