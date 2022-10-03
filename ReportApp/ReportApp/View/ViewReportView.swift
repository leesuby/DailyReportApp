//
//  ViewReportView.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import Foundation
import UIKit

protocol ViewReportDelegate {
    func sendReport()
}

class ViewReport {
    
    var delegate : ViewReportDelegate!
    
    var background : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var sendButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "SendSymbol"), for: .normal)
        
        return button
    }()
    
    func initialFisrtLook(viewController : ViewReportViewController){
        let view: UIView = viewController.view
        let collectionView: UICollectionView = viewController.detailReportCollectionView
        
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        
        let btnView = UIView()
        
        btnView.backgroundColor = .darkPurple
        btnView.layer.cornerRadius = 25
        btnView.layer.shadowOpacity = 0.4
        btnView.layer.shadowRadius = 30
        
        view.addSubview(btnView)
        
        btnView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: btnView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: btnView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: btnView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: btnView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        
        
        btnView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: sendButton, attribute: .centerX, relatedBy: .equal, toItem: btnView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: sendButton, attribute: .centerY, relatedBy: .equal, toItem: btnView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: sendButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: sendButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
      
        
        sendButton.addTarget(self, action: #selector(sendReport), for: .touchUpInside)
    
    }
    
    
    @objc func sendReport(){
        delegate.sendReport()
    }
}
