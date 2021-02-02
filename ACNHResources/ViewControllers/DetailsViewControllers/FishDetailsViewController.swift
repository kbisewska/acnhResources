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
        Availability (Months): \(getAvailability())
        
        Time: \(fish.isAllDay ? allDay : fish.time ?? "")
        
        Location: \(fish.location)
        
        Rarity: \(fish.rarity)
        
        Price: \(fish.price) Bells
        
        CJ's Price: \(fish.cjPrice) Bells
        """
    }
    
    private func getAvailability() -> String {
        let allYear = "All Year"
        
        let hemisphereIndex: Int? = try? persistenceManager.retrieve(fromKey: "Hemisphere")
        let hemisphere = Hemisphere.allCases[hemisphereIndex ?? 0]
        
        switch hemisphere {
        case .north: return "\(fish.isAllYear ? allYear : fish.monthNorthern ?? "")"
        case .south: return "\(fish.isAllYear ? allYear : fish.monthSouthern ?? "")"
        }
    }
}
