//
//  DetailReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import UIKit

class DetailReportCell: UICollectionViewCell {
    
    private var tasks : [Task]  = []
    
    private let userText: UITextView = UITextView()
    
    private var userBox: UIView = UIView()
    
    private var heightUserBox : Int = 0
    
    private var titles : [UITextView] = []
    
    private var taskCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initConstraint()
    }
    
    func initView(){
        contentView.backgroundColor = .clear
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: contentView.frame.width - 3, height: contentView.frame.height), cornerRadius: 20).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 1
        
        contentView.layer.addSublayer(shadowLayer)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.zingPurple.cgColor
        contentView.layer.cornerRadius = 20
        
        userBox.frame = CGRect(x: 0, y: 0, width: 140, height: 40)
        userBox.center.x = contentView.center.x
        userBox.backgroundColor = .zingPurple
        userBox.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 15)
        
        userText.frame = CGRect(x: 0,y: 0,width: Int(userBox.frame.size.width),height: Int(userBox.frame.size.height))
        userText.font = .latoBold(size: 24)
        userText.isEditable = false
        userText.isScrollEnabled = false
        userText.textColor = .white
        userText.textAlignment = .center
        userText.backgroundColor = .clear
        userBox.addSubview(userText)
        contentView.addSubview(userBox)
        
        taskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        taskCollectionView.backgroundColor = .clear
        contentView.addSubview(taskCollectionView)
        taskCollectionView.delegate = self
        taskCollectionView.dataSource = self
        taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: "task")
    }
    
    func initConstraint(){
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        taskCollectionView.topAnchor.constraint(equalTo: userBox.bottomAnchor).isActive = true
        taskCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        taskCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        taskCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
    }
    
    
    func configure(tasks : [Task],userName : String){
        userText.text = userName
        self.tasks = tasks
        taskCollectionView.reloadData()
        
    }
    
    func hidden(){
        contentView.isHidden = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Error Creating DetailCell")
    }
}


extension DetailReportCell : UICollectionViewDelegate{
    
}

extension DetailReportCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let taskCell = collectionView.dequeueReusableCell(withReuseIdentifier: "task", for: indexPath) as? TaskCell{
            
            taskCell.config(task: tasks[indexPath.row])
            
            cell = taskCell
        }
        
        return cell
    }
    
    
}

extension DetailReportCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: collectionView.frame.size.width, height: 195)
    }
}


