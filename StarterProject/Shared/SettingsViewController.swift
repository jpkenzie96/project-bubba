//
//  SettingsViewController.swift
//  iOS
//
//  Created by Kamren Davis on 11/14/21.
//  Copyright © 2021 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear
import MBProgressHUD

@available(iOS 15.0, *)
class SettingsViewController: UIViewController {
    @IBOutlet weak var backgroundColorSelection: UIPickerView!
    @IBOutlet weak var textColorSelection: UIPickerView!
    @IBOutlet weak var backgroundSelectionButton: UIButton!
    @IBOutlet weak var textSelectionButton: UIButton!
    @IBOutlet weak var scrollingTimeSlider: UISlider!
    @IBOutlet weak var scrollingTimeLabel: UILabel!
    @IBOutlet weak var BackgroundColorLabel: UILabel!
    @IBOutlet weak var TextColorLabel: UILabel!
    @IBOutlet weak var ScrollingLabel: UILabel!
    
    @IBOutlet weak var SettingsLabel: UILabel!
    
    var textColorChoices = ["Black", "Gray", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    var backgroundColorChoices = ["Red", "Gray", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    var device: MetaWear!
    var scrollTime: Int!
    var backgroundColor: String?
    
    var delegate: ScrollTimeDelegate?
    
    override func viewDidLoad() {
        
        textColorSelection.isHidden = true
        backgroundColorSelection.isHidden = true
        super.viewDidLoad()
        backgroundColorSelection.dataSource = self
        backgroundColorSelection.delegate = self
        textColorSelection.dataSource = self
        textColorSelection.delegate = self
        scrollingTimeLabel.text = "\(Int(scrollingTimeSlider.value))" + " sec"
        let backgroundColor = UserDefaults.standard.string(forKey: "selectedBackgroundColor")
        view.backgroundColor = SystemColor(color: String(backgroundColor ?? "Red"))
        //view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
        
        // adding white background to button
        textSelectionButton.backgroundColor = UIColor.white
        textSelectionButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        backgroundSelectionButton.backgroundColor = UIColor.white
        backgroundSelectionButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        textSelectionButton.layer.cornerRadius = 10
        backgroundSelectionButton.layer.cornerRadius = 10
        
        textColorChoices = reloadAllComponents(tag: 1, color: backgroundColor ?? "Red")
        backgroundSelectionButton.setTitle(backgroundColor ?? "Red", for: .normal)
        //backgroundSelectionButton.configuration?.title = backgroundColorChoices[row]
        
        //let textColor = UserDefaults.standard.string(forKey: "selectedBackgroundColor")
        //view.backgroundColor = SystemColor(color: String(backgroundColor ?? "Red"))
        let textColor = UserDefaults.standard.string(forKey: "selectedTextColor")
        //print("view did load text row: ", row2)
        textSelectionButton.setTitle(textColor ?? "Black", for: .normal)
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = SystemColor(color: textColor ?? "Black")
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(SystemColor(color: textColor ?? "Black"), for: .normal)
        //textSelectionButton.configuration?.title = textColorChoices[row2]
        backgroundColorSelection.setValue(SystemColor(color: textColor ?? "Black"), forKeyPath: "textColor")
        textColorSelection.setValue(SystemColor(color: textColor ?? "Black"), forKeyPath: "textColor")
        backgroundColorChoices = reloadAllComponents(tag: 0, color: textColor ?? "Black")
        
    }
    
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        scrollTime = Int(scrollingTimeSlider.value)
        scrollingTimeLabel.text = "\(Int(scrollingTimeSlider.value))" + " sec"
        
        delegate?.updateScrollTime(newScroll: scrollTime)
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let homeController = segue.destination as? HomeViewController {
            homeController.scrollTime = scrollTime
        }
    }
    
}

@available(iOS 15.0, *)
extension SettingsViewController: UIPickerViewDataSource {
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

@available(iOS 15.0, *)
extension SettingsViewController: UIPickerViewDelegate {
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
            //backgroundSelectionButton.setTitle(backgroundColorChoices[row], for: .normal)
            backgroundSelectionButton.setTitle(backgroundColorChoices[row], for: .normal)
            self.view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
            self.textColorChoices = reloadAllComponents(tag: pickerView.tag, color: backgroundColorChoices[row])
            //HomeViewController.backgroundColor = SystemColor(color: backgroundColorChoices[row])
            UserDefaults.standard.set(backgroundColorChoices[row], forKey: "selectedBackgroundColor")
            pickerView.isHidden = true
        }
        else {
            //textSelectionButton.setTitle(textColorChoices[row], for: .normal)
            //UserDefaults.standard.set(row, forKey: "textPickerViewRow")
            textSelectionButton.setTitle(textColorChoices[row], for: .normal)
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = SystemColor(color: textColorChoices[row])
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(SystemColor(color: textColorChoices[row]), for: .normal)
            self.backgroundColorSelection.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.textColorSelection.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.scrollingTimeLabel.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.ScrollingLabel.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.TextColorLabel.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.BackgroundColorLabel.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.backgroundColorChoices = reloadAllComponents(tag: pickerView.tag, color: textColorChoices[row])
            self.SettingsLabel.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            self.backgroundSelectionButton.setTitleColor(SystemColor(color: textColorChoices[row]), for: .normal)
            self.textSelectionButton.setTitleColor(SystemColor(color: textColorChoices[row]), for: .normal)
            //self.backgroundSelectionButton.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            //self.textSelectionButton.setValue(SystemColor(color: textColorChoices[row]), forKeyPath: "textColor")
            UserDefaults.standard.set(textColorChoices[row], forKey: "selectedTextColor")
            pickerView.isHidden = true
        }
    }
}


