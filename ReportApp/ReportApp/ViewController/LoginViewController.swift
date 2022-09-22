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
    }
    
    override func viewDidLayoutSubviews() {
        if (isInitial){
            loginView.initialLoginBox(view: view)
            isInitial = false
        }
    }
    
    
    
    func btnLoginTapped(sender: UIButton) {
        let button: UIButton = sender
        if (button.tag == 1){
            let email = loginView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = loginView.passTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password){
                (result,error) in
                
                if error != nil{
                    print(error!.localizedDescription)
                }
                else {
                    
                    let homeViewController = HomeViewController()
                    self.present(homeViewController, animated: true, completion: nil)
                }
                
                let homeViewController = HomeViewController()
                let nav = UINavigationController(rootViewController: homeViewController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                
            }
        }
    }
    
    
}

