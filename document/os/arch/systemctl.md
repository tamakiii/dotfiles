# Arch Linux Services Configuration

This document lists all systemd services that are expected to be enabled and configured on this Arch Linux system.

## Makefile Organization

Services are managed by two independent Makefiles:
- **Core Dotfiles (`Makefile`)**: User configs and user systemd services (~/.config)
- **System Services (`systemctl.mk`)**: System-level services and configurations (/etc)

## System Services (systemctl)

### Wake-on-LAN Configuration
- **Service**: `wol@eno1.service`
- **Status**: Enabled and active
- **Purpose**: Configure Wake-on-LAN for ethernet interface on boot
- **Managed by**: `systemctl.mk` (system-level only)
- **Configuration**: 
  - Service file: `/etc/systemd/system/wol@.service`
  - Network config: `/etc/systemd/network/20-ethernet.network`
- **Installation**:
  ```bash
  make -f os/arch/systemctl.mk install
  ```
- **Commands**:
  ```bash
  sudo systemctl enable wol@eno1.service
  sudo systemctl start wol@eno1.service
  sudo systemctl status wol@eno1.service
  ```
- **Dependencies**: ethtool package
- **Notes**: Enables magic packet wake-up and PCI device wakeup capability

### Network Management
- **Service**: `systemd-networkd.service`
- **Status**: Enabled and active
- **Purpose**: Network configuration management
- **Configuration**: `/etc/systemd/network/20-ethernet.network`
- **Notes**: Configured with Wake-on-LAN support

### Bluetooth Stack
- **Service**: `bluetooth.service`
- **Status**: Enabled and active
- **Purpose**: Bluetooth device management
- **Dependencies**: bluez, bluez-utils packages

## User Services (systemctl --user)

### Audio Streaming
- **Service**: `shairport-sync.service`
- **Status**: User service (enabled via autostart)
- **Purpose**: AirPlay audio receiver
- **Managed by**: `Makefile` (user configs)
- **Configuration**: `~/.config/shairport-sync.conf`
- **Installation**:
  ```bash
  make -C os/arch install
  ```
- **Commands**:
  ```bash
  systemctl --user enable shairport-sync.service
  systemctl --user start shairport-sync.service
  systemctl --user status shairport-sync.service
  ```
- **Dependencies**: shairport-sync, avahi packages

## Autostart Applications

### Bluetooth Management
- **Application**: `blueman-applet`
- **Autostart file**: `~/.config/autostart/blueman-applet.desktop`
- **Managed by**: `Makefile` (user configs)
- **Purpose**: Bluetooth GUI management applet
- **Package**: blueman

- **Application**: `overskride`
- **Autostart file**: `~/.config/autostart/overskride.desktop`
- **Managed by**: `Makefile` (user configs)
- **Purpose**: Modern Bluetooth pairing tool (especially for keyboards)
- **Package**: overskride (AUR)

## Service Verification Commands

### Check all expected services
```bash
# System services
sudo systemctl is-enabled wol@eno1.service
sudo systemctl is-active wol@eno1.service
sudo systemctl is-enabled systemd-networkd.service
sudo systemctl is-active systemd-networkd.service
sudo systemctl is-enabled bluetooth.service
sudo systemctl is-active bluetooth.service

# User services
systemctl --user is-enabled shairport-sync.service
systemctl --user is-active shairport-sync.service

# Wake-on-LAN verification
sudo ethtool eno1 | grep "Wake-on"
cat /sys/class/net/eno1/device/power/wakeup
```

### Autostart verification
```bash
# Check autostart applications
ls -la ~/.config/autostart/
```

## Troubleshooting

### Wake-on-LAN Issues
- Check ethernet interface name: `ip link show`
- Verify WoL capabilities: `sudo ethtool eno1 | grep "Supports Wake-on"`
- Test magic packet: `wakeonlan e8:9c:25:37:6e:33` (from another device)

### Network Issues
- Restart networkd: `sudo systemctl restart systemd-networkd`
- Check network config: `networkctl status`

### Bluetooth Issues
- Restart bluetooth: `sudo systemctl restart bluetooth`
- Check device status: `bluetoothctl show`
- See detailed troubleshooting in `../CLAUDE.md`

## Service Dependencies by Makefile

### Core Dotfiles (`Makefile`) Dependencies
- shairport-sync (audio streaming)
- avahi (service discovery)
- blueman (Bluetooth GUI)
- overskride (modern Bluetooth tool)

### System Services (`systemctl.mk`) Dependencies
- ethtool (Wake-on-LAN)

### System Dependencies (not managed by Makefiles)
- systemd-networkd (network management)
- bluez, bluez-utils (Bluetooth stack)

## Configuration Files Reference

### System Files (managed by `systemctl.mk`)
- `/etc/systemd/system/wol@.service` - Wake-on-LAN service template
- `/etc/systemd/network/20-ethernet.network` - Ethernet configuration with WoL

### User Files (managed by `Makefile`)
- `~/.config/systemd/user/shairport-sync.service` - User audio service
- `~/.config/shairport-sync.conf` - AirPlay configuration
- `~/.config/autostart/*.desktop` - Autostart application entries

## Installation Commands

### Complete Installation
```bash
# Install user configs + system services
make -C os/arch install
make -f os/arch/systemctl.mk install

# Verify everything
make -C os/arch check
make -f os/arch/systemctl.mk check
```

### Selective Installation
```bash
# User configs only (no sudo required)
make -C os/arch install

# System services only (requires sudo)
make -f os/arch/systemctl.mk install
```