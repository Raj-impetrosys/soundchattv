//
//  PosterView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 08/06/23.
//

import SwiftUI

struct PosterView : View{
    @State private var isFocused = false
    @State private var isActive = false
    let isFromDetailScreen: Bool
    @Binding var currentInterview: Event?
    let event: Event
    let interviews: [Event]
    var body: some View{
        ZStack{
        NavigationLink(
            isActive: $isActive,
            destination: {
                if(isFromDetailScreen){
                    if(currentInterview != nil){
                        VideoPlayerView(url: currentInterview!.videoURL)
                    }
                }else{
                    InterviewDetailView(interviews: interviews, event: event)
                }
        },label: {
            NetworkImage(urlString:baseurlimageinetrviews + event.featureImg).frame(width: 250, height: 250).overlay {
                LinearGradient(colors: [.black, .black.opacity(0)], startPoint: .bottom, endPoint: .top)
            }.cornerRadius(20)
        }).cornerRadius(20).buttonStyle(.plain)
            Text(event.postTitle).lineLimit(2)
//                                .background(Color.black.opacity(0.5))
                .multilineTextAlignment(.center).frame(width: 250, height: 250, alignment: .bottom)
        }
        .scaleEffect(isFocused ? 1.2 : 1)
                    .focusable(true, onFocusChange: { newState in
                        isFocused = newState
                        if(isFocused){
                            currentInterview = event
                        }
                    })
                    .animation(.easeInOut, value: isFocused)
                    .overlay {
                        if(isFocused){RoundedRectangle(cornerRadius: 20).opacity(0.2)}
                    }
                    .onTapGesture {
                        isActive.toggle()
                    }
    }
}
