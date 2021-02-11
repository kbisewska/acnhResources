//
//  StateRefreshable.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 10/02/2021.
//  Copyright © 2021 kbisewska. All rights reserved.
//

import UIKit

protocol StateRefreshable: AnyObject {
    var refreshControl: UIRefreshControl? { get }
}

extension StateRefreshable where Self: UIViewController {
    
    func configureRefreshControl(forTableView tableView: UITableView, withAction action: Selector) {
        refreshControl?.addTarget(self, action: action, for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension StateRefreshable where Self: UITableViewController {
    
    func configureRefreshControl(withAction action: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: action, for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}
