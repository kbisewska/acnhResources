//
//  TabBarController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
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
    
    private func createVillagersNavigationController() -> UINavigationController {
        let villagersViewController = VillagersViewController()
        villagersViewController.title = "Villagers"
        villagersViewController.tabBarItem = UITabBarItem(title: "Villagers", image: UIImage(named: "Villagers.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: villagersViewController)
    }
    
    private func createFishNavigationController() -> UINavigationController {
        let fishViewController = FishViewController()
        fishViewController.title = "Fish"
        fishViewController.tabBarItem = UITabBarItem(title: "Fish", image: UIImage(named: "Fish.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: fishViewController)
    }
    
    private func createBugsNavigationController() -> UINavigationController {
        let bugsViewController = BugsViewController()
        bugsViewController.title = "Bugs"
        bugsViewController.tabBarItem = UITabBarItem(title: "Bugs", image: UIImage(named: "Bug.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: bugsViewController)
    }
    
    private func createFossilsNavigationController() -> UINavigationController {
        let fossilsViewController = FossilsViewController()
        fossilsViewController.title = "Fossils"
        fossilsViewController.tabBarItem = UITabBarItem(title: "Fossils", image: UIImage(named: "Fossil.png")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        
        return UINavigationController(rootViewController: fossilsViewController)
    }
    
    private func createSettingsNavigationController() -> UINavigationController {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings & More"
        settingsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        
        return UINavigationController(rootViewController: settingsViewController)
    }
}
