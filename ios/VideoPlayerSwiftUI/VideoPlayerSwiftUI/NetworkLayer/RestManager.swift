//
//  RestManager.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

enum Result<T: Codable> {
    case success(T)
    case failure(WebError)
}

class RestManager<T: Codable> {
    
    // MARK: - Properties
    var requestHttpHeaders: [String:String] = [:]
    var response: [String:Any] = [:]
    
    // MARK: - Public Methods
    func makeRequest(request : URLRequest, completion: @escaping (_ result: Result<T>) -> Void) {
      
        /*Return if mobile is not connected with the internet*/
        if !isConnectedToNetwork() {
            completion(.failure(.networkLost))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            /*HTTP REQUEST*/
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let response = response as? HTTPURLResponse else {
                        if (error?.localizedDescription) != nil {
                            completion(.failure(.other(error?.localizedDescription ?? "")))
                            return
                        }
                        completion(.failure(.networkLost))
                        return
                    }
                    
                    /*RESPONSE*/
                    /***********************************************/
                    if let responseData = data
                    {
                        let str = String(decoding: responseData, as: UTF8.self)
                        print(str)
                    }
                    
                    switch response.statusCode {
                    case (200..<300):
                        guard let model = Response<T>().parceModel(data: data) else {
                            completion(.failure(WebError.parse))
                            return
                        }
                        completion(.success(model))
                    case (300...600):
                        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                            completion(.failure(.other((error?.localizedDescription) ?? "Internal server error")))
                            return
                        }
                        let message = json["error"] as? String ?? WebError.parse.description
                        completion(.failure(.other(message)))
                        return
                    default:
                        break
                    }
                }
            }
            task.resume()
        }
    }
}


// MARK: - RestManager Parce Model
extension RestManager {
    
    fileprivate struct Response<T: Codable> {
        
        func parceModel(data: Data?) -> T? {
            guard let data = data else {
                return nil
            }
            let mappedData = try? JSONDecoder().decode(T.self, from: data)
            return mappedData
        }
    }
}
