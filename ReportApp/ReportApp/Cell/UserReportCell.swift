//
//  UserReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

import UIKit

protocol UserReportCellDelegate{
    func editReport(task : Task)
    func deleteReport(task: Task)
}

class UserReportCell: UICollectionViewCell {
    
    private let taskText: UITextView = UITextView()
    
    private let title: UILabel = UILabel()
    
    private let status: UILabel = UILabel()
    
    private let detail : UILabel = UILabel()
    
    private let note : UILabel = UILabel()
    
    private let noteImage : UIImageView = UIImageView()
    
    private let taskBox : UIView = UIView()
    
    private var task : Task!
    private var heightUserBox : Float = 0
    
    var delegate: UserReportCellDelegate!
    
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
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 20
        
        taskBox.frame = CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int(contentView.frame.size.width) / 10)
        taskBox.backgroundColor = .zingPurple
        taskBox.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        taskText.frame = CGRect(x: taskBox.center.x - 10, y: 0,width: 30,height: 30)
        taskText.font = .latoBold(size: 20)
        taskText.isEditable = false
        taskText.isScrollEnabled = false
        taskText.textColor = .white
        taskText.textAlignment = .center
        taskText.backgroundColor = .clear
        taskBox.addSubview(taskText)
        contentView.addSubview(taskBox)
        
        let editButton: UIButton = UIButton(frame: CGRect(x: taskBox.frame.size.width - 30, y: 10,width: 20,height: 20))
        editButton.setImage(UIImage(named: "EditSymbol")?.withRenderingMode(.alwaysTemplate), for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = .clear
        editButton.addTarget(self, action: #selector(editReport), for: .touchUpInside)
        contentView.addSubview(editButton)
        
        let deleteButton : UIButton = UIButton(frame: CGRect(x: 10, y: 10, width: 20, height:20))
        deleteButton.setImage(UIImage(named: "DeleteSymbol_Red")?.withRenderingMode(.alwaysTemplate), for: .normal)
        deleteButton.backgroundColor = .clear
        deleteButton.tintColor = .white
        deleteButton.layer.cornerRadius = 10
        deleteButton.addTarget(self, action: #selector(deleteReport), for: .touchUpInside)
        contentView.addSubview(deleteButton)
        
        title.font = .latoBold(size: 20)
        title.textColor = Global.titleColor
        title.numberOfLines = 2
        title.textAlignment = .left
        contentView.addSubview(title)
        
        status.font = .latoRegular(size: 18)
        status.textAlignment = .right
        status.backgroundColor = .clear
        contentView.addSubview(status)
        
        detail.font = .latoRegular(size: 16)
        detail.textColor = Global.detailColor
        detail.textAlignment = .left
        detail.numberOfLines = 3
        detail.backgroundColor = .clear
        contentView.addSubview(detail)
        
        noteImage.image = UIImage(named: "NoteSymbol")
        noteImage.contentMode = .scaleAspectFit
        noteImage.backgroundColor = .clear
        contentView.addSubview(noteImage)
        
        note.font = .latoRegular(size: 16)
        note.textColor = Global.noteColor
        note.textAlignment = .left
        note.numberOfLines = 3
        note.backgroundColor = .clear
        contentView.addSubview(note)
        
    }
    
    func initConstraint(){
        status.translatesAutoresizingMaskIntoConstraints = false
        status.topAnchor.constraint(equalTo: taskBox.bottomAnchor, constant: Global.padding).isActive = true
        status.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Global.padding).isActive = true
        status.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: taskBox.bottomAnchor, constant: Global.padding).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Global.padding).isActive = true
        title.trailingAnchor.constraint(equalTo: status.leadingAnchor).isActive = true
        
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.topAnchor.constraint(equalTo: title.bottomAnchor,constant: Global.padding).isActive = true
        detail.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        detail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Global.padding).isActive = true
        
        noteImage.translatesAutoresizingMaskIntoConstraints = false
        noteImage.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: Global.padding).isActive = true
        noteImage.leadingAnchor.constraint(equalTo: detail.leadingAnchor).isActive = true
        noteImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        noteImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        note.translatesAutoresizingMaskIntoConstraints = false
        note.leadingAnchor.constraint(equalTo: noteImage.trailingAnchor).isActive = true
        note.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Global.padding).isActive = true
        note.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: Global.padding + 5).isActive = true
    }
    
    func configureOneTask(task : Task,text: String){
        self.task = task
    
        title.text = task.title
        
        taskText.text = text
        
        status.text = "\(String(task.status))%"
        status.textColor = Helper.getStatusColor(status: task.status)
        
        detail.text = task.detail
        
        note.text = task.note
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("Error Creating DetailCell")
    }
    
    
    @objc func editReport(){
        delegate.editReport(task: self.task)
    }
    
    @objc func deleteReport(){
        delegate.deleteReport(task: self.task)
    }
}
