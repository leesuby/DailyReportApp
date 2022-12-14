//
//  HomeView.swift
//  ReportApp
//
//  Created by LAP15335 on 22/09/2022.
//

import Foundation
import UIKit

protocol HomeViewDelegate{
    func createReport();
    func logOut();
}

class HomeView {
    var delegate : HomeViewDelegate!
    
    var background : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var banner : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "BannerHome")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var logo : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "LogoZingMp3")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var brand : UITextView = {
        let textView = UITextView(frame: .zero)
        textView.text = "Zing MP3"
        textView.font = .latoBold(size: 26)
        textView.textColor = .white
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var avatar : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "DefaultAvatar")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var userName : UITextView = {
        let textView = UITextView(frame: .zero)
        textView.text = UserSession.username
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.font = .latoRegular(size: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var latestText : UITextView = {
        let textView = UITextView(frame: .zero)
        textView.text = "Latest Report"
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.font = .latoBold(size: 26)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var createButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "AddReportSymbol"), for: .normal)
        
        return button
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "LogoutSymbol"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
   
    var textNoReport : UILabel = {
        let text = UILabel()
        text.backgroundColor = .clear
        text.font = .latoBold(size: 20)
        text.text = "Currently no reports have been created"
        text.textColor = .darkGray
        return text
    }()
    
    func initialFisrtLook(viewController : HomeViewController){
        
        let view: UIView = viewController.view
        var safeArea : UILayoutGuide
        
        if #available(iOS 11.0, *) {
            safeArea = viewController.view.safeAreaLayoutGuide
        } else {
            safeArea = viewController.topLayoutGuide as! UILayoutGuide
        }
        let collectionView : UICollectionView = viewController.reportCollectionView
        
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(banner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/8, constant: 0).isActive = true
        
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: logo, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: banner, attribute: .centerY, multiplier: 2.0, constant: 30).isActive = true
        NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1/4, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/14, constant: 0).isActive = true
        
        view.addSubview(brand)
        brand.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: brand, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: -6).isActive = true
        NSLayoutConstraint(item: brand, attribute: .centerX, relatedBy: .equal, toItem: logo, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: brand, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200).isActive = true
        NSLayoutConstraint(item: brand, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
       
        
        view.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: avatar, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: avatar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: avatar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: avatar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        
        view.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: userName, attribute: .leading , relatedBy: .equal, toItem: avatar, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: userName, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: userName, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80).isActive = true
        NSLayoutConstraint(item: userName, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        
        view.addSubview(latestText)
        latestText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: latestText, attribute: .top , relatedBy: .equal, toItem: logo, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: latestText, attribute: .centerX, relatedBy: .equal, toItem: logo, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: latestText, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: -30).isActive = true
        NSLayoutConstraint(item: latestText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: collectionView, attribute: .top , relatedBy: .equal, toItem: latestText, attribute: .bottom, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .centerX, relatedBy: .equal, toItem: latestText, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: -30).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        
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
        
        
        btnView.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: createButton, attribute: .centerX, relatedBy: .equal, toItem: btnView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: createButton, attribute: .centerY, relatedBy: .equal, toItem: btnView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: createButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: createButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        createButton.addTarget(self, action: #selector(createReport), for: .touchUpInside)
        
        
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: logoutButton, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: logoutButton, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: logoutButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25).isActive = true
        NSLayoutConstraint(item: logoutButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25).isActive = true
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        view.addSubview(textNoReport)
        textNoReport.translatesAutoresizingMaskIntoConstraints = false
        textNoReport.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textNoReport.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func hideText(){
        textNoReport.isHidden = true
    }
    
    func showText(){
        textNoReport.isHidden = false
    }
    
    @objc func createReport(){
        delegate.createReport()
    }
    
    @objc func logout(){
        delegate.logOut()
    }
}
