import Foundation

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
    
    func post<T: Codable, R: Codable>(model: T, response: R, endpoint: String, token: Bool = true, method: String = "POST", completion: @escaping (Result<R,APIErr>) -> Void) {
        guard let encoded = try? JSONEncoder().encode(model) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://messangel.caansoft.com/api/v1/\(endpoint)")!
//        let url = URL(string: "http://172.16.17.80:8030/api/v1/\(endpoint)")!
        var request = URLRequest(url: url)
        if token {
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode(R.self, from: data) {
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
    
    func upload(_ fileData: Data, fileName:String, fileType:String, then completion: @escaping (Result<UploadResponse, APIError>) -> Void) {
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
        var data = Data()
        for (key,value) in dic{
            data.append("------\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)\r\n".data(using: .utf8)!)
        }
        data.append("------\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"dataFiles\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: application/\(fileType)\r\n\r\n".data(using: .utf8)!)
        data.append(fileData)
        data.append("\r\n".data(using: .utf8)!)
        data.append("------\(boundary)--".data(using: .utf8)!)
        // END FORM DATA
        let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(UploadResponse.self, from: data)
                    completion(.success(decodedData))
                } catch let decodingError {
                    completion(.failure(APIError.error("Error: \(decodingError)")))
                }
            }
        }
        task.resume()
    }
}

struct UploadResponse: Decodable {
    let files: [UploadedFile]
}

struct UploadedFile: Decodable {
    let path: String
    let size: Int
}
