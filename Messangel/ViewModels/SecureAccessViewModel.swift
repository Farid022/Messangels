//
//  SecureAccessViewModel.swift
//  Messangel
//
//  Created by Saad on 1/25/22.
//

import Foundation

struct AccessPassword : Codable{
    var password: String
}

struct AccessOTP : Codable{
    var otp: Int
}

class SecureAccessViewModel: ObservableObject {
    @Published var password = AccessPassword(password: "")
    @Published var otp = AccessOTP(otp: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func authPassword(completion: @escaping () -> Void) {
        APIService.shared.post(model: password, response: apiResponse, endpoint: "users/\(getUserId())/access") { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self.apiResponse = res
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
    
    func authOTP(completion: @escaping () -> Void) {
        APIService.shared.post(model: otp, response: apiResponse, endpoint: "users/\(getUserId())/accessotp") { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self.apiResponse = res
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
