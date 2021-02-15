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
    
    lazy var hemisphereLabel: UILabel = {
        let title = UILabel().adjustedForAutoLayout()
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        title.textColor = .systemBackground
        return title
    }()
    
    lazy var hemisphereSettingsLabel: UILabel = {
        let label = UILabel().adjustedForAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var picker: UIPickerView = {
        return UIPickerView().adjustedForAutoLayout()
    }()
    
    lazy var separator: UIView = {
        let view = UIView().adjustedForAutoLayout()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton().adjustedForAutoLayout()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .systemBackground
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
        
        addSubviews(header, hemisphereSettingsLabel, picker, separator, resetButton)
        header.addSubview(hemisphereLabel)
        
        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 57),
            
            hemisphereLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: verticalPadding),
            hemisphereLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -verticalPadding),
            hemisphereLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            hemisphereLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            
            hemisphereSettingsLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: verticalPadding),
            hemisphereSettingsLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            hemisphereSettingsLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            
            picker.topAnchor.constraint(equalTo: hemisphereSettingsLabel.bottomAnchor, constant: verticalPadding / 2),
            picker.centerXAnchor.constraint(equalTo: centerXAnchor),
            picker.heightAnchor.constraint(equalToConstant: 100),
            
            separator.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: verticalPadding),
            separator.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            separator.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            resetButton.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: verticalPadding),
            resetButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: horizontalPadding),
            resetButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -horizontalPadding),
            resetButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
