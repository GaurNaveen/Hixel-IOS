//
//  ViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 6/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

// Global Declration of Arrays that temporarily holds the Company Names and their respective stock exchange
var compName = ["Apple Inc.","Samsung","Alphabet Inc. ","Facebook Inc.","Google Inc.","IBM Inc.","Daimler AMG","Amazon Inc.","BMW"]
var stockExchange = ["NYSE","NASDAQ","NYSE","NYSE","NASDAQ","NYSE","NASDAQ","NYSE","NASDAQ"]

// Array that will hold all the HardCoded Strings that the App will use throughout all of the views
var hardCodedStrings = ["Portfolio"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Creates a UIView that will consist of a Label to display the header.
    func setupTheHeader(){
        // Create the Label
        let headerView = UIView(frame:CGRect(x: 0, y: 28, width: 420, height: 51))
        
        // Change the UIView Color using the extension for UIColor
        headerView.backgroundColor = UIColor.init(netHex: 0x395A97)
        
        // Add it to the Main View
        self.view.addSubview(headerView)
        
        // Create the Label and add it to the header view
        headerView.addSubview(setupLabelForHeaderView())
        
    }
    
    // This Function creates a Label that is wrapped inside the HEADER VIEW
    func setupLabelForHeaderView() -> UILabel
    {
        // Instantiate the Label
        let label = UILabel(frame: CGRect(x: 135, y: 5, width: 207, height: 45))
        
        // Set the Color of Label Text to White
        label.textColor = .white
        
        // Add text to the Label
        label.text = hardCodedStrings[0]
        
        // Change the font size of the Label
        label.font = label.font.withSize(32)
        
        // Return the Created Label
        return label
    }
    
    
    
    
}


// To get Custom Colors or To convert HEX code into RGBA
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
// Acts as a resuable component. Allows us to add shadow  effect to any UIView by just calling this.
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}





