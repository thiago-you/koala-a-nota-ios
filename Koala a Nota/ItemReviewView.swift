//
//  ItemReviewView.swift
//  Koala a Nota
//
//  Created by user241334 on 10/1/23.
//

import SwiftUI

struct ItemReviewView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var owner = ""
    @State private var review = ""
    @State private var rating = 5
    
    @State private var isNewItem = false

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
            Button {
                dismiss()
                
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
