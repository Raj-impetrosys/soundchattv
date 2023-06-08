//
//  UserDefault.swift
//  soundchattv
//
//  Created by RAJKUMAR on 06/06/23.
//

import Foundation

func saveUserData(loginResponse: LoginResponse){
    UserDefaults.standard.set(true, forKey: "isLogin")
    UserDefaults.standard.set(loginResponse.id, forKey: "userId")
    UserDefaults.standard.set(loginResponse.username, forKey: "username")
    UserDefaults.standard.set(loginResponse.email, forKey: "email")
    UserDefaults.standard.set(loginResponse.mobileno, forKey: "mobileno")
    UserDefaults.standard.set(loginResponse.accessToken, forKey: "accessToken")
    UserDefaults.standard.set(loginResponse.fname, forKey: "fname")
    UserDefaults.standard.set(loginResponse.lname, forKey: "lname")
    UserDefaults.standard.set(loginResponse.country, forKey: "country")
    UserDefaults.standard.set(loginResponse.profilepic, forKey: "profilepic")
}

func getIsLogin()->Bool{
    print(UserDefaults.standard.bool(forKey: "isLogin"))
    return UserDefaults.standard.bool(forKey: "isLogin")
}

func getUserId()->Int{
    return UserDefaults.standard.integer(forKey: "userId")
}

func getUserName()->String?{
    return UserDefaults.standard.string(forKey: "username")
}

func getEmail()->String?{
    return UserDefaults.standard.string(forKey: "email")
}

func getMobileNo()->String?{
    return UserDefaults.standard.string(forKey: "mobileno")
}

func getAccessToken()->String?{
    return UserDefaults.standard.string(forKey: "accessToken")
}

func getFname()->String?{
    return UserDefaults.standard.string(forKey: "fname")
}

func getLname()->String?{
    return UserDefaults.standard.string(forKey: "lname")
}

func getCountry()->String?{
    return UserDefaults.standard.string(forKey: "country")
}

func getProfilePic()->String?{
    return UserDefaults.standard.string(forKey: "profilepic")
}
