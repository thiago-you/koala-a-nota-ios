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

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func fetchAllReviews() {
        let db = Firestore.firestore()
        
        db.collection("reviews").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var updatedReviews: [ItemReview] = []
                for document in querySnapshot!.documents {
                    let review = ItemReview(id: document.documentID, title: document.get("title") as! String, owner: document.get("owner") as! String, rating: document.get("rating") as! Int , review: document.get("review") as! String, type: 1)
                    
                    updatedReviews.append(review)
                }
                
                self.reviews = updatedReviews
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    headerView
                    listView
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: ItemReviewView(itemReview: nil)) {
                        Label("Nova Avaliação", systemImage: "plus")
                            .foregroundColor(.black)
                    }
                }
            }
        }.onAppear {
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
                    NavigationLink(destination: ItemReviewView(itemReview: itemReview)) {
                        HStack {
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
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("lightPurple"), Color("darkPurple"), Color("darkerPurple")]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
