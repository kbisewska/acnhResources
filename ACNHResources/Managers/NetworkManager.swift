//
//  NetworkManager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class NetworkManager {
    
    private let baseURL = "http://acnhapi.com/v1/"
    private let urlSession = URLSession(configuration: .default)
    private let persistanceManager = PersistenceManager()
    
    static private var cancellableTasks = [String: URLSessionDataTask]()
    
    // MARK: - Getting Data
    
    func getVillagersData(completion: @escaping (Result<[String: Villager], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "villagers") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getFishData(completion: @escaping (Result<[String: Fish], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "fish") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getBugsData(completion: @escaping (Result<[String: Bug], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "bugs") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    func getFossilsData(completion: @escaping (Result<[String: Fossil], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "fossils") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceData(urlRequest: urlRequest, completion: completion)
    }
    
    // MARK: - Getting Images
    
    func getVillagerImage(id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/villagers/\(id)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getFishImage(id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/fish/\(id)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getBugImage(id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: baseURL + "images/bugs/\(id)") else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getFossilImage(fileName: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = getFossilURL(fileName: fileName) else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getFossilURL(fileName: String) -> URL? {
        URL(string: baseURL + "images/fossils/\(fileName.lowercased())")
    }
    
    // MARK: - Getting Icons
    
    func getIcon(for resource: String, id: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = getURL(for: resource, id: id) else { return }
        let urlRequest = URLRequest(url: url)
        getResourceImage(urlRequest: urlRequest, completion: completion)
    }
    
    func getURL(for resource: String, id: Int) -> URL? {
        URL(string: baseURL + "icons/\(resource)/\(id)")
    }
    
    // MARK: - Helper Methods
    
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
                errorMessage = .unableToComplete
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<300 ~= response.statusCode else {
                    errorMessage = .invalidResponse
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
    
    private func getResourceImage(urlRequest: URLRequest, completion: @escaping (UIImage?) -> Void) {
        let key = urlRequest.url!.absoluteString.sha256()
        
        if let image = persistanceManager.retrieveImage(from: key) {
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            NetworkManager.cancellableTasks.removeValue(forKey: key)
            
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
            
            self.persistanceManager.store(image: image, with: key)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        NetworkManager.cancellableTasks[key] = task
        task.resume()
    }
    
    func cancelTask(for resource: String, id: Int) {
        guard let key = getURL(for: resource, id: id)?.absoluteString.sha256(), let task = NetworkManager.cancellableTasks[key] else { return }
        NetworkManager.cancellableTasks.removeValue(forKey: key)
        task.cancel()
    }
    
    func cancelFossilTask(fileName: String) {
        guard let key = getFossilURL(fileName: fileName)?.absoluteString.sha256(), let task = NetworkManager.cancellableTasks[key] else { return }
        NetworkManager.cancellableTasks.removeValue(forKey: key)
        task.cancel()
    }
}
