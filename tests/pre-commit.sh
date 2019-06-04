#!/bin/bash

set -e

docker run -v "$(pwd):$(pwd)" -w "$(pwd)" lsstsqre/terraform-pre-commit:latest \
  pre-commit run -a

# vim: tabstop=2 shiftwidth=2 expandtab
