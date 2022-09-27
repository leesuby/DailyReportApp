//
//  AddReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 25/09/2022.
//

import UIKit

protocol AddReportCellDelegate {
    func cancelReport()
    func saveReport()
}

class AddReportCell: UICollectionViewCell {
    
    private var tagField : UITextField = UITextField()
    private var statusField : UITextField = UITextField()
    private var detailField : UITextView = UITextView()
    private var noteField : UITextView = UITextView()
    var delegate : AddReportCellDelegate!
    
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
        
        let userBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int(contentView.frame.size.width) / 10))
        
        userBox.backgroundColor = .zingPurple
        userBox.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        
        let userText: UITextView = UITextView(frame: CGRect(x: 0,y: 0,width: Int(userBox.frame.size.width),height: Int(userBox.frame.size.height)))
        
        userText.text = "Longnct"
        userText.font = .latoBold(size: 20)
        userText.isEditable = false
        userText.isScrollEnabled = false
        userText.textColor = .white
        userText.textAlignment = .center
        userText.backgroundColor = .clear
        
        userBox.addSubview(userText)
        contentView.addSubview(userBox)
        
        let tagImage = UIImageView(frame: CGRect(x: 10, y: userBox.frame.size.height + 15, width: 30, height: 30))
        tagImage.image = UIImage(named: "TitleSymbol")
        tagImage.layer.backgroundColor = UIColor.zingPurple70a.cgColor
        tagImage.layer.cornerRadius = 15
        contentView.addSubview(tagImage)
        
        
        let tagText = UITextView(frame: CGRect(x: 40, y: userBox.frame.size.height + 12, width: 60, height: 30))
        tagText.text = "Title"
        tagText.textColor = .zingPurple70a
        tagText.font = .latoRegular(size: 16)
        tagText.backgroundColor = .clear
        tagText.isEditable = false
        tagText.isScrollEnabled = false
        contentView.addSubview(tagText)
        

        tagField.frame = CGRect(x: 105, y: userBox.frame.size.height + 12, width: contentView.frame.size.width - tagText.frame.size
            .width - tagImage.frame.size.width - 40, height: 40)
        tagField.textColor = .black
        tagField.font = .latoLight(size: 14)
        tagField.layer.borderColor = UIColor.darkPurple40a.cgColor
        tagField.layer.borderWidth = 0.5
        tagField.layer.cornerRadius = 20
        tagField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: tagField.frame.height))
        tagField.leftViewMode = .always
        contentView.addSubview(tagField)
        
        
        let statusImage = UIImageView(frame: CGRect(x: 10, y: tagImage.center.y + 38, width: 30, height: 30))
        statusImage.image = UIImage(named: "StatusSymbol")
        statusImage.layer.backgroundColor = UIColor.zingPurple70a.cgColor
        statusImage.layer.cornerRadius = 15
        contentView.addSubview(statusImage)
        
        
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
        
        let detailImage = UIImageView(frame: CGRect(x: 10, y: statusImage.center.y + 38, width: 30, height: 30))
        detailImage.image = UIImage(named: "DetailSymbol")
        detailImage.layer.backgroundColor = UIColor.zingPurple70a.cgColor
        detailImage.layer.cornerRadius = 15
        contentView.addSubview(detailImage)
        
        
        let detailText = UITextView(frame: CGRect(x: 40, y: statusText.center.y + 38, width: 60, height: 30))
        detailText.text = "Detail"
        detailText.textColor = .zingPurple70a
        detailText.font = .latoRegular(size: 16)
        detailText.backgroundColor = .clear
        detailText.isEditable = false
        detailText.isScrollEnabled = false
        contentView.addSubview(detailText)
        

        detailField.frame = CGRect(x: 10, y: detailImage.center.y + 25, width: contentView.frame.size.width - 20, height: 100)
        detailField.textColor = .black
        detailField.backgroundColor = .clear
        detailField.font = .latoLight(size: 14)
        detailField.layer.borderColor = UIColor.darkPurple40a.cgColor
        detailField.layer.borderWidth = 0.5
        detailField.layer.cornerRadius = 20
        contentView.addSubview(detailField)
        
        
        let noteImage = UIImageView(frame: CGRect(x: 10, y: detailImage.center.y + detailField.frame.size.height + 38, width: 30, height: 30))
        noteImage.image = UIImage(named: "NoteSymbol_White")
     
        noteImage.contentMode = .scaleAspectFit
        noteImage.layer.backgroundColor = UIColor.zingPurple70a.cgColor
        noteImage.layer.cornerRadius = 15
        contentView.addSubview(noteImage)
        
        
        let noteText = UITextView(frame: CGRect(x: 40, y: detailText.center.y + detailField.frame.size.height + 38, width: 60, height: 30))
        noteText.text = "Note"
        noteText.textColor = .zingPurple70a
        noteText.font = .latoRegular(size: 16)
        noteText.backgroundColor = .clear
        noteText.isEditable = false
        noteText.isScrollEnabled = false
        contentView.addSubview(noteText)
        

        noteField.frame = CGRect(x: 10, y: noteImage.center.y + 25, width: contentView.frame.size.width - 20, height: 100)
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
        contentView.addSubview(buttonCancel)
        
        
        let buttonSave = UIButton(frame: CGRect(x:(contentView.frame.size.width / 2) + 10, y:  contentView.frame.size.height - 40 , width: 60, height: 30))
        
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.titleLabel?.textColor = .white
        buttonSave.titleLabel?.font = .latoBold(size: 16)
        buttonSave.backgroundColor = .darkPurple40a
        buttonSave.layer.cornerRadius = 10
        contentView.addSubview(buttonSave)
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Create addreportcell error")
    }
}
