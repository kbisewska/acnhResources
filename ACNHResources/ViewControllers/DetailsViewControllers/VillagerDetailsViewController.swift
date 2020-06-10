//
//  ResourceDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class VillagerDetailsViewController: UIViewController {
    
    private let customView = DetailsView().adjustedForAutoLayout()
    private var villager: Villager
    
    init(with villager: Villager) {
        self.villager = villager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.widthAnchor.constraint(equalToConstant: 400),
            customView.heightAnchor.constraint(equalToConstant: 540)
        ])
        
        customView.resourceImageView.downloadImage(for: .villager(id: villager.id))
        customView.resourceNameLabel.text = villager.name
        customView.resourceDetailsLabel.text = """
        Personality: \(villager.personality)
        
        Birthday: \(villager.birthday)
        
        Species: \(villager.species)
        
        Gender: \(villager.gender)
        """
    }
}
