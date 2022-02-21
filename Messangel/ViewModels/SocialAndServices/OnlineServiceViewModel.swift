//
//  SocialAndServicesViewModel.swift
//  Messangel
//
//  Created by Saad on 1/19/22.
//

import Foundation
import UIKit

struct ServiceCategory: Hashable, Codable {
    var id: Int
    var name: String
}

struct OnlineService: Hashable, Codable {
    var id: Int?
    var name: String
    var url: String
    var type: String
    var user = getUserId()
    var category: Int?
}

struct ServiceAccountFields: Codable {
    var id: Int?
    var onlineService: Int
    var mailAccount: Int
    var smartphone: Int
    var deleteAccount: Bool?
    var manageAccountNote: String?

    enum CodingKeys: String, CodingKey {
        case id
        case onlineService = "online_service"
        case mailAccount = "mail_account"
        case smartphone = "smartphone_account"
        case deleteAccount = "delete_account"
        case manageAccountNote = "manage_account_note"
    }
}

struct ServiceAccountFieldsDetail: Hashable, Codable {
    var id: Int
    var onlineService: OnlineService
    var mailAccount: PrimaryEmailAcc
    var smartphone: PrimaryPhone
    var deleteAccount: Bool
    var manageAccountNote: String

    enum CodingKeys: String, CodingKey {
        case id
        case deleteAccount = "delete_account"
        case manageAccountNote = "manage_account_note"
        case onlineService = "online_service"
        case mailAccount = "mail_account"
        case smartphone = "smartphone_account"
    }
}

struct OnlineServiceAccount: Codable {
    var id: Int?
    var accountId: Int
    var lastPostNote: String?
    var lastPostImage: String?
    var lastPostImageNote: String?
    var leaveMsgTime: String?
    var memorialAccount: Bool?
    var user = getUserId()

    enum CodingKeys: String, CodingKey {
        case accountId = "account_fields"
        case lastPostNote = "last_post_note"
        case lastPostImage = "last_post_image"
        case lastPostImageNote = "last_post_image_note"
        case leaveMsgTime = "leave_msg_time"
        case memorialAccount = "memorial_account"
        case user
    }
}

// MARK: - OnlineAccountDetail
struct OnlineServiceAccountDetail: Hashable, Codable {
    var id: Int
    var user: User
    var lastPostImage: String?
    var lastPostImageNote: String?
    var lastPostNote, leaveMsgTime: String?
    var memorialAccount: Bool?
    var accountFields: ServiceAccountFieldsDetail

    enum CodingKeys: String, CodingKey {
        case id, user
        case lastPostImage = "last_post_image"
        case lastPostImageNote = "last_post_image_note"
        case lastPostNote = "last_post_note"
        case leaveMsgTime = "leave_msg_time"
        case memorialAccount = "memorial_account"
        case accountFields = "account_fields"
    }
}


// MARK: - View Model
class OnlineServiceViewModel: ObservableObject {
    @Published var socialAccPic = UIImage()
    @Published var updateRecord = false
    @Published var categories = [ServiceCategory]()
    @Published var account = OnlineServiceAccount(accountId: 0)
    @Published var accounts = [OnlineServiceAccountDetail]()
    @Published var accountFields = ServiceAccountFields(onlineService: 0, mailAccount: 0, smartphone: 0)
    @Published var services = [OnlineService]()
    @Published var service = OnlineService(name: "", url: "", type: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func addService(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: service, response: service, endpoint: "users/\(getUserId())/online_service") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.service = response
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
    
    func getCategories() {
        APIService.shared.getJSON(model: categories, urlString: "users/service_category") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.categories = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getServices() {
        APIService.shared.getJSON(model: services, urlString: "users/\(getUserId())/services") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.services = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addAccountFields(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: accountFields, response: accountFields, endpoint: "users/\(getUserId())/account_field") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.accountFields = response
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
    
    func addAccount(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: account, response: account, endpoint: "users/\(getUserId())/account\(updateRecord ? "/\(account.id ?? 0)" : "")", method: "\(updateRecord ? "PUT" : "POST")") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.account = response
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
    
    func getAccounts(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: accounts, urlString: "users/\(getUserId())/account") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.accounts = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/account/\(id)") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
