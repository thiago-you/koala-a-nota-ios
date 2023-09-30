//
//  LoginView.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var senha = ""
    @State private var rememberPassword = true
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 180, height: 180)
                    Spacer()
                    ZStack {
                        Color.white.ignoresSafeArea()
                        VStack {
                            Text("Crie sua conta")
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 30)
                            Text("E-mail:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Digite seu e-mail...", text: $email)
                                .padding(.all)
                                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                                .padding(.bottom, 20)
                            HStack {
                                Text("Senha:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            SecureField("Digite sua senha...", text: $senha)
                                .padding(.all)
                                .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color("lightPurple"), style: StrokeStyle(lineWidth: 1.0)))
                                .padding(.bottom, 20)
                            HStack {
                                Text("Lembrar minha senha")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                                Toggle("", isOn: $rememberPassword)
                            }
                            .padding(.bottom, 30)
                            Button("Criar conta") {
                                
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("darkerPurple"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.bottom, 10)
                            Button(action: {}) {
                                HStack {
                                    Text("Ja possui uma conta?")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                    Text("Entre")
                                        .font(.callout)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                        .padding()
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .frame(minHeight: reader.size.height)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("darkerPurple"), Color("darkPurple"), .white]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
