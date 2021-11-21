//
//  DeviceViewController.swift
//  SwiftStarter
//
//  Created by Stephen Schiffli on 10/20/15.
//  Copyright © 2015 MbientLab Inc. All rights reserved.
//

import UIKit
import MetaWear
import MetaWearCpp

@available(iOS 15.0, *)
class DeviceViewController: UIViewController {
    @IBOutlet weak var deviceStatus: UILabel!
    
    let textColorChoices = ["Black", "Gray", "White", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    let backgroundColorChoices = ["Red", "Black", "Gray", "White", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    var device: MetaWear!
    
    override func viewWillAppear(_ animated: Bool) {
        let row = UserDefaults.standard.integer(forKey: "backgroundPickerViewRow")
        view.backgroundColor = SystemColor(color: backgroundColorChoices[row])
        
        super.viewWillAppear(animated);
        
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
                    
                }
            }
        }
    }

    
    func updateLabel(_ msg: String) {
        DispatchQueue.main.async {
            self.deviceStatus.text = msg
        }
    }
    
    func didGetTemperature(timestamp: Date, entry: Float) {
        print("temp: \(timestamp) \(entry)")
    }
    
    func progress(entriesLeft: UInt32, totalEntries: UInt32) {
        // Clear the in progress flag
        if entriesLeft == 0 {
            self.updateLabel("Finished download \(totalEntries) entries")
        }
    }
    
    func unknownEntry(id: UInt8, epoch: Int64, data: UnsafePointer<UInt8>?, length: UInt8) {
        print("unknownEntry: \(epoch) \(String(describing: data)) \(length)")
    }
    
    func unhandledEntry(data: UnsafePointer<MblMwData>?) {
        print("unhandledEntry: \(String(describing: data))")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        device.flashLED(color: .red, intensity: 1.0, _repeat: 3)
        mbl_mw_debug_disconnect(device.board)
    }
    
    // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            if let homeViewController = segue.destination as? HomeViewController {
                homeViewController.device = (device!)
            }
        }
    
}
