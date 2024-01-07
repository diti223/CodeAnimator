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
    
    @Namespace var namespace
    
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
            VStack(alignment: .leading) {
                let textLines = text.split(separator: "\n").map { String($0) }
                ForEach(Array(textLines.enumerated()), id: \.offset) { (index, line) in
                    HStack {
                        Text("\(index+1).")
                        Text(line)
                            .matchedGeometryEffect(id: line, in: namespace)
                            .transition(.opacity.combined(with: .move(edge: .trailing)))
                    }
                }
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
}

#Preview {
    ContentView()
}
