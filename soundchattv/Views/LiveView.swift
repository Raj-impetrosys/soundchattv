//
//  LiveView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 19/05/23.
//

//import SwiftUI
//
//struct LiveView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct LiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiveView()
//    }
//}

import SwiftUI
import CoreData
import Alamofire

struct LiveView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    @State private var stories: [Timeline] = []
    @State private var ads: [Ad] = []
    @State private var schedules: [Schedule] = []
    @State private var raandomIndex = 0
    @State private var raandomIndexForAds = 0
    @State private var currentShow: Scheduleperday?
    var maxNoOfSchedulesToShow = 8;
    @State var lastShows: [Scheduleperday] = [];
    @State var upcomingShows: [Scheduleperday] = [];
    let imageSize: CGFloat = 350
    let spacing: CGFloat = 5
    
    init(){
        let date = getDetroitTime()
        print(date)
    }

    var body: some View {
        ZStack(alignment: .top){
            if(currentShow == nil){
                ProgressView()
            } else{
                NetworkImage(urlString:baseurlimagepodcast + currentShow!.showImage).frame(width: width, height: height).overlay {
                    LinearGradient(colors: [.black,.black.opacity(0.5), .black.opacity(0)], startPoint: .leading, endPoint: .trailing)
                }
            }
           
            VStack(alignment: .leading){
                Image("soundchat-tv-logo").resizable().scaledToFit().frame(width: 150, height: 150)
                HStack(spacing: 20){
                    Text("LIVE NOW")
                    NavigationLink{
                        VideoPlayerView(url: liveVideoStreaming)
                    }label: {
                        HStack(spacing: 4){
                            Image(systemName: "play.circle.fill").foregroundColor(.red)
                            Text("WATCH").foregroundColor(.black)
                        }
//                        .padding(5).background(Color.white).cornerRadius(20).frame(width: 200)
                    }
                    
//                    NavigationLink{
//                        VideoPlayerView()
//                    }label: {
//                        HStack(spacing: 4){
//                            Image(systemName: "play.circle.fill").foregroundColor(.red)
//                            Text("Watch").foregroundColor(.black)
//                        }
//                    }
                    
                }
                if(currentShow == nil){
                    ProgressView()
                } else{
                    Group{
                        Text(currentShow!.showName).font(.title).foregroundColor(Color.gray)
                        Text(currentShow!.hostDesc ?? "").foregroundColor(Color.yellow)
                        Text(currentShow!.showDescription).font(.caption).foregroundColor(Color.gray)
                    }
                }
                
                HStack(spacing: spacing){
                    if(stories.isEmpty){
                        ProgressView()
                    } else{
                        ListItem(url: (stories[raandomIndex]
                            .timelinemedia
                            .first!
                            .mediaType
                            .contains("video"))
                                 ? baseurlTimelineThumbnailImage +
                                 (stories[raandomIndex]
                                    .timelinemedia
                                    .first!
                                    .mediaThumbnail ?? "")
                                 : baseurlTimelineImage +
                                 stories[raandomIndex]
                            .timelinemedia
                            .first!
                            .mediaName, title: "LATEST STORIES", imageSize: imageSize)
                        
                    }
                    
                    if(ads.isEmpty){
                        ProgressView()
                    } else{
                        ListItem(url: baseurlimage + ads[raandomIndexForAds].img, title: "PAID ADVERTISING", imageSize: imageSize)
                    }
                    
                    Spacer().frame(width: 10)
                    
                    VStack(spacing: spacing){
                        //                            ScrollView(.horizontal){
                        HStack(spacing: spacing){
                            Image("next_up").resizable().renderingMode(.template).frame(width: imageSize/2, height: imageSize/2).foregroundColor(.white)
                            ForEach(lastShows, id: \.showID) { show in
                                NetworkImage(urlString: baseurlimagepodcast + show.showImage).frame(width: imageSize/2, height: imageSize/2)
                            }
                        }
                        
                        HStack(spacing: spacing){
                            ForEach(lastShows, id: \.showID) { show in
                                NetworkImage(urlString: baseurlimagepodcast + show.showImage).frame(width: imageSize/2, height: imageSize/2)
                            }
                            Image("clock-refresh-icon").resizable().renderingMode(.template).frame(width: imageSize/2, height: imageSize/2).foregroundColor(.white)
                        }
                        
                        //                            }
                    }
                }
                
                
            }.frame(width: width * 0.9, height: height, alignment: .leading)
        }
            .onAppear(){
            struct Param: Encodable {
                let page: Int
                let limit: Int
            }

            let param = Param(page: 1, limit: 5)
            AF.request("\(baseUrl)listtimeline",
                       method: .post,
                       parameters: param,
                       encoder: JSONParameterEncoder.default)
            .responseDecodable(of: TimelineResponse.self) { response in
                if(response.value != nil){
                    stories = response.value!.data.rows
                    raandomIndex = Int.random(in: 0...stories.count-1)
                }
            }
            
            AF.request("\(baseUrl)homeslider", method: .post, parameters: ["slider_id":"1"], encoder: JSONParameterEncoder.default)
                .responseDecodable(of: HomesliderResponse.self) { response in
                    if(response.error == nil){
                        ads = response.value!.data
                        raandomIndexForAds = Int.random(in: 0...ads.count-1)
                    }else{
                        print(response.error!.localizedDescription)
                    }
                    
                }
            
            AF.request("\(baseUrl)listshowschedule", method: .post, parameters: ["slider_id":"1"], encoder: JSONParameterEncoder.default)
                .responseDecodable(of: ScheduleResponse.self) { response in
                    if(response.error == nil){
                        schedules = response.value!.data
    //                    raandomIndexForAds = Int.random(in: 0...schedules.count)
                        getCurrentShow()
                    }else{
                        print(response.error!.localizedDescription)
                    }
                    
                }
        }
    }
    
    func getCurrentShow(){
        currentShow = schedules.first?.scheduleperdays.first
        lastShows = Array(schedules.first!.scheduleperdays.prefix(upTo: 4))
        upcomingShows = Array(schedules.last!.scheduleperdays.prefix(upTo: 4))
    }
}



struct ListItem: View{
    var url: String
    var title: String
    let imageSize: CGFloat
    var body: some View{
        NetworkImage(urlString: url).frame(width: imageSize, height: imageSize).overlay {
            Text(title).padding(5).background(Color.black.opacity(0.9)).frame(width: imageSize, height: imageSize, alignment: .top).rotationEffect(Angle(degrees: 270))
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
