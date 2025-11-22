# AndaOS

<div align="center">

**A minimalist, KISS-principle Arch-based distribution**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Based on Arch](https://img.shields.io/badge/Based%20on-Arch%20Linux-1793D1?logo=arch-linux)](https://archlinux.org)
[![Build Status](https://img.shields.io/badge/build-passing-success)]()

*Clean • Fast • Predictable • Transparent*

[Download](#download) • [Installation](#installation) • [Build Guide](#building-from-source) • [Contributing](#contributing)

</div>

---

## 📋 Overview

**AndaOS** is a minimal, user-respecting operating system built on Arch Linux with the XFCE desktop environment. It embodies the KISS (Keep It Simple, Stupid) philosophy by providing only essential components, transparent configuration, and zero bloat.

Unlike traditional distributions that add layers of abstraction, AndaOS delivers a clean Arch system that's ready to use immediately—no week-long configuration required, no mysteries about what's running on your machine.

### Why AndaOS?

- **Minimal by Design**: Only essential packages, no telemetry, no hidden services
- **Instant Productivity**: XFCE desktop pre-configured with sensible defaults
- **Fully Auditable**: Every package, every config file is documented and justified
- **Arch Compatibility**: Uses official Arch repositories and follows upstream packaging
- **Reproducible Builds**: Build identical ISOs from source using standard ArchISO tooling
- **User Control**: No forced updates, no vendor lock-in, you own your system

---

## 🎯 Core Philosophy

### The KISS Principle
Every component in AndaOS must answer: **"Why is this here?"**
- If it's not essential → removed
- If it can be optional → made optional
- If it's configurable → made transparent

### Design Tenets
1. **Minimalism**: Ship only what users need to be productive
2. **Transparency**: No hidden automation, every behavior is documented
3. **Predictability**: Follows Arch standards, no surprises
4. **Performance**: Fast boot, low memory footprint, responsive desktop
5. **Maintainability**: Simple enough that users can understand and modify everything

---

## 📦 What's Included

### Base System
- **Linux Kernel**: Latest stable from Arch repos
- **Base Packages**: Core system utilities (`base`, `base-devel`)
- **Firmware**: Complete hardware support (`linux-firmware`, vendor firmware)
- **Network**: NetworkManager with CLI and applet
- **Audio**: PipeWire for modern audio routing

### Desktop Environment
- **XFCE 4**: Lightweight, stable, and highly customizable
- **Display Manager**: LightDM with auto-login for live sessions
- **Terminal**: XFCE Terminal with fastfetch integration
- **File Manager**: Thunar with essential plugins

### Essential Tools
- **Browser**: Firefox (privacy-focused defaults)
- **Editor**: Nano and Vim
- **System Monitor**: htop for process management
- **Network Tools**: wget, curl, git
- **Compression**: Full archive support (zip, tar, 7z, etc.)

### Hardware Support
- **Graphics**: Intel, AMD, and NVIDIA firmware
- **Wireless**: Broadcom, Intel, and Realtek drivers
- **Bluetooth**: Full stack with GUI controls
- **USB**: Modern USB-C and legacy support

### What's NOT Included
❌ Office suites (install LibreOffice if needed)  
❌ Development environments (install your preferred stack)  
❌ Gaming platforms (add Steam/Lutris yourself)  
❌ Bloatware, telemetry, unnecessary daemons  

**Philosophy**: AndaOS gives you a foundation. You add what *you* need.

---

## 👥 Target Audience

AndaOS is designed for:

- **Arch Enthusiasts** who want a pre-configured system without manual installation
- **Developers** who need a clean, distraction-free environment
- **System Administrators** deploying consistent workstations
- **Students & Educators** teaching Linux fundamentals
- **Privacy-Conscious Users** who want transparent, auditable systems
- **Tinkerers** who enjoy understanding and customizing their OS

**Not for:**
- Users expecting Ubuntu-style hand-holding
- Those who want every possible package pre-installed
- Anyone uncomfortable with the command line

---

## 💻 System Requirements

### Minimum
- **CPU**: x86_64 processor (64-bit)
- **RAM**: 2 GB (live environment may be sluggish)
- **Storage**: 10 GB
- **Firmware**: BIOS or UEFI

### Recommended
- **CPU**: Dual-core x86_64 or better
- **RAM**: 4 GB or more
- **Storage**: 20 GB SSD
- **Firmware**: UEFI with Secure Boot disabled
- **Graphics**: Any with open-source driver support

### Tested Hardware
✅ Intel/AMD CPUs  
✅ Intel integrated graphics  
✅ AMD Radeon graphics  
✅ NVIDIA (nouveau drivers; proprietary drivers installable post-install)  
✅ Most WiFi cards (Broadcom may require manual firmware)  

---

## 📥 Download

### Latest Release
**Version**: Rolling (based on Arch Linux rolling release model)  
**ISO Size**: ~1.5 GB  

🔗 **[Download from Releases](https://github.com/hello2himel/andaos/releases)**

### Verify Your Download
```bash
# Download checksum file
wget https://github.com/hello2himel/andaos/releases/download/vX.X/SHA256SUMS

# Verify ISO integrity
sha256sum -c SHA256SUMS
```

**Always verify checksums before installation to ensure integrity and authenticity.**

---

## 🚀 Installation

### Live Boot
1. Write ISO to USB drive:
   ```bash
   # Linux/macOS
   sudo dd bs=4M if=andaos-YYYY.MM.DD-x86_64.iso of=/dev/sdX status=progress oflag=sync
   
   # Windows: Use Rufus or balenaEtcher
   ```

2. Boot from USB (disable Secure Boot if enabled)

3. System auto-boots to live XFCE desktop—no password required

### Install to Disk

#### Option A: Calamares Installer (If Available)
- Launch "Install AndaOS" from desktop
- Follow GUI wizard
- Reboot when complete

#### Option B: Manual Installation
AndaOS is 100% compatible with the [official Arch installation guide](https://wiki.archlinux.org/title/Installation_guide):

```bash
# Partition disk
cfdisk /dev/sda

# Format partitions
mkfs.ext4 /dev/sda1

# Mount and install
mount /dev/sda1 /mnt
pacstrap /mnt base linux linux-firmware xfce4 networkmanager

# Configure system
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

# Set locale, timezone, hostname
# Install bootloader (GRUB)
# Set root password
# Exit and reboot
```

**Full guide**: [ArchWiki Installation Guide](https://wiki.archlinux.org/title/Installation_guide)

### Post-Installation
```bash
# Update system
sudo pacman -Syu

# Install additional software
sudo pacman -S <package-name>

# Enable services
sudo systemctl enable <service>
```

---

## 🛠️ Building from Source

### Prerequisites
```bash
# On Arch Linux
sudo pacman -S archiso git base-devel

# Clone repository
git clone https://github.com/hello2himel/andaos.git
cd andaos
```

### Build ISO
```bash
# Automated build script
./build.sh

# Manual build
sudo mkarchiso -v -w work -o out .
```

**Output**: `out/andaos-YYYY.MM.DD-x86_64.iso`

### Build Options
```bash
./build.sh --help              # Show all options
./build.sh --auto-qemu         # Build and test in QEMU
./build.sh --no-qemu           # Build only, skip testing
./build.sh --clean             # Clean build directories
```

### Testing in QEMU
```bash
# Install QEMU
sudo pacman -S qemu-full

# Test ISO
qemu-system-x86_64 -enable-kvm -m 4096 -boot d -cdrom out/andaos-*.iso
```

---

## 📂 Repository Structure

```
andaos/
├── airootfs/                   # Live system overlay
│   ├── etc/
│   │   ├── skel/              # Default user home directory files
│   │   ├── os-release         # System identification
│   │   └── lightdm/           # Display manager config
│   ├── root/
│   │   └── customize_airootfs.sh  # Build-time customization script
│   └── usr/
│       └── share/
│           └── backgrounds/   # Default wallpapers
├── efiboot/                   # UEFI boot configuration
├── grub/                      # GRUB bootloader config
├── syslinux/                  # BIOS/Syslinux config
├── packages.x86_64            # Package manifest
├── profiledef.sh              # ArchISO build profile
├── build.sh                   # Automated build script
└── README.md                  # This file
```

### Key Files

| File | Purpose |
|------|---------|
| `packages.x86_64` | List of packages included in ISO |
| `profiledef.sh` | Build configuration (ISO name, bootmodes, etc.) |
| `airootfs/root/customize_airootfs.sh` | Script that runs during build to configure system |
| `airootfs/etc/skel/.bashrc` | Default Bash configuration (includes fastfetch) |

---

## 🎨 Customization

### Branding
```bash
# Change OS name and identity
nano airootfs/etc/os-release

# Update boot menu
nano grub/grub.cfg
nano syslinux/syslinux.cfg

# Replace wallpaper
cp your-wallpaper.png airootfs/usr/share/backgrounds/andaos/default.png
```

### Package Selection
```bash
# Edit package list
nano packages.x86_64

# Add packages
echo "package-name" >> packages.x86_64

# Rebuild
./build.sh
```

### Desktop Theming
```bash
# XFCE settings are in
airootfs/etc/skel/.config/xfce4/

# Modify panel layout, theme, icons, etc.
```

### Fastfetch ASCII Art
```bash
# Custom logo
nano airootfs/etc/skel/.config/fastfetch/config.jsonc
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### Before Contributing
1. Read this README completely
2. Check existing [issues](https://github.com/hello2himel/andaos/issues) and [pull requests](https://github.com/hello2himel/andaos/pulls)
3. Understand the KISS philosophy—**less is more**

### Contribution Standards
- **Minimalism**: New packages must be justified (essential or widely useful)
- **Documentation**: Explain *why*, not just *what*
- **Testing**: Test ISOs before submitting PRs
- **Compatibility**: Changes must not break Arch compatibility

### How to Contribute
```bash
# Fork the repository
git clone https://github.com/YOUR-USERNAME/andaos.git
cd andaos

# Create a feature branch
git checkout -b feature/your-feature-name

# Make changes and test
./build.sh --auto-qemu

# Commit with clear messages
git commit -m "Add: Brief description of change"

# Push and create PR
git push origin feature/your-feature-name
```

### PR Checklist
- [ ] ISO builds successfully
- [ ] Changes tested in QEMU or real hardware
- [ ] Documentation updated if needed
- [ ] Commit messages are clear and descriptive
- [ ] No unnecessary packages added

---

## 📖 Documentation

- **Arch Wiki**: [https://wiki.archlinux.org](https://wiki.archlinux.org)
- **ArchISO**: [https://wiki.archlinux.org/title/Archiso](https://wiki.archlinux.org/title/Archiso)
- **XFCE Docs**: [https://docs.xfce.org](https://docs.xfce.org)

---

## 🐛 Known Issues

### Current Limitations
- **Calamares**: Not included by default (AUR package, adds complexity)
- **Secure Boot**: Not supported (requires signed bootloader)
- **Proprietary Drivers**: NVIDIA proprietary drivers must be installed post-install

### Reporting Bugs
Open an issue at: [https://github.com/hello2himel/andaos/issues](https://github.com/hello2himel/andaos/issues)

**Include:**
- AndaOS version (ISO date)
- Hardware specs
- Steps to reproduce
- Expected vs. actual behavior

---

## 📜 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2024 hello2himel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## ⚠️ Disclaimer

1. **Not Affiliated**: AndaOS is an independent project and is not officially affiliated with, endorsed by, or supported by Arch Linux.

2. **Use at Your Own Risk**: This is a community-maintained distribution. While we strive for stability, **always maintain backups** of important data.

3. **Rolling Release**: Like Arch, AndaOS follows a rolling release model. Regular updates are your responsibility.

4. **Support**: Community support only. No commercial support or warranties.

5. **Security**: Keep your system updated. Security is a shared responsibility between the maintainers and users.

---

## 🌟 Acknowledgments

- **Arch Linux** team for the excellent base distribution
- **XFCE** developers for a solid desktop environment
- **ArchISO** maintainers for the build tools
- All contributors who help improve AndaOS

---

## 📞 Contact & Community

- **GitHub**: [hello2himel/andaos](https://github.com/hello2himel/andaos)
- **Issues**: [Report bugs or request features](https://github.com/hello2himel/andaos/issues)
- **Discussions**: [Community forum](https://github.com/hello2himel/andaos/discussions)

---

<div align="center">

**Made with ❤️ by the AndaOS community**

*Keep it simple. Keep it stupid.*

[⬆ Back to Top](#andaos)

</div>