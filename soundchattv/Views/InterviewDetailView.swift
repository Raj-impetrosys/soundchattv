//
//  InterviewDetailView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 24/05/23.
//

import SwiftUI

struct InterviewDetailView: View {
    @State private var isFocused: Bool = false
    let interviews: [Event]
//    let event: Event
//    @State private var interviews: Interviews?
    @State private var currentInterview: Event?
    @State private var navigate: Bool = false
//    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    init(interviews: [Event], event: Event?){
        currentInterview = event
        self.interviews = interviews
    }
    
    var body: some View {
        ZStack{
            NetworkImage(urlString:baseurlimageinetrviews + (currentInterview?.tvposter ?? currentInterview?.featureImg ?? ""))
                .frame(width: width, height: height * 0.8).overlay {
                LinearGradient(colors: [.black,.black.opacity(0.5), .black.opacity(0)], startPoint: .leading, endPoint: .trailing)
            }
    VStack(alignment: .leading){
        Image("soundchat-tv-logo").resizable().scaledToFit().frame(width: 150, height: 150)
        Text("TRENDING").font(.title2)
        
        NavigationLink(isActive: $navigate){
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
        
        ScrollView(.horizontal){
            HStack{
                ForEach(interviews, id: \.id){event in
                    PosterView(
                        isFromDetailScreen: true,
                        currentInterview: $currentInterview,
                        event: event, interviews: interviews)
//                        .focusable(true, onFocusChange: { newState in
//                            isFocused = newState
//                        if(isFocused){
//                            currentInterview = event
//                        }
//                    })
//                        .scaleEffect(isFocused ? 1.2 : 1)
//                                    .animation(.easeInOut, value: isFocused)
//                                    .overlay {
//                                        if(isFocused){RoundedRectangle(cornerRadius: 20).opacity(0.2)}
//                                    }
                    
//                        .onTapGesture {
//                            navigate.toggle()
//                            print("tapped")
//                        }

                }
            }
        }
    }.frame(width: width * 0.9, alignment: .leading)
        }
//        .onReceive(timer) { _ in
//            currentInterview = interviews.randomElement()
//        }
    }
}

//struct InterviewDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterviewDetailView()
//    }
//}
