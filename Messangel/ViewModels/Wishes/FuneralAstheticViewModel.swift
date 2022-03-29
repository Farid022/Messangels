//
//  FuneralAstheticViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

struct FueneralAsthetic: Codable {
    var special_decoration_note: String
    var attendence_dress_note: String
    var guest_accessories_note: String
    var flower: Int
    var user = getUserId()
}

struct FueneralAstheticData: Codable {
    var id: Int
    var special_decoration_note: String
    var attendence_dress_note: String
    var guest_accessories_note: String
    var flower: FuneralChoice
    var user: User
}

class FueneralAstheticViewModel: CUViewModel {
    @Published var updateRecord = false
    @Published var recordId = 0
    @Published var progress = 0
    @Published var asthetics = [FueneralAstheticData]()
    @Published var asthetic = FueneralAsthetic(special_decoration_note: "", attendence_dress_note: "", guest_accessories_note: "", flower: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: asthetic, response: asthetic, endpoint: "users/\(getUserId())/asthetic") { result in
            switch result {
            case .success(let asthetic):
                DispatchQueue.main.async {
                    self.asthetic = asthetic
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
        APIService.shared.post(model: asthetic, response: asthetic, endpoint: "users/\(getUserId())/asthetic/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.asthetic = item
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
        APIService.shared.getJSON(model: asthetics, urlString: "users/\(getUserId())/asthetic") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.asthetics = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
