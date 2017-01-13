//
//  RecordSoundViewController.swift
//  PitchPerfect_sy
//
//  Created by 윤사라 on 2017. 1. 9..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    var progressTimer: Timer!
        
    let timeRecordSelector:Selector = #selector(RecordSoundViewController.updateRecordTime)
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var recordTime: UILabel!
   
    var durationTime : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func convertNSTimerInterval2String(time:TimeInterval) -> String{
        let min = Int(time/60)
        let sec = Int((time.truncatingRemainder(dividingBy: 60)))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func updateRecordTime()
    {
        recordTime.text = convertNSTimerInterval2String(time: audioRecorder.currentTime)
    }

    @IBAction func startRecord(_ sender: AnyObject) {
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url:filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo:nil, repeats:true)
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        durationTime = recordTime.text
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("recording was not successful")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?)
    {
        if segue.identifier == "stopRecording"
        {
        let playSoundVC = segue.destination as! PlaySoundViewController
        let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        
        let duration = segue.destination as! PlaySoundViewController
            duration.durationTime = durationTime
            
            
        }
        
    }
}

