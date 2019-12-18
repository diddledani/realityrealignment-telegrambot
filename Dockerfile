FROM node:10.13-alpine AS tdjson
WORKDIR /app
RUN apk add --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf php php-ctype cmake
RUN git clone https://github.com/tdlib/td.git . \
    && rm -rf build \
    && mkdir build \
    && cd build \
    && export CXXFLAGS="" \
    && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib .. \
    && cmake --build . --target prepare_cross_compiling \
    && cd .. \
    && php SplitSource.php \
    && cd build \
    && cmake --build . --target install

FROM node:10.13-alpine as nodebuild
WORKDIR /app
RUN apk add --no-cache python alpine-sdk
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

FROM node:10.13-alpine
ENV NODE_ENV production
WORKDIR /usr/src/app
RUN apk add --no-cache libssl1.0 libcrypto1.0
COPY --from=nodebuild /app .
COPY --from=tdjson /app/tdlib/lib/libtdjson.so .

CMD npm start