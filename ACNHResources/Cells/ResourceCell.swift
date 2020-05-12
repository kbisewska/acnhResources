//
//  ResourceCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 07/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {
    
    var checkmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        return button
    }()
    
    var resourceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var resourceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "questionmark.square")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonTapped(_:)), for: .touchUpInside)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkmarkButtonTapped(_ sender: UIButton) {
        checkmarkButtonAction?()
    }
    
    var checkmarkButtonAction: (() -> ())?
    
    // FIXME: Fix issues with constraints
    
    private func configureLayout() {
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(resourceImageView)
        contentView.addSubview(resourceNameLabel)
        
        let horizontalPadding: CGFloat = 16
        let verticalPadding: CGFloat = 2
        
        NSLayoutConstraint.activate([
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.07),
            checkmarkButton.heightAnchor.constraint(equalTo: checkmarkButton.widthAnchor),
            
            resourceNameLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: horizontalPadding),
            resourceNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            resourceImageView.leadingAnchor.constraint(greaterThanOrEqualTo: resourceNameLabel.trailingAnchor, constant: horizontalPadding),
            resourceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
            resourceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            resourceImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            resourceImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            resourceImageView.heightAnchor.constraint(equalTo: resourceImageView.widthAnchor)
        ])
    }
}
