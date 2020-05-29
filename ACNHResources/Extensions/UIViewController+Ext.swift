//
//  UIViewController+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 26/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view.adjustedForAutoLayout())
        child.didMove(toParent: self)
    }
}

extension UIViewController: UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {}
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a resource"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
