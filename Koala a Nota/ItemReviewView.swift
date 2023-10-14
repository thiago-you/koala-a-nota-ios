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
    @State private var isPresentingAlert: Bool = false
    @State private var isPresentingConfirmDelete: Bool = false
    
    @State private var title: String
    @State private var owner: String
    @State private var review: String
    @State var rating: Int
    
    init(itemReview: ItemReview?) {
        self.itemReview = itemReview
        
        _title = State(initialValue: itemReview?.title ?? "")
        _owner = State(initialValue: itemReview?.owner ?? "")
        _review = State(initialValue: itemReview?.review ?? "")
        _rating = State(initialValue: itemReview?.rating ?? 5)
    }
    
    func adicionar() {
        if title.isEmpty || owner.isEmpty || review.isEmpty {
            viewError = "Por favor, verifique os dados informados!"
            isPresentingAlert = true
            return
        }
        
        let review: ItemReview = ItemReview(id: UUID().uuidString, title: title, owner: owner, rating: rating, review: review, type: 1)
        
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
                viewError = "Nao foi possível adicionar os dados!"
                isPresentingAlert = true
            } else {
                dismiss()
            }
        }
    }
    
    func atualizar() {
        if title.isEmpty || owner.isEmpty || review.isEmpty {
            viewError = "Por favor, verifique os dados informados!"
            isPresentingAlert = true
            return
        }
        
        let review: ItemReview = ItemReview(id: UUID().uuidString, title: title, owner: owner, rating: rating, review: review, type: 1)
        
        let db = Firestore.firestore()
        
        db.collection("reviews").document(itemReview?.id ?? "").setData([
            "title": review.title,
            "owner": review.owner,
            "rating": review.rating,
            "review": review.review,
            "type": review.type
        ]) { err in
            if err != nil {
                viewError = "Nao foi possível atualizar os dados!"
                isPresentingAlert = true
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
        NavigationView {
            VStack {
                contentView
            }
        }
        .navigationBarTitle("Avaliação", displayMode: .inline)
        .toolbar {
            if itemReview != nil {
                ToolbarItem {
                    Button {
                        isPresentingConfirmDelete = true
                    }
                    label: {
                        Label("Deletar", systemImage: "trash")
                            .foregroundColor(.white)
                    }
                    .confirmationDialog("Tem certeza que deseja deletar este item?",
                                        isPresented: $isPresentingConfirmDelete) {
                        Button("Deletar") {
                            delete()
                        }
                    }
                }
            }
        }
        .toolbarBackground(Color("darkerPurple"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    var contentView: some View {
        VStack {
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
                SelectedRatingView(rating: $rating)
                Text("Avaliação:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Escreva a avaliação...", text: $review, axis: .vertical)
                    .lineLimit(5...10)
                    .padding(.all)
                    .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                    .padding(.bottom, 10)
            }
            Spacer()
            Button(itemReview == nil ? "Adicionar" : "Atualizar") {
                if itemReview == nil {
                    adicionar()
                } else {
                    atualizar()
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(Color("darkPurple"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .alert(viewError as! String, isPresented: $isPresentingAlert) {
            }
        }
        .padding()
    }
}

struct SelectedRatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            SelectableStarView(rating: $rating, value: 1)
            Spacer()
            SelectableStarView(rating: $rating, value: 2)
            Spacer()
            SelectableStarView(rating: $rating, value: 3)
            Spacer()
            SelectableStarView(rating: $rating, value: 4)
            Spacer()
            SelectableStarView(rating: $rating, value: 5)
        }
        .padding(.top, 10)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}

struct SelectableStarView: View {
    @Binding var rating: Int
    
    var value: Int
    
    init(rating: Binding<Int>, value: Int) {
        self._rating = rating
        self.value = value
    }
    
    var body: some View {
        Button {
            rating = value
        }
        label: {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(rating >= value ? Color.yellow : Color.gray)
        }
    }
}

struct ItemReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ItemReviewView(itemReview: nil)
    }
}
