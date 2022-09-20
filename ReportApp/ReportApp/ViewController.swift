//
//  ViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 15/09/2022.
//

import UIKit

class ViewController: UIViewController {
   
    private var background : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
     
        return imageView
    }()
    
    private var logo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoApp")
        imageView.contentMode = .scaleAspectFit
        imageView.transform = imageView.transform.rotated(by: (.pi * 0.025))
        return imageView
    }()
    
    private var textViewCopyRight : UITextView = {
        let textView = UITextView()
        textView.text = "Copyright ©2022 Longnct - ZingMP3\n All right reserved"
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: logo, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1/2, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 2/3, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        

        
   

        
      
        
    }
    


}

