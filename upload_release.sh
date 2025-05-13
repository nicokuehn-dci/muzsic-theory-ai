#!/bin/bash
# filepath: upload_release.sh

VERSION="1.0.0"
GITHUB_USER="nico-kuehn-dci"
REPO="music-theory-ai"

echo "Bereite Release v$VERSION für den Upload vor..."
echo "Stellen Sie sicher, dass Sie ein GitHub Personal Access Token haben."
echo "Sie können eines erstellen unter: https://github.com/settings/tokens"

read -p "GitHub Personal Access Token: " GITHUB_TOKEN
echo

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
