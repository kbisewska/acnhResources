//
//  SelfConfiguringCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 20/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    
    static var reuseIdentifier: String { get }
    
    func configure(with villager: Villager)
}
