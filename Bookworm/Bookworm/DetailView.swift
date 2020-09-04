//
//  DetailView.swift
//  Bookworm
//
//  Created by Vitor Capretz on 2020-08-02.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingDeleteAlert = false
    
    var book: Book
    
    var formattedDate: String {
        guard let safeDate = book.date else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: safeDate)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unkown")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                
                Text("Added on \(self.formattedDate)")
                    .padding()
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unkown"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.isShowingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $isShowingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                }, secondaryButton: .cancel())
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book()
        
        book.title = "Test title"
        book.author = "Test author"
        book.rating = 4
        book.genre = "Fantasy"
        book.review = "Oh wow I am so impressed with this book you have no idea pls read it!!!!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
