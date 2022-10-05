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
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pass) { result, error in
                guard error == nil else{
                    let alert = UIAlertController(title: "Notification", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                let alert = UIAlertController(title: "Notification", message: "Create account successfully!!!", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { action in
                    let vc = ViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func checkRequirement(email: String, pass: String, confirmPass: String) -> Bool{
        if (!email.contains("@vng.com.vn")){
            let alert = UIAlertController(title: "Notification", message: "Please check again your email. Must be follow format @vng.com.vn!!!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if(pass.count < 6){
            let alert = UIAlertController(title: "Notification", message: "Your password need to have at least 6 characters!!!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if (!pass.elementsEqual(confirmPass)){
            let alert = UIAlertController(title: "Notification", message: "Please check again your Password and Confirm Password!!!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
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
