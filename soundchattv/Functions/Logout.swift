//
//  Logout.swift
//  soundchattv
//
//  Created by RAJKUMAR on 08/06/23.
//

import Foundation

func logout(globals: GlobalString){
    resetDefaults(globals: globals)
}

func resetDefaults(globals: GlobalString) {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
    defaults.synchronize()
    globals.isLogin = false
}
