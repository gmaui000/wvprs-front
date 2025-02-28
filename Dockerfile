FROM ubuntu:20.04

ENV LC_ALL zh_CN.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive &&\
        apt-get update && \
        apt-get install -y --no-install-recommends nodejs npm build-essential \
        ca-certificates openssl language-pack-zh-hans &&\
        apt-get autoremove -y && \
        apt-get clean -y && \
        rm -rf /var/lib/apt/lists/*dic

WORKDIR /opt/wvprs-front
COPY . /opt/wvprs-front
RUN npm --registry=http://registry.npmmirror.com install && \
    npm run build

EXPOSE 9090
CMD ["npm", "run", "dev"]

