//
//  GalleryViewModel.swift
//  Messangel
//
//  Created by Saad on 7/29/21.
//

import Foundation

struct MsgGallery: Codable, Hashable {
    var id: Int
    var image_link: String
    var group: Int
}

struct Gallery: Codable {
    var group: Int?
    var images = [GImage]()
    var size = 100
}

//// MARK: - Gallery
//struct Gallery: Codable {
//    var group: Int
//    var images: [GImage]
//}
//
// MARK: - Image
struct GImage: Codable {
    var imageLink: String
    var size: Int

    enum CodingKeys: String, CodingKey {
        case imageLink = "image_link"
        case size
    }
}

class GalleryViewModel: ObservableObject {
    @Published var gallery = Gallery()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: gallery, response: [MsgGallery](), endpoint: "mon-messages/gallery") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
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
