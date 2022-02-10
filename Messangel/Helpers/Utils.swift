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

func dateToStr(_ date: Date, dateFormat: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
}

func strToDate(_ dateStr: String, dateFormat: String = "yyyy-MM-dd") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.date(from: dateStr)
}

func unixStrToDateSring(_ dateStr: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    } else {
        return ""
    }
}

func formatDateString(_ dateStr: String, inFormat: String, outFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inFormat
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.dateFormat = outFormat
        dateFormatter.locale = Locale(identifier: "fr")
        return dateFormatter.string(from: date)
    } else {
        return ""
    }
}
