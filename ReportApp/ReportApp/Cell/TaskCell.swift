//
//  TaskCell.swift
//  ReportApp
//
//  Created by LAP15335 on 30/09/2022.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    private var title : UITextView = UITextView()
    
    private var status : UITextView = UITextView()
    
    private var detail : UITextView = UITextView()
    
    private var note : UITextView = UITextView()
    
    private var noteImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let divider = UIView(frame: CGRect(x: 0, y: contentView.frame.size.height, width: contentView.frame.size.width, height: 1))
        
        divider.backgroundColor = .darkPurple40a
        
        contentView.addSubview(divider)
        title.frame = CGRect(x: 0,y: 5,width: .max ,height: 30)
        
        title.font = .latoBold(size: 18)
        title.isEditable = false
        title.isScrollEnabled = false
        title.textColor = .white
        title.textAlignment = .left
        title.backgroundColor = .zingPurple70a
        title.layer.cornerRadius = 15
        
        contentView.addSubview(title)
        
        
        status.frame = CGRect(x: Int(contentView.frame.width) - 80, y: 5, width: 80, height: 35)
        
        status.font = .latoRegular(size: 18)
        status.isEditable = false
        status.isScrollEnabled = false
        status.textColor = .darkGreen
        status.textAlignment = .right
        status.backgroundColor = .clear
        contentView.addSubview(status)
        
        detail.frame = CGRect(x: 0, y: Int(title.center.y) + 20, width: Int(contentView.frame.width) - 20, height: 100)
        
        detail.font = .latoRegular(size: 16)
        detail.isEditable = false
        detail.isScrollEnabled = false
        detail.textColor = .black
        detail.textAlignment = .left
        detail.backgroundColor = .clear
        
        contentView.addSubview(detail)
        
        noteImage = UIImageView(frame: CGRect(x: 0, y: Int(detail.center.y) + 40, width: Int(contentView.frame.width / 8), height: 40))
        
        noteImage.image = UIImage(named: "NoteSymbol")
        noteImage.contentMode = .scaleAspectFit
        noteImage.backgroundColor = .clear
        contentView.addSubview(noteImage)
        
        note.frame = CGRect(x: Int(noteImage.center.x) + 20, y: Int(detail.center.y) + 40 , width: Int(contentView.frame.width * 7/8) - 20, height: 60)
        
        note.font = .latoRegular(size: 16)
        note.isEditable = false
        note.isScrollEnabled = false
        note.textColor = .red
        note.textAlignment = .left
        note.backgroundColor = .noteColor
        
        contentView.addSubview(note)
    }
    
    
    func config(task: Task){
        title.frame = CGRect(x: 0 ,y: 5,width: 200,height: 30)
        title.text = task.title
        title.sizeToFit()
        
        switch task.status{
        case 75...100:
            status.textColor = .darkGreen
        case 35..<75:
            status.textColor = .darkYello
        default:
            status.textColor = .darkRed
            
        }
        
        status.text = "\(task.status)%"
        
        detail.text = task.detail
        
        note.text = task.note
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error init taskcell")
    }
}
