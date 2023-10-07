//
//  ContentView.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI

class UserStatus: ObservableObject {
    @Published var isLogged: Bool?
}

struct ContentView: View {
    @EnvironmentObject private var user: UserStatus
    
    var body: some View {
        if user.isLogged == true {
            HomeView()
                .transition(AnyTransition.slide.animation(.easeInOut(duration: 1)))
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
