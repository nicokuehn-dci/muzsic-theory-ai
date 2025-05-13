# Music Theory AI Chat Assistant - Installation Guide (v1.0.3)

This guide provides detailed instructions for installing the Music Theory AI Chat Assistant on different Python versions, with specific guidance for Python 3.13 users.

## System Requirements

- **Operating System**: Debian-based Linux distribution (Ubuntu, Debian, Linux Mint, etc.)
- **Python Version**: Python 3.8 or later (including Python 3.13)
- **Dependencies**: The installer will handle most dependencies, but requires internet access

## Installation Methods

### Method 1: Using the Debian Package (Recommended)

1. Download the latest Debian package from the [GitHub Releases page](https://github.com/nicokuehn-dci/muzsic-theory-ai/releases/latest)

2. Install the package:
   ```bash
   sudo dpkg -i music-theory-ai_1.0.3_all.deb
   ```

3. If you encounter dependency issues, run:
   ```bash
   sudo apt-get -f install
   ```

4. Follow the on-screen instructions to configure your Groq API key

### Method 2: Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/nicokuehn-dci/muzsic-theory-ai.git
   cd muzsic-theory-ai
   ```

2. Install system dependencies:
   ```bash
   sudo apt-get update
   sudo apt-get install -y python3-pip python3-venv portaudio19-dev python3-pyaudio
   ```

3. Create and activate a virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

4. Install Python dependencies:
   
   **For Python 3.8 - 3.12**:
   ```bash
   pip install -r requirements.txt
   ```
   
   **For Python 3.13**:
   ```bash
   # Install problematic packages separately first
   pip install --no-build-isolation playsound==1.2.2
   
   # Install main dependencies with no build isolation
   pip install --no-build-isolation -r requirements.txt
   
   # If you encounter groq installation issues, install directly from GitHub
   pip install --no-build-isolation git+https://github.com/groq/groq-python.git
   ```

5. Run the application:
   ```bash
   python first_ai.py
   ```

## Troubleshooting

### Python 3.13 Specific Issues

If you encounter errors like "OSError: could not get source code" during installation with Python 3.13:

1. Try installing packages without build isolation:
   ```bash
   pip install --no-build-isolation <package-name>
   ```

2. Ensure you have the latest pip version:
   ```bash
   pip install --upgrade pip
   ```

3. For persistent issues with the `groq` package, install it directly from GitHub:
   ```bash
   pip install --no-build-isolation git+https://github.com/groq/groq-python.git
   ```

### PyAudio Installation Problems

If you encounter issues with PyAudio installation:

1. Install it using apt instead of pip:
   ```bash
   sudo apt-get install python3-pyaudio
   ```

2. Make sure you have the PortAudio development files:
   ```bash
   sudo apt-get install portaudio19-dev
   ```

### Virtual Environment Issues

If you have problems with the virtual environment:

1. Try creating it with system packages:
   ```bash
   python3 -m venv venv --system-site-packages
   ```

2. If needed, reinstall the virtual environment:
   ```bash
   rm -rf venv
   python3 -m venv venv
   source venv/bin/activate
   ```

## Getting Help

If you continue to experience installation issues, please:

1. Check the [GitHub Issues page](https://github.com/nicokuehn-dci/muzsic-theory-ai/issues) for similar problems
2. Create a new issue with details about your system and the exact error messages
3. Contact the developer at nico.kuehn.dci@gmail.com
