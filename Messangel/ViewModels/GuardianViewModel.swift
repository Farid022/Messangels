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
    var status: String
}

class GuardianViewModel: ObservableObject {
    @Published var guardian = Guardian(id: 0, user_id: 0, first_name: "", last_name: "", email: "", status: "1")
    @Published var guardians = [Guardian]()
    @Published var apiResponse = APIService.APIResponse(message: "")

    
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
    
    func delete(id: Int, userId: Int, completion: @escaping (Bool) -> Void) {
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
}
