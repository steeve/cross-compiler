#!/bin/bash

for PIP in /opt/python/*/bin/pip; do
  $PIP install scikit-build==0.4.0
done
