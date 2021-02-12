//
//  NavigationBarCustomizable.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 10/02/2021.
//  Copyright © 2021 kbisewska. All rights reserved.
//

import UIKit

protocol NavigationBarCustomizable: AnyObject {}

extension NavigationBarCustomizable where Self: UIViewController {
    
    func addNavigationItems(leftBarButtonTitle: String, leftBarButtonAction: Selector, rightBarButtonTitle: String, rightBarButtonAction: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftBarButtonTitle, style: .plain, target: self, action: leftBarButtonAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightBarButtonTitle, style: .plain, target: self, action: rightBarButtonAction)
    }
    
    func configureNavigationBar(forEnabledState state: Bool, forViewController viewController: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = state
        
        if let navigationItem = viewController?.navigationItem {
            navigationItem.leftBarButtonItem?.isEnabled = state
            navigationItem.rightBarButtonItem?.isEnabled = state
            navigationItem.searchController?.searchBar.isUserInteractionEnabled = state
        }
    }
}
