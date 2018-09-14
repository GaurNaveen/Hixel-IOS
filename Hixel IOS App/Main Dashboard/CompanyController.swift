//
//  CompanyControllerViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 14/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class CompanyController: UIViewController {
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoreChartContainer: UIView!
    let shapeLayer = CAShapeLayer()
    var pulsatingLayer: CAShapeLayer!
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var score_percent: UILabel!
    
    @IBOutlet weak var dataField1: UIView!
    @IBOutlet weak var score1: UILabel!
    let scoreLabel: UILabel = {
       let label = UILabel()
        label.text = "Score"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont . boldSystemFont(ofSize: 32)
        return label
    }()

    fileprivate func setAutoLayoutOnScore1() {
        /// Adds text to the circular chart we have created. Make sure to add it after the layers have been created
        // use Auto Layout to position the score
        //scoreLabel.heightAnchor.constraint(equalToConstant: 50)
        //scoreLabel.widthAnchor.constraint(equalToConstant: 50)
        
        // Set Score using auto layout
        score1.translatesAutoresizingMaskIntoConstraints = false
        score1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        score1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        score1.topAnchor.constraint(equalTo: scoreChartContainer.bottomAnchor, constant: 170).isActive = true
        score1.bottomAnchor.constraint(equalTo: scoreChartContainer.topAnchor, constant: 210).isActive = true
        score1.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 100).isActive = true
        score1.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 235).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataField1.dropShadow()
        //score.translatesAutoresizingMaskIntoConstraints = false
        //score.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
        //score.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        //score.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //score.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //score.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 180).isActive = true
        //score.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 150).isActive = true
        // Do any additional setup after loading the view.
        // let's start by drawing a circle somehow
        scoreLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scoreLabel.center = view.center
        
        let center = CGPoint(x: 190, y: 140)
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle:2*CGFloat.pi, clockwise: true)
        
        // This
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle:2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        // Change the color of the circle
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeEnd = 0
        
        
        
        // Create my track layer now
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath1.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        //scoreChartContainer.layer.addSublayer(trackLayer)
        
        
        
        
        scoreChartContainer.layer.addSublayer(shapeLayer)
        
        setAutoLayoutOnScore1()
        
        scoreChartContainer.addSubview(score1)
        // Use autoLayout on score_percent
        
        scoreChartContainer.addSubview(score_percent)
        addAutoLayoutToScorePercent()        //view.addSubview(score)
        handleTap()
       // view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    // does the fillin animation
    @objc private func handleTap()
    {
        print("Attepmting to animate strokee")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.7  // This will be helpfull to control the outer layer , 1 means full , 0.5 means half. adjust accordingly
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation,forKey: "ursoBasic")
        
        
    }
    
    func addAutoLayoutToScorePercent()
    {
        score_percent.translatesAutoresizingMaskIntoConstraints = false
        score_percent.heightAnchor.constraint(equalToConstant: 100).isActive = true
        score_percent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        score_percent.topAnchor.constraint(equalTo: scoreChartContainer.bottomAnchor, constant: 170).isActive = true
        score_percent.bottomAnchor.constraint(equalTo: scoreChartContainer.topAnchor, constant: 160).isActive = true
        score_percent.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 100).isActive = true
        score_percent.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 235).isActive = true
        
    }
  
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
