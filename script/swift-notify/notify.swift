import Foundation
import UserNotifications

// Minimal Swift notification tool inspired by terminal-notifier
// Uses UNUserNotificationCenter with proper app bundle

func showNotification(title: String, message: String, completion: @escaping () -> Void) {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        if let error = error {
            print("Authorization error: \(error)")
            completion()
            return
        }
        
        if granted {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = message
            content.sound = .default
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: nil
            )
            
            center.add(request) { error in
                if let error = error {
                    print("Notification error: \(error)")
                }
                completion()
            }
        } else {
            print("🔒 Notification permission not granted")
            completion()
        }
    }
}

// Parse command line arguments
guard CommandLine.arguments.count > 1 else {
    print("Usage: swift-notify <type> [message]")
    print("Types: complete, prompt")
    exit(1)
}

let notificationType = CommandLine.arguments[1]
let customMessage = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : nil

let semaphore = DispatchSemaphore(value: 0)

switch notificationType {
case "complete":
    let title = "✅ Task Complete"
    let message = customMessage ?? "Claude Code has finished the task."
    showNotification(title: title, message: message) {
        semaphore.signal()
    }
case "prompt":
    let title = "🤔 Claude Code"
    let message = customMessage ?? "Claude Code is asking for input."
    showNotification(title: title, message: message) {
        semaphore.signal()
    }
default:
    print("Unknown notification type: \(notificationType)")
    print("Types: complete, prompt")
    exit(1)
}

// Wait for notification to complete
_ = semaphore.wait(timeout: .now() + 5)
