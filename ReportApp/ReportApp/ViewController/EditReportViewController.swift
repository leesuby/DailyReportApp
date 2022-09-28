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
                
                editCell.config(title: String(indexPath.item), task: task)
                
                editCell.delegate = self
                cell = editCell
            }
        }
        else{
            
            if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "userReport", for: indexPath) as? UserReportCell{
                
                detailCell.configureOneTask(task: task,text: String(indexPath.item))
                detailCell.delegate = self
                cell = detailCell
            }
        }
        
        return cell
    }
    
    
}

extension EditReportViewController : EditReportDelegate{
    func addTask() {
        let tmp = Task(isEdit: true)
        tmp.id = "-1"
        tasks.append(tmp)
        
        editReportCollectionView.reloadData()
        
    }
    
}

extension EditReportViewController : AddReportCellDelegate{
    func cancelReport(task: Task) {
        for (index, element) in tasks.enumerated(){
            if(element.id == task.id){
                if(element.id == "-1"){
                    tasks.remove(at: index)
                }
                else{
                    element.isEdit = false
                }
            }
        }
        self.editReportCollectionView.reloadData()
    }
    
    func saveReport(task: Task) {
        if(task.id == "-1"){
            task.id = "\(Int(Date().timeIntervalSince1970 * 1000000))"
        }
        for t in tasks{
            if(t.id == task.id){
                t.isEdit = false
                editReportCollectionView.reloadData()
            }
        }
        print(task.id)
        Remote.remoteFirebase.saveTaskOfUser(task: task, date: self.dateOfReport)
    
    }
    
    
}

extension EditReportViewController : UserReportCellDelegate{
    func deleteReport(task: Task) {
        Remote.remoteFirebase.deleteTaskOfUser(task: task, date: self.dateOfReport)
        tasks.removeAll()
    }
    
    func editReport(task: Task) {
        for t in tasks{
            if(t.id == task.id){
                t.isEdit = true
                editReportCollectionView.reloadData()
            }
        }
    }
}

