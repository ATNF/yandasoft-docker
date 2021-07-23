ARG IMAGE=registry.gitlab.com/askapsdp/all_yandasoft:1.1.x-latest
FROM $IMAGE as buildenv
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing \
   && apt-get upgrade -y \
   && apt-get install -y tzdata \
   && apt-get install -y g++ \
   && apt-get install -y git \
   && apt-get install -y cmake \
   && apt-get install -y xsltproc \
   && apt-get install -y zeroc-ice-all-dev \
   && apt-get install -y zeroc-ice-all-runtime \
   && apt-get install -y libczmq-dev \
   && apt-get -qq --no-install-recommends install vim \
   && apt-get -qq --no-install-recommends install sudo \
   && apt-get -qq --no-install-recommends install ssh \
   && apt-get -qq clean    \
   && rm -rf /var/lib/apt/lists/*

# Setup the default user.
RUN mkdir -p /var/run/sshd
RUN mkdir -p /run/sshd
RUN useradd -rm -d /home/yanda -s /bin/bash -U -u 1000 -G sudo yanda
RUN echo 'yanda:yanda' | chpasswd

