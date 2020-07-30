//
//  AddView.swift
//  iExpense
//
//  Created by Vitor Capretz on 2020-07-27.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @ObservedObject var expenses: Expenses
    
    @State private var isShowingAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle(Text("Add new expense"))
            .navigationBarItems(trailing: Button("Save") {
                if let amountInt = Int(self.amount) {
                    let expense = ExpenseItem(name: self.name, type: self.type, amount: amountInt)
                    self.expenses.items.append(expense)
                    
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isShowingAlert = true
                }
            }
            .disabled(name == "")
            )
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text("Unable to save item"), message: Text("Please make sure to type in the correct values"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
