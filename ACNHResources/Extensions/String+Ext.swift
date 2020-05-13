//
//  String+Ext.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}
