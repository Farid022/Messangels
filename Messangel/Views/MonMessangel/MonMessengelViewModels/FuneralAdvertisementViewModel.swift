//
//  FuneralAdvertisement.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct FuneralAdvertisement: Codable {
    var invitation_photo: String
    var invitation_note: String
    var invitation_photo_note: String?
    var theme_note: String
    var newspaper_note: String
    var user: User?
}

class FuneralAdvertisementViewModel: ObservableObject {
    @Published var advertisement = FuneralAdvertisement(invitation_photo: "", invitation_note: "", theme_note: "", newspaper_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getAnnounce(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: advertisement, response: advertisement, endpoint: "users/\(getUserId())/announce") { result in
            switch result {
            case .success(let announcement):
                DispatchQueue.main.async {
                    self.advertisement = announcement
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
