#!/usr/bin/env bash
# Full setup script in scripts/

set -euo pipefail

echo "================================================================"
echo "🎵 Music Theory AI Chat Assistant - Installation Script 🎹"
echo "================================================================"

# Ensure Python 3 is present
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    exit 1
fi

PY_MIN_MAJOR=3
PY_MIN_MINOR=6
PY_VERSION_STR=$(python3 -c 'import sys; print("{}.{}".format(sys.version_info[0], sys.version_info[1]))')
PY_MAJOR=$(echo "$PY_VERSION_STR" | cut -d. -f1)
PY_MINOR=$(echo "$PY_VERSION_STR" | cut -d. -f2)
if [ "$PY_MAJOR" -lt "$PY_MIN_MAJOR" ] || { [ "$PY_MAJOR" -eq "$PY_MIN_MAJOR" ] && [ "$PY_MINOR" -lt "$PY_MIN_MINOR" ]; }; then
    echo "❌ Python ${PY_MIN_MAJOR}.${PY_MIN_MINOR}+ is required. You have ${PY_VERSION_STR}"
    exit 1
fi

echo "📦 Creating virtual environment 'venv'..."
python3 -m venv venv
source venv/bin/activate

echo "📥 Upgrading pip and installing requirements..."
pip install --upgrade pip
if [ -f requirements.txt ]; then
    pip install -r requirements.txt || true
fi

echo "📁 Creating project directories..."
mkdir -p saved_chats saved_sessions

echo "🔧 Making backend entry executable..."
if [ -f backend/first_ai.py ]; then
    chmod +x backend/first_ai.py
fi

echo "🔍 Quick environment checks (optional warnings):"
python3 - <<'PY'
import importlib
modules = ["pyttsx3", "speech_recognition", "requests", "playsound", "music21"]
for m in modules:
    try:
        importlib.import_module(m)
        print(f"✅ {m}")
    except Exception:
        print(f"⚠️  {m} not available")
PY

if [ -z "${GROQ_API_KEY:-}" ]; then
    echo "⚠️  GROQ_API_KEY environment variable not set."
    if [ ! -f .env ]; then
        cat > .env <<EOF
# Add your API keys here
GROQ_API_KEY=your_key_here
# OPENAI_API_KEY=your_openai_key_here
EOF
        echo "📝 Created .env template at .env"
    fi
fi

echo "\n✅ Installation complete. Activate with: source venv/bin/activate"
echo "Run the backend: python3 backend/first_ai.py"
echo "To run frontend: cd frontend && npm install && npm run dev"
echo "================================================================"
