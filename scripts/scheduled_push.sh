#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/lectures/first_ai/scheduled_push.sh
# Automated script for scheduled Git operations
# Can be used with cron jobs to automatically commit and push changes

# Set script to exit on error
set -e

# Navigate to the repository directory
REPO_DIR=$(dirname "$(realpath "$0")")
cd "$REPO_DIR"

# Define log file
LOG_FILE="$REPO_DIR/git_automation.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
    echo "$1"
}

log_message "Starting automated Git operations"

# Check if we're in a git repository
if [ ! -d .git ]; then
    log_message "Error: Not a git repository. Exiting."
    exit 1
fi

# Check for changes
if git diff-index --quiet HEAD --; then
    # No changes in tracked files
    # Check for untracked files
    UNTRACKED=$(git ls-files --others --exclude-standard)
    if [ -z "$UNTRACKED" ]; then
        log_message "No changes detected. Exiting."
        exit 0
    fi
fi

# Stage all changes
log_message "Staging changes"
git add .

# Get a meaningful commit message based on changed files
CHANGED_FILES=$(git diff --cached --name-only | tr '\n' ' ')
COMMIT_MSG="Automated update: Changes in $CHANGED_FILES ($(date '+%Y-%m-%d %H:%M'))"

# Commit changes
log_message "Committing changes: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# Check if a remote is configured
if git remote -v | grep -q "origin"; then
    # Push changes
    # Check for environment variable to determine push mode
    PUSH_MODE="${GIT_PUSH_MODE:-current}"  # Default to current branch if not specified
    
    if [ "$PUSH_MODE" = "all" ]; then
        log_message "Pushing all branches to remote repository"
        if git push --all origin; then
            log_message "Successfully pushed all branches to remote repository"
        else
            log_message "Failed to push changes to remote repository"
            exit 1
        fi
    elif [ "$PUSH_MODE" = "all-tags" ]; then
        log_message "Pushing all branches and tags to remote repository"
        if git push --all --tags origin; then
            log_message "Successfully pushed all branches and tags to remote repository"
        else
            log_message "Failed to push changes to remote repository"
            exit 1
        fi
    else
        log_message "Pushing current branch to remote repository"
        if git push origin $(git branch --show-current); then
            log_message "Successfully pushed current branch to remote repository"
        else
            log_message "Failed to push changes to remote repository"
            exit 1
        fi
    fi
else
    log_message "No remote repository configured. Changes committed locally only."
fi

log_message "Automated Git operations completed successfully"
