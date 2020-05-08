//
//  NetworkManager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class NetworkManager {
    
    private let baseURL = "http://acnhapi.com/"
    private let urlSession = URLSession(configuration: .default)
    
    // MARK: - Getting Data
    
    func getVillagerData(completion: @escaping (Result<[String: Villager], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "villagers") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getFishData(completion: @escaping (Result<[String: Fish], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "fish") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getBugData(completion: @escaping (Result<[String: Bug], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "bugs") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getFossilData(completion: @escaping (Result<[String: Fossil], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "fossils") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    private func getResourceData<T: Codable>(urlRequest: URLRequest, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            var resource: T?
            var errorMessage: ErrorMessage?
            
            defer {
                DispatchQueue.main.async {
                    if let resource = resource {
                        completion(.success(resource))
                    } else if let errorMessage = errorMessage {
                        completion(.failure(errorMessage))
                    }
                }
            }
            
            guard error == nil, let data = data else {
                errorMessage = .clientError
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<300 ~= response.statusCode else {
                    errorMessage = .serverError
                    return
            }
            
            do {
                resource = try JSONDecoder().decode(T.self, from: data)
            } catch {
                errorMessage = .invalidData
            }
        }
        
        task.resume()
    }
    
    // MARK: - Getting Images
    
    func getVillagerImage(with id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/villagers/\(id)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getFishImage(with id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/fish/\(id)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getBugImage(with id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/bugs/\(id)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getFossilImage(with fileName: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/fossils/\(fileName)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    private func getResourceImage(urlRequest: URLRequest, completion: @escaping (UIImage?) -> Void) {
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil,
                let response = response as? HTTPURLResponse,
                200..<300 ~= response.statusCode,
                let data = data,
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                       completion(nil)
                    }
                    return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        task.resume()
    }
}
