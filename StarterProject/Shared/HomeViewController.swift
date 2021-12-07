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
class HomeViewController: UIViewController, ScrollTimeDelegate {
    @IBOutlet weak var settingsButton: UIButton!
    
    var device: MetaWear!
    var scrollTime: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingsButton.setTitle("", for: .normal)
        
        let backgroundColor = UserDefaults.standard.string(forKey: "selectedBackgroundColor")
        view.backgroundColor = SystemColor(color: String(backgroundColor ?? "Red"))
        //SystemColor(color: backgroundColorChoices[row])
    }
    
    func updateScrollTime(newScroll: Int) {
        scrollTime = newScroll
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
                actionsViewController.scrollTime = (scrollTime!)
            } else if let watchViewController = segue.destination as? WatchViewController {
                watchViewController.device = (device!)
                watchViewController.scrollTime = (scrollTime!)
            } else if let settingsViewController = segue.destination as? SettingsViewController {
                settingsViewController.device = (device!)
                settingsViewController.delegate = self
            }
        }
    
}
