//
//  TalkVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit

class TalkVC: UIViewController {
    @IBOutlet weak var yesNoLabel: UIButton!
    var timer = Timer()
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
    }

    @IBAction func sensorInput(_ sender: Any) {
        self.yesNoLabel.configuration?.background.backgroundColor = UIColor.green
        self.yesNoLabel.configuration?.title = "Yes"
                 
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        self.yesNoLabel.configuration?.background.backgroundColor = UIColor.red
        self.yesNoLabel.configuration?.title = "No"
        
    }
    
}
