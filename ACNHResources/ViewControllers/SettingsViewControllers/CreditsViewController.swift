//
//  CreditsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 25/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class CreditsViewController: UIViewController {
    
    private let scrollView = UIScrollView().adjustedForAutoLayout()
    private let customView = CreditsView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        
        customView.titleLabel.text = "Credits"
        customView.firstCreditsLabel.text = "All data images used in this app are the sole property of Nintendo."
        customView.secondCreditsLabel.text = "Data used in the app come from ACNH API (http://acnhapi.com)."
        customView.thirdCreditsLabel.text = "Tab bar icons made by Freepik, Smashicons, and Vitaly Gorbachev from www.flaticon.com."
    }
}
