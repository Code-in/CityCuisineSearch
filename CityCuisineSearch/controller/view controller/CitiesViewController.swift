//
//  CitiesViewController.swift
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/7/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
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

        PJPCityFetchController.fetchSupportedCities(inState: "Portland") { (cities, error) in
            print(cities)
            self.cities = cities
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        let city = cities[indexPath.row]
        print(cities)
        cell.textLabel?.text = city.cityName
        

        PJPCityFetchController.fetchCountryImage(city.countryFlagUrl) { (image, error) in
            DispatchQueue.main.sync {
                cell.imageView = image
            }
        }
    
        
        return cell
    }
}
