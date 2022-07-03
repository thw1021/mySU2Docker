FROM ubuntu:20.04

# avoid time zone configuration by tzdata
ARG DEBIAN_FRONTEND=noninteractive

# see https://github.com/moby/moby/issues/27988#issuecomment-462809153
# same issue when installing SU2
RUN chmod 777 /var/cache/debconf/
RUN chmod 777 /var/cache/debconf/passwords.dat
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y -q

# install basic utilities
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-utils       \
    ca-certificates \
    cmake           \
    g++             \
    make            \
    sudo            \
    unzip           \
    vim-tiny        \
    wget

# install git and swig for SU2 (SU2 uses git to download some module)
RUN apt-get install -y build-essential git swig

# see https://su2code.github.io/docs_v7/Build-SU2-Linux-MacOS/
# not sure whether this is really necessary
RUN apt-get install pkg-config

# not sure which libs are necessary, so all install (needed by installing OpenFOAM)
RUN apt-get install -y flex libfl-dev bison zlib1g-dev libboost-system-dev libboost-thread-dev libopenmpi-dev openmpi-bin gnuplot libreadline-dev libncurses-dev libxt-dev

