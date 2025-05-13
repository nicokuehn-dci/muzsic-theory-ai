#!/bin/bash
# filepath: build_deb_package.sh

# Erstelle Basisverzeichnisstruktur
mkdir -p music-theory-ai/DEBIAN
mkdir -p music-theory-ai/usr/local/bin/music-theory-ai
mkdir -p music-theory-ai/usr/share/applications
mkdir -p music-theory-ai/usr/share/icons/music-theory-ai
mkdir -p music-theory-ai/usr/share/doc/music-theory-ai
mkdir -p music-theory-ai/etc/music-theory-ai

# Kopiere Anwendungsdateien
echo "Kopiere Anwendungsdateien..."
cp first_ai.py music_notation.py prompt_manager.py topic_manager.py system_prompts.json requirements.txt setup.sh music-theory-ai/usr/local/bin/music-theory-ai/

# Erstelle Verzeichnisse für Daten
mkdir -p music-theory-ai/usr/local/bin/music-theory-ai/saved_chats
mkdir -p music-theory-ai/usr/local/bin/music-theory-ai/saved_sessions

# Kopiere das Icon
echo "Kopiere Icon..."
cp Icon.jpeg music-theory-ai/usr/share/icons/music-theory-ai/app-icon.jpg

# Kopiere README und erstelle Lizenz
cp README.md music-theory-ai/usr/share/doc/music-theory-ai/
echo "MIT License" > music-theory-ai/usr/share/doc/music-theory-ai/LICENSE

# Control-Datei für Debian-Paket
cat > music-theory-ai/DEBIAN/control << EOL
Package: music-theory-ai
Version: 1.0.0
Section: education
Priority: optional
Architecture: all
Depends: python3 (>= 3.8), python3-pip, python3-venv, portaudio19-dev, python3-pyaudio, musescore3 | mscore3
Recommends: ffmpeg
Suggests: 
Maintainer: Nico Kühn <nico.kuehn.dci@gmail.com>
Homepage: https://github.com/nico-kuehn-dci/music-theory-ai
Description: Music Theory AI Chat Assistant
 An interactive command-line application for music theory education
 powered by Groq AI API.
 .
 Features include:
  * Conversational learning about music theory concepts
  * Interactive voice input and output
  * Music notation rendering with ABC notation and Music21
  * Custom topics covering harmony, composition, ear training and more
  * Export options for saving lessons in multiple formats
EOL

# Post-Installation-Skript
cat > music-theory-ai/DEBIAN/postinst << EOL
#!/bin/bash
set -e

# Verzeichnisse erstellen
echo "Einrichtung der Verzeichnisstruktur..."
mkdir -p /usr/local/share/music-theory-ai
mkdir -p /etc/music-theory-ai

# Python-Abhängigkeiten installieren
echo "Installation der Python-Abhängigkeiten..."
cd /usr/local/bin/music-theory-ai

# Prüfe, ob python3-venv installiert ist
if ! dpkg -l python3-venv &> /dev/null; then
    echo "Das python3-venv Paket ist nicht installiert. Installiere es jetzt..."
    apt-get update
    apt-get install -y python3-venv
fi

# Versuche, eine virtuelle Umgebung zu erstellen
echo "Erstelle Python virtuelle Umgebung..."
if ! python3 -m venv venv; then
    echo "Fehler beim Erstellen der virtuellen Umgebung."
    echo "Versuche mit expliziten Berechtigungen..."
    python3 -m venv venv --system-site-packages
fi

# Aktiviere die virtuelle Umgebung und installiere Abhängigkeiten
echo "Aktiviere virtuelle Umgebung und installiere Abhängigkeiten..."
if [ -f venv/bin/activate ]; then
    source venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    # Überprüfen, ob die Installation erfolgreich war
    if [ $? -ne 0 ]; then
        echo "WARNUNG: Einige Abhängigkeiten konnten nicht installiert werden."
        echo "Sie können die Installation manuell durchführen mit:"
        echo "cd /usr/local/bin/music-theory-ai && source venv/bin/activate && pip install -r requirements.txt"
    fi
else
    echo "FEHLER: Die virtuelle Umgebung konnte nicht erstellt werden."
    echo "Versuche Python-Pakete global zu installieren..."
    pip3 install -r requirements.txt
fi

# API-Schlüssel abfragen und speichern
echo "---------------------------------------"
echo "Music Theory AI Assistant - Konfiguration"
echo "---------------------------------------"
echo "Diese Anwendung benötigt einen Groq API-Schlüssel."
echo "Sie können diesen kostenlos unter https://console.groq.com/ erhalten."
echo 

