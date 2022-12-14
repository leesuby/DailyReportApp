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
    
    func readRecentTask(completion: @escaping ([Any]) -> Void){
        database.readRecentTasks(completion)
    }
    
    func readARecentTask(id: String,completion: @escaping (Task) -> Void){
        database.readARecentTask(id, completion: completion)
    }
    
    func updateRecentTask(tasks: [Task]){
        database.updateRecentTask(tasks)
    }
    
    func saveTaskOfUser(task: Task,date: String){
        database.saveTaskUser(task, dateofReport: date)
    }
    
    func editTaskOfUser(task: Task,date: String){
        database.editTaskUser(task, dateofReport: date)
    }
    
    func deleteTaskOfUser(task: Task,date: String){
        database.deleteTaskUser(task, dateofReport: date)
    }
    
    func createReport(date: String){
        database.createReport(date)
    }
    
    func updateStatusReport(status: String , date: String){
        database.updateStatusReport(status, date: date)
    }
    
    func createUser(user: User, name: String){
        database.createUser(user, name: name)
    }
    
    func checkUser(user: User, name: String, completion: @escaping (Int) -> Void){
        database.check(user, name: name, completionBlock: completion)
    }
    
}
