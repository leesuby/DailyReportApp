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
    private var tasks : [Task]  = [Task(title: "Bug", status: 80, detail: "trace bug màn hình khi không có kết nối", note: "Đã tìm ra nguyên nhân, đang khắc phục"),Task(title: "Bug", status: 80, detail: "trace bug màn hình khi không có kết nối", note: "Đã tìm ra nguyên nhân, đang khắc phục")]
    
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
    }

    
    private func setupNavBar(){
        navigationItem.title = "Your Task"
        self.navigationController!.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
        
    }
    
    
    @objc func saveTask(){
        print("task saved")
    }
}


extension EditReportViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (tasks[indexPath.row].isEdit == true){
            return CGSize(width: collectionView.frame.size.width, height:  500)
        }
        else{
            return CGSize(width: collectionView.frame.size.width, height:  200)
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
        
        if (tasks[indexPath.row].isEdit == true){
            if let editCell = collectionView.dequeueReusableCell(withReuseIdentifier: "editReport", for: indexPath) as? AddReportCell{
                
                cell = editCell
            }
        }
        else{
            
            if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailReport", for: indexPath) as? DetailReportCell{
                
                detailCell.configure(tasks: [self.tasks[indexPath.row]])
                cell = detailCell
            }
        }
        
        return cell
    }
    
    
}

extension EditReportViewController : EditReportDelegate{
    func addTask() {
        tasks.append(Task(isEdit: true))
        EditReportCollectionView.reloadData()
    }
    
    
}


