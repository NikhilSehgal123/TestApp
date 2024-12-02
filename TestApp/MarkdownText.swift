import SwiftUI

extension Text {
    /// Processes a markdown string into SwiftUI Text with proper styling
    static func markdown(_ text: String) -> Text {
        processMarkdownText(text)
    }
    
    private static func processMarkdownText(_ text: String) -> Text {
        let lines = text.components(separatedBy: "\n")
        return lines.reduce(Text("")) { (result, line) in
            if line.isEmpty {
                return result + Text("\n")
            }
            return result + processMarkdownLine(line) + Text("\n")
        }
    }
    
    private static func processMarkdownLine(_ line: String) -> Text {
        if line.hasPrefix("# ") {
            return Text(line.dropFirst(2))
                .font(.system(size: 28, weight: .bold))
        } else if line.hasPrefix("## ") {
            return Text(line.dropFirst(3))
                .font(.system(size: 24, weight: .bold))
        } else if line.hasPrefix("* ") {
            return Text("• ").bold() + processInlineMarkdown(String(line.dropFirst(2)))
        } else if line.matches(of: #/^\d+\.\s/#).first != nil {
            return processInlineMarkdown(line)
        } else {
            return processInlineMarkdown(line)
        }
    }
    
    private static func processInlineMarkdown(_ text: String) -> Text {
        var result = Text("")
        var currentText = ""
        var index = text.startIndex
        
        while index < text.endIndex {
            let twoChars = text[index...].prefix(2)
            
            if twoChars == "**" {
                if !currentText.isEmpty {
                    result = result + Text(currentText)
                    currentText = ""
                }
                
                // Find the end of bold text
                if let endBold = text[text.index(after: text.index(after: index))...].firstIndex(of: "*") {
                    let boldText = text[text.index(after: text.index(after: index))..<endBold]
                    result = result + Text(String(boldText)).bold()
                    index = text.index(after: endBold)
                } else {
                    currentText.append(String(twoChars))
                    index = text.index(after: index)
                }
            } else if text[index] == "_" {
                if !currentText.isEmpty {
                    result = result + Text(currentText)
                    currentText = ""
                }
                
                // Find the end of italic text
                if let endItalic = text[text.index(after: index)...].firstIndex(of: "_") {
                    let italicText = text[text.index(after: index)..<endItalic]
                    result = result + Text(String(italicText)).italic()
                    index = text.index(after: endItalic)
                } else {
                    currentText.append(text[index])
                }
            } else {
                currentText.append(text[index])
            }
            
            if index < text.endIndex {
                index = text.index(after: index)
            }
        }
        
        if !currentText.isEmpty {
            result = result + Text(currentText)
        }
        
        return result
    }
}
