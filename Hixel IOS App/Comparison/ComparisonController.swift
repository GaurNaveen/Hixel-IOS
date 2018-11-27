//
//  ComparisonController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//

import Foundation
import UIKit
import SVProgressHUD

class ComparisonController: UIViewController{
    
    var searchArray = [SearchEntry]()
    @IBOutlet weak var searchView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var clear: UIButton!
    
    // MARK: Takes the uesr to the comaparison view
    @IBAction func compare1(_ sender: Any) {
        performSegue(withIdentifier: "search_comparison", sender: self)
    }
    
    // MARK: Passes the data between views
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ComparisonController2
        //vc.Aselected = self.selected_companies
        vc.companiesSelected = self.companiesSelectedFromSearch
        vc.Aselected1 =  self.loadedCompanies
        //  vc.companiesSelected =
        
    }
    var companiesSelectedFromSearch : [SearchEntry] = []
    var loadedCompanies : [Company] = []
    
    
    /// Action button that allows the user to remove the
    /// selected companies from the Comparison Search.
    ///
    /// - Parameter sender: Pass the sender.
    @IBAction func clear(_ sender: Any) {
        // setAccessoryToNone()
        //selected_companies.removeAll()
        loadedCompanies.removeAll()
        compare2.isHidden = true
        clear.isHidden = true
        //updateCollectionView()
        tableView.reloadData()
    }
    @IBAction func compareButton(_ sender: Any) {
        if(loadedCompanies.count >= 2)
        {
        performSegue(withIdentifier: "search_comparison", sender: self)
        }
            
        else{
            popAlert()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var compare2: UIButton!
    var searchData = companies
    @IBOutlet weak var searchBar: UISearchBar!
    var filtered: [TempCompany] = []
    var isSearching: Bool = false
    var selected_companies: [TempCompany] = []
    
    /// Function that is activated everytime the view is loaded.
    override func viewDidLoad() {
        compare2.isHidden = true
        clear.isHidden = true
        //searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.isHidden = true
        //searchView.dropShadow()
        //  searchView.layer.cornerRadius = 10.0
    }
    
    /// Stops the user from going to the comparison view without selecting atleast 2 companies.
    func popAlert()
    {
        let alert = UIAlertController(title: " Invalid ", message: "Please select at least two companies", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Function used to update the collection view
    /// data when the View appears on the user screen.
    ///
    /// - Parameter animated: Pass true if you want animations.
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    /// This function is depreciated.
    func setAccessoryToNone()
    {
        let size = companies.count
        for i in 0..<size
        {   let indexPath = IndexPath(row: i, section: 0)
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
    }
    
    /// This function connects to the server and loads the search results.
    ///
    /// - Parameter query: Pass the text entered by the user in the search bar.
    func search(query:String)
    {
        let _ = Client().request(.search(query: query)).subscribe { event in
            switch event{
            case .success(let response):
                let searches = try! JSONDecoder().decode([SearchEntry].self, from: response.data)
                self.searchArray = searches
                
                // MARK: Reload the table data when the search results are in.
                self.searchView.reloadData()
                var frame = self.searchView.frame
                frame.size.height = self.searchView.contentSize.height + 70
                self.searchView.frame = frame
                break
                
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    
    /// This Function is used to load a company when the user
    /// selects the company from search result.
    ///
    /// - Parameter ticker: Pass the ticker obtained from the search resutls.
    func loadCompany(ticker:String)
    {
        if (self.loadedCompanies.contains(where: {$0.identifiers.ticker == ticker}))
        {
            return
        }
        
        SVProgressHUD.show(withStatus: "Loading Company")
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        let _ = Client().request(.companydata(tickers: ticker, years: 5)).subscribe{ event in
            switch event {
            case .success(let response):
                
                let company = try! JSONDecoder().decode([Company].self, from: response.data)

                self.loadedCompanies.append(company[0])
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
                break
                
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
}




// MARK: - Comparison Search setup here
extension ComparisonController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchView.isHidden = false
        
        if (searchText.count != 0)
        {
            // make network calls
            search(query: searchText)
        }
        
        if (searchText.count == 0)
        {
            searchView.isHidden = true
        }
        
    }
}


// MARK: - Setup for the Collection view
extension ComparisonController: UITableViewDataSource,UITableViewDelegate {
    
    /// Configures how many rows there should be in the collection view.
    ///
    /// - Parameters:
    ///   - tableView: Pass the table view.
    ///   - section: Section is any.
    /// - Returns: returns the count of rows.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == searchView)
        {
            return searchArray.count
        }
    
        return loadedCompanies.count
        
    }
    
    /// Funtion used to setup the cell inside the Collection view.
    ///
    /// - Parameters:
    ///   - tableView: System Defined Params
    ///   - indexPath: System Defined Params
    /// - Returns: Returns the cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Perform a check to see if the table view is a search view.
        if(tableView == searchView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchComparisonCell
            
            if(searchArray.count != 0 )
            {
                cell.setupCell(company: searchArray[indexPath.row])
            }
            return cell
        }
        
        
        
        // let company = companies[indexPath.row]
        var company = loadedCompanies[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchCell
        // cell.setCompany(tempCompany: company)
        cell.setCompany(company: &company)
        return cell
        
    }
    
    // ------ Swipe to Delete--------//
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            loadedCompanies.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
    /// Funtion configures the behaviour for both collection view , and is
    /// activated when a user taps on a cell.
    ///
    /// - Parameters:
    ///   - tableView: System Defined Params
    ///   - indexPath: System Defined Params
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView != searchView)
        {
            clear.isHidden = false
            
            if(tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark)
            {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                if selected_companies.count != 0 {
                    
                    // Will be changed later on...
                    _ = selected_companies.popLast()
                    
                }
                if selected_companies.count <= 1 {
                    // compare_button.isHidden = true
                    compare2.isHidden = true
                    
                }
                
            }
            else{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                
                // When the user selects the company add it to a seprate array
                selected_companies.append(companies[indexPath.row])
                
                // When the user selects the companies, update the collection view
                updateCollectionView()
                
                if selected_companies.count == 2 {
                    compare2.isHidden = false
                    
                }
            }
        }
        
        /// Checks if the table view if of Search View.
        if (tableView == searchView)
        {
            companiesSelectedFromSearch.append(searchArray[indexPath.row])
            // Load the selected companies
            loadCompany(ticker: searchArray[indexPath.row].ticker)
            searchView.isHidden = true
            searchBar.text = ""
        }
        
        
    }
}

// MARK: - Setup for selected companies on top of Your Portfolio companies
extension ComparisonController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    /// Function used to detmine number of rows.
    ///
    /// - Parameters:
    ///   - collectionView: System Defined Params
    ///   - section: System Defined Params
    /// - Returns: Count of rows required.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return selected_companies.count
        // return selected_companies.count
        return portcomp.count
    }
    
    /// Function is used to setup the cell.
    ///
    /// - Parameters:
    ///   - collectionView: System Defined Params
    ///   - indexPath: System Defined Params
    /// - Returns: Configured Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selected_companies", for: indexPath) as! SelectedCompaniesCollectionViewCell
        //cell.setupCell(name: selected_companies[indexPath.row].name)
        cell.setupCell(name: portcomp[indexPath.row].identifiers.name)
        return cell
    }
    
    
    /// Function makes sure when the user selects the company, that company should appear in the collection view too
    func updateCollectionView()
    {
        collectionView.reloadData()
    }
    
    
    /// Funtion updates the view when a user selects the company.
    ///
    /// - Parameters:
    ///   - collectionView: System Defined Params.
    ///   - indexPath: System Defined Params.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let company = portcomp[indexPath.row];
        
        if (self.loadedCompanies.contains(where: {$0.identifiers.ticker == company.identifiers.ticker}))
        {
            return
        }
        
        loadedCompanies.append(company)
        
        if (loadedCompanies.count >= 2)
        {
            compare2.isHidden = false
        }
        
        if (loadedCompanies.count >= 1)
        {
            clear.isHidden = false
        }
        
        tableView.reloadData()
    }
}
