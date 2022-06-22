//
//  GroupViewModel.swift
//  Messangel
//
//  Created by Saad on 7/29/21.
//

import Foundation

struct MsgGroup: Codable, Hashable {
    var id: Int?
    var name: String
    var user = getUserId()
    var permission = "1"
    var group_contacts: [Int]?
    var texts: [MsgText]?
    var audios: [MsgAudio]?
    var videos: [MsgVideo]?
    var galleries: [MsgGallery]?
}

struct MsgGroupDetail: Codable, Hashable {
    var id: Int
    var name: String
    var user: Int
    var permission: String
    var group_contacts: [Contact]?
    var texts: [MsgText]?
    var audios: [MsgAudio]?
    var videos: [MsgVideo]?
    var galleries: [MsgGallery]?
}

struct ContactMsgGroup: Codable, Hashable {
    var id: Int
    var name: String
    var user: [User]
    var permission: String
    var group_contacts: [Contact]?
    var texts: [MsgText]?
    var audios: [MsgAudio]?
    var videos: [MsgVideo]?
    var galleries: [MsgGallery]?
}

class GroupViewModel: ObservableObject {
    @Published var groupContacts = [Contact]()
    @Published var group = MsgGroup(name: "")
    @Published var groups = [MsgGroupDetail]()
    @Published var contactGroups = [ContactMsgGroup]()
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
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: group, response: group, endpoint: "mon-messages/group_crud/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.group = item
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
        APIService.shared.getJSON(model: groups, urlString: "mon-messages/group/\(getUserId())") { result in
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
    
    func getContactGroups(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: contactGroups, urlString: "contact-messages/group/\(getUserId())") { result in
            switch result {
            case .success(let groups):
                DispatchQueue.main.async {
                    self.contactGroups = groups
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
