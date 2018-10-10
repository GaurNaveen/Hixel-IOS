//
//  CompanyControllerViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 14/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import Charts
class CompanyController: UIViewController {
    
    @IBOutlet weak var add_button2: UIButton!
    // MARK: This is the main company variable
    var company : TempCompany? = nil
    var searchedCompany : Company? = nil
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    
    let indexPath0 = IndexPath(item: 0, section:0)
    let indexPath1 = IndexPath(item: 1, section:0)
    let indexPath2 = IndexPath(item: 2, section:0)
    let indexPath3 = IndexPath(item: 3, section:0)
    let indexPath4 = IndexPath(item: 4, section:0)
    var selectedIndexPath: IndexPath?

    // Prepare to send the current company back to Portfolio
    @IBAction func add_button(_ sender: Any) {
        //companies.append(company!)
       // add = true
        //let Port = PortfolioController()
        //Port.addCompany1(company: company!)
      //  companyToAdd.append(company!)
       // performSegue(withIdentifier: "segue2", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  let vc = segue.destination as! PortfolioController
       // vc.addCompany1(company: company!)
    }
    
    @IBOutlet weak var lineChartView: LineChartView!
    // Company Name is hardcoded rn, will be removed when network layer is connected
    var ratios = ["Apple Inc","Liquidity Ratio","Debt Ratio","P/E Ratio","Health","Performance","Strength","Risk"]
    var indexPaths : [IndexPath] = []
    var ratiosValue = [0,1.2,0.2,2.4,3,3,4,1]
    let indicators = ["Health","Performance","Safety","Strength","Returns"]
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
        score1.bottomAnchor.constraint(equalTo: scoreChartContainer.topAnchor, constant: 200).isActive = true
        score1.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 160).isActive = true
        score1.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 225).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add_button2.isHidden = true
        companyNameLabel.text = searchedCompany?.identifiers.name
        setChartValues()
       // dataField1.dropShadow()
        // Do any additional setup after loading the view.
        // let's start by drawing a circle somehow
        scoreLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scoreLabel.center = view.center
        
        let center = CGPoint(x: 190, y: 140)
        let circularPath = UIBezierPath(arcCenter: center, radius: 85, startAngle: -CGFloat.pi / 2, endAngle:2*CGFloat.pi, clockwise: true)
        
        // This
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle:2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 5
        // Change the color of the circle
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeEnd = 0
    
        // Create my track layer now
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath1.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        //scoreChartContainer.layer.addSublayer(trackLayer)
        scoreChartContainer.layer.addSublayer(shapeLayer)
        
        setAutoLayoutOnScore1()
        
        scoreChartContainer.addSubview(score1)
        // Use autoLayout on score_percent
        scoreChartContainer.addSubview(score_percent)
        addAutoLayoutToScorePercent()        //view.addSubview(score)
        handleTap()
       // view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        indexPaths.append(indexPath0)
        indexPaths.append(indexPath1)
        indexPaths.append(indexPath2)
        indexPaths.append(indexPath3)
        indexPaths.append(indexPath4)

    }

    // does the fillin animation
    @objc private func handleTap()
    {
        print("Attepmting to animate strokee")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.5  // This will be helpfull to control the outer layer , 1 means full , 0.5 means half. adjust accordingly
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
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
        score_percent.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 120).isActive = true
        score_percent.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 225).isActive = true
        
    }
  var lineChartEntry = [ChartDataEntry]()
  var lineChartEntry2 = [ChartDataEntry]()
  var score_Values = [1,3,2,4,3]
    //var score_Values1 = [2,1,5,1,2]

    var years = ["2014","2015","2016","2017","2018"]
    // MARK: Setup Line Chart
    func setChartValues()
    {
        for i in 0..<score_Values.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values[i]))
            lineChartEntry.append(value)
        }
        /*
        for i in 0..<score_Values1.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values1[i]))
            lineChartEntry2.append(value)
        }
        */
        //let set2 = LineChartDataSet(values: lineChartEntry2, label: "Risk")
        
        let set1 = LineChartDataSet(values: lineChartEntry, label: "Health")
        set1.circleColors = [NSUIColor.init(red: 42, green: 76, blue: 126)]
        set1.colors = [NSUIColor.init(red: 42, green: 76, blue: 126)]
        set1.mode = .cubicBezier
        set1.circleRadius  = 4.0
        let data = LineChartData(dataSet: set1)
        //data.addDataSet(set2)
        lineChartView.data = data
        lineChartView.chartDescription?.text = "Financial Indiacators"
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: years)
        lineChartView.xAxis.granularity = 1
        
    }
   

   

}

extension CompanyController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  ratios.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = ratiosValue[indexPath.row]

        let name = ratios[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratio1", for: indexPath) as! CompanyTableViewCell
        cell.setupName(name: name)
        cell.setupValue(value: value)

        if(indexPath.row == 0)
        {
            cell.backgroundColor = UIColor.init(netHex: 0x335289)
            cell.ratioName.text = company?.name
            cell.ratioName.textColor = .white
            cell.ratioValue.isHidden = true

        }

        return cell
    }

}

extension CompanyController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indicators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RatioCell
        cell.setupIndicator(name: indicators[indexPath.row])
        cell.layer.cornerRadius = 12.0
        return cell;
        
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
        // MARK: TO Access cell elments
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! RatioCell
        cell.cellView.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
        cell.indicator.textColor = .white
        
//        for i in 0..<indexPaths.count {
//           // print(indexPath)
//            print(collectionView.visibleCells.count)
//           // let visible = collectionView.visibleCells
//            if(indexPath != indexPaths[i])
//            {
//
//                if(collectionView.cellForItem(at: indexPaths[i]) != nil)
//                {
//                     let cell1 =  collectionView.cellForItem(at: indexPaths[i]) as! RatioCell
//                    cell1.cellView.backgroundColor = .white
//                    cell1.indicator.textColor = .black
//                }
//
//
//            }
//
//
//        }
//        selectedIndexPath = indexPath
        
    
        
    }
    
    
   
    
    

}
