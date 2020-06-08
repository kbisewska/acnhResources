//
//  VillagersViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 15/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class VillagersViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private let villagersCollectionViewController = VillagersCollectionViewController(with: [])
    private let villagersTableViewController = VillagersTableViewController(with: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(villagersCollectionViewController)
        add(villagersTableViewController)
        configureLayout()
        configureSearchController()
        getVillagers()
        
        villagersTableViewController.delegate = villagersCollectionViewController
    }
    
    func getVillagers() {
        networkManager.getVillagersData() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let villagersDictionary):
                let villagersList = Array(villagersDictionary.values).sorted { $0.name < $1.name }
                self.villagersTableViewController.update(with: villagersList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            villagersCollectionViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            villagersCollectionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            villagersCollectionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            villagersCollectionViewController.view.heightAnchor.constraint(equalToConstant: 250),
            
            villagersTableViewController.view.topAnchor.constraint(equalTo: villagersCollectionViewController.view.bottomAnchor, constant: 20),
            villagersTableViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            villagersTableViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            villagersTableViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
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
        villagersCollectionViewController.filteredVillagers = villagersTableViewController.villagers.filter { $0.name.lowercased().contains(filter.lowercased()) }
        villagersCollectionViewController.collectionView.reloadData()
    }
}
