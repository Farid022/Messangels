//
//  FuneralChoicesViewModel.swift
//  Messangel
//
//  Created by Saad on 10/21/21.
//

import Foundation

enum FuneralBool: CaseIterable {
    case none
    case yes
    case no
}

enum ClothsDonationType: CaseIterable {
    case none
    case single
    case multiple
}

enum ClothsDonationPlace: CaseIterable {
    case none
    case contact
    case organization
}



enum FuneralType: Int, CaseIterable {
    case none
    case burial
    case crematization
}

struct FuneralCoice: Hashable {
    var id: Int
    var name: String
    var image: String
}

struct Funeral: Codable {
    var place_burial_note: String
    var handle_note: String
    var religious_sign_note: String
    var outfit_note: String
    var acessories_note: String
    var deposite_ashes_note: String
    var burial_type: Int
    var coffin_material: Int
    var coffin_finish: Int
    var internal_material: Int
    var urn_material: Int?
    var urn_style: Int?
    var user: Int
}

class FeneralViewModel: ObservableObject {
    @Published var funeral = Funeral(place_burial_note: "", handle_note: "", religious_sign_note: "", outfit_note: "", acessories_note: "", deposite_ashes_note: "", burial_type: 0, coffin_material: 0, coffin_finish: 0, internal_material: 0, user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: funeral, response: funeral, endpoint: "users/\(getUserId())/funeral") { result in
            switch result {
            case .success(let funeral):
                DispatchQueue.main.async {
                    self.funeral = funeral
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
