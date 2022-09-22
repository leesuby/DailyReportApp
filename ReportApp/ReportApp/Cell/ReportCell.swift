//
//  ReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 22/09/2022.
//

import UIKit

class ReportCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: contentView.frame.width - 3, height: contentView.frame.height), cornerRadius: 30).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
   
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 1
        
        contentView.layer.addSublayer(shadowLayer)
        contentView.layer.cornerRadius = 30
        
        let dateBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width) / 3, height: Int(contentView.frame.size.width) / 10))
        
        dateBox.backgroundColor = .zingPurple
        dateBox.roundCorners(corners: [.topLeft], radius: 30)
        
        let dateText: UITextView = UITextView(frame: CGRect(x: 12,y: 0,width: Int(dateBox.frame.size.width),height: Int(dateBox.frame.size.height)))
        
        dateText.text = "19/09/2022"
        dateText.font = .latoRegular(size: 16)
        dateText.isEditable = false
        dateText.textColor = .white
        dateText.textAlignment = .left
        dateText.backgroundColor = .clear
        
        dateBox.addSubview(dateText)
        contentView.addSubview(dateBox)
        
        
        let reportText : UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int(dateBox.frame.size.height)))
        reportText.text = "Report"
        reportText.font = .latoBold(size: 20)
        reportText.isEditable = false
        reportText.textColor = .black
        reportText.textAlignment = .center
        reportText.backgroundColor = .clear
        reportText.layer.addBorder(edge: .bottom , color: UIColor.zingPurple, thickness: 1)
    
        contentView.addSubview(reportText)
      

        let viewDetail : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width / 2, height: contentView.frame.size.height / 3))
        viewDetail.center.x = contentView.center.x
        viewDetail.center.y = contentView.center.y
        viewDetail.image = UIImage(named: "ViewDetailSymbol")
        viewDetail.backgroundColor = .clear
        viewDetail.contentMode = .scaleAspectFit
    
        
        contentView.addSubview(viewDetail)
    
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Creating Cell Error")
    }
}
