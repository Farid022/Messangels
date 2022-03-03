//
//  OrganizationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/25/22.
//

import Foundation

struct Organization: Hashable, Codable {
    var id: Int?
    var name: String
    var emailAddress, phoneNumber, contactName: String?
    var address, postalCode, city, website: String?
    var type: String
    var user = getUserId()

    enum CodingKeys: String, CodingKey {
        case id, name
        case emailAddress = "email_address"
        case phoneNumber = "phone_number"
        case contactName = "contact_name"
        case address
        case postalCode = "postal_code"
        case city, website, type, user
    }
}

class OrgViewModel: ObservableObject {
    @Published var orgs = [Organization]()
    @Published var newOrg = Organization(name: "", type: "1")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: newOrg, response: newOrg, endpoint: "choices/\(getUserId())/organization") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    self.newOrg = org
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
    
    func getOrgs(_ type: Int) {
        APIService.shared.getJSON(model: orgs, urlString: "choices/\(getUserId())/organization?type=\(type)") { result in
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
