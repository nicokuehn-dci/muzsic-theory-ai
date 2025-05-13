#!/bin/bash
# filepath: upload_release.sh

VERSION="1.0.0"
GITHUB_USER="nicokuehn-dci"
REPO="muzsic-theory-ai"

echo "Bereite Release v$VERSION für den Upload vor..."
echo "===== WICHTIG: GitHub Token-Berechtigungen ====="
echo "1. Gehen Sie zu: https://github.com/settings/tokens/new"
echo "2. Geben Sie einen Namen ein (z.B. 'Music Theory AI Release')"
echo "3. Wählen Sie folgende Berechtigungen:"
echo "   - [x] repo (alle Checkboxen darunter)"
echo "   - [x] workflow"  
echo "   - [x] write:packages"
echo "   - [x] delete:packages"
echo "   - [x] admin:org (nur wenn Sie in einer Organisation sind)"
echo "4. Generieren Sie den Token und kopieren Sie ihn"
echo "================================================"
echo

# Check if token is provided via environment variable
if [ -z "$GITHUB_TOKEN" ]; then
    read -p "GitHub Personal Access Token: " GITHUB_TOKEN
    echo
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Token erforderlich. Abbruch."
    exit 1
fi

echo "Erstelle Release v$VERSION..."
API_JSON=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    -d "{\"tag_name\": \"v$VERSION\", \"name\": \"v$VERSION\", \"body\": \"Music Theory AI Assistant v$VERSION\"}" \
    "https://api.github.com/repos/$GITHUB_USER/$REPO/releases")

RELEASE_ID=$(echo $API_JSON | grep -o '"id": [0-9]*' | head -1 | sed 's/"id": //')

if [ -z "$RELEASE_ID" ]; then
    echo "Fehler beim Erstellen des Releases. API-Antwort:"
    echo "$API_JSON"
    exit 1
fi

echo "Release erstellt mit ID: $RELEASE_ID"
echo "Lade .deb-Datei hoch..."

curl -s -H "Authorization: token $GITHUB_TOKEN" \
    -H "Content-Type: application/octet-stream" \
    --data-binary @"music-theory-ai_${VERSION}_all.deb" \
    "https://uploads.github.com/repos/$GITHUB_USER/$REPO/releases/$RELEASE_ID/assets?name=music-theory-ai_${VERSION}_all.deb"

echo "Upload abgeschlossen. Release ist verfügbar unter:"
echo "https://github.com/$GITHUB_USER/$REPO/releases/tag/v$VERSION"
echo
echo "Debian-Paket kann mit folgender URL heruntergeladen werden:"
echo "https://github.com/$GITHUB_USER/$REPO/releases/download/v$VERSION/music-theory-ai_${VERSION}_all.deb"
