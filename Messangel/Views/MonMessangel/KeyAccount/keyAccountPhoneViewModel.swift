//
//  keyAccountPhoneViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import Foundation


struct otpItem: Hashable, Codable {
    var otp: String?
   

 
}

struct passwordItem: Hashable, Codable {
    var password: String?

}

struct messageItem: Hashable, Codable {
    var message: String?

}

class keyAccountVerficationViewModel: ObservableObject {


    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func verifyOTP(otp : String, completion: @escaping (Bool) -> Void) {
        
        
        APIService.shared.post(model: otpItem(otp: otp), response: messageItem(), endpoint: "users/\(getUserId())/accessotp") { result in
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
    
    func verifyPassword(password: String,completion: @escaping (Bool) -> Void) {
        
        
        APIService.shared.post(model: passwordItem(password: password), response: messageItem(), endpoint: "users/\(getUserId())/access") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.message == "1"
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
    
    
    
   
}
