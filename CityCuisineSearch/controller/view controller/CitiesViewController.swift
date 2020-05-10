//
//  CitiesViewController.swift
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/7/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var urlFlagImage: UIImage? = nil
    
    var cities: [PJPLocation] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        searchBarOutlet.delegate = self
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Entering segueCuisine")
        if segue.identifier == "segueCuisine" {
            guard let indexPath = tableViewOutlet.indexPathForSelectedRow, let destVC : CuisineListViewController = segue.destination as? CuisineListViewController else {return}
            let city = cities[indexPath.row]
            print("Segue \(city)")
            destVC.city = city
        }
    }
    

}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }

        let location = cities[indexPath.row]
        print(location)
        cell.location = location
        
        return cell
    }
}

extension CitiesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBarOutlet.text, !searchTerm.isEmpty else { return }

        PJPCityFetchController.fetchSupportedCities(inState: searchTerm) { (cities, error) in
            print(cities)
            self.cities = cities
        }
    } // EoF
} // EoE



