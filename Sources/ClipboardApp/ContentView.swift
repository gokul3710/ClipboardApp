import SwiftUI


struct Theme {
    struct Colors {
        static let text = Color(hex: "#B9DBFA")
        static let text200 = Color(hex: "#486d8c")
        static let text400 = Color(hex: "#6691b5")
        static let text700 = Color(hex: "#99bad5")
        static let text800 = Color(hex: "#9fcff9")
        static let blue = Color(hex: "#399ef4")
        static let blue200 = Color(hex: "#246eac")
        static let blue400 = Color(hex: "#2e89d6")
        static let blue700 = Color(hex: "#6ac2fa")
        static let darkBlue400 = Color(hex: "#032949")
        static let darkRed400 = Color(hex: "#99081d")
        static let green = Color(hex: "#4eb071")
        static let background = Color(hex: "#090D13")
        static let background700 = Color(hex: "#1c2837")
        static let background500 = Color(hex: "#17222F")
        static let background300 = Color(hex: "#101821")
        static let background200 = Color(hex: "#0e1824")
        static let background100 = Color(hex: "#051420")
        static let codeBackground = Color(hex: "#192535")
        static let medium700 = Color(hex: "#4c606f")
        static let medium500 = Color(hex: "#293946")
        static let medium400 = Color(hex: "#1f2d38")
        
        struct Token {
            static let function = Color(hex: "#21c5c7")
            static let number = Color(hex: "#e5949b")
            static let string = Color(hex: "#da6771")
            static let comment = Color(hex: "#676f83")
        }
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

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