# Wiederholen bis gültiger Schlüssel eingegeben oder abgebrochen wird
while true; do
    echo -n "Bitte geben Sie Ihren Groq API-Schlüssel ein (oder 'später' zum Überspringen): "
    read -r API_KEY
    
    if [ "\$API_KEY" = "später" ]; then
        echo "Sie können den API-Schlüssel später mit dem Befehl 'music-theory-ai-config' einrichten."
        break
    fi
    
    if [ -z "\$API_KEY" ]; then
        echo "Der API-Schlüssel darf nicht leer sein. Bitte versuchen Sie es erneut."
        continue
    fi
    
    # Einfacher Test des API-Schlüssels
    echo "Überprüfe API-Schlüssel..."
    if python3 -c "
import requests
try:
    headers = {'Authorization': f'Bearer \$API_KEY'}
    response = requests.get('https://api.groq.com/v1/models', headers=headers)
    if response.status_code == 200:
        print('API-Schlüssel ist gültig')
        exit(0)
    else:
        print('API-Schlüssel scheint ungültig zu sein')
        exit(1)
except Exception as e:
    print(f'Fehler bei der API-Überprüfung: {e}')
    exit(1)
" &> /dev/null; then
        echo "API-Schlüssel wurde validiert."
        # Speichere in einer Konfigurationsdatei
        echo "{\"api_key\": \"\$API_KEY\"}" > /etc/music-theory-ai/config.json
        chmod 600 /etc/music-theory-ai/config.json
        break
    else
        echo "Der API-Schlüssel konnte nicht validiert werden. Bitte überprüfen Sie den Schlüssel."
        echo "Möchten Sie es erneut versuchen? (j/n)"
        read -r RETRY
        if [ "\$RETRY" != "j" ]; then
            echo "Sie können den API-Schlüssel später mit dem Befehl 'music-theory-ai-config' einrichten."
            break
        fi
    fi
done

# Konfigurationstool erstellen
cat > /usr/local/bin/music-theory-ai-config << 'EOTOOL'
#!/bin/bash

function configure_api_key() {
    echo "Music Theory AI Assistant - API-Schlüssel Konfiguration"
    echo "-------------------------------------------------------"
    echo "Bitte besuchen Sie https://console.groq.com/ um einen API-Schlüssel zu erhalten."
    echo -n "Geben Sie Ihren Groq API-Schlüssel ein: "
    read -r API_KEY
    
    if [ -z "\$API_KEY" ]; then
        echo "Der API-Schlüssel darf nicht leer sein."
        return 1
    fi
    
    # Für den Benutzer speichern
    mkdir -p "\$HOME/.config/music-theory-ai"
    echo "{\"api_key\": \"\$API_KEY\"}" > "\$HOME/.config/music-theory-ai/config.json"
    chmod 600 "\$HOME/.config/music-theory-ai/config.json"
    echo "API-Schlüssel wurde in \$HOME/.config/music-theory-ai/config.json gespeichert."
}

# Hauptmenü
echo "Music Theory AI Assistant - Konfiguration"
echo "----------------------------------------"
echo "1) API-Schlüssel konfigurieren"
echo "2) Beenden"
echo -n "Auswahl: "
read -r CHOICE

case \$CHOICE in
    1) configure_api_key ;;
    *) echo "Beenden." ;;
esac
EOTOOL

chmod 755 /usr/local/bin/music-theory-ai-config

# Anwendungsstarter erstellen
cat > /usr/local/bin/music-theory-ai << 'EOSCRIPT'
#!/bin/bash

# Prüfe, ob API-Schlüssel existiert
if [ ! -f "\$HOME/.config/music-theory-ai/config.json" ] && [ ! -f "/etc/music-theory-ai/config.json" ]; then
    echo "Kein API-Schlüssel gefunden. Starte Konfigurationsassistenten..."
    music-theory-ai-config
fi

# Benutzerverzeichnis einrichten
mkdir -p "\$HOME/.music-theory-ai/saved_chats"
mkdir -p "\$HOME/.music-theory-ai/saved_sessions"

# Starte die Anwendung
cd /usr/local/bin/music-theory-ai

# Prüfe, ob virtuelle Umgebung existiert und aktivierbar ist
if [ -f venv/bin/activate ]; then
    echo "Aktiviere virtuelle Python-Umgebung..."
    source venv/bin/activate
    echo "Starte Music Theory AI Assistant..."
    python3 first_ai.py "\$@"
