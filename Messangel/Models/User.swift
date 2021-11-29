//
//  Users.swift
//  Messangel
//
//  Created by Saad on 7/13/21.
//

import Foundation

struct User: Codable {
    var id: Int?
    var first_name: String
    var last_name: String
    var email: String
    var password: String?
    var phone_number: String
    var dob: String
    var city: String
    var postal_code: String
    var gender: String
    var is_active: Bool
    var image_url: String?
    var registration_date: String?
}

struct Profile: Codable {
    var first_name: String
    var last_name: String
    var postal_code: String
    var gender: String
    var image_url: String?
}

struct Credentials: Codable {
    var email: String
    var password: String
}

struct Password: Codable {
    var password: String
    var new_password: String
}

struct Email: Codable {
    var email: String
    var new_email: String
}

struct Mobile: Codable {
    var email: String
    var new_mobile: String
}

struct Token: Codable {
    var access_token: String
    var token_type: String
    var refresh_token: String
}

struct OTP: Codable {
    let phone_number: String
}

struct OTPVerify: Codable {
    let phone_number: String
    let otp: String
}

struct EmailVerify: Codable {
    let email: String
}
