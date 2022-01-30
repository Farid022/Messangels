//
//  Utils.swift
//  Messangel
//
//  Created by Saad on 1/28/22.
//

import Foundation

class Utils {
    static func saveData<T: Encodable>(_ data: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    static func getData<T: Decodable>(_ key: String) -> T? {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(T.self, from: data) {
                return object
            }
        }
        return nil
    }
}
