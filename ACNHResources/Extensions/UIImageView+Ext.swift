//
//  ImageView+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 07/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(for resource: Resource, completion: (() -> Void)? = nil) {
        let networkManager = Current.networkManager
        
        switch resource {
        case .villager(let id):
            networkManager.getVillagerImage(id: id) { [weak self] image in
                guard let self = self else { return }
                self.image = image
                completion?()
            }
            
        case .fish(let id):
            networkManager.getFishImage(id: id) { [weak self] image in
                guard let self = self else { return }
                self.image = image
                completion?()
            }
            
        case .bug(let id):
            networkManager.getBugImage(id: id) { [weak self] image in
                guard let self = self else { return }
                self.image = image
                completion?()
            }
            
        case .fossil(let fileName):
            networkManager.getFossilImage(fileName: fileName) { [weak self] image in
                guard let self = self else { return }
                self.image = image
                completion?()
            }
        }
    }
    
    func downloadIcon(for resource: Resource, completion: (() -> Void)? = nil) {
        let networkManager = Current.networkManager
        
        switch resource {
        case .bug(let id), .villager(let id), .fish(let id):
            networkManager.getIcon(for: resource.name, id: id) { [weak self] icon in
                guard let self = self else { return }
                self.image = icon
                completion?()
            }
        case .fossil: return
        }
    }
    
    func cancelTask(for resource: Resource) {
        let networkManager = Current.networkManager
        
        switch resource {
        case .bug(let id), .villager(let id), .fish(let id):
            networkManager.cancelTask(for: resource.name, id: id)
            
        case .fossil(let fileName):
            networkManager.cancelFossilTask(fileName: fileName)
        }
    }
}
