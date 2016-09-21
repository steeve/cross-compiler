#!/bin/bash

for PIP in /opt/python/*/bin/pip; do
  $PIP install scikit-build==0.3.0
done
