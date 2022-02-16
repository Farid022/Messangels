//
//  ObjectDonationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

struct ObjectDonation: Codable {
    var id: Int?
    var single_object: Bool?
    var single_object_note: String?
    var object_name: String
    var object_contact_detail: Int?
    var organization_detail: Int?
    var object_photo: String
    var object_note: String
    var user = getUserId()
}

struct ObjectDonationDetails: Hashable, Codable {
    var id: Int
    var single_object: Bool
    var single_object_note: String?
    var object_name: String
    var object_contact_detail: Contact?
    var organization_detail: Organization?
    var object_photo: String
    var object_note: String
    var user: User
}

class ObjectDonationViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var donations = [ObjectDonationDetails]()
    @Published var orgs = [Organization]()
    @Published var objectDonation = ObjectDonation(object_name: "", object_photo: "", object_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
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
    
    func getOrgs() {
        APIService.shared.getJSON(model: orgs, urlString: "choices/\(getUserId())/organization?type=1") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.orgs = items
                }
            case .failure(let error):
                print(error)
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