@available(iOS 15.0, *)
func SystemColor(color: String) -> UIColor {
    if color == "Black" {
        return UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    else if color == "Gray" {
        return UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
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

func reloadAllComponents(tag: Int, color: String) -> Array<String> {
    if tag == 0 {
        if color == "Black" {
            return ["Red", "Gray", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
        }
        else if color == "Gray" {
            return ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
        }
        else if color == "Red" {
            return ["Gray", "Yellow", "Green", "Blue", "Purple", "Pink"]
        }
        else if color == "Orange" {
            return ["Gray", "Yellow", "Green", "Blue", "Purple"]
        }
        else if color == "Green" {
            return ["Red", "Gray", "Orange", "Yellow", "Blue", "Purple", "Pink"]
        }
        else if color == "Blue" {
            return ["Red", "Gray", "Orange", "Yellow", "Green", "Pink"]
        }
        else if color == "Purple" {
            return ["Red", "Gray", "Orange", "Yellow", "Pink"]
        }
        else {
            return ["Gray", "Yellow", "Green", "Blue", "Purple"]
        }
    }
    else {
        if color == "Gray" {
            return ["Black", "Red", "Orange", "Green", "Blue", "Purple", "Pink"]
        }
        else if color == "Red" {
            return ["Black", "Gray", "Green", "Blue", "Purple"]
        }
        else if color == "Orange" {
            return ["Black", "Gray", "Green", "Blue", "Purple"]
        }
        else if color == "Yellow" {
            return ["Black", "Gray", "Red", "Orange", "Green", "Blue", "Purple", "Pink"]
        }
        else if color == "Green" {
            return ["Black", "Gray", "Red", "Orange", "Blue", "Pink"]
        }
        else if color == "Blue" {
            return ["Black", "Gray", "Red", "Orange", "Green", "Pink"]
        }
        else if color == "Purple" {
            return ["Black", "Gray", "Red", "Orange", "Green", "Pink"]
        }
        else {
            return ["Black", "Gray", "Red", "Green", "Blue", "Purple"]
        }
    }
}

protocol ScrollTimeDelegate {
    func updateScrollTime(newScroll: Int)
}
