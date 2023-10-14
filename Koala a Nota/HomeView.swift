//
//  HomeView.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    let dataModel = ItemReviewModel()
    
    @State private var reviews: [ItemReview] = []
    @State private var selectedReview: ItemReview?

    @State private var isPresentingConfirmDemo: Bool = false
    @State private var isPresentingConfirmClear: Bool = false
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func fetchAllReviews() {
        let db = Firestore.firestore()
        
        db.collection("reviews").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var updatedReviews: [ItemReview] = []
                for document in querySnapshot!.documents {
                    let review = ItemReview(id: document.documentID, title: document.get("title") as! String, owner: document.get("owner") as! String, rating: document.get("rating") as! Int , review: document.get("review") as! String, type: 1)
                    
                    updatedReviews.append(review)
                }
                
                DispatchQueue.main.async {
                    self.reviews = updatedReviews
                }
            }
        }
    }
    
    func demo() {
        clear()
        
        dataModel.reviews.forEach { review in
            let db = Firestore.firestore()
            
            db.collection("reviews").document().setData([
                "title": review.title,
                "owner": review.owner,
                "rating": review.rating,
                "review": review.review,
                "type": review.type
            ])
        }
    }
    
    func clear() {
        let db = Firestore.firestore()
            
        reviews.forEach { review in
            db.collection("reviews").document(review.id).delete()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    headerView
                    listView
                }
                .padding(.top, 30)
            }
            .navigationBarTitle("Home")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: ItemReviewView(itemReview: nil)) {
                        Label("Nova Avaliação", systemImage: "plus")
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(Color("darkerPurple"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear {
            fetchAllReviews()
        }
    }
    
    var headerView: some View {
        HStack {
            VStack {
                Image("profile")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.all, 10)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("lightPurple"), Color("darkPurple"), Color("darkerPurple")]), startPoint: .top, endPoint: .bottom)
                    )
                    .clipShape(Circle())
                Button("Sair", action: { logout() })
                    .bold()
                    .foregroundColor(.black)
            }
            Spacer()
            HStack {
                VStack {
                    Button {
                        isPresentingConfirmDemo = true
                    }
                    label: {
                        VStack {
                            Image(systemName: "note.text.badge.plus")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("darkerPurple"))
                                .padding(.bottom, 5)
                            Text("Demo")
                                .bold()
                                .font(.callout)
                                .foregroundColor(.black)
                        }
                    }
                    .confirmationDialog("Tem certeza que deseja cadastrar os dados de demonstracao?",
                      isPresented: $isPresentingConfirmDemo) {
                      Button("Cadastrar Demonstracao") {
                        demo()
                       }
                     }
                }
                .padding(.trailing, 20)
                VStack {
                    Button {
                        isPresentingConfirmClear = true
                    }
                    label: {
                        VStack {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("darkerPurple"))
                                .padding(.bottom, 5)
                            Text("Limpar")
                                .bold()
                                .font(.callout)
                                .foregroundColor(.black)
                        }
                    }
                    .confirmationDialog("Tem certeza que deseja deletar todos os itens?",
                      isPresented: $isPresentingConfirmClear) {
                      Button("Limpar Dados") {
                        clear()
                       }
                     }
                }
            }
            .padding(.trailing, 15)
        }
        .frame(height: 50)
        .padding()
        .padding(.top, 20)
    }
    
    var listView: some View {
        VStack {
            VStack {
                Text("Avaliações")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                ForEach(reviews) { itemReview in
                    ZStack {
                        NavigationLink(destination: ItemReviewView(itemReview: itemReview)) {
                            HStack {
                                ZStack {
                                    VStack(alignment: .leading) {
                                        Text(itemReview.title)
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .bold()
                                        Text(itemReview.owner)
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .padding(.top, 10)
                                        Text(itemReview.review)
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                            .padding(.top, 1)
                                    }
                                    .padding(.all, 25)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    HStack {
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.white)
                                            .padding(.trailing, 20)
                                        
                                    }
                                    VStack {
                                        Spacer()
                                        Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                            .resizable()
                                            .frame(width: 65, height: 60)
                                            .foregroundColor(Color.white)
                                            .opacity(0.4)
                                            .padding(.trailing, 20)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color("lightPurple"), Color("darkPurple"), Color("darkerPurple")]), startPoint: .leading, endPoint: .trailing)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.bottom, 20)
                        }
                        RatingView(review: itemReview)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct RatingView: View {
    var review: ItemReview
    
    init(review: ItemReview) {
        self.review = review
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                HStack {
                    StarView(filled: review.rating >= 1)
                    StarView(filled: review.rating >= 2)
                    StarView(filled: review.rating >= 3)
                    StarView(filled: review.rating >= 4)
                    StarView(filled: review.rating >= 5)
                }
                .padding(.trailing, 10)
                Spacer()
            }
        }
        .padding(.top, -13)
    }
}

struct StarView: View {
    var filled: Bool = true
    
    init(filled: Bool) {
        self.filled = filled
    }
    
    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(filled ? Color.yellow : Color.gray)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
