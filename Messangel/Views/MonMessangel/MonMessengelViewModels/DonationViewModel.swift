//
//  DonationViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Donation: Codable {
    var donation_organization: Int
    var donation_note: String
    var user: Int
}

struct DonationDetail: Hashable, Codable {
    var donation_organization: Organismes
    var donation_note: String
    var user: User
}

class DonationViewModel: ObservableObject {
    @Published var newOrganismes = Organismes(name: "", type: "1", user: getUserId())
    @Published var donations = [DonationDetail]()
    @Published var orgnismes = [Organismes]()
    @Published var donation = Donation(donation_organization: 0, donation_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: newOrganismes, response: newOrganismes, endpoint: "users/\(getUserId())/organization") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    self.newOrganismes = org
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
    
    func setDonationNote(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: donation, response: donation, endpoint: "users/\(getUserId())/org_donation") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    self.donation = org
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
        APIService.shared.getJSON(model: orgnismes, urlString: "choices/\(getUserId())/organization?type=3") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.orgnismes = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDonationOrgs() {
        APIService.shared.getJSON(model: donations, urlString: "users/\(getUserId())/org_donation") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.donations = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
