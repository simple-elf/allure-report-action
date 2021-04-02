FROM openjdk:8-jre-alpine

ARG RELEASE=2.13.9
RUN echo $RELEASE
ARG ALLURE_REPO=https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline

RUN apk update
RUN apk add bash
RUN apk add wget
RUN apk add unzip

RUN wget --no-verbose -O /tmp/allure-$RELEASE.tgz $ALLURE_REPO/$RELEASE/allure-commandline-$RELEASE.tgz \
  && tar -xf /tmp/allure-$RELEASE.tgz \
  && rm -rf /tmp/*

RUN rm -rf /var/cache/apk/*

RUN chmod -R +x /allure-$RELEASE/bin

ENV ROOT=/app
ENV PATH=$PATH:/allure-$RELEASE/bin

RUN mkdir -p $ROOT

WORKDIR $ROOT
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]