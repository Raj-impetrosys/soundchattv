//
//  GetDetroitTime.swift
//  soundchattv
//
//  Created by RAJKUMAR on 17/05/23.
//

import Foundation

func getDetroitTime()->String{
    let detroit = TimeZone(identifier: "America/Detroit")
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.locale = Locale.current
    formatter.timeZone = detroit
    let dateString = formatter.string(from: Date())
//    let date = formatter.date(from: Date().description.split(separator: "+").first!.description)
//    print(dateString)
//    print(date)
    let date = formatter.date(from: Date().description)
    print(Date().description)
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
////    dateFormatter.locale = Locale.current
////    dateFormatter.timeZone = TimeZone.current
//    print(TimeZone.current)
//    let date = dateFormatter.date(from: dateString)
    print(date)
    return dateString
//    return formatter.date(from: Date().description.split(separator: " +").first!.description)!
//    return Date().convert(from: TimeZone.current, to: detroit!)
}

extension Date {
    func convert(from timeZone: TimeZone, to destinationTimeZone: TimeZone) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents(in: timeZone, from: self)
        components.timeZone = destinationTimeZone
        return calendar.date(from: components)!
    }
}

//extension Date {
//    func convert(from initTimeZone: TimeZone, to targetTimeZone: TimeZone) -> Date {
//        let delta = TimeInterval(initTimeZone.secondsFromGMT() - targetTimeZone.secondsFromGMT())
//        return addingTimeInterval(delta)
//    }
//}
