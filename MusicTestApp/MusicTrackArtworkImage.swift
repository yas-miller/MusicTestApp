//
//  MusicTrackArtworkImage.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI
import MusicCodebase

struct MusicTrackArtworkImage: View {
    @State var musicTrack: MusicCodebase.MusicTrack
    
    var body: some View {
        if let artworkImageBinaryData = musicTrack.artworkImageBinaryData ?? { try? musicTrack.getArtworkImageBinaryDataFromMetadata(); return musicTrack.artworkImageBinaryData }() {
            Image(uiImage: UIImage(data: artworkImageBinaryData)!)
                .resizable()
                .scaledToFit()
        }
        else {
            Image(systemName: "xmark.circle")
                .imageScale(.large)
                .foregroundColor(.black)
        }
    }
}
