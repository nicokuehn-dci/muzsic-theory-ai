#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/lectures/first_ai/setup.sh

# Music Theory AI Chat Installation Script
echo "================================================================"
echo "🎵 Music Theory AI Chat Assistant - Installation Script 🎹"
echo "================================================================"

# Check if Python 3.6+ is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is required but not installed."
    echo "   Please install Python 3.6+ and try again."
    exit 1
fi

# Check Python version
PY_VERSION=$(python3 -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
if (( $(echo "$PY_VERSION < 3.6" | bc -l) )); then
    echo "❌ Error: Python 3.6+ is required. You have Python $PY_VERSION"
    exit 1
fi

# Create virtual environment
echo -e "\n📦 Creating virtual environment..."
python3 -m venv venv || { echo "❌ Failed to create virtual environment"; exit 1; }
source venv/bin/activate || { echo "❌ Failed to activate virtual environment"; exit 1; }

# Install basic requirements
echo -e "\n📥 Installing required packages..."
pip install -q --upgrade pip
pip install -q -r requirements.txt || { 
    echo "❌ Failed to install some packages. Trying individual installations..."
    
    # Try installing core dependencies individually
    pip install -q groq python-dotenv fpdf python-docx rich
    
    # Note that we continue even if some packages fail
}

# Create necessary directories
echo -e "\n📁 Setting up directories..."
mkdir -p saved_chats
mkdir -p saved_sessions

# Make the main script executable
echo -e "\n🔧 Making the script executable..."
chmod +x first_ai.py

# Check for cloud TTS dependencies
echo -e "\n🔍 Checking voice capabilities..."
if python3 -c "import pyttsx3, speech_recognition" &> /dev/null; then
    echo "✅ Basic voice capabilities are ready."
else
    echo "⚠️ Basic voice packages not fully installed."
fi

if python3 -c "import requests, playsound" &> /dev/null; then
    echo "✅ Cloud TTS capabilities are ready."
else
    echo "⚠️ Cloud TTS packages not fully installed."
    echo "   For enhanced voice quality, run: pip install requests playsound"
fi

# Check for music notation
if python3 -c "import music21" &> /dev/null; then
    echo "✅ Music notation capabilities are ready."
else
    echo "⚠️ Music notation packages not fully installed."
    echo "   For music notation support, run: pip install music21"
fi

# Check if Groq API key is set
if [ -z "$GROQ_API_KEY" ]; then
    echo -e "\n⚠️ GROQ_API_KEY environment variable is not set."
    echo "   To set it now temporarily, export GROQ_API_KEY=your_api_key_here"
    
    # Create a template .env file if it doesn't exist
    if [ ! -f .env ]; then
        echo -e "\n📝 Creating a template .env file..."
        echo "# Add your API key below" > .env
        echo "GROQ_API_KEY=your_key_here" >> .env
        echo "# Uncomment if using OpenAI API" >> .env
        echo "# OPENAI_API_KEY=your_openai_key_here" >> .env
        echo "# Voice settings (optional)" >> .env
        echo "# DEFAULT_TTS_RATE=150" >> .env
        echo "# DEFAULT_TTS_VOLUME=1.0" >> .env
        echo "✅ Created .env file template. Please edit it with your API key."
    fi
fi

echo -e "\n✅ Installation complete!"
echo -e "================================================================"
echo -e "To start the application:"
echo -e "1. Ensure your virtual environment is activated:"
echo -e "   source venv/bin/activate"
echo -e ""
echo -e "2. Run the application:"
echo -e "   ./first_ai.py"
echo -e "   or"
echo -e "   python3 first_ai.py"
echo -e "================================================================"
