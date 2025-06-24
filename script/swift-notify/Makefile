.PHONY: help build clean

APP_BUNDLE = ../../bin/swift-notify.app
APP_EXECUTABLE = $(APP_BUNDLE)/Contents/MacOS/swift-notify
WRAPPER_SCRIPT = ../../bin/swift-notify

build: $(WRAPPER_SCRIPT)

clean:
	rm -rf $(APP_BUNDLE)
	rm -f $(WRAPPER_SCRIPT)

# Create the app bundle structure and executable
$(APP_EXECUTABLE): notify.swift Info.plist
	mkdir -p $(APP_BUNDLE)/Contents/MacOS
	mkdir -p $(APP_BUNDLE)/Contents/Resources
	cp Info.plist $(APP_BUNDLE)/Contents/
	swiftc notify.swift -o $@
	chmod u+x $@

# Create wrapper script that calls the bundled app
$(WRAPPER_SCRIPT): $(APP_EXECUTABLE)
	echo '#!/bin/bash' > $@
	echo 'exec "$(abspath $(APP_EXECUTABLE))" "$$@"' >> $@
	chmod u+x $@

