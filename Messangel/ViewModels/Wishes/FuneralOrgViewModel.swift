//
//  FuneralOrgViewModel.swift
//  Messangel
//
//  Created by Saad on 1/4/22.
//

import Foundation

struct FuneralCompany: Hashable, Codable {
    var id: Int
    var name: String
}


struct FuneralOrg: Codable {
    var chose_funeral_home: Bool
    var funeral_company: Int
    var funeral_company_note: String
    var company_contact_detail: Bool
    var company_contact_num: String
    var have_funeral_contact: Int
    var user: Int
}

class FuneralOrgViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var funeralCompanies = [FuneralCompany]()
    @Published var funeralOrg = FuneralOrg(chose_funeral_home: true, funeral_company: 0, funeral_company_note: "", company_contact_detail: true, company_contact_num: "", have_funeral_contact: 0, user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: funeralOrg, response: funeralOrg, endpoint: "users/\(getUserId())/organization") { result in
            switch result {
            case .success(let funeralOrg):
                DispatchQueue.main.async {
                    self.funeralOrg = funeralOrg
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
    
    func getCompanies() {
        APIService.shared.getJSON(model: funeralCompanies, urlString: "users/\(getUserId())/funeral_company") { result in
            switch result {
            case .success(let companies):
                DispatchQueue.main.async {
                    self.funeralCompanies = companies
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: funeralOrg, response: funeralOrg, endpoint: "users/\(getUserId())/organization/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.funeralOrg = item
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
    
//    func get(completion: @escaping (Bool) -> Void) {
//        APIService.shared.getJSON(model: funeralChoices, urlString: "users/\(getUserId())/organization") { result in
//            switch result {
//            case .success(let items):
//                DispatchQueue.main.async {
//                    self.funeralChoices = items
//                    completion(true)
//                }
//            case .failure(let error):
//                print(error)
//                completion(false)
//            }
//        }
//    }
}
