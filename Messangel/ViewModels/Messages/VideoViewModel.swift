//
//  VideoViewModel.swift
//  Messangel
//
//  Created by Saad on 7/29/21.
//

import Foundation

struct MsgVideo: Codable, Hashable {
    var id: Int
    var name: String
    var video_link: String
    var size: String?
    var group: Int
    var created_at: String?
}

class VideoViewModel: ObservableObject {
    @Published var video = MsgVideo(id: 0, name: "", video_link: "", group: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    @Published var uploadResponse = UploadResponse(files: [UploadedFile]())
    
    func create(completion: @escaping () -> Void) {
        APIService.shared.post(model: video, response: video, endpoint: "mon-messages/video") { result in
            switch result {
            case .success(let video):
                DispatchQueue.main.async {
                    self.video = video
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
