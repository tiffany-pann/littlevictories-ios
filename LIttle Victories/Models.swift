//
//  Models.swift
//  LIttle Victories
//
//  Created by Tiffany Pan on 6/17/22.
//

import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

struct Victory: Codable {
    let id: Int
    let date: Int
    let description: String
    let image: String
}

struct VictoryResponse: Codable {
    let victories: [Victory]
}

// convert UNIX time into a presentable string
func convertUnixToString(date: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(date))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "MMM \n dd" //Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    
    return strDate
}

func convertStringtoUnix(dateInput: String) -> Int {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd yyyy                h:mm a"
    let dateString = dateFormatter.date(from: dateInput)
    let dateTimeStamp  = dateString!.timeIntervalSince1970
    let dateSt:Int = Int(dateTimeStamp)
    
    return dateSt
}
