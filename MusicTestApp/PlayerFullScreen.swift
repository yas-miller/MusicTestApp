//
//  PlayerFullScreen.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerFullScreen: View {
    @Binding public var isPlayerFullScreenViewPresented: Bool
    @State private var appeared: Double = 0
    @ObservedObject private var musicPlayer: MusicPlayer = MusicPlayer.shared
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isPlayerFullScreenViewPresented.toggle()
                }, label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                })
                Spacer()
            }
            VStack {
                if let currentMusicTrackInQueue = musicPlayer.musicTracksQueue.first {
                    Text(currentMusicTrackInQueue.name)
                    Text(currentMusicTrackInQueue.performer.name)
                    
                    if let artworkBinaryImage = musicPlayer.getCurrentMusicTrackArtworkImageFromMetadata() {
                        Image(uiImage: artworkBinaryImage)
                    }
                }
                
                Text(String(format: "%02d:%02d", (Int)(musicPlayer.currentTime) / 60, (Int)(musicPlayer.currentTime) % 60))
                Slider(value: $musicPlayer.currentTime, in: 0...musicPlayer.duration)
                Text(String(format: "%02d:%02d", (Int)(musicPlayer.duration) / 60, (Int)(musicPlayer.duration) % 60))
                
                HStack {
                    if musicPlayer.isPlaying {
                        Button(action: {
                            MusicPlayer.shared.pause()
                        }, label: {
                            Image(systemName: "pause.circle")
                                .imageScale(.large)
                        })
                    }
                    else {
                        Button(action: {
                            MusicPlayer.shared.play()
                        }, label: {
                            Image(systemName: "play.circle")
                                .imageScale(.large)
                        })
                        .disabled(musicPlayer.musicTracksQueue.isEmpty)
                    }
                    
                    Button(action: {
                        do
                        {
                            try MusicPlayer.shared.playNextInQueue()
                        }
                        catch let error
                        {
                            
                        }
                    }, label: {
                        Image(systemName: "forward.circle")
                            .imageScale(.large)
                    })
                    .disabled(musicPlayer.musicTracksQueue.count < 2)
                }
            }
            .opacity(appeared)
            .animation(Animation.easeInOut(duration: 1.0), value: appeared)
            .onAppear {self.appeared = 1.0}
            .onDisappear {self.appeared = 0.0}
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}
