//
//  AudioPreviewView.swift
//  spine
//
//  Created by Mac on 10/09/22.
//

import SwiftUI

struct AudioPreviewView: View {
    @EnvironmentObject var voiceVM: VoiceViewModel
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                BannerImageView(image: "AudioBG", heightF: 1)
                MicrophoneVisualization(height: 200).environmentObject(voiceVM)
            }
            Title4(title: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.").padding()
            Spacer()
        }
        
        .onAppear {
            voiceVM.startPlaying()
        }
        
    }
}

struct AudioPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPreviewView()
    }
}
