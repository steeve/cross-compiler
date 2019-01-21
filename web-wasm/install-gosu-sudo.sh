#!/usr/bin/env bash

# verify that the binary works
gosu nobody true


cat << EOF >> /usr/bin/sudo
#!/bin/sh

# Emulate the sudo command

exec gosu root:root "\$@"

EOF

chmod +x /usr/bin/sudo
