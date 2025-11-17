#!/usr/bin/env bash
# Wrapper: delegate to scripts/git_manager.sh
exec "$(dirname "$0")/scripts/git_manager.sh" "$@"
#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/lectures/first_ai/git_manager.sh
# Comprehensive Git repository management script for Music Theory AI Chat

#!/usr/bin/env bash
# Wrapper: delegate to scripts/git_manager.sh
exec "$(dirname "$0")/scripts/git_manager.sh" "$@"
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
