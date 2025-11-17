#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/portfolio/first_ai/github_setup.sh

# This script helps set up and push to a GitHub repository
# Repository: https://github.com/nicokuehn-dci/muzsic-theory-ai

# Setting fixed repository info based on provided URL
GITHUB_USERNAME="nicokuehn-dci"
REPO_NAME="muzsic-theory-ai"

# Override with command line parameters if provided
if [ ! -z "$1" ]; then
  GITHUB_USERNAME="$1"
fi

if [ ! -z "$2" ]; then
  REPO_NAME="$2"
fi

# Configure Git user if not already done
if [ -z "$(git config --global user.email)" ]; then
    echo "Enter your email for Git commits:"
    read EMAIL
    git config --global user.email "$EMAIL"
fi

if [ -z "$(git config --global user.name)" ]; then
    echo "Enter your name for Git commits:"
    read NAME
    git config --global user.name "$NAME"
fi

# Remove existing origin if it exists
git remote remove origin 2>/dev/null

# Add GitHub as a remote
echo "Adding GitHub repository as remote..."
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Switch to main branch if not already there
echo "Ensuring we're on the main branch..."
git branch -M main

# Push to GitHub
echo "Pushing to GitHub..."
echo "You'll be prompted to enter your GitHub username and password/token."
git push -u origin main

echo
echo "Repository successfully pushed to GitHub!"
echo "Visit: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
