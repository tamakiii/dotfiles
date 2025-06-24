import Foundation
import Cocoa

// Swift notification tool inspired by terminal-notifier
// Uses NSUserNotificationCenter like terminal-notifier for compatibility

class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Parse command line arguments
        let arguments = CommandLine.arguments
        
        guard arguments.count > 1 else {
            print("Usage: swift-notify <type> [message]")
            print("Types: complete, prompt")
            exit(1)
        }
        
        let notificationType = arguments[1]
        let customMessage = arguments.count > 2 ? arguments[2] : nil
        
        var title: String
        var message: String
        
        switch notificationType {
        case "complete":
            title = "✅ Task Complete"
            message = customMessage ?? "Claude Code has finished the task."
        case "prompt":
            title = "🤔 Claude Code"
            message = customMessage ?? "Claude Code is asking for input."
        default:
            print("Unknown notification type: \(notificationType)")
            print("Types: complete, prompt")
            exit(1)
        }
        
        deliverNotification(title: title, message: message)
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
