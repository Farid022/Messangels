//
//  CodePractiveViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct CodePractive: Codable {
    var id: Int?
    var name: String
    var codes: [Int]
    var note: String
    var user: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "code_name"
        case codes = "code"
        case note, user
    }
}

struct CodePractiveDetail: Hashable, Codable {
    var id: Int
    var name: String
    var codes: [CodeModel]
    var note: String
    var user: User
    var assign_user : [User]?
    enum CodingKeys: String, CodingKey {
        case id
        case name = "code_name"
        case codes = "code"
        case note, user, assign_user
    }
}

struct Code: Hashable, Codable {
    var id: Int?
    var code: String
    var user: Int
    var assign_user : [User]?
}

class CodePractiveViewModel: ObservableObject {
    @Published var codes = [Code]()
    @Published var code = Code(code: "", user: getUserId())
    @Published var codesPractive = [CodePractiveDetail]()
    @Published var codePractive = CodePractive(name: "", codes: [Int](), note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createPracticalCode(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: codePractive, response: codePractive, endpoint: "users/\(getUserId())/practical_code") { result in
            switch result {
            case .success(let code):
                DispatchQueue.main.async {
                    self.codePractive = code
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
    
    func getPracticalCodes(success: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: codesPractive, urlString: "users/\(getUserId())/practical_code") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.codesPractive = items
                    success(true)
                }
            case .failure(let error):
                print(error)
                success(false)
            }
        }
    }
    
    func addCode(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: code, response: code, endpoint: "users/\(getUserId())/code") { result in
            switch result {
            case .success(let code):
                DispatchQueue.main.async {
                    self.code = code
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
    
    func getCodes(success: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: codes, urlString: "users/\(getUserId())/code") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.codes = items
                    success(true)
                }
            case .failure(let error):
                print(error)
                success(false)
            }
        }
    }
}
