//
//  Helper.swift
//  ReportApp
//
//  Created by LAP15335 on 30/09/2022.
//

import Foundation
import UIKit

class Helper{
    static func getDate(dateString : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: dateString)
    }
    
    static func createAlertOneOption(viewController: UIViewController,title: String, messages: String, completion: ((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: title, message: messages, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: completion))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func createAlertTwoOption(viewController: UIViewController,title: String, messages: String, yes: ((UIAlertAction) -> Void)? = nil, no: ((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: title, message: messages, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: yes))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: no))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getStatusColor(status: Int) -> UIColor{
        switch status{
        case 75...100:
            return .darkGreen
        case 35..<75:
            return .darkYellow
        default:
            return .darkRed
            
        }
    }
}

