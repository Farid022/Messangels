//
//  ContactViewModel.swift
//  Messangel
//
//  Created by Saad on 7/26/21.
//

import Foundation

struct Contact: Codable, Hashable {
    var id: Int
    var user: Int
    var first_name: String
    var last_name:String
    var email:String
    var phone_number:String
    var dob:String?
    var legal_age:Bool
}

class ContactViewModel: ObservableObject {
    @Published var contact = Contact(id: 0, user: getUserId(), first_name: "", last_name: "", email: "", phone_number: "", legal_age: true)
    @Published var contacts = [Contact]()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createContact(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: contact, response: contact, endpoint: "users/contact") { result in
            switch result {
            case .success(let contact):
                DispatchQueue.main.async {
                    self.contact = contact
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
    
    func getContacts() {
        APIService.shared.getJSON(model: contacts, urlString: "users/contact/\(getUserId())") { result in
            switch result {
            case .success(let contactList):
                DispatchQueue.main.async {
                    self.contacts = contactList
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func delete(userId: Int, contactId: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/contact/\(getUserId())/\(contactId)") { result in
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
