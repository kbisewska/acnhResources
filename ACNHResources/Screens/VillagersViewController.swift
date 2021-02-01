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
        
        let villagerObjects = persistenceManager.retrieve(objectsOfType: Villager.self)
        
        if villagerObjects.isEmpty {
            getVillagers()
        } else {
            villagersTableViewController.update(with: villagerObjects.sorted { $0.name < $1.name })
        }
        
        add(villagersCollectionViewController)
        add(villagersTableViewController)
        configureLayout()
        configureSearchController()
        
        villagersTableViewController.delegate = villagersCollectionViewController
    }
    
    // MARK: - Getting Data
    
    private func getVillagers() {
        networkManager.getVillagersData() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let villagersDictionary):
                let villagers = Array(villagersDictionary.values).sorted { $0.name < $1.name }
                self.villagersTableViewController.update(with: villagers)
                
                self.persistenceManager.store(objects: villagers)
                
            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue)
            }
        }
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
