FROM dockcross/base:latest
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

ENV WINEARCH win64
ARG MXE_TARGET_ARCH=x86_64
ARG MXE_TARGET_THREAD=
ARG MXE_TARGET_LINK=static

#include "common.windows"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE=dockcross/windows-static-x64
ARG VERSION=latest
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
ENV DEFAULT_DOCKCROSS_IMAGE ${IMAGE}:${VERSION}
