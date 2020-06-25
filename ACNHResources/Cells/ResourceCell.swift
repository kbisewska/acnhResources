//
//  ResourceCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 07/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {
    
    private var resource: Resource?
    
    var activityIndicator: UIActivityIndicatorView = {
        UIActivityIndicatorView().adjustedForAutoLayout()
    }()
    
    var checkmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 8, bottom: 9, right: 8)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .systemIndigo
        return button
    }()
    
    var resourceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var resourceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resourceImageView.image = nil
        
        if let resource = resource {
            resourceImageView.cancelTask(for: resource)
            self.resource = nil
        }
    }
    
    @objc func checkmarkButtonTapped(_ sender: UIButton) {
        checkmarkButtonAction?()
    }
    
    var checkmarkButtonAction: (() -> ())?
    
    func configure(with resource: Resource) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        switch resource {
        case .villager, .fish, .bug:
            resourceImageView.downloadIcon(for: resource, completion: { [weak activityIndicator] in
                activityIndicator?.isHidden = true
                activityIndicator?.stopAnimating()
            })
            
        case .fossil:
            resourceImageView.downloadImage(for: resource, completion: { [weak activityIndicator] in
                activityIndicator?.isHidden = true
                activityIndicator?.stopAnimating()
            })
        }
        
        accessoryType = .disclosureIndicator
        self.resource = resource
    }
    
    func configure(forSelectionState isSelected: Bool) {
        let stateImage = isSelected ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        checkmarkButton.setImage(stateImage, for: .normal)
    }
    
    private func configureLayout() {
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(resourceImageView)
        contentView.addSubview(resourceNameLabel)
        contentView.addSubview(activityIndicator)
        
        let horizontalPadding: CGFloat = 16
        let verticalPadding: CGFloat = 2
        
        let resourceImageViewHeightAnchor = resourceImageView.heightAnchor.constraint(equalToConstant: 76)
        resourceImageViewHeightAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 44),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 44),
            
            resourceNameLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: horizontalPadding),
            resourceNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            resourceImageView.leadingAnchor.constraint(greaterThanOrEqualTo: resourceNameLabel.trailingAnchor, constant: horizontalPadding),
            resourceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 2 * -horizontalPadding),
            resourceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            resourceImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            resourceImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.08),
            resourceImageViewHeightAnchor,
            
            activityIndicator.centerXAnchor.constraint(equalTo: resourceImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: resourceImageView.centerYAnchor)
        ])
    }
}
