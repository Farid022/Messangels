//
//  ContentView.swift
//  Messangel
//
//  Created by Saad on 5/8/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var auth: AuthState
    
    var body: some View {
        NavigationView {
            if auth.user {
                TabBarView()
            } else {
                StartView()
            }
        }
        .environmentObject(auth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(auth: AuthState())
    }
}
