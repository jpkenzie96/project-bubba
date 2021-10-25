//
//  TalkVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit

class TalkVC: UIViewController {
    @IBOutlet weak var yesNoLabel: UIButton!
    var noImage = UIImage(named:"No")
    var yesImage = UIImage(named:"Yes")
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sensorInput(_ sender: Any) {
        self.yesNoLabel.setImage(yesImage, for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        self.yesNoLabel.setImage(noImage, for: .normal)
    }
    
}
