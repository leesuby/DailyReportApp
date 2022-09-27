//
//  EditReportViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import UIKit

class EditReportViewController: UIViewController {

    private let editReportView : EditReport = EditReport()
    var editReportCollectionView : UICollectionView!
    private var tasks : [Task] = []
    var dateOfReport: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        editReportView.delegate = self
        
        editReportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        editReportView.initialFisrtLook(viewController: self)
        
        editReportCollectionView.delegate = self
        editReportCollectionView.dataSource = self
        
        editReportCollectionView.register(UserReportCell.self, forCellWithReuseIdentifier: "userReport")
        
        editReportCollectionView.register(AddReportCell.self, forCellWithReuseIdentifier: "editReport")
        // Do any additional setup after loading the view.
        
        Remote.remoteFirebase.readTaskOfUser(date: dateOfReport) { loadedTask in
            DispatchQueue.main.async {
                self.tasks = loadedTask as! [Task]
                self.editReportCollectionView.reloadData()
            }
            
        }

    }

    
    private func setupNavBar(){
        navigationItem.title = "Your Task"
        self.navigationController!.navigationBar.tintColor = UIColor.white
        
    }
    
    
    @objc func saveTask(){
        print("task saved")
    }
}


extension EditReportViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let task = tasks[indexPath.row]
        
        if (task.isEdit == true){
            return CGSize(width: collectionView.frame.size.width, height:  500)
        }
        else{
            return CGSize(width: collectionView.frame.size.width, height:  260)
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

        
        let task = tasks[indexPath.item]
        
        if (task.isEdit == true){
            if let editCell = collectionView.dequeueReusableCell(withReuseIdentifier: "editReport", for: indexPath) as? AddReportCell{
                
                editCell.config(title: String(indexPath.item))
                editCell.delegate = self
                cell = editCell
            }
        }
        else{
            
            if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "userReport", for: indexPath) as? UserReportCell{
                
                detailCell.configureOneTask(task: task)
                cell = detailCell
            }
        }
        
        return cell
    }
    
    
}

extension EditReportViewController : EditReportDelegate{
    func addTask() {
        
        tasks.append(Task(isEdit: true))
        
        editReportCollectionView.reloadData()
        
    }
    
}

extension EditReportViewController : AddReportCellDelegate{
    func cancelReport(task: String) {
        let oneTask = tasks[Int(task)!]
        if(oneTask.detail != ""){
            oneTask.isEdit = false
        }
        else{
            tasks.remove(at: Int(task)!)
        }
        
        self.editReportCollectionView.reloadData()
    }
    
    func saveReport(task: Task) {
        Remote.remoteFirebase.saveTaskOfUser(task: task, date: self.dateOfReport)
        tasks.removeAll()
    
    }
    
    
}



