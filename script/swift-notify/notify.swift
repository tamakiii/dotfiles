import Foundation
import Cocoa

// Minimal Swift notification tool inspired by terminal-notifier
// Uses NSUserNotificationCenter for compatibility

class NotificationDelegate: NSObject, NSUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}

func showNotification(title: String, message: String) {
    let notification = NSUserNotification()
    notification.title = title
    notification.informativeText = message
    notification.soundName = NSUserNotificationDefaultSoundName
    
    let center = NSUserNotificationCenter.default
    let delegate = NotificationDelegate()
    center.delegate = delegate
    center.deliver(notification)
    
    // Keep the process alive briefly to ensure delivery
    RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
}

// Parse command line arguments
guard CommandLine.arguments.count > 1 else {
    print("Usage: swift-notify <type> [message]")
    print("Types: complete, prompt")
    exit(1)
}

let notificationType = CommandLine.arguments[1]
let customMessage = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : nil

switch notificationType {
case "complete":
    let title = "✅ Task Complete"
    let message = customMessage ?? "Claude Code has finished the task."
    showNotification(title: title, message: message)
case "prompt":
    let title = "🤔 Claude Code"
    let message = customMessage ?? "Claude Code is asking for input."
    showNotification(title: title, message: message)
default:
    print("Unknown notification type: \(notificationType)")
    print("Types: complete, prompt")
    exit(1)
}
