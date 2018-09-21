//
//  ForgotPasswordViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        email.delegate = self
        
    }
    
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func submit_button(_ sender: Any) {
        
    }
    
    
   

}
extension ForgotPasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
