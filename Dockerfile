FROM alpine:3.6
MAINTAINER UKAEA <admin@fispact.ukaea.uk>

# Build-time metadata as defined at http://label-schema.org
ARG PROJECT_NAME
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="$PROJECT_NAME" \
      org.label-schema.description="Alpine Linux docker image for FISPACT-II" \
      org.label-schema.url="http://fispact.ukaea.uk/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/fispact/docker_alpine" \
      org.label-schema.vendor="UKAEA" \
      org.label-schema.version=$VERSION \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.schema-version="1.0"

ENV RUN_SCRIPT ~/.bashrc

# Install additional packages
RUN apk update && apk upgrade && \
    apk add --no-cache gfortran g++ make git cmake less && \
    apk add --no-cache python3 doxygen rsync cpio bash bash-completion && \
    # pip3 packages
    pip3 install --upgrade pip && \
    pip3 install pytest pytest-xdist pypact

WORKDIR /

# Run the tests
CMD bash $RUN_SCRIPT
