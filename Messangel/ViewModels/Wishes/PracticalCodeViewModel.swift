//
//  PracticalCodeViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct PracticalCode: Codable {
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

struct PracticalCodeDetail: Hashable, Codable {
    var id: Int
    var name: String
    var codes: [CodeModel]
    var note: String
    var user: User

    enum CodingKeys: String, CodingKey {
        case id
        case name = "code_name"
        case codes = "code"
        case note, user
    }
}

struct CodeModel: Hashable, Codable {
    var id: Int?
    var code: String
    var user: Int
}

class PracticalCodeViewModel: ObservableObject {
    @Published var codes = [CodeModel]()
    @Published var code = CodeModel(code: "", user: getUserId())
    @Published var practicalCodes = [PracticalCodeDetail]()
    @Published var practicalCode = PracticalCode(name: "", codes: [Int](), note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createPracticalCode(completion: @escaping (Bool) -> Void) {
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
    
    func getPracticalCodes(success: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: practicalCodes, urlString: "users/\(getUserId())/practical_code") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.practicalCodes = items
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
