//
//  PlayerFullScreen.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase
import NavigationStack

struct PlayerFullScreen: View {
    @Binding public var isViewPresented: Bool
    @State private var appeared: Double = 0
    @ObservedObject private var musicPlayer: MusicPlayer = MusicPlayer.shared
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isViewPresented.toggle()
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
                    
                    Button(currentMusicTrackInQueue.artist.name) {
                        self.isViewPresented = false
                        self.navigationStack.push(MusicTracksList(specifiedAuthor: currentMusicTrackInQueue.artist))
                    }
                    
                    if let artworkUIImage = musicPlayer.musicTracksQueue.first!.getArtworkImageFromMetadata() {
                        Image(uiImage: artworkUIImage)
                    }
                }
                
                Text(String(format: "%02d:%02d", (Int)(musicPlayer.currentTime) / 60, (Int)(musicPlayer.currentTime) % 60))
                Slider(value: $musicPlayer.currentTime, in: 0...musicPlayer.duration) {editing in
                    if !editing {
                        print(musicPlayer.currentTime)
                        musicPlayer.musicTracksPlayer?.currentTime = TimeInterval(musicPlayer.currentTime)
                        
                        musicPlayer.repeatedTimer?.resume()
                    }
                    else
                    {
                        musicPlayer.repeatedTimer?.pause()
                    }
                }
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
    }
}
