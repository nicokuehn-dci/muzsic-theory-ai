#!/bin/bash
# filepath: build_package.sh

echo "Erstelle Debian-Paket für Music Theory AI Assistant..."

# Version aus dem Control-File extrahieren
VERSION=$(grep -Po "Version: \K[0-9]+\.[0-9]+\.[0-9]+" build_deb_package.sh || echo "1.0.3")
echo "Erkannte Version: $VERSION"

# Stelle sicher, dass das Skript ausführbar ist
chmod +x build_deb_package.sh

# Verzeichnisstruktur erstellen und Dateien kopieren
./build_deb_package.sh

# Falls alte Pakete existieren, entferne sie
rm -f music-theory-ai.deb music-theory-ai_*_all.deb

# Paket erstellen
echo "Baue Debian-Paket..."
dpkg-deb --build music-theory-ai

# Umbenennen entsprechend Debian-Konventionen
mv music-theory-ai.deb music-theory-ai_${VERSION}_all.deb

echo "======================================================"
echo "Paket erfolgreich erstellt: music-theory-ai_${VERSION}_all.deb"
echo "======================================================"
echo
echo "Installieren mit: sudo apt install ./music-theory-ai_${VERSION}_all.deb"
echo "Oder hochladen zu GitHub als Release-Asset."
