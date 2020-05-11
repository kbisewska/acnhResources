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
    
    fileprivate var name: String {
        switch self {
        case .villager: return "villagers"
        case .fish: return "fish"
        case .bug: return "bugs"
        case .fossil: return "fossils"
        }
    }
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
    
    func downloadIcon(for resource: Resource) {
        let networkManager = NetworkManager()
        
        switch resource {
        case .bug(let id), .villager(let id), .fish(let id):
            networkManager.getIcon(for: resource.name, id: id) { [weak self] icon in
                guard let self = self else { return }
                self.image = icon
            }
        case .fossil: return
        }
    }
}
