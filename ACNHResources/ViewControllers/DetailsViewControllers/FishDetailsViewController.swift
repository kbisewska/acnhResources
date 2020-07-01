//
//  FishDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class FishDetailsViewController: UIViewController {

    private let persistenceManager = PersistenceManager()
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
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.widthAnchor.constraint(equalToConstant: 320),
            customView.heightAnchor.constraint(equalToConstant: 530),
        ])
        
        customView.resourceImageView.downloadIcon(for: .fish(id: fish.id))
        customView.resourceNameLabel.text = fish.name
        
        let allDay = "All Day"
        
        customView.resourceDetailsLabel.text = """
        Availability: \(getAvailability())
        
        Time: \(fish.availability.isAllDay ? allDay : fish.availability.time ?? "")
        
        Location: \(fish.availability.location)
        
        Rarity: \(fish.availability.rarity)
        
        Price: \(fish.price) Bells
        
        CJ's Price: \(fish.cjPrice) Bells
        """
    }
    
    private func getAvailability() -> String {
        let allYear = "All Year"
        let hemisphere: Hemisphere? = try? persistenceManager.retrieve(from: "Hemisphere")
        
        switch hemisphere {
        case .north: return "\(fish.availability.isAllYear ? allYear : fish.availability.monthNorthern ?? "")"
        case .south: return "\(fish.availability.isAllYear ? allYear : fish.availability.monthSouthern ?? "")"
        case .none: return ""
        }
    }
}
