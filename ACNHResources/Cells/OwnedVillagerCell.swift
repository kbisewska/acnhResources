//
//  OwnedVillagerCell.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 19/05/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class OwnedVillagerCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseIdentifier = "OwnedVillagerCell"
    
    var separator: UIView = {
        let view = UIView(frame: .zero).adjustedForAutoLayout()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .label
        return label
    }()
    
    var birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
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
        let stackView = UIStackView(arrangedSubviews: [separator, nameLabel, birthdayLabel, villagerImageView]).adjustedForAutoLayout()
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: birthdayLabel)
    }
    
    func configure(with villager: Villager) {
        nameLabel.text = "Name: \(villager.name)"
        birthdayLabel.text = "Birthday: \(villager.birthday)"
        villagerImageView.downloadIcon(for: .villager(id: villager.id))
    }
}
