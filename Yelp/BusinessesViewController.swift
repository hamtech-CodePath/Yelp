//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var businesses: [Business]!
    var filteredData: [Business]!
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
        
        self.setUpSearchBar()
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false) //stop
    }
    
        
    // UITableView - Delegate & Datasource Methods
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if businesses != nil {
                if searchController.active && searchController.searchBar.text != "" {
                    return filteredData.count
                } else {
                    return businesses.count
                }
            } else {
                return 0
            }
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
            
            //filtering mechanism
            if searchController.active && searchController.searchBar.text != "" {
                cell.business = filteredData[indexPath.row]
            } else {
                cell.business = businesses[indexPath.row]
            }
            
            //cell.business = businesses[indexPath.row]
            return cell
    }
    
    //UISearchResultsUpdating  Methods
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredData = businesses.filter { business in
            return business.name!.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    func setUpSearchBar() {
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        
        // If we are using thi
        //same view controller to present the results
        // dimming it out wouldn't make sense.  Should set probably only set
        // this to yes if using another controller to display the search results.
        //self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.sizeToFit()
        //tableView.tableHeaderView = searchController.searchBar
        self.searchController.active = false
        self.searchController.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false) //stop
        self.navigationController?.navigationBar.addSubview(self.searchController.searchBar)
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }
    
        
/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BusinessesViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}
