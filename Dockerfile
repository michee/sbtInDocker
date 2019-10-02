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

RUN groupadd -g 999 docker

# Add and use user sbtuser
ARG user=sbtuser
ARG group=sbtuser
ARG uid=1000
ARG gid=1000
RUN groupadd --gid ${gid} ${group} && useradd --gid ${gid} --uid ${uid} ${user} --shell /bin/bash
RUN chown -R ${user}:${group} /opt
RUN mkdir /home/sbtuser && chown -R ${user}:${group} /home/sbtuser
RUN mkdir /logs && chown -R ${user}:${group} /logs
RUN usermod -a -G sudo ${user}
RUN usermod -a -G docker ${user}

RUN apt-get install acl
RUN setfacl -m user:${user}:rw /var/run/docker.sock

# install docker
ARG DOCKER_V=18.06.1~ce~3-0~debian
# RUN apt-cache madison docker-ce
# RUN apt-get install -y --allow-downgrades docker-ce=$DOCKER_V

# TODO: docker group id must be same as hosts docker group id. FIXME
RUN wget https://download.docker.com/linux/static/stable/aarch64/docker-18.06.1-ce.tgz && \
    tar zxvf docker-18.06.1-ce.tgz && \
    cp docker/* /usr/bin/
   
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

USER ${user}:docker

WORKDIR project 
