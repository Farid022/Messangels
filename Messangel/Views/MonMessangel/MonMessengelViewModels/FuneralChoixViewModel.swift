//
//  FuneralChoixViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation
import SwiftUI







struct FuneralItem: Hashable, Codable {
    var id: Int
    var name: String
    var image: String?
    
}



struct FuneralChoix: Hashable,Codable {
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

struct FuneralChoixDetail: Hashable,Codable {
    var id: Int
    var placeBurialNote: String
    var handleNote: String
    var religiousSignNote: String
    var outfitNote: String
    var acessoriesNote: String
    var depositeAshesNote: String
    var burialType: FuneralItem?
    var coffinMaterial: FuneralItem
    var coffinFinish: FuneralItem
    var internalMaterial: FuneralItem?
    var urnMaterial: FuneralItem
    var urnStyle: FuneralItem
    var burial_type_note: String?
    var coffin_material_note: String?
    var coffin_finish_note: String?
    var urn_material_note: String?
    var urn_style_note: String?
    var assign_user : [User]?
    

    enum CodingKeys: String, CodingKey {
        case id
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
        case burial_type_note
        case coffin_material_note
        case coffin_finish_note
        case urn_material_note
        case urn_style_note
        case assign_user
    }
}

class FuneralChoixViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var funeralChoixes = [FuneralChoixDetail]()
    @Published var funeral = FuneralChoixDetail(id: 0, placeBurialNote: "", handleNote: "", religiousSignNote: "", outfitNote: "", acessoriesNote: "", depositeAshesNote: "", burialType: FuneralItem(id: 0, name: "", image: ""), coffinMaterial: FuneralItem(id: 0, name: "", image: ""), coffinFinish: FuneralItem(id: 0, name: "", image: ""), internalMaterial: FuneralItem(id: 0, name: "", image: ""), urnMaterial: FuneralItem(id: 0, name: "", image: ""), urnStyle: FuneralItem(id: 0, name: "", image: ""))
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getFuneralChoix(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: funeralChoixes, urlString: "users/\(getUserId())/funeral") { result in
            switch result {
            case .success(let funeral):
                DispatchQueue.main.async {
                    self.funeralChoixes = funeral
                    if funeral.count > 0
                    {
                        self.funeral = funeral[0]
                    }
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
        APIService.shared.getJSON(model: funeralChoixes, urlString: "users/\(getUserId())/funeral") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.funeralChoixes = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
