//
//  FuneralAnnounce.swift
//  Messangel
//
//  Created by Saad on 1/4/22.
//

import SwiftUI

struct FuneralAnnounce: Codable {
    var invitation_photo: String
    var invitation_photo_note: String?
    var invitation_photo_note_attachment: [Int]?
    var invitation_note: String
    var invitation_note_attachment: [Int]?
    var theme_note: String
    var theme_note_attachment: [Int]?
    var newspaper_note: String
    var newspaper_note_attachment: [Int]?
    var user = getUserId()
}

struct FuneralAnnounceData: Hashable, Codable {
    var id: Int
    var invitation_photo: String
    var invitation_photo_note: String?
    var invitation_note: String
    var theme_note: String
    var newspaper_note: String
    var user: User
}

class FuneralAnnounceViewModel: CUViewModel {
    @Published var attachements = [Attachement]()
    @Published var invitePhoto = UIImage()
    @Published var updateRecord = false
    @Published var recordId = 0
    @Published var progress = 0
    @Published var announcements = [FuneralAnnounceData]()
    @Published var announcement = FuneralAnnounce(invitation_photo: "", invitation_note: "", theme_note: "", newspaper_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: announcement, response: announcement, endpoint: "users/\(getUserId())/announce") { result in
            switch result {
            case .success(let announcement):
                DispatchQueue.main.async {
                    self.announcement = announcement
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
        APIService.shared.post(model: announcement, response: announcement, endpoint: "users/\(getUserId())/announce/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.announcement = item
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
        APIService.shared.getJSON(model: announcements, urlString: "users/\(getUserId())/announce") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.announcements = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
