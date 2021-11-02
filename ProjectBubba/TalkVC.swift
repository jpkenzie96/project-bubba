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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
