#!/bin/sh
set -e
./update_to_edge.sh
./install_deps.sh
./generate_images.sh
