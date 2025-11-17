#!/usr/bin/env bash
# Wrapper: delegate to scripts/build_deb_package.sh
exec "$(dirname "$0")/scripts/build_deb_package.sh" "$@"
#!/usr/bin/env bash
# Wrapper: delegate to scripts/build_deb_package.sh
exec "$(dirname "$0")/scripts/build_deb_package.sh" "$@"
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
