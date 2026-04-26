#!/usr/bin/env bash
# 激活 repo-tracked git hooks（每台 clone 这个 repo 的机器跑一次）。
# .git/hooks/ 不进 git，所以靠 core.hooksPath 指向 repo 内的 scripts/hooks/。
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

git config core.hooksPath scripts/hooks
chmod +x scripts/hooks/* 2>/dev/null || true

echo "✓ git hooks 已激活"
echo "  core.hooksPath = $(git config --get core.hooksPath)"
echo "  hooks:"
ls -la scripts/hooks/
