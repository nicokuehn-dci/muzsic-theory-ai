#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/lectures/first_ai/git_manager.sh
# Comprehensive Git repository management script for Music Theory AI Chat

# Print banner
echo "====================================================="
echo "🎵 Music Theory AI Chat - Git Repository Manager 🎹"
echo "====================================================="

# Navigate to the repository directory
REPO_DIR=$(dirname "$(realpath "$0")")
cd "$REPO_DIR"

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "❌ Not a git repository. Would you like to initialize one? (y/n)"
    read init_repo
    
    if [[ $init_repo == "y" || $init_repo == "Y" ]]; then
        git init
        echo "✅ Git repository initialized."
    else
        echo "ℹ️ Exiting without initializing repository."
        exit 0
    fi
fi

# Function to show menu
show_menu() {
    echo -e "\n📋 Git Operations Menu:"
    echo "1. Check status"
    echo "2. View changes (diff)"
    echo "3. Stage all changes"
    echo "4. Commit changes"
    echo "5. Push to remote"
    echo "6. Pull from remote"
    echo "7. Full process (stage, commit, push)"
    echo "8. Configure remote repository"
    echo "9. View commit history"
    echo "10. Create/switch branch"
    echo "0. Exit"
    echo -n "Enter your choice: "
}

# Function to check status
check_status() {
    echo -e "\n📊 Current git status:"
    git status
}

# Function to view diff
view_diff() {
    echo -e "\n🔍 Changes since last commit:"
    git diff --color
}

# Function to stage changes
stage_changes() {
    echo -e "\n📦 Staging all changes..."
    git add .
    echo "✅ Changes staged."
}

# Function to commit changes
commit_changes() {
    echo -e "\n✏️ Enter commit message (or press Enter for default message):"
    read commit_msg
    
    # Use default message if none provided
    if [ -z "$commit_msg" ]; then
        commit_msg="Update Music Theory AI Chat application $(date +"%Y-%m-%d %H:%M")"
        echo "ℹ️ Using default commit message."
    fi
    
    # Commit changes
    git commit -m "$commit_msg"
    echo "✅ Changes committed."
}

# Function to push to remote
push_to_remote() {
    # Check if a remote is configured
    if git remote -v | grep -q "origin"; then
        echo -e "\n🚀 Pushing changes to remote repository..."
        echo "   (Enter your credentials if prompted)"
        git push origin $(git branch --show-current)
        
        # Check push status
        if [ $? -eq 0 ]; then
            echo "✅ Successfully pushed changes to remote repository!"
        else
            echo "❌ Failed to push changes. Check your network connection and credentials."
        fi
    else
        echo "❌ No remote repository configured."
        echo "   Use option 8 to configure a remote repository."
    fi
}

# Function to pull from remote
pull_from_remote() {
    # Check if a remote is configured
    if git remote -v | grep -q "origin"; then
        echo -e "\n🔄 Pulling changes from remote repository..."
        git pull origin $(git branch --show-current)
        
        # Check pull status
        if [ $? -eq 0 ]; then
            echo "✅ Successfully pulled changes from remote repository!"
        else
            echo "❌ Failed to pull changes. Check for conflicts."
        fi
    else
        echo "❌ No remote repository configured."
        echo "   Use option 8 to configure a remote repository."
    fi
}

# Function for full process
full_process() {
    stage_changes
    commit_changes
    push_to_remote
}

# Function to configure remote
configure_remote() {
    echo -e "\n🔗 Current remote repositories:"
    git remote -v
    
    echo -e "\nDo you want to add/update the 'origin' remote? (y/n)"
    read update_remote
    
    if [[ $update_remote == "y" || $update_remote == "Y" ]]; then
        echo "Enter the remote repository URL:"
        read repo_url
        
        if git remote | grep -q "origin"; then
            git remote set-url origin "$repo_url"
            echo "✅ Updated remote 'origin' to $repo_url"
        else
            git remote add origin "$repo_url"
            echo "✅ Added remote 'origin' as $repo_url"
        fi
    fi
}

# Function to view commit history
view_history() {
    echo -e "\n📜 Commit history:"
    git log --oneline --graph --decorate --color -n 10
}

# Function to create/switch branch
manage_branches() {
    echo -e "\n🌿 Current branch: $(git branch --show-current)"
    echo -e "\nAvailable branches:"
    git branch
    
    echo -e "\n1. Create new branch"
    echo "2. Switch to existing branch"
    echo "3. Return to main menu"
    echo -n "Enter your choice: "
    read branch_choice
    
    case $branch_choice in
        1)
            echo "Enter new branch name:"
            read new_branch
            git checkout -b "$new_branch"
            echo "✅ Created and switched to new branch '$new_branch'"
            ;;
        2)
            echo "Enter branch name to switch to:"
            read target_branch
            git checkout "$target_branch"
            echo "✅ Switched to branch '$target_branch'"
            ;;
        *)
            return
            ;;
    esac
}

# Main menu loop
while true; do
    show_menu
    read choice
    
    case $choice in
        0)
            echo "Exiting..."
            break
            ;;
        1)
            check_status
            ;;
        2)
            view_diff
            ;;
        3)
            stage_changes
            ;;
        4)
            commit_changes
            ;;
        5)
            push_to_remote
            ;;
        6)
            pull_from_remote
            ;;
        7)
            full_process
            ;;
        8)
            configure_remote
            ;;
        9)
            view_history
            ;;
        10)
            manage_branches
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    
    echo -e "\nPress Enter to continue..."
    read
done

echo -e "\n✅ Git operations completed!"
echo "====================================================="
