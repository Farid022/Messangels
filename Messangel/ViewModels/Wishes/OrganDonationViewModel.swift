//
//  OrganDonationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/6/22.
//

import Foundation

enum OrganDonChoice: Int, CaseIterable {
    case none
    case organs
    case deny
    case body
}

struct OrganDonation: Codable {
    var register_to_national: Bool?
    var donation: Int
    var user: Int
}

class OrganDonationViewModel: ObservableObject {
    @Published var donation = OrganDonation(donation: 0, user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: donation, response: donation, endpoint: "users/\(getUserId())/organ_donation") { result in
            switch result {
            case .success(let organ_donation):
                DispatchQueue.main.async {
                    self.donation = organ_donation
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
