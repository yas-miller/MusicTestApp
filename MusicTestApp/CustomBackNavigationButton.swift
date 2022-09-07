//
//  CustomBackNavigationButton.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI
import NavigationStack

struct CustomBackNavigationButton: View {
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        HStack {
            if self.navigationStack.depth > 0 {
                Button(action: {
                    self.navigationStack.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .scaleEffect(0.83)
                        .font(Font.title.weight(.medium))
                }
                .padding(Edge.Set.horizontal, 10)
                Spacer()
            }
        }
    }
}

struct CustomBackNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackNavigationButton()
    }
}
