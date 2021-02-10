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
