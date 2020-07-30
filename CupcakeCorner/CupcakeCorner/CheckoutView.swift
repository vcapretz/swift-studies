//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Vitor Capretz on 2020-07-30.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Your total is $\(self.order.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("no data in response: \(error?.localizedDescription ?? "Unknown error")")
                self.alertTitle = "Ops!"
                self.alertMessage = "\(error?.localizedDescription ?? "Unknown error")"
                self.showingAlert = true
                
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderModel.self, from: data) {
                DispatchQueue.main.async {
                    self.alertTitle = "Thank you!"
                    self.alertMessage = "Your order for \(decodedOrder.quantity)x \(OrderModel.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                    self.showingAlert = true
                }
            } else {
                print("Invalid order data")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
