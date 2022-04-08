//
//  categoryDetailViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import Foundation

struct smartPhoneAccount: Hashable, Codable
{
    var id: Int?
    var is_deleted: Bool?
    var smartphone_name: String?
    var phone_num: String?
    var smartphone_pincode: String?
    var device_unlock_code: String?
    var user: Int?
}

struct mailAccount: Hashable, Codable
{
    var id: Int?
    var is_deleted: Bool?
    var primary_email: String?
    var password: String?
    var delete_account: Bool?
    var manage_account_note: String?
    var user: Int?
}
struct onlineService: Hashable, Codable
{
    var id: Int?
    var is_deleted: Bool?
    var name: String?
    var url: String?
    var type: String?
    var user: Int?
    var category: Int?
}

struct accountField: Hashable, Codable
{
    var id: Int?
    var is_deleted: Bool?
    var delete_account: Bool?
    var manage_account_note: String?
    var last_post_note:String?
    var leave_msg_time:String?
    var online_service: onlineService?
    var mail_account: mailAccount?
    var smartphone_account: smartPhoneAccount?
}


struct categoryDetailItem: Hashable, Codable {
    var id: Int?
    var user: User?
    var assign_user: [User]?
    var last_post_image:String?
    var last_post_note:String?
    var leave_msg_time:String?
    var memorial_account:Bool?
    var account_fields: accountField?
    
    
}



class CategoryDetailViewModel: ObservableObject {
    @Published var categories = [categoryDetailItem()]
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func verifyOTP(categoryID: Int?,completion: @escaping (Bool) -> Void) {
//
//        APIService.shared.post(model: categories, response: messageItem(), endpoint: "users/\(getUserId())/category/\(categoryID)/account") { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    if data.message == "Password Matched"
//                    {
//                        completion(true)
//                    }
//                    else
//                    {
//                        completion(false)
//                    }
//
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    print(error.error_description)
//                    self.apiError = error
//                    completion(false)
//                }
//            }
//        }
    }
    
    func getCategoryDetail(categoryID: Int)
    {
        APIService.shared.getJSON(model: categories, urlString:"users/\(getUserId())/category/\(categoryID)/account") { result in
         
                switch result {
                case .success(let category):
                DispatchQueue.main.async {
                    self.categories = category
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
   
}
