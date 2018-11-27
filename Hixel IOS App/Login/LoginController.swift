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
var userData = [ApplicationUser]()

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var move = false
    var userCompanyTicker = [String]()
    var companies1 = [Company]()
    let companiesTicker = ["aapl","tsla","msft","twtr","snap","fb","amzn","intc","amd"]
    var string = ""
    
    /// Function used to set the delegate for the text fields.
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit

        let joinedStrings = companiesTicker.joined(separator: ",")
        string = joinedStrings
        
        // MARK: Setting up Delegates
        username.delegate = self
        password.delegate = self
    }
    
    
    /// Function checks whether to display the onboarding or not.
    ///
    /// - Parameter animated: System Defiend Params.
    override func viewDidAppear(_ animated: Bool) {
        let didOnboarding = KeychainWrapper.standard.bool(forKey: "ONBOARDING_COMPLETED") ?? false

        if (didOnboarding == false)
        {
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
        if (username.text!.isEmpty || password.text!.isEmpty)
        {
            self.popAlert(title: "Invalid", message: "Username or password was incorrect.")
        }
        else
        {
            SVProgressHUD.show(withStatus: "Authenticating...")
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            
            let body = LoginData(email: username.text ?? "", password: password.text ?? "")
            
            let _ = Client().request(.login(loginData: body)).subscribe { result in
                switch result {
                case .success(let response):
                    if (response.statusCode == 200) {
                        SVProgressHUD.setStatus("Loading Dashboard...")
                        
                        let authToken = response.response?.allHeaderFields["Authorization"] as? String
                        let refreshToken = response.response?.allHeaderFields["Refresh"] as? String
                        
                        let newCredentials = Credentials(authToken: authToken ?? "", refreshToken: refreshToken ?? "")
                        
                        Credentials.setCredentials(newCredentials: newCredentials)
                        
                        // MARK: Load User Data from the server
                        self.loadUserData()
                    }
                    else if (response.statusCode == 401) {
                        SVProgressHUD.dismiss()
                        self.popAlert(title: "Invalid Details", message: "Username or password was incorrect.")
                    }
                    
                case .error(let error):
                    SVProgressHUD.dismiss()
                    self.popAlert(title: "Network Error", message: error.localizedDescription)
                }
            }
        }
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
    func popAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
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
                
                let company = try! JSONDecoder().decode([Company].self, from: response.data)
                
                self.companies1 = company
                portcomp = company

                self.performSegue(withIdentifier: "login_MainView", sender: self)
                break
                
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    /// Loads the Application User profile
    func loadUserData()
    {
        let _ =  Client().request(.userData()).subscribe{
            event in
            switch event{
                
            case .success(let response):
                let data = try! JSONDecoder().decode(ApplicationUser.self, from: response.data)
                 userData.append(data)
                
                let count = userData[0].portfolio!.companies.count
                
                if (count > 0)
                {
                    for i in 0 ... count - 1 {
                        self.userCompanyTicker.append(userData[0].portfolio!.companies[i].ticker) // put the tickers into an array
                    }
                    
                    // call the loadUser method below
                    self.loadCompaniesFromUserData(tickers: self.userCompanyTicker)
                }
                else{
                    //------ We still move to the Main Dashboard but don't actually setup the Bar Chart ------//
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "login_MainView", sender: self)
                }
                
            case .error(let error):
                SVProgressHUD.dismiss()
                print(error)
            }
        }
    }
    
    func loadCompaniesFromUserData(tickers:[String])
    {
        var tickersString = ""
        let joinedStrings = userCompanyTicker.joined(separator: ",")
        // Do any additional setup after loading the view.
        tickersString = joinedStrings
        
        let _ = Client().request(.companydata(tickers: tickersString, years: 5)).subscribe{ event in
            switch event {
            case .success(let response):
                // Dismiss the Progress bar.
                SVProgressHUD.dismiss()
                
                let company = try! JSONDecoder().decode([Company].self, from: response.data)

                self.companies1 = company
                portcomp = company
                
                // Go to the Main Dashboard
                self.performSegue(withIdentifier: "login_MainView", sender: self)
                break
                
            case .error(let error):
                SVProgressHUD.dismiss()
                print(error)
                break
            }
        }
        
        
    }
    
   
    
    /// Function used to test the search resutls.
    func search()
    {
        let _ = Client().request(.search(query: "aap")).subscribe { event in
            switch event{
            case .success(let response):
                
                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
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
        
        if (segue.identifier ==  "test")
        {
            
        }
        
        if (move == true && segue.identifier != "test")
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
