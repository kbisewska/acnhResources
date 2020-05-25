//
//  OwnedVillagerCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 19/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class VillagerCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier = "VillagerCell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        return label
    }()
    
    var birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        return label
    }()
    
    var villagerImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, birthdayLabel, villagerImageView]).adjustedForAutoLayout()
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with villager: Villager) {
        nameLabel.text = "Name: \(villager.name)"
        birthdayLabel.text = "Birthday: \(villager.birthday)"
        villagerImageView.downloadIcon(for: .villager(id: villager.id))
    }
}
