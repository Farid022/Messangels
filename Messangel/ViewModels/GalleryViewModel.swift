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

class GalleryViewModel: ObservableObject {
    @Published var gallery = MsgGallery(id: 0, image_link: "", group: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
}
