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

struct mailAssociation: Hashable, Codable
{
    var id: Int?
    var primary_email: String?
    var password: String?
    var manage_account_note: String?
    var associated_account: Int?
    var delete_account: Bool?
    var user: Int?
    
}


struct phoneAssociation: Hashable, Codable
{
    var id: Int?
    var smartphone_name: String?
    var phone_num: String?
    var smartphone_pincode: String?
    var device_unlock_code: String?
    var associated_account: Int?
    var delete_account: Bool?
    var user: Int?
    
}

class keyAccountVerficationViewModel: ObservableObject {

    @Published var mailAssociations = [mailAssociation()]
    @Published var phoneAssociations = [phoneAssociation()]
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
    
    
    func emailRegAssociated()
    {
        APIService.shared.getJSON(model: mailAssociations, urlString:"users/\(getUserId())/mail_reg_associated") { result in
         
                switch result {
                case .success(let mailAssociations):
                DispatchQueue.main.async {
                    self.mailAssociations = mailAssociations
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func phoneRegAssociated()
    {
        APIService.shared.getJSON(model: mailAssociations, urlString:"users/\(getUserId())/smartphone_reg_associated") { result in
         
                switch result {
                case .success(let mailAssociations):
                DispatchQueue.main.async {
                    self.mailAssociations = mailAssociations
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
   
}
