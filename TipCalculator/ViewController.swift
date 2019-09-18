//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mason Kelly on 8/23/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var perPersonNumber: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var defaultSeg = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // run one time only
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let savedPercentage = UserDefaults.standard.value(forKey: <#T##String#>)
        //let savedPercentage = UserDefaults.standard.double(forKey: "defaultPercentage")
        //print(savedPercentage)
        
    }
    
    
    func setupView() {
        let barButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsTapped))
        
        barButton.tintColor = .white
        navigationItem.rightBarButtonItem = barButton

        textField.addTarget(self, action: #selector(ViewController.textDidChange(_:)), for: UIControl.Event.editingChanged)
        
        segmentControl.addTarget(self, action: Selector(("segmentedControlValueChanged:")), for:.touchUpInside)
        
        self.textField.becomeFirstResponder()
        stepper.value = 1.0
    }
    
    
    @IBAction func textDidChange(_ sender: Any) {
        let amount: Double? = Double(textField.text!)
        calculateTip(amount: amount ?? 0.00)
    }
    
    
    @IBAction func selectorDidChange(_ sender: Any) {
        let amount: Double? = Double(textField.text!)
        calculateTip(amount: amount ?? 0.00)
    }
    
    @IBAction func stepperDidChange(_ sender: Any) {
        perPersonNumber.text = String(Int(stepper.value))
        let amount: Double? = Double(textField.text!)
        calculateTip(amount: amount ?? 0.00)
    }
    
    

    
    func calculateTip(amount: Double) {
        //print(amount)
        let tipAmounts = [0.15, 0.20, 0.25]
        let selectedTip = tipAmounts[segmentControl.selectedSegmentIndex]
        //print(selectedTip)
        let tip = amount * selectedTip
        tipLabel.text = String(tip)
        let total = amount + tip
        totalLabel.text = String(total)
        let perPerson = total / stepper.value
        perPersonLabel.text = String(perPerson)
    }
    
    @objc func settingsTapped() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}


extension ViewController: SettingDelegate {
    func didSelectDefaultPercentage(_ value: Double) {
        print(value)
    }
    
    
}


