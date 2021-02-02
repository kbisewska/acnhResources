//
//  ViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class FishTableViewController: UITableViewController {
    
    private let networkManager = Current.networkManager
    private let persistenceManager = PersistenceManager()
    private let reuseIdentifier = "FishCell"
    
    var fish = [Fish]()
    var filteredFish = [Fish]()
    var isFiltering = false
    
    weak var ownedCountLabel: UILabel?
    var ownedCountLabelText: String {
        "You found \(fish.filter { $0.isOwned }.count) out of \(fish.count) fish."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        configureNavigationBar()
        configureRefreshControl()
        configureSearchController()
        
        let fishObjects = persistenceManager.retrieve(objectsOfType: Fish.self)
        
        if fishObjects.isEmpty {
            getFish(needsUpdate: false)
        } else {
            fish = fishObjects.sorted { $0.name < $1.name }
            tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: Notification.Name("ResetData"), object: nil)
    }
    
    // MARK: - Table View Configuration
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredFish.count : fish.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeFishArray = isFiltering ? filteredFish : fish
        let fishItem = activeFishArray[indexPath.row]
        
        var selectionState = fishItem.isOwned
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            self.persistenceManager.update {
                fishItem.isOwned = !fishItem.isOwned
            }
            
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
            
            self.ownedCountLabel?.text = self.ownedCountLabelText
        }
        
        let resource = Resource.fish(id: fishItem.id)
        cell.resourceNameLabel.text = fishItem.name
        cell.configure(with: resource)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeFishArray = isFiltering ? filteredFish : fish
        
        let fishDetailsViewController = FishDetailsViewController(with: activeFishArray[indexPath.row])
        presentViewController(fishDetailsViewController)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemIndigo
        
        let headerTitle = UILabel().adjustedForAutoLayout()
        headerTitle.configureHeaderLabel(text: ownedCountLabelText, textAlignment: .center)
        header.addSubview(headerTitle)
        ownedCountLabel = headerTitle
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: header.topAnchor, constant: padding),
            headerTitle.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -padding),
            headerTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: padding),
            headerTitle.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -padding)
        ])
        
        return header
    }
    
    // MARK: - Navigation Bar Configuration
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortItems))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterItems))
    }
    
    // MARK: - Refresh Control Configuration
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        getFish(needsUpdate: true)
    }
    
    // MARK: - Getting Data

    private func getFish(needsUpdate: Bool) {
        let ownedFish = fish.filter { $0.isOwned }
        
        networkManager.getFishData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fishDictionary):
                self.fish = Array(fishDictionary.values)
                    .map { entry -> Fish in
                        entry.name = entry.name.capitalized
                        if needsUpdate {
                            entry.isOwned = ownedFish.first { $0.id == entry.id }?.isOwned ?? false
                        }
                        return entry
                    }
                    .sorted { $0.name < $1.name }
                
                if needsUpdate {
                    self.persistenceManager.delete(objectsOfType: Fish.self)
                }
                
                self.persistenceManager.store(objects: self.fish)
                
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()

            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue)
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Resetting Data
    
    @objc func resetData() {
        persistenceManager.delete(objectsOfType: Fish.self)
        fish = []
        filteredFish = []
        
        getFish(needsUpdate: false)
    }
    
    // MARK: - Filtering Items
    
    @objc private func filterItems() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Show only found items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredFish = self.fish.filter { $0.isOwned }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show only undiscovered items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredFish = self.fish.filter { !$0.isOwned }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show all items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = false
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    // MARK: - Sorting Items
    
    @objc private func sortItems() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sort by name: A to Z", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFish.sort { $0.name < $1.name } : self.fish.sort { $0.name < $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by name: Z to A", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFish.sort { $0.name > $1.name } : self.fish.sort { $0.name > $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: low to high", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFish.sort { $0.price < $1.price } : self.fish.sort { $0.price < $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: high to low", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFish.sort { $0.price > $1.price } : self.fish.sort { $0.price > $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    // MARK: - Searching Items
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isFiltering = false
            filteredFish.removeAll()
            tableView.reloadData()
            return
        }
        
        isFiltering = true
        filteredFish = fish.filter { $0.name.lowercased().contains(filter.lowercased()) }
        tableView.reloadData()
    }
}
