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
    var fossils = [Fossil]()
    let reuseIdentifier = "FossilCell"
    var ownedItems = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)

        getFossils()
    }
    
    func getFossils() {
        networkManager.getFossilsData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fossilsDictionary):
                let fossilsList = Array(fossilsDictionary.values).sorted { $0.fileName.lowercased() < $1.fileName.lowercased() }
                self.fossils = fossilsList
                print(self.fossils)
                
                self.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fossils.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let fossil = fossils[indexPath.row]
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
        cell.resourceNameLabel.text = "\(indexPath.row + 1). \(fossil.name)"
        cell.resourceImageView.downloadImage(for: .fossil(fileName: fossil.fileName))
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
