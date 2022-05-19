//
//  GuardianViewModel.swift
//  Messangel
//
//  Created by Saad on 7/26/21.
//

import Foundation

struct Guardian: Codable, Hashable {
    var id: Int
    var user_id: Int
    var first_name: String
    var last_name: String
    var email: String
    var guardian_note: String?
    var status: String
    var guardian: User?
    var created_at: String?
    var updated_at: String?
}

struct MyProtected: Codable, Hashable {
    var id: Int
    var user: User
    var first_name: String
    var last_name: String
    var email: String
    var status: String
    var guardian: User
    var created_at: String?
    var updated_at: String?
}

struct ProtectedUser {
    var first_name: String
    var last_name: String
}

struct DeathDeclaration: Codable, Hashable {
    var status: String?
    var user: Int?
    var guardian: Int?
    var death_text: String?
}

struct Death: Codable {
    var user: Int
    var guardian = getUserId()
    var legal: Bool?
    var death_text: String
}

class GuardianViewModel: ObservableObject {
    @Published var deaths = [DeathDeclaration]()
    @Published var guardiansUpdated = false
    @Published var death = Death(user: 0, death_text: "")
    @Published var guardian = Guardian(id: 0, user_id: 0, first_name: "", last_name: "", email: "", guardian_note: "", status: "2")
    @Published var guardians = [Guardian]()
    @Published var protectedUser = ProtectedUser(first_name: "", last_name: "")
    @Published var protectedUsers = [MyProtected]()
    @Published var apiResponse = APIService.APIResponse(message: "")
    
    func getDeaths(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: deaths, urlString: "users/\(getUserId())/death_declaration") { result in
            switch result {
            case .success(let deaths):
                DispatchQueue.main.async {
                    self.deaths = deaths
                }
            case .failure(let error):
                print(error)
            }
            completion(true)
        }
    }
    
    func getGuardianDeaths(guardianID: Int?,completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: deaths, urlString: "users/\(guardianID)/death_declaration") { result in
            switch result {
            case .success(let deaths):
                DispatchQueue.main.async {
                    self.deaths = deaths
                }
            case .failure(let error):
                print(error)
            }
            completion(true)
        }
    }

    func getGuardians(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: guardians, urlString: "users/guardian/\(getUserId())") { result in
            switch result {
            case .success(let guardians):
                DispatchQueue.main.async {
                    self.guardians = guardians
                }
            case .failure(let error):
                print(error)
            }
            completion(true)
        }
    }
    
    func getProtectedUsers(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: protectedUsers, urlString: "users/imguardian/\(getUserId())") { result in
            switch result {
            case .success(let guardians):
                DispatchQueue.main.async {
                    self.protectedUsers = guardians
                }
            case .failure(let error):
                print(error)
            }
            completion(true)
        }
    }
    
    func delete(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/guardian/\(getUserId())/\(id)") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.apiResponse = response
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func cancel(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/guardian/\(id)/\(getUserId())") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.apiResponse = response
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
