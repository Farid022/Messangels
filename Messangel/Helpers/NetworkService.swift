import Foundation
import UIKit
import Alamofire

typealias APIService = Networking

class Networking {

    public static let shared = Networking()
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    struct APIErr: Decodable, Error {
        let error: String
        let error_description: String
    }
    
    struct APIResponse: Codable {
        let message: String
    }
    
    public func getJSON<T: Decodable>(model: T, urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void) {
        
        guard let url = URL(string: "https://messangel.caansoft.com/api/v1/\(urlString)") else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
          
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                return
            }
            print("GET Response Data: \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error("Error: \(decodingError)")))
                return
            }
            
        }.resume()
    }
    
    func post<T: Codable, R: Codable>(model: T, response: R, endpoint: String, token: Bool = true, method: String = "POST", keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, completion: @escaping (Result<R,APIErr>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(model) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://messangel.caansoft.com/api/v1/\(endpoint)")!
        UserDefaults.standard.removeObject(forKey: url.lastPathComponent)
        print("Request URL: \(url.path)")
        print("Body: \(String(describing: String(data: encoded, encoding: .utf8)))")
        var request = URLRequest(url: url)
        if token {
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse  else {
                return
            }
            print("Status code: \(httpResponse.statusCode)")
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            print("\(method) Response Data: \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode(R.self, from: data) {
                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(decodedData))
                    return
                } else {
                    let res = decodedData as? APIResponse
                    completion(.failure(APIErr(error: "Server Error: \(httpResponse.statusCode)", error_description: res?.message ?? "")))
                    return
                }
            } else if let decodedError = try? decoder.decode(APIErr.self, from: data) {
                completion(.failure(APIErr(error: decodedError.error, error_description: decodedError.error_description)))
                return
            } else {
                completion(.failure(APIErr(error: "Error", error_description: String(bytes: data, encoding: .utf8) ?? "Unknown error occured!")))
                return
            }
        }.resume()
    }
    
    func patch<T: Codable, R: Codable>(model: T, response: R, endpoint: String, token: Bool = true, method: String = "PATCH", keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, completion: @escaping (Result<R,APIErr>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(model) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://messangel.caansoft.com/api/v1/\(endpoint)")!
        UserDefaults.standard.removeObject(forKey: url.lastPathComponent)
        print("Request URL: \(url.path)")
        print("Body: \(String(describing: String(data: encoded, encoding: .utf8)))")
        var request = URLRequest(url: url)
        if token {
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse  else {
                return
            }
            print("Status code: \(httpResponse.statusCode)")
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            print("\(method) Response Data: \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode(R.self, from: data) {
                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(decodedData))
                    return
                } else {
                    let res = decodedData as? APIResponse
                    completion(.failure(APIErr(error: "Server Error: \(httpResponse.statusCode)", error_description: res?.message ?? "")))
                    return
                }
            } else if let decodedError = try? decoder.decode(APIErr.self, from: data) {
                completion(.failure(APIErr(error: decodedError.error, error_description: decodedError.error_description)))
                return
            } else {
                completion(.failure(APIErr(error: "Error", error_description: String(bytes: data, encoding: .utf8) ?? "Unknown error occured!")))
                return
            }
        }.resume()
    }
    
    func delete(endpoint: String, completion: @escaping (Result<APIResponse,APIErr>) -> Void) {
        
        let url = URL(string: "https://messangel.caansoft.com/api/v1/\(endpoint)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(APIResponse.self, from: data) {
                completion(.success(decodedData))
                return
            } else if let decodedError = try? decoder.decode(APIErr.self, from: data) {
                completion(.failure(APIErr(error: decodedError.error, error_description: decodedError.error_description)))
                return
            } else {
                completion(.failure(APIErr(error: "Error", error_description: String(bytes: data, encoding: .utf8) ?? "Unknown error occured!")))
                return
            }
        }.resume()
    }
    
    func upload(_ fileData: Data, fileName:String, fileType:String) async -> UploadResponse? {
        let url = URL(string: "http://51.83.41.210:4000/uploadfile")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary:String = "Boundary-\(UUID().uuidString)"
        request.allHTTPHeaderFields = ["Content-Type": "multipart/form-data; boundary=----\(boundary)"]
        let user = UserDefaults.standard.value(forKey: "user") as! [String: Any]
        // START FORM DATA
        let dic:[String:String] = [
            "artifect_type":fileType,
            "base_path":"/messangel/\(user["id"] ?? "0")/\(fileType)"
        ]
        var requestData = Data()
        for (key,value) in dic{
            requestData.append("------\(boundary)\r\n".data(using: .utf8)!)
            requestData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            requestData.append("\(value)\r\n".data(using: .utf8)!)
        }
        requestData.append("------\(boundary)\r\n".data(using: .utf8)!)
        requestData.append("Content-Disposition: form-data; name=\"dataFiles\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        requestData.append("Content-Type: application/\(fileType)\r\n\r\n".data(using: .utf8)!)
        requestData.append(fileData)
        requestData.append("\r\n".data(using: .utf8)!)
        requestData.append("------\(boundary)--".data(using: .utf8)!)
        // END FORM DATA
        do {
            let (responseData, urlResponse) = try await URLSession.shared.upload(for: request, from: requestData)
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse,
                  (200...299).contains(httpUrlResponse.statusCode) else {
                      print ("server error")
                      return nil
                  }
            if let mimeType = httpUrlResponse.mimeType,
               mimeType == "application/json",
               let dataString = String(data: responseData, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
            let uploadResponse = try JSONDecoder().decode(UploadResponse.self, from: responseData)
            return uploadResponse
        } catch (let error) {
            print(error.localizedDescription)
        }
        return nil
    }
    func uploadMultiple(_ fileUrls: [Data], fileNames:[String], fileTypes:[String]) async -> UploadResponse? {
        await withCheckedContinuation { continuation in
            uploadMultiple(fileUrls, fileNames: fileNames, fileTypes: fileTypes) { response in
                continuation.resume(returning: response)
            }
        }
    }
    func uploadMultiple(_ fileUrls: [Data], fileNames:[String], fileTypes:[String], completion: @escaping (UploadResponse?) -> Void) {
//        let url = URL(string: "http://51.83.41.210:4000/uploadfile")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let boundary:String = "Boundary-\(UUID().uuidString)"
//        request.allHTTPHeaderFields = ["Content-Type": "multipart/form-data; boundary=----\(boundary)"]
        let user = UserDefaults.standard.value(forKey: "user") as! [String: Any]
        // START FORM DATA
        var basePaths = [String]()
        for fileType in fileTypes {
            basePaths.append("/messangel/\(user["id"] ?? "0")/\(fileType)")
        }
//        let dic:[String:String] = [
//            "artifect_type":fileTypes.joined(separator: ","),
//            "base_path":basePaths.joined(separator: ",")
//        ]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(fileTypes.joined(separator: ",").utf8), withName: "artifect_type")
            multipartFormData.append(Data(basePaths.joined(separator: ",").utf8), withName: "base_path")
            for url in fileUrls {
//                multipartFormData.append(file, withName: "dataFiles")
                    multipartFormData.append(url, withName: "dataFiles")
//                    multipartFormData.append(url, withName: "dataFiles")
            }
        }, to: "http://51.83.41.210:4000/uploadfile")
//            .responseData(completionHandler: { resData in
//                resData.data
//            })
            .responseDecodable(of: UploadResponse.self) { response in
                switch response.result {
                case .success(let res):
                    if let resData = response.data {
                        debugPrint("Upload Reponse Data: \(String(data: resData, encoding: .utf8) ?? "")")
                    }
                    completion(res)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(nil)
                }
            }
//        var requestData = Data()
//        for (key,value) in dic {
//            requestData.append("------\(boundary)\r\n".data(using: .utf8)!)
//            requestData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//            requestData.append("\(value)\r\n".data(using: .utf8)!)
//        }
//        requestData.append("------\(boundary)\r\n".data(using: .utf8)!)
//        var i = 0
//        for _ in fileNames {
//            requestData.append("Content-Disposition: form-data; name=\"dataFiles\"; filename=\"\(fileNames[i])\"\r\n".data(using: .utf8)!)
//            requestData.append("Content-Type: application/\(fileTypes[i])\r\n\r\n".data(using: .utf8)!)
//            i += 1
//        }
//        requestData.append("\r\n".data(using: .utf8)!)
//        for fileDatum in fileData {
//            requestData.append(fileDatum)
//        }
//        requestData.append("------\(boundary)--".data(using: .utf8)!)
        // END FORM DATA
//        do {
//            let (responseData, urlResponse) = try await URLSession.shared.upload(for: request, from: requestData)
//            guard let httpUrlResponse = urlResponse as? HTTPURLResponse,
//                  (200...299).contains(httpUrlResponse.statusCode) else {
//                      print ("server error")
//                      return nil
//                  }
//            if let mimeType = httpUrlResponse.mimeType,
//               mimeType == "application/json",
//               let dataString = String(data: responseData, encoding: .utf8) {
//                print ("Upload Reponse Data: \(dataString)")
//            }
//            let uploadResponse = try JSONDecoder().decode(UploadResponse.self, from: responseData)
//            return uploadResponse
//        } catch (let error) {
//            print(error.localizedDescription)
//        }
//        return nil
    }
    
} // END OF CLASS

