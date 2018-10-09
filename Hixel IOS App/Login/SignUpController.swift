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
        
        // If the user misses a field , then an alert is generated tellling the user about it.
        if(firstName.text!.isEmpty || lastName.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty)
        {
            popAlert()
        }
        
        else
        {
        // Takes the user back to the login view.
       performSegue(withIdentifier: "signup_login", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
    }
    
    // Takes the user back to the login page, after the Sign Up process is completed.
    @IBAction func back_tologin(_ sender: Any) {
        performSegue(withIdentifier: "signup_login", sender: self)

    }
    // Takes the user to the Login Page.
    @IBAction func back_button(_ sender: Any) {
        performSegue(withIdentifier: "signup_login", sender: self)
        
    }
    
    // Displays an alert to the screen when user misses a credentials on Sign Up.
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please Fill all the credentials", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SignUpController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
