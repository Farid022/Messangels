//
//  DeathAnnouncementViewModel.swift
//  Messangel
//
//  Created by Saad on 1/6/22.
//

import Foundation

struct PriorityContact: Codable {
    var id : Int?
    var priority_note: String?
    var contact: [PriorityContactItem]?
    var user: User?
}

struct PriorityContactItem: Codable, Hashable {
    var id: Int?
    var first_name: String?
    var last_name:String?
    var email:String?
    var phone_number:String?
    var dob:String?
    var priority: String?
    var legal_age:Bool?
    
   
}

class PriorityContactViewModel: ObservableObject {
    @Published var priorityContacts = PriorityContact()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getPriorityContacts(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: [priorityContacts], urlString: "users/\(getUserId())/priority_contact") { result in
            switch result {
            case .success(let contacts):
                DispatchQueue.main.async {
                    if contacts.count>0
                    {
                        self.priorityContacts = contacts[0]
                    }
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

