//
//  TabBarController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createVillagersNavigationController(),
            createFishNavigationController(),
            createBugsNavigationController(),
            createFossilsNavigationController()
        ]
    }
    
    func createVillagersNavigationController() -> UINavigationController {
        let villagersViewController = VillagersViewController()
        villagersViewController.title = "Villagers"
        
        return UINavigationController(rootViewController: villagersViewController)
    }
    
    func createFishNavigationController() -> UINavigationController {
        let fishViewController = FishViewController()
        fishViewController.title = "Fish"
        
        return UINavigationController(rootViewController: fishViewController)
    }
    
    func createBugsNavigationController() -> UINavigationController {
        let bugsViewController = BugsViewController()
        bugsViewController.title = "Bugs"
        
        return UINavigationController(rootViewController: bugsViewController)
    }
    
    func createFossilsNavigationController() -> UINavigationController {
        let fossilsViewController = FossilsViewController()
        fossilsViewController.title = "Fossils"
        
        return UINavigationController(rootViewController: fossilsViewController)
    }
}
