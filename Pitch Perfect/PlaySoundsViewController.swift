//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Wally Thornton on 6/11/15.
//  Copyright (c) 2015 Wally Thornton. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopEverything() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func audioPlayModifier(rate: Float) {
        stopEverything()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayModifier(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayModifier(1.5)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopEverything()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithReverb(reverb: Float) {
        stopEverything()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var addReverb = AVAudioUnitReverb()
        addReverb.wetDryMix = reverb
        
        audioEngine.attachNode(addReverb)
        
        audioEngine.connect(audioPlayerNode, to: addReverb, format: nil)
        audioEngine.connect(addReverb, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        playAudioWithReverb(80.0)
    }
    
    func playAudioWithEcho() {
        stopEverything()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var addEcho = AVAudioUnitDistortion()
        addEcho.loadFactoryPreset(AVAudioUnitDistortionPreset(rawValue: 13)!)
        
        audioEngine.attachNode(addEcho)
        
        audioEngine.connect(audioPlayerNode, to: addEcho, format: nil)
        audioEngine.connect(addEcho, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        playAudioWithEcho()
    }
    
    @IBAction func stopAudioPlay(sender: UIButton) {
        stopEverything()
    }

}
