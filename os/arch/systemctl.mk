# systemctl.mk - systemd service management rules
# This file contains rules for managing systemd services and configurations

.PHONY: help check install uninstall check-dependency

SHELL := bash --noprofile --norc -eo pipefail

help:
	@cat $(firstword $(MAKEFILE_LIST))

# Main targets
check:
	test -f /etc/systemd/system/wol@.service
	test -f /etc/systemd/network/20-ethernet.network
	systemctl is-enabled wol@eno1.service

check-dependency:
	which ethtool > /dev/null || $(error Please install ethtool)

install: \
	/etc/systemd/system/wol@.service \
	/etc/systemd/network/20-ethernet.network \
	wol@eno1.service-enabled

uninstall:
	sudo systemctl disable wol@eno1.service
	sudo rm -vf /etc/systemd/network/20-ethernet.network
	sudo rm -vf /etc/systemd/system/wol@.service

# Rule definitions
/etc/systemd/system/wol@.service: etc/systemd/system/wol@.service
	sudo cp $< $@

/etc/systemd/network/20-ethernet.network: etc/systemd/network/20-ethernet.network
	sudo cp $< $@
	sudo systemctl restart systemd-networkd

wol@eno1.service-enabled: /etc/systemd/system/wol@.service
	sudo systemctl daemon-reload
	sudo systemctl enable wol@eno1.service
	sudo systemctl start wol@eno1.service
	touch $@