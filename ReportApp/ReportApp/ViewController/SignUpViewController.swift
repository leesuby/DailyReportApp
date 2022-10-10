//
//  SignUpViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 05/10/2022.
//

import UIKit

class SignUpViewController: UIViewController,SignUpViewDelegate {
    
    private var isInitial : Bool = true
    private var signUpView = SignUpView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.initialFirstLook(view: view)
        signUpView.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.keyboardMoveView()
    }
    
    override func viewDidLayoutSubviews() {
        if (isInitial){
            signUpView.initialLoginBox(view: view)
            isInitial = false
            
        }
    }
    
    func btnSignupTapped() {
        let email = signUpView.emailTextField.text!
        let pass = signUpView.passTextField.text!
        let confirmPass = signUpView.confirmPassTextField.text!
        
        if(checkRequirement(email: email, pass: pass, confirmPass: confirmPass)){
            
            let user = User(email: email.localizedLowercase, password: pass)
            Remote.remoteFirebase.createUser(user: user, name: email.localizedLowercase.components(separatedBy: "@")[0])
            
            //Successfully
            Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Create account successfully!!!") { action in
                let vc = ViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                
                //                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pass) { result, error in
                //                    //Register fail
                //                    guard error == nil else{
                //                        Helper.createAlertOneOption(viewController: self, title: "Notification", messages: error!.localizedDescription, completion: nil)
                //                        return
                //                    }
                //
                
                //                    }
                
                
            }
            
            
        }}
    
    //Check correct of pass and email
    func checkRequirement(email: String, pass: String, confirmPass: String) -> Bool{
        
        //Check if mail contains @vng.com.vn
        if (!email.contains("@vng.com.vn")){
            Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Please check again your email. Must be follow format @vng.com.vn!!!", completion: nil)
            return false
        }
        
        //Check if password less than 6 characters
        if(pass.count < 6){
            Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Your password need to have at least 6 characters!!!", completion: nil)
            return false
        }
        
        //Check if confirm pass is the same with pass
        if (!pass.elementsEqual(confirmPass)){
            Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Please check again your Password and Confirm Password!!!", completion: nil)
            return false
        }
        
        return true
    }
    
    
    func btnLoginTapped() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
