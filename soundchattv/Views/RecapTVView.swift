//
//  RecapTVView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 23/05/23.
//

import SwiftUI
import Alamofire

struct RecapTVView: View {
    @State private var recapTVShows: RecapTVShow?
    @State private var currentInterview: Event?
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView{
            ZStack(alignment: .top){
                NetworkImage(urlString:baseurlimageinetrviews + (currentInterview?.tvposter ?? currentInterview?.featureImg ?? ""))
                    .frame(width: width, height: height * 0.8)
                    .overlay {
                    LinearGradient(colors: [.black,.black.opacity(0.5), .black.opacity(0)], startPoint: .leading, endPoint: .trailing)
                }
        VStack(alignment: .leading){
            Image("soundchat-tv-logo").resizable().scaledToFit().frame(width: 150, height: 150)
            Text("TRENDING").font(.title2)
            
            NavigationLink{
                if(currentInterview != nil){
                    VideoPlayerView(url: currentInterview!.videoURL)
                }
                
            }label: {
                HStack(spacing: 10){
                    Image(systemName: "play.circle.fill").foregroundColor(.red)
                    Text("WATCH NOW").font(.title3)
                }
            }
            
            Text(currentInterview?.postTitle ?? "").font(.title).bold().foregroundColor(.gray)
            Text(currentInterview?.postExcerpt ?? "").font(.caption)
        }
        .frame(width: width * 0.95, alignment: .leading)
        
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(timer) { _ in
                currentInterview = recapTVShows?.mawninVibesShow.randomElement()
//                print(currentInterview)
            }
            ///latest
            HorizontalList(events: recapTVShows?.soundChatTalkShow, heading: recapTVShows?.soundChatTalkShow.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.soundChatTalkShowMonday, heading: recapTVShows?.soundChatTalkShowMonday.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.mawninVibesShow, heading: recapTVShows?.mawninVibesShow.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.soundChatTVRandomMix, heading: recapTVShows?.soundChatTVRandomMix.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.supaFridgeReeewindSun, heading: recapTVShows?.supaFridgeReeewindSun.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.talkAnythingFridays, heading: recapTVShows?.talkAnythingFridays.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.timeTravelSeries, heading: recapTVShows?.timeTravelSeries.first!.interviewType ?? "")
            HorizontalList(events: recapTVShows?.winnersCircleSports, heading: recapTVShows?.winnersCircleSports.first!.interviewType ?? "")
        }
            .onAppear(){
                
                AF.request("\(baseUrl)recaptvlist", method: .post, parameters: ["":""], encoder: JSONParameterEncoder.default)
                    .responseDecodable(of: RecapTVResponse.self) { response in
                        if(response.error == nil){
                            recapTVShows = response.value!.data
                            currentInterview = recapTVShows?.mawninVibesShow.first
//                            print(recapTVShows.debugDescription)
    //                        raandomIndexForAds = Int.random(in: 0...ads.count-1)
                        }else{
                            print(response.error!.localizedDescription)
                        }
                        
                    }
            }
    }
}

struct RecapTVView_Previews: PreviewProvider {
    static var previews: some View {
        RecapTVView()
    }
}
