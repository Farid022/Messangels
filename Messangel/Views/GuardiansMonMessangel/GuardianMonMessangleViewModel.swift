//
//  GuardianMonMessangleViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 4/8/22.
//
import Foundation

struct GuardianMonMessangelData: Codable {
   
    var Choix_funéraires: [FuneralChoixDetail]?
    var Don_dorganes_ou_du_corps: [DonationDetail]?
    
    var Esthétique: [Aesthetic]?
    var Musique: [MusicItem]?
    var Spiritualité_et_traditions: [FuneralSpiritualite]?
    var Diffusion_de_la_nouvelle: [PriorityContact]?
    var Organismes_spécialisés : [OgranismesData]?
    var Lieux : [PremisesItem]?
    var Objets : [ObjectListDetails]?
    var Vêtements_et_accessoires : [ClothsList]?
    var Animaux : [AnimalDetail]?
    var Dons_et_collectes : [DonationDetail]?
     
}


class GuardianMonMessangelViewModel: ObservableObject {
    @Published var data = GuardianMonMessangelData()
    
    
    func getDeathUserData(guardianID: Int,completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: [String: Any], urlString: "users/\(getUserId())/guardian/\(guardianID)/data") { result in
            switch result {
            case .success(let deaths):
                DispatchQueue.main.async {
                    self.deaths = deaths
                }
            case .failure(let error):
                print(error)
            }
            completion(true)
        }
    }

}
