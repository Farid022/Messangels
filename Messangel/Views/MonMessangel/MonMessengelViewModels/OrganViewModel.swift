//
//  OrganViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

enum OrganChoix: Int, CaseIterable {
    case none
    case organs
    case deny
    case body
}

struct OrganItem: Codable {
    var register_to_national: Bool?
    var donation: Int
    var user: Int
}

class OrganViewModel: ObservableObject {
    @Published var organ = OrganItem(donation: 0, user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: organ, response: organ, endpoint: "users/\(getUserId())/organ_donation") { result in
            switch result {
            case .success(let organ_donation):
                DispatchQueue.main.async {
                    self.organ = organ_donation
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
