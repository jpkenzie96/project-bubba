//
//  WatchVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit
import AVFoundation

class WatchVC: UIViewController{
    @IBOutlet weak var movie: UIButton!
	var url = URL(string:"http://www.disneyplus.com")
	var currentmovie = ""
    var timer = Timer()
	var timer2 = Timer()
    var count: Int = 0
    var movie1 = UIImage(named:"movie1.jpeg")
    var movie2 = UIImage(named:"movie2.jpeg")
    var movie3 = UIImage(named:"movie3.jpeg")
    var movie4 = UIImage(named:"movie4.jpeg")
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
	var audioPlayer: AVAudioPlayer?
	var confirm = false
	let synthesizer = AVSpeechSynthesizer()
    
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
			self.currentmovie = "Meet the Robinsons"
			let pathToSound = Bundle.main.path(forResource: "movie1", ofType: "mp3")!
			let url = URL(fileURLWithPath: pathToSound)
			
			do{
				audioPlayer = try AVAudioPlayer(contentsOf: url)
				audioPlayer?.play()
			} catch{
				
			}
            
        case 1:
            self.movie.configuration?.background.image = movie2
			self.url = URL(string: "https://www.disneyplus.com/video/b683ca96-70d0-453d-b014-207b16d74a5a")
			self.currentmovie = "Tangled"
			let pathToSound = Bundle.main.path(forResource: "movie2", ofType: "mp3")!
			let url = URL(fileURLWithPath: pathToSound)
			do{
				audioPlayer = try AVAudioPlayer(contentsOf: url)
				audioPlayer?.play()
			} catch{
				
			}
			
        case 2:
            self.movie.configuration?.background.image = movie3
			self.url = URL(string: "https://www.disneyplus.com/video/eccdbdc5-7767-448e-be14-74647b128ca9")
			self.currentmovie = "Toy Story"
			let pathToSound = Bundle.main.path(forResource: "movie3", ofType: "mp3")!
			let url = URL(fileURLWithPath: pathToSound)
			do{
				audioPlayer = try AVAudioPlayer(contentsOf: url)
				audioPlayer?.play()
			} catch{
				
			}
			
        case 3:
            self.movie.configuration?.background.image = movie4
			self.url = URL(string: "https://www.disneyplus.com/video/87982e2b-5636-41a2-9d9a-5bc77cacb7d7")
			self.currentmovie = "The Lion King"
			let pathToSound = Bundle.main.path(forResource: "movie4", ofType: "mp3")!
			let url = URL(fileURLWithPath: pathToSound)
			do{
				audioPlayer = try AVAudioPlayer(contentsOf: url)
				audioPlayer?.play()
			} catch{
				
			}
            
        default:
            self.movie.setBackgroundImage(movie3, for: UIControl.State.normal)
     
        }
        
        count += 1
    }
	
	@objc func timerWait() {
		self.confirm = false;
		timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
	}
	
	@IBAction func SensorInput(_ sender: Any){
		if (self.confirm){
			UIApplication.shared.open(url!, options: [:], completionHandler: nil)
			timer2.invalidate()
		}
		else{
			timer.invalidate()
			audioPlayer?.stop()
			timer2 = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerWait), userInfo: nil, repeats: false)
			let confirmspeak = AVSpeechUtterance(string: "Confirm Selection of")
			confirmspeak.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(confirmspeak)
			let moviespeak = AVSpeechUtterance(string: self.currentmovie)
			moviespeak.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(moviespeak)
			self.confirm = true
			
		}
		
	}
	@IBAction func back(_ sender: UIButton) {
		timer.invalidate();
		audioPlayer?.stop();
	}
}
