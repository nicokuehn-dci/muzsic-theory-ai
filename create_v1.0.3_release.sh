#!/bin/bash
# filepath: /home/nico-kuehn-dci/Desktop/portfolio/first_ai/create_v1.0.3_release.sh
#
# Script to help create GitHub release for v1.0.3
#

# ANSI color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${GREEN}Music Theory AI Assistant - v1.0.3 Release Tool${NC}"
echo -e "${BLUE}===============================================${NC}"
echo

# Check if required files exist
if [ ! -f "music-theory-ai_1.0.3_all.deb" ]; then
    echo -e "${RED}ERROR: Package file music-theory-ai_1.0.3_all.deb not found!${NC}"
    echo -e "Please run ./build_package.sh first to create the package."
    exit 1
fi

if [ ! -f "github_release_v1.0.3.md" ]; then
    echo -e "${RED}ERROR: Release notes file github_release_v1.0.3.md not found!${NC}"
    exit 1
fi

if [ ! -f "INSTALLATION_GUIDE_v1.0.3.md" ]; then
    echo -e "${RED}ERROR: Installation guide file INSTALLATION_GUIDE_v1.0.3.md not found!${NC}"
    exit 1
fi

echo -e "${YELLOW}All required files found. Ready to create the release.${NC}"
echo
echo -e "To create a release on GitHub:"
echo -e "${GREEN}1. Go to: ${BLUE}https://github.com/nicokuehn-dci/muzsic-theory-ai/releases/new${NC}"
echo -e "${GREEN}2. Choose tag: ${BLUE}v1.0.3${NC}"
echo -e "${GREEN}3. Set title: ${BLUE}Music Theory AI Assistant v1.0.3${NC}"
echo -e "${GREEN}4. Copy content from: ${BLUE}github_release_v1.0.3.md${NC}"
echo -e "${GREEN}5. Upload the following files:${NC}"
echo -e "   - ${BLUE}music-theory-ai_1.0.3_all.deb${NC}"
echo -e "   - ${BLUE}INSTALLATION_GUIDE_v1.0.3.md${NC}"
echo
echo -e "Would you like to open the GitHub release page now? (y/n)"
read -r OPEN_PAGE

if [ "$OPEN_PAGE" = "y" ] || [ "$OPEN_PAGE" = "Y" ]; then
    echo -e "${YELLOW}Opening GitHub release page...${NC}"
    xdg-open https://github.com/nicokuehn-dci/muzsic-theory-ai/releases/new
else
    echo -e "${YELLOW}Please visit: ${BLUE}https://github.com/nicokuehn-dci/muzsic-theory-ai/releases/new${NC}"
fi

echo
echo -e "${GREEN}After the release is published, users can install with:${NC}"
echo -e "${BLUE}sudo apt install ./music-theory-ai_1.0.3_all.deb${NC}"
echo
