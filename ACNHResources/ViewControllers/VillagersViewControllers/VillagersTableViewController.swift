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
    
    private let reuseIdentifier = "VillagerCell"
    private let persistenceManager = PersistenceManager()
    
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
    }
    
    func update(with villagers: [Villager]) {
        self.villagers = villagers
//        let ownedVillagers: [Villager]? = try? persistenceManager.retrieve(from: "OwnedVillagers")
//        self.ownedVillagers = ownedVillagers ?? []
        tableView.reloadData()
    }

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
}
