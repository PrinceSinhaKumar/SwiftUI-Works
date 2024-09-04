//
//  ContentView.swift
//  WorkOnStatePropertyWrapper
//
//  Created by  Prince Shrivastav on 29/08/24.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
extension TodoItem {
    static var defaultItem: [TodoItem] {
        let item = [
            TodoItem(title: "Top", isCompleted: false)
        ]
        return item
    }
}

struct ContentView: View {
    
    @State private var todoListItem: [TodoItem] = []
    @State private var textFieldInput: String = ""
    
    var body: some View {
        List {
            ForEach($todoListItem) { $item in
                HStack {
                    Toggle(isOn: $item.isCompleted) {
                        Text(item.title)
                    }
                }
            }
            HStack {
                TextField("Enter title", text: $textFieldInput)
                Button(action: {
                    todoListItem.append(TodoItem(title: textFieldInput, isCompleted: false))
                    textFieldInput = ""
                }, label: {
                    Text("Add")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
