import SwiftUI

struct StreamingMarkdownView: View {
    let text: String
    let speed: TimeInterval
    
    @State private var displayedTextIndex = 0
    @State private var timer: Timer?
    @State private var isStreaming = false
    
    // Add suggestions state
    @State private var suggestions: [String] = [
        "Tell me more about systolic pressure",
        "What are the best ways to reduce blood pressure?",
        "How often should I check my blood pressure?"
    ]
    
    init(text: String, speed: TimeInterval = 0.0002) {
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
        VStack(spacing: 0) {
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
            
            // Add suggestions view with enhanced animation
            if !isStreaming {
                SuggestionsView(
                    suggestions: suggestions,
                    onSuggestionTapped: { suggestion in
                        print("Selected suggestion: \(suggestion)")
                    }
                )
                .transition(.opacity.animation(.easeInOut(duration: 0.5)))
            }
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
