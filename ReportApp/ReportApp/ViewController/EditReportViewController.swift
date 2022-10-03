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
    
    let templateBox = TemplateModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        editReportView.delegate = self
        
        editReportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        self.hideKeyboardWhenTappedAround()
        
        editReportView.initialFisrtLook(viewController: self)
        
        editReportCollectionView.showsVerticalScrollIndicator = false
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
            return CGSize(width: collectionView.frame.size.width, height:  525)
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
        cell.sizeToFit()
        return cell
    }
    
    
}

extension EditReportViewController : EditReportDelegate{
    func addTask() {
        for task in tasks{
            if(task.id == "-1"){
                let alert = UIAlertController(title: "Information", message: "There is a new task created at the bottom.Please save before create a new task!!!", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler: nil))
              
                self.present(alert, animated: true, completion: nil)
                
                return
            }
        }
        
        let tmp = Task(isEdit: true)
        tmp.id = "-1"
        tasks.append(tmp)
        
        editReportCollectionView.reloadData()
        
    }
    
}

extension EditReportViewController : AddReportCellDelegate{
    func getTemplate(taskId: String) {
        templateBox.showBox(title: "Saved Task", viewController: self)
    }
    
    @objc func dismiss(){
        templateBox.dismiss()
    }
    
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
    
        Remote.remoteFirebase.saveTaskOfUser(task: task, date: self.dateOfReport)
    
    }
    
    
}

extension EditReportViewController : UserReportCellDelegate{
    func deleteReport(task: Task) {
        // create the alert
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete this task?", preferredStyle: UIAlertController.Style.alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler: {_ in
            Remote.remoteFirebase.deleteTaskOfUser(task: task, date: self.dateOfReport)
            self.tasks.removeAll()
        }))
                        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
                        
      
        self.present(alert, animated: true, completion: nil)
      
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


