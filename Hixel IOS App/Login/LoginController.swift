//
//  LoginController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 21/9/18.
//

import Foundation
import UIKit
import Moya
import SVProgressHUD

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var companies1 = [Company]()
    let companiesTicker = ["aapl","msft","tsla"]
    var string = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let joinedStrings = companiesTicker.joined(separator: ",")
        // Do any additional setup after loading the view.
        string = joinedStrings
        print(string)
        // MARK: Setting up Delegates
        username.delegate = self
        password.delegate = self
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        // If the username and password are empty , raise an alert telling the user about it.
        if(username.text!.isEmpty || password.text!.isEmpty)
        {
            popAlert()
           //self.performSegue(withIdentifier: "login_MainView", sender: self)
            
        }
        
            
        else
        {
            
        SVProgressHUD.show(withStatus: "Signing in")
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            
        let body = LoginData(email: username.text ?? "", password: password.text ?? "")
        
        let _ = Client().request(.login(loginData: body)).subscribe { result in
            switch result {
            case .success(let response):
                if (response.statusCode == 200) {
                    
                    SVProgressHUD.setStatus("Loading Portfolio")
                    //SVProgressHUD.dismiss()
                    
                    let authToken = response.response?.allHeaderFields["Authorization"]as? String
                    let refreshToken = response.response?.allHeaderFields["Refresh"]as? String
                    
                    let newCredentials = Credentials(authToken: authToken ?? "", refreshToken: refreshToken ?? "")
                    
                    Credentials.setCredentials(newCredentials: newCredentials)
                    
                    
                    // Load data here
                    self.loadDataFromServer()
                   // self.performSegue(withIdentifier: "login_MainView", sender: self)
                }
                else if (response.statusCode == 401) {
                    SVProgressHUD.dismiss()
                    self.incorrectDetailsAlert()
                    print("Incorrect username or password.")//TODO: Display user-facing message
                }
                
            case .error(let error):
                SVProgressHUD.dismiss()
                self.serverErrorAlert()
                print("Network error: \(error)" ) //TODO: Display user-facing message
            }
        }
    }
    }
    
    // Takes the user to the Sign Up View
    @IBAction func newAccount(_ sender: Any) {
        performSegue(withIdentifier: "login_signUP", sender: self)
    }
    
    // Takes the user to the Forgot Password View
    @IBAction func forgot_password(_ sender: Any) {
        
        performSegue(withIdentifier: "login_forgotPassword", sender: self)
    }
    
    // Displays an alert on the screen when username or password are missing.
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please enter your Username or Password", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Displays an Alert when the App cannot connect to the Server.
    func serverErrorAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Could not connect to the Server. Please try again!", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func incorrectDetailsAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Username or Password incorrect", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // This function is used to load the data from the server. After the data is loaded is takes the
    // user to the Portfolio.
    func loadDataFromServer()
    {
       
       let _ = Client().request(.companydata(tickers: string, years: 1)).subscribe{ event in
            switch event {
            case .success(let response):
                // Dismiss the Progress bar.
                SVProgressHUD.dismiss()
               
                print("hello")
                
                // let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                //print(json)
                let company = try! JSONDecoder().decode([Company].self, from: response.data)
                self.companies1 = company
                //self.companies1[0].identifiers.name
                
                // Go to the Main Dashboard

                self.performSegue(withIdentifier: "login_MainView", sender: self)

               // print(self.companies1)
                break
           
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    // MARK: Pass the loaded data to the Portfolio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* This won't work as the segue is connected to a UITabbarController, we need to cast it to
         * UITabbarController and get the View Controller object.
        let vc = segue.destination as! PortfolioController
        vc.portfolioCompanies = companies1
        */
        let tabCtrl: UITabBarController = segue.destination as! UITabBarController
        let destinationVC = tabCtrl.viewControllers![0] as! PortfolioController // [0] because Portfolio is the first tab in the tab bar controller.
        destinationVC.portfolioCompanies = companies1
    }
}

extension LoginController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
