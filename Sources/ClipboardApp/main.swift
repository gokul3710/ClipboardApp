import SwiftUI

@main
struct ClipboardApp: App {
    @StateObject private var clipboardManager = ClipboardManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(clipboardManager)
        }
    }
}
