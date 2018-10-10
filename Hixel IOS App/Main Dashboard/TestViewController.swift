//
//  TestViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 10/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var searchArray = [SearchEntry]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        serach()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var search: UITableView!
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func serach(query:String)
    {
        let _ = Client().request(.search(query: query)).subscribe { event in
            switch event{
            case .success(let response):
                print("Hurray")
                
                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                let searches = try! JSONDecoder().decode([SearchEntry].self, from: response.data)
                self.searchArray = searches
                print("Sex",searches)
                
                // MARK: Reload the table data when the search results are in.
                self.search.reloadData()

                break
                
            case .error(let error):
                print("Yikes")
                print(error)
                break
            }
        }
    }

}

extension TestViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchTableViewCell
        
        if(searchArray.count != 0 )
        {
            cell.setupCell(searchEntry: searchArray[indexPath.row])
        }
        
        
        
        return cell
    }
    
}

extension TestViewController: UISearchBarDelegate {
    
    // Call the Search method from here and put the results into the array , then reload the table view
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText.count != 0)
        {
            search.isHidden = false
            serach(query: searchText)

        }
        
        if(searchText.count == 0)
        {
                        search.isHidden = true
        }
       print("count",searchText.count)
        
    }
    
}
