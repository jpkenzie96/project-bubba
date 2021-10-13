//
//  SettingsVC.swift
//  ProjectBubba
//
//  Created by Joseph Kenzie on 10/12/21.
//

import UIKit

class SettingsVC: UIViewController{
    
    @IBOutlet weak var backgroundColorSelection: UIPickerView!
    @IBOutlet weak var textColorSelection: UIPickerView!
    @IBOutlet weak var backgroundSelectionButton: UIButton!
    @IBOutlet weak var textSelectionButton: UIButton!
    
    let textColorChoices = ["Black", "Red", "Gray", "White"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White"]
    
    override func viewDidLoad() {
        
        backgroundColorSelection.isHidden = true
        textColorSelection.isHidden = true
        
        super.viewDidLoad()
        backgroundColorSelection.dataSource = self
        backgroundColorSelection.delegate = self
        textColorSelection.dataSource = self
        textColorSelection.delegate = self
    }
    
    @IBAction func selectionMade(_ sender: UIButton) {
        if sender.tag == 1 {
            if backgroundColorSelection.isHidden {
                backgroundColorSelection.isHidden = false
            }
            else {
                backgroundColorSelection.isHidden = true
            }
        }
        else{
            if textColorSelection.isHidden {
                textColorSelection.isHidden = false
            }
            else {
                textColorSelection.isHidden = true
            }
        }
    }



}

extension SettingsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return backgroundColorChoices.count
        }
        else {
            return textColorChoices.count
        }
    }
    
    
}

extension SettingsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(backgroundColorChoices[row])"
        }
        else {
            return "\(textColorChoices[row])"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            backgroundSelectionButton.setTitle(backgroundColorChoices[row], for: .normal)
            pickerView.isHidden = true
        }
        else {
            textSelectionButton.setTitle(textColorChoices[row], for: .normal)
            pickerView.isHidden = true
        }
    }
}
