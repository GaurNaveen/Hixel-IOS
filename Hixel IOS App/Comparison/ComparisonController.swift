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
    
    // MARK: Takes the uesr to the comaparison view
    @IBAction func compare1(_ sender: Any) {
        performSegue(withIdentifier: "search_comparison", sender: self)
    }
    // MARK: Passes the data between views
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ComparisonController2
        vc.Aselected = self.selected_companies
    }
    
    @IBOutlet weak var compare2: UIButton!
    var searchData = companies
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filtered: [TempCompany] = []
    var isSearching: Bool = false
    var selected_companies: [TempCompany] = []
    
    override func viewDidLoad() {
       print(companies.count, "ey")
       compare2.isHidden = true
        
        
    }

   
}

// MARK: Comparison Search setup here
extension ComparisonController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
   
}

extension ComparisonController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return   companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = companies[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchCell
        cell.setCompany(tempCompany: company)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if(tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark)
        {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
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
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            // When the user selects the company add it to a seprate array
            selected_companies.append(companies[indexPath.row])
            
            if selected_companies.count == 2{
                compare2.isHidden = false
                
            }
            //print(selected_companies[indexPath.row].name)
        }
        
    }
   
    
    
}

