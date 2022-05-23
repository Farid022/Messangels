//
//  DonationOrgViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct DonationOrg: Codable {
    var id: Int?
    var donation_organization: Int
    var donation_note: String
    var donation_note_attachment: [Int]?
    var user = getUserId()
}

struct DonationOrgDetail: Hashable, Codable {
    var id: Int
    var donation_organization: Organization
    var donation_note: String
    var user: User
}

class DonationOrgViewModel: ObservableObject {
    @Published var attachements = [Attachement]()
    @Published var orgName = ""
    @Published var updateRecord = false
    @Published var donationOrgs = [DonationOrgDetail]()
    @Published var orgs = [Organization]()
    @Published var donationOrg = DonationOrg(donation_organization: 0, donation_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func setDonationNote(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: donationOrg, response: donationOrg, endpoint: "users/\(getUserId())/org_donation") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    self.donationOrg = org
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
    
    func getDonationOrgs(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: donationOrgs, urlString: "users/\(getUserId())/org_donation") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.donationOrgs = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/donation/\(id)/org_donation") { result in
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
        APIService.shared.post(model: donationOrg, response: donationOrg, endpoint: "users/\(getUserId())/donation/\(id)/org_donation", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.donationOrg = item
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
