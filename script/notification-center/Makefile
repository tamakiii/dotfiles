.PHONY: help build clean

APP_BUNDLE = ../../bin/NotificationCenter.app
APP_EXECUTABLE = $(APP_BUNDLE)/Contents/MacOS/notification-center
WRAPPER_SCRIPT = ../../bin/notification-center

build: $(WRAPPER_SCRIPT)

clean:
	rm -rf "$(APP_BUNDLE)"
	rm -f "$(WRAPPER_SCRIPT)"

# Create the app bundle structure and executable
$(APP_EXECUTABLE): notify.swift Info.plist
	mkdir -p "$(APP_BUNDLE)/Contents/MacOS"
	mkdir -p "$(APP_BUNDLE)/Contents/Resources"
	cp Info.plist "$(APP_BUNDLE)/Contents/"
	swiftc notify.swift -o "$@"
	chmod u+x "$@"

# Create wrapper script that calls the bundled app
$(WRAPPER_SCRIPT): $(APP_EXECUTABLE)
	echo '#!/bin/bash' > "$@"
	echo 'exec "$(shell pwd)/$(APP_EXECUTABLE)" "$$@"' >> "$@"
	chmod u+x "$@"
	# Register app bundle with Launch Services so it appears in System Settings
	/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$(shell pwd)/$(APP_BUNDLE)"

