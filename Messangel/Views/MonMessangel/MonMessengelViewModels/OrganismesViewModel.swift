//
//  OrganismesViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Organismes: Hashable, Codable {
    var id: Int?
    var name: String?
    var emailAddress, phoneNumber, contactName: String?
    var address, postalCode, city, website: String?
    var type: String?
    
    

    enum CodingKeys: String, CodingKey {
        case id, name
        case emailAddress = "email_address"
        case phoneNumber = "phone_number"
        case contactName = "contact_name"
        case address
        case postalCode = "postal_code"
        case city, website, type
        
    }
}

struct OgranismesData: Hashable, Codable
{
    var id: Int?
    var funeral_company: Organismes?
    var company_contract_detail:  Bool?
    var funeral_contract: String?
    var user: User?
    var assign_user: [User]?
    var chose_funeral_home: Bool?
    var chose_funeral_home_note: String?
    var funeral_company_note1: String?
    var funeral_company_note: String?
    var company_contract_detail_note: String?
    var company_contract_num: String?
   
    enum CodingKeys: String, CodingKey {
        case id,funeral_company,company_contract_detail,funeral_contract,user,assign_user,chose_funeral_home_note,funeral_company_note1,funeral_company_note,company_contract_detail_note,company_contract_num,chose_funeral_home
    }

    
}

class OrganismesViewModel: ObservableObject {
    @Published var organismes = OgranismesData()
    @Published var organismesArray = [OgranismesData()]
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func getOrganismes(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: organismesArray, urlString: "choices/\(getUserId())/organization") { result in
            switch result {
            case .success(let org):
                DispatchQueue.main.async {
                    if org.count > 0
                    {
                        self.organismes = org[0]
                    }
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    //self.apiError = error
                    completion(false)
                }
            }
        }
    }
}
