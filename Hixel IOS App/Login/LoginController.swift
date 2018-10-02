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
        let provider = MoyaProvider<ServerInterface>()
        let body = LoginData(email: username.text ?? "", password: password.text ?? "")
        
        provider.request(.login(loginData: body)) { result in
            switch result {
            case let .success(response):
                if (response.statusCode == 200) {
                    self.performSegue(withIdentifier: "login_MainView", sender: self)
                }
                else if (response.statusCode == 401) {
                    print("Incorrect username or password.")//TODO: Display user-facing message
                }
            case let .failure(error):
                print("Network error: \(error)" ) //TODO: Display user-facing message
            }
        }
    }
    
    @IBAction func newAccount(_ sender: Any) {
        performSegue(withIdentifier: "login_signUP", sender: self)
    }
    
    @IBAction func forgot_password(_ sender: Any) {
        
        performSegue(withIdentifier: "login_forgotPassword", sender: self)
    }
    
}

extension LoginController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
