//
//  UIViewController+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 26/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view.adjustedForAutoLayout())
        child.didMove(toParent: self)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func presentViewController(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissViewController))
            viewController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
}

extension UIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configure(tableView: UITableView, cell: AnyClass, with identifier: String) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cell.self, forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
        tableView.adjustedForAutoLayout().pinToEdges(of: view)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
