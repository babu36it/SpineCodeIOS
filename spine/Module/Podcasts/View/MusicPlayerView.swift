//
//  MusicPlayerView.swift
//  spine
//
//  Created by Mac on 26/05/22.
//

import SwiftUI
import AVKit
import AVFoundation

struct MusicPlayerView1: View {
    @StateObject var audioVM: AudioViewModel
    let mpModel: MusicPlayerModel
    @State var value: Double = 0.0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) var dismiss
    @State var player = AVPlayer()
    
    var body: some View {
        VStack(spacing: 0) {
            musicPlayerBackgroundView
           
            ZStack(alignment: .top) {
                Text("")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.28)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.lightBrown.opacity(0.4), Color.lightBrown]), startPoint: .top, endPoint: .bottom)
                    )
                
                if let player = audioVM.player, let duration = player.currentItem?.asset.duration {
                    VStack {
                        Slider(value: $value, in: 0...CMTimeGetSeconds(duration)) { editing in
                            audioVM.isEditing = editing
                            if !editing {
                                audioVM.updateCurrentTime(value: value)
                            }
                        }.tint(Color.lightBrown).padding(.top, 20)
                        
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: CMTimeGetSeconds(player.currentTime())) ?? "0:00")
                            Spacer()
                            Text(DateComponentsFormatter.positional.string(from: CMTimeGetSeconds(duration) - CMTimeGetSeconds(player.currentTime())) ?? "0:00")
                        }.font(.caption)
                        
                        HStack {
                            
                            ButtonWithSystemImage(image: "heart.fill", size: 18, fColor: Color.lightGray1) {
                                print("Heart tapped")
                            }
                            Spacer()
                            ButtonWithSystemImage(image: "backward.fill", size: 20, fColor: Color.lightBrown) {
                                audioVM.updateCurrentTime(value: value - 10)
                            }
                            Spacer()
                            ZStack {
                                Color.lightBrown
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                                ButtonWithSystemImage(image: audioVM.isPlaying ? "pause.fill": "play.fill", size: 20, fColor: .white) {
                                    audioVM.playPause()
                                }//.padding(.leading,3)
                            }

                            Spacer()
                            ButtonWithSystemImage(image: "forward.fill", size: 20, fColor: Color.lightBrown) {
                                audioVM.updateCurrentTime(value: value + 10)
                            }
                            Spacer()
                            ButtonWithCustomImage(image: "directArrow", size: 18) {
                                print("share tapped")
                            }
                            
                        }//.padding(.horizontal, 20)
                        Color(hex: 0xD7C7B5)
                            .frame(width: 60, height: 2)
                    }.padding(.horizontal, 20)
                }//player
            }
        }.edgesIgnoringSafeArea(.top)
        //.padding(.bottom, 170) //tab bar height
            .onReceive(timer) { _ in
                guard let player = audioVM.player, !audioVM.isEditing else {return}
                value = CMTimeGetSeconds(player.currentTime())
            }
            .onDisappear {
                audioVM.stopPlayer()
            }
            .modifier(BackButtonModifier(fColor: .white, action: {
                self.dismiss()
            }))
            .navigationBarItems(trailing: Button(action : {
                print("More")
            }){
                NavBarButtonImage(image: "More")
            })
    }
    
    @ViewBuilder
    var musicPlayerBackgroundView: some View {
        ZStack(alignment: .bottom) {
            Image("musicPlayerBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.72)
            //.mask(Color.white.opacity(0.9))
            VStack(alignment: .leading, spacing: 8) {
                Title4(title: mpModel.episodeNumber, fColor: .white)
                Header1(title: mpModel.title, fColor: .white)
                Title4(title: mpModel.subtitle, fColor: .white)
                HStack(spacing: 10) {
                    CircularBorderedProfileView1(imageUrl: mpModel.authorImage, size: 45, borderWidth: 3)
                    Title4(title: mpModel.authorName, fColor: .white)
                    Spacer()
                    LargeButton(title: "ALL EPISODES", width: 140, height: 30, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                        dismiss()
                    }
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
    }
}


