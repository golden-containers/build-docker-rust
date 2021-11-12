#!/bin/bash

set -Eeuxo pipefail
rm -rf working
mkdir working
cd working

# Checkout upstream

git clone --depth 1 --branch master https://github.com/rust-lang/docker-rust.git
cd docker-rust

# Transform

sed -i -e "1 s/FROM.*/FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye/; t" -e "1,// s//FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye/" 1.56.1/bullseye/Dockerfile

# Build

docker build 1.56.1/bullseye/ --tag ghcr.io/golden-containers/rust:1.56.1-bullseye --label ${1:-DEBUG=TRUE}

# Push

docker push ghcr.io/golden-containers/rust -a
