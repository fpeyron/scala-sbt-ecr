#
# Scala and sbt Dockerfile
#
# https://github.com/fpeyron/scala-sbt-ecr
#

# Pull base image
FROM hseeberger/scala-sbt:11.0.2_2.12.8_1.2.8


# Install golang and make
USER root
RUN \
  apt-get update && \
  apt-get -yq install sbt make golang && \
  rm -rf /var/lib/apt/lists/*

# Install amazon-ecr-credential-helper
USER root
RUN \
  export GOROOT=/usr/lib/go && export GOPATH=$HOME/go && export PATH=$PATH:$GOROOT/bin:$GOPATH/bin && \
  go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login



