//
//  VillagersViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class VillagersViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    var villagers = [Villager]()
    var villager: Villager!
    var villagerImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        villagerImage = UIImageView()
        villagerImage.frame = view.frame
        view.addSubview(villagerImage)
        
        //getVillagers()
        getVillagerImage()
    }
    
    func getVillagers() {
        networkManager.getVillagerData() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let villagersDictionary):
                let villagersList = Array(villagersDictionary.values).sorted { $0.id < $1.id }
                self.villagers = villagersList
                print(self.villagers)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getVillagerImage() {
        networkManager.getFossilImage(with: "amber") { [weak self] image in
            guard let self = self else { return }
            
            self.villagerImage.image = image
        }
    }
}
