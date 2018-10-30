//
//  ChangePasswordViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 29/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import SVProgressHUD
class ChangePasswordViewController: UIViewController {
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var retypeNewPass: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPassword.delegate = self
        newPassword.delegate = self
        retypeNewPass.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        if(currentPassword.text!.isEmpty || newPassword.text!.isEmpty || retypeNewPass.text!.isEmpty)
        {
            popAlert()
        }
        
        else {
        SVProgressHUD.show(withStatus: "Loading")
        let _ = Client().request(.changePassword(oldPassword: currentPassword.text!, newPassword: newPassword.text!)).subscribe{
            event in
            switch event{
            case .success(let response):
                
               // print(response.statusCode)
                if(response.statusCode == 200)
                {
                    SVProgressHUD.dismiss()
                    self.donePopAlert()
                    self.dismiss(animated: true)
                }
                
                else if(response.statusCode == 401)
                {
                    SVProgressHUD.dismiss()
                    self.errorPopAlert()
                    self.dismiss(animated: true)

                }
                
                else{
                    self.dismiss(animated: true)

                }
                break
            case .error(let _):
                SVProgressHUD.dismiss()
                print("Failure")
                self.dismiss(animated: true)
                }
            
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please fill the empty text field", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func donePopAlert()
    {
        let alert = UIAlertController(title: " Success! ", message: "Your Password has been changed successfully", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorPopAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Your Password was not changed", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
