//
//  CuisineListViewController.swift
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/8/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class CuisineListViewController: UITableViewController {
    @IBOutlet var tableViewOutlet: UITableView!
    
    var city: PJPLocation?
    var cuisines: [PJPCuisine]? {
        didSet {
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        guard let city = city else {return}
        print("heading to fetch quisine data: \(city)")
        PJPCityCuisineFetch.fetchCityCuisine(city) { (cuisines, error) in
            print(cuisines)
            self.cuisines = cuisines
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let cuisines = self.cuisines else { return 0 }
        return cuisines.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cuisineCell", for: indexPath)
        
        guard let cuisines = self.cuisines else { return cell }
        let cuisine = cuisines[indexPath.row]
        print(cuisine.cuisineName)
        
        cell.textLabel?.text = cuisine.cuisineName

        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Entering segueRestaurants")
        if segue.identifier == "segueRestaurants" {
            guard let indexPath = tableViewOutlet.indexPathForSelectedRow, let destVC : CityRestaurantListViewController = segue.destination as? CityRestaurantListViewController else {return}
            
            
            guard let cuisine = self.cuisines?[indexPath.row] else { return }
            print("Segue to \(cuisine)")
            destVC.cuisine = cuisine  // to fix
        }
    }
    

}
