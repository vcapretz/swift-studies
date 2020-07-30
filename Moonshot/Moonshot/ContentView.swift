//
//  ContentView.swift
//  Moonshot
//
//  Created by Vitor Capretz on 2020-07-27.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        Text(self.showDates ? mission.formattedLaunchDate : self.getAstronautNames(for: mission))
                    }
                }
            }
            .navigationBarTitle(Text("Moonshot"))
            .navigationBarItems(trailing: Button("Show \(self.showDates ? "names" : "dates")") {
                self.showDates.toggle()
            })
        }
    }
    
    func getAstronautNames(for mission: Mission) -> String {
        var matches = [String]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(match.name)
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        
        return matches.joined(separator: ",")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
