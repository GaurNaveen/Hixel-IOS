//
//  SignUpController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import SVProgressHUD
class SignUpController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    /// Action Button that comes in play when user presses the submit button.
    ///
    /// - Parameter sender: System Defined Param
    @IBAction func signUp(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Signing UP!")
        // If the user misses a field , then an alert is generated tellling the user about it.
        if(firstName.text!.isEmpty || lastName.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty)
        {
            popAlert()
        }
            
        else
        {   
            let _ = Client().request(.signup(applicationUser: ApplicationUser(firstName: firstName.text!, lastName: lastName.text!, email: email.text!, password: password.text!))).subscribe{
                result in
                
                switch result{
                case .success(let response):
                    if(response.statusCode == 200)
                    {
                        // sign up was succesull
                        SVProgressHUD.dismiss()
                        // Takes the user back to the login view.
                        self.performSegue(withIdentifier: "onboarding", sender: self)
                        
                    }
                    else if(response.statusCode == 409){
                        SVProgressHUD.dismiss()
                        print("Email Is Already in use")
                        
                    }
                    else if(response.statusCode == 500)
                    {
                        SVProgressHUD.dismiss()
                        print("Invalid Input")
                    }
                    
                    
                case .error(let error):
                    SVProgressHUD.dismiss()
                    print(error)
                    break
                    
                default: print("A null error code")
                SVProgressHUD.dismiss()
                    break
                }
                
                
            }
            
        }
        
    }
    
    /// Function is used to set delegates for the text fields.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
    }
    
    /// Action Button takes the user back to the login page, after the Sign Up process is completed.
    @IBAction func back_tologin(_ sender: Any) {
        performSegue(withIdentifier: "signup_login", sender: self)
        
    }
    // Action Button takes the user to the Login Page.
    @IBAction func back_button(_ sender: Any) {
        performSegue(withIdentifier: "signup_login", sender: self)
        
    }
    
    // Action Button displays an alert to the screen when user misses a credentials on Sign Up.
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please Fill all the credentials", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Sets up the text view
extension SignUpController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
