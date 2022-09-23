//
//  DetailReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import UIKit

class DetailReportCell: UICollectionViewCell {
    
    private var tasks : [Task]  = [Task(title: "Bug", status: 80, detail: "trace bug màn hình khi không có kết nối", note: "Đã tìm ra nguyên nhân, đang khắc phục"),Task(title: "Bug", status: 80, detail: "trace bug màn hình khi không có kết nối", note: "Đã tìm ra nguyên nhân, đang khắc phục")]
    
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
        
        let dateBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int(contentView.frame.size.width) / 10))
        
        dateBox.backgroundColor = .zingPurple
        dateBox.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        
        let dateText: UITextView = UITextView(frame: CGRect(x: 0,y: 0,width: Int(dateBox.frame.size.width),height: Int(dateBox.frame.size.height)))
        
        dateText.text = "Longnct"
        dateText.font = .latoBold(size: 20)
        dateText.isEditable = false
        dateText.textColor = .white
        dateText.textAlignment = .center
        dateText.backgroundColor = .clear
        
        dateBox.addSubview(dateText)
        contentView.addSubview(dateBox)
        var y = 0
        for task in tasks {
            let title = UITextView(frame: CGRect(x: 10,y: y + Int(dateBox.frame.size.height) + 10,width: 50,height: 30))
            title.text = task.title
            title.font = .latoBold(size: 18)
            title.isEditable = false
            title.textColor = .white
            title.textAlignment = .center
            title.backgroundColor = .zingPurple70a
            title.layer.cornerRadius = 15
            contentView.addSubview(title)
            
            let status = UITextView(frame: CGRect(x: Int(contentView.frame.width) - 50, y: y + Int(dateBox.frame.size.height) + 10 , width: 50, height: 35))
            
            status.text = "\(task.status)%"
            status.font = .latoRegular(size: 18)
            status.isEditable = false
            status.textColor = .darkGreen
            status.textAlignment = .left
            status.backgroundColor = .clear
            contentView.addSubview(status)
            
            let detail = UITextView(frame: CGRect(x: 10, y: Int(title.center.y) + 20, width: Int(contentView.frame.width) - 20, height: 60))
            detail.text = task.detail
            detail.font = .latoRegular(size: 16)
            detail.isEditable = false
            detail.textColor = .black
            detail.textAlignment = .left
            detail.backgroundColor = .clear
            contentView.addSubview(detail)
            
            let noteImage = UIImageView(frame: CGRect(x: 10, y: Int(detail.center.y) + 20, width: Int(contentView.frame.width / 8), height: 40))
            
            noteImage.image = UIImage(named: "NoteSymbol")
            noteImage.contentMode = .scaleAspectFit
            noteImage.backgroundColor = .clear
            contentView.addSubview(noteImage)
            
            let noteText = UITextView(frame: CGRect(x: Int(noteImage.center.x) + 20, y: Int(detail.center.y) + 20 , width: Int(contentView.frame.width * 7/8) - 20, height: 60))
            noteText.text = task.note
            noteText.font = .latoRegular(size: 16)
            noteText.isEditable = false
            noteText.textColor = .red
            noteText.textAlignment = .left
            noteText.backgroundColor = .clear
            noteText.layer.borderColor = UIColor.black.cgColor
            noteText.layer.borderWidth = 0.5
            noteText.layer.cornerRadius = 10
            contentView.addSubview(noteText)
            
            
        
            y = Int(noteImage.center.y)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error Creating DetailCell")
    }
}
