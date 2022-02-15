//
//  ExtraWishesViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct ExtraWish: Codable {
    var express_yourself_note: String
    var user: Int
}

struct ExtraWishData: Hashable, Codable {
    var id: Int
    var express_yourself_note: String
    var user: User
}

class ExtraWishViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var extraWishes = [ExtraWishData]()
    @Published var extraWish = ExtraWish(express_yourself_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: extraWish, response: extraWish, endpoint: "users/\(getUserId())/free_expression") { result in
            switch result {
            case .success(let extraWish):
                DispatchQueue.main.async {
                    self.extraWish = extraWish
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
        APIService.shared.post(model: extraWish, response: extraWish, endpoint: "users/\(getUserId())/free_expression/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.extraWish = item
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
        APIService.shared.getJSON(model: extraWishes, urlString: "users/\(getUserId())/free_expression") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.extraWishes = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
