import os
import json
from pathlib import Path

def get_api_key():
    """Holt den Groq API-Schlüssel aus verschiedenen möglichen Quellen."""
    
    # 1. Prüfe Umgebungsvariable (höchste Priorität)
    if 'GROQ_API_KEY' in os.environ:
        return os.environ['GROQ_API_KEY']
    
    # 2. Prüfe dotenv Datei im aktuellen Verzeichnis
    if os.path.exists('.env'):
        try:
            with open('.env', 'r') as f:
                for line in f:
                    if line.strip().startswith('GROQ_API_KEY='):
                        return line.strip().split('=', 1)[1].strip(' \'"')
        except:
            pass
    
    # 3. Prüfe benutzerspezifische Konfiguration
    user_config = os.path.join(Path.home(), ".config/music-theory-ai/config.json")
    if os.path.exists(user_config):
        try:
            with open(user_config, 'r') as f:
                config = json.load(f)
                if 'api_key' in config and config['api_key']:
                    return config['api_key']
        except (json.JSONDecodeError, IOError):
            pass
    
    # 4. Prüfe systemweite Konfiguration
    system_config = "/etc/music-theory-ai/config.json"
    if os.path.exists(system_config):
        try:
            with open(system_config, 'r') as f:
                config = json.load(f)
                if 'api_key' in config and config['api_key']:
                    return config['api_key']
        except (json.JSONDecodeError, IOError):
            pass
    
    # 5. Keine Konfiguration gefunden
    return None
