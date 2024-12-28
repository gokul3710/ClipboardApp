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

    func moveToTop(index: Int) {
        guard index >= 0 && index < clipboardHistory.count else { return }
        let item = clipboardHistory.remove(at: index)

        // Copy the selected item back to the clipboard
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(item, forType: .string)

        // Move the item to the top of the list
        // clipboardHistory.insert(item, at: 0)
    }
}
