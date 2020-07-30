//
//  ContentView.swift
//  Challenge3-HWS
//
//  Created by Vitor Capretz on 2020-07-29.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct Activity: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var completedTimes: Int
}

class HabitsStore: ObservableObject {
    @Published var habits: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Activity].self, from: habits) {
                self.habits = decoded
                return
            }
        }
        self.habits = []
    }
}

struct ContentView: View {
    @ObservedObject var store = HabitsStore()
    
    @State private var isShowingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.habits) { habit in
                    NavigationLink(destination: ActivityDetailView(activity: habit)) {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            
                            Text("\(habit.completedTimes == 0 ? "Long press to mark as completed" : "Completed \(habit.completedTimes) time\(habit.completedTimes > 1 ? "s" : "")")")
                        }
                        .contextMenu {
                            Button("Mark as done!") {
                                self.store.habits = self.store.habits.map { storeHabit in
                                    if storeHabit.id == habit.id {
                                        return Activity(name: storeHabit.name, description: storeHabit.description, completedTimes: storeHabit.completedTimes + 1)
                                    }
                                    
                                    return storeHabit
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Habits"))
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.isShowingAddHabit = true
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $isShowingAddHabit) {
                    AddView(habitsStore: self.store)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
