#!/bin/bash

# Initialize the main Git repository if not already initialized
if [ ! -d ".git" ]; then
  git init
  echo -e "\033[0;32mGit repository initialized in the current directory.\033[0m"
fi

# Define the desired file extension
file_extension=".R"
processed_count=0
skipped_count=0

# Loop through each file in the current directory
for file in *$file_extension; do
  if [ -f "$file" ]; then
    dirname="${file%.*}_gist"
    # Check if the directory already exists to avoid re-initialization
    if [ ! -d "$dirname" ]; then
      let processed_count+=1
      echo -e "\033[0;34mProcessing file: $file\033[0m"

      mkdir "$dirname" && echo "Directory $dirname created."
      
      # Move the file into the new directory
      mv "$file" "$dirname/" && echo "$file moved to $dirname/"

      # Initialize a new git repository in the new directory
      cd "$dirname"
      git init
      git add "$file"
      git commit -m "Initial commit for $file"
      cd ..

      # Add the new directory as a submodule to the main repository
      git submodule add ./"$dirname" "$dirname" && echo -e "\033[0;32m$file added as a submodule.\033[0m"
    else
      echo -e "\033[0;33mDirectory $dirname already exists, skipping submodule addition.\033[0m"
      let skipped_count+=1
    fi
  else
    let skipped_count+=1
    echo -e "\033[0;33mSkipping $file (not a regular file or does not match extension $file_extension).\033[0m"
  fi
done

# Update and initialize submodules
git submodule update --init --recursive

# Commit the submodule changes to the main repository
git add .gitmodules
git add .
git commit -m "Added all files as submodules"

echo -e "\033[0;32mAll matching files have been initialized as separate git repositories and added as submodules.\033[0m"
echo -e "\033[1;37mProcessed files: $processed_count, Skipped files: $skipped_count\033[0m"
