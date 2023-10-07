//
//  HomeView.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI

struct HomeView: View {
    let dataModel = ItemReviewModel()
    
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
                    NavigationLink(destination: ItemReviewView()) {
                        Label("Nova Avaliacao", systemImage: "plus")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Image("profile")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.all, 10)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("lightPurple"), Color("darkPurple"), Color("darkerPurple")]), startPoint: .top, endPoint: .bottom)
                )
                .clipShape(Circle())
            Spacer()
        }
        .frame(height: 50)
        .padding()
    }
    
    var listView: some View {
        VStack {
            VStack {
                Text("Avaliações")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                ForEach(dataModel.reviews) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .bold()
                            Text(item.owner)
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .padding(.top, 10)
                            Text(item.review)
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
        .padding()
        .background(Color.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
