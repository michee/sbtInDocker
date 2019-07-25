#
# Scala and sbt in Dockerfile for arm64v8 architecture
#
# https://github.com/michee/sbtInDocker
#

# Pull base image
FROM arm64v8/openjdk:11.0.2
#FROM arm64v8/openjdk:8-jdk-alpine

#FROM openjdk:11.0.2

# Env variables
ENV SCALA_VERSION 2.12.8
ENV SBT_VERSION 1.2.8

# Install Scala
## Piping curl directly in tar
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
  apt-get install sbt && \
  sbt sbtVersion

  # rm -r project && rm build.sbt && rm Temp.scala && rm -r target

# Define working directory
# -v $(pwd)/echoService:/project
WORKDIR project 
