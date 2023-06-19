//
//  DateFormatter.swift
//  soundchattv
//
//  Created by RAJKUMAR on 14/06/23.
//

import Foundation

func formatDate(date: String, format: String)->String{
    let dateFormatter = DateFormatter()
//    2023-06-12T11:15:04.000Z
//    print(date)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
    let formattedDate = dateFormatter.date(from: date)
//    return formattedDate!.formatted()
//    return formattedDate!.formatted(date: Foundation.Date.FormatStyle.DateStyle.long, time: Foundation.Date.FormatStyle.TimeStyle.shortened)
    
    let outDateFormatter = DateFormatter()
    if(Calendar.current.isDateInToday(formattedDate!) || Calendar.current.isDateInYesterday(formattedDate!)){
        outDateFormatter.timeStyle = .short
    }else{
        outDateFormatter.timeStyle = .none
    }
    
    outDateFormatter.dateStyle = .full
//    outDateFormatter.locale = Locale(identifier: "en_GB")
    outDateFormatter.doesRelativeDateFormatting = true

//    if(Calendar.current.isDateInToday(formattedDate!)){
////        outDateFormatter.dateFormat = "Today @ HH:mm a"
//        outDateFormatter.timeStyle = .short
//        outDateFormatter.dateStyle = .none
//    }else if(Calendar.current.isDateInYesterday(formattedDate!)){
////        outDateFormatter.dateFormat = "Yesterday @ HH:mm a"
//        outDateFormatter.timeStyle = .short
//        outDateFormatter.dateStyle = .none
//    }else{
//        outDateFormatter.dateFormat = "EEE, MMM dd, yyyy"
//    }
    
    return outDateFormatter.string(from: formattedDate!)
//    let formatter = RelativeDateTimeFormatter()
//    return formatter.localizedString(for: formattedDate!, relativeTo: Date())
}
