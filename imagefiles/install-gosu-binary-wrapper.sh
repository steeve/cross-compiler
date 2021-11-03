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
# is created in /usr/local/bin

cat << EOF >> /usr/local/bin/sudo
#!/bin/bash
# Emulate the sudo command
SUDO_USER=root
SUDO_GROUP=root
while (( "\$#" )); do
  case "\$1" in
    # user option
    -u)
      SUDO_USER=\$2
      shift 2
      ;;
    # group option
    -g)
      SUDO_GROUP=\$2
      shift 2
      ;;
    # skipping arguments without values
    -A|-b|-E|-e|-H|-h|-K|-n|-P|-S|-V|-v)
      shift 1
      ;;
    # skipping arguments with values
    -a|-C|-c|-D|-i|-k|-l|-ll|-p|-r|-s|-t|-U)
      shift 2
      ;;
    # stop processing command line arguments
    --)
      shift 1
      break
      ;;
    *)
      break
      ;;
  esac
done
exec gosu \$SUDO_USER:\$SUDO_GROUP "\$@"
EOF

chmod +x /usr/local/bin/sudo
