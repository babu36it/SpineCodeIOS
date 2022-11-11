//
//  MicrophoneVisualization.swift
//  spine
//
//  Created by Mac on 10/09/22.
//
import SwiftUI
import Speech
//import SwiftSpeech
import Combine


fileprivate let numberOfSamples: Int = 100

struct MicrophoneVisualization: View {
    var height: CGFloat = 200
    var fColor: Color = .white
    @EnvironmentObject var mic: VoiceViewModel

   // @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)

    private func normalizeSoundLevel(level: Float, maxHeight: CGFloat) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        return CGFloat(level * (maxHeight / 25))
    }

    var body: some View {
        GeometryReader { g in
            main(spacing: g.size.width / (2 * CGFloat(numberOfSamples)),
                 height: g.size.height)
        }.frame(height: height)
    }

    func main(spacing: CGFloat, height: CGFloat) -> some View {
        VStack {
            HStack(spacing: spacing) {
                ForEach(mic.soundSamples.indices, id: \.self) { i in
                    BarView(value: self.normalizeSoundLevel(level: mic.soundSamples[i], maxHeight: height), width: spacing, fColor: fColor)
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

struct BarView: View {
    
    var value: CGFloat
    var width: CGFloat
    var fColor: Color = .white

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: width / 2)
                .foregroundColor(fColor)
                .frame(width: width, height: max(width, value))
        }
    }
}

class MicrophoneMonitor: ObservableObject {

    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    private var currentSample: Int
    private let numberOfSamples: Int
    @Published public var soundSamples: [Float]

    init(numberOfSamples: Int) {
        self.numberOfSamples = numberOfSamples
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0

        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }

        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])

            startMonitoring()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.audioRecorder.updateMeters()
            DispatchQueue.main.async {
                self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
            }
        })
    }

    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}

