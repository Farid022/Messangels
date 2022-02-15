//
//  FuneralLocationViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

enum FuneralRestPlace: Int, CaseIterable {
    case none
    case funeral_place
    case residence
}

struct BuryLocation: Hashable, Codable {
    var id: Int
    var name: String
}

struct FuneralLocation: Codable {
    var location_of_ceremony: Bool
    var location_of_ceremony_note: String?
    var route_convey_note: String?
    var reunion_location_note: String?
    var special_ceremony_note: String?
    var bury_location: Int?
    var resting_place: Int?
    var user = getUserId()
}

struct FuneralLocationData: Codable {
    var id: Int
    var location_of_ceremony: Bool
    var location_of_ceremony_note: String?
    var route_convey_note: String?
    var reunion_location_note: String?
    var special_ceremony_note: String?
    var bury_location: BuryLocation
    var resting_place: FuneralIntity
    var user: User
}

class FuneralLocationViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var buryLocations = [BuryLocation]()
    @Published var locations = [FuneralLocationData]()
    @Published var location = FuneralLocation(location_of_ceremony: false)
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
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: location, response: location, endpoint: "users/\(getUserId())/premises/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.location = item
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
        APIService.shared.getJSON(model: locations, urlString: "users/\(getUserId())/premises") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.locations = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
