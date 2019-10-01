#
# Scala and sbt in Dockerfile for arm64v8 architecture
#
# https://github.com/michee/sbtInDocker
#
# example run: 
#
# docker run --rm -it -v $(pwd)/testproject:/project -v $(pwd)/ivy2:/ivy2 michee/sbt:1.2.8
#

# Pull base image
FROM arm64v8/openjdk:11.0.2

# Env variables
ENV SCALA_VERSION 2.12.8
ENV SBT_VERSION 1.2.8

# easy access to ivy2 dir, origin in /root/.ivy2
RUN mkdir /ivy2 && ln -s /ivy2 /root/.ivy2
RUN mkdir /sbt  && ln -s /sbt /root/.sbt && chmod 777 /sbt

# Install Scala
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt
  
  # sbt version
  #mkdir /ivy2 && \ #sbt -Dsbt.ivy.home=/ivy2 && \ #sbt version

# Define working directory
# -v $(pwd)/echoService:/project

# install docker
ARG DOCKER_V=18.06.1~ce~3-0~debian
# RUN apt-cache madison docker-ce
# RUN apt-get install -y --allow-downgrades docker-ce=$DOCKER_V
#RUN apt-get update \
#    && apt-get upgrade -y \
#    && apt-get install -y git curl software-properties-common apt-transport-https ca-certificates \
#    && rm -rf /var/lib/apt/lists/*
    
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/debian stretch stable" \
    && apt-get update \
    && apt-get install -y docker-ce=$DOCKER_V containerd.io \
    && rm -rf /var/lib/apt/lists/*

WORKDIR project 
