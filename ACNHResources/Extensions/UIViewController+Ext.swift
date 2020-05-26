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
}
