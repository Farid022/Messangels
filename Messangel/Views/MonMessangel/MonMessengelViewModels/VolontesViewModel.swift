//
//  VolontesViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/23/22.
//

import Foundation

struct VolontesTab: Hashable, Codable {
    var id: Int
    var name: String
    var description: String
    var type: String
    var active: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case type = "types"
        case active
    }
}

struct VolontesProgress: Hashable, Codable {
    var user: Int
    var tab: Int
    var progress: Int
}

struct counterUser: Hashable, Codable {
    var id: Int?
    var user_id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var password: String?
    var phone_number: String
    var dob: String
    var city: String?
    var postal_code: String?
    var gender: String?
    var is_active: Bool?
    var image_url: String?
    var registration_date: String?
    var updated_at : String?
    var referral_code: String?
}
struct counterText: Hashable, Codable {
    var id: Int?
    var name: String?
    var size: Int?
    var email: String?
    var group: Int?
    var message: String?
    
}
struct counterAudios: Hashable, Codable {
    var id: Int?
    var name: String?
    var size: Int?
    var audio_link: String?
    var audio_image: String?
    var group: Int?
    var message: String?
    
}
struct counterVideos: Hashable, Codable {
    var id: Int?
    var name: String?
    var size: Int?
    var video_link: String?
    var audio_image: String?
    var group: Int?
    var message: String?
    
}
struct counterGalleries: Hashable, Codable {
    var id: Int?
    var name: String?
    var size: Int?
    var image_link: String?
    var audio_image: String?
    var group: Int?
    var message: String?
    
}


struct counter: Hashable, Codable {
    var id: Int?
    var name: String?
    var permission: String?
    var user: Int?
    var group_contacts: [counterUser]?
    var texts: [counterText]?
    var audios: [counterAudios]?
    var videos: [counterVideos]?
    var galleries: [counterGalleries]?
}
class VolontesViewModel: ObservableObject {
    @Published var tabs = [VolontesTab]()
    @Published var counterValue = counter()
    @Published var volontesProgresses = [VolontesProgress]()
    @Published var volontesProgress = VolontesProgress(user: getUserId(), tab: 1, progress: 100)
    @Published var apiError = APIService.APIErr(error: "", error_description: "")

    
    func getTabs() {
        APIService.shared.getJSON(model: tabs, urlString: "tabs/volontes") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.tabs = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func setProgress(_ progress: Int = 100, tab: Int, completion: @escaping (Bool) -> Void) {
        let user = getUserId()
        let model = VolontesProgress(user: user, tab: tab, progress: progress)
        APIService.shared.post(model: model, response: model, endpoint: "tabs/progress/\(user)") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    completion(false)
                }
            }
        }
    }
    
    func getProgress() {
        APIService.shared.getJSON(model: volontesProgresses, urlString: "tabs/progress/\(getUserId())") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    
                    self.volontesProgresses = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getCounts() {
        APIService.shared.getJSON(model: [counterValue], urlString: "mon-messages/group/\(getUserId())")
        { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    
                    for countVal in items
                    {
                        if countVal.id == getUserId()
                        {
                            self.counterValue = countVal
                        }
                    }
                   
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategories()
    {
        APIService.shared.getJSON(model: volontesProgresses, urlString: "users/service_category") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.volontesProgresses = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

