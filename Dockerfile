FROM ubuntu:jammy

COPY ci/setup.sh /tmp/setup.sh
COPY ci/install-src-deps.sh /tmp/install-src-deps.sh
RUN chmod +x /tmp/setup.sh
RUN chmod +x /tmp/install-src-deps.sh

RUN /tmp/setup.sh
RUN /tmp/install-src-deps.sh

# Aditional development tools
RUN apt-get install -y \
    git-core git-man git-email \
    gcc-multilib g++-multilib gdb-multiarch \
    sudo nano vim openssh-client bash-completion

# Add swupdate user
RUN useradd -ms /bin/bash swupdate
RUN echo "swupdate ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER swupdate
WORKDIR /home/swupdate

CMD ["/bin/bash"]
