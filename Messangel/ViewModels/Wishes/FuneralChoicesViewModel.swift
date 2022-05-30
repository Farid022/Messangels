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
    var place_burial_note: String?
    var place_burial_note_attachment: [Int]?
    @CodableIgnored var place_burial_note_attachments: [URL]?
    var handle_note: String?
    var handle_note_attachment: [Int]?
    @CodableIgnored var handle_note_attachments: [URL]?
    var religious_sign_note: String?
    var religious_sign_note_attachment: [Int]?
    @CodableIgnored var religious_sign_note_attachments: [URL]?
    var outfit_note: String?
    var outfit_note_attachment: [Int]?
    @CodableIgnored var outfit_note_attachments: [URL]?
    var acessories_note: String?
    var acessories_note_attachment: [Int]?
    @CodableIgnored var acessories_note_attachments: [URL]?
    var deposite_ashes_note: String?
    var deposite_ashes_note_attachment: [Int]?
    @CodableIgnored var deposite_ashes_note_attachments: [URL]?
    var burial_type: Int
    var burial_type_note: String?
    var burial_type_note_attachment: [Int]?
    @CodableIgnored var burial_type_note_attachments: [URL]?
    var coffin_material: Int?
    var coffin_material_note: String?
    var coffin_material_note_attachment: [Int]?
    @CodableIgnored var coffin_material_note_attachments: [URL]?
    var coffin_finish: Int?
    var coffin_finish_note: String?
    var coffin_finish_note_attachment: [Int]?
    @CodableIgnored var coffin_finish_note_attachments: [URL]?
    var internal_material: Int?
    var internal_material_note: String?
    var internal_material_note_attachment: [Int]?
    @CodableIgnored var internal_material_note_attachments: [URL]?
    var urn_material: Int?
    var urn_material_note: String?
    var urn_material_note_attachment: [Int]?
    @CodableIgnored var urn_material_note_attachments: [URL]?
    var urn_style: Int?
    var urn_style_note: String?
    var urn_style_note_attachment: [Int]?
    @CodableIgnored var urn_style_note_attachments: [URL]?
    var user: Int
}

struct FuneralChoiceDetail: Codable {
    var id: Int
    var user: User
    var placeBurialNote: String
    var placeBurialNoteAttachment: [Attachement]?
    var handleNote: String
    var handleNoteAttachment: [Attachement]?
    var religiousSignNote: String
    var religiousSignNoteAttachment: [Attachement]?
    var outfitNote: String
    var outfitNoteAttachment: [Attachement]?
    var acessoriesNote: String
    var acessoriesNoteAttachment: [Attachement]?
    var depositeAshesNote: String
    var depositeAshesNoteAttachment: [Attachement]?
    var burialType: BurialType
    var burialTypeNote: String?
    var burialTypeNoteAttachment: [Attachement]?
    var coffinMaterial: FuneralChoice
    var coffinMaterialNote: String?
    var coffinMaterialNoteAttachment: [Attachement]?
    var coffinFinish: FuneralChoice
    var coffinFinishNote: String?
    var coffinFinishNoteAttachment: [Attachement]?
    var internalMaterial: FuneralChoice
    var internalMaterialNote: String?
    var internalMaterialNoteAttachment: [Attachement]?
    var urnMaterial: FuneralChoice?
    var urnMaterialNote: String?
    var urnMaterialNoteAttachment: [Attachement]?
    var urnStyle: FuneralChoice?
    var urnStyleNote: String?
    var urnStyleNoteAttachment: [Attachement]?

    enum CodingKeys: String, CodingKey {
        case id, user
        case placeBurialNote = "place_burial_note"
        case placeBurialNoteAttachment = "place_burial_note_attachment"
        case handleNote = "handle_note"
        case handleNoteAttachment = "handle_note_attachment"
        case religiousSignNote = "religious_sign_note"
        case religiousSignNoteAttachment = "religious_sign_note_attachment"
        case outfitNote = "outfit_note"
        case outfitNoteAttachment = "outfit_note_attachment"
        case acessoriesNote = "acessories_note"
        case acessoriesNoteAttachment = "acessories_note_attachment"
        case depositeAshesNote = "deposite_ashes_note"
        case depositeAshesNoteAttachment = "deposite_ashes_note_attachment"
        case burialType = "burial_type"
        case burialTypeNote = "burial_type_note"
        case burialTypeNoteAttachment = "burial_type_note_attachment"
        case coffinMaterial = "coffin_material"
        case coffinMaterialNote = "coffin_material_note"
        case coffinMaterialNoteAttachment = "coffin_material_note_attachment"
        case coffinFinish = "coffin_finish"
        case coffinFinishNote = "coffin_finish_note"
        case coffinFinishNoteAttachment = "coffin_finish_note_attachment"
        case internalMaterial = "internal_material"
        case internalMaterialNote = "internal_material_note"
        case internalMaterialNoteAttachment = "internal_material_note_attachment"
        case urnMaterial = "urn_material"
        case urnMaterialNote = "urn_material_note"
        case urnMaterialNoteAttachment = "urn_material_note_attachment"
        case urnStyle = "urn_style"
        case urnStyleNote = "urn_style_note"
        case urnStyleNoteAttachment = "urn_style_note_attachment"
    }
}

protocol CUViewModel: ObservableObject {
    var updateRecord: Bool { get }
    var recordId: Int { get }
    var progress: Int { get }
    func create(completion: @escaping (Bool) -> Void)
    func update(id: Int, completion: @escaping (Bool) -> Void)
}

class FeneralViewModel: CUViewModel {
    @Published var attachements = [Attachement]()
    @Published var updateRecord = false
    @Published var recordId = 0
    @Published var progress = 0
    @Published var funeralChoices = [FuneralChoiceDetail]()
    @Published var funeral = Funeral(burial_type: 0, user: getUserId())
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
