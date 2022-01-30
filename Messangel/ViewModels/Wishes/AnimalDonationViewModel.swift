//
//  AnimalDonationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

struct AnimalDonation: Codable {
    var single_animal: Bool
    var animal_name: String
    var animal_contact_detail: Int
    var animal_organization_detail: Int
    var animal_species: String
    var animal_note: String
    var user: Int
}

struct AnimalDonationDetail: Hashable, Codable {
    var single_animal: Bool
    var animal_name: String
    var animal_contact_detail: Contact?
    var animal_organization_detail: Organization?
    var animal_species: String
    var animal_note: String
    var user: User
}

class AnimalDonatiopnViewModel: ObservableObject {
    @Published var donations = [AnimalDonationDetail]()
    @Published var orgs = [Organization]()
    @Published var animalDonation = AnimalDonation(single_animal: true, animal_name: "", animal_contact_detail: 0, animal_organization_detail: 0, animal_species: "", animal_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: animalDonation, response: animalDonation, endpoint: "users/\(getUserId())/animal") { result in
            switch result {
            case .success(let animal):
                DispatchQueue.main.async {
                    self.animalDonation = animal
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
        APIService.shared.getJSON(model: orgs, urlString: "choices/\(getUserId())/organization?type=5") { result in
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
    
    func getAll() {
        APIService.shared.getJSON(model: donations, urlString: "users/\(getUserId())/animal") { result in
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
