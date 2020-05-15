//
//  FossilDetailsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class FossilDetailsViewController: UIViewController {
    
    private let customView = DetailsView()
    private var fossil: Fossil
    
    init(with fossil: Fossil) {
        self.fossil = fossil
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
        
        customView.resourceImageView.downloadImage(for: .fossil(fileName: fossil.fileName))
        customView.resourceNameLabel.text = "Name: \(fossil.name)"
        customView.resourceDetailsLabel.text = "Price: \(fossil.price)"
    }
}
