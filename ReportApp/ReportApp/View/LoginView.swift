//
//  Login.swift
//  ReportApp
//
//  Created by LAP15335 on 22/09/2022.
//

import Foundation
import UIKit

protocol LoginViewDelegate{
    func btnLoginTapped(sender: UIButton)
}


class LoginView{
    
    var delegate : LoginViewDelegate?
    
    var background : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
   var logo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoApp")
        imageView.contentMode = .scaleAspectFit
        imageView.transform = imageView.transform.rotated(by: (.pi * 0.025))
        return imageView
    }()
    
    var copyrightTextView : UITextView = {
        let textView = UITextView()
        textView.contentMode = .center
        textView.text = "Copyright ©2022 Longnct - ZingMP3\n All right reserved"
        textView.font = .latoRegular(size: 14)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.alpha = 0.4
        return textView
    }()
    
    var loginBox : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var textViewLoginBox: UITextView = {
        let textView = UITextView()
        textView.contentMode = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = "Login"
        textView.textColor = .white
        textView.font = .latoBlack(size: 30)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        return textView
    }()
    
    var emailTextField : CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0),text: "Email",imageName: "MailSymbol")
        
        textField.font = .latoLight(size: 16)
        
        return textField
    }()
    
    var passTextField : CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0),text: "Password",imageName: "KeySymbol")
        
        textField.font = .latoLight(size: 16)
        
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var loginButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Login", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .latoBold(size: 16)
        button.layer.cornerRadius = 16
        button.backgroundColor = .deepPurple
        
        return button
    }()
    
    @objc func loginTapped(sender : UIButton!){
        delegate?.btnLoginTapped(sender: sender)
    }
    
    var forgotTextView : UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textColor = .darkPurple
        textView.textAlignment = .right
        
        textView.backgroundColor = .clear
        textView.text = "Forgot password?"
        
        textView.font = UIFont.latoRegular(size: 17)
        
        
        return textView
    }()
    
    
    func initialFirstLook(view : UIView){
        //Set Background
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        
        //Set Logo
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: logo, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1/2, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/3, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        
        //Set Copyright
        view.addSubview(copyrightTextView)
        copyrightTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: copyrightTextView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: copyrightTextView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: copyrightTextView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: copyrightTextView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0).isActive = true
        
        NSLayoutConstraint(item: copyrightTextView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        
        //Set Login container
        view.addSubview(loginBox)
        
        loginBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: loginBox, attribute: .top, relatedBy: .equal, toItem: logo, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: loginBox, attribute: .bottom, relatedBy: .equal, toItem: copyrightTextView, attribute: .top, multiplier: 1.0, constant: -25).isActive = true
        NSLayoutConstraint(item: loginBox, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading , multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: loginBox, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -40).isActive = true
        
    }
    
    func initialLoginBox(view : UIView){
        //Draw shadow for login container
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: loginBox.frame.width - 3, height: loginBox.frame.height - 30), cornerRadius: 30).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 2
        
        loginBox.layer.addSublayer(shadowLayer)
        loginBox.layer.cornerRadius = 40
        loginBox.clipsToBounds = true
        
        //Draw Elipse
        let ellipsePath = UIBezierPath(ovalIn: CGRect(x: -((view.frame.width - loginBox.frame.width) / 2 ), y: -(loginBox.frame.height / 4), width: view.frame.width - 10, height: loginBox.frame.height / 2.2))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = UIColor.darkPurple80a.cgColor
        shapeLayer.shadowPath = shapeLayer.path
        shapeLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowRadius = 3
        shapeLayer.opacity = 0.8
        
        loginBox.layer.addSublayer(shapeLayer)
        
        
        loginBox.addSubview(textViewLoginBox)
        textViewLoginBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: textViewLoginBox, attribute: .top, relatedBy: .equal, toItem: loginBox, attribute: .top, multiplier: 1.0, constant: loginBox.frame.height / 26).isActive = true
        NSLayoutConstraint(item: textViewLoginBox, attribute: .leading, relatedBy: .equal, toItem: loginBox, attribute: .leading , multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textViewLoginBox, attribute: .trailing, relatedBy: .equal, toItem: loginBox, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textViewLoginBox, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/6, constant: 0).isActive = true
        
        NSLayoutConstraint(item: textViewLoginBox, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        
        
        loginBox.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: emailTextField, attribute: .centerX, relatedBy: .equal, toItem: loginBox, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .centerY, relatedBy: .equal, toItem: loginBox, attribute: .centerY, multiplier: 1.0, constant: -loginBox.frame.height / 9).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 7/8, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/8, constant: 0).isActive = true
        
        
        loginBox.addSubview(passTextField)
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: passTextField, attribute: .centerX, relatedBy: .equal, toItem: loginBox, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .centerY, relatedBy: .equal, toItem: loginBox, attribute: .centerY, multiplier: 1.0, constant: loginBox.frame.height / 10).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 7/8, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/8, constant: 0).isActive = true
        
        
        
        
        
        
        loginBox.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: loginBox, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .centerY, relatedBy: .equal, toItem: loginBox, attribute: .centerY, multiplier: 2.0, constant: -30).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 1/4, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/10, constant: 0).isActive = true
        
        //Action
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.tag = 1
        
        
        loginBox.addSubview(forgotTextView)
        forgotTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: forgotTextView, attribute: .trailing, relatedBy: .equal, toItem: passTextField, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: forgotTextView, attribute: .bottom, relatedBy: .equal, toItem: loginButton, attribute: .top, multiplier: 1.0, constant: -10).isActive = true
        
        
        NSLayoutConstraint(item: forgotTextView, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 1/2, constant: 0).isActive = true
        
        NSLayoutConstraint(item: forgotTextView, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/10, constant: 0).isActive = true
        
    }
}
