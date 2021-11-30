//
//  TalkViewController.swift
//  iOS
//
//  Created by Kamren Davis on 11/14/21.
//  Copyright © 2021 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear
import MetaWearCpp
import MBProgressHUD
import AVFoundation

@available(iOS 15.0, *)
class TalkViewController: UIViewController {
    @IBOutlet weak var deviceStatus: UILabel!
    @IBOutlet weak var yesNoLabel: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    var enable = false;
    var yes = false;
    let synthesizer = AVSpeechSynthesizer()
    var check: Bool = false;
    
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    var device: MetaWear!
    
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
        self.yes = false;
        self.yesNoLabel.configuration?.background.backgroundColor = UIColor.red
        self.yesNoLabel.configuration?.title = "No"
        yesNoLabel.titleLabel?.font =  UIFont(name: "Futura Medium", size: 90)
        yesNoLabel.titleLabel?.textColor = UIColor.black
        
        let board = device.board
            guard mbl_mw_metawearboard_lookup_module(board, MBL_MW_MODULE_ACCELEROMETER) != MBL_MW_MODULE_TYPE_NA else {
                print("No accelerometer")
                return
            }
            let signal = mbl_mw_acc_get_acceleration_data_signal(board)
            mbl_mw_datasignal_subscribe(signal, bridge(obj: self)) { (context, data) in
                let contBridge: TalkViewController = bridge(ptr: context!)
                let obj: MblMwCartesianFloat = data!.pointee.valueAs()
                if ((abs(obj.x)>0.7) || (abs(obj.y)>0.7)){
                    //print(obj.x, obj.y, obj.z)
                    print("MOVEMENT DETECTED")
                    contBridge.sensorInput()
                }
            }
            mbl_mw_acc_enable_acceleration_sampling(board)
            mbl_mw_acc_start(board)
    }
    
    func sensorInput(){
        
        // Stop getting Data from sensor
        let board = device.board
            let signal = mbl_mw_acc_get_acceleration_data_signal(board)
            mbl_mw_acc_stop(board)
            mbl_mw_acc_disable_acceleration_sampling(board)
            mbl_mw_datasignal_unsubscribe(signal)
        
        
        // Ensure main thread
        DispatchQueue.main.async {
            let yesspeak = AVSpeechUtterance(string: "yes")
            yesspeak.voice = AVSpeechSynthesisVoice(language: "en-US")
            self.synthesizer.speak(yesspeak)
            self.yes = true;
            self.yesNoLabel.configuration?.background.backgroundColor = UIColor.green
            self.yesNoLabel.configuration?.title = "Yes"
            self.yesNoLabel.titleLabel?.font =  UIFont(name: "Futura Medium", size: 90)
            self.yesNoLabel.titleLabel?.textColor = UIColor.black
            self.startButton.configuration?.background.backgroundColor = UIColor.white
        }
        
        //timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
    }
    
    
    @objc func timerUpdate() {
        self.yes = false;
        self.yesNoLabel.configuration?.background.backgroundColor = UIColor.red
        self.yesNoLabel.configuration?.title = "No"
    }
    
}
