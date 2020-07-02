//
//  OwnedVillagerCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 19/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class VillagerCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier = "VillagerCell"
    
    var nameLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        return label
    }()
    
    var birthdayLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        return label
    }()
    
    var villagerImageView: UIImageView = {
        let imageView = UIImageView().adjustedForAutoLayout()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubviews(nameLabel, birthdayLabel, villagerImageView)
        
        let padding: CGFloat = 14
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -padding),
            
            birthdayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: padding),
            
            villagerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            villagerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            villagerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            villagerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    func configure(with villager: Villager) {
        nameLabel.text = "Name: \(villager.name)"
        birthdayLabel.text = "Birthday: \(villager.birthday)"
        villagerImageView.downloadIcon(for: .villager(id: villager.id))
    }
}