struct UploadResponse: Decodable {
    let files: [UploadedFile]
}

struct UploadedFile: Decodable {
    let path: String
    let size: Int
}

func getUserId() -> Int {
    return UserDefaults.standard.dictionary(forKey: "user")?["id"] as! Int
}

func uploadImage(_ image: UIImage, type: String) async -> (String, Int) {
    if let response = await Networking.shared.upload(image.jpegData(compressionQuality: 1)!, fileName: "msgl_user_\(getUserId())_\(type)_\(UUID().uuidString).jpeg", fileType: "image") {
        return (response.files.first?.path ?? "", response.files.first?.size ?? 0)
    }
    return ("", 0)
}

func uploadFiles(_ urls: [URL]) async -> [String] {
    var filesData = [Data]()
    var fileNames = [String]()
    var fileTypes = [String]()
    for url in urls {
        if url.startAccessingSecurityScopedResource(), let data = NSData(contentsOfFile: url.path) {
            filesData.append(data as Data)
            fileNames.append(url.lastPathComponent)
            fileTypes.append(url.pathExtension)
            do { url.stopAccessingSecurityScopedResource() }
        }
    }
    var uploadedFilesPaths = [String]()
    var i = 0
    for fileData in filesData {
        if let response = await Networking.shared.upload(fileData, fileName: fileNames[i], fileType: fileTypes[i]) {
            uploadedFilesPaths.append(response.files[0].path)
        }
        i += 1
    }
//    if let response = await Networking.shared.uploadMultiple(filesData, fileNames: fileNames, fileTypes: fileTypes) {
//
//        for uploadedFile in response.files {
//            uploadedFilesPaths.append(uploadedFile.path)
//        }
//        return uploadedFilesPaths
//    }
    return uploadedFilesPaths
}

