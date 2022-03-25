//
//  AudioViewModel.swift
//  Messangel
//
//  Created by Saad on 7/29/21.
//

import Foundation

struct MsgAudio: Codable, Hashable {
    var id: Int
    var name: String
    var audio_link: String
    var audio_image: String?
    var size: Int?
    var group: Int
    var created_at: String?
}

class AudioViewModel: ObservableObject {
    @Published var audio = MsgAudio(id: 0, name: "", audio_link: "", group: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    @Published var uploadResponse = UploadResponse(files: [UploadedFile]())
    
    func create(completion: @escaping () -> Void) {
        APIService.shared.post(model: audio, response: audio, endpoint: "mon-messages/audio") { result in
            switch result {
            case .success(let audio):
                DispatchQueue.main.async {
                    self.audio = audio
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
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: audio, response: audio, endpoint: "mon-messages/audio/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.audio = item
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
    
    func delete(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "mon-messages/audio/\(id)") { result in
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
