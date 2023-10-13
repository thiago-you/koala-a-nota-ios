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
    
    let itemReview: ItemReview?
    
    @State private var viewError: Any = ""
    
    @State private var title: String
    @State private var owner: String
    @State private var review: String
    @State private var rating: String
    
    init(itemReview: ItemReview?) {
        self.itemReview = itemReview
        
        _title = State(initialValue: itemReview?.title ?? "")
        _owner = State(initialValue: itemReview?.owner ?? "")
        _review = State(initialValue: itemReview?.review ?? "")
        _rating = State(initialValue: "\(itemReview?.rating ?? 5)")
    }
    
    func adicionar() {
        let review: ItemReview = ItemReview(id: UUID().uuidString, title: title, owner: owner, rating: Int(rating) ?? 5, review: review, type: 1)
        
        let db = Firestore.firestore()
        
        db.collection("reviews").addDocument(data: [
            "id": review.id,
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
    
    func atualizar() {
        let review: ItemReview = ItemReview(id: UUID().uuidString, title: title, owner: owner, rating: Int(rating) ?? 5, review: review, type: 1)
        
        let db = Firestore.firestore()
        
        db.collection("reviews").document(itemReview?.id ?? "").setData([
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

    func delete() {
        let db = Firestore.firestore()
        db.collection("reviews").document(itemReview?.id ?? "").delete()
        dismiss()
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
                    if itemReview == nil {
                        adicionar()
                    } else {
                        atualizar()
                    }
                } label: {
                    Image(systemName: "sdcard.fill")
                        .foregroundColor(Color.white)
                    if itemReview != nil {
                        Text("Adicionar")
                    } else {
                        Text("Atualizar")
                    }
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color("materialGreen"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .toolbar {
            if itemReview != nil {
                ToolbarItem {
                    Button {
                        delete()
                    }
                    label: {
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
        ItemReviewView(itemReview: nil)
    }
}
