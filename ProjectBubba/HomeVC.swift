//
//  ViewController.swift
//  ProjectBubba
//
//  Created by Joseph Kenzie on 10/9/21.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}

