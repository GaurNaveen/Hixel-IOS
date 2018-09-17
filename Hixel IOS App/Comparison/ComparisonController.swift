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
    var searchData = companies
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filtered: [TempCompany] = []
    var isSearching: Bool = false
    var selected_companies: [TempCompany] = []
    
    override func viewDidLoad() {
       print(companies.count, "ey")
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
        
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            // When the user selects the company add it to a seprate array
            selected_companies.append(companies[indexPath.row])
            print(selected_companies[indexPath.row].name)
        }
        
    }
   
    
    
}

