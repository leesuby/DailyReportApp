//
//  ViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 15/09/2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, LoginViewDelegate {
    
    private var isInitial : Bool = true
    private var loginView = LoginView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.initialFirstLook(view: view)
        loginView.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.keyboardMoveView()
    }
    
    override func viewDidLayoutSubviews() {
        if (isInitial){
            loginView.initialLoginBox(view: view)
            isInitial = false
        }
    }
    
    
    func btnLoginTapped() {
        
        let email = loginView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = loginView.passTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Remote.remoteFirebase.checkUser(user: User(email: email.localizedLowercase, password: password), name:email.localizedLowercase.components(separatedBy: "@")[0]) { result in
            switch result{
            case 0:
                Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Your account is not exists!!!", completion: nil)
            case 1:
                UserDefaults.standard.set(email.localizedLowercase.components(separatedBy: "@")[0], forKey: "user")
                UserSession.username = email.localizedLowercase.components(separatedBy: "@")[0]
                
                //Go to HomeViewController
                let homeViewController = HomeViewController()
                let nav = UINavigationController(rootViewController: homeViewController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            default:
                Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Please check again your password!!!", completion: nil)
            }
        }
        
        
        //        //Verification
        //        Auth.auth().signIn(withEmail: email, password: password){
        //            (result,error) in
        //            if error != nil{
        //                //Login fail
        //                Helper.createAlertOneOption(viewController: self, title: "Notification", messages: error!.localizedDescription, completion: nil)
        //                return
        //            }
        //            else {
        //
        //            }
        //        }
        
        
        
    }
    
    func btnSignUpTapped() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

