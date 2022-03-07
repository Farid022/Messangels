//
//  AnnouncementViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct UserPriorityContacts: Codable {
    var contact: [Int]
    var user: Int
}

class UserPriorityContactsViewModel: ObservableObject {
    @Published var userPriorityContacts = UserPriorityContacts(contact: [Int](), user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func addPriorityContacts(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: userPriorityContacts, response: userPriorityContacts, endpoint: "users/\(getUserId())/priority_contact") { result in
            switch result {
            case .success(let contacts):
                DispatchQueue.main.async {
                    self.userPriorityContacts = contacts
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

