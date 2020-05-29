//
//  ViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 05/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class FishTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager()
    let reuseIdentifier = "FishCell"
    
    var fish = [Fish]()
    var filteredFish = [Fish]()
    var isFiltering = false
    var ownedFish = [Fish]() {
        didSet {
            ownedCountLabel?.text = "You found \(ownedFish.count) out of \(fish.count) fish."
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
        getFish()
    }

    func getFish() {
        networkManager.getFishData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fishDictionary):
                let fishList = Array(fishDictionary.values).sorted { $0.id < $1.id }
                self.fish = fishList
                
                self.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredFish.count : fish.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let activeFishArray = isFiltering ? filteredFish : fish
        let fishItem = activeFishArray[indexPath.row]
        
        var selectionState = ownedFish.contains(fishItem)
        cell.configure(forSelectionState: selectionState)
        
        cell.checkmarkButtonAction = { [unowned self] in
            selectionState ? self.ownedFish.removeAll(where: { $0.id == fishItem.id }) : self.ownedFish.append(fishItem)
            let updatedState = !selectionState
            cell.configure(forSelectionState: updatedState)
            selectionState = updatedState
        }
        
        let resource = Resource.fish(id: fishItem.id)
        cell.resourceNameLabel.text = fishItem.name
        cell.configure(with: resource)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeFishArray = isFiltering ? filteredFish : fish
        
        let fishDetailsViewController = FishDetailsViewController(with: activeFishArray[indexPath.row])
        present(fishDetailsViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemIndigo
        
        let headerTitle = UILabel()
        headerTitle.text = "You found \(ownedFish.count) out of \(fish.count) fish."
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
            self.filteredFish = self.ownedFish
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Show only undiscovered items", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isFiltering = true
            self.filteredFish = self.fish.filter { !self.ownedFish.contains($0) }
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
            self.fish.sort { $0.name < $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by name: Z to A", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fish.sort { $0.name > $1.name }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: low to high", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fish.sort { $0.price < $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Sort by price: high to low", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fish.sort { $0.price > $1.price }
            self.tableView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
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

