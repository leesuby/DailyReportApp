//
//  User.swift
//  ReportApp
//
//  Created by LAP15335 on 10/10/2022.
//

import Foundation

@objc(User)
class User :NSObject{
    @objc var email: String = ""
    @objc var password: String = ""
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
    override init(){
    }
    
}
