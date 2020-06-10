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
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var separator: UIView = {
        let view = UIView().adjustedForAutoLayout()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    lazy var resourceNameLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .systemIndigo
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var resourceDetailsLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
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
        layer.cornerRadius = 20
        layer.borderWidth = 6
        layer.borderColor = UIColor.systemIndigo.cgColor
        
        addSubviews(resourceImageView, separator, resourceNameLabel, resourceDetailsLabel)
        
        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            resourceImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            resourceImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            resourceImageView.heightAnchor.constraint(equalToConstant: 200),
            resourceImageView.widthAnchor.constraint(equalToConstant: 200),
            
            resourceNameLabel.topAnchor.constraint(equalTo: resourceImageView.bottomAnchor, constant: padding),
            resourceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            resourceNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            separator.topAnchor.constraint(equalTo: resourceNameLabel.bottomAnchor, constant: padding),
            separator.leadingAnchor.constraint(equalTo: resourceNameLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: resourceNameLabel.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            resourceDetailsLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: padding),
            resourceDetailsLabel.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            resourceDetailsLabel.trailingAnchor.constraint(equalTo: separator.trailingAnchor),
        ])
    }
}
