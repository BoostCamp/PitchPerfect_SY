//
//  ViewController.swift
//  PitchPerfect_sy
//
//  Created by 윤사라 on 2017. 1. 9..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecord(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
    }
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        
    }

}

