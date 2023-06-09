//
//  LoginView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 02/06/23.
//

import SwiftUI
import Alamofire
import Introspect
//import TVOSToast

struct LoginView: View {
    @Namespace private var namespace
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isChecked: Bool = false
    @State private var showToast: Bool = false
    @State private var message: String = ""
//    @State private var isFocused: Bool = false
    @FocusState private var isFocused: Bool
    @FocusState private var isUserNameFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @EnvironmentObject private var globals: GlobalString
        
    var body: some View {
        VStack{
//            Spacer().frame(height: 200)
            Button{}label: {
                Text("Demo").frame(maxWidth: .infinity)
            }
            HStack(alignment: .top){
                
                VStack(spacing: 70){
                    Spacer().frame(height: 1)
                    HStack{
                        Image("soundchat-tv-logo").resizable().scaledToFit().frame(width: 150, height: 150)
                        Rectangle().fill(.white).frame(width: width * 0.05, height: 5)
                        Text("SIGN IN").font(.title).bold()
                        Rectangle().fill(.white).frame(width: width * 0.05, height: 5)
                    }
                    
                    HStack(spacing: 25){
                        Image(systemName: "person.circle.fill").resizable().frame(width: 100, height: 100).foregroundColor(.gray)
                        TextField("Username/Email", text: $username).focused($isUserNameFocused)
//                            .focusable(true) { isFocused in
//                            self.isFocused = false
//                        }
//                            .introspectTextField { textField in
//                                textField.becomeFirstResponder()
//                                print(textField.isFocused)
//                            }
                    }
                    .frame(width: width * 0.4)
                    .modifier(customViewModifier(roundedCornes: 100, startColor: .orange, endColor: .purple, textColor: .white))
//                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.black).overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.white, lineWidth: 5)
                    )
//                    .focusable(true).focused($isUserNameFocused)
                    
                    HStack(spacing: 25){
                        Image(systemName: "lock.circle.fill").resizable().frame(width: 100, height: 100).foregroundColor(.gray)
                        TextField("Password", text: $password).focused($isPasswordFocused)
                        Image(systemName: "eye").resizable().frame(width: 70, height: 40).foregroundColor(.gray)
                    }
                    .frame(width: width * 0.4)
                    .modifier(customViewModifier(roundedCornes: 100, startColor: .orange, endColor: .purple, textColor: .white))
//                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.black).overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.white, lineWidth: 5)
                    )
//                    .focusable(true)
                    
                    HStack{
                        Toggle(isOn: $isChecked) {
                                        Text("Remember Me")
                                    }
                                    .toggleStyle(CheckboxToggleStyle())
                        Spacer()
                    }.focusable(true).onTapGesture {
                        isChecked.toggle()
                    }
                    
                    Button{
                        login(userName: username, password: password, globals: globals)
                    }label: {
                        Text("LOGIN").font(.title2).bold()
                    }.buttonStyle(.bordered).cornerRadius(200)
                    VStack{
                        Rectangle().fill(.white).frame(width: width * 0.35, height: 5).padding()
                        
                        Text("To create account please use the App. Download App from Playstore and Appstore.").multilineTextAlignment(.center)
                    }
                }
                
                Rectangle().fill(.white).frame(width: 5, height: height * 0.8)
                
                VStack{
                    Spacer()
                    Image("qr_code").resizable().frame(width: width * 0.3, height: width * 0.3)
                    Spacer()
                    Text("To download the App scan QR Code through your phone camera.").multilineTextAlignment(.center)
                    Spacer().frame(height: 0)
                }
            }
        }.alert(isPresented: $showToast) {
            Alert(title: Text(message))
        }
//        .overlay {
//            ToastView(isPresented: $showToast, message: "Login Successfully")
//        }
//        .focused($isFocused)
//        .focusScope(namespace)
//            .focusable(true) { isFocused in
//                if(isFocused){
//                    self.isUserNameFocused.toggle()
//                    self.isFocused = false
//                }
//            }.onAppear(){
//                isFocused = true
//            }
    }
    
    func login(userName: String, password: String, globals: GlobalString){
        AF.request("\(baseUrl)signin", method: .post, parameters: ["mobileno": userName,"password": password], encoder: JSONParameterEncoder.json)
            .responseDecodable(of: LoginResponse.self) { response in
                if(response.error == nil){
                    print(response.value.debugDescription);
                    if(response.value?.status == 200){
                        saveUserData(loginResponse: response.value!)
                        globals.isLogin = true
                    }else{
                        print(response.value!.message!)
                        message = response.value!.message!
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

public struct CustomTFStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .accentColor(.black)
            .frame(width: .infinity, height: 70, alignment: .leading)
                .border(Color.yellow, width: 4)
             .font(.system(size: 30, weight: .heavy, design: .default))
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .shadow(radius: 12)
            .foregroundColor(.black)
            
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
//            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(0)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 25))

            .shadow(radius: 10)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
 
            configuration.label
 
        }
    }
}
