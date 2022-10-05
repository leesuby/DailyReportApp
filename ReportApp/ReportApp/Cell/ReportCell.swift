//
//  ReportCell.swift
//  ReportApp
//
//  Created by LAP15335 on 22/09/2022.
//

import UIKit

class ReportCell: UICollectionViewCell {
    
    let dateText: UILabel = UILabel()
    let status: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        initConstraint()
    }
    
    func initView(){
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: contentView.frame.width - 3, height: contentView.frame.height), cornerRadius: 20).cgPath
        shadowLayer.fillColor = UIColor.zingPurple40a.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 1
        contentView.layer.addSublayer(shadowLayer)
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.backgroundColor = .zingPurple40a
        
        dateText.font = .latoBlack(size: 24)
        dateText.textColor = .white
        dateText.textAlignment = .center
        dateText.backgroundColor = .clear
        contentView.addSubview(dateText)
        
        status.font = .latoRegular(size: 14)
        status.text = "Sent by longnct at 19:03:20"
        status.textColor = .white
        status.backgroundColor = .clear
        status.textAlignment = .center
        contentView.addSubview(status)
    }
    
    func initConstraint(){
        dateText.translatesAutoresizingMaskIntoConstraints = false
        dateText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        status.translatesAutoresizingMaskIntoConstraints = false
        status.topAnchor.constraint(equalTo: dateText.bottomAnchor).isActive = true
        status.centerXAnchor.constraint(equalTo: dateText.centerXAnchor).isActive = true
    }
    
    func config(report : Report){
        dateText.text = report.date
        status.text = report.status
    }
    
    required init?(coder: NSCoder) {
        fatalError("Creating Cell Error")
    }
}
