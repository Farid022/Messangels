//
//  PracticalCodeViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct PracticalCode: Codable {
    var code_name: String
    var code: [Int]
    var user: Int
}

class PracticalCodeViewModel: ObservableObject {
    @Published var practicalCode = PracticalCode(code_name: "", code: [Int](), user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: practicalCode, response: practicalCode, endpoint: "users/\(getUserId())/practical_code") { result in
            switch result {
            case .success(let code):
                DispatchQueue.main.async {
                    self.practicalCode = code
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
