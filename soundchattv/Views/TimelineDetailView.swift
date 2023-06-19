//
//  TimelineDetailView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 13/06/23.
//

import SwiftUI

struct TimelineDetailView: View {
    @State private var isFocused = false
//    @State private var comments: [Timelinecomment]
    let story: Timeline
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: (story
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
                .mediaName),
                       content: { image in
                           image
                               .resizable().frame(width: width * 0.5, height: height)
                               .scaledToFit()
                       }, placeholder: {
                           ProgressView()
                               .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                       }
            )
            .frame(width: width * 0.5, height: height)
            VStack(){
                Text(story.postDesc)
                HStack{
                    Spacer()
                    Button{}label: {
                        Image(systemName: "hand.thumbsup")
                        Text(story.timelinelikes.filter({ like in
                            like.likeIcon == "0"
                        }).count.description)
                    }
                    Button{}label: {
                        Image(systemName: "hand.thumbsdown")
                        Text(story.timelinelikes.filter({ like in
                            like.likeIcon == "1"
                        }).count.description)
                    }
                    Button{}label: {
                        Image(systemName: "ellipsis.message")
                        Text(story.timelinecomments.count.description)
                    }
                }.buttonStyle(.plain)
                Text("Comments")
                List{
                    ForEach(story.timelinecomments, id: \.id){comment in
                        CommentListItem(comment: comment)
                    }
                }
            }.frame(width: width * 0.4, height: height, alignment: .top)
        }.frame(width: width)
    }
}

struct CommentListItem: View{
    let comment: Timelinecomment
    @State private var isFocused = false
    @State private var isActive = false
    var body: some View{
        HStack{
            if(comment.user == nil) { Image("soundchat-tv-logo").frame(width: 100, height: 100).clipShape(Circle())}
            else{
                AsyncImage(url: URL(string:baseurlimage + comment.user!.profilepic),
                           content: { image in
                               image
                                   .resizable()
//                                                   .frame(width: width * 0.5, height: height)
//                                                   .scaledToFit()
                           }, placeholder: {
                               ProgressView()
                                   .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                           }).frame(width: 100, height: 100).clipShape(Circle())
            }
            VStack(alignment: .leading){
                HStack{
                    Text(comment.user == nil ? "SoundChat Radio Admin" : comment.user!.fname).bold()
                    Spacer()
                    Text(formatDate(date: comment.createdAt ,format:"")).font(.caption2).foregroundColor(.gray)
                }
                Text(comment.comments).font(.caption)
            }
        }.focusable(true, onFocusChange: { newState in
            isFocused = newState
        })
        .animation(.easeInOut, value: isFocused)
        .overlay {
            if(isFocused){RoundedRectangle(cornerRadius: 10).opacity(0.2)}
        }.cornerRadius(10)
.buttonStyle(.plain)
    .onTapGesture {
        isActive.toggle()
    }
    }
}
