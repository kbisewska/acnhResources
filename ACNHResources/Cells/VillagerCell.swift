//
//  VillagerCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 20/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class VillagerCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier = "VillagerCell"
    
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
    
    var villagerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var villagerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    private func configureLayout() {
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(villagerImageView)
        contentView.addSubview(villagerNameLabel)
        
        let horizontalPadding: CGFloat = 16
        let verticalPadding: CGFloat = 2
        
        let resourceImageViewHeightAnchor = villagerImageView.heightAnchor.constraint(equalToConstant: 76)
        resourceImageViewHeightAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 44),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 44),
            
            villagerNameLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: horizontalPadding),
            villagerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            villagerImageView.leadingAnchor.constraint(greaterThanOrEqualTo: villagerNameLabel.trailingAnchor, constant: horizontalPadding),
            villagerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
            villagerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            villagerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            villagerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            resourceImageViewHeightAnchor
        ])
    }
    
    func configure(with villager: Villager) {
        villagerNameLabel.text = villager.name
        villagerImageView.downloadIcon(for: .villager(id: villager.id))
    }
}
