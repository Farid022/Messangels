//
//  FuneralMusicViewModel.swift
//  Messangel
//
//  Created by Saad on 1/7/22.
//

import Foundation

struct FuneralMusic: Codable {
    var id: Int?
    var artist_name: String
    var song_title: String
    var broadcast_song_note: String
    var broadcast_song_note_attachment: [Int]?
    var user = getUserId()
}

struct Music: Hashable, Codable {
    var id: Int
    var user: User
    var artist_name: String
    var song_title: String
    var broadcast_song_note: String
}

class FuneralMusicViewModel: ObservableObject {
    @Published var attachements = [Attachement]()
    @Published var updateRecord = false
    @Published var musics = [Music]()
    @Published var music = FuneralMusic(artist_name: "", song_title: "", broadcast_song_note: "")
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: music, response: music, endpoint: "users/\(getUserId())/music") { result in
            switch result {
            case .success(let music):
                DispatchQueue.main.async {
                    self.music = music
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
    
    func getMusics(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: musics, urlString: "users/\(getUserId())/music") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.musics = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/song/\(id)/music") { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: music, response: music, endpoint: "users/\(getUserId())/song/\(id)/music", method: "PUT") { result in
            switch result {
            case .success(let music):
                DispatchQueue.main.async {
                    self.music = music
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
    
    
}
