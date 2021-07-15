FROM ubuntu:16.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Denver
RUN apt-get update && apt-get upgrade -y && apt-get install build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 git libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-chrono-dev libboost-program-options-dev  libboost-thread-dev libssl-dev libminiupnpc-dev libnatpmp-dev libzmq3-dev -y
RUN apt-get install sqlite wget -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:bitcoin/bitcoin -y && apt-get update && apt-get install libdb4.8-dev libdb4.8++-dev -y
WORKDIR ccoin
COPY . .
WORKDIR src
RUN make -j$(nproc) -f makefile.unix
ENTRYPOINT [ "/ccoin/src/ccoind" ]
