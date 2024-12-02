//
//  ContentView.swift
//  TestApp
//
//  Created by admin on 02/12/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let markdownText = """
# Understanding Blood Pressure 🫀\n\nBlood pressure is a **vital sign** that measures the force of blood pushing against your artery walls. It consists of two numbers:\n\n* **Systolic pressure** (top number)\n* **Diastolic pressure** (bottom number)
"""
    
    var body: some View {
        VStack(spacing: 20) {
            StreamingMarkdownView(text: markdownText)
                .frame(maxHeight: .infinity)
            
            Button("Restart Animation") {
                // Access the StreamingMarkdownView using a ViewRef if needed
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
