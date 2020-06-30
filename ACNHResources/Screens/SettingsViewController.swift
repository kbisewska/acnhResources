//
//  SettingsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 25/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let generalSettingsViewController = GeneralSettingsViewController()
    private let creditsViewController = CreditsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(generalSettingsViewController)
        add(creditsViewController)
        configureLayout()
    }
    
    func configureLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            generalSettingsViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            generalSettingsViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            generalSettingsViewController.view.heightAnchor.constraint(equalToConstant: 200),
            
            creditsViewController.view.topAnchor.constraint(equalTo: generalSettingsViewController.view.bottomAnchor, constant: padding),
            creditsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            creditsViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
