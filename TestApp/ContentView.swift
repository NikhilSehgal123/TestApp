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
# Understanding Blood Pressure 🫀\n\nBlood pressure is a **vital sign** that measures the force of blood pushing against your artery walls. It consists of two numbers:\n\n* **Systolic pressure** (top number)\n* **Diastolic pressure** (bottom number)\n\n## Normal Blood Pressure Ranges 📊\n\nA healthy blood pressure reading is typically:\n* Systolic: 90-120 mmHg\n* Diastolic: 60-80 mmHg\n\n## Risk Factors ⚠️\n\nCommon factors that can affect blood pressure:\n1. Age\n2. Diet\n3. Exercise\n4. Stress levels\n5. Family history\n\n_Remember to check your blood pressure regularly and consult healthcare professionals for guidance._\n\n**Tips for Maintenance:**\n* Reduce salt intake\n* Exercise regularly\n* Maintain healthy weight\n* Limit alcohol\n* Get adequate sleep
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
