//
//  VillagersTableViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 15/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

protocol VillagersTableViewControllerDelegate: class {
    func didTapCheckmarkButton()
}

final class VillagersTableViewController: UITableViewController, UISearchBarDelegate {
    
    weak var delegate: VillagersTableViewControllerDelegate!
    
    private let networkManager = Current.networkManager
    private let persistenceManager = PersistenceManager()
    private let reuseIdentifier = "VillagerCell"
    
    var villagers = [Villager]()
    var filteredVillagers = [Villager]()
    var isFiltering = false
    
    init(with villagers: [Villager]) {
        super.init(nibName: nil, bundle: nil)
        self.villagers = villagers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let villagerObjects = persistenceManager.retrieve(objectsOfType: Villager.self)
        
        if villagerObjects.isEmpty {
            getVillagers(needsUpdate: false)
        } else {
            villagers = villagerObjects.sorted { $0.name < $1.name }
            tableView.reloadData()
        }
    }
    
    // MARK: - Refresh Control Configuration
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        getVillagers(needsUpdate: true)
    }
    
    // MARK: - Table View Configuration

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredVillagers.count : villagers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeVillagersArray = isFiltering ? filteredVillagers : villagers
        let villager = activeVillagersArray[indexPath.row]
        
        var selectionState = villager.isOwned
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            self.persistenceManager.update {
                villager.isOwned = !villager.isOwned
            }
            
            self.delegate.didTapCheckmarkButton()
            
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
        }
        
        let resource = Resource.villager(id: villager.id)
        cell.resourceNameLabel.text = villager.name
        cell.configure(with: resource)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeVillagersArray = isFiltering ? filteredVillagers : villagers
        
        let villagerDetailsViewController = VillagerDetailsViewController(with: activeVillagersArray[indexPath.row])
        presentViewController(villagerDetailsViewController)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemIndigo
        
        let headerTitle = UILabel().adjustedForAutoLayout()
        headerTitle.configureHeaderLabel(text: "All Villagers", textAlignment: .left)
        header.addSubview(headerTitle)

        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 16

        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: header.topAnchor, constant: verticalPadding),
            headerTitle.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -verticalPadding),
            headerTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            headerTitle.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding)
        ])
        
        return header
    }
    
    // MARK: - Getting Data
    
    private func getVillagers(needsUpdate: Bool) {
        let ownedVillagers = villagers.filter { $0.isOwned }
        
        networkManager.getVillagersData() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let villagersDictionary):
                self.villagers = Array(villagersDictionary.values)
                    .sorted { $0.name < $1.name }
                    .map { entry -> Villager in
                        if needsUpdate {
                            entry.isOwned = ownedVillagers.first { $0.id == entry.id }?.isOwned ?? false
                        }
                        return entry
                    }
                
                if needsUpdate {
                    self.persistenceManager.delete(objectsOfType: Villager.self)
                }
                
                self.persistenceManager.store(objects: self.villagers)
                
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                
            case .failure(let error):
                self.presentAlert(title: "Something went wrong", message: error.rawValue)
                self.refreshControl?.endRefreshing()
                self.tableView.setContentOffset(.zero, animated: true)
            }
        }
    }
}
