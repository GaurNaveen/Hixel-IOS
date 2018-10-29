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
        
        // Creat my track layer
        let trackLayer = CAShapeLayer()
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 35, startAngle: -CGFloat.pi / 2, endAngle: 2*CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath1.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 8
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        score_container.layer.addSublayer(trackLayer)
        
        
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 35, startAngle: -CGFloat.pi / 2, endAngle: 2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor/////UIColor.init(netHex: 0x3C4F7B).cgColor//
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        chooseColor(score: score)
        shapeLayer.lineWidth = 8
        shapeLayer.strokeEnd = 0
        
        score_container.layer.addSublayer(shapeLayer)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.centerXAnchor.constraint(equalTo: score_container.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: score_container.centerYAnchor).isActive = true
        scoreLabel.textColor = UIColor.init(netHex: 0x4153AF)
        scoreLabel.text = "\(score)"
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
        
       basicAnimation.toValue = calculateStroke(value: score)
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
//        if(score < 50)
//        {
//            shapeLayer.strokeColor = UIColor.init(netHex: 0x4153AF)//UIColor.red.cgColor
//            return
//        }
//        else if (score == 50)
//        {
//            shapeLayer.strokeColor = //UIColor.yellow.cgColor
//            return
//        }
//
//        shapeLayer.strokeColor = UIColor.green.cgColor
//
//    }
        
        shapeLayer.strokeColor = UIColor.init(netHex: 0x4153AF).cgColor
}
    func calculateStroke(value:Int) -> Double
    {
        if(value>=80)
        {
            //shapeLayer.strokeColor = UIColor.init(netHex: 0x1DCEB1).cgColor
            return 0.65
        }
            
        else if(value >= 70 && value < 80)
        {
            //shapeLayer.strokeColor = UIColor.init(netHex: 0x1DCEB1).cgColor
            return 0.56
        }
        else if(value > 60 && value < 70)
        {
            //shapeLayer.strokeColor = UIColor.init(netHex: 0x1DCEB1).cgColor
            return 0.48
        }
        else if(value>=50 && value <= 60)
        {   //shapeLayer.strokeColor = UIColor.init(netHex: 0xFFDD7C).cgColor
            return 0.42
        }
            
        else if(value == 50)
        {  //shapeLayer.strokeColor =  UIColor.init(netHex: 0xFFDD7C).cgColor
            return 0.4
        }
            
        else if (value < 50  && value >= 40)
        {
            //shapeLayer.strokeColor = UIColor.init(netHex: 0xFFDD7C).cgColor
            return 0.35
        }
        else if (value >= 30 && value < 40 )
        {
            //shapeLayer.strokeColor = UIColor.init(netHex:0xFF5D84).cgColor
            return 0.25
        }
            
        else {
            //shapeLayer.strokeColor = UIColor.init(netHex:0xFF5D84).cgColor
            return 0.2
        }
        
    }
}
