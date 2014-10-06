FROM google/debian:wheezy

RUN apt-get update && apt-get upgrade -y && apt-get -y install openjdk-7-jre

RUN mkdir /usr/local/qlink

ADD ./target/qlink-0.1.0.jar /usr/local/qlink/qlink.jar

VOLUME ["/etc/qlink"]

ENTRYPOINT /usr/bin/java -jar /usr/local/qlink/qlink.jar

EXPOSE 5190
