//
//  AnimalsViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Animal: Codable {
    var single_animal: Bool
    var animal_name: String
    var animal_contact_detail: Int
    var animal_organization_detail: Int
    var animal_species: String
    var animal_note: String
    var user: Int
    var assign_user : [User]?
}

struct AnimalDetail: Hashable, Codable {
    var id : Int?
    var single_animal: Bool
    var animal_name: String
    var animal_contact_detail: Contact?
    var animal_organization_detail: Organismes?
    var animal_species: String
    var animal_note: String
    var animal_photo: String
    var user: User
    var animal_note_attachment: [String]?
    var assign_user : [User]?
}

class AnimalsViewModel: ObservableObject {
    @Published var animals = [AnimalDetail]()
    @Published var orgs = [Organization]()
    @Published var animalDonation = Animal(single_animal: true, animal_name: "", animal_contact_detail: 0, animal_organization_detail: 0, animal_species: "", animal_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getAnimal(completion: @escaping (Bool) -> Void) {
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
        APIService.shared.getJSON(model: animals, urlString: "users/\(getUserId())/animal") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.animals = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
