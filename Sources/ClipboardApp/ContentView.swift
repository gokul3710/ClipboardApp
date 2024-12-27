import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clipboardManager: ClipboardManager

    var body: some View {
        VStack {
            Text("Clipboard History")
                .font(.headline)
                .padding()

            List(clipboardManager.clipboardHistory, id: \.self) { item in
                Text(item)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .frame(minWidth: 300, minHeight: 400)
    }
}
