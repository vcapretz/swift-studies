//
//  LoginView.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-07-20.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var show = false
    @State private var viewState = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
            
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                GeometryReader { geometry in
                    Text("Learn Design & Code.\nFrom scratch.")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                .offset(x: viewState.width / 15, y: viewState.height / 15)
                
                Text("80 hours of courses for SwiftUI, React and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                    .multilineTextAlignment(.center)
                    .offset(x: viewState.width / 20, y: viewState.height / 20)
                
                Spacer()
            }
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200)
                        .rotationEffect(.degrees(show ? 360 + 90 : 90))
                        .blendMode(.plusDarker)
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                        .onAppear { self.show = true }
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: -250)
                        .rotationEffect(.degrees(show ? 360 : 0), anchor: .leading)
                        .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                        .blendMode(.overlay)
                }
            )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3"))
                    .offset(x: viewState.width / 25, y: viewState.height / 25),
                alignment: .bottom
            )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(.degrees(5), axis: (x: viewState.width, y: viewState.height, z: 0))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.isDragging = true
                        self.viewState = value.translation
                }
                .onEnded { value in
                    self.isDragging = false
                    self.viewState = .zero
                }
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
