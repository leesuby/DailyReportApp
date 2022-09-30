//
//  Helper.swift
//  ReportApp
//
//  Created by LAP15335 on 30/09/2022.
//

import Foundation

class Helper{
    static func getDate(dateString : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
     
        return dateFormatter.date(from: dateString)
    }
}
