#!/bin/bash

# GitHub 用户名和访问令牌
GITHUB_USER=""
GITHUB_TOKEN="your_github_token"

# 遍历当前目录下的所有子目录
for dir in */ ; do
  # 进入目录
  cd "$dir"
  
  # 检查是否为 Git 仓库
  if [ -d ".git" ]; then
    echo "Checking $dir for remote..."

    # 检查是否已配置远程仓库
    remote=$(git remote)
    if [ -z "$remote" ]; then
      echo "No remote found for $dir. Setting up GitHub repo..."

      # 使用 GitHub CLI 创建远程仓库
      repo_name="${dir%/}" # 删除路径中的尾部斜杠
      gh repo create "$GITHUB_USER/$repo_name" --private --source=. --remote=origin --push

      echo "GitHub repository created and pushed for $dir"
    else
      echo "Remote already set for $dir"
    fi
  else
    echo "$dir is not a Git repository"
  fi
  
  # 返回上一级目录
  cd ..
done
