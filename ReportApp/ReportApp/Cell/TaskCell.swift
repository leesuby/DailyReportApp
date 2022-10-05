//
//  TaskCell.swift
//  ReportApp
//
//  Created by LAP15335 on 30/09/2022.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    private var title : UILabel = UILabel()
    
    private var status : UILabel = UILabel()
    
    private var detail : UILabel = UILabel()
    
    private var note : UILabel = UILabel()
    
    private var noteImage: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initConstraint()
        
    }
    
    func initView() {
        let divider = UIView(frame: CGRect(x: 0, y: contentView.frame.size.height, width: contentView.frame.size.width, height: 1))
        divider.backgroundColor = .darkPurple40a
        contentView.addSubview(divider)
        
        title.font = .latoBold(size: 20)
        title.textColor = Global.titleColor
        title.numberOfLines = 2
        title.textAlignment = .left
        contentView.addSubview(title)
        
        status.font = .latoRegular(size: 18)
        status.textAlignment = .right
        status.backgroundColor = .clear
        contentView.addSubview(status)
        
        detail.font = .latoRegular(size: 16)
        detail.textColor = Global.detailColor
        detail.textAlignment = .left
        detail.numberOfLines = 3
        detail.backgroundColor = .clear
        contentView.addSubview(detail)
        
        noteImage.image = UIImage(named: "NoteSymbol")
        noteImage.contentMode = .scaleAspectFit
        noteImage.backgroundColor = .clear
        contentView.addSubview(noteImage)
        
        
        note.font = .latoRegular(size: 16)
        note.textColor = Global.noteColor
        note.textAlignment = .left
        note.numberOfLines = 3
        note.backgroundColor = .clear
        contentView.addSubview(note)
    }
    
    func initConstraint() {
        status.translatesAutoresizingMaskIntoConstraints = false
        status.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Global.padding).isActive = true
        status.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Global.padding).isActive = true
        status.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Global.padding).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Global.padding).isActive = true
        title.trailingAnchor.constraint(equalTo: status.leadingAnchor).isActive = true
        
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.topAnchor.constraint(equalTo: title.bottomAnchor,constant: Global.padding).isActive = true
        detail.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        detail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Global.padding).isActive = true
        
        noteImage.translatesAutoresizingMaskIntoConstraints = false
        noteImage.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: Global.padding).isActive = true
        noteImage.leadingAnchor.constraint(equalTo: detail.leadingAnchor).isActive = true
        noteImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        noteImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        note.translatesAutoresizingMaskIntoConstraints = false
        note.leadingAnchor.constraint(equalTo: noteImage.trailingAnchor).isActive = true
        note.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Global.padding).isActive = true
        note.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: Global.padding + 5).isActive = true
    
    }
    
    
    func config(task: Task){
        title.text = task.title
        
        status.text = "\(task.status)%"
        status.textColor = Helper.getStatusColor(status: task.status)
        
        detail.text = task.detail
        
        note.text = task.note
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error init taskcell")
    }
}
