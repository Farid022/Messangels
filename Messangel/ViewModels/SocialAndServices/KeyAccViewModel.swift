//
//  KeyAccChoiceViewModel.swift
//  Messangel
//
//  Created by Saad on 12/14/21.
//

import Foundation

// MARK: - PrimaryEmailAcc
struct PrimaryEmailAcc: Hashable, Codable {
    var id: Int?
    var email, password, note: String
    var deleteAccount: Bool
    var user: Int

    enum CodingKeys: String, CodingKey {
        case id
        case email = "primary_email"
        case password
        case note = "manage_account_note"
        case deleteAccount = "delete_account"
        case user
    }
}

// MARK: - PrimaryPhone
struct PrimaryPhone: Hashable, Codable {
    var id: Int?
    var name, phoneNum, pincode, deviceUnlockCode: String
    var user: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name = "smartphone_name"
        case phoneNum = "phone_num"
        case pincode = "smartphone_pincode"
        case deviceUnlockCode = "device_unlock_code"
        case user
    }
}

// MARK: - ViewModel
class KeyAccViewModel: ObservableObject {
    @Published var keyAccounts = [PrimaryEmailAcc]()
    @Published var smartphones = [PrimaryPhone]()
    @Published var keyEmailAcc = PrimaryEmailAcc(email: "", password: "", note: "", deleteAccount: false, user: getUserId())
    @Published var keySmartPhone = PrimaryPhone(name: "", phoneNum: "", pincode: "", deviceUnlockCode: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")

    
    func addPrimaryEmailAcc(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: keyEmailAcc, response: apiResponse, endpoint: "users/\(getUserId())/mail_reg_key") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.apiResponse = response
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
    
    func addPrimaryPhone(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: keySmartPhone, response: apiResponse, endpoint: "users/\(getUserId())/smartphone_reg_key") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.apiResponse = response
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
    
    func getKeyAccounts(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: keyAccounts, urlString: "users/\(getUserId())/mail_reg_key") { result in
            switch result {
            case .success(let accounts):
                DispatchQueue.main.async {
                    self.keyAccounts = accounts
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func getKeyPhones() {
        APIService.shared.getJSON(model: smartphones, urlString: "users/\(getUserId())/smartphone_reg_key") { result in
            switch result {
            case .success(let phones):
                DispatchQueue.main.async {
                    self.smartphones = phones
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: -

enum KeyAccChoice: CaseIterable {
    case none
    case remove
    case manage
}

enum KeyAccCase {
    case register
    case manage
    case addEmail
    case addPhone
    case modifyEmail
    case modifyPhone
    case delEmail
    case delPhone
}

class AccStateViewModel: ObservableObject {
    @Published var showSuccessScreen = false
    @Published var showAddAccScreen = false
    @Published var keyAccRegistered = false
    @Published var keyAccCase: KeyAccCase = .register
}

