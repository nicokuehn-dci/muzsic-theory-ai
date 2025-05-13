#!/bin/bash
# filepath: build_package.sh

echo "Erstelle Debian-Paket für Music Theory AI Assistant..."

# Stelle sicher, dass das Skript ausführbar ist
chmod +x build_deb_package.sh

# Verzeichnisstruktur erstellen und Dateien kopieren
./build_deb_package.sh

# Falls ein altes Paket existiert, entferne es
rm -f music-theory-ai.deb music-theory-ai_1.0.0_all.deb

# Paket erstellen
echo "Baue Debian-Paket..."
dpkg-deb --build music-theory-ai

# Umbenennen entsprechend Debian-Konventionen
mv music-theory-ai.deb music-theory-ai_1.0.0_all.deb

echo "======================================================"
echo "Paket erfolgreich erstellt: music-theory-ai_1.0.0_all.deb"
echo "======================================================"
echo
echo "Installieren mit: sudo apt install ./music-theory-ai_1.0.0_all.deb"
echo "Oder hochladen zu GitHub als Release-Asset."
