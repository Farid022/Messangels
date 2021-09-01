//
//  GroupViewModel.swift
//  Messangel
//
//  Created by Saad on 7/29/21.
//

import Foundation

struct MsgGroup: Codable, Hashable {
    var id: Int
//    var is_deleted: Bool?
//    var created_at: String?
//    var updated_at: String?
    var name: String
    var user: Int
    var permission: String
    var group_contacts: [Int]?
    var texts: [MsgText]?
    var audios: [MsgAudio]?
    var videos: [MsgVideo]?
    var galleries: [MsgGallery]?
}

class GroupViewModel: ObservableObject {
    @Published var group = MsgGroup(id: 0, name: "", user: 0, permission: "1")
    @Published var groups = [MsgGroup]()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: group, response: group, endpoint: "mon-messages/group") { result in
            switch result {
            case .success(let group):
                DispatchQueue.main.async {
                    self.group = group
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
    
    func getAll(userId: Int) {
        APIService.shared.getJSON(model: groups, urlString: "mon-messages/group/\(userId)") { result in
            switch result {
            case .success(let groups):
                DispatchQueue.main.async {
                    self.groups = groups
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
