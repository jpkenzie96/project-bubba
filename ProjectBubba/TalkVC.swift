//
//  TalkVC.swift
//  ProjectBubba
//
//  Created by Kamren Davis on 10/12/21.
//

import UIKit
import AVFoundation

class TalkVC: UIViewController {
    @IBOutlet weak var yesNoLabel: UIButton!
	var timer = Timer()
	var enable = false;
	var yes = false;
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
	let synthesizer = AVSpeechSynthesizer()
	

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
		//sensor.isEnabled = false;
		
    }
	@IBAction func asked(sender: Any){
		//sensor.isEnabled = false;
		self.enable = true;
		timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerNo), userInfo: nil, repeats: false)
	}
    @IBAction func sensorInput(_ sender: UIButton) {
		if (self.enable){
			self.yes = true;
			self.yesNoLabel.configuration?.background.backgroundColor = UIColor.green
			self.yesNoLabel.configuration?.title = "Yes"
			let yesspeak = AVSpeechUtterance(string: "yes")
			yesspeak.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(yesspeak)
			
					 
			//timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
		}
        
	}
    
    /*@objc func timerAction() {
        self.yesNoLabel.configuration?.background.backgroundColor = UIColor.red
        self.yesNoLabel.configuration?.title = "No"
        
    }*/
	@objc func timerNo(){
		if (!self.yes)
		{
			let nospeak = AVSpeechUtterance(string: "no")
		nospeak.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(nospeak)
			
		}
		if (self.yes){
			self.yesNoLabel.configuration?.background.backgroundColor = UIColor.red
			self.yesNoLabel.configuration?.title = "No"
		}
		self.yes = false
		self.enable = false
	}
}
