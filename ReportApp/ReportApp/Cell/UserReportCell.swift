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
    
    private let userText: UITextView = UITextView()
    
    private let title: UITextView = UITextView()
    
    private let status: UITextView = UITextView()
    
    private let detail : UITextView = UITextView()
    
    private let noteText : UITextView = UITextView()
    
    private var task : Task!
    private var heightUserBox : Float = 0
    
    var delegate: UserReportCellDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        let userBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int(contentView.frame.size.width) / 10))
        
        userBox.backgroundColor = .zingPurple
        userBox.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        
        
        heightUserBox = Float(userBox.frame.size.height)
        
        userText.frame = CGRect(x: userBox.center.x - 10, y: 0,width: 30,height: 30)
        userText.text = ""
        userText.font = .latoBold(size: 20)
        userText.isEditable = false
        userText.isScrollEnabled = false
        userText.textColor = .white
        userText.textAlignment = .center
        userText.backgroundColor = .clear
        
        
        let editButton: UIButton = UIButton(frame: CGRect(x: userBox.frame.size.width - 30, y: 10,width: 20,height: 20))
        editButton.setImage(UIImage(named: "EditSymbol")?.withRenderingMode(.alwaysTemplate), for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = .clear
        editButton.addTarget(self, action: #selector(editReport), for: .touchUpInside)
        
        userBox.addSubview(editButton)
        userBox.addSubview(userText)
        contentView.addSubview(userBox)
        
        
        title.frame = CGRect(x: 10,y: Int(heightUserBox) + 10,width: 200,height: 30)
        title.font = .latoBold(size: 18)
        title.isEditable = false
        title.isScrollEnabled = false
        title.textColor = .white
        title.textAlignment = .left
        title.backgroundColor = .zingPurple70a
        title.layer.cornerRadius = 15
        

        contentView.addSubview(title)
        
        status.frame = CGRect(x: Int(contentView.frame.width) - 80, y:  Int(heightUserBox) + 10 , width: 80, height: 35)
        
        status.font = .latoRegular(size: 18)
        status.isEditable = false
        status.isScrollEnabled = false
        status.textColor = .darkGreen
        status.textAlignment = .right
        status.backgroundColor = .clear
        contentView.addSubview(status)
        
        detail.frame = CGRect(x: 10, y: Int(title.center.y) + 20, width: Int(contentView.frame.width) - 20, height: 90)
        detail.font = .latoRegular(size: 16)
        detail.isEditable = false
        detail.isScrollEnabled = false
        detail.textColor = .black
        detail.textAlignment = .left
        detail.backgroundColor = .clear
        
        contentView.addSubview(detail)
        
        let noteImage = UIImageView(frame: CGRect(x: 10, y: Int(detail.center.y) + 40, width: Int(contentView.frame.width / 8), height: 40))
        
        noteImage.image = UIImage(named: "NoteSymbol")
        noteImage.contentMode = .scaleAspectFit
        noteImage.backgroundColor = .clear
        contentView.addSubview(noteImage)
        
        noteText.frame =  CGRect(x: Int(noteImage.center.x) + 20, y: Int(detail.center.y) + 40 , width: Int(contentView.frame.width * 7/8) - 20, height: 60)
    
    
        noteText.font = .latoRegular(size: 16)
        noteText.isEditable = false
        noteText.isScrollEnabled = false
        noteText.textColor = .red
        noteText.textAlignment = .left
        noteText.backgroundColor = .noteColor

        contentView.addSubview(noteText)
        
        let deleteButton : UIButton = UIButton(frame: CGRect(x: 10, y: 10, width: 20, height:20))
        
        deleteButton.setImage(UIImage(named: "DeleteSymbol_Red")?.withRenderingMode(.alwaysTemplate), for: .normal)
        deleteButton.backgroundColor = .clear
        deleteButton.tintColor = .white
        deleteButton.layer.cornerRadius = 10
        deleteButton.addTarget(self, action: #selector(deleteReport), for: .touchUpInside)

        
        contentView.addSubview(deleteButton)
        
        
    }
    
    func configureOneTask(task : Task,text: String){
        self.task = task
        title.frame = CGRect(x: 10,y: Int(heightUserBox) + 10,width: Int(contentView.frame.size.width - status.frame.width),height: 30)
        title.text = task.title
        title.sizeToFit()
        
        userText.text = text
        
        status.text = "\(String(task.status))%"
        
        switch task.status{
        case 75...100:
            status.textColor = .darkGreen
        case 35..<75:
            status.textColor = .darkYello
        default:
            status.textColor = .darkRed
            
        }
        
        detail.frame = CGRect(x: 10, y: Int(title.center.y) + 20, width: Int(contentView.frame.width) - 20, height: 100)
        detail.text = task.detail
        detail.sizeToFit()
        
        noteText.text = task.note
        
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
