//
//  ForgotPasswordViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//

import UIKit
import SVProgressHUD
var email1 = ""
class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        email.delegate = self
    }
    
    
    /// Action button used to dismmis the current view.
    ///
    /// - Parameter sender: System Defined
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    /// Action function for the Submit button. Takes the email from the user
    /// and sends to the server , which then sends the recovery code to the email.
    ///
    /// - Parameter sender: System Defined Params
    @IBAction func submit_button(_ sender: Any) {
        // If the email field is empty, display an alert on the screen.
        if(email.text!.isEmpty)
        {
            emptyEmailAlert()
        }
        
        else {
            SVProgressHUD.show(withStatus: "Loading")
        email1 = email.text!
        let _ = Client().request(.resetEmail(email: email.text!)).subscribe{
            result in
            
            switch result{
            case .success:
                SVProgressHUD.dismiss()
                 self.performSegue(withIdentifier: "enter_code", sender: self)
            case .error:
                SVProgressHUD.dismiss()
                self.errorAlert()
                break
                
            }
           
            }
        }
    }
    
    /// Function that displays an alert on the screen telling user that he left the Email field empty.
    func emptyEmailAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please enter your Email Address", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Couldn't connect to the server", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

// MARK: - Sets up the table view
extension ForgotPasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
