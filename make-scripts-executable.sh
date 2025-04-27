#!/bin/bash
# Make all scripts in the scripts directory executable

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Making all scripts executable...${NC}"

# Make all .sh files in the scripts directory executable
find "$SCRIPT_DIR" -name "*.sh" -exec chmod +x {} \;

echo -e "${GREEN}Done!${NC}"
echo -e "${GREEN}You can now run scripts with ./scripts/script-name.sh${NC}"