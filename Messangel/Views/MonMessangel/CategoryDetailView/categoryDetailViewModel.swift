//
//  categoryDetailViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import Foundation





struct categoryDetailItem: Hashable, Codable {
    var message: String?

}

class categoryDetailViewModel: ObservableObject {

    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func verifyOTP(completion: @escaping (Bool) -> Void) {
        
        APIService.shared.post(model: otpItem(), response: messageItem(), endpoint: "users/\(getUserId())/accessotp") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.message == "Password Matched"
                    {
                        completion(true)
                    }
                    else
                    {
                        completion(false)
                    }
                   
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
    
    func getCategories()
    {
        APIService.shared.getJSON(model: otpItem(), urlString: "users/\(getUserId())/service_category") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                   // self.volontesProgresses = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
   
}
