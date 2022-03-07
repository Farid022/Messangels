//
//  SpiritualiteViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

enum SpiritualiteType: Int, CaseIterable {
    case none
    case non_religious
    case religious
}

struct FuneralSpiritualite: Codable {
    var spritual_ceremony: Int
    var ceremony_note: String
    var user: Int
}

class SpiritualiteViewModel: ObservableObject {
    @Published var spiritualite = FuneralSpiritualite(spritual_ceremony: 0, ceremony_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createSprituality(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: spiritualite, response: spiritualite, endpoint: "users/\(getUserId())/sprituality") { result in
            switch result {
            case .success(let sprituality):
                DispatchQueue.main.async {
                    self.spiritualite = sprituality
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
