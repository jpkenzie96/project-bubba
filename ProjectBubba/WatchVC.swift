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
    var movie1 = UIImage(named:"movie1.jpeg")
    var movie2 = UIImage(named:"movie2.jpeg")
    var movie3 = UIImage(named:"movie3.jpeg")
    var movie4 = UIImage(named:"movie4.jpeg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
	
        // Do any additional setup after loading the view.
    }
    
    @objc func timerUpdate() {
        
        switch count % 4 {
        case 0:
            self.movie.configuration?.background.image = movie1
            
        case 1:
            self.movie.configuration?.background.image = movie2
            
        case 2:
            self.movie.configuration?.background.image = movie3
        
        case 3:
            self.movie.configuration?.background.image = movie4
            
        default:
            self.movie.setBackgroundImage(movie3, for: UIControl.State.normal)
     
        }
        
        count += 1
    }
}
