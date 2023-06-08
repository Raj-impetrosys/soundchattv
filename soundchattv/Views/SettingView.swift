//
//  SettingView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 06/06/23.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var globals: GlobalString
    
    init(){
//        globals.isLogin = getIsLogin()
//        print(isLogin)
    }
    
    var body: some View {
        if(globals.isLogin) {ProfileView()}else {LoginView()}
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
