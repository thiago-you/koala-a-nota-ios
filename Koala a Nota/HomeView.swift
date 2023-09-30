//
//  HomeView.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI

struct HomeView: View {
    let dataModel = DataModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            headerView
            listView
        }
    }

    var headerView: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
        }
        .frame(height: 240)
    }

    var listView: some View {
        VStack {
            VStack {
                Text("Avaliações")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                ForEach(dataModel.reviews) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title2)
                                .bold()
                            Text(item.review)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
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
