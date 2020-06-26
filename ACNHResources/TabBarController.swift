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
        
        UITabBar.appearance().tintColor = .systemIndigo
        
        viewControllers = [
            createVillagersNavigationController(),
            createFishNavigationController(),
            createBugsNavigationController(),
            createFossilsNavigationController(),
            createSettingsNavigationController()
        ]
    }
    
    func createVillagersNavigationController() -> UINavigationController {
        let villagersViewController = VillagersViewController()
        villagersViewController.title = "Villagers"
        villagersViewController.tabBarItem = UITabBarItem(title: "Villagers", image: UIImage(named: "Villagers.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: villagersViewController)
    }
    
    func createFishNavigationController() -> UINavigationController {
        let fishTableViewController = FishTableViewController()
        fishTableViewController.title = "Fish"
        fishTableViewController.tabBarItem = UITabBarItem(title: "Fish", image: UIImage(named: "Fish.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: fishTableViewController)
    }
    
    func createBugsNavigationController() -> UINavigationController {
        let bugsTableViewController = BugsTableViewController()
        bugsTableViewController.title = "Bugs"
        bugsTableViewController.tabBarItem = UITabBarItem(title: "Bugs", image: UIImage(named: "Bug.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: bugsTableViewController)
    }
    
    func createFossilsNavigationController() -> UINavigationController {
        let fossilsTableViewController = FossilsTableViewController()
        fossilsTableViewController.title = "Fossils"
        fossilsTableViewController.tabBarItem = UITabBarItem(title: "Fossils", image: UIImage(named: "Fossil.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: fossilsTableViewController)
    }
    
    func createSettingsNavigationController() -> UINavigationController {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings & More"
        settingsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        
        return UINavigationController(rootViewController: settingsViewController)
    }
}
