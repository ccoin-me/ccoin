FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Denver
RUN apt-get update && apt-get upgrade -y && apt-get install build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 git libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-chrono-dev libboost-program-options-dev  libboost-thread-dev libssl-dev libminiupnpc-dev libnatpmp-dev libzmq3-dev -y
RUN apt-get install sqlite wget -y
WORKDIR ccoin
COPY . .
RUN ./contrib/install_db4.sh `pwd`
ENV BDB_PREFIX='/ccoin/db4'
RUN ./autogen.sh && ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include" --without-gui && make -j$(nproc)
ENTRYPOINT [ "/ccoin/src/ccoind" ]
