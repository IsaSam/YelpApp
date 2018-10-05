//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//  Copyright (c) 2018 Isaac Samuel. All rights reserved.

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var update: [NSDictionary] = []
    var businesses: [Business]!
    var filteredResto: [Business]!
    var seachBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView.rowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        MySearchBar()
      /*
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.tableView.reloadData()
            
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)}
                }
            
            }) */
        
        // Example of Yelp search with more search options specified
         Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["asianfusion", "burgers"]) { (businesses, error) in
                self.businesses = businesses
                self.tableView.reloadData()
                 for business in self.businesses {
                     print(business.name!)
                     print(business.address!)
                 }
         }
         //*/
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create searchbar
    func MySearchBar(){
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Restorants..."
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredResto = searchText.isEmpty ? businesses: businesses?.filter({(businesses: Business) -> Bool in
            return (businesses.name?.lowercased().hasPrefix(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredResto = filteredResto{
            return filteredResto.count
        } else {
            return 0
        }
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        //cell.business = businesses[indexPath.row]
        cell.business = filteredResto[indexPath.row]
        return cell
    }
    
    
    
   
    
}
