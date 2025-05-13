# Installation Guide for Music Theory AI v1.0.2

## Installation der Debian-Datei

Um das Musik Theory AI Assistant zu installieren, verwende bitte den folgenden Befehl:

```bash
sudo apt install ./music-theory-ai_1.0.0_all.deb
```

## Fehlerbehebung

Falls während der Installation Probleme mit den Python-Abhängigkeiten auftreten, kannst du folgende Schritte durchführen:

### 1. System-Pakete manuell installieren

```bash
sudo apt update
sudo apt install python3-pip python3-venv portaudio19-dev python3-pyaudio
```

### 2. Notwendige Python-Pakete installieren

```bash
pip3 install --user groq python-dotenv rich playsound==1.2.2
```

### 3. Anwendung starten

```bash
music-theory-ai
```

### 4. Falls die Anwendung immer noch Probleme macht

Führe folgende Befehle aus, um die virtuelle Umgebung neu zu erstellen:

```bash
sudo rm -rf /usr/local/bin/music-theory-ai/venv
cd /usr/local/bin/music-theory-ai 
sudo python3 -m venv venv
cd /usr/local/bin/music-theory-ai 
sudo -H venv/bin/pip install playsound==1.2.2
sudo -H venv/bin/pip install -r requirements.txt
```

## Was wurde in Version 1.0.2 behoben?

1. Problem mit der playsound-Bibliothek behoben (Version auf 1.2.2 festgelegt)
2. Verbesserte Fehlerbehandlung während der Installation
3. Zusätzliche Fehlerbehandlung beim Starten der Anwendung
4. Automatische Installation fehlender Abhängigkeiten
