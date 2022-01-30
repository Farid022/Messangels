//
//  UserViewModel.swift
//  Messangel
//
//  Created by Saad on 7/13/21.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user = User(id: nil, first_name: "", last_name: "", email: "", password: " ", phone_number: "", dob: "", city: "", postal_code: "", gender: "", is_active: true, image_url: nil)
    
    @Published var profile = Profile(first_name: "", last_name: "", postal_code: "", gender: "", image_url: nil)
    
    @Published var apiResponse = APIService.APIResponse(message: "")

    
}
