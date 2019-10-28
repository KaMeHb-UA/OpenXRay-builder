FROM debian

RUN apt update && \
    apt install -y gcc g++ git cmake libglew-dev libfreeimage-dev libfreeimageplus-dev liblockfile-dev libopenal-dev libtbb-dev libcrypto++-dev libogg-dev libtheora-dev libvorbis-dev libsdl2-dev liblzo2-dev libjpeg-dev libreadline-dev && \
    rm -rf /var/cache

RUN git clone https://github.com/OpenXRay/xray-16.git --recursive /xray-16

WORKDIR /xray-16

# cleanup local cache if exist
ENTRYPOINT rm -rf bin && \
    git pull && \
    git submodule update --init --recursive && \
    mkdir bin && \
    cd bin && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc --all) && \
    make DESTDIR=/opt/OpenXRay install
