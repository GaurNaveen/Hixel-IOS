//
//  Portfolio.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import UIKit
class PortfolioController: UIViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    let hardCodedStrings = ["Dashboard"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
    }
    
    // Sets up the Header View of the Portfolio/Dashboard
    private func setupHeaderView(){
        header.backgroundColor = UIColor.init(netHex: 0x395A97)
        headerLabel.text = hardCodedStrings[0]
        headerLabel.textColor = .white
        
    }



}
// MARK: Extension Methods for UIColor and UIView
// To get Custom Colors or To convert hex code into rgb
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

// To add shadow effects on views
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

