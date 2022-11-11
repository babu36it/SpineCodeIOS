//
//  MusicPlayerView.swift
//  spine
//
//  Created by Mac on 26/05/22.
//

import SwiftUI

struct MusicPlayerView: View {
    @State var sliderValue: CGFloat = 10
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Image("musicPlayerBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.72)
                    //.mask(Color.white.opacity(0.9))
                VStack(alignment: .leading, spacing: 8) {
                    Title4(title: "EPISODE-#3", fColor: .white)
                    Header1(title: "Universal Laws from Friend of the Indian -2", fColor: .white)
                    Title4(title: "Eospace mit dem ganzen Universum", fColor: .white)
                    HStack(spacing: 10) {
                        CircularBorderedProfileView(image: "Oval 57", size: 45, borderWidth: 3)
                        Title4(title: "Tom Reese", fColor: .white)
                        Spacer()
                        LargeButton(title: "ALL EPISODES", width: 140, height: 30, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                            dismiss()
                        }
                        
                    }.padding(.top, 10)
                }.padding(.horizontal, 30)
                    .padding(.bottom, 20)
                
            }
           
            ZStack(alignment: .top) {
                Text("")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.28)
                //.background(Color.lightBrown)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.lightBrown.opacity(0.4), Color.lightBrown]), startPoint: .top, endPoint: .bottom)
                    )
//                Image("ic_background")
//                    .resizable()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.28)
//                    .scaleEffect()
//                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Slider(value: $sliderValue, in: 0...100) { _ in
                        print("")
                    }.tint(Color.lightBrown)
                        .padding()
                    
                    HStack {
                        
                        ButtonWithSystemImage(image: "heart.fill", size: 18, fColor: Color.lightGray1) {
                            print("Heart tapped")
                        }
                        Spacer()
                        ButtonWithSystemImage(image: "backward.fill", size: 20, fColor: Color.lightBrown) {
                            
                        }
                        Spacer()
                        ZStack {
                            Text("")
                                .frame(width: 70, height: 70)
                                .background(Color.lightBrown)
                                .clipShape(Circle())
                            ButtonWithSystemImage(image: "play.fill", size: 20, fColor: .white) {
                                
                            }.padding(.leading,3)
                        }
                        Spacer()
                        ButtonWithSystemImage(image: "forward.fill", size: 20, fColor: Color.lightBrown) {
                            
                        }
                        Spacer()
                        ButtonWithCustomImage(image: "directArrow", size: 18) {
                            print("share tapped")
                        }
                        
                    }.padding(.horizontal, 20)
                    Color(hex: 0xD7C7B5)
                        .frame(width: 60, height: 2)
                }
            }
        }.edgesIgnoringSafeArea(.top)
        //.padding(.bottom, 170) //tab bar height
            .modifier(BackButtonModifier(fColor: .white, action: {
                self.dismiss()
            }))
            .navigationBarItems(trailing: Button(action : {
                print("More")
            }){
                NavBarButtonImage(image: "More")
            })
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView()
    }
}


import AVKit
import AVFoundation

struct MusicPlayerView1: View {
    @StateObject var audioVM: AudioViewModel
    var feed: RssFeedModel?
    var item: RssItemModel?
    var user: RssUserModel?
    @State var value: Double = 0.0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) var dismiss
    
    @State var player = AVPlayer()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Image("musicPlayerBG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.72)
                    //.mask(Color.white.opacity(0.9))
                VStack(alignment: .leading, spacing: 8) {
                    Title4(title: "EPISODE-#3", fColor: .white)
                    Header1(title: item?.title ?? "NA", fColor: .white)
                    Title4(title: feed?.title ?? "NA", fColor: .white)
                    HStack(spacing: 10) {
                        CircularBorderedProfileView1(imageUrl: user?.user_image ?? "", size: 45, borderWidth: 3)
                        Title4(title: item?.author ?? "NA", fColor: .white)
                        Spacer()
                        LargeButton(title: "ALL EPISODES", width: 140, height: 30, bColor: Color.lightBrown, fSize: 12, fColor: .white) {
                            dismiss()
                        }
                        
                    }.padding(.top, 10)
                }.padding(.horizontal, 30)
                    .padding(.bottom, 20)
                
            }
           
            ZStack(alignment: .top) {
                Text("")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.28)
                //.background(Color.lightBrown)
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
                            Text("")
                                .frame(width: 70, height: 70)
                                .background(Color.lightBrown)
                                .clipShape(Circle())
                            ButtonWithSystemImage(image: audioVM.isPlaying ? "pause.fill": "play.fill", size: 20, fColor: .white) {
                                audioVM.playPause()
                            }.padding(.leading,3)
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
}

class AudioViewModel: ObservableObject {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    @Published var isPlaying = false
    var isEditing: Bool = false
    
    init(urlStr: String) {
        playerItem = AVPlayerItem(url: URL(string: urlStr)!)
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
