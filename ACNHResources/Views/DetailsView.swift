//
//  DetailsView.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 13/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class DetailsView: UIView {
    
    lazy var resourceImageView: UIImageView = {
        let imageView = UIImageView().adjustedForAutoLayout()
        return imageView
    }()
    
    lazy var resourceNameLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    lazy var resourceDetailsLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.numberOfLines = 0
        return label
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
        
        addSubviews(resourceImageView, resourceNameLabel, resourceDetailsLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            resourceImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            resourceImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            resourceImageView.heightAnchor.constraint(equalToConstant: 300),
            resourceImageView.widthAnchor.constraint(equalToConstant: 300),
            
            resourceNameLabel.topAnchor.constraint(equalTo: resourceImageView.bottomAnchor, constant: padding),
            resourceNameLabel.leadingAnchor.constraint(equalTo: resourceImageView.leadingAnchor),
            resourceNameLabel.trailingAnchor.constraint(equalTo: resourceImageView.trailingAnchor),
            
            resourceDetailsLabel.topAnchor.constraint(equalTo: resourceNameLabel.bottomAnchor, constant: padding),
            resourceDetailsLabel.leadingAnchor.constraint(equalTo: resourceImageView.leadingAnchor),
            resourceDetailsLabel.trailingAnchor.constraint(equalTo: resourceImageView.trailingAnchor),
        ])
    }
}
