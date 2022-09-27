//
//  UserReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

import UIKit

class UserReportCell: UICollectionViewCell {
    private var tasks : [Task]  = []
    
    private let userText: UITextView = UITextView()
    
    private let title: UITextView = UITextView()
    
    private let status: UITextView = UITextView()
    
    private let detail : UITextView = UITextView()
    
    private let noteText : UITextView = UITextView()
    
    private var heightUserBox : Float = 0
    
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
        
        userText.frame = CGRect(x: 0,y: 0,width: Int(userBox.frame.size.width),height: Int(userBox.frame.size.height))
        userText.text = "Longnct"
        userText.font = .latoBold(size: 20)
        userText.isEditable = false
        userText.isScrollEnabled = false
        userText.textColor = .white
        userText.textAlignment = .center
        userText.backgroundColor = .clear
        
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
        
        detail.frame = CGRect(x: 10, y: Int(title.center.y) + 20, width: Int(contentView.frame.width) - 20, height: 100)
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
        noteText.backgroundColor = .clear
        noteText.layer.borderColor = UIColor.black.cgColor
        noteText.layer.borderWidth = 0.5
        noteText.layer.cornerRadius = 10
        contentView.addSubview(noteText)
        
        
    }
    func configureOneTask(task : Task){
        
        title.frame = CGRect(x: 10,y: Int(heightUserBox) + 10,width: 200,height: 30)
        title.text = task.title
        title.sizeToFit()
        
        status.text = "\(String(task.status))%"
        
        detail.text = task.detail

        
        noteText.text = task.note
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("Error Creating DetailCell")
    }
}
