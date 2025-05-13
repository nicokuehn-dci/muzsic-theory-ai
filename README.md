# Music Theory AI Chat Assistant

![Version](https://img.shields.io/badge/version-1.0.3-blue)
![Python](https://img.shields.io/badge/python-3.8--3.13-green)
![License](https://img.shields.io/badge/license-MIT-brightgreen)

A sophisticated command-line chat application designed for interactive music theory education, powered by the Groq AI API. This application combines natural language processing with music notation rendering and voice interaction capabilities to create an engaging and educational experience.

## 🎵 Overview

The Music Theory AI Chat Assistant serves as a virtual music theory tutor, capable of explaining complex musical concepts, providing examples with visual notation, and engaging in voice-based conversations. Perfect for music students, educators, and enthusiasts looking to enhance their understanding of music theory.

## ✨ Key Features

### 🤖 AI-Powered Learning
- **Interactive Conversations**: Engage in natural dialogues about music theory with a knowledgeable AI assistant
- **Specialized Topics**: Focus on specific areas including harmony, composition, ear training, counterpoint, and more
- **Adaptive Learning**: The AI tailors explanations based on user knowledge level and questions

### 🎼 Music Notation
- **Visual Examples**: Renders ABC notation into viewable musical scores
- **Real-time Generation**: Creates example scales, chords, progressions, and melodies on demand
- **Integration with MuseScore**: Optional enhanced rendering quality with MuseScore

### 🔊 Voice Interaction
- **Voice Input**: Ask questions and give commands through your microphone
- **Text-to-Speech**: Listen to AI responses with natural-sounding speech
- **Dual TTS Options**: Choose between local (pyttsx3) or cloud-based TTS for higher quality output

### 📊 User Experience
- **Rich Text Formatting**: Markdown rendering for enhanced readability
- **Session Management**: Save and restore conversation sessions for continuous learning
- **Multiple Export Options**: Save conversations as TXT, PDF, or DOCX files
- **Elegant Console Interface**: Progress indicators and formatted text for improved usability

## 🛠 Technical Requirements

- **Python**: 3.8 to 3.13 (fully tested and compatible)
- **Groq API**: Valid API key (set as environment variable or in `.env` file)
- **Optional Software**:
  - MuseScore (for enhanced music notation quality)
  - System audio support for voice features
- **Required System Packages** (for Debian-based systems):
  - `python3-pip`, `python3-venv`, `portaudio19-dev`, `python3-pyaudio`
- **Required Python Packages**: All dependencies are managed in `requirements.txt`

## 🚀 Quick Start Guide

The simplest way to get started is using the included setup script:

```bash
# Make the setup script executable
chmod +x setup.sh

# Run the setup script
./setup.sh

# Activate the virtual environment
source venv/bin/activate

# Set your Groq API key
export GROQ_API_KEY=your_api_key_here
# Alternatively, create a .env file with: GROQ_API_KEY=your_key

# Launch the application
./first_ai.py
```

## 🎤 Voice Capabilities

The application offers two tiers of voice interaction:

### Basic Voice Setup
- Voice input via microphone using SpeechRecognition
- Local text-to-speech via pyttsx3
- Configurable speech rate and volume

### Enhanced Cloud TTS
- Higher quality voice output using cloud-based services
- Improved pronunciation of musical terminology
- Better handling of longer text passages

**Note**: PyAudio installation may require additional system packages:
- **Ubuntu/Debian**: `sudo apt-get install portaudio19-dev python3-pyaudio`
- **macOS**: `brew install portaudio`
- **Windows**: Typically works with standard pip install

## 🎹 Music Notation System

The application leverages music21 and ABC notation for interactive music examples:

- **Dynamic Generation**: Create notation for various musical elements
- **Visual Rendering**: Convert ABC notation in AI responses to graphical notation
- **Customization Options**: Adjust notation parameters for different contexts

For optimal notation rendering, installing MuseScore is recommended:
- **Ubuntu/Debian**: `sudo apt-get install musescore`
- **macOS/Windows**: Download from [MuseScore website](https://musescore.org/)

## 📋 Command Reference

### Core Commands
- `exit`, `quit`: End the conversation and exit the application
- `help`: Display all available commands with descriptions
- `clear`: Clear the conversation history while preserving the selected topic
- `models`: List and select available Groq AI models
- `temp <value>`: Adjust temperature (0.0-1.0) to control AI response creativity

### Topic Management
- `topic`: Select a specialized music topic to focus the conversation

### Session Management
- `save txt`: Export conversation to a text file
- `save pdf`: Export conversation to a PDF document
- `save docx`: Export conversation to a Word document
- `save session`: Preserve the current conversation state to a session file
- `load session`: Restore a previously saved conversation session

### Voice Commands
- `voice input`: Toggle microphone input for speaking your messages
- `voice output`: Read the last AI response aloud using text-to-speech
- `voice settings`: Configure voice output settings (rate, volume)
- `install cloud tts`: Install packages required for high-quality cloud TTS

### Music Notation Commands
- `music example`: Generate example music notation (scale, chord, or melody)
- `render notation`: Convert ABC notation from the last AI response into visual notation

## 🔄 Example Workflow

1. Start by selecting a topic: `topic harmony`
2. Ask a question about chord progressions
3. When the AI mentions a chord progression in ABC notation, use `render notation`
4. Use `voice output` to hear the explanation read aloud
5. Save your learning progress with `save session`
6. Export materials with `save pdf` for future reference

## 🧰 Project Components

### Core Files
- **first_ai.py**: Main application script with chat interface and command processing
- **music_notation.py**: Music notation rendering engine using music21 and ABC notation
- **prompt_manager.py**: Manages different prompt types and AI conversation states
- **topic_manager.py**: Handles topic selection and specialization for music theory domains
- **system_prompts.json**: System prompt templates defining AI behavior for different topics

### Utility Scripts
- **setup.sh**: Installation script for environment setup and dependencies
- **git_push.sh**: Quick Git commit and push script
- **git_manager.sh**: Interactive Git management interface
- **scheduled_push.sh**: Automated Git operation script for scheduled backups

## 📂 Directory Structure

```
first_ai/
├── first_ai.py          # Main application script
├── music_notation.py    # Music notation rendering module
├── prompt_manager.py    # Manages prompt types and state
├── topic_manager.py     # Handles topic selection and specialization
├── system_prompts.json  # System prompt templates for different topics
├── requirements.txt     # Python dependencies
├── setup.sh             # Installation script
├── git_*.sh             # Git automation scripts
├── README.md            # Documentation
├── saved_chats/         # Directory for exported conversations
└── saved_sessions/      # Directory for saved conversation sessions
```

## ⚙️ Advanced Configuration

### Environment Variables

The application supports the following environment variables:

- `GROQ_API_KEY`: Your Groq API key (required)
- `MUSESCORE_PATH`: Custom path to MuseScore executable
- `DEFAULT_TTS_RATE`: Default speech rate (default: 150)
- `DEFAULT_TTS_VOLUME`: Default speech volume (default: 1.0)

These can be set in your shell or in a `.env` file in the project directory.

### Custom Topics

You can extend the `system_prompts.json` file with your own specialized music topics:

```json
{
  "jazz_theory": {
    "prompt": "You are a professional jazz theory teacher...",
    "description": "Jazz theory and improvisation"
  }
}
```

## 🛡️ Error Handling

The application includes robust error handling for:

- API connectivity issues
- Audio device problems
- File system access errors
- Invalid user inputs
- Music notation rendering failures

Error messages are descriptive and suggest potential solutions to common issues.

## 🤝 Contributing

Contributions to improve the Music Theory AI Chat Assistant are welcome:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📚 Acknowledgments

- The Groq team for their powerful AI models
- The music21 project for music notation capabilities
- The Python community for the excellent libraries that power this application
```

## Running Outside VS Code
The application is designed to run in any terminal environment:

```bash
# Make the script executable (if not already)
chmod +x first_ai.py

# Run directly
./first_ai.py

# Or using Python
python3 first_ai.py
```

## 📦 Debian Installation

For Debian, Ubuntu, and compatible distributions, you can install Music Theory AI Assistant using the Debian package:

### Building the Package

If you want to build the Debian package yourself:

```bash
# Make scripts executable
chmod +x build_deb_package.sh build_package.sh

# Build the package
./build_package.sh
```

The resulting .deb file will be in the project root directory.

### Option 1: Direct Installation
```bash
# Download the .deb package
wget https://github.com/nico-kuehn-dci/music-theory-ai/releases/download/v1.0.0/music-theory-ai_1.0.0_all.deb

# Install the package
sudo apt install ./music-theory-ai_1.0.0_all.deb
```

### Option 2: Using APT Repository
```bash
# Add the repository key
curl -s https://raw.githubusercontent.com/nico-kuehn-dci/music-theory-ai/main/KEY.gpg | sudo apt-key add -

# Add the repository
echo "deb [arch=all] https://github.com/nico-kuehn-dci/music-theory-ai/releases/download/apt-repo ./" | \
    sudo tee /etc/apt/sources.list.d/music-theory-ai.list

# Update and install
sudo apt update
sudo apt install music-theory-ai
```

### First Run Configuration
When you first install the package, you'll be prompted to enter your Groq API key. If you skip this step during installation, you can configure it later by running:

```bash
music-theory-ai-config
```

After installation, you can launch the application from your application menu or by running:
```bash
music-theory-ai
```
