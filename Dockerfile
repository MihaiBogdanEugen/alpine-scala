# Start from alpine linux 3.6.* with glibc 2.26 and oracle jdk 8u144
FROM mbe1224/alpine-oraclejdk:3.6-2.26-8u144

# Setup SCALA_HOME
ENV SCALA_HOME=/usr/share/scala

# Install Scala 2.11.11
RUN SCALA_VERSION=2.11.11 && \
    SCALA_SHA256_SUM=2b796ab773fbedcc734ba881a6486d54180b699ade8ba7493e91912044267c8c && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash && \
    cd "/tmp" && \
    wget "http://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    echo "${SCALA_SHA256_SUM}  scala-${SCALA_VERSION}.tgz" | sha256sum -c - && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*