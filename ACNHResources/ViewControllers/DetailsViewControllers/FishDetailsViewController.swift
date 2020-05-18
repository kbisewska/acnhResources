//
//  FishDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class FishDetailsViewController: UIViewController {

    private let customView = DetailsView()
    private var fish: Fish
    
    init(with fish: Fish) {
        self.fish = fish
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
        
        let allYear = "All Year"
        let allDay = "All Day"
        
        customView.resourceImageView.downloadIcon(for: .fish(id: fish.id))
        customView.resourceNameLabel.text = fish.name
        customView.resourceDetailsLabel.text = """
        Availability in the Northern Hemisphere: \(fish.availability.isAllYear ? allYear : fish.availability.monthNorthern?.convertMonths() ?? "")
        
        Availability in the Southern Hemisphere: \(fish.availability.isAllYear ? allYear : fish.availability.monthSouthern?.convertMonths() ?? "")
        
        Time: \(fish.availability.isAllDay ? allDay : fish.availability.time ?? "")
        
        Location: \(fish.availability.location)
        
        Rarity: \(fish.availability.rarity)
        
        Price: \(fish.price) Bells
        
        CJ's Price: \(fish.cjPrice) Bells
        """
    }
}
