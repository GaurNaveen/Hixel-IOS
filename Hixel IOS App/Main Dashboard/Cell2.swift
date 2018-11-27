//
//  Cell2.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 8/9/18.
//

import UIKit

class Cell2: UITableViewCell {
    @IBOutlet weak var port: UILabel!
    @IBOutlet weak var cont: UIView!
    @IBOutlet weak var cellView: UIView!
    
    
    /// Function to set up the Label for the cell.
    func setupLabel()
    {
        port.text = "Graph will be added here"
        
    }
    
    /// Function that adds a shadow affect to the cell's view
    func setupCell()
    {
        cont.dropShadow()
    }

}
