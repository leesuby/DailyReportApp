//
//  TemplateCell.swift
//  ReportApp
//
//  Created by LAP15335 on 03/10/2022.
//

import Foundation
import UIKit

protocol TemplateCellDelegate {
    func getTemplate()
}

class TemplateCell : UICollectionViewCell{
    
    private var title : UITextView = UITextView()
    
    private var date : UITextView = UITextView()
    
    private var id : String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.layer.borderColor = UIColor.deepPurple.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 5
        
        title.frame = CGRect(x: 5, y: 0, width: contentView.frame.width - 30, height: contentView.frame.size.height / 1.5)
        title.backgroundColor = .clear
        title.isEditable = false
        title.isScrollEnabled = false
        title.text = "taskkkkk"
        title.textColor = .black
        title.font = .latoRegular(size: 16)
        contentView.addSubview(title)
        
        date.frame = CGRect(x: 5 , y: title.center.y + 2, width: contentView.frame.width - 30, height: contentView.frame.size.height / 2.5)
        date.backgroundColor = .clear
        date.isEditable = false
        date.isScrollEnabled = false
        date.text = "19-08-2022"
        date.textColor = .black
        date.font = .latoLight(size: 12)
        contentView.addSubview(date)
        
        let imageGet = UIImageView(frame: CGRect(x: contentView.frame.size.width - 30, y: 0, width: 25, height: contentView.frame.size.height))
        
        imageGet.image = UIImage(named: "GetSymbol")
        imageGet.contentMode = .scaleAspectFit
        contentView.addSubview(imageGet)
    }
    
    func config(task: Task, date: String){
        
        self.id = task.id
        self.title.text = task.title
        self.date.text = date
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Error Creating Template Cell")
    }
}
