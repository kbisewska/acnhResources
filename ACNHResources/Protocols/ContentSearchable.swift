//
//  ContentSearchable.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 10/02/2021.
//  Copyright © 2021 kbisewska. All rights reserved.
//

import UIKit

protocol ContentSearchable: AnyObject {
    var searchController: UISearchController { get }
}

extension ContentSearchable where Self: UIViewController {
    
    func configureSearchController(withPlaceholder placeholder: String) {
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
