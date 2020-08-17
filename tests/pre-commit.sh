#!/usr/bin/env bash

set -e

docker run -v "$(pwd):$(pwd)" -w "$(pwd)" lsstsqre/terraform-pre-commit:tf-0.12.6 \
  pre-commit run -a

# vim: tabstop=2 shiftwidth=2 expandtab
