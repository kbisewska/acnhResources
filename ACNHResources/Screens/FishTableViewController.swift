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
    var fish = [Fish]()
    let reuseIdentifier = "FishCell"
    var ownedItems = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)
        
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
        fish.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let fishItem = fish[indexPath.row]
        var isItemChecked = false
        
        cell.checkmarkButtonAction = { [unowned self] in
            if !isItemChecked {
                self.ownedItems += 1
                cell.checkmarkButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
                isItemChecked.toggle()
            } else {
                self.ownedItems -= 1
                cell.checkmarkButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
                isItemChecked.toggle()
            }
        }
        cell.resourceNameLabel.text = "\(fishItem.id). \(fishItem.name)"
        cell.resourceImageView.downloadIcon(for: .fish(id: fishItem.id))
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

