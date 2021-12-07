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
    
    var device: MetaWear!
    var scrollTime: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundColor = UserDefaults.standard.string(forKey: "selectedBackgroundColor")
        view.backgroundColor = SystemColor(color: String(backgroundColor ?? "Red"))
        let textColor = UserDefaults.standard.string(forKey: "selectedTextColor")
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = SystemColor(color: textColor ?? "Black")
        
        super.viewWillAppear(animated);
        
    }

   
    func didGetTemperature(timestamp: Date, entry: Float) {
        print("temp: \(timestamp) \(entry)")
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
                homeViewController.scrollTime = 3
            }
        }
    
}
