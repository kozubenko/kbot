#!/bin/sh

if ! command -v docker >/dev/null 2>&1; then
  echo "For support multiple OS we need to you install Docker locally."
  echo "Please install Docker: https://docs.docker.com/get-docker/ first to support hooks"
  exit 1
fi

docker pull zricethezav/gitleaks:latest

for arg in "$@"; do
  case $arg in
    --enable-gitleaks)
      git config gitleaks.enable true
      echo "Gitleaks pre-commit hook enabled ✅"
      ;;
  esac
done

cp -r scripts/githooks/* .git/hooks/
chmod +x .git/hooks/*

echo "Git hooks installed ✅"