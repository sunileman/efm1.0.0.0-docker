FROM openjdk:8-jdk-alpine

ARG SRC_COMMIT_HASH=""
ENV COMMIT_HASH ${SRC_COMMIT_HASH}

ENV NIFI_REGISTRY_ENABLED=false
ENV NIFI_REGISTRY=http://localhost:18080
ENV NIFI_REGISTRY_BUCKETID=
ENV NIFI_REGISTRY_BUCKETNAME=
ENV EFM_VERSION=1.0.0.1.1.0.0-172
ENV MIRROR_SITE=https://archive.cloudera.com/CEM/centos7

ARG UID=1000
ARG GID=1000

ENV EFM_BASE_DIR /opt/efm
ENV EFM_HOME $EFM_BASE_DIR/efm-$EFM_VERSION 


ENV EFM_SCRIPTS /opt/scripts
ENV EFM_CONFIG_SCRIPT $EFM_SCRIPTS/config.sh
ENV EFM_ENTRY_SCRIPT $EFM_SCRIPTS/entrypoint.sh

RUN apk add --no-cache bash wget

EXPOSE 10080

ADD ./scripts $EFM_SCRIPTS

RUN wget https://sunileman1.s3-us-west-2.amazonaws.com/CEM/JAVA/efm-$EFM_VERSION-bin.tar.gz -P $EFM_BASE_DIR

run tar -xzf $EFM_BASE_DIR/efm-$EFM_VERSION-bin.tar.gz -C $EFM_BASE_DIR

#ADD ./target/efm-*-bin.tar.gz $EFM_BASE_DIR

RUN addgroup -g $GID efm || groupmod -n efm `getent group $GID | cut -d: -f1`

RUN adduser -S -H -G efm efm

RUN chown -R efm:efm $EFM_BASE_DIR
RUN chown -R efm:efm $EFM_SCRIPTS

USER efm

RUN ["chmod", "+x", "/opt/scripts/config.sh"]
RUN ["chmod", "+x", "/opt/scripts/entrypoint.sh"]


CMD ${EFM_SCRIPTS}/entrypoint.sh
