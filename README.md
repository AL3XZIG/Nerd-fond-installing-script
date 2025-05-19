# Nerd Font Installer for IBM Plex Mono

![Nerd Fonts Logo](https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/images/nerd-fonts-logo.png)

A cross-distribution installer script for IBM Plex Mono Nerd Font that works on Debian-based and Arch Linux systems.

## Features

- 🚀 Automatic detection of Linux distribution (Debian/Ubuntu or Arch/Manjaro)
- 📦 Handles dependency installation (curl, unzip, fontconfig)
- 🏠 User-local installation (no root required by default)
- ✅ Includes installation verification
- 🧹 Automatic cleanup of temporary files

## Prerequisites

- Linux system (Debian-based or Arch-based recommended)
- Internet connection for downloading the font
- Basic terminal knowledge

## Installation

1. **Download the script**:

   ```bash
   curl -O https://github.com/AL3XZIG/Nerd-fond-installing-script/blob/main/install_ibm_plex_mono_nerd.sh
   ```

2. **Make it executable**:

   ```bash
   chmod +x install_ibm_plex_mono_nerd.sh
   ```

3. **Run the installer**:

   ```bash
   ./install_ibm_plex_mono_nerd.sh
   ```

## Usage Options

### User Installation (Default)

```bash
./install_ibm_plex_mono_nerd.sh
```

Installs fonts to `~/.local/share/fonts/IBMPlexMonoNF/` (recommended for most users)

### System-wide Installation (Requires Root)

```bash
sudo ./install_ibm_plex_mono_nerd.sh --system
```

Installs fonts to `/usr/share/fonts/IBMPlexMonoNF/` for all users

### Verify Installation

```bash
fc-list | grep -i "IBM Plex Mono"
```

## Command-line Options

| Option       | Description                          |
|--------------|--------------------------------------|
| `--system`   | Install system-wide (requires root)  |
| `--help`     | Show help message                    |
| `--version`  | Show version information             |

## Troubleshooting

### Fonts not appearing after installation

1. Try rebuilding the font cache:
   ```bash
   fc-cache -fv
   ```
2. Restart your applications
3. Log out and log back in

### Permission errors

If you get permission errors, either:
- Run with `sudo` for system-wide installation
- Or check your user has write permissions to `~/.local/share/fonts/`

### Missing dependencies

The script should automatically install required dependencies. If it fails, manually install:

- **Debian/Ubuntu**:
  ```bash
  sudo apt install curl unzip fontconfig
  ```
- **Arch/Manjaro**:
  ```bash
  sudo pacman -S curl unzip fontconfig
  ```

## Customization

To install a different Nerd Font:

1. Edit the script variables:
   ```bash
   FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FontName.zip"
   FONT_DIR="$HOME/.local/share/fonts/FontNameNF"
   ```

## Contributing

Contributions are welcome! Please open an issue or pull request for:
- Bug fixes
- Support for additional distributions
- New features

## License

MIT License - See [LICENSE](LICENSE) file

## Acknowledgments

- [Nerd Fonts Project](https://www.nerdfonts.com/)
- [IBM Plex Font Family](https://www.ibm.com/plex/)
- Original script contributors

---

**Note**: This is not an official IBM or Nerd Fonts project, just a convenient installer script.
