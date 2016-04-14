#!/bin/bash
exec ${0/${CROSS_TRIPLE}-/x86_64-linux-gnu-} --32 "$@"
