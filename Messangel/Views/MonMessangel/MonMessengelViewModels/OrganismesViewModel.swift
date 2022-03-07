//
//  OrganismesViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Organismes: Hashable, Codable {
    var id: Int?
    var name: String
    var emailAddress, phoneNumber, contactName: String?
    var address, postalCode, city, website: String?
    var type: String
    var user: Int

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

class OrganismesViewModel: ObservableObject {
    @Published var organismes = Organismes(name: "", type: "1", user: getUserId())
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: organismes, response: organismes, endpoint: "choices/\(getUserId())/organization") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    self.organismes = org
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
