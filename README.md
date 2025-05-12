# Music Theory AI Chat Assistant

An interactive command-line chat application designed for music theory education, powered by the Groq AI API. This application features advanced voice interaction, music notation rendering, and rich formatting to enhance the learning experience.

## Features

- **Interactive Chat**: Engage in conversations about music theory topics with a knowledgeable AI assistant
- **Topic Selection**: Specialize in different music areas like harmony, composition, ear training, and more
- **Voice Interaction**: Use voice commands for input and listen to AI responses with text-to-speech
  - Basic TTS using pyttsx3
  - Enhanced cloud-based TTS option for better voice quality
  - Voice input through microphone using SpeechRecognition
- **Music Notation**: Display and render ABC notation examples with visual output
  - Generate example scales, chords, and melodies
  - Render ABC notation from AI responses into viewable notation
- **Session Management**: Save and load conversation sessions for continuous learning
- **Export Options**: Save conversations in various formats (TXT, PDF, DOCX)
- **Markdown Rendering**: AI responses are displayed with formatted Markdown for better readability
- **Rich Console Interface**: User-friendly interface with progress indicators and formatted text

## Requirements

- Python 3.6+ (3.8+ recommended)
- Groq API key (set as environment variable `GROQ_API_KEY` or in a `.env` file)
- MuseScore (optional, for improved music notation rendering)
- System audio support for voice features

## Quick Start

The easiest way to get started is to use the included setup script:

```bash
# Make the setup script executable
chmod +x setup.sh

# Run the setup script
./setup.sh

# Activate the virtual environment
source venv/bin/activate

# Set your API key
export GROQ_API_KEY=your_api_key_here
# Or create a .env file with GROQ_API_KEY=your_key

# Run the application
./first_ai.py
```

## Voice Capabilities

The application provides two levels of voice interaction:

### Basic Voice Setup (already included in requirements.txt)
- **Voice Input**: Speak commands and questions using your microphone
- **Basic TTS**: Text-to-speech using the pyttsx3 engine
- **Voice Configuration**: Adjust speech rate and volume

### Enhanced Cloud TTS
For higher quality voice output, the application can use cloud-based text-to-speech:
- More natural-sounding voice
- Better pronunciation of musical terms
- Handles longer passages of text

Note: PyAudio installation might require additional system packages:
- **Ubuntu/Debian**: `sudo apt-get install portaudio19-dev python3-pyaudio`
- **macOS**: `brew install portaudio`
- **Windows**: No additional steps typically needed with pip install

## Music Notation Features

The application uses music21 and ABC notation to provide interactive music examples:

- **Generate Examples**: Create notation for scales, chords, and melodies
- **Render from AI Response**: Convert ABC notation in AI responses to visual notation
- **Customization**: Adjust notation parameters for different musical concepts

The notation rendering works out of the box, but installing MuseScore will provide better quality output:
- **Ubuntu/Debian**: `sudo apt-get install musescore`
- **macOS/Windows**: Download from [MuseScore website](https://musescore.org/)

## Commands Reference

### Basic Commands
- `exit`: End the conversation and exit the application
- `help`: Show all available commands with descriptions
- `clear`: Clear the conversation history (keeps the selected topic)
- `models`: List and select available Groq AI models
- `temp <value>`: Set temperature (0.0-1.0) for AI response creativity

### Topic and Learning
- `topic`: Select a specialized music topic (harmony, ear training, composition, etc.)

### Saving and Loading
- `save txt`: Export conversation to a text file
- `save pdf`: Export conversation to a PDF document
- `save docx`: Export conversation to a Word document
- `save session`: Save the current conversation state to a session file
- `load session`: Load a previously saved conversation session

### Voice Interaction
- `voice input`: Use your microphone to speak your next message
- `voice output`: Read the last AI response aloud using text-to-speech
- `voice settings`: Configure voice output settings (rate, volume)
- `install cloud tts`: Install packages required for high-quality cloud TTS

### Music Notation
- `music example`: Generate an example music notation (scale, chord, or melody)
- `render notation`: Render ABC notation from the last AI response into visual notation

### Example Workflow
1. Start a conversation about a music theory concept
2. Use `topic` to specialize in a specific area like harmony
3. Ask questions or request examples
4. Use `render notation` to visualize ABC notation in responses
5. Use `voice output` to hear explanations
6. `save session` to continue later or `save pdf` to export the learning material

## Git Automation

The project includes several scripts to automate Git operations:

### Quick Push (`git_push.sh`)
A simple script to quickly stage, commit, and push all changes to the remote repository.

```bash
# Make executable (first time only)
chmod +x git_push.sh

# Run the script
./git_push.sh
```

The script will:
1. Check for changes in the repository
2. Prompt for a commit message (or use a default one with timestamp)
3. Stage all changes
4. Commit with the provided message
5. Push to the remote repository (if configured)

### Interactive Git Manager (`git_manager.sh`)
A comprehensive interactive menu for managing Git operations.

```bash
# Make executable (first time only)
chmod +x git_manager.sh

# Run the script
./git_manager.sh
```

Features:
- Check repository status
- View file changes (diff)
- Stage, commit, and push changes
- Pull from remote repository
- Configure remote repository URL
- View commit history
- Create and switch branches
- Full workflow automation (stage, commit, push)

### Scheduled Automation (`scheduled_push.sh`)
Designed for automated backups or continuous integration with no user interaction.

```bash
# Make executable (first time only)
chmod +x scheduled_push.sh

# Run the script manually
./scheduled_push.sh

# Or set up a cron job (example: every hour)
# crontab -e
# 0 * * * * /full/path/to/scheduled_push.sh
```

This script:
- Automatically detects changes in the repository
- Creates meaningful commit messages based on changed files
- Logs all actions to `git_automation.log`
- Can be run silently as a cron job

## Project Structure

```
first_ai/
├── first_ai.py          # Main application script
├── music_notation.py    # Music notation rendering module
├── prompt_manager.py    # Manages prompt types and state
├── topic_manager.py     # Handles topic selection and specialization
├── system_prompts.json  # System prompt templates for different topics
├── requirements.txt     # Python dependencies
├── setup.sh             # Installation script
├── README.md            # Documentation
├── .gitignore           # Git exclusion patterns
├── saved_chats/         # Directory for exported conversations
└── saved_sessions/      # Directory for saved conversation sessions
```

## Advanced Configuration

### Environment Variables
The application supports the following environment variables:

- `GROQ_API_KEY`: Your Groq API key (required)
- `OPENAI_API_KEY`: Optional OpenAI API key for additional models
- `MUSESCORE_PATH`: Custom path to MuseScore executable
- `DEFAULT_TTS_RATE`: Default speech rate (default: 150)
- `DEFAULT_TTS_VOLUME`: Default speech volume (default: 1.0)

These can be set in a `.env` file in the project directory.

### Adding Custom Topics
You can extend the `system_prompts.json` file with your own specialized music topics:

```json
{
  "jazz_theory": {
    "prompt": "You are a professional jazz theory teacher...",
    "description": "Jazz theory and improvisation"
  }
}
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
