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

class VolontesViewModel: ObservableObject {
    @Published var tabs = [VolontesTab]()
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

