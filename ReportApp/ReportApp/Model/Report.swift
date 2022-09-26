//
//  Report.swift
//  ReportApp
//
//  Created by LAP15335 on 26/09/2022.
//

import Foundation
class Report{
    var tasks : [Task]
    var userName: String
    var date : String
    
    init(tasks: [Task], user: String , date: String){
        self.tasks = tasks
        self.userName = user
        self.date = date
    }
}
