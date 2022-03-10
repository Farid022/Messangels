//
//  PremisesViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/10/22.
//

import Foundation

struct PremisesItem: Hashable, Codable {
    var id: Int?
    var user: User?
    var location_of_ceremony: Bool?
    var location_of_ceremony_note: String?
    var route_convey_note: String?
    var reunion_location_note: String?
    var special_ceremony_note: String?
    var bury_location_note: String?
    var resting_place_note: String?
    var bury_location: FuneralItem?
    var resting_place: FuneralItem?
 
}

class PremisesViewModel: ObservableObject {
    @Published var newPremises = PremisesItem()
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getPremises(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: [newPremises], urlString: "users/\(getUserId())/premises") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.count > 0
                    {
                        self.newPremises = data[0]
                    }
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
}
