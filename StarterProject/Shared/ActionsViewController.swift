//
//  ActionsViewController.swift
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
class ActionsViewController: UIViewController {
    @IBOutlet weak var action1: UIButton!
    @IBOutlet weak var action2: UIButton!
    @IBOutlet weak var action3: UIButton!
    @IBOutlet weak var action4: UIButton!
    @IBOutlet weak var deviceStatus: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var timer = Timer()
	var timer2 = Timer()
    var count: Int = 0
    var confirmed = AVSpeechUtterance()
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    var device: MetaWear!
    var scrollTime: Int!
    
	let synthesizer = AVSpeechSynthesizer()
	var confirm = false
	var currentaction = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
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
        
        timer.invalidate()
        timer2.invalidate()
        device.flashLED(color: .red, intensity: 1.0, _repeat: 3)
        mbl_mw_debug_disconnect(device.board)
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
        self.startButton.configuration?.background.backgroundColor = UIColor.blue
        
        let board = device.board
            guard mbl_mw_metawearboard_lookup_module(board, MBL_MW_MODULE_ACCELEROMETER) != MBL_MW_MODULE_TYPE_NA else {
                print("No accelerometer")
                return
            }
            let signal = mbl_mw_acc_get_acceleration_data_signal(board)
            mbl_mw_datasignal_subscribe(signal, bridge(obj: self)) { (context, data) in
                let contBridge: ActionsViewController = bridge(ptr: context!)
                let obj: MblMwCartesianFloat = data!.pointee.valueAs()
                if ((abs(obj.x)>0.9) || (abs(obj.y)>0.9)){
                    //print(obj.x, obj.y, obj.z)
                    print("MOVEMENT DETECTED")
                    contBridge.sensorInput()
                }
            }
            mbl_mw_acc_enable_acceleration_sampling(board)
            mbl_mw_acc_start(board)
    }
    
    func sensorInput(){
		if (self.confirm){
			timer.invalidate()
			// Stop getting Data from sensor
			let board = device.board
			let signal = mbl_mw_acc_get_acceleration_data_signal(board)
            mbl_mw_acc_stop(board)
            mbl_mw_acc_disable_acceleration_sampling(board)
            mbl_mw_datasignal_unsubscribe(signal)
			DispatchQueue.main.async {
				self.startButton.configuration?.background.backgroundColor = UIColor.white
				switch self.count {
				case 0:
					self.action4.configuration?.baseBackgroundColor = UIColor.blue
                    self.confirmed = AVSpeechUtterance(string: "read is confirmed")
				case 1:
					self.action1.configuration?.baseBackgroundColor = UIColor.blue
                    self.confirmed = AVSpeechUtterance(string: "sleep is confirmed")
				case 2:
					self.action2.configuration?.baseBackgroundColor = UIColor.blue
                    self.confirmed = AVSpeechUtterance(string: "draw is confirmed")
				case 3:
					self.action3.configuration?.baseBackgroundColor = UIColor.blue
                    self.confirmed = AVSpeechUtterance(string: "play is confirmed")
				default:
					self.action1.configuration?.baseBackgroundColor = UIColor.blue
				}
                self.confirmed.voice = AVSpeechSynthesisVoice(language: "en-US")
                self.synthesizer.speak(self.confirmed)
			}
		}
		else{
			timer.invalidate()
            timer2 = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerWait), userInfo: nil, repeats: false)
			/*let confirmspeak = AVSpeechUtterance(string: "Confirm Selection of")
			confirmspeak.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(confirmspeak)
			let moviespeak = AVSpeechUtterance(string: self.currentaction)
			moviespeak.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(moviespeak)*/
			self.confirm = true
		}
    }
    
    @objc func timerUpdate() {
        
        switch count % 4 {
        case 0:
            self.action4.configuration?.baseBackgroundColor = UIColor.white
            self.action1.configuration?.baseBackgroundColor = UIColor.green
			self.currentaction = "sleep"
			let sleep = AVSpeechUtterance(string: self.currentaction)
			sleep.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(sleep)
        case 1:
            self.action1.configuration?.baseBackgroundColor = UIColor.white
            self.action2.configuration?.baseBackgroundColor = UIColor.green
			self.currentaction = "draw"
			let draw = AVSpeechUtterance(string: self.currentaction)
			draw.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(draw)
        case 2:
            self.action2.configuration?.baseBackgroundColor = UIColor.white
            self.action3.configuration?.baseBackgroundColor = UIColor.green
			self.currentaction = "play"
			let play = AVSpeechUtterance(string: self.currentaction)
			play.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(play)
        case 3:
            self.action3.configuration?.baseBackgroundColor = UIColor.white
            self.action4.configuration?.baseBackgroundColor = UIColor.green
			self.currentaction = "read"
			let read = AVSpeechUtterance(string: self.currentaction)
			read.voice = AVSpeechSynthesisVoice(language: "en-US")
			synthesizer.speak(read)
        default:
            self.action1.configuration?.baseBackgroundColor = UIColor.white
            self.action2.configuration?.baseBackgroundColor = UIColor.white
            self.action3.configuration?.baseBackgroundColor = UIColor.white
            self.action4.configuration?.baseBackgroundColor = UIColor.white
        }
        
        count += 1
        
    }
	@objc func timerWait() {
		self.confirm = false;
		timer = Timer.scheduledTimer(timeInterval: Double(scrollTime), target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
	}
	@IBAction func back(_ sender: UIButton) {
		timer.invalidate();
	}
    
}
