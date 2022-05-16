//
//  DocumentViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Document: Codable {
    var document_name: String
    var document_note: String
    var user: Int
}

struct DocumentUpload: Hashable, Codable {
    let id: Int
    let user: User
    let name, note: String
    var assign_user : [User]?

    enum CodingKeys: String, CodingKey {
        case id, user, assign_user
        case name = "document_name"
        case note = "document_note"
    }
}

class DocumentViewModel: ObservableObject {
    @Published var documentUpload = [DocumentUpload]()
    @Published var document = Document(document_name: "", document_note: "", user:0 )
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: document, response: document, endpoint: "users/\(getUserId())/administrative_doc") { result in
            switch result {
            case .success(let doc):
                DispatchQueue.main.async {
                    self.document = doc
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
        APIService.shared.getJSON(model: documentUpload, urlString: "users/\(getUserId())/administrative_doc") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.documentUpload = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
