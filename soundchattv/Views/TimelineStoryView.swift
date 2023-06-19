//
//  TimelineStoryView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 31/05/23.
//

import SwiftUI
import Alamofire

struct TimelineStoryView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineStoryView()
    }
}

struct TimelineStoryView: View {
    @State private var stories: [Timeline] = []
    @State private var currentTimeline: Timeline?
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var raandomIndex = 0
    let imageSize: CGFloat = 350
    let columns = [
        GridItem(.fixed(width/4-50)),
        GridItem(.fixed(width/4-50)),
        GridItem(.fixed(width/4-50)),
        GridItem(.fixed(width/4-50)),
    ]

    var body: some View {
        ScrollView {
            TimelineSlider(stories: stories).frame(width: width, height: height * 0.8)
            Text("RECENT STORIES").frame(minWidth: width, minHeight: 80, alignment: .leading).background(LinearGradient(colors: [.black, .gray], startPoint: UnitPoint.leading, endPoint: SwiftUI.UnitPoint.trailing))
            ScrollView(.horizontal){
                HStack{
                    ForEach(stories.prefix(10), id: \.id) { story in
                        StoryListItem(story: story)
                    }
                }
            }.padding(.horizontal, 90)
            Text("MORE STORIES").frame(minWidth: width, minHeight: 80, alignment: .leading).background(LinearGradient(colors: [.black, .gray], startPoint: UnitPoint.leading, endPoint: SwiftUI.UnitPoint.trailing))
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(stories.dropFirst(10), id: \.id) { story in
                    if(stories.isEmpty){
                        ProgressView()
                    } else{
                        StoryListItem(story: story)
                    }
                }
            }            .padding(.horizontal)
        }
//        .ignoresSafeArea()
        .onReceive(timer) { _ in
            currentTimeline = stories.randomElement()
        }
        .frame(maxHeight: .infinity)
        .onAppear(){
            AF.request("\(baseUrl)listtimeline", method: .post, parameters: ["limit":"50", "page": "1"], encoder: JSONParameterEncoder.default)
                .response{respose in
                    print(respose)
                    
                }
                .responseDecodable(of: TimelineResponse.self) { response in
                    if(response.error == nil){
                        stories = response.value!.data.rows
                        print(stories.count)
                        currentTimeline = stories.first
                    }else{
                        print(response.error!.localizedDescription)
                        print(response.description)
                    }

                }
        }
    }
}

struct StoryListItem: View{
    @State private var isFocused = false
    @State private var isActive = false
    let size: Double = width * 0.2
    let story: Timeline
    var body: some View{
//        NavigationLink(isActive: $isActive ,destination: {
//            NavigationDetailView()
//        },label:{
            ZStack{
                NetworkImage(urlString: (story
                    .timelinemedia
                    .first!
                    .mediaType
                    .contains("video"))
                             ? baseurlTimelineThumbnailImage +
                             story
                    .timelinemedia
                    .first!
                    .mediaThumbnail!
                             : baseurlTimelineImage +
                             story
                    .timelinemedia
                    .first!
                    .mediaName).scaleEffect(isFocused ? 1.2 : 1)
                VStack{
                    Text(story.postDesc).lineLimit(2)
                    NavigationLink(isActive: $isActive ,destination: {
                        TimelineDetailView(story: story)
                    },label:{
                        Text("View Story").foregroundColor(.red).bold()
                    })
                    
                }.multilineTextAlignment(.center).frame(minWidth: size).background(Color.black.opacity(0.5)).frame(width: size, height: size, alignment: .bottom)
                Text(formatDate(date: story.createdAt, format: "")).padding().background(Color.black.opacity(0.5)).frame(width: size, height: size, alignment: .topTrailing)
                    .cornerRadius(50, corners: .bottomLeft)
                if(story.timelinemedia.first!.mediaType.contains("video")){
                    Image(systemName: "play.circle").scaleEffect(2)
                }
            }
            .frame(width: size, height: size)
                
                            .focusable(true, onFocusChange: { newState in
                                isFocused = newState
                            })
                            .animation(.easeInOut, value: isFocused)
                            .overlay {
                                if(isFocused){RoundedRectangle(cornerRadius: 50).opacity(0.2)}
                            }.cornerRadius(50)
            
//        })
        .buttonStyle(.plain)
                        .onTapGesture {
                            isActive.toggle()
                        }
    }
}

struct TimelineSlider: View{
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let stories: [Timeline]
    @State private var isFocused = false
    @State private var isActive = false
    @State private var selection = 0
    var body: some View{
        TabView(selection: $selection) {
//            ForEach(stories, id: \.id) { story in
            if(!stories.isEmpty){
                ZStack{
                NetworkImage(urlString: (stories[selection]
                    .timelinemedia
                    .first!
                    .mediaType
                    .contains("video"))
                             ? baseurlTimelineThumbnailImage +
                             stories[selection]
                    .timelinemedia
                    .first!
                    .mediaThumbnail!
                             : baseurlTimelineImage +
                             stories[selection]
                    .timelinemedia
                    .first!
                    .mediaName).scaleEffect(isFocused ? 1.2 : 1)
                    VStack{
                        Text(stories[selection].postDesc).lineLimit(2)
                        NavigationLink(isActive: $isActive ,destination: {
                            TimelineDetailView(story: stories[selection])
                        },label:{
                            Text("View Story").foregroundColor(.red).bold()
                        })
                        
                    }.multilineTextAlignment(.center).frame(minWidth: width).background(Color.black.opacity(0.5)).frame(width: width, height: height * 0.8, alignment: .bottom)
                    Text(formatDate(date: stories[selection].createdAt, format: "")).padding().background(Color.black.opacity(0.5)).frame(width: width, height: height * 0.8, alignment: .topTrailing)
                    if(stories[selection].timelinemedia.first!.mediaType.contains("video")){
                        Image(systemName: "play.circle").scaleEffect(4)
                    }
                }
                .frame(width: width, height: height * 0.8)
                .cornerRadius(20)
                
                            .focusable(true, onFocusChange: { newState in
                                isFocused = newState
                            })
                            .animation(.easeInOut, value: isFocused)
                            .overlay {
                                if(isFocused){RoundedRectangle(cornerRadius: 50).opacity(0.2)}
                            }
                            .cornerRadius(50)
        .buttonStyle(.plain)
                        .onTapGesture {
                            isActive.toggle()
                        }
                
            }
//            }
        }.tabViewStyle(PageTabViewStyle()).indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)).onReceive(timer) { _ in
            withAnimation {
                selection = (selection < stories.count - 1) ? selection + 1 : 0
                print(selection)
            }
            
        }
    }
}

