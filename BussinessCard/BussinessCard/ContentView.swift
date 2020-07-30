//
//  ContentView.swift
//  BussinessCard
//
//  Created by Vitor Capretz on 2020-05-09.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("ghProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                    )
                
                Text("Vitor Capretz")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                
                Text("Software Engineer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                
                Divider()
                    .padding(.horizontal)
                
                InfoView(text: "+46 77 111 55 99", imageName: "phone.fill")
                
                InfoView(text: "capretzvitor@gmail.com", imageName: "envelope.fill")
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct InfoView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(Color(red: 0.09, green: 0.63, blue: 0.52))
                    Text(text).foregroundColor(.black)
                }
        )
            .padding([.horizontal, .top])
    }
}
