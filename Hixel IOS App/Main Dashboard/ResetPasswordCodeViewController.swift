//
//  ResetPasswordCodeViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class ResetPasswordCodeViewController: UIViewController,UITextFieldDelegate {
    @IBAction func submit(_ sender: Any) {
        
        let _ = Client().request(.resetCode(email: email1, code: resetCode.text!)).subscribe{
            result in
            
            switch result {
            case .success(let response):
                if(response.statusCode == 200)
                {
                    print("Done")
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
extension ResetPasswordCodeViewController{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
