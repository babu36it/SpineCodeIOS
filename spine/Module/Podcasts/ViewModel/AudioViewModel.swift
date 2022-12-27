//
//  AudioViewModel.swift
//  spine
//
//  Created by Mac on 27/12/22.
//

import Foundation
import AVKit
import AVFoundation

class AudioViewModel: ObservableObject {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    @Published var isPlaying = false
    var isEditing: Bool = false
    
    init(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    var duration: Double {
        self.player?.currentItem?.duration.seconds ?? 0.0
    }
    
    func playPause() {
        if let player = player {
            if isPlaying {
                player.pause()
            } else {
                player.play()
            }
            isPlaying = player.rate != 0
        }
    }
    
    func updateCurrentTime(value: Double) {
        if let player = player {
            player.seek(to: CMTime(seconds: value, preferredTimescale: 1000000))
        }
    }
    
    func stopPlayer() {
        player = nil
    }
    
}
