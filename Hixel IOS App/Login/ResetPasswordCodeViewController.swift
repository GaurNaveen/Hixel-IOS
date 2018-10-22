//
//  ResetPasswordCodeViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
var code = ""

class ResetPasswordCodeViewController: UIViewController,UITextFieldDelegate {
    
    /// Action button tat sends the email and the reset code to the server.
    ///
    /// - Parameter sender: System Defined params.
    @IBAction func submit(_ sender: Any) {
        code=resetCode.text!
        let _ = Client().request(.resetCode(email: email1, code: resetCode.text!)).subscribe{
            result in
            
            switch result {
            case .success(let response):
                if(response.statusCode == 200)
                {
                    print("Done")
                   self.performSegue(withIdentifier: "newPassword", sender: self)
                }
                
                else{
                    print("not done")
                }
                
                break

            default:
                print("Got Error")
            }
        }
    }
    
    @IBOutlet weak var resetCode: UITextField!
    
    
    /// Sets the delegate for the text field.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetCode.delegate = self
        
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
//Mark -: extension implemented so that the text field returns something.
extension ResetPasswordCodeViewController{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