else
    echo "Warnung: Virtuelle Python-Umgebung nicht gefunden."
    echo "Versuche, die Anwendung mit system-weitem Python zu starten..."
    python3 first_ai.py "\$@"
    
    # Falls das fehlschlägt, gib Hilfestellung
    if [ $? -ne 0 ]; then
        echo
        echo "FEHLER: Die Anwendung konnte nicht gestartet werden."
        echo "Bitte stellen Sie sicher, dass alle erforderlichen Python-Module installiert sind:"
        echo "sudo pip3 install -r /usr/local/bin/music-theory-ai/requirements.txt"
        echo
        echo "Oder reparieren Sie die virtuelle Umgebung mit:"
        echo "sudo rm -rf /usr/local/bin/music-theory-ai/venv"
        echo "cd /usr/local/bin/music-theory-ai && sudo python3 -m venv venv"
        echo "cd /usr/local/bin/music-theory-ai && sudo -H venv/bin/pip install -r requirements.txt"
    fi
fi
EOSCRIPT

chmod 755 /usr/local/bin/music-theory-ai

# API-Konfigurations-Modul erstellen
cat > /usr/local/bin/music-theory-ai/api_config.py << 'EOMODULE'
import os
import json
from pathlib import Path

def get_api_key():
    """Holt den Groq API-Schlüssel aus verschiedenen möglichen Quellen."""
    
    # 1. Prüfe Umgebungsvariable (höchste Priorität)
    if 'GROQ_API_KEY' in os.environ:
        return os.environ['GROQ_API_KEY']
    
    # 2. Prüfe benutzerspezifische Konfiguration
    user_config = os.path.join(Path.home(), ".config/music-theory-ai/config.json")
    if os.path.exists(user_config):
        try:
            with open(user_config, 'r') as f:
                config = json.load(f)
                if 'api_key' in config and config['api_key']:
                    return config['api_key']
        except (json.JSONDecodeError, IOError):
            pass
    
    # 3. Prüfe systemweite Konfiguration
    system_config = "/etc/music-theory-ai/config.json"
    if os.path.exists(system_config):
        try:
            with open(system_config, 'r') as f:
                config = json.load(f)
                if 'api_key' in config and config['api_key']:
                    return config['api_key']
        except (json.JSONDecodeError, IOError):
            pass
    
    # 4. Keine Konfiguration gefunden
    return None
EOMODULE

# Erstelle Desktop-Eintrag
cat > music-theory-ai/usr/share/applications/music-theory-ai.desktop << EOL
[Desktop Entry]
Version=1.0
Name=Music Theory AI Assistant
GenericName=Music Theory Tutor
Comment=Interactive AI assistant for music theory education by Nico Kühn
Exec=/usr/local/bin/music-theory-ai
Terminal=true
Type=Application
Icon=/usr/share/icons/music-theory-ai/app-icon.jpg
Categories=Education;Music;Utility;
Keywords=music;theory;ai;education;learning;
StartupNotify=true
EOL

chmod 755 music-theory-ai/DEBIAN/postinst

# Vor-Entfernen-Skript
cat > music-theory-ai/DEBIAN/prerm << EOL
#!/bin/bash
set -e

echo "Entferne Music Theory AI Assistant..."
# Lösche generierte Skripte
rm -f /usr/local/bin/music-theory-ai
rm -f /usr/local/bin/music-theory-ai-config

# Systemweite Konfiguration bleibt erhalten, falls der Benutzer sie behalten möchte
echo "Hinweis: Benutzerdaten in ~/.music-theory-ai/ und ~/.config/music-theory-ai/ bleiben erhalten."
echo "Wenn Sie diese löschen möchten, führen Sie aus:"
echo "rm -rf ~/.music-theory-ai/ ~/.config/music-theory-ai/"

exit 0
EOL

chmod 755 music-theory-ai/DEBIAN/prerm

# Copyright-Datei
cat > music-theory-ai/usr/share/doc/music-theory-ai/copyright << EOL
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: Music Theory AI Assistant
Upstream-Contact: Nico Kühn <nico.kuehn.dci@gmail.com>
Source: https://github.com/nico-kuehn-dci/music-theory-ai

Files: *
Copyright: 2023-2025 Nico Kühn
License: MIT
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 .
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 .
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
EOL

echo "Debian-Paket Struktur wurde erfolgreich erstellt!"
