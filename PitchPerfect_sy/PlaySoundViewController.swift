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
    
    @IBOutlet weak var recordedTime: UILabel!
   
    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!

    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var slVolumeLabel: UILabel!
    @IBOutlet weak var slVolume: UISlider!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    let timePlayerSelector:Selector = #selector(PlaySoundViewController.updatePlayTime)

    
    var durationTime = ""

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
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject)
    {
        stopAudio()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
    }
    func convertNSTimerInterval2String(time:TimeInterval) -> String{
        let min = Int(time/60)
        let sec = Int((time.truncatingRemainder(dividingBy: 60)))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func updatePlayTime(){
        startTimeLabel.text = convertNSTimerInterval2String(time: audioPlayer.currentTime)
        print(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayerNode.volume = slVolume.value
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
