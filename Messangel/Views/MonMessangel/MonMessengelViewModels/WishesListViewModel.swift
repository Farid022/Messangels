//
//  WishesListViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct WishList: Codable {
    var id: Int
    var express_yourself_note: String
    var assign_user : [User]?

}

class WishesListViewModel: ObservableObject {
    @Published var wishlist = WishList(id: 0, express_yourself_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getExpressions(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: [wishlist], urlString: "users/\(getUserId())/free_expression") { result in
            switch result {
            case .success(let extraWish):
                DispatchQueue.main.async {
                    if extraWish.count > 0
                    {
                        self.wishlist = extraWish[0]
                    }
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                        //  self.apiError = error
                    completion(false)
                }
            }
        }
    }
}
