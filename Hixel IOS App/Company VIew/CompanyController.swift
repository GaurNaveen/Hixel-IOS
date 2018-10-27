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
    
    /// Action button used to display the info view.
    ///
    /// - Parameter sender: System Defined Params.
    @IBAction func finanail_indicators_info(_ sender: Any) {
        performSegue(withIdentifier: "indicators_info", sender: self)
        
    }
    
    @IBOutlet weak var add_button2: UIButton!
    // MARK: This is the main company variable
    var company : TempCompany? = nil
    var searchedCompany : Company? = nil
    
    @IBOutlet weak var companyNameLabel: UILabel!
    // let port :PortfolioController = nil
    
    let indexPath0 = IndexPath(item: 0, section:0)
    let indexPath1 = IndexPath(item: 1, section:0)
    let indexPath2 = IndexPath(item: 2, section:0)
    let indexPath3 = IndexPath(item: 3, section:0)
    let indexPath4 = IndexPath(item: 4, section:0)
    var selectedIndexPath: IndexPath?
    
    
    /// Function used to add the company to the portfolio when the user presses the add button.
    ///
    /// - Parameter sender: System Defined Params.
    @IBAction func add_button(_ sender: Any) {
        //companies.append(company!)
        // add = true
        //let Port = PortfolioController()
        //Port.addCompany1(company: company!)
        //  companyToAdd.append(company!)
        // performSegue(withIdentifier: "segue2", sender: self)
        portcomp.append(searchedCompany!)
        addCompany()

        // performSegue(withIdentifier: "segue2", sender: self)
        self.dismiss(animated: true, completion: viewDidLoad)
        
    }
    
    /// Not in use anymore
    ///
    /// - Parameters:
    ///   - segue: Params.
    ///   - sender: Params.
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
    
    
    /// Function used to dismiss the current view.
    ///
    /// - Parameter sender: System defined params.
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var score_percent: UILabel!
    @IBOutlet weak var dataField1: UIView!
    @IBOutlet weak var score1: UILabel!
    /// Closure for the Score label
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont . boldSystemFont(ofSize: 32)
        return label
    }()
    
    /// Function used to set up the Auto layout on the score label.
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
        score1.bottomAnchor.constraint(equalTo: scoreChartContainer.topAnchor, constant: 160).isActive = true
        score1.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 170).isActive = true
        score1.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 219).isActive = true
    }
    
    func setStatusStatusBarColor()
    {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.init(netHex: 0x1956CC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusStatusBarColor()
        print("Hoya",(searchedCompany?.calculateScore())!)
        scoreChartContainer.dropShadow()
        score_percent.text = "\((searchedCompany?.calculateScore())!)%"
        /// Only display the add button when a company is not present in the portfolio.
        if(portcomp.contains(where: {$0.identifiers.ticker == searchedCompany?.identifiers.ticker}))
        {
            add_button2.isHidden = true
        }
        else{
            add_button2.isHidden = false
            
        }
        
        add_button2.backgroundColor = UIColor.blue
        add_button2.layer.cornerRadius = add_button2.frame.height / 2
        add_button2.layer.shadowOpacity = 0.25
        add_button2.layer.shadowRadius = 5
        add_button2.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        companyNameLabel.text = searchedCompany?.identifiers.name
        setChartValues(check: false)
        // dataField1.dropShadow()
        // Do any additional setup after loading the view.
        // let's start by drawing a circle somehow
        scoreLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scoreLabel.center = view.center
        
        let center = CGPoint(x: 175, y: 60)
        let circularPath = UIBezierPath(arcCenter: center, radius: 65, startAngle: -CGFloat.pi / 2, endAngle:2*CGFloat.pi, clockwise: true)
        
        // This
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle:2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 7
        // Change the color of the circle
        shapeLayer.fillColor = UIColor.init(netHex: 0x333A43).cgColor
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    
    /// Function that does the filling animation on the score chart.
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
    
    /// Function used to add auto layout to the score percent.
    func addAutoLayoutToScorePercent()
    {
        score_percent.translatesAutoresizingMaskIntoConstraints = false
        score_percent.heightAnchor.constraint(equalToConstant: 100).isActive = true
        score_percent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        score_percent.topAnchor.constraint(equalTo: scoreChartContainer.bottomAnchor, constant: 220).isActive = true
        score_percent.bottomAnchor.constraint(equalTo: scoreChartContainer.topAnchor, constant: 88).isActive = true
        score_percent.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 130).isActive = true
        score_percent.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 230).isActive = true
        
    }
    
    var score_Values = [1,3,2,4,3]
    //var score_Values1 = [2,1,5,1,2]
    var years = ["2014","2015","2016","2017","2018"]
    
    // MARK: Setup Line Chart
    func setChartValues(check:Bool)
    {
        var lineChartEntry = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        score_Values.removeAll()
        score_Values.append(Int((searchedCompany?.getHealth())!))
        score_Values.append(Int((searchedCompany?.getHealth2())!))
        score_Values.append(Int((searchedCompany?.getHealth3())!))
        score_Values.append(Int((searchedCompany?.getHealth4())!))
        score_Values.append(Int((searchedCompany?.getHealth5())!))

        // add health values for previous yhears
        if(check==true)
        {
            
        }
        
        
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
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom

    }
    
    func setChartValues2(score_Values:[Int],indicator:String)
    {
        var lineChartEntry3 = [ChartDataEntry]()

        
        for i in 0..<score_Values.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values[i]))
            lineChartEntry3.append(value)
        }
        let set1 = LineChartDataSet(values: lineChartEntry3, label: indicator)
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
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom

    }
    
    /// Adds the company to the uer portfolio.
    func addCompany()
    {
        let _ = Client().request(.addCompany(ticker: (searchedCompany?.identifiers.ticker)!)).subscribe{
            event in
            switch event{
            case .success(let response ):
                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                print("Yass",json)
            // self.loadUserData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    
    
}

// MARK: - Sets the Table view and it's cells content.
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

// MARK: - Sets the Collection view and it's cells content.
extension CompanyController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indicators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RatioCell
        cell.setupIndicator(name: indicators[indexPath.row])
        cell.layer.cornerRadius = 4.0
        return cell;
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
        // MARK: TO Access cell elments
        //let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! RatioCell
        //cell.cellView.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
       // cell.indicator.textColor = .white
        
        if(indexPath.row == 0)
        {
            // shows the performance indicator for the company in the line chart
            var values1 = [0,1,2,3,4]
            values1.removeAll()
            values1.append( Int((searchedCompany?.getHealth())!))
            values1.append( Int((searchedCompany?.getHealth2())!))
            values1.append( Int((searchedCompany?.getHealth3())!))
            values1.append( Int((searchedCompany?.getHealth4())!))
            values1.append( Int((searchedCompany?.getHealth5())!))
            setChartValues2(score_Values: values1, indicator: "Health")
            
            //setLineChart2(values1)
        }
        
        
        
        
        if(indexPath.row == 1)
        {
            // shows the performance indicator for the company in the line chart
            var values1 = [0,1,2,3,4]
            values1.removeAll()
            values1.append( Int((searchedCompany?.getPerformance())!))
            values1.append( Int((searchedCompany?.getPerformance2())!))
            values1.append( Int((searchedCompany?.getPerformance3())!))
            values1.append( Int((searchedCompany?.getPerformance4())!))
            values1.append( Int((searchedCompany?.getPerformance5())!))
           // setChartValues(check: true)
            print("yad",values1)
            //setLineChart2(values1)
        }
        
        if(indexPath.row == 2)
        {
            // shows the performance indicator for the company in the line chart
            var values1 = [0,1,2,3,4]
            values1.removeAll()
            values1.append( Int((searchedCompany?.getSafety())!))
            values1.append( Int((searchedCompany?.getSafety2())!))
            values1.append( Int((searchedCompany?.getSafety3())!))
            values1.append( Int((searchedCompany?.getSafety4())!))
            values1.append( Int((searchedCompany?.getSafety5())!))
            setChartValues2(score_Values: values1, indicator: "Safety")

            
        }
        
        if(indexPath.row == 3)
        {
            // shows the performance indicator for the company in the line chart
            var values1 = [0,1,2,3,4]
            values1.removeAll()
            values1.append( Int((searchedCompany?.getStrength())!))
            values1.append( Int((searchedCompany?.getStrength2())!))
            values1.append( Int((searchedCompany?.getStrengt3())!))
            values1.append( Int((searchedCompany?.getStrength4())!))
            values1.append( Int((searchedCompany?.getStrength5())!))
            setChartValues2(score_Values: values1, indicator: "Strength")

        }
        
        if(indexPath.row == 4)
        {
            // shows the performance indicator for the company in the line chart
            var values1 = [0,1,2,3,4]
            values1.removeAll()
            values1.append( Int((searchedCompany?.getReturns())!))
            values1.append( Int((searchedCompany?.getReturns2())!))
            values1.append( Int((searchedCompany?.getReturns3())!))
            values1.append( Int((searchedCompany?.getReturns4())!))
            values1.append( Int((searchedCompany?.getReturns5())!))
            setChartValues2(score_Values: values1, indicator: "Returns")

            
        }
    }
}
