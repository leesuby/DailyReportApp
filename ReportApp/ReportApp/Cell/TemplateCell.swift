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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.layer.borderColor = UIColor.deepPurple.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 5
        
        title.frame = CGRect(x: 5, y: 5, width: contentView.frame.width - 25, height: contentView.frame.size.height / 2)
        title.backgroundColor = .clear
        title.isEditable = false
        title.isScrollEnabled = false
        title.text = "taskkkkk"
        title.font = .latoRegular(size: 14)
        
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Error Creating Template Cell")
    }
}
