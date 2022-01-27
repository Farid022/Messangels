//
//  ObjectDonationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

struct ObjectDonation: Codable {
    var single_object: Bool
    var object_name: String
    var object_contact_detail: Int
    var organization_detail: Int
    var object_photo: String
    var object_note: String
    var user: Int
}

struct ObjectDonationDetails: Hashable, Codable {
    var id: Int
    var single_object: Bool
    var object_name: String
    var object_contact_detail: Contact?
    var organization_detail: Organization?
    var object_photo: String
    var object_note: String
    var user: User
}

class ObjectDonationViewModel: ObservableObject {
    @Published var donations = [ObjectDonationDetails]()
    @Published var orgs = [Organization]()
    @Published var objectDonation = ObjectDonation(single_object: true, object_name: "", object_contact_detail: 0, organization_detail: 0, object_photo: "", object_note: "", user: getUserId())
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
}
