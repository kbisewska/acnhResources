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
    
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Something Went Wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
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
