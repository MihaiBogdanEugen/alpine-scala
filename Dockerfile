# Start from alpine linux 3.5.* with glibc 2.25 and oracle jdk 8u144
FROM mbe1224/alpine-oraclejdk:3.5-2.25-8u144

# Setup SCALA_HOME
ENV SCALA_HOME=/usr/share/scala

# Install Scala 2.11.11
RUN SCALA_VERSION=2.11.11 && \
    apk add --no-cache bash && \
    cd "/tmp" && \
    wget "http://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*