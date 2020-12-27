FROM node:14 AS tdjson
WORKDIR /app
# RUN apk add --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf php php-ctype cmake
RUN apt-get update && apt-get install -yqq \
    build-essential \
    cmake \
    git \
    gperf \
    php
RUN git clone -b v1.7.0 https://github.com/tdlib/td.git .
RUN rm -rf build \
    && mkdir build \
    && cd build \
    && export CXXFLAGS="" \
    && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib .. \
    && cmake --build . --target prepare_cross_compiling \
    && cd .. \
    && php SplitSource.php \
    && cd build \
    && cmake --build . --target install

FROM node:14 as nodebuild
WORKDIR /app
# RUN apk add --no-cache python3 alpine-sdk libffi-dev
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install
COPY . .
RUN npm run build && npm prune --production

FROM node:14
ENV NODE_ENV production
WORKDIR /usr/src/app
# RUN apk add --no-cache libssl1.1 libcrypto1.1
RUN apt-get update && apt-get install -yqq libssl1.1 && apt-get clean && rm -rf /var/apt
COPY --from=nodebuild /app .
COPY --from=tdjson /app/tdlib/lib/libtdjson.so .

CMD npm start