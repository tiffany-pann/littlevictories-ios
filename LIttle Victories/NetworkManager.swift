//
//  NetworkManager.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import Foundation
import Alamofire

class NetworkManager {
    static let host: String = "http://34.130.14.60"
    
    // sends a token to the backend to create a User
    static func sendToken(token: String, completion: @escaping (User) -> Void) {
        let endpoint = "\(host)/api/login/"
        let params = [
            "token": token
        ]
        AF.request(endpoint, method: .post,parameters: params,encoding: JSONEncoding.default).validate().responseData { response in
                debugPrint(response)
                switch (response.result) {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let eventResponse = try? jsonDecoder.decode(User.self, from: data) {
                        completion(eventResponse)
                    } else {
                        print("Failed to decode sendToken")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    // gets all victories from the backend
    static func getVictories(completion: @escaping (VictoryResponse) -> Void) {
        let endpoint = "\(host)/api/users/1/victories/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let VictoryResponse = try? jsonDecoder.decode(VictoryResponse.self, from: data) {
                    completion(VictoryResponse)
                } else {
                    print("Failed to decode getVictories")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // sends a post request to the backend
    static func postVictory(date: Int, description: String, image: String, completion: @escaping (Victory) -> Void) {
        let endpoint = "\(host)/api/users/1/victories/"
        let params: [String:Any] = [
            "date": date,
            "description": description,
            "image_data": image
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
                debugPrint(response)
                switch (response.result) {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let victoryResponse = try? jsonDecoder.decode(Victory.self, from: data) {
                        completion(victoryResponse)
                    } else {
                        print("Failed to decode postVictory")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
        
    }
    
    // sends a phone number to the backend for their Twilio requests
    static func sendPhoneNumber(number: Int, completion: @escaping (User) -> Void) {
        let endpoint = "\(host)/api/users/1/number/"
        let params: [String:Any] = [
            "number": number
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
                debugPrint(response)
                switch (response.result) {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let victoryResponse = try? jsonDecoder.decode(User.self, from: data) {
                        completion(victoryResponse)
                    } else {
                        print("Failed to decode sendPhoneNumber")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
