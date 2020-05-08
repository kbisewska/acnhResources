//
//  ImageView+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 07/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

enum Resource {
    
    case villager(id: Int)
    case fish(id: Int)
    case bug(id: Int)
    case fossil(fileName: String)
}

extension UIImageView {
    
    func downloadImage(for resource: Resource) {
        let networkManager = NetworkManager()
        
        switch resource {
        case .villager(let id):
            networkManager.getVillagerImage(id: id) { [weak self] image in
                guard let self = self else { return }
            
                self.image = image
            }
            
        case .fish(let id):
            networkManager.getFishImage(id: id) { [weak self] image in
                guard let self = self else { return }
            
                self.image = image
            }
            
        case .bug(let id):
            networkManager.getBugImage(id: id) { [weak self] image in
                guard let self = self else { return }
            
                self.image = image
            }
            
        case .fossil(let fileName):
            networkManager.getFossilImage(fileName: fileName) { [weak self] image in
                guard let self = self else { return }
            
                self.image = image
            }
        }
    }
}
