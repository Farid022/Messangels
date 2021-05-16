//
//  MessangelApp.swift
//  Messangel
//
//  Created by Saad on 5/8/21.
//

import SwiftUI

@main
struct MessangelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(auth: AuthState())
        }
    }
}
