//
//  CreditsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 25/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    private let scrollView = UIScrollView().adjustedForAutoLayout()
    private let customView = CreditsView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    func configureLayout() {
        view.backgroundColor = .systemBackground
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(customView)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//            customView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            customView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            customView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            customView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            customView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            customView.heightAnchor.constraint(equalToConstant: 320)
//        ])
        
        customView.titleLabel.text = "Credits"
        customView.firstCreditsLabel.text = "All data images used in this app are the sole property of Nintendo."
        customView.secondCreditsLabel.text = "Data used in the app come from ACNH API (http://acnhapi.com)."
        customView.thirdCreditsLabel.text = "Tab bar icons made by Freepik and Vitaly Gorbachev from www.flaticon.com."
    }
}
