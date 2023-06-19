//
//  ProfileView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 06/06/23.
//

import SwiftUI
import Alamofire

struct ProfileView: View {
    @EnvironmentObject private var globals: GlobalString
//    @State private var isFocused = false
    @State private var isLogoutFocused = false
    @State private var isEditFocused = false
    @State private var showLogoutAlert = false
    @State private var showDeleteAlert = false
    @State private var message: String = ""
    @State private var showToast = false
    var body: some View {
        VStack{
            HStack{
                Image("soundchat-tv-logo").resizable().scaledToFit().frame(width: 150, height: 150)
                Spacer()
                Image(systemName: "power")
                    .scaleEffect(isLogoutFocused ? 1.5 : 1)
                    .focusable(true) { newState in isLogoutFocused = newState }
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(title: Text("Alert"), message: Text("Do you really want to logout?"),
                              primaryButton: .destructive(Text("Yes"), action: {
                            logout(globals: globals)
                        }), secondaryButton: .cancel(Text("No")))
                    }.onTapGesture {
                        showLogoutAlert.toggle()
                    }
            }
            NetworkImage(urlString:baseurlimage + (getProfilePic() ?? ""))
                .frame(width: 150, height: 150)
//                .foregroundColor(.white)
//                .padding(20)
                .background(Color.green)
                .clipShape(Circle())
            Text("\(getFname() ?? "") \(getLname() ?? "")").font(.title2).bold()
            Text("@\(getUserName() ?? "")")
            
            Spacer().frame(height: 100)
            
            HStack{
                Text("Account Details").font(.title2)
                Spacer()
                Image(systemName: "pencil").resizable().frame(width: 50, height: 50)
                    .scaleEffect(isEditFocused ? 1.5 : 1)
                    .focusable(true) { newState in isEditFocused = newState }
            }
            Rectangle().fill(.yellow).frame(width: width * 0.9, height: 2)
            
            Spacer().frame(height: 50)
            
            VStack(alignment: .leading){
                HStack{
                    Text("Email:")
                    Text(getEmail() ?? "")
                }
                HStack{
                    Text("Mobile:")
                    Text(getMobileNo() ?? "")
                }
                HStack{
                    Text("Country:")
                    Text(getCountry() ?? "")
                }
                HStack{
                    Text("Password:")
                    Text("Change Password")
                }
            }.frame(maxWidth: .infinity ,alignment: .leading)
            
            Button{
                showDeleteAlert.toggle()
            } label: {
                Text("Delete Account").foregroundColor(.red)
            }.buttonStyle(.plain).frame(maxWidth: .infinity ,alignment: .trailing)
                .alert(isPresented: $showDeleteAlert) {
                    Alert(title: Text("Alert"), message: Text("Do you really want to Delete this account?"),
                          primaryButton: .destructive(Text("Yes"), action: {
                        deleteAccount()
                    }), secondaryButton: .cancel(Text("No")))
                }
            
//            ScrollView(.horizontal) {
//                        LazyHStack {
//                            ForEach(0..<100) { index in
//                                Poster()
//                            }
//                        }
//                    }
        }
    }
    
    func deleteAccount(){
        AF.request("\(baseUrl)deleteuseraccount", method: .post, parameters: ["user_id": 4720], encoder: JSONParameterEncoder.json, headers: ["x-access-token":getAccessToken() ?? ""])
            .responseDecodable(of: DeleteAccountResponse.self) { response in
                if(response.error == nil){
                    print(response.value.debugDescription);
                    if(response.value?.status == 200){
//                        saveUserData(loginResponse: response.value!)
                        globals.isLogin = false
                    }else{
                        print(response.value!.message)
                        message = response.value!.message
                        showToast.toggle()
                    }
                    
//                    let toast = TVOSToast(frame: CGRect(x: 0, y: 0, width: 800, height: 140))
//                    toast.style.position = TVOSToastPosition.topRight(insets: 20)
//                    toast.text = "This is regular text"
//                    print(TVOSToast.presentOnView(toast))
////                    presentToast(toast)
//                    showToast.toggle()
                }else{
                    print(response.error!.localizedDescription)
                }
                
            }
    }
}

struct Poster: View {
    @State private var isFocused = false

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 100, height: 150)
            .scaleEffect(isFocused ? 1.2 : 1)
            .focusable(true) { newState in isFocused = newState }
            .animation(.easeInOut, value: isFocused)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
