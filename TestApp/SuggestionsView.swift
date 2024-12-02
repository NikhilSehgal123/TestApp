import SwiftUI

public struct SuggestionButton: View {
    let title: String
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                )
                .foregroundColor(.blue)
        }
    }
}

public struct SuggestionsView: View {
    let suggestions: [String]
    let onSuggestionTapped: (String) -> Void
    let animationDelay: Double
    
    public init(
        suggestions: [String],
        onSuggestionTapped: @escaping (String) -> Void,
        animationDelay: Double = 0.1
    ) {
        self.suggestions = suggestions
        self.onSuggestionTapped = onSuggestionTapped
        self.animationDelay = animationDelay
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(suggestions.indices, id: \.self) { index in
                    SuggestionButton(title: suggestions[index]) {
                        onSuggestionTapped(suggestions[index])
                    }
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity)
                            .animation(.easeInOut.delay(Double(index) * animationDelay)),
                        removal: .opacity.animation(.easeOut(duration: 0.2))
                    ))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
    }
}

// Preview provider for SwiftUI canvas
#Preview {
    VStack {
        SuggestionsView(
            suggestions: [
                "How does this work?",
                "Tell me more",
                "What's next?",
                "Can you explain further?"
            ],
            onSuggestionTapped: { suggestion in
                print("Tapped: \(suggestion)")
            }
        )
    }
    .padding()
}
