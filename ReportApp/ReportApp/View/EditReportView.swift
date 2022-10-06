//
//  EditReportView.swift
//  ReportApp
//
//  Created by LAP15335 on 25/09/2022.
//

import Foundation
import UIKit

protocol EditReportDelegate{
    func addTask()
}

class EditReport {
    
    var delegate : EditReportDelegate!
    
    var background : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var addButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkPurple
        button.setImage(UIImage(named: "AddSymbol"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 30
        return button
    }()
    
    var textNoTask : UILabel = {
        let text = UILabel()
        text.backgroundColor = .clear
        text.font = .latoBold(size: 24)
        text.text = "You have not created any task yet"
        text.textColor = .darkGray
        return text
    }()
    
    func initialFisrtLook(viewController : EditReportViewController){
        let view: UIView = viewController.view
        let collectionView: UICollectionView = viewController.editReportCollectionView
        collectionView.backgroundColor = .clear
        
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: addButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: addButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: addButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        addButton.addTarget(self, action: #selector(btnAddTask), for: .touchUpInside)
        
        view.addSubview(textNoTask)
        textNoTask.translatesAutoresizingMaskIntoConstraints = false
        textNoTask.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textNoTask.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func hiddenText(){
        textNoTask.isHidden = true
    }
    
    func showText(){
        textNoTask.isHidden = false
    }
    
    @objc func btnAddTask(sender:UIButton){
        delegate.addTask()
    }
    
    
}
