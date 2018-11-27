//
//  SettingsController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//

import Foundation
import UIKit

class SettingsController: UIViewController{
    
    // Should take the user back to the Login View
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func nameChange(_ sender: Any) {
        firstName.isUserInteractionEnabled = true
        
    }
    @IBAction func lastNameChange(_ sender: Any) {
        lastName.isUserInteractionEnabled = true
    }
    
    //--- Implement the Change Password APi endpoint
    @IBAction func passwordChange(_ sender: Any) {
        performSegue(withIdentifier: "changePassword", sender: self)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        performSegue(withIdentifier: "logout", sender: self)
        //performSegue(withIdentifier: "testsegue", sender: self)
    }
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        firstName.isUserInteractionEnabled = false
        lastName.isUserInteractionEnabled = false
        password.isUserInteractionEnabled = false
        firstName.text =  userData[0].firstName
        lastName.text = userData[0].lastName
        headerLabel.text = "Hi, "+firstName.text!+" "+lastName.text!
       
    }
}
