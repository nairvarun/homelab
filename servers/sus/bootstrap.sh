#!/usr/bin/env bash
set -euo pipefail

if command -v just &>/dev/null; then
    echo "just $(just --version) already installed"
    exit 0
fi

dnf install just
echo "just $(just --version) installed"
