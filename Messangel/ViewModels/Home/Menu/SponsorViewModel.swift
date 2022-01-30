//
//  SponsorViewModel.swift
//  Messangel
//
//  Created by Saad on 7/28/21.
//

import Foundation

struct Sponsor: Codable {
    var first_name: String
    var last_name: String
    var email: String
    var user: Int
}

class SponsorViewModel: ObservableObject {
    @Published var sponsor = Sponsor(first_name: "", last_name: "", email: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func sendInvitation(completion: @escaping () -> Void) {
        APIService.shared.post(model: sponsor, response: apiResponse, endpoint: "users/invite") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.apiResponse = response
                    completion()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    self.apiError = error
                    completion()
                }
            }
        }
    }
}
