//
//  InterviewsView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 19/05/23.
//

import SwiftUI
import Alamofire

struct InterviewsView: View {
    @State private var interviews: Interviews?
    @State private var currentInterview: Event?
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .top){
                NetworkImage(urlString:baseurlimageinetrviews + (currentInterview?.tvposter ?? currentInterview?.featureImg ?? ""))
                    .frame(width: width, height: height * 0.8).overlay {
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
        }.frame(width: width * 0.95, alignment: .leading)
            }.onReceive(timer) { _ in
                currentInterview = interviews?.events.randomElement()
            }
            
            HorizontalList(events: interviews?.inStudio, heading: interviews?.inStudio.first?.interviewType ?? "")
            HorizontalList(events: interviews?.events, heading: interviews?.soundSystemCulture.first?.interviewType ?? "")
            HorizontalList(events: interviews?.soundSystemCulture, heading: interviews?.yellowTent.first?.interviewType ?? "")
            HorizontalList(events: interviews?.yellowTent, heading: interviews?.events.first?.interviewType ?? "")
            
        }
            .onAppear(){
                
                AF.request("\(baseUrl)interviews", method: .post, parameters: ["":""], encoder: JSONParameterEncoder.default)
                    .responseDecodable(of: InterviewsResponse.self) { response in
                        if(response.error == nil){
                            interviews = response.value!.data
                            currentInterview = interviews?.events.first
//                            print(interviews.debugDescription)
    //                        raandomIndexForAds = Int.random(in: 0...ads.count-1)
                        }else{
                            print(response.error!.localizedDescription)
                        }
                
                    }
            }
    }
}

struct HorizontalList : View{
    let events: [Event]?
    let heading: String
    var body: some View{
        VStack{
            Text(heading).font(.subheadline).frame(maxWidth: .infinity, alignment: .leading).padding(10).background(LinearGradient(colors: [.gray, .black], startPoint: .leading, endPoint: .trailing))
            ScrollView(.horizontal){
                HStack{
                    ForEach(events ?? [], id: \.id){event in
                        PosterView(event: event, interviews: events ?? [])
                    }
                }
            }
        }
    }
}


struct PosterView : View{
    let event: Event
    let interviews: [Event]
    var body: some View{
        ZStack{
        NavigationLink{
            InterviewDetailView(interviews: interviews, event: event)
        }label: {
            NetworkImage(urlString:baseurlimageinetrviews + event.featureImg).frame(width: 250, height: 250).overlay {
                LinearGradient(colors: [.black, .black.opacity(0)], startPoint: .bottom, endPoint: .top)
            }.cornerRadius(20)
        }.cornerRadius(20).buttonStyle(.plain)
            Text(event.postTitle).lineLimit(2)
//                                .background(Color.black.opacity(0.5))
                .multilineTextAlignment(.center).frame(width: 250, height: 250, alignment: .bottom)
        }
    }
}

struct InterviewsView_Previews: PreviewProvider {
    static var previews: some View {
        InterviewsView()
    }
}
