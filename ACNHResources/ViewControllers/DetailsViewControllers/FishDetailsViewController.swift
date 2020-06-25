//
//  FishDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class FishDetailsViewController: UIViewController {

    private let customView = DetailsView().adjustedForAutoLayout()
    private var fish: Fish
    
    init(with fish: Fish) {
        self.fish = fish
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
            customView.heightAnchor.constraint(equalToConstant: 530),
        ])
        
        
        let allDay = "All Day"
        
        customView.resourceImageView.downloadIcon(for: .fish(id: fish.id))
        customView.resourceNameLabel.text = fish.name
        customView.resourceDetailsLabel.text = """
        Availability: \(availability(northern: true))
        
        Time: \(fish.availability.isAllDay ? allDay : fish.availability.time ?? "")
        
        Location: \(fish.availability.location)
        
        Rarity: \(fish.availability.rarity)
        
        Price: \(fish.price) Bells
        
        CJ's Price: \(fish.cjPrice) Bells
        """
    }
    
    // Temporary Solution
    func availability(northern: Bool) -> String {
        let allYear = "All Year"
        
        if northern {
            return "\(fish.availability.isAllYear ? allYear : fish.availability.monthNorthern?.convertMonths() ?? "")"
        } else {
            return "\(fish.availability.isAllYear ? allYear : fish.availability.monthSouthern?.convertMonths() ?? "")"
        }
    }
}
