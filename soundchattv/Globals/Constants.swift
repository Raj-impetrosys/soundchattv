//
//  Constants.swift
//  soundchattv
//
//  Created by RAJKUMAR on 15/05/23.
//

import Foundation
import UIKit

var width = UIScreen.main.bounds.size.width
var height = UIScreen.main.bounds.size.height
var baseUrl = "https://app.soundchatradio.com:3000/api/v1/auth/"
var baseurlimage =
    "https://app.soundchatradio.com/soundradiobackend/images/"
var baseurlTimelineThumbnailImage = "\(baseurlimage)thumbnail/"
var baseurlTimelineImage = "\(baseurlimage)timeline/"
var baseurlimagepodcast = "\(baseurlimage)podcast/"
var liveVideoStreaming = "https://1885255065.rsc.cdn77.org/soundchatradio/livestream/playlist.m3u8"
var baseurlimageinetrviews = "\(baseurlimage)interviews/";

class GlobalString: ObservableObject {
  @Published var isLogin: Bool = false
}
