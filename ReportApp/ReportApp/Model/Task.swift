//
//  Task.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import Foundation
@objc(Task)
class Task :NSObject{
    @objc var id: String = ""
    @objc var title: String = ""
    @objc var status: Int = 0
    @objc var detail: String = ""
    @objc var note: String = ""
    @objc var isEdit: Bool = false
    
    init(title: String, status: Int, detail: String, note: String){
        self.title = title
        self.status = status
        self.detail = detail
        self.note = note
    }
    
    init(isEdit: Bool){
        self.isEdit = isEdit
    }
    

    override init(){
    }
    
    func editTask(){
        isEdit = true
    }
}
