//
//  TemplateModal.swift
//  ReportApp
//
//  Created by LAP15335 on 03/10/2022.
//

import Foundation
import UIKit
class TemplateModal : NSObject{
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let templateView: UIView = {
        let templateBox = UIView()
        templateBox.backgroundColor = .white
        templateBox.layer.cornerRadius = 10
        templateBox.layer.masksToBounds = true
        
        return templateBox
        
    }()
    
    private var view : UIView?
    private var taskCollectionView : UICollectionView!
    
    func showBox(title: String, viewController: UIViewController){
        guard let targetView = viewController.view else{
            return
        }
        
        view = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        templateView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 100, height: 300)
        targetView.addSubview(templateView)
        
        let imageLogo = UIImageView(frame: CGRect(x: 0, y: 5, width: templateView.frame.size.width, height: 50))
        imageLogo.image = UIImage(named: "LogoZingMp3")
        imageLogo.backgroundColor = .clear
        imageLogo.contentMode = .scaleAspectFit
        templateView.addSubview(imageLogo)
        
        let guideText = UITextView(frame: CGRect(x: 0, y: 50, width: templateView.frame.size.width, height: 30))
        guideText.text = "Your five recent tasks:"
        guideText.textColor = .deepPurple
        guideText.font = .latoBold(size: 16)
        guideText.textAlignment = .center
        guideText.isEditable = false
        guideText.isScrollEnabled = false
        guideText.backgroundColor = .clear
        templateView.addSubview(guideText)
        
        
        let dismissButton = UIButton(frame: CGRect(x: 0, y: templateView.frame.size.height - 50, width: templateView.frame.size.width, height: 50))
        dismissButton.backgroundColor = .zingPurple70a
        dismissButton.setTitle("Cancel", for: .normal)
        dismissButton.titleLabel?.font = .latoBold(size: 18)
        dismissButton.titleLabel?.contentMode = .center
        dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        templateView.addSubview(dismissButton)
        
        
        //init collectionView
        
        taskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        taskCollectionView.backgroundColor = .clear
        
        templateView.addSubview(taskCollectionView)
        
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: taskCollectionView!, attribute: .top, relatedBy: .equal, toItem: guideText, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: taskCollectionView!, attribute: .bottom, relatedBy: .equal, toItem: dismissButton, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: taskCollectionView!, attribute: .leading, relatedBy: .equal, toItem: templateView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: taskCollectionView!, attribute: .width, relatedBy: .equal, toItem: templateView, attribute: .width, multiplier: 1.0, constant: -20).isActive = true
        
        taskCollectionView.register(TemplateCell.self, forCellWithReuseIdentifier: "template")
        taskCollectionView.dataSource = self
        taskCollectionView.delegate = self
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = 0.4
        }) { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.templateView.center = targetView.center
                })
            }
        }
        
    }
    
    func initCollectionView(){
        
    }
    
    @objc func dismiss(){
        guard let targetView = view else {
            return
        }

        UIView.animate(withDuration: 0.25, animations: {
            self.templateView.frame = CGRect(x: 40,
                                             y: targetView.frame.height,
                                             width: targetView.frame.size.width - 100,
                                             height: 300)
        }) { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }) { done in
                    if done {
                        self.templateView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        self.taskCollectionView.removeFromSuperview()
                    }
                }
            }
        }
    }
}

extension TemplateModal : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let templateCell = collectionView.dequeueReusableCell(withReuseIdentifier: "template", for: indexPath) as? TemplateCell{
            
            cell = templateCell
        }
        
        return cell
    }
    
    
}

extension TemplateModal : UICollectionViewDelegate{
    
}

extension TemplateModal : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 40)
    }
}
