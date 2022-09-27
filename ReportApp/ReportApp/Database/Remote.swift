//
//  Remote.swift
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

import Foundation
import UIKit

class Remote {
    static var remoteFirebase = Remote()
    
    var database: DatabaseFirebase
    
    init(){
        database = DatabaseFirebase()
    }
    
    func readAllReport(completion: @escaping ([Any]) -> Void){
        database.readAllReport(completion)
    }
    
    func readDetailReport(date : String, completion: @escaping ([Any]) -> Void){
        database.readDetailReport(withDate: date, completion: completion)
    }
    
    
    func readTaskOfUser(date : String, completion: @escaping ([Any]) -> Void){
        database.readTaskUser(withDate: date, completion: completion)
    }
    
    func saveTaskOfUser(task: Task,date: String){
        database.saveTaskUser(task, dateofReport: date)
    }
    
}
