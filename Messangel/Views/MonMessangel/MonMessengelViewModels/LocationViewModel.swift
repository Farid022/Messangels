//
//  LocationViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

enum FuneralRestPlaceItem: Int, CaseIterable {
    case none
    case funeral_place
    case residence
}

struct BuryLocationItem: Hashable, Codable {
    var id: Int
    var name: String
}

struct FuneralLocationItem: Codable {
    var location_of_ceremony: Bool
    var route_convey_note: String?
    var reunion_location_note: String?
    var special_ceremony_note: String?
    var bury_location: Int?
    var resting_place: Int?
    var user: Int
}

class LocationViewModel: ObservableObject {
    @Published var buryLocations = [BuryLocationItem]()
    @Published var location = FuneralLocationItem(location_of_ceremony: false, user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: location, response: location, endpoint: "users/\(getUserId())/premises") { result in
            switch result {
            case .success(let location):
                DispatchQueue.main.async {
                    self.location = location
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
