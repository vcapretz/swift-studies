//
//  TabBar.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-05-19.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Home")
            }
            
            CourseList()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Courses")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
