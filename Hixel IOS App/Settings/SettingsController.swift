//
//  SettingsController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UIViewController{
    
    // Should take the user back to the Login View
    @IBAction func logout(_ sender: Any) {
       // performSegue(withIdentifier: "logout", sender: self)
        performSegue(withIdentifier: "testsegue", sender: self)

    }
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        headerLabel.text = "Hi, John Smith"
    }
}
