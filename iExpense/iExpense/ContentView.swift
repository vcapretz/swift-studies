//
//  ContentView.swift
//  iExpense
//
//  Created by Vitor Capretz on 2020-07-27.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var isShowingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text("$\(item.amount)")
                            .foregroundColor(item.amount > 0 ? .green : item.amount < 0 ? .red : .none)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle(Text("iExpense"))
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.isShowingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $isShowingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
