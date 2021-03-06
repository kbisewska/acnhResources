//
//  BugDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class BugDetailsViewController: UIViewController {

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
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.widthAnchor.constraint(equalToConstant: 320),
            customView.heightAnchor.constraint(equalToConstant: 550),
        ])
        
        customView.resourceImageView.downloadIcon(for: .bug(id: bug.id))
        customView.resourceNameLabel.text = bug.name
        
        let allDay = "All Day"
        
        customView.resourceDetailsLabel.text = """
        Availability (Months): \(getAvailability())
        
        Time: \(bug.isAllDay ? allDay : bug.time ?? "")
        
        Location: \(bug.location)
        
        Rarity: \(bug.rarity)
        
        Price: \(bug.price) Bells
        
        Flick's Price: \(bug.flickPrice) Bells
        """
    }
    
    private func getAvailability() -> String {
        let allYear = "All Year"
        
        let hemisphereIndex: Int? = try? Current.persistenceManager.retrieve(fromKey: "Hemisphere")
        let hemisphere = Hemisphere.allCases[hemisphereIndex ?? 0]
        
        switch hemisphere {
        case .north: return "\(bug.isAllYear ? allYear : bug.monthNorthern ?? "")"
        case .south: return "\(bug.isAllYear ? allYear : bug.monthSouthern ?? "")"
        }
    }
}
