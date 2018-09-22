//
//  SignUpController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
       performSegue(withIdentifier: "signup_login", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
    }
    
    
    @IBAction func back_tologin(_ sender: Any) {
        performSegue(withIdentifier: "signup_login", sender: self)

    }
    
    @IBAction func back_button(_ sender: Any) {
        performSegue(withIdentifier: "signup_login", sender: self)
        
    }
    
}

extension SignUpController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
