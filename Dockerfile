FROM node:8
LABEL maintainer "Joe Hildebrand <joe-github@cursive.net>"

WORKDIR /tmp

RUN git clone https://github.com/mozilla-lockbox/lockbox-extension.git

VOLUME /tmp/host
WORKDIR /tmp/lockbox-extension

RUN npm config set progress false && npm config set cache /tmp/host/npm-cache

ARG BUILD_DATE=1
RUN git pull

CMD git pull && npm install && npm run package && cp addon.xpi /tmp/host
