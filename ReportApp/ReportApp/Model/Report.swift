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
    
    init(tasks: [Task], date: String){
        self.tasks = tasks
        self.date = date
    }
    
    @objc func initDate(date: String){
    
        self.date = date
    }
    
    override init(){
        
    }
}
