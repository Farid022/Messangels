//
//  AuthState.swift
//  Messangel
//
//  Created by Saad on 5/10/21.
//

import Foundation

class AuthState: ObservableObject {
    @Published var user: Bool
    
    init() {
        self.user = false
    }
}
