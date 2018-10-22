//
//  NewPasswordViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController,UITextFieldDelegate {

    
    /// Action button that sends your newly added password back to server
    /// so that you can use it.
    ///
    /// - Parameter sender: System Defined Params.
    @IBAction func submit(_ sender: Any) {
        
        
        let _ =   Client().request(.resetPassword(email: email1, code: code, password: newPassword.text!)).subscribe{
            resut in
            
            switch resut{
                
            case .success(let response):
                if(response.statusCode == 200)
                {
                    print("Almost done")
                    // move to login
                    self.performSegue(withIdentifier: "login_here", sender: self)
                }
                else{
                    print("Not Done1")
                }
                break
                
            default: print("Not Done")
            }
        }
        
        
        
    }
    
    @IBOutlet weak var newPassword: UITextField!
    
    
    /// sets the delegate for text field.
    override func viewDidLoad() {
        super.viewDidLoad()
        newPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK - extension so that the text field returns user data
extension NewPasswordViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
