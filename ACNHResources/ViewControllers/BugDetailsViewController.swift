//
//  BugDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class BugDetailsViewController: UIViewController {

    private let customView = DetailsView()
    private var bug: Bug
    
    init(with bug: Bug) {
        self.bug = bug
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.resourceImageView.downloadImage(for: .bug(id: bug.id))
        customView.resourceNameLabel.text = "Name: \(bug.name)"
        customView.resourceDetailsLabel.text = """
        Availability in the Northern Hemisphere: \(bug.availability.monthNorthern ?? "")
        Availability in the Southern Hemisphere: \(bug.availability.monthSouthern ?? "")
        Time: \(bug.availability.time ?? "")
        Location: \(bug.availability.location)
        Rarity: \(bug.availability.rarity)
        Price: \(bug.price) Bells
        Flick's Price: \(bug.flickPrice) Bells
        """
    }
}
