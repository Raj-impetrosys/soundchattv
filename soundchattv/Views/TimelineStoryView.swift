//
//  TimelineStoryView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 31/05/23.
//

import SwiftUI
import Alamofire

//struct TimelineStoryView: View {
//    var body: some View {
//        GridView()
////        HStack{
////            TimelineListItemView()
////            TimelineListItemView()
////            TimelineListItemView()
////            TimelineListItemView()
////        }
//    }
//}

//struct TimelineListItemView: View{
//    var body: some View{
//        if(timelineList.isEmpty){
//            ProgressView()
//        } else{
//            ListItem(url: (stories[raandomIndex]
//                .timelinemedia
//                .first!
//                .mediaType
//                .contains("video"))
//                     ? baseurlTimelineThumbnailImage +
//                     stories[raandomIndex]
//                .timelinemedia
//                .first!
//                .mediaThumbnail
//                     : baseurlTimelineImage +
//                     stories[raandomIndex]
//                .timelinemedia
//                .first!
//                .mediaName, title: "LATEST STORIES", imageSize: imageSize)
//
//        }
//    }
//}

struct TimelineStoryView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineStoryView()
    }
}

struct TimelineStoryView: View {
    @State private var stories: [Timeline] = []
    @State private var currentTimeline: Timeline?
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
//    @State var data: Any
    @State private var raandomIndex = 0
    let imageSize: CGFloat = 350
    
//    init(){
//        data = (1...stories.count).map { "Item \($0)" }
//    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            ForEach(stories, id: \.id) { item in
                ListItem(url: (item
                                           .timelinemedia
                                           .first!
                                           .mediaType
                                           .contains("video"))
                                                ? baseurlTimelineThumbnailImage +
                         (item
                            .timelinemedia
                            .first!
                            .mediaThumbnail ?? "")
                                                : baseurlTimelineImage +
                                                item
                                           .timelinemedia
                                           .first!
                                           .mediaName, title: "LATEST STORIES", imageSize: imageSize)
            }
            
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(stories, id: \.id) { item in
//
//                    if(stories.isEmpty){
//                        ProgressView()
//                    } else{
//                        Image("soundchat-tv_logo")
////                        ListItem(url: (item
////                            .timelinemedia
////                            .first!
////                            .mediaType
////                            .contains("video"))
////                                 ? baseurlTimelineThumbnailImage +
////                                 item
////                            .timelinemedia
////                            .first!
////                            .mediaThumbnail
////                                 : baseurlTimelineImage +
////                                 item
////                            .timelinemedia
////                            .first!
////                            .mediaName, title: "LATEST STORIES", imageSize: imageSize)
//
//
//                    }
//                }
//            }            .padding(.horizontal)
        }
        .onReceive(timer) { _ in
            currentTimeline = stories.randomElement()
        }
        .frame(maxHeight: .infinity)
        .onAppear(){
            AF.request("\(baseUrl)listtimeline", method: .post, parameters: ["":""], encoder: JSONParameterEncoder.default)
                .responseDecodable(of: TimelineResponse.self) { response in
                    if(response.error == nil){
                        stories = response.value!.data.rows
                        print(stories.count)
                        currentTimeline = stories.first
//                        raandomIndexForAds = Int.random(in: 0...ads.count-1)
                    }else{
                        print(response.error!.localizedDescription)
                    }

                }
        }
    }
}

