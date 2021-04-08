#!/bin/bash
set -e

cmake $CUDA_APP_DIR -GNinja
cmake --build .

exec "$@"
