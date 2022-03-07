//
//  WishesListViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct WishList: Codable {
    var express_yourself_note: String
    var user: Int
}

class WishesListViewModel: ObservableObject {
    @Published var wishlist = WishList(express_yourself_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: wishlist, response: wishlist, endpoint: "users/\(getUserId())/free_expression") { result in
            switch result {
            case .success(let extraWish):
                DispatchQueue.main.async {
                    self.wishlist = extraWish
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
