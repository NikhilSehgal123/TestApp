import SwiftUI

struct StreamingMarkdownView: View {
    let text: String
    let speed: TimeInterval
    
    @State private var displayedTextIndex = 0
    @State private var timer: Timer?
    @State private var isStreaming = false
    
    init(text: String, speed: TimeInterval = 0.03) {
        self.text = text
        self.speed = speed
    }
    
    private var displayedText: String {
        String(text.prefix(displayedTextIndex))
    }
    
    private func startStreaming() {
        timer?.invalidate()
        displayedTextIndex = 0
        isStreaming = true
        
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
            if displayedTextIndex < text.count {
                displayedTextIndex += 1
            } else {
                timer.invalidate()
                isStreaming = false
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            Text.markdown(displayedText)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue.opacity(isStreaming ? 0.6 : 0), lineWidth: 2)
                                .scaleEffect(isStreaming ? 1.02 : 1.0)
                        )
                )
                .padding()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeInOut, value: displayedText)
        }
        .onAppear {
            startStreaming()
        }
    }
    
    /// Restarts the streaming animation
    func restart() {
        startStreaming()
    }
}
