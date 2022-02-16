//
//  AdminDocViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct AdminDocLocal: Codable {
    var id: Int?
    var document_name: String
    var document_note: String
    var user = getUserId()
}

struct AdminDocServer: Hashable, Codable {
    let id: Int
    let user: User
    let name, note: String

    enum CodingKeys: String, CodingKey {
        case id, user
        case name = "document_name"
        case note = "document_note"
    }
}

class AdminDocViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var adminDocs = [AdminDocServer]()
    @Published var adminDoc = AdminDocLocal(document_name: "", document_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: adminDoc, response: adminDoc, endpoint: "users/\(getUserId())/administrative_doc") { result in
            switch result {
            case .success(let doc):
                DispatchQueue.main.async {
                    self.adminDoc = doc
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
    
    func getAll(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: adminDocs, urlString: "users/\(getUserId())/administrative_doc") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.adminDocs = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/doc/\(id)/administrative_doc") { result in
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
        APIService.shared.post(model: adminDoc, response: adminDoc, endpoint: "users/\(getUserId())/doc/\(id)/administrative_doc", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.adminDoc = item
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
