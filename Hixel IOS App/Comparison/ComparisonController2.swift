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
    
    @IBOutlet weak var collectionView3: UICollectionView!
    // Arrays that holds the Financial Indicators values
    var financialIndicatorsValue = [4,3,2]
    var financialIndicators = ["Financial Indicators","Health","Performance","Strength","Risk","Return"]
    
    // All Horizontal line
    @IBOutlet weak var H_Bar3: UIView!
    @IBOutlet weak var H_Bar4: UIView!
    @IBOutlet weak var H_Bar2: UIView!
    
    @IBAction func info(_ sender: Any) {
        performSegue(withIdentifier: "comparison_info", sender: self)
    }
    
    
    @IBOutlet weak var HBar3: UILabel!

    // All Bars
    @IBOutlet weak var bar1: UIView!
    @IBOutlet weak var bar2: UIView!
    @IBOutlet weak var bar3: UIView!
    
    // MARK: All Graph labels
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    
    
    @IBOutlet weak var graphContainerView: UIView!
    
    @IBOutlet weak var graphHeaderView: UIView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    // Contains all the companies user have selected
    var Aselected: [TempCompany] = []
    let shapeLayer = CAShapeLayer()
    
    @IBOutlet weak var horizontalLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphHeaderView.dropShadow()
        graphContainerView.dropShadow()
        graphContainerView.layer.borderColor = UIColor.black.cgColor
        graphContainerView.layer.borderWidth = 0.4
        
        setGraphLabels()
       bar1.backgroundColor =  cherryPickColour(value: financialIndicatorsValue[0])
       bar2.backgroundColor =  cherryPickColour(value: financialIndicatorsValue[1])
       bar3.backgroundColor =  cherryPickColour(value: financialIndicatorsValue[2])

        // intital constraints on the bar graphs
        // Auto Layout for Bar 1
        bar1.translatesAutoresizingMaskIntoConstraints = false
        bar1.topAnchor.constraint(equalTo: H_Bar4.bottomAnchor, constant: 0).isActive = true
        bar1.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: 0).isActive = true
        bar1.leftAnchor.constraint(equalTo: graphContainerView.rightAnchor, constant: 63).isActive = true
        bar1.rightAnchor.constraint(equalTo: graphContainerView.leftAnchor, constant: 95).isActive = true
        bar1.heightAnchor.constraint(equalToConstant: 120).isActive = true
        bar1.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Auto Layout for Bar 2
        bar2.isHidden = false
        bar2.translatesAutoresizingMaskIntoConstraints = false
        bar2.topAnchor.constraint(equalTo: H_Bar3.bottomAnchor, constant: 0).isActive = true
        bar2.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: 0).isActive = true
        bar2.leftAnchor.constraint(equalTo: graphContainerView.rightAnchor, constant: 63).isActive = true
        bar2.rightAnchor.constraint(equalTo: graphContainerView.leftAnchor, constant: 200).isActive = true
        bar2.heightAnchor.constraint(equalToConstant: 120).isActive = true
        bar2.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Auto Layout for Bar 3
        bar3.isHidden = false
        bar3.translatesAutoresizingMaskIntoConstraints = false
        bar3.topAnchor.constraint(equalTo: H_Bar2.bottomAnchor, constant: 0).isActive = true
        bar3.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: 0).isActive = true
        bar3.leftAnchor.constraint(equalTo: graphContainerView.rightAnchor, constant: 63).isActive = true
        bar3.rightAnchor.constraint(equalTo: graphContainerView.leftAnchor, constant: 305).isActive = true
        bar3.heightAnchor.constraint(equalToConstant: 120).isActive = true
        bar3.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setGraphLabels()
    {
        label1.text = Aselected[0].name
        label2.text = Aselected[1].name
        label3.text = Aselected[2].name

    }
    
    func cherryPickColour(value: Int) -> UIColor
    {
        if (value > 3)
        {
            return UIColor.init(netHex: 0x60CBB2)
        }
        
        else if (value == 3)
        {
            return UIColor.init(netHex: 0xFADD8A)
            
        }
            
        else{
            return UIColor.init(netHex: 0xED6985)

            
        }
    }
    
    // Dismiss the Comparison view when the back button is pressed.
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionView3)
        {
            return financialIndicators.count
        }
        
        return Aselected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var scoreNumber = [70, 50, 20]
        // Inside this if statement setup the score chart
        if collectionView == self.collectionViewB {
            let temp_Company = Aselected[indexPath.row]
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "score", for: indexPath) as! ScoreCollectionViewCell
            cellB.setupCompaniesName(companies: temp_Company, score: scoreNumber[indexPath.row])
            cellB.layer.borderColor = UIColor.black.cgColor
            cellB.layer.borderWidth = 0.5
            cellB.layer.cornerRadius = 10.0
            
            // Add the Score chart
            
            
            return cellB
        }
        
        if collectionView == self.collectionView3{
            
            let indicator = financialIndicators[indexPath.row]
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "indicators", for: indexPath) as! CollectionViewCell3
                cell3.layer.cornerRadius = 12.0
                cell3.setIndicatorsLabel(indicator: indicator)

                return cell3
            
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComparisonCell", for: indexPath) as! ComparisonCollectionViewCell
        
        cell.company_name.text = Aselected[indexPath.row].name
        cell.layer.cornerRadius = 10.0
        // The color of the cell should depend upon the
        //cell.backgroundColor = UIColor.init(netHex: 0x)
       // print(Aselected.count)
        return cell
    
    }
    
    var selectedIndexPath: IndexPath?
    var previoud:IndexPath?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.collectionView3) {
           collectionView3.cellForItem(at: indexPath)?.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
            
            //  MARK: This allows you to access cell elements
            let cell =  collectionView.cellForItem(at: indexPath) as! CollectionViewCell3
           // cell.label.textColor = .white
            
            if(selectedIndexPath != nil)
            {
                collectionView3.cellForItem(at: selectedIndexPath!)?.backgroundColor = UIColor.white
                
               // cell.label.textColor = .black

            }
            selectedIndexPath = indexPath

            
        }
    }
    
 

}
