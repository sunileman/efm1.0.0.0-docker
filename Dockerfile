FROM openjdk:8-jdk-alpine

ARG SRC_COMMIT_HASH=""
ENV COMMIT_HASH ${SRC_COMMIT_HASH}


ENV EFM_VERSION=1.0.0.0 \
	EFM_BASE=1.x \
        EFM_HOME=/opt/efm \
        MIRROR_SITE=https://archive.cloudera.com/CEM/centos7

EXPOSE 10080

ADD ./scripts /opt/script

ADD ./target/efm-*-bin.tar.gz /opt/efm

RUN ls /opt/efm/

#RUN mv efm-*-bin.tar.gz efm-bin.tar.gz

#RUN tar -xzf /tmp/efm-bin.tar.gz -C ${EFM_HOME}

# Default to binding to any interface
RUN sed -i -e "s|^efm.server.address=.*$|efm.server.address=0.0.0.0|" '/opt/efm/efm-1.0.0.1.0.0.0-54/conf/efm.properties'

RUN ["chmod", "+x", "/opt/script/entrypoint.sh"]

CMD /opt/efm/efm-*/bin/efm.sh run

#CMD /opt/script/entrypoint.sh
