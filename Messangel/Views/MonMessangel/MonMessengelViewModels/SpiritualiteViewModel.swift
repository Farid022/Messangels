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
    var id: Int?
    var user: User?
    var spirtual_cermony_note: String?
    var ceremony_note: String?
    var spritual_ceremony: FuneralItem?
}

class SpiritualiteViewModel: ObservableObject {
    @Published var spiritualite = FuneralSpiritualite()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getspiritualite(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: spiritualite, urlString: "users/\(getUserId())/sprituality") { result in
            switch result {
            case .success(let sprituality):
                DispatchQueue.main.async {
                    self.spiritualite = sprituality
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                  //  self.apiError = error
                    completion(false)
                }
            }
        }
    }
}
