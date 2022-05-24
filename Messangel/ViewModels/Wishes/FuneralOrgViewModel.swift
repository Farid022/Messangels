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

struct FuneralContract: Hashable, Codable {
    var id: Int?
    var hasFuneralContract: Bool?
    var funeralContractNote: String?
    var funeralLinkedCompanyNote: String?
    var linkedCompanyContractNote: String?
    var funeralLinkedCompany: FuneralCompany?

    enum CodingKeys: String, CodingKey {
        case id
        case hasFuneralContract = "has_funeral_contract"
        case funeralContractNote = "funeral_contract_note"
        case funeralLinkedCompanyNote = "funeral_linked_company_note"
        case linkedCompanyContractNote = "linked_company_contract_note"
        case funeralLinkedCompany = "funeral_linked_company"
    }
}


struct FuneralOrg: Codable {
    var chose_funeral_home: Bool?
    var chose_funeral_home_note: String?
    var chose_funeral_home_note_attachment: [Int]?
    var funeral_company: Int?
    var funeral_company_note: String?
    var funeral_company_note_attachment: [Int]?
    var company_contract_detail: Bool?
    var company_contract_detail_note: String?
    var company_contract_detail_note_attachment: [Int]?
    var company_contract_num: String?
    var company_contract_num_note: String?
    var company_contract_num_note_attachment: [Int]?
    var funeral_contract: Int?
    var user = getUserId()
}

struct FuneralOrgData: Hashable, Codable {
    var id: Int
    var chose_funeral_home: Bool
    var chose_funeral_home_note: String?
    var funeral_company: FuneralCompany?
    var funeral_company_note: String?
    var company_contract_detail: Bool
    var company_contract_detail_note: String?
    var company_contract_num: String
    var company_contract_num_note: String?
    var funeral_contract: FuneralContract?
    var user: User
}

class FuneralOrgViewModel: ObservableObject {
    @Published var attachements = [Attachement]()
    @Published var orgName = ""
    @Published var updateRecord = false
    @Published var funeralOrgs = [FuneralOrgData]()
    @Published var funeralOrg = FuneralOrg()
    @Published var funeralContract = FuneralContract()
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
    
    func get(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: funeralOrgs, urlString: "users/\(getUserId())/organization") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.funeralOrgs = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
