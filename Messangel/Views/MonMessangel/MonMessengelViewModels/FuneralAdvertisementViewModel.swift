//
//  FuneralAdvertisement.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct FuneralAdvertisement: Codable {
    var invitation_photo: String?
    var invitation_note: String?
    var invitation_photo_note: String?
    var theme_note: String?
    var newspaper_note: String?
    var user: User?
}

class FuneralAdvertisementViewModel: ObservableObject {
    @Published var advertisement = FuneralAdvertisement()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getAnnounce(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: [advertisement], urlString: "users/\(getUserId())/announce", completion: { result in
            switch result {
            case .success(let announcement):
                DispatchQueue.main.async {
                    self.advertisement = announcement[0]
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                   // print(error.error_description)
                   // self.apiError = error
                    completion(false)
                }
            }
        })
    
}
}
