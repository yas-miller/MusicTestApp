//
//  PlayerControls.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI

struct PlayerControls: View {
    var body: some View {
        HStack {
            PlayerBackwardButton()
            PlayerPlayPauseButton()
            PlayerForwardButton()
        }
    }
}

struct PlayerControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControls()
    }
}
