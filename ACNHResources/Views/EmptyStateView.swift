//
//  EmptyStateView.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 08/02/2021.
//  Copyright © 2021 kbisewska. All rights reserved.
//

import UIKit

final class EmptyStateView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.text = "Oops..."
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .systemIndigo
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton().adjustedForAutoLayout()
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.backgroundColor = .systemIndigo
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .systemBackground
        
        addSubviews(titleLabel, detailsLabel, tryAgainButton)
        
        let verticalPadding: CGFloat = 64
        let horizontalPadding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: verticalPadding),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalPadding),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            detailsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tryAgainButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: verticalPadding),
            //tryAgainButton.heightAnchor.constraint(equalToConstant: 60),
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
