//
//  CityRestaurantListViewController.swift
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/9/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class CityRestaurantListViewController: UITableViewController {

    @IBOutlet var tableViewOutlet: UITableView!
    var cuisine: PJPCuisine?
    
    var restaurants: [PJPRestaurant]? {
        didSet {
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Need to do a fetch for the restaurants and data
        
        print("viewDidLoad")
        guard let cuisine = self.cuisine else { return }
        print("heading to fetch quisine data: \(cuisine)")
        PJPCityRestaurantsFetch.fetchCityRestaurants(cuisine) { (restaurants, error) in
            self.restaurants = restaurants
            for rest in restaurants {
                print(rest.name)
            }
            
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return restaurants?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)

        guard let restaurants = self.restaurants else { return cell }
        let restaurant = restaurants[indexPath.row]
        print(restaurant.name)

        cell.textLabel?.text = restaurant.name
        cell.detailTextLabel?.text = restaurant.phoneNumbers
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
    }


}
