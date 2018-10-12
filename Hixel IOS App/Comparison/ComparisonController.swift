//
//  ComparisonController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import UIKit


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
        vc.Aselected = self.selected_companies
    }
    
    @IBAction func clear(_ sender: Any) {
        setAccessoryToNone()
        selected_companies.removeAll()
        compare2.isHidden = true
        clear.isHidden = true
        updateCollectionView()
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var compare2: UIButton!
    var searchData = companies
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filtered: [TempCompany] = []
    var isSearching: Bool = false
    var selected_companies: [TempCompany] = []
    
    override func viewDidLoad() {
       print(companies.count, "ey")
       compare2.isHidden = true
       clear.isHidden = true
        //searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.isHidden = true
        //searchView.dropShadow()
      //  searchView.layer.cornerRadius = 10.0
    }

    func setAccessoryToNone()
    { let size = companies.count
        for i in 0..<size
        {   let indexPath = IndexPath(row: i, section: 0)

            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
    }
    
    // This function connects to the server and loads the search results.
    func serach(query:String)
    {
        let _ = Client().request(.search(query: query)).subscribe { event in
            switch event{
            case .success(let response):
                print("Hurray")
                
               // let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                let searches = try! JSONDecoder().decode([SearchEntry].self, from: response.data)
                self.searchArray = searches
                print("Sex",searches)
                
                // MARK: Reload the table data when the search results are in.
                self.searchView.reloadData()
                var frame = self.searchView.frame
                frame.size.height = self.searchView.contentSize.height+70
                self.searchView.frame = frame
                break
                
            case .error(let error):
                print("Yikes")
                print(error)
                break
            }
        }
    }
   
}

// MARK: Comparison Search setup here
extension ComparisonController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchView.isHidden = false
        
        if(searchText.count != 0)
        {
            // make network calls
            serach(query: searchText)
        }
        
        if(searchText.count == 0)
        {
            searchView.isHidden = true
        }
        
    }
    
   
}

extension ComparisonController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == searchView)
        {
            return searchArray.count
        }
        
        
      return   companies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == searchView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchComparisonCell
            
            if(searchArray.count != 0 )
            {
            cell.setupCell(company: searchArray[indexPath.row])
            }
            return cell
        }
        
        
        
        let company = companies[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchCell
        cell.setCompany(tempCompany: company)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView != searchView)
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
            
            // When the user selects the companies , update the collection view
            updateCollectionView()
            
            if selected_companies.count == 2{
                compare2.isHidden = false
                
            }
            //print(selected_companies[indexPath.row].name)
        }
        
    }
   
   
    
    }
}

// MARK: Setup for selected companies on top of Your Portfolio companies
extension ComparisonController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return selected_companies.count
         return selected_companies.count
        //return portcomp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selected_companies", for: indexPath) as! SelectedCompaniesCollectionViewCell
        cell.setupCell(name: selected_companies[indexPath.row].name)
        //cell.setupCell(name: portcomp[indexPath.row].identifiers.name)
        
        return cell
        
    }
    
    // When the user selects the company, that company should appear in the collection view too
    func updateCollectionView()
    {
        //let indexPath = IndexPath(item: 0, section: 0)
        print("hello")
        collectionView.reloadData()
        
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
   */
    
    
    
}
