.PHONY: help build clean

build: \
	../../bin/swift-notify

clean:
	rm -rf ../../bin/swift-notify

../../bin/swift-notify: notify.swift
	swiftc $< -o $@
	chmod u+x $@

