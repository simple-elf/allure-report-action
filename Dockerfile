FROM openjdk:8-jre-alpine

ARG RELEASE=2.17.2 \
    ALLURE_REPO=https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline

RUN echo $RELEASE && \
    apk update && \
    apk add --no-cache bash wget unzip && \
    rm -rf /var/cache/apk/*

RUN wget --no-verbose -O /tmp/allure-$RELEASE.tgz $ALLURE_REPO/$RELEASE/allure-commandline-$RELEASE.tgz && \
    tar -xf /tmp/allure-$RELEASE.tgz && \
    rm -rf /tmp/* && \
    chmod -R +x /allure-$RELEASE/bin

ENV ROOT=/app \
    PATH=$PATH:/allure-$RELEASE/bin

RUN mkdir -p $ROOT

WORKDIR $ROOT
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
