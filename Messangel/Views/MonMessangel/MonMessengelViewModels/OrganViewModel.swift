//
//  OrganViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

enum OrganChoix: Int, CaseIterable {
    case none
    case organs
    case deny
    case body
}

struct OrganDonationItem: Hashable,Codable
{
    var id: Int?
    var is_deleted: Bool?
    var name: String?
    
}

struct OrganItem: Hashable,Codable {
    var register_to_national: Bool?
    var id: Int
    var user: User?
    var assign_user: [User]?
    var register_to_nationa: Bool?
    var donation: OrganDonationItem?
    var register_to_national_note: String?
    var donation_note: String?
    
    
}

class OrganViewModel: ObservableObject {
    @Published var organ = [OrganItem(id: 0)]
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getOrganDonation(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: organ, urlString: "users/\(getUserId())/organ_donation") { result in
            switch result {
            case .success(let organ_donation):
                DispatchQueue.main.async {
                    self.organ = organ_donation
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    //self.apiError = error
                    completion(false)
                }
            }
        }
    }
}
