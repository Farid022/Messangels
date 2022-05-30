//
//  ClothDonationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import SwiftUI

struct Attachement: Hashable, Codable {
    var id: Int?
    var url: String
    var user: User
}

struct Attachment: Hashable, Codable {
    var id: Int?
    var url: String
    var user = getUserId()
}

struct ClothDonation: Codable {
    var id: Int?
    var single_clothing: Bool?
    var single_clothing_note: String?
    var single_clothing_note_attachment: [Int]?
    @CodableIgnored
    var single_clothing_note_attachments: [URL]?
    var clothing_name: String
    var clothing_contact_detail: Int?
    var clothing_organization_detail: Int?
    var clothing_photo: String?
    var clothing_note: String
    var clothing_note_attachment: [Int]?
    @CodableIgnored
    var clothing_note_attachments: [URL]?
    var user = getUserId()
}

struct ClothingDonation: Hashable, Codable {
    var id: Int
    var user: User
    var single_clothing: Bool
    var single_clothing_note: String?
    var single_clothing_note_attachment: [Attachement]?
    var clothing_name: String
    var clothing_organization_detail: Organization?
    var clothing_contact_detail: Contact?
    var clothing_photo: String?
    var clothing_note_attachment: [Attachement]?
    var clothing_note: String
}

class ClothDonationViewModel: ObservableObject {
    @Published var contactName = ""
    @Published var orgName = ""
    @Published var localPhoto = UIImage()
    @Published var updateRecord = false
    @Published var donations = [ClothingDonation]()
    @Published var clothDonation = ClothDonation(clothing_name: "", clothing_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createClothDonation(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: clothDonation, response: clothDonation, endpoint: "users/\(getUserId())/clothing") { result in
            switch result {
            case .success(let clothDonation):
                DispatchQueue.main.async {
                    self.clothDonation = clothDonation
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
    
    func getAll(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: donations, urlString: "users/\(getUserId())/clothing") { result in
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
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/cloth/\(id)/clothing") { result in
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
        APIService.shared.post(model: clothDonation, response: clothDonation, endpoint: "users/\(getUserId())/cloth/\(id)/clothing", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.clothDonation = item
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
