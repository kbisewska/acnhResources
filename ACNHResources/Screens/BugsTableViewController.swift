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
    var ownedItems = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)

        getBugs()
    }
    
    func getBugs() {
        networkManager.getBugsData() { [weak self] result in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ResourceCell
        let bug = bugs[indexPath.row]
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
        cell.resourceNameLabel.text = "\(bug.id). \(bug.name)"
        cell.resourceImageView.downloadIcon(for: .bug(id: bug.id))
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
