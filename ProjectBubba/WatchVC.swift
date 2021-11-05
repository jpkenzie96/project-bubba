//
//  WatchVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit

class WatchVC: UIViewController{
    @IBOutlet weak var movie: UIButton!
	var url = URL(string:"http://www.disneyplus.com")
    var timer = Timer()
    var count: Int = 0
    var movie1 = UIImage(named:"movie1.jpeg")
    var movie2 = UIImage(named:"movie2.jpeg")
    var movie3 = UIImage(named:"movie3.jpeg")
    var movie4 = UIImage(named:"movie4.jpeg")
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
		//sensor.addTarget(self, action: "SensorInput", for: .touchUpInside)
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func timerUpdate() {
        
        switch count % 4 {
        case 0:
            self.movie.configuration?.background.image = movie1
			self.url = URL(string:"https://www.disneyplus.com/video/6d31fb45-d7a5-4ffb-a99c-e914550b01a1")
            
        case 1:
            self.movie.configuration?.background.image = movie2
			self.url = URL(string: "https://www.disneyplus.com/video/b683ca96-70d0-453d-b014-207b16d74a5a")
        case 2:
            self.movie.configuration?.background.image = movie3
			self.url = URL(string: "https://www.disneyplus.com/video/eccdbdc5-7767-448e-be14-74647b128ca9")
        
        case 3:
            self.movie.configuration?.background.image = movie4
			self.url = URL(string: "https://www.disneyplus.com/video/87982e2b-5636-41a2-9d9a-5bc77cacb7d7")
            
        default:
            self.movie.setBackgroundImage(movie3, for: UIControl.State.normal)
     
        }
        
        count += 1
    }
	
	@IBAction func SensorInput(_ sender: Any){
		UIApplication.shared.open(url!, options: [:], completionHandler: nil)
	}
}
