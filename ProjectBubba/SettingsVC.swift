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
    
    var textInd = -1
    var choice = ""
    var bgInd = -1
    var textColorChoices: [String] = ["Black", "Gray", "Red", "Orange", "Green", "Blue", "Purple", "Pink"]
    var backgroundColorChoices: [String] = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    override func viewDidLoad() {
        textColorChoices = ["Black", "Gray", "Red", "Orange", "Green", "Blue", "Purple", "Pink"]
        backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
        textColorSelection.isHidden = true
        backgroundColorSelection.isHidden = true
        super.viewDidLoad()
        backgroundColorSelection.dataSource = self
        backgroundColorSelection.delegate = self
        textColorSelection.dataSource = self
        textColorSelection.delegate = self
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
        backgroundSelectionButton.setTitle(backgroundColorChoices[row], for: .normal)
        let row2 = UserDefaults.standard.integer(forKey: "textPickerViewRow")
        textSelectionButton.setTitle(textColorChoices[row2], for: .normal)
        backgroundColorSelection.setValue(SystemColor(color: textColorChoices[row2]), forKeyPath: "textColor")
        textColorSelection.setValue(SystemColor(color: textColorChoices[row2]), forKeyPath: "textColor")
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
            backgroundSelectionButton.setTitle(backgroundColorChoices[row], for:.normal)
            self.view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
            UserDefaults.standard.set(row, forKey: "backgroundPickerViewRow")
            if bgInd >= 0 {
                backgroundColorChoices.insert(choice, at:bgInd)
                if row >= bgInd {
                    choice = backgroundColorChoices[row + 1]
                }
                else {
                    choice = backgroundColorChoices[row]
                }
            }
            else {
                choice = backgroundColorChoices[row]
            }
            if textColorChoices.contains(choice) {
                textInd = textColorChoices.firstIndex(of: choice)!
                textColorChoices.remove(at: textInd)
            }
            pickerView.isHidden = true
        }
        else {
            textSelectionButton.setTitle(textColorChoices[row], for: .normal)
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = SystemColor(color: textColorChoices[row])
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(SystemColor(color: textColorChoices[row]), for: .normal)
            UserDefaults.standard.set(row, forKey: "textPickerViewRow")
//            view.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            backgroundColorSelection.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            textColorSelection.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            if textInd >= 0 {
                textColorChoices.insert(choice, at: textInd)
                if row >= textInd {
                    choice = textColorChoices[row + 1]
                }
                else {
                    choice = textColorChoices[row]
                }
            }
            else{
                choice = textColorChoices[row]
            }
            if backgroundColorChoices.contains(choice) {
                bgInd = backgroundColorChoices.firstIndex(of: choice)!
                backgroundColorChoices.remove(at: bgInd)
            }
            pickerView.isHidden = true
        }
    }
}


func SystemColor(color: String) -> UIColor {
    if color == "Black" {
        return UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    else if color == "Gray" {
        return UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
    }
    else if color == "White" {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    else if color == "Red" {
        return UIColor(red: 255/255, green: 126/255, blue: 121/255, alpha: 1)
    }
    else if color == "Orange" {
        return UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
    }
    else if color == "Yellow" {
        return UIColor(red: 255/255, green: 252/255, blue: 121/255, alpha: 1)
    }
    else if color == "Green" {
        return UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1)
    }
    else if color == "Blue" {
        return UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1)
    }
    else if color == "Purple" {
        return UIColor(red: 122/255, green: 129/255, blue: 255/255, alpha: 1    )
    }
    return UIColor(red: 255/255, green: 138/255, blue: 216/255, alpha: 1)
}
