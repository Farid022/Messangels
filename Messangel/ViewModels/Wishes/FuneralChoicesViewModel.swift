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

struct FuneralChoice: Hashable, Codable {
    var id: Int
    var name: String
    var image: String
}

struct BurialType: Codable {
    var id: Int
    var name: String
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

struct FuneralChoiceDetail: Codable {
    var id: Int
    var user: User
    var placeBurialNote: String
    var handleNote: String
    var religiousSignNote: String
    var outfitNote: String
    var acessoriesNote: String
    var depositeAshesNote: String
    var burialType: BurialType
    var coffinMaterial: FuneralChoice
    var coffinFinish: FuneralChoice
    var internalMaterial: FuneralChoice
    var urnMaterial: FuneralChoice?
    var urnStyle: FuneralChoice?

    enum CodingKeys: String, CodingKey {
        case id, user
        case placeBurialNote = "place_burial_note"
        case handleNote = "handle_note"
        case religiousSignNote = "religious_sign_note"
        case outfitNote = "outfit_note"
        case acessoriesNote = "acessories_note"
        case depositeAshesNote = "deposite_ashes_note"
        case burialType = "burial_type"
        case coffinMaterial = "coffin_material"
        case coffinFinish = "coffin_finish"
        case internalMaterial = "internal_material"
        case urnMaterial = "urn_material"
        case urnStyle = "urn_style"
    }
}

class FeneralViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var funeralChoices = [FuneralChoiceDetail]()
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
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: funeral, response: funeral, endpoint: "users/\(getUserId())/funeral/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.funeral = item
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
        APIService.shared.getJSON(model: funeralChoices, urlString: "users/\(getUserId())/funeral") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.funeralChoices = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
