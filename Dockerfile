FROM philcollins/aurora-centos7

RUN yum install -y java-1.8.0-openjdk maven mariadb

ADD . /usr/local/qlink
WORKDIR /usr/local/qlink
RUN /usr/local/qlink/package

ENTRYPOINT /usr/local/qlink/dockerrun

EXPOSE 5190
