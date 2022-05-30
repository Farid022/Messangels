//
//  DeathAnnouncementViewModel.swift
//  Messangel
//
//  Created by Saad on 1/6/22.
//

import Foundation

struct PriorityContacts: Codable {
    var contact: [Int]
    var priority_note: String?
    var priority_note_attachment: [Int]?
    @CodableIgnored var priority_note_attachments: [URL]?
    var user = getUserId()
}

struct PriorityContactsData: Hashable, Codable {
    var id: Int
    var contact: [Contact]
    var priority_note: String?
    var priority_note_attachment: [Attachement]?
    var user: User
}

class PriorityContactsViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var contacts = [Contact]()
    @Published var priorities = [PriorityContactsData]()
    @Published var priorityContacts = PriorityContacts(contact: [Int]())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func addPriorityContacts(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: priorityContacts, response: apiResponse, endpoint: "users/\(getUserId())/priority_contact") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.apiResponse = response
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
    
//    func update(id: Int, completion: @escaping (Bool) -> Void) {
//        APIService.shared.post(model: priorityContacts, response: priorityContacts, endpoint: "users/\(getUserId())/priority_contact/\(id)", method: "PUT") { result in
//            switch result {
//            case .success(let item):
//                DispatchQueue.main.async {
//                    self.priorityContacts = item
//                    completion(true)
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    print(error.error_description)
//                    self.apiError = error
//                    completion(false)
//                }
//            }
//        }
//    }
    
    func get(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: priorities, urlString: "users/\(getUserId())/priority_contact") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.priorities = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}

