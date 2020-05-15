//
//  ResourceDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class VillagerDetailsViewController: UIViewController {
    
    private let customView = DetailsView()
    private var villager: Villager
    
    init(with villager: Villager) {
        self.villager = villager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.resourceImageView.downloadImage(for: .villager(id: villager.id))
        customView.resourceNameLabel.text = "Name: \(villager.name)"
        customView.resourceDetailsLabel.text = """
        Personality: \(villager.personality)
        Birthday: \(villager.birthday)
        Species: \(villager.species)
        Gender: \(villager.gender)
        """
    }
}
