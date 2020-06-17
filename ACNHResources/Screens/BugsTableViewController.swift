//
//  BugsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class BugsTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager()
    private let persistenceManager = PersistenceManager()
    private let reuseIdentifier = "BugCell"
    
    var bugs = [Bug]()
    var filteredBugs = [Bug]()
    var isFiltering = false
    var ownedBugs = [Bug]() {
        didSet {
            ownedCountLabel?.text = "You found \(ownedBugs.count) out of \(bugs.count) bugs."
        }
    }
    weak var ownedCountLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortItems))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterItems))
        
        tableView.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        configureSearchController()
        getBugs()
    }
    
    func getBugs() {
        networkManager.getBugsData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let bugsDictionary):
                let bugsList = Array(bugsDictionary.values).sorted { $0.id < $1.id }
                self.bugs = bugsList
                
                let ownedBugs: [Bug]? = try? self.persistenceManager.retrieve(from: "OwnedBugs")
                self.ownedBugs = ownedBugs ?? []
                
                self.tableView.reloadData()

            case .failure(let error):
                self.presentAlert(with: error.rawValue)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredBugs.count : bugs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeBugsArray = isFiltering ? filteredBugs : bugs
        let bug = activeBugsArray[indexPath.row]
        
        var selectionState = ownedBugs.contains(bug)
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            selectionState ? self.ownedBugs.removeAll(where: { $0.id == bug.id }) : self.ownedBugs.append(bug)
            try? self.persistenceManager.store(value: self.ownedBugs, with: "OwnedBugs")
            
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
        }
        
        let resource = Resource.bug(id: bug.id)
        cell.resourceNameLabel.text = bug.name
        cell.configure(with: resource)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeBugsArray = isFiltering ? filteredBugs : bugs
        
        let bugDetailsViewController = BugDetailsViewController(with: activeBugsArray[indexPath.row])
        presentViewController(bugDetailsViewController)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemIndigo
        
        let headerTitle = UILabel().adjustedForAutoLayout()
        headerTitle.configureHeaderLabel(text: "You found \(ownedBugs.count) out of \(bugs.count) bugs.", textAlignment: .center)
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
    
    @objc func filterItems() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Show only found items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredBugs = self.ownedBugs
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show only undiscovered items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredBugs = self.bugs.filter { !self.ownedBugs.contains($0) }
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
    
    @objc func sortItems() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sort by name: A to Z", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredBugs.sort { $0.name < $1.name } : self.bugs.sort { $0.name < $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by name: Z to A", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredBugs.sort { $0.name > $1.name } : self.bugs.sort { $0.name > $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: low to high", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredBugs.sort { $0.price < $1.price } : self.bugs.sort { $0.price < $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: high to low", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredBugs.sort { $0.price > $1.price } : self.bugs.sort { $0.price > $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isFiltering = false
            filteredBugs.removeAll()
            tableView.reloadData()
            return
        }
        
        isFiltering = true
        filteredBugs = bugs.filter { $0.name.lowercased().contains(filter.lowercased()) }
        tableView.reloadData()
    }
}
