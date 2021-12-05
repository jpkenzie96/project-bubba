//
//  HomeViewController.swift
//  iOS
//
//  Created by Kamren Davis on 11/14/21.
//  Copyright © 2021 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import UIKit
import MetaWear
import MetaWearCpp

@available(iOS 15.0, *)
class HomeViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    var device: MetaWear!
    var scrollTime: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingsButton.setTitle("", for: .normal)
        
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
    }
    
    @IBAction func talkViewButtonPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "TalkViewSegue", sender: self)
    }
    
    @IBAction func actionViewButtonPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "ActionViewSegue", sender: self)
    }
    
    @IBAction func watchViewButtonPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "WatchViewSegue", sender: self)
    }
    
    // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            if let talkViewController = segue.destination as? TalkViewController {
                talkViewController.device = (device!)
                talkViewController.scrollTime = (scrollTime!)
            } else if let actionsViewController = segue.destination as? ActionsViewController {
                actionsViewController.device = (device!)
            } else if let watchViewController = segue.destination as? WatchViewController {
                watchViewController.device = (device!)
            } else if let settingsViewController = segue.destination as? SettingsViewController {
                settingsViewController.device = (device!)
            }
        }
    
}
