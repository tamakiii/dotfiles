# Arch Linux Services Configuration

This document lists all systemd services that are expected to be enabled and configured on this Arch Linux system.

## System Services (systemctl)

### Wake-on-LAN Configuration
- **Service**: `wol@eno1.service`
- **Status**: Enabled and active
- **Purpose**: Configure Wake-on-LAN for ethernet interface on boot
- **Configuration**: 
  - Service file: `/etc/systemd/system/wol@.service`
  - Network config: `/etc/systemd/network/20-ethernet.network`
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
- **Configuration**: `~/.config/shairport-sync.conf`
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
- **Purpose**: Bluetooth GUI management applet
- **Package**: blueman

- **Application**: `overskride`
- **Autostart file**: `~/.config/autostart/overskride.desktop`
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

## Service Dependencies

The following packages must be installed for services to function:
- ethtool (Wake-on-LAN)
- systemd-networkd (network management)
- bluez, bluez-utils (Bluetooth)
- shairport-sync (audio streaming)
- avahi (service discovery)
- blueman (Bluetooth GUI)
- overskride (modern Bluetooth tool)

## Configuration Files Reference

- `/etc/systemd/system/wol@.service` - Wake-on-LAN service template
- `/etc/systemd/network/20-ethernet.network` - Ethernet configuration with WoL
- `~/.config/systemd/user/shairport-sync.service` - User audio service
- `~/.config/shairport-sync.conf` - AirPlay configuration
- `~/.config/autostart/*.desktop` - Autostart application entries