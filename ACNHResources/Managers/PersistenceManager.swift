//
//  PersistenceManager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 12/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit
import RealmSwift

struct PersistenceManager {

    private let fileManager = FileManager.default
    private let userDefaults = UserDefaults.standard
    private let realm = try? Realm()
    
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
    
    func store<T>(value: T, withKey key: String) throws {
        userDefaults.set(value, forKey: key)
    }
    
    func retrieve<T>(fromKey key: String) throws -> T? {
        guard let data = userDefaults.object(forKey: key) as? T else { return nil }
        return data
    }
    
    func removeData(withKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    // MARK: - Storing and Retrieving Data Using Realm Database
    
    func store<T: Object>(objects: [T]) {
        try? realm?.write {
            realm?.add(objects)
        }
    }
    
    func update(with action: @escaping () -> Void) {
        try? realm?.write {
            action()
        }
    }
    
    func retrieve<T: Object>(objectsOfType type: T.Type) -> [T] {
        guard let results = realm?.objects(type) else { return [] }
        return Array(results)
    }
    
    func delete<T: Object>(objectsOfType type: T.Type) {
        try? realm?.write {
            realm?.delete(retrieve(objectsOfType: type))
        }
    }
}
