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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let fishItem = fish[indexPath.row]
        cell.textLabel?.text = fishItem.name
        return cell
    }
}

