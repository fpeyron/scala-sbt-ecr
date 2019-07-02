#
# Scala and sbt Dockerfile
#
# https://github.com/fpeyron/scala-sbt-ecr
#

# Pull base image
FROM openjdk:8u212-b04-jdk-stretch

# Env variables
ENV SCALA_VERSION 2.13.0
ENV SBT_VERSION 1.2.8

MAINTAINER Florent Peyron <florentpeyron@gmail.com>

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt make golang && \
  export GOROOT=/usr/lib/go && export GOPATH=/opt/go && export PATH=$PATH:$GOROOT/bin:$GOPATH/bin && \
  go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login


# Add and use user sbtuser
RUN groupadd --gid 1001 sbtuser && useradd --gid 1001 --uid 1001 sbtuser --shell /bin/bash
RUN chown -R sbtuser:sbtuser /opt
RUN mkdir /home/sbtuser && chown -R sbtuser:sbtuser /home/sbtuser
RUN mkdir /logs && chown -R sbtuser:sbtuser /logs
USER sbtuser

# Switch working directory
WORKDIR /home/sbtuser

# Prepare sbt
RUN \
  sbt sbtVersion && \
  mkdir -p project && \
  echo "scalaVersion := \"${SCALA_VERSION}\"" > build.sbt && \
  echo "sbt.version=${SBT_VERSION}" > project/build.properties && \
  echo "case object Temp" > Temp.scala && \
  sbt compile && \
  rm -r project && rm build.sbt && rm Temp.scala && rm -r target

# Link everything into root as well
# This allows users of this container to choose, whether they want to run the container as sbtuser (non-root) or as root
USER root
RUN \
  echo "export PATH=/home/sbtuser/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc && \
  ln -s /home/sbtuser/.ivy2 /root/.ivy2 && \
  ln -s /home/sbtuser/.sbt /root/.sbt

# Switch working directory back to root
## Users wanting to use this container as non-root should combine the two following arguments
## -u sbtuser
## -w /home/sbtuser
WORKDIR /root
