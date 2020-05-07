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
        let fishTableViewController = FishTableViewController()
        fishTableViewController.title = "Fish"
        
        return UINavigationController(rootViewController: fishTableViewController)
    }
    
    func createBugsNavigationController() -> UINavigationController {
        let bugsTableViewController = BugsTableViewController()
        bugsTableViewController.title = "Bugs"
        
        return UINavigationController(rootViewController: bugsTableViewController)
    }
    
    func createFossilsNavigationController() -> UINavigationController {
        let fossilsTableViewController = FossilsTableViewController()
        fossilsTableViewController.title = "Fossils"
        
        return UINavigationController(rootViewController: fossilsTableViewController)
    }
}