#!/bin/bash

# ani-cli Installation Script
# This script installs ani-cli and all its dependencies

set -e  # Exit on error

echo "========================================="
echo "ani-cli and Dependencies Installation Script"
echo "========================================="
echo ""

# Step 1: Clone ani-cli repository
echo "[1/3] Cloning ani-cli repository..."
if [ -d "ani-cli" ]; then
    echo "Removing existing ani-cli directory..."
    rm -rf ani-cli
fi
git clone "https://github.com/pystardust/ani-cli.git"
echo "✓ ani-cli cloned successfully"
echo ""

# Step 2: Copy ani-cli to /usr/local/bin
echo "[2/3] Installing ani-cli to /usr/local/bin..."
sudo cp ani-cli/ani-cli /usr/local/bin
sudo chmod +x /usr/local/bin/ani-cli
echo "✓ ani-cli installed successfully"
echo ""

# Step 3: Clean up
echo "[3/3] Cleaning up..."
rm -rf ani-cli
echo "✓ Cleanup completed"
echo ""

# Step 4: Install dependencies
echo "========================================="
echo "Installing Dependencies"
echo "========================================="
echo ""

# Detect package manager
if command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
    echo "Detected package manager: apt"
    sudo apt update
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    echo "Detected package manager: dnf"
    sudo dnf check-update || true
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    echo "Detected package manager: yum"
    sudo yum check-update || true
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    echo "Detected package manager: pacman"
    sudo pacman -Sy
elif command -v brew &> /dev/null; then
    PKG_MANAGER="brew"
    echo "Detected package manager: brew (Homebrew)"
else
    echo "Warning: Could not detect package manager. Please install dependencies manually."
    PKG_MANAGER="unknown"
fi

echo ""

# Install grep (usually pre-installed)
echo "Installing grep..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y grep
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y grep
        ;;
    pacman)
        sudo pacman -S --noconfirm grep
        ;;
    brew)
        brew install grep
        ;;
    *)
        echo "grep is typically pre-installed on most systems."
        ;;
esac
echo "✓ grep installed/verified"
echo ""

# Install sed (usually pre-installed)
echo "Installing sed..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y sed
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y sed
        ;;
    pacman)
        sudo pacman -S --noconfirm sed
        ;;
    brew)
        brew install gnu-sed
        ;;
    *)
        echo "sed is typically pre-installed on most systems."
        ;;
esac
echo "✓ sed installed/verified"
echo ""

# Install curl
echo "Installing curl..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y curl
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y curl
        ;;
    pacman)
        sudo pacman -S --noconfirm curl
        ;;
    brew)
        brew install curl
        ;;
    *)
        echo "Please install curl manually."
        ;;
esac
echo "✓ curl installed/verified"
echo ""

# Install mpv (Video Player)
echo "Installing mpv..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y mpv
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y mpv
        ;;
    pacman)
        sudo pacman -S --noconfirm mpv
        ;;
    brew)
        brew install mpv
        ;;
    *)
        echo "Please install mpv manually."
        ;;
esac
echo "✓ mpv installed/verified"
echo ""

# Install iina (macOS only - mpv replacement)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing iina (macOS video player)..."
    if command -v brew &> /dev/null; then
        brew install --cask iina
        echo "✓ iina installed/verified"
    else
        echo "Homebrew not found. Please install iina manually from https://iina.io/"
    fi
    echo ""
else
    echo "Skipping iina (macOS only)"
    echo ""
fi

# Install yt-dlp
echo "Installing yt-dlp..."
case $PKG_MANAGER in
    apt)
        # Try to install latest version via pip if available
        if command -v pip3 &> /dev/null; then
            sudo pip3 install --upgrade yt-dlp
        else
            sudo apt install -y yt-dlp
        fi
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y yt-dlp
        ;;
    pacman)
        sudo pacman -S --noconfirm yt-dlp
        ;;
    brew)
        brew install yt-dlp
        ;;
    *)
        if command -v pip3 &> /dev/null; then
            sudo pip3 install --upgrade yt-dlp
        else
            echo "Please install yt-dlp manually."
        fi
        ;;
esac
echo "✓ yt-dlp installed/verified"
echo ""

# Install ffmpeg
echo "Installing ffmpeg..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y ffmpeg
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y ffmpeg
        ;;
    pacman)
        sudo pacman -S --noconfirm ffmpeg
        ;;
    brew)
        brew install ffmpeg
        ;;
    *)
        echo "Please install ffmpeg manually."
        ;;
esac
echo "✓ ffmpeg installed/verified"
echo ""

# Install fzf
echo "Installing fzf..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y fzf
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y fzf
        ;;
    pacman)
        sudo pacman -S --noconfirm fzf
        ;;
    brew)
        brew install fzf
        ;;
    *)
        echo "Please install fzf manually."
        ;;
esac
echo "✓ fzf installed/verified"
echo ""

# Install ani-skip (optional)
echo "Installing ani-skip (optional dependency)..."
if command -v pip3 &> /dev/null; then
    sudo pip3 install --upgrade ani-skip 2>/dev/null || echo "ani-skip installation skipped (optional)"
    echo "✓ ani-skip installed/verified (if available)"
else
    echo "pip3 not found. ani-skip installation skipped (optional)"
fi
echo ""

# Install patch (for self-updating)
echo "Installing patch..."
case $PKG_MANAGER in
    apt)
        sudo apt install -y patch
        ;;
    dnf|yum)
        sudo $PKG_MANAGER install -y patch
        ;;
    pacman)
        sudo pacman -S --noconfirm patch
        ;;
    brew)
        brew install patch
        ;;
    *)
        echo "patch is typically pre-installed on most systems."
        ;;
esac
echo "✓ patch installed/verified"
echo ""

# Verification
echo "========================================="
echo "Installation Summary"
echo "========================================="
echo ""
echo "Verifying installations..."
echo ""

commands=("grep" "sed" "curl" "mpv" "yt-dlp" "ffmpeg" "fzf" "patch" "ani-cli")

for cmd in "${commands[@]}"; do
    if command -v $cmd &> /dev/null; then
        version=$($cmd --version 2>&1 | head -n 1 || echo "installed")
        echo "✓ $cmd: $version"
    else
        echo "✗ $cmd: NOT FOUND"
    fi
done

# Check iina on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v iina &> /dev/null; then
        echo "✓ iina: installed"
    else
        echo "⚠ iina: NOT FOUND (optional, macOS only)"
    fi
fi

# Check ani-skip
if command -v ani-skip &> /dev/null || pip3 show ani-skip &> /dev/null 2>&1; then
    echo "✓ ani-skip: installed (optional)"
else
    echo "⚠ ani-skip: NOT FOUND (optional)"
fi

echo ""
echo "========================================="
echo "Installation Complete!"
echo "========================================="
echo ""
echo "You can now use ani-cli by running: ani-cli"
