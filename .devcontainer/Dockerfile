FROM debian:12

RUN dpkg --add-architecture armhf && apt-get update
RUN dpkg --add-architecture arm64 && apt-get update
RUN apt-get install -y \
        build-essential \
        crossbuild-essential-armhf \
        crossbuild-essential-arm64 \
        gdb-multiarch \
        cmake \
        ccache \
        qemu-user

# Install swupdate native dependencies
RUN apt-get install -y \
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
        lua5.2-dev

# Install swupdate dependencies for armhf
RUN apt-get install -y \
        libefiboot-dev:armhf  \
        libebgenv-dev:armhf  \
        libmtd-dev:armhf  \
        libubi-dev:armhf  \
        libzck-dev:armhf  \
        libcurl4-openssl-dev:armhf  \
        libssl-dev:armhf  \
        libwolfssl-dev:armhf  \
        libsystemd-dev:armhf  \
        libjson-c-dev:armhf  \
        libncurses5-dev:armhf  \
        libncursesw5-dev:armhf  \
        libarchive-dev:armhf  \
        libzmq3-dev:armhf  \
        libconfig-dev:armhf \
        libz-dev:armhf \
        libyaml-dev:armhf \
        lua5.2-dev:armhf

# Install swupdate dependencies for arm64
RUN apt-get install -y \
        libefiboot-dev:arm64  \
        libebgenv-dev:arm64  \
        libmtd-dev:arm64  \
        libubi-dev:arm64  \
        libzck-dev:arm64  \
        libcurl4-openssl-dev:arm64  \
        libssl-dev:arm64  \
        libwolfssl-dev:arm64  \
        libsystemd-dev:arm64  \
        libjson-c-dev:arm64  \
        libncurses5-dev:arm64  \
        libncursesw5-dev:arm64  \
        libarchive-dev:arm64  \
        libzmq3-dev:arm64  \
        libconfig-dev:arm64  \
        libz-dev:arm64 \
        libyaml-dev:arm64 \
        lua5.2-dev:arm64

# Aditional development tools
RUN apt-get install -y \
        git-core \
        git-man \
        git-email \
        sudo \
        nano \
        vim \
        curl \
        openssh-client \
        bash-completion

# Install libubootenv library (new version not available in debian)
# for native, armhf and arm64
RUN  git clone https://github.com/sbabic/libubootenv.git && \
        cd libubootenv && \
        cmake -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu \
                -DCMAKE_INSTALL_INCLUDEDIR=/usr/include . && \
        make -j && \
        sudo make install && git clean -fdx && \
        cmake -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc \
                -DCMAKE_INSTALL_LIBDIR=/usr/lib/arm-linux-gnueabihf \
                -DCMAKE_INSTALL_INCLUDEDIR=/usr/include . && \
        make -j && \
        sudo make install && git clean -fdx && \
        cmake -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
                -DCMAKE_INSTALL_LIBDIR=/usr/lib/aarch64-linux-gnu \
                -DCMAKE_INSTALL_INCLUDEDIR=/usr/include . && \
        make -j && \
        sudo make install

# Install python3 and dependencie required for python swupdateclient
RUN apt-get install -y \
        python3 \
        python3-pip \
        python3-requests \
        python3-websockets \
        python3-termcolor

# Add swupdate user
RUN useradd -ms /bin/bash swupdate
RUN echo "swupdate ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER swupdate
WORKDIR /home/swupdate

CMD ["/bin/bash"]
