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
        ZStack {
            ScrollView(showsIndicators: false) {
                headerView
                listView
            }
            addButton
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
    
    var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 20, height: 20)
                        
                }
                .padding(.all, 20)
                .background(Color("materialGreen"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
