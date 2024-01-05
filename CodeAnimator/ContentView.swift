//
//  ContentView.swift
//  CodeAnimator
//
//  Created by Adrian Bilescu on 02.01.2024.
//

import SwiftUI
import Runestone

struct ContentView: View {
    @State var textVersions: [String] = [
"""
    HStack {
        ForEach(Array(textVersions.enumerated()), id: \\.offset) { (index, version) in
            Text(String(index))
                .foregroundStyle(Color.white)
                .background(
                    Circle().foregroundStyle(Color.black)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedVersion = index
                    text = version
                }
        }
    }
""",
"""
    HStack {
        ForEach(Array(textVersions.enumerated()), id: \\.offset) { (index, version) in
            Text(String(index))
                .foregroundStyle(Color.white)
                .background(
                    Circle().foregroundStyle(Color.black)
                )
                .contentShape(Rectangle())
        }
    }
"""
    ]
    @State var selectedVersion: Int? = 0
    @State var text: String = ""
    
    @State var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(textVersions.enumerated()), id: \.offset) { (index, version) in
                    Text(String(index+1)).padding()
                        .foregroundStyle(Color.white)
                        .background(
                            Circle().foregroundStyle(Color.black)
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedVersion = index
                            withAnimation {
                                text = version
                            }
                        }
                }
            }
//            TextEditor(text: $text).transition(.scale)
            VStack(alignment: .leading) {
                let textLines = text.split(separator: "\n").map { String($0) }
                ForEach(Array(textLines.enumerated()), id: \.offset) { (index, line) in
                    HStack {
                        Text("\(index+1).")
                        Text(line)
//                        HStack(spacing: 1) {
//                            let words = line.split(separator: " ").map { String($0) }
//                            ForEach(Array(words.enumerated()), id: \.offset) { (index, word) in
//                                Text(word + " ")
//                                    .transition(.opacity.combined(with: .move(edge: .trailing)))
//                            }
//                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                }
//                .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
            
            Button(action: {
                saveVersion()
            }, label: {
                Text("Save Version")
            }).padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func saveVersion() {
        textVersions.append(text)
    }
    
//    private var editingContent: some View {
//        RSTextView(text: $text)
//    }
}

//struct RSTextView: UIViewRepresentable {
//    @Binding var text: String
//    
//    func makeUIView(context: Context) -> TextView {
//        let view = TextView()
//        view.text = text
//        return view
//    }
//    
//    func updateUIView(_ uiView: TextView, context: Context) {
////        uiView.editorDelegate = Coordinator(text: $text)
//    }
//    
//    class Coordinator: TextViewDelegate {
//        var text: Binding<String>
//        
//        init(text: Binding<String>) {
//            self.text = text
//        }
//        func textViewDidChange(_ textView: TextView) {
//            self.text.wrappedValue = textView.text
//            
//        }
//    }
//}

#Preview {
    ContentView()
}
