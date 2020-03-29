//
//  ViewController.swift
//  PitchPerfecred
//
//  Created by JASJEEV on 3/29/20.
//  Copyright © 2020 Lorgarithmic Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RecordButton: UIButton!
    
    @IBOutlet weak var RecordMsgLabel: UILabel!
    
    
    @IBOutlet weak var StopRecording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecordButton.isEnabled = true
        StopRecording.isEnabled = false
        // Do any additional setup after loading the view.
    }

    @IBAction func record(_ sender: Any) {
        RecordButton.isEnabled = false
        StopRecording.isEnabled = true
        RecordMsgLabel.text = "Tap to stop recording"
    }
    
    
    @IBAction func stopRecord(_ sender: Any) {
        RecordButton.isEnabled = true
        StopRecording.isEnabled = false
        RecordMsgLabel.text = "Tap to record"
    }
    
}

