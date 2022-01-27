//
//  AdminDocViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct AdminDocLocal: Codable {
    var document_name: String
    var document_note: String
    var user: Int
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
    @Published var adminDocs = [AdminDocServer]()
    @Published var adminDoc = AdminDocLocal(document_name: "", document_note: "", user:0 )
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
    
    func getAll() {
        APIService.shared.getJSON(model: adminDocs, urlString: "users/\(getUserId())/administrative_doc") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.adminDocs = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
