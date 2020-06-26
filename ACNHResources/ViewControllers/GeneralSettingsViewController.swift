//
//  GeneralSettingsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 25/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

class GeneralSettingsViewController: UIViewController {
    
    private let customView = GeneralSettingsView()
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        customView.titleLabel.text = "Settings"
        customView.settingsLabel.text = "Your Hemisphere:"
        customView.picker.delegate = self
        customView.picker.dataSource = self
    }
}

extension GeneralSettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Hemisphere.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let view = view {
            label = view as! UILabel
        }
        label.text = Hemisphere.allCases[row].description
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }
}
