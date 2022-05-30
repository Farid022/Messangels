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
    var note_attachment: [Int]?
    var note_attachments: [URL]?
    var user = getUserId()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "code_name"
        case codes = "code"
        case note, note_attachment, user
    }
}

struct PracticalCodeDetail: Hashable, Codable {
    var id: Int
    var name: String
    var codes: [CodeModel]
    var note: String
    var note_attachment: [Attachement]?
    var user: User

    enum CodingKeys: String, CodingKey {
        case id
        case name = "code_name"
        case codes = "code"
        case note, note_attachment, user
    }
}

struct CodeModel: Hashable, Codable {
    var id: Int?
    var code: String
    var user = getUserId()
}

class PracticalCodeViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var codes = [CodeModel]()
    @Published var code = CodeModel(code: "")
    @Published var practicalCodes = [PracticalCodeDetail]()
    @Published var practicalCode = PracticalCode(name: "", codes: [Int](), note: "")
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
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/code/\(id)/practical_code") { result in
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
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: practicalCode, response: practicalCode, endpoint: "users/\(getUserId())/code/\(id)/practical_code", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.practicalCode = item
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
