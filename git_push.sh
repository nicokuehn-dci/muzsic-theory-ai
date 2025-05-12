#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/lectures/first_ai/git_push.sh
# Automated Git push script for Music Theory AI Chat

# Print banner
echo "====================================================="
echo "🎵 Music Theory AI Chat - Git Repository Manager 🎹"
echo "====================================================="

# Navigate to the repository directory
REPO_DIR=$(dirname "$(realpath "$0")")
cd "$REPO_DIR"

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "❌ Error: Not a git repository. Run 'git init' first."
    exit 1
fi

# Check for changes
if git diff-index --quiet HEAD --; then
    echo "ℹ️ No changes to commit."
else
    echo "🔍 Changes detected in the repository."
fi

# Check for untracked files
if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo "🆕 Untracked files detected."
fi

# Optional: Show status before proceeding
echo -e "\n📊 Current git status:"
git status --short

# Ask for commit message
echo -e "\n✏️ Enter commit message (or press Enter for default message):"
read commit_msg

# Use default message if none provided
if [ -z "$commit_msg" ]; then
    commit_msg="Update Music Theory AI Chat application $(date +"%Y-%m-%d %H:%M")"
    echo "ℹ️ Using default commit message."
fi

# Stage changes
echo -e "\n📦 Staging changes..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "$commit_msg"

# Check if a remote is configured
if git remote -v | grep -q "origin"; then
    # Push changes
    echo "🚀 Pushing changes to remote repository..."
    echo "   (Enter your credentials if prompted)"
    git push origin master

    # Check push status
    if [ $? -eq 0 ]; then
        echo "✅ Successfully pushed changes to remote repository!"
    else
        echo "❌ Failed to push changes. Check your network connection and credentials."
    fi
else
    echo "ℹ️ No remote repository configured."
    echo "   To add a remote repository, use:"
    echo "   git remote add origin <your-repo-url>"
    echo "   Then run this script again."
fi

echo -e "\n✅ Git operations completed!"
echo "====================================================="
