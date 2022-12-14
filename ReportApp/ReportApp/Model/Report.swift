//
//  Report.swift
//  ReportApp
//
//  Created by LAP15335 on 26/09/2022.
//

import Foundation

@objc(Report)
class Report: NSObject{
    @objc var tasks : [Task] = []
    @objc var date : String = ""
    @objc var userName: String = ""
    @objc var status: String = ""
    
    init(tasks: [Task], date: String){
        self.tasks = tasks
        self.date = date
    }

    @objc func setTask(tasks: [Task]){
        self.tasks = tasks
    }
    
    @objc func setUser(userName: String){
        self.userName = userName
    }
    
    override init(){
        
    }
}
