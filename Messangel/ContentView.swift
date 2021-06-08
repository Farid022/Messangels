//
//  ContentView.swift
//  Messangel
//
//  Created by Saad on 5/8/21.
//

import SwiftUI
import NavigationStack

struct ContentView: View {
    @ObservedObject var auth: AuthState
    
    init() {
        self.auth = AuthState()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [
            .font : UIFont.boldSystemFont(ofSize: 34),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        Group {
            if auth.user {
                TabBarView()
            } else {
                StartView()
            }
        }
        .environmentObject(auth)
        .environmentObject(NavigationModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
