//
//  LoginView.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var viewError: Any = ""
    @State private var isPresentingAlert: Bool = false
    
    @State private var email = ""
    @State private var senha = ""
    @State private var rememberPassword = true
    
    func signIn() {
        if email.isEmpty || senha.isEmpty {
            viewError = "Por favor, verifique os dados informados!"
            isPresentingAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: senha) { authResult, error in
            if error != nil {
                viewError = "O login informado nao e valido!"
                isPresentingAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                ZStack {
                    VStack {
                        Spacer()
                        Image("profile")
                            .resizable()
                            .frame(width: 180, height: 180)
                        Spacer()
                        ZStack {
                            Color.white.ignoresSafeArea()
                            VStack {
                                Text("Entre na sua conta")
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 30)
                                Text("E-mail:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                TextField("Digite seu e-mail...", text: $email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
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
                                Button(action: { signIn() }) {
                                    Text("Entrar")
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("darkerPurple"))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.bottom, 10)
                                .padding(.top, 50)
                                .alert(viewError as! String, isPresented: $isPresentingAlert) {
                                }
                                NavigationLink(destination: SignupView()) {
                                    HStack {
                                        Text("Não possui uma conta?")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                        Text("Cadastre-se!")
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
            .navigationBarTitle("Login", displayMode: .inline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
