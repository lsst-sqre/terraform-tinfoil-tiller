#!/bin/bash

set -e

TF_VER="0.11.14"

tf() {
  docker run -ti -v "$(pwd):$(pwd)" -w "$(pwd)" \
    "hashicorp/terraform:${TF_VER}" "$@"
}

tf fmt --check=true --diff=true
tf validate --check-variables=false

# vim: tabstop=2 shiftwidth=2 expandtab
