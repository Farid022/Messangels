//
//  AuthState.swift
//  Messangel
//
//  Created by Saad on 5/10/21.
//

import Foundation

class Auth: ObservableObject {
    @Published var user: User
    @Published var credentials: Credentials
    @Published var token: Token
    
    init() {
        self.user = User(id: nil, first_name: "", last_name: "", email: "", password: "", phone_number: "", dob: "", city: "", postal_code: "", gender: "", is_active: false, image_url: nil)
        self.credentials = Credentials(email: "", password: "")
        self.token = Token(access_token: "", token_type: "", refresh_token: "")
    }
    
    func userObject() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(user) else {
            return ["id": 0]
        }
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
    
    func updateUser() {
        UserDefaults.standard.set(self.userObject(), forKey: "user")
        self.credentials.email = ""
        self.credentials.password = ""
    }
    
    func removeUser() {
        UserDefaults.standard.removeObject(forKey: "user")
        self.user = User(id: nil, first_name: "", last_name: "", email: "", password: "", phone_number: "", dob: "", city: "", postal_code: "", gender: "", is_active: false, image_url: nil)
        self.credentials = Credentials(email: "", password: "")
        self.token = Token(access_token: "", token_type: "", refresh_token: "")
    }
    
    func getToken(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: credentials, response: token, endpoint: "token", token: false) { result in
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    UserDefaults.standard.set(token.access_token, forKey: "token")
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    completion(false)
                }
            }
        }
    }
}
