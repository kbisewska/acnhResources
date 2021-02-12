//
//  BugsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class BugsViewController: UIViewController, NavigationBarCustomizable, StateRefreshable,  EmptyStateRepresentable, ContentSearchable, UISearchResultsUpdating {
    
    private let tableView = UITableView()
    private let reuseIdentifier = "BugCell"
    var refreshControl: UIRefreshControl? = UIRefreshControl()
    let emptyStateView = EmptyStateView()
    let searchController = UISearchController()
    
    var bugs = [Bug]()
    var filteredBugs = [Bug]()
    var isFiltering = false
    
    weak var ownedCountLabel: UILabel?
    var ownedCountLabelText: String {
        "You found \(bugs.filter { $0.isOwned }.count) out of \(bugs.count) bugs."
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure(tableView: tableView, cell: ResourceCell.self, with: reuseIdentifier)
        addNavigationItems(leftBarButtonTitle: "Sort", leftBarButtonAction: #selector(sortItems), rightBarButtonTitle: "Filter", rightBarButtonAction: #selector(filterItems))
        configureNavigationBar(forEnabledState: true, forViewController: self)
        configureRefreshControl(forTableView: tableView, withAction: #selector(refresh))
        configureEmptyStateView(for: self)
        configureSearchController(withPlaceholder: "Search for a resource")
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: Notification.Name("ResetData"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let bugsObjects = Current.persistenceManager.retrieve(objectsOfType: Bug.self)
        
        if bugsObjects.isEmpty {
            getBugs(needsUpdate: false)
        } else {
            bugs = bugsObjects.sorted { $0.name < $1.name }
            tableView.reloadData()
        }
    }
    
    // MARK: - Getting Data
    
    private func getBugs(needsUpdate: Bool) {
        let ownedBugs = bugs.filter { $0.isOwned }
        
        Current.networkManager.getBugsData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let bugsDictionary):
                self.bugs = Array(bugsDictionary.values)
                    .map { entry -> Bug in
                        entry.name = entry.name.capitalized
                        if needsUpdate {
                            entry.isOwned = ownedBugs.first { $0.id == entry.id }?.isOwned ?? false
                        }
                        return entry
                    }
                    .sorted { $0.name < $1.name }
                
                if needsUpdate {
                    Current.persistenceManager.delete(objectsOfType: Bug.self)
                }
                
                Current.persistenceManager.store(objects: self.bugs)
                
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                self.emptyStateView.isHidden = true
                self.configureNavigationBar(forEnabledState: true, forViewController: self)

            case .failure(let error):
                if needsUpdate {
                    self.presentAlert(title: "Something went wrong", message: error.rawValue)
                    self.refreshControl?.endRefreshing()
                } else {
                    self.presentEmptyStateView(withMessage: error.rawValue, withAction: #selector(self.tryAgainButtonTapped))
                    self.configureNavigationBar(forEnabledState: false, forViewController: self)
                    self.refreshControl = nil
                }
            }
        }
    }
    
    // MARK: - Sorting Items
    
    @objc private func sortItems() {
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

    // MARK: - Filtering Items
    
    @objc private func filterItems() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Show only found items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredBugs = self.bugs.filter { $0.isOwned }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show only undiscovered items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredBugs = self.bugs.filter { !$0.isOwned }
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
        
    // MARK: - Searching Items
    
    func updateSearchResults(for searchController: UISearchController) {
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
    
    // MARK: - Selectors
    
    @objc func refresh() {
        getBugs(needsUpdate: true)
    }
    
    @objc func resetData() {
        Current.persistenceManager.delete(objectsOfType: Bug.self)
        bugs = []
        filteredBugs = []
        
        tableView.reloadData()
    }
    
    @objc func tryAgainButtonTapped() {
        getBugs(needsUpdate: false)
        configureRefreshControl(forTableView: tableView, withAction: #selector(refresh))
    }
}

// MARK: - Table View Configuration

extension BugsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredBugs.count : bugs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeBugsArray = isFiltering ? filteredBugs : bugs
        let bug = activeBugsArray[indexPath.row]
        
        var selectionState = bug.isOwned
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            Current.persistenceManager.update {
                bug.isOwned = !bug.isOwned
            }
            
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
            
            self.ownedCountLabel?.text = self.ownedCountLabelText
        }
        
        let resource = Resource.bug(id: bug.id)
        cell.resourceNameLabel.text = bug.name
        cell.configure(with: resource)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeBugsArray = isFiltering ? filteredBugs : bugs
        
        let bugDetailsViewController = BugDetailsViewController(with: activeBugsArray[indexPath.row])
        presentViewController(bugDetailsViewController)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
}
