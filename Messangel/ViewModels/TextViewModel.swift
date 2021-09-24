//
//  TextViewModel.swift
//  Messangel
//
//  Created by Saad on 7/29/21.
//

import Foundation

struct MsgText: Codable, Hashable {
    var id: Int
    var name: String
    var message: String
    var size: String?
    var group: Int
    var created_at: String?
}

class TextViewModel: ObservableObject {
    @Published var text = MsgText(id: 0, name: "", message: "", size: "", group: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    @Published var uploadResponse = UploadResponse(files: [UploadedFile]())
    
    func create(completion: @escaping () -> Void) {
        APIService.shared.post(model: text, response: text, endpoint: "mon-messages/text") { result in
            switch result {
            case .success(let text):
                DispatchQueue.main.async {
                    self.text = text
                    completion()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    self.apiError = error
                    completion()
                }
            }
        }
    }
}
