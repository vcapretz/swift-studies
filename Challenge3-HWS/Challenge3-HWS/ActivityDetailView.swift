//
//  ActivityDetailView.swift
//  Challenge3-HWS
//
//  Created by Vitor Capretz on 2020-07-29.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(activity.description)
                .font(.title)
            
            Text("\(activity.completedTimes == 0 ? "You've not yet completed this one" : "Awesome! You've completed this \(activity.completedTimes) time\(activity.completedTimes > 1 ? "s" : "") already")")
            
            Spacer()
        }
        .navigationBarTitle(Text(activity.name))
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(name: "Test", description: "Some more text", completedTimes: 10))
    }
}
