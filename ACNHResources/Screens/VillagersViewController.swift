//
//  VillagersViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 15/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class VillagersViewController: UIViewController {
    
    private let networkManager = Current.networkManager
    private let persistenceManager = PersistenceManager()
    private let villagersCollectionViewController = VillagersCollectionViewController()
    private let villagersTableViewController = VillagersTableViewController(with: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(villagersCollectionViewController)
        add(villagersTableViewController)
        villagersTableViewController.delegate = villagersCollectionViewController
        
        configureLayout()
        configureSearchController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: Notification.Name("ResetData"), object: nil)
    }
    
    // MARK: - Layout Configuration
    
    private func configureLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            villagersCollectionViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            villagersCollectionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            villagersCollectionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            villagersCollectionViewController.view.heightAnchor.constraint(equalToConstant: 187),
            
            villagersTableViewController.view.topAnchor.constraint(equalTo: villagersCollectionViewController.view.bottomAnchor),
            villagersTableViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            villagersTableViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            villagersTableViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Searching Items
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            villagersTableViewController.isFiltering = false
            villagersTableViewController.filteredVillagers.removeAll()
            villagersTableViewController.tableView.reloadData()
            
            villagersCollectionViewController.isFiltering = false
            villagersCollectionViewController.filteredVillagers.removeAll()
            villagersCollectionViewController.collectionView.reloadData()
            return
        }
        
        villagersTableViewController.isFiltering = true
        villagersTableViewController.filteredVillagers = villagersTableViewController.villagers.filter { $0.name.lowercased().contains(filter.lowercased()) }
        villagersTableViewController.tableView.reloadData()
        
        villagersCollectionViewController.isFiltering = true
        villagersCollectionViewController.filteredVillagers = villagersCollectionViewController.villagers.filter { $0.name.lowercased().contains(filter.lowercased()) }
        villagersCollectionViewController.collectionView.reloadData()
    }
}
