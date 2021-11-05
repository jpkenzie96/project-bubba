//
//  StartupVC.swift
//  ProjectBubba
//
//  Created by Vania Rohmetra on 10/23/21.
//

import UIKit


class StartupVC: UIViewController{
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
        // Do any additional setup after loading the view.
    }
}
