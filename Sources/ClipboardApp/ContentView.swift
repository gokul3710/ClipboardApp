import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clipboardManager: ClipboardManager

    var body: some View {
        VStack {
            Text("Clipboard History")
                .font(.headline)
                .padding()

            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 6),
                    spacing: 16
                ) {
                    ForEach(clipboardManager.clipboardHistory.indices, id: \.self) { index in
                        CardView(
                            text: clipboardManager.clipboardHistory[index],
                            onCopy: {
                                clipboardManager.moveToTop(index: index)
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .padding()
        .frame(minWidth: 600, minHeight: 400)
    }
}

import SwiftUI

struct CardView: View {
    let text: String
    let onCopy: () -> Void

    var body: some View {
        VStack {
            Text(text)
                .font(.body)
                .foregroundColor(.white) // Card text color
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(Color.black.opacity(0.8)) // Card background color
                .cornerRadius(8)

            Button(action: onCopy) {
                Text("Copy")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.blue) // Button background
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2)) // Outer card background
        .cornerRadius(12)
        .shadow(radius: 4) // Subtle shadow
    }
}

