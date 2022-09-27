//
//  EditReportViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import UIKit

class EditReportViewController: UIViewController {

    private let EditReportView : EditReport = EditReport()
    var EditReportCollectionView : UICollectionView!
    private var tasks : NSMutableArray = []
    var dateOfReport: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        EditReportView.delegate = self
        
        EditReportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        EditReportView.initialFisrtLook(viewController: self)
        
        EditReportCollectionView.delegate = self
        EditReportCollectionView.dataSource = self
        
        EditReportCollectionView.register(DetailReportCell.self, forCellWithReuseIdentifier: "detailReport")
        
        EditReportCollectionView.register(AddReportCell.self, forCellWithReuseIdentifier: "editReport")
        // Do any additional setup after loading the view.
        
        Remote.remoteFirebase.readTaskOfUser(list: tasks, collectionView: EditReportCollectionView, date: dateOfReport)
    }

    
    private func setupNavBar(){
        navigationItem.title = "Your Task"
        self.navigationController!.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(saveTask))
        
    }
    
    
    @objc func saveTask(){
        print("task saved")
    }
}


extension EditReportViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let task = tasks[indexPath.row] as! Task
        if (task.isEdit == true){
            return CGSize(width: collectionView.frame.size.width, height:  500)
        }
        else{
            return CGSize(width: collectionView.frame.size.width, height:  230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}

extension EditReportViewController : UICollectionViewDelegate{
    
}

extension EditReportViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        let task = tasks[indexPath.row] as! Task
        
        if (task.isEdit == true){
            if let editCell = collectionView.dequeueReusableCell(withReuseIdentifier: "editReport", for: indexPath) as? AddReportCell{
                
                cell = editCell
            }
        }
        else{
            
            if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailReport", for: indexPath) as? DetailReportCell{
                
                detailCell.configure(tasks: [task], userName: UserSession.username)
                cell = detailCell
            }
        }
        
        return cell
    }
    
    
}

extension EditReportViewController : EditReportDelegate{
    func addTask() {
        
        tasks.add(Task(isEdit: true))
    
        EditReportCollectionView.reloadData()
    }
    
    
}


