#!/usr/bin/env bash

set -ex
set -o pipefail

if ! command -v gosu &> /dev/null; then
	echo >&2 'error: "gosu" not found!'
	exit 1
fi

# verify that the binary works
gosu nobody true

# To ensure that our custom sudo wrapper is not
# overwritten by a future re-install of sudo, it
# is created in /usr/loca/bin

cat << EOF >> /usr/local/bin/sudo
#!/bin/sh
# Emulate the sudo command
exec gosu root:root "\$@"
EOF

chmod +x /usr/local/bin/sudo

