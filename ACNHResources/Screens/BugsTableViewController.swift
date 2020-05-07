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
    var bugs = [Bug]()
    let reuseIdentifier = "BugCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        getBugs()
    }
    
    func getBugs() {
        networkManager.getBugData() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let bugsDictionary):
                let bugsList = Array(bugsDictionary.values).sorted { $0.id < $1.id }
                self.bugs = bugsList
                
                self.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bugs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let bug = bugs[indexPath.row]
        cell.textLabel?.text = bug.name
        return cell
    }
}
