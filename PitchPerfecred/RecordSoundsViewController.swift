//
//  RecordSoundsViewController.swift
//  PitchPerfecred
//
//  Created by JASJEEV on 3/29/20.
//  Copyright © 2020 Lorgarithmic Science. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	
    @IBOutlet weak var RecordButton: UIButton!
    
    @IBOutlet weak var RecordMsgLabel: UILabel!
    
    @IBOutlet weak var StopRecording: UIButton!
    
    var audioRecorder:  AVAudioRecorder!
    
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
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath)

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopRecord(_ sender: Any) {
        RecordButton.isEnabled = true
        StopRecording.isEnabled = false
        RecordMsgLabel.text = "Tap to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Failed recording")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL  = recordedAudioURL
        }
    }
}

