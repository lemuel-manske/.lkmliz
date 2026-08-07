#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/lemuel-manske/.lkmliz.git"
REPO_DIR="${HOME}/.files"

if ! command -v git &>/dev/null || ! command -v ansible &>/dev/null; then
    echo "==> Updating apt..."
    sudo apt-get update -y
fi

if ! command -v git &>/dev/null; then
    echo "==> Installing git..."
    sudo apt-get install -y git
fi

if ! command -v ansible &>/dev/null; then
    echo "==> Installing ansible..."
    sudo apt-get install -y ansible
fi

if [ ! -d "${REPO_DIR}" ]; then
    echo "==> Cloning .lkmliz..."
    git clone "${REPO_URL}" "${REPO_DIR}"
fi

echo "==> Installing Galaxy collections..."
ansible-galaxy collection install \
    -r "${REPO_DIR}/ansible/requirements.yml"

echo "==> Running playbook..."
ansible-playbook \
    "${REPO_DIR}/ansible/playbook.yml" \
    -i "${REPO_DIR}/ansible/inventory"
