//
//  EmptyStateRepresentable.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 10/02/2021.
//  Copyright © 2021 kbisewska. All rights reserved.
//

import UIKit

protocol EmptyStateRepresentable: AnyObject {
    var emptyStateView: EmptyStateView { get }
}

extension EmptyStateRepresentable where Self: UIViewController {
    
    func configureEmptyStateView(for viewController: UIViewController?) {
        if let view = viewController?.view {
            emptyStateView.isHidden = true
            view.addSubview(emptyStateView)
            emptyStateView.adjustedForAutoLayout().pinToEdges(of: view)
        }
    }
    
    func presentEmptyStateView(withMessage message: String, withAction action: Selector) {
        emptyStateView.detailsLabel.text = message
        emptyStateView.tryAgainButton.addTarget(self, action: action, for: .touchUpInside)
        emptyStateView.isHidden = false
    }
}
