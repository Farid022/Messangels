//
//  FuneralSpritualityViewModel.swift
//  Messangel
//
//  Created by Saad on 1/6/22.
//

import Foundation

enum SpiritualType: Int, CaseIterable {
    case none
    case non_religious
    case religious
}

struct FuneralSprituality: Codable {
    var spritual_ceremony: Int
    var ceremony_note: String
    var user = getUserId()
}

struct FuneralSpritualityData: Codable {
    var id: Int
    var spritual_ceremony: FuneralIntity
    var spritual_ceremony_note: String
    var ceremony_note: String
    var user: User
}

class FuneralSpritualityViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var spritualities = [FuneralSpritualityData]()
    @Published var sprituality = FuneralSprituality(spritual_ceremony: 0, ceremony_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createSprituality(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: sprituality, response: sprituality, endpoint: "users/\(getUserId())/sprituality") { result in
            switch result {
            case .success(let sprituality):
                DispatchQueue.main.async {
                    self.sprituality = sprituality
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
        APIService.shared.post(model: sprituality, response: sprituality, endpoint: "users/\(getUserId())/sprituality/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.sprituality = item
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
        APIService.shared.getJSON(model: spritualities, urlString: "users/\(getUserId())/sprituality") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.spritualities = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
