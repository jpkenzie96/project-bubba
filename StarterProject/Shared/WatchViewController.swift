//
//  WatchViewController.swift
//  iOS
//
//  Created by Kamren Davis on 11/14/21.
//  Copyright © 2021 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear
import MetaWearCpp
import AVFoundation

@available(iOS 15.0, *)
class WatchViewController: UIViewController {
    @IBOutlet weak var movie: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var url = URL(string:"http://www.disneyplus.com")
    var timer = Timer()
	var timer2 = Timer()
    var count: Int = 0
    var movie1 = UIImage(named:"movie1")
    var movie2 = UIImage(named:"movie2")
    var movie3 = UIImage(named:"movie3")
    var movie4 = UIImage(named:"movie4")
    
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    @IBOutlet weak var deviceStatus: UILabel!
    var device: MetaWear!
    var scrollTime: Int!
	
	var audioPlayer: AVAudioPlayer?
	var confirm = false
	let synthesizer = AVSpeechSynthesizer()
	var currentmovie = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
		
        self.updateLabel("Restoring")
        if let state = DeviceState.loadForDevice(device) {
            // Initialize the device
            device.deserialize(state.serializedState)
            self.updateLabel("Connecting")
            device.connectAndSetup().continueWith { t in
                if let error = t.error {
                    // Sorry we couldn't connect
                    self.deviceStatus.text = error.localizedDescription
                } else {
                    // The result of a connectAndSetup call is a task which completes upon disconnection.
                    t.result!.continueWith {
                        state.serializedState = self.device.serialize()
                        state.saveToUrl(self.device.uniqueUrl)
                        self.updateLabel($0.error?.localizedDescription ?? "Disconnected")
                    }
                    
                    self.updateLabel("Connected")
                    self.device.flashLED(color: .green, intensity: 1.0, _repeat: 3)
                    
                    //self.doDownload(state: state)
                }
            }
        }
    }
    
    
    
    func updateLabel(_ msg: String) {
        DispatchQueue.main.async {
            self.deviceStatus.text = msg
        }
    }
    
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        device.flashLED(color: .red, intensity: 1.0, _repeat: 3)
        mbl_mw_debug_disconnect(device.board)
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.startButton.configuration?.background.backgroundColor = UIColor.blue
        
        // Watch Functionality
        timer = Timer.scheduledTimer(timeInterval: Double(scrollTime), target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        
        // Sensor Function
        let board = device.board
            guard mbl_mw_metawearboard_lookup_module(board, MBL_MW_MODULE_ACCELEROMETER) != MBL_MW_MODULE_TYPE_NA else {
                print("No accelerometer")
                return
            }
            let signal = mbl_mw_acc_get_acceleration_data_signal(board)
            //mbl_mw_acc_bosch_enable_motion_detection(board, MBL_MW_ACC_BOSCH_MOTION_SIGMOTION)

            mbl_mw_datasignal_subscribe(signal, bridge(obj: self)) { (context, data) in
                let contBridge: WatchViewController = bridge(ptr: context!)
                let obj: MblMwCartesianFloat = data!.pointee.valueAs()
                print(Double(obj.x), Double(obj.y), Double(obj.z))
                
                if ((abs(obj.x)>0.7) || (abs(obj.y)>0.7)){
                    //print(obj.x, obj.y, obj.z)
                    print("MOVEMENT DETECTED")
                    contBridge.sensorInput()
                }
            }
            
        
            mbl_mw_acc_enable_acceleration_sampling(board)
            mbl_mw_acc_start(board)
            //let motion_signal = mbl_mw_acc_bosch_get_motion_data_signal(board)
            
            //if(motion_signal?.read().result?.valueAs() == 1){
            //    print("Motion Detected")
            //    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            //}
        
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
		timer = Timer.scheduledTimer(timeInterval: Double(scrollTime), target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
	}
    
    func sensorInput(){
		if (self.confirm){
			UIApplication.shared.open(url!, options: [:], completionHandler: nil)
		}
		else{
			timer.invalidate()
			audioPlayer?.stop()
			timer2 = Timer.scheduledTimer(timeInterval: Double(scrollTime), target: self, selector: #selector(timerWait), userInfo: nil, repeats: false)
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
