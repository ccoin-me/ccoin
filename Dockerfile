FROM ubuntu:20.04
RUN apt-get update && apt-get upgrade -y && apt-get install build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 git libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-chrono-dev libboost-program-options-dev  libboost-thread-dev libssl-dev libminiupnpc-dev libnatpmp-dev libzmq3-dev -y
WORKDIR ccoin
COPY . .
RUN ./autogen.sh && ./configure --disable-wallet --without-gui && make -j$(nproc)
ENTRYPOINT [ "/ccoin/src/ccoind" ]

