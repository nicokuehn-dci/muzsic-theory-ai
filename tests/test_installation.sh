#!/bin/bash
# filepath: test_installation.sh
# Script to test the installation of the music-theory-ai package

echo "================================================================"
echo "🎵 Music Theory AI Assistant - Installation Test 🎹"
echo "================================================================"
echo

# Check if the package is installed
if dpkg -l music-theory-ai &> /dev/null; then
    echo "✅ The package is installed."
else
    echo "❌ The package is not installed."
    echo "Run: sudo apt install ./music-theory-ai_1.0.0_all.deb"
    exit 1
fi

# Check if the main script exists and is executable
if [ -f /usr/local/bin/music-theory-ai ] && [ -x /usr/local/bin/music-theory-ai ]; then
    echo "✅ The main application script exists and is executable."
else
    echo "❌ The main application script is missing or not executable."
    exit 1
fi

# Check if the virtual environment exists
if [ -d /usr/local/bin/music-theory-ai/venv ]; then
    echo "✅ The Python virtual environment exists."
    
    # Check if it contains the necessary activation script
    if [ -f /usr/local/bin/music-theory-ai/venv/bin/activate ]; then
        echo "✅ The virtual environment activation script exists."
    else
        echo "❌ The virtual environment activation script is missing."
    fi
else
    echo "❌ The Python virtual environment is missing."
    echo "This might cause the application to fail if dependencies are not installed globally."
fi

# Check for API configuration
if [ -f "$HOME/.config/music-theory-ai/config.json" ]; then
    echo "✅ User-specific API configuration exists."
elif [ -f "/etc/music-theory-ai/config.json" ]; then
    echo "✅ System-wide API configuration exists."
else
    echo "❓ No API configuration found. The application will prompt for an API key on first run."
fi

echo
echo "================================================================"
echo "Test completed. If all checks passed, you can run the application:"
echo "music-theory-ai"
echo "================================================================"
