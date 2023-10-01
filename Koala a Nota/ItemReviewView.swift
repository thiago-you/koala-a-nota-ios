//
//  ItemReviewView.swift
//  Koala a Nota
//
//  Created by user241334 on 10/1/23.
//

import SwiftUI

struct ItemReviewView: View {
    @State private var title = ""
    @State private var owner = ""
    @State private var review = ""
    @State private var rating = 5
    
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
            TextField("Informe o lugar...", text: $title)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Text("Nota:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Qual a nota...", text: $title)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Text("Avaliacao:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Escreva a avaliacao...", text: $title)
                .padding(.all)
                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                .padding(.bottom, 20)
            Spacer()
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "sdcard.fill")
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
        .padding(.top, 50)
    }
}

struct ItemReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ItemReviewView()
    }
}
