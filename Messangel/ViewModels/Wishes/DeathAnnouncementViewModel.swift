//
//  DeathAnnouncementViewModel.swift
//  Messangel
//
//  Created by Saad on 1/6/22.
//

import Foundation

struct PriorityContacts: Codable {
    var contact: [Int]
    var user: Int
}

class PriorityContactsViewModel: ObservableObject {
    @Published var priorityContacts = PriorityContacts(contact: [Int](), user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func addPriorityContacts(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: priorityContacts, response: priorityContacts, endpoint: "users/\(getUserId())/priority_contact") { result in
            switch result {
            case .success(let contacts):
                DispatchQueue.main.async {
                    self.priorityContacts = contacts
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    self.apiError = error
                    completion(false)
                }
            }
        }
    }
}

