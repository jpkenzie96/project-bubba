//
//  WatchVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit

class WatchVC: UIViewController{
    @IBOutlet weak var movie: UIButton!
    @IBOutlet weak var sensor: UIButton!
    var timer = Timer()
    var count: Int = 0
    var movie1 = UIImage(named:"movie1")
    var movie2 = UIImage(named:"movie2")
    var movie3 = UIImage(named:"movie3")
    var movie4 = UIImage(named:"movie4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
	
        // Do any additional setup after loading the view.
    }
    
    @objc func timerUpdate() {
        
        switch count % 4 {
        case 0:
            self.movie.setBackgroundImage(movie1, for: .normal)
            self.sensor.configuration?.baseBackgroundColor = UIColor.white
        case 1:
            self.movie.setBackgroundImage(movie2, for: UIControl.State.normal)
            self.sensor.configuration?.baseBackgroundColor = UIColor.green
        case 2:
            self.movie.setBackgroundImage(movie3, for: UIControl.State.normal)
            self.sensor.configuration?.baseBackgroundColor = UIColor.white
        case 3:
            self.movie.setBackgroundImage(movie4, for: .normal)
            self.sensor.configuration?.baseBackgroundColor = UIColor.gray
        default:
            self.movie.setBackgroundImage(movie3, for: UIControl.State.normal)
            self.sensor.configuration?.baseBackgroundColor = UIColor.gray
     
        }
        
        count += 1
    }
}
