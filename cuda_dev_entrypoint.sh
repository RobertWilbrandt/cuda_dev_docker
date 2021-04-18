#!/bin/bash
set -e

# Start openssh server
/usr/sbin/sshd

cmake $CUDA_APP_DIR -GNinja
cmake --build .

exec "$@"
