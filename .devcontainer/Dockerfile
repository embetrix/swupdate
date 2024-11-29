FROM debian:12

RUN dpkg --add-architecture armhf && apt-get update
RUN dpkg --add-architecture arm64 && apt-get update
RUN apt-get install --no-install-recommends -y \
        build-essential \
        crossbuild-essential-armhf \
        crossbuild-essential-arm64 \
        gdb-multiarch \
        cmake \
        ccache \
        cpio \
        gawk \
        meson \
        ninja-build \
        wget \
        qemu-user \
        git-core \
        git-man \
        git-email \
        sudo \
        nano \
        vim \
        curl \
        openssh-client \
        bash-completion \
        python3 \
        python3-pip \
        python3-requests \
        python3-websockets \
        python3-termcolor

# Install swupdate native dependencies
RUN apt-get install --no-install-recommends -y \
        libefiboot-dev \
        libebgenv-dev \
        libmtd-dev \
        libubi-dev \
        libzck-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libwolfssl-dev  \
        libsystemd-dev \
        libjson-c-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libarchive-dev \
        libzmq3-dev  \
        libconfig-dev \
        libz-dev \
        libyaml-dev \
        libmbedtls-dev \
        libfdisk-dev \
        librsync-dev \
        libgpiod-dev \
        liburiparser-dev \
        libudev-dev \
        libblkid-dev \
        libext2fs-dev \
        libbtrfsutil-dev \
        liblua5.2-dev \
        libcmocka-dev \
        libzstd-dev \
        libwebsockets-dev

# remove conflicting file(s)
#RUN mv /usr/include/lws_config.h /usr/include/lws_config.h.amd64

# Install swupdate dependencies for armhf
# RUN apt-get install --no-install-recommends -y \
#         libefiboot-dev:armhf  \
#         libebgenv-dev:armhf  \
#         libmtd-dev:armhf  \
#         libubi-dev:armhf  \
#         libzck-dev:armhf  \
#         libcurl4-openssl-dev:armhf  \
#         libssl-dev:armhf  \
#         libwolfssl-dev:armhf  \
#         libsystemd-dev:armhf  \
#         libjson-c-dev:armhf  \
#         libncurses5-dev:armhf  \
#         libncursesw5-dev:armhf  \
#         libarchive-dev:armhf  \
#         libzmq3-dev:armhf  \
#         libconfig-dev:armhf \
#         libz-dev:armhf \
#         libyaml-dev:armhf \
#         libmbedtls-dev:armhf \
#         libfdisk-dev:armhf \
#         librsync-dev:armhf \
#         libgpiod-dev:armhf \
#         liburiparser-dev:armhf \
#         libudev-dev:armhf \
#         libblkid-dev:armhf \
#         libext2fs-dev:armhf \
#         libbtrfsutil-dev:armhf \
#         lua5.2-dev:armhf \
#         libcmocka-dev:armhf \
#         libzstd-dev:armhf \
#         libwebsockets-dev:armhf

# remove conflicting file(s)
#RUN mv /usr/include/lws_config.h /usr/include/lws_config.h.armhf


# Install swupdate dependencies for arm64
# RUN apt-get install --no-install-recommends -y \
#         libefiboot-dev:arm64  \
#         libebgenv-dev:arm64  \
#         libmtd-dev:arm64  \
#         libubi-dev:arm64  \
#         libzck-dev:arm64  \
#         libcurl4-openssl-dev:arm64  \
#         libssl-dev:arm64  \
#         libwolfssl-dev:arm64  \
#         libsystemd-dev:arm64  \
#         libjson-c-dev:arm64  \
#         libncurses5-dev:arm64  \
#         libncursesw5-dev:arm64  \
#         libarchive-dev:arm64  \
#         libzmq3-dev:arm64  \
#         libconfig-dev:arm64  \
#         libz-dev:arm64 \
#         libyaml-dev:arm64 \
#         libmbedtls-dev:arm64 \
#         libfdisk-dev:arm64 \
#         librsync-dev:armhf \
#         libgpiod-dev:arm64 \
#         liburiparser-dev:arm64 \
#         libudev-dev:arm64 \
#         libblkid-dev:arm64 \
#         libext2fs-dev:arm64 \
#         libbtrfsutil-dev:arm64 \
#         libcmocka-dev:arm64 \
#         lua5.2-dev:arm64 \
#         libzstd-dev:arm64 \
#         libwebsockets-dev:arm64


# Install libubootenv library (new version not available in debian)
# for native, armhf and amd64
ENV LIBUBOOTENV_VERSION=v0.3.6
RUN git clone -b $LIBUBOOTENV_VERSION https://github.com/sbabic/libubootenv.git && \
        cd libubootenv && \
        cmake -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu \
              -DCMAKE_INSTALL_INCLUDEDIR=/usr/include . && \
        make -j && \
        make install && git clean -fdx 
        ##&& \
        # cmake -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc \
        #       -DCMAKE_INSTALL_LIBDIR=/usr/lib/arm-linux-gnueabihf \
        #       -DCMAKE_INSTALL_INCLUDEDIR=/usr/include . && \
        # make -j && \
        # make install && git clean -fdx && \
        # cmake -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
        #       -DCMAKE_INSTALL_LIBDIR=/usr/lib/aarch64-linux-gnu \
        #       -DCMAKE_INSTALL_INCLUDEDIR=/usr/include . && \
        # make -j && \
        # make install

# Install zchunk library (new version not available in debian)
# for native 
# ToDo: Cross-Compile for armhf and amd64
ENV ZCHUNK_VERSION=1.5.1
RUN git clone -b $ZCHUNK_VERSION https://github.com/zchunk/zchunk && \
        cd zchunk   && \
        meson setup build && \
        meson compile -C build && \
        ninja install -C build && git clean -fdx


# Fix lua include path
RUN PC_FILE_DIR=$(pkg-config --variable=pcfiledir lua5.2) && \
    ln -sf "$PC_FILE_DIR/lua5.2.pc" "$PC_FILE_DIR/lua.pc"

# Add swupdate user
RUN useradd -ms /bin/bash swupdate
RUN echo "swupdate ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER swupdate
WORKDIR /home/swupdate

CMD ["/bin/bash"]
