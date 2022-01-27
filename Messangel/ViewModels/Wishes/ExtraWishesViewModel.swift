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

class ExtraWishViewModel: ObservableObject {
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
}
