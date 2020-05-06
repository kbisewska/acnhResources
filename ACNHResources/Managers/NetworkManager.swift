//
//  NetworkManager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class NetworkManager {
    
    let baseURL = "http://acnhapi.com/"
    let urlSession = URLSession(configuration: .default)
    
    func getVillagerData(completion: @escaping (Result<[String: Villager], ErrorMessage>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: baseURL + "villagers")!)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getFishData(completion: @escaping (Result<[String: Fish], ErrorMessage>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: baseURL + "fish")!)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getBugData(completion: @escaping (Result<[String: Bug], ErrorMessage>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: baseURL + "bugs")!)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getFossilData(completion: @escaping (Result<[String: Fossil], ErrorMessage>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: baseURL + "fossils")!)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getResourceData<T: Codable>(urlRequest: URLRequest, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.clientError))
                return                       
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<300 ~= response.statusCode else {
                    completion(.failure(.serverError))
                    return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let resource = try JSONDecoder().decode(T.self, from: data)
                completion(.success(resource))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}


