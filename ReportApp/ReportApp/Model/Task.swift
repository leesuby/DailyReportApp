//
//  Task.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import Foundation
class Task{
    var title: String = ""
    var status: Int = 0
    var detail: String = ""
    var note: String = ""
    var isEdit: Bool = false
    
    init(title: String, status: Int, detail: String, note: String){
        self.title = title
        self.status = status
        self.detail = detail
        self.note = note
    }
    
    init(isEdit: Bool){
        self.isEdit = isEdit
    }
    
    func editTask(){
        isEdit = true
    }
}
