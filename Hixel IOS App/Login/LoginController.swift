//
//  LoginController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//

import Foundation
import UIKit
import Moya

class LoginController: UIViewController, UITextFieldDelegate {
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
        
        // If the username and password are empty , raise an alert telling the user about it.
        if(username.text!.isEmpty || password.text!.isEmpty)
        {
            //popAlert()
            self.performSegue(withIdentifier: "login_MainView", sender: self)

        }
        
            
        else
        {
        
        let body = LoginData(email: username.text ?? "", password: password.text ?? "")
        
        let _ = Client().request(.login(loginData: body)).subscribe { result in
            switch result {
            case .success(let response):
                if (response.statusCode == 200) {
                    self.performSegue(withIdentifier: "login_MainView", sender: self)
                }
                else if (response.statusCode == 401) {
                    self.serverErrorAlert()
                    print("Incorrect username or password.")//TODO: Display user-facing message
                }
            case .error(let error):
                self.serverErrorAlert()
                print("Network error: \(error)" ) //TODO: Display user-facing message
            }
        }
    }
    }
    
    // Takes the user to the Sign Up View
    @IBAction func newAccount(_ sender: Any) {
        performSegue(withIdentifier: "login_signUP", sender: self)
    }
    
    // Takes the user to the Forgot Password View
    @IBAction func forgot_password(_ sender: Any) {
        
        performSegue(withIdentifier: "login_forgotPassword", sender: self)
    }
    
    // Displays an alert on the screen when username or password are missing.
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please enter your Username or Password", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Displays an Alert when the App cannot connect to the Server.
    func serverErrorAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Could not connect to the Server. Please try again!", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension LoginController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
