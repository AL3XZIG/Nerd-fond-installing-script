#!/bin/bash

# IBM Plex Mono Nerd Font installer for Debian-based and Arch Linux
# Version: 2.0
# Downloads and installs IBM Plex Mono Nerd Font v3.4.0

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    echo "Please do not run this script as root. It will ask for sudo when needed."
    exit 1
fi

# Font information
FONT_NAME="IBM Plex Mono Nerd Font"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IBMPlexMono.zip"
FONT_ZIP="IBMPlexMono.zip"
FONT_DIR="$HOME/.local/share/fonts/IBMPlexMonoNF"
TEMP_DIR=$(mktemp -d)

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
    else
        DISTRO="unknown"
    fi
}

# Install dependencies based on distribution
install_dependencies() {
    case $DISTRO in
        debian|ubuntu|linuxmint|pop)
            echo "Detected Debian-based system"
            sudo apt-get update
            sudo apt-get install -y curl unzip fontconfig
            ;;
        arch|manjaro|endeavouros)
            echo "Detected Arch-based system"
            sudo pacman -Sy --noconfirm curl unzip fontconfig
            ;;
        *)
            echo "Unsupported distribution. Trying to continue anyway..."
            ;;
    esac
}

# Check for required commands
check_dependencies() {
    for cmd in curl unzip fc-cache; do
        if ! command -v $cmd &> /dev/null; then
            echo "Missing required package: $cmd"
            NEED_INSTALL=true
        fi
    done

    if [ "$NEED_INSTALL" = true ]; then
        detect_distro
        echo "Some dependencies are missing. Installing them now..."
        install_dependencies
    fi
}

echo "=== Installing $FONT_NAME ==="

# Check and install dependencies
check_dependencies

# Create font directory if it doesn't exist
echo "Creating font directory..."
mkdir -p "$FONT_DIR"

# Download the font
echo "Downloading $FONT_NAME..."
curl -L "$FONT_URL" -o "$TEMP_DIR/$FONT_ZIP" || {
    echo "Error: Failed to download the font."
    exit 1
}

# Extract the font
echo "Extracting font files..."
unzip -q "$TEMP_DIR/$FONT_ZIP" -d "$TEMP_DIR" || {
    echo "Error: Failed to extract the font archive."
    exit 1
}

# Install the font
echo "Installing font files..."
find "$TEMP_DIR" -name "*.ttf" -exec mv {} "$FONT_DIR" \;

# Update font cache
echo "Updating font cache..."
fc-cache -fv "$FONT_DIR"

# Clean up
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "=== $FONT_NAME installed successfully! ==="
echo "Fonts were installed to: $FONT_DIR"
echo "You may need to restart your applications to use the new fonts."

# Verify installation
echo -e "\nVerifying installation:"
fc-list | grep -i "IBM Plex Mono" || echo "Font installation verification failed (might need to restart first)"
