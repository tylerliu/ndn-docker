FROM ndn-node-0.7.0:latest

RUN apt-get update \
    && apt-get install -y cmake libsnappy-dev wget

# install dledger
RUN wget https://github.com/google/leveldb/archive/1.22.tar.gz \
    && tar -xzf 1.22.tar.gz \
    && rm -f 1.22.tar.gz \
    && cd leveldb-1.22 \
    && mkdir build\
    && cd build \
    && cmake .. -DBUILD_SHARED_LIBS=ON \
    && make \
    && make install \
    && make clean \
    && cmake .. -DBUILD_SHARED_LIBS=OFF \
    && make \
    && cd ../../ \
    && rm -rf leveldb-1.22

# install dledger
RUN git clone https://github.com/UCLA-IRL/dledger.git \
    && cd dledger \
    && git checkout master \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd .. 

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

CMD /usr/local/bin/nfd -c $CONFIG > $LOG_FILE 2>&1