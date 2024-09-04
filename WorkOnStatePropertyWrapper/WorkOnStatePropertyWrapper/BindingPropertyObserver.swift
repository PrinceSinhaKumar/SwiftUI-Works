//
//  BindingPropertyObserver.swift
//  WorkOnStatePropertyWrapper
//
//  Created by  Prince Shrivastav on 30/08/24.
//

import SwiftUI

struct ShoppingItem: Identifiable {
    var id = UUID()
    var price: String
    var name: String
}

extension ShoppingItem {
    static var defaultList: [ShoppingItem] {
        let list = [ShoppingItem(price: "$1999", name: "Macbook Air M2"),
                    ShoppingItem(price: "$2999", name: "Macbook Air M3")]
        return list
    }
}

struct BindingPropertyObserver: View {
    @State private var shoppingList: [ShoppingItem] = ShoppingItem.defaultList
    var body: some View {
        List($shoppingList) { $item in
            ShoppingView(item: item)
        }
    }
}

#Preview {
    BindingPropertyObserver()
}

struct ShoppingView: View {
    @State var item: ShoppingItem
    @State private var isPresenteted: Bool = false
    var body: some View {
        HStack {
            TextField("Product Name", text: $item.name)
            Spacer()
            Text(item.price)
        }
        .onTapGesture {
            isPresenteted.toggle()
        }
        .padding([.leading, .trailing], 5)
        .sheet(isPresented: $isPresenteted, content: {
            DetailView(item: $item)
        })
    }
}

struct DetailView: View {
    @Binding var item: ShoppingItem
    var body: some View {
        HStack {
            TextField("Product Name", text: $item.name)
            Spacer()
            Text(item.price)
        }
        .padding([.leading, .trailing], 5)
    }
}

