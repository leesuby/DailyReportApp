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
    
    private var database: DatabaseFirebase
    
    init(){
        database = DatabaseFirebase()
    }
    
    func saveData(){
        database.saveReport()
    }
    
    func readAllReport(list : NSMutableArray, collectionView : UICollectionView){
        database.readAllReport(list , collectionView: collectionView)
    }
    
    func readDetailReport(list : NSMutableArray, collectionView: UICollectionView, date : String){
        database.readDetailReport(list, collectionView: collectionView, dateofReport: date)
    }
    
    func readTaskOfUser(list : NSMutableArray, collectionView: UICollectionView, date : String){
        database.readTaskUser(list, collectionView: collectionView, dateofReport: date)
    }
    
}
