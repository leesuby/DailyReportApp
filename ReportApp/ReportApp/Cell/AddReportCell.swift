//
//  AddReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 25/09/2022.
//

import UIKit

protocol AddReportCellDelegate {
    func cancelReport(task: Task)
    func saveReport(task: Task)
}

class AddReportCell: UICollectionViewCell {
    
    private var tagField : UITextField = UITextField()
    private var statusField : UITextField = UITextField()
    private var detailField : UITextView = UITextView()
    private var noteField : UITextView = UITextView()
    var delegate : AddReportCellDelegate!
    
    private let taskText : UITextView = UITextView()
    private var task: Task!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        let taskBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int(contentView.frame.size.width) / 10))
        
        taskBox.backgroundColor = .zingPurple
        taskBox.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        
        taskText.frame = CGRect(x: 0,y: 0,width: Int(taskBox.frame.size.width),height: Int(taskBox.frame.size.height))
        
        taskText.text = ""
        taskText.font = .latoBold(size: 20)
        taskText.isEditable = false
        taskText.isScrollEnabled = false
        taskText.textColor = .white
        taskText.textAlignment = .center
        taskText.backgroundColor = .clear
        
        taskBox.addSubview(taskText)
        contentView.addSubview(taskBox)
        
        let tagView = UIView(frame: CGRect(x: 10, y: taskBox.frame.size.height + 15, width: 30, height: 30))
        tagView.backgroundColor = .zingPurple70a
        tagView.layer.cornerRadius = 15
        contentView.addSubview(tagView)
        
        
        let tagImage = UIImageView()
        tagImage.image = UIImage(named: "TitleSymbol")
        tagView.addSubview(tagImage)
        
        tagImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: tagImage, attribute: .centerX, relatedBy: .equal, toItem: tagView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tagImage, attribute: .centerY, relatedBy: .equal, toItem: tagView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tagImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: tagImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
    
        
        let tagText = UITextView(frame: CGRect(x: 40, y: taskBox.frame.size.height + 12, width: 60, height: 30))
        tagText.text = "Title"
        tagText.textColor = .zingPurple70a
        tagText.font = .latoRegular(size: 16)
        tagText.backgroundColor = .clear
        tagText.isEditable = false
        tagText.isScrollEnabled = false
        contentView.addSubview(tagText)
        

        tagField.frame = CGRect(x: 105, y: taskBox.frame.size.height + 12, width: contentView.frame.size.width - tagText.frame.size
            .width - tagImage.frame.size.width - 40, height: 40)
        tagField.textColor = .black
        tagField.font = .latoLight(size: 14)
        tagField.layer.borderColor = UIColor.darkPurple40a.cgColor
        tagField.layer.borderWidth = 0.5
        tagField.layer.cornerRadius = 20
        tagField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: tagField.frame.height))
        tagField.leftViewMode = .always
        contentView.addSubview(tagField)
        
        
        let statusView = UIView(frame: CGRect(x: 10, y: tagView.center.y + 38, width: 30, height: 30))
        statusView.backgroundColor = .zingPurple70a
        statusView.layer.cornerRadius = 15
        contentView.addSubview(statusView)
        
        
        let statusImage = UIImageView()
        statusImage.image = UIImage(named: "StatusSymbol")
        statusView.addSubview(statusImage)
        
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: statusImage, attribute: .centerX, relatedBy: .equal, toItem: statusView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: statusImage, attribute: .centerY, relatedBy: .equal, toItem: statusView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: statusImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: statusImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        
        
        
        let statusText = UITextView(frame: CGRect(x: 40, y: tagText.center.y + 38, width: 60, height: 30))
        statusText.text = "Status"
        statusText.textColor = .zingPurple70a
        statusText.font = .latoRegular(size: 16)
        statusText.backgroundColor = .clear
        statusText.isEditable = false
        statusText.isScrollEnabled = false
        contentView.addSubview(statusText)
        

        statusField.frame = CGRect(x: 105, y: tagField.center.y + 34, width: contentView.frame.size.width - statusText.frame.size
            .width - statusImage.frame.size.width - 40, height: 40)
        statusField.textColor = .black
        statusField.font = .latoLight(size: 14)
        statusField.layer.borderColor = UIColor.darkPurple40a.cgColor
        statusField.layer.borderWidth = 0.5
        statusField.layer.cornerRadius = 20
        statusField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: statusField.frame.height))
        statusField.leftViewMode = .always
        contentView.addSubview(statusField)
        
        let detailView = UIView(frame: CGRect(x: 10, y: statusView.center.y + 38, width: 30, height: 30))
        detailView.backgroundColor = .zingPurple70a
        detailView.layer.cornerRadius = 15
        contentView.addSubview(detailView)
        
        
        let detailImage = UIImageView()
        detailImage.image = UIImage(named: "DetailSymbol")
        detailView.addSubview(detailImage)
        
        detailImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: detailImage, attribute: .centerX, relatedBy: .equal, toItem: detailView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: detailImage, attribute: .centerY, relatedBy: .equal, toItem: detailView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: detailImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: detailImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        
        
        let detailText = UITextView(frame: CGRect(x: 40, y: statusText.center.y + 38, width: 60, height: 30))
        detailText.text = "Detail"
        detailText.textColor = .zingPurple70a
        detailText.font = .latoRegular(size: 16)
        detailText.backgroundColor = .clear
        detailText.isEditable = false
        detailText.isScrollEnabled = false
        contentView.addSubview(detailText)
        

        detailField.frame = CGRect(x: 10, y: detailView.center.y + 25, width: contentView.frame.size.width - 20, height: 100)
        detailField.textColor = .black
        detailField.backgroundColor = .clear
        detailField.font = .latoLight(size: 14)
        detailField.layer.borderColor = UIColor.darkPurple40a.cgColor
        detailField.layer.borderWidth = 0.5
        detailField.layer.cornerRadius = 20
        contentView.addSubview(detailField)
        
        let noteView = UIView(frame: CGRect(x: 10, y: detailView.center.y + detailField.frame.size.height + 38, width: 30, height: 30))
        noteView.backgroundColor = .zingPurple70a
        noteView.layer.cornerRadius = 15
        contentView.addSubview(noteView)
        
        
        let noteImage = UIImageView()
        noteImage.image = UIImage(named: "NoteSymbol_White")
        noteView.addSubview(noteImage)
        
        noteImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: noteImage, attribute: .centerX, relatedBy: .equal, toItem: noteView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: noteImage, attribute: .centerY, relatedBy: .equal, toItem: noteView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: noteImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: noteImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20).isActive = true
        
        
        let noteText = UITextView(frame: CGRect(x: 40, y: detailText.center.y + detailField.frame.size.height + 38, width: 60, height: 30))
        noteText.text = "Note"
        noteText.textColor = .zingPurple70a
        noteText.font = .latoRegular(size: 16)
        noteText.backgroundColor = .clear
        noteText.isEditable = false
        noteText.isScrollEnabled = false
        contentView.addSubview(noteText)
        

        noteField.frame = CGRect(x: 10, y: noteView.center.y + 25, width: contentView.frame.size.width - 20, height: 100)
        noteField.textColor = .black
        noteField.backgroundColor = .clear
        noteField.font = .latoLight(size: 14)
        noteField.layer.borderColor = UIColor.darkPurple40a.cgColor
        noteField.layer.borderWidth = 0.5
        noteField.layer.cornerRadius = 20
        contentView.addSubview(noteField)
        
        
        let buttonCancel = UIButton(frame: CGRect(x:(contentView.frame.size.width / 2) - 60, y:  contentView.frame.size.height - 40 , width: 60, height: 30))
        
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.titleLabel?.textColor = .white
        buttonCancel.titleLabel?.font = .latoBold(size: 16)
        buttonCancel.backgroundColor = .gray40a
        buttonCancel.layer.cornerRadius = 10
        buttonCancel.addTarget(self, action: #selector(cancelAddReport) , for: .touchUpInside)
        contentView.addSubview(buttonCancel)
        
        
        let buttonSave = UIButton(frame: CGRect(x:(contentView.frame.size.width / 2) + 10, y:  contentView.frame.size.height - 40 , width: 60, height: 30))
        
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.titleLabel?.textColor = .white
        buttonSave.titleLabel?.font = .latoBold(size: 16)
        buttonSave.backgroundColor = .darkPurple40a
        buttonSave.layer.cornerRadius = 10
        buttonSave.addTarget(self, action: #selector(saveAddReport) , for: .touchUpInside)
        contentView.addSubview(buttonSave)
        
    }
    
    func config(title: String){
        taskText.text = title
    }
    func config(title: String,task: Task){
        self.task = task
        taskText.text = title
        tagField.text = task.title
        statusField.text = "\(task.status)"
        detailField.text = task.detail
        noteField.text = task.note
    }
    
    @objc func cancelAddReport(){
        self.delegate.cancelReport(task: self.task)
    }
    
    @objc func saveAddReport(){
        let task = Task(title: tagField.text!, status: Int(statusField.text!)!, detail: detailField.text, note: noteField.text)
        task.id = self.task.id
        
        self.delegate.saveReport(task: task)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Create addreportcell error")
    }
}
