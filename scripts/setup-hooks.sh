#!/usr/bin/env bash
# 激活 repo-tracked git hooks（每台 clone 这个 repo 的机器跑一次）。
# .git/hooks/ 不进 git，所以靠 core.hooksPath 指向 repo 内的 scripts/hooks/。
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# 检查 .git/hooks/ 里是否有非样例 hook（用户自定义的会被切换走）
EXISTING=$(ls .git/hooks/ 2>/dev/null | grep -v '\.sample$' || true)
if [ -n "$EXISTING" ]; then
  echo "⚠  警告：.git/hooks/ 里发现非样例 hook，切换 core.hooksPath 后将不再被调用："
  echo "$EXISTING" | sed 's/^/      /'
  echo ""
  echo "   如果这些是你自己装的（husky / lefthook / 个人 pre-push 等）："
  echo "   - 备份它们，再合并到 scripts/hooks/ 里（这样会跟随 repo 同步）"
  echo "   - 或保留旧位置，本脚本就别跑"
  echo ""
  printf "   按 Enter 继续，Ctrl+C 退出: "
  read -r _
fi

git config core.hooksPath scripts/hooks
chmod +x scripts/hooks/* 2>/dev/null || true

echo "✓ git hooks 已激活"
echo "  core.hooksPath = $(git config --get core.hooksPath)"
echo "  hooks:"
ls -la scripts/hooks/
