//
//  EmptyStateView.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 08/02/2021.
//  Copyright © 2021 kbisewska. All rights reserved.
//

import UIKit

final class EmptyStateView: UIView {
    
    lazy var errorImage: UIImageView = {
        let imageView = UIImageView().adjustedForAutoLayout()
        imageView.image = UIImage(named: "error")
        imageView.alpha = 0.7
        return imageView
    }()
    
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
        
        addSubviews(errorImage, titleLabel, detailsLabel, tryAgainButton)
        
        let padding: CGFloat = 16
        let verticalPadding: CGFloat = 64
        
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            errorImage.bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.topAnchor, constant: -verticalPadding),
            errorImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            errorImage.heightAnchor.constraint(equalTo: errorImage.widthAnchor),
            errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalPadding / 2),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            detailsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tryAgainButton.topAnchor.constraint(lessThanOrEqualTo: detailsLabel.bottomAnchor, constant: verticalPadding),
            tryAgainButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
