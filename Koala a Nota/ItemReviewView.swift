//
//  ItemReviewView.swift
//  Koala a Nota
//
//  Created by user241334 on 10/1/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ItemReviewView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State private var viewError: Any = ""
    
    @State private var title = ""
    @State private var owner = ""
    @State private var review = ""
    @State private var rating = "5"
    
    @State private var isNewItem = false
    
    func salvar() {
        let review: ItemReview = ItemReview(title: title, owner: owner, rating: Int(rating) ?? 5, review: review, type: 1)
        
        let db = Firestore.firestore()
        
        db.collection("reviews").addDocument(data: [
            "title": review.title,
            "owner": review.owner,
            "rating": review.rating,
            "review": review.review,
            "type": review.type
        ]) { err in
            if err != nil {
                viewError = "Nao foi possivel salvar os dados!"
            } else {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Titulo:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Informe o titulo...", text: $title)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Text("Lugar:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Informe o lugar...", text: $owner)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Text("Nota:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Qual a nota...", text: $rating)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Text("Avaliacao:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Escreva a avaliacao...", text: $review)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Spacer()
            
            Group {
                if viewError as! String != "" {
                    Text(viewError as! String)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.red)
                        .padding(.bottom, 15)
                } else {
                    Text("")
                        .padding(.bottom, 30)
                }
                
                Button {
                    salvar()
                } label: {
                    Image(systemName: "sdcard.fill")
                        .foregroundColor(Color.white)
                    Text("Salvar")
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color("materialGreen"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .toolbar {
            if !isNewItem {
                ToolbarItem {
                    NavigationLink(destination: ItemReviewView()) {
                        Label("Deletar Avaliação", systemImage: "trash")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
    }
}

struct ItemReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ItemReviewView()
    }
}
