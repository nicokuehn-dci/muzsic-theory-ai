import os
from pathlib import Path

def get_directories():
    """
    Returns the appropriate directories for saved chats and sessions
    based on whether we're running as a Debian package or from source.
    """
    # Check if we're running as a Debian package
    is_debian_package = os.path.exists('/usr/local/bin/music-theory-ai-config')
    
    if is_debian_package:
        # Use the user's home directory for installed package
        home_dir = Path.home()
        user_data_dir = os.path.join(home_dir, ".music-theory-ai")
        saved_chats_dir = os.path.join(user_data_dir, "saved_chats")
        saved_sessions_dir = os.path.join(user_data_dir, "saved_sessions")
    else:
        # Use local directories for development
        current_dir = os.path.dirname(os.path.abspath(__file__))
        saved_chats_dir = os.path.join(current_dir, "saved_chats")
        saved_sessions_dir = os.path.join(current_dir, "saved_sessions")
    
    # Ensure directories exist
    os.makedirs(saved_chats_dir, exist_ok=True)
    os.makedirs(saved_sessions_dir, exist_ok=True)
    
    return saved_chats_dir, saved_sessions_dir
