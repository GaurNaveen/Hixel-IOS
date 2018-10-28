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
        SVProgressHUD.show(withStatus: "Loading")
        let _ = Client().request(.changePassword(oldPassword: currentPassword.text!, newPassword: newPassword.text!)).subscribe{
            event in
            switch event{
            case .success(let reponse):
                print("Success")
                SVProgressHUD.dismiss()
                self.dismiss(animated: true)
                break
            case .error(let error):
                SVProgressHUD.dismiss()
                print("Failure")
                self.dismiss(animated: true)
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

}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
