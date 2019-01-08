FROM base/archlinux:latest
LABEL maintainer="marlock@etlgr.com"

# Updating base system
RUN pacman -Syu --noconfirm
# Installing deps
RUN pacman -S --noconfirm\
        make\
        cmake\
        gcc\
        glew\
        freeimage\
        lockfile-progs\
        openal\
        intel-tbb\
        crypto++\
        pugixml\
        libtheora\
        libvorbis\
        sdl2\
        lzo\
        libjpeg-turbo\
        git

# Project cloning
RUN git clone https://github.com/OpenXRay/xray-16.git --recurse-submodules

COPY build.sh /
RUN /bin/sh -c 'echo "make -j$(nproc)" >> /build.sh'

# Project building
RUN /build.sh
COPY install.sh /
RUN /install.sh

# Project packaging
RUN mkdir /game-pkgbuild
RUN pacman -S --noconfirm audit fakeroot
RUN useradd -m utemp && chmod 777 /game-pkgbuild
COPY ./PKGBUILD /game-pkgbuild
COPY ./pkg.sh /
RUN su - utemp -c '/pkg.sh'
