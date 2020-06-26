//
//  GeneralSettingsView.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 26/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class GeneralSettingsView: UIView {
    
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
    
    lazy var settingsLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var picker: UIPickerView = {
        return UIPickerView().adjustedForAutoLayout()
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
        
        addSubviews(header, settingsLabel, picker)
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
            
            settingsLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: verticalPadding),
            settingsLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            settingsLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            
            picker.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 2),
            picker.centerXAnchor.constraint(equalTo: centerXAnchor),
            picker.heightAnchor.constraint(equalToConstant: 86)
        ])
    }
}
