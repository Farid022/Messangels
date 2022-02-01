//
//  WishesViewModel.swift
//  Messangel
//
//  Created by Saad on 2/1/22.
//

import Foundation

struct WishesTab: Hashable, Codable {
    var id: Int
    var name: String
    var description: String
    var type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case type = "types"
    }
}

struct WishesProgress: Hashable, Codable {
    var user: Int
    var tab: Int
    var progress: Int
}

class WishesViewModel: ObservableObject {
    @Published var tabs = [WishesTab]()
    @Published var wishesProgresses = [WishesProgress]()
    @Published var wishProgress = WishesProgress(user: getUserId(), tab: 1, progress: 100)
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
        let model = WishesProgress(user: user, tab: tab, progress: progress)
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
        APIService.shared.getJSON(model: wishesProgresses, urlString: "tabs/progress/\(getUserId())") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.wishesProgresses = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
