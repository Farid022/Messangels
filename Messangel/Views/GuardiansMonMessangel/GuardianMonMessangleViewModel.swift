//
//  GuardianMonMessangleViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 4/8/22.
//
import Foundation

struct GuardianMonMessangelData: Codable {
   
    var funeralChoice: [FuneralChoixDetail]?
    var organBodyDonation: [DonationDetail]?
    var announcements: [PriorityContact]?
    var aesthetic: [Aesthetic]?
    var music: [MusicItem]?
    var spiritualityandtraditions: [FuneralSpiritualite]?
    var dissemination: [PriorityContact]?
    var specializedBodies : [OgranismesData]?
    var premises : [PremisesItem]?
    var Objets : [ObjectListDetails]?
    var Clothesandaccessories : [ClothsList]?
    var Animals : [AnimalDetail]?
    var Donationsandcollections : [DonationDetail]?
    var freeexpression : [WishList]?
    var Administrativedocuments : [Document]?
    var Contractstomanage : [ContractUpload]?
    var Codesofpractice : [CodePractiveDetail]?
    var SequenceAddkeyaccount : [PrimaryEmailAcc]?
    var SequenceAddsmartphone : [PrimaryPhone]?
    //var newsocialnetwork : []?
    
    enum CodingKeys: String, CodingKey {
        case funeralChoice = "Choix funéraires"
        case organBodyDonation = "Don d’organes ou du corps"
        case announcements = "Announces"
        case music = "Musique"
        case aesthetic = "Esthétique"
        case spiritualityandtraditions = "Spiritualité et traditions"
        case dissemination = "Diffusion de la nouvelle"
        case specializedBodies = "Organismes spécialisés"
        case premises = "Lieux"
        case Objets = "Objets"
        case Clothesandaccessories = "Vêtements et accessoires"
        case Animals = "Animaux"
        case Donationsandcollections = "Dons et collectes"
        case freeexpression = "Expression libre"
        case Administrativedocuments = "Pièces administratives"
        case Contractstomanage = "Contrats à gérer"
        case Codesofpractice = "Codes pratiques"
        case SequenceAddkeyaccount = "Séquence Ajouter un compte-clé"
        case SequenceAddsmartphone = "Séquence Ajouter un smartphone"
            //case newsocialnetwork = "Création d’un nouveau Réseau social ou service en ligne"
    }
     
}

struct assignTaskResponse: Codable {

    var message: String?
}


struct assignTaskRequest: Codable {

    var tab_name: String?
    var death_user: Int?
    var obj_id: Int?

   

}
class GuardianMonMessangelViewModel: ObservableObject {
    @Published var data = GuardianMonMessangelData()
    
    
    func getUserGuardianData(guardianID: Int,completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: data, urlString: "users/\(getUserId())/guardian/\(guardianID)/data") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.data = data
                }
            case .failure(let error):
                print(error)
            }
            completion(true)
        }
    }
    
    @Published var assignTaskResponseObject = assignTaskResponse()
    
    func assignTask(request: assignTaskRequest,guardianID: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.patch(model: request, response: assignTaskResponseObject, endpoint: "users/\(guardianID)/assign_task") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    self.assignTaskResponseObject = org
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    
                    completion(false)
                }
            }
        }
    }
}
