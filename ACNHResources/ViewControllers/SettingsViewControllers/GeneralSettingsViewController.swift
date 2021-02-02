//
//  GeneralSettingsViewController.swift
//  ACNHResources
//
//  Created by Kornelia Bisewska on 25/06/2020.
//  Copyright © 2020 kbisewska. All rights reserved.
//

import UIKit

final class GeneralSettingsViewController: UIViewController {
    
    private let customView = GeneralSettingsView()
    private let persistenceManager = PersistenceManager()
    
    override func loadView() {
        view = customView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: Notification.Name("ResetData"), object: nil)
        
        configureLayout()
        configurePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func resetData() {
        persistenceManager.removeData(withKey: "Hemisphere")
        customView.picker.selectRow(0, inComponent: 0, animated: true)
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        
        customView.hemisphereLabel.text = "Settings"
        customView.hemisphereSettingsLabel.text = "Your Hemisphere:"
        
        customView.resetButton.setTitle("Clear App Data", for: .normal)
        customView.resetButton.addTarget(self, action: #selector(presentResetAlert), for: .touchUpInside)
    }
    
    private func configurePicker() {
        customView.picker.delegate = self
        customView.picker.dataSource = self
    
        if let row: Int = try? persistenceManager.retrieve(fromKey: "Hemisphere") {
            customView.picker.selectRow(row, inComponent: 0, animated: true)
        } else {
            customView.picker.selectRow(0, inComponent: 0, animated: true)
            try? persistenceManager.store(value: 0, withKey: "Hemisphere")
        }
    }
    
    @objc func presentResetAlert() {
        let alert = UIAlertController(title: "Clear App Data", message: "All saved data in this app will be cleared. Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
            self?.sendNotification()
        }))
        present(alert, animated: true)
    }
    
    func sendNotification() {
        NotificationCenter.default.post(Notification(name: Notification.Name("ResetData")))
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        try? persistenceManager.store(value: row, withKey: "Hemisphere")
    }
}
