//
//  FossilsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class FossilsViewController: UIViewController, NavigationBarCustomizable, StateRefreshable, EmptyStateRepresentable, ContentSearchable, UISearchResultsUpdating {
    
    private let tableView = UITableView()
    private let reuseIdentifier = "FossilCell"
    let refreshControl = UIRefreshControl()
    let emptyStateView = EmptyStateView()
    let searchController = UISearchController()
    
    var fossils = [Fossil]()
    var filteredFossils = [Fossil]()
    var isFiltering = false
    
    weak var ownedCountLabel: UILabel?
    var ownedCountLabelText: String {
        "You found \(fossils.filter { $0.isOwned }.count) out of \(fossils.count) fossils."
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(tableView: tableView, cell: ResourceCell.self, with: reuseIdentifier)
        addNavigationItems(leftBarButtonTitle: "Sort", leftBarButtonAction: #selector(sortItems), rightBarButtonTitle: "Filter", rightBarButtonAction: #selector(filterItems))
        configureNavigationBar(forEnabledState: true)
        configureRefreshControl(forTableView: tableView, withAction: #selector(refresh))
        configureEmptyStateView()
        configureSearchController(withPlaceholder: "Search for a resource")
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: Notification.Name("ResetData"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let fossilObjects = Current.persistenceManager.retrieve(objectsOfType: Fossil.self)
        
        if fossilObjects.isEmpty {
            getFossils(needsUpdate: false)
        } else {
            fossils = fossilObjects.sorted { $0.name < $1.name }
            tableView.reloadData()
        }
    }
    
    // MARK: - Getting Data
    
    private func getFossils(needsUpdate: Bool) {
        let ownedFossils = fossils.filter { $0.isOwned }
        
        Current.networkManager.getFossilsData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fossilsDictionary):
                self.fossils = Array(fossilsDictionary.values)
                    .map { entry -> Fossil in
                        entry.name = entry.name.capitalized
                        if needsUpdate {
                            entry.isOwned = ownedFossils.first { $0.fileName == entry.fileName }?.isOwned ?? false
                        }
                        return entry
                    }
                    .sorted { $0.fileName < $1.fileName }
                
                if needsUpdate {
                    Current.persistenceManager.delete(objectsOfType: Fossil.self)
                }
                
                Current.persistenceManager.store(objects: self.fossils)
                
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                self.emptyStateView.isHidden = true
                self.configureNavigationBar(forEnabledState: true)

            case .failure(let error):
                if needsUpdate {
                    self.presentAlert(title: "Something went wrong", message: error.rawValue)
                    self.tableView.refreshControl?.endRefreshing()
                } else {
                    self.presentEmptyStateView(withMessage: error.rawValue, withAction: #selector(self.tryAgainButtonTapped))
                    self.configureNavigationBar(forEnabledState: false)
                    self.tableView.refreshControl = nil
                }
            }
        }
    }
        
    // MARK: - Sorting Items
    
    @objc private func sortItems() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sort by name: A to Z", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFossils.sort { $0.name < $1.name } : self.fossils.sort { $0.name < $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by name: Z to A", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFossils.sort { $0.name > $1.name } : self.fossils.sort { $0.name > $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: low to high", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFossils.sort { $0.price < $1.price } : self.fossils.sort { $0.price < $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: high to low", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering ? self.filteredFossils.sort { $0.price > $1.price } : self.fossils.sort { $0.price > $1.price }
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
            self.filteredFossils = self.fossils.filter { $0.isOwned }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show only undiscovered items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredFossils = self.fossils.filter { !$0.isOwned }
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
            filteredFossils.removeAll()
            tableView.reloadData()
            return
        }
        
        isFiltering = true
        filteredFossils = fossils.filter { $0.name.lowercased().contains(filter.lowercased()) }
        tableView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func refresh() {
        getFossils(needsUpdate: true)
    }
    
    @objc func resetData() {
        Current.persistenceManager.delete(objectsOfType: Fossil.self)
        fossils = []
        filteredFossils = []
        
        tableView.reloadData()
    }
    
    @objc func tryAgainButtonTapped() {
        getFossils(needsUpdate: false)
        configureRefreshControl(forTableView: tableView, withAction: #selector(refresh))
    }
}

// MARK: - Table View Configuration

extension FossilsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredFossils.count : fossils.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeFossilsArray = isFiltering ? filteredFossils : fossils
        let fossil = activeFossilsArray[indexPath.row]
        
        var selectionState = fossil.isOwned
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            Current.persistenceManager.update {
                fossil.isOwned = !fossil.isOwned
            }
            
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
            
            self.ownedCountLabel?.text = self.ownedCountLabelText
        }
        
        let resource = Resource.fossil(fileName: fossil.fileName)
        cell.resourceNameLabel.text = fossil.name
        cell.configure(with: resource)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeFossilsArray = isFiltering ? filteredFossils : fossils
        
        let fossilDetailsViewController = FossilDetailsViewController(with: activeFossilsArray[indexPath.row])
        presentViewController(fossilDetailsViewController)
        
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
