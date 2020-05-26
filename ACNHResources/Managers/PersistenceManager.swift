//
//  PersistenceManager.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 12/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

struct PersistenceManager {
    
    func store(image: UIImage, forKey key: String) {
        if let imageData = image.pngData() {
            if let filePath = getFilePath(forKey: key) {
                try? imageData.write(to: filePath, options: .atomic)
            }
        }
    }
    
    private func getFilePath(forKey key: String) -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return path.appendingPathComponent(key + ".png")
    }
    
    func retrieveImage(forKey key: String) -> UIImage? {
        if let filePath = self.getFilePath(forKey: key),
            let fileData = FileManager.default.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            return image
        }
        
        return nil
    }
}
