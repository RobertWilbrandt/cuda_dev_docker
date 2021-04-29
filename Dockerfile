FROM nvidia/cuda:9.1-devel
LABEL maintainer="Robert Wilbrandt <robert@stamm-wilbrandt.de>"
LABEL description="Development environment for building cmake-based cuda 9.1 applications"

# Install dependencies
RUN apt update \
  && apt install -y wget ninja-build

# Install cmake
RUN mkdir system \
  && cd system \
  && wget https://cmake.org/files/v3.17/cmake-3.17.0-Linux-x86_64.tar.gz \
  && tar xf cmake-3.17.0-Linux-x86_64.tar.gz

ENV PATH="/system/cmake-3.17.0-Linux-x86_64/bin:${PATH}"

# Set up networking and ssh server for remote profiling
RUN apt install -y iproute2 openssh-server \
  && sed -i "s/.*PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
  && mkdir /var/run/sshd \
  && echo 'root:root' | chpasswd

# Use --volume to map cuda application here
ENV CUDA_APP_DIR=/cuda_app

WORKDIR /build

COPY ./cuda_dev_entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
