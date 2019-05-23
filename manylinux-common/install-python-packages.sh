#!/usr/bin/env bash

for PIP in /opt/python/*/bin/pip; do
  $PIP install --disable-pip-version-check --upgrade pip
  $PIP install scikit-build==0.10.0
done
