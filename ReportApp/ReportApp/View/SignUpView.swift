//
//  SignUpView.swift
//  ReportApp
//
//  Created by LAP15335 on 05/10/2022.
//

import Foundation
import UIKit

protocol SignUpViewDelegate{
    func btnSignupTapped()
    func btnLoginTapped()
}


class SignUpView{
    
    var delegate : SignUpViewDelegate?
    
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
        textView.textColor = .gray70a
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
        textView.text = "Signup"
        textView.textColor = .white
        textView.font = .latoBlack(size: 30)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        return textView
    }()
    
    var emailTextField : CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0),text: "Email : example@vng.com.vn",imageName: "MailSymbol")
        textField.textColor = .deepPurple
        textField.font = .latoLight(size: 16)
        
        return textField
    }()
    
    var passTextField : CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0),text: "Password: At least 6 characters",imageName: "KeySymbol")
        textField.textColor = .deepPurple
        textField.font = .latoLight(size: 16)
        
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var confirmPassTextField : CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0),text: "Confirm Password",imageName: "KeySymbol")
        textField.textColor = .deepPurple
        textField.font = .latoLight(size: 16)
        
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var signUpButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Signup", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .latoBold(size: 16)
        button.layer.cornerRadius = 16
        button.backgroundColor = .deepPurple
        
        return button
    }()
    
    @objc func signUpTapped(){
        delegate?.btnSignupTapped()
    }
    
    var loginButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Already have account?", for: .normal)
        button.setTitleColor(UIColor.deepPurple, for: .normal)
        button.titleLabel?.font = .latoBold(size: 16)
        button.titleLabel?.attributedText = NSAttributedString(string: "Already have account?", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.backgroundColor = .clear
        
        return button
    }()
    
    @objc func loginTapped(){
        delegate?.btnLoginTapped()
    }
    
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
        shadowLayer.shadowOpacity = 0.2
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
        
        
        loginBox.addSubview(passTextField)
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: passTextField, attribute: .centerX, relatedBy: .equal, toItem: loginBox, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .centerY, relatedBy: .equal, toItem: loginBox, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 7/8, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/8, constant: 0).isActive = true
        
        loginBox.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: emailTextField, attribute: .bottom, relatedBy: .equal, toItem: passTextField, attribute: .top, multiplier: 1.0, constant: -20).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: passTextField, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 7/8, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/8, constant: 0).isActive = true
        
        loginBox.addSubview(confirmPassTextField)
        confirmPassTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: confirmPassTextField, attribute: .top, relatedBy: .equal, toItem: passTextField, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
        
        NSLayoutConstraint(item: confirmPassTextField, attribute: .leading, relatedBy: .equal, toItem: passTextField, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: confirmPassTextField, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 7/8, constant: 0).isActive = true
        
        NSLayoutConstraint(item: confirmPassTextField, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/8, constant: 0).isActive = true
        
  
        loginBox.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: signUpButton, attribute: .centerX, relatedBy: .equal, toItem: loginBox, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: signUpButton, attribute: .bottom, relatedBy: .equal, toItem: loginBox, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: signUpButton, attribute: .width, relatedBy: .equal, toItem: loginBox, attribute: .width, multiplier: 1/4, constant: 0).isActive = true
        NSLayoutConstraint(item: signUpButton, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/10, constant: 0).isActive = true
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        
        loginBox.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: passTextField, attribute: .leading, multiplier: 1.0, constant: 2).isActive = true
        NSLayoutConstraint(item: loginButton, attribute: .bottom, relatedBy: .equal, toItem: signUpButton, attribute: .top, multiplier: 1.0, constant: -5).isActive = true
        NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: loginBox, attribute: .height, multiplier: 1/10, constant: 0).isActive = true
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
}
