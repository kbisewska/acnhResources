//
//  BugDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class BugDetailsViewController: UIViewController {

    private let customView = DetailsView().adjustedForAutoLayout()
    private var bug: Bug
    
    init(with bug: Bug) {
        self.bug = bug
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.widthAnchor.constraint(equalToConstant: 400),
            customView.heightAnchor.constraint(equalToConstant: 740)
        ])
        
        let allYear = "All Year"
        let allDay = "All Day"
        
        customView.resourceImageView.downloadIcon(for: .bug(id: bug.id))
        customView.resourceNameLabel.text = bug.name
        customView.resourceDetailsLabel.text = """
        Availability in the Northern Hemisphere: \(bug.availability.isAllYear ? allYear : bug.availability.monthNorthern?.convertMonths() ?? "")
        
        Availability in the Southern Hemisphere: \(bug.availability.isAllYear ? allYear : bug.availability.monthSouthern?.convertMonths() ?? "")
        
        Time: \(bug.availability.isAllDay ? allDay : bug.availability.time ?? "")
        
        Location: \(bug.availability.location)
        
        Rarity: \(bug.availability.rarity)
        
        Price: \(bug.price) Bells
        
        Flick's Price: \(bug.flickPrice) Bells
        """
    }
}
