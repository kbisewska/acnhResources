//
//  FossilsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class FossilsTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager()
    private let persistenceManager = PersistenceManager()
    private let reuseIdentifier = "FossilCell"
    
    var fossils = [Fossil]()
    var filteredFossils = [Fossil]()
    var isFiltering = false
    var ownedFossils = [Fossil]() {
        didSet {
            ownedCountLabel?.text = "You found \(ownedFossils.count) out of \(fossils.count) fossils."
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
        getFossils()
    }
    
    func getFossils() {
        networkManager.getFossilsData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fossilsDictionary):
                let fossilsList = Array(fossilsDictionary.values).sorted { $0.fileName.lowercased() < $1.fileName.lowercased() }
                self.fossils = fossilsList
                
                let ownedFossils: [Fossil]? = try? self.persistenceManager.retrieve(from: "OwnedFossils")
                self.ownedFossils = ownedFossils ?? []
                
                self.tableView.reloadData()

            case .failure(let error):
                self.presentAlert(with: error.rawValue)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredFossils.count : fossils.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeFossilsArray = isFiltering ? filteredFossils : fossils
        let fossil = activeFossilsArray[indexPath.row]
        
        var selectionState = ownedFossils.contains(fossil)
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            selectionState ? self.ownedFossils.removeAll(where: { $0.fileName == fossil.fileName }) : self.ownedFossils.append(fossil)
            try? self.persistenceManager.store(value: self.ownedFossils, with: "OwnedFossils")
            
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
        }
        
        let resource = Resource.fossil(fileName: fossil.fileName)
        cell.resourceNameLabel.text = fossil.name
        cell.configure(with: resource)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeFossilsArray = isFiltering ? filteredFossils : fossils
        
        let fossilDetailsViewController = FossilDetailsViewController(with: activeFossilsArray[indexPath.row])
        present(fossilDetailsViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemIndigo
        
        let headerTitle = UILabel()
        headerTitle.text = "You found \(ownedFossils.count) out of \(fossils.count) fossils."
        headerTitle.textColor = .white
        headerTitle.textAlignment = .center
        headerTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
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
            self.filteredFossils = self.ownedFossils
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show only undiscovered items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredFossils = self.fossils.filter { !self.ownedFossils.contains($0) }
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
            self.fossils.sort { $0.name < $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by name: Z to A", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fossils.sort { $0.name > $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: low to high", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fossils.sort { $0.price < $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: high to low", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fossils.sort { $0.price > $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
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
}
