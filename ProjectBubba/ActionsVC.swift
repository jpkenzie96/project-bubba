//
//  ActionsVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit

class ActionsVC: UIViewController {

    @IBOutlet weak var action1: UIButton!
    @IBOutlet weak var action2: UIButton!
    @IBOutlet weak var action3: UIButton!
    @IBOutlet weak var action4: UIButton!
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    var timer = Timer()
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
    }

    
    @objc func timerUpdate() {
        
        switch count % 4 {
        case 0:
            self.action4.configuration?.baseBackgroundColor = UIColor.white
            self.action1.configuration?.baseBackgroundColor = UIColor.green
        case 1:
            self.action1.configuration?.baseBackgroundColor = UIColor.white
            self.action2.configuration?.baseBackgroundColor = UIColor.green
        case 2:
            self.action2.configuration?.baseBackgroundColor = UIColor.white
            self.action3.configuration?.baseBackgroundColor = UIColor.green
        case 3:
            self.action3.configuration?.baseBackgroundColor = UIColor.white
            self.action4.configuration?.baseBackgroundColor = UIColor.green
        default:
            self.action1.configuration?.baseBackgroundColor = UIColor.white
            self.action2.configuration?.baseBackgroundColor = UIColor.white
            self.action3.configuration?.baseBackgroundColor = UIColor.white
            self.action4.configuration?.baseBackgroundColor = UIColor.white
        }
        
        count += 1
        
    }
    
}
