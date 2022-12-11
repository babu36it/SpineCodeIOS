//
//  VoiceViewModel.swift
//  spine
//
//  Created by Mac on 10/09/22.
//

import Foundation
import AVFoundation
fileprivate let numberOfSamples1: Int = 100
class VoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate {
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    @Published var isRecording : Bool = false
    @Published var isPlaying : Bool = false
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var timer : String = "0:00"
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("CO-Voice.m4a")
    @Published var isAudioExist : Bool = false
    
    //new
    @Published public var soundSamples: [Float]
    private var timer1: Timer?
    private var currentSample: Int
    private let numberOfSamples: Int
    
    override init() {
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples1)
        self.numberOfSamples = numberOfSamples1
        self.currentSample = 0
    }
    
    private func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        self.timer1 = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.audioRecorder.updateMeters()
            DispatchQueue.main.async {
                self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
            }
        })
    }

//    deinit {
//        timer1?.invalidate()
//        audioRecorder.stop()
//    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: filePath, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
            self.startMonitoring()
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.countSec += 1
                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
                if self.countSec > 10 {
                    self.stopRecording()
                }
            })
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    func stopRecording(){
        audioRecorder.stop()
        isRecording = false
        self.countSec = 0
        timerCount!.invalidate()
       // blinkingCount!.invalidate()
        isAudioExist = true
    }
    
    func startPlaying() {
        let playSession = AVAudioSession.sharedInstance()
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            self.isPlaying = true
            self.startMonitoring()
        } catch {
            print("Playing Failed")
        }
    }
    
    func pausePlaying() {
        audioPlayer.pause()
    }
    
    
    func stopPlaying() {
        self.isPlaying = false
        audioPlayer.stop()
        audioRecorder.stop()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        audioRecorder.stop()
        print("stop playing")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print(error)
        }
    }
    func deleteRecording(){
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            print("catch error")
        }
        isAudioExist = false
    }
    
//    func isAudioExist()-> Bool {
//        return FileManager.default.fileExists(atPath: filePath.path)
//    }
    
    func covertSecToMinAndHour(seconds : Int) -> String{
        let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec : String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
    }
}

extension Date {
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
