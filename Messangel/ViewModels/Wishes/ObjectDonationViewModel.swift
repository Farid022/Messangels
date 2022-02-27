//
//  ObjectDonationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import SwiftUI

struct ObjectDonation: Codable {
    var id: Int?
    var single_object: Bool?
    var single_object_note: String?
    var object_name: String
    var object_contact_detail: Int?
    var organization_detail: Int?
    var object_photo: String?
    var object_note: String
    var object_note_attachment: [Int]?
    var user = getUserId()
}

struct ObjectDonationDetails: Hashable, Codable {
    var id: Int
    var single_object: Bool
    var single_object_note: String?
    var object_name: String
    var object_contact_detail: Contact?
    var organization_detail: Organization?
    var object_photo: String?
    var object_note: String
    var object_note_attachment: [Attachement]?
    var user: User
}

class ObjectDonationViewModel: ObservableObject {
    @Published var attachements = [Attachement]()
    @Published var contactName = ""
    @Published var orgName = ""
    @Published var localPhoto = UIImage()
    @Published var updateRecord = false
    @Published var donations = [ObjectDonationDetails]()
    @Published var objectDonation = ObjectDonation(object_name: "", object_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func attach(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: attachements, response: attachements, endpoint: "users/note_attachment") { result in
            switch result {
            case .success(let attachements):
                DispatchQueue.main.async {
                    self.attachements = attachements
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
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: objectDonation, response: objectDonation, endpoint: "users/\(getUserId())/object") { result in
            switch result {
            case .success(let object):
                DispatchQueue.main.async {
                    self.objectDonation = object
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
    
    func getAll(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: donations, urlString: "users/\(getUserId())/object") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.donations = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/obj/\(id)/object") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: objectDonation, response: objectDonation, endpoint: "users/\(getUserId())/obj/\(id)/object", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.objectDonation = item
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
