//
//  ViewController.swift
//  ProjectBubba
//
//  Created by Joseph Kenzie on 10/9/21.
//

import UIKit

class HomeVC: UIViewController {
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
    }

    @IBAction func talkViewButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "TalkViewSegue", sender: self)
    }
    
    @IBAction func actionViewButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ActionsViewSegue", sender: self)
    }
    
    @IBAction func watchViewButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "WatchViewSegue", sender: self)
    }
    
    @IBAction func settingsViewButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "SettingsViewSegue", sender: self)
    }}

