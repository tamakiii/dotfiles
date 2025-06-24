import Foundation
import Cocoa

// Swift notification tool inspired by terminal-notifier
// Uses NSUserNotificationCenter like terminal-notifier for compatibility

class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Parse command line arguments
        let arguments = CommandLine.arguments
        
        guard arguments.count > 1 else {
            printUsage()
            exit(1)
        }
        
        // Parse arguments with flags like terminal-notifier
        var notificationType: String?
        var customTitle: String?
        var customMessage: String?
        
        var i = 1
        while i < arguments.count {
            let arg = arguments[i]
            
            switch arg {
            case "-title":
                if i + 1 < arguments.count {
                    customTitle = arguments[i + 1]
                    i += 1
                }
            case "-message":
                if i + 1 < arguments.count {
                    customMessage = arguments[i + 1]
                    i += 1
                }
            case "complete", "prompt":
                notificationType = arg
            default:
                // If no flag, treat as message for backwards compatibility
                if notificationType != nil && customMessage == nil {
                    customMessage = arg
                }
            }
            i += 1
        }
        
        guard let type = notificationType else {
            printUsage()
            exit(1)
        }
        
        var title: String
        var message: String
        
        switch type {
        case "complete":
            title = customTitle ?? "✅ Task Complete"
            message = customMessage ?? "Claude Code has finished the task."
        case "prompt":
            title = customTitle ?? "🤔 Claude Code"
            message = customMessage ?? "Claude Code is asking for input."
        default:
            printUsage()
            exit(1)
        }
        
        deliverNotification(title: title, message: message)
    }
    
    func printUsage() {
        print("Usage: swift-notify <type> [message]")
        print("       swift-notify <type> -title \"Custom Title\" -message \"Custom Message\"")
        print("")
        print("Types: complete, prompt")
        print("")
        print("Examples:")
        print("  swift-notify complete \"Task finished successfully\"")
        print("  swift-notify prompt -title \"Confirm\" -message \"Do you want to continue?\"")
    }
    
    func deliverNotification(title: String, message: String) {
        let userNotification = NSUserNotification()
        userNotification.title = title
        userNotification.informativeText = message
        userNotification.soundName = NSUserNotificationDefaultSoundName
        
        let center = NSUserNotificationCenter.default
        center.delegate = self
        center.deliver(userNotification)
    }
    
    // NSUserNotificationCenterDelegate methods
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    // Exit after notification is delivered, like terminal-notifier
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        exit(0)
    }
}

// Main entry point - create NSApplication and run
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// Required for command-line apps to properly initialize Cocoa
app.setActivationPolicy(.accessory)
app.run()
