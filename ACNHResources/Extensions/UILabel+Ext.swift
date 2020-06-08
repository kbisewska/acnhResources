//
//  UILabel+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 08/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

extension UILabel {
    
    func configureHeaderLabel(text: String, textAlignment: NSTextAlignment) {
        self.text = text
        self.textColor = .white
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: .title3)
    }
}
