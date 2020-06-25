//
//  FossilDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class FossilDetailsViewController: UIViewController {
    
    private let customView = DetailsView().adjustedForAutoLayout()
    private var fossil: Fossil
    
    init(with fossil: Fossil) {
        self.fossil = fossil
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
            customView.widthAnchor.constraint(equalToConstant: 320),
            customView.heightAnchor.constraint(equalToConstant: 306)
        ])
        
        customView.resourceImageView.downloadImage(for: .fossil(fileName: fossil.fileName))
        customView.resourceNameLabel.text = fossil.name
        customView.resourceDetailsLabel.text = "Price: \(fossil.price)"
    }
}
