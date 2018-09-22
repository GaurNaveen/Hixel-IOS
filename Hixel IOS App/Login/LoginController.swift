//
//  LoginController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: Setting up Delegates
        username.delegate = self
        password.delegate = self
        
      
    }
    
    @IBAction func loginButton(_ sender: Any) {
    performSegue(withIdentifier: "login_MainView", sender: self)
    }
    
    @IBAction func newAccount(_ sender: Any) {
        performSegue(withIdentifier: "login_signUP", sender: self)
    }
    
    @IBAction func forgot_password(_ sender: Any) {
        
        performSegue(withIdentifier: "login_forgotPassword", sender: self)
    }
    
}

extension LoginController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
