//
//  PersistenceManager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 12/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

struct PersistenceManager {

    private let fileManager = FileManager.default
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Storing and Retrieving Images Using FileManager
    
    func store(image: UIImage, with key: String) {
        if let imageData = image.pngData() {
            if let filePath = getFilePath(for: key) {
                try? imageData.write(to: filePath, options: .atomic)
            }
        }
    }
    
    func retrieveImage(from key: String) -> UIImage? {
        if let filePath = getFilePath(for: key),
            let fileData = fileManager.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            return image
        }
        
        return nil
    }
    
    private func getFilePath(for key: String) -> URL? {
        guard let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return path.appendingPathComponent(key + ".png")
    }
    
    // MARK: - Storing and Retrieving Data Using UserDefaults
    
    func store<T: Codable>(value: T, with key: String) throws {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch (let error) {
            throw error
        }
    }
    
    func retrieve<T: Codable>(from key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            throw error
        }
    }
}
