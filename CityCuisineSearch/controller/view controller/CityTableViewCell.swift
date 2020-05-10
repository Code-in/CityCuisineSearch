//
//  CityTableViewCell.swift
//  CityCuisineSearch
//
//  Created by Pete Parks on 5/8/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageOutlet: UIImageView!
    @IBOutlet weak var cityNameLabelOutlet: UILabel!
    @IBOutlet weak var stateNameLabelOutlet: UILabel!
    @IBOutlet weak var countryLabelOutlet: UILabel!
    
    // MARK: Properties
    var location: PJPLocation? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        cityNameLabelOutlet.text = ""
        stateNameLabelOutlet.text = ""
        countryLabelOutlet.text = ""
        guard let cityName = location?.cityName else { return }
        cityNameLabelOutlet.text = cityName
        guard let stateName = location?.stateName else { return }
        stateNameLabelOutlet.text = stateName
        guard let countryName = location?.countryName else { return }
        countryLabelOutlet.text = countryName
        self.flagImageOutlet.image = nil
        guard let countryFlagUrl = location?.countryFlagUrl else { return }
        print(countryFlagUrl)
        PJPCityFetchController.fetchCountryImage(countryFlagUrl) { (image, error) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.flagImageOutlet.image = image
            }
        }
    } // EoF
}
