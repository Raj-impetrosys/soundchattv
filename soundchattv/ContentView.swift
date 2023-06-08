//
//  ContentView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 01/05/23.
//

import SwiftUI
import CoreData
import Alamofire

enum TabType{
    case live, interviews, recaptv, stories, setting
}

struct ContentView: View {
    @ObservedObject private var globals: GlobalString=GlobalString()
    @State private var selectedTab = TabType.live
//    @State private var isFocussed: FocusState<Bool>
    @FocusState private var isFocussed: Bool
    
    init(){
        globals.isLogin = getIsLogin()
    }

    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top){
                if(selectedTab == TabType.live){
                    LiveView()
                } else if(selectedTab == TabType.interviews){
                    InterviewsView()
                }else if(selectedTab == TabType.recaptv){
                    RecapTVView()
                }else if(selectedTab == TabType.stories){
                    TimelineStoryView()
                }else if(selectedTab == TabType.setting){
                    SettingView()
                }
               
                HStack{
                    Tab(selectedTab: $selectedTab, tabType: .live, title: "LIVE")
                    Tab(selectedTab: $selectedTab, tabType: .interviews, title: "INTERVIEWS")
                    Tab(selectedTab: $selectedTab, tabType: .recaptv, title: "RECAP TV")
                    Tab(selectedTab: $selectedTab, tabType: .stories, title: "STORIES")
                    Tab(selectedTab: $selectedTab, tabType: .setting, title: "SETTING")
                }
                .focused($isFocussed)
                .padding(50).frame(width: width * 0.8, height: 70).background(LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom))
                
            }
        }.environmentObject(globals)
    }
}

struct Tab: View{
    @Binding var selectedTab: TabType
    let tabType: TabType
    let title: String
    var body: some View{
        Button {
            print(tabType)
            selectedTab = tabType
        }label: {
            VStack{
                if(tabType == .setting) { Image(systemName: "gearshape")} else{ Text(title)}
//            if(selectedTab==tabType){
                Rectangle().fill(selectedTab==tabType ? .yellow: .yellow.opacity(0)).frame(width: 150, height: 2)
//            }
            }
        }.buttonStyle(.plain)
//                        .focused($isFocussed)
            .focusable(true, onFocusChange: { isFocused in
                print(tabType)
                selectedTab = tabType
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
