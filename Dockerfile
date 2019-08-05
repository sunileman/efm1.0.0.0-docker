FROM openjdk:8-jdk-alpine

ARG SRC_COMMIT_HASH=""
ENV COMMIT_HASH ${SRC_COMMIT_HASH}

ARG NIFI_REGISTRY_ENABLED=false
ARG NIFI_REGISTRY=http://localhost:18080
ARG NIFI_REGISTRY_BUCKETID=
ARG NIFI_REGISTRY_BUCKETNAME=
ARG EFM_VERSION=1.0.0.1.0.0.0-54
ARG MIRROR_SITE=https://archive.cloudera.com/CEM/centos7


ENV EFM_BASE_DIR /opt/efm
ENV EFM_HOME $EFM_BASE_DIR/efm-$EFM_VERSION 


EXPOSE 10080

ADD ./scripts /opt/script

ADD ./target/efm-*-bin.tar.gz /opt/efm

RUN ls /opt/efm/

#RUN mv efm-*-bin.tar.gz efm-bin.tar.gz

#RUN tar -xzf /tmp/efm-bin.tar.gz -C ${EFM_HOME}

# Default to binding to any interface
RUN sed -i -e "s|^efm.server.address=.*$|efm.server.address=0.0.0.0|" $EFM_HOME'/conf/efm.properties'

# bind to args
RUN sed -i -e "s|^efm.nifi.registry.enabled=.*$|efm.nifi.registry.enabled=$NIFI_REGISTRY_ENABLED|" $EFM_HOME'/conf/efm.properties'

RUN sed -i -e "s|^efm.nifi.registry.url=.*$|efm.nifi.registry.url=$NIFI_REGISTRY|" $EFM_HOME'/conf/efm.properties'

RUN sed -i -e "s|^efm.nifi.registry.bucketId=.*$|efm.nifi.registry.bucketId=$NIFI_REGISTRY_BUCKETID|" $EFM_HOME'/conf/efm.properties'

RUN sed -i -e "s|^efm.nifi.registry.bucketName=.*$|efm.nifi.registry.bucketName=$NIFI_REGISTRY_BUCKETNAME|" $EFM_HOME'/conf/efm.properties'


RUN apk add --no-cache bash

RUN ["chmod", "+x", "/opt/script/entrypoint.sh"]

CMD /opt/efm/efm-*/bin/efm.sh run

#CMD /opt/script/entrypoint.sh
