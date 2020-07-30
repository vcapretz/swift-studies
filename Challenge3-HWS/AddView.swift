//
//  AddView.swift
//  Challenge3-HWS
//
//  Created by Vitor Capretz on 2020-07-29.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var habitsStore: HabitsStore
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("What habit you wanna track?", text: $name)
                TextField("Describe why you want to do it", text: $description)
            }
            .navigationBarTitle(Text("Add new habit"))
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let activity = Activity(name: self.name, description: self.description, completedTimes: 0)
                    
                    self.habitsStore.habits.append(activity)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(self.name == "")
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habitsStore: HabitsStore())
    }
}
