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
# Project building
RUN /build.sh
