//
//  FuneralAstheticViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

@propertyWrapper
public struct CodableIgnored<T>: Codable {
    public var wrappedValue: T?
        
    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = nil
    }
    
    public func encode(to encoder: Encoder) throws {
        // Do nothing
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: CodableIgnored<T>.Type,
        forKey key: Self.Key) throws -> CodableIgnored<T>
    {
        return CodableIgnored(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode<T>(
        _ value: CodableIgnored<T>,
        forKey key: KeyedEncodingContainer<K>.Key) throws
    {
        // Do nothing
    }
}

struct FueneralAsthetic: Codable {
    var special_decoration_note: String
    var special_decoration_note_attachment: [Int]?
    @CodableIgnored var special_decoration_note_attachments: [URL]?
    var attendence_dress_note: String
    var attendence_dress_note_attachment: [Int]?
    @CodableIgnored var attendence_dress_note_attachments: [URL]?
    var guest_accessories_note: String
    var guest_accessories_note_attachment: [Int]?
    @CodableIgnored var guest_accessories_note_attachments: [URL]?
    var flower: Int
    var flower_note: String?
    var flower_note_attachment: [Int]?
    @CodableIgnored var flower_note_attachments: [URL]?
    var user = getUserId()
}

struct FueneralAstheticData: Codable {
    var id: Int
    var special_decoration_note: String
    var special_decoration_note_attachment: [Attachement]?
    var attendence_dress_note: String
    var attendence_dress_note_attachment: [Attachement]?
    var guest_accessories_note: String
    var guest_accessories_note_attachment: [Attachement]?
    var flower: FuneralChoice
    var flower_note: String?
    var flower_note_attachment: [Attachement]?
    var user: User
}

class FueneralAstheticViewModel: CUViewModel {
    @Published var updateRecord = false
    @Published var recordId = 0
    @Published var progress = 0
    @Published var asthetics = [FueneralAstheticData]()
    @Published var asthetic = FueneralAsthetic(special_decoration_note: "", attendence_dress_note: "", guest_accessories_note: "", flower: 0)
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: asthetic, response: asthetic, endpoint: "users/\(getUserId())/asthetic") { result in
            switch result {
            case .success(let asthetic):
                DispatchQueue.main.async {
                    self.asthetic = asthetic
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
        APIService.shared.post(model: asthetic, response: asthetic, endpoint: "users/\(getUserId())/asthetic/\(id)", method: "PUT") { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.asthetic = item
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
        APIService.shared.getJSON(model: asthetics, urlString: "users/\(getUserId())/asthetic") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.asthetics = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
