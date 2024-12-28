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

struct CardView: View {
    let text: String
    let onCopy: () -> Void

    var body: some View {
        VStack {
            Text(text)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Button(action: onCopy) {
                Text("Copy")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
