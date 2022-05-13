//
//  AestheticViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Aesthetic: Hashable,Codable {
    var id: Int?
    var special_decoration_note: String?
    var attendence_dress_note: String?
    var guest_accessories_note: String?
    var flower_note: String?
    var assign_user : [assignUser]?
    var user: User?
    var flower: Flower?
}

struct Flower: Hashable,Codable
{
    var id: Int?
    var is_deleted: Bool?
    var name: String?
    var image: String?
    
    
}

class AestheticViewModel: ObservableObject {
    @Published var asthetic = [Aesthetic()]
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getAesthetic(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: asthetic, urlString: "users/\(getUserId())/asthetic") { result in
            switch result {
            case .success(let asthetic):
                DispatchQueue.main.async {
                    self.asthetic = asthetic
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                  //  self.apiError = error
                    completion(false)
                }
            }
        }
    }
}
