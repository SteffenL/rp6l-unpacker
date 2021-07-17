FROM ubuntu:20.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential curl unzip git
WORKDIR /zlib
RUN curl -fsSLo zlib.tar.gz https://www.zlib.net/zlib-1.2.11.tar.gz \
    && tar -xf zlib.tar.gz && rm -f zlib.tar.gz
RUN cd zlib-* && ./configure --shared && make install
WORKDIR /lua
RUN curl -fsSLo lua.tar.gz http://www.lua.org/ftp/lua-5.4.3.tar.gz \
    && tar -xf lua.tar.gz && rm -f lua.tar.gz
RUN cd lua-* && make && make local
RUN ln -s ${PWD}/lua-*/install/bin/lua /usr/local/bin/lua5.4 \
    && ln -s ${PWD}/lua-*/install/lib/liblua.a /usr/local/lib/liblua5.4.a \
    && ln -s ${PWD}/lua-*/install/include /usr/local/include/lua5.4
WORKDIR /luarocks
RUN curl -fsSLo luarocks.tar.gz https://luarocks.org/releases/luarocks-3.7.0.tar.gz \
    && tar -xf luarocks.tar.gz && rm -f luarocks.tar.gz
RUN cd luarocks-* && ./configure && make && make install
RUN luarocks install lua-zlib
WORKDIR /luastatic
RUN curl -fsSLo luastatic.tar.gz https://github.com/ers35/luastatic/archive/refs/tags/0.0.12.tar.gz \
    && tar -xf luastatic.tar.gz && rm -f luastatic.tar.gz
RUN cd luastatic-* && \
    LUA=/usr/local/bin/lua5.4 \
    LIBLUA_A=/usr/local/lib/liblua5.4.a \
    LUA_INCLUDE=/usr/local/include/lua5.4 \
    make
RUN ln -s ${PWD}/luastatic-*/luastatic /usr/local/bin/luastatic
WORKDIR /rp6l
COPY src/ src/
WORKDIR src
RUN luastatic rp6l.lua mod_dds_header.lua \
    /usr/local/lib/liblua5.4.a \
    /usr/local/lib/libz.a \
    -I/usr/local/include/lua5.4 -O3
RUN mv ./rp6l /usr/local/bin/
WORKDIR ..
COPY entrypoint.sh /usr/local/bin/rp6l-entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/rp6l-entrypoint.sh" ]
