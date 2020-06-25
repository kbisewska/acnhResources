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
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.widthAnchor.constraint(equalToConstant: 320),
            customView.heightAnchor.constraint(equalToConstant: 550),
        ])
        
        let allDay = "All Day"
        
        customView.resourceImageView.downloadIcon(for: .bug(id: bug.id))
        customView.resourceNameLabel.text = bug.name
        customView.resourceDetailsLabel.text = """
        Availability: \(availability(northern: true))
        
        Time: \(bug.availability.isAllDay ? allDay : bug.availability.time ?? "")
        
        Location: \(bug.availability.location)
        
        Rarity: \(bug.availability.rarity)
        
        Price: \(bug.price) Bells
        
        Flick's Price: \(bug.flickPrice) Bells
        """
    }
    
    // Temporary Solution
    func availability(northern: Bool) -> String {
        let allYear = "All Year"
        
        if northern {
            return "\(bug.availability.isAllYear ? allYear : bug.availability.monthNorthern?.convertMonths() ?? "")"
        } else {
            return "\(bug.availability.isAllYear ? allYear : bug.availability.monthSouthern?.convertMonths() ?? "")"
        }
    }
}
