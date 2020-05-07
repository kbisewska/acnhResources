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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        getFossils()
    }
    
    func getFossils() {
        networkManager.getFossilData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fossilsDictionary):
                let fossilsList = Array(fossilsDictionary.values).sorted { $0.fileName.lowercased() < $1.fileName.lowercased() }
                self.fossils = fossilsList
                
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let fossil = fossils[indexPath.row]
        cell.textLabel?.text = fossil.name
        return cell
    }
}
