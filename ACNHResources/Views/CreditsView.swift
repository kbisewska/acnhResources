//
//  CreditsView.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 26/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class CreditsView: UIView {
    
    lazy var header: UIView = {
        let header = UIView().adjustedForAutoLayout()
        header.backgroundColor = .systemIndigo
        return header
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel().adjustedForAutoLayout()
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        title.textColor = .systemBackground
        return title
    }()
    
    lazy var firstCreditsLabel = createCreditsLabel()
    lazy var secondCreditsLabel = createCreditsLabel()
    lazy var thirdCreditsLabel = createCreditsLabel()
    
    lazy var firstSeparator = createSeparator()
    lazy var secondSeparator = createSeparator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .systemBackground
        
        addSubviews(header, firstCreditsLabel, firstSeparator, secondCreditsLabel, secondSeparator, thirdCreditsLabel)
        header.addSubview(titleLabel)
        
        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 57),
            
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: verticalPadding),
            titleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -verticalPadding),
            titleLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            
            firstCreditsLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: verticalPadding),
            firstCreditsLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            firstCreditsLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            
            firstSeparator.topAnchor.constraint(equalTo: firstCreditsLabel.bottomAnchor, constant: verticalPadding),
            firstSeparator.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            firstSeparator.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            firstSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            secondCreditsLabel.topAnchor.constraint(equalTo: firstSeparator.bottomAnchor, constant: verticalPadding),
            secondCreditsLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            secondCreditsLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            
            secondSeparator.topAnchor.constraint(equalTo: secondCreditsLabel.bottomAnchor, constant: verticalPadding),
            secondSeparator.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            secondSeparator.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            secondSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            thirdCreditsLabel.topAnchor.constraint(equalTo: secondSeparator.bottomAnchor, constant: verticalPadding),
            thirdCreditsLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            thirdCreditsLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
        ])
    }
    
    func createCreditsLabel() -> UILabel {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }
    
    func createSeparator() -> UIView {
        let view = UIView().adjustedForAutoLayout()
        view.backgroundColor = .quaternaryLabel
        return view
    }
}
