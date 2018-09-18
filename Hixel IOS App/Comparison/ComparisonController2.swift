//
//  ComparisonController2.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 18/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class ComparisonController2: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    //var selectedCompanies = ["Apple Inc","Samsung Corp","Alphabet","Bmw","Facebook"]

    @IBOutlet weak var collectionViewB: UICollectionView!
    // Contains all the companies user have selected
    var Aselected: [TempCompany] = []
    let shapeLayer = CAShapeLayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    // Dismiss the Comparison view when the back button is pressed.
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Aselected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Inside this if statement setup the score chart
        if collectionView == self.collectionViewB {
            let temp_Company = Aselected[indexPath.row]
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "score", for: indexPath) as! ScoreCollectionViewCell
            cellB.setupCompaniesName(companies: temp_Company)
            cellB.layer.borderColor = UIColor.black.cgColor
            cellB.layer.borderWidth = 0.4
            cellB.layer.cornerRadius = 10.0
            
            // Add the Score chart
            
            
            return cellB
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComparisonCell", for: indexPath) as! ComparisonCollectionViewCell
        
        cell.company_name.text = Aselected[indexPath.row].name
        cell.layer.cornerRadius = 10.0
        // The color of the cell should depend upon the
        //cell.backgroundColor = UIColor.init(netHex: 0x)
       // print(Aselected.count)
        return cell
    
    }
 

}
