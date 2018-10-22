//
//  ScoreCollectionViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 18/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
   // @IBOutlet weak var hey: UILabel!
    @IBOutlet weak var hey: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    let shapeLayer = CAShapeLayer()
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var score_container: UIView!
    
    /// Function sets up the score chart.
    ///
    /// - Parameters:
    ///   - companies: Pass the selected companies in here
    ///   - score: Pass their Scores
    func setupCompaniesName( companies: inout Company,score : Int)
    {
        companyName.text = companies.identifiers.name
        let score = companies.calculateScore()
        
        let center = score_container.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 88, startAngle: -CGFloat.pi / 2, endAngle: 2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.init(netHex: 0x3C4F7B).cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        chooseColor(score: score)
        shapeLayer.lineWidth = 5
        shapeLayer.strokeEnd = 0
        
        score_container.layer.addSublayer(shapeLayer)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.centerXAnchor.constraint(equalTo: score_container.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: score_container.centerYAnchor).isActive = true
        scoreLabel.text = "\(score)%"
        score_container.addSubview(scoreLabel)
        
        /// This "hey" will be changed to a more correct name soon.
        hey.translatesAutoresizingMaskIntoConstraints = false
        hey.topAnchor.constraint(equalTo: score_container.topAnchor, constant: 55).isActive = true
        hey.bottomAnchor.constraint(equalTo: score_container.bottomAnchor, constant: 20).isActive = true
        hey.leftAnchor.constraint(equalTo: score_container.leftAnchor, constant: 69).isActive = true
        hey.rightAnchor.constraint(equalTo: score_container.rightAnchor, constant: 40).isActive = true
        hey.heightAnchor.constraint(equalToConstant: 21)
        hey.widthAnchor.constraint(equalToConstant: 31)
        hey.textColor = .white
        hey.text = "Score"
        score_container.addSubview(hey)
        handleTap(score: score)
        
    }
    
    /// Function adds the animation effects on the Score Chart.
    ///
    /// - Parameter score: Pass in the Score value
    @objc private func handleTap(score: Int)
    {
        print("Attepmting to animate strokee")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        if(score > 65)
        {
            basicAnimation.toValue = 0.5
        }
        
        else if(score < 50)
        {
            basicAnimation.toValue = 0.2

        }
        else if (score == 50){
            basicAnimation.toValue = 0.4  // This will be helpfull to control the outer layer , 1 means full , 0.5 means half. adjust accordingly
            
        }
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation,forKey: "ursoBasic")
    }
    
    /// Function assits the system to choose a color
    /// for the score chart depending upon the score values.
    ///
    /// - Parameter score: Pass the score value.
    func chooseColor(score: Int)
    {
        if(score < 50)
        {
            shapeLayer.strokeColor = UIColor.red.cgColor
            return
        }
        else if (score == 50)
        {
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            return
        }
        
        shapeLayer.strokeColor = UIColor.green.cgColor

    }
}
