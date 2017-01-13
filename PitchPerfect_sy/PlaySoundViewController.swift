//
//  PlaySoundViewController.swift
//  PitchPerfect_sy
//
//  Created by 윤사라 on 2017. 1. 12..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    //show duration and progress view
    @IBOutlet weak var recordedTime: UILabel!
    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    //different pitch buttons
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var progressTimer: Timer!
    
    let timePlayerSelector:Selector = #selector(PlaySoundViewController.updatePlayTime)

    //init duration time
    var durationTime = ""
    var countProgress : Float = 0.0
    var currentTime : Float = 0.0
    var totalTime : Float = 0.0

    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb}
    
    
    @IBAction func playSoundForButton(_ sender: UIButton){
       
        
        switch(ButtonType(rawValue: sender.tag)!)
       {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)

        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo:nil, repeats:true)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject)
    {
        stopAudio()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
    }
    
    func updatePlayTime()
    {
        currentTimeCal()
        //start time label update
        startTimeLabel.text = convertNSTimerInterval2String(time:TimeInterval(currentTime))
        
        //progressview update
        totalTime = Float(Float(audioFile.length) / Float(audioFile.fileFormat.sampleRate))
        pvProgressPlay.progress = Float(currentTime/totalTime)
    }
   
    //calculate current play time
    func currentTimeCal()
    {
        if let lastRenderTime = audioPlayerNode.lastRenderTime, let playerTime = audioPlayerNode.playerTime(forNodeTime: lastRenderTime){
            currentTime = Float(Double(playerTime.sampleTime) / playerTime.sampleRate)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
   
    //convert to string 
    func convertNSTimerInterval2String(time:TimeInterval) -> String{
        let min = Int(time/60)
        let sec = Int((time.truncatingRemainder(dividingBy: 60)))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
