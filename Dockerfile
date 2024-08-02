FROM ubuntu:nobel
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y build-essential wget curl git python3 net-tools nano cmake \
    gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    automake autoconf texinfo libtool libftdi-dev libusb-1.0-0-d

RUN mkdir /opt/pico-sdk && cd /opt/pico-sdk && \
    git clone https://github.com/raspberrypi/pico-sdk . && git submodule update --init --recursive

RUN mkdir /opt/openocd && cd /opt/openocd && \
    git clone https://github.com/raspberrypi/openocd --branch rp2040 . && git submodule update --init --recursive && \
    ./bootstrap && ./configure --enable-cmsis-dap && make -j4 && make install

RUN mkdir /opt/pico-lab && cd /opt/pico-lab && \
    git clone https://github.com/wuxx/pico-lab . && source ./tools/env.sh
