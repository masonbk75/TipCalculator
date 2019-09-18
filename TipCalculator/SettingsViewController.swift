//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Mason Kelly on 8/23/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import UIKit

/*
 - first: search
 - can;tsearch _-> text me -> tell you keywords or solutions -> implement yourself
 - i will help
 
 
 How to pass data from controller to controller
 - userDefault: -> save into local (from controller) and load it (to controller)
 - delegate: from controller will call a function in to controller and pass a data as parameter
 - Global/static variable : any classes in the project can access to. set in from controller, load in to controller
 
 
 - Post notification: tell all live screens about your information (data incuded)
 - segue: prepare for segue // useless
 -
 
 
 */



/*
 Retain cycle, related to memory leak
 weak, strong
 */

var percentage: Double = 0

class SettingsViewController: UIViewController {
    static var staticPercentage: Double = 0
    
    weak var delegate: SettingDelegate?
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    var defaultSeg = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    func setupView() {
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backTapped))
        
        barButton.tintColor = .white
        navigationItem.leftBarButtonItem = barButton
        
        segmentControl.addTarget(self, action: Selector(("segmentedControlValueChanged:")), for:.touchUpInside)
        
    }
    
    
    
    @IBAction func segmentControlTapped(_ sender: Any) {
        print(segmentControl.selectedSegmentIndex)
        
        if let textValue = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) {
            print(textValue)
            /// can access textValue
        }
        /// cant access textValue
        
        guard let newTextValue = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else {
            /// cant access newTextValue
            return
        }
        /// can access newTextValue
        let pureString = newTextValue.replacingOccurrences(of: "%", with: "")
        guard let pureNumber = Double(pureString) else { return }
        UserDefaults.standard.set(pureNumber, forKey: "defaultPercentage")
        
    }
    
    
    @objc func backTapped() {
        guard let newTextValue = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else {
            /// cant access newTextValue
            return
        }
        let pureString = newTextValue.replacingOccurrences(of: "%", with: "")
        guard let pureNumber = Double(pureString) else { return }
        delegate?.didSelectDefaultPercentage(pureNumber)
        
        navigationController?.popViewController(animated: true)
    }
    

}

protocol SettingDelegate: class {
    func didSelectDefaultPercentage(_ value: Double)
}

