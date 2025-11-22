#!/bin/bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Options
CLEAN_ONLY=false
NO_QEMU=false
AUTO_QEMU=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --clean)
            CLEAN_ONLY=true
            shift
            ;;
        --no-qemu)
            NO_QEMU=true
            shift
            ;;
        --auto-qemu)
            AUTO_QEMU=true
            shift
            ;;
        --help)
            echo "Anda OS Build Script"
            echo ""
            echo "Usage: ./build.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --clean       Clean build directories and exit"
            echo "  --no-qemu     Build only, skip QEMU test"
            echo "  --auto-qemu   Build and auto-launch QEMU"
            echo "  --help        Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}   Anda OS Build Script${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

if [ ! -f "profiledef.sh" ]; then
    echo -e "${RED}Error: profiledef.sh not found!${NC}"
    exit 1
fi

# Clean
echo -e "${YELLOW}Cleaning...${NC}"
sudo rm -rf work/ out/
sudo rm -f airootfs/etc/lsb-release 2>/dev/null || true
sudo rm -f airootfs/etc/os-release 2>/dev/null || true

if [ "$CLEAN_ONLY" = true ]; then
    echo -e "${GREEN}✓ Cleaned!${NC}"
    exit 0
fi

# Build
echo -e "${YELLOW}Building ISO...${NC}"
if sudo mkarchiso -v -w work/ -o out/ ./; then
    echo -e "${GREEN}✓ Build successful!${NC}"
else
    echo -e "${RED}✗ Build failed!${NC}"
    exit 1
fi

ISO_FILE=$(ls out/andaos-*.iso 2>/dev/null | head -n1)
ISO_SIZE=$(du -h "$ISO_FILE" | cut -f1)

echo ""
echo -e "${GREEN}ISO: ${ISO_FILE} (${ISO_SIZE})${NC}"
echo ""

# QEMU
if [ "$NO_QEMU" = false ]; then
    if [ "$AUTO_QEMU" = true ]; then
        REPLY="y"
    else
        read -p "Test in QEMU? (y/n): " -n 1 -r
        echo ""
    fi

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v qemu-system-x86_64 &> /dev/null; then
            echo -e "${YELLOW}Launching QEMU...${NC}"
            qemu-system-x86_64 \
                -enable-kvm \
                -m 4096 \
                -smp 2 \
                -boot d \
                -cdrom "$ISO_FILE" \
                -cpu host \
                -vga virtio \
                -display sdl,gl=on \
                2>/dev/null &
            echo -e "${GREEN}✓ QEMU started!${NC}"
        else
            echo -e "${RED}QEMU not installed!${NC}"
        fi
    fi
fi

echo ""
echo -e "${GREEN}✓ Done!${NC}"
echo ""
echo "Write to USB:"
echo "  sudo dd bs=4M if=$ISO_FILE of=/dev/sdX status=progress"
