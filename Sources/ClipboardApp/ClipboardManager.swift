import Foundation
import AppKit

class ClipboardManager: ObservableObject {
    @Published var clipboardHistory: [String] = []
    private var lastCopiedItem: String = ""

    init() {
        startPollingClipboard()
    }

    private func startPollingClipboard() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.checkClipboard()
        }
    }

    private func checkClipboard() {
        if let currentItem = NSPasteboard.general.string(forType: .string), currentItem != lastCopiedItem {
            lastCopiedItem = currentItem
            DispatchQueue.main.async {
                self.clipboardHistory.insert(currentItem, at: 0)
            }
        }
    }
}
