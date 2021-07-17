FROM ubuntu:20.04
RUN apt-get update && apt-get install -y build-essential curl unzip git libz-dev
WORKDIR /lua
RUN curl -fsSLo lua.tar.gz http://www.lua.org/ftp/lua-5.4.3.tar.gz \
    && tar -xf lua.tar.gz && rm -f lua.tar.gz
RUN cd lua-* && make all test install
RUN lua -v
WORKDIR /luarocks
RUN curl -fsSLo luarocks.tar.gz https://luarocks.org/releases/luarocks-3.7.0.tar.gz \
    && tar -xf luarocks.tar.gz && rm -f luarocks.tar.gz
RUN cd luarocks-* && ./configure && make && make install
RUN luarocks --version
RUN luarocks install lua-zlib
WORKDIR /rp6l
COPY src/* ./
RUN luac -s -o rp6l *.lua
ENTRYPOINT [ "./entrypoint.sh" ]
