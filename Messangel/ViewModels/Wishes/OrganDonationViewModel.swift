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

struct FuneralIntity: Hashable, Codable {
    var id: Int
    var name: String
}

struct OrganDonationData: Hashable, Codable {
    var id: Int
    var register_to_national: Bool?
    var register_to_national_note: String?
    var donation: FuneralIntity
    var donation_note: String?
    var user: User
}

struct OrganDonation: Codable {
    var register_to_national: Bool?
    var register_to_national_note: String?
    var donation: Int
    var donation_note: String?
    var user = getUserId()
}

class OrganDonationViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var donations = [OrganDonationData]()
    @Published var donation = OrganDonation(donation: 0)
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
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: donation, response: donation, endpoint: "users/\(getUserId())/organ_donation/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.donation = item
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
    
    func get(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: donations, urlString: "users/\(getUserId())/organ_donation") { result in
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
}
