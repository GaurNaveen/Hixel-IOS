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
import SwiftKeychainWrapper
var portcomp = [Company]()

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var move = false
    var companies1 = [Company]()
    let companiesTicker = ["aapl","msft","tsla","twtr","snap","fb","amzn","intc","amd"]
    var string = ""
    
    /// Function used to set the delegate for the text fields.
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: "loggedIn")

        
        
        
        let joinedStrings = companiesTicker.joined(separator: ",")
        // Do any additional setup after loading the view.
        string = joinedStrings
        print(string)
        // MARK: Setting up Delegates
        username.delegate = self
        password.delegate = self
    }
    
    
    /// Function checks whether to display the onboarding or not.
    ///
    /// - Parameter animated: System Defiend Params.
    override func viewDidAppear(_ animated: Bool) {
        let check = retrievePasswordAndUserName()
        print(check)
        if(check == false)
        {   print("Hello bruh!")
            
            // Move to the onboarding
            moveToOnboarding()
        }
    }
    
    func moveToOnboarding()
    {
        performSegue(withIdentifier: "onboarding_login1", sender: self)

        
    }
    
    /// Function executed when the user clicks the login button.
    ///
    /// - Parameter sender: System Defined Params
    @IBAction func loginButton(_ sender: Any) {
        move = true
        // If the username and password are empty , raise an alert telling the user about it.
        if(username.text!.isEmpty || password.text!.isEmpty)
        {
            popAlert()
            // self.performSegue(withIdentifier: "test", sender: self)
            
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
                        print("Killa")
                        SVProgressHUD.setStatus("Loading Portfolio")
                        //SVProgressHUD.dismiss()
                        
                        let authToken = response.response?.allHeaderFields["Authorization"]as? String
                        let refreshToken = response.response?.allHeaderFields["Refresh"]as? String
                        
                        let newCredentials = Credentials(authToken: authToken ?? "", refreshToken: refreshToken ?? "")
                        
                        Credentials.setCredentials(newCredentials: newCredentials)
                        
                        // Save user defaults
                        self.saveUserDefaults()
                        
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
    
    /// Function use to save User's email and password. Might come in use to keep the user logged in.
    func saveUserDefaults()
    {
        let saveSuccessful1 : Bool = KeychainWrapper.standard.set(password.text!, forKey: "userPassword")
        let saveSuccessful2 : Bool = KeychainWrapper.standard.set(username.text!, forKey: "userEmail")
        print("Save was Successful: \(saveSuccessful1)")
        
    }
    
    /// Function that helps us to read user defaults.
    func retrievePasswordAndUserName()
    {   let retrieveUserName : String? = KeychainWrapper.standard.string(forKey: "userEmail")
        let retrievePassword : String? = KeychainWrapper.standard.string(forKey: "userPassword")
        let retieveLoginStatus: Bool? = KeychainWrapper.standard.bool(forKey: "loggedIn")
    }
    
    /// Action Button takes the user to the Sign Up View
    @IBAction func newAccount(_ sender: Any) {
        move = false
        performSegue(withIdentifier: "login_signUP", sender: self)
    }
    
    /// Action Button takes the user to the Forgot Password View
    @IBAction func forgot_password(_ sender: Any) {
        move = false
        performSegue(withIdentifier: "login_forgotPassword", sender: self)
    }
    
    /// Function displays an alert on the screen when username or password are missing.
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please enter your Username or Password", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Function displays an Alert when the App cannot connect to the Server.
    func serverErrorAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Could not connect to the Server. Please try again!", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Function displays a pop alert if the details entred by the user are not correct.
    func incorrectDetailsAlert()
    {
        let alert = UIAlertController(title: " Error ", message: "Username or Password incorrect", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This function is used to load the data from the server. After the data is loaded is takes the user to the Portfolio.
    func loadDataFromServer()
    {
        
        let _ = Client().request(.companydata(tickers: string, years: 5)).subscribe{ event in
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
                portcomp = company
                // Go to the Main Dashboard
                
                self.performSegue(withIdentifier: "login_MainView", sender: self)
                
                // print(self.companies1)
                break
                
            case .error(let error):
                print(error)
                break
            }
        }
        
        //serach()
        
    }
    
    
    /// Function used to test the search resutls.
    func serach()
    {
        let _ = Client().request(.search(query: "aap")).subscribe { event in
            switch event{
            case .success(let response):
                print("Hurray")
                
                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                print("Sex",json)
                break
                
            case .error(let error):
                print("Yikes")
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
        
        if(segue.identifier ==  "test")
        {
            
        }
        
        if(move == true && segue.identifier  != "test")
        {
            let tabCtrl: UITabBarController = segue.destination as! UITabBarController
            let destinationVC = tabCtrl.viewControllers![0] as! PortfolioController // [0] because Portfolio is the first tab in the tab bar controller.
            destinationVC.portfolioCompanies = companies1
        }
    }
}

// MARK: - Sets up the text fields.
extension LoginController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
