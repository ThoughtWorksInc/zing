//
//  ContentView.swift
//  Zing
//
//  Created by Andres Kievsky on 2/9/2024.
//

import SwiftUI
import SwiftData

struct ItemAction {
    static func execute(_ item: FilesystemItem) {
        let env = Env()
        env.execute(item.url)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var text: String = ""
    @FocusState private var keyboardFocused: Bool
    @EnvironmentObject private var vm: ContentViewViewModel

    private let textFieldFont = Font.custom("Menlo", size: 28)
    private let files: [FilesystemItem] = AppLister().listApps() ?? []
    @State var filteredFiles: [FilesystemItem] = []
    
    var body: some View {
        TextField("", text: $text)
            .font(textFieldFont)
            .textFieldStyle(.plain)
            .focused($keyboardFocused)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    keyboardFocused = true
                }
            }
            .background(.black)
            .padding()
            .background(.red)
            .onKeyPress(.escape, action: {
                vm.rejectPressed()
                return .handled
            })
            .onKeyPress(.return, action: {
                vm.acceptPressed()
                return .handled
            })
            .onChange(of: text) {
                filteredFiles = filterFiles(files, text)
            }
            
        List {
            ForEach(filteredFiles, id: \.url.description) { item in
                Button(action: { ItemAction.execute(item) }) {
                    Text(item.url.lastPathComponent)
                }
                    
            }
        }
    }

    typealias Parts = [String]
    
    private func match(_ pattern: Parts, within: Parts) -> Float {
        guard !pattern.isEmpty else {
            return 0
        }
        return 1
    }

    private func filterFiles(_ hayStack: [FilesystemItem], _ input: String) -> [FilesystemItem] {
        let needle = input.trimmingCharacters(in: .whitespacesAndNewlines)
        print(hayStack)
//        let needleParts: Parts = needle.components(separatedBy: .whitespacesAndNewlines)
        return hayStack.filter { item in
            let name = item.url.lastPathComponent
            let lcNeedle = needle.lowercased()
            let lcHayStack = name.lowercased()
            return lcHayStack.contains(lcNeedle)
        }
    }
}
