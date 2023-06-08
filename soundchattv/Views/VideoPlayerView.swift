//
//  VideoPlayerView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 19/05/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var url: String
    private let player: AVPlayer

    init(url: String){
        self.url = url
        player = AVPlayer(url: URL(string: url)!)
    }
     var body: some View {
        VideoPlayer(player: player)
             .onAppear() {
                         player.play()
                     }
    }
}

//struct VideoPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoPlayerView()
//    }
//}
